Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:42107 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932302AbcKJVA3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 16:00:29 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH] pci/vmd: Update maintainers file
Date: Thu, 10 Nov 2016 16:10:44 -0500
Message-Id: <1478812244-5519-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Updating MAINTAINERS to reflect the new location of the vmd driver.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 906e969..aefa6bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9318,7 +9318,7 @@ PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
 M:	Keith Busch <keith.busch@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	arch/x86/pci/vmd.c
+F:	drivers/pci/host/vmd.c
 
 PCIE DRIVER FOR ST SPEAR13XX
 M:	Pratyush Anand <pratyush.anand@gmail.com>
-- 
2.7.2

