Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Aug 2016 08:33:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH] PCI: Export pci_enable_ptm
Message-ID: <20160825133321.GB9554@localhost>
References: <1472096495-42916-1-git-send-email-jonathan.yong@intel.com>
 <1472096495-42916-2-git-send-email-jonathan.yong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472096495-42916-2-git-send-email-jonathan.yong@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 03:41:35AM +0000, Yong, Jonathan wrote:
> Export symbol so device drivers outside of the core pci subsystem
> can use it.
> 
> Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
> ---
>  drivers/pci/pcie/ptm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 3b83024..bab8ac6 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -139,3 +139,4 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  		*granularity = dev->ptm_granularity;
>  	return 0;
>  }
> +EXPORT_SYMBOL(pci_enable_ptm);

I just folded this into the original patch on the pci/ptm branch, since it
hasn't been merged anywhere.  Thanks!
