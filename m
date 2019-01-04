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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B251BC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5E521872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nemLFnIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfADRtr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:49:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41972 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfADRtq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so18618904pfi.8;
        Fri, 04 Jan 2019 09:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJzDYEASCtJoBvSDPXwzAPQP14rP9PAwK4xPdCOMwW0=;
        b=nemLFnIamffqdBky0GXQXY3CwxeEZ6YWQvEdffEfXhg1yhDLxnXlcalOt573u1sphT
         MQA2tC0oNIURJ61ez6iZL53jSASIHY5+LzZb90k4qAmV4XRPeyI/P5VXpBL0QiKy6CWi
         ueaQzXxxy0vHwwxqoZXYOjkhInhi70mODbn0ZiLqifwqLK61gAA/ee3HcRfIKCBNnoAa
         EABmaBKKY+l00GJLewcwRGIIO4t5/9fCCwcbrrWvzAIZcZBCXpU6sOgTCp+XXZKJA3LS
         kU44lTNF6hmLVyGYszi9bl4yiX97Sr2l9Shz7uJinixiBQMWR/OkHqhDmvbdw5e9io5M
         MA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJzDYEASCtJoBvSDPXwzAPQP14rP9PAwK4xPdCOMwW0=;
        b=Tlwtzg4yxF2kaU+mGwhY7CrJV0vXwBYn8xdEeqPxoWlFoo9r62I1wyacczfME0WH3r
         pmEVHSwAUpAB6pNNg9TkWWMf9OjTBW1B8v1ATkniIRa8vEcorLnax3zAx6h6bw5sL+eH
         FhspVkGLFTioe1RiLHViviQNX2CwBo8xlJvMarOg9lTn10Bi+LEsAJJes6NcLBaiTGxX
         mnxZx3Ekhv6+ucCxO1QTQpxb3T5L/luDdV6vQYgJWW7VdC6zIdbw4a4HP7/mof8Tr6wA
         2U10a9rcZm5heUz3szGCtHs6DLilQoGbW41FMipFv6353Lae+eQGnLiFeMMT0dStufJT
         p6Lw==
X-Gm-Message-State: AJcUukePDilYMzCiX4ncYl07eTAdGPmnxdyuqEQ/3QnQ5+mojW9yKlCA
        rRA0pdloBtyN2dcrhOOYhXIxunXQ9mo=
X-Google-Smtp-Source: ALg8bN62Z/ONTKavQulh6umuVA7rLaQLdKNV4XVr/H5+FtFegah5dPfF4bl9v0EW0vr/zUZ1sJ9Pfg==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr2459416pgd.416.1546624185485;
        Fri, 04 Jan 2019 09:49:45 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:44 -0800 (PST)
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
Subject: [PATCH v2 03/20] PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
Date:   Fri,  4 Jan 2019 09:49:08 -0800
Message-Id: <20190104174925.17153-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
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
index 491a93a02c80..a81edfac9974 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -698,7 +698,7 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	}
 
 	dev_err(dev, "Speed change timeout\n");
-	return -EINVAL;
+	return -ETIMEDOUT;
 }
 
 static void imx6_pcie_ltssm_enable(struct device *dev)
-- 
2.20.1

