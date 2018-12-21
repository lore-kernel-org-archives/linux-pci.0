Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69E0C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A627621906
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+v8BjIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeLUHaP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:30:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37420 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbeLUH1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:27:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so2186980pfb.4;
        Thu, 20 Dec 2018 23:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1XPUyhdugQdjD1RjA8TcbqShFQ6vNfPgtVDRPKD26M=;
        b=D+v8BjIwaeBkHWCUn0SIc9Vauqh6k/EcRAx/6NL+x5IkPsPR441bJb8zpvorrru7tf
         WQpOaXEz0F1I4yQjIp9cCpkZZstdoQUvPF3cliFgyAXSrybbqb/8LC1ZPsZ/pgufsNk1
         AqoNPMrKD5/PZcnFX859gEz7gy30NgnwpnnDc2apCYY1C/yyrzFwKlpvRbN19PuE17mw
         +WDInCgOVD3V4o4MLInCLYjY7gnhvqx71hXA3y/rOjwfCq96gemXDtl252k3YS+E2Rbb
         76bKO8WtEZwQ1BWm8+h7aJDHIQopoRuLzD2zYjXfyDwD9usA8s80o2WQvuznD7ZxgcER
         j7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1XPUyhdugQdjD1RjA8TcbqShFQ6vNfPgtVDRPKD26M=;
        b=FNR5LcGb6LNCSN7wNwbCm6TLui4I/L+U7tYlKSKmQ/wXkVqJOwVzb1KgzOP4+2cMXi
         k+ysMilWqD5GZeASBCiGdAWMArtedA2eFqQYUrOSeKGKqea+sR6yF7XbjxXV13gPLzbD
         HhvAC5WUlIsJgHpY5gVNJv2CRFfHCumQVnNmNwb+VCYnFP/D18hMI6tZIxeo+fI4XKON
         /dOcCieWa1B4SNizM570SQqCZRFCrCpOwgbonHaDR4zv8WS2cOgA6iTEFhSdLimz1VXR
         3CHPW+j45lUkWPjqp0WWaO4Jj+6l6YrbckNJ+5VZx4lOPKCFG9FjvhIIxiyXHSI1kLMr
         w7eQ==
X-Gm-Message-State: AJcUukdIdnnbzHDsTemJUdIkIvHxQcCzchfL2j40X0Y/5mFJ8att+LjZ
        RiUTT9kbfGO5/sjJzfXCr0MMZXFv
X-Google-Smtp-Source: ALg8bN7DefFb9r+kRTFCRUxMnRCb2jxCddzSWYYkcXZREmCl0oq4M1VuRrjtSzH7qve+8RIUv4nlxw==
X-Received: by 2002:a63:70c:: with SMTP id 12mr1315807pgh.352.1545377268946;
        Thu, 20 Dec 2018 23:27:48 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:48 -0800 (PST)
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
Subject: [PATCH 05/21] PCI: imx6: Remove PCIE_PL_PFLR_* constants
Date:   Thu, 20 Dec 2018 23:27:00 -0800
Message-Id: <20181221072716.29017-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
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
index 2265f4b40e39..60803f1f16f8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,9 +82,6 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
-#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
-#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
-#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
-- 
2.19.1

