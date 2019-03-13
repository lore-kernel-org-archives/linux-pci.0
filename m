Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39601C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0522A217F5
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 16:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki-org.20150623.gappssmtp.com header.i=@mbuki-mvuki-org.20150623.gappssmtp.com header.b="0a74UO8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCMQuZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:50:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45974 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCMQuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2019 12:50:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id h99so2758952wrh.12
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2019 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=tBsvxjBznWCx4BmLg9M6SENL8GgDw631+vIslwJbWRU=;
        b=0a74UO8nUn+icfLlLnf8bVYRtIyTbA4/l+z76oT5gG1p5zIdUM+bDEo+5vqOmYUmoH
         fFs8269/q1tDuJ0EyQhrverlT+LPWZi6PTjv9YRxm/ep4tfP89WQMC6bX9+Q56EVcCGT
         p0IMFO2SnWeh9FkuZfwq+ZqdxSHkz2JxbM7W79SLAyNbmHc/GfFiq/ii07btnfIf4C+k
         2Wk2HPkoB4MivqfpEFc9eY0OZo2KIZDWsCeRFGpmoEScVu/Vw8yZrUEN+OjXMch2vUSd
         t1Hzpzsrhkac9U/2H5kc2xWQeecJDc9Isbvh2Akh3nYqnt55H/IHQsSPwyUkFj4ycMTB
         eRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tBsvxjBznWCx4BmLg9M6SENL8GgDw631+vIslwJbWRU=;
        b=doRRz6s7Bbq5ii5LeXERQ2o/bN5wl6nB//a80ZeyG0GtXhQVVOEEkLWzg8RHOByIu0
         rJvQvuqsZEaspTpbTfXdWLyRs24zwisOCCVYUcXdsSwL9pmGzapyF2IKtuaePnmYUtJU
         sQqszB8HL2vaRSWOqi4RsPbJFxGTr9Wo9mkkFzbtdkXYu9CkwSUdUjYzV0qoDWmlqDdX
         0PnZtRngsxAx2cyrMR/wJ2qYpdzqoEb3TX/3zKnjHrfJU5jZS99Gh7FxBcsSRlMUmLtu
         RIpukaKPrZKlO00QfAEjA0ckkuW4NtSX5joMRZItd0p/4CBct+XYOesfVTiDwwep7TxF
         xjqg==
X-Gm-Message-State: APjAAAViD8XP/DiEkKUVxM60LNmOvXby49V5J9caJQFIZqVcckNEQyTI
        /lwDSaSm0XH6OA4WsoSj7Y6q8OTk/ry8FHsFtMBC/w==
X-Google-Smtp-Source: APXvYqyaofohS5mNk7X1zhRkkVBvy9qja8Uxv4bRtng+jfOvL+ynLMoMq8T1IBUgotbmGvYrcp2+vHDK/femCXBFtoA=
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr27016220wrw.87.1552495818416;
 Wed, 13 Mar 2019 09:50:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Wed, 13 Mar 2019 11:50:07 -0500
Message-ID: <CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com>
Subject: Regression causes a hang on boot with a Comtrol PCI card
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Two regressions cause Linux to hang on boot when a Comtrol PCI card is present.

If I revert the following two commits, I can boot again and the card operates
without issue:

1302fcf0d03e (refs/bisect/bad) PCI: Configure *all* devices, not just
hot-added ones
1c3c5eab1715 sched/core: Enable might_sleep() and smp_processor_id()
checks early

; lspci -vs 82:00.0
82:00.0 Multiport serial controller: Comtrol Corporation Device 0061
        Subsystem: Comtrol Corporation Device 0061
        Flags: 66MHz, medium devsel, IRQ 35, NUMA node 1
        Memory at c8004000 (32-bit, non-prefetchable) [size=4K]
        Memory at c8000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Hot-plug capable
        Capabilities: [48] Power Management version 2
        Kernel driver in use: rp2
        Kernel modules: rp2

Is it possible that the problem is that the card claims to support Hot-plug,
but does not?

I would love to help fix this issue, please let me know what other information
would be helpful to provide.

; awk -f scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux tty01 5.0.1-amd64 #1 SMP Wed Mar 13 15:43:44 UTC 2019 x86_64 GNU/Linux

GNU C                   6.3.0
GNU Make                4.1
Binutils                2.28
Util-linux              2.29.2
Mount                   2.29.2
Linux C Library         2.24
Dynamic linker (ldd)    2.24
Procps                  3.3.12
Sh-utils                8.26
Udev                    232
Modules Loaded          8021q acpi_power_meter aesni_intel aes_x86_64
ahci autofs4 bonding button coretemp crc16 crc32c_generic crc32c_intel
crc32_pclmul crct10dif_pclmul cryptd crypto_simd dca dcdbas dm_mod drm
drm_kms_helper ehci_hcd ehci_pci evdev ext4 fscrypto garp
ghash_clmulni_intel glue_helper i2c_algo_bit igb intel_cstate
intel_powerclamp intel_rapl intel_rapl_perf intel_uncore ioatdma
ipmi_devintf ipmi_msghandler ipmi_si iptable_filter ip_tables
irqbypass iTCO_vendor_support iTCO_wdt ixgbe jbd2 kvm kvm_intel
libahci libata libcrc32c libphy llc lpc_ich mbcache mdio megaraid_sas
mei mei_me mgag200 mrp mxm_wmi nf_conntrack nf_defrag_ipv4
nf_defrag_ipv6 pcc_cpufreq pcspkr rp2 sb_edac scsi_mod sd_mod sg snd
snd_pcm snd_timer soundcore stp ttm usbcore wmi x86_pkg_temp_thermal
xfrm_algo x_tables xt_conntrack xt_tcpudp
