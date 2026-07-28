Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF13D9689
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222411; cv=none; b=lmlr72tbooWMuJebMurI4S+DcQDhAl2iuR0IhqyTtx7RxJxJGbWnyJkvnyiRBZ8u6zMUsmo4uuyVnvu+ZHPBQE4f1LVU1XtBSEyPIXcFF2X/s3K1AUSzCqEU1eCMvXNNAi+uz8X39DZLVKlkTfWKpBVxaFvOPNRbgCzMzT1uci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222411; c=relaxed/simple;
	bh=ztQ16TX6JHl54CQY4JeUYC4JsypCSsLL05RbsKPqIws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzYWI6EJsBzb3DwjVY0Qi9zQ123eaKrZIhYCMb3/z66dhG69c8KtTyXEp//QLnI/11Y9PLqQvLNJzj4LZxpR54SI3kB9hJ6IxN600dqDIZQjNIbAb28iGzI0l0h/5nyZxd4/UdAmdRmAdBaDttrdUVYKf5pvpPtIK2CIIlPGAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SWeeAcUo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U8Hgr5M/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWeeAcUo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U8Hgr5M/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S40eXl1593353
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 07:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+TCd8VYlfoTqCZXBNdcc0rSBVEIa1+gKOgOniEJSCGo=; b=SWeeAcUol5xJAz26
	r8ulz9Sgh5SBnp0vE1DBMVS993SqTFczhq/hbNu9SNtzN0kQOZPssJyFJzxD7Px2
	jzU3H410c0i+N5AXHxAimx52fWgD9D1Rk+aZVsFrVZwD+FEU1zw6hziDgw581TFB
	J3o8O43dvV+18FIjJ5FIFq2Bivbq6MnCKRayfFLAQ23KKsie4bliEqaD4b9PDn/E
	e0STmsK7VU5qI/Yt98gm9saoI9KkK9tzmnZRuMAgjxgXIbdrnykb4DdcOr8FQTHa
	4OLwI8vgWsyuouQ813VlLiaaP62KWE2RUvA0zb1JvRT1i6mwrhGL9ChEx4ksMRV0
	iqS3mg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19gngh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 07:06:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so8796663a91.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785222402; x=1785827202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TCd8VYlfoTqCZXBNdcc0rSBVEIa1+gKOgOniEJSCGo=;
        b=U8Hgr5M/rVE3D4hEI8RLmmEo5BYQWi0HkvpHudDKvxkhrvoXziiqLm2XnDurF7ikoE
         ZNLx/rxiAShFVveAl8ZRWNLiKMbnApgEMZLlnj9XSXf8RmbOrRUiIA9NRSjKkDQTLZD9
         tfckmh1wuCZ1dSnQBhhTwLdvZlw/0kao6oYsrcs1/JF2KpGi0fkYv61eN1/jYzlrHX7T
         c5l0IGrCZ3w3FHLu0BYGCOrKK3Q6xdWBpoiBS1koxxPdqA+wMsRQ6wpFyEoQDI6tLi8s
         hybYBHzJQy3MVvvIa6xP7mrvzYvwkn1XL1LnbWJpCw4jlGtGCsZeiHs1AhOfY9lJDrPU
         FP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785222402; x=1785827202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TCd8VYlfoTqCZXBNdcc0rSBVEIa1+gKOgOniEJSCGo=;
        b=lzBPqSrEV7sltXlC943ogmqpEtj6ED99LziSO/ZGkR/iNCg8NioYEUJG1P8J5eOK6h
         i6yCDzznAHkdNF8BFtiS6M/MjbXFDTcY7/AkMllDJ7ems472ENIB662lcNlKAwB6oDHa
         JV8zfGG0LZmFnVDLndgsQVAl21b1ODE76tDOBLVXaaqe2zu37mxYRSjLX4KsX2c6dUbx
         FQXOsbtqhH4fc8LIOXubvpH0+YLYcuGxpUnNC2mGgLk5RY+mJKj3QNPvjM1Jl6e1F8+C
         6MYgnc5LSk3Cm8szxqxX78yXvM5xggZ+NH+qCP05r+0OBtL+Y6SQ0ZnpLetHTb2+VwWi
         Ac7g==
X-Forwarded-Encrypted: i=1; AHgh+RpBHImZFz74OW4Qs8g4YWqQ7SRAHHdONwqILgVuEJOLnVlbXyisQF5/xIwMvxrE/XNRDm2lpHWYfKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuAZA4kNjNg8s6XAbK00H1yZJOwCWflWqs+Cbkw/c4X1NtZWM
	1a19ci+gFClTgACGttfCuKG5n0qECZZfRIZUT2rV1NWTDPpn2VKlOowhDb2QURlkh5YZHE+VZP0
	X6se89/u7/F/JikoZ0t1ZC0BmcEZHowTEKTpb3NO/5HtNpKyVOOZMLEGOXbqgQmmzCwnDedM=
X-Gm-Gg: AR+sD13E3SFr3HzLxiCGj/F+8Rgzwtm0tX58CGD4kA+ZlS/fSO2ul7SFU4Dcp/f9HUn
	63YI9osuJp9de1Te0oPhe4NwUcBpH4SMi9Tf7e11IYT+EGRVoHMakCx+D/3DJBGwuOnhGz3zu1m
	fcc5RFvzflVOLOJqmr7yRNVMpQmCfuzpkS6aUft4/UtAvw5+EYK7S+u4Qpn7z4HVh/47ItDcv8q
	3rJy4HXuHfd6yblwpKZZM08M3ZxyLZQmwEzIFDa5zM06/KYd5QKRhD1zpU+bMgDvJQsc6ktdzmO
	92W5i8YZ5AMXhEaXMEXSVMD/kGpZD4tTGRbeaAqJ6VtfFSNnF5DNdkPIMlS8AIyrTEIQfcIRMQZ
	hCYsCxYkt+jLiYmsSEv60GIrCLPA629p3rcI=
X-Received: by 2002:a05:6a21:4c08:b0:3c3:becb:b705 with SMTP id adf61e73a8af0-3c8ac70867dmr1644498637.27.1785222402424;
        Tue, 28 Jul 2026 00:06:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c08:b0:3c3:becb:b705 with SMTP id adf61e73a8af0-3c8ac70867dmr1644465637.27.1785222402077;
        Tue, 28 Jul 2026 00:06:42 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm59846776eec.4.2026.07.28.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:06:41 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 12:36:14 +0530
Subject: [PATCH v4 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E
 key connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-eliza_evk-v4-2-decc7fe5246e@oss.qualcomm.com>
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
In-Reply-To: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785222387; l=3855;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ztQ16TX6JHl54CQY4JeUYC4JsypCSsLL05RbsKPqIws=;
 b=ft8+vXMn50lEQEsDtLGBhzcEEzdnjDtxFzWjldrrO7WSn5IRCWqIrXDOYxRJ2OL17b1aEuvlE
 5DBhczmkwD5APCmScKYY+S4Hr2q3rjmvPDnKV8QiBKj72dE2BCyAp4m
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a685503 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX4SNNv5+U4tyo
 O/ewzQY6O57NCh7L/hqxvnfa5QTlvtTuV0lIguTFW7tgV1diVeUxskMikwmk4sA90SRuSi5ykcA
 ZO5uMSBpBSZJz97QSEsOM5Tk/dEfqIN+FW3d3DKfISNaD6kX28cGyDjTCGQz6CMLuJfjwfjQofv
 YMCvsX7++PsJ+xq/Q/RGLB7DJIapR8ZAGBZrnXjVz0Gpok+cYh23SL0C4Fg872I1caNp13krr8T
 00E7CCVjauTh6/gCjz+PhFECOaJb5s+ITzKsTvkU2yNAKInDh46pxyH7gCx+iyXVYB9xqGPrOox
 o5tAYBAI08mW1N1nYNc1z3A1aqILmDExWc1UnBOtniMbECY1zW4cHWik7Sc/RdRtwDlALmI5wZJ
 suG51ceFWkDyEb1bp9a5mOSLX4+kJs4xoNmjal4McNOx67xMwz38Nv6CZ2YvcSQZSc4QSvIb9ak
 OM23Lj+aV1xBFUQNnkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX1Mi2LxDxD3CV
 FYmcH/m7uVk71hhAIP22sSfaThP3qfet3+Q0b0IGOIvUMZbPYzE+bxephjIm7I8WcbOjS0e/T3Y
 rOpm1E1/Agkl34u3zDKBOAbPkVbgoJE=
X-Proofpoint-GUID: OA8FzlSl5mX6MEZalkLWxISgcjmOq1_b
X-Proofpoint-ORIG-GUID: OA8FzlSl5mX6MEZalkLWxISgcjmOq1_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280061

The Eliza EVK board features an M.2 E key connector connected to PCIe0.
Enable the PCIe0 root port and its QMP PHY with the necessary RPMH
regulator supplies. The M.2 slot's 3.3V supply rail is GPIO-controlled
via a TCA9538 I/O expander on I2C4.

The M.2 E key slot hosts a WLAN card connected over PCIe and a Bluetooth
device connected over UART. Model the connector using the
pcie-m2-e-connector binding, wiring the PCIe root port and UART5 for
the respective interfaces.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 116 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
 2 files changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
index e47b24f8b827..b35fffb50976 100644
--- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
@@ -11,6 +11,92 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	vreg_pcie_m_3p3: regulator-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vreg_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio_expander1 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	connector-0 {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&vreg_pcie_m_3p3>;
+		w-disable1-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&pm8550vs_g_gpios 4 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&m2_w_disable1>, <&m2_w_disable2>;
+		pinctrl-names = "default";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				m2_e_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcieport0_ep>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&uart5_ep>;
+				};
+			};
+		};
+	};
+};
+
+&i2c4 {
+	pinctrl-0 = <&qup_i2c4_data_clk>;
+	pinctrl-names = "default";
+
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	gpio_expander1: gpio@3c {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x3c>;
+	};
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l1k>;
+	vdda-pll-supply = <&vreg_l3k>;
+
+	status = "okay";
+};
+
+&pcie0_port0 {
+	wake-gpios = <&tlmm 114 GPIO_ACTIVE_LOW>;
+	reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
+
+	port {
+		pcieport0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &uart13 {
@@ -18,3 +104,33 @@ &uart13 {
 
 	status = "okay";
 };
+
+&uart5 {
+	status = "okay";
+
+	port {
+		uart5_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
+	};
+};
+
+&pm8550vs_g_gpios {
+	m2_w_disable2: m2-w-disable2-state {
+		pins = "gpio4";
+		function = "normal";
+		input-disable;
+		output-enable;
+		bias-disable;
+		power-source = <2>;
+	};
+};
+
+&tlmm {
+	m2_w_disable1: m2-w-disable1-state {
+		pins = "gpio35";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index a54a956531e5..c99bcccae00c 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -1909,6 +1909,7 @@ opp-8000000-3 {
 			};
 
 			pcie0_port0: pcie@0 {
+				compatible = "pciclass,0604";
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1

