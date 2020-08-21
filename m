Return-Path: <SRS0=IRj4=B7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7912AC433F2
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 03:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5860B20714
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 03:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597982159;
	bh=REcoMS4JGTg3AU+ePV9ELkKsX+LsT2j6+Obk/UhK52A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6kWXmi+0tPSkzWoxaR4bJXbEzDmLDVq7xU/M64JLSxr+TSICRu0V8glkT78VQCAC
	 5mJ2vfkQR6/jxL6aZ5VVHGoNO2xfAr+XYdmqAPK04gSRZXEXjnKAPQt8oGw5UzEDEu
	 sPd2362bivs2FWsu20dom45EESPoP42fdJ8d/JRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHUDz6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:55:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34045 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgHUDz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:56 -0400
Received: by mail-io1-f67.google.com with SMTP id q75so487770iod.1;
        Thu, 20 Aug 2020 20:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SzKekjf6fRGgLEC8a7Q0N4huYSGdxsop7/CqILDTfo=;
        b=n6B3EDPxP0YV6Mcp6xnpT4zsSsGeeXxUm68RA5OO6uBmalyRrgEZennjl28Fg9k6UE
         YWAv3eXzVxREgEk4+7hLuPsoFmdLN7H1tir2F3PK/23y5Ht6Nuk9QNx7tshzeTiqDxye
         J1VqPtOVFYL3IolYXqGaFWbdNTz9OXdpvKNpUrkCL8vTW46GN7KT5mA7Af4yeTQDhFrs
         98Nye+dL1Kvx6afSc+xL6J62KESPHRrnnZ/LhTcByHb2DOLYhwH6zrDqf9Mm01jRJSaK
         lueXR2pCjY4RxWGwYJXpw5D7A+zhJUWyXv2w9bba/mMlwbZeboswx8+rljUYElbytKnQ
         dQhw==
X-Gm-Message-State: AOAM531Kgmkyj+R1VQwfIoBYYMm8UAkNQ5q2yrtsq2/TFSs58m+IoQAm
        eAJzJd+6boeI+srU/C/Q5Q==
X-Google-Smtp-Source: ABdhPJxpMTeiMlYRVgyTNiC9a7PyE7DHTrmOsJRe09lztrnsaJ5bD8KQoQujvIa/rDSeytaaTwHavg==
X-Received: by 2002:a05:6638:25d3:: with SMTP id u19mr821718jat.103.1597982155028;
        Thu, 20 Aug 2020 20:55:55 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:54 -0700 (PDT)
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
Subject: [PATCH v2 22/40] PCI: dwc/imx6: Remove duplicate define PCIE_LINK_WIDTH_SPEED_CONTROL
Date:   Thu, 20 Aug 2020 21:54:02 -0600
Message-Id: <20200821035420.380495-23-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIE_LINK_WIDTH_SPEED_CONTROL is already defined in pcie-designware.h,
so remove it from the i.MX6 driver.

Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 68a09680e728..2b075a468104 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -116,8 +116,6 @@ struct imx6_pcie {
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
 #define PCIE_PHY_STAT_ACK		BIT(16)
 
-#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
 #define  PCIE_PHY_ATEOVRD_EN			BIT(2)
-- 
2.25.1

