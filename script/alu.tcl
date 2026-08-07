set script_dir [file dirname [info script]]
set repo_dir   [file normalize "$script_dir/.."]

create_project alu_proj "$repo_dir/build" -part xazu1eg-sbva484-1-i -force

add_files -norecurse [list \
    "$repo_dir/src/adder_1bit.sv" \
    "$repo_dir/src/full_adder_8bit.sv" \
    "$repo_dir/src/top_module.sv" \
]

set_property top top_module [current_fileset]

add_files -fileset sim_1 -norecurse [list "$repo_dir/test/alu_tb.sv"]
set_property top alu_tb [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

launch_simulation
run all
close_sim
close_project

file delete -force "$repo_dir/build"