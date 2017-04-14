Return-Path: <SRS0=k68l=3W=cavium.com=Jayachandran.Nair@kernel.org>
Return-Path: <SRS0=k68l=3W=cavium.com=Jayachandran.Nair@kernel.org>
Date: Fri, 14 Apr 2017 21:06:46 +0000
From: Jayachandran C <jnair@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, Jon Masters <jcm@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Message-ID: <20170414210646.GA5346@localhost>
References: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
 <1492115445-4069-3-git-send-email-jnair@caviumnetworks.com>
 <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 13, 2017 at 07:19:11PM -0500, Bjorn Helgaas wrote:
> I tentatively applied both patches to pci/host-thunder for v4.12.
> 
> However, I am concerned about the topology here:
> 
> On Thu, Apr 13, 2017 at 08:30:45PM +0000, Jayachandran C wrote:
> > On Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the
> > PCI topology is slightly unusual.  For a multi-node system, it looks
> > like:
> > 
> >     00:00.0 [PCI] bridge to [bus 01-1e]
> >     01:0a.0 [PCI-PCIe bridge, type 8] bridge to [bus 02-04]
> >     02:00.0 [PCIe root port, type 4] bridge to [bus 03-04] (XLATE_ROOT)
> >     03:00.0 PCIe Endpoint
> 
> A root port normally has a single PCIe link leading downstream.
> According to this, 02:00.0 is a root port that has the usual
> downstream link leading to 03:00.0, but it also has an upstream link
> to 01:0a.0.

The PCI topology is a bit broken due to the way that the PCIe IP block
was integrated into SoC PCI bridges and devices. The current mechanism
of adding a PCI-PCIe bridge to glue these together is not ideal.

> Maybe this example is omitting details that are not relevant to DMA
> aliases?  The PCIe capability only contains one set of link-related
> registers, so I don't know how we could manage a single device that
> has two links.
 
The root port is standard and has just one link to the EP (or whatever
is on the external PCIe slot). The fallout of the current hw design is
that the PCI-PCIe bridge has a link that does not follow standard and
does not have a counterpart (as you noted).

> A device with two links would break things like ASPM.  In
> set_pcie_port_type(), for example, we have this comment:
> 
>    * A Root Port or a PCI-to-PCIe bridge is always the upstream end
>    * of a Link.  No PCIe component has two Links.  Two Links are
>    * connected by a Switch that has a Port on each Link and internal
>    * logic to connect the two Ports.
> 
> The topology above breaks these assumptions, which will make
> pdev->has_secondary_link incorrect, which means ASPM won't work
> correctly.

Given the current hardware, the pcieport driver seems to work reasonably
for the root port at 02:00.0, with AER support. I will take a look at the
ASPM part.

Thanks,
JC.
