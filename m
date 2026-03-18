Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602963C7DE2
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837915; cv=none; b=Qgufhm7UbHHFC3OR5IZUBmu49FH7U7q6tx5+Y4mk5a8fv9pJ8UsLE6Wcxq3Ig7kjYq7/tXfpRmz+YzbAm1wJikMvT46RK+IoaKMjfe7TW+jBZGpEDqfCh3YeyAUY3lFg2UFyPyOZ7P164CciFcqjimljgZTErd3OwISepTCj+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837915; c=relaxed/simple;
	bh=WzTncAMQYnUAjkJv6VacHhJuXVWxUaLMygBhcDC1f9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbEv/Z4AUjh16pitc+4SDBK/5R2rBa/WbEB3coHIqCQ9qmCQRw2wjjHSWhfkiwvyyHMVjeHPf1qU17dej67YZqogCyJwTTMPLx+iXTqn5Fg9R5H34gvAgcWYGTSD+cZAfRrkxMjXKsNqcUqqnCAGl3xONCTu6dtZz3kRsM/pmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUfK8uxO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUfK8uxO"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so3207244f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773837908; x=1774442708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stC055Do0g5JVm9ctV7BdXY8ikwKBl5kRv52IetvAxY=;
        b=mUfK8uxOOgZ67GQsE/RnpR75Xw26rRNFofBH0GGqHFlnfOua3w+0WC3NHasT/DQdMs
         ttsJRxDjhPfmgXzz+P6UEU8BVYxSBNHXutsdlLGj1DQ+RjnrZhekKF83sjhu72xeBDfN
         Y8nGLWxTV1tqKggOwaCYkRaXaxav4zhIdjRr1vgqyBaumBkBfAdwxE5xYrYrzf5TJZa+
         O7W1Jx+DkqWkeIc5gdxx05ivD6hKczzOpJEjaw8avjgNhYpYuWGr4vcUXNdxzNRBvo9m
         lKITew3viWQeMB8RO9iMcv8fZTbTBRWLtGTq1fYsnhP8g1cg3Ni+CLqNzl6biKnLBGjp
         g5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773837908; x=1774442708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=stC055Do0g5JVm9ctV7BdXY8ikwKBl5kRv52IetvAxY=;
        b=sm7S3RmM3pq/Rkly1t/KCUytNP+rB0Nn76VNKaEcPWAcfnsz+0lWj76clCUqZexRy4
         k0v5rzjApuOiDWE8+V1iP+JoY3LjLesde6UbZMb+5g+JM8Niev1i7TjRZ6Ssm2/twFqX
         MuriuVAyIGcprj3Qk4PpITrama9dU0iHJt6fGZENPzvY09Z04zUT08EvMmSfDsF7a+3W
         h81oZ3n2iJiZq0hWwcSxGqBuPJ+TuK0GBXOROwf9AbkpIg+zXKJSaQfpfuLNWbDN9GPh
         lbScCwUc3U25YMnpDHJ04qPcGlOiyQoTYIi8eG+MhYsj/qLrmmK9ZRi4iBqx0xRqcbP2
         01JA==
X-Forwarded-Encrypted: i=1; AJvYcCVJiCRJNYDFlQPtH89SanT1G4VeCnMkJTVcDgrMU7fSD0gK3Gy10KlxJvSS5g18btiejhZwMslHs7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6U0wZS66twHRxwW0V5kHs5Q4dAakqZlV8BpO7IQw1PRjBGTMW
	V7/qcjrj/ZPkoxmwbcUOV3Hm6JzI3WTK4dBIXfsJggApPk6e/6Og1rd0
X-Gm-Gg: ATEYQzykM56KWXPwApz1nY7n91g8mnHiN7hmfFORFpN6ltBaIXJgtnSgY3EaB7AkdAB
	X08dXax6p4tKxIQc0KqLIe2oW1rEIQHI1YG4XdcfTp8Ra0OspaTFL38tV3PUTNKdOZORwskrpkO
	+t3C56Ufsskb6WhUrb5LTeWG7QGmkHS07+EEDFWWngFp6LTCa+in6uE9UJOqtBHDG1+8CNylBHK
	/JYrAzNWpdYTfg0iqtCEw2eu+6j68uotOIeW4H8e9vUr6wu93W0oc1jxCTJydri3lo+8wsVDEJI
	ro6mgJ/TgEgMwIn7S0zyx+iM1rJDYPdtVYN0K1WlbkvnQfYHfcbHeq505peQO+6lCjNF0fG0zPU
	v/EognfJGf+GEjdPVPUNZTJx3gFrdHZafiaPE6Y0ZunY2w7G252IfB913NXOOM7yuNtsfVZKPvc
	1hw9cTX4RQ3gjcSuflk2NAa/2wKUMPFU3+NCJFod9F/8cfEa8wWHjrRj38YfkTJHBWKu6Ybx8Ho
	M8Lck5FxNV4HFb3H2CoqZ1JICaLzMIIE8mhYk3KTJhP2Yk=
X-Received: by 2002:a05:6000:2c04:b0:439:c6d9:7fc with SMTP id ffacd0b85a97d-43b527c4040mr5296152f8f.25.1773837907912;
        Wed, 18 Mar 2026 05:45:07 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5f14:a98b:b4be:efbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518985f6sm7888162f8f.25.2026.03.18.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:45:06 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/5] dt-bindings: pci: renesas,r9a08g045-pcie: Add RZ/V2N support
Date: Wed, 18 Mar 2026 12:44:46 +0000
Message-ID: <20260318124450.163471-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the Renesas RZ/V2N PCIe host controller, which is compatible with
the RZ/G3E PCIe IP and therefore uses it as a fallback compatible. The
only difference is that it uses device ID 0x003B.

Make the binding title generic to avoid extending the title for each new
SoC, and update the description to list the supported SoCs and their
capabilities.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index a67108c48feb..858ec02e6d62 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -4,21 +4,27 @@
 $id: http://devicetree.org/schemas/pci/renesas,r9a08g045-pcie.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/G3S PCIe host controller
+title: Renesas RZ/G3S PCIe host controller (and similar SoCs)
 
 maintainers:
   - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 
-description:
-  Renesas RZ/G3{E,S} PCIe host controllers comply with PCIe
-  Base Specification 4.0 and support up to 5 GT/s (Gen2) for RZ/G3S and
-  up to 8 GT/s (Gen3) for RZ/G3E.
+description: |
+  PCIe host controller found in Renesas RZ/G3S and similar SoCs complies
+  with PCIe Base Specification 4.0 and supports different link speeds
+  depending on the SoC variant:
+    - Gen2 (5 GT/s): RZ/G3S
+    - Gen3 (8 GT/s): RZ/G3E, RZ/V2N
 
 properties:
   compatible:
-    enum:
-      - renesas,r9a08g045-pcie # RZ/G3S
-      - renesas,r9a09g047-pcie # RZ/G3E
+    oneOf:
+      - enum:
+          - renesas,r9a08g045-pcie # RZ/G3S
+          - renesas,r9a09g047-pcie # RZ/G3E
+      - items:
+          - const: renesas,r9a09g056-pcie # RZ/V2N
+          - const: renesas,r9a09g047-pcie
 
   reg:
     maxItems: 1
@@ -152,6 +158,7 @@ patternProperties:
         enum:
           - 0x0033
           - 0x0039
+          - 0x003B
 
       clocks:
         items:
-- 
2.53.0

