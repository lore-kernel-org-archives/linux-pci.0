Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Alex Barba <alex.barba@broadcom.com>,
	Oza Oza <oza.oza@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 00/12] Additional iProc PCIe host support/fixes
Date: Mon, 31 Oct 2016 17:38:29 -0700
Message-Id: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

This patch series contains various changes and fixes to the iProc PCIe
host driver. It also adds support for the next generation of PAXB and
PAXC based host controllers

This patch series was developed based on v4.9-rc1 and tested on both NS2
SVK and Cygnus wireless audio platform

repo: https://github.com/Broadcom/arm64-linux.git
branch: iproc-pcie-v2

Changes from v1:
 - Fixed varioues typos in the commit message
 - Improved various DT binding patch titles with more specific information

Ray Jui (12):
  PCI: iproc: Improve core register population
  PCI: iproc: Do not reset PAXC when initializing the driver
  PCI: iproc: Add BCMA type
  PCI: iproc: Fix exception with multi-function devices
  PCI: iproc: Added PAXCv2 related binding
  PCI: iproc: Add PAXC v2 support
  PCI: iproc: Remove redundant outbound properties
  PCI: iproc: Making outbound mapping code more generic
  PCI: iproc: Add optional dma-ranges
  PCI: iproc: Add inbound DMA mapping support
  PCI: iproc: Add PAXBv2 binding info
  PCI: iproc: Add support for the next-gen PAXB controller

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  43 +-
 drivers/pci/host/pcie-iproc-bcma.c                 |   1 +
 drivers/pci/host/pcie-iproc-msi.c                  |   1 +
 drivers/pci/host/pcie-iproc-platform.c             |  19 +-
 drivers/pci/host/pcie-iproc.c                      | 942 ++++++++++++++++++---
 drivers/pci/host/pcie-iproc.h                      |  45 +-
 6 files changed, 916 insertions(+), 135 deletions(-)

-- 
2.1.4
