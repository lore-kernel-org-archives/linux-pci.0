Return-Path: <SRS0=1MX4=3G=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Return-Path: <SRS0=1MX4=3G=sigmadesigns.com=Marc_Gonzalez@kernel.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH v3 0/2] Tango PCIe controller support
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
CC: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David Laight
	<david.laight@aculab.com>, linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Phuong Nguyen
	<phuong_nguyen@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>, DT
	<devicetree@vger.kernel.org>, Mason <slash.tmp@free.fr>
Message-ID: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
Date: Wed, 29 Mar 2017 13:11:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
List-ID: <linux-pci.vger.kernel.org>

Hello,

The patch is split in two parts, to ease review of two orthogonal
parts (MSI controller vs host bridge)

Marc Gonzalez (2):
  PCI: Add tango MSI controller support
  PCI: Add tango PCIe host bridge support

 Documentation/devicetree/bindings/pci/tango-pcie.txt |  34 ++++
 drivers/pci/host/Kconfig                             |   7 +
 drivers/pci/host/Makefile                            |   1 +
 drivers/pci/host/pcie-tango.c                        | 344 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
 create mode 100644 drivers/pci/host/pcie-tango.c

-- 
2.11.0
