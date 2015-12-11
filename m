Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60096 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbbLKJdN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Dec 2015 04:33:13 -0500
Message-ID: <566A9852.7060109@arm.com>
Date: Fri, 11 Dec 2015 09:33:06 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"sbranden@broadcom.com" <sbranden@broadcom.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	Paul Burton <paul.burton@imgtec.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
References: <1448798633-12697-1-git-send-email-bharatku@xilinx.com> <20151209231921.GI31930@localhost> <8520D5D51A55D047800579B09414719825869A85@XAP-PVEXMBX01.xlnx.xilinx.com> <20151210201817.GB367@localhost>
In-Reply-To: <20151210201817.GB367@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/12/15 20:18, Bjorn Helgaas wrote:
> [+cc Marc for irq_dispose_mapping() question]

>>>> +		}
>>>> +	} while (status);
>>>> +
>>>> +	return retval;
>>>>
>>>> +	for (i = 0; i < 4; i++) {
>>>> +		irq = irq_find_mapping(pcie->legacy_irq_domain, i + 1);
>>>> +		if (irq > 0)
>>>> +			irq_dispose_mapping(irq);
>>>> +	}
>>>> +	if (pcie->legacy_irq_domain)
>>>> +		irq_domain_remove(pcie->legacy_irq_domain);
>>>
>>> Something seems wrong here.  I don't know when irq_dispose_mapping() is
>>> required, but it's not used consistently in drivers/pci, and it should be.
>>> Currently, only pci-tegra.c, pcie-xilinx.c, and this new driver use it.  Tegra uses
>>> it only for MSIs, and Xilinx seems to use it for both MSIs and INTx.  What's
>>> right?
>> Its not related to MSI or INTx, its related to domain, for freeing irq descriptor associated with irq.
> 
> So are you saying that other drivers in drivers/pci/host should be
> using irq_dispose_mapping(), but they aren't?
> 
> Marc, can you chime in here?

This indeed looks like be a bug in most drivers. Having a mapping left
when freeing the domain has a couple of side effects:
- We leak virtual interrupt numbers
- If the domain is backed by a radix tree, we leak the tree as well (but
irq_domain_remove will shout if that's the case).

So I think using irq_dispose_mapping is the right thing to do, and that
we should fix the other drivers (and maybe provide a convenient helper
to that effect).

I'll try to come up with something.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
