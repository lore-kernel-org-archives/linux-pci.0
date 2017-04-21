Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 21 Apr 2017 17:05:41 +0000
From: Jayachandran C <jnair@caviumnetworks.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Message-ID: <20170421170414.GA2429@localhost>
References: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
 <1492115445-4069-3-git-send-email-jnair@caviumnetworks.com>
 <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
 <20170414210646.GA5346@localhost>
 <CAErSpo731xSzrnKF+G+8SA_UUHy7ROA1V9oFkpwKi85GQf9VAg@mail.gmail.com>
 <20170417174712.GA7575@localhost>
 <CAErSpo6+do8GXon3EzZAUpqc2TFsA0BDwWBULqZCd1ayCJhD6w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAErSpo6+do8GXon3EzZAUpqc2TFsA0BDwWBULqZCd1ayCJhD6w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Jon Masters <jcm@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 21, 2017 at 10:48:15AM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 17, 2017 at 12:47 PM, Jayachandran C
> <jnair@caviumnetworks.com> wrote:
> > On Fri, Apr 14, 2017 at 09:00:06PM -0500, Bjorn Helgaas wrote:
> >> On Fri, Apr 14, 2017 at 4:06 PM, Jayachandran C
> >> <jnair@caviumnetworks.com> wrote:
> >> > On Thu, Apr 13, 2017 at 07:19:11PM -0500, Bjorn Helgaas wrote:
> >> >> I tentatively applied both patches to pci/host-thunder for v4.12.
> >> >>
> >> >> However, I am concerned about the topology here:
> >> >>
> >> >> On Thu, Apr 13, 2017 at 08:30:45PM +0000, Jayachandran C wrote:
> >> >> > On Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the
> >> >> > PCI topology is slightly unusual.  For a multi-node system, it looks
> >> >> > like:
> >> >> >
> >> >> >     00:00.0 [PCI] bridge to [bus 01-1e]
> >> >> >     01:0a.0 [PCI-PCIe bridge, type 8] bridge to [bus 02-04]
> >> >> >     02:00.0 [PCIe root port, type 4] bridge to [bus 03-04] (XLATE_ROOT)
> >> >> >     03:00.0 PCIe Endpoint
> >> >>
> >> >> A root port normally has a single PCIe link leading downstream.
> >> >> According to this, 02:00.0 is a root port that has the usual
> >> >> downstream link leading to 03:00.0, but it also has an upstream link
> >> >> to 01:0a.0.
> >> >
> >> > The PCI topology is a bit broken due to the way that the PCIe IP block
> >> > was integrated into SoC PCI bridges and devices. The current mechanism
> >> > of adding a PCI-PCIe bridge to glue these together is not ideal.
> >>
> >> Yeah, that's definitely broken.
> >>
> >> >> Maybe this example is omitting details that are not relevant to DMA
> >> >> aliases?  The PCIe capability only contains one set of link-related
> >> >> registers, so I don't know how we could manage a single device that
> >> >> has two links.
> >> >
> >> > The root port is standard and has just one link to the EP (or whatever
> >> > is on the external PCIe slot). The fallout of the current hw design is
> >> > that the PCI-PCIe bridge has a link that does not follow standard and
> >> > does not have a counterpart (as you noted).
> >> >
> >> >> A device with two links would break things like ASPM.  In
> >> >> set_pcie_port_type(), for example, we have this comment:
> >> >>
> >> >>    * A Root Port or a PCI-to-PCIe bridge is always the upstream end
> >> >>    * of a Link.  No PCIe component has two Links.  Two Links are
> >> >>    * connected by a Switch that has a Port on each Link and internal
> >> >>    * logic to connect the two Ports.
> >> >>
> >> >> The topology above breaks these assumptions, which will make
> >> >> pdev->has_secondary_link incorrect, which means ASPM won't work
> >> >> correctly.
> >> >
> >> > Given the current hardware, the pcieport driver seems to work reasonably
> >> > for the root port at 02:00.0, with AER support. I will take a look at the
> >> > ASPM part.
> >>
> >> I don't think pcieport itself cares much about links.  ASPM does, but
> >> it looks like set_pcie_port_type() actually is smart enough to know
> >> that PCI-to-PCIe bridges and Root Ports always have links on their
> >> secondary sides.  So has_secondary_link probably does get set
> >> correctly.
> >>
> >> But I think you'll hit the VIA "strange chipset" thing in
> >> pcie_aspm_init_link_state(), which will probably prevent us from doing
> >> ASPM on the link from 02:00.0 to 03:00.0.
> >>
> >> Could you collect "lspci -vv" output from this system?  I'd like to
> >> archive that as background for this IOMMU issue and the ASPM tweaks I
> >> suspect we'll have to do.  I *wish* we had more information about that
> >> VIA thing, because I suspect we could get rid of it if we had more
> >> details.
> >
> > The full logs are slightly large, so I have kept them at:
> > https://github.com/jchandra-cavm/thunderx2/blob/master/logs/
> > The lspci -vv output is lspci-vv.txt and lspci -tvn output is lspci-tvn.txt
> >
> > The output is from 2 socket system, the cards are not on the first slot
> > like the example above, so the bus and device numbers are different.
> 
> Can somebody with this system collect the "lspci -xxxx" output as well?
> 
> I'm making some lspci changes to handle the PCI-to-PCIe bridge
> correctly, and I can use the "lspci -xxxx" output to create an lspci
> test case.

[Sorry was AFK for a few days]

I have updated the above directory with the log. Also tested your next branch
and it works fine on ThunderX2.

JC.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
