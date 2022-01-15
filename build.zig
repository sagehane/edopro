const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .ReleaseSafe });

    const cover_url = b.option(
        []const u8,
        "cover-url",
        "Sets the cover URL",
    ) orelse "";

    const field_url = b.option(
        []const u8,
        "field-url",
        "Sets the field URL",
    ) orelse "";

    const pic_url = b.option(
        []const u8,
        "pic-url",
        "Sets the pic URL",
    ) orelse "";

    const update_url = b.option(
        []const u8,
        "update-url",
        "Sets the update URL",
    ) orelse "";

    //const discord_app_id = b.option(
    //    []const u8,
    //    "discord-app-id",
    //    "Sets the Discord App ID.",
    //);

    const clzma = b.addStaticLibrary(.{
        .name = "clzma",
        .target = target,
        .optimize = optimize,
    });
    clzma.addCSourceFiles(&.{
        "gframe/lzma/Alloc.c",
        "gframe/lzma/LzFind.c",
        "gframe/lzma/LzmaDec.c",
        "gframe/lzma/LzmaEnc.c",
        "gframe/lzma/LzmaLib.c",
    }, &.{
        "-MP",
        "-Wall",
        "-Werror",
        "-Wextra",
        "-fno-strict-aliasing",
    });

    clzma.linkLibC();

    const freetype = b.addStaticLibrary(.{
        .name = "freetype",
        .target = target,
        .optimize = optimize,
    });
    freetype.addCSourceFiles(&.{
        "freetype-2.6.5/src/autofit/autofit.c",
        "freetype-2.6.5/src/base/ftbase.c",
        "freetype-2.6.5/src/base/ftbbox.c",
        "freetype-2.6.5/src/base/ftbdf.c",
        "freetype-2.6.5/src/base/ftbitmap.c",
        "freetype-2.6.5/src/base/ftcid.c",
        "freetype-2.6.5/src/base/ftfstype.c",
        "freetype-2.6.5/src/base/ftgasp.c",
        "freetype-2.6.5/src/base/ftglyph.c",
        "freetype-2.6.5/src/base/ftgxval.c",
        "freetype-2.6.5/src/base/ftinit.c",
        "freetype-2.6.5/src/base/ftmm.c",
        "freetype-2.6.5/src/base/ftotval.c",
        "freetype-2.6.5/src/base/ftpatent.c",
        "freetype-2.6.5/src/base/ftpfr.c",
        "freetype-2.6.5/src/base/ftstroke.c",
        "freetype-2.6.5/src/base/ftsynth.c",
        "freetype-2.6.5/src/base/ftsystem.c",
        "freetype-2.6.5/src/base/fttype1.c",
        "freetype-2.6.5/src/base/ftwinfnt.c",
        "freetype-2.6.5/src/bdf/bdf.c",
        "freetype-2.6.5/src/cache/ftcache.c",
        "freetype-2.6.5/src/cff/cff.c",
        "freetype-2.6.5/src/cid/type1cid.c",
        "freetype-2.6.5/src/gzip/ftgzip.c",
        "freetype-2.6.5/src/lzw/ftlzw.c",
        "freetype-2.6.5/src/pcf/pcf.c",
        "freetype-2.6.5/src/pfr/pfr.c",
        "freetype-2.6.5/src/psaux/psaux.c",
        "freetype-2.6.5/src/pshinter/pshinter.c",
        "freetype-2.6.5/src/psnames/psmodule.c",
        "freetype-2.6.5/src/raster/raster.c",
        "freetype-2.6.5/src/sfnt/sfnt.c",
        "freetype-2.6.5/src/smooth/smooth.c",
        "freetype-2.6.5/src/truetype/truetype.c",
        "freetype-2.6.5/src/type1/type1.c",
        "freetype-2.6.5/src/type42/type42.c",
        "freetype-2.6.5/src/winfonts/winfnt.c",
    }, &.{
        "-DFT2_BUILD_LIBRARY",
        "-MP",
        "-Wall",
        "-Werror",
        "-Wextra",
        "-fno-sanitize=undefined",
        "-fno-strict-aliasing",
    });

    freetype.addIncludePath("freetype-2.6.5/include");
    freetype.linkLibC();

    //const lua = b.addStaticLibrary(.{
    //    .name = "lua",
    //    .target = target,
    //    .optimize = optimize,
    //});
    //lua.addCSourceFiles(&.{
    //    "lua-5.3.6/src/lapi.c",
    //    "lua-5.3.6/src/lauxlib.c",
    //    "lua-5.3.6/src/lbaselib.c",
    //    "lua-5.3.6/src/lbitlib.c",
    //    "lua-5.3.6/src/lcode.c",
    //    "lua-5.3.6/src/lcorolib.c",
    //    "lua-5.3.6/src/lctype.c",
    //    "lua-5.3.6/src/ldblib.c",
    //    "lua-5.3.6/src/ldebug.c",
    //    "lua-5.3.6/src/ldo.c",
    //    "lua-5.3.6/src/ldump.c",
    //    "lua-5.3.6/src/lfunc.c",
    //    "lua-5.3.6/src/lgc.c",
    //    "lua-5.3.6/src/linit.c",
    //    "lua-5.3.6/src/liolib.c",
    //    "lua-5.3.6/src/llex.c",
    //    "lua-5.3.6/src/lmathlib.c",
    //    "lua-5.3.6/src/lmem.c",
    //    "lua-5.3.6/src/loadlib.c",
    //    "lua-5.3.6/src/lobject.c",
    //    "lua-5.3.6/src/lopcodes.c",
    //    "lua-5.3.6/src/loslib.c",
    //    "lua-5.3.6/src/lparser.c",
    //    "lua-5.3.6/src/lstate.c",
    //    "lua-5.3.6/src/lstring.c",
    //    "lua-5.3.6/src/lstrlib.c",
    //    "lua-5.3.6/src/ltable.c",
    //    "lua-5.3.6/src/ltablib.c",
    //    "lua-5.3.6/src/ltm.c",
    //    "lua-5.3.6/src/lundump.c",
    //    "lua-5.3.6/src/lutf8lib.c",
    //    "lua-5.3.6/src/lvm.c",
    //    "lua-5.3.6/src/lzio.c",
    //}, &.{
    //    "-DLUA_COMPAT_5_2",
    //    //"-DLUA_USE_LINUX",
    //    "-DLUA_USE_POSIX",

    //    "-Wall",
    //    "-Werror",
    //    "-Wextra",
    //    "-Wno-string-plus-int",
    //    "-fPIC",
    //    //"-xc++",
    //});

    //lua.linkLibCpp();

    const md5 = b.addStaticLibrary(.{
        .name = "md5",
        .root_source_file = .{ .path = "gframe/MD5/md5.c" },
        .target = target,
        .optimize = optimize,
    });
    md5.linkLibC();

    const ocgcore = b.addStaticLibrary(.{
        .name = "ocgcore",
        .target = target,
        .optimize = optimize,
    });
    ocgcore.addCSourceFiles(&.{
        "ocgcore/card.cpp",
        "ocgcore/duel.cpp",
        "ocgcore/effect.cpp",
        "ocgcore/field.cpp",
        "ocgcore/group.cpp",
        "ocgcore/interpreter.cpp",
        "ocgcore/libcard.cpp",
        "ocgcore/libdebug.cpp",
        "ocgcore/libduel.cpp",
        "ocgcore/libeffect.cpp",
        "ocgcore/libgroup.cpp",
        "ocgcore/ocgapi.cpp",
        "ocgcore/operations.cpp",
        "ocgcore/playerop.cpp",
        "ocgcore/processor.cpp",
        "ocgcore/scriptlib.cpp",
    }, &.{
        "-MP",
        "-Wall",
        "-Wextra",
        "-Werror",
        "-Wno-missing-braces",
        "-Wno-parentheses",
        "-Wno-sign-compare",
        "-Wno-unused-function",
        "-fno-strict-aliasing",
        "-pedantic",
        "-std=c++14",
    });

    ocgcore.addIncludePath("lua-5.3.6/src");

    ocgcore.linkLibCpp();
    //ocgcore.linkLibrary(lua);
    ocgcore.linkSystemLibrary("lua");

    const sfAudio_flags = [_][]const u8{
        "-MP",
        "-Wall",
        "-Werror",
        "-Wextra",
        "-Wno-implicit-const-int-float-conversion",
        "-Wno-sign-compare",
        "-Wno-unused-function",
        "-fno-strict-aliasing",
        "-std=c++14",
    };

    const sfAudio = b.addStaticLibrary(.{
        .name = "sfAudio",
        .target = target,
        .optimize = optimize,
    });
    sfAudio.addCSourceFiles(&.{
        "sfAudio/src/ALCheck.cpp",
        "sfAudio/src/AlResource.cpp",
        "sfAudio/src/AudioDevice.cpp",
        "sfAudio/src/InputSoundFile.cpp",
        "sfAudio/src/Music.cpp",
        "sfAudio/src/Sound.cpp",
        "sfAudio/src/SoundBuffer.cpp",
        "sfAudio/src/SoundFileFactory.cpp",
        "sfAudio/src/SoundFileReaderFlac.cpp",
        "sfAudio/src/SoundFileReaderMp3_minimp3.cpp",
        "sfAudio/src/SoundFileReaderOgg.cpp",
        "sfAudio/src/SoundSource.cpp",
        "sfAudio/src/SoundStream.cpp",
        "sfAudio/src/System/FileInputStream.cpp",
        "sfAudio/src/System/MemoryInputStream.cpp",
        "sfAudio/src/System/Time.cpp",
    }, &sfAudio_flags);

    // Files that seem to contain UB
    sfAudio.addCSourceFiles(&.{
        // Activate any card that increases LP.
        // * frame #0: 0x0000000000989bb3 edopro`sf::priv::SoundFileReaderWav::read(this=0x00007fff6c002c80, samples=0x00007fff6c3aecfe, maxCount=133824) at SoundFileReaderWav.cpp:218:38
        "sfAudio/src/SoundFileReaderWav.cpp",
    }, &(sfAudio_flags ++ [_][]const u8{"-fno-sanitize=undefined"}));

    sfAudio.addIncludePath("sfAudio/include");
    sfAudio.addIncludePath("sfAudio/external/headers");

    sfAudio.linkLibCpp();
    sfAudio.linkSystemLibrary("FLAC");
    sfAudio.linkSystemLibrary("openal");
    sfAudio.linkSystemLibrary("vorbisfile");

    const edopro_flags = [_][]const u8{
        b.fmt("-DDEFAULT_COVER_URL=\"{s}\"", .{cover_url}),
        b.fmt("-DDEFAULT_FIELD_URL=\"{s}\"", .{field_url}),
        b.fmt("-DDEFAULT_PIC_URL=\"{s}\"", .{pic_url}),
        b.fmt("-DUPDATE_URL=\"{s}\"", .{update_url}),

        //"-DCURL_STATICLIB",
        //"-DLUA_COMPAT_5_2",
        //"-DLUA_USE_LINUX",
        "-DYGOPRO_USE_SFML",
        "-MP",
        "-Werror",
        "-Wno-deprecated-declarations",
        "-Wno-implicit-const-int-float-conversion",
        "-Wno-inconsistent-missing-override",
        "-fno-rtti",
        "-fno-strict-aliasing",
        "-std=c++14",
    };

    const exe = b.addExecutable(.{
        .name = "edopro",
        .target = target,
        .optimize = optimize,
    });
    exe.addCSourceFiles(&.{
        "gframe/CGUICustomCheckBox/CGUICustomCheckBox.cpp",
        "gframe/CGUICustomComboBox/CGUICustomComboBox.cpp",
        "gframe/CGUICustomContextMenu/CGUICustomContextMenu.cpp",
        "gframe/CGUICustomContextMenu/CGUICustomMenu.cpp",
        "gframe/CGUICustomTabControl/CGUICustomTabControl.cpp",
        "gframe/CGUICustomTable/CGUICustomTable.cpp",
        "gframe/CGUICustomText/CGUICustomText.cpp",
        "gframe/CGUIFileSelectListBox/CGUIFileSelectListBox.cpp",
        "gframe/CGUIImageButton/CGUIImageButton.cpp",
        "gframe/CGUISkinSystem/CConfigMap.cpp",
        "gframe/CGUISkinSystem/CGUIProgressBar.cpp",
        "gframe/CGUISkinSystem/CGUISkinSystem.cpp",
        "gframe/CGUITTFont/CGUITTFont.cpp",
        "gframe/CGUIWindowedTabControl/CGUIWindowedTabControl.cpp",
        "gframe/CProgressBar/CProgressBar.cpp",
        "gframe/CXMLRegistry/CXMLNode.cpp",
        "gframe/CXMLRegistry/CXMLRegistry.cpp",
        "gframe/ResizeablePanel/ResizeablePanel.cpp",
        "gframe/client_card.cpp",
        "gframe/client_field.cpp",
        "gframe/client_updater.cpp",
        "gframe/core_utils.cpp",
        "gframe/custom_skin_enum.cpp",
        "gframe/data_handler.cpp",
        "gframe/data_manager.cpp",
        "gframe/deck_con.cpp",
        "gframe/deck_manager.cpp",
        "gframe/discord_wrapper.cpp",
        "gframe/dllinterface.cpp",
        "gframe/duelclient.cpp",
        "gframe/game.cpp",
        "gframe/game_config.cpp",
        "gframe/gframe.cpp",
        "gframe/image_downloader.cpp",
        "gframe/image_manager.cpp",
        "gframe/ireadfile_sqlite.cpp",
        "gframe/joystick_wrapper.cpp",
        "gframe/logging.cpp",
        "gframe/materials.cpp",
        "gframe/menu_handler.cpp",
        "gframe/netserver.cpp",
        "gframe/old_replay_mode.cpp",
        "gframe/replay.cpp",
        "gframe/replay_mode.cpp",
        "gframe/repo_manager.cpp",
        "gframe/server_lobby.cpp",
        "gframe/settings_window.cpp",
        "gframe/single_mode.cpp",
        "gframe/sound_manager.cpp",
        "gframe/sound_sfml.cpp",
        "gframe/sound_threaded_backend.cpp",
        "gframe/utils.cpp",
        "gframe/utils_gui.cpp",
        "gframe/windbot.cpp",
        "gframe/windbot_panel.cpp",
    }, &edopro_flags);

    // Files that seem to contain UB
    exe.addCSourceFiles(
        &.{
            // Click on the settings icon
            // frame #0: 0x00000000003cf419 edopro`irr::clipRects(dstRect=0x00007fffffff9b80, srcRect=0x00007fffffff9b90, clip=<unavailable>) at clipRects.h:0
            "gframe/CGUISkinSystem/CImageGUISkin.cpp",

            // Normal summon a monster
            // frame #0: 0x00000000005a79df edopro`ygo::ClientField::OnEvent(this=<unavailable>, event=<unavailable>) at event_handler.cpp:0:43
            "gframe/event_handler.cpp",

            // Play a two-player game and wait for the "Waiting" prompt
            // #0  0x000000000097a32a in ygo::GenericDuel::Sending (this=<optimized out>, this@entry=0x7fff98021bf0, packet=..., return_value=<optimized out>,
            //     record=<optimized out>, record_last=<optimized out>) at gframe/generic_duel.cpp:877
            "gframe/generic_duel.cpp",

            // Draw a card on the 2nd draw phase
            // #0  0x00000000008ccce7 in ygo::Game::DrawSpec (this=0x7fffffffa180) at gframe/drawing.cpp:446
            "gframe/drawing.cpp",
        },
        &(edopro_flags ++ [_][]const u8{"-fno-sanitize=undefined"}),
    );

    exe.addIncludePath("fmt/include");
    //exe.addIncludePath("freetype-2.6.5/include");
    exe.addIncludePath("irrlicht1-8-4/include");
    exe.addIncludePath("ocgcore");
    exe.addIncludePath("sfAudio/include");

    exe.addLibraryPath("fmt/build");
    exe.addLibraryPath("irrlicht1-8-4/lib/Linux");
    exe.addLibraryPath("lua-5.3.6/src");

    exe.linkLibCpp();
    exe.linkLibrary(clzma);
    //exe.linkLibrary(freetype);
    //exe.linkLibrary(irrlicht);
    exe.linkLibrary(md5);
    exe.linkLibrary(ocgcore);
    exe.linkLibrary(sfAudio);

    exe.linkSystemLibrary("Irrlicht");
    exe.linkSystemLibrary("fmt");

    exe.linkSystemLibrary("crypto");
    exe.linkSystemLibrary("curl");
    exe.linkSystemLibrary("event");
    exe.linkSystemLibrary("event_pthreads");
    exe.linkSystemLibrary("freetype");
    exe.linkSystemLibrary("git2");
    exe.linkSystemLibrary("sqlite3");
    exe.linkSystemLibrary("wayland-client");

    // For NO_IRR_WAYLAND_DYNAMIC_LOAD_
    exe.linkSystemLibrary("wayland-cursor");
    exe.linkSystemLibrary("wayland-egl");
    exe.linkSystemLibrary("xkbcommon");

    // For NO_IRR_DYNAMIC_OPENGL_
    exe.linkSystemLibrary("GL");

    b.installArtifact(exe);
}
