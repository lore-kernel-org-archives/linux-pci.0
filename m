Return-Path: <SRS0=Uw6M=34=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Return-Path: <SRS0=Uw6M=34=sigmadesigns.com=Marc_Gonzalez@kernel.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH v4 0/2] Tango PCIe controller support
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
CC: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David Laight
	<david.laight@aculab.com>, linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Phuong Nguyen
	<phuong_nguyen@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>, Mason
	<slash.tmp@free.fr>
Message-ID: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
Date: Thu, 20 Apr 2017 16:24:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
List-ID: <linux-pci.vger.kernel.org>

Hello,

This patch was split in two, to ease review of two orthogonal
parts (MSI controller and host bridge). NB: the patch is
just split in two where host bridge support starts.

Changes from v3 to v4

In the MSI part:
- Support 256 MSIs instead of only 32
- Define tango_{ack,mask,unmask} callbacks for the HW irq_chip
- Use a spinlock instead of a mutex
- Rename msi_mask register to msi_enable

In the host bridge part:
- Move several quirk-handling snippets out of the config space read function
- Check whether the PCIe link is up at probe-time

Other files
- Let the framework compute the bus-range from the config space width
- Be slightly more verbose in the Kconfig help


What has *not* changed, waiting from feedback from Bjorn:

- Pray that config and mem space accesses NEVER occur concurrently.
- Using of_device_is_compatible() vs of_device_get_match_data()


Marc Gonzalez (2):
  PCI: Add tango MSI controller support
  PCI: Add tango PCIe host bridge support

 Documentation/devicetree/bindings/pci/tango-pcie.txt |  32 ++++
 drivers/pci/host/Kconfig                             |   8 +
 drivers/pci/host/Makefile                            |   1 +
 drivers/pci/host/pcie-tango.c                        | 393 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h                              |   2 +
 5 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
 create mode 100644 drivers/pci/host/pcie-tango.c

-- 
2.11.0
