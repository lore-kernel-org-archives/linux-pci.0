Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B11C43382
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 22:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14E720833
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 22:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=colorremedies-com.20150623.gappssmtp.com header.i=@colorremedies-com.20150623.gappssmtp.com header.b="a6AUpCUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14E720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeIYEcz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:32:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36314 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIYEcz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 00:32:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id v17-v6so14301127lfe.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Sep 2018 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=igwF53H0rAttH8xDmAmo6a+QEj5OL73Ox6Fsdmielc4=;
        b=a6AUpCUNU5Li4cmEuExPBYRp/6ahSqaJNdzpBAeSel2UDEAqrOH4IpvRlOg2OVQYD7
         x0u9Uf9VVz3T3WBm4ll/5b6ooX3UKfL+vVxf5fUxpsX2AMBswJU5TPMkgtuF7oVpqssw
         e3BJLzTJrTPGa7hEB/2x5Q8p4VW9OTC2w1GT66nyO2I9bJIlo86vUFs0Q9FxulKcAmZi
         fXK+tYeGRf0A2FU3eNf7pmGmjasWmgK0cl66S6FziUQSfWAVbKQws2nYze7PYeOjJSCg
         uHabJ1Xn2GkAjGJ/25wXIOTrCocP/Wtjzygag4Ash63TN+5JZRnKlpU9YZ1+ILr1J2s7
         15eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=igwF53H0rAttH8xDmAmo6a+QEj5OL73Ox6Fsdmielc4=;
        b=Ovwazo9QSSwGlyNmtdbwQDdB4Bxfa1Cm/qnQBlImqdwCVq1b9urpfTeBeLxRTJv7+m
         tQlrvltF4gwDWJYCENtRs98zVvpnsSr3BU2txNCmQ3f7eadIEz/J65jV8fc55LkRWKeP
         3Pa5V11L5cHaDLsu5tdRQywZQL41gxAnkDs0i784KZUrTMDmfl/CYqpirj90gCYDFzT3
         tqydy9w4Rty7phnI67Wd9GuqEPwgPCK6JVMJ2KqsAokH/60P4olCkorrG3oqeBb9sfKN
         UMU4/pgtXMMTQbkU/DrpGUa/AfxEC46zms86pQvl+0LNPUtJ7iyolBMLBr2cj8LsKcHO
         71lg==
X-Gm-Message-State: ABuFfogRyS4v8gvADjLevTl13WFFbg3E61G21Llmm8d0tLaCiVuprJxr
        10zUfu/srbUa4lbTef7fXr6LYhczfhTgSCYg0EIIXQ==
X-Google-Smtp-Source: ACcGV6357mDO/AWwc3kEPUk/wABbcPrjWoUiFlvYyreLSRUVj1Vsa36tyxuY/rs0wUV8dvDJyYQY5Ijob2Hmt2T9dnU=
X-Received: by 2002:a19:988a:: with SMTP id a132-v6mr538241lfe.76.1537828107100;
 Mon, 24 Sep 2018 15:28:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5697:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 15:28:26
 -0700 (PDT)
X-Originating-IP: [69.7.113.20]
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Sep 2018 16:28:26 -0600
X-Google-Sender-Auth: _PtHLbtQxcW_v3JYOJ4vkwK69r0
Message-ID: <CAJCQCtTcgH-SB7s7EqM55PRQoG9u+EJOovJSRMoDwVSH8bJYOQ@mail.gmail.com>
Subject: WARNING: at drivers/thunderbolt/switch.c:594 tb_switch_add+0x69b/0x780
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This appears to be new in 4.19 rc5. But it doesn't happen every boot.
Details and attachments in the bug:
https://bugzilla.kernel.org/show_bug.cgi?id=201227



[   35.502605] f29h.local kernel: pci_bus 0000:02: Allocating resources
[   51.172922] f29h.local kernel: thunderbolt 0000:03:00.0: timeout
reading config space 1 from 0x1
[   51.172925] f29h.local kernel: ------------[ cut here ]------------
[   51.172927] f29h.local kernel: thunderbolt 0000:03:00.0: 0:3: non
switch port without a PHY
[   51.172954] f29h.local kernel: WARNING: CPU: 2 PID: 2036 at
drivers/thunderbolt/switch.c:594 tb_switch_add+0x69b/0x780
[thunderbolt]
[   51.172955] f29h.local kernel: Modules linked in: hidp vfat fat
thunderbolt(+) rfcomm fuse ccm devlink nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ebtable_nat ebtable_broute bridge stp llc ip6table_nat
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat
nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables cmac bnep sunrpc
arc4 intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp hp_wmi
iTCO_wdt kvm_intel iTCO_vendor_support sparse_keymap snd_soc_skl
wmi_bmof kvm intel_wmi_thunderbolt snd_soc_skl_ipc iwlmvm
snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core
snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core mac80211
[   51.172987] f29h.local kernel:  snd_hda_codec_hdmi snd_compress
irqbypass snd_hda_codec_conexant crct10dif_pclmul
snd_hda_codec_generic ac97_bus ghash_clmulni_intel snd_pcm_dmaengine
intel_cstate snd_hda_intel iwlwifi intel_uncore snd_hda_codec
intel_rapl_perf snd_hda_core uvcvideo snd_hwdep btusb snd_seq btrtl
snd_seq_device btbcm videobuf2_vmalloc btintel videobuf2_memops
videobuf2_v4l2 snd_pcm videobuf2_common cfg80211 bluetooth videodev
joydev snd_timer media snd i2c_i801 soundcore idma64 ecdh_generic
mei_me mei rfkill intel_pch_thermal intel_lpss_pci intel_lpss
processor_thermal_device intel_soc_dts_iosf wmi int3403_thermal
int340x_thermal_zone pinctrl_sunrisepoint pinctrl_intel
int3400_thermal hp_wireless acpi_thermal_rel acpi_pad pcc_cpufreq
crc32_generic crc32_pclmul f2fs dm_crypt btrfs libcrc32c xor
zstd_decompress
[   51.173016] f29h.local kernel:  zstd_compress xxhash i915 raid6_pq
i2c_algo_bit drm_kms_helper nvme crc32c_intel drm nvme_core serio_raw
video hid_apple lz4 lz4_compress
[   51.173025] f29h.local kernel: CPU: 2 PID: 2036 Comm: systemd-udevd
Not tainted 4.19.0-0.rc5.git0.1.fc30.x86_64 #1
[   51.173027] f29h.local kernel: Hardware name: HP HP Spectre
Notebook/81A0, BIOS F.41 06/15/2018
[   51.173032] f29h.local kernel: RIP: 0010:tb_switch_add+0x69b/0x780
[thunderbolt]
[   51.173034] f29h.local kernel: Code: 89 4c 24 08 44 89 44 24 04 e8
e1 96 35 d3 44 8b 44 24 04 4c 89 f2 48 8b 4c 24 08 48 89 c6 48 c7 c7
38 e7 29 c1 e8 cf 13 e2 d2 <0f> 0b e9 fc fb ff ff 41 8b 97 ec 02 00 00
41 8b 87 e8 02 00 00 8b
[   51.173035] f29h.local kernel: RSP: 0018:ffffba6904cb3a68 EFLAGS: 00010286
[   51.173037] f29h.local kernel: RAX: 0000000000000000 RBX:
ffff923a44b46098 RCX: 0000000000000006
[   51.173039] f29h.local kernel: RDX: 0000000000000007 RSI:
0000000000000082 RDI: ffff923ab6b16860
[   51.173040] f29h.local kernel: RBP: ffffffffc129d68d R08:
0000000000000005 R09: 0000000000000007
[   51.173041] f29h.local kernel: R10: 0000000000000000 R11:
ffffffff959b116d R12: ffffffffc129d695
[   51.173042] f29h.local kernel: R13: 0000000000000003 R14:
ffff923a59d50c68 R15: ffff923a44b464f8
[   51.173044] f29h.local kernel: FS:  00007f34253cd940(0000)
GS:ffff923ab6b00000(0000) knlGS:0000000000000000
[   51.173045] f29h.local kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[   51.173046] f29h.local kernel: CR2: 00007f15b8039228 CR3:
00000002316b4002 CR4: 00000000003606e0
[   51.173048] f29h.local kernel: Call Trace:
[   51.173054] f29h.local kernel:  icm_start+0x59/0xa0 [thunderbolt]
[   51.173059] f29h.local kernel:  tb_domain_add+0xa6/0x140 [thunderbolt]
[   51.173064] f29h.local kernel:  nhi_probe+0x2be/0x560 [thunderbolt]
[   51.173068] f29h.local kernel:  local_pci_probe+0x41/0x90
[   51.173071] f29h.local kernel:  pci_device_probe+0x188/0x1a0
[   51.173074] f29h.local kernel:  really_probe+0x235/0x3a0
[   51.173076] f29h.local kernel:  driver_probe_device+0xb3/0xf0
[   51.173079] f29h.local kernel:  __driver_attach+0xdd/0x110
[   51.173081] f29h.local kernel:  ? driver_probe_device+0xf0/0xf0
[   51.173084] f29h.local kernel:  bus_for_each_dev+0x76/0xc0
[   51.173086] f29h.local kernel:  ? klist_add_tail+0x3b/0x60
[   51.173089] f29h.local kernel:  bus_add_driver+0x152/0x230
[   51.173090] f29h.local kernel:  ? 0xffffffffc12b0000
[   51.173093] f29h.local kernel:  driver_register+0x6b/0xb0
[   51.173094] f29h.local kernel:  ? 0xffffffffc12b0000
[   51.173099] f29h.local kernel:  nhi_init+0x2b/0x1000 [thunderbolt]
[   51.173103] f29h.local kernel:  do_one_initcall+0x46/0x1c3
[   51.173105] f29h.local kernel:  ? do_init_module+0x22/0x210
[   51.173108] f29h.local kernel:  ? kmem_cache_alloc_trace+0x15f/0x1e0
[   51.173110] f29h.local kernel:  do_init_module+0x5a/0x210
[   51.173113] f29h.local kernel:  load_module+0x206d/0x22d0
[   51.173116] f29h.local kernel:  ? __do_sys_init_module+0x13d/0x180
[   51.173118] f29h.local kernel:  __do_sys_init_module+0x13d/0x180
[   51.173121] f29h.local kernel:  do_syscall_64+0x5b/0x160
[   51.173124] f29h.local kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   51.173125] f29h.local kernel: RIP: 0033:0x7f3426083f5e
[   51.173127] f29h.local kernel: Code: 48 8b 0d 2d 1f 0c 00 f7 d8 64
89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49
89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fa 1e
0c 00 f7 d8 64 89 01 48
[   51.173128] f29h.local kernel: RSP: 002b:00007ffc248b80e8 EFLAGS:
00000246 ORIG_RAX: 00000000000000af
[   51.173130] f29h.local kernel: RAX: ffffffffffffffda RBX:
0000565467470b20 RCX: 00007f3426083f5e
[   51.173132] f29h.local kernel: RDX: 00007f34261f984d RSI:
0000000000045c5e RDI: 00005654674edd00
[   51.173133] f29h.local kernel: RBP: 00007f34261f984d R08:
0000000000000006 R09: 0000000000000005
[   51.173134] f29h.local kernel: R10: 0000565467325010 R11:
0000000000000246 R12: 00005654674edd00
[   51.173135] f29h.local kernel: R13: 00005654674905b0 R14:
0000000000020000 R15: 0000000000000000
[   51.173137] f29h.local kernel: ---[ end trace 77997381a0d11433 ]---
[   51.173140] f29h.local kernel: thunderbolt 0000:03:00.0:  Port 3:
8086:1578 (Revision: 4, TB Version: 1, Type: Port (0x1))
[   51.173142] f29h.local kernel: thunderbolt 0000:03:00.0:   Max hop
id (in/out): 15/15
[   51.173144] f29h.local kernel: thunderbolt 0000:03:00.0:   Max counters: 16
[   51.173145] f29h.local kernel: thunderbolt 0000:03:00.0:   NFC
Credits: 0x3c00000
[   71.652850] f29h.local kernel: thunderbolt 0000:03:00.0: timeout
reading config space 1 from 0x0
[   71.652991] f29h.local kernel: thunderbolt 0000:03:00.0: stopping RX ring 0
