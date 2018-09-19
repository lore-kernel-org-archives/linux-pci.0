Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11546 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731332AbeISVyN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 17:54:13 -0400
Date: Wed, 19 Sep 2018 10:17:30 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 12/12] PCI/pciehp: Use device managed allocations
Message-ID: <20180919161730.GC26372@localhost.localdomain>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20180918235848.26694-13-keith.busch@intel.com>
 <87c363e3-e274-853e-414f-7568c8e16ade@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87c363e3-e274-853e-414f-7568c8e16ade@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2018 at 11:11:19AM -0400, Sinan Kaya wrote:
> On 9/18/2018 7:58 PM, Keith Busch wrote:
> > -	ctrl->notification_enabled = 1;
> >   	return 0;
> >   }
> >   void pcie_shutdown_notification(struct controller *ctrl)
> >   {
> > -	if (ctrl->notification_enabled) {
> > -		pcie_disable_notification(ctrl);
> > -		pciehp_free_irq(ctrl);
> > -		ctrl->notification_enabled = 0;
> > -	}
> > +	pcie_disable_notification(ctrl);
> > +	if (pciehp_poll_mode)
> > +		kthread_stop(ctrl->poll_thread);
> >   }
> 
> I think this notification_enabled bit change needs to go to
> another path. The rest of the change in this file is pretty mechanic changes.
> Also, are you going to remove the notification_enabled member?

Right, we don't need it, and I should have removed it. There is no path
that would call pcie_shutdown_notification if it hadn't been enabled.
