Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF654C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C69217F5
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfC2MWO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:22:14 -0400
Received: from foss.arm.com ([217.140.101.70]:58804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbfC2MWO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 08:22:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F012580D;
        Fri, 29 Mar 2019 05:22:13 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95D063F575;
        Fri, 29 Mar 2019 05:22:11 -0700 (PDT)
Date:   Fri, 29 Mar 2019 12:22:06 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, wangkefeng.wang@huawei.com,
        arnd@arndb.de, rafael@kernel.org, linux-pci@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        andy.shevchenko@gmail.com, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>, bp@suse.de,
        linux@roeck-us.net
Subject: Re: [RFC PATCH v2 1/3] resource: Request IO port regions from
 children of ioport_resource
Message-ID: <20190329122206.GA28421@e107981-ln.cambridge.arm.com>
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
 <1553105650-28012-2-git-send-email-john.garry@huawei.com>
 <20190325233255.GF24180@google.com>
 <b9164269-c2a1-e0fa-4c17-2d06fb42f39b@huawei.com>
 <20190326224810.GY24180@google.com>
 <20190328174655.GC19825@red-moon>
 <418943e2-19cd-f4b9-b5e1-2a49bce99b66@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418943e2-19cd-f4b9-b5e1-2a49bce99b66@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 29, 2019 at 10:42:17AM +0000, John Garry wrote:
> On 28/03/2019 17:46, Lorenzo Pieralisi wrote:
> >On Tue, Mar 26, 2019 at 05:48:10PM -0500, Bjorn Helgaas wrote:
> >
> >[...]
> >
> 
> Hi Lorenzo,
> 
> 
> >>I'm not convinced about this last sentence.
> >>
> >>It's true that on most modern systems, including that Intel PCH, the
> >>Super I/O controller is attached via an LPC bridge on a PCI bus.
> >>
> >>But I don't think it's an actual requirement that PCI be involved.
> >>There certainly once were systems, e.g., PC/104, that had ISA devices
> >>but no PCI.  Maybe Super I/O attached via ISA is obsolete enough that
> >>we don't care any more, but I really don't know.
> >>
> >>>>On x86, I think inb/inw/inl from a port where nothing responds
> >>>>probably just returns ~0, and outb/outw/outl just get dropped.
> >>>>Shouldn't arm64 do the same, without crashing?
> >>>
> >>>That would be ideal and we're doing something similar in patch 2/3.
> >>>
> >>>So on ARM64 we have to IO remap the PCI IO resource. If this mapping is not
> >>>done (due to no PCI host), then any inb/inw/inl calls will crash the system.
> >>
> >>My take is that ARM64 is responsible for implementing inb/inw/inl in
> >>such a way that they don't crash.  I don't think it's practical to
> >>update all the old ISA drivers or even the core code to work around
> >>that.
> >
> >The problem is that those drivers are accessing a resource that does not
> >exist in practice, it is taken for granted on x86 systems (and on IA64)
> >because that was an actual bus (actual or emulated) and was made part of
> >the architecture. The ISA space is not necessarily tied to PCI,
> >at least not always.
> >
> >Side note: these drivers can't be compiled on PPC, it would be
> >good to understand why, I have a hunch it can be related.
> 
> I mentioned this earlier:
> 
> I saw that in commits like 746cdfbf01c0 ("hwmon: Avoid building drivers
> forpowerpc that read/write ISA addresses"), PPC would not build these
> drivers, as, like arm, it has no native ISA.
> 
> However I still don't think just avoiding compiling these drivers for
> certain archs solves the problem.

No it does not but I would like to understand how relevant is fixing
those drivers (that should not use ISA IO space without first claiming
their resources, for the records) given that PPC did not even try and
apparently that's not a problem.

> 
> [...]
> 
> >>>>>[1] https://www.spinics.net/lists/linux-pci/msg49821.html
> >>>>
> >>>>Please use a https://lore.kernel.org/ URL instead of spinics.net.
> >>>
> >>>ok, I hope that I can find this old thread.
> >>
> >>The beauty of lore.kernel.org is that the URL contains the Message-ID, so
> >>it's easy build the URL and it would contain useful information even if
> >>lore.kernel.org disappeared:
> >>
> >>https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
> >
> >Yes, the bottom line is what Arnd outlined in the thread above.
> >
> >ISA IO port space is not necessarily PCI but it does not exist
> >architecturally on ARM systems.
> >
> >Taking the example of IA64, the ISA space is memory mapped (like any
> >other arch except for x86) but IIUC the virtual mapping for the ISA
> >port space _always_ exists on IA64 so this issue won't happen.
> >
> >Arnd pointed out a solution in the thread above but I need to check
> >if that's feasible.
> 
> I doubt that it can work now.
> 
> Since we when introduced the concept of logical PIO space, this IO space
> became sparely populated by 2 regions - MMIO and indirect IO - so we cannot
> grow it as we map in regions. I also don't think it works for when we IO
> unmap regions.

I do not have the full picture but I suspect that, apart from x86/IA64,
this is a common issue across architectures, I am trying to untangle
how ARM 32-bit deals with this (if it does).

Lorenzo
