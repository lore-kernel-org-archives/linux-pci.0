Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 30 Sep 2016 10:14:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, bigeasy@linutronix.de
Subject: Re: [PATCH] aer: function comments cleanup
Message-ID: <20160930151457.GA15920@localhost>
References: <1475203977-21926-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475203977-21926-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 30, 2016 at 10:52:57AM +0800, Cao jin wrote:
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

Applied to pci/aer for v4.9, thanks!

> ---
>  drivers/pci/pcie/aer/aerdrv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 48d21e0..20eea86 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -294,7 +294,6 @@ static void aer_remove(struct pcie_device *dev)
>  /**
>   * aer_probe - initialize resources
>   * @dev: pointer to the pcie_dev data structure
> - * @id: pointer to the service id data structure
>   *
>   * Invoked when PCI Express bus loads AER service driver.
>   */
> -- 
> 2.1.0
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
