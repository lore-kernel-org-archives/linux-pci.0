Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36900 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755554Ab2IRVjm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 17:39:42 -0400
Received: by lagy9 with SMTP id y9so239957lag.19
        for <linux-pci@vger.kernel.org>; Tue, 18 Sep 2012 14:39:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5uj9YwxjZweoLDsrx11S5NjCFwPeNfROsKySr1dTOjqQ@mail.gmail.com>
References: <CAErSpo4=cakjCQ_Z_nUa2xZQr9KV72kxtsgrW0cjeFN=ktb8zQ@mail.gmail.com>
 <1347552010-6718-1-git-send-email-jiang.liu@huawei.com> <CAErSpo781H+k=veR19WoRvRRKe-pVpxYV4UK74iaQv36Ms3LrA@mail.gmail.com>
 <505747FA.6060708@gmail.com> <CAErSpo5uj9YwxjZweoLDsrx11S5NjCFwPeNfROsKySr1dTOjqQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 18 Sep 2012 15:39:19 -0600
Message-ID: <CAErSpo5QwebVypZK21R9_mXaWic0NJqMPzx8vd-FVfTDq9Ui4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: introduce root bridge hotplug safe interfaces to
 walk root buses
To: Jiang Liu <liuj97@gmail.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2012 at 10:24 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Sep 17, 2012 at 9:55 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> On 09/14/2012 01:40 AM, Bjorn Helgaas wrote:
>>> On Thu, Sep 13, 2012 at 10:00 AM, Jiang Liu <liuj97@gmail.com> wrote:
>>>> This patch introduces two root bridge hotplug safe interfaces to walk
>>>> all root buses. Function pci_get_root_buses() takes a snopshot of the
>>>> pci_root_buses list and holds a reference count to each root buses.
>>>> pci_{get|put}_root_buses are used to replace hotplug unsafe interface
>>>> pci_find_next_bus().
>>>
>>> Honestly, I think the whole idea of walking these lists is wrong, and
>>> adding safer interfaces just perpetuates the idea that it's OK to walk
>>> them.
>>>
>>> We should be doing the setup in the device add path instead.  I know
>>> we have other issues with that in some cases, but I'd like to at least
>>> move in that direction.
>>>
>>> For example, sba_init() is a problem because it's an ACPI driver, and
>>> we currently enumerate PCI devices before binding most ACPI drivers.
>>> That's broken -- in that particular case, there's an HWP0001 IOMMU
>>> device that encloses the PNP0A03 PCI host bridge.  Currently we bind
>>> the PNP0A03 driver first, enumerate the PCI devices below it, then
>>> bind the HWP0001 driver (sba_init).  Obviously that's backwards and
>>> the HWP0001 driver should have been bound first, then the PNP0A03
>>> driver.  But I don't think we're ready to make that shift yet (though
>>> it'd be nice if somebody were working on it).
>> I remember there were some discussions on the mail list above the divergence
>> between boot and hotplug paths. But it's a little hard for me to work on
>> this, I only have experience with PCI on IA64 and x86:(
>>
>>>
>>> I wonder if we could add some kind of iterator that does the list
>>> traversals in the PCI core and calls a callback for every device?  I
>>> think that would work for sba_init(), but I don't know about the
>>> others.  This would still be ugly in that the iterator would have to
>>> hold some sort of hotplug lock while doing for_each_pci_dev() and the
>>> callers, e.g., sba_init(), are not solving the problem for hot-added
>>> devices, but at least the locking would be in the core and the drivers
>>> would stop depending on the lists themselves.
>
>> I will try the iterator first, hope we could find a solution here.
>
> A plain iterator only handles devices that already exist.  But I
> wonder if it would work to have an interface like "call this callback
> for every device that exists already *and* for every device that's
> hot-added in the future."  The bus notifiers are close to this, e.g.,
> "bus_register_notifier(&pci_bus_type, ...)" handles this for hot-added
> devices.  A little glue around it could take care of doing it for
> already-existing devices as well.

BTW, while reviewing Yinghai's vga patch, I found a case in
vga_arb_device_init() that does exactly this: registers a notifier to
catch future hot-added devices, then calls the notifier "add" function
for every existing device.  So that's another place that could use
something like this.
