Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42145 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbcBHWMJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Feb 2016 17:12:09 -0500
Date: Mon, 8 Feb 2016 16:12:04 -0600
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
Message-ID: <20160208221204.GA30821@localhost>
References: <1454715675-17512-1-git-send-email-ddaney.cavm@gmail.com>
 <1454715675-17512-4-git-send-email-ddaney.cavm@gmail.com>
 <20160208195642.GA15103@rob-hp-laptop>
 <56B8FED6.1050804@caviumnetworks.com>
 <CAL_JsqJNndZ59465YhpkP=dQYaijaar+LcQG4KQEJwF5e1ryLQ@mail.gmail.com>
 <56B90B09.7090500@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B90B09.7090500@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 08, 2016 at 01:39:21PM -0800, David Daney wrote:
> On 02/08/2016 01:12 PM, Rob Herring wrote:
> >On Mon, Feb 8, 2016 at 2:47 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> >>On 02/08/2016 11:56 AM, Rob Herring wrote:
> >>>On Fri, Feb 05, 2016 at 03:41:15PM -0800, David Daney wrote:
> >>>>From: David Daney <david.daney@cavium.com>
> >
> >[...]
> >
> >>>>+Properties of the host controller node that differ from
> >>>>+host-generic-pci.txt:
> >>>>+
> >>>>+- compatible     : Must be "cavium,pci-host-thunder-ecam"
> >>>>+
> >>>>+Example:
> >>>>+
> >>>>+       pci@84b0,00000000 {
> >>>
> >>>
> >>>Drop the comma,
> >>
> >>
> >>OK...
> >>
> >>>and the node name should be "pcie".
> >>>
> >>
> >>Why pcie?
> >>
> >>There are no PCIe devices or buses reachable from this type of root complex.
> >>There are however many PCI devices.
> >
> >I thought ECAM is a PCIe thing. If not, then nevermind.

The "ECAM" confusion bites again :)

> Well, Enhanced Configuration Access Mechanism (ECAM) is defined  the
> the PCI Express(R) base Specification, but it just defines a
> standard layout of address bits to memory map config space
> operations.  Since the PCI config space is a sub set of the PCIe
> config space, ECAM can also be used in PCI systems.
> 
> Really, it is a bit of a gray area here as we don't have any bridges
> to PCIe buses and there are multiple devices residing on each bus,
> so from that point of view it cannot be PCIe.  There are, however,
> devices that implement the PCI Express Capability structure, so does
> that make it PCIe?  It is not clear what the specifications demand
> here.

The PCI core doesn't care about the node name in the device tree.  But
it *does* care about some details of PCI/PCIe topology.  We consider
anything with a PCIe capability to be PCIe.  For example,

  - pci_cfg_space_size() thinks PCIe devices have 4K of config space

  - only_one_child() thinks a PCIe bus, i.e., a link, only has a
    single device on it

  - a PCIe device should have a PCIe Root Port or PCIe Downstream Port
    upstream from it (we did remove some of these restrictions with
    b35b1df5e6c2 ("PCI: Tolerate hierarchies with no Root Port"), but 
    it's possible we didn't get them all)

I assume your system conforms to expectations like these; I'm just
pointing them out because you mentioned buses with multiple devices on
them, which is definitely something one doesn't expect in PCIe.

Bjorn
