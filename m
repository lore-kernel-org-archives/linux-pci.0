Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40410 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529AbcEWRG5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 May 2016 13:06:57 -0400
Date: Mon, 23 May 2016 12:06:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
Message-ID: <20160523170652.GA12826@localhost>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <1463521199-16604-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463521199-16604-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 17, 2016 at 03:39:59PM -0600, Keith Busch wrote:
> Registers a standard boiler-plate SR-IOV configure callback for NVMe.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/nvme/host/pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fbe8cc2..8379b9a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2033,6 +2033,18 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_put_ctrl(&dev->ctrl);
>  }
>  
> +static int nvme_sriov_configure(struct pci_dev *pdev, int numvfs)
> +{
> +	int ret = 0;
> +
> +	if (numvfs == 0)
> +		pci_disable_sriov(pdev);
> +	else
> +		ret = pci_enable_sriov(pdev, numvfs);
> +
> +	return ret ? ret : numvfs;
> +}

I do not subscribe to the belief that every function should have a
single exit.  In this case, I think it makes the function much harder
to understand than this:

  if (numvfs == 0)
    pci_disable_sriov(pdev);
    return 0;
  }

  return pci_enable_sriov(pdev, numvfs);

>  #ifdef CONFIG_PM_SLEEP
>  static int nvme_suspend(struct device *dev)
>  {
> @@ -2127,6 +2139,7 @@ static struct pci_driver nvme_driver = {
>  	.driver		= {
>  		.pm	= &nvme_dev_pm_ops,
>  	},
> +	.sriov_configure = nvme_sriov_configure,
>  	.err_handler	= &nvme_err_handler,
>  };
>  
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
