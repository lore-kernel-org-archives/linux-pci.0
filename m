Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0167FC04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BE52146D
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6NliBIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BE52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeLFHf7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:35:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41374 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbeLFHf6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 02:35:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so10252834pgh.8;
        Wed, 05 Dec 2018 23:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rr95nKWuiBKL9zj7ZRZZsfvYCE/2bA6VDwAU3HZE0ss=;
        b=q6NliBIOs7fYEWBDM0uB2PcJ8j5oxCac/VLQ/MYHoSPFT/e7kWzbM/2tPjh53qLUH4
         uu6j6p2IH71/FLH8irPa1ml0WUWJBr7P9GjeUH3n7GRSi2eT1Y34Au9/4NwBPk6n61V1
         yE6PuXCQxBmj6VUP4qNZkBMEToayNfNadl4Tn7+gPSYMTMZbsngK3lLQH4avJ8fdnna0
         xneZ+xxnvzNCzwSX7ZPZ4jJKag82dA5F/DZIhSI9wxV/RGsG1yKLa2cB9/FZMBt0v5VF
         TYuKh+oMk2KTKYmQLwWZdEHISNiolEeIa5Xs/duzzd7SB8h7m9JaRuJUzWHKvVMUgGUy
         Lagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rr95nKWuiBKL9zj7ZRZZsfvYCE/2bA6VDwAU3HZE0ss=;
        b=tUFNuI3yDqqChJLviy/nKUUdJwyMygO7r2UvupF6LSSoYAQcNHRqJv+Hgq5xmoPEcZ
         lyipfyTZXGReR6TWqgQtW0o4C4XbV9HxSILOyQ+0pYV5nLgZTSnsmc6Tq08IiH8MhdOi
         iximDO9+xkFQh3nFJ4sms5OaybnECMqDRD1Z/ZrwRJXyDDvHa2aIJFzxP9LovbFEz+DG
         JKeloT03SFc01NtXrlje295aPXhflZjn3+gWdRDskwcPHYM+RRyWTFOkcw+Y3sfWXjcc
         pBx3wFjlzbtC7fgNCqTmDiIYZ8rOsCMkdZigyclqxXqA7uJavZePIHXylp8NjW8I/56q
         EOcg==
X-Gm-Message-State: AA+aEWa1fJ9rFKOS4b7Qjz/ajtphpWZJ7X1D22CU/N1Rw1rDtIFrLZ59
        bKswne1bcopOIkYxV2hnUDaQNwVB
X-Google-Smtp-Source: AFSGD/Uj+Z4hxzshIa52t3yofWiY0beMqFci5+lTEddAfHdRvJb/ul6Jt1iEqifzbsgwGNZeHoAwQg==
X-Received: by 2002:a63:588:: with SMTP id 130mr22895466pgf.273.1544081757518;
        Wed, 05 Dec 2018 23:35:57 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v15sm33035894pfn.94.2018.12.05.23.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:35:56 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, bhelgaas@google.com,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
Date:   Wed,  5 Dec 2018 23:35:44 -0800
Message-Id: <20181206073545.10967-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073545.10967-1-andrew.smirnov@gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_pcie_reset_phy()
is applicable.

Cc: bhelgaas@google.com
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Tested-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c140f7987598..3c3002861d25 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -245,6 +245,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
+	if (imx6_pcie->variant == IMX7D)
+		return;
+
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-- 
2.19.1

