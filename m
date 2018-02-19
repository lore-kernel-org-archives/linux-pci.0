Return-Path: <SRS0=+pYx=FN=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=+pYx=FN=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, George Cherian <gcherian@caviumnetworks.com>, George Cherian <george.cherian@cavium.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, Jayachandran.Nair@cavium.com, Robert.Richter@cavium.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Date: Mon, 19 Feb 2018 12:21:56 +0100
Message-ID: <2858019.9TUCWsDpTB@aspire.rjw.lan>
In-Reply-To: <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com> <2323301.ORZpb3hFRe@aspire.rjw.lan> <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, February 16, 2018 9:34:34 PM CET Bjorn Helgaas wrote:
> On Fri, Feb 16, 2018 at 01:40:37PM +0100, Rafael J. Wysocki wrote:
> > On Friday, February 16, 2018 12:39:00 AM CET Bjorn Helgaas wrote:
> > > On Thu, Feb 15, 2018 at 10:57:25PM +0100, Rafael J. Wysocki wrote:
> > > > On Wednesday, February 14, 2018 9:16:53 PM CET Bjorn Helgaas wrote:
> > > > > On Wed, Feb 14, 2018 at 04:58:08PM +0530, George Cherian wrote:
> > > > > > On 02/13/2018 08:39 PM, Bjorn Helgaas wrote:
> > > > > > >On Fri, Feb 02, 2018 at 07:00:46AM +0000, George Cherian wrote:
> 
> <snip>
> > > > > > >>[   12.775202] Unhandled fault: synchronous external abort (0x96000610) at 0x0000000000000000
> > > > > 
> > > > > > >>[   12.813518] PC is at pci_generic_config_read+0x5c/0xf0
> > > > > > >>[   12.818643] LR is at pci_generic_config_read+0x48/0xf0
> > > > > > >> ...
> > > > > > >>[   13.269819] [<ffff000008506f34>] pci_generic_config_read+0x5c/0xf0
> > > > > > >>[   13.275987] [<ffff000008506e2c>] pci_bus_read_config_dword+0xb4/0xd8
> > > > > > >>[   13.282328] [<ffff0000085089f4>] pcie_capability_read_dword+0x64/0xb8
> > > > > > >>[   13.288757] [<ffff000008513d28>] __pci_dev_reset+0x90/0x328
> > > > > > >>[   13.294317] [<ffff0000085142d4>] pci_probe_reset_function+0x24/0x30
> > > > > > >>[   13.300571] [<ffff000008518754>] pci_create_sysfs_dev_files+0x18c/0x2a0
> > > > > > >>[   13.307173] [<ffff000008d9a974>] pci_sysfs_init+0x38/0x60
> > > > > > >>[   13.312560] [<ffff000008083b4c>] do_one_initcall+0x5c/0x170
> > > > > > >>[   13.318122] [<ffff000008d60dfc>] kernel_init_freeable+0x1c0/0x27c
> > > > > > >>[   13.324205] [<ffff000008980d90>] kernel_init+0x18/0x110
> > > > > > >>[   13.329416] [<ffff000008083690>] ret_from_fork+0x10/0x40
> > > > > 
> > > > > I should have asked this before: why are we even trying to do this
> > > > > config read to a device that's in D3?  I assume this root port started
> > > > > out in D0 because we apparently enumerated it successfully, but it
> > > > > must have been put into D3 later?
> > > > > 
> > > > > The pci_probe_reset_function() function comment says "the PCI device
> > > > > must be responsive to PCI config space in order to use this function." 
> > > > > So apparently the caller should make sure the device is in at least
> > > > > D3hot and any bridges leading to it are in D0.
> > > > > 
> > > > > If we're missing whatever it is that makes sure the target device is
> > > > > reachable and responsive to config space, we likely have issues on
> > > > > other systems as well.  On Cavium this causes the external abort, but
> > > > > on other systems, we'd probably just get all 1's data back from the
> > > > > config read and silently do the wrong thing in
> > > > > pci_probe_reset_function().
> > > > > 
> > > > > I don't know how this runtime PM works, but maybe Rafael can help us
> > > > > out.
> > > > 
> > > > I'm not sure what the question is to be honest.
> > > 
> > > My questions are basically "What does the PCI core need to do to make
> > > sure a device is in D0 before it operates on it?  And where do we need
> > > to do that?"
> > > 
> > > > Unused ports are autosuspended after 100ms as per pcie_portdrv_probe().
> > > 
> > > So I guess this is only done for PCIe bridges, not for conventional
> > > PCI bridges.  Is this because autosuspend depends on a PCIe-only
> > > feature?
> > 
> > Yes, that's PCIe-only.
> 
> What PCIe feature does this depend on?

It doesn't depend on any PCIe feature in particular, but we don't need to do it
for PCI-to-PCI bridges in general.

> I see the PCIe test in pci_bridge_d3_possible(), added by 9d26d3a8f1b0
> ("PCI: Put PCIe ports into D3 during suspend"), but unfortunately that
> commit doesn't say *why* we only do this for PCIe, or only for BIOS
> dates of 2015 or newer.

The reason why we need this is related to deep low-power states on new
SoCs that only can be entered if PCIe root ports are in D3 (that is, if the
root ports are not in D3, the whole SoC cannot enter some of its deep
low-power states and that may exted to package C-states for processors).

That also is the reason why we do it for PCIe only.

The reason for the cut-off date is because we know it for a fact that PCIe
port PM doesn't work on some older platforms due to hardware issues and,
again, it only really needs to be done on recent SoCs.

I believe that all of the above was mentioned during discussions on the patches
that ended up as commit 9d26d3a8f1b0 and so on.

> > > Here's the path we're in now:
> > > 
> > >   pcie_portdrv_init                        # device_initcall (level 6)
> > >     pci_register_driver(&pcie_portdriver)
> > >       ...
> > >         pcie_portdrv_probe                 # pcie_portdriver.probe
> > >           pm_runtime_set_autosuspend_delay(&dev->dev, 100)
> > > 
> > >   pci_sysfs_init                           # late_initcall (level 7)
> > >     for_each_pci_dev(dev)
> > >       pci_create_sysfs_dev_files(dev)
> > >         pci_create_capabilities_sysfs(dev)
> > >           pci_probe_reset_function(dev)
> > >             ...
> > >               pcie_capability_read_dword   <-- config read causing abort
> > > 
> > > I guess it's conceivable that more than 100ms elapsed between
> > > pcie_portdrv_probe() and pci_probe_reset_function(), and obviously we
> > > can't depend on any particular timing.
> > 
> > Right.
> 
> George, can you find out which specific devices are involved here?
> 
> My working assumption is that as for_each_pci_dev() iterates through
> all the devices, we call pci_probe_reset_function() for a root port
> that happens to be in D3hot (this should work fine because the root
> port's config space should be accessible), then we call
> pci_probe_reset_function() for a device *below* the root port.  That
> doesn't work because the root port's link is down and and devices
> below it are not accessible.  The root port should treat this as an
> Unsupported Request.
> 
> > > > Now, it looks like they should be resumed in the code path in question,
> > > > so this case seems to have been overlooked.
> > > 
> > > How do we identify which code paths need to resume the device, and
> > > what do we need to do to resume it?
> > 
> > The "suspended" metastate is generally defined as "the device may not be
> > accessible now" and for the majority of bus types it is unsafe to attempt
> > to access suspended devices.
> > 
> > That's not strictly the case for PCI, but IMO PCI devices should be resumed
> > before accessing them too because of the below. :-)
> > 
> > pm_runtime_get_sync() resumes the device and prevents it from suspending
> > again until pm_runtime_put() (or equivalent) is called on it.
> 
> How do we identify the places that need to call pm_runtime_get_sync()?
> 
> PCI devices will respond to config accesses while in D3hot, but not to
> memory or I/O accesses.  I think that distinction is probably too
> detailed and the general rule should be "the device must be in D0
> before you access it."

Right, but in some cases we access config spaces for things like PME
status changes and similar (and AML may be accessing them too for similar
reasons) and if the request is dropped on the floor silently then, well,
so be it.

> I guess generally the driver is in control, and if it suspends the
> device, it has to be smart enough to resume it before touching it.

Not necessarily.

Say, user space may want to access it too via the bus type's sysfs.

That's why we have pci_config_pm_runtime_get(), for instance.

> This particular pci_probe_reset_function() case is a problem because
> it's the PCI *core* doing the access while the device may already be
> claimed by a driver.  I think it's generally taboo for the core to do
> this, and I have a patch to move this access so it happens before a
> driver can claim the device.

The core may do accesses like that IMO (especially reads, not writes), but
indeed this particular case looks a bit over the top.

> We also have the case where userspace accesses a device via sysfs.  I
> guess all those cases probably need to wake up the device.  It looks
> like pci_config_pm_runtime_get() already does that for config
> accesses.

Right.

> But I think other entry points, e.g., the following, should have the
> same problem and I don't see anything there:
> 
>   pci_read_legacy_io()
>   pci_write_legacy_io()
>   pci_mmap_legacy_mem()
>   pci_mmap_legacy_io()
>   pci_mmap_resource()
>   pci_resource_io()
>   pci_read_rom()
>   reset_store()
> 
> Plus probably the ASPM control files, VPD, maybe others?

Generally speaking, every code path going directly to the config space
(below the driver) needs to take the possibility that the device may be in
D3cold into account.

Whether or not this means resuming the device upfront depends on the purpose
of the access I think.
