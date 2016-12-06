Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58661 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbcLFOem (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Dec 2016 09:34:42 -0500
Subject: Re: [PATCH] xen/pci: Bubble up error and fix description.
To: Konrad Rzeszutek Wilk <konrad@kernel.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, bhelgaas@google.com, x86@kernel.org,
        linux-pci@vger.kernel.org
References: <1481034501-716-1-git-send-email-konrad.wilk@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <fe789d9e-8493-8931-02d3-8dd22092946b@suse.com>
Date: Tue, 6 Dec 2016 15:34:37 +0100
MIME-Version: 1.0
In-Reply-To: <1481034501-716-1-git-send-email-konrad.wilk@oracle.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/12/16 15:28, Konrad Rzeszutek Wilk wrote:
> The function is never called under PV guests, and only shows up
> when MSI (or MSI-X) cannot be allocated. Convert the message
> to include the error value.
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>

> ---
>  arch/x86/pci/xen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index bedfab9..e1fb269 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -264,8 +264,8 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  	return 0;
>  
>  error:
> -	dev_err(&dev->dev,
> -		"Xen PCI frontend has not registered MSI/MSI-X support!\n");
> +	dev_err(&dev->dev, "Failed to create MSI%s! ret=%d!\n",
> +		type == PCI_CAP_ID_MSI ? "" : "-X", irq);
>  	return irq;
>  }
>  
> 

