Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35364 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbbIWSCA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 14:02:00 -0400
Date: Wed, 23 Sep 2015 19:01:57 +0100
From: Will Deacon <will.deacon@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
Subject: Re: [PATCH v2 4/5] PCI: generic: Correct, and avoid overflow, in
 bus_max calculation.
Message-ID: <20150923180157.GV7356@arm.com>
References: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com>
 <1442527332-1174-5-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442527332-1174-5-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 17, 2015 at 11:02:11PM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> There are two problems with the bus_max calculation:
> 
> 1) The u8 data type can overflow for large config space windows.
> 
> 2) The calculation is incorrect for a bus range that doesn't start at
>    zero.
> 
> Since the configuration space is relative to bus zero, make bus_max
> just be the size of the config window scaled by bus_shift.  Then clamp
> it to a maximum of 255, per PCI.  Use a data type of int to avoid
> overflow problems.
> 
> Update host-generic-pci.txt to clarify the semantics of the "reg"
> property with respect to non-zero starting bus numbers.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> Change from v1: Added text to host-generic-pci.txt
> 
>  Documentation/devicetree/bindings/pci/host-generic-pci.txt | 4 +++-
>  drivers/pci/host/pci-host-generic.c                        | 7 ++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> index cf3e205..105a968 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> @@ -34,7 +34,9 @@ Properties of the host controller node:
>  - #size-cells    : Must be 2.
>  
>  - reg            : The Configuration Space base address and size, as accessed
> -                   from the parent bus.
> +                   from the parent bus.  The base address corresponds to
> +                   bus zero, even though the "bus-range" property may specify
> +                   a different starting bus number.

That's a useful clarification, thanks.

>  Properties of the /chosen node:
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 77cf4bd..0a9c453 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -164,7 +164,7 @@ out_release_res:
>  static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>  {
>  	int err;
> -	u8 bus_max;
> +	int bus_max;
>  	resource_size_t busn;
>  	struct resource *bus_range;
>  	struct device *dev = pci->host.dev.parent;
> @@ -177,8 +177,9 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>  	}
>  
>  	/* Limit the bus-range to fit within reg */
> -	bus_max = pci->cfg.bus_range->start +
> -		  (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
> +	bus_max = (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
> +	if (bus_max > 255)
> +		bus_max = 255;

I still don't understand the need for this part. If the cfg space is bigger
than bus_max, isn't that simply an invalid resource? Given that the resource
could be broken in other ways too, this check feels more like a specific
workaround rather than generally useful code.

Will
