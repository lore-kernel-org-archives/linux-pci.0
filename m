Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4F3C09F1
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491461; cv=none; b=oC+R1PQUJGj4HLM2eYnAGjPANuaGreveLcR8Vzbgtrx6CoKWksu/ghF4w/D7So+9Zi7Jh+XNA1WuKflrCf7JWVCML/js7eFB2L1m+Udy5AoawNDoF7nYPRC1zssZTB8mBI05nLdQ/rigSJDSAuC06gzvg2AxX+Q/lwnOysV9eLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491461; c=relaxed/simple;
	bh=kjUp38+rZsebDdPzQoG333l/YriQXg1AGNOnuiL62m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gE2hnER+h5K7wT16r3DO6EmOtPOC9Ya3En0mGfiNc5Ug2DLJy6em2HpYCq4qGiv5EgHJckFiGmLak9KbtHtqY0ItKKpL5fybCzJtXq3qC4cLPkoTX99tIt4eZ78YlskNl7P8CC2jT/NX+Rk8vCbUSWtyI/3vv8NOAB+lPeJ62fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldXcBAFc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OgUR90Bu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldXcBAFc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OgUR90Bu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842aSB1491302
	for <linux-pci@vger.kernel.org>; Wed, 8 Jul 2026 06:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	InvKQYryfFOrhTSliTwFdO7Bo44w0fLxACXlIQp7TTk=; b=ldXcBAFc1oy7BVaQ
	geQkDdR5GzBJVn3t0Nk41ejVG1bHWSqhuqrAGTkDgHs1qPjRfKyXXqh2qrRVIwvC
	gkQeZs6QFhP9zw/5o2IVLebqtuDF15A+l2zKygmvx0tsWa5czjc9UslGuQKNbkTF
	8meMx8TZekhY8yk0CzZQEF0Fm1Ohh0ixQ0Zwi91UmJSfc89o8Xtup8c9GFENSZNB
	xncFEJVU47zPSpNdvrpVhBwWl9Y2QnSyaWC+6y3lB+VtItvIL+1arBj1bhZIwK7L
	n1igPF5MlyfXkWHS/C1HOK2aCSYnTnfdywIDg729yhmT8HrttxB4HHnBWLRwkN48
	dXvajQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9b5g99pr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 06:17:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so393930a12.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 23:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783491457; x=1784096257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InvKQYryfFOrhTSliTwFdO7Bo44w0fLxACXlIQp7TTk=;
        b=OgUR90BuP/t9MltAnt2PQYUg3Cuas4TBmSyTh+X7Wzuv8hyk4X/ezDhN9UB77h77bh
         wiKDtq5U2iTzgPSisW7GC8Mo4DjYP9m+sWVbpXgFJVRUSz7BJFdn585ZssliPu7zovSK
         jpthgJn29lFkQfI/Sp8K176QV9o3QiwQlUcG9xA88+Azt9Q1mWwxPCh8oeNDSoMSDQBZ
         mYiDis5sGEplsxDCdy2JvUq8K3Lhlfkr0aaZ5bVLMoSoAiM6kTxg41Mmfs5d/OqQwQv7
         QXU8QPvSxqAPZwl+yyKdp3EO6vn1TiWOQ6VMsWgA0WtPwPtWpn1vheiSlwnCH1ZYhT8+
         gGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491457; x=1784096257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InvKQYryfFOrhTSliTwFdO7Bo44w0fLxACXlIQp7TTk=;
        b=kDqcWRmp1SRiia7smWX5gmA7Pj3kFIL5CxXSjDGMeYhPtxnLuewhzKoIyitd6U/qoo
         /AeyEpBlefQR4KYM6c5/RpInCxL2fmVTU6AHgQxtSOW6SiBpET+IPniFH13jwS+pm+gZ
         mSiwSL1R0V+DDmkXWkrQ88kGDzutj0Y89A75UmJYjXmIS5qVcrWYMn+bsr/subjDgnL1
         y5QOEmXYVgwZD7+Mv4CwYxTPfwlC7evsLEdTlaM+4N6kIhlP6SLv7z/cEpnbJrPpZMCZ
         /w1nrQX4OKMz2t3WzhnfYVLMZQibdMsOmiA16Hw8BH/Zo7TdHw0xv5rPQplGuyccBHdC
         V4SA==
X-Forwarded-Encrypted: i=1; AHgh+RobAve1IpQ+gGvCqLwMWEKh6g+uq9WnZ+WGe5nOpu3zMCCbUrJKX21d/9NIRA2yLHrft7HAQG4/MoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ALip7NfNTyYfmBLPrC0K14kxgu14n12bMDJKoM/Vf8UdEFAl
	0HCuiuJpLMttrGTME3AO9/FPQtF4YlbbRC29LK01bs5nlApTClx2bn6OX2o+BkaxU2t4BkojBTT
	1ejeTf4k11rLICarQk8NHDPbvBr71T4YnM7qikr66rH9A320A27RTCxlBPmHY9RMIuZ3Gazw=
X-Gm-Gg: AfdE7clgLCBzBdtwKMPj1+hv1g7KhgDjThptTevEclh3nEXZz8h4kemHyl/7No3DARb
	b+/SIE51+Hkm2+st6EcJOEzB1KkO7yDpYpEujEREIE+Fg6EdEQJnH4Upw+gZFCQYoEkhodxIXMP
	eqdeT3/pwkI8naScLJBO/R6oZLogsE7wU258Z1IWX608Yhb2Ryy/p6QXJiSKyzgAnqNY8uV9JLi
	6w1OiNJ5HGp/oqUu1iGwG9PhCywHqeYoTy5+Ig/aRdJMAJL16/Twq+bcsu/mDib0Xs35TBv4y17
	O/ggGalB21A66TALlQAd5fXkoUI3RMOEr9tVJu+MmO8I1B6mDJfin1PoURl4kijUfXLaRytb3I7
	/DRF6FMiNGDGdVnHMFXqZqmDYJjp4JLS6fn5IChyvt7f5Pg==
X-Received: by 2002:a05:6a21:a49:b0:3c0:b3f7:e5eb with SMTP id adf61e73a8af0-3c0bce18b33mr1228432637.9.1783491457281;
        Tue, 07 Jul 2026 23:17:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:a49:b0:3c0:b3f7:e5eb with SMTP id adf61e73a8af0-3c0bce18b33mr1228375637.9.1783491456796;
        Tue, 07 Jul 2026 23:17:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483941csm17028221eec.7.2026.07.07.23.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:17:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:47:17 +0530
Subject: [PATCH v2 2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783491443; l=4100;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kjUp38+rZsebDdPzQoG333l/YriQXg1AGNOnuiL62m0=;
 b=G61ADCIY1Ze5+lv7CZtLAmL/rg7NSYIdGZe0glTwXeTJ3e1hJuMMhAtvqTpf1CVKN0Eo1m6OV
 ehcDpjAkQ/4DMDFp8tUeYKQWQLvlYdg6gZ+9qkcyv/n9QcDtEUPI085
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX4JvD5D1lr7AB
 kDtjdBN9oQikMnCPFsHxtiErUe0iva2FbvkRWANj2bh5SmF75t6lvf4M72xnKPFl7Jd7FtZA/Nl
 S/FgnJ66TKs7CJj/bLtMXH/4IUATHsQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX+arLvxv2Njf2
 abe2GVoNBT0AwVsgT0jl93hmgByIo8PhlGE83C8q2Lexo6ltQdk9YfzyqipoMB1fRmMTHcjOlBO
 ufp6frr6P/ApLBVFeFH05XKt3kW/vtVzR8ivUmTIkC/XM1TJq4Kz7CCEGM0hJFgks4rgBW+JBh/
 +mXeslcGmjmn/cg3czt/3S8Yy0nWhqaIgxHT8roCiC3qEzhHeIvTRrfN/i/12ez9qXYj/PgcMcT
 zYc28gJeElpjuDgS8JpSLCOmzPi6HechjOtetyrmMKnBHguZ2xgqEEGGRiMuYPwrOPIAJnVNECt
 X0XDOy6KBKExLpflF9djbtJzigYXPOK0hxAt9qnaUxz44uExYyfoFJKnIxItB99/n6hXKh2+NLb
 Vx3ZFeZi8VnmipsjGgpwkBBY+yxf2HhNIwDEu4gNQPxIJmhRHMsKBMSaVrZdwDCmIBF3nxZiTme
 4Y8nSsl4oTBlzzAiY1A==
X-Proofpoint-ORIG-GUID: roI984Ci18Czz7i1zcoYc7TDx_JEUjJV
X-Authority-Analysis: v=2.4 cv=JLULdcKb c=1 sm=1 tr=0 ts=6a4deb82 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: roI984Ci18Czz7i1zcoYc7TDx_JEUjJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080056

The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
PCIe switch. Enable PCIe1 and its QMP PHY nodes.

TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.

Override the base iommu-map with the expanded set covering all the
switch's downstream ports (0x1400-0x1408 SID range).

The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
from the PCIe controller.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 112 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
 2 files changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
index 6d76715ccffb..e099b7c8c371 100644
--- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
@@ -12,6 +12,26 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	vreg_0p9: regulator-0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_0P9";
+
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vreg_1p8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_1P8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vreg_pcie_m_3p3: regulator-3p3 {
 		compatible = "regulator-fixed";
 
@@ -99,6 +119,98 @@ pcieport0_ep: endpoint {
 	};
 };
 
+&pcie1 {
+	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
+		    <0x100 &apps_smmu 0x1401 0x1>,
+		    <0x208 &apps_smmu 0x1402 0x1>,
+		    <0x210 &apps_smmu 0x1403 0x1>,
+		    <0x218 &apps_smmu 0x1404 0x1>,
+		    <0x300 &apps_smmu 0x1405 0x1>,
+		    <0x400 &apps_smmu 0x1406 0x1>,
+		    <0x500 &apps_smmu 0x1407 0x1>,
+		    <0x501 &apps_smmu 0x1408 0x1>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l1k>;
+	vdda-pll-supply = <&vreg_l3k>;
+
+	status = "okay";
+};
+
+&pcie1port0 {
+	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+
+	tc9563: pcie@0,0 {
+		compatible = "pci1179,0623";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		device_type = "pci";
+		ranges;
+		bus-range = <0x2 0xff>;
+
+		vddc-supply = <&vreg_0p9>;
+		vdd18-supply = <&vreg_1p8>;
+		vdd09-supply = <&vreg_0p9>;
+		vddio1-supply = <&vreg_1p8>;
+		vddio2-supply = <&vreg_1p8>;
+		vddio18-supply = <&vreg_1p8>;
+
+		i2c-parent = <&i2c4 0x77>;
+
+		resx-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
+
+		pcie@1,0 {
+			reg = <0x20800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x3 0xff>;
+		};
+
+		pcie@2,0 {
+			reg = <0x21000 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x4 0xff>;
+		};
+
+		pcie@3,0 {
+			reg = <0x21800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges;
+			bus-range = <0x5 0xff>;
+
+			pci@0,0 {
+				reg = <0x50000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+
+			pci@0,1 {
+				reg = <0x50100 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+		};
+	};
+};
+
 &uart13 {
 	compatible = "qcom,geni-debug-uart";
 
diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index cce65e18f979..363cabc5f55c 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -2102,6 +2102,7 @@ opp-16000000-3 {
 
 			};
 			pcie1port0: pcie@0 {
+				compatible = "pciclass,0604";
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1

