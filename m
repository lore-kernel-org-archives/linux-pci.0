Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Feb 2016 17:24:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Rob Herring <robh@kernel.org>, David Daney <ddaney.cavm@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v5 3/3] pci, pci-thunder-ecam: Add driver for
 ThunderX-pass1 on-chip devices
Message-ID: <20160208232430.GA1353@localhost>
References: <1454715675-17512-1-git-send-email-ddaney.cavm@gmail.com>
 <1454715675-17512-4-git-send-email-ddaney.cavm@gmail.com>
 <20160208195642.GA15103@rob-hp-laptop>
 <56B8FED6.1050804@caviumnetworks.com>
 <CAL_JsqJNndZ59465YhpkP=dQYaijaar+LcQG4KQEJwF5e1ryLQ@mail.gmail.com>
 <56B90B09.7090500@caviumnetworks.com>
 <20160208221204.GA30821@localhost>
 <56B919A5.5090000@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B919A5.5090000@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 08, 2016 at 02:41:41PM -0800, David Daney wrote:
> On 02/08/2016 02:12 PM, Bjorn Helgaas wrote:
> >On Mon, Feb 08, 2016 at 01:39:21PM -0800, David Daney wrote:
> >>On 02/08/2016 01:12 PM, Rob Herring wrote:
> >>>On Mon, Feb 8, 2016 at 2:47 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> >>>>On 02/08/2016 11:56 AM, Rob Herring wrote:
> >>>>>On Fri, Feb 05, 2016 at 03:41:15PM -0800, David Daney wrote:
> >>>>>>From: David Daney <david.daney@cavium.com>
> >>>>>>+Properties of the host controller node that differ from
> >>>>>>+host-generic-pci.txt:
> >>>>>>+
> >>>>>>+- compatible     : Must be "cavium,pci-host-thunder-ecam"
> >>>>>>+
> >>>>>>+Example:
> >>>>>>+
> >>>>>>+       pci@84b0,00000000 {
> ...
> >>>>>and the node name should be "pcie".
> >>>>
> >>>>Why pcie?
> >>>>
> >>>>There are no PCIe devices or buses reachable from this type of root complex.
> >>>>There are however many PCI devices.
> ...

> >>Really, it is a bit of a gray area here as we don't have any bridges
> >>to PCIe buses and there are multiple devices residing on each bus,
> >>so from that point of view it cannot be PCIe.  There are, however,
> >>devices that implement the PCI Express Capability structure, so does
> >>that make it PCIe?  It is not clear what the specifications demand
> >>here.
> >
> >The PCI core doesn't care about the node name in the device tree.  But
> >it *does* care about some details of PCI/PCIe topology.  We consider
> >anything with a PCIe capability to be PCIe.  For example,
> >
> >   - pci_cfg_space_size() thinks PCIe devices have 4K of config space
> >
> >   - only_one_child() thinks a PCIe bus, i.e., a link, only has a
> >     single device on it
> >
> >   - a PCIe device should have a PCIe Root Port or PCIe Downstream Port
> >     upstream from it (we did remove some of these restrictions with
> >     b35b1df5e6c2 ("PCI: Tolerate hierarchies with no Root Port"), but
> >     it's possible we didn't get them all)
> >
> >I assume your system conforms to expectations like these; I'm just
> >pointing them out because you mentioned buses with multiple devices on
> >them, which is definitely something one doesn't expect in PCIe.
> 
> The topology we have is currently working with the kernel's core PCI
> code.  I don't really want to get into discussing what the
> definition of PCIe is.  We have multiple devices (more than 32) on a
> single bus, and they have PCI Express and ARI Capabilities.  Is that
> PCIe?  I don't know.

I don't need to know the details of your topology.  As long as it
conforms to the PCIe spec, it should be fine.  If it *doesn't* conform
to the spec, but things currently seem to work, that's less fine,
because a future Linux change is liable to break something for you.

I was a little concerned about your statement that "there are multiple
devices residing on each bus, so from that point of view it cannot be
PCIe."  That made it sound like you're doing something outside the
spec.  If you're just using regular multi-function devices or ARI,
then I don't see any issue (or any reason to say it can't be PCIe).

Bjorn
