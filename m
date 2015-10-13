Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51091 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbbJMMrc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Oct 2015 08:47:32 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B8BDDACEB
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2015 12:47:29 +0000 (UTC)
Message-ID: <1444740359.2934.11.camel@suse.com>
Subject: warnings upon repeated plug of Thunderbolt device
From: Oliver Neukum <oneukum@suse.com>
To: linux-pci@vger.kernel.org
Date: Tue, 13 Oct 2015 14:45:59 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

in 4.3.0-rc5 I get a warning if you plug in my Thunderbolt device
more than once:

Oct 13 14:41:03 linux-dtbq.site kernel: pciehp 0000:00:1c.0:pcie04: Card present on Slot(0)
Oct 13 14:41:03 linux-dtbq.site kernel: pciehp 0000:00:1c.0:pcie04: slot(0): Link Up event
Oct 13 14:41:03 linux-dtbq.site kernel: pciehp 0000:00:1c.0:pcie04: Link Up event ignored on slot(0): already powering on
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:02:00.0: [8086:1567] type 01 class 0x060400
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:02:00.0: supports D1 D2
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:02:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
Oct 13 14:41:03 linux-dtbq.site kernel: pci_bus 0000:03: busn_res: can not insert [bus 03-ff] under [bus 02-3a] (conflicts with (null) [bus 02-3a])
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:00.0: [8086:1567] type 01 class 0x060400
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:00.0: supports D1 D2
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:03.0: [8086:1567] type 01 class 0x060400
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:03.0: supports D1 D2
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:03.0: PME# supported from D0 D1 D2 D3hot D3cold
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:04.0: [8086:1567] type 01 class 0x060400
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:04.0: supports D1 D2
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:04.0: PME# supported from D0 D1 D2 D3hot D3cold
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:05.0: [8086:1567] type 01 class 0x060400
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:05.0: supports D1 D2
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:05.0: PME# supported from D0 D1 D2 D3hot D3cold
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:06.0: [8086:1567] type 01 class 0x060400
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:06.0: supports D1 D2
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:06.0: PME# supported from D0 D1 D2 D3hot D3cold
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:02:00.0: PCI bridge to [bus 03-ff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:02:00.0:   bridge window [io  0x0000-0x0fff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:02:00.0:   bridge window [mem 0x00000000-0x000fffff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:02:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:06.0: bridge configuration invalid ([bus 00-00]), reconfiguring
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:04:00.0: [8086:1566] type 00 class 0x088000
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x0003ffff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:04:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:04:00.0: supports D1 D2
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:00.0: PCI bridge to [bus 04-ff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:00.0:   bridge window [io  0x0000-0x0fff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000fffff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
Oct 13 14:41:03 linux-dtbq.site kernel: pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:03.0: PCI bridge to [bus 05-ff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:03.0:   bridge window [io  0x0000-0x0fff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:03.0:   bridge window [mem 0x00000000-0x000fffff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
Oct 13 14:41:03 linux-dtbq.site kernel: pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
Oct 13 14:41:03 linux-dtbq.site kernel: ------------[ cut here ]------------
Oct 13 14:41:03 linux-dtbq.site kernel: WARNING: CPU: 0 PID: 2911 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x64/0x80()
Oct 13 14:41:03 linux-dtbq.site kernel: sysfs: cannot create duplicate filename '/class/pci_bus/0000:06'
Oct 13 14:41:03 linux-dtbq.site kernel: Modules linked in: ext4(E) mbcache(E) jbd2(E) uas(E) usb_storage(E) fuse(E) rfcomm(E) af_packet(E) nf_log_ipv6(E) xt_pkttype(E) nf_log_ipv4(E) nf_log_common(E) xt_LOG(E) xt_limit(E) bnep(E) ip6t_REJECT(E) nf_reject_ipv6(E) xt_tcpudp(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ip6table_raw(E) ipt_REJECT(E) nf_reject_ipv4(E) iptable_raw(E) xt_CT(E) iptable_filter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) uvcvideo(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_core(E) v4l2_common(E) videodev(E) hid_generic(E) usbhid(E) idmouse(E) crc16(E) xfs(E) libcrc32c(E) raid0(E) snd_hda_codec_hdmi(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  bcache(E) arc4(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) iwldvm(E) snd_hda_codec_idt(E) coretemp(E) mac80211(E) snd_hda_codec_generic(E) kvm_intel(E) kvm(E) md_mod(E) crct10dif_pclmul(E) snd_hda_intel(E) snd_hda_codec(E) crc32_pclmul(E) ghash_clmulni_intel(E) drbg(E) iwlwifi(E) snd_hda_core(E) ansi_cprng(E) snd_hwdep(E) snd_pcm(E) aesni_intel(E) snd_timer(E) aes_x86_64(E) lrw(E) gf128mul(E) glue_helper(E) ablk_helper(E) cfg80211(E) snd(E) joydev(E) iTCO_wdt(E) hp_wmi(E) hp_accel(E) ppdev(E) e1000e(E) iTCO_vendor_support(E) sparse_keymap(E) i2c_i801(E) mxm_wmi(E) pcspkr(E) serio_raw(E) lis3lv02d(E) parport_pc(E) cryptd(E) rfkill(E) tpm_infineon(E) input_polldev(E) mei_me(E) mei(E) xhci_pci(E) soundcore(E) parport(E) xhci_hcd(E) lpc_ich(E) ptp(E) mfd_core(E) shpchp(E) battery(E) pps_core(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  thermal(E) ac(E) processor(E) dm_mod(E) btrfs(E) xor(E) raid6_pq(E) sr_mod(E) cdrom(E) sd_mod(E) crc32c_intel(E) ahci(E) libahci(E) libata(E) i915(E) i2c_algo_bit(E) drm_kms_helper(E) ehci_pci(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ehci_hcd(E) fb_sys_fops(E) usbcore(E) drm(E) usb_common(E) wmi(E) video(E) button(E) sg(E) scsi_mod(E) autofs4(E)
Oct 13 14:41:03 linux-dtbq.site kernel: CPU: 0 PID: 2911 Comm: kworker/0:3 Tainted: G        W   E   4.3.0-rc5-default+ #4
Oct 13 14:41:03 linux-dtbq.site kernel: Hardware name: Hewlett-Packard HP EliteBook 8780w/190A, BIOS L70 Ver. 93.01 05/17/2013
Oct 13 14:41:03 linux-dtbq.site kernel: Workqueue: pciehp-0 pciehp_power_thread
Oct 13 14:41:03 linux-dtbq.site kernel:  ffffffff8183fa6a ffff88061c01ba78 ffffffff812e3e26 ffff88061c01bac0
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff88061c01bab0 ffffffff810647a6 ffff8805b82b5000 ffff88002432a540
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff880692b26118 0000000000000001 ffffffffffffffef ffff88061c01bb10
Oct 13 14:41:03 linux-dtbq.site kernel: Call Trace:
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812e3e26>] dump_stack+0x44/0x5e
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff810647a6>] warn_slowpath_common+0x86/0xc0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8106482c>] warn_slowpath_fmt+0x4c/0x50
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812450b8>] ? kernfs_path+0x48/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81248644>] sysfs_warn_dup+0x64/0x80
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812489d3>] sysfs_do_create_link_sd.isra.2+0xa3/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81248a05>] sysfs_create_link+0x25/0x40
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8140bd6d>] device_add+0x27d/0x5e0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8140c0ea>] device_register+0x1a/0x20
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff813228ba>] pci_add_new_bus+0x18a/0x3f0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8132aa5b>] ? pci_find_next_bus+0x4b/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323714>] pci_scan_bridge+0x554/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff813238af>] pci_scan_child_bus+0xaf/0x140
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323690>] pci_scan_bridge+0x4d0/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81341a0f>] pci_hp_add_bridge+0x6f/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e5c4>] pciehp_configure_device+0x74/0x120
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e0c3>] pciehp_enable_slot+0x163/0x280
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e2cb>] pciehp_power_thread+0x3b/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c119>] process_one_work+0x149/0x3e0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c94a>] worker_thread+0x11a/0x460
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c830>] ? max_active_store+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081d69>] kthread+0xc9/0xe0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff815a705f>] ret_from_fork+0x3f/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel: ---[ end trace fcbcb9f14a5da4b6 ]---
Oct 13 14:41:03 linux-dtbq.site kernel: ------------[ cut here ]------------
Oct 13 14:41:03 linux-dtbq.site kernel: WARNING: CPU: 0 PID: 2911 at drivers/pci/probe.c:752 pci_add_new_bus+0x3d0/0x3f0()
Oct 13 14:41:03 linux-dtbq.site kernel: Modules linked in: ext4(E) mbcache(E) jbd2(E) uas(E) usb_storage(E) fuse(E) rfcomm(E) af_packet(E) nf_log_ipv6(E) xt_pkttype(E) nf_log_ipv4(E) nf_log_common(E) xt_LOG(E) xt_limit(E) bnep(E) ip6t_REJECT(E) nf_reject_ipv6(E) xt_tcpudp(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ip6table_raw(E) ipt_REJECT(E) nf_reject_ipv4(E) iptable_raw(E) xt_CT(E) iptable_filter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) uvcvideo(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_core(E) v4l2_common(E) videodev(E) hid_generic(E) usbhid(E) idmouse(E) crc16(E) xfs(E) libcrc32c(E) raid0(E) snd_hda_codec_hdmi(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  bcache(E) arc4(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) iwldvm(E) snd_hda_codec_idt(E) coretemp(E) mac80211(E) snd_hda_codec_generic(E) kvm_intel(E) kvm(E) md_mod(E) crct10dif_pclmul(E) snd_hda_intel(E) snd_hda_codec(E) crc32_pclmul(E) ghash_clmulni_intel(E) drbg(E) iwlwifi(E) snd_hda_core(E) ansi_cprng(E) snd_hwdep(E) snd_pcm(E) aesni_intel(E) snd_timer(E) aes_x86_64(E) lrw(E) gf128mul(E) glue_helper(E) ablk_helper(E) cfg80211(E) snd(E) joydev(E) iTCO_wdt(E) hp_wmi(E) hp_accel(E) ppdev(E) e1000e(E) iTCO_vendor_support(E) sparse_keymap(E) i2c_i801(E) mxm_wmi(E) pcspkr(E) serio_raw(E) lis3lv02d(E) parport_pc(E) cryptd(E) rfkill(E) tpm_infineon(E) input_polldev(E) mei_me(E) mei(E) xhci_pci(E) soundcore(E) parport(E) xhci_hcd(E) lpc_ich(E) ptp(E) mfd_core(E) shpchp(E) battery(E) pps_core(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  thermal(E) ac(E) processor(E) dm_mod(E) btrfs(E) xor(E) raid6_pq(E) sr_mod(E) cdrom(E) sd_mod(E) crc32c_intel(E) ahci(E) libahci(E) libata(E) i915(E) i2c_algo_bit(E) drm_kms_helper(E) ehci_pci(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ehci_hcd(E) fb_sys_fops(E) usbcore(E) drm(E) usb_common(E) wmi(E) video(E) button(E) sg(E) scsi_mod(E) autofs4(E)
Oct 13 14:41:03 linux-dtbq.site kernel: CPU: 0 PID: 2911 Comm: kworker/0:3 Tainted: G        W   E   4.3.0-rc5-default+ #4
Oct 13 14:41:03 linux-dtbq.site kernel: Hardware name: Hewlett-Packard HP EliteBook 8780w/190A, BIOS L70 Ver. 93.01 05/17/2013
Oct 13 14:41:03 linux-dtbq.site kernel: Workqueue: pciehp-0 pciehp_power_thread
Oct 13 14:41:03 linux-dtbq.site kernel:  ffffffff81856cb1 ffff88061c01bba0 ffffffff812e3e26 0000000000000000
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff88061c01bbd8 ffffffff810647a6 ffff880691bb6000 ffff880691bb6118
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff880690fdd000 ffff88049b128000 ffff88049b128000 ffff88061c01bbe8
Oct 13 14:41:03 linux-dtbq.site kernel: Call Trace:
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812e3e26>] dump_stack+0x44/0x5e
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff810647a6>] warn_slowpath_common+0x86/0xc0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8106489a>] warn_slowpath_null+0x1a/0x20
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81322b00>] pci_add_new_bus+0x3d0/0x3f0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8132aa5b>] ? pci_find_next_bus+0x4b/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323714>] pci_scan_bridge+0x554/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff813238af>] pci_scan_child_bus+0xaf/0x140
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323690>] pci_scan_bridge+0x4d0/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81341a0f>] pci_hp_add_bridge+0x6f/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e5c4>] pciehp_configure_device+0x74/0x120
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e0c3>] pciehp_enable_slot+0x163/0x280
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e2cb>] pciehp_power_thread+0x3b/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c119>] process_one_work+0x149/0x3e0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c94a>] worker_thread+0x11a/0x460
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c830>] ? max_active_store+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081d69>] kthread+0xc9/0xe0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff815a705f>] ret_from_fork+0x3f/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel: ---[ end trace fcbcb9f14a5da4b7 ]---
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:04.0: PCI bridge to [bus 06-ff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:04.0:   bridge window [io  0x0000-0x0fff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:04.0:   bridge window [mem 0x00000000-0x000fffff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
Oct 13 14:41:03 linux-dtbq.site kernel: pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
Oct 13 14:41:03 linux-dtbq.site kernel: ------------[ cut here ]------------
Oct 13 14:41:03 linux-dtbq.site kernel: WARNING: CPU: 0 PID: 2911 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x64/0x80()
Oct 13 14:41:03 linux-dtbq.site kernel: sysfs: cannot create duplicate filename '/class/pci_bus/0000:07'
Oct 13 14:41:03 linux-dtbq.site kernel: Modules linked in: ext4(E) mbcache(E) jbd2(E) uas(E) usb_storage(E) fuse(E) rfcomm(E) af_packet(E) nf_log_ipv6(E) xt_pkttype(E) nf_log_ipv4(E) nf_log_common(E) xt_LOG(E) xt_limit(E) bnep(E) ip6t_REJECT(E) nf_reject_ipv6(E) xt_tcpudp(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ip6table_raw(E) ipt_REJECT(E) nf_reject_ipv4(E) iptable_raw(E) xt_CT(E) iptable_filter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) uvcvideo(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_core(E) v4l2_common(E) videodev(E) hid_generic(E) usbhid(E) idmouse(E) crc16(E) xfs(E) libcrc32c(E) raid0(E) snd_hda_codec_hdmi(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  bcache(E) arc4(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) iwldvm(E) snd_hda_codec_idt(E) coretemp(E) mac80211(E) snd_hda_codec_generic(E) kvm_intel(E) kvm(E) md_mod(E) crct10dif_pclmul(E) snd_hda_intel(E) snd_hda_codec(E) crc32_pclmul(E) ghash_clmulni_intel(E) drbg(E) iwlwifi(E) snd_hda_core(E) ansi_cprng(E) snd_hwdep(E) snd_pcm(E) aesni_intel(E) snd_timer(E) aes_x86_64(E) lrw(E) gf128mul(E) glue_helper(E) ablk_helper(E) cfg80211(E) snd(E) joydev(E) iTCO_wdt(E) hp_wmi(E) hp_accel(E) ppdev(E) e1000e(E) iTCO_vendor_support(E) sparse_keymap(E) i2c_i801(E) mxm_wmi(E) pcspkr(E) serio_raw(E) lis3lv02d(E) parport_pc(E) cryptd(E) rfkill(E) tpm_infineon(E) input_polldev(E) mei_me(E) mei(E) xhci_pci(E) soundcore(E) parport(E) xhci_hcd(E) lpc_ich(E) ptp(E) mfd_core(E) shpchp(E) battery(E) pps_core(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  thermal(E) ac(E) processor(E) dm_mod(E) btrfs(E) xor(E) raid6_pq(E) sr_mod(E) cdrom(E) sd_mod(E) crc32c_intel(E) ahci(E) libahci(E) libata(E) i915(E) i2c_algo_bit(E) drm_kms_helper(E) ehci_pci(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ehci_hcd(E) fb_sys_fops(E) usbcore(E) drm(E) usb_common(E) wmi(E) video(E) button(E) sg(E) scsi_mod(E) autofs4(E)
Oct 13 14:41:03 linux-dtbq.site kernel: CPU: 0 PID: 2911 Comm: kworker/0:3 Tainted: G        W   E   4.3.0-rc5-default+ #4
Oct 13 14:41:03 linux-dtbq.site kernel: Hardware name: Hewlett-Packard HP EliteBook 8780w/190A, BIOS L70 Ver. 93.01 05/17/2013
Oct 13 14:41:03 linux-dtbq.site kernel: Workqueue: pciehp-0 pciehp_power_thread
Oct 13 14:41:03 linux-dtbq.site kernel:  ffffffff8183fa6a ffff88061c01ba78 ffffffff812e3e26 ffff88061c01bac0
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff88061c01bab0 ffffffff810647a6 ffff8805b82b5000 ffff8804977c6ea0
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff880692b26118 0000000000000001 ffffffffffffffef ffff88061c01bb10
Oct 13 14:41:03 linux-dtbq.site kernel: Call Trace:
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812e3e26>] dump_stack+0x44/0x5e
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff810647a6>] warn_slowpath_common+0x86/0xc0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8106482c>] warn_slowpath_fmt+0x4c/0x50
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812450b8>] ? kernfs_path+0x48/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81248644>] sysfs_warn_dup+0x64/0x80
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812489d3>] sysfs_do_create_link_sd.isra.2+0xa3/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81248a05>] sysfs_create_link+0x25/0x40
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8140bd6d>] device_add+0x27d/0x5e0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8140c0ea>] device_register+0x1a/0x20
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff813228ba>] pci_add_new_bus+0x18a/0x3f0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8132aa5b>] ? pci_find_next_bus+0x4b/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323714>] pci_scan_bridge+0x554/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff813238af>] pci_scan_child_bus+0xaf/0x140
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323690>] pci_scan_bridge+0x4d0/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81341a0f>] pci_hp_add_bridge+0x6f/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e5c4>] pciehp_configure_device+0x74/0x120
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e0c3>] pciehp_enable_slot+0x163/0x280
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e2cb>] pciehp_power_thread+0x3b/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c119>] process_one_work+0x149/0x3e0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c94a>] worker_thread+0x11a/0x460
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c830>] ? max_active_store+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081d69>] kthread+0xc9/0xe0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff815a705f>] ret_from_fork+0x3f/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel: ---[ end trace fcbcb9f14a5da4b8 ]---
Oct 13 14:41:03 linux-dtbq.site kernel: ------------[ cut here ]------------
Oct 13 14:41:03 linux-dtbq.site kernel: WARNING: CPU: 0 PID: 2911 at drivers/pci/probe.c:752 pci_add_new_bus+0x3d0/0x3f0()
Oct 13 14:41:03 linux-dtbq.site kernel: Modules linked in: ext4(E) mbcache(E) jbd2(E) uas(E) usb_storage(E) fuse(E) rfcomm(E) af_packet(E) nf_log_ipv6(E) xt_pkttype(E) nf_log_ipv4(E) nf_log_common(E) xt_LOG(E) xt_limit(E) bnep(E) ip6t_REJECT(E) nf_reject_ipv6(E) xt_tcpudp(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ip6table_raw(E) ipt_REJECT(E) nf_reject_ipv4(E) iptable_raw(E) xt_CT(E) iptable_filter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) uvcvideo(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_core(E) v4l2_common(E) videodev(E) hid_generic(E) usbhid(E) idmouse(E) crc16(E) xfs(E) libcrc32c(E) raid0(E) snd_hda_codec_hdmi(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  bcache(E) arc4(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) iwldvm(E) snd_hda_codec_idt(E) coretemp(E) mac80211(E) snd_hda_codec_generic(E) kvm_intel(E) kvm(E) md_mod(E) crct10dif_pclmul(E) snd_hda_intel(E) snd_hda_codec(E) crc32_pclmul(E) ghash_clmulni_intel(E) drbg(E) iwlwifi(E) snd_hda_core(E) ansi_cprng(E) snd_hwdep(E) snd_pcm(E) aesni_intel(E) snd_timer(E) aes_x86_64(E) lrw(E) gf128mul(E) glue_helper(E) ablk_helper(E) cfg80211(E) snd(E) joydev(E) iTCO_wdt(E) hp_wmi(E) hp_accel(E) ppdev(E) e1000e(E) iTCO_vendor_support(E) sparse_keymap(E) i2c_i801(E) mxm_wmi(E) pcspkr(E) serio_raw(E) lis3lv02d(E) parport_pc(E) cryptd(E) rfkill(E) tpm_infineon(E) input_polldev(E) mei_me(E) mei(E) xhci_pci(E) soundcore(E) parport(E) xhci_hcd(E) lpc_ich(E) ptp(E) mfd_core(E) shpchp(E) battery(E) pps_core(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  thermal(E) ac(E) processor(E) dm_mod(E) btrfs(E) xor(E) raid6_pq(E) sr_mod(E) cdrom(E) sd_mod(E) crc32c_intel(E) ahci(E) libahci(E) libata(E) i915(E) i2c_algo_bit(E) drm_kms_helper(E) ehci_pci(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ehci_hcd(E) fb_sys_fops(E) usbcore(E) drm(E) usb_common(E) wmi(E) video(E) button(E) sg(E) scsi_mod(E) autofs4(E)
Oct 13 14:41:03 linux-dtbq.site kernel: CPU: 0 PID: 2911 Comm: kworker/0:3 Tainted: G        W   E   4.3.0-rc5-default+ #4
Oct 13 14:41:03 linux-dtbq.site kernel: Hardware name: Hewlett-Packard HP EliteBook 8780w/190A, BIOS L70 Ver. 93.01 05/17/2013
Oct 13 14:41:03 linux-dtbq.site kernel: Workqueue: pciehp-0 pciehp_power_thread
Oct 13 14:41:03 linux-dtbq.site kernel:  ffffffff81856cb1 ffff88061c01bba0 ffffffff812e3e26 0000000000000000
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff88061c01bbd8 ffffffff810647a6 ffff88049bcff000 ffff88049bcff118
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff880690fdd000 ffff880497717000 ffff880497717000 ffff88061c01bbe8
Oct 13 14:41:03 linux-dtbq.site kernel: Call Trace:
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812e3e26>] dump_stack+0x44/0x5e
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff810647a6>] warn_slowpath_common+0x86/0xc0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8106489a>] warn_slowpath_null+0x1a/0x20
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81322b00>] pci_add_new_bus+0x3d0/0x3f0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8132aa5b>] ? pci_find_next_bus+0x4b/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323714>] pci_scan_bridge+0x554/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff813238af>] pci_scan_child_bus+0xaf/0x140
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323690>] pci_scan_bridge+0x4d0/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81341a0f>] pci_hp_add_bridge+0x6f/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e5c4>] pciehp_configure_device+0x74/0x120
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e0c3>] pciehp_enable_slot+0x163/0x280
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e2cb>] pciehp_power_thread+0x3b/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c119>] process_one_work+0x149/0x3e0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c94a>] worker_thread+0x11a/0x460
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c830>] ? max_active_store+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081d69>] kthread+0xc9/0xe0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff815a705f>] ret_from_fork+0x3f/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel: ---[ end trace fcbcb9f14a5da4b9 ]---
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:05.0: PCI bridge to [bus 07-ff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:05.0:   bridge window [io  0x0000-0x0fff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:05.0:   bridge window [mem 0x00000000-0x000fffff]
Oct 13 14:41:03 linux-dtbq.site kernel: pci 0000:03:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
Oct 13 14:41:03 linux-dtbq.site kernel: pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
Oct 13 14:41:03 linux-dtbq.site kernel: ------------[ cut here ]------------
Oct 13 14:41:03 linux-dtbq.site kernel: WARNING: CPU: 0 PID: 2911 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x64/0x80()
Oct 13 14:41:03 linux-dtbq.site kernel: sysfs: cannot create duplicate filename '/class/pci_bus/0000:08'
Oct 13 14:41:03 linux-dtbq.site kernel: Modules linked in: ext4(E) mbcache(E) jbd2(E) uas(E) usb_storage(E) fuse(E) rfcomm(E) af_packet(E) nf_log_ipv6(E) xt_pkttype(E) nf_log_ipv4(E) nf_log_common(E) xt_LOG(E) xt_limit(E) bnep(E) ip6t_REJECT(E) nf_reject_ipv6(E) xt_tcpudp(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ip6table_raw(E) ipt_REJECT(E) nf_reject_ipv4(E) iptable_raw(E) xt_CT(E) iptable_filter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) uvcvideo(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) videobuf2_vmalloc(E) videobuf2_memops(E) videobuf2_core(E) v4l2_common(E) videodev(E) hid_generic(E) usbhid(E) idmouse(E) crc16(E) xfs(E) libcrc32c(E) raid0(E) snd_hda_codec_hdmi(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  bcache(E) arc4(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) iwldvm(E) snd_hda_codec_idt(E) coretemp(E) mac80211(E) snd_hda_codec_generic(E) kvm_intel(E) kvm(E) md_mod(E) crct10dif_pclmul(E) snd_hda_intel(E) snd_hda_codec(E) crc32_pclmul(E) ghash_clmulni_intel(E) drbg(E) iwlwifi(E) snd_hda_core(E) ansi_cprng(E) snd_hwdep(E) snd_pcm(E) aesni_intel(E) snd_timer(E) aes_x86_64(E) lrw(E) gf128mul(E) glue_helper(E) ablk_helper(E) cfg80211(E) snd(E) joydev(E) iTCO_wdt(E) hp_wmi(E) hp_accel(E) ppdev(E) e1000e(E) iTCO_vendor_support(E) sparse_keymap(E) i2c_i801(E) mxm_wmi(E) pcspkr(E) serio_raw(E) lis3lv02d(E) parport_pc(E) cryptd(E) rfkill(E) tpm_infineon(E) input_polldev(E) mei_me(E) mei(E) xhci_pci(E) soundcore(E) parport(E) xhci_hcd(E) lpc_ich(E) ptp(E) mfd_core(E) shpchp(E) battery(E) pps_core(E)
Oct 13 14:41:03 linux-dtbq.site kernel:  thermal(E) ac(E) processor(E) dm_mod(E) btrfs(E) xor(E) raid6_pq(E) sr_mod(E) cdrom(E) sd_mod(E) crc32c_intel(E) ahci(E) libahci(E) libata(E) i915(E) i2c_algo_bit(E) drm_kms_helper(E) ehci_pci(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ehci_hcd(E) fb_sys_fops(E) usbcore(E) drm(E) usb_common(E) wmi(E) video(E) button(E) sg(E) scsi_mod(E) autofs4(E)
Oct 13 14:41:03 linux-dtbq.site kernel: CPU: 0 PID: 2911 Comm: kworker/0:3 Tainted: G        W   E   4.3.0-rc5-default+ #4
Oct 13 14:41:03 linux-dtbq.site kernel: Hardware name: Hewlett-Packard HP EliteBook 8780w/190A, BIOS L70 Ver. 93.01 05/17/2013
Oct 13 14:41:03 linux-dtbq.site kernel: Workqueue: pciehp-0 pciehp_power_thread
Oct 13 14:41:03 linux-dtbq.site kernel:  ffffffff8183fa6a ffff88061c01ba78 ffffffff812e3e26 ffff88061c01bac0
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff88061c01bab0 ffffffff810647a6 ffff8805b82b5000 ffff880539731a20
Oct 13 14:41:03 linux-dtbq.site kernel:  ffff880692b26118 0000000000000001 ffffffffffffffef ffff88061c01bb10
Oct 13 14:41:03 linux-dtbq.site kernel: Call Trace:
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812e3e26>] dump_stack+0x44/0x5e
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff810647a6>] warn_slowpath_common+0x86/0xc0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8106482c>] warn_slowpath_fmt+0x4c/0x50
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812450b8>] ? kernfs_path+0x48/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81248644>] sysfs_warn_dup+0x64/0x80
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff812489d3>] sysfs_do_create_link_sd.isra.2+0xa3/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81248a05>] sysfs_create_link+0x25/0x40
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8140bd6d>] device_add+0x27d/0x5e0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8140c0ea>] device_register+0x1a/0x20
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff813228ba>] pci_add_new_bus+0x18a/0x3f0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8132aa5b>] ? pci_find_next_bus+0x4b/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323714>] pci_scan_bridge+0x554/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff813238af>] pci_scan_child_bus+0xaf/0x140
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81323690>] pci_scan_bridge+0x4d0/0x640
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81341a0f>] pci_hp_add_bridge+0x6f/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e5c4>] pciehp_configure_device+0x74/0x120
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e0c3>] pciehp_enable_slot+0x163/0x280
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8133e2cb>] pciehp_power_thread+0x3b/0xb0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c119>] process_one_work+0x149/0x3e0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c94a>] worker_thread+0x11a/0x460
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff8107c830>] ? max_active_store+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081d69>] kthread+0xc9/0xe0
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff815a705f>] ret_from_fork+0x3f/0x70
Oct 13 14:41:03 linux-dtbq.site kernel:  [<ffffffff81081ca0>] ? kthread_park+0x60/0x60
Oct 13 14:41:03 linux-dtbq.site kernel: ---[ end trace fcbcb9f14a5da4ba ]---
Oct 13 14:41:03 linux-dtbq.site kernel: ------------[ cut here ]------------

This is on an HP laptop.

Regards
Oliver



