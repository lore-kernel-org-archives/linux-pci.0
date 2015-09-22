Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58668 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbbIVQFe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Sep 2015 12:05:34 -0400
Date: Tue, 22 Sep 2015 17:05:49 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/3] PCI: generic: Add support for Cavium ThunderX PCIe
 root complexes.
Message-ID: <20150922160549.GE17444@red-moon>
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
 <1442529694-1792-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442529694-1792-4-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 17, 2015 at 11:41:34PM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The config space for external PCIe root complexes on some Cavium
> ThunderX SoCs is very similar to CAM and ECAM, but differs in the
> shift values that have to be applied to the bus and devfn numbers to
> compose that address window offset.  These root complexes also have
> the interesting property that there is no root bridge, so the standard
> manner of limiting scanning to only the first device doesn't work.  We
> can use the standard pci-host-generic driver if we make a minor
> addition to handle these differences, so we...
> 
> Add a mapping function for ThunderX PCIe root complexes with a bus
> shift of 24 and devfn shift of 16.  Ignore accesses for devices other
> than the first device on the primary bus.
> 
> Document the whole thing in devicetree/bindings/pci/host-generic-pci.txt
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/pci/host-generic-pci.txt   |  8 +++---
>  drivers/pci/host/pci-host-generic.c                | 29 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> index 105a968..a5aed0f 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> @@ -14,9 +14,11 @@ tree bindings communicated in pci.txt:
>  
>  Properties of the host controller node:
>  
> -- compatible     : Must be "pci-host-cam-generic" or "pci-host-ecam-generic"
> -                   depending on the layout of configuration space (CAM vs
> -                   ECAM respectively).
> +- compatible     : One of the following with bus:devfn:reg mapped to the
> +                   PCI config space address window in the bit positions shown:
> +                   "pci-host-cam-generic" -- 'CAM'  bits 16:8:0
> +                   "pci-host-ecam-generic" -- 'ECAM'  bits 20:12:0
> +                   "cavium,pci-host-thunder-pem" --  bits 24:16:0

To me that's ECAM left shifted by 4. Is not it just a matter of defining
config space base address (ie reg property) differently ?

Lorenzo

>  
>  - device_type    : Must be "pci".
>  
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index e364232..e1d8d5b 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -91,6 +91,32 @@ static struct gen_pci_cfg_bus_ops gen_pci_cfg_ecam_bus_ops = {
>  	}
>  };
>  
> +static void __iomem *gen_pci_map_cfg_bus_thunder_pem(struct pci_bus *bus,
> +						     unsigned int devfn,
> +						     int where)
> +{
> +	struct gen_pci *pci = bus->sysdata;
> +	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
> +
> +	/*
> +	 * Thunder PEM is a PCIe RC, but without a root bridge.  On
> +	 * the primary bus, ignore accesses for devices other than
> +	 * the first device.
> +	 */
> +	if (idx == 0 && (devfn & ~7u))
> +		return NULL;
> +	return pci->cfg.win[idx] + ((devfn << 16) | where);
> +}
> +
> +static struct gen_pci_cfg_bus_ops gen_pci_cfg_thunder_pem_bus_ops = {
> +	.bus_shift	= 24,
> +	.ops		= {
> +		.map_bus	= gen_pci_map_cfg_bus_thunder_pem,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> +
>  static const struct of_device_id gen_pci_of_match[] = {
>  	{ .compatible = "pci-host-cam-generic",
>  	  .data = &gen_pci_cfg_cam_bus_ops },
> @@ -98,6 +124,9 @@ static const struct of_device_id gen_pci_of_match[] = {
>  	{ .compatible = "pci-host-ecam-generic",
>  	  .data = &gen_pci_cfg_ecam_bus_ops },
>  
> +	{ .compatible = "cavium,pci-host-thunder-pem",
> +	  .data = &gen_pci_cfg_thunder_pem_bus_ops },
> +
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, gen_pci_of_match);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
