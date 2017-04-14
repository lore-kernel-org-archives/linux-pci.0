Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Apr 2017 19:19:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jayachandran C <jnair@caviumnetworks.com>
Subject: Re: [PATCH v5 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Message-ID: <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
References: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
 <1492115445-4069-3-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
In-Reply-To: <1492115445-4069-3-git-send-email-jnair@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org, Jon Masters <jcm@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

I tentatively applied both patches to pci/host-thunder for v4.12.

However, I am concerned about the topology here:

On Thu, Apr 13, 2017 at 08:30:45PM +0000, Jayachandran C wrote:
> On Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the
> PCI topology is slightly unusual.  For a multi-node system, it looks
> like:
> 
>     00:00.0 [PCI] bridge to [bus 01-1e]
>     01:0a.0 [PCI-PCIe bridge, type 8] bridge to [bus 02-04]
>     02:00.0 [PCIe root port, type 4] bridge to [bus 03-04] (XLATE_ROOT)
>     03:00.0 PCIe Endpoint

A root port normally has a single PCIe link leading downstream.
According to this, 02:00.0 is a root port that has the usual
downstream link leading to 03:00.0, but it also has an upstream link
to 01:0a.0.

Maybe this example is omitting details that are not relevant to DMA
aliases?  The PCIe capability only contains one set of link-related
registers, so I don't know how we could manage a single device that
has two links.

A device with two links would break things like ASPM.  In
set_pcie_port_type(), for example, we have this comment:

   * A Root Port or a PCI-to-PCIe bridge is always the upstream end
   * of a Link.  No PCIe component has two Links.  Two Links are
   * connected by a Switch that has a Port on each Link and internal
   * logic to connect the two Ports.

The topology above breaks these assumptions, which will make
pdev->has_secondary_link incorrect, which means ASPM won't work
correctly.

What am I missing?

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
