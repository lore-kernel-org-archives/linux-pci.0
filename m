Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712B9C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F52D218FE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FDPIhd/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfDXFU1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:20:27 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5554 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXFU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 01:20:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbff2200000>; Tue, 23 Apr 2019 22:20:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 22:20:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Apr 2019 22:20:26 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 05:20:25 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Apr 2019 05:20:25 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cbff2140001>; Tue, 23 Apr 2019 22:20:25 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 01/16] PCI: Add #defines for some of PCIe spec r4.0 features
Date:   Wed, 24 Apr 2019 10:49:49 +0530
Message-ID: <20190424052004.6270-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424052004.6270-1-vidyas@nvidia.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556083232; bh=wxJ5+q+g/kFpZR8p8vZjwPAwisePUDBAR1J9fMSkOWE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FDPIhd/6lZrSefreRnfl6TLul5tQfBCgGkPb4PtJkTN8xP3Tqk67UHXWVc2PFObK7
         9Eom9Ych18uopwrHAsOZ+RnynxjnA9EZcrxssTQ9rPE2nHEuwf6BEsFeDd7icpYZ3f
         KgUIg7FD0kClibQgvZswGEeE1O/QN9feRo8sOl5woQY/qMcBfWYjxaOZmxfgVzTBIW
         ghXHiKNFK4ONxUTPYarbCXZS7Nroizut84KrRIULws0xdHHiG9vwnao0IGveH0fr12
         asTNcdxboVHIyHa5Ptm2ZUfMJ2fgmohE5LQBDiCorR+D355bfZfhp6aCsf8F4i8ZzO
         cwhDRSKJeTinQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add #defines only for the Data Link Feature and Physical Layer 16.0 GT/s
features.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
Changes from [v4]:
* None

Changes from [v3]:
* None

Changes from [v2]:
* Updated commit message and description to explicitly mention that defines are
  added only for some of the features and not all.

Changes from [v1]:
* None

 include/uapi/linux/pci_regs.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f7d3e7831fa8..4da04b1faab3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -703,7 +703,9 @@
 #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
+#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
+#define PCI_EXT_CAP_ID_PL	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1043,4 +1045,22 @@
 #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
 #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
 
+/* Data Link Feature */
+#define PCI_DLF_CAP		0x04	/* Capabilities Register */
+#define  PCI_DLF_LOCAL_DLF_SUP_MASK	0x007fffff  /* Local Data Link Feature Supported */
+#define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
+#define PCI_DLF_STS		0x08	/* Status Register */
+#define  PCI_DLF_REMOTE_DLF_SUP_MASK	0x007fffff  /* Remote Data Link Feature Supported */
+#define  PCI_DLF_REMOTE_DLF_SUP_VALID	0x80000000  /* Remote Data Link Feature Support Valid */
+
+/* Physical Layer 16.0 GT/s */
+#define PCI_PL_16GT_CAP		0x04	/* Capabilities Register */
+#define PCI_PL_16GT_CTRL	0x08	/* Control Register */
+#define PCI_PL_16GT_STS		0x0c	/* Status Register */
+#define PCI_PL_16GT_LDPM_STS	0x10	/* Local Data Parity Mismatch Status Register */
+#define PCI_PL_16GT_FRDPM_STS	0x14	/* First Retimer Data Parity Mismatch Status Register */
+#define PCI_PL_16GT_SRDPM_STS	0x18	/* Second Retimer Data Parity Mismatch Status Register */
+#define PCI_PL_16GT_RSVD	0x1C	/* Reserved */
+#define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.17.1

