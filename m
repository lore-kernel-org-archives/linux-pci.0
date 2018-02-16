Return-Path: <SRS0=V5oD=FK=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=V5oD=FK=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, George Cherian <gcherian@caviumnetworks.com>, George Cherian <george.cherian@cavium.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, Jayachandran.Nair@cavium.com, Robert.Richter@cavium.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Date: Fri, 16 Feb 2018 13:40:37 +0100
Message-ID: <2323301.ORZpb3hFRe@aspire.rjw.lan>
In-Reply-To: <20180215233900.GA195653@bhelgaas-glaptop.roam.corp.google.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com> <26660034.hqiP3ND89J@aspire.rjw.lan> <20180215233900.GA195653@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Friday, February 16, 2018 12:39:00 AM CET Bjorn Helgaas wrote:
> On Thu, Feb 15, 2018 at 10:57:25PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, February 14, 2018 9:16:53 PM CET Bjorn Helgaas wrote:
> > > On Wed, Feb 14, 2018 at 04:58:08PM +0530, George Cherian wrote:
> > > > On 02/13/2018 08:39 PM, Bjorn Helgaas wrote:
> > > > >On Fri, Feb 02, 2018 at 07:00:46AM +0000, George Cherian wrote:
> > > > >>The PCIe Controller on Cavium ThunderX2 processors does not
> > > > >>respond to downstream CFG/ECFG cycles when root port is
> > > > >>in power management D3-hot state.
> > > > >
> > > > >I think you're talking about the CPU initiating a config cycle to
> > > > >a device below the root port, right?
> > > > Yes
> > >=20
> > > If a bridge, e.g., a Root Port in your case, is in D3hot, we should be
> > > able to access config space of the bridge itself, but the secondary
> > > bus will be in B2 or B3 and we won't be able to access config space
> > > for any devices below the bridge.  This is true for *all* bridges, not
> > > just this Cavium Root Port.
> >=20
> > Right.
> >=20
> > But AFAICS config space reads from devices that aren't there (which
> > effectively is what happens if the bridge is in D3hot) are at least
> > expected to return all ones.
>=20
> Yes.  AIUI, the PCIe spec doesn't actually *require* all ones in this
> case, but the sec 2.3.2 implementation note says hardware intended for
> use with software (like Linux) that assumes the all ones behavior
> should synthesize all ones.  So I'm speculating that this Cavium
> device is supposed to synthesize all ones, but does not.
>=20
> But from the discussion below, it sounds like this may have helped
> uncover a more serious Linux bug, i.e., we don't resume a device
> before trying to use it.
>=20
> > > The PCIe r4.0, sec 5.3.1, implementation note seems relevant:
> > >=20
> > >   When a Type 1 Function associated with a Switch/Root Port (a
> > >   "virtual bridge") is in a non-D0 power state, it will emulate the
> > >   behavior of a conventional PCI bridge in its handling of Memory,
> > >   I/O, and Configuration Requests and Completions. ...  All Type 1
> > >   Configuration Requests are terminated as Unsupported Requests, ...
> > >=20
> > > > >This erratum isn't published anywhere where we could include a URL,
> > > > >is it?
> > > > This erratum is available at support.cavium.com, You might need to
> > > > register to the website to get hold of a copy.
> > >=20
> > > That appears to require an NDA, so that doesn't work for me.  Can you
> > > just include the erratum text in the changelog?
> > >=20
> > > > >>In our tests the above mentioned errata causes the following cras=
h when
> > > > >>the downstream endpoint config space is accessed, while root port=
 is in
> > > > >>D3 state.
> > > > >>
> > > > >>[   12.775202] Unhandled fault: synchronous external abort (0x960=
00610) at 0x0000000000000000
> > > > >
> > > > >This looks like another example of not being able to deal with err=
or
> > > > >responses to PCIe events, for example, the whole mess with drivers
> > > > >checking whether the link is up before issuing a config access.
> > > > >
> > > > >In that sense, this looks like a band-aid that avoids the issue by
> > > > >preventing the use of D3, but doesn't fix the underlying problem. =
 If
> > > > >we *could* deal nicely with this error, maybe we could use D3 on t=
hese
> > > > >root ports.
> > > > >
> > > > >So I'm not convinced yet that this is actually a PCIe erratum.  Do=
es
> > > > >the hardware actually violate the PCIe spec, or is this just a pro=
blem
> > > > >with the kernel not knowing how to deal nicely with a PCIe error?
> > > > >
> > > > This is not an issue with the way kernel handles the PCIe error.
> > > >=20
> > > > >If you could include the erratum text and reference to the relevant
> > > > >section of the PCIe spec, that would be useful.
> > > > >
> > > > The relevant section of the PCIe Spec is the following Section 5.3
> > > > on wards (subsection  5.3.1.4.1)
> > > >=20
> > > > Configuration and Message requests are the only TLPs accepted by a
> > > > Function in the D3hot state. All other received Requests must be
> > > > handled as Unsupported Requests, and all received Completions may
> > > > optionally be handled as Unexpected Completions.
> > >=20
> > > This isn't exactly relevant because it says requests *other than*
> > > config and message requests must be handled as Unsupported Requests,
> > > and we're talking about a config request.  I think sec 5.3.1 is more
> > > to the point: the Root Port sees a Type 1 Configuration Request that
> > > would be forwarded to its secondary interface if the port were in D0,
> > > and that request should be terminated as an Unsupported Request.
> > >=20
> > > I think the question is how the Root Complex turns this Unsupported
> > > Request into some signal to the CPU.  The implementation note in 2.3.2
> > > might be relevant:
> > >=20
> > >   Some system configuration software depends on reading a data value
> > >   of all 1=E2=80=99s when a Configuration Read Request is terminated =
as an
> > >   Unsupported Request, particularly when probing to determine the
> > >   existence of a device in the system. A Root Complex intended for use
> > >   with software that depends on a read-data value of all 1=E2=80=99s =
must
> > >   synthesize this value when UR Completion Status is returned for a
> > >   Configuration Read Request.
> > >=20
> > > So maybe the erratum is that the RC was intended to synthesize all 1's
> > > but it doesn't?
> > >=20
> > > There are other cases that can result in Unsupported Request
> > > completions, so my fear is that this change will take care of one such
> > > case but leave others that will cause similar unhandled external
> > > aborts.
> > >=20
> > > > >>[   12.775202] Unhandled fault: synchronous external abort (0x960=
00610) at 0x0000000000000000
> > >=20
> > > > >>[   12.813518] PC is at pci_generic_config_read+0x5c/0xf0
> > > > >>[   12.818643] LR is at pci_generic_config_read+0x48/0xf0
> > > > >> ...
> > > > >>[   13.269819] [<ffff000008506f34>] pci_generic_config_read+0x5c/=
0xf0
> > > > >>[   13.275987] [<ffff000008506e2c>] pci_bus_read_config_dword+0xb=
4/0xd8
> > > > >>[   13.282328] [<ffff0000085089f4>] pcie_capability_read_dword+0x=
64/0xb8
> > > > >>[   13.288757] [<ffff000008513d28>] __pci_dev_reset+0x90/0x328
> > > > >>[   13.294317] [<ffff0000085142d4>] pci_probe_reset_function+0x24=
/0x30
> > > > >>[   13.300571] [<ffff000008518754>] pci_create_sysfs_dev_files+0x=
18c/0x2a0
> > > > >>[   13.307173] [<ffff000008d9a974>] pci_sysfs_init+0x38/0x60
> > > > >>[   13.312560] [<ffff000008083b4c>] do_one_initcall+0x5c/0x170
> > > > >>[   13.318122] [<ffff000008d60dfc>] kernel_init_freeable+0x1c0/0x=
27c
> > > > >>[   13.324205] [<ffff000008980d90>] kernel_init+0x18/0x110
> > > > >>[   13.329416] [<ffff000008083690>] ret_from_fork+0x10/0x40
> > >=20
> > > I should have asked this before: why are we even trying to do this
> > > config read to a device that's in D3?  I assume this root port started
> > > out in D0 because we apparently enumerated it successfully, but it
> > > must have been put into D3 later?
> > >=20
> > > The pci_probe_reset_function() function comment says "the PCI device
> > > must be responsive to PCI config space in order to use this function.=
"=20
> > > So apparently the caller should make sure the device is in at least
> > > D3hot and any bridges leading to it are in D0.
> > >=20
> > > If we're missing whatever it is that makes sure the target device is
> > > reachable and responsive to config space, we likely have issues on
> > > other systems as well.  On Cavium this causes the external abort, but
> > > on other systems, we'd probably just get all 1's data back from the
> > > config read and silently do the wrong thing in
> > > pci_probe_reset_function().
> > >=20
> > > I don't know how this runtime PM works, but maybe Rafael can help us
> > > out.
> >=20
> > I'm not sure what the question is to be honest.
>=20
> My questions are basically "What does the PCI core need to do to make
> sure a device is in D0 before it operates on it?  And where do we need
> to do that?"
>=20
> > Unused ports are autosuspended after 100ms as per pcie_portdrv_probe().
>=20
> So I guess this is only done for PCIe bridges, not for conventional
> PCI bridges.  Is this because autosuspend depends on a PCIe-only
> feature?

Yes, that's PCIe-only.

> Here's the path we're in now:
>=20
>   pcie_portdrv_init                        # device_initcall (level 6)
>     pci_register_driver(&pcie_portdriver)
>       ...
>         pcie_portdrv_probe                 # pcie_portdriver.probe
>           pm_runtime_set_autosuspend_delay(&dev->dev, 100)
>=20
>   pci_sysfs_init                           # late_initcall (level 7)
>     for_each_pci_dev(dev)
>       pci_create_sysfs_dev_files(dev)
>         pci_create_capabilities_sysfs(dev)
>           pci_probe_reset_function(dev)
>             ...
>               pcie_capability_read_dword   <-- config read causing abort
>=20
> I guess it's conceivable that more than 100ms elapsed between
> pcie_portdrv_probe() and pci_probe_reset_function(), and obviously we
> can't depend on any particular timing.

Right.

> > Now, it looks like they should be resumed in the code path in question,
> > so this case seems to have been overlooked.
>=20
> How do we identify which code paths need to resume the device, and
> what do we need to do to resume it?

The "suspended" metastate is generally defined as "the device may not be
accessible now" and for the majority of bus types it is unsafe to attempt
to access suspended devices.

That's not strictly the case for PCI, but IMO PCI devices should be resumed
before accessing them too because of the below. :-)

pm_runtime_get_sync() resumes the device and prevents it from suspending
again until pm_runtime_put() (or equivalent) is called on it.

And, of course, resuming the target device itself will cause all of the
bridges above it to resume (at least that should happen by design).

> I'm kind of scared about this because most hardware just returns all
> ones in this case and we might never notice.

That's a valid concern and not just related to bridges.  Devices in D3cold
look like they were not present.
