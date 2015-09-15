Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52153 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbbIORzT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Sep 2015 13:55:19 -0400
Date: Tue, 15 Sep 2015 18:55:20 +0100
From: Will Deacon <will.deacon@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	David Daney <david.daney@cavium.com>, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 5/6] PCI: generic: Pass proper starting bus number to
 pci_scan_root_bus().
Message-ID: <20150915175519.GN31157@arm.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
 <1442013719-5001-6-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442013719-5001-6-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 12, 2015 at 12:21:58AM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> If the bus is being configured with a bus-range that does not start at
> zero, pass that starting bus number to pci_scan_root_bus().  Passing
> the incorrect value of zero causes attempted config accesses outside
> of the supported range, which cascades to an OOPs spew and eventual
> kernel panic.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/pci/host/pci-host-generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index fce5bf7..8219c0b 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -265,7 +265,7 @@ static int gen_pci_probe(struct platform_device *pdev)
>  	if (!pci_has_flag(PCI_PROBE_ONLY))
>  		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
>  
> -	bus = pci_scan_root_bus(dev, 0,
> +	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
>  				&pci->cfg.ops.ops, pci, &pci->resources);
>  	if (!bus) {
>  		dev_err(dev, "Scanning rootbus failed");

Acked-by: Will Deacon <will.deacon@arm.com>

Will
