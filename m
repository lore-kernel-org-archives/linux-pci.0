Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38196 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeIEKoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Sep 2018 06:44:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so2782499plq.5
        for <linux-pci@vger.kernel.org>; Tue, 04 Sep 2018 23:15:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180904094234.jm5je5sfpagdf6dz@wunner.de>
References: <1535690081-16116-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75VfC8GN3oEzSFJYfMr0iqBTYUJ=WPoLS9Oh5NgVcFmnBkw@mail.gmail.com>
 <20180831085534.n6eikj5cw522ihhe@wunner.de> <CAK=zhgrzNYDeUFN0YWVJLdGR0nA443su0xydwSHFQzhouhZBuw@mail.gmail.com>
 <20180904094234.jm5je5sfpagdf6dz@wunner.de>
From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date: Wed, 5 Sep 2018 11:45:45 +0530
Message-ID: <CAK=zhgprkzcF-UZeeqg_qN0xFLR=BfzkRNRZKA=DJyf7aMPmeg@mail.gmail.com>
Subject: Re: [Patch v1 0/7] mpt3sas: Hot-Plug Surprise removal support on IOC.
To: Lukas Wunner <lukas@wunner.de>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

l


On Tue, Sep 4, 2018 at 3:12 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Tue, Sep 04, 2018 at 11:19:04AM +0530, Sreekanth Reddy wrote:
>> On Fri, Aug 31, 2018 at 2:25 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> > * Just reading the vendor ID may not be sufficient to detect unplug,
>> >   it may also read as "all ones" if the link is down due to error
>> >   recovery by DPC.
>>
>> So, is their any other way to detect pci device unplug apart from
>> reading the vendor ID, I mean we have check any other flags, etc?
>
> Many scsi drivers call pci_channel_offline() to detect inaccessibility
> of the device due to a PCI error:
> https://elixir.bootlin.com/linux/v4.19-rc2/ident/pci_channel_offline
>
> A patch is pending such that surprise removal can also be queried
> with that same function:
> https://www.spinics.net/lists/linux-pci/msg75722.html

Lukas, thanks for pointing to this pci_dev_is_disconnected() API. So
we can use this API directly instead of reading the vendor Id and
checking for all one's once this patch get accepted?

>
>
>> > * I don't see why you need to poll for the device's removal from a
>> >   watchdog thread.  pciehp will invoke your driver's ->remove hook
>> >   once the device is gone.
>>
>> If we have some three to four PCI devices and all pci devices are hot
>> unplugged simultaneously, then we observed that driver's-remove hook
>> is called sequentially. So it takes some time to call fourth PCI
>> device driver's->remove hook. so during this time we want all the
>> outstanding commands to be gracefully terminated and hence we added
>> this watchdog thread to quickly detect the hba unplug and take
>> necessary steps such as gracefully terminate the outstanding IOs and
>> stop receiving further IOs on it. At later time when PCI subsystem
>> calls driver's-remove hook then driver can quickly release the
>> resources allocated for this unplugged device.
>
> pciehp does the following as soon as the surprise removal event is handled:
>
>         pci_dev_set_disconnected(dev, NULL);
>         if (pci_has_subordinate(dev))
>                 pci_walk_bus(dev->subordinate, pci_dev_set_disconnected, NULL);
>
> Thus, once the above-linked patch lands, you'll be able to detect
> surprise removal by calling pci_channel_offline() or checking
> pdev->error_state == pci_channel_io_perm_failure, obviating the
> need to poll for surprise removal from a kthread.
>
> There's another patch pending to move pci_walk_bus() out of the
> pci_lock_rescan_remove() so that it runs even earlier, without
> pointlessly waiting for a lock:
> https://www.spinics.net/lists/linux-pci/msg75438.html

Yes due to this pci_lock_rescan_remove() lock, we observed that
driver's->remove hook called sequentially even though multiple HBA
devices are hot unplugged simultaneously.

I have one more instance where still we need this poll kthread, i.e
during the device probe time we have some commands which has more
timeout value (e.g. 300 seconds), so if user has unplugged this device
just after sending this more time-out valued command then driver has
to wait until this time-out value expires. i.e. this device is still
visible in lspci output until this 300 seconds timeout value expires
even though device is unplugged. if we have a poll kthread (which will
poll for every one second) then driver can early detect the unplugged
state and can terminate the outstanding commands and hence probe
operation can be completed quickly.


Also whether we need to wait for below patches get accepted? so that
we can post the new set of patches accommodating according to your
suggestions,
https://www.spinics.net/lists/linux-pci/msg75722.html
https://www.spinics.net/lists/linux-pci/msg75438.html

>
> Thanks,
>
> Lukas
