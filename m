Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:57368 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab2GMV5x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jul 2012 17:57:53 -0400
Received: by qcqs25 with SMTP id s25so391435qcq.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 14:57:52 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id C062D100048
	for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 14:57:50 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 7590418004F
	for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 14:57:50 -0700 (PDT)
Subject: [PATCH 2/2] PCI: add Vendor-Specific Extended Capability header info
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 13 Jul 2012 15:57:50 -0600
Message-ID: <20120713215750.21756.21414.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120713215258.21756.42132.stgit@bhelgaas.mtv.corp.google.com>
References: <20120713215258.21756.42132.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds the fields in the Vendor-Specific Header: ID, Rev, and Length.
There may be multiple Vendor-Specific capabilities, so drivers should use
the VSEC ID to identify the one of interest.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_regs.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index 4b608f5..0f3e814 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -615,6 +615,12 @@
 #define PCI_PWR_CAP		12	/* Capability */
 #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
 
+/* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
+#define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
+#define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)
+#define  PCI_VNDR_HEADER_REV(x)	(((x) >> 16) & 0xf)
+#define  PCI_VNDR_HEADER_LEN(x)	(((x) >> 20) & 0xfff)
+
 /*
  * Hypertransport sub capability types
  *

