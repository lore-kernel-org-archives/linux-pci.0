Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033414AbdEXVnK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 May 2017 17:43:10 -0400
Date: Wed, 24 May 2017 16:43:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Douglas Lehr <dllehr@us.ibm.com>,
        Milton Miller <miltonm@us.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v1 2/2] PCI: Correct PCI_STD_RESOURCE_END usage
Message-ID: <20170524214308.GD2794@bhelgaas-glaptop.roam.corp.google.com>
References: <20170519195849.25440.65477.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170519195855.25440.29969.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170519195855.25440.29969.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 19, 2017 at 02:58:55PM -0500, Bjorn Helgaas wrote:
> PCI_STD_RESOURCE_END is (confusingly) the index of the last valid BAR, not
> the *number* of BARs.  To iterate through all possible BARs, we need to
> include PCI_STD_RESOURCE_END.
> 
> Fixes: 9fe373f9997b ("PCI: Increase IBM ipr SAS Crocodile BARs to at least system page size")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied both of these to pci/misc for v4.13.

> ---
>  drivers/pci/quirks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 085fb787aa9e..16e6cd86ad71 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -304,7 +304,7 @@ static void quirk_extend_bar_to_page(struct pci_dev *dev)
>  {
>  	int i;
>  
> -	for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
> +	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>  		struct resource *r = &dev->resource[i];
>  
>  		if (r->flags & IORESOURCE_MEM && resource_size(r) < PAGE_SIZE) {
> 
