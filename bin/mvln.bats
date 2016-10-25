#! /usr/bin/env bats

setup() {
	tmp=`mktemp --tmpdir --directory mvln_test.XXXX`
	pushd "$tmp" >/dev/null
}
teardown() {
	popd >/dev/null
	rm -rf "$tmp"
}

@test "moves and links across directories with absolute paths" {
	mkdir dir
	touch file
	
	mvln "$tmp"/file "$tmp"/dir
	
	[[ `readlink dir/file` = "$tmp"/file ]]
}

@test "works with relative paths" {
	
}

@test "works within the same directory" {
	
}

@test "handles multiple source files" {
	
}

@test "create destination directory if it doesn't exist" {
	
}

@test "handles spaces in source name" {
	
}

@test "handles spaces in destination name" {
	
}

@test "exits with helpful error if last arg is not destination directory" {
	
}

@test "destination link exists" {
	
}

@test "source file doesn't exist" {
	
}

@test "" {
	
}

@test "" {
	
}

@test "" {
	
}

@test "" {
	
}
