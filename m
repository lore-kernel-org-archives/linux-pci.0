Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:53017 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbcBIJ01 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 04:26:27 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	David Daney <ddaney@caviumnetworks.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	David Daney <ddaney.cavm@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 3/3] pci, pci-thunder-ecam: Add driver for ThunderX-pass1 on-chip devices
Date: Tue, 09 Feb 2016 10:25:33 +0100
Message-ID: <12842339.z2KnaZPlyO@wuerfel>
In-Reply-To: <20160208232430.GA1353@localhost>
References: <1454715675-17512-1-git-send-email-ddaney.cavm@gmail.com> <56B919A5.5090000@caviumnetworks.com> <20160208232430.GA1353@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 08 February 2016 17:24:30 Bjorn Helgaas wrote:
> > >
> > >I assume your system conforms to expectations like these; I'm just
> > >pointing them out because you mentioned buses with multiple devices on
> > >them, which is definitely something one doesn't expect in PCIe.
> > 
> > The topology we have is currently working with the kernel's core PCI
> > code.  I don't really want to get into discussing what the
> > definition of PCIe is.  We have multiple devices (more than 32) on a
> > single bus, and they have PCI Express and ARI Capabilities.  Is that
> > PCIe?  I don't know.
> 
> I don't need to know the details of your topology.  As long as it
> conforms to the PCIe spec, it should be fine.  If it *doesn't* conform
> to the spec, but things currently seem to work, that's less fine,
> because a future Linux change is liable to break something for you.
> 
> I was a little concerned about your statement that "there are multiple
> devices residing on each bus, so from that point of view it cannot be
> PCIe."  That made it sound like you're doing something outside the
> spec.  If you're just using regular multi-function devices or ARI,
> then I don't see any issue (or any reason to say it can't be PCIe).

It doesn't conform to the PCIe port spec, because there are no external
ports but just integrated devices in the host bridge. For this special
case, I don't think it matters at all from the point of view of the DT
binding whether we call the node name "pci" or "pcie".

IIRC, even on real Open Firmware, the three companies that shipped
PCIe (or Hypertransport, which doesn't even have a formal binding)
based machines (Sun, IBM, Apple) were using slightly different
bindings in practice, so I wouldn't read to much into it. Any OS
that wants to run on real OF already has to support it either way.

	Arnd
