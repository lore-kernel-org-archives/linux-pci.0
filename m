Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47227C43612
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 04:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A34720855
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 04:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PZ8PS85G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfAREXn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:23:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33712 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfAREXm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 23:23:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so5939268pfb.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Jan 2019 20:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZCj9TpA5+KFGBjGs5bVmzmjZpUi3uoeqcfxLIJ5odhs=;
        b=PZ8PS85GfXUhCAdRhRQY0pdSJSP8MBx/TGZguYjSUzu4EIst3duEXe+a0HiJeLDSDd
         PTR5jBzhNqYJtD/+E+hvni/xq6P7EkW45i+e0VYv2NdmG3Q21uYRq9ax4NR0n5aL6NxW
         i1bh7QDI7msvVq2x+wQdfeIH0Cp0IQprG/Q6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZCj9TpA5+KFGBjGs5bVmzmjZpUi3uoeqcfxLIJ5odhs=;
        b=BzRNipMrwqRDwN7bRMjAs5Q0yH/vM853CQsyPlh81a7Gc1szpczGsqaCaST8s0tGRA
         qdaV8IoOfcbL7dobdoiE2pT1jcAgu7MflZ0KB3AzeihkaqdFlrKIhlyZyLGxCSMdjv9/
         In7gCo9XqCVFBbhrPxqfztHgR+mX73Ff9CumDAnmmf9AlCpcVR8Nhae9X79Ni0XASqEi
         qWylJ+L7YVFey7sX4VmeEhfqETsc4m82KneRRuJHtFjepDdN1YPagcE1CqZR6thBwCwL
         e5uZL5dBId+Y3FqrpDpGDEo0S6t996yeVFgnQtx3V0WIcF7zK2Ues+Q6G+kDCj2wLZJd
         g9sA==
X-Gm-Message-State: AJcUukfvrgDN5jpxbG/YZnjvDNXvsbuVJGRnT+sjdTedu2ZvGeqkR1wE
        O52EuqBvKUsl796Ggym+e+MeUw==
X-Google-Smtp-Source: ALg8bN6E1KdnsZvDicFUGQE1DOjCcL6Bviwc/6eRFGxwreQOn7pbTF7om9HzzNcDW5qDXxiE/Spx6w==
X-Received: by 2002:a63:30c8:: with SMTP id w191mr16623267pgw.120.1547785421639;
        Thu, 17 Jan 2019 20:23:41 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l19sm7339642pfi.71.2019.01.17.20.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 20:23:40 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 2/3] PCI: iproc: CRS state check in config request
Date:   Fri, 18 Jan 2019 09:53:22 +0530
Message-Id: <1547785403-32268-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the current implementation, config read of 0xffff0001 data
is assumed as CRS completion. but sometimes 0xffff0001 can be
a valid data.
IPROC PCIe RC has a register to show config request status flags
like SC, UR, CRS and CA.
So that extra check is added in the code to confirm the CRS
state using this register before reissue config request.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 13ce80f..ee89d56 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -63,6 +63,10 @@
 #define APB_ERR_EN_SHIFT		0
 #define APB_ERR_EN			BIT(APB_ERR_EN_SHIFT)
 
+#define CFG_RD_SUCCESS			0
+#define CFG_RD_UR			1
+#define CFG_RD_CRS			2
+#define CFG_RD_CA			3
 #define CFG_RETRY_STATUS		0xffff0001
 #define CFG_RETRY_STATUS_TIMEOUT_US	500000 /* 500 milliseconds */
 
@@ -300,6 +304,9 @@ enum iproc_pcie_reg {
 	IPROC_PCIE_IARR4,
 	IPROC_PCIE_IMAP4,
 
+	/* config read status */
+	IPROC_PCIE_CFG_RD_STATUS,
+
 	/* link status */
 	IPROC_PCIE_LINK_STATUS,
 
@@ -370,6 +377,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
 	[IPROC_PCIE_IMAP3]		= 0xe08,
 	[IPROC_PCIE_IARR4]		= 0xe68,
 	[IPROC_PCIE_IMAP4]		= 0xe70,
+	[IPROC_PCIE_CFG_RD_STATUS]	= 0xee0,
 	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
 	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
 	[IPROC_PCIE_ORDERING_CFG]	= 0x2000,
@@ -501,10 +509,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
 	return (pcie->base + offset);
 }
 
-static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
+static unsigned int iproc_pcie_cfg_retry(struct iproc_pcie *pcie,
+					 void __iomem *cfg_data_p)
 {
 	int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
 	unsigned int data;
+	u32 status;
 
 	/*
 	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software Visibility only
@@ -525,6 +535,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
 	 */
 	data = readl(cfg_data_p);
 	while (data == CFG_RETRY_STATUS && timeout--) {
+		/*
+		 * CRS state is set in CFG_RD status register
+		 * This will handle the case where CFG_RETRY_STATUS is
+		 * valid config data.
+		 */
+		status = iproc_pcie_read_reg(pcie, IPROC_PCIE_CFG_RD_STATUS);
+		if (status != CFG_RD_CRS)
+			return data;
+
 		udelay(1);
 		data = readl(cfg_data_p);
 	}
@@ -603,7 +622,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	if (!cfg_data_p)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	data = iproc_pcie_cfg_retry(cfg_data_p);
+	data = iproc_pcie_cfg_retry(pcie, cfg_data_p);
 
 	*val = data;
 	if (size <= 2)
-- 
2.7.4

