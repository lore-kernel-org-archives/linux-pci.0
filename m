Return-Path: <SRS0=pSR+=5Z=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26965C2BB85
	for <linux-pci@archiver.kernel.org>; Thu,  9 Apr 2020 23:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F256520757
	for <linux-pci@archiver.kernel.org>; Thu,  9 Apr 2020 23:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586476176;
	bh=SHeuq/joBTNKk/Xb589LvKalBpI233MFrVL4mNsGHkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ft9b3f1q6vuAKdnJP6xLELM1S5FncUWlBVHpahJz/z/XbMOPsU8QIlvBjitoXV49U
	 GV7bqoc44ag4cjvdaS2B6w/Ma9+bl98SNeXRVG8N8rB1tDFxWxABnYVPPyO7F4U9M6
	 bZW0b2yzNxWpA0zKVxfkcLZBr/0UYZOveW316m8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgDIXte (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:49:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44182 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDIXte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 19:49:34 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so176285iok.11;
        Thu, 09 Apr 2020 16:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwY8gKjA6jl+xShBah6YhoU02iHkzzm5PEUXPKXngvY=;
        b=c2PEMD8g+72osGKShvD8pZUpkY0zIMd0FlRD7jzR2v6Hkyb6C+E3zLSvL7v9BEtmOS
         jjAN1819KOAXrmZitmYWin88OClHEmtGQDf5YsehwO/TX+g6c0K++cKQyInRhQRb1CYb
         uzGh1+Zjn3Q/d07HH8G13nxhSLcI7wz1SFdKYeqsvh8nFNTQ6O25w4EzyK+vedQ+SV2H
         pRG3mzY1zIBWBDGyGNygD+sSqpBlGQklgEx1B99P6v37x6ukZLUh6mHjbvk/BSoQh5HY
         hKMD7P/7655D6fuTzRhXYmuG75BsCYSMgvyWOQeXfXZFVRXv313GPmXMaOs6Lz1fvOYP
         WF8w==
X-Gm-Message-State: AGi0PubKv3+VJO0m++lFokxwuVXwZG7bD0Cd9Rr2hOUlNT5VB2GsSQEX
        38Kdx7yy9Sgv1wgsDUz2fg==
X-Google-Smtp-Source: APiQypJMSPk1SQGHUk19Mji7mfAOyAhmVDtiKBJq3x/PJhQq5zLRhze+ldidQIKHoFaaxTx9uGjPRg==
X-Received: by 2002:a02:c7c2:: with SMTP id s2mr2159789jao.130.1586476172538;
        Thu, 09 Apr 2020 16:49:32 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id w7sm93416ior.51.2020.04.09.16.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:49:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mans Rullgard <mans@mansr.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Robert Richter <rrichter@marvell.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Toan Le <toan@os.amperecomputing.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: host-generic: Support building as modules
Date:   Thu,  9 Apr 2020 17:49:22 -0600
Message-Id: <20200409234923.21598-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409234923.21598-1-robh@kernel.org>
References: <20200409234923.21598-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable building host-generic and its host-common dependency as a
module.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/Kconfig            | 4 ++--
 drivers/pci/controller/pci-host-common.c  | 5 +++++
 drivers/pci/controller/pci-host-generic.c | 7 +++++--
 drivers/pci/ecam.c                        | 4 ++++
 drivers/pci/setup-bus.c                   | 1 +
 include/linux/pci-ecam.h                  | 2 +-
 6 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 91bfdb784829..416a53414728 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -62,11 +62,11 @@ config PCIE_RCAR
 	  Say Y here if you want PCIe controller support on R-Car SoCs.
 
 config PCI_HOST_COMMON
-	bool
+	tristate
 	select PCI_ECAM
 
 config PCI_HOST_GENERIC
-	bool "Generic PCI host controller"
+	tristate "Generic PCI host controller"
 	depends on OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index f6d5dc068488..6d15bc12e726 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
@@ -95,6 +96,7 @@ int pci_host_common_probe(struct platform_device *pdev,
 	platform_set_drvdata(pdev, bridge->bus);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_host_common_probe);
 
 int pci_host_common_remove(struct platform_device *pdev)
 {
@@ -107,3 +109,6 @@ int pci_host_common_remove(struct platform_device *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_host_common_remove);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index 7e9a7c0833b1..fd8cff61de14 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
@@ -76,6 +77,7 @@ static const struct of_device_id gen_pci_of_match[] = {
 
 	{ },
 };
+MODULE_DEVICE_TABLE(of, gen_pci_of_match);
 
 static int gen_pci_probe(struct platform_device *pdev)
 {
@@ -92,9 +94,10 @@ static struct platform_driver gen_pci_driver = {
 	.driver = {
 		.name = "pci-host-generic",
 		.of_match_table = gen_pci_of_match,
-		.suppress_bind_attrs = true,
 	},
 	.probe = gen_pci_probe,
 	.remove = pci_host_common_remove,
 };
-builtin_platform_driver(gen_pci_driver);
+module_platform_driver(gen_pci_driver);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 1b05ff627859..8f065a42fc1a 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -101,6 +101,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	pci_ecam_free(cfg);
 	return ERR_PTR(err);
 }
+EXPORT_SYMBOL_GPL(pci_ecam_create);
 
 void pci_ecam_free(struct pci_config_window *cfg)
 {
@@ -121,6 +122,7 @@ void pci_ecam_free(struct pci_config_window *cfg)
 		release_resource(&cfg->res);
 	kfree(cfg);
 }
+EXPORT_SYMBOL_GPL(pci_ecam_free);
 
 /*
  * Function to implement the pci_ops ->map_bus method
@@ -143,6 +145,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 		base = cfg->win + (busn << cfg->ops->bus_shift);
 	return base + (devfn << devfn_shift) + where;
 }
+EXPORT_SYMBOL_GPL(pci_ecam_map_bus);
 
 /* ECAM ops */
 const struct pci_ecam_ops pci_generic_ecam_ops = {
@@ -153,6 +156,7 @@ const struct pci_ecam_ops pci_generic_ecam_ops = {
 		.write		= pci_generic_config_write,
 	}
 };
+EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 /* ECAM ops for 32-bit access only (non-compliant) */
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bbcef1a053ab..5b35f7fc2ace 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -26,6 +26,7 @@
 #include "pci.h"
 
 unsigned int pci_flags;
+EXPORT_SYMBOL_GPL(pci_flags);
 
 struct pci_dev_resource {
 	struct list_head list;
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 6c21dd0901ab..fd0edb8b8a00 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -59,7 +59,7 @@ extern const struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x
 extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
 #endif
 
-#ifdef CONFIG_PCI_HOST_COMMON
+#if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,
 			  const struct pci_ecam_ops *ops);
-- 
2.20.1

