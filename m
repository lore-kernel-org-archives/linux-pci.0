Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4DDC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 04:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAB12087E
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 04:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hkKz6QKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfCAEwn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:52:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36749 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfCAEwj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 23:52:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id g9so18941852eds.3
        for <linux-pci@vger.kernel.org>; Thu, 28 Feb 2019 20:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X38eFwuBgWp8MGPFCoaU0Ni9s4eRvIBeyKW0QTJB5zs=;
        b=hkKz6QKTvlTwazwOXDF6ItPMBD7Re0DcX/SxZQhrdryfLYyf+S5+dh6XQrHaMNbUGA
         6XmlAzzVmVOpeaYQ8gTlBYcD1rM2g4BLrH32bynQqiGI3JZPu7ROrMOJKdPxFJYtIoDc
         dkAbBVpyfbhzcqmohZa1lU7WBTVPMmMhbOQJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X38eFwuBgWp8MGPFCoaU0Ni9s4eRvIBeyKW0QTJB5zs=;
        b=cB9N1KBkNzigSAPydYMLNB5odUNgc9Y0b1s0f0adtTBoB2DZZG3UK2f8SkyTqooibY
         JNKPCrEGetwBZta1q1teSNhPaZelUxWlN8+EoPmJRkBclgoUZchb/uOoNHffAEWolBOd
         ZTcQzflOtd/fHUxfVvO9FvoT+eDTLbligb8qdMq3/zGu5u0+aHwwXouYPvOm0Egm8MOc
         hYmzT79urS99scfsrNzW5Y3TfYTxflDmFP6OeEpjAl7yPAcIkLGSUTGUj9xJQjwBnvW3
         GoCzwuVCq6Q8lo9DSZRIKZsMF3wnG5UqzkeGIxCX1ce6HDwdn2jyz/6Fk+c/oOdTEHHd
         LXpg==
X-Gm-Message-State: APjAAAVUeCwRhmW7pHZ4A4G43tK0wcjuCn88wf/ZnaD8z541j3ZwyHk4
        sBoDwRXcOggrvWALgzuxB88YAA==
X-Google-Smtp-Source: APXvYqzlRuZ+Hd6UdSYb86E6X+Zw9yihCJW2FRwZ2zrdPfevqFPwmzfRqfsP2jsSZmRsqBgwjQW3XQ==
X-Received: by 2002:a17:906:7f88:: with SMTP id f8mr1665545ejr.108.1551415957130;
        Thu, 28 Feb 2019 20:52:37 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s24sm4300931edd.23.2019.02.28.20.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Feb 2019 20:52:36 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 1/2] PCI: iproc: Add CRS check in config read
Date:   Fri,  1 Mar 2019 10:22:15 +0530
Message-Id: <1551415936-30174-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the current implementation, config read output data 0xffff0001 is
assumed as CRS completion. But sometimes 0xffff0001 can be a valid data.

IPROC PCIe host controller PAXB v2 has a register to show config read
status flags like SC, UR, CRS and CA. So that extra check is added to
confirm the CRS using status flags before reissue config read.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
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

