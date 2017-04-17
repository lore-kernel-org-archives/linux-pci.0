Return-Path: <SRS0=6Kxz=3Z=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=6Kxz=3Z=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170417174712.GA7575@localhost>
References: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
 <1492115445-4069-3-git-send-email-jnair@caviumnetworks.com>
 <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
 <20170414210646.GA5346@localhost> <CAErSpo731xSzrnKF+G+8SA_UUHy7ROA1V9oFkpwKi85GQf9VAg@mail.gmail.com>
 <20170417174712.GA7575@localhost>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Apr 2017 14:51:53 -0500
Message-ID: <CAErSpo4aA+ZYz53DP=FpK01r29oNz=orAPH1q9NjZx6jH6BXVQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
To: Jayachandran C <jnair@caviumnetworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
	Jon Masters <jcm@redhat.com>, linux-arm <linux-arm-kernel@lists.infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 17, 2017 at 12:47 PM, Jayachandran C
<jnair@caviumnetworks.com> wrote:
> On Fri, Apr 14, 2017 at 09:00:06PM -0500, Bjorn Helgaas wrote:
>> On Fri, Apr 14, 2017 at 4:06 PM, Jayachandran C
>> <jnair@caviumnetworks.com> wrote:
>> > On Thu, Apr 13, 2017 at 07:19:11PM -0500, Bjorn Helgaas wrote:
>> >> I tentatively applied both patches to pci/host-thunder for v4.12.
>> >>
>> >> However, I am concerned about the topology here:
>> >>
>> >> On Thu, Apr 13, 2017 at 08:30:45PM +0000, Jayachandran C wrote:
>> >> > On Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the
>> >> > PCI topology is slightly unusual.  For a multi-node system, it looks
>> >> > like:
>> >> >
>> >> >     00:00.0 [PCI] bridge to [bus 01-1e]
>> >> >     01:0a.0 [PCI-PCIe bridge, type 8] bridge to [bus 02-04]
>> >> >     02:00.0 [PCIe root port, type 4] bridge to [bus 03-04] (XLATE_ROOT)
>> >> >     03:00.0 PCIe Endpoint
>> >>
>> >> A root port normally has a single PCIe link leading downstream.
>> >> According to this, 02:00.0 is a root port that has the usual
>> >> downstream link leading to 03:00.0, but it also has an upstream link
>> >> to 01:0a.0.
>> >
>> > The PCI topology is a bit broken due to the way that the PCIe IP block
>> > was integrated into SoC PCI bridges and devices. The current mechanism
>> > of adding a PCI-PCIe bridge to glue these together is not ideal.
>>
>> Yeah, that's definitely broken.
>>
>> >> Maybe this example is omitting details that are not relevant to DMA
>> >> aliases?  The PCIe capability only contains one set of link-related
>> >> registers, so I don't know how we could manage a single device that
>> >> has two links.
>> >
>> > The root port is standard and has just one link to the EP (or whatever
>> > is on the external PCIe slot). The fallout of the current hw design is
>> > that the PCI-PCIe bridge has a link that does not follow standard and
>> > does not have a counterpart (as you noted).
>> >
>> >> A device with two links would break things like ASPM.  In
>> >> set_pcie_port_type(), for example, we have this comment:
>> >>
>> >>    * A Root Port or a PCI-to-PCIe bridge is always the upstream end
>> >>    * of a Link.  No PCIe component has two Links.  Two Links are
>> >>    * connected by a Switch that has a Port on each Link and internal
>> >>    * logic to connect the two Ports.
>> >>
>> >> The topology above breaks these assumptions, which will make
>> >> pdev->has_secondary_link incorrect, which means ASPM won't work
>> >> correctly.
>> >
>> > Given the current hardware, the pcieport driver seems to work reasonably
>> > for the root port at 02:00.0, with AER support. I will take a look at the
>> > ASPM part.
>>
>> I don't think pcieport itself cares much about links.  ASPM does, but
>> it looks like set_pcie_port_type() actually is smart enough to know
>> that PCI-to-PCIe bridges and Root Ports always have links on their
>> secondary sides.  So has_secondary_link probably does get set
>> correctly.
>>
>> But I think you'll hit the VIA "strange chipset" thing in
>> pcie_aspm_init_link_state(), which will probably prevent us from doing
>> ASPM on the link from 02:00.0 to 03:00.0.
>>
>> Could you collect "lspci -vv" output from this system?  I'd like to
>> archive that as background for this IOMMU issue and the ASPM tweaks I
>> suspect we'll have to do.  I *wish* we had more information about that
>> VIA thing, because I suspect we could get rid of it if we had more
>> details.
>
> The full logs are slightly large, so I have kept them at:
> https://github.com/jchandra-cavm/thunderx2/blob/master/logs/
> The lspci -vv output is lspci-vv.txt and lspci -tvn output is lspci-tvn.txt
>
> The output is from 2 socket system, the cards are not on the first slot
> like the example above, so the bus and device numbers are different.
>
> Looks like I have to spend some time on ASPM next.

Thanks, I attached these to
https://bugzilla.kernel.org/show_bug.cgi?id=195447 and added that link
to the changelogs.

  01:0a.0 PCI-to-PCIe bridge to [bus 02-03]
    Capabilities: [40] Express (v2) PCI/PCI-X to PCI-Express Bridge

lspci doesn't decode the "Slot Implemented" bit here.  The spec (PCIe
r3.1, sec 7.8.2) isn't explicit about whether that bit is defined for
this kind of bridge, but it seems to me like this bridge contains a
Downstream Port that could lead to a slot, so we *should* decode "Slot
Implemented", and if it does indicate a slot, we should decode the
Slot Capabilities, Control, and Status registers as well.

Linux also doesn't currently believe this bridge can have a slot below
it (see pcie_cap_has_sltctl() and pcie_downstream_port()).  I don't
know if your topology has actual slots there, but I think the spec
does allow it, so Linux probably should handle that.

For this port:

  02:00.0 Root Port to [bus 03]
    Capabilities: [ac] Express (v2) Root Port (Slot-)

I'm pretty sure there *is* a slot (currently empty), and your lspci
output shows "Slot-", which seems wrong to me.  It should show "Slot+"
with Presence Detect State showing "Slot Empty", shouldn't it?

Bjorn
