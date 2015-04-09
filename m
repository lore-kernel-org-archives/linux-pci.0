Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33951 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933304AbbDIUAv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 16:00:51 -0400
Received: by obbry2 with SMTP id ry2so31783275obb.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 13:00:51 -0700 (PDT)
Date: Thu, 9 Apr 2015 15:00:48 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Export pci_probe_reset_function()
Message-ID: <20150409200048.GM30967@google.com>
References: <20150409155100.6891.72838.stgit@gimli.home>
 <20150409195846.GL30967@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150409195846.GL30967@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 09, 2015 at 02:58:46PM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 09, 2015 at 09:51:43AM -0600, Alex Williamson wrote:
> > The equivalent bus and slot versions of this are already exported and
> > vfio-pci would like a function-probe available so we can expose
> > function-level reset capabilities to the user without necessarily
> > using it to perform a reset before enabling the device for the user.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> Applied to pci/virtualization for v4.1, thanks!

Actually, maybe it makes more sense for you to apply this along with the
vfio patch that uses it?  So if you want:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> > ---
> >  drivers/pci/pci.c   |    1 +
> >  include/linux/pci.h |    1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 81f06e8..9f3e691 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3524,6 +3524,7 @@ int pci_probe_reset_function(struct pci_dev *dev)
> >  {
> >  	return pci_dev_reset(dev, 1);
> >  }
> > +EXPORT_SYMBOL_GPL(pci_probe_reset_function);
> >  
> >  /**
> >   * pci_reset_function - quiesce and reset a PCI device function
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 211e9da..233d1ae 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -986,6 +986,7 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
> >  			  enum pcie_link_width *width);
> >  int __pci_reset_function(struct pci_dev *dev);
> >  int __pci_reset_function_locked(struct pci_dev *dev);
> > +int pci_probe_reset_function(struct pci_dev *dev);
> >  int pci_reset_function(struct pci_dev *dev);
> >  int pci_try_reset_function(struct pci_dev *dev);
> >  int pci_probe_reset_slot(struct pci_slot *slot);
> > 
