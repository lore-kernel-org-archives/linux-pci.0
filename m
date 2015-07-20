Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59008 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932575AbbGTOYE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jul 2015 10:24:04 -0400
Date: Mon, 20 Jul 2015 16:24:00 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 7/8] PCI: Clean up ATS error handling
Message-ID: <20150720142400.GG13082@suse.de>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213240.18379.42110.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717213240.18379.42110.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 04:32:40PM -0500, Bjorn Helgaas wrote:
> There's no need to BUG() if we enable ATS when it's already enabled.  We
> don't need to BUG() when disabling ATS on a device that doesn't support ATS
> or if it's already disabled.  If ATS is enabled, certainly we found an ATS
> capability in the past, so it should still be there now.
> 
> Clean up these error paths.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index c35de8e..9069126 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -43,8 +43,6 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  {
>  	u16 ctrl;
>  
> -	BUG_ON(dev->ats_cap && dev->ats_enabled);
> -
>  	if (!dev->ats_cap)
>  		return -EINVAL;

Hmm, what happens if pci_enable_ats is called twice for the same
device? Can we change the STU without disabling ATS first, for example?

The function should probably return if it finds ATS already enabled (or
at least WARN when it is enabled and ps != last ps value).



	Joerg

