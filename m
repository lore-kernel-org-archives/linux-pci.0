Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA4C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 04:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23862145D
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 04:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SsMXJFnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfBEE5u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 23:57:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43034 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfBEE5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Feb 2019 23:57:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so897792pgk.10
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 20:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mGL7QcC1bDOgscis3sOXPMveHiHvdLDsFx5c3yvyr38=;
        b=SsMXJFnJkICPYuOw7nMuSdlZolJ4JyVOFLtAw3igIzPfTG/qcjJ1DE6A67180NANzu
         H8SHtoR/L5VHWTjL4NjUaOHWBteOM9OeP2c4DgdZ4bkPg+HZo7/CGaPk1vfjpVf8K+Jz
         X57LvawCWMTQgoGw1NfpmmSemkSr609sy8dBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mGL7QcC1bDOgscis3sOXPMveHiHvdLDsFx5c3yvyr38=;
        b=fJ9Td6ftMkFQFneq4lmpTqhmOdy0VGc/z7055e+4XNznyaXS0yfcoakCTBeUewOaSr
         tHPxnrE1jUol7jDdrFTsqhv8Xg7r8CTb9XONR+FKFcpiSn3KOLpuCC1sX6PoTSplCuw8
         hl7a4EkXFXJ/nUrHUD0SMupwAjEl9p+pNNdFTrWnW2wS4RUEoD3mm911YgpfcCyLssQt
         PzauJqDzogNibsjwniO3lSFkAO95X2NI/BLYWDJiSOm6siWG+rxfUXWrKWj4/ewLkcir
         20yoxz4QXiCpD7Jf9F2ZjNfSv3ZAzD0News8lgyYdLeIvGii+3dP8Ah3JSuOw6oj/4AQ
         UI1A==
X-Gm-Message-State: AHQUAuaV6OaXVrQLcxP5FF7wKx4fQAclv6fmHZ/UFZsHEmqI+bU3Zxy9
        s+B5Bvu6xNP8gkAtBwOdhxWghg==
X-Google-Smtp-Source: AHgI3IYn/pJ7dHAJ8JID2C384pGVyCW4tbF841XkF6Q3bbpD3vbTbmBpUEEGTeG4MklRgLpuXHTjSA==
X-Received: by 2002:a63:2a44:: with SMTP id q65mr2628356pgq.231.1549342669385;
        Mon, 04 Feb 2019 20:57:49 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r76sm2895164pfb.69.2019.02.04.20.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 20:57:48 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 1/2] PCI: iproc: Add CRS check in config read
Date:   Tue,  5 Feb 2019 10:27:00 +0530
Message-Id: <1549342622-9929-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
References: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the current implementation, config read output data 0xffff0001 is
assumed as CRS completion. But sometimes 0xffff0001 can be a valid data.

IPROC PCIe host controller has a register to show config read request
status flags like SC, UR, CRS and CA. So that extra check is added to
confirm the CRS using status flags before reissue config read.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..b882255 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -60,6 +60,10 @@
 #define APB_ERR_EN_SHIFT		0
 #define APB_ERR_EN			BIT(APB_ERR_EN_SHIFT)
 
+#define CFG_RD_SUCCESS			0
+#define CFG_RD_UR			1
+#define CFG_RD_CRS			2
+#define CFG_RD_CA			3
 #define CFG_RETRY_STATUS		0xffff0001
 #define CFG_RETRY_STATUS_TIMEOUT_US	500000 /* 500 milliseconds */
 
@@ -289,6 +293,9 @@ enum iproc_pcie_reg {
 	IPROC_PCIE_IARR4,
 	IPROC_PCIE_IMAP4,
 
+	/* config read status */
+	IPROC_PCIE_CFG_RD_STATUS,
+
 	/* link status */
 	IPROC_PCIE_LINK_STATUS,
 
@@ -350,6 +357,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
 	[IPROC_PCIE_IMAP3]		= 0xe08,
 	[IPROC_PCIE_IARR4]		= 0xe68,
 	[IPROC_PCIE_IMAP4]		= 0xe70,
+	[IPROC_PCIE_CFG_RD_STATUS]	= 0xee0,
 	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
 	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
 };
@@ -474,10 +482,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
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
@@ -498,6 +508,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
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
@@ -576,7 +595,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	if (!cfg_data_p)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	data = iproc_pcie_cfg_retry(cfg_data_p);
+	data = iproc_pcie_cfg_retry(pcie, cfg_data_p);
 
 	*val = data;
 	if (size <= 2)
-- 
2.7.4

