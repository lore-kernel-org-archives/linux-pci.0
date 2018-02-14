Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 14 Feb 2018 14:16:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: George Cherian <gcherian@caviumnetworks.com>
Cc: George Cherian <george.cherian@cavium.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Message-ID: <20180214201653.GA62268@bhelgaas-glaptop.roam.corp.google.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <20180213150907.GD75542@bhelgaas-glaptop.roam.corp.google.com>
 <dd104986-81e2-e7a2-353c-91827078bc4c@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <dd104986-81e2-e7a2-353c-91827078bc4c@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, PM question below]

On Wed, Feb 14, 2018 at 04:58:08PM +0530, George Cherian wrote:
> On 02/13/2018 08:39 PM, Bjorn Helgaas wrote:
> >On Fri, Feb 02, 2018 at 07:00:46AM +0000, George Cherian wrote:
> >>The PCIe Controller on Cavium ThunderX2 processors does not
> >>respond to downstream CFG/ECFG cycles when root port is
> >>in power management D3-hot state.
> >
> >I think you're talking about the CPU initiating a config cycle to
> >a device below the root port, right?
> Yes

If a bridge, e.g., a Root Port in your case, is in D3hot, we should be
able to access config space of the bridge itself, but the secondary
bus will be in B2 or B3 and we won't be able to access config space
for any devices below the bridge.  This is true for *all* bridges, not
just this Cavium Root Port.

The PCIe r4.0, sec 5.3.1, implementation note seems relevant:

  When a Type 1 Function associated with a Switch/Root Port (a
  "virtual bridge") is in a non-D0 power state, it will emulate the
  behavior of a conventional PCI bridge in its handling of Memory,
  I/O, and Configuration Requests and Completions. ...  All Type 1
  Configuration Requests are terminated as Unsupported Requests, ...

> >This erratum isn't published anywhere where we could include a URL,
> >is it?
> This erratum is available at support.cavium.com, You might need to
> register to the website to get hold of a copy.

That appears to require an NDA, so that doesn't work for me.  Can you
just include the erratum text in the changelog?

> >>In our tests the above mentioned errata causes the following crash when
> >>the downstream endpoint config space is accessed, while root port is in
> >>D3 state.
> >>
> >>[   12.775202] Unhandled fault: synchronous external abort (0x96000610) at 0x0000000000000000
> >
> >This looks like another example of not being able to deal with error
> >responses to PCIe events, for example, the whole mess with drivers
> >checking whether the link is up before issuing a config access.
> >
> >In that sense, this looks like a band-aid that avoids the issue by
> >preventing the use of D3, but doesn't fix the underlying problem.  If
> >we *could* deal nicely with this error, maybe we could use D3 on these
> >root ports.
> >
> >So I'm not convinced yet that this is actually a PCIe erratum.  Does
> >the hardware actually violate the PCIe spec, or is this just a problem
> >with the kernel not knowing how to deal nicely with a PCIe error?
> >
> This is not an issue with the way kernel handles the PCIe error.
> 
> >If you could include the erratum text and reference to the relevant
> >section of the PCIe spec, that would be useful.
> >
> The relevant section of the PCIe Spec is the following Section 5.3
> on wards (subsection  5.3.1.4.1)
> 
> Configuration and Message requests are the only TLPs accepted by a
> Function in the D3hot state. All other received Requests must be
> handled as Unsupported Requests, and all received Completions may
> optionally be handled as Unexpected Completions.

This isn't exactly relevant because it says requests *other than*
config and message requests must be handled as Unsupported Requests,
and we're talking about a config request.  I think sec 5.3.1 is more
to the point: the Root Port sees a Type 1 Configuration Request that
would be forwarded to its secondary interface if the port were in D0,
and that request should be terminated as an Unsupported Request.

I think the question is how the Root Complex turns this Unsupported
Request into some signal to the CPU.  The implementation note in 2.3.2
might be relevant:

  Some system configuration software depends on reading a data value
  of all 1’s when a Configuration Read Request is terminated as an
  Unsupported Request, particularly when probing to determine the
  existence of a device in the system. A Root Complex intended for use
  with software that depends on a read-data value of all 1’s must
  synthesize this value when UR Completion Status is returned for a
  Configuration Read Request.

So maybe the erratum is that the RC was intended to synthesize all 1's
but it doesn't?

There are other cases that can result in Unsupported Request
completions, so my fear is that this change will take care of one such
case but leave others that will cause similar unhandled external
aborts.

> >>[   12.775202] Unhandled fault: synchronous external abort (0x96000610) at 0x0000000000000000

> >>[   12.813518] PC is at pci_generic_config_read+0x5c/0xf0
> >>[   12.818643] LR is at pci_generic_config_read+0x48/0xf0
> >> ...
> >>[   13.269819] [<ffff000008506f34>] pci_generic_config_read+0x5c/0xf0
> >>[   13.275987] [<ffff000008506e2c>] pci_bus_read_config_dword+0xb4/0xd8
> >>[   13.282328] [<ffff0000085089f4>] pcie_capability_read_dword+0x64/0xb8
> >>[   13.288757] [<ffff000008513d28>] __pci_dev_reset+0x90/0x328
> >>[   13.294317] [<ffff0000085142d4>] pci_probe_reset_function+0x24/0x30
> >>[   13.300571] [<ffff000008518754>] pci_create_sysfs_dev_files+0x18c/0x2a0
> >>[   13.307173] [<ffff000008d9a974>] pci_sysfs_init+0x38/0x60
> >>[   13.312560] [<ffff000008083b4c>] do_one_initcall+0x5c/0x170
> >>[   13.318122] [<ffff000008d60dfc>] kernel_init_freeable+0x1c0/0x27c
> >>[   13.324205] [<ffff000008980d90>] kernel_init+0x18/0x110
> >>[   13.329416] [<ffff000008083690>] ret_from_fork+0x10/0x40

I should have asked this before: why are we even trying to do this
config read to a device that's in D3?  I assume this root port started
out in D0 because we apparently enumerated it successfully, but it
must have been put into D3 later?

The pci_probe_reset_function() function comment says "the PCI device
must be responsive to PCI config space in order to use this function." 
So apparently the caller should make sure the device is in at least
D3hot and any bridges leading to it are in D0.

If we're missing whatever it is that makes sure the target device is
reachable and responsive to config space, we likely have issues on
other systems as well.  On Cavium this causes the external abort, but
on other systems, we'd probably just get all 1's data back from the
config read and silently do the wrong thing in
pci_probe_reset_function().

I don't know how this runtime PM works, but maybe Rafael can help us
out.

> >>Fix this by adding a quirk that prevents the root port from
> >>entering D3 state. This is seen on both Ax/Bx variants of the processor.
> >>
> >>Signed-off-by: George Cherian <george.cherian@cavium.com>
> >>---
> >>  drivers/pci/quirks.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >>index 10684b1..2eb08a8 100644
> >>--- a/drivers/pci/quirks.c
> >>+++ b/drivers/pci/quirks.c
> >>@@ -1154,6 +1154,18 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
> >>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
> >>  /*
> >>+ * Cavium's Thunder-X2 Processors root port doesnot handle cfg/ecfg access to
> >>+ * downstream properly if root port is put into D3
> >>+ */
> >>+
> >>+static void quirk_no_rootport_d3(struct pci_dev *pdev)
> >>+{
> >>+	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> >>+}
> >>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM, 0x9084, quirk_no_rootport_d3);
> >>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xaf84, quirk_no_rootport_d3);
> >
> >I assume this is really only of interest if we have the Thunder-X2
> >host bridge driver in the kernel, right?  Could the quirk be moved to
> >that driver so it's not included in everybody's kernel?
> >
> We dont have a separate driver for  THUNDERX2 PCIhost. It uses the
> pci-host-generic driver. Instead I can have the changes to be under
> #ifdef CONFIG_ARCH_THUNDER2
> #endif
> 
> so that it is only included for CONFIG_ARCH_THUNDER2 enabled builds.
