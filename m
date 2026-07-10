Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA74071C5
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677482; cv=none; b=kZmIxs4uMOagAQ9FL2m1Y6rM1dP5H9llC4NaHTG5yiSmjxJ6YRACwxQNTws494nHVd2Jyi4mcfzpLikbraqvRDK1yWYksk1YLWHarNNZ9VHR2LssJHUo0jMfN8Iw1svNQ5q995clbz2pDzewx8TmD882p2tDG1e/l0gocf3U36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677482; c=relaxed/simple;
	bh=6pXYbq0cnSv0KPQPpczNz5p2DBipwsIgwwH6Bmrx3y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FobB6q4frZ1fpSccTeEzLbNnSAzoU1/LLTpKaHGjS9KiExfM/SNPZMZHEyHjvlAGzzGNe4hpLSfMlqF1k+no7so1BRLeAK6WtI7iqFVExnfQIa+gbJoXpbm30In1GLmJyo+Bi87ISCDxvIz6vK4CcFN7Elnt2HwIOX2muDe3G0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ozl487vZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WA0rlals; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ozl487vZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WA0rlals"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7eFoR190659
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Vyq56zyV3kK/hWlhQpFe9/5myCJg+mLyuzZJXrDJPQ=; b=ozl487vZanGltMn+
	QpHgalX8RBnW6jugZr+4QR1ocqaSsPjHS55sxqaiRDh/3Z5mdW+Kr1N003XRGNwY
	tZnj7UUur6r3c0NZxInCQiJAJMc4dTnbz9Wgc0/wLSidN1kwA53A5hkAiXQ6N66y
	6EtyJ6C72Ww9kQPEv3C71mwt8C+YZDoH+693GWikPE0Dlw0BaZmrnc9THC794Jiu
	uNEYTtip+GZphKsdktaSSa/T2pxeBy0zxZjVrUrqh6hsjuPz6IxHRj8dNSCE2bqM
	Z8DljmkommMI518uUh6ryj06cMuopd0ZVvdSf/T1ZC2mTS55ifRtaIbQyNtot61Q
	U4hEzw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n1as6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0d6a2f4cso7089381cf.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677472; x=1784282272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Vyq56zyV3kK/hWlhQpFe9/5myCJg+mLyuzZJXrDJPQ=;
        b=WA0rlalsrE78wUgu9Y70T8dGyKZblV4tF8kxsU8TgTNA7dhymQRmkFHqgJ/R4iOp8B
         lbpvB2/V9KhjQeKj9B8G+rxUTZwysMoUfUdu21YJBJqBpTINCuOKLJ+nvpBJt5soJsGN
         iRYl9dvRXQ8xLXNQNePqtiG8gXSBW7FbECk8Xeoh+n+O1VkPFuTPqkR6cC9bL9DWJtgm
         F5RCZr0M8Bc/8iirsrk+Xq8ZGrCEt37VAXNy8ACHCpmPxDb2yaQ575rcS1mAoX4R2sY8
         wBceAijLIub1QJiNvCQtNyuxULQC1oQNFtbV3I2yV9XMymXR7DwTHPdiMcJ7wC/tjXu6
         BIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677472; x=1784282272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Vyq56zyV3kK/hWlhQpFe9/5myCJg+mLyuzZJXrDJPQ=;
        b=bre/QJ9fUKhpvHLJeOGAjsWOWTFLNt3KQ985CQCUHGYZ3JWOIcjLL9aYX4jWRQtub9
         WTIy2VvlwVOHA36IOW/CI4O1JCpC+7wygXRIb+kgSI5wLGPiK/MBTDEHXtJHQKxCsfaS
         lbpMNnX63MiP7LMrqcyQ0MrJDjrPazSC1RxTT+TGHHKYvvor4Tk7lOgNa6wB64OBcWkt
         lCXiv4xlUvqmIPVlwjlqhlML2d/0bxTyvMz82QyxCwWgvvHz/HUzJUPw9XHN1Sj0AWOW
         D/rYVkM86J4oDCzz9qTM3q8YRSu85OJ4vof9+HThFfU9TAH185sKnsHB1c++IqXM9spe
         O9Hg==
X-Gm-Message-State: AOJu0Yz3JSbCczDBJrUPpkAmGVfrOy/e6AkF039ueIX+Vyy3momPSbXa
	6aWVJUZI7zOBNQuCPsCIFIP2T7IcEQV8aJkaHyVCaLEMJGr5q/q8VmJ60m5r6SfsLm3z3vkUfHT
	grn+JRJrxT2QrYJ1GbE42Py8wWKfkjhMyi5CKpy0cV6Ovg9cC6uM9lSQ0O8/PB3k=
X-Gm-Gg: AfdE7cmRRnC3mgyOxAOxrmm8OeKZgcSwSCHZnBf/epABSTTnCKoolPlvjZska0bAFJl
	FXbzKV5wajefGuo4C88F72+ivoKK8KHy+tHb1jyaG+Z83N9JkrJBzhm0oNXxgC4UCB9nDPVZpmK
	vm/P0mWgFZRi+j9cevKLsG7Jvyl+TJ0zyC4lhPTEpi7jnFvljt7iou+ZL+7osUBg3N4PfZuuQXH
	FedDsm3sta5SayKFodgEmq9qFDw0DnXO2e8lIEoCMzJ9aQTbv0AaoIX5z2tI9xWk1uX05SOu2pR
	wKFqPrUxrUeJX6B48X78k5dOmSzfWa87AE5v8QYLJC3Gy76Va39sxwXtuKc3iu2yRupRd8NpL0A
	OSuD9LLGEvZjc69KS9EvrvMQn3AP7G43UII68PssC7ISe55Qmng2rf3hQtAS0/0w0Gcp/CAQQfa
	NragtBueGVt6ypuIkYbtmPSG8L9ucQg4fHGSthBB8OXKg7j8z0C7nELjToF6fdO/3TyuA63EBFk
	+kaUu7BvaeSjQEo+iCP
X-Received: by 2002:a05:622a:1195:b0:51b:f40b:2fb3 with SMTP id d75a77b69052e-51c8b3ffca3mr110162161cf.9.1783677471887;
        Fri, 10 Jul 2026 02:57:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1195:b0:51b:f40b:2fb3 with SMTP id d75a77b69052e-51c8b3ffca3mr110161911cf.9.1783677471489;
        Fri, 10 Jul 2026 02:57:51 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:37 +0200
Subject: [PATCH v3 11/11] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-11-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX7UzUq+Mk1IyH
 3SUEUkwPojQRoYE8rEHY4pp8b7hIHAOmpF5RpZjLoJzcZLvrPAf8IaY7sAu8N2W8ClHWZWo9Src
 PO5B4ZOi4mlnAlTLvSWGuirMWGZmCaU=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a50c220 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 9XXLenOGy6MClepnKDMOokmix2tgwoU2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX8MYwJXfY03Rn
 QTfWv56fN/awLDVDRwKehofXFo05AmoMhtEB8oPcZEl/sqED9xKW4VEUphp1yk2chGxjq14aa+Y
 LocBePC+vWJ3vLIPixUCLINpk2YTsMYtLcmfKYoOqAOYnuZBkLfMhmas871YhrRZngGqGuQhMTI
 jB3NoM/00WszgPH/z3Wx0yXbV5fs7C2NHYOP1dcUYRE0fOQuVppnXT7Jg9uIZcE7y57M6fbvBej
 xFMAQ0EFfDG0b3V6svsOJjJ0GBQ6xovlu3uryEzX6UlH8ZknBsGuoxv/lWP6bXNrzyRIeeQI/Qe
 v59BtfUvvFtcj54GGhq8OMx0WE4/j2bZ3gUaoBCqfZ8pt9RiIFM+VZ9t8X1N9uJCEOTv2uPHpTH
 rmYjknw3rRX/h/LsS0phK5d5kn5TJKJeiTvrium/gjVKdfu6H+53G/f48ZadkGYp8rIYv11CHCk
 mU7981zvPkY71LksxlA==
X-Proofpoint-GUID: 9XXLenOGy6MClepnKDMOokmix2tgwoU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

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
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 64 +++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
index f67a554adf956696aeac2348e478dbd0b74f0e62..e3d3d68932efff494f3c7ab96d75869be24c4a94 100644
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
+					remote-endpoint = <&pcie_bridge_ep>;
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
+				pcie_bridge_ep: endpoint {
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

