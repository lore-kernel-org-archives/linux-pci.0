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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28030C43444
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF46321872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avaFwitL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfADRuk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:50:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45379 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfADRuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:50:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so17767240pgc.12;
        Fri, 04 Jan 2019 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2zFuyHm8nEdjnfJDmsDhZ6LWDdoDXqHHbGY0Z+L7BY=;
        b=avaFwitLVqF1WLutZiOj/v4o0ynDRwJO+ElVicQxUpG98KuEEireOp+xpZrw0xZwQJ
         ZRAGv4+qsLQgbVhAcF9uO9Y6gEaR+sZjErsYYABnmU8YLifDJOAr0VF8ER7QjkN25cZ4
         Mo4/c65UDgYj6+LWmmHgXokUoyvTIQ3CTnH3FI41NV9oFMT85aFnVRe1VX8RVKjIOCNq
         Tltk/1tpieU8sKkw+F7vxxDoUXpUaTcnEqq8g/doK3gfwhu84q4INt5Vns35qRcqHaQe
         RvzwMLJL867FhnTHC8tW3P40eEa9/NFvtOeq1//QcNhDabh1qto0u2VZxjmCRGkSY690
         BENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2zFuyHm8nEdjnfJDmsDhZ6LWDdoDXqHHbGY0Z+L7BY=;
        b=AVyke1iqSTlXwz1ftaK/iXsVKvwiAJtZIxywVTCjC+ipdFG+bPTupCy+CuxIkgCymw
         bAtZ3ByqCjcDIZRpqSIf/gcs0Lz+3dqVimEYJk+9aK7HHgUXzj+Id0scKzeNxaySkJXw
         cl+qlnvC/ujLqpdahzVNMYGWqLZSANT2qlrXxTZ5t1OkQorhXOtxpnalibi3tpczksea
         k86xOKM5Bj1JQG/NkDmx2OnIe5KmHzvc4F3RohQUrWlWsaG29GXcEgXZqPjqESIo40W8
         /LdQTA56Y/ohcuhaw3s4DMcjsQrrSm/cJ+e75VG3AwYEoOpDYL0FnphmY8Gf8slF6S5E
         2ydQ==
X-Gm-Message-State: AA+aEWYqcDD7i/njUlGk9lRYKqImFXjyPz4VboZyjUNmkwM2HlhIlWAb
        IbVMBCZ9h/dLvi6mt5Tk3cVCVfPRscM=
X-Google-Smtp-Source: AFSGD/UUBJh8pSGiYrD6XyoNobfobXZ/MOuQezUc5bLzOuCVreeYIfxnWKi2HmVlZZroiMi3VbEUZw==
X-Received: by 2002:a62:3811:: with SMTP id f17mr54238299pfa.206.1546624221002;
        Fri, 04 Jan 2019 09:50:21 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:50:20 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2 20/20] PCI: dwc: Remove superfluous shifting in definitions
Date:   Fri,  4 Jan 2019 09:49:25 -0800
Message-Id: <20190104174925.17153-21-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Surrounding definitions no longer use explicit shift, so "<< 0" here
serve no purpose. Remove them. No functional change intended.

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
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0de653284fca..636689fd4ee7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -63,14 +63,14 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
-#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
-#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
-#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
+#define PCIE_ATU_REGION_INDEX2		0x2
+#define PCIE_ATU_REGION_INDEX1		0x1
+#define PCIE_ATU_REGION_INDEX0		0x0
 #define PCIE_ATU_CR1			0x904
-#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
-#define PCIE_ATU_TYPE_IO		(0x2 << 0)
-#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
-#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
+#define PCIE_ATU_TYPE_MEM		0x0
+#define PCIE_ATU_TYPE_IO		0x2
+#define PCIE_ATU_TYPE_CFG0		0x4
+#define PCIE_ATU_TYPE_CFG1		0x5
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
-- 
2.20.1

