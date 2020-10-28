Return-Path: <SRS0=cGNF=ED=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D56C6369E
	for <linux-pci@archiver.kernel.org>; Wed, 28 Oct 2020 02:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1624122281
	for <linux-pci@archiver.kernel.org>; Wed, 28 Oct 2020 02:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgJ1CGC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Oct 2020 22:06:02 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:3619 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725805AbgJ1CGC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 22:06:02 -0400
X-IronPort-AV: E=Sophos;i="5.77,425,1596466800"; 
   d="scan'208";a="60779613"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2020 11:06:00 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9BAD14178AB9;
        Wed, 28 Oct 2020 11:06:00 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 3/3] dt-bindings: pci: rcar-pci: Add device tree support for r8a774e1
Date:   Wed, 28 Oct 2020 11:05:51 +0900
Message-Id: <1603850751-32762-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add PCIe support for the RZ/G2H (a.k.a. R8A774E1).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index 1c6a03b..48dfec9 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -28,6 +28,7 @@ properties:
             - renesas,pcie-r8a774a1     # RZ/G2M
             - renesas,pcie-r8a774b1     # RZ/G2N
             - renesas,pcie-r8a774c0     # RZ/G2E
+            - renesas,pcie-r8a774e1     # RZ/G2H
             - renesas,pcie-r8a7795      # R-Car H3
             - renesas,pcie-r8a7796      # R-Car M3-W
             - renesas,pcie-r8a77961     # R-Car M3-W+
-- 
2.7.4

