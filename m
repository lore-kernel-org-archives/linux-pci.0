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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4CEC43444
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75B021872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMXNaB96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfADRtt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:49:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45400 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfADRtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so18614714pfd.12;
        Fri, 04 Jan 2019 09:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCqECGpQL31DJ49A/L9K3JSZYoIJTRJ5Yhw/wHfMJEY=;
        b=PMXNaB96VaHiHNXXRIHAGRolmiJt2VeTXMHSbsRa+yIvRjh8vO2UvjjDajS06DTCHp
         jWutAyiiydc4NkFnXGLy8N/TKPZKD6KMPwY3EH+dHSSqDsvDJOlUsxKYJWDAh6GSQBpn
         x78yK7yfbVBbCqEJID6hSONoqZQSylqhwLN/GB57ydLzk+Xzhvt7k+tLziAYM6vOSaoU
         i9jqZUIk1WWJ1dquNnOEhxnLwI/4LTQFPBe+w3G5H/iSDgyC1EpnPh1XFnw3Qf1uD8WJ
         zsnZmx2+2cVthJVX+X04/hP4lWTKK5jC6pt2X0GbBJ4VNyGlGIQFWqAUUSj4CguTLscm
         KsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCqECGpQL31DJ49A/L9K3JSZYoIJTRJ5Yhw/wHfMJEY=;
        b=GI4NN9s2hWna0hCpdpGrxZ94Q+eNJgCClJvMvmsXTSakmPXcJb2+w4hot3PD/nOccO
         7kJ85mkpfgK+57yKVO+vkA1Q8iOb56sHml4Fnc1cy7e7LA6gUttF47MLfnRPA2r9D83H
         NJ9Z1OzK0X6UGbpdK0aAgC410K8oiBNOhypTxr7aMynfba1syM+sWp8zvfOtL+e9NV3H
         kf9uSu3kz90WmZrUTSB3/nkPFUPG9Mb0PfEB12O6TWMBTUBvnCjRt+0rHJxSbcFbo6jM
         aESwWDFuLx+vxsFDyFj7kOYQ9lIaA44iDLzSd3DxQLPAnZefNtx55QC/9kfR6nDxFhfR
         A06g==
X-Gm-Message-State: AJcUukdrb16oLUe7qpXiTlfg4N/avsauhQSOJM6NHuGDghEDHXbw1Set
        rNQ6Y6V6dhzrz+2GKAptHYb/fYtVu3g=
X-Google-Smtp-Source: ALg8bN7X7QAfuXbhJyAnQ0K3OS6WnTAeWqdTDKnmKlvEbHUmdoUhGMy5B/iQDijGEZKW7/W0AWPMFA==
X-Received: by 2002:a63:34c3:: with SMTP id b186mr2346117pga.184.1546624187337;
        Fri, 04 Jan 2019 09:49:47 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:46 -0800 (PST)
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
Subject: [PATCH v2 04/20] PCI: imx6: Remove duplicate macro definitions
Date:   Fri,  4 Jan 2019 09:49:09 -0800
Message-Id: <20190104174925.17153-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both PCIE_LINK_WIDTH_SPEED_CONTROL and PORT_LOGIC_SPEED_CHANGE are
already defined in pcie-desingware.h, so drop duplicate definintion in
pci-imx6.c. No functional change intended.

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
index a81edfac9974..5090a618c3e2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -115,9 +115,6 @@ struct imx6_pcie {
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
 #define PCIE_PHY_STAT_ACK_LOC 16
 
-#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
-
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
 #define  PCIE_PHY_ATEOVRD_EN			(0x1 << 2)
-- 
2.20.1

