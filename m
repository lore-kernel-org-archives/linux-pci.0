Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Daney <ddaney.cavm@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v4 0/2] pci: Add host controller driver for Cavium ThunderX PCIe
Date: Tue, 26 Jan 2016 13:46:19 -0800
Message-Id: <1453844781-24380-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

Some Cavium ThunderX processors require quirky access methods for the
config space of the PCIe bridge.

There are two patches:

1) Refactor code in pci-host-generic so that it can more easily be
   used by other drivers.  This splits the driver for CAM and ECAM
   access methods to a separate file from the common host driver code.

2) Add the ThunderX PCIe driver, which leverages the code in
   pci-host-generic

Changes from v3: Add some Acked-by, rebased to v4.5.0-rc1

Changes from v2: Improve device tree binding example as noted by Rob
Herring.  Rename pcie-thunder-pem.* to pci-thunder-pem.* for better
consistency.  Update MAINTAINERS to reflect the changes.

Changes from v1: Split CAM and ECAM code from common driver code as
suggested by Arnd Bergmann.  Fix spelling errors in
pcie-thunder-pem.txt



David Daney (2):
  PCI: generic: Refactor code to enable reuse by other drivers.
  pci, pci-thunder-pem: Add PCIe host driver for ThunderX processors.

 .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 ++++
 MAINTAINERS                                        |   9 +
 drivers/pci/host/Kconfig                           |  11 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pci-host-common.c                 | 194 ++++++++++++++
 drivers/pci/host/pci-host-common.h                 |  47 ++++
 drivers/pci/host/pci-host-generic.c                | 181 +------------
 drivers/pci/host/pci-thunder-pem.c                 | 283 +++++++++++++++++++++
 8 files changed, 593 insertions(+), 177 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
 create mode 100644 drivers/pci/host/pci-host-common.c
 create mode 100644 drivers/pci/host/pci-host-common.h
 create mode 100644 drivers/pci/host/pci-thunder-pem.c

-- 
1.8.3.1
