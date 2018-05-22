Return-Path: <SRS0=Jy+Z=IJ=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=Jy+Z=IJ=broadcom.com=ray.jui@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 0/2] Improve Broadcom PAXC support
Date: Tue, 22 May 2018 10:05:07 -0700
Message-Id: <1527008709-20786-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

This patch series improves the Broadcom PAXC support by adding logic
to reject internally unconfigured physical functions from the embedded
network processor acting as endpoint. A change is also made to reduce
verbose print level in the outbound/inbound mapping code

This patch series is based off v4.17-rc5 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-paxc-v1

Ray Jui (2):
  PCI: iproc: Reject unconfigured physical functions from PAXC
  PCI: iproc: Reduce inbound/outbound mapping print level

 drivers/pci/host/pcie-iproc.c | 60 ++++++++++++++++++++++++++++++-------------
 drivers/pci/host/pcie-iproc.h |  5 ++++
 2 files changed, 47 insertions(+), 18 deletions(-)

-- 
2.1.4
