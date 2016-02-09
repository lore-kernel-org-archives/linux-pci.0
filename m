Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36722 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948AbcBIWKb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 17:10:31 -0500
Received: by mail-pf0-f174.google.com with SMTP id e127so588068pfe.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Feb 2016 14:10:30 -0800 (PST)
From: Bhaskar Jupudi <njupudi@ucsc.edu>
To: linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	cmps107-njupudi <njupudi@ucsc.edu>
Subject: [PATCH] drivers/pci:Broken link fixed
Date: Tue,  9 Feb 2016 14:10:16 -0800
Message-Id: <1455055816-3768-1-git-send-email-njupudi@ucsc.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: cmps107-njupudi <njupudi@ucsc.edu>

Dell developed a way to consistently name devices, 
and their last proposal was accepted under the name biosdevname.

Signed-off-by: Naga Venkata Sai Indubhaskar Jupudi <njupudi@ucsc.edu>
---
Proposal 1 provides a character device interface to ethernet devices.

Proposal 2 is implemented in the same way as proposal 1 except that
device nodes are created without any changes in the kernel.

Proposal 3 is an installer based proposal where it provides the user 
with options to rename network interfaces.

Proposal 4 exports system firmware provided SMBIOS strings on
onboard devices to sysfs.

Proposal 5 uses the firmware provided index to derive ethN names

Proposal 6 is named as biosdevname and renames network interfaces 
to a different names space and accepted upstream.

 drivers/pci/pci-label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 024b5c1..27143a0 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -16,7 +16,7 @@
  * the instance number and string from the type 41 record and exports
  * it to sysfs.
  *
- * Please see http://linux.dell.com/wiki/index.php/Oss/libnetdevname for more
+ * Please see http://linux.dell.com/files/biosdevname/ for more
  * information.
  */
 
-- 
2.5.0


