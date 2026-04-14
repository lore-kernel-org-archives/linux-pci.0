Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1041A5B8A
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776125817; cv=none; b=iZM6t9QamDbSXeS3ssrJVqm1HzeMnks11yLGA97OLCDX8btsJ1xOYsbJvI2krkekWkFsroKSuYCdPdWDvIVUBj5NIK2redWWclFZlUNCrBps7no604Da08c9a773LbjPibPgJSI13+RKhqKwvSY3qNRmQuy47UoqgFJGMznnuxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776125817; c=relaxed/simple;
	bh=Ew870inppcv4vJEytupkKvNwcIFcd21HjqdKcRralfs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pOzjiKpCLk7//0bMh5CZ0hYz4cpu/HcVk6jII1hq0r6vwyJ9oyfxw5DxgsLrNtudjtIC8waNyE2ow7tS2JSPoNtuW7vHXg9Frubavux7nOhuo1+ISOkNRwhdki9t5kGH4zU44kyEtMx5imohBGbE6/SmhKlN4lD/es2TRoWC6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=Xuvs5l/j; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b="Xuvs5l/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail; t=1776125796; x=1776384996;
	bh=cPG3MUY/aZI27Qvi7IuleElJ2iaZGvPNQOGvNDOLcNY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Xuvs5l/jLMHfIHRhxLDy7rMES5pH0Rjhb6yEXE3os2UEhdKhr9vHgo7YjA+uo/ArG
	 vMQWzSRA4YxoMNnVz/tF8oe8gh1MvYWsVm5831a+Q5HCUYhfZUOf3QuT4GIZHKy+oE
	 ppwcsS9dC1C8oP4RFF1yy+AlU5sm4NIhfC3hrjOMVnLZjTTSpeOgj0TgxbFXXWO6n5
	 aSNMSudxDUfhgS09wex/D22Zjn+saEH50PgD+yPQz2vVQA4LZK/gfiBLKZfbPKlpLH
	 P/p5dLAywNShVUQi4Fvz4ChFqcjNlyFXJDusjNFDfg/wibupTuqQ8FPL/TLboJdTwW
	 k0j0u+Yk1vGHA==
Date: Tue, 14 Apr 2026 00:16:30 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Rio Liu <rio@r26.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [REGRESSION] amdgpu fails to load eGPU after 6.19
Message-ID: <a1FodrO_nl6UemO3VLBk5Gsu6PjvxLU-OYhvJEMeKFem-Bpi7ZXDHrIxtwsTCmpn-WndBxnzZNtdKJy_V6PjafnFjSKz7sr1eEfGobRzpgs=@r26.me>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: f8b7360477b6a35ac306f70035f598369d4abf2b
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Ilpo,

There seems to be another PCI alignment issue with external amdgpu since 6.=
19.
Bisecting this time pointed me to this commit

commit bc75c8e5071120e919beb39e69f0979cccfdf219 (HEAD)
Author: Ilpo J<C3><A4>rvinen <ilpo.jarvinen@linux.intel.com>
Date:   Fri Dec 19 19:40:15 2025 +0200

    PCI: Rewrite bridge window head alignment function

It looks like the same issue that has happened before in
https://lore.kernel.org/all/o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzO=
W1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=3D@r26.me/.
It seems like the previous fix with min_align
https://lore.kernel.org/all/20250822123359.16305-2-ilpo.jarvinen@linux.inte=
l.com/
got removed in this commit.

Applying the following patch to the commit fixes the regression. I'm still
looking at how to rebasing it onto latest commit as there is quite a bit of
code change around it. But the same regression still happens as of v7.0-rc7=
.

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 80e5a8fc62e7..12ab84271214 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1445,7 +1445,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsign=
ed long type,

        if (bus->self && size0 &&
            !pbus_upstream_space_available(bus, b_res, size0, min_align)) {
-               min_align =3D calculate_head_align(aligns2, max_order);
+               min_align =3D min(min_align, calculate_head_align(aligns2, =
max_order));
                size0 =3D calculate_memsize(size, min_size, 0, 0, old_size,=
 win_align);
                resource_set_range(b_res, min_align, size0);
                pci_info(bus->self, "bridge window %pR to %pR requires rela=
xed alignment rules\n",
@@ -1459,7 +1459,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsign=
ed long type,

                if (bus->self && size1 &&
                    !pbus_upstream_space_available(bus, b_res, size1, add_a=
lign)) {
-                       min_align =3D calculate_head_align(aligns2, max_ord=
er);
+                       min_align =3D min(min_align, calculate_head_align(a=
ligns2, max_order));
                        size1 =3D calculate_memsize(size, min_size, add_siz=
e, children_add_size,
                                                  old_size, win_align);
                        pci_info(bus->self,
---

Relevant errors in dmesg:

[   10.166037] amdgpu: Virtual CRAT table created for CPU
[   10.166050] amdgpu: Topology: Add CPU node
[   10.166166] amdgpu 0000:08:00.0: enabling device (0000 -> 0002)
[   10.166293] amdgpu 0000:08:00.0: initializing kernel modesetting (SIENNA=
_CICHLID 0x1002:0x73BF 0x148C:0x2406 0xC1).
[   10.166345] amdgpu 0000:08:00.0: register mmio base: 0x8C000000
[   10.166347] amdgpu 0000:08:00.0: register mmio size: 1048576
[   10.173624] wlan0: Limiting TX power to 30 (30 - 0) dBm as advertised by=
 72:13:01:87:79:82
[   10.174898] amdgpu 0000:08:00.0: detected ip block number 0 <common_v1_0=
_0> (nv_common)
[   10.174901] amdgpu 0000:08:00.0: detected ip block number 1 <gmc_v10_0_0=
> (gmc_v10_0)
[   10.174903] amdgpu 0000:08:00.0: detected ip block number 2 <ih_v5_0_0> =
(navi10_ih)
[   10.174904] amdgpu 0000:08:00.0: detected ip block number 3 <psp_v11_0_0=
> (psp)
[   10.174906] amdgpu 0000:08:00.0: detected ip block number 4 <smu_v11_0_0=
> (smu)
[   10.174907] amdgpu 0000:08:00.0: detected ip block number 5 <dce_v1_0_0>=
 (dm)
[   10.174908] amdgpu 0000:08:00.0: detected ip block number 6 <gfx_v10_0_0=
> (gfx_v10_0)
[   10.174909] amdgpu 0000:08:00.0: detected ip block number 7 <sdma_v5_2_0=
> (sdma_v5_2)
[   10.174911] amdgpu 0000:08:00.0: detected ip block number 8 <vcn_v3_0_0>=
 (vcn_v3_0)
[   10.174912] amdgpu 0000:08:00.0: detected ip block number 9 <jpeg_v3_0_0=
> (jpeg_v3_0)
[   10.278772] amdgpu 0000:08:00.0: Fetched VBIOS from ROM BAR
[   10.278776] amdgpu 0000:08:00.0: [drm] ATOM BIOS: 113-001-X01
[   10.308408] amdgpu 0000:08:00.0: Trusted Memory Zone (TMZ) feature disab=
led as experimental (default)
[   10.308424] amdgpu 0000:08:00.0: PCIE atomic ops is not supported
[   10.308433] amdgpu 0000:08:00.0: GPU posting now...
[   10.308461] amdgpu 0000:08:00.0: MEM ECC is not presented.
[   10.308462] amdgpu 0000:08:00.0: SRAM ECC is not presented.
[   10.308484] amdgpu 0000:08:00.0: vm size is 262144 GB, 4 levels, block s=
ize is 9-bit, fragment size is 9-bit
[   10.308522] amdgpu 0000:08:00.0: Problem resizing BAR0 (-22).
[   10.308529] amdgpu 0000:08:00.0: VRAM: 16368M 0x0000008000000000 - 0x000=
00083FEFFFFFF (16368M used)
[   10.308531] amdgpu 0000:08:00.0: GART: 512M 0x0000000000000000 - 0x00000=
0001FFFFFFF
[   10.308545] resource: resource sanity check: requesting [mem 0x000000000=
0000000-0xffffffffffffffff], which spans more than PCI Bus 0000:00 [mem 0x0=
00a0000-0x000bffff window]
[   10.308550] ------------[ cut here ]------------
[   10.308551] WARNING: arch/x86/mm/pat/memtype.c:721 at memtype_reserve_io=
+0xfc/0x110, CPU#7: (udev-worker)/606
[   10.308557] Modules linked in: ccm amdgpu(+) amdxcp drm_panel_backlight_=
quirks gpu_sched drm_exec snd_hda_codec_atihdmi drm_suballoc_helper drm_ttm=
_helper ntfs3 vfat fat v4l2loopback(OE) snd_seq_midi snd_seq_midi_event snd=
_seq snd_rawmidi snd_seq_device dm_multipath dm_mod kvmgt mdev vfio_iommu_t=
ype1 vfio iommufd crypto_user uinput cmac algif_hash algif_skcipher af_alg =
uvcvideo videobuf2_vmalloc uvc videobuf2_memops videobuf2_v4l2 btusb videob=
uf2_common btmtk btrtl videodev btbcm mc btintel snd_hda_codec_intelhdmi sn=
d_hda_codec_hdmi snd_hda_codec_alc269 snd_hda_codec_realtek_lib snd_hda_sco=
dec_component snd_hda_codec_generic snd_hda_intel snd_sof_pci_intel_cnl joy=
dev snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt snd=
_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_inte=
l_hda intel_rapl_msr soundwire_cadence intel_rapl_common snd_sof_pci snd_so=
f_xtensa_dsp intel_uncore_frequency intel_uncore_frequency_common snd_sof s=
nd_sof_utils snd_soc_acpi_intel_match
[   10.308591]  snd_soc_acpi_intel_sdca_quirks soundwire_generic_allocation=
 snd_soc_sdw_utils snd_soc_acpi intel_tcc_cooling soundwire_bus x86_pkg_tem=
p_thermal intel_powerclamp snd_soc_sdca coretemp crc8 snd_soc_avs kvm_intel=
 snd_soc_hda_codec mousedev snd_hda_ext_core kvm r8169 snd_hda_codec nvme 8=
021q irqbypass realtek snd_hda_core ghash_clmulni_intel rtsx_pci_sdmmc aesn=
i_intel nvme_core snd_intel_dspcfg garp mdio_devres snd_intel_sdw_acpi spi_=
nor iwlmvm mrp iTCO_wdt rapl nvme_keyring stp mmc_core libphy intel_cstate =
nvme_auth snd_hwdep hid_multitouch mei_hdcp mei_pxp ee1004 intel_pmc_bxt mt=
d intel_wmi_thunderbolt llc clevo_xsm_wmi(OE) i915 intel_uncore snd_soc_cor=
e thunderbolt mdio_bus i2c_hid_acpi hkdf mac80211 rtsx_pci i2c_hid snd_comp=
ress drm_buddy ptp ac97_bus ttm pps_core snd_pcm_dmaengine i2c_algo_bit int=
el_oc_wdt libarc4 intel_pmc_core drm_display_helper snd_pcm pmt_telemetry c=
ec pmt_discovery iwlwifi snd_timer i2c_i801 intel_lpss_pci intel_gtt pmt_cl=
ass mei_me spi_intel_pci i2c_smbus snd intel_lpss
[   10.308633]  intel_pmc_ssram_telemetry intel_hid psmouse spi_intel video=
 idma64 soundcore mei intel_pch_thermal i2c_mux intel_vsec pcspkr mac_hid s=
erio_raw sparse_keymap wmi acpi_pad bnep cfg80211 bluetooth rfkill
[   10.308645] CPU: 7 UID: 0 PID: 606 Comm: (udev-worker) Tainted: G S     =
    OE       7.0.0-rc7 #21 PREEMPT(full)  78435afb69b0b07f3561902db6ca6395f=
9133c11
[   10.308648] Tainted: [S]=3DCPU_OUT_OF_SPEC, [O]=3DOOT_MODULE, [E]=3DUNSI=
GNED_MODULE
[   10.308649] Hardware name: COPELION INTERNATIONAL INC. ZX Series/ZX Seri=
es, BIOS 1.07.14RCOP1 12/29/2020
[   10.308650] RIP: 0010:memtype_reserve_io+0xfc/0x110
[   10.308652] Code: aa fb ff ff b8 f0 ff ff ff eb 88 8b 54 24 04 4c 89 ee =
48 89 df e8 04 fe ff ff 85 c0 75 db 8b 54 24 04 41 89 16 e9 69 ff ff ff <0f=
> 0b e9 4b ff ff ff e8 48 d2 09 01 0f 1f 84 00 00 00 00 00 90 90
[   10.308654] RSP: 0018:ffffcf4781c736d0 EFLAGS: 00010286
[   10.308655] RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 00000000000=
00027
[   10.308657] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff9b5=
f5e70
[   10.308657] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000fff=
fefff
[   10.308658] R10: ffffffff9a85fac0 R11: ffffcf4781c73548 R12: 00000000000=
00001
[   10.308659] R13: 0000000000000000 R14: ffffcf4781c7371c R15: 00000000000=
00001
[   10.308660] FS:  00007fdda0fa5c80(0000) GS:ffff8b4d39075000(0000) knlGS:=
0000000000000000
[   10.308662] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.308662] CR2: 00007ffd23cf0ff0 CR3: 0000000109bfa005 CR4: 00000000003=
726f0
[   10.308664] Call Trace:
[   10.308665]  <TASK>
[   10.308666]  arch_io_reserve_memtype_wc+0x31/0x50
[   10.308670]  amdgpu_bo_init+0x3e/0x90 [amdgpu 9e1de60160a9bdc6283126cc89=
fe53e3272a6751]
[   10.309129]  ? amdgpu_gmc_get_vbios_allocations+0xa9/0x140 [amdgpu 9e1de=
60160a9bdc6283126cc89fe53e3272a6751]
[   10.309416]  gmc_v10_0_sw_init+0x352/0x5d0 [amdgpu 9e1de60160a9bdc628312=
6cc89fe53e3272a6751]
[   10.309721]  amdgpu_device_init.cold+0x1612/0x22f8 [amdgpu 9e1de60160a9b=
dc6283126cc89fe53e3272a6751]
[   10.310080]  ? pci_conf1_read+0xb2/0x100
[   10.310084]  ? pci_bus_read_config_word+0x4c/0x80
[   10.310087]  amdgpu_driver_load_kms+0x19/0x80 [amdgpu 9e1de60160a9bdc628=
3126cc89fe53e3272a6751]
[   10.310352]  amdgpu_pci_probe+0x233/0x480 [amdgpu 9e1de60160a9bdc6283126=
cc89fe53e3272a6751]
[   10.310610]  local_pci_probe+0x3e/0x90
[   10.310614]  pci_device_probe+0xe1/0x260
[   10.310616]  ? sysfs_do_create_link_sd+0x6d/0xd0
[   10.310619]  really_probe+0xde/0x380
[   10.310622]  __driver_probe_device+0x78/0x150
[   10.310624]  driver_probe_device+0x1f/0xa0
[   10.310625]  ? __pfx___driver_attach+0x10/0x10
[   10.310627]  __driver_attach+0xcb/0x210
[   10.310628]  bus_for_each_dev+0x85/0xd0
[   10.310632]  bus_add_driver+0x118/0x200
[   10.310634]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu 9e1de60160a9bdc628312=
6cc89fe53e3272a6751]
[   10.310890]  driver_register+0x75/0xe0
[   10.310893]  ? amdgpu_init+0x36/0xff0 [amdgpu 9e1de60160a9bdc6283126cc89=
fe53e3272a6751]
[   10.311150]  do_one_initcall+0x5d/0x330
[   10.311155]  do_init_module+0x62/0x250
[   10.311158]  ? init_module_from_file+0xd8/0x140
[   10.311160]  init_module_from_file+0xd8/0x140
[   10.311163]  idempotent_init_module+0x114/0x310
[   10.311166]  __x64_sys_finit_module+0x71/0xe0
[   10.311167]  do_syscall_64+0x11c/0x15f0
[   10.311170]  ? alloc_fd+0x12e/0x190
[   10.311172]  ? do_sys_openat2+0x9a/0xe0
[   10.311175]  ? __x64_sys_openat+0x61/0xa0
[   10.311177]  ? do_syscall_64+0x11c/0x15f0
[   10.311179]  ? alloc_fd+0x12e/0x190
[   10.311180]  ? do_sys_openat2+0x9a/0xe0
[   10.311182]  ? __x64_sys_openat+0x61/0xa0
[   10.311184]  ? do_syscall_64+0x11c/0x15f0
[   10.311186]  ? do_syscall_64+0x2d6/0x15f0
[   10.311187]  ? do_syscall_64+0x11c/0x15f0
[   10.311189]  ? clear_bhb_loop+0x30/0x80
[   10.311191]  ? clear_bhb_loop+0x30/0x80
[   10.311192]  ? clear_bhb_loop+0x30/0x80
[   10.311193]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   10.311195] RIP: 0033:0x7fdda10b967d
[   10.311197] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 63 16 0d 00 f7 d8 64 89 01 48
[   10.311198] RSP: 002b:00007ffea5c85328 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   10.311200] RAX: ffffffffffffffda RBX: 000055c8dfdae250 RCX: 00007fdda10=
b967d
[   10.311201] RDX: 0000000000000004 RSI: 00007fdda0f5b2f2 RDI: 00000000000=
00018
[   10.311202] RBP: 00007ffea5c853c0 R08: 0000000000000000 R09: 00000000000=
00000
[   10.311203] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   10.311204] R13: 000055c8dfdb3130 R14: 000055c8dfdae250 R15: 00000000000=
00000
[   10.311205]  </TASK>
[   10.311206] ---[ end trace 0000000000000000 ]---
[   10.311208] [drm:amdgpu_bo_init [amdgpu]] *ERROR* Unable to set WC memty=
pe for the aperture base
[   10.311476] amdgpu 0000:08:00.0: sw_init of IP block <gmc_v10_0> failed =
-22
[   10.311477] amdgpu 0000:08:00.0: amdgpu_device_ip_init failed
[   10.311478] amdgpu 0000:08:00.0: Fatal error during GPU init
[   10.311480] amdgpu 0000:08:00.0: finishing device.
[   10.311825] amdgpu 0000:08:00.0: probe with driver amdgpu failed with er=
ror -22

Best,
Rio
