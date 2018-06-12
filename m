Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 0/5] Improve Broadcom PAXC support
Date: Mon, 11 Jun 2018 17:21:02 -0700
Message-Id: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

This patch series improves the Broadcom PAXC support by 1) adding more
quirks for specific versions of PAXC controllers; 2) adding logic to
reject internally unconfigured physical functions from the embedded
network processor acting as endpoint; 3) reducing verbose print level
in the outbound/inbound mapping code

This patch series is based off v4.17 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-paxc-v2

Changes since v1:
 - consolidate 2 PAXC related patch series into 1
 - change the way how the capability list corruption is handled, per
recommendation from Bjorn. Now handle and fix up the corruption at
the config register read
 - rebase to v4.17

Ray Jui (5):
  PCI: iproc: Activate PAXC bridge quirk for more devices
  PCI: iproc: Fix up corrupted PAXC root complex config registers
  PCI: iproc: Disable MSI parsing in certain PAXC blocks
  PCI: iproc: Reject unconfigured physical functions from PAXC
  PCI: iproc: Reduce inbound/outbound mapping print level

 drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
 drivers/pci/host/pcie-iproc.h |   8 +++
 drivers/pci/quirks.c          |   3 +
 3 files changed, 144 insertions(+), 26 deletions(-)

-- 
2.1.4
