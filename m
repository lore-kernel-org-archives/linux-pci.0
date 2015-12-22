Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] pci: Add host controller driver for Cavium ThunderX PCIe
Date: Mon, 21 Dec 2015 17:53:40 -0800
Message-Id: <1450749222-15966-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

Some Cavium ThunderX processors require quirky access methods for the
config space of the PCIe bridge.

There are two patches:

1) Refactor code in pci-host-generic so that it can more easily be
   used by other drivers.

2) Add the ThunderX PCIe driver, which leverages the code in
   pci-host-generic

David Daney (2):
  PCI: generic: Refactor code to enable reuse by other drivers.
  pci, pcie-thunder-pem: Add PCIe host driver for ThunderX processors.

 .../devicetree/bindings/pci/pcie-thunder-pem.txt   |  43 ++++
 drivers/pci/host/Kconfig                           |   6 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-host-generic.c                |  53 ++--
 drivers/pci/host/pci-host-generic.h                |  56 ++++
 drivers/pci/host/pcie-thunder-pem.c                | 283 +++++++++++++++++++++
 6 files changed, 407 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-thunder-pem.txt
 create mode 100644 drivers/pci/host/pci-host-generic.h
 create mode 100644 drivers/pci/host/pcie-thunder-pem.c

-- 
1.8.3.1

