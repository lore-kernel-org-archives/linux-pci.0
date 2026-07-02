Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DE3BBFC1
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989201; cv=none; b=gP7x2ERgBQNasj6qJqE66E2CG+AoW2f6qNQ56p/j+fVV2Ebr4BxiBlGsCjgLtmEgYDJ4OdooZv+uJg8TnouMRUsXdqwkOBORIHGNXhTAJVgV+um0IpUsHThs9gG/j6vOc/1aO380Md98TyzDU5r8z7KRk1SKVlYmO2v8vBu2/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989201; c=relaxed/simple;
	bh=3DSVzwIlnQfv+D7lfNEK0mAhgs9cSZ6PohGta8ETunw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vyv9bQ0KmvQujQoTguBGawtexgcD7zEs9NWcyIWM9T2WkwNpRBjsZ9HfZsuSc3DOSuMsYlKrFAg9lcgZU6zOfEtu1H6ZX9yQes1jJwWF3DaTSKlQ96UDdVcW4VJiEN9AS2cw1VJkeOpl/Ey2v/ExHLA2yK9EHTnqhPQHl7u02fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T4ItMzV4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcHrN8bf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T4ItMzV4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcHrN8bf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629KJ3Q4115130
	for <linux-pci@vger.kernel.org>; Thu, 2 Jul 2026 10:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wa7zNeg/NowcWs39grlG3DDJYgS0nuGoGJSwyYi+7Oo=; b=T4ItMzV4QpaTtcBx
	XsVrhIVkfIpAIf5yUx+JRAUEB2piepvOZfe4XDKmVQxNjAPWFesCq4qSmt9KLGw5
	vqQhsBW1Kc7XW3WE/IP2o9jc8N+svf3miupUWM7ZoOhxdM/YoDFpRrAJ7xRJznhl
	4rpkL/EgCj5BDT41MBHUADyfLGSZoWJvHiqd7Sao9BIELkkQPpK5CYeSrj9RUTrc
	MQb8fJXzlvz270zHmi2onpJqZlTKIDB5il+7Ls1cu80idVKSt9SzNnE92QOzfhRY
	BQ2m9iq7wN5JPksKS4U/DjyqCoX7TjP2vYsv8d3tVHqFaXYi5KQJhKuvbFn5F+Fn
	y1jTgw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n940a50-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 10:46:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92ac0a54110so217307685a.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989197; x=1783593997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wa7zNeg/NowcWs39grlG3DDJYgS0nuGoGJSwyYi+7Oo=;
        b=UcHrN8bfSR6RgK9NtvaXhvHVROBc/o13hdfG5xmWpUATvmV5xu8/VcqU779U2Aafgw
         yd8y+fIxiSE200ohu0SaFY1bC93gwnxLonGvue2NH7yiAjdVKtNxwBi9BCEFkoLHatcC
         Gic6np0+8IP1RBZLPbEceYlRZL1dT/EpaG+fih2mOYNW9hPuwAVF/NRoNTjE9GIDFhFY
         W7sv5+c9G1KQUduFfv+Z2iZ4JOTXsFtQOtE3z9Yh/p2f6P6ODNudhRbChsGASYJ2aEhk
         CstwZuIo5HfSJxUFNKZfpWA3UazwmDabpgDZ80u2H9sQ+l1+uXZEN1mJqhIhPfRAvAYm
         nhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989197; x=1783593997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wa7zNeg/NowcWs39grlG3DDJYgS0nuGoGJSwyYi+7Oo=;
        b=Nxtg9HWZdT2IK9R1s6BHlbfRGIjpYpv5uQaQT8fyz5jhGZxIS3L/pvYLw4LE0F8dmU
         tnjvGKrNxGyif32fdG2qXTRc+yBYkw45gvps9sBfRKNn/mCe01ht0al9n4rbPOdR+dR7
         njpKFqpJEDJPwyHZFiMG/RFt37Xiq2KWvE37SsGeL79ppYdtCM9cx3NBOo11IZTiy4IW
         YSE9msMTUWRAezu9jbKYaIr87GLYoFrC1MDgbwTrHyyin/O/PQVqI1YS58jLzRGGTfJT
         Xm/THTwdUEv7gQBcHNNIGZHvBgKHJhQtq6pg+x6y+M47FpUyz7eZYRhddgY0dhwtMycV
         q1Cw==
X-Gm-Message-State: AOJu0YzkFAyv6oV9MDO4AXsQctXuIq65es02b+U3TMLPJysg8SCnk+5/
	XjqBOdaTFdQirSjfzDkdWsROo4URDgplEloJYoK1mVicKXhcsuEuHzZqAdaNELwO9wsko4ZKGOI
	8uxfaBZqz1lGpDaZvVUa8MZGAvs4nYhpjzMxkXnmqMQt6iu8QRsZAhj6xB2myd+M=
X-Gm-Gg: AfdE7ckF90p+Z4b5DCDgLTw7UIst2kl1mbvwuiMsLp9RQzV4pxvZTMZEqSXH5o82mJF
	msAGZP5ILEzNFftrvWCgqy4cJbRqXumfjeGqH1xMLLoMmVKSIr/uAjGpXvuz7lG3luv4xyQZnIr
	7NEMtDXxbG016P6C37h3YSc0rihVF1cQY6pPviztnydQDMX8iGfwdLcPPcK0I6NVrwTzmFJDXeK
	splb8ZuB0hJc0HtzBS7mIsby/+8qmQNzXYy0nGmrEpWHIpqi6hgNXICgXJlhMGY9p/h0tav/NGI
	Vt5MMlenEfGwOddHfaZoTNf2hRNu+oyivstccrcXkgd99ZpLapr5RyftbQiCE3Y+S4flsyKOkgG
	P7zuElZaj6vF8wAOHG/9Hbtc7ZWZXZTCDKk3MqrmsBCAquo5vU+QHIGNI1S81GYLponoZxVdNpm
	5KipquDGbIVCLwzZUjoqF7/NCk35Oa4zTKp1UYGWhGwumcg305kSTdK/XQGkL1zsg=
X-Received: by 2002:a05:620a:444f:b0:92e:5610:e479 with SMTP id af79cd13be357-92e784db52fmr656336685a.52.1782989196872;
        Thu, 02 Jul 2026 03:46:36 -0700 (PDT)
X-Received: by 2002:a05:620a:444f:b0:92e:5610:e479 with SMTP id af79cd13be357-92e784db52fmr656332885a.52.1782989196333;
        Thu, 02 Jul 2026 03:46:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b5ae4959sm109689666b.0.2026.07.02.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:46:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 12:46:16 +0200
Subject: [PATCH v2 4/4] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-monza-wireless-v2-4-7b56e2a6a6d4@oss.qualcomm.com>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
In-Reply-To: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX/fRc8VEvvBMG
 IdWfkQCa61q/mNDMEL1+5co2XwexIel++YERlvIcuNo7HlHYJR6zIfzSrAYAUKsCdwikj2wYxH6
 m5wEXOAbOxWOMQBLprXQBPWqjtIVwjo0qqja0OyXnFazkgH0fwYkDaCymVhml2biIqo+PSdktmZ
 ISNvhKEcXBVw4tuLZX5PCnxCk+YcUWi0t+fxcMI/H6uWILIJbyK+6Jn69hkGiC5SqXNkIhnHQsJ
 nx++5hEJlr7nDOjHCLz/KEn7/c2lP4DVao6bU2ac27jM7LJPNBzeXzVuOQOOUM5j5N2qN1FdDZW
 KrfW6ysj0tx1r3zNPkWldYurL6wUtd4OYUiyBMkyCSLNhyJCCGcoCUt5Ry2m4bWAk6NZfiUmxrG
 O7oyFtPxEqJp4I6o/1wfWimBWrq7t+qTbjC9GGOgiUZSsdhTO7vw6VrSiALARIjs5vHgZ8d41i3
 4fhs8B+roVOhjq1sqMg==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a46418d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: VEKv5qr3aqSq6UjySLVAwPJDJRk6f-yC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX/gBfe2YRbErI
 ZFnjvXa1imgQkGmLsUckKTgp/Me20+IBSvf7e4L3sBH72oyB2KduBwKNzUylUSPs86GKJrADVSi
 vYGI9ivRPxU00yZHkH8+UwkJTs36CRA=
X-Proofpoint-GUID: VEKv5qr3aqSq6UjySLVAwPJDJRk6f-yC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020111

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

