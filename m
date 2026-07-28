Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992823D955E
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222414; cv=none; b=EtI8P8RfODLR+xFk6oy0L4SwCWfCa9t9fKjv5uyRVVwPrQW4a3Ais3mzEM2X5JzHB2EJRMrJUeBY74GRmZrRmOHFeyvb0Ws+sO7M9LQ9bWkmROL+rub9tYiWhIcVM7TBryxONCA/bZrG6tVlOo75nPyEc5FOum+J3cVb3hKbqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222414; c=relaxed/simple;
	bh=JYkeLnEmFT8bA95wWtE/PoI4PXOK+JDItqSH4/urX4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tk5zRrQJ3BYKCyw0vUzIqvDFORdWTmBcRdrhEB0kqdbge7e7SAO08SfQQoyE8EUAnYrLAOzeWBpKm4DnOBPDKDxmhZ7cXZGWPa6QYbSX5gbeDZVH/XP46OblDNKIH8s+a0bIZ5/KrpVTM3FrxXIsjcDgmknkELOjFJkaFYQ8ubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9IsDC/r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IXp92XoM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9IsDC/r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IXp92XoM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3adSE1527550
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 07:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mE34zSrvZSrxlh3bSH9tNq1l23w+B4YRvv1wHMSMCEE=; b=E9IsDC/rhZdLFRWm
	Dgbo0KXn5uLK7Dls1IrNbW4zDQdw7Xel3LRwTlr1nukf33ArGokudath1bViXPRq
	fS7jB53pItFc7yjZ6VWChUmNSs3Sac9cMoWuT3xYQvYQpnNV10wOzxupH7jqVJ0t
	6e5sgZNg0BxSEXOT42HJXUFst6lP7YbbkWCVu1cTXjdMr+6gmoud1NJ9hGgKc/oy
	iT/Vcx+0kctXMBgf1n+O0xd86zvwG7R3yvBczRROpE/bseZyUkmtMofjF9VsjrUE
	CMErnrOusQ3Pofr6xf4sTrVR8X27X349LidxYh+tHkVtuIX0u4frU+OxXhSOQMSc
	Eg7epw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8awne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 07:06:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7d6ba548eso4451890a12.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 00:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785222407; x=1785827207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mE34zSrvZSrxlh3bSH9tNq1l23w+B4YRvv1wHMSMCEE=;
        b=IXp92XoMyA/WjWE/x1n9pwRorQeD1mbQ1kXTJdyPtRvoqYH0woCAwx72PMJwbFnHE+
         C7PSL8KsTZDO/rkKhougaC4XjB6IVhwEmj8TrPOyJ/TB7U2C6/yjwMpkTFHjApKedNeH
         cksAFfpMWsy/+Fe/u2e14r5KsMYeTcqrd2wO7jG+slwjBHASjijGxwWaBGY4iM8szMW+
         XJJlogzSVFc/Q+7Rm1TUGfqPIK7PySblQURriuNJIyW9Wa/lVfgJqT6dWHf3etq99x8C
         4FD4DF4B6l6E8Umj+Ny+eh2GUAwfn/qlDogjQIy1TETdjslUbsEPEVVA4etOC2AZVNiT
         B/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785222407; x=1785827207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mE34zSrvZSrxlh3bSH9tNq1l23w+B4YRvv1wHMSMCEE=;
        b=UBpw/VYOeiLV4zlU8o1w2W8EDd+kvwXCXZ0yFXIUotf8WwfK67Unk/2+glz3DjoH1m
         xw9c+JF8Be36fYOmYzU51kz90PDQcq/Ni2KhaW4pGp2QqIz1FRrmWzgbUn+3GcvHXTFG
         2gT4bdJ5+Pf1zjEfhl62Y97JaHuY1mRekjUNRB7EiSi9udqgOLrdl9ggty9hklHsRz2r
         DwwFcQk+6679Eujy8Gw+8fAWZr5jqACFhHfy0ZuX9fohjyFY0YNn6yGsduvKgaVq9ssg
         HJm5Cm0V7jTZFeGuo1JDJ9aR2RbSi/zoczmrOVLoevs+iCNwExazwYSoqT5tEo6vGVaB
         YCQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxbOHol3UehVxuOYVGh5eTPfQF9RRabe+iWcAFHsa5dgc94CgLoE49J8iQZVPw4FJAdGcvRjUzsPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC936tA2cqy4VaHip76UPe7chlf6ID1tJ3LpSglhk/y8vO5lHw
	3Nq8v5B9OEg57xj7JpncgectY8B40Kx96Pu+jmLkp0SOQppUaRQzjnDyXjm+Sbqyf+37R7gnPpK
	KSq/UUBwKTdoqyZMdQntJMKG/bx71EBY2wwNyXb34OVTYS5yS7qDEEq5184nVJVg=
X-Gm-Gg: AR+sD115MSYOLilvnKuSEXJDRBXUpvrQwCysHzrtQG1BDGNe75FO14bqW4VJ+VHHgSH
	IxsNO94Atpg4vr/35NtrETzmjZBue6ggu94UV4PtH0+1e1o6C3yEA0K2sP/R4iu5zHRYic8lFkt
	F2+9lV6oiNbds3RQ3zqc199HMKFmTyvl6JMiciDeEGtXdBYnyhku6LEv0D+vaFBT6K7eyLoKQcn
	WdR1JRaZqCrnY18erMUcO/6hZLz4Gxi0CD6V9jDOgeFGJiqvKayzMkwsh7bS5GYK+OeeooNV36E
	BPfEShtPUcNQ3yOFhBJV4J5djoJWdqFX1BgiBiZMDPTViAJv1yvF5amJax1uLTDTZjv5C5yxErE
	Oo8qzC/u89g4EWRxkOs34N6HxVVJrGCpF7Fk=
X-Received: by 2002:a05:6a21:7489:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3c8aaf8058cmr1603280637.5.1785222407162;
        Tue, 28 Jul 2026 00:06:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:7489:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3c8aaf8058cmr1603244637.5.1785222406728;
        Tue, 28 Jul 2026 00:06:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm59846776eec.4.2026.07.28.00.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:06:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 12:36:15 +0530
Subject: [PATCH v4 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785222387; l=4159;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=JYkeLnEmFT8bA95wWtE/PoI4PXOK+JDItqSH4/urX4I=;
 b=6sdu6byWUtIMZbfzjzCWwdCOZxmQ7M6ntuEhC1rKU0k/jrAiOkP4d0mBGBWJCZgIVfMan1ieX
 KjSXnFrZ38TBxAmVqMuoy32W3gjRTAjCJPN1XY02jjGJuqRiDkzNGYo
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX2eh3NKMtk4gh
 wVYwLz1pqmS8W43F8vQIKv70gvwB4FAErVCCMp2R+zbRfhuhr9XW6bWAKbRv6hWL0sEipNBzsri
 IzYt1cr6GOBH3CvGZJi2Fx9K3MC14F/3325p4N2rlLOm2QuHj+XDSjZRkrBR7CJW2H6rSqsfMlk
 4lj1dAPFZlwoDFkIthpsbdQhYDAOPnC6VWDLZDi4GKqXTeZy1/jwCpRJ+VLtNktHb74vH+hpvTT
 qvFt4CgZMsMe/Ol4vgi1H+2w3Pmj1HVXkR9sI0FpUKZhNfDThL+v2SdAO3FPFTG3ZafWneqkHyY
 J6kCdIOUZxzrSySIiHNUxJKZ3i6jnWXcScVwK9UegZ/b8TGSQiiXhgpbTUZvkQJcpzNjfU7XFcw
 z8bF7P2wFUdOcQEMvuJTq0eIHQ51bIMeHODNbxdlJ/0wcR2jauHOz+7JkJ55kxCTo3Fd3MjQeeS
 7XKmTwHN1zXl89HIWMw==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a685508 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 3cHBUHw7cFc0EwqqwxSkhSxl0qEXlfsf
X-Proofpoint-GUID: 3cHBUHw7cFc0EwqqwxSkhSxl0qEXlfsf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX/N5M0q1pLYHX
 n7rh1cP4ZG6uwP7j5sAf6B5uu2O7KbTSJzWRAhvfsPOPdU2gYRi/VcDGtOjYgIhqLBMn91c/4p7
 LVMR6O4ZwBxd/I2WBYAxPbNPcfJRzms=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280061

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
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 113 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
 2 files changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
index b35fffb50976..32a0fdd80c8a 100644
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
 
@@ -99,6 +119,99 @@ pcieport0_ep: endpoint {
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
+&pcie1_port0 {
+	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+	/* Same GPIO is used for both PERST# and resx-gpio */
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
index c99bcccae00c..2ecfeddea496 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -2104,6 +2104,7 @@ opp-16000000-3 {
 			};
 
 			pcie1_port0: pcie@0 {
+				compatible = "pciclass,0604";
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1

