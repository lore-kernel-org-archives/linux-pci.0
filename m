Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A872FC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A35620870
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdJza43B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfDAE0J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43260 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDAE0F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id m10so3810749plt.10;
        Sun, 31 Mar 2019 21:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRIMMJnFx48ZsTwclAff4hTCypRB7eLLBoMHJVX8zVw=;
        b=YdJza43BOnVXl9w4aQozS74ldOjIc2qmzmlWkf+Rwl8s9hWdwv0lPiAIAGYAlEf+C1
         6sOKRcqWnBbADp51djipuN4KA5q8DAhPigCcZCZsap+TpsLaGBDDq/7gcQN3K4/CiDOT
         zK/pSCYjJRrKtwgCc6XM9H6wgayOD0bIHCh7p3ModGUslfawaNzTKShKHGknuQbvPF8/
         0PJJybLnyDeMDKlemP4vluJWGOFokCDDtAlYaOG3hWG76sV9f6VGZhNUHMPBfFyFDpoj
         wNP5mRdx/lRSWtJTKmIpsd6nzEgRrFrZsOhR9wnkDaXYdOn8P6zYOQ5WXamlKUnswHqy
         kXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRIMMJnFx48ZsTwclAff4hTCypRB7eLLBoMHJVX8zVw=;
        b=nUOV72CXSoclBFSRKtEd7EoMIJPIUdNFOmlPJwNZd3MKNSejbR/EY4iIA2VEkcYBB7
         3y9u2sS/yvgqnHWzdKzeVjWgBc7b8TWnSBae3nPH9b1PouCbe89vVpANCDxZS/LOYDzP
         ch0RsB3NBvl5p6p9nMfVifyxoLlhcMfKxgbuK1sLnI/Azsc8dFkB9tRwmkvGAnOy8+vT
         A1e+ptqaNqaMH95dIkCj3eB7HC8jeWACAPa18xJDOriIWh6nf9vcIpZKWfo6tnJXLXHx
         lkMsam0AJoum8C1OZJezp90K8LegKep+UaIzLCBHAaX4PHbXkgP1tzf/GsA3pAjeSBUw
         sq4g==
X-Gm-Message-State: APjAAAXjQZIrTUmoJcDCN4SmeRaZA55S/MN3dsJyZdsQxCrvgck8HyET
        /ZbU77z0hNRb+DBCpkl/vJqauglU
X-Google-Smtp-Source: APXvYqxffyBQyjAtvVDGeBIA7I3n5OMk2RMcayjx8YTwssnSmQDR2SuLAIdmd2JKzBnrn+YGHp6XWw==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr62773899plk.106.1554092764177;
        Sun, 31 Mar 2019 21:26:04 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:26:03 -0700 (PDT)
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
Subject: [PATCH v3 03/11] PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
Date:   Sun, 31 Mar 2019 21:25:39 -0700
Message-Id: <20190401042547.14067-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change error code from EINVAL to ETIMEDOUT in
imx6_pcie_wait_for_speed_change() since that error code seems more
appropriate.

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
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7582d0b2fbe7..3f4707072942 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -747,7 +747,7 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	}
 
 	dev_err(dev, "Speed change timeout\n");
-	return -EINVAL;
+	return -ETIMEDOUT;
 }
 
 static void imx6_pcie_ltssm_enable(struct device *dev)
-- 
2.20.1

