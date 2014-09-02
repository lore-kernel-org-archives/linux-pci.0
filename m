Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:62128 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbaIBEDt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Sep 2014 00:03:49 -0400
Received: by mail-ie0-f182.google.com with SMTP id rd18so6962476iec.41
        for <linux-pci@vger.kernel.org>; Mon, 01 Sep 2014 21:03:49 -0700 (PDT)
Subject: [PATCH] lspci: Correct Root Capabilities "CRS Software Visibility"
 bit
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rajatxjain@gmail.com
Date: Mon, 01 Sep 2014 22:03:46 -0600
Message-ID: <20140902040346.18691.58345.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

lspci incorrectly tests bit 4, not bit 0, for "CRS Software Visibility" in
the Root Capabilities register, so it shows "RootCap: CRSVisible-" even for
devices that do support Software Visibility.

Use the correct definition for PCI_EXP_RTCAP_CRSVIS.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/header.h b/lib/header.h
index db85df1..8ee7565 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -842,7 +842,7 @@
 #define  PCI_EXP_RTCTL_PMEIE	0x0008	/* PME Interrupt Enable */
 #define  PCI_EXP_RTCTL_CRSVIS	0x0010	/* Configuration Request Retry Status Visible to SW */
 #define PCI_EXP_RTCAP		0x1e	/* Root Capabilities */
-#define  PCI_EXP_RTCAP_CRSVIS	0x0010	/* Configuration Request Retry Status Visible to SW */
+#define  PCI_EXP_RTCAP_CRSVIS	0x0001	/* Configuration Request Retry Status Visible to SW */
 #define PCI_EXP_RTSTA		0x20	/* Root Status */
 #define  PCI_EXP_RTSTA_PME_REQID   0x0000ffff /* PME Requester ID */
 #define  PCI_EXP_RTSTA_PME_STATUS  0x00010000 /* PME Status */

