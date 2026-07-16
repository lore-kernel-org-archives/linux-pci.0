Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB3E38D6BD
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218744; cv=none; b=CIjiYJCdRuZ/8Msl5Ko7utN/Iuuzfy4ew2SXUNwfH4sdv6bUvqVdp2M+VLhdnu44WwGsu6N3iBQbxpqjM5bSeH6ijmc+q6dHNTLBTij4FJ3A6B3YZ1m1uCHHSVlkmVpAnXcrSakH9kR8+HecoGdsLR8J2blTTlZdP/W7j4OgwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218744; c=relaxed/simple;
	bh=EILi4Z/HlIjZKXIC4ZrM+OocFMeGQtXeC7RenzsUUVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYA/ojMO+7cPDdjs58wHW40nMPZollXHpsvvg9HN99uqD5czW23cayEijmpMPdmkMDvUE0j6dQDEB02aqn3EwAHZYjfn6DbCE9UtamouPb2neH4kijySX7+WmrkLBNHJeXG+U8FiKx91iMjdftlSrqT2y7VEWih1AqLqdzmH8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/rtDTJD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YthqtWeP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/rtDTJD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YthqtWeP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GF4Di92811374
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A3c/IYji9aAg2mwzDYhmuLrQNs2xKPwSpSPEjBK9EwM=; b=c/rtDTJD2bBUuIJM
	hdttu0V9zXhG5WmLieds7CmF3jBFmc5tJNz1pjRl487UTSU+uw3uRYydfFzSkqhZ
	c/Czndk/hi7/yUnUcl0RfatlbRBMkd3LU8YLsZlbstfG0L9idsCR06LcWQqwuE34
	AApHWciA5NMznkYM0E58V2lGQLnnjoxY31mZdBllmQVbVX5O7F0wtM4cVBPYgKKH
	zkiaC3Ltn0qRnxvX/5/gv0RMHkuS4h0Q7jqE/ssWa9uIn/xtXID8l7poUdphyT9z
	b3pMOC1ekGaOK2yEI9UM+j/HOLBSDkyfzMaGDf2HHyiPS7Q0Ag02nAqfLySMVeh2
	2uO5aw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1m9gac7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so59053981cf.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218734; x=1784823534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3c/IYji9aAg2mwzDYhmuLrQNs2xKPwSpSPEjBK9EwM=;
        b=YthqtWePpi+QLwcmo0UlVsjHLio28YYGYWRTUPbFcYpCzMtrWEVOG3qF7y0oyT+RVF
         Hhml9PdrEUD2/KPVpuUAvJR5m9cBs8Fg4HnuEJBnqDdcSEpON+PcioPfo21uGNqUjJj2
         CSEbmGORx1v/TOXTPMqbqOPUrCTQzrkiYHmMJCP30LgvPAT/x463QPJVUiOqRdXtKgg4
         b6DtMv1DqbiDXmvbXOw4qTgvATe/E2w7UzO/QrHwyYP2wTDd+lWVFheBIvpWCDSJPsLT
         L25OVab6z/DC3nBnbJPR3h8u1eQHoOyoywI+vi0b87Y/VyBtn6n/SVMOYRTJbdOI3CsL
         pKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218734; x=1784823534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3c/IYji9aAg2mwzDYhmuLrQNs2xKPwSpSPEjBK9EwM=;
        b=W5CvLWhcZD7ODgm+ihD0S9RvWDpl0JIRUKr5UjfvFhqDWSRH7+7YKo3dzI8OiBa4vI
         k2Q9phHOhjj7I+V1BHkNwdwKhPL0C74rrQJWT52McD+CDbbHchHdHZJvCEuP7Z/+gINA
         3lMyy+3H7aqAlW0c3Wd2uU2v5gDdDvML9F7s36ow54iQ8yLAr+jnGYV4pM//l2ty2DBq
         45PA5hdA+DVvSZvwNxnYWzdqh0sxKR8/Nn4egV2y2yscKbHslZTa9hE5NQHA5oPb4yZB
         YAC/EQopa1U6nvT3goa3fxqpcwsSvjkVS2wxxgSKoHNvI/Kr/nQuDU+EDFfiX8Bsw2Go
         iasg==
X-Gm-Message-State: AOJu0YzWwIKVk1J2yPxvKZXp2zGkChU/28ZkZ6FC68VwWvDDd5j4yDH5
	9rdSGPEn1w0xkyQO9TL6rVd1PZUJNhpkuKKdjbPsEMdh2iv78fvuL3QAnPwG45kMhSWdSdoXI0K
	w9l1Bgp0Mxr4PaW6kf9KAI54rdoguvwT4W1gTOTsJRQO6HW3ceQSvNjlMiZhB3DM=
X-Gm-Gg: AfdE7cl0CxKpLaMp/bG2xAUz9LErmTL7ygzIQGq0MC8e4TTUS1lIXBmaCx9V4ApZLuS
	XDADxsSI1UR0cqvo+j2JgzL12YIoPfk+j6WZCw+v/RLbPog2ZLmbjkseBEy95RbhKMR4M/RwLNB
	WGAjyisZcCm9m8QgHAvPvbTThNJxZ7s4d7ZtYxIW/brXOwtMqAPDKlIxtnzlxcrAtSHPp0ey7Zg
	POI6FgpWtOV6jb9vVLFOCoWYmQkbju9R6V5uG1l4nLcY8Mu7hX95zgsDryTxjwCKVtnUTNYk3jF
	7Q22Vt1x9GGo8LBMjS/hEJfT4sNgEWpUjhsnEhr3VxhUMa45c8xjVBFIfRkzSWJ1Qfuy8ddF77L
	VdwzebtkXL2uS4dBGmARfzm2i1+ha2/7ThFWFZ0MAoPg92sRe7IHAqGajFpIbgRDOoQsZN6/4k5
	elJhJQPLpTqs5l/zW6YrNpqPz+MJd4fVUYAml58emV9Uw1HcUrZ5Q=
X-Received: by 2002:a05:622a:1aa1:b0:51c:c37:df31 with SMTP id d75a77b69052e-520bc709f45mr3031591cf.7.1784218733713;
        Thu, 16 Jul 2026 09:18:53 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa1:b0:51c:c37:df31 with SMTP id d75a77b69052e-520bc709f45mr3031111cf.7.1784218733144;
        Thu, 16 Jul 2026 09:18:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:49 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:28 +0200
Subject: [PATCH v4 11/11] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-11-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=IMIyzAvG c=1 sm=1 tr=0 ts=6a59046e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX11lgiX89LG9S
 l3LX5znHXjMcFYLl7BcAu/j1hH9AObu+/mLykhBE2chkvvEG4P/w8w3ZX3tikJiFcHWvSYdt9t3
 iDVq+rK7SJNY5WbMBpUZdFkpkb4KDNBCRhQz7ScoX4QyKSFJQVgus6O3f4w5M8xd48IgBoBzxNa
 5ouHu9QknGG3VyGztEUTh6QwAdYg9u1qk9HwIFkwWtTUPASxE0WFFS974YftowJDp4KLtScO8JE
 BI1P2dNJh8RxE9r6gtMDhWRfgTtHBT/lYDxffx7Jfqg6k+UlmfwnYD2SXlegc9KbHPrqVJsK+8L
 gfjXb69a5QQ7QGUji07i8ThEojBpKeFa7Z3xJFzzsPhbycIuf3tHwrqxFV/FErQli7jPmQDbNGW
 3BRK9TbV8HjBCJaY5PfltjT2cL/1GvlxatZHMhMYwU6oe1vRA5e3tgJUuy3SUW764N4Unh8vwX7
 po1bKYgxJWz7LyGgm3Q==
X-Proofpoint-GUID: seIpFqBiKjr-jHAscHYCH5anpG8N1vRv
X-Proofpoint-ORIG-GUID: seIpFqBiKjr-jHAscHYCH5anpG8N1vRv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfXzg2LeWN9UBKB
 KgPhlAudYRd0SeqmphA8PwuMewG7Dn38/R4MzZHfq0ct9DAi85Ts7LbEPU6YhZf/axoGdcVeUn3
 7XDRofp6WXMoNbhM4R575y/0byfPBk8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160166

Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
Arduino VENTUNO Q board. The module is interfaced via LGA and is
compatible with the M.2 Key E.

Add wireless-lga-connector node using pcie-m2-e-connector binding,
connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
the Bluetooth interface.

Add pcie@1,0 downstream port node with pciclass,0604 compatible so
the pci-pwrctrl driver can acquire the power sequencer and enable
the M.2 slot before PCIe enumeration.

Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
(gpio56/gpio55) used by the power sequencer.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 64 +++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
index f67a554adf956696aeac2348e478dbd0b74f0e62..5e41e637c1c705ce0f3847aa71b229261a1e3664 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -155,6 +155,40 @@ vreg_nvme: regulator-3p3-m2 {
 		enable-active-high;
 		startup-delay-us = <20000>;
 	};
+
+	wireless-lga-connector {
+		compatible = "qcom,pcie-m2-1418-lga-connector",
+			     "pcie-m2-e-connector";
+		vpcie3v3-supply = <&vdc_3v3>;
+		vpcie1v8-supply = <&vdc_1v8>;
+		w-disable1-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&nfa725b_default_state>;
+		pinctrl-names = "default";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* WiFi/PCIe */
+			port@0 {
+				reg = <0>;
+
+				lga_pcie_ep: endpoint {
+					remote-endpoint = <&pcie_ep>;
+				};
+			};
+
+			/* Bluetooth/UART */
+			port@3 {
+				reg = <3>;
+
+				lga_uart_ep: endpoint {
+					remote-endpoint = <&uart10_ep>;
+				};
+			};
+		};
+	};
 };
 
 &cci1 {
@@ -409,6 +443,22 @@ pci@0,0 {
 		ranges;
 		reg = <0x010000 0x00 0x00 0x00 0x00>;
 
+		pcie@1,0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			compatible = "pciclass,0604";
+			bus-range = <0x00 0xff>;
+			ranges;
+			reg = <0x020800 0x00 0x00 0x00 0x00>;
+
+			port {
+				pcie_ep: endpoint {
+					remote-endpoint = <&lga_pcie_ep>;
+				};
+			};
+		};
+
 		pci@2,0 {
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -501,6 +551,12 @@ max98091_default: max98091-default-state {
 		bias-pull-up;
 	};
 
+	nfa725b_default_state: nfa725b-default-state {
+		pins = "gpio55", "gpio56";
+		function = "gpio";
+		bias-disable;
+	};
+
 	pcie1_default_state: pcie1-default-state {
 		wake-pins {
 			pins = "gpio21";
@@ -544,10 +600,10 @@ &uart7 {
 &uart10 {
 	status = "okay";
 
-	bluetooth: bluetooth {
-		compatible = "qcom,qca2066-bt";
-		enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
-		clocks = <&sleep_clk>;
+	port {
+		uart10_ep: endpoint {
+			remote-endpoint = <&lga_uart_ep>;
+		};
 	};
 };
 

-- 
2.34.1

