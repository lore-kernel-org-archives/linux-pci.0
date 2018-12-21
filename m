Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E09C43612
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3A821903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4zvbexJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbeLUH1x (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:27:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44540 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeLUH1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:27:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so2099862pgr.11;
        Thu, 20 Dec 2018 23:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+ZYsrQDzgljKv7Hwi24dI5tor2oRWLv2kgiIeP0lnI=;
        b=Z4zvbexJFGJpGh32+7HGRQJGf6LTreqO/NmuvyBGVazPAY0h38tNQYijQDnyfi3QPw
         Zkvn54K8ava4sziwAA6w/Q9AIBKSE6lM0Bvt2NPsHGg9fRaMQZiJToJMqMBbbbfUgPwc
         99RndgkRnhG1ZyrXbhPws6Hag+v8/OXuDqa9EOPRpggP1oCMMTyzWzxkfd3agbv9dy+5
         TqMgrK6Ur0Xw3/mt6+GI7+RAa025bD/gDyK6eM7DBbx6BKGs5/XYjxEQVIabiwDDG5sT
         SyPVnhijHovEidUWEGCZH5O644uq161RRE5MNd2vCNtxe6JZ+wY+L1TtCLruPMqh001H
         ntlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+ZYsrQDzgljKv7Hwi24dI5tor2oRWLv2kgiIeP0lnI=;
        b=rgNjhXzxWhyQ7da4u0esaYcboOCE1ZTieztVzcJN+nFeT7UYHHuCDOrquhVOgo+aLc
         vDo6BI1XkdR10zK7tc/JGWdF/U4gmxtqnAgU4F9BdxbtYNAtZ5aqDuRdfZSq9DY5xEvd
         efLLBrq3AKkRaN4hXb3Va256GynTpGOv8Xo9se5zJOLIJKStLj97BUdNQHe+GDv1g2T+
         1qTB+x7N6+iRNXG4mxzoPz3eH5oxOFNbz6kxcPvTuiFmwAIfatA3vFlqXntBpEbbXvkj
         qA6SmuFpP4JukH4INM344vmUfQ1lKp8smDiKJVWSd6Vq1igcy1qEO+EBfkKuxhw8T4ia
         blvA==
X-Gm-Message-State: AJcUukcygeS3eiQs+jWB2R9JDsyx/6NO4lOnrK19baLJym7WY23nMqF7
        dYJtkNzvPDniX487pZDPOSoLYKJt
X-Google-Smtp-Source: AFSGD/WzK6aotUaeFQYslS1ZuCcb0xGrM4bYW4RJdzTkpTf9ea02REhEidYhtufShyRIHnc/I9ASqQ==
X-Received: by 2002:a62:4c:: with SMTP id 73mr1424657pfa.24.1545377271247;
        Thu, 20 Dec 2018 23:27:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:50 -0800 (PST)
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
Subject: [PATCH 06/21] PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
Date:   Thu, 20 Dec 2018 23:27:01 -0800
Message-Id: <20181221072716.29017-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Code using these constants was removed in commit a77c5422d758 ("PCI:
imx6: Remove broken Gen2 workaround"). No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 60803f1f16f8..937d630f8c9d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -108,9 +108,6 @@ struct imx6_pcie {
 #define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
 #define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
 
-#define PCIE_PHY_RX_ASIC_OUT 0x100D
-#define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
-
 #define PHY_RX_OVRD_IN_LO 0x1005
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
-- 
2.19.1

