Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57756 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbbGTODV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jul 2015 10:03:21 -0400
Date: Mon, 20 Jul 2015 16:03:18 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 2/8] PCI: Embed ATS info directly into struct pci_dev
Message-ID: <20150720140318.GC13082@suse.de>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213200.18379.96435.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717213200.18379.96435.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 04:32:00PM -0500, Bjorn Helgaas wrote:
> @@ -98,13 +81,13 @@ void pci_disable_ats(struct pci_dev *dev)
>  {
>  	u16 ctrl;
>  
> -	BUG_ON(!dev->ats || !dev->ats->is_enabled);
> +	BUG_ON(!dev->ats_cap || !dev->ats_enabled);

So since dev->ats_enabled can only get set to 1 of dev->ats_cap != 0,
wouldn't it be sufficient to just do a BUG_ON(!dev->ats_enabled)?

>  static inline int pci_ats_enabled(struct pci_dev *dev)
>  {
> -	return dev->ats && dev->ats->is_enabled;
> +	return dev->ats_cap && dev->ats_enabled;
>  }

Here too, can't we just return dev->ats_enabled?



	Joerg

