Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482FD3E00BD
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582195; cv=none; b=HFUupotUIHoUPCtfCF0PkdGk58YApGVYgcXLBYHXGyMYO/3dao1NkewHUkUOEU3HMYXQC+Qq7oZ4pGXLLAsXQ8Jqg+2mOz/5/lpazAiSrq/uKqemCwiKoHVmRW/fOAl3qRmC+CPQhxY8ACjLsv5GKuaxDOZjRvj5UE/7NbLeyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582195; c=relaxed/simple;
	bh=ti18E3whOjj3E/clAE26Ilsl5ydBCy/MZpD7NC2EUk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dA2TsFajbe88fYHl/0r5nVu3gkwz8AHIFSQESVFwlAN4kWpEdwEc3cipCUyx371gMuRM74GTWNPW7UrQVHuhC7nFiZ0MtXrMxG3FeKqje033onLiaS4yTyqpFn1bMSHnW6Lcfi/z4dPxEnGL4h4fL/4iLpqzq1apwFDOJk0LPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=btsOzL5j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EDyt7AT+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="btsOzL5j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EDyt7AT+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960Ia5972678
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 07:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vScidbHly171Kf0BpSO9ox3SUP4FemmOhWhhk06koyM=; b=btsOzL5j3LfvjMji
	9np+rj9bTGs6uDp/e4zKFJE+05qLgcNptS9W1STcFqAwdIWamzMdZSWR6IDLzt9T
	tPrsrvG7uYA3aOrsLVGy8LlggCGJoE6jZ97300rvTFwJmYFCs0j+0S6LCnwMi7Lc
	o4mFG6OeBf7EY/cInoM0e9MRFqEybw3zUQCTYse/ABDVW2bjLv2ekP8WLn/vSpZ8
	SM1FkeeDo4EFfB/fr7n93B/g2uXv7v2fQ8svShIvN9nzwPAM8Pzsvs+Ed4UHWo0O
	i9knQqzCSekiQH+xmoYNV1HcjzaEaqaZ3MTuQJDMv2kCSL9B1Ztjso8xh76IaaD6
	uRRMiw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vtdsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 07:29:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8477d84264bso438459b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783582190; x=1784186990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vScidbHly171Kf0BpSO9ox3SUP4FemmOhWhhk06koyM=;
        b=EDyt7AT+PB0rNikDNFg5tcb3hFxWrEsSQmEQz3LLVHW5a9AuLVgyOhA2Qf3KilAlxB
         dKZ9rd4oaFlZEVSBl9yvByEkYm6P11DLHloBncBWMtH7WsPyF0EyutYZvVXRvmWdZ6je
         94WHTX96MQ5ONgHUB/m03xnECZtnSkEhrQRSMNcCVg4YeY/XVv6Qqizhexza2O9DTm7Q
         gw0q6yRrH48kOGlMi7RQzWjQtYo+kORdShdYiwzn4EQlaz2hbLR3Gk2Pd7lZGSGavT6a
         0693v4E21ElI6Z8m50mOCDHxC/3AyPOE1RdbgzeASh/CtEpg32n908OykRMWOtxaCMIS
         ulUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582190; x=1784186990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vScidbHly171Kf0BpSO9ox3SUP4FemmOhWhhk06koyM=;
        b=ct+vu7jL/6UwgOagZvi8lcBOeNapQ/szpVZcV/KjMvbWO7yjJqdQk6iEzgf9TWnqih
         JAcojxeZY/0mx9EtShN4+1OItW4ADSWUeBR/n/005ZhduvKx2Fc1bEXuTQjBXQOS3oP3
         voFgPs2SuCUlnz1DP+L712pTOme8Qh63fNCbefuNn88puEULpzbYznpUXmloMOQ0o5fw
         8p5txsGutfI9+uhjfq/XgcF7LkfH1Jf6tkub4MPYM9SioRrB08iWrupqMGMgfjGRJZKX
         /mZpLhJGyRql4SQehSy13ComsQb4aGd8tZ5CzE1jz6miqDvtX4nF/Nvq5OjuC5r4LwPi
         vsOg==
X-Forwarded-Encrypted: i=1; AHgh+RqVCDvooYTa/eSpQnnOnpHBRaFkz+9L+elwlPWA0NTISsVlIZb/6iNsrqBlyQ6YNGVA8U8s5gY4cVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4GjiPO6IpK8frMaKnEj/OhLZtGkN/vnfOijUAm1n2D7TSvXQ
	wqF7Tn0LqZ03NWBjev/uV0YAPqIp9m/03W2o6lxQBFhSiyAe5AQlMN4UvrpvEa3AGXUf11J1PkE
	zLRULeYn54NRVAodB5mo/Qv6oL4kaNDgPabiGzoxPJc63oB1rN1Pla+aqc0uhMeo=
X-Gm-Gg: AfdE7cmF/yktZmDja/JGT0TXkQRUqno3fMSF3qvAtpf0xUXpe7UeXU3lUShVH5MWYt5
	vlpX4iOXMPmhyiDTkfMcCQaC8YcVxCZgeHUOq919AvGSTRpMaIND+HOBTYi6pU4SjYJQlTm/mR7
	Dgto5IilHstnIp8H3GTSIrqjLmL0Ewep7m0xBeuAkxgOZffa2y/3O9FrAA2igK1IFjG5+IITuO3
	UXUkgpfBt/o2I1EMetCaXieyCWnF+rz2/4C019d1uAJ8/mNNMiZLDldRDt8Z0lDFf9XSVQyTt7x
	EiY0yQ1Bx+NpLKJ/tOfkL/RVw4/3phHiMdGHLLn8aLUJgaa4P/rRs4bpjhgW00/xbySjg/CeduJ
	jtLrqQWQy/5+ivv1M3E/3LcqAIaHicBJwuWLskiQe0o7A8/17yfhdJp0MNojz3A==
X-Received: by 2002:a05:6a00:a0c:b0:842:3932:71cb with SMTP id d2e1a72fcca58-84855fe8b89mr1634934b3a.4.1783582189779;
        Thu, 09 Jul 2026 00:29:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0c:b0:842:3932:71cb with SMTP id d2e1a72fcca58-84855fe8b89mr1634921b3a.4.1783582189335;
        Thu, 09 Jul 2026 00:29:49 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d44d53sm8167222b3a.38.2026.07.09.00.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:29:48 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 12:59:40 +0530
Subject: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2
 Key E connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>,
        mengshi.wu@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Gmoz8wyBtJrTceu6XDUKRkLuHml2UmtR
X-Proofpoint-ORIG-GUID: Gmoz8wyBtJrTceu6XDUKRkLuHml2UmtR
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4f4dee cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6xwnDyfGkisnSeZ8xU8A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfXwkDe6Brw1lpb
 zahkSgb6is0IBhIZyz7o+jhTguW+S5E9QXR8+NGFTwrebZEdpwm5wqApJueNuz7LdU2JOOIa85o
 dgctayeQw4gNupHrY3bl/mQl0dNUOEq+LRo/UEqAAOTmgvVBjkBom0tM8YoSOF3FIDHZVsjbEdB
 SedJrNMPwIrNbjBk2gDfcZPZTJrk2joVoNCr/cRVIHbb9tMOZJT0aQ2Bu5HyAHGbDwfJjohzE56
 czm13g1tMt4LxS2dMDau+3LmKRCw0rEvB+r4GFeGHR0CuaZRtN2gHdou33pHygoaxpJUMy/7LpD
 5/yqBrRo13CVprNRyN1ojjedWDjN4vuBdvAI8j7ACjyagOdM8JVK2BazslUMSjjOv6lOd69pEGa
 m464LiRTof0UJWQ9yIU6Irrj9eR3JfZgVMkOMiGk6nWsYeEK1t0e/r12qS3yaEtzkFesn4AXR3V
 KVtKCfuoduL9CI0y1+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfX3PBYcF3VDAeK
 7IlPueMe2z1MGbjNmGrBp4jAz6XbhsaqecwkUvgXqQMIsHDfNcU3VXa41DGYGGaeWI2hZ/ptyh0
 AxDQf37/R2l+gfRXF+jjdOKDUZsMLpk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090069

The hamoa IoT EVK has the PCIe M.2 Mechanical Key E connector to
connect wireless connectivity cards over PCIe and UART interfaces.
Hence, describe the connector node, link it with the PCIe 4 Root Port
node and replace the static BT serdev under UART14 and the
chip-specific wifi@0 child node with graph port/endpoints, allowing
the pwrseq-pcie-m2 driver to power the card and dynamically create
the BT serdev device.

The M.2 Key E connector is powered by vreg_wcn_3p3. WLAN enable is
controlled via W_DISABLE1# (GPIO117) and BT enable via W_DISABLE2#
(GPIO116), both described as active-low GPIOs on the connector node.

Remove the chip-specific wcn7850-pmu node as the M.2 connector
approach replaces the WCN7850-specific power sequencing with a
chip-agnostic one managed by the pwrseq-pcie-m2 driver.

Also add 'compatible = "pciclass,0604"' to pcie4_port0 in hamoa.dtsi
to allow the PCI subsystem to associate the DT node with the
PCI-to-PCI bridge device.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 129 ++++++++++-------------------
 arch/arm64/boot/dts/qcom/hamoa.dtsi        |   1 +
 2 files changed, 47 insertions(+), 83 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 9fa86bb6438e..41c2004f0ef6 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -68,6 +68,44 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&vreg_wcn_3p3>;
+
+		w-disable1-gpios = <&tlmm 117 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&tlmm 116 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&wcn_wlan_en>, <&wcn_bt_en>;
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
+					remote-endpoint = <&pcie4port0_ep>;
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
+					remote-endpoint = <&uart14_ep>;
+				};
+			};
+		};
+	};
+
 	connector3 {
 		compatible = "usb-a-connector";
 		label = "USB-3-Type-A";
@@ -676,65 +714,6 @@ usb_1_ss0_sbu_mux: endpoint {
 			};
 		};
 	};
-
-	wcn7850-pmu {
-		compatible = "qcom,wcn7850-pmu";
-
-		vdd-supply = <&vreg_wcn_0p95>;
-		vddio-supply = <&vreg_l15b_1p8>;
-		vddaon-supply = <&vreg_wcn_0p95>;
-		vdddig-supply = <&vreg_wcn_0p95>;
-		vddrfa1p2-supply = <&vreg_wcn_1p9>;
-		vddrfa1p8-supply = <&vreg_wcn_1p9>;
-
-		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
-		wlan-enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
-
-		pinctrl-0 = <&wcn_bt_en>, <&wcn_wlan_en>;
-		pinctrl-names = "default";
-
-		regulators {
-			vreg_pmu_rfa_cmn: ldo0 {
-				regulator-name = "vreg_pmu_rfa_cmn";
-			};
-
-			vreg_pmu_aon_0p59: ldo1 {
-				regulator-name = "vreg_pmu_aon_0p59";
-			};
-
-			vreg_pmu_wlcx_0p8: ldo2 {
-				regulator-name = "vreg_pmu_wlcx_0p8";
-			};
-
-			vreg_pmu_wlmx_0p85: ldo3 {
-				regulator-name = "vreg_pmu_wlmx_0p85";
-			};
-
-			vreg_pmu_btcmx_0p85: ldo4 {
-				regulator-name = "vreg_pmu_btcmx_0p85";
-			};
-
-			vreg_pmu_rfa_0p8: ldo5 {
-				regulator-name = "vreg_pmu_rfa_0p8";
-			};
-
-			vreg_pmu_rfa_1p2: ldo6 {
-				regulator-name = "vreg_pmu_rfa_1p2";
-			};
-
-			vreg_pmu_rfa_1p8: ldo7 {
-				regulator-name = "vreg_pmu_rfa_1p8";
-			};
-
-			vreg_pmu_pcie_0p9: ldo8 {
-				regulator-name = "vreg_pmu_pcie_0p9";
-			};
-
-			vreg_pmu_pcie_1p8: ldo9 {
-				regulator-name = "vreg_pmu_pcie_1p8";
-			};
-		};
-	};
 };
 
 &i2c1 {
@@ -1025,19 +1004,10 @@ &pcie4_port0 {
 	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
 
-	wifi@0 {
-		compatible = "pci17cb,1107";
-		reg = <0x10000 0x0 0x0 0x0 0x0>;
-
-		vddaon-supply = <&vreg_pmu_aon_0p59>;
-		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
-		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
-		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
-		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
-		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
-		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
-		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
-		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+	port {
+		pcie4port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
 	};
 };
 
@@ -1531,17 +1501,10 @@ wcn_usb_sw_n: wcn-usb-sw-n-state {
 &uart14 {
 	status = "okay";
 
-	bluetooth {
-		compatible = "qcom,wcn7850-bt";
-		max-speed = <3200000>;
-
-		vddaon-supply = <&vreg_pmu_aon_0p59>;
-		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
-		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
-		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
-		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
-		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
-		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+	port {
+		uart14_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 60f485a4892e..566a6b4c6208 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -3776,6 +3776,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 
 			pcie4_port0: pcie@0 {
 				device_type = "pci";
+				compatible = "pciclass,0604";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
 

-- 
2.34.1

