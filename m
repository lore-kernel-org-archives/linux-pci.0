Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43202 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933746AbeCGPmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 10:42:46 -0500
Received: by mail-ot0-f195.google.com with SMTP id m22so2430642otf.10
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2018 07:42:46 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
Subject: [PATCH 1/9] PCI: kirin: remove unnecessary asm/compiler.h include
Date: Wed,  7 Mar 2018 09:42:35 -0600
Message-Id: <20180307154243.3205-2-robh@kernel.org>
In-Reply-To: <20180307154243.3205-1-robh@kernel.org>
References: <20180307154243.3205-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

compiler.h is unnecessary and doesn't exist on some arches, so remove
it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/dwc/pcie-kirin.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index 13d839bd6160..dcc8cedf6e17 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -8,7 +8,6 @@
  * Author: Xiaowei Song <songxiaowei@huawei.com>
  */
 
-#include <asm/compiler.h>
 #include <linux/compiler.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.14.1
