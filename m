Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34593 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbaAaKp4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 Jan 2014 05:45:56 -0500
Date: Fri, 31 Jan 2014 12:53:01 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release
 resources in pci_release_dev()) broke TBT hotplug
Message-ID: <20140131105301.GD18029@intel.com>
References: <20140130131236.GW18029@intel.com>
 <CAE9FiQUmuaarJEhOQogusyv3EpBPDjRTtRvbh4U4QCJqfs0Vvw@mail.gmail.com>
 <1560693.rdg5lbdvCP@vostro.rjw.lan>
 <2622847.3aWjiMW5oK@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2622847.3aWjiMW5oK@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 31, 2014 at 01:38:42AM +0100, Rafael J. Wysocki wrote:
> On Friday, January 31, 2014 12:59:06 AM Rafael J. Wysocki wrote:
> > On Thursday, January 30, 2014 03:39:02 PM Yinghai Lu wrote:
> > > On Thu, Jan 30, 2014 at 3:39 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > On Thursday, January 30, 2014 08:56:05 AM Yinghai Lu wrote:
> > > >>
> > > >> --047d7b5d2ea4eb937804f132eedf
> > > >> Content-Type: text/plain; charset=ISO-8859-1
> > > >>
> > > >> >> The latest mainline kernel "hangs" when Thunderbolt devices are
> > > >> >> hot-unplugged to the system. I can't see any oops but after hot-unplug I'm
> > > >> >> getting huge amounts of messages like:
> > > >> >>
> > > >> >> [  352.717001] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717011] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717021] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717032] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717041] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717051] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717061] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717070] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717083] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717094] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717104] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717113] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717124] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717133] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717143] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717153] pci 0000:02:00.0: PME# disabled
> > > >> >> [  352.717162] pci 0000:02:00.0: PME# disabled
> > > >> >
> > > >> > that mean pci_stop_dev() get called again and again ?
> > > >>
> > > >> please check if attached patch could help.
> > > >
> > > > Well, it looks like what happens is an endless loop in
> > > > acpiphp_glue.c:disable_slot().
> > > >
> > > > dev_in_slot() returns the first device in the list, so
> > > > pci_stop_and_remove_bus_device() is called for it, but it
> > > > doesn't remove the device from bus->devices any more, so
> > > > dev_in_slot() will return the same device next time and
> > > > so on forever.
> > > >
> > > ...
> > > >
> > > > So the above won't help in my opinion.
> > > >
> > > > I wonder, however, if this patch helps instead:
> > > >
> > > > https://patchwork.kernel.org/patch/3540701/
> > > >
> > > > I thought it would be 3.15 material, but it very well can go in earlier if
> > > > it happens to address this particular problem.
> > > 
> > > Agree, that should fix the problem.
> > > 
> > > but please use list_for_each_entry_safe_reverse
> > > instead.
> > 
> > OK, I will.
> 
> Mika, below is an updated patch to try.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: ACPI / hotplug / PCI: Simplify disable_slot()
> 
> After recent PCI core changes related to the rescan/remove locking,
> the ACPIPHP's disable_slot() function is only called under the
> general PCI rescan/remove lock, so it doesn't have to use
> dev_in_slot() any more to avoid race conditions.  Make it simply
> walk the devices on the bus and drop the ones in the slot being
> disabled and drop dev_in_slot() which has no more users.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for the fix.

Unfortunately, it now crashes here after I re-plug the TBT chain (I have
both of your patches applied):

int sysfs_create_bin_file(struct kobject *kobj,
                          const struct bin_attribute *attr)
{
	BUG_ON(!kobj || !kobj->sd || !attr); <--

Since I don't have proper serial console to that machine, all I see is the
end of the backtrace :-(

Here is a hand copied backtrace from the screen:

pci_create_sysfs_dev_files()
pci_bus_add_device()
pci_bus_add_devices()
enable_slot()
acpiphp_check_bridge()
hotplug_event()
...
