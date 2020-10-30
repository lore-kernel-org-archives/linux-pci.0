Return-Path: <SRS0=OHpB=EF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4917FC6379D
	for <linux-pci@archiver.kernel.org>; Fri, 30 Oct 2020 05:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025892220B
	for <linux-pci@archiver.kernel.org>; Fri, 30 Oct 2020 05:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgJ3F3P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Oct 2020 01:29:15 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:22044 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725781AbgJ3F3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 01:29:13 -0400
X-IronPort-AV: E=Sophos;i="5.77,432,1596466800"; 
   d="scan'208";a="61013960"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Oct 2020 14:29:11 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1538F400F798;
        Fri, 30 Oct 2020 14:29:11 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 2/3] dt-bindings: pci: rcar-pci-host: document r8a77965 bindings
Date:   Fri, 30 Oct 2020 14:29:04 +0900
Message-Id: <1604035745-22095-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the R-Car M3-N (R8A77965) SoC in the R-Car PCIe bindings.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index 40c38a6..c93b0d1 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -34,6 +34,7 @@ properties:
               - renesas,pcie-r8a7795      # R-Car H3
               - renesas,pcie-r8a7796      # R-Car M3-W
               - renesas,pcie-r8a77961     # R-Car M3-W+
+              - renesas,pcie-r8a77965     # R-Car M3-N
               - renesas,pcie-r8a77980     # R-Car V3H
               - renesas,pcie-r8a77990     # R-Car E3
           - const: renesas,pcie-rcar-gen3 # R-Car Gen3 and RZ/G2
-- 
2.7.4

