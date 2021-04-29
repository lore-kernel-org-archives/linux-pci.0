Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4EC43461
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A341613FF
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 12:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbhD2MpB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Apr 2021 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhD2MpB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 08:45:01 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D08C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 05:44:14 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d4dd:70b4:3264:8d97])
        by michel.telenet-ops.be with bizsmtp
        id yckC240074p6Y3806ckCb8; Thu, 29 Apr 2021 14:44:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lc61b-001F8j-Ko; Thu, 29 Apr 2021 14:44:11 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lc61b-009VlG-6N; Thu, 29 Apr 2021 14:44:11 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: PCI: rcar-pci-host: Document missing R-Car H1 support
Date:   Thu, 29 Apr 2021 14:44:09 +0200
Message-Id: <fb0bb969cd0e5872ab5eac70e070242c0d8a5b81.1619700202.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

scripts/checkpatch.pl -f drivers/pci/controller/pcie-rcar-host.c:

    WARNING: DT compatible string "renesas,pcie-r8a7779" appears un-documented -- check ./Documentation/devicetree/bindings/
    #853: FILE: drivers/pci/controller/pcie-rcar-host.c:853:
    +	{ .compatible = "renesas,pcie-r8a7779",

Re-add the compatible value for R-Car H1, which was lost during the
json-schema conversion.  Make the "resets" property optional on R-Car
H1, as it is not present yet on R-Car Gen1 SoCs.

Fixes: 0d69ce3c2c63d4db ("dt-bindings: PCI: rcar-pci-host: Convert bindings to json-schema")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This was never enabled in the upstream r8a7779.dtsi, but the Linux
driver does support it.
---
 .../devicetree/bindings/pci/rcar-pci-host.yaml       | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index 4a2bcc0158e2d49a..8fdfbc763d704532 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -17,6 +17,7 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - const: renesas,pcie-r8a7779       # R-Car H1
       - items:
           - enum:
               - renesas,pcie-r8a7742      # RZ/G1H
@@ -74,7 +75,16 @@ required:
   - clocks
   - clock-names
   - power-domains
-  - resets
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          const: renesas,pcie-r8a7779
+then:
+  required:
+    - resets
 
 unevaluatedProperties: false
 
-- 
2.25.1

