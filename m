Return-Path: <SRS0=nDxn=5Z=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=nDxn=5Z=sigmadesigns.com=marc_gonzalez@kernel.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH v9 0/3] Tango PCIe controller support
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
CC: linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	DT <devicetree@vger.kernel.org>, Mason <slash.tmp@free.fr>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>
Message-ID: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
Date: Tue, 20 Jun 2017 10:12:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

Marc Z pointed out that posting partial series is not ideal.
Collect last-minute fixups into a single patch series.

- Bump series to v9 to avoid any ambiguity
- Add Rob's Ack on patch 1

Marc Gonzalez (3):
  PCI: Add DT binding for tango PCIe controller
  PCI: Add tango PCIe host bridge support
  PCI: Add tango MSI controller support

 .../devicetree/bindings/pci/tango-pcie.txt         |  29 ++
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-tango.c                      | 390 +++++++++++++++++=
++++
 include/linux/pci_ids.h                            |   2 +
 5 files changed, 430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
 create mode 100644 drivers/pci/host/pcie-tango.c

--=20
2.11.0
