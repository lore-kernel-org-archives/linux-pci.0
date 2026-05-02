Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB932ABC0
	for <linux-pci@vger.kernel.org>; Sat,  2 May 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777716836; cv=none; b=WtHhOkvhRN1DrMvmNMknkJ3d+Zk5bUdH3A7x3tf1UUrWRDfyQ8cxCVlUuHi21pWnuNAb0ppr9mZFSyIdd0wjd6eh/OqyigiaEEVKtuKUM1vrAln6wg5xI/xBjSwcWspIP30wVaU/1h/y0SRb70cPhYiEMcTHrZ0AiPzsH4lyroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777716836; c=relaxed/simple;
	bh=nSlzbIx7Nmk0KHaWQK/SZMleU7sulO2Kk1O2J1oM+3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDGdIfDAU0ZdJEw0/HVOPk11tED+IpsFa9pcXta14JxoEymKzDActTsT1ObTw3QyOtYeQ7PIycYaCYCQcVzah/Cgk5t/kJMtax8s9yOMiHN9hMQCUtpje81WyRsY9avZrLy0S+xeJrHee+TA8jpf+s+wnP7bB5IVgpDD84yr5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZKTfUwB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZKTfUwB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso2367435ad.0
        for <linux-pci@vger.kernel.org>; Sat, 02 May 2026 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777716832; x=1778321632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMpwp33NUvTYaPHi9wjn2SqCZPfqp0TeYPs16K2j4ho=;
        b=AZKTfUwB/DqxeKDS60BVcxePyis1GEVsYXNgC5M+wVgbN4PbehGvp8p2xZ50dOrmWS
         7VWxmNv9KyHFs2bEZoFUfEdRjKsIUHzHQymCxtmd5OdTpNDvF687WbGPLcwp7q4jOFER
         9+3jw3nSP9f1cIwqvDDWZCdQTNEm3m/opOLBEfyZ4epjNVWNuSN+0gsWuD4EDx/cWyiM
         TTDEaX0EeflRKkOgJ/Vdq6iIxLoAteApj4IBvrqnRsUEU/589eQyNIP6txGboUAIg8gO
         Mv0VLHWrjg2pa50V1JqyqVbTdlVgEOmcUBN/kWa0smSCxezf5Y6zl8bYRwVLrveHseN4
         vhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777716832; x=1778321632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMpwp33NUvTYaPHi9wjn2SqCZPfqp0TeYPs16K2j4ho=;
        b=d7tOVmfmawe22gaXHEMxhh9sxRdHopZRqdHCS5c4fucwi27Qn1CtCKWK/b5L8w9Yfm
         xKtiFNmfk62UyW70zY25PkJ+3lw4Fz9RSbrvksBJsMJ+urPji3M+pOhJCDA4hDMXb88o
         6/0KRX86obbt0HI9ZE7gimU5vHN22JcjmkF5F+x1ocqj7AawWgjXQGU/Dp2+JeNkfy82
         Kbxlxwd421rUkknDTMEe1Ar2xh0Hxo0YkcZc5AVcoLRN5QMyCiNX9toKn1JIjKs0liKJ
         UAd39Ce68V21fMwODDxFU0YnFGGBTMTey8l0v+FYJQ4Tgu1aYquj+ScYA89Nfc/BKHOI
         BhdA==
X-Gm-Message-State: AOJu0Yz1eKxIRYntAZCL17WVj8MGJHtbZA+oCG2ddcGa3W0X4Kc+Ugrj
	reRfsBpwupE3XbfO8wH6jDUcut4/g6zUtjzvSDEZDsyYog3oo4x3lQD2
X-Gm-Gg: AeBDiethdfgGFFMGYHyk5WX05ANOinK4GZ/U8sTjuAE3sW5aYQpLZlnyXsjonmOXuu8
	M8oTby/q51ngedezN9p/fEah/89qkCPE1keQYbzS+NzLEjTOpXf9rOraI33kVy6gWovVZw0iKXt
	dKFW63SwhsYpuYPrGy5DV8PgzcKpwdaXeuyYmmNuLeYLbu+eAzQyHrE6Aon16LGKkl+opFLrZgE
	fQyEgSvsDFatXN1daygoqtqMipVN5wfh89wVFkMlcatrpDjHk57QTLCqR9rlEYudEWZPqLZn5T2
	fDNNQ6czqyNi6lyw+QSrvT6Xw1YNrH/yLddYpdF8KdPNMnLabF92BikZlqE4+JsGFLnXiDANeqz
	I2xapKvuPIOFxep0dQau+I1/Qld/g4IOEfpRzjBvKFbsJHZMgz8UDGzDlbBuR8TD+RSdp1YQx1E
	i5WgOp2WfiONRVa/4Xg+kAzq+rqvHkJf301w==
X-Received: by 2002:a17:902:ebc4:b0:2b4:5dad:2523 with SMTP id d9443c01a7336-2b9f2815bb5mr27612865ad.35.1777716831640;
        Sat, 02 May 2026 03:13:51 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae36885sm47201105ad.59.2026.05.02.03.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 03:13:51 -0700 (PDT)
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
	Alex Elder <elder@riscstar.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 4/5] dt-bindings: pci: spacemit: Introduce Spacemit K3 PCIe host controller
Date: Sat,  2 May 2026 18:13:17 +0800
Message-ID: <20260502101319.2364052-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260502101319.2364052-1-inochiama@gmail.com>
References: <20260502101319.2364052-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding support for the PCIe controller on the SpacemiT K3 SoC.
This controller is almost a standard Synopsys Designware PCIe IP,
with some extra link and reset state control.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/pci/spacemit,k3-pcie-host.yaml   | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
new file mode 100644
index 000000000000..be2641526b19
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
@@ -0,0 +1,142 @@
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
+  DesignWare PCIe IP.  The controller uses the external MSI interrupt
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
+  interrupts:
+    items:
+      - description: Interrupt used for port state
+
+  interrupt-names:
+    const: app
+
+  msi-parent: true
+
+  phys:
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
+  - interrupts
+  - interrupt-names
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
+        interrupts = <141 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "app";
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

