Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16015 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbcA3LHR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 30 Jan 2016 06:07:17 -0500
From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	dwmw2@infradead.org, jroedel@suse.de, jacek.lawrynowicz@intel.com
Subject: [PATCH v3 0/2] Fixed couple of issues pointed by Alex and Bjorn 
Date: Sat, 30 Jan 2016 12:06:50 +0100
Message-Id: <1454152012-46337-1-git-send-email-jacek.lawrynowicz@intel.com>
In-Reply-To: <1453926324.18221.2.camel@redhat.com>
References: <1453926324.18221.2.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- changed pci_dma_alias_is_enabled to be a static helper
- renamed pci_enable_dma_alias to pci_add_dma_alias
- fixed "exisiting" typo

Jacek Lawrynowicz (2):
  pci: Add support for multiple DMA aliases
  pci: Add DMA alias quirk for mic_x200_dma

 drivers/iommu/iommu.c | 17 ++++++++++-------
 drivers/pci/pci.c     | 21 +++++++++++++++++++++
 drivers/pci/pci.h     |  2 ++
 drivers/pci/probe.c   |  1 +
 drivers/pci/quirks.c  | 28 +++++++++++++++++++---------
 drivers/pci/search.c  | 14 +++++++++-----
 include/linux/pci.h   | 12 +++++-------
 7 files changed, 67 insertions(+), 28 deletions(-)

-- 
2.1.4

