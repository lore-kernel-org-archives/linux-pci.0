Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A5382291
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777631058; cv=none; b=L1OlpseUCUdaBayGvil0pPOdwx1uZ9aNN1qpY2fHQX9sMOoE2kkEgcsCXUlJ5ZXOoKp7uulSKmCkwPe/OAWzZkuD9uZ15Z+xJpcXl6hHbWAPALCjPyKz4Z20jO1SgvYn/iEGByiYqO8tb1EzxvoXHgITCMjHRIC23w6XN8dlrUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777631058; c=relaxed/simple;
	bh=QnkNnx9k8UNt0OzcapqQjvj9/iFCN7S7MPJtuIjyvqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lm/A5vK792MsG1Wbou1BSHexzwLCMGz2dRBqtLNx4lFo5NQiv2I+EFo1O+kiOoUktL8RTodxT1PehysLp/yG+DA467C++sFJfsjGZ1fAJi/jLvl6cIpEwfM7kk0V3Cl+nwABOegipjTdVqHEseit1Zom8P/Kgmy659uQlPajO1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOToTaHd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOToTaHd"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso14854905e9.1
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777631056; x=1778235856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tjdh99dmMY77j16LsBzv2dEuLqYqGw+VhQyABiovB2k=;
        b=IOToTaHda46GVhULUWEUd0N6CA6+cso4UAyI7xb2Sh0m6dRBn/fW6PJX8zO1FCnuav
         go+kmCygBSEFFcZ+cJuXiAYw+AfcPpnrkzHFTLmX3F/FENFzBWYsIKpAn3NRjGQg203H
         1Lj19Ci2SKXMWNWVuWGxIo5TmbCdcgob11ZULVdRuqpoqKzU8RSqVccbzUlxxbOSDFfK
         jn5sWHI02yBvlG3SzXQ6m29circSEDmAJiULxjxMKRmikoKCNkfM2Ys2X2LblLYbG+TP
         NDUbv4zoCA/M9bJC+QWxu7K4AGRMB8C0WS+GpanFv11bGm4npSriXudHNkVlYeQ/LU4v
         V9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777631056; x=1778235856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tjdh99dmMY77j16LsBzv2dEuLqYqGw+VhQyABiovB2k=;
        b=qQ6uWV9obhj+Kx5/SJmb06hbN7vLKLC0CuU3TTVSvH7GrqP7TBVfPjChE7yNMp3fkI
         VRk+WJhuBeODKoso9qDhSI3F5JqKDaTYsUqYZkbD6SilT/UBovGxsz+rFaytwOY+Kl+t
         KDtgdBxiXpbeoTP7XsntT2dYN6AltO5ZQar48Esi296AOCjszR8zfkChJ34j0Z7IpHhP
         X0Ee5Ifck2rxfqCxsZLInM/E6oztOJLCw32huMGArBcgKr0Zk86iQN84GyoZFBCCBuBl
         xo1FJxYOtiuQcClN8KNs3aBRPQP+Pyz6g50AJOQwqqCiQNrL+MczNPQ8/KyR25EG8JhR
         PeYw==
X-Forwarded-Encrypted: i=1; AFNElJ9XfKn+34K1ZjSQ8U4q5UnAxjucu5UF0HrkaYOhNtEsQp75C1GER/sX9o3Pdk+v8haSnQ5MhQRMJf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xfLNXXZKuR6EaAdYn/IggsgNFoCfhV4NMoGtrI90c27e9qWC
	vTBydtTMLrfePOXW1j8a1W2T/V6+ERtW61P8POnRCh3Hh379I1m359AO
X-Gm-Gg: AeBDiesEijqGRWwB9pXpBzaCD867SYcDWyW06/kuHJPk8thfW+u3X1iiEVyIULnyIOG
	3ys3IONve1ataLhQC0mr31Yhf4AOpAWWOpTg0Qjho3OCyOJOof6rZi4UNkLQKH+1zM4jCa7s7PC
	am1qWuRsdBpWtmQ2KBz2M1gaK2FMGISjY5l3lgzoNEfRC52GuJZO1vdqmxqLKIOQfUsIjMO/kH1
	6+o3VyOqarMjZJFAmTjwg7lTuzifHB2AlsT7ht1Kkprj4eVZSuvAM5m1e3rupIUWRw1ZcHT/Vc0
	dtR+9HNyj+5rLawbjKVlPOHtPJ9GhLacgB6J6veN4385s8P2LfX2qSKR0Or9PP5rFzFPxx9osSG
	m3QqyQe58MS47VEq4bFEGdxxoIDkZpwaVaivvDNylzTKvZ/Ce6gUjs5RYGB/aw6MEr9WS28L8vs
	EZ3BECCz3UiHo8v8Fo4L6M+hdOll7d60zYRItRkY0uUfCt9xIVDMQ8MTlXEb4ASdZTW2qK/Jgw6
	HJWSp+tYtF40u5t+RbCMs3UEBA5x6x3mrrdgz908tmBjIxRIbVyBeeEpA==
X-Received: by 2002:a05:600d:6:b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-48a83d6a8b6mr90374315e9.4.1777631055567;
        Fri, 01 May 2026 03:24:15 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1220:5ff:c603:f3ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ef52854sm4405895f8f.12.2026.05.01.03.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 03:24:15 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v2] dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2N support
Date: Fri,  1 May 2026 11:24:07 +0100
Message-ID: <20260501102407.29462-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
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
v1->v2:
- Updated the title
- device-id value updated to lowercase

Note this patch was originally sent as part of series [0], as RZ/V2H
support needs discussion sending this single patch. The RZ/V2N support
can be merged independently of RZ/V2H.

[0] https://lore.kernel.org/all/20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index a67108c48feb..90086909e921 100644
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
+          - 0x003b
 
       clocks:
         items:
-- 
2.54.0

