Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56848 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932797AbaBAOUu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Feb 2014 09:20:50 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release resources in pci_release_dev()) broke TBT hotplug
Date: Sat, 01 Feb 2014 15:35:14 +0100
Message-ID: <5223287.Whp4qv3MBf@vostro.rjw.lan>
In-Reply-To: <CAE9FiQVm2mbZnJTJ=wJ6yQqpByZHD2+gaUvhJSZ6P13sa2Z6vg@mail.gmail.com>
References: <20140130131236.GW18029@intel.com> <CAE9FiQU8+RRiTdsCm0v8Z46UyQ5xLSGWResVzEyHNCoWvWZjEw@mail.gmail.com> <CAE9FiQVm2mbZnJTJ=wJ6yQqpByZHD2+gaUvhJSZ6P13sa2Z6vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, January 31, 2014 07:51:49 PM Yinghai Lu wrote:
> 
> --001a11c2019ad93b5d04f1503567
> Content-Type: text/plain; charset=ISO-8859-1
> 
> On Fri, Jan 31, 2014 at 7:44 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Fri, Jan 31, 2014 at 5:49 AM, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> >> On Fri, Jan 31, 2014 at 02:49:21PM +0100, Rafael J. Wysocki wrote:
> >>> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.672933] pci_bus 0000:03: busn_res: [bus 03-3a] is released
> >>>
> >>> OK, so my guess wasn't right.  We seem to call pci_release_dev for all of the
> >>> devices that go away after unplug.
> >>>
> >>> Do I think correctly that the below doesn't happen with the Yinghai's commit
> >>> reverted?
> >>
> >> Yes, with that commit reverted everything works fine.
> >
> > can you make it clear ?
> >
> > after my commit is reverted, the warning does not happen any more?
> >
> > Jan 31 20:06:11 buildroot kern.warn kernel: [  453.616434]
> > ------------[ cut here ]------------
> > Jan 31 20:06:11 buildroot kern.warn kernel: [  453.618102] WARNING:
> > CPU: 1 PID: 956 at lib/kobject.c:244 kobject_add_internal+0x12d/
> > 0x400()
> 
> Hi, Mika,
> 
> Can you try attached partial reverting?

My mailer has mangled the patch, so the below has been copied by hand
from patchwork:

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 04796c0..dd91116 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1231,10 +1231,6 @@  static void pci_release_dev(struct device *dev)
> 
>  {
>  
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> 
> -	down_write(&pci_bus_sem);
> -	list_del(&pci_dev->bus_list);
> -	up_write(&pci_bus_sem);
> -
> 
>  	pci_free_resources(pci_dev);
>  	
>  	pci_release_capabilities(pci_dev);
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 4ff36bf..c8264c4 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -25,6 +25,10 @@  static void pci_destroy_dev(struct pci_dev *dev)
> 
>  	device_del(&dev->dev);
> 
> +	down_write(&pci_bus_sem);
> +	list_del(&dev->bus_list);
> +	up_write(&pci_bus_sem);
> +
> 
>  	put_device(&dev->dev);
>  
>  }

I've tried that, but it only helps partly.  The box doesn't crash any more,
but we get resource conflicts on replug (if that happens sufficiently quickly
after the preceding unplug).

That's why I sent a full revert.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
