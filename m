Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF8C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651B821903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLSqRc9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbeLUH2W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38951 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388687AbeLUH2T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so2180675pfc.6;
        Thu, 20 Dec 2018 23:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8dhLzSnPx3HKyxwtCcSuNx1W6yfU30Y/Wfx+1/N/Vew=;
        b=bLSqRc9dwd9ei5Ve+zw/9pLETxqpu8pBnK9BeL8a2X3DonypYSPOmVeYpocbvhAmZi
         OblCtyzJyjuoDulFLvvONYRpinSVdrHXiYRe7vPro4Eq5n7SH0FsQcTZiOh9xsv09uYF
         yroXC7ScFFbGTjW9qaa+z67bAKFqMkdzQZvLO4G9Z2Zw2JfJKj2ypNX5GlKIhEuhKqWw
         JUO1ml2sFBMha9Tp2dl9KpDVUqhf9mTY5MutviY1sIP6RFa3R3fuUL+F8d4h5J6bl6A/
         JFkOcIQwYFNHwR61CL2e4DT/DxT4PmmtA8Hct8PEsbpyqA/QxKlMlYUPa5xeMvs1twYZ
         dGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8dhLzSnPx3HKyxwtCcSuNx1W6yfU30Y/Wfx+1/N/Vew=;
        b=K6tIIA9oWiO0dynSyk+5Wdo7dDP4gcIpEoLAV6u86LZ56RMBSSajs5VAmmlaUyzLYW
         QDHLGU0oBy58a4M7BrGy6gq2xO1lKl9RY5VcP+D4S8+oUgE5ur5RjdMgjLrRNDUPvgRE
         cXCB0Djj9VwASVtTIBG6/gZAOiirQGdZTxpz6j2cE4yjm5zXzbyQ7S5H6C9YZKJqRb8C
         6cprfusSkZ+hAjJ3iUoe+Sfg62kvLqFXSu8Obd1vimOwy2vdZCdXwgnEK61wKo+BzSZQ
         uMJp6j1T8AG7QviMW1f6qa864NrvjVQFbpiG90yFN26QwOXjwGgUZwGuz/U3h2Y7LciP
         TiMg==
X-Gm-Message-State: AA+aEWZKAW8c8u9ezmAx4gtvX4hKBkwZ9HEc4Fxp7ltMyDLdTDn8l+QC
        DmRd2yYacNgayU2idXVZ/v4pNjZr
X-Google-Smtp-Source: ALg8bN7J7z15Vw9jy9SjMTeALt7WAUznlJJWop7q8AhJdKts8Qxw224THgFRSQek6rXMFVsm083Vkg==
X-Received: by 2002:a62:34c6:: with SMTP id b189mr1424691pfa.229.1545377298459;
        Thu, 20 Dec 2018 23:28:18 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:17 -0800 (PST)
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
Subject: [PATCH 21/21] PCI: designware: Remove superfluous shifting in definitions
Date:   Thu, 20 Dec 2018 23:27:16 -0800
Message-Id: <20181221072716.29017-22-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
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
2.19.1

