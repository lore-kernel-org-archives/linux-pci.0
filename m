Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EBC43444
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C1F218CD
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs3tzkr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfADRuR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:50:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39312 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfADRuR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:50:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so17734076pld.6;
        Fri, 04 Jan 2019 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UaA45DYiu1lBKpFMAL9ysyx77C82thANkIMXH/mfBAE=;
        b=Bs3tzkr/uZcCHPaZu2HC5rYTi8GL2xZCuXOZqzuKLivxSlZKMduu5g57xFjts444WS
         aLTTJjrYRcQxVpLNnfPQt6OAoisHm/NSpTJyfXH1d7PytSHs27GbyRNl8SujipOFhyjJ
         NnYUlQHLxMA8ZgnFhxlLbO/haYwJFygVbnASjw7l9I68RaR3h5MyZOhTAKG4USmh1gRP
         ygOOi61RG7LOGat1w7HY23N82Kqk/IV+4VnGyP6ZkLlIFadq7Wf6ag4EMlfirn8HPMh0
         XbJe22qc5MXA1xr4f2TLR+/SemO5mZu9d9crmelJJTrHpoYR2hGIJ+Z8fYPjnxrQrxpe
         mvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UaA45DYiu1lBKpFMAL9ysyx77C82thANkIMXH/mfBAE=;
        b=gIbWFrZmzZ+asUTEYfQwq6V1nVU6NCLW12TkQVKIBtc3QwDg0Bf2b5nePJ6pe9tueE
         FxN4k2d+FO0otan4syajXlPRPpm+jRoq7ia5WH5Cl2lB4a1SMvUwGucBF9VIQO9T0Uxj
         jRHlzko+LVeinEy+9ObKLCe6klEhBL7XraQgLTnmNLq4rNndgfjaGnffqlLq+kpvNYWc
         JMSYX5teA/FTSEPiKYBWxe8uaUITbH+VSgihm7WS7u3AunZtQiwhmq9r6afAG+9PASrN
         ah8lh8n7Tbbr3B/J+NtIrmdpTWsSjQv/9cecm1VRQ8yW0oKjys7oGxiu0+J5Y45xPsRs
         CT7A==
X-Gm-Message-State: AJcUukfvcHW7BbjbKgmwsxIklTFRIEdVIQ0uGVdtmIG+mrZ8eCQsQ6Ew
        fKuCXdRWt2UWZJ2I0KdFf0yg1DvEgU0=
X-Google-Smtp-Source: ALg8bN6KeuZvj5+hH6fAqcxHS1bkhdDruLVrs8+ZmBPnURzylt69qWEgGUKtUB4UE4vpX1xHqF/LzA==
X-Received: by 2002:a17:902:981:: with SMTP id 1mr50372962pln.142.1546624215901;
        Fri, 04 Jan 2019 09:50:15 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:50:15 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/20] PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
Date:   Fri,  4 Jan 2019 09:49:23 -0800
Message-Id: <20190104174925.17153-19-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Explicitly define PCIE_RC_LCSR_LINK_SPEED and remove magic numbers
from imx6_pcie_establish_link(). No functional change intended.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d8aef9da476f..f2aca339e9b7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -96,6 +96,7 @@ struct imx6_pcie {
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
 
 #define PCIE_RC_LCSR				0x80
+#define PCIE_RC_LCSR_LINK_SPEED			GENMASK(19, 16)
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
@@ -766,8 +767,9 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
 
-	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCSR);
-	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
+	tmp = FIELD_GET(PCIE_RC_LCSR_LINK_SPEED,
+			dw_pcie_readl_dbi(pci, PCIE_RC_LCSR));
+	dev_info(dev, "Link up, Gen%i\n", tmp);
 	return 0;
 
 err_reset_phy:
-- 
2.20.1

