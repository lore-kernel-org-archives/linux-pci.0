Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41461 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab2KSSe1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2012 13:34:27 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 316/493] pci: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:25 -0500
Message-Id: <1353349642-3677-316-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-pci@vger.kernel.org 
---
 drivers/pci/pci.c   | 2 +-
 include/linux/pci.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 133ffd1..f3ad6f5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -86,7 +86,7 @@ enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
  * the dfl or actual value as it sees fit.  Don't forget this is
  * measured in 32-bit words, not bytes.
  */
-u8 pci_dfl_cache_line_size __devinitdata = L1_CACHE_BYTES >> 2;
+u8 pci_dfl_cache_line_size = L1_CACHE_BYTES >> 2;
 u8 pci_cache_line_size;
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb9d5e9..34862da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1582,7 +1582,7 @@ extern int pci_pci_problems;
 
 extern unsigned long pci_cardbus_io_size;
 extern unsigned long pci_cardbus_mem_size;
-extern u8 __devinitdata pci_dfl_cache_line_size;
+extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
-- 
1.8.0

