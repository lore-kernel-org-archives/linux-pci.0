Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:37958 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab3KFUdb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2013 15:33:31 -0500
Received: by mail-ie0-f175.google.com with SMTP id aq17so51315iec.20
        for <linux-pci@vger.kernel.org>; Wed, 06 Nov 2013 12:33:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131106201239.GA8971@google.com>
References: <20131105232903.3790.8738.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<CAE9FiQX74B32iD2LAaWxwOAH62YAFWkt2=hK9pVDCDUnfrEaNw@mail.gmail.com>
	<20131106181558.GA14444@google.com>
	<CAE9FiQU4V0waWNvMFgEjKv90KuCCQ2CYJU2UsnDP0+WDS9zb1Q@mail.gmail.com>
	<20131106201239.GA8971@google.com>
Date: Wed, 6 Nov 2013 12:33:31 -0800
Message-ID: <CAE9FiQWxGdiRjZSt8OhVkJAGJ3p4zZ+Tza9HFiKtZZSa01kztA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Use pci_is_root_bus() to check for root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Nishank Trivedi <nistrive@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> > commit 4e5415f02e32c85e902cd9692eab18200e14b347
>> > Author: Bjorn Helgaas <bhelgaas@google.com>
>> > Date:   Wed Nov 6 10:00:51 2013 -0700
>> >
>> >     PCI: Enable upstream bridges even for VFs on virtual buses
>> >
>> >     Previously we enabled the upstream PCI-to-PCI bridge only when
>> >     "dev->bus->self != NULL".  In the case of a VF on a virtual bus, where
>> >     "bus->self == NULL", we didn't enable the upstream bridge.
>> >
>> >     This fixes that by enabling the upstream bridge of the PF corresponding to
>> >     the VF.
>> >
>> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> >
>> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> > index ac40f90..744dc26 100644
>> > --- a/drivers/pci/pci.c
>> > +++ b/drivers/pci/pci.c
>> > @@ -1150,10 +1150,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
>> >  {
>> >         int retval;
>> >
>> > -       if (!dev)
>> > -               return;
>> > -
>> > -       pci_enable_bridge(dev->bus->self);
>> > +       if (!pci_is_root_bus(dev->bus))
>> > +               pci_enable_bridge(pci_upstream_bridge(dev));
>> >
>> >         if (pci_is_enabled(dev)) {
>> >                 if (!dev->is_busmaster)
>> > @@ -1188,7 +1186,8 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>> >         if (atomic_inc_return(&dev->enable_cnt) > 1)
>> >                 return 0;               /* already enabled */
>> >
>> > -       pci_enable_bridge(dev->bus->self);
>> > +       if (!pci_is_root_bus(dev->bus))
>> > +               pci_enable_bridge(pci_upstream_bridge(dev));
>> >
>> >         /* only skip sriov related */
>> >         for (i = 0; i <= PCI_ROM_RESOURCE; i++)
>>
>> still have problem.
>>
>> pci_upstream_bridge() could return NULL. so later pci_enable_bridge()
>> referring dev->bus could panic, as you remove !dev checking.
>
> pci_upstream_bridge(dev) can only return NULL if dev is on a root bus,
> and we never call pci_enable_bridge() in that case.  So I don't see
> the problem.

how about it is VF and it is on it's own virtual bus ?
and it will pass !pci_is_root_bus(dev->bus) checking and get into
pci_enable_bridge(pci_upstream_bridge(dev));


Thanks

Yinghai
