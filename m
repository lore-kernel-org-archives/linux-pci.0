Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdHQQeQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Aug 2017 12:34:16 -0400
Date: Thu, 17 Aug 2017 11:34:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Dongdong Liu <liudongdong3@huawei.com>, linux-pci@vger.kernel.org,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V3 1/2] PCI/DPC: Add local struct device
Message-ID: <20170817163414.GG28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1502970505-89777-1-git-send-email-liudongdong3@huawei.com>
 <1502970505-89777-2-git-send-email-liudongdong3@huawei.com>
 <20170817153221.GM7233@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817153221.GM7233@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 17, 2017 at 11:32:21AM -0400, Keith Busch wrote:
> On Thu, Aug 17, 2017 at 07:48:24PM +0800, Dongdong Liu wrote:
> > Use a local "struct device *dev" for brevity and consistency in DPC driver.
> > No functional change intended.
> 
> I think there is a functional change here:
> 
> > @@ -119,10 +120,11 @@ static int dpc_probe(struct pcie_device *dev)
> >  {
> >  	struct dpc_dev *dpc;
> >  	struct pci_dev *pdev = dev->port;
> > +	struct device *device = &pdev->dev;
> >  	int status;
> >  	u16 ctl, cap;
> >  
> > -	dpc = devm_kzalloc(&dev->device, sizeof(*dpc), GFP_KERNEL);
> > +	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
> >  	if (!dpc)
> >  		return -ENOMEM;
> 
> We were using the pcie_device's device for the devres API, but now it's
> the pci_dev's. That will change the lifetime of memory allocations. I'm
> not sure that it matters at th emoment, but it's certainly different.

Yep.  I'll drop this rev.  When you repost it, please make the
cosmetic change last in the series so the important thing is easier to
backport.
