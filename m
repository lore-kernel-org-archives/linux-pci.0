Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43995303CAB
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429828; cv=none; b=nFlSFlTrgrlfk6lazir4Tv9t89cZxr9Iz0+HZwT1IwQsJENvfrgEn/I7y/XPHzbPL+EnjZ/Z5SCYBT8ZXl7Al6JAYY468444u+4fEc6XDFncnV5uYFp+iFRl/cKUxesWyx9tpZUaxDWQ79ayw9ebgT6gWVHmbJSx6BptHkDYPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429828; c=relaxed/simple;
	bh=ZOpM5OdnqNWrvQDczhxPsWdG7jLUfQPifEOebrLG/Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kD6cwvg3xEKlBMh5T09HETAHfyyzVLoDB2Vsqs/XBdzQMfB1VzF97A3Gmc0VmuP04F+Za6GvHubTlkDtp4gF777AvEAiykMfqfvZvFzftRRb7wn/Y7ZSA5gFHkoAOv2WZJOVxHjdLb8/mRnS8SRVNwKRf9Iv6PWJgzQ7ZXSOpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCQKoOxS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCQKoOxS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a765d410so33131665e9.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429825; x=1781034625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm+3oQVrQ6OU+bm/G/Ce4MSGjEbTIHm7c3f5dG9U7Wc=;
        b=mCQKoOxSQerbw9its8h+pEUkxlDiwlB3lrmxyY+af26qQ52gAK4Vk/4WwZysUfodqs
         ZMRm8Bev/V2NwiQluGJFUIRax+y39oRC6r2xIXWTrJ1WVm6yPjAi3X+YZqxEZWT5qgqw
         7VEad97Q4fqUrwYYa55UIq2heLjbOqXwknIStwD/6A8Kz6jAgLL4Z/f3Slv4IpgCPD1Q
         AiFhkzhVrcJZuBJxRzHiooaefw2bAGgAtON2+oUFyrx/DSi7oEM5Tj4NEMhGYSw7YJbs
         LKVPOhGFjPfhhbzU06Y1dLFkRRoSMlxMZv7jnlg6RF1lybl/YcSgvu09UhI/72fIbnan
         jhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429825; x=1781034625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sm+3oQVrQ6OU+bm/G/Ce4MSGjEbTIHm7c3f5dG9U7Wc=;
        b=F0rVjlmG10mTQpNxlN+YSf2BIeefrL0FesS0K76LsZ0wNW+U4x77Yv8xH99DSXgl1R
         0uzTFQ5oCnEQwfeZTIVFAWrw0t31SodUOAKoXLiMF9YpM6ZYcH0jyjFiXrUboZylO2xY
         up1dtmiSvC9olIvOGvgvdQC5fyFOdBK/r3l5w01KdCNVXGoXFKdV4VaCV+6Yxd3kSeuw
         B0jFQg7G+NWUj3Xp997knf0xHCp2aXsLSJ5zlGmpD7g9Otf1cv+ptz/HyGlxo5ZZdeyW
         3WPD0C8brULzY/02pHcFAfFx00VnFOupftVKpF2UbRo5bslVOqSFjrBNnLRJxywOUx3s
         FyHw==
X-Forwarded-Encrypted: i=1; AFNElJ9/fMofe750VGFPCd2n7+PzxmxVZCuk8MvZaCKRiOVZ0uJWmcZgsqRKd8dPSs5eJzrml5p0FO6JqcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4I4dQb974Rvw62Ra7zVZjp2/h11WBb/JWhh/T1uEZAqe79gPh
	T+D+ZGlD2fQ5b3tz8c7qMoRcVkbDLcyC4Ai3NN6YWTzAOAjy1mRkNVG2
X-Gm-Gg: Acq92OGXqlBEDhzZ+27yIR5B1A2pVwm5hR4C8+MFh5JtvdAigZczEvvSS5l0VE9mhB2
	6Vlczog4csybx14DXhoo+8sYbdeoiUG5KU3nGNGKmKZl2sLeTbFFUAg7tNBoBa0c06xLv5TQ4Fr
	I1oUCOH1OhLFU8SWiENW08vqhSepRgAxhqz8NE3NATy/35to0a6vG58AGfKTFVWl/XYuGeQ5sZ0
	PC3LvSOkfTpi/uKb8xY/F2hCPPcsi/VAmKbx6gVgL7rLDmU5uOl+qvAh17tbnyWZq8ZPfBiMNw0
	++dKr/c6u7NY3YAdb/VPtQSZZMfPKssxM9EbyrZ8kFO5oE1PcptrRbkEyUwQH/d71eEK/NXarHj
	KsroC8A2D3KFGyTOWEozpSoPFdowCz9Ryh8MSn/p5qtwp2U7EqHTkA59c5SiQQVYHSJhdjhXvrW
	fjRIhCUY4PFUqawrhyyvwicCD0y4C+hiQBDA/ldedrEQe6hC3FWpzcH2z3He9wW6EekGzwrd6aD
	go703MWCZjyo9U/TD12MS0VQ45St+ZnhlcOm2uL/TJ7/fKS/jAUAeTD
X-Received: by 2002:a05:600c:470e:b0:488:b187:3c with SMTP id 5b1f17b1804b1-490b5e834bbmr4587785e9.14.1780429824695;
        Tue, 02 Jun 2026 12:50:24 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5ef:9913:4a77:3bcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e13eefsm87353395e9.2.2026.06.02.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:50:24 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 1/4] dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
Date: Tue,  2 Jun 2026 20:50:16 +0100
Message-ID: <20260602195019.1798126-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for the PCIe controller found on the Renesas RZ/V2H(P) SoC.

The RZ/V2H(P) controller is similar to the RZ/G3E variant but includes
additional registers and configuration bits for PCIe lane control. It
supports multilink operation configured as either a single x4 link
or two independent x2 link controllers.

Unlike earlier SoCs supported by this driver which only feature a single
PCIe controller, the RZ/V2H(P) SoC implements two controllers. Both
instances rely on the system controller (SYSC) for configuration, but
the required registers reside at different offsets for each controller.

To correctly identify the controller instance and map the corresponding
system controller registers, update the "renesas,sysc" property to a
phandle-array. For the RZ/V2H(P) SoC, require an accompanying cell to
specify the controller instance index (0 or 1). For all earlier SoCs,
strictly restrict the property to a single phandle with zero argument
cells.

Additionally, make the "num-lanes" property mandatory for this SoC and
restrict its values according to the hardware capabilities.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
v3->v4:
- Added RB tags.

v2->v3:
- Dropped using linux,pci-domain property.
- Switched property to phandle-array for renesas,sysc
  to support multiple controllers with different SYSC register sets.
- Updated commit message for clarity.

v1->v2:
- Updated commit message.
- Dropped un-necessary new line in schema.
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 34 +++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index 90086909e921..09d78bd1a577 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -14,7 +14,7 @@ description: |
   with PCIe Base Specification 4.0 and supports different link speeds
   depending on the SoC variant:
     - Gen2 (5 GT/s): RZ/G3S
-    - Gen3 (8 GT/s): RZ/G3E, RZ/V2N
+    - Gen3 (8 GT/s): RZ/G3E, RZ/V2H(P), RZ/V2N
 
 properties:
   compatible:
@@ -22,6 +22,7 @@ properties:
       - enum:
           - renesas,r9a08g045-pcie # RZ/G3S
           - renesas,r9a09g047-pcie # RZ/G3E
+          - renesas,r9a09g057-pcie # RZ/V2H(P)
       - items:
           - const: renesas,r9a09g056-pcie # RZ/V2N
           - const: renesas,r9a09g047-pcie
@@ -139,7 +140,13 @@ properties:
       - clkl1pm clock request state
       - power off information in L2 state
       - errors (fatal, non-fatal, correctable)
-    $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to system controller
+          - description: PCIe controller index
+            enum: [0, 1]
+        minItems: 1
 
 patternProperties:
   "^pcie@0,[0-0]$":
@@ -220,7 +227,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a09g047-pcie
+            enum:
+              - renesas,r9a09g047-pcie
+              - renesas,r9a09g057-pcie
     then:
       properties:
         interrupts:
@@ -235,6 +244,25 @@ allOf:
           maxItems: 1
         reset-names:
           maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-pcie
+    then:
+      properties:
+        num-lanes:
+          enum: [2, 4]
+        renesas,sysc:
+          items:
+            - minItems: 2
+      required:
+        - num-lanes
+    else:
+      properties:
+        renesas,sysc:
+          items:
+            - maxItems: 1
 
 unevaluatedProperties: false
 
-- 
2.54.0

