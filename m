Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 15 Sep 2015 18:49:34 +0100
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
Subject: Re: [PATCH 4/6] PCI: generic: Correct, and avoid overflow, in
 bus_max calculation.
Message-ID: <20150915174934.GL31157@arm.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
 <1442013719-5001-5-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442013719-5001-5-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 12, 2015 at 12:21:57AM +0100, David Daney wrote:
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
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/pci/host/pci-host-generic.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index cd6f898..fce5bf7 100644
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
>  	pci->cfg.bus_range->end = min_t(resource_size_t,
>  					pci->cfg.bus_range->end, bus_max);

Hmm, this is changing the meaning of the bus-range property in the
device-tree, which really needs to match what IEEE Std 1275-1994 requires.

My understanding was that the bus-range could be used to offset the config
space, which is why it's subtracted from the bus number in
gen_pci_map_cfg_bus_[e]cam. Also, why is your config space so large that
we end up overflowing bus_max?

Will
