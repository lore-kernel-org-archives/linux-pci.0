Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 0/3] Tango PCIe controller support
Message-ID: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
Date: Wed, 31 May 2017 15:28:50 +0200
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: DT <devicetree@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mason <slash.tmp@free.fr>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Spin v5 to address comments from Marc and Bjorn.

Changes from v4 to v5

- Split the DT binding into a third patch
- Introduce host bridge support first
- Put all MSI stuff in the MSI patch
- Inline 2 single-use functions
- Fix tango_ack
- Allocate irq at probe start
- Print dire message in probe, and taint kernel
	("Lasciate ogne speranza, voi ch'intrate")

Marc Gonzalez (3):
  PCI: Add DT binding for tango PCIe controller
  PCI: Add tango PCIe host bridge support
  PCI: Add tango MSI controller support

 Documentation/devicetree/bindings/pci/tango-pcie.txt |  30 +++
 drivers/pci/host/Kconfig                             |   8 +
 drivers/pci/host/Makefile                            |   1 +
 drivers/pci/host/pcie-tango.c                        | 386 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h                              |   2 +
 5 files changed, 427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
 create mode 100644 drivers/pci/host/pcie-tango.c

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
