Return-Path: <SRS0=oLbb=L7=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=oLbb=L7=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 17 Sep 2018 15:47:34 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Remove redundant "valid device" check
Message-ID: <20180917144734.GF7239@e107981-ln.cambridge.arm.com>
References: <20171215202935.157396.74423.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171215202935.157396.74423.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 15, 2017 at 02:29:35PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> In rockchip_pcie_valid_device(), we do the exact same test twice:
> 
>   if (bus->number == rockchip->root_bus_nr && dev > 0)
>     return 0;
>   if (bus->number == rockchip->root_bus_nr && dev > 0)
>     return 0;
> 
> We only need to do it once, so remove one of them.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pcie-rockchip.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 9051c6c8fea4..dd9c7ea69e0b 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -293,10 +293,6 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
>  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>  				      struct pci_bus *bus, int dev)
>  {
> -	/* access only one slot on each root port */
> -	if (bus->number == rockchip->root_bus_nr && dev > 0)
> -		return 0;
> -
>  	/*
>  	 * do not read more than one device on the bus directly attached
>  	 * to RC's downstream side.
> 

Hi Bjorn,

this patch slipped through the cracks but I do not think it is right.

The point here is filtering both the host bridge access side (ie check
for dev > 0) AND the RC downstream side, it is two different busses.

Perhaps the check can be written in a more concise way (squash them in
one single conditional) but I think the current logic is correct,
AFAICS.

I would drop it from the PCI patch queue.

Thanks,
Lorenzo
