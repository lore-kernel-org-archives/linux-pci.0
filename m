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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FE4C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C00121872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZRJ3v8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfADRvr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:51:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41975 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfADRtu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so18618962pfi.8;
        Fri, 04 Jan 2019 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTd99CHE5iLaVoOAVJd8WfMcBFC6tGpgGczKpbbc3Sc=;
        b=KZRJ3v8fnd9guo51anuzyHME3XTBHLulXCoUd46xXupoa9GJBDDSahPQaeaI6PLGVr
         8WGYsbFLDSaqyj4vvuSYG5SYiOJLBRczG4BTCT412zHy0aHlx67BJF/5bkIB3ajth8M3
         j0DOWvO/vyFVPj9cdvQt3pkHf/p2UMnt6OUkI2HKxtpV20UXZk5glYy6iKg5mDpqKjxi
         hcAFFzi7QNbmQbGsn3A0vnbCTD4Xz1FWDYBl9/cDKuzVr5ZdDGbup+l0Yu9qrXJK/XMo
         W0iKa/8vKbVIyT/WW+X1irJAlhyfyKoLZGtxCaBxnthGEZW6chT2vwCL5iJJ7SR4zOqo
         /rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTd99CHE5iLaVoOAVJd8WfMcBFC6tGpgGczKpbbc3Sc=;
        b=c/syLtwfH6SrxeedTdtF67+G4yl46GT1D/TynSiSMn83VOMtVmXFG5RcDi54gO4TD3
         ON1LpSWRIE73BEVmyq/7SH8OMsecHvMXmlG4EE8w25mu7nfJHnOSqTwEBJZnv6V65Z52
         jVgg2o9SDG4xVOh2ogf150seIICuNHcq9Il0yqg2hUedfzVDJnMzvDcayeHf98V5CwBm
         WGtCUaAv2YWl9pl6+XsqxpgQd/dF5b4hBEKZQel2cLgB60GcCPDjpL7NpPdFOHjZeqtX
         E292nGjBJ9V1XiMIDv1gtfIpME7Ses7czG4jkJAWz6NOsZfsGNfCDDdqGNSr0YiOc1VW
         i8EQ==
X-Gm-Message-State: AA+aEWZS/YSqPrhrsEfnK4j/RoxvrnmhWYyDV1Y/Lokuss4Ac2YjBVmm
        KcHBdMIif4ZYElTwiy2J3GLJ/e5Zfjo=
X-Google-Smtp-Source: ALg8bN4Qb8qQMO7TZhcNjLcZcF+mDwHVBnDykUSYqKB+NrSY3NbwaLE59uALn6HrKRe517RVcaaUeQ==
X-Received: by 2002:a62:520b:: with SMTP id g11mr53858019pfb.53.1546624189099;
        Fri, 04 Jan 2019 09:49:49 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:48 -0800 (PST)
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
Subject: [PATCH v2 05/20] PCI: imx6: Remove PCIE_PL_PFLR_* constants
Date:   Fri,  4 Jan 2019 09:49:10 -0800
Message-Id: <20190104174925.17153-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Code using these constants was removed in commit a71280722eeb ("PCI:
imx6: Remove LTSSM disable workaround"). No functional change
intended.

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
index 5090a618c3e2..a7192b9e0e71 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -99,9 +99,6 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
-#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
-#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
-#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 
-- 
2.20.1

