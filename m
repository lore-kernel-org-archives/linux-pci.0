Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33858 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbbD3ERF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Apr 2015 00:17:05 -0400
From: Pratyush Anand <panand@redhat.com>
To: bhelgaas@google.com, jg1.han@samsung.com
Cc: linux-pci@vger.kernel.org, mohit.kumar.dhaka@gmail.com,
	Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH] MAINTAINERS: Update SPEAr13xx and Designware PCIe maintainer
Date: Thu, 30 Apr 2015 09:46:07 +0530
Message-Id: <dd210909090e843e8f7cfc84479af7baa2250d33.1430366548.git.panand@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@gmail.com>

Didn't add myself as Maintainer earlier, as I was moving out of ST
and didn't had a board to test. But learnt recently that, its fine being
in MAINTAINERS in such situations, at least I can review the patches.

So, let me add myself.

Signed-off-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68e96ee0d58c..69ce49782ff9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7553,6 +7553,7 @@ F:	drivers/pci/host/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSIS DESIGNWARE
 M:	Jingoo Han <jg1.han@samsung.com>
+M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*designware*
@@ -7566,8 +7567,9 @@ F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
 F:	drivers/pci/host/pci-host-generic.c
 
 PCIE DRIVER FOR ST SPEAR13XX
+M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
-S:	Orphan
+S:	Maintained
 F:	drivers/pci/host/*spear*
 
 PCMCIA SUBSYSTEM
-- 
2.1.0

