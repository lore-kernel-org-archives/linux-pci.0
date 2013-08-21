Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53970 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab3HUV4K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Aug 2013 17:56:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: add hibernation hooks
Date: Thu, 22 Aug 2013 00:06:43 +0200
Message-ID: <3498248.Me8u1JmYkr@vostro.rjw.lan>
In-Reply-To: <CAErSpo7OfDUcfM=2Tycx9H5LG8kpSq_B93SqT21-_413Re3KpA@mail.gmail.com>
References: <alpine.LFD.2.03.1308201637390.1566@linux.vnet.ibm.com> <3503956.Yk8myngYqt@vostro.rjw.lan> <CAErSpo7OfDUcfM=2Tycx9H5LG8kpSq_B93SqT21-_413Re3KpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 21, 2013 10:23:21 AM Bjorn Helgaas wrote:
> On Tue, Aug 20, 2013 at 3:33 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, August 20, 2013 11:08:56 AM Bjorn Helgaas wrote:
> >> On Tue, Aug 20, 2013 at 8:41 AM, Sebastian Ott
> >> <sebott@linux.vnet.ibm.com> wrote:
> >> > Hello Bjorn,
> >> >
> >> > I'm currently trying to implement hibernate support for pci on s390. To access
> >> > the config space of a pci function on s390 the function has to be enabled first.
> >> > So I need some kind of callback to achieve this before the pci core or the device
> >> > driver tries to access the function after a resume from hibernate.
> >> >
> >> > Would you be OK with the following patch?
> >>
> >> I think doing something like this is fine.
> >
> > Well, since we seem to be doing everything using __weak functions in the PCI
> > land like in this patch, shouldn't we drop pci_platform_pm and use __weak
> > functions for that stuff too?
> 
> Well, we could consider that, if somebody wanted to do the work, but I
> don't think we need to tie it to Sebastian's change.

No, it's not.  I was thinking in general.

> It's hard to tell over email, but it sounds like you have some
> reluctance to using weak functions?  PCI has long used the pcibios_*()
> style for arch-dependent code.  Before we used weak functions, every
> arch had to implement every pcibios_*() interface, whether the arch
> needed it or not.  Using weak functions just means when an arch
> doesn't need anything special in pcibios_foo(), it can do nothing at
> all and automatically get the weak definition.

I don't have a problem with __weak functions as such, although it's happened
to me to overlook an arch-specific variant for a couple of times, but to me
it's just inconsistent to use __weak functions here and something different
somewhere else.  It would be better to choose one convention in my opinion.

> For Sebastian's changes, the question is whether we want this:
> 
>   struct dev_pm_ops __weak pcibios_pm_ops;
> 
>   static int pci_pm_thaw(struct device *dev)
>   {
>     ...
>     if (pcibios_pm_ops.thaw) {
>       error = pcibios_pm_ops.thaw(pci_dev)
>       if (error)
>         return error;
>     }
>     ...
>   }
> or this:
> 
>   int __weak pcibios_pm_thaw(struct pci_dev *pdev) { return 0; }
> 
>   static int pci_pm_thaw(struct device *dev)
>   {
>     ...
>     error = pcibios_pm_thaw(pci_dev);
>     if (error)
>       return error;
>     ...
>   }
> 
> I prefer the latter because there's no need to repeat the
> "pcibios_pm_ops.thaw" reference and it seems more straightforward to
> read.

I agree here, but ->

> But it does have the disadvantage of requiring a weak
> definition for every hook, instead of a single weak pcibios_pm_ops
> definition.
> 
> There's also the x86 pcibios_enable_irq() style, where we declare
> "extern int (*pcibios_enable_irq)(struct pci_dev *dev)".  The call
> looks the same as using a weak function, but you can change the
> pointer at run-time.  Run-time control isn't needed here, so it seems
> overkill to me, but it is a possibility, e.g., make pcibios_pm_thaw()
> a pointer that defaults to an empty implementation, and arches could
> override by reassigning it.

-> the prevailing convention for representing platform options like that
seems to be to use a pointer to an object containing callback pointers.  This
is what we do for pci_platform_pm and for suspend_ops, hibernation_ops etc.
I think it is just more flexible, because it allows the pointer to be left
unset if there is an initialization error of some sort or a command line
option disabling something is set etc.

So I know that PCI has a history of using __weak symbols, but PM has
always been using a different approach.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
