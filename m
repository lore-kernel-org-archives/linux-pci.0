Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459426;
	b=bjmZQNDOaTCqIv4LTuF0Ztu14jj7j80aT2u+q6EJWSyJVQii0iqbIOxceFMqYOGwjD+F
	 zJ/VyXoRzdox/vVe/XNnGkWSASClFmrw5Y91Hkm40fUzY2SgZfs9y5jZX2IhY4XfqmlKu
	 nbWM+aDNofLX67KqLVJOOJJQV7+Bo+Qy9YHy/gmETEKEqd3Cli38g0vO0Vj14YoIuevs4
	 rkplJm3Oareig3aqvdDCK3ogtHAIpd1mBfO0HExI9FvDdqRNVdcBt70Hx4SRRiNGV6/Ct
	 ezgmUzkz7vfyDD9Pzq2tcwix2NfWekP+oc5MZEZjFZ6+Er4/jCzFDsMhdNa3rqohCYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459426;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lSA+wX9NNEY3sTm7hObzBOSDNhatk2iNQOlIwAan+js=;
	b=ZVHwwWYsA/6g3b1IdYtSVOSkwnw4Sk3lv53dcdELkoKdohYFk7ptT8d/M8JsuN8kPDWZ
	 vFIpXVRrZovnWeq8cFuB06wRrym7uee5BnsmripyeMTQ1Lt/74e7A9lFRw0oQCTn6/tyO
	 xu8ErMtfAWcBidY5Yrh+6kGDZcATDPmy2HFFMS7bcQfKTIHc+pBzRLyn+u38UYP7qR2AK
	 HNlx++Zr6NDmUe0jSwWkxQ2m0pW9m2C/rE1vPMyqt7UmaFPBMs2p5R6u0U0pEr7DFTCvu
	 kky1Ed+novbR85Lan2sHIOWJaCcGRWN9RZJnGZW/N9hZO17Z5IDMPEf5r/WHD9ab2wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Un8myjU0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F8606A332;
	Mon, 23 Nov 2026 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Un8myjU0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459426;
	b=tJUOWqYO316FGc88m6d2uModOhYdYvMQCjnuY5k/vy2u+nMCFYFW6Cyyozi+KhYFLdOi
	 Kib1eU6J/qNHp8eH/sELu7a2y0jnfxpU+xyYQ1XhQUw0TYgQYdPwWnYcY7TQHQGS6y11k
	 c8ECoYz3uIfmIR33FeFKvcHpjDyURfV5iz88GWJnInGc8uXmZzgos+Ref92vRPu251ZbV
	 w5/un42+1KYZWpivwlO/ZSEuzHCvRNM4HQN++kLLozZAVAkmpaYOvkZhrLL5EDBbRdGE+
	 iCfOdh84f6Mz0DHQAQkj656CmSdCWPfe1DEKByP+MZveYM6NecDiOBVWmeukf+/xmeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459426;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lSA+wX9NNEY3sTm7hObzBOSDNhatk2iNQOlIwAan+js=;
	b=gLvjefVOaUpqydN+p/gmd1HH1I+a0T7295Oq8fCM9yiJZ4M/e1kfLlUMNQtTIb5G+MOg
	 ZOUCIlFInL1M2NSShKaSlqjK6FOj2krwu6uAtVKGm9M6m/0qBXIEVno7VqdRdVdsgwl6x
	 Da3W49e/YeL72PLZwdgZjAHsAhWZr4z/tTKxNpXhYHC3ruNVq87EGmDZFRheSJvj4CpG2
	 Ju6hz8LYrwE9nSASsZquAYD5ZfItf9+6IevxmU2RrlBCdqKb1T9ag0dFDN8XsJVwisGnp
	 YypKr64JTVA0UYwAhoVHmk2rNd49XxGt4RZ1R0257/5gsEJ9sMwtGBxLSE8ph0jrSeQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B38FE1F000D3;
	Mon, 23 Nov 2026 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459425;
	bh=lSA+wX9NNEY3sTm7hObzBOSDNhatk2iNQOlIwAan+js=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Un8myjU0scak/jaKb2yaqjXYn8Oi648okTOXq9LHmhxryXovAzNaUMfm8OtChf2Q1
	 486FpomHlEOm8cKohMOlnKMDRHlDiiYey9zYvcE08pahHidMqOzgrXx9NQ7PVOIGGp
	 JfHH+w+4Td676GriEEJMvXAmECSxp/tWi8kwHH8B7voWdYvAuCWZP1F8kkF3gLcDTS
	 MMbDGsR17KIOdd7HasKlVC/LzuHIg9/c2pxuiy7XhPPic94gMENf8nvSkZfKV/FuVf
	 tv3nkUahCQfODvw8K/EakZY+34lAxsJ9D8yP7GDnJ1Af7rLhI5XLz3Jwsl1zdsMh/p
	 r1uBWHFGRjMmg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4450B4C5F5;
	Mon, 23 Nov 2026 18:43:34 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:43:32 +0300
Subject: [PATCH 4/8] dt-bindings: phy: Describe CS7542 PCIe SerDes
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-cs7542-pcie-v1-4-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459409; l=2484;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=MyL1iV5O/zQ+yKb0w2UWGAKIr38mntIf4hXKW1lxhNg=;
 b=CyfGYps0N0F18Ogfls7Z2cKPA0iJsxM7CQiMoFc/TJzEWtC25qzOYNTxxH81X6hJBysGBSLDN
 TU81Lt4mtIRDulo+kyHKPPxoAmXXT8mJlbYOLX1OPihK/aFpDL2ZpW4
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Describe three Snow Bush lanes, their shared status bank, global reset
controls and 24 MHz reference. PCIe is the only supported operating mode.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../bindings/phy/cortina,cs7542-pcie-phy.yaml      | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/cortina,cs7542-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/cortina,cs7542-pcie-phy.yaml
new file mode 100644
index 000000000..9ccde6e05
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cortina,cs7542-pcie-phy.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/cortina,cs7542-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems CS7542 PCIe SerDes
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+description: |
+  Three Snow Bush SerDes lanes shared by PCIe and SATA. Only PCIe mode
+  with a 24 MHz reference is described. The PHY specifier is the lane
+  number, 0 through 2. The status resource contains the shared PHY
+  status registers, with a stride of 0x80 bytes per lane.
+
+properties:
+  compatible:
+    const: cortina,cs7542-pcie-phy
+
+  reg:
+    items:
+      - description: Lane 0 programming registers
+      - description: Lane 1 programming registers
+      - description: Lane 2 programming registers
+      - description: Shared PHY status registers
+
+  reg-names:
+    items:
+      - const: phy0
+      - const: phy1
+      - const: phy2
+      - const: status
+
+  clocks:
+    maxItems: 1
+    description: 24 MHz SerDes reference clock
+
+  cortina,global-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Global control syscon providing lane reset and mode selection
+
+  "#phy-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - cortina,global-syscon
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@f00a1000 {
+        compatible = "cortina,cs7542-pcie-phy";
+        reg = <0xf00a1000 0x400>, <0xf00a5000 0x400>,
+              <0xf00a9000 0x400>, <0xf00a0e00 0x180>;
+        reg-names = "phy0", "phy1", "phy2", "status";
+        clocks = <&ref24>;
+        cortina,global-syscon = <&global>;
+        #phy-cells = <1>;
+    };

-- 
2.53.0


