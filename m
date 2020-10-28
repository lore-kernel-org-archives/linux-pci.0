Return-Path: <SRS0=cGNF=ED=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714F8C63699
	for <linux-pci@archiver.kernel.org>; Wed, 28 Oct 2020 02:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF8722283
	for <linux-pci@archiver.kernel.org>; Wed, 28 Oct 2020 02:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgJ1CGD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Oct 2020 22:06:03 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:21183 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbgJ1CGC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 22:06:02 -0400
X-IronPort-AV: E=Sophos;i="5.77,425,1596466800"; 
   d="scan'208";a="60995345"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Oct 2020 11:06:00 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7ED69417A611;
        Wed, 28 Oct 2020 11:06:00 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/3] dt-bindings: pci: rcar-pci-host: document r8a77965 bindings
Date:   Wed, 28 Oct 2020 11:05:50 +0900
Message-Id: <1603850751-32762-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the R-Car M3-N (R8A77965) SoC in the R-Car PCIe bindings.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index d286454..1c6a03b 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -31,6 +31,7 @@ properties:
             - renesas,pcie-r8a7795      # R-Car H3
             - renesas,pcie-r8a7796      # R-Car M3-W
             - renesas,pcie-r8a77961     # R-Car M3-W+
+            - renesas,pcie-r8a77965     # R-Car M3-N
             - renesas,pcie-r8a77980     # R-Car V3H
             - renesas,pcie-r8a77990     # R-Car E3
         - const: renesas,pcie-rcar-gen3 # R-Car Gen3 and RZ/G2
-- 
2.7.4

