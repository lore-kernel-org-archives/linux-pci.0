Return-Path: <SRS0=ngrz=OZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F5CC43612
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516132084A
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXYMqlK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbeLPXJn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:09:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46849 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbeLPXJk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Dec 2018 18:09:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so5384775pfe.13;
        Sun, 16 Dec 2018 15:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThdCHGx7HMeXDSODXXhk1TA+McwuEBwFRrEXyBqC4tY=;
        b=QXYMqlK3GSzfXI7WNRhf3Lz0lj8ztycPnCZijolGGZxyteGhEryVwQu+wNKPAUY+YP
         fo+Tg1U2Uo8OzVLtxtxMbZeWIeoOFNtkWQa3txQbNhbx5isGQaM31MOeLS1EG1V2/Aw/
         PgkX2upipOZOjpz/GhPPaHJ6s4ZBQtHsmZfdAKG7vakzIsckbF/66owIY2jK4U9jH8Gx
         3qTVt5orgN7K0HlBrnD6gTv+hcgH6OBftgBrN9nG/GtjXuyVwCp7aZVSGqBjH/inSNVw
         hNfD4FhGss5YL3gZJRrvma3EFKIvfSU4ng5gKPqww+mXYicev6szBieKPoA833+I0QdV
         OKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThdCHGx7HMeXDSODXXhk1TA+McwuEBwFRrEXyBqC4tY=;
        b=Aw0WuHoqPxun0ZrT/9qNK7YP7kjYEfdZYnZ6PCbAqC3QC41pVu8wRtj05tr8ASoF9Y
         NoYtryDDkB8EXpSIxSNT0XnD5IK5YOqIavVzd/dgfHd55MNkP8BuUteOKkmeO78te0s+
         PBGCxWjK7uDbf958AqqR0do7me7eH9teLIMazIF545M+MZAwMzoj/dbv8xdNni7BlEx/
         dbbsfJLOtab0n892QVpa765N0NGFTavR/ehWM67ZHq1far5XqXU3Esg+peZ1dB0FcQk4
         +adv/bNy7wi2L3TqHR+d0XCuehjX2causI3qEavYfRt76GuVocdvF2cppXc7ctQ3yqpi
         T53w==
X-Gm-Message-State: AA+aEWaEapSu1nLATZw/FNjgijQ40OkSZ5rpfxwzLNhwNCr+6N5UXdal
        S0hrbn4z4TOYISvS1FXcO7JfiyyT
X-Google-Smtp-Source: AFSGD/W1bNEAwXlRjNa/wfgL9IEzOfuTo7fwcKylCFfKncceXmLpYw3zP057F6Lfib8rOiNANa1KIw==
X-Received: by 2002:a63:1013:: with SMTP id f19mr10316563pgl.38.1545001779866;
        Sun, 16 Dec 2018 15:09:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d18sm13837878pfj.47.2018.12.16.15.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 15:09:39 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: imx6: Fixup Kconfig and #endif placement
Date:   Sun, 16 Dec 2018 15:09:14 -0800
Message-Id: <20181216230916.22982-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181216230916.22982-1-andrew.smirnov@gmail.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixup Kconfig, which lost SOC_IMX7D during merge as well as move
"endif" to its original placement to only imx6q_pcie_abort_handler()
when building for AArch64

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig    | 4 ++--
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0c8142529241..b5202ed78762 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -89,8 +89,8 @@ config PCI_EXYNOS
 	select PCIE_DW_HOST
 
 config PCI_IMX6
-	bool "Freescale i.MX6/7 PCIe controller"
-	depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
+	bool "Freescale i.MX6/7/8 PCIe controller"
+	depends on SOC_IMX8MQ || SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e563ca9bdb78..4b7f638b8aff 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -311,6 +311,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 
 	return 1;
 }
+#endif
 
 static int imx6_pcie_attach_pd(struct device *dev)
 {
@@ -389,7 +390,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 				ret);
 	}
 }
-#endif
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-- 
2.19.1

