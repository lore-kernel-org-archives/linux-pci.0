Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268854;
	b=hWnIMbq2NOytJU/G1SqgL2L2VbwCD8e3p5qON6V59eQ6l3Fc2A3iqtkLEgxk4Pr/AWeG
	 sEEOaiIzkxzYdnE21isRyJ3+KzS6sMHDnaPLEXpVK1d91EI5iErcrKOK0FH6V0U4ATtw0
	 bQHplMCHiU3tq7tlBV3gzZuMdxNO+IHFI7Sc94jkunuH57JVNlZnB5FTpQn5gHkCWb6g7
	 2BFmmmZBt21y9hc7BdDI1islfFZe7lnHHMEuMqjrBxauEfIljt+mdiiIMPBF8WA859YnD
	 wcFkZJyCJHSCI96R9UwRC/u8nqkE2xWHxlh4BvGBKIa/zAeYguVIbRCVKU6XKhToelg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268854;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=I6pGS9HlPdajy6JVHzNvNG5YnPfZi+MQBITdwkrjbpg=;
	b=B0infXv98IIGwODZeL2zCb8Sp2COwVYiqVaI3PgEY7AlwND4V/9LhacunJGC2js78Uye
	 NUzIH/NI5kKJu1x5HXkirDZ33XkwoT5ARYGIJtL5XmiNWKIp3mr3I9DSw9UuqxHDNNacX
	 KiEOIbS4VIDQBm1DV84maIuyQBdv+HlVFpWGW882spfN8cxKzYhvvtxHh8pj0dZ43U2ft
	 Cp8ZHg0p1xlPvkFg1S3t7fXq1Uz9AEm0gCw3S1n3G9QxfMQWgx5ZNqOri4C7HBUP3+WEE
	 zqwbjyzHZRiJa1h1ZVjArKMIjXxigQMjFxuXn5eEGdSYrbIo0e0/U+216LzmK4ygj5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF3606A323;
	Thu, 29 Oct 2026 10:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26CF3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1793268831tcfcd0a9e
X-QQ-Originating-IP: JWcGZpaxS2VvXr8ks7Aa0kMOHfyGgrDNgxaWqapRT/I=
Received: from [192.168.30.244] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Oct 2026 18:13:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6520119527471735759
EX-QQ-RecipientCnt: 31
From: Xilin Wu <sophon@radxa.com>
Date: Thu, 29 Oct 2026 18:13:35 +0800
Subject: [PATCH v4 1/4] arm64: dts: qcom: sc8280xp: enable PCIe ECAM and
 64-bit memory
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-q8b-dts-v4-1-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
In-Reply-To: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5116; i=sophon@radxa.com;
 h=from:subject:message-id; bh=ZKeyJhuJk5Q9HhRIB0I7m7yyN1y8Ot222NY5V9safMA=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFmPZcJW59kGHrdytv2f433o+76pL7ufl69XbuZrnaPzi
 SV3P+PTjlIWBjEuBlkxRRaFeIa57JW5156KlerBzGFlAhnCwMUpABN5zM3wh4dz974tTmcyfxnd
 XPYiTXRzVeKONbm62W7X878/NL4pv5qR4Y9NudJulTxnwbpvcfYvCgJaP63l0tmx8OtiJsk9j1/
 dZwYA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OYcWkDQesdWF3SFjyfjWqBDVlG7cdsEGs82P87uGZA1iOYH2XrFHKoGa
	QSbliJXmbJPhxyT0MxuO/WWARi3h6DSLO6IJBRz3D0Ez6cQ3/s33iUiGDCFaGS/8LigM+aV
	o7BOVKZ36C76DhNuzWAos5tkZhDs8+YyNmQN4f7gVwefd3yzTxDk4oKApvOnH+s1Cg7plYG
	hiDEcDcnTm1JOLkyUdWE2s7bfr35wpzOaUt5hk+vcFz3B4KpuX0hlKT5Hf6aKNZ7FSIBQLP
	rKC6wRenUMRBqTmx/fPtwzV4lbWwBnC+3MAbutciWnXudUUiAlB22k9792hFzZ4UaDAMXvd
	BrSpn/fuqCf14hOzgeQzx8d02xC+TmL6gTpSpAX2WW7aQTLzjfzw4M4P+o1gWkBS5K2MHOI
	0O6AKH8M3xGEMgT7Y+k1i0RqwqxVp8JVVF88aqSNRje9bzZNLUuEvAnGuq3HA+sFbeJM07o
	62JDzEFLlvdiZtyM7ImBCD0AZwmClcAnJzm2LwrfB9YscK5A8LYwjmJ9fbAO7Oe56Mc/6kv
	rqVOLqPrde1auxVp/Ru2jdwZCzwsxsb1txHD3ZnZno/Rj+KdMaWwy/sMs85QKCZZTVCZsRP
	l2vWJZIVpMBh4Jvr62CAfSMRCSYmrxD8zXmZBROcjICYoXhKL1sDjci1bpU43M0HXtxdM7h
	iltxVrKhTrvb/+eZBjRhdhB9oySfJ+WQPgpxJSHcuz0gxd628JZG4QVCuqmozNL3oZOEUJ6
	4S3N+o+jfywnLXV0KcamVNodcpeWAOGukineObLh+u9vHMreY8ydOTxrVxeH/1PL0UYNJmD
	fv+Eh1q2iyJ7TsEzPWcysGM0NRRtZmFZQxS06XePSSTDDOw8UmXclnLvb7tpj4jR3FQ55Ob
	NC3cQCtpVPqK1Z2i/z8OoeCBvStJcslCgvPjiNNY0Tonm+uX9rR0bgzMYcVXjtJhbmSNsGq
	XN7wWjxaZRsxWXFjOka6HOh2esHFcLTSRhN8QiiZl7hFsdIDNI6lWfFlRNK6MVHo1kKjQ/v
	wj3E+ZGUKq4XUEn3JNXqWIN10egYWe2aoexoJFHvYNaz5GGkfZR+d/fPqZ+G6n39A6EzzDL
	UmSmlpbUyOZSCqD6tgUWwozHeBDFNb7cvxE0MB0u5vSDJdZ3iTv/hI0AYc2VzifiA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Enable ECAM to avoid reprogramming iATU on every downstream configuration
access, reducing latency and CPU utilization. Add 64-bit memory windows
for devices with large BARs, such as discrete GPUs.

Preserve the SA8540P PCIe2a and PCIe3a address maps to avoid regressions
due to firmware differences.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 arch/arm64/boot/dts/qcom/sa8540p.dtsi  |  9 +++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 25 +++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 23888029cc11..e5393a237497 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -180,6 +180,15 @@ &gpu_smmu {
 
 &pcie2a {
 	compatible = "qcom,pcie-sa8540p";
+	reg = <0x0 0x01c20000 0x0 0x3000>,
+	      <0x0 0x3c000000 0x0 0xf1d>,
+	      <0x0 0x3c000f20 0x0 0xa8>,
+	      <0x0 0x3c001000 0x0 0x1000>,
+	      <0x0 0x3c100000 0x0 0x100000>,
+	      <0x0 0x01c23000 0x0 0x1000>;
+
+	ranges = <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
+		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
 
 	linux,pci-domain = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index d17475c3e66c..0c4abf60d1d2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2161,13 +2161,14 @@ pcie4: pcie@1c00000 {
 			      <0x0 0x30000000 0x0 0xf1d>,
 			      <0x0 0x30000f20 0x0 0xa8>,
 			      <0x0 0x30001000 0x0 0x1000>,
-			      <0x0 0x30100000 0x0 0x100000>,
+			      <0x4 0x00000000 0x0 0x10000000>,
 			      <0x0 0x01c03000 0x0 0x1000>;
 			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x30200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x30300000 0x0 0x30300000 0x0 0x1d00000>;
+				 <0x02000000 0x0 0x40000000 0x4 0x10000000 0x0 0x10000000>,
+				 <0x03000000 0x4 0x20000000 0x4 0x20000000 0x0 0x20000000>;
 			bus-range = <0x00 0xff>;
 
 			dma-coherent;
@@ -2273,13 +2274,14 @@ pcie3b: pcie@1c08000 {
 			      <0x0 0x32000000 0x0 0xf1d>,
 			      <0x0 0x32000f20 0x0 0xa8>,
 			      <0x0 0x32001000 0x0 0x1000>,
-			      <0x0 0x32100000 0x0 0x100000>,
+			      <0x4 0x40000000 0x0 0x10000000>,
 			      <0x0 0x01c0b000 0x0 0x1000>;
 			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x32200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x32300000 0x0 0x32300000 0x0 0x1d00000>;
+				 <0x02000000 0x0 0x40000000 0x4 0x50000000 0x0 0x10000000>,
+				 <0x03000000 0x4 0x60000000 0x4 0x60000000 0x0 0x20000000>;
 			bus-range = <0x00 0xff>;
 
 			dma-coherent;
@@ -2383,13 +2385,14 @@ pcie3a: pcie@1c10000 {
 			      <0x0 0x34000000 0x0 0xf1d>,
 			      <0x0 0x34000f20 0x0 0xa8>,
 			      <0x0 0x34001000 0x0 0x1000>,
-			      <0x0 0x34100000 0x0 0x100000>,
+			      <0x4 0x80000000 0x0 0x10000000>,
 			      <0x0 0x01c13000 0x0 0x1000>;
 			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x34200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x34300000 0x0 0x34300000 0x0 0x1d00000>;
+				 <0x02000000 0x0 0x40000000 0x4 0x90000000 0x0 0x10000000>,
+				 <0x03000000 0x4 0xa0000000 0x4 0xa0000000 0x0 0x20000000>;
 			bus-range = <0x00 0xff>;
 
 			dma-coherent;
@@ -2496,13 +2499,14 @@ pcie2b: pcie@1c18000 {
 			      <0x0 0x38000000 0x0 0xf1d>,
 			      <0x0 0x38000f20 0x0 0xa8>,
 			      <0x0 0x38001000 0x0 0x1000>,
-			      <0x0 0x38100000 0x0 0x100000>,
+			      <0x4 0xc0000000 0x0 0x10000000>,
 			      <0x0 0x01c1b000 0x0 0x1000>;
 			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x38200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x38300000 0x0 0x38300000 0x0 0x1d00000>;
+				 <0x02000000 0x0 0x40000000 0x4 0xd0000000 0x0 0x10000000>,
+				 <0x03000000 0x4 0xe0000000 0x4 0xe0000000 0x0 0x20000000>;
 			bus-range = <0x00 0xff>;
 
 			dma-coherent;
@@ -2606,13 +2610,14 @@ pcie2a: pcie@1c20000 {
 			      <0x0 0x3c000000 0x0 0xf1d>,
 			      <0x0 0x3c000f20 0x0 0xa8>,
 			      <0x0 0x3c001000 0x0 0x1000>,
-			      <0x0 0x3c100000 0x0 0x100000>,
+			      <0x5 0x00000000 0x0 0x10000000>,
 			      <0x0 0x01c23000 0x0 0x1000>;
 			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
+				 <0x02000000 0x0 0x40000000 0x5 0x10000000 0x0 0x10000000>,
+				 <0x03000000 0x5 0x20000000 0x5 0x20000000 0x0 0xe0000000>;
 			bus-range = <0x00 0xff>;
 
 			dma-coherent;

-- 
2.56.0

