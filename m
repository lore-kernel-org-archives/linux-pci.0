Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B93384CC4
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569697; cv=none; b=qYnYdqKB+pD4F1xpHNnlrgNFC5P0gJoN4jQWPq85QiWMINSwJ6vrzlowzoTc5hjcWaZ6hl+o2GFJ3Mo+8rmmaGnjm05944ZvQ7cmlL1dUij/B7PNnGtPon6Qw+DWiNafQ7c/42FL2l4eSr4B00GOqM8JXDzimdysf95DRGP3IOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569697; c=relaxed/simple;
	bh=tT7VHBhWW/0ENtiLY3CsIjS6UXJSVBBo9toNQ+Sp3xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmikIGveZDSPEx+jkQVK+6T46s7zZJyczCC/Z8Q4XpYdrTN5YYyZ4T9eh5VbMxUtu0mM13XJncFY9LHCZpkbd9FwONFG28KAvYVW9N2bd8pR6G/ICb8eW/nF0GgWhTvP4oEgC19l57hOyDJpxdvkCo7eb2ccnrY/ebL6nCuGweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3PV5qLl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3PV5qLl"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84832ec2615so513582b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 21:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783569693; x=1784174493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4ITEkWMTQ7J+Xoqp3nk8zHPj5XC/FSGr4Xf18I5rrE=;
        b=Q3PV5qLlQCCXe1uDAeEROAMtPIPEDYalnKbgOeGFHQaxDIL16jbDswageX2fI4LWmz
         tPIxrbR69QOSofhkLwRiyOGSyPuZiC0FcV9uhae19jalwPO/6tLF9Bct0xWvzPIg5xer
         je/qoGQ4sAzb16/7ZKSXxMMCC9Thy9G7cVL14AQQvyiCratUYndCMkje5GPaR1XDnG3r
         qWYWBFr7NcB194GuOEQJbzEo/OGBJsTfR7ArNy1/txJsGqZjFMB+8/TeApt0LJhDTJ9c
         vmUV55Q1pxPO/xRmSqQYgHEzahpOWqoXJQGTXmJ2PLAh0+/ocG3tgwo8/hD8KBCoyRet
         eR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783569693; x=1784174493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4ITEkWMTQ7J+Xoqp3nk8zHPj5XC/FSGr4Xf18I5rrE=;
        b=Y7bIPich5qw6JiCvgrXt3hgJwkGevmR7Y3ztv7eFpqxJakp3qLjmH0OMBLr0eQnlqT
         N6yml2kq0q+ikT6CE1oFJyDlaJjkhK8y/kYaJd7bxReHxu3XtlJz8+/XqAqQcop5TqFg
         dvsKNB7NXncw/ZFQmQiTx1VpEtcTgo8lAy5qIvag7eHBCLjFkbOIJ57LFs7p8ggb8gQB
         fmvvDmXDWUAFC76o/qpA46PhZR9uaYS8Vxee47Q2y1HXKK7PfXeuG1VecD28ORCcX+et
         9AJAOO5ZWp7nexcDd9SZjIm3gRSkPt0E9yzZbFnoseEIhJ4luA4anJ7ED+HrGK1WJyGK
         dx4Q==
X-Gm-Message-State: AOJu0YwnnLzXTGp4n0J+Z0N6zdmSp+co/1JJNFgsCQKW5sFUz/cvAEXf
	mr490Q6kMT0VzHqrwG5X7OxirFB9LpcUSXee0BngI0xDfKR2aTXR5ZKy
X-Gm-Gg: AfdE7ck4ykVLD/mc/nm3TPWhpiqnNzkmzPe3JycMzlKSLjpYUYUhA4rqMenlqwO1Mbt
	f32kX/K9OLg/UoEtZgieJiEqd+tnpziFVAO8pIa5lYTZe6NniR7TrDb00pplpZUSu/fwtpdBBkR
	dvi/jE6+HT0hm6TZ/Ub2DdUZ9LLKHj0MP/zCjV/KluLClqoNt2M2QTQ1dxbUFtEuovVmDLh8StT
	V+yeWLdf65nhyM5LeMOB001r303TWvALCRtDuIp5Q+nJaH93orhodcMzYAQnGW/7RpD/0wORHtN
	sDY1/BJdyX1hgGx6jtIiZX08NcMgMIK7GajR4abCdxDVygX15g25ps8N8YmJSnYvPK25Z7xThxg
	z1lBNQ5HwbJoMeQ7eAP/84IHiC1IBPOU3sLRvja+mOyOcvA0eElZ39958Vh52Fw0Q
X-Received: by 2002:a05:6a00:9493:b0:848:4754:28e5 with SMTP id d2e1a72fcca58-84847542dbbmr4333053b3a.16.1783569692809;
        Wed, 08 Jul 2026 21:01:32 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm8064705b3a.7.2026.07.08.21.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:01:32 -0700 (PDT)
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
	Nam Cao <namcao@linutronix.de>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
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
Subject: [PATCH v4 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
Date: Thu,  9 Jul 2026 12:00:25 +0800
Message-ID: <20260709040027.958400-6-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709040027.958400-1-inochiama@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
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
 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 50 ++++++++++++++++---
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
index c4c00b5fcdc0..54817d6fd9af 100644
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
@@ -96,13 +102,43 @@ patternProperties:
 
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
+
+      required:
+        - interrupts
+        - interrupt-names
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

