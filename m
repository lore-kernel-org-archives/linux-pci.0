Return-Path: <SRS0=XLrH=XT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40EDC4320D
	for <linux-pci@archiver.kernel.org>; Tue, 24 Sep 2019 21:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8474D214DA
	for <linux-pci@archiver.kernel.org>; Tue, 24 Sep 2019 21:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569361595;
	bh=3BsfJ7I+5YYL4kFCCW6XZrDG2C2uYZN8VcC8UQqAfcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pwc1O0qJwRaV6d8NBWsaxKjH7k4MfO0Dm8PigpcTly618R/z2triiw830rhOPBbdd
	 VffU4s8bg8MqNq+yHKVayZrOafRyDskfB734ovZsKTQcguEvjnzavfi/zJxJ2Tg5Ty
	 gAjxmzhV2694dnPzVwIAPmuLNLrYljzr6wW4/DlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfIXVqf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:46:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40501 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbfIXVqe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so3056330oib.7
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 14:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mj2cHfPK1Lg/i3xyl7unPwCDQ0FPsiiGlXxaMpguDq4=;
        b=WWqXMK+hntEY0D00cceGO59w8ixciz59MtP3p4zdGSi8fsNYKW6WLyf9jGyyMFMIiH
         Yn76BKGgKMlIqvXrumSIKjfqOTrk7RXo8gjPtKV1c51GptieE80fvwkenOeSMEooWET9
         hMRvmfsAJXv+5idzSnddtT4RHPNHNIMVr4j6gvpQuRoqd3zM6upSGhCkLPZr/RGC43gQ
         uwGPnvFRCuGILUs/FQovvYHU3cu5HTLOSiQKm+LXC1Xf/NxcfuL/qvpEHzbt/OCm9G0d
         vw4sUCrAFnm/adekL5OAU4GHIbwgwWoZnOrl+baZb9233ybqTAUwkuR03ddfwv8rregS
         jC1A==
X-Gm-Message-State: APjAAAVWc4O6lxAaoR/PapVn4gVPCth52BwSX+dfVxr2BAmE4Un4NaGm
        zPL+pNxM8eTcyjp9N0RFcgi8xT8=
X-Google-Smtp-Source: APXvYqzJ4oTIA1/Jq8Esdkdrq7dZsqt1eEao9dTNXYBUMMxJ++4DN0aBrQ0da6ZPPMILRTn37hQf4Q==
X-Received: by 2002:a05:6808:647:: with SMTP id z7mr2028480oih.16.1569361593520;
        Tue, 24 Sep 2019 14:46:33 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:32 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 01/11] PCI: aardvark: Use pci_parse_request_of_pci_ranges()
Date:   Tue, 24 Sep 2019 16:46:20 -0500
Message-Id: <20190924214630.12817-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924214630.12817-1-robh@kernel.org>
References: <20190924214630.12817-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert aardvark to use the common pci_parse_request_of_pci_ranges().

Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 58 ++-------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index fc0fe4d4de49..ff3af3d34028 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -910,63 +910,11 @@ static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
-{
-	int err, res_valid = 0;
-	struct device *dev = &pcie->pdev->dev;
-	struct resource_entry *win, *tmp;
-	resource_size_t iobase;
-
-	INIT_LIST_HEAD(&pcie->resources);
-
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &pcie->resources, &iobase);
-	if (err)
-		return err;
-
-	err = devm_request_pci_bus_resources(dev, &pcie->resources);
-	if (err)
-		goto out_release_res;
-
-	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
-		struct resource *res = win->res;
-
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
-			err = devm_pci_remap_iospace(dev, res, iobase);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, res);
-				resource_list_destroy_entry(win);
-			}
-			break;
-		case IORESOURCE_MEM:
-			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-			break;
-		case IORESOURCE_BUS:
-			pcie->root_bus_nr = res->start;
-			break;
-		}
-	}
-
-	if (!res_valid) {
-		dev_err(dev, "non-prefetchable memory resource required\n");
-		err = -EINVAL;
-		goto out_release_res;
-	}
-
-	return 0;
-
-out_release_res:
-	pci_free_resource_list(&pcie->resources);
-	return err;
-}
-
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct advk_pcie *pcie;
-	struct resource *res;
+	struct resource *res, *bus;
 	struct pci_host_bridge *bridge;
 	int ret, irq;
 
@@ -991,11 +939,13 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = advk_pcie_parse_request_of_pci_ranges(pcie);
+	ret = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
+					      &bus);
 	if (ret) {
 		dev_err(dev, "Failed to parse resources\n");
 		return ret;
 	}
+	pcie->root_bus_nr = bus->start;
 
 	advk_pcie_setup_hw(pcie);
 
-- 
2.20.1

