Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6FF3D6CB4
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837917; cv=none; b=jkQvg77NVpKKdSz1tK01hbGwY24LdPMw206b2plx+q4CaERP5/6eMQeec4B4lj065RSLSJLahcAci6/+3fHFqgrInwK0pzS/BwFETASgl7pMu6pbla0rH0KF9r8ajLWvdgx8HFKwN4t/uUvgpzMbDUTtz7XycfRxlLGKeFJ+PDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837917; c=relaxed/simple;
	bh=S2KC3vKp+XiJMeRZkqtihpR3beahjbDMHQU04/KXPHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI5bIj+qe/3WOJKe7zX1t6p0gbT5J7+hz1iGTqnuFWoSHHAsEiC4+6Da6/eDxa8uJJ4DqIYKKeCXOr8KKNjcp6gK8foBrpFjQBWhLEYz++WunAcipC2gxJyk0FmJDCpvc84w1+1ygoITrdIQ9by9xFgVwlisJ5r+BpDoNdgbeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jddml+oL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jddml+oL"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b4d73463dso1259802f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773837909; x=1774442709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e51u2Yg6neT38eXp4c23jk4Undnjc8a7bolt2l3qII=;
        b=jddml+oL2i7whJ/Gr2f+6ld1F0nPVZmR0KPkydbevcXowWNXVKP260851n5/1sY9AK
         F1E0ofe0jdUTgOFHgU/15DSeE0btgl56t66mcVwXKWnJETUiAbUrlXmetLr1yfOuKq2s
         NVg7aSp0gHwCh+Xg8hv62TdD1zlu3d9/qlhhzBiJZgVJiykrBQgUw4r5URpOs1Lr6xAc
         wH0fcmygF40rnyDK1sdjgacLieCSnqQfBKBvGORm/am7Soj7QF0+GYICa4LN4RBzdycP
         QjakgS2uVKeKz43cO1V9RDUljz1n/nW0z4OVFei6p3LIKHD8dYkdpZ/mY/UeU0RnOymG
         pEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773837909; x=1774442709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+e51u2Yg6neT38eXp4c23jk4Undnjc8a7bolt2l3qII=;
        b=sMgwyHHLZ5mEEn5eMOKaFViRv+6hxK3PbaXB3hgGu78IQR+b3QVc+VUBxIECXMsTJh
         H5u14+ISGpbR743W6YeRqpbxg+cTLEqYQ5/9NGCXbxEmjUeetT4ovWPiVjTj52BEyBmG
         6FNxhQj0qPV/zIYeydXEvDv1sK3hfJ5Q+LCgzsOyzKKDjTj2YZWIKQBbVoGyE10J39ww
         +QyoZg4crGLi5q7/wuR8O3BEeiVYtqF5ZD8OPz5RA3qWoAzn0NzdXOYDDpJluubFN3qP
         cs+CZMjYAukbIimjUohkX/JFLnZ9E/X7SOE7+QB3UBehMwgE+oR4hePh0Hogw0Ur+oiT
         cGOA==
X-Forwarded-Encrypted: i=1; AJvYcCXQRfczIeQX6E1TE+/d0zz2pYvoncYV1th9Chka6fWXQEera8D/DVG75yGVjZj4KVhycp2gaZqmV4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgzWUo4hZEYyJn37Z6iaZeaNjcD9vghN0G0/bAZyb0vbuBCqm8
	kfliUDSlOj6KQv6fO4bPALtvOvePx6zrYCz7TyTD/oQ/Ur3NF48wIUIh
X-Gm-Gg: ATEYQzztqfD/NwT6cjkL10BHj7RvqKhH037O8/8Mlmqid6GhhsYD2kD7yq5D8Q6x0cB
	C6ysKmFUzi6yOoWhrF1II15rj2yoqirMQXfRut8dC1bMICDM9wqiw8C7bPTR4w0AHfCMDaXF9OM
	ry9ZB5ixYvmwUZgG51qLUwBpli1OEJqxDyMT6x9TgNy2OYN59uby67fEgUFFZQQf2gTf9MqAWrL
	CGTyv1aBiz5tOjGRb5PiVpD76ipU09bniDiHk/Ou7+PjQU/f/5GsISJqrBgCavKztfoHlwRUj1+
	Sui07TbqCWImjCyoqlr4P0roUr4vH6J6v6e+lF9+VvPGASWamhtZr4LaqiuYEwCeSvVmHdxhFqN
	s7OO0Fq/NVUcFp36QeiwxrVpDt6Xiz1V4sp+j9ENTnfdztmsJyTF3vIKLXR9HdRxiCOW7ToEQJw
	8imlXfycxVbaxqKbaOOEbKQ3faJadwDkQskH3rwXc9gvY2vM4Ro7OBIPZYc+6kXCHuR5eR+ZDaJ
	y4NC+wfUhL352xrrqWyKpCmcBvmP4YgTGLz1mPsU1FsZp0=
X-Received: by 2002:a05:6000:2f81:b0:439:cb9f:d635 with SMTP id ffacd0b85a97d-43b527cd28emr5179904f8f.46.1773837909165;
        Wed, 18 Mar 2026 05:45:09 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5f14:a98b:b4be:efbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518985f6sm7888162f8f.25.2026.03.18.05.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:45:08 -0700 (PDT)
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
Subject: [PATCH 2/5] dt-bindings: pci: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
Date: Wed, 18 Mar 2026 12:44:47 +0000
Message-ID: <20260318124450.163471-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add support for the PCIe controller found on the RZ/V2H(P) SoC. The
RZ/V2H(P) controller is similar to the RZ/G3E variant but includes
additional registers and configuration bits for PCIe lane control, and
supports multilink operation selectable between a single x4 port or two
independent x2 ports.

The RZ/V2H(P) SoC supports multilink operation, in which it provides
two independent PCIe channels (channel 0 and channel 1). To correctly
configure the multilink mode and per-channel PCIe settings in the SYS
registers, make the "linux,pci-domain" and "num-lanes" properties
mandatory for this SoC and restrict their values as per the SoC
requirements.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index 858ec02e6d62..57807d0abd9a 100644
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
@@ -220,7 +221,9 @@ allOf:
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
@@ -236,6 +239,21 @@ allOf:
         reset-names:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-pcie
+    then:
+      properties:
+        linux,pci-domain:
+          enum: [0, 1]
+        num-lanes:
+          enum: [2, 4]
+      required:
+        - linux,pci-domain
+        - num-lanes
+
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0

