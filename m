Return-Path: <SRS0=d3wJ=7E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87448C433E0
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 23:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589C020812
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590191324;
	bh=5Sy4xxtTopVBFWbKmXNaDdHsc6ggYp/NRxt1kFT2dSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oOhauFU5jmFhCLF5pw05mzdRi9bVkn8yFAt0Ec2wjc8MjnFVRnM0l8jFbvZYNhWW2
	 hkaJZ+IGzbdDcuj0+5dtdWBn3uR2sbRNO2P0Y0rtwG0KimrE8swYB/uzz/eGaHfnZF
	 M7Cy4a2nOwHczD10AfVgmdUmY4CrfUBRJhbfz518=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgEVXsn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 May 2020 19:48:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39998 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgEVXsm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:42 -0400
Received: by mail-io1-f67.google.com with SMTP id q8so11951983iow.7
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J45nDshYNcYrGRYkIpqQuCHqEq06Xr5wTtd6CkH1TKQ=;
        b=Px6KCRkXqteLcDbFVtgCfHUK/6jarc22FmaA1LCHeTChauwPqO3TTx/tBSGMpDvtGn
         nq+WeRDTzJyPXQWg6+cQ9gyPkbc0RwdREDo6osB50S6Q9kW64/or4Qx9ni3MFMhrWqgE
         MRe/nxtFc4zkzyh1+9Fauy6UmdFkltsVWshEw8Qcl/X1/O1gE+1U2C/GYcst8VbHa1wv
         zLNdFtOvpcBIHwBPWooJl51zC7OsdW/1sHMqEjSi02qWDwCZOBEneb5NZ4OKBtemEuMc
         zUgPtnrnif+JqIMoiSEByPDcQQlBzde2QjgAF7/jlSzdEnCBqguCrY/Sqsi5psVQ5Bij
         7L9A==
X-Gm-Message-State: AOAM531h4j67vgHAXkNJqvKCt+MfTHuNYly97ne2uEotaFsqGbRQKsCo
        hbQiahnMbMLT0raVoAqIyg==
X-Google-Smtp-Source: ABdhPJwvpizplNylsZ+mOBoLddCdqOsvUiQzZKpGEl+BV1UIE2Xf70za28p9484+5NSevVTlVtJ7jw==
X-Received: by 2002:a5e:cb4d:: with SMTP id h13mr5172992iok.141.1590191321380;
        Fri, 22 May 2020 16:48:41 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/15] PCI: v3: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:24 -0600
Message-Id: <20200522234832.954484-8-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The v3 host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-v3-semi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 3681e5af3878..198cf2c6ed92 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -239,7 +239,6 @@ struct v3_pci {
 	struct device *dev;
 	void __iomem *base;
 	void __iomem *config_base;
-	struct pci_bus *bus;
 	u32 config_mem;
 	u32 non_pre_mem;
 	u32 pre_mem;
@@ -904,17 +903,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 	val |= V3_SYSTEM_M_LOCK;
 	writew(val, v3->base + V3_SYSTEM);
 
-	ret = pci_scan_root_bus_bridge(host);
-	if (ret) {
-		dev_err(dev, "failed to register host: %d\n", ret);
-		return ret;
-	}
-	v3->bus = host->bus;
-
-	pci_bus_assign_resources(v3->bus);
-	pci_bus_add_devices(v3->bus);
-
-	return 0;
+	return pci_host_probe(host);
 }
 
 static const struct of_device_id v3_pci_of_match[] = {
-- 
2.25.1

