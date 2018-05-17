Return-Path: <SRS0=uItE=IE=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=uItE=IE=broadcom.com=ray.jui@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH INTERNAL 0/3] Add Broadcom PAXC related quirks
Date: Thu, 17 May 2018 10:21:29 -0700
Message-Id: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

This patch series adds quirks to work around a few issues related to
certain revisions of Broadcom PAXC based PCIe root complexes

This patch series is based off v4.17-rc5 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-paxc-quirk-v1

Ray Jui (3):
  PCI: iproc: Activate PAXC bridge quirk for more devices
  PCI: iproc: Fix up corrupted PAXC root complex config registers
  PCI: iproc: Disable MSI parsing in certain PAXC blocks

 drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++-
 drivers/pci/quirks.c          | 98 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 2 deletions(-)

-- 
2.1.4
