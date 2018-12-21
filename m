Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC87C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E26F21903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShvpZPrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbeLUHaE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:30:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42665 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387631AbeLUH1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:27:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so2177445pfr.9;
        Thu, 20 Dec 2018 23:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUwToKhhL89vx1LjgzipUu4yk4Mqqx0vIAofTHjHZac=;
        b=ShvpZPrvcZfDw0J1ASzD0s3YT+jY0oS1MadiUlCWWjzz5X5zDssoIvCHAloq9QV5xC
         NjF1rpzikWkybtHcGu4YjiZKY4KAoohtfSZsMzW1qJB+ZSiDdNcHxyug7LkwUWD5OpTk
         qmksrnvAHxMg9bf3m5lOM4e7opmqBfi2JuMtRoBinthmsui86Y5DvN1TzH8lKSWPBgWh
         xCjIGY45Q6rwEo5Bm/5Vo8c6WxKZO2lCzUp0tchyY/Odxeyts6XvWLZjmlZhEtuekZCE
         UlTYTDThf99GmmFa6/nTdxRaY+Jr7AJymU93pMSI6FDUAjJHf3J/K4+4q5TDxLV9RDrS
         PerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUwToKhhL89vx1LjgzipUu4yk4Mqqx0vIAofTHjHZac=;
        b=EhpsuuXV3TGAN0ycM5PrmJo45kMjY11LpmvEhlhVIsjT6pCKX6RyGXt/xb6w9VpWNC
         Ei8BK4jK/lM+HNykHA5SBx2fwCjbXWuj39fbXko+tYWOJ7cFobgi+1sQvotQ6+aBbWXC
         O4DmIOl1ST7w1S4CDPOX5VTdbogj9fJG6RKuXbijCSffXI+5vN+TkMaeqEft36MdYwMX
         YbLneWqEwBeUIDxgvkdkPC37y1+Xxb8s5M+RlXTPCqzo0853/5Td08IPWu3uisGSxtp1
         OhqjOIDVxuYSqFNVGHQTxzjoheVj3Ph+7mV7CZM5Bc6hmnLi4sNKgrAIxiACWftPOMSC
         3DwA==
X-Gm-Message-State: AA+aEWZbgoYqRy3NlJ0sNLTYk8Tar61RClVoJic2UgR7wJ+65RiAbN/U
        o7XSV6x//kl8T7lePq8RitF/O+0f
X-Google-Smtp-Source: AFSGD/VUQQi8yisb9aoewB9+qE7nuQLuYz8kYTpt3NojM7V2vPNF3ZlRLRnTQ6Sz6/Yix3QYYdtGqw==
X-Received: by 2002:a62:a99:: with SMTP id 25mr1380678pfk.121.1545377272845;
        Thu, 20 Dec 2018 23:27:52 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:52 -0800 (PST)
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
Subject: [PATCH 07/21] PCI: designware: Make use of IS_ALIGNED()
Date:   Thu, 20 Dec 2018 23:27:02 -0800
Message-Id: <20181221072716.29017-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make the intent a bit more clear as well as get rid of explicit
arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
"size". No functional change intended.

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
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 93ef8c31fb39..67236379c61a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -22,7 +22,7 @@
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
-	if ((uintptr_t)addr & (size - 1)) {
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
@@ -43,7 +43,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 
 int dw_pcie_write(void __iomem *addr, int size, u32 val)
 {
-	if ((uintptr_t)addr & (size - 1))
+	if (!IS_ALIGNED((uintptr_t)addr, size))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (size == 4)
-- 
2.19.1

