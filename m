Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231F2FFDD6
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778982567; cv=none; b=i59sboshnirR4neBv8DtkQxb8gzVbTFU29cReQzTfL9kKZkvSXDEyLRKIFgPzuBNo7E2i01in3O1gVIx/C/VU5Y72m7bdZVXwMEWCN5If2FsTmQT/su+OdPsnqZ5Jf4nvGKWc04SFwaQDC5MN92I3LqZbhCcHHFTeA78ntkS9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778982567; c=relaxed/simple;
	bh=44csRfRZMQMnbhYT2ypXHrgXGaPwDpJHCybAdwDm4h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt60kbK3ik/edZ3ebOtQ24g1/+1eEDFpM4vhj8gBzXqlgXhi134yXAqyokbP/inFfr8O6mUFDhej6lT7y5YPWSR0a1tIkI3TmEiLKQFw6nj8pfCVT+YMfZevCMhneSxo8fggsrG5r+u5Pl7Et51oVUCGSVcz5NbpZ8nm7RGjn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd5TQ3kz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd5TQ3kz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bd80b3aa13so6732965ad.0
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 18:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778982565; x=1779587365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCXH+i9l3J50hp/oNhGfXSVKTT+GnfnP1ORn6KkZK5A=;
        b=bd5TQ3kzwCV/vnoQwr6ceHqnjEvFKplsJH059wN4gCnkns6jisbcHlWEL++eydgSgv
         fzNzM5XSnkixlClWTABMMWENKX96dUI4ReyiHV5zhiQtGH8eCq7/ZVDRF6kjuDYs63og
         MGaFV1OID6Mz/+spGar7cQKp/jJy5ARfRtMUA4hJ4cyB/Iye3H+hBGX7AQn260oCFIaQ
         BWUdUIUe8VjX0gz3dvnq9shuHrBkd1kSNXzWlL1JhSn3/PVrMUOdUF6nvIZkIMibzaKU
         3Gydc8jLGva2rKWslwyNZ1rKoFyJ+tv5TjdoBP2UDsosQ9F+v3nqNl8kHn28l5VI8jNT
         1DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778982565; x=1779587365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCXH+i9l3J50hp/oNhGfXSVKTT+GnfnP1ORn6KkZK5A=;
        b=ZSFPo2NQMsykWnIF4ZKvDntMMq9yhX0hYD4TQiBuxrlpcsIaQHRH7SPlJeexJRQu/p
         GZowQzUtsPsnjN6J+j4HTZWC8QeD9qpwz3X0oeToHeIM5Z3aBC9PTsWnnQdFORRcZJxh
         dDlk00VMUDlXgZeBrJjeq98lx6E5C2WnRRQ4gS3+EyFPT0Gs2O17UNiyzmQCktjXuS2s
         xuIRJ5otvWN2V6kALzizKic3yR06XpRcaWbizasaXNS6N7u7tmLpsRkpSn2c4FfdfhKg
         CvDYNjCaCMYKGnH8LrhKrdcHoWd73Qx5IuAUDwl8hiZ2T7QyKy+fpvf+hTg3JX3Pnx/P
         HCUw==
X-Gm-Message-State: AOJu0YwWewoJTo9NKx/arqjWtekvqqS1K5ehgM2Mm00VxH5rqEVTQpaM
	SIKjJcCOhG9IiZcziwFlr7S6y2rY8aWIBhUS3sW1eEGx2gbZxWuPV9IN
X-Gm-Gg: Acq92OHo0Qz0iBGLnYDs/atzJFJML3YiwkstofV3l0j5M8vr89IjmCG7qyxPSls4s/f
	/U5LKml4sIlmttSazD9MR2alpT15l+mVBcnxlHy6uXzylD8G/fTbqAzpvTxoGZ0wH8alMtMaoZe
	X/oW3GXZuVicznZpkPJqbOn3nsUSqSPS6OcnglcZD94fOVNP4B1njAcLIJc14B97XWL/ZTdxCNY
	jvkfJ/CqrnL1de2aDckiJyWsIBr6Ug7mfmi4DuImwAnGGsptX7RBUtFh0PpsqtB5v7qH4GicTjL
	3c09dBHusDruu68mZwqu1qySZI4smO0RA+obNWztQoBLDrnzG8Zn/x7hvUi5ySO+oeVXVoolkaE
	xLjM0oflmR279gvGZcH5pN4WZ3IC3B51RCnWqjFPbjPjIOpycPWhQuO9/dDnYEWGuc6iUjbNzmN
	wiknHT0ZPmEoGmbM5jEusvWVSlbIaLiCS/3w==
X-Received: by 2002:a17:903:1209:b0:2bd:d4dc:a4f9 with SMTP id d9443c01a7336-2bdd4dcb523mr2759755ad.26.1778982565125;
        Sat, 16 May 2026 18:49:25 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49a4sm95507955ad.38.2026.05.16.18.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:49:24 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Inochi Amaoto <inochiama@gmail.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Alex Elder <elder@riscstar.com>,
	Nam Cao <namcao@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Randolph Lin <randolph@andestech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 4/5] dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
Date: Sun, 17 May 2026 09:48:39 +0800
Message-ID: <20260517014841.254085-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517014841.254085-1-inochiama@gmail.com>
References: <20260517014841.254085-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding support for the PCIe controller on the SpacemiT K3 SoC.
This controller is almost a standard Synopsys DesignWare PCIe IP,
with some extra link and reset state control.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/pci/spacemit,k3-pcie-host.yaml   | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
new file mode 100644
index 000000000000..46147a37a9ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/spacemit,k3-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K3 PCI Express Host Controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+description:
+  The SpacemiT K3 SoC PCIe host controller is based on the Synopsys
+  DesignWare PCIe IP. The controller uses the external MSI interrupt
+  controller.
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k3-pcie
+
+  reg:
+    items:
+      - description: DesignWare PCIe registers
+      - description: Data Bus Interface (DBI) shadow registers
+      - description: ATU address space
+      - description: PCIe configuration space
+      - description: Link control registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: atu
+      - const: config
+      - const: link
+
+  clocks:
+    items:
+      - description: DWC PCIe Data Bus Interface (DBI) clock
+      - description: DWC PCIe application AXI-bus master interface clock
+      - description: DWC PCIe application AXI-bus slave interface clock
+
+  clock-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  resets:
+    items:
+      - description: DWC PCIe Data Bus Interface (DBI) reset
+      - description: DWC PCIe application AXI-bus master interface reset
+      - description: DWC PCIe application AXI-bus slave interface reset
+
+  reset-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  msi-parent: true
+
+  phys:
+    description:
+      PHY phandle from the Combo PHY, the lane number does not depends
+      on this, since the number of lanes provided by Combo PHY can be
+      1 or 2.
+    minItems: 1
+    maxItems: 6
+
+  phy-names:
+    minItems: 1
+    maxItems: 6
+
+  spacemit,apmu:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle that refers to the APMU system controller, whose regmap is
+      used in managing resets and link state, along with and offset of its
+      reset control register.
+    items:
+      - items:
+          - description: phandle to APMU system controller
+          - description: register offset
+
+required:
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - msi-parent
+  - spacemit,apmu
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
+      pcie@80000000 {
+        compatible = "spacemit,k3-pcie";
+        reg = <0x0  0x80000000 0x0 0x00001000>,
+              <0x0  0x80100000 0x0 0x00001000>,
+              <0x0  0x80300000 0x0 0x00003f20>,
+              <0x11 0x00000000 0x0 0x00010000>,
+              <0x0  0x82900000 0x0 0x00001000>;
+        reg-names = "dbi", "dbi2", "atu", "config", "link";
+        device_type = "pci";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        clocks = <&syscon_apmu 89>,
+                 <&syscon_apmu 56>,
+                 <&syscon_apmu 57>;
+        clock-names = "dbi", "mstr", "slv";
+        msi-parent = <&simsic>;
+        ranges = <0x01000000 0x00 0x00010000 0x11 0x00010000 0x0 0x00100000>,
+                 <0x02000000 0x0  0x00110000 0x11 0x00110000 0x0 0x7fef0000>,
+                 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x1 0x00000000>;
+        resets = <&syscon_apmu 76>,
+                 <&syscon_apmu 78>,
+                 <&syscon_apmu 77>;
+        reset-names = "dbi", "mstr", "slv";
+        linux,pci-domain = <0>;
+        spacemit,apmu = <&syscon_apmu 0x1f0>;
+      };
+    };
+
-- 
2.54.0

