Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E46BC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F35520823
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfC1RqV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:46:21 -0400
Received: from foss.arm.com ([217.140.101.70]:49336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbfC1RqU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Mar 2019 13:46:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29EF980D;
        Thu, 28 Mar 2019 10:46:20 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 967B43F557;
        Thu, 28 Mar 2019 10:46:17 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:46:55 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, rafael@kernel.org,
        arnd@arndb.de, bp@suse.de, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        wangkefeng.wang@huawei.com, linuxarm@huawei.com,
        andy.shevchenko@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/3] resource: Request IO port regions from
 children of ioport_resource
Message-ID: <20190328174655.GC19825@red-moon>
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
 <1553105650-28012-2-git-send-email-john.garry@huawei.com>
 <20190325233255.GF24180@google.com>
 <b9164269-c2a1-e0fa-4c17-2d06fb42f39b@huawei.com>
 <20190326224810.GY24180@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326224810.GY24180@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 26, 2019 at 05:48:10PM -0500, Bjorn Helgaas wrote:

[...]

> I'm not convinced about this last sentence.
> 
> It's true that on most modern systems, including that Intel PCH, the
> Super I/O controller is attached via an LPC bridge on a PCI bus.
> 
> But I don't think it's an actual requirement that PCI be involved.
> There certainly once were systems, e.g., PC/104, that had ISA devices
> but no PCI.  Maybe Super I/O attached via ISA is obsolete enough that
> we don't care any more, but I really don't know.
> 
> > > On x86, I think inb/inw/inl from a port where nothing responds
> > > probably just returns ~0, and outb/outw/outl just get dropped.
> > > Shouldn't arm64 do the same, without crashing?
> > 
> > That would be ideal and we're doing something similar in patch 2/3.
> > 
> > So on ARM64 we have to IO remap the PCI IO resource. If this mapping is not
> > done (due to no PCI host), then any inb/inw/inl calls will crash the system.
> 
> My take is that ARM64 is responsible for implementing inb/inw/inl in
> such a way that they don't crash.  I don't think it's practical to
> update all the old ISA drivers or even the core code to work around
> that.

The problem is that those drivers are accessing a resource that does not
exist in practice, it is taken for granted on x86 systems (and on IA64)
because that was an actual bus (actual or emulated) and was made part of
the architecture. The ISA space is not necessarily tied to PCI,
at least not always.

Side note: these drivers can't be compiled on PPC, it would be
good to understand why, I have a hunch it can be related.

> > So in patch 2/3, I am also making the change to the logical PIO inb/inw/inl
> > accessors to discard accesses when no PCI MMIO regions are registered in
> > logical PIO space.
> > 
> > This is really a second line of defense (this patch being the first).
> > 
> > > > root@(none)$root@(none)$ insmod f71882fg.ko
> > > > [  152.215377] Unable to handle kernel paging request at virtual address ffff7dfffee0002e
> > > > [  152.231299] Mem abort info:
> > > > [  152.236898]   ESR = 0x96000046
> > > > [  152.243019]   Exception class = DABT (current EL), IL = 32 bits
> > > > [  152.254905]   SET = 0, FnV = 0
> > > > [  152.261024]   EA = 0, S1PTW = 0
> > > > [  152.267320] Data abort info:
> > > > [  152.273091]   ISV = 0, ISS = 0x00000046
> > > > [  152.280784]   CM = 0, WnR = 1
> > > > [  152.286730] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> > > > [  152.300537] [ffff7dfffee0002e] pgd=000000000141c003, pud=000000000141d003, pmd=0000000000000000
> > > > [  152.318016] Internal error: Oops: 96000046 [#1] PREEMPT SMP
> > > > [  152.329199] Modules linked in: f71882fg(+)
> > > > [  152.337415] CPU: 8 PID: 2732 Comm: insmod Not tainted 5.1.0-rc1-00002-gab1a0e9200b8-dirty #102
> > > > [  152.354712] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
> > > > [  152.373058] pstate: 80000005 (Nzcv daif -PAN -UAO)
> > > > [  152.382675] pc : logic_outb+0x54/0xb8
> > > > [  152.390017] lr : f71882fg_find+0x64/0x390 [f71882fg]
> > > > [  152.399977] sp : ffff000013393aa0
> > > > [  152.406618] x29: ffff000013393aa0 x28: ffff000008b98b10
> > > > [  152.417278] x27: ffff000013393df0 x26: 0000000000000100
> > > > [  152.427938] x25: ffff801f8c872d30 x24: ffff000011420000
> > > > [  152.438598] x23: ffff801fb49d2940 x22: ffff000011291000
> > > > [  152.449257] x21: 000000000000002e x20: 0000000000000087
> > > > [  152.459917] x19: ffff000013393b44 x18: ffffffffffffffff
> > > > [  152.470577] x17: 0000000000000000 x16: 0000000000000000
> > > > [  152.481236] x15: ffff00001127d6c8 x14: ffff801f8cfd691c
> > > > [  152.491896] x13: 0000000000000000 x12: 0000000000000000
> > > > [  152.502555] x11: 0000000000000003 x10: 0000801feace2000
> > > > [  152.513215] x9 : 0000000000000000 x8 : ffff841fa654f280
> > > > [  152.523874] x7 : 0000000000000000 x6 : 0000000000ffc0e3
> > > > [  152.534534] x5 : ffff000011291360 x4 : ffff801fb4949f00
> > > > [  152.545194] x3 : 0000000000ffbffe x2 : 76e767a63713d500
> > > > [  152.555853] x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
> > > > [  152.566514] Process insmod (pid: 2732, stack limit = 0x(____ptrval____))
> > > > [  152.579968] Call trace:
> > > > [  152.584863]  logic_outb+0x54/0xb8
> > > > [  152.591506]  f71882fg_find+0x64/0x390 [f71882fg]
> > > > [  152.600768]  f71882fg_init+0x38/0xc70 [f71882fg]
> > > > [  152.610031]  do_one_initcall+0x5c/0x198
> > > > [  152.617723]  do_init_module+0x54/0x1b0
> > > > [  152.625237]  load_module+0x1dc4/0x2158
> > > > [  152.632752]  __se_sys_init_module+0x14c/0x1e8
> > > > [  152.641490]  __arm64_sys_init_module+0x18/0x20
> > > > [  152.650404]  el0_svc_common+0x5c/0x100
> > > > [  152.657919]  el0_svc_handler+0x2c/0x80
> > > > [  152.665433]  el0_svc+0x8/0xc
> > > > [  152.671202] Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
> > > > [  152.683434] ---[ end trace fd4f35b610829a48 ]---
> > > > Segmentation fault
> > > > root@(none)$
> > > 
> > > > Note that the f71882fg driver correctly calls request_muxed_region().
> > > > 
> > > > This issue was originally reported in [1].
> > > > 
> > > > This patch changes the functionality of request{muxed_}_region() to
> > > > request a region from a direct child descendent of the top
> > > > ioport_resource.
> > > > 
> > > > In this, if the IO port region has not been mapped for a particular IO
> > > > region, the PCI IO resource would also not have been inserted, and so a
> > > > suitable child region will not exist. As such,
> > > > request_{muxed_}region() calls will fail.
> > > > 
> > > > A side note: there are many drivers in the kernel which fail to even call
> > > > request_{muxed_}region() prior to IO port accesses, and they also need to
> > > > be fixed (to call request_{muxed_}region(), as appropriate) separately.
> > > > 
> > > > [1] https://www.spinics.net/lists/linux-pci/msg49821.html
> > > 
> > > Please use a https://lore.kernel.org/ URL instead of spinics.net.
> > 
> > ok, I hope that I can find this old thread.
> 
> The beauty of lore.kernel.org is that the URL contains the Message-ID, so
> it's easy build the URL and it would contain useful information even if
> lore.kernel.org disappeared:
> 
> https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com

Yes, the bottom line is what Arnd outlined in the thread above.

ISA IO port space is not necessarily PCI but it does not exist
architecturally on ARM systems.

Taking the example of IA64, the ISA space is memory mapped (like any
other arch except for x86) but IIUC the virtual mapping for the ISA
port space _always_ exists on IA64 so this issue won't happen.

Arnd pointed out a solution in the thread above but I need to check
if that's feasible.

Lorenzo
