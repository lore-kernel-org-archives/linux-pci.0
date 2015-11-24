Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, CARLOS.PALMINHA@synopsys.com,
	Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 0/2] adding PCI support to AXS10x
Date: Tue, 24 Nov 2015 14:32:04 +0000
Message-Id: <cover.1448375184.git.jpinto@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
AXS10x. It includes the necessary tweaks to the ARC architecture, necessary
tweaks to the PCI subsystem and a new driver (pcie-snpsdev).
This new driver will be used extensively in the PCIe RC Prototyping Kit.

The patches were produced against the 'next' branch of Bjorn Helgaas'
repository. It was properly tested in an IP Prototyping Kit.

Joao Pinto (2):
  add new platform driver for PCI RC
  PCI support added to ARC

 .../devicetree/bindings/pci/pcie-snpsdev.txt       |  28 ++
 MAINTAINERS                                        |   7 +
 arch/arc/Kconfig                                   |  22 ++
 arch/arc/include/asm/dma.h                         |   5 +
 arch/arc/include/asm/io.h                          |   2 +
 arch/arc/include/asm/mach/pci.h                    |  97 ++++++
 arch/arc/include/asm/pci.h                         |  34 ++
 arch/arc/kernel/Makefile                           |   1 +
 arch/arc/kernel/pcibios.c                          | 360 +++++++++++++++++++++
 arch/arc/mm/ioremap.c                              |  29 +-
 arch/arc/plat-axs10x/Kconfig                       |   1 +
 drivers/pci/Makefile                               |   1 +
 drivers/pci/host/Kconfig                           |   5 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-designware.c                 |  15 +
 drivers/pci/host/pcie-designware.h                 |   1 +
 drivers/pci/host/pcie-snpsdev.c                    | 342 ++++++++++++++++++++
 17 files changed, 950 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
 create mode 100644 arch/arc/include/asm/mach/pci.h
 create mode 100644 arch/arc/include/asm/pci.h
 create mode 100644 arch/arc/kernel/pcibios.c
 create mode 100644 drivers/pci/host/pcie-snpsdev.c

-- 
1.8.1.5

