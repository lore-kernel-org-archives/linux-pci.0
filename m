Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267115;
	b=xoH2AKDUWBoYGeWN+zA/C0Y36R3WE6dpXQmnQTZhcG2zfEm+DBZhup+lnO4p6uYE1+1f
	 SEdGB5SLlncXl1wOLqax+azdyT8neAqGxaN0mH4g/4pKtLuBgEHc+PNldXd5fhV/nb5+5
	 vKB3fGJKQlvnkj+9egG5vD1xtYwWC8tOwjqGeU2hrf29R1V/0/8u85EIns394Qit7RYMd
	 wXeN+WNXTg8EsZ0mbuGe0jx11f5Bdai2DJEB/be/ECwsOXbZT58QQhd/sBZK4/q7jWNQI
	 aB4ftWrc7KuY16rdMyDHv16iDKXn8c5qWxU5RCAnEbZPn8bMfAFaT5+ZGbVHsTlMT1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267115;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=I6pGS9HlPdajy6JVHzNvNG5YnPfZi+MQBITdwkrjbpg=;
	b=3spxHI+sQt0oB4PG7RBGdN7dALuCy3OFB6Y9hzBMDLekehA9KWycd5yMznKn+8ztT2oF
	 6uVryobl/Y0ysQTrKwPrEvI0zMGFntq6aLBzjqgd0jLHSpLvViIRPg+Sh0/IC7v8D0Gm5
	 UgNL6B0W7OREZLjpN1oZFXpYE/cB7P3s7sXR6V6zMy7Eh4mDW9znlMQZg917b1YkFWcVL
	 F8/nWTX4e7jaFDotZnhpNWnRYIWmubIYAIGUr6WAntzl3ZlOG1kFgwoEiMIBqdb0YKhyr
	 hoIBWSZpseqRZN9ncf3mosdO+QyjPJKWRr3nbJnbr8dVWW1VLip8KvKhSiTktESc2Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2C606A31D;
	Thu, 29 Oct 2026 09:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2E2C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1793267081t50177237
X-QQ-Originating-IP: NhZPlk1+WIs/nEBYGHCH1CYwxEn5UdbQk/jw1hYepC4=
Received: from [192.168.30.244] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Oct 2026 17:44:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16080051997495535406
EX-QQ-RecipientCnt: 31
From: Xilin Wu <sophon@radxa.com>
Date: Thu, 29 Oct 2026 17:44:28 +0800
Subject: [PATCH v3 1/4] arm64: dts: qcom: sc8280xp: enable PCIe ECAM and
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
Message-Id: <20261029-q8b-dts-v3-1-655696dfec45@radxa.com>
References: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
In-Reply-To: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
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
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFmPRRu90jdsX59iVaX6QvHgk1Ufind9aOY/9/UNe5oC7
 +SENR8Wd5SyMIhxMciKKbIoxDPMZa/MvfZUrFQPZg4rE8gQBi5OAZjIsU8M/+ztjvXcF7Gfc1hq
 0x0PliafqMx5eZc6VO57pd5NznefZcLIcCLMpP2ekk1MrsSN7bqGkzbcVS0+4mlxwFH3mlfFk85
 4PgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MLnLowx4CbXM9c1jenNX3SLALNkVFZdBwcEO69+0Tmm7Bc7ofMOr5fA2
	AYZNxxgbjTgyC6EYnrs1e6N7+9UGWU7y0vb2ORZS6/FjidWq8t/C3i5n3WlvmsfIzgu/0Cn
	gDCo+yXaA9V47I/QvpWAZ9iwf5U6QLUgkOGjyCCCLK4TIJypnmzzxQbo3qQvAA421yfB/Rm
	4JjjzyTzSka6J0cizxw2P6E4D3f0lzbiI7ahyT+4OOBvVbz5jg8yt3/+Ucg8CLXUnmXMSiK
	9u+0hiqSGqqtLHjC8ztWN4ngSYo1sfC21PHu+3Mzn6lUhRJqGa4IZwwPBiHild+OHVyjWXw
	o1cLzrB1yIqJyPDQXyBlobY5DHASpPmDHoAt1a4/xsffydRHr5W0CHSRjfTD1ickNbWJ70M
	YjQ5VgKbpe0bfN5yFUOOJroTLeG1fka9NAnziztyUWa5ruAygRTyY7KtiYW/RyjyqUetro8
	41kXQ9wMwdoNVvVo351mYcfgN/Kn5BXnZ2lyEJ18pb1zcEA6EBS8123Zf9FWd1/3XvRrrZ/
	I+ZZcdAojphKb3utsLHbE2QbNmrMUN4B+LA8c8UTPYPb9Rcs0dqsHllbphK3Rj5PMqIbbnn
	/PGBtE1nK87Uojy94Xk/ibXASLMjRvd4oGBWdIvLyk0AJhu2Wg9TI9tdflKm7BTV+eh+l10
	n51G/RYtJooviI83HaD3E6XxbBEzHq5xfDNAHJ3I/yTK2kidTuwav1CXIyz/JD2InuBCr+P
	B4PGX2T2w/0F5+i9ecTfNKq8uY90m3T+cL4C0miJzjXwfzgmp2TXN1R3gVqgm4f6jExsalV
	eGYmyoeiYUG0oLVsKN+F3SqQg9SS64vpg/qS8MQpdaGrYHXEc4vbe7u7e8tMgrKJ1Ddmm7c
	lIWY0ZmprRyf/pdiQlMQVQBCfealHtjRFKRa3yY/qejYdPAxiLUH0tGOYlIcr7/psNydnJK
	AuojOiYbgKVyHKEBM94AsowNcXE6xFNk2aPFq175iSqWxw6odjxz+1SNa3OlxJgFUiWY4sy
	8/yv/KrBY0MNVkIBRj9rFmUAt1z6lLhKJG3kgfT7KEemb3xflw5p5TdNlhEEiVOYrzN+kpi
	TeN5xRhesAA0VY9Yj70k7Wa2OvMRLRg65TzHblcm+rifx66hwXqQMc=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

