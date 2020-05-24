Return-Path: <SRS0=Hy9I=7G=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F149C433E0
	for <linux-pci@archiver.kernel.org>; Sun, 24 May 2020 21:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09170207FB
	for <linux-pci@archiver.kernel.org>; Sun, 24 May 2020 21:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbgEXVkC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 24 May 2020 17:40:02 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:17462 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387879AbgEXVkC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 May 2020 17:40:02 -0400
X-IronPort-AV: E=Sophos;i="5.73,431,1583161200"; 
   d="scan'208";a="47678206"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 May 2020 06:40:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D78F640E44D5;
        Mon, 25 May 2020 06:39:57 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/8] dt-bindings: dmaengine: renesas,usb-dmac: Add binding for r8a7742
Date:   Sun, 24 May 2020 22:37:53 +0100
Message-Id: <1590356277-19993-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document RZ/G1H (R8A7742) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
index 9ca6d8d..03aea6a 100644
--- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r8a7742-usb-dmac  # RZ/G1H
           - renesas,r8a7743-usb-dmac  # RZ/G1M
           - renesas,r8a7744-usb-dmac  # RZ/G1N
           - renesas,r8a7745-usb-dmac  # RZ/G1E
-- 
2.7.4

