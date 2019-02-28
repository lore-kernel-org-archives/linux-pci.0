Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B266C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 02:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CC7218CD
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 02:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfB1CxI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:53:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:14214 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbfB1CxH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Feb 2019 21:53:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 18:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,421,1544515200"; 
   d="scan'208";a="324037319"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.176])
  by fmsmga005.fm.intel.com with SMTP; 27 Feb 2019 18:53:04 -0800
Received: by ubuntu (sSMTP sendmail emulation); Thu, 28 Feb 2019 18:53:04 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v6 3/3] dt-bindings: PCI: altera: Add altr,pcie-root-port-2.0
Date:   Thu, 28 Feb 2019 18:52:52 +0800
Message-Id: <1551351172-25424-4-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551351172-25424-1-git-send-email-ley.foon.tan@intel.com>
References: <1551351172-25424-1-git-send-email-ley.foon.tan@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for altr,pcie-root-port-2.0.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/altera-pcie.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
index 6c396f17c91a..816b244a221e 100644
--- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/altera-pcie.txt
@@ -1,11 +1,13 @@
 * Altera PCIe controller
 
 Required properties:
-- compatible :	should contain "altr,pcie-root-port-1.0"
+- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-root-port-2.0"
 - reg:		a list of physical base address and length for TXS and CRA.
+		For "altr,pcie-root-port-2.0", additional HIP base address and length.
 - reg-names:	must include the following entries:
 		"Txs": TX slave port region
 		"Cra": Control register access region
+		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
 - interrupts:	specifies the interrupt source of the parent interrupt
 		controller.  The format of the interrupt specifier depends
 		on the parent interrupt controller.
-- 
2.19.0

