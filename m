Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43145 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758073Ab3DXWrE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Apr 2013 18:47:04 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Guo <tuffkidtt@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: About dynamically loading the acpiphp.ko
Date: Thu, 25 Apr 2013 00:55:08 +0200
Message-ID: <3400627.YcEmgrxv5I@vostro.rjw.lan>
In-Reply-To: <CAErSpo6zf34MOLNh5t_PifYhA87vFLRRx-g0WG5N=8+oUcWukQ@mail.gmail.com>
References: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com> <CAAh6nkmkbKh7FjEZea4GmEbZvH4qvnfOJ2Og8xHYm5othsWLwQ@mail.gmail.com> <CAErSpo6zf34MOLNh5t_PifYhA87vFLRRx-g0WG5N=8+oUcWukQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 24, 2013 02:03:04 PM Bjorn Helgaas wrote:
> [+cc Rafael, Yinghai, -cc t-kochi for real this time]
> 
> On Wed, Apr 24, 2013 at 2:46 AM, Gavin Guo <tuffkidtt@gmail.com> wrote:
> > 2013/4/18 Bjorn Helgaas <bhelgaas@google.com>:
> >
> >> [+cc Jiang, -cc willy@hp.com (defunct address), -cc t-kochi (I assume
> >> also defunct)]
> >>
> >> On Wed, Apr 17, 2013 at 9:27 PM, Gavin Guo <tuffkidtt@gmail.com> wrote:
> >>> Hi All,
> >>>
> >>> I've a Dell platform which has PCI-to-USB card and would like to let
> >>> the module be dynamically insmoded when hotplugging this card.
> >>> Firstly, I've submitted a patch, which added acpiphp to the
> >>> /etc/modules, to the init-module-tools package in the Debian system,
> >>> but maintainer rejected to accept the patch and said it would be done
> >>> in the kernel side to enable the automatically loading. Then, I've
> >>> tried to read the code about acpiphp under drivers/pci/hotplug/* and
> >>> found that acpiphp_ibm.c seems providing a hook to build the
> >>> dependency with acpiphp.ko, providing a way to construct a empty
> >>> ibm_handle_events-liked callback function, named dell_handle_events,
> >>> for acpi_install_notify_handler and the acpiphp_dell.ko could be
> >>> insmoded by udev through the MODULE_ALIAS("dmi*...") which describe
> >>> the dell platform information. However, writing a code with fake empty
> >>> function just to enable the hotplugging PCI is silly in my opinion, I
> >>> would be appreciated if anyone could provide a method to enable the
> >>> hotplugging automatically.
> >>
> >> Please test linux-next (20130417 or later) with
> >> CONFIG_HOTPLUG_PCI_ACPI=y and see if that works as you expect.  That
> >> contains Jiang's patch (that you mentioned in a your subsequent email)
> >> which removes the option of building acpiphp as a module.
> >>
> >> If that doesn't work, please let us know, along with more details,
> >> such as a complete dmesg log.  There are still known issues with
> >> acpiphp, e.g., https://bugzilla.kernel.org/show_bug.cgi?id=54981, that
> >> you might be seeing.
> >>
> >> Bjorn
> >
> > Hi Bjorn,
> >
> > I've tested the helgaas/next tree. And the hotplugging cannot work. The
> > sequence I tested the function are as following: Booting with PCI-USB
> > express card plugged-in, then plugging in the USB disk; un-plugging the USB
> > disk; un-plugging the PCI-USB express card; plugging in the PCI-USB express
> > card. The dmesg is attached.
> 
> Thanks for testing this!
> 
> Your dmesg log includes this:
> 
>     acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
>     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
>     \_SB_.PCI0:_OSC invalid UUID
>     acpiphp: Slot [1] registered
>     acpiphp: Slot [1-1] registered
>    acpi root: \_SB_.PCI0 notify handler is installed
>     _handle_hotplug_event_root: Bus check notify on \_SB_.PCI0
>     _handle_hotplug_event_root: Bus check notify on \_SB_.PCI0
> 
> We won't use pciehp (PCIe native hotplug) because the _OSC evaluation
> failed.  (As a workaround, you could try booting with
> "pcie_ports=native".  That's not a fix, of course, but it might be a
> temporary hack to get it to work until the bug is fixed.)
> 
> So we should be using acpiphp, which you do have built in statically,
> and it found a couple slots.  And we did get two bus check notifies on
> \_SB_.PCI0, so we *should* be re-enumerating PCI bus 0000:00.  But it
> looks like we're handling this as a host bridge hotplug event instead
> of a PCI device hotplug.  My guess is that
> handle_root_bridge_insertion() does nothing because the PCI0 ACPI
> device already exists, though I would expect to see the "acpi device
> exists..." in your dmesg log if this were the case.
> 
> We install a notify handler on PCI0 in find_root_bridges(), and that
> notify handler leads to _handle_hotplug_event_root(), which assumes
> this is a host bridge hotplug event.  But I would expect the notify
> for a host bridge hot-add would go to the *parent* of the host bridge,
> not to the host bridge itself, so something seems wrong here.
> 
> Maybe the ACPI & hotplug experts can comment on this.

I think it may (ie. won't be against the spec) go both ways, so it may go
to the parent or the host bridge object itself.  We should be handling both
cases IMO.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
