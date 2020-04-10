Return-Path: <SRS0=9Ijd=52=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D781DC2BB85
	for <linux-pci@archiver.kernel.org>; Fri, 10 Apr 2020 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE756208E4
	for <linux-pci@archiver.kernel.org>; Fri, 10 Apr 2020 09:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDJJam (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:30:42 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:55928 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbgDJJam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 05:30:42 -0400
X-IronPort-AV: E=Sophos;i="5.72,366,1580742000"; 
   d="scan'208";a="44365938"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Apr 2020 18:30:41 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 056A44201A35;
        Fri, 10 Apr 2020 18:30:41 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, robh+dt@kernel.org
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] dt-bindings: pci: rcar: add r8a77961 support
Date:   Fri, 10 Apr 2020 18:30:20 +0900
Message-Id: <1586511020-31833-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for r8a77961 (R-Car M3-W+).

To avoid confusion between R-Car M3-W (R8A77960) and R-Car M3-W+
(R8A77961), this patch also updates the comment of
"renesas,pcie-r8a7796".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 12702c8..1041c44a 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -11,7 +11,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
 	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
 	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
-	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
+	    "renesas,pcie-r8a7796" for the R8A77960 SoC;
+	    "renesas,pcie-r8a77961" for the R8A77961 SoC;
 	    "renesas,pcie-r8a77980" for the R8A77980 SoC;
 	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
 	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
-- 
2.7.4

