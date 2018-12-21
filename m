Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24215C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A3B21903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igx2pbzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbeLUH3r (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:29:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42134 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbeLUH15 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:27:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so2101299pga.9;
        Thu, 20 Dec 2018 23:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1hnIy8vmdV/yZX7E7Jm64Qo+GuGNv09m6Pi4D4/jFs=;
        b=igx2pbzCncxfVAQhjH9xaI/FCAIaddYLG9x2Ieuc5tdWQzv3z0MRHJ2KIenPF8WV63
         27/RiEAvf91QtmM/jEQgI9eyV+NhU/PU18Q+py2Gp/j37fvH+i7GGtwxWIlty+PHFvUH
         Va3uTUJCjPQxAdkVT3b86nHZOSfjjGh87OT09JNdzIzMwJ6rphof1OdaYiYbySpiUTpY
         /3tS4m+UEU3uqZpKCzV8LgRTqXfSsJbbfzqS45E8uxSx7JbCCH9NfWFb0bDhoUjtRHPB
         gEQLQacnRuVmTtuv4k4vSBTCWnooTZxxj4CgWe1mV3aYE2toxh040AN136AF8Qv97XbR
         JeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1hnIy8vmdV/yZX7E7Jm64Qo+GuGNv09m6Pi4D4/jFs=;
        b=FGX7gFRdJU6cNcnkAzOjNFpSemKiehTmS0jVsz9SF1jgCHMJ5Ok3KYz4F8sxhd9PTA
         F9ZVHXenA1DapfeL8FJpwLVF0o25vfGR1ZHiRH6cU5ryoVLTulvW+DKzurJ6Cjg250SE
         T/bnzC/H+gc+odfpQqQ0XF84VEd6nDxf0bWFosE8DSuAvIbqzXLUVDAB427YpmA3pToV
         SrHveIexgfIeABHfcg1x+48fc2LjJ7QmMZDtFgAuLOnRHroV5zOlUQz5rlA0bKD1g72B
         Q3vo3J6Z/08DsgYNnc/lQnmcG+B61pbJ9JcMtzh05eGPKk8pXuRkwfJQ3TdlvXYEK1Ht
         Vu3A==
X-Gm-Message-State: AJcUukdWUZP45bPlqVrn9/rTDnVe/nb5ZiDgi0ioi9+u5uGOMJamrMCd
        EExBcPA9dBRqPmurBFLAc9vNHMt+
X-Google-Smtp-Source: ALg8bN4vox9LZebHZGx5bOBLDLief4pJfhpahT2U2GmwxOnNKMv9alUCzjnwm7VG02285/dOUUeVLQ==
X-Received: by 2002:a65:4381:: with SMTP id m1mr1327155pgp.358.1545377276324;
        Thu, 20 Dec 2018 23:27:56 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:55 -0800 (PST)
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
Subject: [PATCH 09/21] PCI: imx6: Drop imx6_pcie_link_up()
Date:   Thu, 20 Dec 2018 23:27:04 -0800
Message-Id: <20181221072716.29017-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Until commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
imx6_pcie_wait_for_link()") the driver relied on both LINK_UP and
LINK_IN_TRAINING to determine if PCIE link was up.

I can't seem to find out why, but code using LINK_IN_TRAINING seem to
disappear after commit 886bc5ceb5cc ("PCI: designware: Add generic
dw_pcie_wait_for_link()") and from then on only LINK_UP seems to be
tested (dw_pcie_wait_for_link() -> dw_pcie_link_up() ->
imx6_pcie_link_up()).

At the same time the default behavior of dw_pcie_link_up() went from
using just LINK_UP in commit dac29e6c5460 ("PCI: designware: Add
default link up check if sub-driver doesn't override") to using both
LINK_IN_TRAINING and LINK_UP in commit 01c076732e82 ("PCI: designware:
Check LTSSM training bit before deciding link is up").

Given all that it seems that i.MX6 doesn't really need a special
.link_up() callback and imx6_pcie_link_up() can be dropped.

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
 drivers/pci/controller/dwc/pci-imx6.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 937d630f8c9d..74faca11eeae 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -84,8 +84,6 @@ struct imx6_pcie {
 #define PL_OFFSET 0x700
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -732,12 +730,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int imx6_pcie_link_up(struct dw_pcie *pci)
-{
-	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
-			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
-}
-
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
@@ -769,9 +761,7 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 	return 0;
 }
 
-static const struct dw_pcie_ops dw_pcie_ops = {
-	.link_up = imx6_pcie_link_up,
-};
+static const struct dw_pcie_ops dw_pcie_ops;
 
 #ifdef CONFIG_PM_SLEEP
 static void imx6_pcie_ltssm_disable(struct device *dev)
-- 
2.19.1

