Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57247 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932424AbaAaNfA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 08:35:00 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release resources in pci_release_dev()) broke TBT hotplug
Date: Fri, 31 Jan 2014 14:49:21 +0100
Message-ID: <1426729.BFFFkbZrqa@vostro.rjw.lan>
In-Reply-To: <20140131123606.GF18029@intel.com>
References: <20140130131236.GW18029@intel.com> <1418039.AWHqDGWMFa@vostro.rjw.lan> <20140131123606.GF18029@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, January 31, 2014 02:36:07 PM Mika Westerberg wrote:
> On Fri, Jan 31, 2014 at 12:52:43PM +0100, Rafael J. Wysocki wrote:
> > So I think what happens is that we leak the struct pci_dev during removal and
> > the proper cleanup is never done.
> > 
> > Can you please add a debug printk into pci_release_dev() and see if that's
> > ever called after TBT unplug?
> 
> OK, I added the debug print (still on top of your two patches) and was able
> to capture a bit more from /var/log/messages before it crashes. Here's the
> log. I added dev_info(dev, "RELEASE\n") to pci_release_dev().
> 
> Unplug:
> 
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.557920] pcieport 0000:06:03.0: PME# disabled
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.559483] pcieport 0000:05:00.0: PME# disabled
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.561074] pci 0000:07:00.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.562536] pci_bus 0000:07: busn_res: [bus 07] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.563993] pci 0000:06:03.0: RELEASE
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.570345] pci 0000:0a:00.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.571734] pci_bus 0000:0a: busn_res: [bus 0a] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.573154] pci 0000:09:00.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.574528] pci_bus 0000:09: busn_res: [bus 09-2e] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.575939] pci 0000:08:00.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.577316] pci_bus 0000:08: busn_res: [bus 08-2e] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.578721] pci 0000:06:04.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.580081] pci_bus 0000:2f: busn_res: [bus 2f] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.581487] pci 0000:06:05.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.582873] pci_bus 0000:06: busn_res: [bus 06-2f] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.584322] pci 0000:05:00.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.585727] pcieport 0000:03:00.0: PME# disabled
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.587225] pci_bus 0000:04: busn_res: [bus 04] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.588723] pci 0000:03:00.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.660389] pci_bus 0000:05: busn_res: [bus 05-2f] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.661993] pci 0000:03:03.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.663527] pci_bus 0000:30: busn_res: [bus 30-38] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.665103] pci 0000:03:04.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.666641] pci_bus 0000:39: busn_res: [bus 39] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.668210] pci 0000:03:05.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.669764] pci_bus 0000:3a: busn_res: [bus 3a] is released
> Jan 31 20:05:57 buildroot kern.info kernel: [  439.671350] pci 0000:03:06.0: RELEASE
> Jan 31 20:05:57 buildroot kern.debug kernel: [  439.672933] pci_bus 0000:03: busn_res: [bus 03-3a] is released

OK, so my guess wasn't right.  We seem to call pci_release_dev for all of the
devices that go away after unplug.

Do I think correctly that the below doesn't happen with the Yinghai's commit
reverted?

> Plug:
> 
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.609684] acpiphp_glue: hotplug_event: Bus check notify on \_SB_.PCI0.RP05
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.611339] acpiphp_glue: hotplug_event: re-enumerating slots under \_SB_.PCI0.RP05
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.614625] pci 0000:02:00.0: scanning [bus 03-3a] behind bridge, pass 0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.616434] ------------[ cut here ]------------
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.618102] WARNING: CPU: 1 PID: 956 at lib/kobject.c:244 kobject_add_internal+0x12d/0x400()
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.619797] kobject_add_internal failed for pci_bus (error: -2 parent: 0000:02:00.0)

create_dir() fails here and that's not because it already exists.
Interesting.

> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.621491] Modules linked in:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.623191] CPU: 1 PID: 956 Comm: kworker/u8:5 Not tainted 3.13.0+ #156
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.624912] Hardware name:                  /D33217CK, BIOS GKPPT10H.86A.0042.2013.0422.1439 04/22/2013
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.626649] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.628395]  0000000000000009 ffff88006de4d9f8 ffffffff818129e3 ffff88006de4da40
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.630164]  ffff88006de4da30 ffffffff81047228 ffff88006dfd1000 00000000fffffffe
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.631933]  ffff88006de140a8 ffff88006d582918 ffff88006d582918 ffff88006de4da90
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.633691] Call Trace:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.635428]  [<ffffffff818129e3>] dump_stack+0x45/0x56
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.637138]  [<ffffffff81047228>] warn_slowpath_common+0x78/0xa0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.638879]  [<ffffffff81047297>] warn_slowpath_fmt+0x47/0x50
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.640579]  [<ffffffff812d81ad>] kobject_add_internal+0x12d/0x400
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.642297]  [<ffffffff812d88b5>] kobject_add+0x65/0xb0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.643986]  [<ffffffff81141852>] ? kmem_cache_alloc_trace+0xe2/0x130
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.645694]  [<ffffffff81455584>] get_device_parent+0x174/0x1e0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.647377]  [<ffffffff81455a33>] device_add+0xe3/0x610
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.649062]  [<ffffffff81460ac4>] ? device_pm_sleep_init+0x44/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.650729]  [<ffffffff81455f75>] device_register+0x15/0x20
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.652409]  [<ffffffff8180c1a7>] pci_add_new_bus+0x167/0x3e0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.654064]  [<ffffffff81303057>] ? pci_find_next_bus+0x47/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.655724]  [<ffffffff812fc692>] pci_scan_bridge+0x5c2/0x630
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.657372]  [<ffffffff812fb9dd>] ? pci_scan_slot+0x10d/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.659057]  [<ffffffff8180d116>] enable_slot+0xb6/0x320
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.660703]  [<ffffffff812fa273>] ? pci_bus_read_dev_vendor_id+0x23/0xe0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.662387]  [<ffffffff81315814>] ? trim_stale_devices+0xc4/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.664049]  [<ffffffff81315cf8>] acpiphp_check_bridge.part.9+0xe8/0x100
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.665746]  [<ffffffff81316685>] hotplug_event+0x105/0x260
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.667417]  [<ffffffff8131680a>] hotplug_event_work+0x2a/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.669118]  [<ffffffff8132fc09>] acpi_hotplug_work_fn+0x17/0x22
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.670816]  [<ffffffff8106128a>] process_one_work+0x17a/0x440
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.672537]  [<ffffffff81061e89>] worker_thread+0x119/0x390
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.674239]  [<ffffffff81061d70>] ? manage_workers.isra.25+0x2a0/0x2a0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.675976]  [<ffffffff81067dfd>] kthread+0xcd/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.677689]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.679446]  [<ffffffff81823a3c>] ret_from_fork+0x7c/0xb0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.681174]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.682942] ---[ end trace 84e80bde4d2086ef ]---
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.684679] ------------[ cut here ]------------
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.686450] WARNING: CPU: 1 PID: 956 at drivers/pci/probe.c:711 pci_add_new_bus+0x3db/0x3e0()

That's failing device_register(), probably because of the earlier sysfs issue.

> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.688245] Modules linked in:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.690032] CPU: 1 PID: 956 Comm: kworker/u8:5 Tainted: G        W    3.13.0+ #156
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.691883] Hardware name:                  /D33217CK, BIOS GKPPT10H.86A.0042.2013.0422.1439 04/22/2013
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.693703] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.695531]  0000000000000009 ffff88006de4db88 ffffffff818129e3 0000000000000000
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.697377]  ffff88006de4dbc0 ffffffff81047228 ffff88006d582800 ffff88006eac9000
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.699233]  ffff88006de14000 ffff88006de14000 ffff88006d582918 ffff88006de4dbd0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.701114] Call Trace:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.702989]  [<ffffffff818129e3>] dump_stack+0x45/0x56
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.704871]  [<ffffffff81047228>] warn_slowpath_common+0x78/0xa0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.706767]  [<ffffffff81047305>] warn_slowpath_null+0x15/0x20
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.708637]  [<ffffffff8180c41b>] pci_add_new_bus+0x3db/0x3e0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.710518]  [<ffffffff81303057>] ? pci_find_next_bus+0x47/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.712381]  [<ffffffff812fc692>] pci_scan_bridge+0x5c2/0x630
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.714258]  [<ffffffff812fb9dd>] ? pci_scan_slot+0x10d/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.716109]  [<ffffffff8180d116>] enable_slot+0xb6/0x320
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.717973]  [<ffffffff812fa273>] ? pci_bus_read_dev_vendor_id+0x23/0xe0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.719824]  [<ffffffff81315814>] ? trim_stale_devices+0xc4/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.721685]  [<ffffffff81315cf8>] acpiphp_check_bridge.part.9+0xe8/0x100
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.723527]  [<ffffffff81316685>] hotplug_event+0x105/0x260
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.725378]  [<ffffffff8131680a>] hotplug_event_work+0x2a/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.727195]  [<ffffffff8132fc09>] acpi_hotplug_work_fn+0x17/0x22
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.729016]  [<ffffffff8106128a>] process_one_work+0x17a/0x440
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.730815]  [<ffffffff81061e89>] worker_thread+0x119/0x390
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.732622]  [<ffffffff81061d70>] ? manage_workers.isra.25+0x2a0/0x2a0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.734403]  [<ffffffff81067dfd>] kthread+0xcd/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.736193]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.737962]  [<ffffffff81823a3c>] ret_from_fork+0x7c/0xb0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.739730]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.741471] ---[ end trace 84e80bde4d2086f0 ]---
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.743215] pci_bus 0000:03: scanning bus
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.744993] pci 0000:03:00.0: [8086:1548] type 01 class 0x060400
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.746859] pci 0000:03:00.0: calling pci_fixup_transparent_bridge+0x0/0x30
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.748767] pci 0000:03:00.0: supports D1 D2
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.750433] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.752141] pci 0000:03:00.0: PME# disabled
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.753848] ------------[ cut here ]------------
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.755500] WARNING: CPU: 1 PID: 956 at lib/kobject.c:244 kobject_add_internal+0x12d/0x400()
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.757195] kobject_add_internal failed for 0000:03:00.0 (error: -2 parent: 0000:02:00.0)

And here it repeats for the next device and so on.

> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.758885] Modules linked in:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.760589] CPU: 1 PID: 956 Comm: kworker/u8:5 Tainted: G        W    3.13.0+ #156
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.762328] Hardware name:                  /D33217CK, BIOS GKPPT10H.86A.0042.2013.0422.1439 04/22/2013
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.764082] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.765862]  0000000000000009 ffff88006de4d9c0 ffffffff818129e3 ffff88006de4da08
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.767661]  ffff88006de4d9f8 ffffffff81047228 ffff88006de170a8 00000000fffffffe
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.769476]  ffff88006de140a8 ffff88006de17098 ffff88006eac9000 ffff88006de4da58
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.771289] Call Trace:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.773091]  [<ffffffff818129e3>] dump_stack+0x45/0x56
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.774886]  [<ffffffff81047228>] warn_slowpath_common+0x78/0xa0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.776712]  [<ffffffff81047297>] warn_slowpath_fmt+0x47/0x50
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.778510]  [<ffffffff812d81ad>] kobject_add_internal+0x12d/0x400
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.780332]  [<ffffffff8163ea05>] ? pci_conf1_read+0xb5/0x110
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.782134]  [<ffffffff812d88b5>] kobject_add+0x65/0xb0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.783959]  [<ffffffff814558fe>] ? device_private_init+0x1e/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.785760]  [<ffffffff81455a61>] device_add+0x111/0x610
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.787573]  [<ffffffff812fb89d>] pci_device_add+0x10d/0x140
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.789362]  [<ffffffff8180c011>] pci_scan_single_device+0x91/0xc0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.791171]  [<ffffffff812fb919>] pci_scan_slot+0x49/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.792958]  [<ffffffff812fc73d>] pci_scan_child_bus+0x3d/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.794759]  [<ffffffff812fc53b>] pci_scan_bridge+0x46b/0x630
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.796535]  [<ffffffff812fb9dd>] ? pci_scan_slot+0x10d/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.798329]  [<ffffffff8180d116>] enable_slot+0xb6/0x320
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.800097]  [<ffffffff812fa273>] ? pci_bus_read_dev_vendor_id+0x23/0xe0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.801896]  [<ffffffff81315814>] ? trim_stale_devices+0xc4/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.803671]  [<ffffffff81315cf8>] acpiphp_check_bridge.part.9+0xe8/0x100
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.805471]  [<ffffffff81316685>] hotplug_event+0x105/0x260
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.807246]  [<ffffffff8131680a>] hotplug_event_work+0x2a/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.809033]  [<ffffffff8132fc09>] acpi_hotplug_work_fn+0x17/0x22
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.810801]  [<ffffffff8106128a>] process_one_work+0x17a/0x440
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.812573]  [<ffffffff81061e89>] worker_thread+0x119/0x390
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.814307]  [<ffffffff81061d70>] ? manage_workers.isra.25+0x2a0/0x2a0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.816053]  [<ffffffff81067dfd>] kthread+0xcd/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.817755]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.819467]  [<ffffffff81823a3c>] ret_from_fork+0x7c/0xb0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.821144]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.822829] ---[ end trace 84e80bde4d2086f1 ]---
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.824500] ------------[ cut here ]------------
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.826182] WARNING: CPU: 1 PID: 956 at drivers/pci/probe.c:1397 pci_device_add+0x13c/0x140()
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.827872] Modules linked in:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.829572] CPU: 1 PID: 956 Comm: kworker/u8:5 Tainted: G        W    3.13.0+ #156
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.831314] Hardware name:                  /D33217CK, BIOS GKPPT10H.86A.0042.2013.0422.1439 04/22/2013
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.833072] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.834845]  0000000000000009 ffff88006de4db10 ffffffff818129e3 0000000000000000
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.836648]  ffff88006de4db48 ffffffff81047228 ffff88006de17000 ffff88006d582828
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.838466]  ffff88006de17098 0000000000000000 ffff88006eac9000 ffff88006de4db58
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.840280] Call Trace:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.842081]  [<ffffffff818129e3>] dump_stack+0x45/0x56
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.843877]  [<ffffffff81047228>] warn_slowpath_common+0x78/0xa0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.845694]  [<ffffffff81047305>] warn_slowpath_null+0x15/0x20
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.847482]  [<ffffffff812fb8cc>] pci_device_add+0x13c/0x140
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.849290]  [<ffffffff8180c011>] pci_scan_single_device+0x91/0xc0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.851090]  [<ffffffff812fb919>] pci_scan_slot+0x49/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.852897]  [<ffffffff812fc73d>] pci_scan_child_bus+0x3d/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.854674]  [<ffffffff812fc53b>] pci_scan_bridge+0x46b/0x630
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.856470]  [<ffffffff812fb9dd>] ? pci_scan_slot+0x10d/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.858251]  [<ffffffff8180d116>] enable_slot+0xb6/0x320
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.860044]  [<ffffffff812fa273>] ? pci_bus_read_dev_vendor_id+0x23/0xe0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.861819]  [<ffffffff81315814>] ? trim_stale_devices+0xc4/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.863612]  [<ffffffff81315cf8>] acpiphp_check_bridge.part.9+0xe8/0x100
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.865389]  [<ffffffff81316685>] hotplug_event+0x105/0x260
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.867187]  [<ffffffff8131680a>] hotplug_event_work+0x2a/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.868956]  [<ffffffff8132fc09>] acpi_hotplug_work_fn+0x17/0x22
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.870739]  [<ffffffff8106128a>] process_one_work+0x17a/0x440
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.872493]  [<ffffffff81061e89>] worker_thread+0x119/0x390
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.874268]  [<ffffffff81061d70>] ? manage_workers.isra.25+0x2a0/0x2a0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.876024]  [<ffffffff81067dfd>] kthread+0xcd/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.877794]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.879532]  [<ffffffff81823a3c>] ret_from_fork+0x7c/0xb0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.881273]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.882984] ---[ end trace 84e80bde4d2086f2 ]---
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.884782] pci 0000:03:03.0: [8086:1548] type 01 class 0x060400
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.886627] pci 0000:03:03.0: calling pci_fixup_transparent_bridge+0x0/0x30
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.888494] pci 0000:03:03.0: supports D1 D2
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.890141] pci 0000:03:03.0: PME# supported from D0 D1 D2 D3hot D3cold
> Jan 31 20:06:11 buildroot kern.debug kernel: [  453.891805] pci 0000:03:03.0: PME# disabled
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.893490] ------------[ cut here ]------------
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.895118] WARNING: CPU: 3 PID: 956 at lib/kobject.c:244 kobject_add_internal+0x12d/0x400()
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.896778] kobject_add_internal failed for 0000:03:03.0 (error: -2 parent: 0000:02:00.0)
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.898453] Modules linked in:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.900135] CPU: 3 PID: 956 Comm: kworker/u8:5 Tainted: G        W    3.13.0+ #156
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.901841] Hardware name:                  /D33217CK, BIOS GKPPT10H.86A.0042.2013.0422.1439 04/22/2013
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.903569] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.905310]  0000000000000009 ffff88006de4d9c0 ffffffff818129e3 ffff88006de4da08
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.907080]  ffff88006de4d9f8 ffffffff81047228 ffff88006d6260a8 00000000fffffffe
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.908866]  ffff88006de140a8 ffff88006d626098 ffff88006eac9000 ffff88006de4da58
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.910654] Call Trace:
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.912412]  [<ffffffff818129e3>] dump_stack+0x45/0x56
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.914189]  [<ffffffff81047228>] warn_slowpath_common+0x78/0xa0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.915980]  [<ffffffff81047297>] warn_slowpath_fmt+0x47/0x50
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.917764]  [<ffffffff812d81ad>] kobject_add_internal+0x12d/0x400
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.919557]  [<ffffffff8164189e>] ? raw_pci_read+0x1e/0x40
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.921344]  [<ffffffff812d88b5>] kobject_add+0x65/0xb0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.923127]  [<ffffffff814558fe>] ? device_private_init+0x1e/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.924910]  [<ffffffff81455a61>] device_add+0x111/0x610
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.926683]  [<ffffffff812fb89d>] pci_device_add+0x10d/0x140
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.928453]  [<ffffffff8180c011>] pci_scan_single_device+0x91/0xc0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.930234]  [<ffffffff812fb919>] pci_scan_slot+0x49/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.932004]  [<ffffffff812fc73d>] pci_scan_child_bus+0x3d/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.933773]  [<ffffffff812fc53b>] pci_scan_bridge+0x46b/0x630
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.935636]  [<ffffffff812fb9dd>] ? pci_scan_slot+0x10d/0x150
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.937399]  [<ffffffff8180d116>] enable_slot+0xb6/0x320
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.939148]  [<ffffffff812fa273>] ? pci_bus_read_dev_vendor_id+0x23/0xe0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.940901]  [<ffffffff81315814>] ? trim_stale_devices+0xc4/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.942659]  [<ffffffff81315cf8>] acpiphp_check_bridge.part.9+0xe8/0x100
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.944419]  [<ffffffff81316685>] hotplug_event+0x105/0x260
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.946166]  [<ffffffff8131680a>] hotplug_event_work+0x2a/0x70
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.947917]  [<ffffffff8132fc09>] acpi_hotplug_work_fn+0x17/0x22
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.949648]  [<ffffffff8106128a>] process_one_work+0x17a/0x440
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.951366]  [<ffffffff81061e89>] worker_thread+0x119/0x390
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.953070]  [<ffffffff81061d70>] ? manage_workers.isra.25+0x2a0/0x2a0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.954764]  [<ffffffff81067dfd>] kthread+0xcd/0xf0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.956425]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.958084]  [<ffffffff81823a3c>] ret_from_fork+0x7c/0xb0
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.959727]  [<ffffffff81067d30>] ? kthread_create_on_node+0x180/0x180
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.961378] ---[ end trace 84e80bde4d2086f3 ]---
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.963016] ------------[ cut here ]------------
> Jan 31 20:06:11 buildroot kern.warn kernel: [  453.964646] WARNING: CPU: 3 PID: 956 at drivers/pci/probe.c:1397 pci_device_add+0x13c/0x140()
> 
> and then it crashes.
> 
> The PCI tree looks like:
> 
> 00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller (rev 09)
> 00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09)
> 00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series Chipset Family MEI Controller #1 (rev 04)
> 00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #2 (rev 04)
> 00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)
> 00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 1 (rev c4)
> 00:1c.4 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 5 (rev c4)
> 00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #1 (rev 04)
> 00:1f.0 ISA bridge: Intel Corporation QS77 Express Chipset LPC Controller (rev 04)
> 00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04)
> 00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SMBus Controller (rev 04)
> 02:00.0 PCI bridge: Intel Corporation Device 1548 (rev 03)
> 03:00.0 PCI bridge: Intel Corporation Device 1548 (rev 03)
> 03:03.0 PCI bridge: Intel Corporation Device 1548 (rev 03)
> 03:04.0 PCI bridge: Intel Corporation Device 1548 (rev 03)
> 03:05.0 PCI bridge: Intel Corporation Device 1548 (rev 03)
> 03:06.0 PCI bridge: Intel Corporation Device 1548 (rev 03)
> 05:00.0 PCI bridge: Intel Corporation Device 1513
> 06:03.0 PCI bridge: Intel Corporation Device 1513
> 06:04.0 PCI bridge: Intel Corporation Device 1513
> 06:05.0 PCI bridge: Intel Corporation Device 1513
> 07:00.0 SATA controller: Marvell Technology Group Ltd. Device 9182 (rev 11)
> 08:00.0 PCI bridge: Intel Corporation DSL3510 Thunderbolt Controller [Cactus Ridge]
> 09:00.0 PCI bridge: Intel Corporation DSL3510 Thunderbolt Controller [Cactus Ridge]
> 0a:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM57762 Gigabit Ethernet PCIe

Can you please check how the PCI sysfs directory structure changes after unplug
with the Yinghai's commit present and reverted and what the difference is?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
