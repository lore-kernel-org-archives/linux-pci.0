Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:39514 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaGJMGs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 08:06:48 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so6074413lbj.31
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 05:06:46 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] pci: Add include guard to include/linux/pci_ids.h
Date: Thu, 10 Jul 2014 14:05:11 +0200
Message-Id: <1404993911-10544-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding an include guard frees the preprocessor from reparsing over
2600 #defines in the cases where pci_ids.h is somehow included more
than once. This gives a tiny-but-measurable performance improvement
when compiling such files.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/pci_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 7fa3173..6ed0bb7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -6,6 +6,8 @@
  *	Do not add new entries to this file unless the definitions
  *	are shared between multiple drivers.
  */
+#ifndef _LINUX_PCI_IDS_H
+#define _LINUX_PCI_IDS_H
 
 /* Device classes and subclasses */
 
@@ -2968,3 +2970,5 @@
 #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
+
+#endif /* _LINUX_PCI_IDS_H */
-- 
1.9.2

