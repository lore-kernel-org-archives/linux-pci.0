Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752544AbdDLQiA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Apr 2017 12:38:00 -0400
Date: Wed, 12 Apr 2017 11:37:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: add functionality for resizing resources v2
Message-ID: <20170412163753.GD25197@bhelgaas-glaptop.roam.corp.google.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-3-git-send-email-deathsimple@vodafone.de>
 <20170324213445.GF25380@bhelgaas-glaptop.roam.corp.google.com>
 <70ea3ef3-10a6-01f1-125c-dbf89e87b1d0@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <70ea3ef3-10a6-01f1-125c-dbf89e87b1d0@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 11, 2017 at 05:37:04PM +0200, Christian König wrote:

> >>+int pci_resize_resource(struct pci_dev *dev, int resno, int size)
> >>+{
> >>+	struct resource *res = dev->resource + resno;
> >>+	u32 sizes = pci_rbar_get_possible_sizes(dev, resno);
> >>+	int old = pci_rbar_get_current_size(dev, resno);
> >>+	u64 bytes = 1ULL << (size + 20);
> >>+	int ret = 0;
> >I think we should fail the request if the device is enabled, i.e., if
> >the PCI_COMMAND_MEMORY bit is set.  We can't safely change the BAR
> >while memory decoding is enabled.
> >
> >I know there's code in pci_std_update_resource() that turns off
> >PCI_COMMAND_MEMORY, but I think that's a mistake: I think it should
> >fail when asked to update an enabled BAR the same way
> >pci_iov_update_resource() does.
> >
> >I'm not sure why you call pci_reenable_device() below, but I think I
> >would rather have the driver do something like this:
> >
> >   pci_disable_device(dev);
> >   pci_resize_resource(dev, 0, size);
> >   pci_enable_device(dev);
> >
> >That way it's very clear to the driver that it must re-read all BARs
> >after resizing this one.
> 
> I've tried it, but this actually doesn't seem to work.
> 
> At least on the board I've tried pci_disable_device() doesn't clear
> the PCI_COMMAND_MEMORY bit, it just clears the master bit.

Yeah, you're right.  We generally turn *on* PCI_COMMAND_MEMORY in the
pci_enable_device() path, but the pci_disable_device() path doesn't
turn it off.

> Additional to that the power management reference counting
> pci_disable_device() and pci_enable_device() doesn't look like what
> I want for this functionality.
> 
> How about the driver needs to disabled memory decoding itself before
> trying to resize anything?

There are a few places that do that, so maybe that's the best option.

Bjorn
