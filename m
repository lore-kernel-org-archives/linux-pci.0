Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Oct 2015 18:21:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] PCI: generic: Fix address window calculation for
 non-zero starting bus.
Message-ID: <20151009232110.GF16112@localhost>
References: <1444334056-4870-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444334056-4870-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 08, 2015 at 12:54:16PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Make the offset from the beginning of the "reg" property be from the
> starting bus number, rather than zero.  Hoist the invariant size
> calculation out of the mapping for loop.
> 
> Update host-generic-pci.txt to clarify the semantics of the "reg"
> property with respect to non-zero starting bus numbers.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Applied to pci/host-generic for v4.4 with Reviewed-by and Acked-by from
Arnd and Rob, thanks David!

Bjorn

> ---
> This is a replacement for:
> 
> https://lkml.org/lkml/2015/10/2/653
> 
> Since that patch is getting too much push-back, this is the only other
> option for fixing the driver to be internally consistent in its
> treatment of the offset from "reg" to the first bus in the "bus-range"
> property.
> 
>  Documentation/devicetree/bindings/pci/host-generic-pci.txt | 5 +++--
>  drivers/pci/host/pci-host-generic.c                        | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> index cf3e205..3f1d3fc 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> @@ -34,8 +34,9 @@ Properties of the host controller node:
>  - #size-cells    : Must be 2.
>  
>  - reg            : The Configuration Space base address and size, as accessed
> -                   from the parent bus.
> -
> +                   from the parent bus.  The base address corresponds to
> +                   the first bus in the "bus-range" property.  If no
> +                   "bus-range" is specified, this will be bus 0 (the default).
>  
>  Properties of the /chosen node:
>  
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index fe9a81b..bb93346 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -169,6 +169,7 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>  	struct resource *bus_range;
>  	struct device *dev = pci->host.dev.parent;
>  	struct device_node *np = dev->of_node;
> +	u32 sz = 1 << pci->cfg.ops->bus_shift;
>  
>  	err = of_address_to_resource(np, 0, &pci->cfg.res);
>  	if (err) {
> @@ -196,10 +197,9 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>  	bus_range = pci->cfg.bus_range;
>  	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
>  		u32 idx = busn - bus_range->start;
> -		u32 sz = 1 << pci->cfg.ops->bus_shift;
>  
>  		pci->cfg.win[idx] = devm_ioremap(dev,
> -						 pci->cfg.res.start + busn * sz,
> +						 pci->cfg.res.start + idx * sz,
>  						 sz);
>  		if (!pci->cfg.win[idx])
>  			return -ENOMEM;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
