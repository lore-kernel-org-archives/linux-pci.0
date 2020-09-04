Return-Path: <SRS0=2Jyt=CN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A3AC43461
	for <linux-pci@archiver.kernel.org>; Fri,  4 Sep 2020 10:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791F4208C7
	for <linux-pci@archiver.kernel.org>; Fri,  4 Sep 2020 10:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgIDKkO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:40:14 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:61196 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730029AbgIDKkG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 06:40:06 -0400
X-IronPort-AV: E=Sophos;i="5.76,389,1592838000"; 
   d="scan'208";a="56169409"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Sep 2020 19:40:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 73F1640061A2;
        Fri,  4 Sep 2020 19:39:58 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH 1/3] dt-bindings: pci: rcar-pci-ep: Document r8a774e1
Date:   Fri,  4 Sep 2020 11:38:49 +0100
Message-Id: <20200904103851.3946-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the support for R-Car PCIe EP on R8A774E1 SoC device.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
index 70c45f72ab20..a059c96c294b 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -18,6 +18,7 @@ properties:
           - renesas,r8a774a1-pcie-ep     # RZ/G2M
           - renesas,r8a774b1-pcie-ep     # RZ/G2N
           - renesas,r8a774c0-pcie-ep     # RZ/G2E
+          - renesas,r8a774e1-pcie-ep     # RZ/G2H
       - const: renesas,rcar-gen3-pcie-ep # R-Car Gen3 and RZ/G2
 
   reg:
-- 
2.17.1

