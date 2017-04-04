Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 4 Apr 2017 11:50:39 +0000
From: Jayachandran C <jnair@caviumnetworks.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Message-ID: <20170404115037.GA2401@localhost>
References: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
 <1491225304-3559-3-git-send-email-jnair@caviumnetworks.com>
 <b44e6df5-4840-ecb4-59c6-b4bc474ad28c@arm.com>
MIME-Version: 1.0
In-Reply-To: <b44e6df5-4840-ecb4-59c6-b4bc474ad28c@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jon Masters <jcm@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 03, 2017 at 04:07:53PM +0100, Robin Murphy wrote:
> On 03/04/17 14:15, Jayachandran C wrote:
> > The Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the PCI
> > topology is slightly unusual. For a multi-node system, it looks like:
> > 
> > [node level PCI bridges - one per node]
> >     [SoC PCI devices with MSI-X but no IOMMU]
> >     [PCI-PCIe "glue" bridges - upto 14, one per real port below]
> >         [PCIe real root ports associated with IOMMU and GICv3 ITS]
> >             [External PCI devices connected to PCIe links]
> 
> Since it's not entirely obvious, what does the actual DT - or IORT if
> you must ;) - topology for this look like? I can't help thinking that
> either it's inaccurate, or that this is going to expose a shortcoming in
> pci_dma_configure() which breaks things - unless I'm missing something,
> isn't find_pci_root_bus() going to go all the way up to the top-level
> glue bridge and pick up the wrong firmware node (if any) for the
> appropriate DMA properties?

I will try to describe the ACPI interface:

There is just one ECAM area, a single bus range and one set of memory
windows for the whole system - so there is just one entry in DSDT for
the PCI controller. This entry also corresponds to the PCI RC node in
IORT. DMA is coherent and supports 64 bits system-wide, the attributes
(in DSDT and IORT) reflect this.

lspci on the system looks like this:
-[0000:00]-+-00.0-[01-1e]--+-04.0  14e4:9026
           |               +-04.1  14e4:9026
           |               +-05.0  14e4:9027
           |               +-05.1  14e4:9027
           |               +-0a.0-[02-03]----00.0-[03]--
           |               +-0a.1-[04-05]----00.0-[05]--
           |           [...etc...]
           |               +-0b.0-[12-14]----00.0-[13-14]--+-00.0  8086:1583
           |               |                               \-00.1  8086:1583
           |           [...etc...]
           |               \-0b.5-[1d-1e]----00.0-[1e]--
           \-00.1-[1f-3b]--+-04.0  14e4:9026
                           +-04.1  14e4:9026
                           +-05.0  14e4:9027
                           +-05.1  14e4:9027
                           +-0a.0-[20-21]----00.0-[21]--
                       [...etc...]

The devices here are:
 - 00:00.0 and 00:00.1 are the node (socket) level bridges
 - 01:[45].x and 1f:[45].x are SoC PCI devices like SATA and USB
 - 01:[ab].x and 1f:[ab].x are the PCI-PCIe "reverse"/glue bridges
 - 02:00.0 etc are the "real" PCIe ports connected to external PCIe cards. 
Each node has a GIC ITS, and a group of 4 PCIe ports have an SMMU.

The IORT is built by the firmware based on its PCI enumeration. The IORT
will have multiple entries under the PCI RC node:
 - one entry per node to map the SoC devices directly to ITS for MSI-X,
   since the SoC devices are not attached to any SMMU.
 - An entry per "real" PCIe port to map RIDs under it to the corresponding
   SMMU.
The SMMU nodes will have an entry to map its RID ranges to the node ITS.

The IORT spec supports this configuration, and the corresponding code is
already upstream, so the only sticking point right now is
pci_for_each_dma_alias().

JC.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
