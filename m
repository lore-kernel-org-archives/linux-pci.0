Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36006 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbbGTP5t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 11:57:49 -0400
Received: by iehx8 with SMTP id x8so40667401ieh.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 08:57:48 -0700 (PDT)
Date: Mon, 20 Jul 2015 10:57:43 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Joerg Roedel <jroedel@suse.de>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 7/8] PCI: Clean up ATS error handling
Message-ID: <20150720155743.GC16841@google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213240.18379.42110.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150720142400.GG13082@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150720142400.GG13082@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 04:24:00PM +0200, Joerg Roedel wrote:
> On Fri, Jul 17, 2015 at 04:32:40PM -0500, Bjorn Helgaas wrote:
> > There's no need to BUG() if we enable ATS when it's already enabled.  We
> > don't need to BUG() when disabling ATS on a device that doesn't support ATS
> > or if it's already disabled.  If ATS is enabled, certainly we found an ATS
> > capability in the past, so it should still be there now.
> > 
> > Clean up these error paths.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/ats.c |    7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > index c35de8e..9069126 100644
> > --- a/drivers/pci/ats.c
> > +++ b/drivers/pci/ats.c
> > @@ -43,8 +43,6 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
> >  {
> >  	u16 ctrl;
> >  
> > -	BUG_ON(dev->ats_cap && dev->ats_enabled);
> > -
> >  	if (!dev->ats_cap)
> >  		return -EINVAL;
> 
> Hmm, what happens if pci_enable_ats is called twice for the same
> device? Can we change the STU without disabling ATS first, for example?
> 
> The function should probably return if it finds ATS already enabled (or
> at least WARN when it is enabled and ps != last ps value).

It would probably be nicest if:

  - enabling PF fails if ATS is already enabled
  - enabling VF fails if (PF ATS is disabled || PS != PF PS)
  - disabling PF fails if ATS is enabled on any VF

I added the first (which we basically had before in the BUG_ON()), and I
already had the second.

The third is where it gets messy because we have either add a refcount and
associated locking, or we have to iterate through all the VFs.  I did
consider both of those but thought it was a lot of work for the way it's
currently used: it looks like ATS is enabled for every device when it is
enumerated, with a fixed PS, and never changed.

But I guess a refcount with atomic_inc() probably wouldn't be too hard.
Let me poke at that.

Bjorn
