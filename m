Return-Path: <SRS0=IRj4=B7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F2C433E4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 03:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE2620714
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 03:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597982203;
	bh=ne8AlhncT0eiuLDHjtCHqUt0Zl/WZefn3kr4UHS1ZCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IslERmCoOHmUcvs3EmME8ArHJGx1yO3AAb4LgpeT8D6h/n4xRafifMeNrDj1xRwB1
	 lWMEycALvBAnE9T7h+vv+L295e2gBavfraUvYKV1jAyBh6/okp2TeJ6QttS1vNCJwp
	 18uKrsNE3eMIvyTCYibpZY5bmBv/r+TbeQNF5VwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHUD4i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:56:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37231 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHUD4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:37 -0400
Received: by mail-io1-f66.google.com with SMTP id b16so484576ioj.4;
        Thu, 20 Aug 2020 20:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XnNKAqnUjN1d+iRAazU+IyknAUrI93QopWNUW3GBtYU=;
        b=FLN0NM03b2yX2lx/S1RYV48Lo9pJlBYhzVntqVSlanZoXMlrb1/BSiHxs4KT1JZXub
         qZpAKPSZd0he8i0IS2ZRzIMVJHVZuKeWGzSXyXWrQ/ySLgJsMGLHaccDr1vruA9NNsFe
         z68Hg9vTGj3rFeUG53nP9aKblLAsliasLw0ssi3Rt/1Gk7kBNwBk/FaedpRuiw7x52yG
         LNcAkQ2mRdjGSw/akRdxQKw4L9XGzy9bFLzcBXhAd6wXYsVdZw2ELBGrumCiX84vD5eu
         vApcpD/m15yHx1hs6UdzETQKhHxRPPSOnrklYCKhO7qPRvRBWncpM5NS4enbygFVCSNA
         i1mw==
X-Gm-Message-State: AOAM532EcyuZ+0ne4NAzXnuHT2FRiWmpIq05hZ684EP/say3F6o+nkMc
        L41MBdnbbgxmo/LqfTauelH0nSzLnQ==
X-Google-Smtp-Source: ABdhPJxPpL1HBEw5J8dDBY93Hs+NL1K9mj9gCD0oWmg6OAV5ux8hwc5CFjZikXwoAoAuwpAiqoM2TQ==
X-Received: by 2002:a6b:1454:: with SMTP id 81mr919882iou.50.1597982195816;
        Thu, 20 Aug 2020 20:56:35 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
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
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 33/40] PCI: dwc: Make ATU accessors private
Date:   Thu, 20 Aug 2020 21:54:13 -0600
Message-Id: <20200821035420.380495-34-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ATU registers are only accessed in pcie-designware.c and can be private
to it.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.h | 12 ------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index b2739b96659f..b0a030661860 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -180,31 +180,31 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 		dev_err(pci->dev, "write DBI address failed\n");
 }
 
-u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size)
+static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 {
 	int ret;
 	u32 val;
 
 	if (pci->ops->read_dbi)
-		return pci->ops->read_dbi(pci, pci->atu_base, reg, size);
+		return pci->ops->read_dbi(pci, pci->atu_base, reg, 4);
 
-	ret = dw_pcie_read(pci->atu_base + reg, size, &val);
+	ret = dw_pcie_read(pci->atu_base + reg, 4, &val);
 	if (ret)
 		dev_err(pci->dev, "Read ATU address failed\n");
 
 	return val;
 }
 
-void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
+static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	int ret;
 
 	if (pci->ops->write_dbi) {
-		pci->ops->write_dbi(pci, pci->atu_base, reg, size, val);
+		pci->ops->write_dbi(pci, pci->atu_base, reg, 4, val);
 		return;
 	}
 
-	ret = dw_pcie_write(pci->atu_base + reg, size, val);
+	ret = dw_pcie_write(pci->atu_base + reg, 4, val);
 	if (ret)
 		dev_err(pci->dev, "Write ATU address failed\n");
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c3178c8694eb..f4b871e3d73f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -268,8 +268,6 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val);
 u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
 void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
-u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
-void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen);
@@ -319,16 +317,6 @@ static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
 	dw_pcie_write_dbi2(pci, reg, 0x4, val);
 }
 
-static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
-{
-	dw_pcie_write_atu(pci, reg, 0x4, val);
-}
-
-static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
-{
-	return dw_pcie_read_atu(pci, reg, 0x4);
-}
-
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
 {
 	u32 reg;
-- 
2.25.1

