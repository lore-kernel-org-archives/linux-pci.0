Return-Path: <SRS0=+2wZ=A3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A375C433E1
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jul 2020 21:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B4F207E8
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jul 2020 21:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594933531;
	bh=iW7BjEZ60Foe5MOsebfnRJHNZwW9KgJqpGOyAb7JsGU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DLfWWzKZX0m5e//M3UNz3TBtnC+U1QCH1rNS+uSspipU+44oXv2nqkyt2mMqnOPGs
	 4EKpEfQ/F6oiuaaQwgNJheBjUqPdiDpro31KoKik3bY0k5S0AfOa1URPG/5ARSLjln
	 KJExxiYC1zUQQgwMuQdidiMDLf/JWZOoB5mqsE0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgGPVFa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgGPVFa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 17:05:30 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE828207DD;
        Thu, 16 Jul 2020 21:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594933529;
        bh=iW7BjEZ60Foe5MOsebfnRJHNZwW9KgJqpGOyAb7JsGU=;
        h=Date:From:To:Cc:Subject:From;
        b=Xdb4jTIC972OWicAcjGAjt8XjGzG33BuaaDDh1fXUuNHRTg3+ov4YPlKacoLY8xVg
         IhUxhZy0U0c3w9Ff34IlHqy4/D0n9cU6ismqF9BuMYIscA9+I+4ndPiK6U257lHkyB
         IAOn0daYQwoZwyOATyV+mTQdHL2e1y1H6RIib0Xk=
Date:   Thu, 16 Jul 2020 16:10:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] PCI: imx6: Use fallthrough pseudo-keyword
Message-ID: <20200716211052.GA16893@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4e5c379ae418..1119ded593d0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -439,7 +439,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
-	case IMX6QP:		/* FALLTHROUGH */
+	case IMX6QP:
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -642,7 +642,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
 				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -1107,7 +1107,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "pcie_aux clock source missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_aux);
 		}
-		/* fall through */
+		fallthrough;
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
-- 
2.27.0

