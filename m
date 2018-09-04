Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34818 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDKMi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Sep 2018 06:12:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7-v6so1100798pgf.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Sep 2018 22:49:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180831085534.n6eikj5cw522ihhe@wunner.de>
References: <1535690081-16116-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75VfC8GN3oEzSFJYfMr0iqBTYUJ=WPoLS9Oh5NgVcFmnBkw@mail.gmail.com> <20180831085534.n6eikj5cw522ihhe@wunner.de>
From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date: Tue, 4 Sep 2018 11:19:04 +0530
Message-ID: <CAK=zhgrzNYDeUFN0YWVJLdGR0nA443su0xydwSHFQzhouhZBuw@mail.gmail.com>
Subject: Re: [Patch v1 0/7] mpt3sas: Hot-Plug Surprise removal support on IOC.
To: Lukas Wunner <lukas@wunner.de>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 2:25 PM, Lukas Wunner <lukas@wunner.de> wrote:
> [cc += linux-pci, benh]
>
> On Fri, Aug 31, 2018 at 7:37 AM Suganath Prabu S <suganath-prabu.subramani@broadcom.com> wrote:
>> Posting below set of patches to support PCIe Hot Plug surprise removal,
>> and few defect fixes.
>
> Please cross-post to linux-pci in the future.
>
>
> Regarding [PATCH 1/7] mpt3sas: Introduce mpt3sas_base_pci_device_is_unplugged:
> https://www.spinics.net/lists/linux-scsi/msg122962.html
>
> * mpt3sas_base_pci_device_is_unplugged() is a duplication of the existing
>   pci_device_is_present().

Thanks for pointing this pci_device_is_present() API, we will replace
mpt3sas_base_pci_device_is_unplugged() with  pci_device_is_present().

>
> * Just reading the vendor ID may not be sufficient to detect unplug,
>   it may also read as "all ones" if the link is down due to error
>   recovery by DPC.

So, is their any other way to detect pci device unplug apart from
reading the vendor ID, I mean we have check any other flags, etc?

>
>
> Regarding [PATCH 2/7] mpt3sas: Add HBA hot plug watchdog thread:
> https://www.spinics.net/lists/linux-scsi/msg122963.html
>
> * I don't see why you need to poll for the device's removal from a
>   watchdog thread.  pciehp will invoke your driver's ->remove hook
>   once the device is gone.

If we have some three to four PCI devices and all pci devices are hot
unplugged simultaneously, then we observed that driver's-remove hook
is called sequentially. So it takes some time to call fourth PCI
device driver's->remove hook. so during this time we want all the
outstanding commands to be gracefully terminated and hence we added
this watchdog thread to quickly detect the hba unplug and take
necessary steps such as gracefully terminate the outstanding IOs and
stop receiving further IOs on it. At later time when PCI subsystem
calls driver's-remove hook then driver can quickly release the
resources allocated for this unplugged device.

>
> * A recent discussion initiated by Benjamin Herrenschmidt came to the
>   conclusion that device removal should be treated as a type of
>   error state (either pci_channel_io_perm_failure or another, newly
>   introduced state).  It will then be possible to detect the device's
>   inaccessibility with pci_channel_offline().  Please help work towards
>   such a future solution in the PCI core instead of solutions localized
>   to a single device driver.  Sorry, the discussion was lengthy, it is
>   available here:
>   https://www.spinics.net/lists/linux-pci/msg75425.html

Oh great, sure. We have very limited knowledge on PCI subsystem but we
try our best in future to provide solutions in the PCI core.

>
> Thanks,
>
> Lukas
