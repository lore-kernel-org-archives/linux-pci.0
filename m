Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A439A05A
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295756; cv=none; b=QEMIs2A9en3OUlgtPGLHDHqzltWkoBtmXdQ0LiBojCi79tyznlMrhdaVx/Pqt90NIPTuJg4VXi0Nef/IntbgjiwIbwC0RlVxsHIS/3+oYsQ6W/Qj6IApQ1eOQYA5bpDTyJADOJEo470ItPBrXUb4rcVpUNhntVOI1DxF4lJ88so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295756; c=relaxed/simple;
	bh=F6+RYDULt4OCEld7JGFE9rEHRKCd9PgaJxEgaJaHdgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqEUxFFVmyTclq/eMvW63DylUJAMu19qGEmtI/nvbWS+KQLV9Kw4YvrzSaorSrMTFNTQpKE6MBKYx1YAiaETEMODEXAkW1UnL2ZmZov4sPtiMTECyvODHR1+JB23zhrjoPe50eqp21Zy9KKorYYaDmv1m6AtFX7YFK4733FdhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1XumvJu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1XumvJu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49021532ebdso20268075e9.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779295752; x=1779900552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z0EKz99OQ69IIyWqmPNk9Dp2si8fNBwQRm1/KGhrU8=;
        b=V1XumvJuOp5WFPElm5X+4zLWup5CnF55cv9YJzR0SP2dZy9lopJDFmZy+edp4P/NXH
         hgaza5Zex1CAJ1ZkENzToNbA3qqxghbVRjNY2ojgv1ivKs0Sy3jB71sLMxMJc8ieRXNw
         zXfHO+YUGMk+KIPk2UJ9cVXGNG9EV97SmCJyZ3379m+X7unm32COST8ClRclUzfT+IHj
         3Cox6SDNofDBZHXLbry90rKbVac1QpA6Gwrr/NlHi1GHTQArD5EQ7cmgZl9yBtmgaRZE
         cGL0FZ24pet3Z06/XZrOJb+X7usrxaXuOvXuTAQfIVqkVP3FdDh20IVakjo/7wv8Lysx
         h3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779295752; x=1779900552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Z0EKz99OQ69IIyWqmPNk9Dp2si8fNBwQRm1/KGhrU8=;
        b=nG/ozcN2BD3S9lPgn2A0MsWH5GNAitFlrK7Kto60Dl6aKwMoiRDGYR/MazvmJRHvZ3
         q71Dy6KlM0eoLttOwcqVSSTXjBU2lz9zSaB8H7kyJPi6WO3q6Lgdi7Ys9Jks5tFDqdOI
         B+38LGS83GqftdsK5pwuFXuwPF1310Y7+IYy9EZ08SlomUe69RzEpzKxnfqWa/L+RM4O
         SDHnJAMZrOVqpPQ4ijKVNm1AantYY+NhY6CChGb9so0+XyvL/Ev8gJqCE5RoXm6y8Nn8
         ahPoQrJuwsUFjOXWpjqwsaQBZvwpp6kG1GJaI0NxqrKRainrkokF6qs+zw1NJDveNBcL
         /q0Q==
X-Gm-Message-State: AOJu0YzfFYwFFrr5CO7wTPsQUFrG2F6Hm7iALEnW2quzd46+l/3DScsT
	ywsCpbx0RqOm/ODmyJyCmPGrHcF/XWr/YJMSb02Gbe1Ht2XxLdpSwfIZ
X-Gm-Gg: Acq92OH3PTQ+SVjoQxSrTrJU9DsEA5ZYbvakovyKXtgdlfZdpzF1Cd3TfFJPiw8Q6yq
	tbPnqyDRp+JJ5drLZS9TFLOVekmK2ixj56/Eyw3NDdY+lk/GEDCuY8h1NfHv9RjBR2S8Aj4Hkl5
	ms7S8y3S4yafUGVjmeOPpbf692uym1YPtvu4NAQW5VjONGJsptw/o7imznvMCz3ySeEFRzTuvA/
	z/uXpeHEqbWJDe8xm1R/k9WyiFjn/mpuDnqDr1374C+1s8qbGj83Qwc+4rQvPzSHDnOu2vPa/74
	fZ0Oz2U6OetlZnuZ2J3niktgiTr+9i3cu0jFD82kC0xyfa6dzpvwB6v6UlppGxF4TGoLX45d6uP
	OA2v4WnidJNKyOpdyLyYua8HDfB3Myqgg4r0ByHdZtPzSmtpbtRsLktLwkYUrNFHaqftOJEFpO4
	pc1SOtPvYG7lPsd1aR/WzJIM3NFjcUDvrEY9+wbPfBqvW/quuXfFhatL7kNoZnFCv0Xtw96FqkP
	1m6D3xPl9O2CVBIoTheoa2tAgxr6UOMROmxJvkkycOgsfY6esh7u8tcGA==
X-Received: by 2002:a05:600c:858d:b0:48f:e230:80a3 with SMTP id 5b1f17b1804b1-48fe6514c31mr301498345e9.33.1779295751631;
        Wed, 20 May 2026 09:49:11 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:dcb8:81c1:dc9e:cd68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d8e71dsm3110285e9.9.2026.05.20.09.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:49:11 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/4] dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
Date: Wed, 20 May 2026 17:48:20 +0100
Message-ID: <20260520164823.436992-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520164823.436992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260520164823.436992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
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

