Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36004 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbbGTQ0j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 12:26:39 -0400
Received: by iehx8 with SMTP id x8so41308700ieh.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 09:26:39 -0700 (PDT)
Date: Mon, 20 Jul 2015 11:26:35 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Joerg Roedel <jroedel@suse.de>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 2/8] PCI: Embed ATS info directly into struct pci_dev
Message-ID: <20150720162635.GD16841@google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213200.18379.96435.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150720140318.GC13082@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150720140318.GC13082@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 04:03:18PM +0200, Joerg Roedel wrote:
> On Fri, Jul 17, 2015 at 04:32:00PM -0500, Bjorn Helgaas wrote:
> > @@ -98,13 +81,13 @@ void pci_disable_ats(struct pci_dev *dev)
> >  {
> >  	u16 ctrl;
> >  
> > -	BUG_ON(!dev->ats || !dev->ats->is_enabled);
> > +	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
> 
> So since dev->ats_enabled can only get set to 1 of dev->ats_cap != 0,
> wouldn't it be sufficient to just do a BUG_ON(!dev->ats_enabled)?
> 
> >  static inline int pci_ats_enabled(struct pci_dev *dev)
> >  {
> > -	return dev->ats && dev->ats->is_enabled;
> > +	return dev->ats_cap && dev->ats_enabled;
> >  }
> 
> Here too, can't we just return dev->ats_enabled?

Yep, that makes sense.  I left ats_cap in to try to make it easier to
review, but I removed it later in the series.

Bjorn
