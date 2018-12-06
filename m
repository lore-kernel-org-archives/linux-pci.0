Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB60BC04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E69820892
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E25F0M4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E69820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeLFHqH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:46:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38249 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFHqH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 02:46:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so11371478pfi.5;
        Wed, 05 Dec 2018 23:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWUNuBobrQGS8tPzC7mZOSiomc02hqs3O+/8VlJOcu4=;
        b=E25F0M4zMsqLFvdU+s7GP8/PEb4WgujJde7XOmYvDnAzcNeb0QdcJa3zdYQyJB7vvn
         QjKY3mDFt9+S9Z2m6F6HjFJXtzm30yxFlCB8rJiU/PKLy+h4Gu9PoGnaOee0jE1+cKMS
         ljM04Ivxsgo7ybjTNiApj/vOVvGckj8NSRPh5vsbN1Lo2VN5NsBGIwDH8xOK9MQj37mG
         rQfVJkadSpGveaLiM58cQ6Bkt3N4EzVhbmCa5Hf2DMhRiPbJ2O/RCD7wPOcyxYA5hbdw
         HNl5b2XeTdPW8kxXQgoh1jpni9NvHF/PFhdrIjgg3oo+2jj2Bl5xZ/qqZsIXfAh4KmKj
         9U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWUNuBobrQGS8tPzC7mZOSiomc02hqs3O+/8VlJOcu4=;
        b=pb67SO0wgC8f5bGdFDeyyThHSqCxAZGQtx6pwqZZLmwJeP+0L7OavEGDZ8BPuEZslB
         62B6RGO5gDn7dg9/Di3Ox35WScgdYp7Kwr8eNmuYLCex7WWz3+2yBa1YPO9sGNRO+sF0
         MLhZTq2KWnCABygscfl/FDIPaML5xJQdDRUo8UmCT4aM/TKyf5LpujHSRHLIYlezD0Cp
         +PgBmRnkhLYUxBVwIVNfretKazmcY1k+wYWRfnxQSTtPF9KzhliBG5aNEryIM2uj9ooJ
         MoYveOeTNfNdq3vb8qdtYqT5tI+5q/XzESQEGksIVcvvXFaj4lvsqTSrYLkgZHGNFNZw
         uBPw==
X-Gm-Message-State: AA+aEWYY1Pbc0OsMO8Phz8Q0BZSq6aqWrz7XosgEUifcQpiZS5Ky1gFd
        aH+lJD5xIJ9Gs0YqYOjuLgSS79Q1
X-Google-Smtp-Source: AFSGD/UQefWq+hnPci7nzwdxqF0q9fBq2vntcT00HEgmLc4u3kL9oimYNMvYqzuEide+WDsdtdqxtw==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr27285081pfh.151.1544082366337;
        Wed, 05 Dec 2018 23:46:06 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l11sm29198232pff.65.2018.12.05.23.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:46:05 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, bhelgaas@google.com,
        cphealy@gmail.com, l.stach@pengutronix.de,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
Date:   Wed,  5 Dec 2018 23:45:55 -0800
Message-Id: <20181206074555.19579-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
to pcieport driver. This, in turn, results in a PCIE bus that is
capable of enumerating attached PCIE device, but lacks functional
interrupt support.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Assuming this is a reasonable dependency, shold this be done to more
than just i.MX6 driver?

 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 2b139acccf32..44ededbeab85 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -92,6 +92,7 @@ config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
 	depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCIEPORTBUS
 	select PCIE_DW_HOST
 
 config PCIE_SPEAR13XX
-- 
2.19.1

