Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B52E339C
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690446; cv=none; b=iA4AyaC9wzBgZQdZXILisy+qYEz71VtsNzqikfFJ9DHPYGwdq8PYiZ26cLgHASka1Vt/6BHNrc1lnkFoD9JgTFEd8hR/0sFlBDVJpOQZdfTwIHEbsFda8qFUnrkqs45rb1WjXj9PZDIRuc/5+LuxxTDO5xsiXr5Uf+HBtLSdDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690446; c=relaxed/simple;
	bh=yHsEtpPni5gtDjtiPZ2Xic8sxC7qWM1WFMNybVML6V8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJlnWUVrJxg0Wk+M6g+QNTKzwgiEkS7020ReriZJCxxZRHon9xwyhmyXFxOi4C22yCYkWO6fqPyiVslfXm8B8kJoh4kOgU+TrBDurQ6s5UIdv7CStX2vPHQEglxvnrJCwqAG67cuQVy7jzvKdeKsIJ/FKSWsVSpH26k15ZeZ120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 57KBJD4K019065
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:19:13 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 57KBIrQq018799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 19:18:53 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Aug 2025
 19:18:53 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-pci@vger.kernel.org>
CC: <ben717@andestech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>,
        Randolph Lin <randolph@andestech.com>
Subject: [PATCH 3/6] dt-bindings: Add Andes QiLai PCIe support
Date: Wed, 20 Aug 2025 19:18:40 +0800
Message-ID: <20250820111843.811481-4-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820111843.811481-1-randolph@andestech.com>
References: <20250820111843.811481-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 57KBJD4K019065

Add the Andes QiLai PCIe node, which includes 3 Root Complexes.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 .../bindings/pci/andestech,qilai-pcie.yaml    | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
new file mode 100644
index 000000000000..2c67b3a6828e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/andestech,qilai-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes QiLai PCIe host controller
+
+description: |+
+  Andes QiLai PCIe host controller is based on the Synopsys DesignWare
+  PCI core. It shares common features with the PCIe DesignWare core and
+  inherits common properties defined in
+  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
+
+maintainers:
+  - Randolph Lin <randolph@andestech.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: andestech,qilai-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: PCIe configuration space region.
+      - description: APB registers.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: apb
+
+  ranges:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-controller: true
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - "#interrupt-cells"
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pci@80000000 {
+        compatible = "andestech,qilai-pcie";
+        device_type = "pci";
+        reg = <0x00 0x80000000 0x00 0x20000000>,
+              <0x20 0x00000000 0x00 0x00010000>,
+              <0x00 0x04000000 0x00 0x00001000>;
+        reg-names = "dbi", "config", "apb";
+        bus-range = <0x0 0xff>;
+        num-viewport = <4>;
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x02000000 0x00 0x10000000 0x20 0x10000000 0x0 0xF0000000>,
+                 <0x43000000 0x01 0x00000000 0x21 0x0000000 0x1F 0x00000000>;
+
+        #interrupt-cells = <1>;
+        interrupts = <0xF>;
+        interrupt-names = "msi";
+        interrupt-parent = <&plic0>;
+        interrupt-controller;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &plic0 0xF IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &plic0 0xF IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &plic0 0xF IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &plic0 0xF IRQ_TYPE_LEVEL_HIGH>;
+      };
+
+      pci@a0000000 {
+        compatible = "andestech,qilai-pcie";
+        device_type = "pci";
+        reg = <0x00 0xA0000000 0x00 0x20000000>,
+              <0x10 0x00000000 0x00 0x00010000>,
+              <0x00 0x04001000 0x00 0x00001000>;
+        reg-names = "dbi", "config", "apb";
+        bus-range = <0x0 0xff>;
+        num-viewport = <4>;
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x02000000 0x00 0x10000000 0x10 0x10000000 0x0 0xF0000000>,
+                 <0x43000000 0x01 0x00000000 0x11 0x00000000 0x7 0x00000000>;
+
+        #interrupt-cells = <1>;
+        interrupts = <0xE>;
+        interrupt-names = "msi";
+        interrupt-parent = <&plic0>;
+        interrupt-controller;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &plic0 0xE IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &plic0 0xE IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &plic0 0xE IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &plic0 0xE IRQ_TYPE_LEVEL_HIGH>;
+      };
+
+      pci@c0000000 {
+        compatible = "andestech,qilai-pcie";
+        device_type = "pci";
+        reg = <0x00 0xC0000000 0x00 0x20000000>,
+              <0x18 0x00000000 0x00 0x00010000>,
+              <0x00 0x04002000 0x00 0x00001000>;
+        reg-names = "dbi", "config", "apb";
+        bus-range = <0x0 0xff>;
+        num-viewport = <4>;
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x02000000 0x00 0x10000000 0x18 0x10000000 0x0 0xF0000000>,
+                 <0x43000000 0x01 0x00000000 0x19 0x00000000 0x7 0x00000000>;
+
+        #interrupt-cells = <1>;
+        interrupts = <0xD>;
+        interrupt-names = "msi";
+        interrupt-parent = <&plic0>;
+        interrupt-controller;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &plic0 0xD IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &plic0 0xD IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &plic0 0xD IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &plic0 0xD IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
-- 
2.34.1

