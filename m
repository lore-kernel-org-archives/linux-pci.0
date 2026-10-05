Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA5485936
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202925; cv=none; b=U8P++vA8Qx2v9rmIcN+1H8zD7EYhEdOpXosWNAOh6RoxYjDAKZgqcvZ2Kc6DJRSefYJBp/Uw0KRKig0lTFjK6EXTzKtwtwhgvgs3g64fuTxDyil1X5/By2yFqPL5iUyYPQW6gm9Lu4ZuNCnQntP4z+SncYJZk7bMVYkY5zw5r+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202925; c=relaxed/simple;
	bh=XBoNQxYvBmyKpKq8cj0A488JdM5oMMiOx6kyiNQnHoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okkMn/IcPJdxNvHUzOYg4Aw9MDYP27JJzEcChWY3Tzwg5zz8uaMh3xZkdYJ0wFQV7gh3Il2YiOnMUGP+gnCiRTY0wD7fKmGktjySEQia2Y5isSHo9W3UbzVMP6WM/fPecfE47s8kj/Mhtn1Q4qQikq856rnfhVDWN2q9m8Rk9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kLnZPTUh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W+fZ8tWT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kLnZPTUh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+fZ8tWT"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFYTY2897741
	for <linux-pci@vger.kernel.org>; Mon, 5 Oct 2026 12:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6muZlLM33J+DBa+9pVOmRUzmFBVv5+7rsnUWPmNF+7o=; b=kLnZPTUh5EIJEt93
	jPvgbk/knlmvBlUQMj6bD1B+AOouvuAJUvkXdV0v5VOiSccRjo6HKQdHAZ/FPgbn
	5jEJaybu8joD5LNvHAzFUY/Ya3jwNlhzCv+S7fnqHwBXs/mSOwwiopznzenyBo40
	7uhJggqOqEYQc5j7DNerqNo6j8y3ycEa8BclYYmW0WMYllPD/cjv66tJE0xL/7pQ
	tShO31rtHH2QUN6szjJM8FvCq8o9iunbZgcruO4lWyPcKTgsgDX8QgFxWx+A1HKk
	JP+XLtAd1h2O7hHTQVP4RlTIK6tE6vt0c5lCJuBwzReEfaY7rcHpFzzA1E+wLcUN
	wp4wlQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sssnrak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 12:22:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cc359d9easo256470485a.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202920; x=1791807720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6muZlLM33J+DBa+9pVOmRUzmFBVv5+7rsnUWPmNF+7o=;
        b=W+fZ8tWTKrWK0T0VWx5r11oLOpLxA12kVGJkdTFUjSR+ICXzk5riTxNjN2LaDXy5NJ
         Pd5v56nAL6cOciEOZ7fQc5fJjAFoe3TwSzbQpISeaHCt8GxPO9x/WRhwFeM+ZhZr1wyp
         pMrlugpi/ZLF6YBlyEMsJqVrS6fgVxCnH9Fd8WkIKt6jNw003BCxILecLNdHZZXLqdDT
         KLLCVc7RucxBVn3samKID+E5o92fTBBxB3y4yNjEf3RAFHzGOd4vxjKlUslDp53Z0gtO
         ++4y4eswGTm1XiaZ30xj6kNTH3wpVb9jFZxipBt7YERU8U84O0xOcup3bE0XgaDW+PDa
         ntMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202920; x=1791807720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6muZlLM33J+DBa+9pVOmRUzmFBVv5+7rsnUWPmNF+7o=;
        b=rWf6YhmaT4wgbbr5ziGYA5c6QOwqz5hX0njKjPwT1CjeGil40acF3BqQmm/BG1E0e/
         fMPLQS/tnGgwx+1mqMEqaI7yVNqY+3zfvdtLNqQ3PnPghaiHQ9RvHjUSYlgBxC5FXGms
         DTYodyUMADV/+hwtBgofaTiI/OHAC9SSYMNugCSdd6zIrK+/+XfvgEsLUeqBppPfZ/5t
         fDT7GnUAxBF4UDWb96dsV+cUj4IwR5tKp4FVj0r4pGP3PQxr+BcINcDujH1gKJeep1FG
         cOF2UQ3SjcCb8fXPU9YMYcvCXIp640A8tt9sn+F8XGG1o4P/N4hdgCGhNiw3PMdph1cc
         pRkg==
X-Gm-Message-State: AFuF++nkUTJ9aI4pV/zourDlcOIk6o8oDRCxCM71UFRuXH+YFa6i3JBd
	WXMUaIMD4avxscauPF6lB5jWHivnojn83P1W+PYZ6eA+EXC1A6kBzLdS4lmaehwqNV5ppliGZXH
	D3mHruGqYfZppuSesCWFD0bpk96/W/EJW6wS1NFhSrP7ykfoKEGMuVBb7lYLcmzA=
X-Gm-Gg: AYBFou1vfC7CSuGrcL5bnbq3GH19ZTh3w0mxXbcajvsnAOLOq32ha2RcigJgb4WbvkR
	aHeKe/Oi2VK7fVTphhQgdk8MsV6lwQyg9DBGl3aG/286J76L9Agyq7tON5twzgwVO7usZenk/mS
	1sixCilKIUe7Ht3EjupQrNChWhwl31VNsfgJxiJu1Qw0TIPrtLrWQFO88nHIilNcKMZfBtGjkv8
	GZtaxyioDHTinvu1XRmeyoArXXL9Z0ZVNjzbHpE+UMJRms+seKh+DPRqL+BD5LW9t1BhwLtG/w1
	XmipdeOsCQyklhBbkFXvqfOFwVcQZplIQhBtNby2wQQTTxXMGbTwr4YqVn/JFlaYpaHFv6FFmw0
	8TCh3lx9jggDQCdb8PWigMIOkT4drinHmaxTith/c1kqLnB7k9LBZtb6FwR8czjNQuz2tTmwoe5
	wNQlPGr66vP2AFL8dmaObQyvrx5TDmd+Ojf7T/pPiBnO369R/dx+Elo6V/w9mbs6XwajrVAQ==
X-Received: by 2002:a05:620a:318d:b0:93b:d79b:9a5f with SMTP id af79cd13be357-93cf19ca651mr2051976085a.64.1791202919400;
        Mon, 05 Oct 2026 05:21:59 -0700 (PDT)
X-Received: by 2002:a05:620a:318d:b0:93b:d79b:9a5f with SMTP id af79cd13be357-93cf19ca651mr2051970085a.64.1791202918884;
        Mon, 05 Oct 2026 05:21:58 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:58 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:38 +0200
Subject: [PATCH v7 8/8] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-8-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX4F1XrHW0a8+z
 Pwye/XoHdDC2ShMEiuZisyj+dP4utjsGLjqy+XEEj1jaDmdTXBY2cmQ8SW6hJB04IgF6YU9Cphq
 89iRA6f+dgwXbkHO2KgBN4u6iiXX9p4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX1VPDydxBJmWb
 Bqbm0w8c6MBG25wHIt/aKUBVrN0NPuSrPuU1Vp/UgaxMcbkwKkI933AHcTfIKWMO+Tc5cfp8prt
 0Ssb3bhhp/THAHN8gvLNtWA5fbEKcxNnbbWB6F+o0Le2Hoq+J1/O3WqPD4iN3ewnZisEIQ6NaBt
 4ykB6n5nUyLCcjjGSrn6tJ+AopGjQajqglAVkyCl9GPpQLHOEAaJIgLA+z9GTjwSLCnyz/Qh7Hc
 Pzmb2H29AV24BUnLMxVVKHGF0idImLimmNDmwPm8gR65w3xSnyzMTIKuNY3BTzRzN3S/qo9YVpv
 VpHvdU19soKW3lhXygsQ1I1CEGwlDYvQIvPqNr5woWRN9qpL9pMziC5T+Hf+QkETT3xcK4fR4l0
 T13V20zcV9Vs7Ah7Pj2axMyuQqB9JY0EYveqwg2OzKkDHy2UtDL30ePB/ZM0ICNOSQPnrM71GXU
 sOk68hN2VqydkH3t0Iw==
X-Proofpoint-GUID: qROeuiStaTy7AV-yxYWcJtBOZeO3qLpt
X-Authority-Analysis: v=2.4 cv=HqjjiETS c=1 sm=1 tr=0 ts=6ac39668 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: qROeuiStaTy7AV-yxYWcJtBOZeO3qLpt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

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

