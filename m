Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab2IQPzp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2012 11:55:45 -0400
Received: by dady13 with SMTP id y13so976156dad.19
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2012 08:55:45 -0700 (PDT)
Message-ID: <505747FA.6060708@gmail.com>
Date: Mon, 17 Sep 2012 23:55:38 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/2] PCI: introduce root bridge hotplug safe interfaces
 to walk root buses
References: <CAErSpo4=cakjCQ_Z_nUa2xZQr9KV72kxtsgrW0cjeFN=ktb8zQ@mail.gmail.com> <1347552010-6718-1-git-send-email-jiang.liu@huawei.com> <CAErSpo781H+k=veR19WoRvRRKe-pVpxYV4UK74iaQv36Ms3LrA@mail.gmail.com>
In-Reply-To: <CAErSpo781H+k=veR19WoRvRRKe-pVpxYV4UK74iaQv36Ms3LrA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/14/2012 01:40 AM, Bjorn Helgaas wrote:
> On Thu, Sep 13, 2012 at 10:00 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> This patch introduces two root bridge hotplug safe interfaces to walk
>> all root buses. Function pci_get_root_buses() takes a snopshot of the
>> pci_root_buses list and holds a reference count to each root buses.
>> pci_{get|put}_root_buses are used to replace hotplug unsafe interface
>> pci_find_next_bus().
> 
> Honestly, I think the whole idea of walking these lists is wrong, and
> adding safer interfaces just perpetuates the idea that it's OK to walk
> them.
> 
> We should be doing the setup in the device add path instead.  I know
> we have other issues with that in some cases, but I'd like to at least
> move in that direction.
> 
> For example, sba_init() is a problem because it's an ACPI driver, and
> we currently enumerate PCI devices before binding most ACPI drivers.
> That's broken -- in that particular case, there's an HWP0001 IOMMU
> device that encloses the PNP0A03 PCI host bridge.  Currently we bind
> the PNP0A03 driver first, enumerate the PCI devices below it, then
> bind the HWP0001 driver (sba_init).  Obviously that's backwards and
> the HWP0001 driver should have been bound first, then the PNP0A03
> driver.  But I don't think we're ready to make that shift yet (though
> it'd be nice if somebody were working on it).
I remember there were some discussions on the mail list above the divergence
between boot and hotplug paths. But it's a little hard for me to work on
this, I only have experience with PCI on IA64 and x86:(

> 
> I wonder if we could add some kind of iterator that does the list
> traversals in the PCI core and calls a callback for every device?  I
> think that would work for sba_init(), but I don't know about the
> others.  This would still be ugly in that the iterator would have to
> hold some sort of hotplug lock while doing for_each_pci_dev() and the
> callers, e.g., sba_init(), are not solving the problem for hot-added
> devices, but at least the locking would be in the core and the drivers
> would stop depending on the lists themselves.
I will try the iterator first, hope we could find a solution here.
--Gerry

> 

