Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595AFC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279D82080A
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2NCdLTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfBLBv1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:51:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44532 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfBLBv0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 20:51:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so453738pfh.11;
        Mon, 11 Feb 2019 17:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMMxpgSAniB8LFv+M0YvWiyKlN5hrWVQrVJB4z8L3aY=;
        b=Q2NCdLTe3L02gUvsERVySCKHaosfpploZ7PksExlTb+pRbqf4g+/w2laNGEF9s3n7D
         BvjDsXKQ1OFHZxurw1RKwZgs5DSysAgHmZweQDOXKH2/UQHJ9GqvpAB72R9krft3vAjY
         qIQazMqb4HojIG9l41zCkgr0+GDKI7/S7ZQjB8ghQOQhArPiu5KYyy3+SM8M9nJm0pbF
         UKigOQyO6c3HcN5ABEj9YlNZjAEj0ZpaMH/xL+Fh+zpkjM0OnH93929okw6KwBhOphdN
         JTEwPuV9p7X6LdPzD719lkpRmGreckTQ0huJhT2+fHfJD4TUX0fcWvXhNLDemxkLj7Qz
         /a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMMxpgSAniB8LFv+M0YvWiyKlN5hrWVQrVJB4z8L3aY=;
        b=fm4C7bVU4+5TOF33/oWA++41RMqXf4kWwQttnqs8HlvKijjhvwznyBZ5qZV+XUvvZc
         utKLASUzDctzm/LkTxFsGO9Evnic7Q5eYrlQGlPHpUA2nG7jk/L7+XrXhYG6RrFCKV8w
         DUVak95jgoJz53EJ7JOPjlraVzu10mIVSFzKR9m7/pHvGgbWMXCayvn6WojZ0w6xkcMf
         wAeeOqb0gvTvwJkjS5MBv1pkOceQ7RoV1iNjzDHuwciHtOfdxs3FxDYIE40eC99oEf1i
         Vq47X4d4NMk0d5PIiISC4FrLg/hzmvWtXcb4i5AM6JxKKjyQSKNUEFbJSEJAmXll4az2
         wv5A==
X-Gm-Message-State: AHQUAuboynhH5PqjZKOnHrsy2QMAIT0ijl1Zu4HyNfBj3DkzX0hSHGGj
        gJQAzR5v2y4sgfHK23Q4FzQ=
X-Google-Smtp-Source: AHgI3IZuyGNGaY3+wbNd56v+9F6Z4rVnNcBqyshgVkthaFjRMDAQfmZ2q/nKFILjhcMsn3X28rVzdg==
X-Received: by 2002:aa7:85cc:: with SMTP id z12mr1418728pfn.196.1549936285714;
        Mon, 11 Feb 2019 17:51:25 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h64sm17146941pfc.142.2019.02.11.17.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 17:51:25 -0800 (PST)
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
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] PCI: imx6: Add code to request/control "pcie_aux" clock for i.MX8MQ
Date:   Mon, 11 Feb 2019 17:51:08 -0800
Message-Id: <20190212015108.16952-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212015108.16952-1-andrew.smirnov@gmail.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe IP block has additional clock, "pcie_aux", that needs to be
controlled by the driver. Add code to support that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
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
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7cdf8f9ab244..1a7031782846 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -65,6 +65,7 @@ struct imx6_pcie {
 	struct clk		*pcie_phy;
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
+	struct clk		*pcie_aux;
 	struct regmap		*iomuxc_gpr;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
@@ -421,6 +422,12 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 		break;
 	case IMX8MQ:
+		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
+		if (ret) {
+			dev_err(dev, "unable to enable pcie_aux clock\n");
+			break;
+		}
+
 		offset = imx6_pcie_grp_offset(imx6_pcie);
 		/*
 		 * Set the over ride low and enabled
@@ -904,6 +911,9 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
+	case IMX8MQ:
+		clk_disable_unprepare(imx6_pcie->pcie_aux);
+		break;
 	default:
 		break;
 	}
@@ -1049,6 +1059,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to get PCIE APPS reset control\n");
 			return PTR_ERR(imx6_pcie->apps_reset);
 		}
+
+		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
+		if (IS_ERR(imx6_pcie->pcie_aux)) {
+			dev_err(dev, "pcie_aux clock source missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_aux);
+		}
 		break;
 	default:
 		break;
-- 
2.20.1

