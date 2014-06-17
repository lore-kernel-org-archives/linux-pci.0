Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52918 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965910AbaFQVrN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jun 2014 17:47:13 -0400
Received: by mail-ie0-f174.google.com with SMTP id lx4so6679081iec.5
        for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2014 14:47:12 -0700 (PDT)
Date: Tue, 17 Jun 2014 15:47:09 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, ben@decadent.org.uk,
	gwshan@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Fix unaligned access testing AF transaction pending
Message-ID: <20140617214709.GA30559@google.com>
References: <20140612152732.4162.23298.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140612152732.4162.23298.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 12, 2014 at 09:28:07AM -0600, Alex Williamson wrote:
> pci_wait_for_pending() uses word access, so we shouldn't be passing
> an offset that is only byte aligned.  Use the control register offset
> instead, shifting the mask to match.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: stable@vger.kernel.org

Applied with Gavin's ack to for-linus for v3.16, thanks!

> ---
>  drivers/pci/pci.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 759475e..81012ec 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3109,8 +3109,13 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  	if (probe)
>  		return 0;
>  
> -	/* Wait for Transaction Pending bit clean */
> -	if (pci_wait_for_pending(dev, pos + PCI_AF_STATUS, PCI_AF_STATUS_TP))
> +	/*
> +	 * Wait for Transaction Pending bit to clear.  A word-aligned test
> +	 * is used, so we use the conrol offset rather than status and shift
> +	 * the test bit to match.
> +	 */
> +	if (pci_wait_for_pending(dev, pos + PCI_AF_CTRL,
> +				 PCI_AF_STATUS_TP << 8))
>  		goto clear;
>  
>  	dev_err(&dev->dev, "transaction is not cleared; "
> 
