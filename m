Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961FB3A960F
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386968; cv=none; b=e+qpE51hRKnGtWveYdHbL92RrNVx2TDgi3JtPQ5fUHfVI+OHX0/pohN04tWZfGULp+ESMvkSX6fr8HOG3YLJWXXisVacSwbtY9xYznCveGQsiiYfimRFeHCrK4gpgZ8KFvP5heMqT5mqh1A/eQ5/2DawcHMJFuRR0LawbCt8PX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386968; c=relaxed/simple;
	bh=xRvX4C1MLDNeabWWOraVYq1lOeHEO2kDMcvyddoS6Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yhf2brG4YcSmF6DyKFgWGtEPZWwpylNobaRkFAGI51iegRfHeTeKbn+LNtmlWWbu3DSLTDY+bf7V7KiB4iTUZ9bW6Qx+6l9UakFVjIwWb4f+Wq1jigEF4ZeWF/jUicQp3i4mqdlF6AwJF+Gdk58Q3qiAL+MZtSz3hy7JrjIEdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hX6pj2sN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W35CIr2g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hX6pj2sN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W35CIr2g"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U4ktX43978078
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 04:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P3Z3wys6yl1RdfpZu+o6Am4NfC2qD7iJbwimZM6YAyo=; b=hX6pj2sNe5NFkUE7
	q1xPicelvFLYLykWPcxozb6+Oc846166aBR7a9XsEII/NTNxlrgLecsxbiwrUkTN
	oLGjIJ7xK0+Gc1Xtkx0oSZTfSwl3oIHcsGfpUIW+IdnMh6UUADfIg6IWdnxOdcCz
	T6f3Gk6O3KdKg8buKy2Akd/hou9OeaBdDoZSzO3OMeyYjEldn989N5uMXDeiIZXU
	nUbtdQ6ljlGvHtFwcDCNJXuZARF/XqVNo0uFDo0E1n6ISXMzNUbCJIBDVOtqlH8y
	srYjHHI0Ax5c7dOdGfLhwBvXTJHhsScyiVRA2VgH7qXKlE9D6Uer/0xLoQQ1B3Vm
	1z70fA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqyvxr0a9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 04:49:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38827cee19eso2160679a91.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 21:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785386964; x=1785991764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P3Z3wys6yl1RdfpZu+o6Am4NfC2qD7iJbwimZM6YAyo=;
        b=W35CIr2g3NN4LflyP7CUSPS4D3GKx0V4VMoy1MTqnLFuwTS0tTO88fF2lHIMt/6+n6
         Akqa70v8FpbOpgG7kLBw/tPyW4FkY2/IEhPdN4h4l6yptVfgCd5n/mjntT3N2nT3hXII
         hSN7+12Tj6dItNFt1iiV0ZSvmlKokW12VslUA2gyHWGqjiRTirSQqRZH0LclYVyjm5m9
         cqCE9xDsX8P/z4s+27GF/6Xnw2bh1Dt5YKVQ1I8lAlknyxGy8f+DsXf1LtwmvYegSSVD
         r9F5/Vt12SHsg7fFarU8vWS+AnKnM5tfaTGNKP2yFxBk+FAHV2TpTwKg9lw0Dwm2Uab/
         3vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785386964; x=1785991764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P3Z3wys6yl1RdfpZu+o6Am4NfC2qD7iJbwimZM6YAyo=;
        b=lulfqHFWidKgtKWbirNgxzurGaiEGSSiDus67NERj1BtG4ll1cPUmaRd0+i9MPJ7iF
         LCvzbmYBpVnlgLZE1/LCUEYS3z023h8wF133k//m++Mw7BU9JO//nZGWZecECyg6AojM
         8zV0SXVnzHCtzKNueFqfxl9osZYvNxch6NjtFjZRnNrWKT9ggT61ICv+G5asIvrm6cMa
         Vq3XNNSMQMyyDJg01zNoBG08M7gbJCNFPwS9r4kjEI5XKvH8m25LgWyDd7Op/GE+Egxb
         9RqF+Z9y3ivZBSyE8CvUTp2UdzS1H5uBm0utIgc3UkgeRl/YAiV4v5l087J7IizAcFAF
         p0Qg==
X-Forwarded-Encrypted: i=1; AHgh+RpzBRm5ThVrf9sc1Id0srkgJJLsFomMMAZrqLDl+UcyI/ACyGAmcY/PsACzp4Ovg0Z1W5LJHxEfmkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFoVbttYPsWlWtG6a9I+hlcHAc+c26Me0HTt+Ygiai91WRqXO5
	ZgTMVwbFS9kAgX4bBVlhX9mNn2fyFQaffrtQKhETVwfiAzlqOYCfcx/ELQwGG4nQCNawPt863ZU
	/LBSIDT32xTUw71TqqzKB+xDB0OAYzp8m1uOEoDP5MxHJcqbpIYfVitiT6XLPrhFR1Dz4uK0=
X-Gm-Gg: AR+sD13pzcWa++gUaH4GPAVFmNdTVpCMRuZ6wfJzoSxWuV7vQL/KKAFdUI0VjKznD8C
	5Oe8RfndH+E5PqDev2zPVzytMb2wp1NysRAbc7TrXLMFLAHI9ncG9TGQS50k/VQREOnsjdRY60a
	qZDtSGy8XZZf/gAekzXfgPKkzOZqV7Hoof0bAB6heF+Wuytr1zxCAhOA0JgY6UwJYVkaXTDRmLc
	eb/PgM+crq3BHccZKofDUyEl9vcenBGPsjfrWKTO9OTfwwpRUF/V/FZZ6qk7eoDb2MNCaH/sm5w
	Nt6Hj7TInskqhlFcz7awq4Ib+FFPjKD2nK23FlKU+AgPhYt1cxVUZBZHYkJjjZb9gqB0c3lJk8z
	wZMkI+6N/N9yeregHhXJCIn3eM2ezWNf7hoo=
X-Received: by 2002:a17:90b:4487:b0:387:e0cb:c8da with SMTP id 98e67ed59e1d1-38f9c05e928mr842174a91.35.1785386964430;
        Wed, 29 Jul 2026 21:49:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4487:b0:387:e0cb:c8da with SMTP id 98e67ed59e1d1-38f9c05e928mr842150a91.35.1785386963954;
        Wed, 29 Jul 2026 21:49:23 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm17740241eec.14.2026.07.29.21.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:49:23 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 10:18:55 +0530
Subject: [PATCH v6 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-eliza_evk-v6-3-40ece2d33114@oss.qualcomm.com>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
In-Reply-To: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785386943; l=3929;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=xRvX4C1MLDNeabWWOraVYq1lOeHEO2kDMcvyddoS6Mc=;
 b=ZXdfrRJ1qSVHT54S1wu6IW0qgZORh00leh/BRLSc6+nRRn89zk0rYmVzD3qywqSvRyRmaLKKL
 Gy76euuD/sHAjZPo2IyN4X1rkeCGijHbSDc25Tmk6L0D56szlRJcWxc
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=c7ubhx9l c=1 sm=1 tr=0 ts=6a6ad7d5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAyOSBTYWx0ZWRfX2UXMkGxLgh3y
 lc9/JUHJwSh6Mzx0Dx4hxmSp7bBI7W2kaFzpw6tIYjC8/Khb6O5IG7GJlvMpvgVhL0dvpM+jaj/
 uQ8qVhoZdXSFt0yfgSQyuHTaaubKCk4=
X-Proofpoint-ORIG-GUID: F3s8GpYufLtsM4_L7auHEKUAEvR3cnt2
X-Proofpoint-GUID: F3s8GpYufLtsM4_L7auHEKUAEvR3cnt2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAyOSBTYWx0ZWRfXwYYA3iH97A+s
 c7r3N8MN0wQamqSUY3MTj/bpyc4RT6GdXA1D0e6tetcNxVt0fRgSsuQPwCRt953BmzKkfpRfxyB
 lzVQ1DNixFqBApSHnPqfLslU757SGQuUIktqxZ5dzmE6D+g0LpJysnVygXKqpdwwlQsFWhB1aWz
 wbaOspPKE5ueu436UxspL82G95DMDSDPE/nsGygoto8i259F4QE2lJgKNGg+XIjeUb0b9jhNtV2
 nrENIz/PnBvDWs8lZSCd1b4rVt5AXK453kz2novDk7ynxdA2hD1Uc4byE0W1qUU8qv2LX6d7tp/
 3Ct85zCAo2AZu+coFI49ANtBDEbfvyp/s7OxdMjjVyy0MviZiZWXYskQb1aSf9ouFSH0ZyNGBRs
 GVFgz0uSwx+O8eMdYvnQBS2vaqokjrptaHT7HxGdP3WIzvRCIekZVilaLAsM9p/0v6mOjbGe2NA
 yHk7qkkNPu4HGP5Djjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300029

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
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 113 ++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

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
 

-- 
2.34.1

