Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39547 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbbJIOSI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 10:18:08 -0400
Message-ID: <5617CC9B.7070405@arm.com>
Date: Fri, 09 Oct 2015 15:18:03 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
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
	"hauke@hauke-m.de" <hauke@hauke-m.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
References: <1444146289-28940-1-git-send-email-bharatku@xilinx.com> <5613F310.6060305@arm.com> <8520D5D51A55D047800579B09414719801690DEC@XAP-PVEXMBX01.xlnx.xilinx.com>
In-Reply-To: <8520D5D51A55D047800579B09414719801690DEC@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/10/15 14:47, Bharat Kumar Gogada wrote:
>> Hi Bharat,
>>>> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
>>> 
>>> +/* SSPL ERROR */ +#define SLVERR					0x02 +#define DECERR
>>> 0x03 + +struct nwl_msi {			/* struct nwl_msi - MSI information
>> */
>>> +	struct msi_controller chip;	/* chip: MSI controller */
>> 
>> We're moving away from msi_controller altogether, as the kernel now
>> has all the necessary infrastructure to do this properly.
>> 
>> Please convert this driver to msi domains (see
>> drivers/pci/host/pci-xgene- msi.c or the gic-v2m driver as examples
>> of how this is being done).
> 
> As suggested I have gone through the code in pci-gene-msi.c for msi
> domains, and have gone through IRQ Domain documentation. I mainly
> observe when we have more than one interrupt controller involved 
> between device and cpu we use "Hierarchy IRQ domain" (parent and
> child msi domains). But in our case we don't have any such Hierarchy
> and we have single interrupt controller. In such case is it necessary
> to use multiple domains in software which actually isn't case in
> hardware.

This is not optional. The generic MSI domain is stacked on top of the
one that drives the HW. Which is exactly the XGene case. Your case is
not different in any way, and the exact same methods apply:

	MSI -> RandomHW -> Interrupt controller (GIC)

We can argue about it as long as you want, but there is no way we're
adding more msi_controller madness to the tree. It took us a long time,
but we now have a generic way to do MSIs in the kernel, and you need to
use it, not sidestep it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
