Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53659 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423015AbcFMRRw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 13:17:52 -0400
Date: Mon, 13 Jun 2016 18:18:23 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Keith Busch <keith.busch@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Myron Stowe <myron.stowe@gmail.com>,
	Auger Eric <eric.auger@redhat.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: LPC16 PCI microconference - Call for sessions proposals
Message-ID: <20160613171823.GA29621@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

following the official LPC16 PCI uconf acceptance notification:

https://www.linuxplumbersconf.org/2016/pci-microconference-accepted-into-2016-linux-plumbers-conference/

I am sending out a call for sessions proposals open to all developers
interested/involved in Linux kernel PCI development.

The LPC16 uconf wiki provides a list of topics that we put forward for
the microconference submission:

http://wiki.linuxplumbersconf.org/2016:pci

The wiki is there to provide a list of topics that we considered key
and it should not be considered final, actually it is a starting point
to define a possible schedule structure.

Session proposals for the LPC16 PCI microconference are warmly encouraged
and can be submitted here:

http://www.linuxplumbersconf.org/2016/ocw/events/LPC2016/tracks/531

Maintainers in CC, as an initial step we singled out the main subtracks
below and I would be grateful if you could add a session through the link
above and run the respective session (in brackets people whom I know are
involved in the topic and are likely to be asked to run/take part in the
session; NB: it is obviously incomplete, and it is based on what we
could infer from current PCI related patches, please do manifest your
interest):

- PCI resources allocation/validation/cross-arch consolidation
  ([Bjorn, Lorenzo, Yinghai, Benjamin, Jesse, Arnd])
- PCI Virtualization (cross-topic)
  ([Alex, Bjorn, Eric, Marc, Joerg, Will, David])
- PCI MSI ([Alex, Eric, Marc])
- PCI IOMMU ([Joerg, David, Jesse, Will, Marc])
- PCIe (ATS, PRI) ([Jesse, Will])
- PCIe root ports power management ([Rafael])
- PCI DT/ACPI - consolidation ([Bjorn, Lorenzo, Arnd, Rob])

Anyone involved in PCI kernel development, if you wish to add sessions and
attend the microconference consider yourself welcome, for any questions
just reply to this thread or drop me a line.

Looking forward to meeting you all in Santa Fe for this interesting track !

Lorenzo
