Return-Path: <SRS0=oLbb=L7=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=oLbb=L7=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 17 Sep 2018 16:01:17 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Subject: Re: [PATCH] PCI: iproc: Remove PAXC slot check to allow VF support
Message-ID: <20180917150117.GG7239@e107981-ln.cambridge.arm.com>
References: <20180828172258.76629-1-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180828172258.76629-1-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 28, 2018 at 10:22:58AM -0700, Ray Jui wrote:
> From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
> 
> Fix previous incorrect logic that limits PAXC slot number to zero only.
> In order for SRIOV/VF to work, we need to allow the slot number to be
> greater than zero.
> 
> Fixes: 46560388c476c ("PCI: iproc: Allow multiple devices except on PAXC")
> Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied to pci/iproc for v4.20, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 3160e9342a2f..c20fd6bd68fd 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -630,14 +630,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
>  			return (pcie->base + offset);
>  	}
>  
> -	/*
> -	 * PAXC is connected to an internally emulated EP within the SoC.  It
> -	 * allows only one device.
> -	 */
> -	if (pcie->ep_is_internal)
> -		if (slot > 0)
> -			return NULL;
> -
>  	return iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
>  }
>  
> -- 
> 2.17.1
> 
