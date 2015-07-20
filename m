Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58445 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbbGTORk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jul 2015 10:17:40 -0400
Date: Mon, 20 Jul 2015 16:17:37 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 6/8] PCI: Use pci_physfn() rather than looking up physfn
 by hand
Message-ID: <20150720141737.GF13082@suse.de>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213232.18379.64802.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717213232.18379.64802.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 04:32:32PM -0500, Bjorn Helgaas wrote:
> Use the pci_physfn() helper rather than looking up physfn by hand.
> No functional change.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index fe59182..c35de8e 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -53,9 +53,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  
>  	ctrl = PCI_ATS_CTRL_ENABLE;
>  	if (dev->is_virtfn) {
> -		struct pci_dev *pdev = dev->physfn;
> -
> -		if (pdev->ats_stu != ps)
> +		if (pci_physfn(dev)->ats_stu != ps)
>  			return -EINVAL;
>  	} else {
>  		dev->ats_stu = ps;

Reviewed-by: Joerg Roedel <jroedel@suse.de>

