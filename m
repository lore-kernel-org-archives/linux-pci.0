Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:39748 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab2GMDuF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jul 2012 23:50:05 -0400
From: <gerg@snapgear.com>
To: <linux-pci@vger.kernel.org>, <linux-m68k@vger.kernel.org>
CC: Greg Ungerer <gerg@uclinux.org>
Subject: [PATCH] pci: add pci resource code to build for M68K architecture
Date: Fri, 13 Jul 2012 13:49:41 +1000
Message-ID: <1342151381-15255-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Greg Ungerer <gerg@uclinux.org>

The ColdFire M54xx family of CPU cores (supported by the m68k arch code)
have PCI bus harwdare. We want to be able to use this and will need the
setup-bus.c and setup-irq.c helper functions. So when CONFIG_M68K is enabled
add them to the objs build list.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 drivers/pci/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 01c001f..8d688b2 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_MN10300) += setup-bus.o
 obj-$(CONFIG_MICROBLAZE) += setup-bus.o
 obj-$(CONFIG_TILE) += setup-bus.o setup-irq.o
 obj-$(CONFIG_SPARC_LEON) += setup-bus.o setup-irq.o
+obj-$(CONFIG_M68K) += setup-bus.o setup-irq.o
 
 #
 # ACPI Related PCI FW Functions
-- 
1.7.0.4

