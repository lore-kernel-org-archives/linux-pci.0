Return-Path: <SRS0=IRj4=B7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB7AC433F2
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 03:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5BC20714
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 03:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597982132;
	bh=avlYQYDa43gq3HW+8hxTeqVnB2TX3Li25wEwXpt3SIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zAIsYjxkr2Y5yhV57ULQcfoBmXtJimuFjmevV0hYWOuijeKnE4U9A/YjhXiCu8cLQ
	 2XetWA1A0iuJGPs71V/vOuBJA7T6bthZMpwDt+qGut5KWX3JDYsG4sRpcTmAhosYYV
	 o2aFlhYRuteFD2o+9G/kTo2Y2bdWYwz4K3PxU28k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHUDz3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:55:29 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38770 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgHUDz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:28 -0400
Received: by mail-il1-f193.google.com with SMTP id 77so337944ilc.5;
        Thu, 20 Aug 2020 20:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcT/tBt5hzVcOFIbbxsACp+IaB0FfUbF9lTytCWuySo=;
        b=Yrzvlp2Vi/+cSl2cg2rcd2F7Syq+hqnAeE0eQZQbNJVIOsPEayJcH2Y6hY5iAgKWaK
         rl35vRuYTMcttHeg4kJmZnhemDKZyyJ6cj4Tq9C+/HaES3vZLdNBirg4/JutOrRnVFHy
         FYxYfDWnxDJ7wOSMVd7jy/BdUDmC540EpSIEvzcu61O914nTmdZKFQRLoMSDmo+BHQ5f
         aVo0TS1zbZgRdCCY3mnkJ5LJi9gdgNm0PEIDvF8hTYQnzVcj1IXvTbHC//oJbsANunev
         xUwHD11ciK+YB9dWcpq/XwUHhD3feLg4g/c0xBCAUUS5gLOZkhTnhioFudpSwgNGsLm0
         j0nA==
X-Gm-Message-State: AOAM531DSVGrZoExLdVC86ZTJe7eY8F76KsAr0Cb83th1vCsPn6TYW2y
        d1BobwEbixrmxDM7+jRKJg==
X-Google-Smtp-Source: ABdhPJwb+JNqT15FRuhKwW2bKzsNM7yeAHD0rWW3xkgvROAQ42nkfFVQ2Kjlc+K/WmlwAfYFGPHgyA==
X-Received: by 2002:a92:6a0c:: with SMTP id f12mr952021ilc.213.1597982126498;
        Thu, 20 Aug 2020 20:55:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:25 -0700 (PDT)
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
Subject: [PATCH v2 16/40] PCI: dwc: Convert to use pci_host_probe()
Date:   Thu, 20 Aug 2020 21:53:56 -0600
Message-Id: <20200821035420.380495-17-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that there are no more .scan_bus() callbacks, we can remove it and just
use pci_host_probe().

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 21 +++----------------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 07791b4ebaa7..42b13a7a7383 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -300,7 +300,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource_entry *win;
-	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
 	int ret;
@@ -436,23 +435,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	bridge->sysdata = pp;
 
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret)
-		goto err_free_msi;
-
-	pp->root_bus = bridge->bus;
-
-	if (pp->ops->scan_bus)
-		pp->ops->scan_bus(pp);
-
-	pci_bus_size_bridges(pp->root_bus);
-	pci_bus_assign_resources(pp->root_bus);
-
-	list_for_each_entry(child, &pp->root_bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(pp->root_bus);
-	return 0;
+	ret = pci_host_probe(bridge);
+	if (!ret)
+		return 0;
 
 err_free_msi:
 	if (pci_msi_enabled() && !pp->ops->msi_host_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 4ed59b051b2b..6cd61892f24f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -161,7 +161,6 @@ enum dw_pcie_device_mode {
 
 struct dw_pcie_host_ops {
 	int (*host_init)(struct pcie_port *pp);
-	void (*scan_bus)(struct pcie_port *pp);
 	void (*set_num_vectors)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
 };
-- 
2.25.1

