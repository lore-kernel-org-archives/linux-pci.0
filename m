Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:5263 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbbIPAjN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 20:39:13 -0400
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH 0/8] Broadcom iProc PCIe fixes and outbound mapping support
Date: Tue, 15 Sep 2015 17:39:14 -0700
Message-ID: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series contains various fixes and outbound mapping support for
the Broadcom iProc PCIe driver. Some of the critical fixes include 1) fix of
PCIe core reset logic and therefore remove its dependency on the bootloader;
2) improved link detection logic that works for more iProc based SoCs.

This patch series also adds the outbound address mapping support. While
outbound address mapping support is not required on chips like North Star,
Cygnus, and etc., some of the newer iProc based chips like North Star 2 require
this support to properly map the AXI address into the address used in the iProc
PCIe core

This patch series is constructed based on Linux v4.3-rc1 (with workaround to
disable calls to pci_read_bridge_bases in pci/probe.c that breaks some of the
ARM based PCIe devices including iProc)

This patch series is tested on the following platforms with an Intel e1000e
based PCIe x1 NIC card:
- ARM32 based Cygnus BCM958305K Wireless Audio board
- ARM64 based North Star 2 SVK board

code available at GITHUB:
https://github.com/Broadcom/cygnus-linux/tree/iproc-pcie-fix-v1

Ray Jui (8):
  PCI: iproc: Fix code comment
  PCI: iproc: Remove unused code
  PCI: iproc: Remove ARCH specific flag
  PCI: iproc: Fix PCIe reset logic
  PCI: iproc: Improve link detection logic
  PCI: iproc: Update iProc PCIe device tree bindings
  PCI: iproc: Add outbound mapping support
  PCI: iproc: Fix compile warnings

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  20 +++
 drivers/pci/host/pcie-iproc-platform.c             |  27 ++++
 drivers/pci/host/pcie-iproc.c                      | 159 +++++++++++++++++++--
 drivers/pci/host/pcie-iproc.h                      |  20 ++-
 4 files changed, 210 insertions(+), 16 deletions(-)

-- 
1.9.1

