Return-Path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150324172702.GC2495@google.com>
References: <OF77E25ED8.9CA80CE3-ON85257E12.004F7B31-85257E12.0053B9A0@gdeb.com> <20150324152806.GD14418@l.oracle.com> <20150324172702.GC2495@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jayson A Dyke <jdyke@gdeb.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	michael.d.labriola@gmail.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Stuart Wehrly <swehrly@gdeb.com>,
	xen-devel@lists.xenproject.org
MIME-Version: 1.0
Subject: Re: [Xen-devel] 3.18 xen-pcifront regression?
Message-ID: <OF3F22FEC8.8B4BEFD3-ON85257E12.007A8088-85257E12.007B5FAC@gdeb.com>
From: Michael D Labriola <mlabriol@gdeb.com>
Date: Tue, 24 Mar 2015 18:27:33 -0400
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas@google.com> wrote on 03/24/2015 01:27:02 PM:

> From: Bjorn Helgaas <bhelgaas@google.com>
> To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
> Cc: Michael D Labriola <mlabriol@gdeb.com>, xen-
> devel@lists.xenproject.org, Stuart Wehrly <swehrly@gdeb.com>, 
> michael.d.labriola@gmail.com, Jayson A Dyke <jdyke@gdeb.com>, "Rafael 
> J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org, linux-
> acpi@vger.kernel.org
> Date: 03/24/2015 01:29 PM
> Subject: Re: [Xen-devel] 3.18 xen-pcifront regression?
> 
> [+cc Rafael, linux-pci, linux-acpi]
> 
> On Tue, Mar 24, 2015 at 11:28:06AM -0400, Konrad Rzeszutek Wilk wrote:
> > On Tue, Mar 24, 2015 at 11:14:29AM -0400, Michael D Labriola wrote:
> > > I'm having problems booting a 3.18 or newer domU w/ PCI devices 
passed 
> > > through.  It only seems to be the domU kernel that's upset (i.e., 
Behavior 
> > > is identical whether I'm running 3.19 or 3.13 dom0).  I'm running a 
32bit 
> > > dom0 (3.13.11) w/ 64bit 4.4.0 hypervisor and 32bit domU.  I get the 
> > > following Oops when trying to boot my domU with a couple PCI cards 
passed 
> > > through:
> > > 
> > > BUG: unable to handle kernel paging request at 0030303e
> > > IP: [<c06ed0e6>] acpi_ns_validate_handle+0x12/0x1a
> > > *pdpt = 00000000019f1027 *pde = 0000000000000000 
> > > Oops: 0000 [#1] PREEMPT SMP 
> > > Modules linked in: xen_pcifront(+) pcspkr xen_blkfront loop
> > > CPU: 0 PID: 18 Comm: xenwatch Not tainted 3.17.0-test+ #6
> > > task: cb869950 ti: cb8ae000 task.ti: cb8ae000
> > > EIP: 0061:[<c06ed0e6>] EFLAGS: 00010246 CPU: 0
> > > EIP is at acpi_ns_validate_handle+0x12/0x1a
> > > EAX: 00000000 EBX: cb895dc0 ECX: 00000000 EDX: 0030303a
> > > ESI: c0a6bccd EDI: 00000000 EBP: 00000004 ESP: cb8afd00
> > >  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0069
> > > CR0: 8005003b CR2: 0030303e CR3: 0a68e000 CR4: 00040660
> > > Stack:
> > >  c06eda4d 00000000 c096a21d 00000000 00000000 00006462 00000000 
c0c102c0
> > >  0030303a 00040004 0030303a cb8afd94 cb8afdec cb8afd60 c06b78e1 
cb8afd60
> > >  00000061 00000246 c0407bc7 c0c102c0 00000000 cb8afda0 cb8afda8 
cb8afdb0
> > > Call Trace:
> > >  [<c06eda4d>] ? acpi_evaluate_object+0x31/0x1fc
> > 
> > We should not be calling in any acpi code in PV domU guests.
> > 
> > WE actually disable it (acpi=0) to make sure we don't call it - as
> > there is no ACPI AML data at all in the guest.
> > 
> > CC-ing Bjorn.
> > >  [<c096a21d>] ? resume_kernel+0x5/0x7
> > >  [<c06b78e1>] ? pci_get_hp_params+0x111/0x4e0
> > >  [<c0407bc7>] ? xen_force_evtchn_callback+0x17/0x30
> > >  [<c04085fb>] ? xen_restore_fl_direct_reloc+0x4/0x4
> > >  [<c0699d34>] ? pci_device_add+0x24/0x450
> > >  [<c06975ce>] ? pci_bus_read_config_word+0x6e/0x80
> > >  [<c069a66d>] ? pci_scan_single_device+0x8d/0xb0
> > >  [<c069a6cc>] ? pci_scan_slot+0x3c/0xf0
> > >  [<c069b1bc>] ? pci_scan_child_bus+0x1c/0x90
> > >  [<c069b71a>] ? pci_scan_bus_parented+0x6a/0x90
> > >  [<d088d241>] ? pcifront_scan_root+0x91/0x130 [xen_pcifront]
> > >  [<d088e69f>] ? pcifront_backend_changed+0x4af/0x654 [xen_pcifront]
> > >  [<c070dd0f>] ? xenbus_gather+0x5f/0x90
> > >  [<c070dd0f>] ? xenbus_gather+0x5f/0x90
> > >  [<c070c393>] ? xenbus_read_driver_state+0x33/0x50
> > >  [<c070f375>] ? xenbus_otherend_changed+0x95/0xa0
> > >  [<c0710a5f>] ? backend_changed+0xf/0x20
> > >  [<c070d712>] ? xenwatch_thread+0x72/0x110
> > >  [<c0486140>] ? bit_waitqueue+0x50/0x50
> > >  [<c070d6a0>] ? join+0x70/0x70
> > >  [<c046e59b>] ? kthread+0xab/0xd0
> > >  [<c096a1c1>] ? ret_from_kernel_thread+0x21/0x30
> > >  [<c046e4f0>] ? flush_kthread_worker+0xa0/0xa0
> > > Code: 03 10 00 00 eb 0e 46 83 c2 04 4b 85 db 75 b9 c6 02 00 31 c0 5b 
5e 5f 
> > > 5d c3 89 c2 8d 40 ff 83 f8 fd 76 06 a1 2c 32 c1 c0 c3 31 c0 <80> 7a 
04 0f 
> > > 0f 44 c2 c3 83 ec 10 83 f8 1d 76 24 89 44 24 0c c7
> > > EIP: [<c06ed0e6>] acpi_ns_validate_handle+0x12/0x1a SS:ESP 
0069:cb8afd00
> > > CR2: 000000000030303e
> > > ---[ end trace d4ddeb038cbcbdf7 ]---
> > > 
> > > 
> > > I've bisected down to the following commit in 3.18, which breaks my 
> > > system.
> > > 
> > > 6cd33649fa83d97ba7b66f1d871a360e867c5220 is the first bad commit
> > > commit 6cd33649fa83d97ba7b66f1d871a360e867c5220
> > > Author: Bjorn Helgaas <bhelgaas@google.com>
> > > Date:   Wed Aug 27 14:29:47 2014 -0600
> > > 
> > >     PCI: Add pci_configure_device() during enumeration
> > > 
> > >     Some platforms can tell the OS how to configure PCI devices, 
e.g., how 
> > > to
> > >     set cache line size, error reporting enables, etc.  ACPI defines 
_HPP 
> > > and
> > >     _HPX methods for this purpose.
> > > 
> > >     This configuration was previously done by some of the hotplug 
drivers 
> > > using
> > >     pci_configure_slot().  But not all hotplug drivers did this, and 
per 
> > > the
> > >     spec (ACPI rev 5.0, sec 6.2.7), we can also do it for "devices 
not
> > >     configured by the BIOS at system boot."
> > > 
> > >     Move this configuration into the PCI core by adding 
> > > pci_configure_device()
> > >     and calling it from pci_device_add(), so we do this for all 
devices as 
> > > we
> > >     enumerate them.
> > > 
> > >     This is based on pci_configure_slot(), which is used by hotplug 
> > > drivers.
> > >     I omitted:
> > > 
> > >       - pcie_bus_configure_settings() because it configures MPS and 
MRRS, 
> > > which
> > >         requires global knowledge of the fabric and must be done 
later, 
> > > and
> > > 
> > >       - configuration of subordinate devices; that will happen when 
we 
> > > call
> > >         pci_device_add() for those devices.
> > > 
> > >     Because pci_configure_slot() was only done by hotplug drivers, 
this 
> > > initial
> > >     version of pci_configure_device() only configures hot-added 
devices,
> > >     ignoring anything added during boot.
> > > 
> > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > >     Acked-by: Yinghai Lu <yinghai@kernel.org>
> > > 
> > > :040000 040000 4fadbe1e5f8f18daa6be7bdb7c9c1d6def0a2615 
> > > 9aef037aa35ca156ac46553f7fc4c5b1b3980c19 M      drivers
> > > 
> > > 
> > > I've reverted that commit on top of 3.19, which feels incredibly 
wrong, 
> > > but does fix the problem on my system.  This is a little over my 
head, 
> > > though...  ;-)
> > > 
> > > Thoughts?
> 
> Thanks for the report, Michael, and sorry for the inconvenience.  I 
think
> the patch below will fix it, but I don't think it's the right fix either
> because it seems a little ad hoc to sprinkle "acpi_pci_disabled" tests
> around like fairy dust.  I wonder if we can set things up so ACPI 
methods
> would fail gracefully like they do when ACPI is disabled at 
compile-time.
> 
> I can boot with "acpi=off" on qemu just fine, and when we look up the 
ACPI
> device handles, we just get NULL pointers, so everything works out even
> without a fix like the one below.

FYI, I'm not passing "acpi=off" on the guest's command line...  I believe 
it's getting turned off dynamically by the guest kernel.  I get the 
following in dmesg within the 1st dozen lines:

ACPI in unprivileged domain disabled

> 
> There must be something different about the way things get set up in 
that
> domU kernel.  I'll try to look into that some more, but I'm going on
> vacation for the next week, so if you learn anything before then, let me
> know.

I can confirm that your patch definitely fixes my problem.

If you need logs, kernel config, or someone to test patches, let me know.

> 
> Bjorn
> 
> 
> commit 6678b0fb6504c890481863b4916089b41e6042bf
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Mar 24 11:12:45 2015 -0500
> 
>     PCI: Don't look for ACPI hotplug parameters if ACPI is disabled
> 
>     In a kernel with CONFIG_ACPI=y, pci_get_hp_params() evaluates ACPI 
methods
>     (_HPX, _HPP, etc.) to learn how to configure devices.  If ACPI has 
been
>     disabled at runtime, e.g., with "acpi=off", this causes an oops 
because
>     there's no AML at all.
> 
>     Before 6cd33649fa83 ("PCI: Add pci_configure_device() during 
enumeration"),
>     we only used pci_get_hp_params() for hot-added devices, but after 
it, we
>     use it for all devices, so we're much more likely to see the oops.
> 
>     Don't bother looking for ACPI configuration information if ACPI has 
been
>     disabled.
> 
>     Fixes: 6cd33649fa83 ("PCI: Add pci_configure_device() during 
enumeration")
>     Reported-by: Michael D Labriola <mlabriol@gdeb.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org   # v3.18+
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 489063987325..c93fbe76d281 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -248,6 +248,9 @@ int pci_get_hp_params(struct pci_dev *dev, struct 
> hotplug_params *hpp)
>     acpi_handle handle, phandle;
>     struct pci_bus *pbus;
> 
> +   if (acpi_pci_disabled)
> +      return -ENODEV;
> +
>     handle = NULL;
>     for (pbus = dev->bus; pbus; pbus = pbus->parent) {
>        handle = acpi_pci_get_bridge_handle(pbus);

---
Michael D Labriola
Electric Boat
mlabriol@gdeb.com
401-848-8871 (desk)
401-848-8513 (lab)
401-316-9844 (cell)



<<<DO_NOT_REMOVE_AUTOMATIC_FOOTER_GOES_HERE>>>



