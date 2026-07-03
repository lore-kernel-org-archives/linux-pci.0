Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8563DD877
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082335; cv=none; b=fRXRrnodtNbrBSsA68DyOANIFAd0sLN6YHbPhO6ZVVx0Y4Dzr5mWF2I492tZIf680cwT/2XDmAQpKo9ZEEZ3XNbo+y7ljNmWhe4K5t2EKRrmosAxvXjvlE0FjUB/GuEGIRabTXa9AiTuXp9kmZ+9rZRha/7bc/OQWvSMGErYF3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082335; c=relaxed/simple;
	bh=LfgTEYQGzxZq560mMTimn0qwbTsn9CmT+QlxLef1Kvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnS4ooTbYcsGAO/azsqMyDcx7ggh+GSjGBmF7iKooCb/5iV9NZBflzoOiOuG3WR5UAEqPjbzuop2wCwJxT2bhSlW/zqZX3mn3ll3Qm9fr3eYTtN//vj46jzX3eqMaWQu8PQrsbE4jt881TGzgDayCQmefqHpbyidWCS+C7G29DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HsKBkQH5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VRwOVRD6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HsKBkQH5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VRwOVRD6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BqnrR4091189
	for <linux-pci@vger.kernel.org>; Fri, 3 Jul 2026 12:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3hGQEyI4vrNbgOfPyY39YCrobQ0YERCOeu3mXSGdPmQ=; b=HsKBkQH5A0bwrfqa
	d3nPa+SoJEKkQVCgp6gZAxmMJ6wzJgSA+//6TjF/qFL8YDX/F3BZe3N3e0RLehsd
	w0vvzblCl6uA7pk9yBo2W3MxTuZn0/7FpT8qPECDgn1UrS9u35wosEUeFZKwt42G
	cM5dREUsYLTUVe2PuSp9gLNEK2NBDf2f4uyaPFpn7X1OL2QaUFlv4GImiNYT78so
	PP3QB+kqeughwjJnUpsCfLPaftR34uLYJXZt7suZKMeHXsHeW96oV3XSHptA1Ps+
	OMAMSANcjPQWCJoKyTX5fCXHDQq2f8djsI43r0wKizIkXW0jwqy6AvDF0q4ys5NN
	Tf/4HA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0666-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 12:38:53 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso470379a12.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783082332; x=1783687132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hGQEyI4vrNbgOfPyY39YCrobQ0YERCOeu3mXSGdPmQ=;
        b=VRwOVRD6H9vzu8roOtXDLT5K9ZwVucHTRPXYhU7N6La+d4eg9XS3QVN6+6V4MDzTPD
         AiYGQr8BkFHIQi2lC+9MzSdtSeAuDw1Ok7EtMRjjMSS7h9o82GZz0jiETwE2Vr16aZwD
         fCOZm5+Ix8EpixTmMpMplhDL2qBTzJuncns2gu3eca4xil5qRG8GuedwDrnrM8mfO5sU
         g5CnwrJhh+HWM7JAoUmspNkK9TijTEN/Hbdn508vKkHhsIU0lKa8m73TWCJZLI3sqlqJ
         mNnbrdSmfq1ExEzmpidINzRafsDgwhWp/eC2zypfaI5EXuteQ+5Z7aQ7YWBgFO6LkE/f
         UkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082332; x=1783687132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3hGQEyI4vrNbgOfPyY39YCrobQ0YERCOeu3mXSGdPmQ=;
        b=aFoyhn7z3HA/VB14bjY95/GzjVgSMgnANf3/HCp6hyF5/xj3r//Mcp9y22YK8Ru/Al
         46XIKvU12+tPCZdAv//PDLpU8Gf/5oFgKR7cYhNS8xbR4sADWYMjhc6pBYAKUK7jTl0I
         l0d3OcNTcanDKWLB+zoWckW67Wzqe6z8OkVjSg8+dOYPR4EEyiMQfnRAMXImEtj1SyQP
         22FVORNHDKk6MnNL5mDomr16vIwjEmlJ+Um9jbwo0XfFUoPh8KuZuYeajdo/XIvlHwby
         bffPbDJ8NHLXNazJjwHwOnHoiV+3JF4UdO3eCmZ9N9QIh3ZfyGlfRJAYhTPMVuNDy07o
         B60A==
X-Forwarded-Encrypted: i=1; AFNElJ9Cveb76xPb980zmkS6p8GApvXn1hXF3UOVNViJCpMjoGmTCu0EYMl8OuYw6XwNp9gO1qQS5JgpPkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgb39ibvKUoj1Xo4oZnxJsE7aPiat26l7ruk/A+xUrnBdbmE+n
	RAbANWJO0dpdEchVas+LzsaD7/gNZzlyOADdlhmwhuRZGF7azUrqncMRp5pmiTcvL3XY1gQcHQ7
	qFmsAYtVcRxt1tMZNOKRbYTw61BHxgoE/JAIW7YknEVjq9PQLXOQIg6SV5iZmyh0=
X-Gm-Gg: AfdE7clTXnu+KAzLTk3fN510J/5g/1OuOULFjlAsmmrv2Zh/ROBkiiBVtEbQofmy+1e
	+Kpc4UppwHHnTxvUzRAsZt485SJ7mmhnomIAYMu0yILuMPO9/XxYbukaPv44Zj3PBVbz4wReQIP
	H+haOTLJQOv2H0SGbKVp/ARcHc1R0mxAF1BDGnz0wIDZiibQDiSwdp8dLHgABIGG/QA5907o/Xx
	GUlhnsBFGIZCeitx4xsUokYy8Xy7hNv9sQUMbHcS6V4YjDxlSyhYxFdmBNy8ZUqxlwxFK+kzg/k
	znR6XaMeUovFspksIVcVU2LJmrey6N74IFYt5bLPIWI8leqQENKwBX9RjOX3ZDoQ4X71azEqpxQ
	yGw22WBF4eBNOMjjLD6iK7IQaBrVfwDYmBaYfCFUp7rSf9g==
X-Received: by 2002:a05:6a20:c98b:b0:3bf:d1f9:b1dd with SMTP id adf61e73a8af0-3bff42a2d00mr10861093637.44.1783082332021;
        Fri, 03 Jul 2026 05:38:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:c98b:b0:3bf:d1f9:b1dd with SMTP id adf61e73a8af0-3bff42a2d00mr10861060637.44.1783082331504;
        Fri, 03 Jul 2026 05:38:51 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c870effsm24356993c88.12.2026.07.03.05.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:38:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 18:08:31 +0530
Subject: [PATCH 2/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-eliza_evk-v1-2-7624440bd76d@oss.qualcomm.com>
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
In-Reply-To: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783082317; l=4277;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=LfgTEYQGzxZq560mMTimn0qwbTsn9CmT+QlxLef1Kvc=;
 b=ZghlYOOdL8qLNSY/3dzJK/9ZXM3EwXZhYeRvoh/RDd7kbo8Vh8yNcLgNo69uegtMI6U7VmxxW
 WjRfGEPvDxrDRinFnWixKBnC8xqNsmNst+AIdCd9Oep/3XwTwRIO29V
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNCBTYWx0ZWRfX58nRVzmZk1YJ
 22Yeyp8H9g7g2HjPRdk8rYJSSBsnckMigIcekmRNSjuY53X9+c1ARsPMrza5zUvbgwShCGyaJpo
 PWbTkNDaZjeBqkvtfN7Rh4gK+7ZvjEY=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47ad5d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xTuWgevKKEmUOcCBws0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 3Jy4YLjgngpyOjfT2glaIJi-eCCZ_fdm
X-Proofpoint-GUID: 3Jy4YLjgngpyOjfT2glaIJi-eCCZ_fdm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNCBTYWx0ZWRfX9UcBJrBQAi3j
 +1dHaEkZdTe7tIEZdAbeLhEmBAULzwNtd95f5PhCPtuuqD+SoBkuBZXXQss5i5JIuA/RtYTxIZO
 1Q7JhYftjZ1XccdXQkPnauxi/UDnWfRPAnmus9InjKed52SR+Pn8RVgLxcWq84+EoyPtmSrCIw6
 4KSUCI4ki1YStphWITZcRdT74XTSTjXgNilYk4HmJGaI1td/jRHnXPz4t3OL2Ewbpq/4tAyykBN
 N8EyE68QEW5vyWy8/sTEEUjgFJGWhuLaZruKY3muTlvpFC3ZSFpacyzrjw4+j0IONGdqDfCSlmN
 FthvXVrsRbUy+5ZjlYoqx3absYt8wno0O8zbKSHVvw7iocp4otloXcELUb9cE7r+ga2PZF/7xMm
 I6Xw9j8FrWyMMWRytpMP3lYb4kDKj28DIlMLeYYDFZJx8lf833LTZJ+dV+qf1hsVtmzxrbPiguX
 J6FcoPDQ9GezVKwccMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030124

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
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 141 ++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
index ba41dbc34b81..c2afb8372ab7 100644
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
 
@@ -102,6 +122,104 @@ pcieport0_ep: endpoint {
 	};
 };
 
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_state>;
+
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
+		pinctrl-0 = <&tc9563_resx_n>;
+		pinctrl-names = "default";
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
 
@@ -159,4 +277,27 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	pcie1_default_state: pcie1-default-state {
+		clkreq-pins {
+			pins = "gpio52";
+			function = "pcie1_clk_req_n";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio53";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	tc9563_resx_n: tc9563-resx-state {
+		pins = "gpio54";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
 };

-- 
2.34.1

