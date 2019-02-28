Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31183C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 02:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DC8218A5
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 02:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfB1CxF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:53:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:1335 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbfB1CxE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Feb 2019 21:53:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 18:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,421,1544515200"; 
   d="scan'208";a="127817059"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.176])
  by fmsmga008.fm.intel.com with SMTP; 27 Feb 2019 18:53:01 -0800
Received: by ubuntu (sSMTP sendmail emulation); Thu, 28 Feb 2019 18:53:00 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v6 2/3] PCI: altera: Enable driver on ARM64
Date:   Thu, 28 Feb 2019 18:52:51 +0800
Message-Id: <1551351172-25424-3-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551351172-25424-1-git-send-email-ley.foon.tan@intel.com>
References: <1551351172-25424-1-git-send-email-ley.foon.tan@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIE_ALTERA on ARM64 platform.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 6671946dbf66..6012f3059acd 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -175,7 +175,7 @@ config PCIE_IPROC_MSI
 
 config PCIE_ALTERA
 	bool "Altera PCIe controller"
-	depends on ARM || NIOS2 || COMPILE_TEST
+	depends on ARM || NIOS2 || ARM64 || COMPILE_TEST
 	help
 	  Say Y here if you want to enable PCIe controller support on Altera
 	  FPGA.
-- 
2.19.0

