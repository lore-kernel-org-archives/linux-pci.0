Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:54624 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbF3Hio (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2015 03:38:44 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 30 Jun 2015 13:08:40 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7CB5B394005A
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 13:08:37 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5U7cYfM56295650
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 13:08:35 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5U6WM6O002139
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 12:02:23 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Don't update VF's BAR
Date: Tue, 30 Jun 2015 15:37:14 +0800
Message-Id: <1435649834-3148-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VF BARs are RO zero, so updating VF BARs will not take any effect.
See the SR-IOV spec r1.1, sec 3.4.1.11.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/setup-res.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 232f925..334b394 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -37,6 +37,13 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	struct resource *res = dev->resource + resno;
 
 	/*
+	 * Per SRIOV SPEC 3.4.1.11, VF BARs are RO zero.
+	 * If this is a VF, just return.
+	 */
+	if (dev->is_virtfn)
+		return;
+
+	/*
 	 * Ignore resources for unimplemented BARs and unused resource slots
 	 * for 64 bit BARs.
 	 */
-- 
1.7.9.5

