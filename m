Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1915C43382
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 23:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40F720C0A
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 23:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUCisyUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40F720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeIYFru (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbeIYFrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 01:47:49 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 046F520874;
        Mon, 24 Sep 2018 23:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537832589;
        bh=nKlPc8RSNMDVVd5eJN/wROanHEjiypiVfHtDpZjOqTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUCisyUHLZxQp8PWmXHwjs6YiKoY54Shjaz72lo8ipZsPQjMXGlBKTeeaC+kvXLE7
         I2H7xGvWNbGK5+znjsrQCeMlT/5zWI4TeBnxEF+6T4KPIYKepkBMb5vFAJJB887SvB
         bdx4PL9dRQQ87lZY1OSGn0dGWUpUoxWpDF17xwTE=
Date:   Mon, 24 Sep 2018 18:43:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 12/12] PCI/pciehp: Use device managed allocations
Message-ID: <20180924234307.GQ224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20180918235848.26694-13-keith.busch@intel.com>
 <20180922181057.2jy2xzmifmvvbwbm@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922181057.2jy2xzmifmvvbwbm@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 22, 2018 at 08:10:57PM +0200, Lukas Wunner wrote:
> On Tue, Sep 18, 2018 at 05:58:48PM -0600, Keith Busch wrote:
> > --- a/drivers/pci/hotplug/pciehp_core.c
> > +++ b/drivers/pci/hotplug/pciehp_core.c

> >  	/* Installs the interrupt handler */
> > -	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
> > -				      IRQF_SHARED, MY_NAME, ctrl);
> > +	retval = devm_request_threaded_irq(&ctrl->pcie->device, irq, pciehp_isr,
> > +					   pciehp_ist, IRQF_SHARED, MY_NAME,
> > +					   ctrl);
> 
> While using devm_kzalloc() for the "ops" and "ctrl" allocations is fine,
> using devm_request_threaded_irq() is *not* because it allows a
> use-after-free of the hotplug_slot_name():
> 
> With your patch the teardown order becomes:
>   pci_hp_del(&ctrl->hotplug_slot);       # After this user space can no longer
>                                          # issue enable/disable requests (but
>                                          # ->reset_slot() is still possible).
>   pcie_disable_notification();           # After this, the IRQ thread is no
>                                          # longer woken because of slot events.
>   pci_hp_destroy(hotplug_slot);          # After this, hotplug_slot_name() must
>                                          # no longer be called.
>   cancel_delayed_work_sync(&slot->work); # After this, the IRQ thread is no
>                                          # longer woken by the button_work.
> 
> What can happen here is the button_work gets scheduled before it is
> canceled, it wakes up the IRQ thread, the IRQ thread brings up or
> down the slot and prints messages to the log which include the
> hotplug_slot_name(), leading to a use-after-free.
> 
> This cannot happen with what's in v4.19 or on the pci/hotplug branch
> because the IRQ is released right after the call to pci_hp_del().
> If the button_work happens to be scheduled afterwards, it will call
> irq_wake_thread(ctrl->pcie->irq, ctrl).  Now if you look at the
> implementation of irq_wake_thread(), it iterates over all the
> actions of the IRQ (in case it's shared by multiple devices) and
> finds the action which matches the ctrl pointer.  But because we've
> already released the IRQ at that point, it won't find the IRQ action
> and just return.  So irq_wake_thread() essentially becomes a no-op.
> 
> The teardown order is very meticulously designed, I went over it
> dozens of times to ensure it's bullet-proof.  The IRQ really has to
> be released at exactly the right time and using a device-managed IRQ
> breaks the correct order I'm afraid.

Thanks for the very detailed analysis!  

This seems like a very subtle issue that we're likely to trip over
again.  I assume most drivers can use device-managed IRQs safely, but
it's a problem here because of the extra complexity around
hotplug_slot?  Is there some way we can make it less subtle, e.g., by
moving the slot cleanup into the pci_destroy_dev() path or something?

Is there some value we get from having both struct hotplug_slot and
struct pci_slot?

> While I had thought of using devm_kzalloc(), I also knew that Bjorn
> wants to get rid of portdrv and I didn't want to make any changes that
> might constrain the future design of portdrv.  Right now, portdrv
> creates a sub-device for each service and service drivers bind to it.
> An alternative design could either be a single driver that binds to
> ports and handles all services at once (probably wouldn't be all that
> different to the current situation), or no driver would be bound to
> ports and the functionality of the port services would be handled
> within the core.  In either case we have the pci_dev of the port to
> attach the device-managed allocations to, so I suppose using
> devm_kzalloc() here isn't constraining us all that much, hence
> seems fine.

I'd *like* to get rid of portdrv, but I don't see a clear path to do
that yet, so it might be impractical.  One reason I don't like it is
that only one driver can bind to a device, so portdrv prevents us from
having drivers for device-specific bridge features like performance
monitors.  For that reason, I'd like to have the architected services
handled directly in the core.

Bjorn
