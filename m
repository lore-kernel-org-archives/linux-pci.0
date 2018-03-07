Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37333 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933746AbeCGPmy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 10:42:54 -0500
Received: by mail-oi0-f66.google.com with SMTP id f186so1974423oig.4
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2018 07:42:54 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH 4/9] PCI: kirin_pcie_driver can be static
Date: Wed,  7 Mar 2018 09:42:38 -0600
Message-Id: <20180307154243.3205-5-robh@kernel.org>
In-Reply-To: <20180307154243.3205-1-robh@kernel.org>
References: <20180307154243.3205-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: kbuild test robot <fengguang.wu@intel.com>

This was generated from 0-day builder.

Fixes: c44f2aed62c2 ("PCI: improve compile test coverage")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
[robh: add commit msg]
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/dwc/pcie-kirin.c    | 2 +-
 drivers/pci/host/pci-ftpci100.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index dcc8cedf6e17..a6b88c7f6e3e 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -504,7 +504,7 @@ static const struct of_device_id kirin_pcie_match[] = {
 	{},
 };
 
-struct platform_driver kirin_pcie_driver = {
+static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
 	.driver			= {
 		.name			= "kirin-pcie",
diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index b9617d1c1d48..5008fd87956a 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -586,11 +586,11 @@ static int faraday_pci_probe(struct platform_device *pdev)
  * We encode bridge variants here, we have at least two so it doesn't
  * hurt to have infrastructure to encompass future variants as well.
  */
-const struct faraday_pci_variant faraday_regular = {
+static const struct faraday_pci_variant faraday_regular = {
 	.cascaded_irq = true,
 };
 
-const struct faraday_pci_variant faraday_dual = {
+static const struct faraday_pci_variant faraday_dual = {
 	.cascaded_irq = false,
 };
 
-- 
2.14.1
