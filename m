Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F864EA37A
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336554; cv=none; b=EH303hfBy982z5byF/Of9YawtnGHvRdTQxpgn7wvFnepiloJzA0zlgiJ6qwtKYYbBujOnNvlC9e3TQnN2cYgJzSK06LktIXBVItal8H0/pgBMzksTtfnvclv9vq1YJUnczFlKfV91YF248O++kR51V4sH9xB4MI02sWjaTGrkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336554; c=relaxed/simple;
	bh=NSuSGrCqq1LU56by9Gr7NQIQY6WQp38yPhx2rsBxjcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ciVB3UP8VVOlETmKtLVRzddtcICX8bQC3qBUKi71gS7ch6Ua+fgHZHkHjQqExBE9d4Yws/D33gfGFujs7Vj4vzE15DkU5C5/mIlMogcADO4w5NMsYawE27G6ckCmlCmOps4hi+lj8VYhW7iT1stovAwPceN1R7IlsZaMDS6i8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QjpgVeN+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rc89InSE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QjpgVeN+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rc89InSE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TEMmxa2298839
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 14:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h4noXsM1Xd5+zXB1BO2QYilNssK3Po4+sJoDspSgBvQ=; b=QjpgVeN+5QUp8ASn
	BWwf01CjpB2eckFGay/8u6U8HHZfUYBNcRHYGxj6WUqIuxrc1CgxwrfVxLAifcAX
	gmA3ABMUSWd49qWwTYKrToR6f1t1Hbai5a1tSG9s0BjQa3VRoSya7sRHyYILKIBk
	Jmb1wUkSU+p3mRgzsYVEMBHOkh1HEwMgu5C8UlMENJqK0YEpwBZI+24SmXCTHOpa
	ZZyIzYFqI2/mrOm6ibstxDZPU2QPe/FQP/ariSUsU3LOTRjTlcD44wtB3w0cbBhm
	lIa6zxbTfAvBWfoUCGVSeJvaxLgKiHPFf+iIbEDR5Ah2oztHnyqxl8G3HVZf9iaq
	EY6ncw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgr68utu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 14:49:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1735832a12.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785336550; x=1785941350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4noXsM1Xd5+zXB1BO2QYilNssK3Po4+sJoDspSgBvQ=;
        b=Rc89InSEHdlqwEb6qJP6XfCAx0mI+cxy7z2FLUS4+RIzBu0VsUZJVgs39GoDoA1tuj
         u97x79Xs5iZL2CSTs7cWtxY1Pg3mGQYN2TjJXLaOkW63UYzCUxGARibrn3wRmXkjK095
         evETWuufpbzMH3A9/6aqOsQD0VWVfqEDeYXZ+3TZQ6LXaqhnwu5fq0nLNzK8Cdvlb+zk
         kcpPLn3+G7fJSa9DeCZ6GxJTfjIl5qusy+kFXKkhoGTtbljYs4DzX6cw/vB/t+84rccj
         2rb08LusWet8YwXJEgEVzLKdHS+eWb4w0YvxJIkmp79ut6u1AdyRt5IJgQkluMKnQhbs
         caDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336550; x=1785941350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4noXsM1Xd5+zXB1BO2QYilNssK3Po4+sJoDspSgBvQ=;
        b=h18jTFqOAV8bngTVJXG1DA4wBUH9VcoVfuwLf5i6hjqAXUj9/0g4Kvp93JItvde1DA
         mxpAheGUcUb2nnzMBrNtFep+yauTXqkWnIa2S7SzQXcBFC6t8HdRvKEE75I/BRwFOv3a
         r6JC1NeIjdLZpLztHrZXbz/HmOLZ2q38ooWl77VCdu1+qnP+d6K6nmlQdKuP/NwqHbkh
         EUkEA3AWF3pdfcB2qhSSnP31edFfsyepIalmDNAGeKJvI2v6GMV85u9DbB4xw4I7izNe
         Do8Dt0WKKryRzp18qq6lF8vvhbARWsyBxHYz6+VJ7jdz7Hk+WhB9BgOzeLO3cKYZj2W9
         Pd6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqQ0w3L1+FsWb7g9DpQS4T0vibTHbV7u595jXqcReEFaeFlh+wEe90TyD5vLSnXFtxFUuPOXQ/lupc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbTj6IweFfYW3MdxlRbFicczH9AuNTGeGunKEaEwBxdYPVO4i
	LI8Gh9dglZ5W8IowW6eDAt+PYBeDHnclKQYGL3WtpKuTdURruzIoCQkcqEhXaPGI9M0vm/tOP7E
	QxVTGCIoGUdeTpd0OTg59tJ8XttAz26LYUzrEKikszfyNTEmP/RJtPX2YLh/xQ+I=
X-Gm-Gg: AR+sD11bgf7e47PXFzTTPK84jz6m9phEGYOHf+j668Ebv3x9ODwQ3axtEyRvILlpmjC
	wbqvuljLsZrTYsvz3XOSTvfwwzgpHnYrQeUuQpqfpiX5BFsQ6tDirzO4cbSVIhi3P2201M77m8Z
	8yYGM5ujdVa8upZlQdaVXeaOIJwFhhcwBHB7euOG9oCYaVSjzBnJDm9KQTtI4TBRcE84NVOONtZ
	uoM6P27fqHGMojzddZdBq19K/lTAgUfil2NZc3zb1wuNTmNoYtb7wtwx/iGrtRdk/8V4XixyPOQ
	drF5Qeg0k/BtbIdSYdUN/bWsoDeCUbS1h972JLkUPBw5uIqbcISnUDkFIp4nERQIKVBNcBnNq6Q
	G5cm5N8707w8pTPIZDhPGYIjfyT0WTav43eA=
X-Received: by 2002:a17:902:cf4c:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2d0267c18b5mr27587705ad.30.1785336550015;
        Wed, 29 Jul 2026 07:49:10 -0700 (PDT)
X-Received: by 2002:a17:902:cf4c:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2d0267c18b5mr27587395ad.30.1785336549457;
        Wed, 29 Jul 2026 07:49:09 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm19515456eec.22.2026.07.29.07.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:49:09 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 20:18:38 +0530
Subject: [PATCH v5 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-eliza_evk-v5-3-41790a5a24de@oss.qualcomm.com>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
In-Reply-To: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785336526; l=4295;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=NSuSGrCqq1LU56by9Gr7NQIQY6WQp38yPhx2rsBxjcU=;
 b=AgBRrLbDnx+I6P1sEXGmM6GEMT0efSB/w8Lux4VUkMq3NWDJufuzmTrYrakZz/IIjeAqHQc/q
 nyr8uIrQXoGApRCQKxxCUuISSwq+/Yn2gUqAFPcTPTnlgllsKw9oLY0
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX3mEdkQFTlMy7
 OtRLPug+JxYxSwZs2bs0N4THw8+cKCc+e8i0n10l6bp986Kv2lPRPzxuoAC7otonxf/cuL0xLlF
 1Ktj5M48RJEBFtOr2dj0HiEAP0zIIX787Zv/gJYvWjzkvEI166P6vpOVwiQPzX5oEq60bY6f+fp
 CcR32QbvCV+h8o32mAS/5qn4azK8kQ1IIqBoBTyazqPXcG50jpH+Cp93ZQ02HqCbjZ/XXVMUXr+
 OyjjR4Yzg84usR/1nSSKsO6gHW3DahdYx4lLnp0LXX1auBgbZPxPspucOvNopVOfVtvlxDs589I
 CzwvJDEbTktq3H9uHVi+oLYG0XfkUj1Qd5EJr57Fdfbn6VZ5oZw9xiPXmAz5bO7PTpBt4tslgj5
 gJTszIE/AorgpBOlI4haJAuVC5xXH/GTGvxHoKacYZuHULX3jN1kJpO7khxcC3hr2/Cnra382Aq
 LwUEYnz+4HGnCdcgstg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfXzC1x63YhBcCY
 ylOVEjxAE5BV/GoeK3XYYMefGnEQJsMsezaJY369XfagNYKwoGV521y9PqOnWLzY32Xfe/HCtH2
 W3OxSxaFhytE+T2d+UTWAhIXPUmYFHo=
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=6a6a12e7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xTuWgevKKEmUOcCBws0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: vtLeINLPilA3rxOmFPmkfgZkIMfUAXiu
X-Proofpoint-GUID: vtLeINLPilA3rxOmFPmkfgZkIMfUAXiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290120

The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
PCIe switch. Enable PCIe1 and its QMP PHY nodes.

TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.

Override the base iommu-map with the expanded set covering all the
switch's downstream ports (0x1400-0x1408 SID range).

The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
from the PCIe controller.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 113 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
 2 files changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
index b35fffb50976..419e737c54e6 100644
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
+			pcie@0,0 {
+				reg = <0x50000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+
+			pcie@0,1 {
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

