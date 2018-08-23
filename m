Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54348 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHWPEU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Aug 2018 11:04:20 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH] tools/pci: Fix compilation warnings
Date: Thu, 23 Aug 2018 13:34:53 +0200
Message-Id: <b2433aaac6ace7b1b9843b520242d9e9185d3685.1535024080.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix compilation warnings:
 - remove unused variables
 - change function return from int to void, since it's not used

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 tools/pci/pcitest.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 9074b47..8ca1c62 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -23,7 +23,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/ioctl.h>
-#include <time.h>
 #include <unistd.h>
 
 #include <linux/pcitest.h>
@@ -43,17 +42,15 @@ struct pci_test {
 	unsigned long	size;
 };
 
-static int run_test(struct pci_test *test)
+static void run_test(struct pci_test *test)
 {
 	long ret;
 	int fd;
-	struct timespec start, end;
-	double time;
 
 	fd = open(test->device, O_RDWR);
 	if (fd < 0) {
 		perror("can't open PCI Endpoint Test device");
-		return fd;
+		return;
 	}
 
 	if (test->barnum >= 0 && test->barnum <= 5) {
-- 
2.7.4
