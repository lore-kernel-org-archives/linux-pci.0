Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442190;
	b=BmlRnJsPGf3stZc2ODL5+2Wc1oIM94JEO2XeIK2D3tcZJEgquoOIPobIGtGfMd4OTtZc
	 zO12G5sY+wAZCSS6FeTCkPdz7GYNlzNbZu9yVkKF9fZzhl9L/amiXAPPGCAQ8FviDAiKv
	 r4E+cTi/k+Jlysj3+DQ/ApUQMNZK9f9YctsYPDCC4qINK37D8umvUUdfzx0L6joI23Xwx
	 xmqxltMPYvv0IcIU/ryyXV3vj8PlFuTnjmhPFrRajTkuIU0uVyLWbK4qtBspONU4vPDcS
	 zMzUwCMa40Paie4bnHGRJzJeRclLm9y4Mly10LWaC4sX3Il/wWUrAK74ue8zDmTqy8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442190;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6muZlLM33J+DBa+9pVOmRUzmFBVv5+7rsnUWPmNF+7o=;
	b=pmOCDI/TuzEh9VJOIz6XiPUpYnIjr+C0JGK0HY4mscRws4uubVi9wmxlYRFaWkUzkVQh
	 bUzNY8XTLE4+Odam44MyER9UaeFerQmh8fH8aG1G25sKx+mR3NQq7l6LnHeAOTmOn4OFv
	 3c770d9EbUQYm5vNy+OoE+7CjN27Fx4Vzu+jx+2UdhNIb9jL9CsrHfEkLRio/wRVdw/kU
	 IGFbMb92CJFA6K9MxoM1h4Z4stg6DkPLFQzMm8PSod1KV/ejsMmYU93JDyLqF4ia1L3fZ
	 dE0o25+ls5brFkE5bqPY/vss/wLHzx3GXgVCXUtCfFsVPDR0xmW3fI10K/f+kzNrapg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XU6bWoIR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PduUGB8g;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F660A5BCF
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 128F660A5BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XU6bWoIR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PduUGB8g
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLTYt446428
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6muZlLM33J+DBa+9pVOmRUzmFBVv5+7rsnUWPmNF+7o=; b=XU6bWoIRNoP/hn/X
	/1yyiYzYxgc+ZrU4eTUh67MIg+w7+VEbkPRbtAqBZi4gb2bkXZAMej6aDoqHoMNg
	wNJmfgkORkyQghNOTxO1Bz7clI450BguHS6qRBPLhaZuPH133rUs6BTJl7CHPO3j
	kD4HoxQKBSnPDUSQ5uw+TzkSlq6aCL70qLl9hSZhpkXUNKYagYNpaF9k6D0aXTYH
	RkrniMdgILlRqrYxFMvqII9sRcblCjFR6ov+kHuZiJFpsq28FfEbVUb8KTq9jLJP
	oDH88enNzRWcA60+zXhVFikQHrQ5OwlJuhNz3mhBVVSzdw4zQSrQCMRYhzQ8aPz2
	y7pgHw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g741n9r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-94960131b4eso620700885a.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 05:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442187; x=1796046987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6muZlLM33J+DBa+9pVOmRUzmFBVv5+7rsnUWPmNF+7o=;
        b=PduUGB8gi9U4YVrDNo4fys1U68+xUVSE9UgLVYPmSQD6FnMggjiyfOttyMb4toYkbT
         WnVtV/yNsuGcUG6Rm4mxt/RGStPCsxFHOS4FcmTusmE7cZsTt3QuST/vpra6x0KxHeSR
         lqpY1lSwNCg7mGyfHW7cxBHU2fXgx1RP0drFXKxQ5wNd6LNzLEWsBILp9FIiiKOSnd+D
         mEPAoaLSPw7XqOzVnbCtIhsBbe2Mv1iYyeBsGe3JvRelldQJtQl4imYBU99YoFbu4zWk
         HQHZuZVX0PaDmpI4ao91w9WRZXO7gzblnKMsUX7fyd6g9Ys6K6yE71IBAZxerzAXCyPc
         nEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442187; x=1796046987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6muZlLM33J+DBa+9pVOmRUzmFBVv5+7rsnUWPmNF+7o=;
        b=zTucaHzm0eeTGlSjpMidl93GkAulHjXH4n+MHrmofBYVsq1VqZJnAklwA7lU/YfI/Y
         dg88IrfvOl8Uq9GSREi5mTzq2N6JdVu50njBPvQ3Tv0VxA7vrDDFLPNKmJ1eL6b2LLMC
         WnjYsB8vMNiUFkBUcDxXi6qLWQeHkrj88t5jCSQ8ZM6CLX2vfHoLRrWn9P6ct229Y4pb
         N5skZZNyd+UI7ZtFNrxwyZci5qRKtWAj4LvjjovKV6hHCfRZrUZepdb8ELkn7aQLomyR
         +AHzVxME7PiUWGJ68aqU4KMNCx9rd8s3Wfj2pnb8q/SvoH6euWoRtkF3MFcoHFU2UcHk
         tP/A==
X-Gm-Message-State: APuU4Z+9EXKb+VV/VT+1zHw75lsFDrQOOpjVOpqIpSOrq6Q9O4fCUV0a
	n1BaS0bnZKoMI2BnivfNelaE7dCRsSOh3nI6HOSwqSuBfy8fQwJy8U8JCk048oWWaxXEGsdSSlW
	Uo5il9F2UlCEpJIdLVoWV026X5rpkA026OH21+dZ/9l275sMYh/SBnD3xTme7hP0=
X-Gm-Gg: AZFdTZdT/cX9lqwiPFflRlBe40HF2LKBVT2LYaiP8MLtDxsrNFso2una0E09GCHNI2w
	jxWmorn88/wsB83OI22WomCvDrTe7Pd7ugVwI/VM6uF2lGSYnETLWvkhnZDRWk4H5VNxAmZGdob
	gdbs3LU5hL7YJxHEjSSqFmltZ1ARUqnBXqU1eOh7pjXMBi6Xf/iVTGOoznRcKtidg6FxrEfbwn/
	yRHi3jIt707Xt2TOdv9IeMEGWBfjkGg5/eagcNEHIZl6Ual3YG7WRQ0PIL7aogGllIuSkuT8TE7
	p180o7Ch7zpnNGgzcbKkQu7FbLeJHHQL8uqA3FcyYpwn2NMBvv4dNFar5FdTG1PbgJ3JOFlH6Y8
	ifkNfX7Or+jo6cnf0FKmMPO4aM5viw/XIfI3XAnQHs/s/urTTDkJ/dr6Ews2qEdm5BtxaIrL0/x
	wHrWJ0Ue7BeZE1MYAxJ35Q36e8BKWUEXSoZbhkmK52bPPXK1arxbL/TJgZJL+xaLBn/8SmVI56i
	BXOzZfbVp+BgStqXHPS+WIECar7
X-Received: by 2002:a05:620a:2995:b0:93c:7040:bf7b with SMTP id af79cd13be357-949ba827c54mr1899041485a.9.1795442187426;
        Mon, 23 Nov 2026 05:56:27 -0800 (PST)
X-Received: by 2002:a05:620a:2995:b0:93c:7040:bf7b with SMTP id af79cd13be357-949ba827c54mr1899036685a.9.1795442186934;
        Mon, 23 Nov 2026 05:56:26 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:26 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:15 +0100
Subject: [PATCH v9 8/8] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-monza-wireless-v9-8-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: hO6I1NI-PNs3frw2VEcoaUTRRCqGQcRn
X-Proofpoint-ORIG-GUID: hO6I1NI-PNs3frw2VEcoaUTRRCqGQcRn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX+bOCXs420qXp
 yOV7QnUrzZQjIkxuee1LfLBQLbj3FaAOucAKpEZcnMuydYm9aQkyfbQhgPkYv8qet2xm20xLCNr
 OG/kmtVB52CBqJdzpMehqwJjGKq7kWY=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b04460c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfXwJ4BS2QRPKuf
 hVtILqzlT5LBZojsROE4wsR5Us7p69123KMY83NzxUbPpxztqiLfjJkG5qH+s8hbRNKZJnMeTQY
 hb5EKwoURQCi3N6SqPYOByP0aezhWrj50POKFCZVMrEIyVB5e6p2zP25Q9JGsxWWMG7JZmCubCj
 Xq1sBPjJyLIywdFStJyfh9YrPJs059l+8jtZptMPUCnbhtOXzt+v6XVZNJAQFMAEzU686Kib/J/
 OezEoovv1dm4ybV5wfm+benJ2Y25UwzAAWwM3DHMr0vVAO1Yg4go9la6PxatLU4ihpXIgs9KrOH
 FUrZnJ5gX5dPZjk6s4dy0amv9sTT2HVYvlg+ul5x4D80LZv8wCLyUDj+K4Ik651JOfxSnus/p7/
 K6v5wKbULXpK8q2KwhHlbfhKZY97VGw6AJTqq8tKJuccV9bem3tpbk7O01e9rvb5zy3CHCkwA17
 /B+ZtpLFz2F40N/+W7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 64 +++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
index 940a03732eefc49280b4182101cf3fb9ee951053..f24a87bd7cbf63bda803161f3659b0538a5ee35a 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -178,6 +178,40 @@ vreg_nvme: regulator-3p3-m2 {
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
@@ -541,6 +575,22 @@ pcie@0,0 {
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
 		pcie@2,0 {
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -694,6 +744,12 @@ max98091_default: max98091-default-state {
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
@@ -745,10 +801,10 @@ &uart7 {
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

