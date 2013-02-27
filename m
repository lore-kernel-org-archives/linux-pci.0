Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f202.google.com ([209.85.220.202]:44829 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab3B0UOv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2013 15:14:51 -0500
Received: by mail-vc0-f202.google.com with SMTP id m8so106142vcd.5
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2013 12:14:49 -0800 (PST)
Date: Wed, 27 Feb 2013 13:14:49 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Joe Lawrence <Joe.Lawrence@stratus.com>,
	linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>
Subject: Re: [PATCH 1/2] PCI: ASPM exit link state code could skip devices
Message-ID: <20130227201449.GA6409@google.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
 <alpine.DEB.2.02.1301181322500.31163@jlaw-desktop.mno.stratus.com>
 <51122BED.8090308@cn.fujitsu.com>
 <CAErSpo6aGiuBbgcVfcduPk++7B_zzuk2Y+fjLiJBvdOqnU+Qmw@mail.gmail.com>
 <5122F276.80807@cn.fujitsu.com>
 <CAErSpo7BeCiKHecJgX9GBR7DYf4M9mrXK+qMLMDXFykxq5C7sQ@mail.gmail.com>
 <CAE9FiQV814mCKqcOKAE_y3JSUq2HotVjde6VYW4M8Zb2-S=NRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQV814mCKqcOKAE_y3JSUq2HotVjde6VYW4M8Zb2-S=NRA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 23, 2013 at 07:13:11PM -0800, Yinghai Lu wrote:
> On Sat, Feb 23, 2013 at 4:20 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > I think this is a general object lifetime issue that really has
> > nothing to do with ASPM except that ASPM happens to be the victim.
> >
> > You're doing this:
> >
> >     echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove ; echo -n 1
> >>  /sys/bus/pci/devices/0000\:1a\:01.0/remove
> >
> > The 1a:01.0 device is downstream from the 10:00.0 bridge.  The sysfs
> > interface remove_store() uses device_schedule_callback() to schedule
> > the remove for later.  I think what's happening is that we schedule
> > remove_callback() for both devices before 10:00.0 has been removed,
> > like this:
> >
> >     # echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove
> >     remove_store  # for 10:00.0
> >       device_schedule_callback(10:00.0, remove_callback)
> >         sysfs_schedule_callback
> >           kobject_get
> >           queue_work
> >     # echo -n 1 >  /sys/bus/pci/devices/0000\:1a\:01.0/remove
> >     remove_store  # for 1a:01.0
> >       device_schedule_callback(1a:01.0, remove_callback)
> >         sysfs_schedule_callback
> >           kobject_get
> >           queue_work
> >
> > Note that we acquire a reference on each pci_dev before queuing the work item.
> >
> > Later, we run the callbacks, starting with 10:00.0.  This calls
> > remove_callback() to perform the remove:
> >
> >     remove_callback(10:00.0)
> >       mutex_lock(&pci_remove_rescan_mutex)
> >       pci_stop_and_remove_bus_device(pdev)
> >       mutex_unlock(&pci_remove_rescan_mutex)
> >
> > This will stop and remove the subtree below 10:00.0, but it does not
> > actually free the pci_dev for 1a:01.0 because we increased its ref
> > count in sysfs_schedule_callback.  So after completing
> > remove_callback(10:00.0), we run the second callback for 1a:01.0.
> >
> > The remove for 1a:01.0 calls pcie_aspm_exit_link_state() from
> > pci_stop_dev().  This is where we blow up because, according to your
> > debugging, pdev->bus->self is no longer valid.
> >
> > The PCI core did this removal wrong.  If we have a valid pci_dev
> > pointer, as we do in pcie_aspm_exit_link_state(), the whole object
> > ought to be valid.  But the PCI core deallocated the struct pci_bus
> > for bus 0000:1a too soon.
> >
> > My guess is that when we build a pci_dev, we need to increase the ref
> > count on the pci_bus where that pci_dev lives.  That way we can keep
> > around all the buses and bridges leading from the root to the device
> > in question.
> 
> Agreed, Please check if attached is what you want.

I included the patch directly below for convenience.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b494066..6df5428 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1337,6 +1337,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	 */
>  	down_write(&pci_bus_sem);
>  	list_add_tail(&dev->bus_list, &bus->devices);
> +	get_device(&bus->dev);
>  	up_write(&pci_bus_sem);

This suggests that taking the reference must be protected by
pci_bus_sem, but I don't think that's the case, is it?

>  	pci_fixup_device(pci_fixup_final, dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index cc875e6..a72b700 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -36,6 +36,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  {
>  	down_write(&pci_bus_sem);
>  	list_del(&dev->bus_list);
> +	put_device(&dev->bus->dev);
>  	up_write(&pci_bus_sem);
>  
>  	pci_free_resources(dev);

The problem is that we capture the struct pci_bus pointer without
taking a reference on the bus object.  The capture occurs in
pci_scan_device() (and other callers of alloc_pci_dev()) where we do
this:

    dev = alloc_pci_dev();
    dev->bus = bus;

To make code analysis easier, I think we should take the reference at
the exact point where we capture the pointer, using something like:

    dev->bus = pci_bus_get(bus);

It'd probably be even better to deprecate alloc_pci_dev() and make a
pci_alloc_dev(struct pci_bus *bus) that takes care of acquiring the
reference itself.

But I don't think this takes care of the whole issue.  What protects
the pci_scan_slot() path against concurrent removal of the pci_bus?
I don't see anything in the hotplug drivers or in the
pci_scan_child_bus() path that acquires a reference or does locking
for this.

Bjorn
