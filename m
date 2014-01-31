Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50388 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754149AbaAaNv2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 08:51:28 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release resources in pci_release_dev()) broke TBT hotplug
Date: Fri, 31 Jan 2014 15:05:51 +0100
Message-ID: <3346247.e0tRWesPgb@vostro.rjw.lan>
In-Reply-To: <1426729.BFFFkbZrqa@vostro.rjw.lan>
References: <20140130131236.GW18029@intel.com> <20140131123606.GF18029@intel.com> <1426729.BFFFkbZrqa@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, January 31, 2014 02:49:21 PM Rafael J. Wysocki wrote:
> On Friday, January 31, 2014 02:36:07 PM Mika Westerberg wrote:
> > On Fri, Jan 31, 2014 at 12:52:43PM +0100, Rafael J. Wysocki wrote:
> > > So I think what happens is that we leak the struct pci_dev during removal and
> > > the proper cleanup is never done.
> > > 
> > > Can you please add a debug printk into pci_release_dev() and see if that's
> > > ever called after TBT unplug?
> > 
> > OK, I added the debug print (still on top of your two patches) and was able
> > to capture a bit more from /var/log/messages before it crashes. Here's the
> > log. I added dev_info(dev, "RELEASE\n") to pci_release_dev().
> > 
> > Unplug:
> > 
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.557920] pcieport 0000:06:03.0: PME# disabled
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.559483] pcieport 0000:05:00.0: PME# disabled
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.561074] pci 0000:07:00.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.562536] pci_bus 0000:07: busn_res: [bus 07] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.563993] pci 0000:06:03.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.570345] pci 0000:0a:00.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.571734] pci_bus 0000:0a: busn_res: [bus 0a] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.573154] pci 0000:09:00.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.574528] pci_bus 0000:09: busn_res: [bus 09-2e] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.575939] pci 0000:08:00.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.577316] pci_bus 0000:08: busn_res: [bus 08-2e] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.578721] pci 0000:06:04.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.580081] pci_bus 0000:2f: busn_res: [bus 2f] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.581487] pci 0000:06:05.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.582873] pci_bus 0000:06: busn_res: [bus 06-2f] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.584322] pci 0000:05:00.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.585727] pcieport 0000:03:00.0: PME# disabled
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.587225] pci_bus 0000:04: busn_res: [bus 04] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.588723] pci 0000:03:00.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.660389] pci_bus 0000:05: busn_res: [bus 05-2f] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.661993] pci 0000:03:03.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.663527] pci_bus 0000:30: busn_res: [bus 30-38] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.665103] pci 0000:03:04.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.666641] pci_bus 0000:39: busn_res: [bus 39] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.668210] pci 0000:03:05.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.669764] pci_bus 0000:3a: busn_res: [bus 3a] is released
> > Jan 31 20:05:57 buildroot kern.info kernel: [  439.671350] pci 0000:03:06.0: RELEASE
> > Jan 31 20:05:57 buildroot kern.debug kernel: [  439.672933] pci_bus 0000:03: busn_res: [bus 03-3a] is released
> 
> OK, so my guess wasn't right.  We seem to call pci_release_dev for all of the
> devices that go away after unplug.
> 
> Do I think correctly that the below doesn't happen with the Yinghai's commit
> reverted?
> 
> > Plug:
> > 
> > Jan 31 20:06:11 buildroot kern.debug kernel: [  453.609684] acpiphp_glue: hotplug_event: Bus check notify on \_SB_.PCI0.RP05
> > Jan 31 20:06:11 buildroot kern.debug kernel: [  453.611339] acpiphp_glue: hotplug_event: re-enumerating slots under \_SB_.PCI0.RP05
> > Jan 31 20:06:11 buildroot kern.debug kernel: [  453.614625] pci 0000:02:00.0: scanning [bus 03-3a] behind bridge, pass 0
> > Jan 31 20:06:11 buildroot kern.warn kernel: [  453.616434] ------------[ cut here ]------------
> > Jan 31 20:06:11 buildroot kern.warn kernel: [  453.618102] WARNING: CPU: 1 PID: 956 at lib/kobject.c:244 kobject_add_internal+0x12d/0x400()
> > Jan 31 20:06:11 buildroot kern.warn kernel: [  453.619797] kobject_add_internal failed for pci_bus (error: -2 parent: 0000:02:00.0)
> 
> create_dir() fails here and that's not because it already exists.
> Interesting.

That's more interesting than I thought.

So the error is -2, which is -ENOENT.  Let's see when create_dir() returns -ENOENT,
then.

Evidently, it calls sysfs_create_dir_ns() and returns the error code returned by
that, but if it is 0, it returns the return value of populate_dir().

sysfs_create_dir_ns() tries to use kobj->parent->sd and returns -ENOENT when
that is NULL.  There you go.  So it looks like the sysfs dir of PCI device
0000:02:00.0 doesn't exist at this point.

Yinghai, any ideas?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
