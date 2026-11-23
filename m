Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459427;
	b=Z3ZAbe4BZlJ8z3muijNM73GXrNdabPlUc8ew3uNIygG+SDmzykwMaL4/k+qEikQqUDOj
	 Ldd4EhNsTs4XFpGbeiR1KnW+ghy9l3tHdp/095T+5TBVqBx88ye1qqRpZkQHq4qaeNe3J
	 A8NNDZ4U0azNw4QnZTql5cM4lTFC0f+wNdAAGJz6/5WuMfIV+mUD3sLonGGk+92T0M5m4
	 fqSiAatdT39n26IgJyQ0o99Dd/oW5BWtt0+Me0/GbfJcb7RbHS21XU3P3+CghQU8xcRMh
	 mzm375LlQQITrzreAUKF3TPWYrMiYm0ivufb7WitfTd5O+7g5PvgMJot2FKTZZTv88w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459427;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gu594QK9/935sSCpF5t7yefSjrcj87y2uIapAQYrgGI=;
	b=i44oOitiNZyrkHdyZ6lUCYK+VTPUu0pdigcx7GG85hX76UsaZ3DUopTakOfspPUesqtU
	 yjbG1zhmvE/Lx4Le/ep/IZOF1LatYyk+MIdeJvta9TbiGSpUbvateaQm1elu4jOEG9uun
	 SBqyxeg8uAnpnRJO1LqC43bZDD73aXcc2+fraLDmFIkIbLDhXIznzVSijYRtuExM+U0F/
	 Q0yW2zWqo5FnjVaaupuKoOevxofi45g+knpY6cdUMpKoZjdLFtu89ffrARet7/tUmkElR
	 O2d0CmMsLedjkT52BstYixPl6JLQE1MyqETYp38s+FYR6jKfQz9Crgyr9bIw9vyclhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VlACv/oR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0F606A693;
	Mon, 23 Nov 2026 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlACv/oR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459427;
	b=t7GN+2I3RQAhJ9ta8jWKogRxwpJwbh+IKL11i92HIA4deGIDvY5G/hNSAIiI7xCkTkF6
	 y4PD5hnEXrsN3o3KGNuVIJ8F931S9e3uTHC9NSVeWBYyi9x4wPapejrxEgDz6DTTe/iKG
	 UdKbI2ZIJBD/rfjxhliIrtOAkq4fceaAoufvCAkxqBAILxZfCLMBp5RqVCurISesuvAUi
	 cofxJo4m8Qa58sOTL2HLZWQzmYYstv4hgcGOkSEFZgfLmqL/6o1n1jZS0qYsOOYnk2f3G
	 g5EyuP4pv0WmmLGmOxD6YlJaqN73NViYH+Uv0Zdaxw99p8rLT+MfqdDA5t9hYddMS7Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459427;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gu594QK9/935sSCpF5t7yefSjrcj87y2uIapAQYrgGI=;
	b=wQVybN8s2hR+qmta5+0IWUxZWBU66gCQqQE3OYQ0ZfDXdhlxEw+yG8rfxgfz+iM8jP1/
	 IwUNCcotbNpZIFdS5C8FtPVu6VYe4xeCG6vDcoabD3znQfp6tXwC9kzzCYD9W5HbUgXfv
	 s5IY6CpDwTpjrfAmyS0x/2tklkXxkLD2G0Z75bGrTTzGAIxYkfUn1E7A24l8p7g/4UE2r
	 VEleT+EENywDom5uSkZFqvhoDPNG8jRC1ME23vQZRaPB43tr15JEW0IsZYHITVzYroRsk
	 FDEzXlsSY1YJ4CYN9MJzEZXDy/phhRdoGsbSKVRJgSuXmI7VMTJllvxv3N3pvUKQPWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 76D4C1F000D1;
	Mon, 23 Nov 2026 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459427;
	bh=gu594QK9/935sSCpF5t7yefSjrcj87y2uIapAQYrgGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VlACv/oRkn6x8Q1rMx8/E6E+qmZzQ1aq8CmDYqh4hcjkQfyxKv9LblJXZC+ZpRTLy
	 e8o3BNY85mH/37yjekVBoeMY7Ye/pnrxurhTHiklkKkIIFHioFGV2NHh1QE3XK1MWu
	 PJ8zmTXoiN/ioCnP2EIWLC/mZ/ruK++4+P7Gmb/MZJKOebn5jun/ixwI0fMpPeH6u+
	 HcOMC0pG5hXnVCBi8CMzZYg/WNSMq8I/zuqJwDVwB0QYfWa8PCiRRuf42WaNDOPjXk
	 2sFW9oXObTDRe1+RScTIgnQ7XdyfcosSnzujo4I/W14f7uDW9hRUS+fTcTojsXieTG
	 b3jA9sOwOXG9A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 084814C5D1;
	Mon, 23 Nov 2026 18:43:34 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:43:30 +0300
Subject: [PATCH 2/8] dt-bindings: clock: Describe CS7542 PCIe gates and
 resets
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
Message-Id: <20261123-b4-cs7542-pcie-v1-2-4cde5201d404@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459409; l=2658;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=dF63p0NESwL1d1J31nL8VBK3t0TGBHI629QHDWtLN0M=;
 b=q6YlorCM1VBJY6HWBaHuUxSchohP8M3owzFdU0wZ3abL+U94253u7AJ05ibgw+fhRjZiJCnkx
 RIBeAIGcQ6PDydvok9cq/tniNsbiJLPke+G7ohjoqjLYBWnbFF4OdcT
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Describe the global-syscon child providing three PCIe controller gates
and reset lines. Port indices are shared by clock and reset specifiers.
The gate-only clocks do not claim a source frequency.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../clock/cortina,cs7542-pcie-control.yaml         | 47 ++++++++++++++++++++++
 .../soc/cortina/cortina,cs7542-syscon.yaml         |  4 ++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/cortina,cs7542-pcie-control.yaml b/Documentation/devicetree/bindings/clock/cortina,cs7542-pcie-control.yaml
new file mode 100644
index 000000000..08e0214d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/cortina,cs7542-pcie-control.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/cortina,cs7542-pcie-control.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems CS7542 PCIe gates and resets
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+description: |
+  Child of the CS7542 global control syscon. Clock and reset specifiers
+  select controller 0, 1 or 2. These clocks describe only the controller
+  enable gates; their source frequency and rate control are not described.
+  SerDes reference clocks and lane reset controls are separate.
+
+properties:
+  compatible:
+    const: cortina,cs7542-pcie-control
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@f0000000 {
+        compatible = "cortina,cs7542-syscon", "syscon", "simple-mfd";
+        reg = <0xf0000000 0x100>;
+        #clock-cells = <1>;
+
+        pcie-control {
+            compatible = "cortina,cs7542-pcie-control";
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon.yaml b/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon.yaml
index fb074de87..52597c4e8 100644
--- a/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon.yaml
+++ b/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon.yaml
@@ -29,6 +29,10 @@ properties:
   "#clock-cells":
     const: 1
 
+  pcie-control:
+    type: object
+    $ref: /schemas/clock/cortina,cs7542-pcie-control.yaml#
+
   pinctrl:
     type: object
     $ref: /schemas/pinctrl/cortina,cs7542-pinctrl.yaml#

-- 
2.53.0


