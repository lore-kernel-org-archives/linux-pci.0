Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:40679 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeIDOGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Sep 2018 10:06:55 -0400
Date: Tue, 4 Sep 2018 11:42:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [Patch v1 0/7] mpt3sas: Hot-Plug Surprise removal support on IOC.
Message-ID: <20180904094234.jm5je5sfpagdf6dz@wunner.de>
References: <1535690081-16116-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75VfC8GN3oEzSFJYfMr0iqBTYUJ=WPoLS9Oh5NgVcFmnBkw@mail.gmail.com>
 <20180831085534.n6eikj5cw522ihhe@wunner.de>
 <CAK=zhgrzNYDeUFN0YWVJLdGR0nA443su0xydwSHFQzhouhZBuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK=zhgrzNYDeUFN0YWVJLdGR0nA443su0xydwSHFQzhouhZBuw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 04, 2018 at 11:19:04AM +0530, Sreekanth Reddy wrote:
> On Fri, Aug 31, 2018 at 2:25 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > * Just reading the vendor ID may not be sufficient to detect unplug,
> >   it may also read as "all ones" if the link is down due to error
> >   recovery by DPC.
> 
> So, is their any other way to detect pci device unplug apart from
> reading the vendor ID, I mean we have check any other flags, etc?

Many scsi drivers call pci_channel_offline() to detect inaccessibility
of the device due to a PCI error:
https://elixir.bootlin.com/linux/v4.19-rc2/ident/pci_channel_offline

A patch is pending such that surprise removal can also be queried
with that same function:
https://www.spinics.net/lists/linux-pci/msg75722.html


> > * I don't see why you need to poll for the device's removal from a
> >   watchdog thread.  pciehp will invoke your driver's ->remove hook
> >   once the device is gone.
> 
> If we have some three to four PCI devices and all pci devices are hot
> unplugged simultaneously, then we observed that driver's-remove hook
> is called sequentially. So it takes some time to call fourth PCI
> device driver's->remove hook. so during this time we want all the
> outstanding commands to be gracefully terminated and hence we added
> this watchdog thread to quickly detect the hba unplug and take
> necessary steps such as gracefully terminate the outstanding IOs and
> stop receiving further IOs on it. At later time when PCI subsystem
> calls driver's-remove hook then driver can quickly release the
> resources allocated for this unplugged device.

pciehp does the following as soon as the surprise removal event is handled:

	pci_dev_set_disconnected(dev, NULL);
	if (pci_has_subordinate(dev))
		pci_walk_bus(dev->subordinate, pci_dev_set_disconnected, NULL);

Thus, once the above-linked patch lands, you'll be able to detect
surprise removal by calling pci_channel_offline() or checking
pdev->error_state == pci_channel_io_perm_failure, obviating the
need to poll for surprise removal from a kthread.

There's another patch pending to move pci_walk_bus() out of the
pci_lock_rescan_remove() so that it runs even earlier, without
pointlessly waiting for a lock:
https://www.spinics.net/lists/linux-pci/msg75438.html

Thanks,

Lukas
