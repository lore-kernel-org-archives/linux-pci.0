Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31699 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbcHHTOb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 15:14:31 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/3] Limiting pci access requests
Date: Mon,  8 Aug 2016 13:14:24 -0600
Message-Id: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We observe that error handling and device hot removal creates many
unnecessary config and memory accesses to devices, some of which are not
even present. While we expect command processing to proceed, we observe
on various platforms that the unnecessary accesses create instability
with hardware performing completion synthesis, and slows down handling
of such error events as well as normal IO processing.

This patch series aims to reduce unnecessary accesses.

Keith Busch (3):
  pcie: Don't search capabilities on removed devices
  pci/msix: Skip disabling removed devices
  pcie/aer: Cache capability position

 drivers/pci/msi.c             |  5 +++++
 drivers/pci/pci.c             |  2 +-
 drivers/pci/pcie/aer/aerdrv.c | 38 +++++++++++++++++---------------------
 drivers/pci/pcie/aer/aerdrv.h |  1 +
 4 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.7.2

