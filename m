Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58770 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbcBZLrh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Feb 2016 06:47:37 -0500
Date: Fri, 26 Feb 2016 11:46:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Will Deacon <will.deacon@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>,
	Tianhong Ding <dingtianhong@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 2/2] PCI: generic: add description of property
 "interrupt-skip-mask"
Message-ID: <20160226114643.GA8728@leverpostej>
References: <1456401208-10136-1-git-send-email-thunder.leizhen@huawei.com>
 <1456401208-10136-2-git-send-email-thunder.leizhen@huawei.com>
 <20160225122035.GB10593@leverpostej>
 <56CFFC9B.20703@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56CFFC9B.20703@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 26, 2016 at 03:19:55PM +0800, Leizhen (ThunderTown) wrote:
> 
> On 2016/2/25 20:20, Mark Rutland wrote:
> > Hi,
> > 
> > In future, please send the binding document first in a series, per point
> > 3 of Documentation/devicetree/bindings/submitting-patches.txt. It makes
> > review easier/faster.
> Thank you for your reminding.
> 
> > On Thu, Feb 25, 2016 at 07:53:28PM +0800, Zhen Lei wrote:
> >> Interrupt Pin register is read-only and optional. Some pci devices may use
> >> msi/msix but leave the value of Interrupt Pin non-zero.
> > 
> > Is that permitted by the spec? Surely 'optional' means it must be zero
> > if not implemented?
> 
> In <PCI Local Bus Specification Revision 3.0>:
> Devices (or device functions) that do not use an interrupt pin must put a 0 in this register. This register is read-only.
> 
> So, do you think this is a hardware bug?

Per the above, that does appear to be the case.

> But these pci-devices are not produced by our company.
> 
> In function init_service_irqs, it try msix first, then msi, Interrupt
> PIN is the last attemption. But of_irq_parse_pci() happened before
> this.

I assume that for devices with 0 in this register we do not produce a
warning. So where do we check the interrupt pin register, and when does
this happen relative to of_irq_parse_pci such that we do not produce
that warning?

I als assume that all instances of these particular devices broken in
this regard? If so, I think we need to identify them by Device ID and
Vendor ID, and treat them as if the interrupt pin register read as
zero, in the place we normally check the interrupt pin register.

Note that this is completely independent of the RID/BDF, so the
interrupt-*-mask approach is insufficient.

> In fact, there also a familiar problem exist. As below:
> pci 0000:42:00.0: BAR 7: no space for [io  size 0x1000]
> pci 0000:42:00.0: BAR 7: failed to assign [io  size 0x1000]
> 
> There no "io space" on arm64, maybe only exist on X86. And the Memory Space Indicator also read-only in BAR register.

I'm not entirely sure, but I thought we handled the PCI I/O space as an
MMIO region on ARM64. Do you have many devices/functions attached? It
may be that our VA carveout of 16M is too small.

This is probably worth a separate thread.

> >> In this case, the driver will print information as below: pci
> >> 0000:40:00.0: of_irq_parse_pci() failed with rc=-22
> >>
> >> It's easily lead to misinterpret.
> > 
> > If this is limited to a subset of devices which we know are broken in
> > this regard, can we not handle these cases explicitly?
> Actually, we have another way to block this warning. Use "interrupt-map" to map it to a pesudo IRQ. But I think it will also be misunderstanded.

This is very fragile, as it depends on the RIDs/addresses assigned by
the host controller. If devices are plugged into different slots then
that could change, you get the warning, and other devices may be
prevented from using wired interrupts.

As I mentioned above, I think we need to identify the buggy devices by
ID, rather than by topology.

Thanks,
Mark.
