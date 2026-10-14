Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74055489881
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962591; cv=none; b=ZyJsIqg1W3hdFiB34H6fKm08b7C3B2cuD7bxdxWCQSNRXqpZ+RWTxIjBPSdKjN1rGkTyi/MOCD2YN9kVD6TMgZsII2dLUIrwxsX5/u+qVLqM7atOw6sOiR4YnewWetFZR4JZOzMWrfWduPGoNUua4+LdMx8XJ0yN8GHWr0PRibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962591; c=relaxed/simple;
	bh=VnEu0lRTEPC7qse15JcpP+s/pUqjm414wBR+oJw4mQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lofXLjA2yoqHZpAesfJbynPIWW3riJHAa/YvGCHnncgA+cQbE+FJyFtnlcOQnN/oSbtap+cvevS1TeL/VKCvpwPcVzjfoSVHuchIhGlNhYuNvDzHtWk4gYNK6Jsdcm/R7YMfWGmabSe2fKZiH//kG8AxAKQe0EeADN/iN3ISgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUb3K7sH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUb3K7sH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4649b35bso89097f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962586; x=1792567386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mjdo2hNwdnJXsJ4gHg2a0k4FrTqX21XKUgFm8PXlXeg=;
        b=pUb3K7sHWLs/VWhx1+aR52sQskZD0rWO84KnXZyZSJPZ0RWu/36gUZCJ6XsO70dWI1
         jHDq7KTxKf/A9hJFlof9TGG21XuDL+g38DpE3lieZkLznEnxOcexbuNQM7wKCnstlHDC
         gWzwslk/62VBacglHiju35DCCTqXBAxgqUkYtb81KEQr+CtRyzTFG5SnYykqJ/pg3HYD
         rUYxJlWiMAdXEzLo4SSKX4i9lNMWM8tu7MmQ9+KlcfAum4hAkCfakvp+UXkB9tyxxVHh
         2LAJlUW4qeaI7OaSiyYYz3v+DgJC388+7XELvEqFQ1tL8P19d44tbMoAO7qKF7VX6hY5
         pCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962586; x=1792567386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mjdo2hNwdnJXsJ4gHg2a0k4FrTqX21XKUgFm8PXlXeg=;
        b=lmxste8nyp9PIIhCDM+tMRe/VYVi5RmP/SHXEJV0Kb7hjGKf2P49eiVhMP2yC/WvW0
         EhmJmgkq1cNmMw9nyMihv1OA6qIfesUKKX4kjn7C+7S9XbYono/u4FljJUnTQOu4M4Ew
         V+DXr4J35HazAXpoBuvypNniJVBT48c0yIUBnPcu9DV1sOgsAQDeDqIHaC+F9rNR++WU
         arx3a84Es3puv8CZT5+X79gu9ImuqYAzq3f3xDrferoUoDEvTKRFWE4vzSBOg3fPvo9l
         k+R2lCgoQcQzeEfSPIiBmtmaMPQkT1xKFKHycYzQK3nxvF9S26+igE46uENtOEaoYKPh
         Xevw==
X-Forwarded-Encrypted: i=1; AKwUvBzVECzyuO8XEUph77gKPC9J/JUMp0w4ufXba32s7w5UAod3dTjZGquZg85CuIjYKcQ5SPm4NHtNYyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0U0tC8HMh46vbR5Z21+BjHhoNtbnHb46la8dSWzw1VxX3E3Ym
	ucAov4XVb0c7UTtoAgpOkxPv1yqwMpWRYrl9a/QQs5xqymdpe3gjCirI
X-Gm-Gg: AYBFou1Yubiw8y1U5foMkHIBGq0FqY5lgVIJXeOLUkAaSr4dTxT+J03Q52y4rSbSKw1
	2fJs4P2qrQ1g6gdS31//PPHpdeNY4UFvuAwXlfAKVtvUgGaW/oC/n9I2glasjXlQalO3qTWNRlm
	oknRTUSYSvV5gzadeiI4fMoDPLBO7e9KE8PuXALvpFHXSZN0DcQCPzvSTrJ5O3WlXeloRJb7cqI
	QEAZdMi0P8G7hDUtwmROYwMRjL43HwkyOO9cQ61IHwTF2f/0BE+j+pEgI2W36UpSiiWdn847K6q
	fk8VUhGYmWZSl0YCr5UvmVJsuonhouOAQeCfpY1QpMkibhAhlmWZCEPmSJ3uTaUhw9QM7ZSIOOp
	4LJUNwRPNEyLXiu6NTIT0PkqsBW0DgFBlycMP1YDGNEd52BBzYw1qAz855f2JZ7oqv1ls2wlNvK
	mEgnsMVk4o1gpawPdNRbiawOhFUrhPP9MnLgd6rU+mgXvSWuzGqRvsikpgl8c5JA1xnNPkRUZls
	nZLrVTtEwkgv/1fvd5OJIVNRi5YlpWRA0eh8j5HqVv2rSnY3KzrSkcZv4o0mM2iPV3nejsFHprO
	1/OXVF7dG7MWEgT/+aKMub8sv0iVKopTaoKP0O7XCLO7AEtDy9VB+1LgSw91AXw=
X-Received: by 2002:a5d:588e:0:b0:48d:c186:dcc6 with SMTP id ffacd0b85a97d-48dc186dd62mr23991885f8f.57.1791962585507;
        Wed, 14 Oct 2026 00:23:05 -0700 (PDT)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm8500933f8f.35.2026.10.14.00.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:23:05 -0700 (PDT)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Navid Ghahremani <ghahramani.navid@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/24] dt-bindings: PCI: Add ZTE ZX279128S host controller
Date: Wed, 14 Oct 2026 08:20:52 +0100
Message-ID: <20261014072109.1759502-13-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree binding for the DesignWare PCIe host controller on the
ZTE ZX279128S SoC, using standard clocks, resets, and phys properties.

Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
---
 .../bindings/pci/zte,zx279128s-pcie.yaml      | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml b/Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml
new file mode 100644
index 0000000000..dc0214511f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/zte,zx279128s-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE zx279128s PCIe host controller
+
+maintainers:
+  - Navid Ghahremani <ghahramani.navid@gmail.com>
+
+description:
+  The ZTE zx279128s has two PCIe host controllers based on the Synopsys
+  DesignWare PCIe IP, each with one lane. Their clocks, resets and PHYs are
+  controlled through the SoC's Top CRM blocks.
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
+
+properties:
+  compatible:
+    const: zte,zx279128s-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers
+      - description: Controller wrapper registers
+      - description: PCIe configuration space region
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: ctrl
+      - const: config
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PCIe controller clock
+
+  clock-names:
+    items:
+      - const: pcie
+
+  resets:
+    items:
+      - description: PCIe controller reset
+
+  reset-names:
+    items:
+      - const: core
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: pcie
+
+  reset-gpios:
+    maxItems: 1
+    description: Optional board GPIO reset line for downstream endpoints.
+
+  enable-gpios:
+    maxItems: 1
+    description: Optional second board GPIO enable line driven together with reset-gpios.
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - '#interrupt-cells'
+  - interrupt-map
+  - interrupt-map-mask
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - phys
+  - phy-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/zte,zx279128s-crm.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/zte,zx279128s-reset.h>
+
+    pcie@f000000 {
+        compatible = "zte,zx279128s-pcie";
+        reg = <0x0f000000 0x4000>,
+              <0x09500000 0x1000>,
+              <0x1c000000 0x200000>;
+        reg-names = "dbi", "ctrl", "config";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        bus-range = <0x00 0xff>;
+        ranges = <0x82000000 0 0x10000000 0x10000000 0 0x08000000>;
+        interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &gic GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &gic GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &gic GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &gic GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+        linux,pci-domain = <0>;
+        clocks = <&crm2 ZX279128S_CRM2_PCIE0_CLK>;
+        clock-names = "pcie";
+        resets = <&crm2 ZX279128S_CRM2_RESET_PCIE0>;
+        reset-names = "core";
+        phys = <&pcie0_phy>;
+        phy-names = "pcie";
+        reset-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
+        enable-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.55.0

