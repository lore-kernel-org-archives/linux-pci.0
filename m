Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 11 Apr 2017 08:41:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jayachandran C <jnair@caviumnetworks.com>
Subject: Re: [PATCH v4 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Message-ID: <20170411134125.GA31773@bhelgaas-glaptop.roam.corp.google.com>
References: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
 <1491225304-3559-3-git-send-email-jnair@caviumnetworks.com>
 <20170411012847.GA15291@bhelgaas-glaptop.roam.corp.google.com>
 <20170411071047.GA3610@localhost>
MIME-Version: 1.0
In-Reply-To: <20170411071047.GA3610@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Joerg]

On Tue, Apr 11, 2017 at 07:10:48AM +0000, Jayachandran C wrote:
> On Mon, Apr 10, 2017 at 08:28:47PM -0500, Bjorn Helgaas wrote:
> > Hi Jayachandran,
> > 
> > On Mon, Apr 03, 2017 at 01:15:04PM +0000, Jayachandran C wrote:
> > > The Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the PCI
> > > topology is slightly unusual. For a multi-node system, it looks like:
> > > 
> > > [node level PCI bridges - one per node]
> > >     [SoC PCI devices with MSI-X but no IOMMU]
> > >     [PCI-PCIe "glue" bridges - upto 14, one per real port below]
> > >         [PCIe real root ports associated with IOMMU and GICv3 ITS]
> > >             [External PCI devices connected to PCIe links]
> > > 
> > > The top two levels of bridges should have introduced aliases since they
> > > are PCI and PCI/PCIe bridges, but in the case of ThunderX2 they do not.
> > > In the case of external PCIe devices, the "real" root ports are connected
> > > to the SMMU and the GIC ITS, so PCI-PCIe bridge does not introduce an
> > > alias. The SoC PCI devices are directly connected to the GIC ITS, so the
> > > node level bridges do not introduce an alias either.
> > > 
> > > To handle this quirk, we mark the real PCIe root ports and node level
> > > PCI bridges with the flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT.  With this,
> > > pci_for_each_dma_alias() works correctly for external PCIe devices and
> > > SoC PCI devices.
> > > 
> > > For the current revision of Cavium ThunderX2, the VendorID and Device ID
> > > are from Broadcom Vulcan (14e4:90XX).
> > 
> > Can you supply some text here about why we want to apply this patch?
> > E.g., does it avoid making unnecessary IOMMU mappings, improve
> > performance, avoid a crash, etc?
> 
> If this is for the commit message, I hope the following is ok:
> 
> "With this change, both MSI-X and IO virtualization work correctly on
> Cavium ThunderX2. The GIC ITS driver gets the correct device ID to
> configure MSI-X, the SMMUv3 driver gets the correct Stream IDs for PCI
> devices, and the IOMMU groups are setup correctly."

This doesn't get at what the actual problem is.  I'm hoping for
something like "without this change, we set up an IOMMU mapping for
requestor ID X, but device DMA uses requestor ID Y because ...., which
results in an IOMMU fault"

I've been puzzling over the fact that most of the callers of
pci_for_each_dma_alias() don't seem to use it correctly.  For Intel
IOMMUs, domain_context_mapping() uses it to add a mapping for every
possible alias.  But most of the other callers only look at the last
alias and ignore all the others.  That might work most of the time,
but:

  - There's no guarantee that pci_for_each_dma_alias() iterates in any
    particular order, so relying on the current order is fragile,

  - The pci_add_dma_alias() interface allows an arbitrary number of
    aliases (as long as they're all on the same bus), and some devices
    do use more than one, e.g., quirk_dma_func0_alias(),
    quirk_mic_x200_dma_alias(),

  - pci_for_each_dma_alias() translates the rules in the PCIe to
    PCI/PCI-X Bridge spec, r1.0, sec 2.3, about taking ownership into
    aliases.  I think it's important to pay attention to *every*
    possible alias, not just the last one.

I suspect the reason this patch makes a difference is because the
current pci_for_each_dma_alias() believes one of those top-level
bridges is an alias, and the iterator produces it last, so that's the
one you map.  The IOMMU is attached lower down, so that top-level
bridge is not in fact an alias, but since you only look at the *last*
one, you don't map the correct aliases from lower down in the tree.

Stopping the iterator earlier happens to make the last alias be one of
the correct ones, but it doesn't solve the problems of quirked devices
that can use multiple requester IDs, and it doesn't solve the problem
of PCIe-to-PCI bridges that optionally take ownership of transactions.

> I can send out a new patch if needed.
> 
> The on chip SATA and USB use MSI-X, so this is needed for basic
> functionality of the platform.

No need for a new patch; I can integrate something into the changelog.

> > > Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> > > ---
> > >  drivers/pci/quirks.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 6736836..564a84a 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -3958,6 +3958,20 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, quirk_mic_x200_dma_alias);
> > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
> > >  
> > >  /*
> > > + * The IOMMU and interrupt controller on Broadcom Vulcan/Cavium ThunderX2 are
> > > + * associated not at the root bus, but at a bridge below. This quirk flag
> > > + * will ensure that the aliases are identified correctly.
> > > + */
> > > +static void quirk_bridge_cavm_thrx2_pcie_root(struct pci_dev *pdev)
> > > +{
> > > +	pdev->dev_flags |= PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT;
> > > +}
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
> > > +				quirk_bridge_cavm_thrx2_pcie_root);
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
> > > +				quirk_bridge_cavm_thrx2_pcie_root);
> > > +
> > > +/*
> > >   * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
> > >   * class code.  Fix it.
> > >   */
> 
> Thanks,
> JC.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
