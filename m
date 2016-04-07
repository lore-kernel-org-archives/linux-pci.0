Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35221 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbcDGRPr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 13:15:47 -0400
Received: by mail-pa0-f52.google.com with SMTP id td3so58404024pab.2
        for <linux-pci@vger.kernel.org>; Thu, 07 Apr 2016 10:15:47 -0700 (PDT)
Date: Thu, 7 Apr 2016 10:15:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Greg KH <greg@kroah.com>
Cc: linux-pci@vger.kernel.org
Subject: PCI dynamic id use after free?
Message-ID: <20160407101559.445760c0@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I was looking at another PCI problem, and discovered this potential use
after kfree.

static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
						    struct pci_dev *dev)
{
	struct pci_dynid *dynid;
	const struct pci_device_id *found_id = NULL;

	/* When driver_override is set, only bind to the matching driver */
	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
		return NULL;

	/* Look at the dynamic ids first, before the static ones */
	spin_lock(&drv->dynids.lock);
	list_for_each_entry(dynid, &drv->dynids.list, node) {
		if (pci_match_one_device(&dynid->id, dev)) {
			found_id = &dynid->id;
			break;
		}
	}
	spin_unlock(&drv->dynids.lock);

At this point found_id if matched (points into dynid) structure but the
lock has been dropped.

What prevents the ID from being removed by store_remvoe_id?

Looks like you need RCU (or ref counts here).
