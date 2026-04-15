Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50716387359;
	Wed, 15 Apr 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237706; cv=none; b=rwmTrEWnyn7KmeWZ3LxAJI2lbyxOWPJt1KO0Hkfi8qWgHheqAohbjfqc1pq0KJH4TLogeDSRh052iABaZugi6NjvyyntO5z2UFF1su9O1HvHbTqnLVAT6sjXwzh+6dZMz0tdFuzymD0zRVTs0KNT4vJUj5BZQeSLNYnJ12eO1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237706; c=relaxed/simple;
	bh=kXanUtk0Z+qovTWMtEnCE6bIyzU1LFldyzcpZgOfTnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLRvZbGojCAVUCEsuErMMbTw6ok1npKMtss+HdrclkiWwmOyDUWO67uz+fzHbHAjPYI58jshLJzoddN4dWY0WEkx3pXkXFRHkzelYaCDNxq/i2qB/A7FyGprxjaj7HzDHDYCBSr3ecTD3nFv0IZdWPduvjYYL89VEU49AFUJnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=rT3j+86S; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="rT3j+86S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=9RcR/I77BpXlSQN2RD71AluqcNUviDV
	EiKCP77YvyBA=; b=rT3j+86SlLCbHDYxYmNTCCY8AYhx5Fvq8j40Z3kDy8UepPA
	am2WapESx9c+8llf4tVlO5sKFpVd3Cq11Rll+Fhw1CZ9fKh4F7SkRQHc2o9x2GYe
	PaLHCJ83rZVOrdMiR+PxtpKjnsMYmku5jtDMRn9m590HksGS0mfCXPsSJT2I=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUKdPN9poSgCAA--.1324S4;
	Wed, 15 Apr 2026 15:22:12 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Wed, 15 Apr 2026 15:21:18 +0800
Subject: [PATCH v3 2/3] dt-bindings: PCI: Add UltraRISC DP1000 PCIe
 controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-ultrarisc-pcie-v3-2-73f06e972616@ultrarisc.com>
References: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
In-Reply-To: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776237679; l=3909;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=kXanUtk0Z+qovTWMtEnCE6bIyzU1LFldyzcpZgOfTnA=;
 b=Jw/Hfu2HfAvuUQp0ma9RQfEiFSut1ef2zRJpxuX8p7ygTC8+JNjRiLYbzRhiUL1C21nSmo630
 hD9Gr0z0dJxC9P5arBz9pF1ElwdC1x6MHTqZ08d0qX2MARsI4smhJFb
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUKdPN9poSgCAA--.1324S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kZr4Utr1rAFW7XFWUurg_yoW5Kr43pF
	WUCFykCF4xtr13uw4fK3W0k3W5XF4vkF9YkwnFgw1UtFZ5Kw1jqrsIkw13G3W5Gr4UXry2
	9Fn0kw17Kw4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiy89tUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQASEWnfCz0AFgAAsU

Add UltraRISC DP1000 SoC PCIe controller devicetree bindings.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 93 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
new file mode 100644
index 000000000000..512b935bf5d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/ultrarisc,dp1000-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UltraRISC DP1000 PCIe Host Controller
+
+description:
+  UltraRISC DP1000 SoC PCIe host controller is based on the DesignWare PCIe IP.
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
+  interrupts:
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
+      pcie@21000000 {
+        compatible = "ultrarisc,dp1000-pcie";
+        reg = <0x0 0x21000000 0x0 0x01000000>,
+              <0x0 0x4fff0000 0x0 0x00010000>;
+        reg-names = "dbi", "config";
+        ranges = <0x81000000 0x0 0x4fbf0000 0x0 0x4fbf0000 0x0 0x00400000>,
+                 <0x82000000 0x0 0x40000000 0x0 0x40000000 0x0 0x0fbf0000>,
+                 <0xc3000000 0x40 0x00000000 0x40 0x00000000 0xd 0x00000000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        device_type = "pci";
+        dma-coherent;
+        bus-range = <0x0 0xff>;
+        num-lanes = <16>;
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
diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..2ec02d8443dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20582,6 +20582,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 F:	drivers/pci/controller/plda/pcie-starfive.c
 
+PCIE DRIVER FOR ULTRARISC DP1000
+M:	Xincheng Zhang <zhangxincheng@ultrarisc.com>
+M:	Jia Wang <wangjia@ultrarisc.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
+
 PCIE ENDPOINT DRIVER FOR QUALCOMM
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-pci@vger.kernel.org

-- 
2.34.1

