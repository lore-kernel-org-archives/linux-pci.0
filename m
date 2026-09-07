Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ECC477293
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780413; cv=none; b=AboPOkQx0UvkW7eN6jGEHKUEiXsi8tJd7kGnTHY8N++xLB8cpderHLoJC21uswJAyxKWQFCaMOMBLShiBq5koa5B6pSwAu1ZKz60BiEBE7I7oqspCieY9twEhrOBOL2Po2ATLEN/4n9kmhVRPLo6w1Pi+Q9pjR0c0TyFAaK5K64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780413; c=relaxed/simple;
	bh=tT7VHBhWW/0ENtiLY3CsIjS6UXJSVBBo9toNQ+Sp3xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpRETSS8tiiHYb77KxC4t9vOLnz/MBYqmq7bmBqtgt67LH2/dpqgDmMrp57hQZnH+EblWRZEc8vYJsQ6/Ee1hslZbhqUSUwZGM4H9/VKm8DZAXn1P8PbFKEWxv3WkbEWygiLaWgWkeszzdjuZaXbj7aGYqSfBuyNVQE8hS07s58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdbOLJ1k; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdbOLJ1k"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d9201076b3so38900455ad.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788780410; x=1789385210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4ITEkWMTQ7J+Xoqp3nk8zHPj5XC/FSGr4Xf18I5rrE=;
        b=NdbOLJ1k9kwgy3emGpJ3IXpC+icgmpKAhnWJCBdMisd/zYkSLcfQOylTpSJvPPB6nz
         +EGYrNvPrjGAumppqOovKGp5EeGQuX/0X6lylLYFEV6apDxFkkHcGRzm0QHmA06qii5h
         zNWv8wmsjF7w/9pIBuhwdAt1bsreeIPx4/hxmzD8lS4qTBS1iLfsz7olHaqSdwBpscpJ
         2N+rDcBZ+CTIH+HKi3VnOFTbqgX6fpwl3VGXoVyAC5/rxwvXoOQmA4oh9oORLOWnuXY5
         +m9PDFmLdLvQ2XAnAc+FigI7VfG8W+eSeIMmbQ0uScMlKjk+YrZNs4HLypF63ZLfssUg
         OKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788780410; x=1789385210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4ITEkWMTQ7J+Xoqp3nk8zHPj5XC/FSGr4Xf18I5rrE=;
        b=jNwgiM/pt8gOsz4cAvcFnDkYPuXwJfG/nmYKiSA92W0N9BpX5o+GKAqGxcY0qG0xee
         VOBJzNVxNn10urHcXsRkfscGScMfd7tlDiFrfT5IvmIMoU4BMDmOZ+cZeMpmns7n5VsI
         cJriiwwshD4I77mJ2KkuVb0W8XKyFE6XQ+TBnLswL6Y9CLLp2Jd+HpCtIkALplaHo2H/
         VsitAULIY4KqBQhtAOWXgJavyvtwUN7TU2PlqEyRVX6TogNK/GwkGA0QUJJaVihy6rvf
         xD3PPdpWc7oksJ1FEmgVNYjm3SvdFAX/7EN9MJGMinJAXHbBUqUri1RAllWsl4qAU/me
         Bepw==
X-Gm-Message-State: AFuF++lmlbnFVWqYJm5PQNbcfH5MMgwg3u3GqEzYJVLvRJNkK9FuK3Nk
	PJcjxMc6Egcg899qxbdgc5USvb+wZB/RpSCxVEJ+lHbJfW4f42zPJl1Y
X-Gm-Gg: AYBFou2t+jlg243J7sPfTYWZvKUivHBxMgr1EHJ8bQounc+zVC++8DBoqEb6ueJqwOz
	bXpZr/I1j0V+wGEyMm/CmFnCEujuBG23Fz9OrLIvPPgticJOCYK9jLScqy/C0+GbEOarAzlLUho
	2HAGiTU18xmAsT//eJlu2PFOoXpkjXoYzQOB42DvE1iMKyCc5DOa98Jq1C+XitFBW+Tnl8WW1QH
	s8q5U8TeFlDI6qkPRKdxSVuSDLpOv3XG5jaZSd/jiKPvzR2eiRTKhXcV5YyrYk4jJQwAcgXivie
	monvH2vlY1yKxrfhT8Ud+cjO1ZhqDhfxMw3jwG8DWwEHy1tHzRk+gYCLC6LWDPgznt9HmI+vkg/
	rPqhSmVQMnCsFA36fOIfxubJMccQSiaMsbLbwADG4XhPQUfCWW9oWhyxPOh3ofrmdijGvgY53P1
	3EtIwdmVgrBWWIVqNE3XNCVu6DAr9GEfTgauft
X-Received: by 2002:a17:90b:1b44:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39b2613249fmr30388041a91.8.1788780409708;
        Mon, 07 Sep 2026 04:26:49 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ca63b3sm26270444a91.11.2026.09.07.04.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:26:49 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alex Elder <elder@riscstar.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
Date: Mon,  7 Sep 2026 19:26:04 +0800
Message-ID: <20260907112606.465778-6-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907112606.465778-1-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
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

