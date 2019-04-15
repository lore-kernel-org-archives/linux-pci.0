Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897E2C10F13
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D1820880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwx1ORez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfDOAsW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:48:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36273 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfDOArb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so7706942plb.3;
        Sun, 14 Apr 2019 17:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GxuKyo+B/7MbRuzp+bShwrzV//RQSTv8UPpnXETmOQ=;
        b=Bwx1ORezfx4adyMoVZvaNhKYAezLR17LZ13BX1BGoyzy2boc3PRupDzTWIqjtVz88U
         43BSUQZNj96vMWUCEdRSavtp6OEBYPDbJ2wWSTPlZikk11r4lLVym7wUDx38gfyzVXOq
         nEU7uzofvMNNwwo5wQH74Wi2sIdNnCl1IdKP3CNGWrucN2qkhEH8aCUHuG/HMBiXxSlg
         4gesDnGKNIBqE9u/CvgOm8fQgLnO+AXz28DO1vaF/EFpgkHA/UL53S/4MiehkmXKGuRC
         VwHuOSU3URAZyhPNpm8N0+smr3wZM1tViEtGJJT9Gfzju5tzmNM9WxVMfOBTeKGtQqyj
         qGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GxuKyo+B/7MbRuzp+bShwrzV//RQSTv8UPpnXETmOQ=;
        b=iterJMDffHxa0XUijLkuZYyWI9bMwm0Ie/9pa3CxYXc2MSQKvo8cQNJRrvcxqpXNKD
         2mUGyZ5tXqtOhSLOmP115XjPO5HLFa40RxyYwhaK1mleEowTC6Kwou5qXfPq9K6IJuWq
         eKDHnCAKRmSmhPDdws+/FDZZhmUb9vurYX3YvvG/xFqKtPCtBga9Ytwb4xCsTl26varU
         ahuCK0ilWo9mGI0TgGfWZ3YfewqHFjZV8K8WexLBnRKGDoN0k4O5wCZH6/gUKhep5F/J
         g/Pq/6EhdZxjuDXhytrwz+rElzceXXeRiYZ9yUJGMN8iS8hB66y5rKLqZmdGkV+PdeX/
         gyFA==
X-Gm-Message-State: APjAAAXcLeJikzRiqm92PDHTZq4qmS1hqw2QC6UkSiNrADexJsXvzRH9
        M6BkAIIADnpH8i/y1HEee5D0ZvLt
X-Google-Smtp-Source: APXvYqxD8SPh+An9HHu8MKhajezK5gAKwk3tDKVhH1ykKQgMdA0SLfWlN9MHsbv6MlpKrjpkeJ8Stw==
X-Received: by 2002:a17:902:2702:: with SMTP id c2mr53116686plb.37.1555289250700;
        Sun, 14 Apr 2019 17:47:30 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:29 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
Date:   Sun, 14 Apr 2019 17:46:24 -0700
Message-Id: <20190415004632.5907-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change error code from EINVAL to ETIMEDOUT in
imx6_pcie_wait_for_speed_change() since that error code seems more
appropriate.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bb3dcfdbf697..021ef121a058 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -739,7 +739,7 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	}
 
 	dev_err(dev, "Speed change timeout\n");
-	return -EINVAL;
+	return -ETIMEDOUT;
 }
 
 static void imx6_pcie_ltssm_enable(struct device *dev)
-- 
2.20.1

