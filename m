Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795754134;
	b=gccCqSoJl73uzjACKC3nspdMvSdFLP5Vnbn2JBWYamGDKgV4iNIuRoYbGlyGwAx1aVf/
	 f1Mfn4Get1bcgzwX6keJve7PH6b+WL9OwyeugiGOQ1VAkkJEXi8xg2IXYTnD/IPy94QqS
	 FcGgFXAWH/zW8gyYDAQrFMhGZ/r6GVWWenFPP46MTdd6bnuMmfYkwGwa8eBNvOysdo2MB
	 Qblx4RtRmsfnWIelBkknIsgwaCLz7gL07vfCk9vhXcnBX7OLj+ZSZjA6vK8ZG5XyFphfB
	 hLRi6J58Txi3z5PKFckFFedvR5b0pu8mnl0MmHJJdSpPOwyshfEoIjMJ9pmPxRm8FtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754134;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lSA+wX9NNEY3sTm7hObzBOSDNhatk2iNQOlIwAan+js=;
	b=owtq14o9Wr47InA+ofL7h3OSgVOTbrBZEYMp95SEbrtLuP/eB0oMpE9k2cMdjMWhB8cP
	 w5hJy/YgR8F5XR1hBiXD0x1b9pQkyaD4JT0p6cc6Kx+DqsORVcf0qSHsKuXY4YUuZZ+3P
	 F7mcLopUkDPfTJbfzdf+r3x9Q6MSNW50mi1LAWgIES89E2BWos4w+3CFjT6MNdQjbcTnU
	 vON0/TxHGKZ4QkvN3SlqsEU+7bHhzvMDrA/E+up76wUcHv7Gn/UflzZTCFvXnE9ABrguG
	 Zr27TEe2SZEtXY3uuBUposy5gZYGWNGS973aT6m1+Qau+asHZ8ovymIF6GhH4H8P+sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnZsIKtl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505D606A336;
	Fri, 27 Nov 2026 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnZsIKtl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795754133;
	b=a2tYENKJfORC+ekjLbz+ZPD0r7bmBBPWZcizRfQRzBi816MyMncjdAa/nHRtrPOp9qMD
	 saMJglI8KGxTQYO62RxSmVgV8zXKFS+BSefH4mWCV3Eo7W4IjkHAbcJbz77TJGmN0sgoL
	 kD7gxrgSJeyHMY4e2J28nCF1dq+I1YYPp1uxByiuTQytqfJ/T8YM1QgfQq86JYQeU4dR5
	 970EUBkBLBXZ1tkakn9N4v0itDUWjjMkPnzrDeUwtqhX3ZnDGMkOfIHwvm75dYni3RrLq
	 fYZ3hXzcsZmGuwGWrBHIknWyxsdYsGXIRO7c1Y3m7DLfnTBt4v6C5N5o06DEzbd3Fyw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754133;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lSA+wX9NNEY3sTm7hObzBOSDNhatk2iNQOlIwAan+js=;
	b=qX8cTQ3bZIRQvtmnOe/xmupieMY5x2Ny/wXLbPG9gbtRPEu3UiOxa1C1cA6U4RCgwPIf
	 s1VImpk4uwVj/9I+rfJJtb6Zo6rwbrKVniMehDacXIy1vSdiqlFiSXpCda3b1z6FyHe5f
	 1RvHDaNx0jv6mxGh7Rjq1Zw8MQvxxCYvBVKPYZj/YuMLhRGMlG/8glY9BOm5sTlQ5uJ4F
	 qikX7/Q6uCPVcaWoI8KGjh8m0EveKVScUoZudBr9HOUwl//imkfGn7A5lZ85H01vQIBvo
	 GWQ+50cov1DYLslvNx0RJhNVYXLgf17BbOeFJu+14yyKYFQuQG8LawqTQ7aeOJqR2fw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E59151F00898;
	Fri, 27 Nov 2026 04:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754133;
	bh=lSA+wX9NNEY3sTm7hObzBOSDNhatk2iNQOlIwAan+js=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BnZsIKtldnNQNC+DvkHidAmPPmEdkJejaGsdrlYmdrnRmYd3Nn/WSZoxpFGcjualm
	 Hlp5lcbf1wNQGq9f1T43qnf+M5d9xMdPZST914yIyj66Rl3LBXXFBpsQHy7/VQsoot
	 W1yJ6Zr6KFmbQ2zjcbayJiUvnmcVhZvRw96y42wCX/nn2HIvu41+0SV3E2ayoxS0Mz
	 D5GJ0Eq45xsKqg4SJZdzgjnC8fveD1Y0GLXVOzc5CRuLAYbHypEzZb8A7yWPWyCrBk
	 v89RwacA5Spj3uuVAahs5SaUHiCELmS4Y4s6RfgXHFf7nELiotYQsLU8KRFgb8neqO
	 1eH9HEsbxYFTA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7A1E34B578;
	Fri, 27 Nov 2026 04:35:20 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 07:35:20 +0300
Subject: [PATCH v3 2/6] dt-bindings: phy: Describe CS7542 PCIe SerDes
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
Message-Id: <20261127-b4-cs7542-pcie-v3-2-b067875c56da@gmail.com>
References: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
In-Reply-To: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795754119; l=2484;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=MyL1iV5O/zQ+yKb0w2UWGAKIr38mntIf4hXKW1lxhNg=;
 b=zj8aOySfKaJbkLTPJh2fFJ3yZZpdGKgL1pncIxDlwcn61MU4mqDhfsw9/pojQfA9VkKTagVHd
 XbTx3h7VbGMB88Sbj0JKuQ5slf4+utTAAKv3g9nAgFEMJ5TjNbOHq5P
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


