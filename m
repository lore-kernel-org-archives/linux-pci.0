Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:21603 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbCYGjv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 02:39:51 -0400
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Scott Branden <sbranden@broadcom.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH 0/2] iProc PCIe driver Kconfig changes
Date: Tue, 24 Mar 2015 23:42:22 -0700
Message-ID: <1427265744-27590-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series contains two patches to address iProc PCIe Kconfig related
issues. The first patch adds more protection to PCIE_IPROC so it cannot be
accidentally enabled for non-ARM based platforms. The second patch changes the
config name of the iProc PCIe platform driver from PCIE_IPROC_PLTFM to
PCIE_IPROC_PLATFORM 

Ray Jui (2):
  pci: iproc: fix PCIE_IPROC in Kconfig
  pci: iproc: change PCIE_IPROC_PLTFM to PCIE_IPROC_PLATFORM

 drivers/pci/host/Kconfig  |    4 +++-
 drivers/pci/host/Makefile |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.7.9.5

