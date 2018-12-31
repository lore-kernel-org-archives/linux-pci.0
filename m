Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46E1C43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE620B1F
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 08:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeLaIZJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:25:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:36475 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbeLaIZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 03:25:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 00:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,421,1539673200"; 
   d="scan'208";a="306332780"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.241])
  by fmsmga006.fm.intel.com with SMTP; 31 Dec 2018 00:25:06 -0800
Received: by ubuntu (sSMTP sendmail emulation); Mon, 31 Dec 2018 16:25:01 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2 2/2] Documentation: dt-bindings: pci: altera: Add altr,pcie-root-port-2.0
Date:   Mon, 31 Dec 2018 16:24:53 +0800
Message-Id: <1546244693-34633-3-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546244693-34633-1-git-send-email-ley.foon.tan@intel.com>
References: <1546244693-34633-1-git-send-email-ley.foon.tan@intel.com>
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

