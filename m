Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	David Daney <ddaney@caviumnetworks.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Daney <david.daney@cavium.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	David Daney <ddaney.cavm@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 4/5] PCI: generic: Correct, and avoid overflow, in bus_max calculation.
Date: Wed, 23 Sep 2015 22:45:28 +0200
Message-ID: <2795004.Hn5xt30nZN@wuerfel>
In-Reply-To: <1707525.QvfFzUYq4E@wuerfel>
References: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com> <20150923193545.GZ7356@arm.com> <1707525.QvfFzUYq4E@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 23 September 2015 21:39:27 Arnd Bergmann wrote:
> On Wednesday 23 September 2015 20:35:45 Will Deacon wrote:
> > 
> > From what Lorenzo was saying, ACPI shares the interpretation that David is
> > implementing here and, given that the DT version seems to be subjective,
> > aligning this reg property with MMCFG seems to make sense.
> 
> We should then make it very clear in the binding that the driver
> is not allowed to actually map the registers for the buses outside
> of the bus-range, as that is highly unusual.

One more point here: I think ACPI does something different here,
it lists the base address of mmconfig space of the the PCI domain
that the host bridge belongs to. In contrast, in DT the 'reg'
property is defined as the registers belonging to the host bridge
itself, and the DT does not say anything about domains at all
(aside from the linux,pci-domain property that is not mandatory
and a Linux-specific extension).

	Arnd
