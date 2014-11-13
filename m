Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:37869 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaKMRcP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 12:32:15 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so881838pad.17
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 09:32:14 -0800 (PST)
Date: Thu, 13 Nov 2014 10:32:10 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Make reset warning messages different
Message-ID: <20141113173210.GI5064@google.com>
References: <1415760111-12344-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415760111-12344-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 01:41:51PM +1100, Gavin Shan wrote:
> We have same warning message for FLR and AF FLR and users can't
> know which type of resets the PCI device is taking when there are
> pending transactions. The patch makes them different for FLR and
> AF FLR cases.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to pci/misc for v3.19, thanks!

> ---
> v2: Adjusted messages according to Bjorn's suggestion
> ---
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 625a4ac..3f12383 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3144,7 +3144,8 @@ static int pcie_flr(struct pci_dev *dev, int probe)
>  		return 0;
>  
>  	if (!pci_wait_for_pending_transaction(dev))
> -		dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
> +		dev_err(&dev->dev, "timed out waiting for pending transaction; "
> +				   "performing function level reset\n");
>  
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>  
> @@ -3178,7 +3179,8 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  				 PCI_AF_STATUS_TP << 8))
>  		goto clear;
>  
> -	dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
> +	dev_err(&dev->dev, "timed out waiting for pending transaction; "
> +			   "performing AF function level reset\n");
>  
>  clear:
>  	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
> -- 
> 1.8.3.2
> 
