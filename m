Return-Path: <SRS0=d3wJ=7E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C70C433DF
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 23:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A780E20723
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 23:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590191326;
	bh=QeTsyYJjXXcXnMQ9yMF6w5KXqYY0+ob9BHE466q4mx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9qMrlyHV2DzrVlo8tiyHxRavVWJrQ9EL+njIQdEDko2mVrF/A7HbIlifclRmBnLv
	 bKHiPe/wGhmFBD8iWNUmc/9PZZjDYbSQeSdgVwiB3LgjpNxnRYI+ImL8NNOxIdkKpc
	 y4zFcVh5YHCS/zEoNFVVIEGwQdUOl3sBnO6mi1MU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgEVXsq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 May 2020 19:48:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45027 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgEVXsp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:45 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so13286573iov.11
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2f+A+UJfY1PJTDNi0NFbPeTlvbbCc37QATxTjmUPVg=;
        b=Y9KupFWxtqpfaSRNOczCJuVf2El072vmF38hxAvllioQadtOmMC3SAKJ/yc5l2TI0t
         /ZhSl1kMWlFZAtKJHdXisEJZbUTg080VpoiorEiI3OOA0Mq+VGCBBKpjGJYU9w0X8wf7
         0L7uKr1uP0Qx7g2pUeUWH6/hqA944x4kADVUEkdwElvL9qCmFo6dCxTpUy2LKpKL0/rn
         nLTrO/tHGSEQdhKh0/UJWsEZTd6Bxfy0XXG2khwlbkvua5ZEHZWEe+6VGw8R5w0D/GWM
         AhJ15k++7HHw/X/ReuSIl5JC43HOQJQ5Eb0H8M4+dIPOVDnhyFpi56XcnMAY/89vRror
         x/2A==
X-Gm-Message-State: AOAM533ZZo0qa5F+z6EtgFxcKNky52Srr6y8c8SL2LkC+dp4R5ionJCd
        8ZcQz9pqczDZSYa0Hdunzw==
X-Google-Smtp-Source: ABdhPJz0drAdXL8tOrdvka5OuWYdrXyPsukcMKwJDfVFN/ZlnqO01gwrcMTn1syXCMOnmaFNfmE11w==
X-Received: by 2002:a5d:9e55:: with SMTP id i21mr3535285ioi.130.1590191324652;
        Fri, 22 May 2020 16:48:44 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        rfi@lists.rocketboards.org
Subject: [PATCH 10/15] PCI: altera: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:27 -0600
Message-Id: <20200522234832.954484-11-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The altera host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

The only difference is pci_assign_unassigned_bus_resources() was called
instead of pci_bus_size_bridges() and pci_bus_assign_resources(). This
should be the same.

Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: rfi@lists.rocketboards.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-altera.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 24cb1c331058..26ac3ad81de0 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -773,8 +773,6 @@ static int altera_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct altera_pcie *pcie;
-	struct pci_bus *bus;
-	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	int ret;
 	const struct of_device_id *match;
@@ -825,20 +823,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0)
-		return ret;
-
-	bus = bridge->bus;
-
-	pci_assign_unassigned_bus_resources(bus);
-
-	/* Configure PCI Express setting. */
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(bus);
-	return ret;
+	return pci_host_probe(bridge);
 }
 
 static int altera_pcie_remove(struct platform_device *pdev)
-- 
2.25.1

