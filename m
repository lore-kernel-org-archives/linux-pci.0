Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Apr 2017 14:11:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jayachandran C <jnair@caviumnetworks.com>
Subject: Re: [PATCH v4 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Message-ID: <20170412191138.GH25197@bhelgaas-glaptop.roam.corp.google.com>
References: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
 <1491225304-3559-3-git-send-email-jnair@caviumnetworks.com>
 <20170411012847.GA15291@bhelgaas-glaptop.roam.corp.google.com>
 <20170411071047.GA3610@localhost>
 <20170411134125.GA31773@bhelgaas-glaptop.roam.corp.google.com>
 <20170411152702.GA2910@localhost>
 <20170412162118.GC25197@bhelgaas-glaptop.roam.corp.google.com>
 <20170412181034.GA3671@localhost>
MIME-Version: 1.0
In-Reply-To: <20170412181034.GA3671@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>,
 Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 12, 2017 at 06:10:34PM +0000, Jayachandran C wrote:
> On Wed, Apr 12, 2017 at 11:21:18AM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 11, 2017 at 03:27:02PM +0000, Jayachandran C wrote:
> > > On Tue, Apr 11, 2017 at 08:41:25AM -0500, Bjorn Helgaas wrote:
> > > > [+cc Joerg]
> > > > 
> > > > On Tue, Apr 11, 2017 at 07:10:48AM +0000, Jayachandran C wrote:
> > > > > On Mon, Apr 10, 2017 at 08:28:47PM -0500, Bjorn Helgaas wrote:
> > > > > > Hi Jayachandran,
> > > > > > 
> > > > > > On Mon, Apr 03, 2017 at 01:15:04PM +0000, Jayachandran C wrote:
> > > > > > > The Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the PCI
> > > > > > > topology is slightly unusual. For a multi-node system, it looks like:
> > > > > > > 
> > > > > > > [node level PCI bridges - one per node]
> > > > > > >     [SoC PCI devices with MSI-X but no IOMMU]
> > > > > > >     [PCI-PCIe "glue" bridges - upto 14, one per real port below]
> > > > > > >         [PCIe real root ports associated with IOMMU and GICv3 ITS]
> > > > > > >             [External PCI devices connected to PCIe links]
> > > > > > > 
> > > > > > > The top two levels of bridges should have introduced aliases since they
> > > > > > > are PCI and PCI/PCIe bridges, but in the case of ThunderX2 they do not.
> > > > > > > In the case of external PCIe devices, the "real" root ports are connected
> > > > > > > to the SMMU and the GIC ITS, so PCI-PCIe bridge does not introduce an
> > > > > > > alias. The SoC PCI devices are directly connected to the GIC ITS, so the
> > > > > > > node level bridges do not introduce an alias either.
> > > > > > > 
> > > > > > > To handle this quirk, we mark the real PCIe root ports and node level
> > > > > > > PCI bridges with the flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT.  With this,
> > > > > > > pci_for_each_dma_alias() works correctly for external PCIe devices and
> > > > > > > SoC PCI devices.
> > > > > > > 
> > > > > > > For the current revision of Cavium ThunderX2, the VendorID and Device ID
> > > > > > > are from Broadcom Vulcan (14e4:90XX).
> > > > > > 
> > > > > > Can you supply some text here about why we want to apply this patch?
> > > > > > E.g., does it avoid making unnecessary IOMMU mappings, improve
> > > > > > performance, avoid a crash, etc?
> > > > > 
> > > > > If this is for the commit message, I hope the following is ok:
> > > > > 
> > > > > "With this change, both MSI-X and IO virtualization work correctly on
> > > > > Cavium ThunderX2. The GIC ITS driver gets the correct device ID to
> > > > > configure MSI-X, the SMMUv3 driver gets the correct Stream IDs for PCI
> > > > > devices, and the IOMMU groups are setup correctly."
> > > > 
> > > > This doesn't get at what the actual problem is.  I'm hoping for
> > > > something like "without this change, we set up an IOMMU mapping for
> > > > requestor ID X, but device DMA uses requestor ID Y because ...., which
> > > > results in an IOMMU fault"
> > > 
> > > Ok. I hope this would be better:
> > > 
> > > "Without this change, the last alias seen while traversing the PCI
> > > hierarchy will be used as the RID to generate the device ID for ITS
> > > and stream ID for SMMU. This in turn causes the MSI-X generated by the
> > > device to fail since the ITS expects to have translation tables based
> > > on the actual PCIe RID and not the (irrelevant) alias. Similarly, the
> > > device DMA also fails when SMMU is enabled due to incorrect value in
> > > SMMU translation tables"
> > 
> > This description is true, but I don't think it addresses the real
> > problem.  I think the real problem is that your IOMMU code doesn't
> > handle aliases correctly, and by ignoring these invalid aliases, we
> > happen to map an alias that works for the builtin devices.  But that's
> > only because we got lucky (those devices use a single RID and they're
> > not behind bridges that optionally take ownership).
> > 
> > It would make sense to me if we fixed the IOMMU code to map *all* the
> > aliases, which should be enough to make your devices work.  If we then
> > wanted to apply a patch like this on top, it would be simply an
> > optimization that avoids unnecessary IOMMU mappings.
> 
> The issue that the IOMMU code does not handle valid aliases is
> unrelated to what I am trying to fix. The quirk is to make sure
> that invalid aliases are not seen on ThunderX2 while doing
> pci_for_each_dma_alias().
> 
> The DMA and MSI-X requests leave the PCI/PCIe hierarchy at the point
> where the SMMU (or ITS) is attached, i.e. at the bridge marked with
> PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT. The quirk ensures that we don't look
> for aliases above that point.
> 
> The toplevel bridge is marked PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT since
> the on-chip devices are directly connected to the ITS (they do not
> use SMMU).
> 
> The top two levels of bridges are not real PCI bridges but just
> PCI bridge-like things that were added to tie the whole hierarchy
> together for configuration and enumeration. They do not handle
> PCI/PCIe transactions in the traditional sense.
> 
> I think my problem description is still not correct, maybe:
> "The SMMU (and ITS) expects to device tables to use the RID seen
> at the bridge they are associated with. Currently the
> pci_for_each_dma_alias() code traverses beyond this point and
> generates incorrect aliases due to the PCI and PCI/PCIe bridges
> above. This causes MSI-X interrupts and device DMA to fail since
> the SMMU and ITS tables to be setup with incorrect IDs"

I haven't tried to figure out the MSI-X piece of this, but let me try
to come up with a concrete DMA example.  Assume this topology:

  00:00.0 bridge to [bus 01-1e]
  01:0a.0 bridge to [bus 04-05]
  04:00.0 [14e4:9000 or 9084] bridge to [bus 05] (XLATE_ROOT)
  05:00.0 endpoint

Assume 05:00.0 generates a DMA request.  Assume the top two bridges
are such that pci_for_each_dma_alias() includes them as well, so it
iterates through 05:00.0, 01:0a.0, and 00:00.0.

When the driver for 05:00.0 makes a DMA mapping, the current code
apparently makes an IOMMU mapping for requester ID 00:00.0 because
that's the last alias.  Obviously this doesn't work because the IOMMU
at 04:00.0 will see a requester ID of 05:00.0, not 00:00.0.

With this quirk, we'll omit 01:0a.0 and 00:00.0, so we'll make an
IOMMU mapping for requester ID 05:00.0, which will work fine.  I think
it would *also* work fine if we made IOMMU mappings for 05:00.0,
01:0a.0, and 00:0.0.  The last two are unnecessary, but probably not
harmful.

Now assume 05:00 is a multi-function device that has a DMA alias
quirk, e.g., see quirk_dma_func0_alias().  It has another function:

  05:00.3 endpoint

DMA from 05:00.3 may use a requester ID of either 05:00.3 or 05:00.0.
The driver makes a DMA mapping, pci_for_each_dma_alias() iterates
through 05:00.3, 05:00.0, 01:0a.0, and 00:00.0, and we again map only
00:00.0, which again doesn't work.

With this quirk, we create a single mapping for 05:00.0.  That will
work sometimes, but the device may also generate DMA with a requester
ID of 05:00.3, and that won't work.

If your on-chip device is, e.g., 01:04.0, pci_for_each_dma_alias()
probably iterates through 01:04.0, 00:00.0.  Today we make an IOMMU
mapping for 00:00.0, which doesn't work.  With this quirk, we'll
ignore 00:00.0 and make a mapping for 01:04.0, which does work.  But I
think if you made the IOMMU code add mappings for each of the aliases,
i.e., for both 01:04.0 and 00:00.0, that device *would* work even
without this quirk.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
