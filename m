Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAMrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Sep 2018 08:47:47 -0400
Date: Sat, 1 Sep 2018 01:36:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 09/16] PCI/ERR: Report current recovery status for udev
Message-ID: <20180901083632.GC32164@infradead.org>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-10-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-10-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:26:32PM -0600, Keith Busch wrote:
> A device still participates in error recovery even if it doesn't have
> the error callbacks. This patch provides the status for user event
> watchers.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/err.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index ee9014615add..a42a17a851fb 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -67,12 +67,12 @@ static int report_error_detected(struct pci_dev *dev,
>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>  		else
>  			vote = PCI_ERS_RESULT_NONE;
> +		goto out;
>  	}
> -
> +	err_handler = dev->driver->err_handler;
> +	vote = err_handler->error_detected(dev, state);
> +out:
> +	pci_uevent_ers(dev, vote);
>  	*result = merge_result(*result, vote);
>  	device_unlock(&dev->dev);
>  	return 0;

The goto out looks a little odd here.  Why not keep the else
and just move the uevent notification out of it?
