Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72BD446052
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626352; cv=none; b=TCy7w4ZUBiZW2FIol5FzjTuvxc2JRpVyfZ505J0s9Z3hypsMSAjYcWC/Ia2QWQokbdxPA7/s7xN2Tqt+/QMgQomH9x7i6Zs7NFsvquVQDkvqakOGNXHGZh4FuGsqnXCGZvv7uWVxsIzypkJlN7mVRfszfWrQjzQ+RynUluWN7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626352; c=relaxed/simple;
	bh=/Hq+rKIRE35bnCO+fN5zdMsm2gsL41wKraZVz8E5CyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qo5k08RNgVYN42+BYaZWRYfyfKZ+rffCrOi6LvXDktsFhpiPakX3l/rqXvSNJXEotZwS+HF/5jxWPzkZyavfblJzvcAl5cOGvEnK2HMXqWmesWQYKJCSwqoI2sPJaIneUBT21MuSNbVtAkp5X7qR5rQlfRMYfhePZLh9H1EjSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oQ9g4YKB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SqqQAUlh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oQ9g4YKB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SqqQAUlh"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L6LShj3978761
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 09:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K1nqga/etGYhYn1fNOgtOTXNg94VNZdC8N1dw2PEOVw=; b=oQ9g4YKBS5EeJmWO
	imhh0DAqpCxoMfMQi+pxyN9CDBFjIuY3YWtLU9UkH4lRVqwgbaBYVQ1GmXMzvCG4
	Udb2k0zOQ7TWAiG9IpqMlaUpJGXgn7EhCy3OSotstyBt2W+Mbt7I/HGnVFZO/GzW
	Jc38iuelMoRAJCXdRHIc2R4DK3nFbNxBrFWyVIcqvmO4PJ0PkdbuIysyF80bhqkr
	poH2svTTGFiEs033nyLqQqtlWsCIaz2XxdhQO6nS5URwCfH2RN92MgsoKFS2Uga3
	2fheP8PINUYXsMqNI2xU1ONQrE8iG3+mDd9JnlQdcw2akkW8mpYb8MuXb1MsHx7i
	uyKeOg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv43r4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 09:32:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so198834365ad.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784626348; x=1785231148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1nqga/etGYhYn1fNOgtOTXNg94VNZdC8N1dw2PEOVw=;
        b=SqqQAUlhDyauQYctJNnB8yQ5Du6dt+XsncsxP+JBgAzkCR502VJua8EQJOmkzEK7FZ
         0e47snyU7D4+jd5wPxcXUNnX2/fHED2hbIYWGKPvoHNVTKFmVP1wEpoGK/mVCGetdqhQ
         VdTAlacRqDBFd2i/WsqRmA1197kD8q8E+YOvXQ6mDf5BYkqkDvCKikJPMy7fsxeHKyd1
         3NoOxUjICqYd8ssIuytfT9xF5SlZnOIWJZ8R9JCRxCImc7299U3zKgxpH5DXf2QHNo2v
         vX+jlEBolYKMcQ47W1S8dnbdFIXMUaIg1PPn5dIKA+NJo1m41vZgDwPRa0wFxuCpGrUQ
         XliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784626348; x=1785231148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1nqga/etGYhYn1fNOgtOTXNg94VNZdC8N1dw2PEOVw=;
        b=byb2CLRkw/XWEVL50A8Qz1yGLyr2JAF2lzIOjBzi1gjcRRaMH8+5c6XTafaiBEiP+x
         JyzYKraR67glvl4b5u9jjmUoupeaDqwAgn3+lKtTe7zt7JKqzCgSnv11ghB7wqkC3o5o
         dEFCVHc8wDuK7eJEhbB/EJZD6GreMQZQCe/OXW3/znyOWXRroa+g/lpMSUThmKiRGhnN
         QNLaYckI2Hy76U3wN852FwrHlUvaPiQG7kKV1kWbSBfyKnfybkqDAoR3dlPm+XfSwp9j
         p1npHnfSYC7ALIhu+SmPT3e3874NKuRD+P06TP4rcoJDNqJJzjHXQ46C5k45xAfZ5LIV
         D7Zg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6B+zAjzmm4LNkwx5vZbVvDW1brbskYl7XIFrWUjaWT9Eu0UCf10UXPAANE7prm60dCnDkWdH5AT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5+fekJKkw5vUozjw+ibnt9qamycj4XicciAQOz8wtPkjc8ag
	AUbQzM3BwV6s/777EMwrRgzbjPTJQycNHKVKNzDHmQohO4jx9lduhs1AzqX8F3qAeCGAl5KKeMm
	I2zHQ2PJtFBjAi2jklIQFiqKpITVvs+w9LiYJq3sIztHd2+bsu9A9cXU2ZVS8F60=
X-Gm-Gg: AfdE7cmNTjDQ6wHPG4vtzkm8h+95YBABWaJamAmiwBeAXBwYGltEg6oteGhjzNZY43g
	NyXZX5VOF8qDTxK9D1yZo/7kh3A9PCQ8N0G9brpRRTwVdsmJFO/aTQozbDUDSDmQD0RYyADN1c6
	a8PXC4R9DNqDvh5CN32RdTOljHnZ2+awpmeZULSt7c8pdDSymzvwistOVbZQu7TmYAN8I3duSAu
	IWQLiW74NhETBl78gnBC7qFvcrhz01HnEXmMfytWQqiJg/DbgKJVF7mr6WgWBv0wwBrHKoZgWZK
	5rfN2qwVyTiSBXhOYGYzZngsUPNSfe7XcMFRbCFs8MreMJj8ThLIIRksqmF1YCas1aMlpZTn6F1
	exRsPIrdg8FlPGqu8xRNA5ht5zjWdNhgBKt8=
X-Received: by 2002:a05:6a20:9148:b0:3bb:21ad:40d8 with SMTP id adf61e73a8af0-3c3ad9d5c6emr18696482637.39.1784626348515;
        Tue, 21 Jul 2026 02:32:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:9148:b0:3bb:21ad:40d8 with SMTP id adf61e73a8af0-3c3ad9d5c6emr18696447637.39.1784626348032;
        Tue, 21 Jul 2026 02:32:28 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb8a4sm49420949eec.14.2026.07.21.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:32:27 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 15:02:03 +0530
Subject: [PATCH v3 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E
 key connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-eliza_evk-v3-2-92b10038f13d@oss.qualcomm.com>
References: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
In-Reply-To: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784626333; l=3853;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=/Hq+rKIRE35bnCO+fN5zdMsm2gsL41wKraZVz8E5CyE=;
 b=PGBU1cIvSyChSiUKtAc2CbNA9tRzTKOIyZ7YO30hCSqEwldKoSZWvigTXdCUYdaVJBEsYwU+L
 W3sb5W75CfPDxyTqkWkF7O2af437IeyZULc4MYMB7JZ5lmDLG2dQt21
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: JIF6m0JxWmNYhMpr3VVtfTbJeKjVbs58
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwMCBTYWx0ZWRfX5m3keSA0MBqQ
 sFp8HmyQuHHzRbIQ39MB8D/hYyDrMAHljBNcE5jS3uP5m2jA0pNIS4GayPpFA9Z78MV4fowJGiu
 o/167fJ2x87A/MTAE1ULmRlPF3ykjNt561ACP4ztppFj3Giw6o5xZG6z99/UDPdbLT66ImWVXa0
 SKHehco1PZ+8X4Q+P57sren4OYFk9I3zdL4k2Gtn1Wi8gdrOuFmPgZzqPZnC2cyAvFXwIQNVeC/
 IXV6GgJoq8giOaL96p/I/Sy/y8y1QtEcYY95xQ2GnNG4Dqv6RMUuTnE2Vr7KuiZEhZcUzQrE3ib
 yPdyst6+fC4rVslXt/VgrJHPgRSLeeh1nb5bNveAkYtn8zlcW09v8vywjIA0VUdSBCPIqjWOCmb
 pazIp7cdRy/Tmd65SjfFc2HdRZbZEkPkfkxuETCQuJ6gIwaW7lmlboqGaQqrDoGgtfmoPEi0zgF
 9IWi9CTK+3JUDYKkqtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwMCBTYWx0ZWRfXwlUiDplCag2E
 gfCKfmn8Eb1N5UDRMVs2HXo5WbvsaIz8J+lgzYFOqfus33JmcIiT4JpncWWMz2qQoQyzM7mFtWU
 GEQULedKB0oAIX9GDcmJtauLwJWCxM0=
X-Authority-Analysis: v=2.4 cv=daawG3Xe c=1 sm=1 tr=0 ts=6a5f3cad cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: JIF6m0JxWmNYhMpr3VVtfTbJeKjVbs58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210100

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
index e47b24f8b827..6d76715ccffb 100644
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
+&pcie0port0 {
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
index b4958954de73..59b3cf7f168d 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -1909,6 +1909,7 @@ opp-8000000-3 {
 			};
 
 			pcie0port0: pcie@0 {
+				compatible = "pciclass,0604";
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1

