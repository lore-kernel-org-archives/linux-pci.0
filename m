Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F69AC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 07:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008A82087A
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 07:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008A82087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeIYNTY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:19:24 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:48707 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIYNTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 09:19:23 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CA06D100B02C3;
        Tue, 25 Sep 2018 09:13:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 78E665CCC0D; Tue, 25 Sep 2018 09:13:11 +0200 (CEST)
Date:   Tue, 25 Sep 2018 09:13:11 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 12/12] PCI/pciehp: Use device managed allocations
Message-ID: <20180925071311.cwd5eunuuauzoymw@wunner.de>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20180918235848.26694-13-keith.busch@intel.com>
 <20180922181057.2jy2xzmifmvvbwbm@wunner.de>
 <20180924234307.GQ224714@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924234307.GQ224714@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 24, 2018 at 06:43:07PM -0500, Bjorn Helgaas wrote:
> On Sat, Sep 22, 2018 at 08:10:57PM +0200, Lukas Wunner wrote:
> > This cannot happen with what's in v4.19 or on the pci/hotplug branch
> > because the IRQ is released right after the call to pci_hp_del().
> > If the button_work happens to be scheduled afterwards, it will call
> > irq_wake_thread(ctrl->pcie->irq, ctrl).  Now if you look at the
> > implementation of irq_wake_thread(), it iterates over all the
> > actions of the IRQ (in case it's shared by multiple devices) and
> > finds the action which matches the ctrl pointer.  But because we've
> > already released the IRQ at that point, it won't find the IRQ action
> > and just return.  So irq_wake_thread() essentially becomes a no-op.
> 
> This seems like a very subtle issue that we're likely to trip over
> again.  I assume most drivers can use device-managed IRQs safely, but
> it's a problem here because of the extra complexity around
> hotplug_slot?  Is there some way we can make it less subtle, e.g., by
> moving the slot cleanup into the pci_destroy_dev() path or something?

The extra complexity is caused by the various ways in which events can
be triggered (Slot Status register change, sysfs, button_work) plus the
deregistration of hotplug_slot.  Teardown paths are always hard, I don't
really see a better code solution, but I should add more code comments to
make it less subtle.


> Is there some value we get from having both struct hotplug_slot and
> struct pci_slot?

When Alex Chiang introduced struct pci_slot, he thought of migrating
struct hotplug_slot into it.  See the "migrate over time" code comment
in commit f46753c5e354.  (It got changed to "move here" by 0aa0f5d1084c.)

On the current pci/hotplug branch, I've embedded struct hotplug_slot
in each hotplug driver's struct slot.  But that doesn't preclude
merging struct hotplug_slot into struct pci_slot, the hotplug drivers
would just have to embed a struct pci_slot instead, or struct pci_slot
would be embedded in struct hotplug_slot.

TBH the rationale behind all the different structs isn't quite clear
to me, e.g. struct pci_slot is also used for non-hotplug slots it seems,
see 8344b568f5bd.

(Note, Alex is no longer reachable under his hp.com address, same for
his canonical.com address.)


> > While I had thought of using devm_kzalloc(), I also knew that Bjorn
> > wants to get rid of portdrv and I didn't want to make any changes that
> > might constrain the future design of portdrv.  Right now, portdrv
> > creates a sub-device for each service and service drivers bind to it.
> > An alternative design could either be a single driver that binds to
> > ports and handles all services at once (probably wouldn't be all that
> > different to the current situation), or no driver would be bound to
> > ports and the functionality of the port services would be handled
> > within the core.  In either case we have the pci_dev of the port to
> > attach the device-managed allocations to, so I suppose using
> > devm_kzalloc() here isn't constraining us all that much, hence
> > seems fine.
> 
> I'd *like* to get rid of portdrv, but I don't see a clear path to do
> that yet, so it might be impractical.  One reason I don't like it is
> that only one driver can bind to a device, so portdrv prevents us from
> having drivers for device-specific bridge features like performance
> monitors.  For that reason, I'd like to have the architected services
> handled directly in the core.

Hm, well in that case we can't use devm_*() at all, as Benjamin
Herrenschmidt has just correctly pointed out, devres_release_all()
is called both on driver unbind in __device_release_driver() as well
as on device destruction in device_release().

Thus, if the port services are handled in the core to allow a driver
to bind to the port and devm_kzalloc() is used by the port services,
those allocations will be freed when that driver unbinds, and any
further use of the allocations is a use-after-free.

Thanks,

Lukas
