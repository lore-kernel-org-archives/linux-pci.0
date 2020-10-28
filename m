Return-Path: <SRS0=7A2k=EE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCA9C5DF9E
	for <linux-pci@archiver.kernel.org>; Thu, 29 Oct 2020 02:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBC820878
	for <linux-pci@archiver.kernel.org>; Thu, 29 Oct 2020 02:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603937505;
	bh=9tWTy0cTI1lNCMQSEqQbwdTkS7i9759vvGAz9FjnCto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HyaKsFRwgrPohMuLBVDn+jQWwNqzDwS+N2X1kL8+JJwDv1QLjyPDhmwE8ip+7nsTL
	 KZKUveaYug1mvSLdsNCw/grte9bSuvVjy+2mI7MTgiD83LffHrV9WDx7/SnX/0pHIW
	 IxRb+/zcjDNLdsLI1GDtkUoc78NW3nSIM6oLWpgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgJ2CLm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:11:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42976 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgJ1Vgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:36:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id c72so1085835oig.9;
        Wed, 28 Oct 2020 14:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxZqaaZeM9rn0EmiB2pyN8ld61KaiAeovfT1I1hXfhU=;
        b=jbkO+wvKRRV3ikg+PXT6GNDQITwfA3vVwTdPYx0DX304QJLoL3iYGJU9kGkea4QsLg
         GFosw2jnRLw76ggy/mlmZkKpbhFIvEtYd3iR9wt6s3GsVTirIXGDeNtcOkGr6cM80jjI
         EDMTFO+7kKfERpJs+H+u6URrbYKFcWyVLwayn+RJ7CLP83iaH4Bq//LFLIxKUTvz+Cdi
         ohl74w1RLlcr27TbwH9hSxv4xenBUZ8YF1TNQsLULpyDR0M1c+pEHjP3sjG/uHLKutaE
         UDTM2E1N3Go8RrRoxGt71qSMddD6V74lyen002ctLOC8o3FSs5TNMH2MwcBT2mu5RBDq
         A//w==
X-Gm-Message-State: AOAM530w8M92wwaD28+mOG/gEsmLVsYB3Z1Y0tlQNNKxSyYYw5cXGrdU
        BKgRLg7064v5/zwmr/0HQTptQ6Hogw==
X-Google-Smtp-Source: ABdhPJyFp7QnoFosByRfbGom+wWmaa8T9lbdi9qswtTyff4qMNEAI9VDyjl5mqDEBjA5fFbiY8f1Ew==
X-Received: by 2002:a54:4194:: with SMTP id 20mr606316oiy.137.1603918027560;
        Wed, 28 Oct 2020 13:47:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t17sm116123oor.3.2020.10.28.13.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:47:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [PATCH 07/13] PCI: dwc: Drop the .set_num_vectors() host op
Date:   Wed, 28 Oct 2020 15:46:40 -0500
Message-Id: <20201028204646.356535-8-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028204646.356535-1-robh@kernel.org>
References: <20201028204646.356535-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's no reason for the .set_num_vectors() host op. Drivers needing a
non-default value can just initialize pcie_port.num_vectors directly.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 19 ++++---------------
 .../pci/controller/dwc/pcie-designware-plat.c |  7 +------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 drivers/pci/controller/dwc/pcie-tegra194.c    |  7 +------
 4 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 265a48f1a0ae..1bd6a9762426 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -365,22 +365,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pci->link_gen = of_pci_get_max_link_speed(np);
 
 	if (pci_msi_enabled()) {
-		/*
-		 * If a specific SoC driver needs to change the
-		 * default number of vectors, it needs to implement
-		 * the set_num_vectors callback.
-		 */
-		if (!pp->ops->set_num_vectors) {
+		if (!pp->num_vectors) {
 			pp->num_vectors = MSI_DEF_NUM_VECTORS;
-		} else {
-			pp->ops->set_num_vectors(pp);
-
-			if (pp->num_vectors > MAX_MSI_IRQS ||
-			    pp->num_vectors == 0) {
-				dev_err(dev,
-					"Invalid number of vectors\n");
-				return -EINVAL;
-			}
+		} else if (pp->num_vectors > MAX_MSI_IRQS) {
+			dev_err(dev, "Invalid number of vectors\n");
+			return -EINVAL;
 		}
 
 		if (!pp->ops->msi_host_init) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 562a05e07b1d..13fede1d4157 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -44,14 +44,8 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static void dw_plat_set_num_vectors(struct pcie_port *pp)
-{
-	pp->num_vectors = MAX_MSI_IRQS;
-}
-
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 	.host_init = dw_plat_pcie_host_init,
-	.set_num_vectors = dw_plat_set_num_vectors,
 };
 
 static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
@@ -128,6 +122,7 @@ static int dw_plat_add_pcie_port(struct dw_plat_pcie *dw_plat_pcie,
 			return pp->msi_irq;
 	}
 
+	pp->num_vectors = MAX_MSI_IRQS;
 	pp->ops = &dw_plat_pcie_host_ops;
 
 	ret = dw_pcie_host_init(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ed19c34dd0fe..96382dcb2859 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -171,7 +171,6 @@ enum dw_pcie_device_mode {
 
 struct dw_pcie_host_ops {
 	int (*host_init)(struct pcie_port *pp);
-	void (*set_num_vectors)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
 };
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f8fca6794282..5e2841f58700 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -990,11 +990,6 @@ static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
-static void tegra_pcie_set_msi_vec_num(struct pcie_port *pp)
-{
-	pp->num_vectors = MAX_MSI_IRQS;
-}
-
 static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
@@ -1019,7 +1014,6 @@ static const struct dw_pcie_ops tegra_dw_pcie_ops = {
 
 static struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
 	.host_init = tegra_pcie_dw_host_init,
-	.set_num_vectors = tegra_pcie_set_msi_vec_num,
 };
 
 static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
@@ -1995,6 +1989,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pci->n_fts[1] = FTS_VAL;
 
 	pp = &pci->pp;
+	pp->num_vectors = MAX_MSI_IRQS;
 	pcie->dev = &pdev->dev;
 	pcie->mode = (enum dw_pcie_device_mode)data->mode;
 
-- 
2.25.1

