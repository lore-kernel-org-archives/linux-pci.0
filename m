Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC6372681;
	Tue,  7 Apr 2026 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775529765; cv=none; b=cAUiA92pNTym5LxEG1Rv8qn8hWkqhahqHmlrC5HRXT8girH3kxfp6Bo9L5TaJ1StB6TVMJsn/cjzN7llvj+QDTRBAjahvXPequwBSyxYq0USLO5c6hYsE9RuzMB6c8jPUkMX27iNxoBUbJsbf5Woq5BAMFZkk5DKj6H7BVASiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775529765; c=relaxed/simple;
	bh=n6k/8wVJxmWBeO9BePZHpNqxXLjgjCXk7EWhwiY8EOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwE8LvamjwodMSpNl+5naa+bW3XXkXJ0l9NAGOHqcyOnP2U3XuIjKCTRfrtzEus/hJg9BBgv3eYExvRy4gglg28svBgNfjkJyvWKkrzaeDRxwSqgmmIjTihqdvdIm8mCixhp5vRoRTl8Nvav4gwh5n73WhI8spWxtkw0UXZ3oLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=Fb1gbpfZ; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="Fb1gbpfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=zxY1VY+lBxzA0Zky0PLENhVVOAkvhGt
	yiMmOwdRciS4=; b=Fb1gbpfZ1PbdzGypBGkkuLkU8IFImjxgjCa7fP9BiDRaf9u
	V1i/GAq857YJ/nCedXZ/3mh8daCWiVzbxFsW5cN1XttLX1JT4jVSi3hUAe1JgUr/
	3wojOV3YhYCaS7ynCVuZkUZcKFzlP0VlLqn9TtUx5CY1AVGsjK3E9L+67KrU=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEELwbtRpBZsBAA--.862S5;
	Tue, 07 Apr 2026 10:42:04 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Tue, 07 Apr 2026 10:40:54 +0800
Subject: [PATCH v2 3/4] dt-bindings: PCI: Add UltraRISC DP1000 PCIe
 controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-ultrarisc-pcie-v2-3-2aa2a19a7fb3@ultrarisc.com>
References: <20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com>
In-Reply-To: <20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775529665; l=3584;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=n6k/8wVJxmWBeO9BePZHpNqxXLjgjCXk7EWhwiY8EOc=;
 b=4U9tay0snX893PxYeDI0ZtUoKjuXL9cGomfwis8ZKod2+9hoZwf3QZ4OiXHovJkU91RsSoM9B
 PF7UtjO9w8gDECWOyaFrErsZwUPF0xTyjBKlWU7xOW+IasOav+Fp3oS
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwDXEELwbtRpBZsBAA--.862S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kZr4UtrW7GrWktFWxtFb_yoW5ZryfpF
	W5Ca4kCF4xtr13uw4fG3W0kF15JF4vkFZYkwnFgw43JrZYgFWjqrsIkw43Jw15GrWDXw12
	gFn0v347Kw17Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUbAw7UUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnTLbsAJAAAsS

Add UltraRISC DP1000 SoC PCIe controller devicetree bindings.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
new file mode 100644
index 000000000000..d0517130e127
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/ultrarisc,dp1000-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UltraRISC DP1000 PCIe Host Controller
+
+description: |
+  UltraRISC DP1000 SoC PCIe host controller is based on the DesignWare PCIe IP.
+  This binding describes the UltraRISC specific extensions to the base
+  DesignWare PCIe binding.
+
+maintainers:
+  - Xincheng Zhang <zhangxincheng@ultrarisc.com>
+  - Jia Wang <wangjia@ultrarisc.com>
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: ultrarisc,dp1000-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: PCIe configuration space region.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+
+  num-lanes:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [4, 16]
+    description: Number of lanes to use.
+
+  max-link-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    const: 4
+    description: Maximum PCIe link speed supported.
+
+  interrupts:
+    description: List of interrupt specifiers used by the controller
+    items:
+      - description: MSI interrupt
+      - description: Legacy INTA interrupt
+      - description: Legacy INTB interrupt
+      - description: Legacy INTC interrupt
+      - description: Legacy INTD interrupt
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: inta
+      - const: intb
+      - const: intc
+      - const: intd
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie_x16: pcie@21000000 {
+        compatible = "ultrarisc,dp1000-pcie";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        reg = <0x0 0x21000000 0x0 0x01000000>,
+              <0x0 0x4fff0000 0x0 0x00010000>;
+        reg-names = "dbi", "config";
+        device_type = "pci";
+        dma-coherent;
+        bus-range = <0x0 0xff>;
+        num-lanes = <16>;
+        ranges = <0x81000000  0x0 0x4fbf0000  0x0 0x4fbf0000  0x0 0x00400000>,
+                 <0x82000000  0x0 0x40000000  0x0 0x40000000  0x0 0x0fbf0000>,
+                 <0xc3000000 0x40 0x00000000 0x40 0x00000000  0xd 0x00000000>;
+
+        max-link-speed = <4>;
+        interrupt-parent = <&plic>;
+        interrupts = <43>, <44>, <45>, <46>, <47>;
+        interrupt-names = "msi", "inta", "intb", "intc", "intd";
+        interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+        interrupt-map = <0x0 0x0 0x0 0x1 &plic 44>,
+                        <0x0 0x0 0x0 0x2 &plic 45>,
+                        <0x0 0x0 0x0 0x3 &plic 46>,
+                        <0x0 0x0 0x0 0x4 &plic 47>;
+      };
+    };

-- 
2.34.1

