Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49961 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab3HUQXm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 12:23:42 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so1230199obb.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2013 09:23:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3503956.Yk8myngYqt@vostro.rjw.lan>
References: <alpine.LFD.2.03.1308201637390.1566@linux.vnet.ibm.com>
 <CAErSpo4qnDyQQt+sZi=1tj0PP+HUmLfMp4zQ2hdqjJ+mOcAzYA@mail.gmail.com> <3503956.Yk8myngYqt@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 21 Aug 2013 10:23:21 -0600
Message-ID: <CAErSpo7OfDUcfM=2Tycx9H5LG8kpSq_B93SqT21-_413Re3KpA@mail.gmail.com>
Subject: Re: [PATCH] PCI: add hibernation hooks
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 20, 2013 at 3:33 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, August 20, 2013 11:08:56 AM Bjorn Helgaas wrote:
>> On Tue, Aug 20, 2013 at 8:41 AM, Sebastian Ott
>> <sebott@linux.vnet.ibm.com> wrote:
>> > Hello Bjorn,
>> >
>> > I'm currently trying to implement hibernate support for pci on s390. To access
>> > the config space of a pci function on s390 the function has to be enabled first.
>> > So I need some kind of callback to achieve this before the pci core or the device
>> > driver tries to access the function after a resume from hibernate.
>> >
>> > Would you be OK with the following patch?
>>
>> I think doing something like this is fine.
>
> Well, since we seem to be doing everything using __weak functions in the PCI
> land like in this patch, shouldn't we drop pci_platform_pm and use __weak
> functions for that stuff too?

Well, we could consider that, if somebody wanted to do the work, but I
don't think we need to tie it to Sebastian's change.

It's hard to tell over email, but it sounds like you have some
reluctance to using weak functions?  PCI has long used the pcibios_*()
style for arch-dependent code.  Before we used weak functions, every
arch had to implement every pcibios_*() interface, whether the arch
needed it or not.  Using weak functions just means when an arch
doesn't need anything special in pcibios_foo(), it can do nothing at
all and automatically get the weak definition.

For Sebastian's changes, the question is whether we want this:

  struct dev_pm_ops __weak pcibios_pm_ops;

  static int pci_pm_thaw(struct device *dev)
  {
    ...
    if (pcibios_pm_ops.thaw) {
      error = pcibios_pm_ops.thaw(pci_dev)
      if (error)
        return error;
    }
    ...
  }
or this:

  int __weak pcibios_pm_thaw(struct pci_dev *pdev) { return 0; }

  static int pci_pm_thaw(struct device *dev)
  {
    ...
    error = pcibios_pm_thaw(pci_dev);
    if (error)
      return error;
    ...
  }

I prefer the latter because there's no need to repeat the
"pcibios_pm_ops.thaw" reference and it seems more straightforward to
read.  But it does have the disadvantage of requiring a weak
definition for every hook, instead of a single weak pcibios_pm_ops
definition.

There's also the x86 pcibios_enable_irq() style, where we declare
"extern int (*pcibios_enable_irq)(struct pci_dev *dev)".  The call
looks the same as using a weak function, but you can change the
pointer at run-time.  Run-time control isn't needed here, so it seems
overkill to me, but it is a possibility, e.g., make pcibios_pm_thaw()
a pointer that defaults to an empty implementation, and arches could
override by reassigning it.

Bjorn
