Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57434 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752968AbaA3XYq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 18:24:46 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yinghai Lu <yinghai@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release resources in pci_release_dev()) broke TBT hotplug
Date: Fri, 31 Jan 2014 00:39:07 +0100
Message-ID: <3365345.z6P9Wo4Pau@vostro.rjw.lan>
In-Reply-To: <CAE9FiQUaof1tk151Wbu2OtpTYb+pvP16ZhLsmbn6LDdBqoVEgA@mail.gmail.com>
References: <20140130131236.GW18029@intel.com> <CAE9FiQWDqXNF5Cn5X_muBERMWdZsZFbzmoqWvuPARREz+XO9Gw@mail.gmail.com> <CAE9FiQUaof1tk151Wbu2OtpTYb+pvP16ZhLsmbn6LDdBqoVEgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 30, 2014 08:56:05 AM Yinghai Lu wrote:
> 
> --047d7b5d2ea4eb937804f132eedf
> Content-Type: text/plain; charset=ISO-8859-1
> 
> >> The latest mainline kernel "hangs" when Thunderbolt devices are
> >> hot-unplugged to the system. I can't see any oops but after hot-unplug I'm
> >> getting huge amounts of messages like:
> >>
> >> [  352.717001] pci 0000:02:00.0: PME# disabled
> >> [  352.717011] pci 0000:02:00.0: PME# disabled
> >> [  352.717021] pci 0000:02:00.0: PME# disabled
> >> [  352.717032] pci 0000:02:00.0: PME# disabled
> >> [  352.717041] pci 0000:02:00.0: PME# disabled
> >> [  352.717051] pci 0000:02:00.0: PME# disabled
> >> [  352.717061] pci 0000:02:00.0: PME# disabled
> >> [  352.717070] pci 0000:02:00.0: PME# disabled
> >> [  352.717083] pci 0000:02:00.0: PME# disabled
> >> [  352.717094] pci 0000:02:00.0: PME# disabled
> >> [  352.717104] pci 0000:02:00.0: PME# disabled
> >> [  352.717113] pci 0000:02:00.0: PME# disabled
> >> [  352.717124] pci 0000:02:00.0: PME# disabled
> >> [  352.717133] pci 0000:02:00.0: PME# disabled
> >> [  352.717143] pci 0000:02:00.0: PME# disabled
> >> [  352.717153] pci 0000:02:00.0: PME# disabled
> >> [  352.717162] pci 0000:02:00.0: PME# disabled
> >
> > that mean pci_stop_dev() get called again and again ?
> 
> please check if attached patch could help.

Well, it looks like what happens is an endless loop in
acpiphp_glue.c:disable_slot().

dev_in_slot() returns the first device in the list, so
pci_stop_and_remove_bus_device() is called for it, but it
doesn't remove the device from bus->devices any more, so
dev_in_slot() will return the same device next time and
so on forever.

> it should prevent possible reattaching driver.

If my analysis above is correct, this isn't related to attaching drivers
and rather to the way dev_in_slot() is designed.

> ---
>  drivers/pci/remove.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/drivers/pci/remove.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/remove.c
> +++ linux-2.6/drivers/pci/remove.c
> @@ -11,6 +11,7 @@ static void pci_stop_dev(struct pci_dev
>          pci_proc_detach_device(dev);
>          pci_remove_sysfs_dev_files(dev);
>          device_release_driver(&dev->dev);
> +        dev->match_driver = false;
>          dev->is_added = 0;
>      }

So the above won't help in my opinion.

I wonder, however, if this patch helps instead:

https://patchwork.kernel.org/patch/3540701/

I thought it would be 3.15 material, but it very well can go in earlier if
it happens to address this particular problem.

Mika, can you please try that?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
