Return-Path: <SRS0=8Jd2=ME=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFF5C433F4
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 18:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AF3208D9
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 18:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AF3208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeIWAF0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Sep 2018 20:05:26 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:49529 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeIWAF0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Sep 2018 20:05:26 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D90F0300168D2;
        Sat, 22 Sep 2018 20:10:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9FD6C35C88; Sat, 22 Sep 2018 20:10:57 +0200 (CEST)
Date:   Sat, 22 Sep 2018 20:10:57 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 12/12] PCI/pciehp: Use device managed allocations
Message-ID: <20180922181057.2jy2xzmifmvvbwbm@wunner.de>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20180918235848.26694-13-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918235848.26694-13-keith.busch@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 18, 2018 at 05:58:48PM -0600, Keith Busch wrote:
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -58,16 +58,16 @@ static int init_slot(struct controller *ctrl)
>  	char name[SLOT_NAME_SIZE];
>  	int retval = -ENOMEM;
>  
> -	hotplug = kzalloc(sizeof(*hotplug), GFP_KERNEL);
> +	hotplug = devm_kzalloc(&ctrl->pcie->device, sizeof(*hotplug), GFP_KERNEL);
>  	if (!hotplug)
>  		goto out;
>  
> -	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	info = devm_kzalloc(&ctrl->pcie->device, sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		goto out;
>  
>  	/* Setup hotplug slot ops */
> -	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
> +	ops = devm_kzalloc(&ctrl->pcie->device, sizeof(*ops), GFP_KERNEL);
>  	if (!ops)
>  		goto out;

The "hotplug" and "info" allocations are gone on the pci/hotplug branch,
so this needs a rebase.


> @@ -111,9 +106,6 @@ static void cleanup_slot(struct controller *ctrl)
>  	struct hotplug_slot *hotplug_slot = ctrl->slot->hotplug_slot;
>  
>  	pci_hp_destroy(hotplug_slot);
> -	kfree(hotplug_slot->ops);
> -	kfree(hotplug_slot->info);
> -	kfree(hotplug_slot);
>  }

Please replace all invocations of cleanup_slot() with a direct call to
pci_hp_destroy() since this is now becoming merely a wrapper function.


> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -45,22 +45,15 @@ static inline int pciehp_request_irq(struct controller *ctrl)
>  	}
>  
>  	/* Installs the interrupt handler */
> -	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
> -				      IRQF_SHARED, MY_NAME, ctrl);
> +	retval = devm_request_threaded_irq(&ctrl->pcie->device, irq, pciehp_isr,
> +					   pciehp_ist, IRQF_SHARED, MY_NAME,
> +					   ctrl);

While using devm_kzalloc() for the "ops" and "ctrl" allocations is fine,
using devm_request_threaded_irq() is *not* because it allows a
use-after-free of the hotplug_slot_name():

With your patch the teardown order becomes:
  pci_hp_del(&ctrl->hotplug_slot);       # After this user space can no longer
                                         # issue enable/disable requests (but
				         # ->reset_slot() is still possible).
  pcie_disable_notification();           # After this, the IRQ thread is no
                                         # longer woken because of slot events.
  pci_hp_destroy(hotplug_slot);          # After this, hotplug_slot_name() must
                                         # no longer be called.
  cancel_delayed_work_sync(&slot->work); # After this, the IRQ thread is no
                                         # longer woken by the button_work.

What can happen here is the button_work gets scheduled before it is
canceled, it wakes up the IRQ thread, the IRQ thread brings up or
down the slot and prints messages to the log which include the
hotplug_slot_name(), leading to a use-after-free.

This cannot happen with what's in v4.19 or on the pci/hotplug branch
because the IRQ is released right after the call to pci_hp_del().
If the button_work happens to be scheduled afterwards, it will call
irq_wake_thread(ctrl->pcie->irq, ctrl).  Now if you look at the
implementation of irq_wake_thread(), it iterates over all the
actions of the IRQ (in case it's shared by multiple devices) and
finds the action which matches the ctrl pointer.  But because we've
already released the IRQ at that point, it won't find the IRQ action
and just return.  So irq_wake_thread() essentially becomes a no-op.

The teardown order is very meticulously designed, I went over it
dozens of times to ensure it's bullet-proof.  The IRQ really has to
be released at exactly the right time and using a device-managed IRQ
breaks the correct order I'm afraid.

While I had thought of using devm_kzalloc(), I also knew that Bjorn
wants to get rid of portdrv and I didn't want to make any changes that
might constrain the future design of portdrv.  Right now, portdrv
creates a sub-device for each service and service drivers bind to it.
An alternative design could either be a single driver that binds to
ports and handles all services at once (probably wouldn't be all that
different to the current situation), or no driver would be bound to
ports and the functionality of the port services would be handled
within the core.  In either case we have the pci_dev of the port to
attach the device-managed allocations to, so I suppose using
devm_kzalloc() here isn't constraining us all that much, hence
seems fine.

Thanks,

Lukas
