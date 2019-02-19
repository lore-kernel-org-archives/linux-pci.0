Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2ECC4360F
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B723021773
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExGmZZHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfBSUER (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:04:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42093 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfBSUEP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 15:04:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so10933339plp.9;
        Tue, 19 Feb 2019 12:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOrFyuS90LqtoruGZQ65onq0a4QdxsrTnhK0HpBAldc=;
        b=ExGmZZHMJkg3u9OTKDoU6CCkSbgS+0X12DwR4A9Kul4Uc9A4dJMK9tC41OY6d5a9Aw
         aglv0JYk/EC04WF1sZDFpRcUzT920K3kqaF3OTvXmaPgQakA8Lxf0n2CHy2zZFUJOH1P
         ZdGLnpsVsX9j9xJVJaiWHxNAL1Da9ACaADQVn+kS5txtuer1F5e5fg0ImOotxr7syKmU
         Zg0PkSB55QlPBaNkBjnM2LtTtjQSOm774p+m3Ru0am6yp72tcDrP8dNiUh8EVoG5Kzj+
         vb9NJKu5Wj3ED3Ylgy3n7yEiUJxkSN5ebyMQ6EgsjdWnVUp3nYXagfA8Mt6ILQEvTpII
         RqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOrFyuS90LqtoruGZQ65onq0a4QdxsrTnhK0HpBAldc=;
        b=aSzH5AEYqb8/XW87xh5xEfvL/Th0J6I6ra5HuAXM12rWK1ewSKnvT4EWQ776QqmybC
         A+GA/RxBCMbmiGEKWu1JRgbwh+aMUwHE4TgnU+0EgEn/rvEcj+MLcfBUTMZeidt84kVI
         RiRS8J7zZNcniFY3nqh6WvaoXhVjdQ4+1GSNoC871bv5xBqproCSH7sYlOrwq4ReDNRe
         UCL4FiFOoVkL/5B55pHbAdI609pJRZeKkScLgObUU6eJQYn37zdMN52pZQSsl93CfYTn
         3WA/m/AMGn/uyhqpvFzCI8VjSnq48tK9uNwYVX1SJR/iMXsanEgP616w45cdhbLEzUA2
         t54Q==
X-Gm-Message-State: AHQUAuad9eI0RglfaETcL+A530+B2vsK0epDnp0PRzIik3JTPuuAHbYh
        3JUqGk1AaG6ltAZTYtK7eVk=
X-Google-Smtp-Source: AHgI3Iaok4AZgi6TJpw48i3eaqZf3u11jkTAsAOrUkZ2mXkf+ku18NlCOMapd64px1h1GQ/s2/axCw==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr32430815plp.118.1550606654870;
        Tue, 19 Feb 2019 12:04:14 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:04:14 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/5] PCI: dwc: Make use of IS_ALIGNED()
Date:   Tue, 19 Feb 2019 12:02:38 -0800
Message-Id: <20190219200242.17243-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make the intent a bit more clear as well as get rid of explicit
arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
"size". No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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
2.20.1

