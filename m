Return-Path: <SRS0=d3wJ=7E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD2C433E1
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 23:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2132E20723
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 23:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590191330;
	bh=Q0+iPgdtFopEBI3wwmQ3MV2iGmwhdvqg6lW9FsmTZLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rYQDAEaT1Rcj0Whwsw+qgPthkH2EQrgDwlhyrKd54yILYL6mecPx69aK8QfQN9dtO
	 Sq8yC0e49PGbWcnqPWMZzPipASGdI2TXAZXaDcSSzgcloUR4+IJ+iqfedxITgiJDNJ
	 xwJ4CRjhbgDk7nv2ebIMiGl6LLayEaRD/lzrrXns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgEVXst (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 May 2020 19:48:49 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44165 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbgEVXst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:49 -0400
Received: by mail-il1-f194.google.com with SMTP id j3so12440152ilk.11;
        Fri, 22 May 2020 16:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8MKWOkTFOUck/e3qV/n3PXjrwRqiBK3sTxqSf9d7+Q=;
        b=bLZniJ8WydzuYPzXs1VjZ+NHffjnZ0kZP+zvjKM0AaYIYG78Jzn1Q6Hs9zNZv+IekH
         WnHC3qxaMMCfrx3sDpeopJlbVx7Nstyq7J917nB34Hl0W/Qt3CJwAIpusMweoXPkGq+S
         kzE2ACnA/7H77xIuYiTh28VbJpb1nrDTUXxAFpiklAee541EE787VuS3nFPy5SZEt7V2
         Z8Gk99I/YRBICGborp0XWHtzx11UY2LbILViCmdi97hCfc1gBrMbjbHVykwOXqrQRkdD
         5Sc0StJxhru++GDu5c/Brt9S+WERlXXvNpndakIxrM4lW8Q1eQzmRr9tee0xb01zm8+W
         Rv0g==
X-Gm-Message-State: AOAM532T40FfaLSX21Qt4J/nDviQUeaOi4lLkCZxjFHP0+UtfcHEB1si
        NSRbOr2uvKOEmx3ApNNCj/KuQBI=
X-Google-Smtp-Source: ABdhPJxg5S2neYCB/6X3dzr3jwkcGSeZrpPJj0feTh/FWKaNYA2PpAUBHLVyiHOLA6yr38KykqSK5Q==
X-Received: by 2002:a92:9e16:: with SMTP id q22mr15130162ili.17.1590191326864;
        Fri, 22 May 2020 16:48:46 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 12/15] PCI: rcar: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:29 -0600
Message-Id: <20200522234832.954484-13-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The rcar host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-rcar-host.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index d210a36561be..9069ad96fe95 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -330,8 +330,6 @@ static int rcar_pcie_enable(struct rcar_pcie_host *host)
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
 	struct rcar_pcie *pcie = &host->pcie;
 	struct device *dev = pcie->dev;
-	struct pci_bus *bus, *child;
-	int ret;
 
 	/* Try setting 5 GT/s link speed */
 	rcar_pcie_force_speedup(pcie);
@@ -349,21 +347,7 @@ static int rcar_pcie_enable(struct rcar_pcie_host *host)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		bridge->msi = &host->msi.chip;
 
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0)
-		return ret;
-
-	bus = bridge->bus;
-
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
-
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(bus);
-
-	return 0;
+	return pci_host_probe(bridge);
 }
 
 static int phy_wait_for_ack(struct rcar_pcie *pcie)
-- 
2.25.1

