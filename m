Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA83C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 06:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2652171F
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 06:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfABGRH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:17:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:6680 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbfABGRH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jan 2019 01:17:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2019 22:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,429,1539673200"; 
   d="scan'208";a="106280779"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.90])
  by orsmga008.jf.intel.com with SMTP; 01 Jan 2019 22:17:03 -0800
Received: by ubuntu (sSMTP sendmail emulation); Wed, 02 Jan 2019 14:16:59 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v3 2/2] dt-bindings: PCI: altera: Add altr,pcie-root-port-2.0
Date:   Wed,  2 Jan 2019 14:16:49 +0800
Message-Id: <1546409810-37630-3-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546409810-37630-1-git-send-email-ley.foon.tan@intel.com>
References: <1546409810-37630-1-git-send-email-ley.foon.tan@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for altr,pcie-root-port-2.0.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 .../devicetree/bindings/pci/altera-pcie.txt        |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
index 6c396f1..816b244 100644
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
1.7.1

