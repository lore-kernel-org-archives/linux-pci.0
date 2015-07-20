Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58386 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440AbbGTOP7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jul 2015 10:15:59 -0400
Date: Mon, 20 Jul 2015 16:15:56 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 5/8] PCI: Inline the ATS setup code into pci_ats_init()
Message-ID: <20150720141556.GE13082@suse.de>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213223.18379.75832.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717213223.18379.75832.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 04:32:23PM -0500, Bjorn Helgaas wrote:
> The ATS setup code in ats_alloc_one() is only used by pci_ats_init(), so
> inline it there.  No functional change.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ea459b3..fe59182 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -17,7 +17,7 @@
>  
>  #include "pci.h"
>  
> -static void ats_alloc_one(struct pci_dev *dev)
> +void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
>  	u16 cap;
> @@ -32,11 +32,6 @@ static void ats_alloc_one(struct pci_dev *dev)
>  					    PCI_ATS_MAX_QDEP;
>  }
>  
> -void pci_ats_init(struct pci_dev *dev)
> -{
> -	ats_alloc_one(dev);
> -}
> -
>  /**
>   * pci_enable_ats - enable the ATS capability
>   * @dev: the PCI device

Reviewed-by: Joerg Roedel <jroedel@suse.de>

