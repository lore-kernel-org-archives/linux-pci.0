Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21830 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbeHIUa7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 16:30:59 -0400
Date: Thu, 9 Aug 2018 12:05:34 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci/sriov: Hold rescan lock while enumerating
Message-ID: <20180809180534.GA18816@localhost.localdomain>
References: <20180809163356.18650-1-keith.busch@intel.com>
 <20180809175819.42j6laq5gxtpnlxy@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180809175819.42j6laq5gxtpnlxy@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 09, 2018 at 07:58:19PM +0200, Lukas Wunner wrote:
> On Thu, Aug 09, 2018 at 10:33:56AM -0600, Keith Busch wrote:
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -591,6 +591,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
> >  	if (num_vfs > pci_sriov_get_totalvfs(pdev))
> >  		return -ERANGE;
> >  
> > +	pci_lock_rescan_remove();
> >  	device_lock(&pdev->dev);
> 
> Doesn't this obviate the need to hold the device_lock()?  What could
> otherwise run concurrently that doesn't hold pci_lock_rescan_remove()
> and would cause a race condition?

The device_lock is still needed to protect against concurrent
pci_reset_function.
