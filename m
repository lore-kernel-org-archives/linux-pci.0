Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Paul Bolle <pebolle@tiscali.nl>
CC: Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>, "Ray Jui" <rjui@broadcom.com>
Subject: [PATCH v4 0/4] pci: iproc: Add Broadcom iProc PCIe support
Date: Mon, 9 Mar 2015 17:21:13 -0700
Message-ID: <1425946878-13169-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds the support for Broadcom iProc PCIe controller

pcie-iproc.c servers as the common core driver, and front-end bus
interface needs to be added to support different bus interfaces

pcie-iproc-pltfm.c contains the support for the platform bus interface

Changes from v3:
 - Export symbols of several PCI functions so they can be used by drivers
   compiled as kernel module
 - Add additional support to the Broadcom iProc PCIe driver so it can be
   installed/uninstalled as kernel loadable module

Changes from v2:
 - Major rework of the PCIe driver to factor out common generic code from
   front-end bus interface. Support for generic platform bus interface is
   also added
 - Adapt to several new PCI APIs that have been introduced lately

Changes from v1:
 - Add standard PCI interrupt DT properties "#interrupt-cells",
   "interrupt-map-mask" and "interrupt-map" so legacy INTx interrupts can be
   supported by using standard PCI OF IRQ parsing function
 - Get rid of custom IRQ mapping function in the driver. Use
   of_irq_parse_and_map_pci instead

Ray Jui (4):
  PCI: Export symbols of PCI functions
  pci: iProc: define iProc PCIe platform bus binding
  pci: iproc: Add Broadcom iProc PCIe support
  ARM: dts: enable PCIe support for Cygnus

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |   63 ++++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   42 +++
 arch/arm/boot/dts/bcm958300k.dts                   |    8 +
 drivers/pci/host/Kconfig                           |   17 +
 drivers/pci/host/Makefile                          |    2 +
 drivers/pci/host/pcie-iproc-pltfm.c                |  101 ++++++
 drivers/pci/host/pcie-iproc.c                      |  337 ++++++++++++++++++++
 drivers/pci/host/pcie-iproc.h                      |   39 +++
 drivers/pci/pci.c                                  |    1 +
 drivers/pci/probe.c                                |    1 +
 drivers/pci/remove.c                               |    2 +
 drivers/pci/setup-bus.c                            |    1 +
 drivers/pci/setup-irq.c                            |    1 +
 13 files changed, 615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 drivers/pci/host/pcie-iproc-pltfm.c
 create mode 100644 drivers/pci/host/pcie-iproc.c
 create mode 100644 drivers/pci/host/pcie-iproc.h

-- 
1.7.9.5

