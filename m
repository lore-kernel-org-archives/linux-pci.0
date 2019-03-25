Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DC0C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750822085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed4EkdeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfCYLlS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:41:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51778 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfCYLlS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:41:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so8533119wmf.1;
        Mon, 25 Mar 2019 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bouaeZrzTDWAEUndAMh7kdOuqT5P+rPOivmIFXh00dk=;
        b=ed4EkdeTP7uaMAfz6Suk5ikELYipVRI2+2rNaNOtph5+JMQXBmL9W/KNzUkKgwQFjB
         kTgdFBCNHjOx2oT0rXkFrwC2Ul6FufQVSvetMBhoygsWyjUW61LdjeSFyzw/puzUdnDV
         AN4j1fltYQj7CZDxO4FDXIsDBRpBNGm9KkUwnvJ2fNpRjyl3keVciEqHRdl4Iejgw/lJ
         y8ERuFY0AAUeOjuVzX5YM03ChO6US2di3YrDkZ4LphSHOTzaEU+SiljS1AYYn/SlMlWw
         7yYC10IfX6uvkG1oKjBzKBv5KDaG6nkHqT+4bZDMw0X3BuzXjpg2yB7ApOxf7KgF83WS
         lhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bouaeZrzTDWAEUndAMh7kdOuqT5P+rPOivmIFXh00dk=;
        b=pJanK8EAR/+CQLwrIDCwuWHojre7y2W5Jhk4zLgtYqmisZPd2dJMBAZCuMEUchryza
         siil/z6bxOWG2ihF7/vMMbigHCNjPjEGsT8cKPXC315+zvHecPrwYfyyOR5tfh24SMt+
         u5xmnNWzPa5ECmI0+u8oceru9Bpr1NAV8AiD9uOywEzWoI8BO2QQFbBJ7hZJ2t5sJYuz
         oSYA7xAR5bVffJNCP2medk0bO89YMvYaBoqlndNmAEmNQcHCkGmP6+twcDuwStms0JOe
         dtQtYvNdVtsJ65hL9IhxLrEmzNancRnZx84qHou5y/K+/bP4KUh+bIOL1KJ4PpJCbfgo
         5CbQ==
X-Gm-Message-State: APjAAAVTGOt1zk+9W0PxP4txK241x7NFbFUiX2GoVEppZ7WuvV9VyeP7
        gAvun007cOi8Odp/E4tXToIhn6SF
X-Google-Smtp-Source: APXvYqwUBdZuLZjJ93dAMqT5oyBuXz7B2T/BHVAF6UHN7C5jWN+Z0pHEdOTr2F2fKFR7ofWH9pe49g==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr999218wmi.69.1553514076296;
        Mon, 25 Mar 2019 04:41:16 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id f1sm3905730wrt.87.2019.03.25.04.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:41:14 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V4 2/6] PCI: rcar: Replace unsigned long with u32/unsigned int in register accessors
Date:   Mon, 25 Mar 2019 12:40:57 +0100
Message-Id: <20190325114101.10198-2-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325114101.10198-1-marek.vasut@gmail.com>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Replace unsigned long with u32 and unsigned int in register accessor
functions, since they access 32bit registers.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V2: Bundle this patch with other cleanups before resending
V3: Add Wolfram's R-B
V4: Change reg to unsigned int
---
 drivers/pci/controller/pcie-rcar.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 5b8736f0cd6b..3db693b4410e 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -152,14 +152,13 @@ struct rcar_pcie {
 	struct			rcar_msi msi;
 };
 
-static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
-			       unsigned long reg)
+static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val,
+			       unsigned int reg)
 {
 	writel(val, pcie->base + reg);
 }
 
-static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
-				       unsigned long reg)
+static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int reg)
 {
 	return readl(pcie->base + reg);
 }
-- 
2.20.1

