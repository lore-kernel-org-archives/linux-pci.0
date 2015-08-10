Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36633 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbbHJW3N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 18:29:13 -0400
Received: by oiev193 with SMTP id v193so65174232oie.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 15:29:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150810220413.GA13982@google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150804215457.9189.27595.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <55C37C92.1020509@arm.com> <20150810220413.GA13982@google.com>
From: Duc Dang <dhdang@apm.com>
Date: Mon, 10 Aug 2015 15:28:43 -0700
Message-ID: <CADaLNDmAzFhqWcR4mD3+Oi=eTu6zaSeNzZrc186_3Va2QaXw2g@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] PCI: xgene: Use pci_scan_root_bus_msi()
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <James.Morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 10, 2015 at 3:04 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Hi Marc,
>
> On Thu, Aug 06, 2015 at 04:26:10PM +0100, Marc Zyngier wrote:
>> On 04/08/15 22:54, Bjorn Helgaas wrote:
>> > Previously there was no way to specify the MSI controller when creating a
>> > new PCI root bus, so we had to create the bus, set its MSI controller, then
>> > scan the bus.  With the new pci_scan_root_bus_msi() interface, we can
>> > specify the MSI controller up front and get rid of that intermediate step.
>> >
>> > Look up the MSI controller first, then use pci_scan_root_bus_msi() to
>> > create and scan the root PCI bus.
>>
>> I'm wondering about these XGene patches.
>>
>> With the code that is queued for v4.3 in tip/irq/core, the X-Gene MSI
>> driver doesn't export a struct msi_controller anymore, and entirely
>> relies on IRQ domains to identify to be matched with the actual PCI driver.
>>
>> Do you intend this as a cleanup until everything lands in mainline? At
>> that point, we'd be able to remove all traces of struct msi_controller
>> from this driver.
>
> I haven't been following the IRQ domain stuff or tip/irq/core, so I
> really don't know how this relates to that.  I took a look, and I see
> 8d63bc7beaee ("PCI/MSI: pci-xgene-msi: Get rid of struct
> msi_controller"), which removes an msi_controller pointer from
> pci-xgene-msi.c, but I don't see any pci-xgene.c changes in
> tip/irq/core.
>
> Are you saying that xgene_pcie_msi_enable() will go away eventually?
> And the OF "msi-parent" lookup will go away, or at least be moved
> elsewhere?  We currently have:
>
>   xgene_pcie_probe_bridge(...)
>   {
>     ...
>     bus = pci_create_root_bus(...);
>     xgene_pcie_msi_enable(...);
>     pci_scan_child_bus(bus);
>     ...
>   }
>
> I'd like to get rid of that arch-specific MSI enable stuff because
> then we can use a higher level interface, e.g., pci_scan_root_bus(),
> and make the X-Gene code slightly simpler.
>
>> Alternatively, we could ask tglx to add an extra patch to the existing
>> queue in order to clean up pci-xgene.c (nuking the whole
>> xgene_pcie_msi_enable function).
>
> Ah, I guess you *are* saying that xgene_pcie_msi_enable() will go away
> eventually.  I don't know how to do that, but apparently you do, so
> I'll just drop these X-Gene-related patches for now.

Hi Bjorn,

I tested PCIe MSI with Marc's patch on X-Gene platform and it was working fine.
xgene_pcie_msi_enable will go away. I will post clean up patch to
remove these msi_controller traces
for X-Gene.

>
> Bjorn



-- 
Regards,
Duc Dang.
