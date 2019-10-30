Return-Path: <SRS0=PrTz=YX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C213ACA9EC9
	for <linux-pci@archiver.kernel.org>; Wed, 30 Oct 2019 14:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C9C21734
	for <linux-pci@archiver.kernel.org>; Wed, 30 Oct 2019 14:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="IOw2lJSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfJ3OBd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:01:33 -0400
Received: from forward106j.mail.yandex.net ([5.45.198.249]:33401 "EHLO
        forward106j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbfJ3OBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2019 10:01:32 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 10:01:29 EDT
Received: from mxback10j.mail.yandex.net (mxback10j.mail.yandex.net [IPv6:2a02:6b8:0:1619::113])
        by forward106j.mail.yandex.net (Yandex) with ESMTP id 3135A11A1F94;
        Wed, 30 Oct 2019 16:54:46 +0300 (MSK)
Received: from iva8-e1a842234f87.qloud-c.yandex.net (iva8-e1a842234f87.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:e1a8:4223])
        by mxback10j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id V5E8gqFvMo-sjkCoBaY;
        Wed, 30 Oct 2019 16:54:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1572443686;
        bh=gWEa5FRcTgUF0nhJEpPZLRQAybGIQLvAfMzmy9iALuU=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=IOw2lJSLcgJgAiZbMTlg7+x1VaooTXAwE6jj0gMZGk7J5MyHLNqfW94LJLIM1z+/z
         mIzcq7YoUGpgeAZI3GH1NjqAojg2Pwszjmy9Gm1Xx1whBV/VImBVTSbc9iuYA6Aziy
         zCietABTtDDeDm9ZHK0BvlcREke9RmEz6WyJUc7I=
Authentication-Results: mxback10j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by iva8-e1a842234f87.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id iQ85YfuBaZ-sbUu9RH8;
        Wed, 30 Oct 2019 16:54:43 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        axboe@kernel.dk, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, bhelgaas@google.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-pci@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/5] dt-bindings: net: document loongson.pci-gmac
Date:   Wed, 30 Oct 2019 21:53:46 +0800
Message-Id: <20191030135347.3636-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030135347.3636-1-jiaxun.yang@flygoat.com>
References: <20191030135347.3636-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This binding will provide extra information for PCI enabled
device.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../net/wireless/loongson,pci-gmac.yaml       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/loongson,pci-gmac.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/loongson,pci-gmac.yaml b/Documentation/devicetree/bindings/net/wireless/loongson,pci-gmac.yaml
new file mode 100644
index 000000000000..5f764bd46735
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/loongson,pci-gmac.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/allwinner,sun7i-a20-gmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson PCI GMAC Device Tree Bindings
+
+allOf:
+  - $ref: "snps,dwmac.yaml#"
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+properties:
+  compatible:
+    const: loongson,pci-gmac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+    items:
+      - description: Combined signal for various interrupt events
+      - description: The interrupt to manage the remote wake-up packet detection
+      - description: The interrupt that occurs when Rx exits the LPI state
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+      - const: eth_lpi
+
+  clocks:
+    items:
+      - description: GMAC main clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - phy-mode
+
+examples:
+  - |
+    gmac: ethernet@ {
+        compatible = "loongson,pci-irq";
+        reg = <0x00001800 0 0 0 0>;
+        interrupts = <12>, <13>;
+        interrupt-names = "macirq", "eth_lpi";
+        clocks =  <&clk_pch_gmac>;
+        clock-names = "stmmaceth";
+        phy-mode = "rgmii";
+    };
+
+# FIXME: We should set it, but it would report all the generic
+# properties as additional properties.
+# additionalProperties: false
+
+...
-- 
2.23.0

