using Pkg

project = Pkg.project()
uuid = project.uuid
current_version = project.version
name = project.name

function get_latest_registered_version(uuid)
    for reg in Pkg.Registry.reachable_registries()
        if haskey(reg.pkgs, uuid)
            pkg_entry = reg.pkgs[uuid]
            reg_info = Pkg.Registry.registry_info(pkg_entry)
            return maximum(keys(reg_info.version_info))
        end
    end
    return nothing # if unregistered
end

latest_v = get_latest_registered_version(uuid)

if isnothing(latest_v)
    println("✅ $name is not yet registered. Skip version check.")
else
    if current_version > latest_v
        println("✅ Version check passed: $current_version > $latest_v")
    else
        println(
            "❌ Error: Current version ($current_version) must be greater than registered version ($latest_v).",
        )
        exit(1)
    end
end
