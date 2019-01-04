Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C474DC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E24218DE
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxuskCBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfADRtp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:49:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45393 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfADRtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so18614636pfd.12;
        Fri, 04 Jan 2019 09:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGsfwtEO4Mu6yENA4Q+2w4zzaj5XitiKPr8jlGDyGeo=;
        b=YxuskCBM45AXemDIJ2J/t1aM4U212J7AUmDeYvPZaIXjSGh9cy7GbOd7yfKc/NYuHh
         t9oivhxz5ZRzufDm1+dfzLGwj1nYYbWBk29iZbo+1TJU/DHUDlzRFzmRIolbi6ntWDan
         WOfcXmgxq7YT/zJqs4TIYnUv4H5sYKi8o1PeBu/L8OslxCZ/fXzvjWOB0vZcPNHIzr6A
         TjOZP25L4PpmSj5aqL6oeX3sPBmmZ7ZEQawAdNw7NTiJKME9qVsyOoy93Hf4JBiWoV+p
         VT9PnQR00RzoWy/fQFhVVMKIX4P035yXvE2SeLImzJ3lyXeI+xdpGko1hh0VKJRqnvtC
         uPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGsfwtEO4Mu6yENA4Q+2w4zzaj5XitiKPr8jlGDyGeo=;
        b=uf5b+4uqkF/Z3nakCY4uv7NtXFPllyCJEMpLfatc39QzAb7oWR6+NRDcamE3NVeHe8
         Rgss7dueX2N4HAZRkepFL3fPa/fTB7GBM4lfrFSLIJj0W1/bMJRf5KignqHSjKeE+bZA
         rS8257YfLdByR2sguuzWHpaUnAqaOUnLR+X/bLeaZHaHWf6uLYw73O03D63Khm38+2nf
         93i7vWX8ucurHGXY3Lx3vOn87HZ2+/Sl/5u/Gx6fOBzLj0z3OY+UEgGFWNaMZ4pEHwP4
         DMHVppjLcGrLsjeLf+jfYjruq7DsvH49Fp9aLwQmGfVU12EIUt3JYEeyk9bjfpt28zI+
         KSgQ==
X-Gm-Message-State: AJcUukd4L4CE0jnTxfi9bqGM6f5WecFgUa8EovLleFoRoFfmQurUKYIA
        mPmlEdj2n8Y3U6z9RD0tOysjgJyVNPE=
X-Google-Smtp-Source: ALg8bN4hDTKnyz/RSy+cC/+oLPKwkfJ8lmWA+5xUtKcgLiApBqTMtrA3ryaQxQYLrzSgPDJfaCpfPg==
X-Received: by 2002:a63:d5e:: with SMTP id 30mr2431937pgn.54.1546624183460;
        Fri, 04 Jan 2019 09:49:43 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:42 -0800 (PST)
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
Subject: [PATCH v2 02/20] PCI: imx6: Remove redundant debug tracing
Date:   Fri,  4 Jan 2019 09:49:07 -0800
Message-Id: <20190104174925.17153-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All calls to imx6_pcie_wait_for_link() share the same error path and
the state of PHY debug registers will already be printed there.

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
 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c73c7a6a4c55..491a93a02c80 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -677,16 +677,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
 
 	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
-	return -ETIMEDOUT;
+	return dw_pcie_wait_for_link(pci);
 }
 
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
-- 
2.20.1

