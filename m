Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465960;
	b=ADEmWRfdvf/qPPujo5M8lB5J8b+rJ5GuhgBKI+2c19EE5R2YaLSo8L5fDQqrtoDM4wp+
	 /a9z7hcbFZgT9kDKGeYmDkmA3GjjB3uX2N99lMBDJz272bFJuyEzghxRJ7Bg+GYgEe2Gx
	 TNdTpVHfgivmvAatjhVSEopRUpUzwRRRagKUJ8GX9d6VjjV3uCLY3c93zid2VqbZxKx0P
	 8Q1HhTaPhDwzsy7a3Jm42eztvoAD83rNqgv4ApaSNbeNoOrlUJMlj5I+RlncFFcLckaJf
	 ry5lRmv0uWUrd8kxE9Bb93vawpAayP0+GhUVtKznb5eazoZRBtjDSaoHrCkfC2Pnemg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465960;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lSA+wX9NNEY3sTm7hObzBOSDNhatk2iNQOlIwAan+js=;
	b=0ItDSq5YonG+vr2BOVmnp4zMIA+uPXklkkSVe+DUn2zv0ZD/NkEKd+ivNXFBbYHTbXPO
	 x03G8gFjDGp2m8aiQ7VHgOjp+GHKUwmA1VGhfynH0J4N4T/EzseCMD2HykoHAtOr1DFAg
	 sWb479sU7uhXmCdU9BmIEJCWmvIneZvOG3kZ79tSBLUS8jFu2qfhSbByIDGA6RwYsO3vU
	 PdjdAGO3pGH+kZmJAmV1nwe4dfkudMj5NhExCMQINm76DBRBHF+Xj6jJMUq5899bURaIs
	 AW7jHL5NAWU5nPLLL0+dBPZC3OIFGNY8VQj8nqyXLNbaZpFgyojwefETOW04af6ZGTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTV+OLqE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AC606A33E;
	Mon, 23 Nov 2026 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTV+OLqE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465959;
	b=x1XuYOcOsPPdpVxE8YCrOHBJamovsqznqOmaKR0PkGyyoefdXu5kkg5SPjpPlkQl85t1
	 w7Ri7Cpd2VOHduwTS9F2YNXANn71XGQOSaw3OjeWLgy5jRnLXXh+s2zSZ91+RbyltRYBY
	 65kpCkl92Y0iPTNLZLlt+F5VaOiJzh5P9Ny5tNx0dq6abcfOmFxv4/716Mq8E/YYA8Bby
	 yXtOLxvd/n88k1t/LOR3C/0Gp/fEP2zDorcnY7IysMQsN0p6HlFy3p6363r1RGF/83stz
	 eYoG2WSV1k2DPEaPABMbAfsnDzv6JP9pwP7qdydtYX0ZXekG/bPL3x7mIh/YXAW1Z5Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465959;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lSA+wX9NNEY3sTm7hObzBOSDNhatk2iNQOlIwAan+js=;
	b=17Y4UXSHWV7frmYT/v/Pe/UXZcol0dRbA8yfqCPRLy1lAvGJ1H41G+DPalFYZcVXn18r
	 BD09XXP/YbY6GimG+jMRczrYloYSLSbTfy9OlwqauaGk88aIGl378d+4D3L1p7CWuJlLJ
	 iXQ65adVPXV0LgYg354dtazVp94iwPDWhP1We0nenQcg35qhSA4VNkRQ7FasGixa9TsKk
	 p2UwZx0MAJtzC2Hfepa6GhcH5mdViwBs7tF6vY93tev1SDQVLvkCwBDhoL0I4IgRKrpYp
	 kAl9URld72AVAVfS9kDgNrG08Iq7j8XsTKj4B966KqcWhuu5fu0YtRVs8s0kvhgjh+A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 32B771F000D1;
	Mon, 23 Nov 2026 20:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465959;
	bh=lSA+wX9NNEY3sTm7hObzBOSDNhatk2iNQOlIwAan+js=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QTV+OLqEpMuSgJeTfvIE27E7FRr2wDGmlAhczjlfNK48DJ/Aissrs+qXqzcWCq2SM
	 UqWoDnvLPM7L+HfF6jxeRcN+HwtoQFWDsP5URjP5DRxsyHVwgKvCwPays99umwTnpJ
	 XvdCPMUEG/gCJFF5yh3qoun30rn9SX0axuA41HqLlu2yyF52sMAGPB8mVkL/gVNROa
	 wffGEGrmMn2i6/G1hsUSSHAZiL+HuKyPsYK//Lj9ycLW5YnyPMfOS+c/oHXlOJc+ic
	 K5OoJnJohhrneaNng9x9+phb3ibDCOqUWYeoVdbCi/2XSe2gIkK3463O5KnNdomZGz
	 hd1DlMuA/74RA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B09C64C70A;
	Mon, 23 Nov 2026 20:32:17 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 23:32:18 +0300
Subject: [PATCH v2 4/8] dt-bindings: phy: Describe CS7542 PCIe SerDes
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
Message-Id: <20261123-b4-cs7542-pcie-v2-4-f589a9cd0bef@gmail.com>
References: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465935; l=2484;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=MyL1iV5O/zQ+yKb0w2UWGAKIr38mntIf4hXKW1lxhNg=;
 b=UXKv6FgpeRwIkYXwJFceJBFMvFDJqHn2ytGbIl4h2Wd1rCSHkXQDOUS12Q5Lx1HC8egNLGh1g
 c89qdqk9MSACOCZ+I3uYzMj8RQtRoYJuSPK3TCzQWILStTqZXKbmnjk
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


