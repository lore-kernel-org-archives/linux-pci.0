Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0ECA6F
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044055; cv=none; b=nYBpndrhWAlmuWzELke3JBLRb8DUrGWhfw+qOuI4cuou30IY/tLypsSCNQ+2SlNra7tHJ0zlL9eL/QOUgnrtOaUjMpm000KBNXfPs+EcJFlI74IXSYIwem4wlOIbXF9Ir/vFgFvdhiZBmmHqEBX3xPuDrTVhK1REUA/201NiMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044055; c=relaxed/simple;
	bh=jxRLXze+30Bd3HWJshR/WJ/vpy4kHy3z4wUO/puyrSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1Kyyo8lJm29trQGGbLZKxXvbbfFQz4zxC+3yBuQazIhSDyBg44+CdaiM2wuVml+L+KmlxQ0/gefhtL02nwOrPD4M51g73d2bR04Jq93SFZaokCIRL5dV5S3TTKdvm7YJZ7L1Vu17SVvn2/TaN4L3tW4Pk4ndArc12GTSloQWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHEiQf4Z; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHEiQf4Z"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso58853a91.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 19:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783044053; x=1783648853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSnOb5hOxX9yUplIfdpmrusjS/RN2Btqas6tLO5wHZk=;
        b=FHEiQf4ZFxMay8wPTlXRe35gUHz3Nsz2HVHHhkWlrt6aX/0Yig2twPUyOMFqqL8rqc
         fwPc0CRznz2Cok1b/Lci5PNwdcJg5DF21G1agHJTvYaBYjq6Hx5yWbRWUeH5XK/Ah2SZ
         CBJFAH0GG+hiWN1gtBP376bGPjYz4DunqD9dlThPrWav1ybSuJyonYtwOOfctHbPhV1a
         j0na8HqiU732duR/qPDyABU6LQkb9MKlT8iqREJe3a/OEYnFe8wMH/DCEUgvnMhGq+oH
         9WlPfHLXEulwECXAEL1SMNEbYPQytuvrThKGB5tLlA0hsafuemSLU9N4IWnMiP9LOnr7
         aJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044053; x=1783648853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSnOb5hOxX9yUplIfdpmrusjS/RN2Btqas6tLO5wHZk=;
        b=fSsPYW6Q+BAm115I9tU6QsCF4HB1R2Hq9HdkF9M8pgqO60t4CTent2UEH1IgSE97XT
         EvWx8hDPRA14LUakJ31aYvs1v7VvzGj2Nz7u7LZ9CffwGCIow2xnXcoxd3dl+WDhKJKd
         AY4cTB/2lRrs69XIFPpqTmuzo30SGDHvXG8Mvfm8zXjotUdzDdzacHRM/ewmhv+51Rc9
         /UVA5OsHRxerseeAy+UzcnztP9DEYcYj6YhS9B1TMys8J5zn+U8HqV0l7OLRK40+Hmjf
         ISPBzVQBJvlhGWYat6aY70wDSfB7bqF05XZ5OgyTWUCnt3yTaD7cFc7KDEA2+PjpDoXm
         yIeg==
X-Gm-Message-State: AOJu0YxEVmtadcQvqzXEj0kYVTJkIBxdvBzolIkhwiiVMv6xc0qqXO6R
	4ZYK02Gu169C6rxC9gvMK/HQvzgBSzkbmbQOvo0WyKofnbOa0meG3fBn
X-Gm-Gg: AfdE7cl0re0yvvU5PTIKU9hMyTvuSDgMmx9BiF+IHQvzT+Zk0KUsRwjOx2pRAC2ztnO
	NlQebQKg3tpHYO1ZOq9sDxzNvzhVkFmi15//dsi3wpKGkk63RsfQMJXyY4Nu69zXvEG/miUeYOl
	VCB4kR54Wfz0TVj/fmKEUipILCoN6jlI0wM+gSfBE27Ik5ZVUzMs+fe60Uh6esoxYZjM9cTR4RU
	KXc+sJdmyht+S2XSsFvZ7zGEdRtg0kOA5Y+GlsiLAVUYIfeWlogERpxJIP5862vmwfUIPYuwL4H
	97uUHiMpbmrUBtMu0dHHC5+p50W3ci9MnUCFPVlAVpIyCdaxK8R3sGF69Xi+S77Zmtx72j3Xyn1
	4kK8YvR5coujMdR0Zg8phC/ppnym5VVhPERJmbCSKuF2JyM3VfZM6XYJRelgxxcko0l7q1fWZp3
	OuygHRQhWs6fM=
X-Received: by 2002:a17:90b:4f4b:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-380aa184432mr8707455a91.18.1783044052854;
        Thu, 02 Jul 2026 19:00:52 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127adeb21sm189517a91.1.2026.07.02.19.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 19:00:52 -0700 (PDT)
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
	Christian Bruel <christian.bruel@foss.st.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
Date: Fri,  3 Jul 2026 10:00:01 +0800
Message-ID: <20260703020003.485436-6-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703020003.485436-1-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
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
 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
index c4c00b5fcdc0..720951b4ba77 100644
--- a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
@@ -14,26 +14,29 @@ description: >
   PCIe IP.  The controller uses the DesignWare built-in MSI interrupt
   controller, and supports 256 MSIs.
 
-allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
-
 properties:
   compatible:
-    const: spacemit,k1-pcie
+    enum:
+      - spacemit,k1-pcie
+      - spacemit,k3-pcie
 
   reg:
+    minItems: 4
     items:
       - description: DesignWare PCIe registers
       - description: ATU address space
       - description: PCIe configuration space
       - description: Link control registers
+      - description: Data Bus Interface (DBI) shadow registers.
 
   reg-names:
+    minItems: 4
     items:
       - const: dbi
       - const: atu
       - const: config
       - const: link
+      - const: dbi2
 
   clocks:
     items:
@@ -66,6 +69,8 @@ properties:
   interrupt-names:
     const: msi
 
+  msi-parent: true
+
   spacemit,apmu:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
@@ -84,7 +89,8 @@ patternProperties:
 
     properties:
       phys:
-        maxItems: 1
+        minItems: 1
+        maxItems: 6
 
       vpcie3v3-supply:
         description:
@@ -96,13 +102,39 @@ patternProperties:
 
     unevaluatedProperties: false
 
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k1-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 4
+
+        reg-names:
+          maxItems: 4
+
+      patternProperties:
+        '^pcie@':
+          properties:
+            phys:
+              maxItems: 1
+    else:
+      properties:
+        reg:
+          minItems: 5
+
+        reg-names:
+          minItems: 5
+
 required:
   - clocks
   - clock-names
   - resets
   - reset-names
-  - interrupts
-  - interrupt-names
   - spacemit,apmu
 
 unevaluatedProperties: false
-- 
2.55.0

