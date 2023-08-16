Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA21EC04FDF
	for <linux-pci@archiver.kernel.org>; Wed, 16 Aug 2023 10:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbjHPKn3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Aug 2023 06:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244021AbjHPKnZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 06:43:25 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF40272D
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=km1S8zZEcbuRQRFhnQ+j9vTvoJEJFWsqJkELKGUX9fM=; b=iipWif
        VziqxvoctkdD0a4uDomoV5Gx5g68x/BZgl/zd/rx26ND5tT8Rb8V+ovfpUGaNoCM
        mboweDoxfCKT+j2ABFnF222c+8dDB3z0/Jc8q3Vr940/R/LcY3JU3KGTMcEs54Rj
        Z0yezwMOGW2xUldHX/WCRTa2lmYvT2/A/Yq4EAxI7fIv0O22noPsq/Q1xTbzI20I
        oGjVy+2xmNrRoknxuSCfDfB8KLXcZQW5WXssUqsTyOJYS5ObWXoeomXwpwL+QdV6
        Ovg4Y7L+Xi5MrHSA6q3c9LsRHyPwVKJoCbSbd1fLbIJrV1/w98FYaMW1k1UYjD8c
        mG8GS/AawGQ9i4tA==
Received: (qmail 101970 invoked from network); 16 Aug 2023 12:43:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Aug 2023 12:43:10 +0200
X-UD-Smtp-Session: l3s3148p1@eVQp9gcDTr0gAwDPXy5qAJ1huuy56R1W
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: PCI: rcar-pci-host: add optional regulators
Date:   Wed, 16 Aug 2023 12:42:49 +0200
Message-Id: <20230816104251.19744-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230816104251.19744-1-wsa+renesas@sang-engineering.com>
References: <20230816104251.19744-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Support regulators found on the KingFisher board for miniPCIe (1.5 and
3.3v). For completeness, describe a 12v regulator while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/rcar-pci-host.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index 8fdfbc763d70..b6a7cb32f61e 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -68,6 +68,15 @@ properties:
   phy-names:
     const: pcie
 
+  vpcie1v5-supply:
+    description: The 1.5v regulator to use for PCIe.
+
+  vpcie3v3-supply:
+    description: The 3.3v regulator to use for PCIe.
+
+  vpcie12v-supply:
+    description: The 12v regulator to use for PCIe.
+
 required:
   - compatible
   - reg
@@ -121,5 +130,7 @@ examples:
              clock-names = "pcie", "pcie_bus";
              power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
              resets = <&cpg 319>;
+             vpcie3v3-supply = <&pcie_3v3>;
+             vpcie12v-supply = <&pcie_12v>;
          };
     };
-- 
2.35.1

