Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from russell.cc ([43.229.61.17]:59278 "EHLO russell.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754244AbcBQGMx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Feb 2016 01:12:53 -0500
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
	benh@kernel.crashing.org, Russell Currey <ruscur@russell.cc>
Subject: [PATCH] MAINTAINERS: Update EEH details and maintainership
Date: Wed, 17 Feb 2016 17:06:04 +1100
Message-Id: <1455689164-12128-1-git-send-email-ruscur@russell.cc>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enhanced Error Handling could mean anything in the context of the entire
kernel, so change the name to reference that it is both for PCI and
powerpc.

EEH covers a bit more than the previously listed files, so add the headers
and platform-specific code to the EEH maintained section.

In addition, I am taking over the maintainership.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 MAINTAINERS | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28eb61b..95d999e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4222,13 +4222,6 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
 S:	Maintained
 F:	drivers/media/rc/ene_ir.*
 
-ENHANCED ERROR HANDLING (EEH)
-M:	Gavin Shan <shangw@linux.vnet.ibm.com>
-L:	linuxppc-dev@lists.ozlabs.org
-S:	Supported
-F:	Documentation/powerpc/eeh-pci-error-recovery.txt
-F:	arch/powerpc/kernel/eeh*.c
-
 EPSON S1D13XXX FRAMEBUFFER DRIVER
 M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
 S:	Maintained
@@ -8244,6 +8237,15 @@ L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.txt
 
+PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
+M:	Russell Currey <ruscur@russell.cc>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	Documentation/powerpc/eeh-pci-error-recovery.txt
+F:	arch/powerpc/kernel/eeh*.c
+F:	arch/powerpc/platforms/*/eeh*.c
+F:	arch/powerpc/include/*/eeh*.h
+
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
 L:	linux-pci@vger.kernel.org
-- 
2.7.1

