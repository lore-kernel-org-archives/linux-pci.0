Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393883C1F46
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491456; cv=none; b=k2bZSHImxgDQdskgM91XWecwN4b7Q8/hphtAJNnWyT1V/PK488zOYUBsY5Pnc5n06e85OKtbiAMq+jygjwctNnNy7NrK3iGNP+DyKk+X+5Kra83HcN6XdCCFfMnDNZZY0N7GeMuAj2x2W3x6BDmNY0YBP2wfmlnMF0el3asEoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491456; c=relaxed/simple;
	bh=x+r3Uu7ejgpXa5q6H5BpnrCS/Hm4+Zml3M3VYQhtkWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsB3MvQi0QjBxj12SSpcwXoxRaaA7Iyf0PM9y6c1sBXsQ85lVjoOc2S3GAgS4mf8qltjyKDo+WWxBQ+N+6Ji7GCjr3Xad/3MAiUoFnyjdLaNrwf0ayXUwG0uNXYVUlgD3n9jtXuP4+8aLvCgy83t7nu7OrDQ51sfRQP2RAtuvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AeibM9xq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BgJn0+T4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AeibM9xq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BgJn0+T4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842RND1638136
	for <linux-pci@vger.kernel.org>; Wed, 8 Jul 2026 06:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/WzztkvtlN2zgLHSjTdTyc2ooR8LQ+rGcbo2eBDOKiQ=; b=AeibM9xq5OOaD0s1
	F37zJ5RgQIC+6ZGjCmtRXYF6Mndjr3mmh0h0trgINmPVF/X4AJa5/qDv6Lg1kpcU
	OA3j7XljA8oKllGxUM5gUG2x24IvAEmr+xjnLIw+lBqswRyWKJRo2cuPGRjmi+kC
	SftSKlIORpm0dzHr9U6pshlMbR4vfIbeCQSd7NWKBmzubvF3sUmwTmqh16wylA36
	GKoBFw6I8YEW+FjRr7cIhIl4qsvgx/8ixTZOtdDVRxXznnQ7LgKOBSmvn2RwTFzn
	JDFr61sRLsYvKx3Oth4qFmFr3jVss2Q4sGJ+GLtiyFmdumccSJITI2kbhdSbAZja
	70lQKA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9c6a93sx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 06:17:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso326313a12.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 23:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783491453; x=1784096253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WzztkvtlN2zgLHSjTdTyc2ooR8LQ+rGcbo2eBDOKiQ=;
        b=BgJn0+T45n+OAvXTlvZTcs/ext5Wtrlm0ZEJwmBPHH9ZoJRltHOLyXPtgvQSWhLWDF
         Rx7Tp60wimjI/IUKEhXfLNIEDNqSz9iI0mFvsm2uPgS9xFnkQl74WmFIcAr0JnszQi6Z
         EAIQPxs5SYSDXwvcygE1N73PKeDYw0sy4tG09A4W3WRsmBIRr5OgtKsRZqaKuggCcOVD
         A3l3RX9eGXglLrW5oEfivjj9qh8ceHRX8xqV3fgoY+8KEKKD1t1EVrPhJtRo4HzrbnGb
         ctDXB/Coh8Hs/kWxnUhy2gViBLxNOMc/udZvqVfsIdgLTuTkbRtgFLieLXiW3YswwbRu
         ed/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491453; x=1784096253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WzztkvtlN2zgLHSjTdTyc2ooR8LQ+rGcbo2eBDOKiQ=;
        b=rWAJ+3HntdWtUwbYVoIMwXlxNB1fRZU7lw1nXl9KrdMpTwewXdhNKnUa0ygupnVXj5
         eW0aWz6PtqeKyUJjfOy6MyM6pVIG9QAFcO5Svb2Mg0MMvWhb1R18X9ShWE4LlNYH8c3H
         BGKMVjKun+LT3sgLoQpw0keA6TpFbG1HtHnW55i9CSLOThD2Wpu6TR7YJhwS0T87G0rp
         yd833+3Qs0tApGsOuWyYOx+8If/cmKGlgiHA4RKUHiLi5XTgw9t1hmxNP6VlbbFMvlyr
         IHhh0TH/QzePdzUd2cFjoEPCzSKxMUk/QmKp8APE1aVT5OCR0BIU24ZFCuwFUH/qHau1
         cu6A==
X-Forwarded-Encrypted: i=1; AHgh+RqVRVVtbX7A28WiB61QzDlQJmW/mABEACAvuE4G5cugO1ptvqRLwEs+YEgPTfEhBFLYKNp4CaQwTvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPh+bJ5f84YwLyxepkseujeVnHSpcHolctaIoysKhflMm0zTR0
	Bgayph5qhBVs1NPIZ+GPpslj509LkXpaI/ue6M/WFHnkPHC4MYCmDeps6BN0gLkcDwo4FWU6Nrj
	H13jwXoVXM8g5a3KPbizh+bMGK3zTtPLg3sp3zPFM6cqQjxTaoVQ9VSW8DZ2bWUaJEwpYWkg=
X-Gm-Gg: AfdE7cnGFOdI19KNYAOcB230gwXdBDdqoneA2CRkXjb07r3sTQ6TzkWaxVGiqAlbH4z
	c3jJDtivM2mTvZDc3bbLjYlOgdMK+ACDKlJ532PqT8n4eGxEdUN3muG/ypQCSsF4wcwYs/dITjb
	oF2fW0WFS8Ru+HBtnbMaAv9eeU/FQsHX703j6tN4fVvj0epp0chk/aCQjBjaGQfc7NR9JMYR5H7
	nKiVNbRcLXs6AptJV7kDndVX8J4zsTezPfLaYk0r8VSmwWGNbLyr33iJ6QSarnfUjpbqniDirB9
	Ggvm4c2/z8kXoBIss+4LYSOFufZurIblXiqXjN/HTEGwoajXBnVsg0pQ8FlSa7gubnSgEIffYcy
	SRGeyn+9snJ83xWr2Xvi2w+AmNMFFRrD7zczu9PROwLROpg==
X-Received: by 2002:a05:6a21:3393:b0:3bf:7994:ddc6 with SMTP id adf61e73a8af0-3c0bcfbbb8cmr1444727637.25.1783491452979;
        Tue, 07 Jul 2026 23:17:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:3393:b0:3bf:7994:ddc6 with SMTP id adf61e73a8af0-3c0bcfbbb8cmr1444675637.25.1783491452517;
        Tue, 07 Jul 2026 23:17:32 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483941csm17028221eec.7.2026.07.07.23.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:17:32 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:47:16 +0530
Subject: [PATCH v2 1/2] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E
 key connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-eliza_evk-v2-1-c599246ceba1@oss.qualcomm.com>
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
In-Reply-To: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783491443; l=3799;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=x+r3Uu7ejgpXa5q6H5BpnrCS/Hm4+Zml3M3VYQhtkWs=;
 b=7AqOMJJPR+rw/DkSZlTE1G5qfiSig8Kneg3zJit3BmeUgVRy6vBdi0E0ekZO4HySIUxl6Wnzf
 BJviW3PCtPvC4H55qcNpKaGH12Y3n6W+21MT8o6Fs1yHA577l0x/EFw
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfXyHlCeKgqQW5n
 OsWZavonZQnylZeqsEaka9/Ttqmc1fwwjQoXwC+oildvZIJ/7x2orW5cNxjWhiNDWO5fsEv7v4P
 +OQEdQyr/CGmk4LekSEUX3X4YwZwqld6TnF3xNN0D4tCv3iuw+GrKcAKkbkdHiDWVLD6USLTYFW
 09TydfcBMbbHzrFUK1oAd2Sm759rPoZe+RXnGfadlqyu6YbbF2TAVOPlqScCto+QXQgMhO9VImE
 yuPLpdF6V6xV/ZeF3XTY33+Uj0Wzn3UehSIqV6j1Ym1F/z551VYGV0bX58RIF1c6C9nHaX+JdV6
 Y5nRmOb84BA7x+r3PMUkyAuoWsCB2Ntuii/Ykz7Xy1BuhQIEZ7taApsz+4JZ2wY4YdbE+M8UBr7
 sFWknz3fe0XsOVkL8O80VMQYreZ725oF/Xig7eR8g1yr/borBTEvtGxNZU2TG5a5RKzZmMf5MAk
 R2tieHd2WczSs1XCVMA==
X-Proofpoint-ORIG-GUID: g_l-ZbgYHLaUgWcjAXvVlUulbKSo8MSv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX4IHFTdXjEvTL
 BOKVUuwl5jpV6hsDnVhR37zo2x07+V63lwJUbMWW7WZL06yZytaRGyZMyHeRY0umRvo5NkSq1uw
 6sSuPjIYnAOo0pcwWB5QWlUnDyCs89s=
X-Authority-Analysis: v=2.4 cv=UehhjqSN c=1 sm=1 tr=0 ts=6a4deb7e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: g_l-ZbgYHLaUgWcjAXvVlUulbKSo8MSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080056

The Eliza EVK board features an M.2 E key connector connected to PCIe0.
Enable the PCIe0 root port and its QMP PHY with the necessary RPMH
regulator supplies. The M.2 slot's 3.3V supply rail is GPIO-controlled
via a TCA9538 I/O expander on I2C4.

The M.2 E key slot hosts a WLAN card connected over PCIe and a Bluetooth
device connected over UART. Model the connector using the
pcie-m2-e-connector binding, wiring the PCIe root port and UART5 for
the respective interfaces.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
index 7cfd242bc192..cce65e18f979 100644
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

