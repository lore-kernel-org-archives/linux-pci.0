Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35652 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbESXZg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 19:25:36 -0400
Received: by iesa3 with SMTP id a3so26518061ies.2
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 16:25:35 -0700 (PDT)
Date: Tue, 19 May 2015 18:25:31 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Russell King <linux@arm.linux.org.uk>,
	Lucas Stach <l.stach@pengutronix.de>,
	Simon Horman <horms@verge.net.au>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [RFC/RFT PATCH 2/2] ARM64: kernel: pci: implement PCI device
 resources claiming
Message-ID: <20150519232531.GZ31666@google.com>
References: <1431614537-16136-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1431614537-16136-2-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431614537-16136-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Thu, May 14, 2015 at 03:42:16PM +0100, Lorenzo Pieralisi wrote:
> When a device is scanned and added to the PCI bus, its resources
> should be claimed to validate the BARs configuration and to assign
> them a parent resource so that the resource hierarchy can be sanity
> checked.
> 
> This patch adds code that carries out PCI device resources claiming to
> the ARM64 pcibios_add_device implementation so that device resources
> are claimed by the core PCI layer upon PCI device initialization on
> ARM64 systems.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Seems like Suravee proposed a tweak?  Can you post a v2 with that
incorporated if necessary?

Bjorn

> ---
>  arch/arm64/kernel/pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 4095379..c0a88ca 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -43,8 +43,18 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>   */
>  int pcibios_add_device(struct pci_dev *dev)
>  {
> +	struct resource *res;
> +	int i;
> +
>  	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>  
> +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		res = &dev->resource[i];
> +		if (res->parent || !res->flags)
> +			continue;
> +		pci_claim_resource(dev, i);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.2.1
> 
