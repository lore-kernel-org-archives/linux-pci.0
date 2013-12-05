Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:36404 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab3LEPY5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 10:24:57 -0500
Received: by mail-vc0-f174.google.com with SMTP id id10so13223395vcb.33
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2013 07:24:56 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 5 Dec 2013 09:24:56 -0600
Message-ID: <CANN5nGKvaHCzWKMNyUhNfSfTfZBcVxG9RfeuQaOAFS9TghF=0w@mail.gmail.com>
Subject: error loading iwlwifi on sony vaio
From: Aaron McSorley <a@aaronmcsorley.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, I'm getting this message when trying to load iwlwifi in our
debian live image running kernel 3.8.5, this is on a Sony SVS13AA11L,
please advise on how to debug this, or any additional information you
need, any help is much appreciated, and thanks in advance

[ 1387.804146] iwlwifi 0000:02:00.0: pci_ioremap_bar failed
[ 1387.804206] iwlwifi: probe of 0000:02:00.0 failed with error -12
[ 1978.637526] Intel(R) Wireless WiFi driver for Linux, in-tree:
[ 1978.637531] Copyright(c) 2003-2012 Intel Corporation
[ 1978.637685] ------------[ cut here ]------------
[ 1978.637695] WARNING: at /build/linux/drivers/pci/pci.c:130
pci_ioremap_bar+0x4a/0x4e()
[ 1978.637697] Hardware name: SVS13A12FXB
[ 1978.637699] Modules linked in: iwlwifi(+) joydev coretemp kvm
tpm_infineon crc32c_intel uvc
video aesni_intel aes_i586 videobuf2_vmalloc cfg80211 xts
videobuf2_memops lrw btusb tpm_tis b
luetooth videobuf2_core gf128mul iTCO_wdt ablk_helper videodev
acpi_cpufreq tpm iTCO_vendor_su
pport psmouse i2c_i801 cryptd sony_laptop crc16 mperf media tpm_bios
of_i2c serio_raw lpc_ich
rfkill battery evdev processor ac mei fuse squashfs loop aufs(C)
nls_utf8 isofs dm_mirror dm_r
egion_hash dm_log dm_mod radeon sg sr_mod sd_mod crc_t10dif cdrom
usb_storage thermal nouveau
mxm_wmi wmi r8169 mii rtsx_pci ttm microcode i915 ahci libahci
ehci_pci ehci_hcd xhci_hcd vide
o libata usbcore button i2c_algo_bit drm_kms_helper scsi_mod
usb_common drm i2c_core thermal_s
ys [last unloaded: iwlwifi]
[ 1978.637759] Pid: 2896, comm: modprobe Tainted: P        WC O
3.8-0baureo1-486 #1 Debian 3.8.5-1~experimental.1~baureo1
[ 1978.637761] Call Trace:
[ 1978.637768]  [<c1021361>] ? warn_slowpath_common+0x68/0x79
[ 1978.637773]  [<c115b85d>] ? pci_ioremap_bar+0x4a/0x4e
[ 1978.637777]  [<c102137f>] ? warn_slowpath_null+0xd/0x10
[ 1978.637781]  [<c115b85d>] ? pci_ioremap_bar+0x4a/0x4e
[ 1978.637804]  [<f89136c2>] ? iwl_trans_pcie_alloc+0x113/0x271 [iwlwifi]
[ 1978.637822]  [<f890f313>] ? iwl_pci_probe+0xf/0x7e [iwlwifi]
[ 1978.637826]  [<c115e50e>] ? pci_device_probe+0x4e/0x85
[ 1978.637833]  [<c11d958b>] ? driver_probe_device+0x78/0x163
[ 1978.637838]  [<c11d96ba>] ? __driver_attach+0x44/0x5f
[ 1978.637842]  [<c11d8357>] ? bus_for_each_dev+0x37/0x61
[ 1978.637846]  [<c11d91ca>] ? driver_attach+0x11/0x13
[ 1978.637851]  [<c11d9676>] ? driver_probe_device+0x163/0x163
[ 1978.637855]  [<c11d8f40>] ? bus_add_driver+0xb0/0x1a7
[ 1978.637861]  [<f891d000>] ? 0xf891cfff
[ 1978.637866]  [<c11d9ae6>] ? driver_register+0x70/0xdb
[ 1978.637871]  [<f891d000>] ? 0xf891cfff
[ 1978.637876]  [<f891d000>] ? 0xf891cfff
[ 1978.637891]  [<f890f3f5>] ? iwl_pci_register_driver+0x15/0x2a [iwlwifi]
[ 1978.637896]  [<f891d000>] ? 0xf891cfff
[ 1978.637900]  [<c100116f>] ? do_one_initcall+0x65/0x10a
[ 1978.637904]  [<f891d000>] ? 0xf891cfff
[ 1978.637910]  [<c1055ea0>] ? load_module+0x1610/0x18e6
[ 1978.637918]  [<c10561e2>] ? sys_init_module+0x6c/0x80
[ 1978.637933]  [<c12aa12f>] ? syscall_call+0x7/0xb
[ 1978.637937] ---[ end trace 57fa059f8cbca6fc ]---
[ 1978.637941] iwlwifi 0000:02:00.0: pci_ioremap_bar failed
[ 1978.638002] iwlwifi: probe of 0000:02:00.0 failed with error -12
