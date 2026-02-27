canonicalize_model(::Val{S}) where {S} = S
canonicalize_quantity(::Val{S}) where {S} = S
# src/core/alias.jl

macro register_aliases(target_func, canon, aliases)
    # --- 修正ポイント：中身の Symbol だけを抽出するヘルパー ---
    unwrap(x) = x isa QuoteNode ? x.value : x

    c = unwrap(canon)
    actual_aliases = if aliases isa Expr && aliases.head == :vect
        unwrap.(aliases.args) # 各要素を unwrap
    else
        [unwrap(aliases)]
    end

    output = quote end

    # 1. 正解（c）の登録
    # ここで改めて QuoteNode に包むことで、生成されるコード内では必ずリテラル :symbol になる
    push!(output.args, :($target_func(::Val{$(QuoteNode(c))}) = $(QuoteNode(c))))

    # 2. 各エイリアスの登録
    for al in actual_aliases
        push!(output.args, :($target_func(::Val{$(QuoteNode(al))}) = $(QuoteNode(c))))
    end

    return esc(output)
end

# Quantity Aliases
@register_aliases canonicalize_quantity :energy [:E, :Energy, :e]
@register_aliases canonicalize_quantity :entanglement_entropy [
    :ee, :EE, :S_vN, :EntanglementEntropy
]
@register_aliases canonicalize_quantity :central_charge [:c, :cc, :CentralCharge]
@register_aliases canonicalize_quantity :zz_corr [:ZZ, :zzcorr, :szsz]

# Model Aliases
@register_aliases canonicalize_model :TFIM [
    :TransverseFieldIsingModel, :transverseFieldIsingModel
]
