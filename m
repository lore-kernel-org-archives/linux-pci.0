Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51826 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751950AbcDGSgA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 14:36:00 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id BAB6B2134F
	for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2016 14:35:59 -0400 (EDT)
Date: Thu, 7 Apr 2016 11:35:56 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI dynamic id use after free?
Message-ID: <20160407183556.GB30657@kroah.com>
References: <20160407101559.445760c0@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160407101559.445760c0@xeon-e3>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 07, 2016 at 10:15:59AM -0700, Stephen Hemminger wrote:
> I was looking at another PCI problem, and discovered this potential use
> after kfree.
> 
> static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
> 						    struct pci_dev *dev)
> {
> 	struct pci_dynid *dynid;
> 	const struct pci_device_id *found_id = NULL;
> 
> 	/* When driver_override is set, only bind to the matching driver */
> 	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
> 		return NULL;
> 
> 	/* Look at the dynamic ids first, before the static ones */
> 	spin_lock(&drv->dynids.lock);
> 	list_for_each_entry(dynid, &drv->dynids.list, node) {
> 		if (pci_match_one_device(&dynid->id, dev)) {
> 			found_id = &dynid->id;
> 			break;
> 		}
> 	}
> 	spin_unlock(&drv->dynids.lock);
> 
> At this point found_id if matched (points into dynid) structure but the
> lock has been dropped.
> 
> What prevents the ID from being removed by store_remvoe_id?

Nothing, good catch.  Luckily no one actually uses that interface :)

> Looks like you need RCU (or ref counts here).

Yes, or create a copy of the id and use that for the short period it is
in use.  I don't have the time at the moment to fix this until next
week, if someone wants to write up a patch before then... :)

thanks,

greg k-h
