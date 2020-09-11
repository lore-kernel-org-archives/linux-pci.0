Return-Path: <SRS0=v1Y9=CU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF87C43461
	for <linux-pci@archiver.kernel.org>; Fri, 11 Sep 2020 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9F220665
	for <linux-pci@archiver.kernel.org>; Fri, 11 Sep 2020 08:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKIuQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:50:16 -0400
Received: from mx.socionext.com ([202.248.49.38]:29483 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgIKIuP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 04:50:15 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Sep 2020 17:50:14 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 28C0B1800EE;
        Fri, 11 Sep 2020 17:50:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Sep 2020 17:50:14 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 9D5351A050C;
        Fri, 11 Sep 2020 17:50:13 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/3] dt-bindings: PCI: uniphier: Add iATU register description
Date:   Fri, 11 Sep 2020 17:50:01 +0900
Message-Id: <1599814203-14441-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the dt-bindings, "atu" reg-names is required to get the register space
for iATU in Synopsys DWC version 4.80 or later.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/uniphier-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
index 1fa2c59..c4b7381 100644
--- a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
@@ -16,6 +16,7 @@ Required properties:
     "dbi"    - controller configuration registers
     "link"   - SoC-specific glue layer registers
     "config" - PCIe configuration space
+    "atu"    - iATU registers for DWC version 4.80 or later
 - clocks: A phandle to the clock gate for PCIe glue layer including
 	the host controller.
 - resets: A phandle to the reset line for PCIe glue layer including
-- 
2.7.4

