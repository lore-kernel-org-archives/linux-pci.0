Return-Path: <SRS0=d3wJ=7E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C884C433DF
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 23:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3185820723
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590191324;
	bh=3xqomzrC6c7yLoeGvL5bKTqBEhOJ8GF2Qg/wV0RAUc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ACOwPrb8vyAUUNeNj8HFaFno5AAhvROKAIl4ggPkoQ6d278Ol3vP6CW4OqZSmuqT+
	 uXMDfVt7zW2aXMrIT6/4YNeUgFNroDUdskBCQbqV3iCRrygzTjAWZGABy5FMzzIUwq
	 TTnk7eBKqXbP8ByYEgDOgCURQo0D+PSMxaYDMfEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbgEVXsn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 May 2020 19:48:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46669 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbgEVXsn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:43 -0400
Received: by mail-io1-f66.google.com with SMTP id j8so13282662iog.13
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hu+r9D87KcoWa189MTy6Edmp4pidtqObZuiMTiz4cgc=;
        b=L4gL4OhXYE7nUbH8ZJhp2KcFZegEglt3DHqsRDYKeBj1PlCqZutN5y60NhBJL3mDEt
         GoU23aTdnWGL9Yt3cHTbbh85rNMlxpvFPMRlzsKrU8Ks/7mZdv0qKogLcqoGHbjmJ2LB
         k2wEy4yS9hFrouhju9KP13zg2xf68ztNExU0iTp3lI8p8G9ciqxJ54Mh+aJJ9lpkb52q
         mKY8ENX+SA+RVXaVes3AU+cgOJRLZSYcEKR3oEwB4LpCSiipgmQYqvkNGEWkCNr9HokL
         IPtbrf049HRMA3cuKxmUXyrGvZg07pE5yBnu4KRfoaQYnqiA/LkTLPpB3VIX0mb361Uh
         RAYA==
X-Gm-Message-State: AOAM530G1sEv/JpxoP9vJFjGRNtyn33qbFOP1xaxGDhD8Kf1KCr6J5Dw
        9VsWg2JSbaWIlP5ATeFENQ==
X-Google-Smtp-Source: ABdhPJzvS3aCPPD+k4N9FAiNd4VPWGqJzq7xAINIEBc8KXR6heifVNZNNeQbLmVhFEJExzb4WHJESg==
X-Received: by 2002:a6b:bc85:: with SMTP id m127mr5019308iof.89.1590191322407;
        Fri, 22 May 2020 16:48:42 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:41 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/15] PCI: versatile: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:25 -0600
Message-Id: <20200522234832.954484-9-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The versatile host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-versatile.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index b911359b6d81..e90f0cc65c73 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -70,7 +70,6 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	int ret, i, myslot = -1, mem = 1;
 	u32 val;
 	void __iomem *local_pci_cfg_base;
-	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
@@ -164,18 +163,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0)
-		return ret;
-
-	bus = bridge->bus;
-
-	pci_assign_unassigned_bus_resources(bus);
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-	pci_bus_add_devices(bus);
-
-	return 0;
+	return pci_host_probe(bridge);
 }
 
 static const struct of_device_id versatile_pci_of_match[] = {
-- 
2.25.1

