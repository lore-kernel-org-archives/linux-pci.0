Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C9480947
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671103; cv=none; b=I4Oo5S6xH4tA9jckDM2EGVgPxOG00lks9xetuLSYaz9WNLl+z7zJyDTlX/7xaszeJZps/Woml6bILLZpHyjQlNNtFzQ/fRm54IjPyd14DaNrZwasCdI19zgUkihJ+o6h+lEAX9sI3FMqerO2oDyaUulU7FcH8vCrIAw9Ue6328A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671103; c=relaxed/simple;
	bh=K3MvCrFWzEsIrhBWqxeXc3gdx6o84wogtYscdysHXgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4CBazEhdpsRUCJ7PmP3/4KXBTOQnSwSE3hAlZso2vpJMHrxrCxKnjY8jL46fySLR+slIQKvCJAydLvjTuuijvxskrZi+dMkCSwdr0zCCj34iXTPr3vwYlRT7tkZ2V0K2PS9r/1roUHCAHfpOZWU5tcxMcpQ7V50Z1IFI+RWMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGQg65Ay; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGQg65Ay"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f05ffcso18467015ad.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 01:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790671101; x=1791275901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dcDcKCilMboIAKoprvjC5MEiUMCPSH4NgyIgQJv6TvI=;
        b=nGQg65AyuobhevuMHzwXsnFs5qSjLgL/SMKFiRLqkn5HbwApKD1PFOgTfbk2D9rAAN
         /PwEd7rZAbZV+za9AKfzee5S960k9F9wOiq0yL5bOAYrkHky7IdOM/wV5Xt8ASeFErv1
         fjs9JRwFSmh7vc5I1u90+VKe+vX2FXQkeqH33peS4mgwbU0wVu11EV5rx5CPr2eHT/Rx
         GcERUxtPVI49/NvGycvMEFlH+SDe2wA66aRzKWbFQe8pJQgVhVMOYxBFyy44bfYjMXt7
         rv4b61/32R4n8Da7tMooWqKVDvHlFW4UCGkektdBbbPHVtfT21MHpCfBMpmYcuoaR90O
         nZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671101; x=1791275901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dcDcKCilMboIAKoprvjC5MEiUMCPSH4NgyIgQJv6TvI=;
        b=KfTetzrI57YivLWDpPfKkAhoOsMVdyRbicae7mnJIO/KlUzcpbMBBH3BIB6QVRJhl7
         hxaxkP41JpmsdltQ1poFG7YaIhSsU2zwt5bfGqoFiWmIVSftj0OrSl+m3/wFjhrXPcS4
         4YETBlc2mNalig7kbjXxQ7QQn2gbr//OEnANuUsn8GpZdP+car/Yl8tHhPlNEJVMd1eg
         yaQQ0dRE3w86+wZBBlRQBAv7X2VlKrnf8SvbRs+JLaF19OI/QdIZmNxMg8dndp5CyVXY
         SDXUmfaECaiH9Vha2zGBnEYE6ys5f9sOJeqq7WcgjOgjdZjg3KMkpzz1wEnWCRCAw1e+
         YQDA==
X-Gm-Message-State: AFq9FYKuoda1mrxD8A9F/DjMRKKaCL9WeDgSXp1KOAJbMVWFUGV7cWyP
	hhfnXV5zwAoQw5OX5q6OyufU2sh/0zGDiYFNmhr3rDUZ1IvNytfTI7JF
X-Gm-Gg: AYBFou0zMH6O7WxsjubPSLTKLabVGyDIfTgSjqIvGB/uYglvae2IAstW5H81g1cgTMW
	jW2jVcgFhaNgvMMbfrKxX9UFPH+r6WAcxnlfEhfOfZVQLg0G3FEOnQb/3N7uV2pX1zj1oWXM1lJ
	a42ShGinhXauLGSRGyBX5O8uhemn8wAhZaHIGf72LTS88BOxClJ8MH5Vj6b5ePG4aaiiUZndxUZ
	CDi8rtbwLZ8o9mCrCfYHPFHINW6JicOxVwe59SofSOrT/MOcgZY/89JxIFRUSbMeCRsZiewBijc
	eL8NaWVX7utRu+/Qzk5ylamw7t1rZSJnlR9N/qffwcS8yX0f/iA8HSn91LQNUS2hyIT2sGvd0Ru
	PxjYTiazutn4xjGaQ9BG2S2exGapoRwhrRrcx+MqihpTxU8DK3p9fRE3s2E3OU5Z1kkHXlIGKTU
	0mZQr0m0gFQ3+Mx7uibtg7La0f4zkXZ3Zl+jSEJVlu9/myloGrW3Ug6mOX0EmRd2FgDmvh
X-Received: by 2002:a17:902:d4c8:b0:2dd:c100:80ba with SMTP id d9443c01a7336-2df7e669010mr123382255ad.53.1790671100775;
        Tue, 29 Sep 2026 01:38:20 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142b002sm51326225ad.50.2026.09.29.01.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:38:20 -0700 (PDT)
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
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Randolph Lin <randolph@andestech.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v7 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
Date: Tue, 29 Sep 2026 16:37:51 +0800
Message-ID: <20260929083755.458238-6-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929083755.458238-1-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
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
 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 55 ++++++++++++++++---
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
index c4c00b5fcdc0..af32e427c0c5 100644
--- a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: SpacemiT K1 PCI Express Host Controller
+title: SpacemiT K1/K3 PCI Express Host Controller
 
 maintainers:
   - Alex Elder <elder@riscstar.com>
@@ -12,28 +12,32 @@ maintainers:
 description: >
   The SpacemiT K1 SoC PCIe host controller is based on the Synopsys DesignWare
   PCIe IP.  The controller uses the DesignWare built-in MSI interrupt
-  controller, and supports 256 MSIs.
-
-allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  controller, and supports 256 MSIs. The K3 controller uses an
+  external MSI interrupt controller and may use multiple PHYs.
 
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
@@ -66,6 +70,8 @@ properties:
   interrupt-names:
     const: msi
 
+  msi-parent: true
+
   spacemit,apmu:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
@@ -84,7 +90,8 @@ patternProperties:
 
     properties:
       phys:
-        maxItems: 1
+        minItems: 1
+        maxItems: 6
 
       vpcie3v3-supply:
         description:
@@ -96,13 +103,43 @@ patternProperties:
 
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

