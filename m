Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:38621 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757348AbcHYFW3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Aug 2016 01:22:29 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        jonathan.yong@intel.com
Subject: [PATCH] Allow pci_enable_ptm to be called outside of the pci subsystem
Date: Thu, 25 Aug 2016 03:41:34 +0000
Message-Id: <1472096495-42916-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow external drivers to enable PTM bits on their respective devices.
Please CC me when replying, thanks.

Yong, Jonathan (1):
  PCI: Export pci_enable_ptm

 drivers/pci/pcie/ptm.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.7.3

