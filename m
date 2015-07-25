Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:32831 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbbGYAFt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 20:05:49 -0400
Received: by oige126 with SMTP id e126so27661803oig.0
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2015 17:05:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150724224258.GA23990@google.com>
References: <20150724224258.GA23990@google.com>
From: Duc Dang <dhdang@apm.com>
Date: Fri, 24 Jul 2015 17:05:19 -0700
Message-ID: <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in pci_generic_config_read32
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Fri, Jul 24, 2015 at 3:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> I regularly see faults like this on an APM X-Gene:
>
>   U-Boot 2013.04-mustang_sw_1.14.14 (Dec 16 2014 - 15:59:33)
>   CPU0: APM ARM 64-bit Potenza Rev B0 2400MHz PCP 2400MHz
>        32 KB ICACHE, 32 KB DCACHE
>        SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
>   ...
>   Unhandled fault: synchronous external abort (0x96000010) at 0xffffff8000110034
>   Internal error: : 96000010 [#1] SMP
>   Modules linked in:
>   CPU: 0 PID: 3723 Comm: ... 4.1.0-smp-DEV #3
>   Hardware name: APM X-Gene Mustang board (DT)
>   task: ffffffc7dc1a4140 ti: ffffffc7dc118000 task.ti: ffffffc7dc118000
>   PC is at pci_generic_config_read32+0x4c/0xb8
>   LR is at pci_generic_config_read32+0x40/0xb8
>   pc : [<ffffffc00033b90c>] lr : [<ffffffc00033b900>] pstate: 600001c5
>   ...
>   Call trace:
>   [<ffffffc00033b90c>] pci_generic_config_read32+0x4c/0xb8
>   [<ffffffc00033bf58>] pci_user_read_config_byte+0x60/0xc4
>   [<ffffffc0003496a8>] pci_read_config+0x15c/0x238
>   [<ffffffc0002393b4>] sysfs_kf_bin_read+0x68/0xa0
>   [<ffffffc00023896c>] kernfs_fop_read+0x9c/0x1ac
>   [<ffffffc0001c361c>] __vfs_read+0x44/0x128
>   [<ffffffc0001c3e28>] vfs_read+0x84/0x144
>   [<ffffffc0001c4764>] SyS_read+0x50/0xb0

The log shows kernel gets an exception when trying to access Mellanox
card configuration space. This is usually due to suboptimal PCIe
SerDes parameters are using in your board, which will cause bad link
quality.
The PCIe SerDes programming is done in U-Boot, so I suggest you do a
U-Boot upgrade to our latest X-Gene U-Boot release.

In order to access latest X-Gene U-Boot release, please use APM
official support channel:
https://myapm.apm.com

Please register an account at myapm.apm.com if you don't have one
using following link:
https://myapm.apm.com/user/register

>
>   # lspci
>   00:00.0 PCI bridge: Applied Micro Circuits Corp. Device e004 (rev 04)
>   01:00.0 Ethernet controller: Mellanox Technologies MT27520 Family
>
> I first saw this on an ancient kernel and thought it was likely specific to
> my environment, but I'm now using an almost unmodified v4.1 kernel and
> still seeing it.  Does anybody else see this?  The box does have a PCI card
> installed, but I haven't yet worked out what device's config space we're
> trying to read.
>
> Is there anything I can do to debug this?  I'm not an arm64 guy, but my
> impression is that this is a page fault, and the address seems to be in the
> "cfg" area ioremapped by xgene_pcie_map_reg(), so I'm not sure this is
> really a PCI issue -- maybe that page mapping got trashed by somebody else?
>
> Bjorn


-- 
Regards,
Duc Dang.
