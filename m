Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465964;
	b=hKad0N2qy9EedlLSOG5rxJNZKq8tnHDjS5SVsnAtKk+7Sv4TJyTE/Tbb621QeIx+1LwO
	 R0IO0k/qg9gOH4jQE2j9EheWulLNbWBkzrNhyupf3Q0UiHX09zfXntU7H5s96c9PPz3oO
	 OytKpREGVSknSfzTYCMVxeMyzD1K5ZZHTrXmQMJ0Dezndo3/Vo33JsCNOsdxFwMJsBFCM
	 I9NUewwKelGRH60tteCFZdndwkHBsZiQkzQrWPpkKDRxz6OR+EucQo3ufWR/EnjfysNf5
	 kja/6qniheCrZumBV+21UDZmjYK0igB34Fc9+l4cbsbvLzORLuKr0IiCwwbM8vd24dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465964;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6P272XRmtxVRxUwOCYKqdPoT8y/CgT8kIkZk04v3YWI=;
	b=NSG4/01KCLZD2foPkQUCcovudN9eoB47wuAbhVLfEfwjN/2K8pqkyuLbgqCvKXLAHyLb
	 y8pWtMIgYpwwRlOrdEcWzd3GDewcEXmbmRbBNwX8zBniKnjdz9ETKfcP9VIZWOHAyL4ES
	 TrShhBBqsZOEwQiiHTpM51gbu3EGO7btnNW7HUiuIKmogXwdIxpcHRY5PvjYfJu5/xP+O
	 9eU1n34Poe14u0vu+qwzS9paAYbebyKnmq48g/usPfTBFH0wVBk7+wBRqCUYKmuPn19cH
	 CHEYMX8mvzRGOxZKyGNRteAPzERN+3lnBIRTrLAAs89RNOe5Gh9GXFanK7zZwjdKWdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNi9GM5h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59761606A682;
	Mon, 23 Nov 2026 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNi9GM5h
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465963;
	b=O0KU5gMTHRZ6ha1UDuyB7fxH28xZWF1JM5HtVisr7qMVIveTwTorp7CTeURvKHlP0rXV
	 Awj7xsaQ4zm5naZq8Y+HKauqGj9RgkXLDpGd8YfW78OcNJC2LrMm2FovAyTmm5zn45+as
	 DxUoRJHXYOIbX7H3z4n2jdcE4r5z5j1IvetdbM+Rxfuo/CXgFFKSQRkVfJdJOi/NF7ksU
	 FA81Vi1LRxFIog93NS4A9YD2JN7u0ODW4XcHpBbKi8Bi4yElAw2kc73aqGR2ovxlkoBiR
	 3B8DsxImOMqRd0cgjvvnx8gwn7Lh0h3P0FIQR0nqkZ78V26Jh4Ofoi0dn5D3b36YF9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465963;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6P272XRmtxVRxUwOCYKqdPoT8y/CgT8kIkZk04v3YWI=;
	b=eYqQz+9W8x4LlTsaUXxBJrtNOhxbfADkbD85SKH1364v9tRrqjoIbXB494ZWhyjWnpIh
	 EI1TkroOFnkPp1wC4hcC3UkkoEFDeCCP8Vf6dwDhhzusj9+eZTlpd1UizQuUrsaQBmOth
	 EuEzvEI9mUR7jfTEPZRtgQSy0o7jLorzEDU5YHVNdtxVSejOLIhp/KceGPXEZJiN9uRdR
	 ZeeaAShv50NWa7ioW0R7hy1QgZ1yh/tNCM6Ot3UqzzLIuNrv27D+FSDFgv7FDha3HmPhN
	 9ZwIFV/9bRwBIHR5AmrJSAisTQjcfWx8xJKEdjv7rUercGVr8ldMvskSHJMBGbb0veA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F06AA1F000EB;
	Mon, 23 Nov 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465963;
	bh=6P272XRmtxVRxUwOCYKqdPoT8y/CgT8kIkZk04v3YWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mNi9GM5hyJs9lnuUF2uiubdVbfjOBxrAp3WFP47gtTBjX0shGksTkE9l2U24xH7IA
	 +cdYhbgXghO2/mmrew1ZEbx51+nB3aJhtY9EXYt3qEJSiTA7McziVBh3t2CUH7QVHR
	 o5LlzkzoZH2SppelWjEkuNnkN4xOSeorKKB7Y2LgUgnbxdNq6++TO6H/pswOnEwD04
	 nHieyVuEXYK8aN345fcXF7jMLyjn9B375tgY8NGQvIbo5jqfFEGzjAh2GHc0h97Zcq
	 FJ5wbyqWGFR5r7TpJr6aGCvrEG51hofvfldSZX33FGTUCjbkhqeCCWwcHlcilmKSLE
	 J6v3nUx7OJcKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 799A24C6FB;
	Mon, 23 Nov 2026 20:32:17 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 23:32:16 +0300
Subject: [PATCH v2 2/8] dt-bindings: soc: Describe CS7542 PCIe clocks and
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
Message-Id: <20261123-b4-cs7542-pcie-v2-2-f589a9cd0bef@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465935; l=3193;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=f8i2MUsoVg+zzyGMskQHqPaf9wJgR56JnWGThlimNzg=;
 b=DMG0WPKRoRxeDezktvzlUVonyL/6hwSDG2kJFWn3seAiKvsgWodsaxp7f0DPc7Rymn84o8WIF
 Pg28KF8cPe7D2TkrATMT7wBqddl/i2RrOVv/6qddpnMuBCUlh0VzPeR
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

The global register block already supplies the strap clocks. Extend that
same provider with the three PCIe gate clocks and controller reset lines,
rather than inventing a resource-less child to instantiate a driver.

Keep the existing APB/CPU/AXI indices and add named PCIe clock and reset
specifiers. The reset property is optional for clock-only descriptions.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../devicetree/bindings/soc/cortina/cortina,cs7542-syscon.yaml | 10 ++++++++--
 include/dt-bindings/clock/cortina,cs7542-clock.h               |  4 ++++
 include/dt-bindings/reset/cortina,cs7542-reset.h               |  9 +++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon.yaml b/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon.yaml
index fb074de87..dc7306868 100644
--- a/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon.yaml
+++ b/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon.yaml
@@ -12,8 +12,10 @@ maintainers:
 description:
   The global control block contains the boot strap status, GPIO/peripheral
   mux registers, reset controls and the secondary CPU release register.
-  It provides the APB, CPU and AXI clock rates selected by the boot straps.
-  The clock specifiers are defined in dt-bindings/clock/cortina,cs7542-clock.h.
+  It provides the APB, CPU and AXI clock rates selected by the boot straps,
+  and the three PCIe clock gates and controller reset lines.
+  Clock specifiers are defined in dt-bindings/clock/cortina,cs7542-clock.h;
+  reset specifiers are defined in dt-bindings/reset/cortina,cs7542-reset.h.
   The pin controller uses the same register map through its parent syscon.
 
 properties:
@@ -29,6 +31,9 @@ properties:
   "#clock-cells":
     const: 1
 
+  "#reset-cells":
+    const: 1
+
   pinctrl:
     type: object
     $ref: /schemas/pinctrl/cortina,cs7542-pinctrl.yaml#
@@ -46,4 +51,5 @@ examples:
         compatible = "cortina,cs7542-syscon", "syscon", "simple-mfd";
         reg = <0xf0000000 0x100>;
         #clock-cells = <1>;
+        #reset-cells = <1>;
     };
diff --git a/include/dt-bindings/clock/cortina,cs7542-clock.h b/include/dt-bindings/clock/cortina,cs7542-clock.h
index 34d544238..c68c6ba20 100644
--- a/include/dt-bindings/clock/cortina,cs7542-clock.h
+++ b/include/dt-bindings/clock/cortina,cs7542-clock.h
@@ -6,4 +6,8 @@
 #define CS7542_CLK_CPU	1
 #define CS7542_CLK_AXI	2
 
+#define CS7542_CLK_PCIE0	3
+#define CS7542_CLK_PCIE1	4
+#define CS7542_CLK_PCIE2	5
+
 #endif
diff --git a/include/dt-bindings/reset/cortina,cs7542-reset.h b/include/dt-bindings/reset/cortina,cs7542-reset.h
new file mode 100644
index 000000000..bfd5799b2
--- /dev/null
+++ b/include/dt-bindings/reset/cortina,cs7542-reset.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef _DT_BINDINGS_RESET_CORTINA_CS7542_H
+#define _DT_BINDINGS_RESET_CORTINA_CS7542_H
+
+#define CS7542_RESET_PCIE0	0
+#define CS7542_RESET_PCIE1	1
+#define CS7542_RESET_PCIE2	2
+
+#endif

-- 
2.53.0


