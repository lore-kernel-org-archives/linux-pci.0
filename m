Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout2.freenet.de ([195.4.92.92]:42598 "EHLO mout2.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754508AbdIHKBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Sep 2017 06:01:01 -0400
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
        by mout2.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.89 #1)
        id 1dqG5s-0001QS-4X
        for linux-pci@vger.kernel.org; Fri, 08 Sep 2017 12:01:00 +0200
Received: from [::1] (port=54354 helo=mjail2.freenet.de)
        by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.89 #1)
        id 1dqG5s-0005z9-1z
        for linux-pci@vger.kernel.org; Fri, 08 Sep 2017 12:01:00 +0200
Received: from mx16.freenet.de ([195.4.92.26]:37826)
        by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.89 #1)
        id 1dqG3J-0004OZ-WD
        for linux-pci@vger.kernel.org; Fri, 08 Sep 2017 11:58:22 +0200
Received: from p200300de53db5100505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:53db:5100:5054:ff:fe15:ac42]:58478 helo=mail.maya.org)
        by mx16.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (port 465) (Exim 4.89 #1)
        id 1dqG3J-000060-R2
        for linux-pci@vger.kernel.org; Fri, 08 Sep 2017 11:58:21 +0200
From: Andreas Hartmann <andihartmann@01019freenet.de>
Subject: AVIC warning - what does it mean?
To: linux-pci@vger.kernel.org
Message-ID: <524102f8-8879-2ed2-3dcb-3162df9062b6@01019freenet.de>
Date: Fri, 8 Sep 2017 11:58:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

If AVIC is enabled, I'm usually getting one warning like the one below a
few minutes after the VM has been started.

What does it mean?

There isn't any problem with that VM - it's just working as expected. If
AVIC is disabled, the warning doesn't come up and the VM works fine, too.

Base is a Ryzen system (RMA'd CPU w/o gcc segfaults meanwhile and X370
chipset (ASUS Prime X370-PRO with Bios 0810)). Linux is 4.9.48.


[ 1603.482692] ------------[ cut here ]------------
[ 1603.482702] WARNING: CPU: 1 PID: 2936 at ../arch/x86/kvm/svm.c:1484 avic_vcpu_load+0x162/0x190 [kvm_amd]
[ 1603.482703] Modules linked in: sr_mod cdrom uas usb_storage vhost_net tun vhost macvtap macvlan igb dca nf_log_ipv4 nf_log_common xt_LOG ipt_REJECT nf_reject_ipv4 xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_tables x_tables vfio_pci vfio_iommu_type1 vfio_virqfd vfio br_netfilter bridge stp llc iscsi_ibft iscsi_boot_sysfs snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep kvm_amd snd_pcm eeepc_wmi asus_wmi kvm sparse_keymap snd_seq rfkill video snd_seq_device mxm_wmi irqbypass snd_timer sp5100_tco i2c_piix4 snd pcspkr e1000e soundcore ptp pps_core fjes pinctrl_amd gpio_amdpt acpi_cpufreq gpio_generic 8250_dw tpm_tis shpchp i2c_designware_platform wmi i2c_designware_core tpm_tis_core button tpm nfsd auth_rpcgss nfs_acl
[ 1603.482740]  lockd grace sunrpc xfs libcrc32c dm_crypt algif_skcipher af_alg hid_generic usbhid raid1 md_mod amdkfd amd_iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm serio_raw drm ccp xhci_pci xhci_hcd usbcore aesni_intel aes_x86_64 glue_helper lrw ablk_helper cryptd ata_generic pata_atiixp dm_mirror dm_region_hash dm_log sg thermal dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[ 1603.482766] CPU: 1 PID: 2936 Comm: CPU 2/KVM Not tainted 4.9.48-1.1-default #1
[ 1603.482767] Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 0810 08/01/2017
[ 1603.482768]  ffffab614aa4fcb8 ffffffff893c14fa 0000000000000000 0000000000000000
[ 1603.482772]  ffffab614aa4fcf8 ffffffff89085da1 000005cc004b6f7f 0000000000000001
[ 1603.482774]  c0000007ea4bc001 0000000000000001 000001753dd1e17d ffff9e84ea7e0140
[ 1603.482776] Call Trace:
[ 1603.482798]  [<ffffffff893c14fa>] dump_stack+0x63/0x89
[ 1603.482804]  [<ffffffff89085da1>] __warn+0xd1/0xf0
[ 1603.482809]  [<ffffffff89085e8d>] warn_slowpath_null+0x1d/0x20
[ 1603.482813]  [<ffffffffc15ade42>] avic_vcpu_load+0x162/0x190 [kvm_amd]
[ 1603.482849]  [<ffffffffc0950da4>] ? kvm_cpu_has_interrupt+0x44/0x50 [kvm]
[ 1603.482852]  [<ffffffffc15ae138>] svm_vcpu_unblocking+0x18/0x20 [kvm_amd]
[ 1603.482868]  [<ffffffffc091b424>] kvm_vcpu_block+0xc4/0x310 [kvm]
[ 1603.482889]  [<ffffffffc0937fac>] kvm_arch_vcpu_ioctl_run+0x19c/0x400 [kvm]
[ 1603.482906]  [<ffffffffc091cc42>] kvm_vcpu_ioctl+0x312/0x5e0 [kvm]
[ 1603.482913]  [<ffffffff8910d10f>] ? do_futex+0x10f/0x510
[ 1603.482916]  [<ffffffff8923ec06>] do_vfs_ioctl+0x96/0x5b0
[ 1603.482921]  [<ffffffff89249767>] ? __fget+0x77/0xb0
[ 1603.482922]  [<ffffffff8923f199>] SyS_ioctl+0x79/0x90
[ 1603.482927]  [<ffffffff8900393b>] do_syscall_64+0x5b/0xd0
[ 1603.482932]  [<ffffffff89719c2f>] entry_SYSCALL64_slow_path+0x25/0x25
[ 1603.484799] ---[ end trace d24b045704bb6ae7 ]---


Thanks,
kind regards,
Andreas
