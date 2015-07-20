Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35138 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbbGTPeN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 11:34:13 -0400
Received: by igr7 with SMTP id 7so16506437igr.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 08:34:13 -0700 (PDT)
Date: Mon, 20 Jul 2015 10:34:08 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Joerg Roedel <jroedel@suse.de>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 1/8] PCI: Allocate ATS struct during enumeration
Message-ID: <20150720153408.GB16841@google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213152.18379.50159.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150720135516.GB13082@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150720135516.GB13082@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 03:55:16PM +0200, Joerg Roedel wrote:
> Hi Bjorn,
> 
> On Fri, Jul 17, 2015 at 04:31:52PM -0500, Bjorn Helgaas wrote:
> > -static int ats_alloc_one(struct pci_dev *dev, int ps)
> > +static void ats_alloc_one(struct pci_dev *dev)
> >  {
> >  	int pos;
> >  	u16 cap;
> > @@ -25,20 +25,17 @@ static int ats_alloc_one(struct pci_dev *dev, int ps)
> >  
> >  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
> >  	if (!pos)
> > -		return -ENODEV;
> > +		return;
> >  
> >  	ats = kzalloc(sizeof(*ats), GFP_KERNEL);
> >  	if (!ats)
> > -		return -ENOMEM;
> > +		return;
> 
> I think we should print a warning here when the allocation fails.
> Otherwise the user wonders why ATS can't be used despite the available
> capability.

Good idea, done (although it gets removed right away in the next patch :))
> 
> > -	if (dev->is_physfn || dev->is_virtfn) {
> > -		struct pci_dev *pdev = dev->is_physfn ? dev : dev->physfn;
> > -
> > -		mutex_lock(&pdev->sriov->lock);
> > -		if (pdev->ats)
> > -			rc = pdev->ats->stu == ps ? 0 : -EINVAL;
> > -		else
> > -			rc = ats_alloc_one(pdev, ps);
> > +	if (ps < PCI_ATS_MIN_STU)
> > +		return -EINVAL;
> >  
> > -		if (!rc)
> > -			pdev->ats->ref_cnt++;
> > -		mutex_unlock(&pdev->sriov->lock);
> > -		if (rc)
> > -			return rc;
> > -	}
> > +	ctrl = PCI_ATS_CTRL_ENABLE;
> > +	if (dev->is_virtfn) {
> > +		struct pci_dev *pdev = dev->physfn;
> >  
> > -	if (!dev->is_physfn) {
> > -		rc = ats_alloc_one(dev, ps);
> > -		if (rc)
> > -			return rc;
> > +		if (pdev->ats->stu != ps)
> > +			return -EINVAL;
> > +	} else {
> > +		dev->ats->stu = ps;
> > +		ctrl |= PCI_ATS_CTRL_STU(dev->ats->stu - PCI_ATS_MIN_STU);
> >  	}
> 
> Okay, enabling ATS for the virt_fn will now fail when it is not
> already enabled for the phys_fn. The drivers probe function, which might
> enable SR-IOV, runs after BUS_NOTIFY_ADD_DEVICE has finished, so this
> should be safe.
> 
> But I think a comment explaining these dependencies would be good here.

Comment added, thanks!

Bjorn
