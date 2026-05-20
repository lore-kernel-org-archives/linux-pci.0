Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7C3DA7C6
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274923; cv=none; b=Gxq3mKHe9KRBMpqzgtxw7ArOvp1HIBsfUIpx6tFD6CHzyMrY6AbzGleICzWNJMwwBdZkcTNrMxJNm+3aUtBhB+Pn2uT+eqViQsGjHa1m+U4G933O7vxUpp4sVHj/S1D+u2xNc01CYpcNiV/KcddUoQaaHU3gENfFZuCzvzN/pXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274923; c=relaxed/simple;
	bh=EcsG3OcBHWatj218IEmU+YqnRsTeebclTu/zvz+F2/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nofq1uk8rCrwSWb6sx7mKVcfGGdSM+ibl54pMOVW+eghDwuZB4dn/BVWzA5sqxG+uY8XJn5TFzjyAo/8iPDytXE0OVrLADNmROx0+fh9TZcFN1yDk/8Ca6lTAeEzJiQ+j608FEnQNNuXGT+omnYz78KV8pISn+mX25RgGPFqTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8WAP1M1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=av8BYizB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8WAP1M1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="av8BYizB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6wXsY2065271
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 11:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lo5MkJYHpFxheGWji+TQIhnd3x4bpUJbquv575x5QgY=; b=B8WAP1M1TMjiWzKi
	x+De4qLwV0+bqyhb0ezjxxAWjTpfYNJsYA5p0A4QoEE8QtVJ4YYduaUuizLmkqPx
	av7CpLxMuMz4J9cMcSG/wS3Tm9eLhvxi1BsJ6jefrDTz4RqjBCqcf2/4Id7S07WV
	AIMYJlv7oijeTLqhmxEjf9aY+20bTW/7axyllnFK9/zXguAhf0D+YFpD1mBsNb7z
	9ZvCs1TOYjsdim+y3yXWQ/dv7PFvY1gnNoHmZ3iZMks6t85nSGDVEMY3n/wd6xDQ
	t7AoTb4hQRF497TReFYpeHYhKn24kLLz29R+yEweg/po+Ggnkd/deS9s5Qtle4ai
	7S5jaQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t4ayp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 11:01:56 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-69d0183aeedso4601657eaf.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779274916; x=1779879716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lo5MkJYHpFxheGWji+TQIhnd3x4bpUJbquv575x5QgY=;
        b=av8BYizBP7X8PSHMjKR6R3vyrqSJ9jhy+WGnwdvUN7SSwXgFriOTeyMlDFbsgUUopN
         YVcUfW0b1zgPioX2SsER1uecgidEck4nYZNqBJuUDSbnUZKtsNY80ch4LcHNsyCY3Co/
         qNmwXj/SCp5F+fwV3E8f+4jspzIk5dD8I1IAzz/+UlkZmmBbYGsYvxWA6rGE80azDDfZ
         PzoUno/rNbdJ425/aPPD2F2PGjQZv+nXKB8aoRSNqqGpyGUlE5BxMXwoX9ze76Fs5SYb
         uP0M7gNqrNDGFnxLFkODsdMvuGj4OUJvDieqjsKiXSa/oaCINZxayFVJ/uc5QIO9vEXF
         S53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274916; x=1779879716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lo5MkJYHpFxheGWji+TQIhnd3x4bpUJbquv575x5QgY=;
        b=kWxiAxhLVxWmLldeLlGNHY3RqYJmh5Y0UGStMZKOsKDPRTh3NRu4EiS69yXDmxLYy1
         Y2lJMxA6iukgnE48+cmoXnLXS8Ig477e0qMv4i8gzXms6Xx0ys3ukX7y4DPiT2PY5iaL
         YePgGXEyBDsnxpeQVYQ4F51f8AYsrGLe/qevsaOc71Rl7d80QLdeoLEn5Jiav4M6KINr
         2c6v6Z7Slt91t70jVNYrfKPe18zXH1TGftu3nAqPKnzVZdH9QJW93A0xMGOHko38QMjr
         uorxKYXKH7Js/q32SYr1AkV9Z5pst4J90bSsCKLpC/Pmq8j7hEKsqlqVFzBwBw0UKzKp
         Owdw==
X-Gm-Message-State: AOJu0YxjmDA6yoMN/mLeu+EIDpIVtAsbBhvh6EdZ0PMQNRzRXL6dmJOw
	PaJ+Mth7i7JSjEruSI8vG5rJN4HizdcOpYALeumytoFJ8/FeSPYPmOjmJtSZGCPvXTjM4NytbE8
	E2mgjg8cI4xrl48r8HS0Fy+YyxL8KxZduL9E5XLhgbR/I7tmkaWJoARRGSYCpP1Q=
X-Gm-Gg: Acq92OFnonzOu6rhiX2GZDlKgijtzDZ3Qrg6sggcAGwknOQol1AdsDlSEtOiRBaDwtx
	ZDfgvXqp1MAL2nzwl/0jqZ1OvTXXeQLQngQRPD5iFYFWD80Zbz+v7dt2mt64sSA/XWiVyDBJqhV
	D0NaEFBRf1SRMM3WLXcsMut+JLMo0u+OIcyEIMG7NqBRZeAGSov+pMAGCJ1SKAD/YvAZgnCQPyB
	mPamNQ/jWW6/zQluIUZibw1BPGWV+5S0cMNfwwY+fLT+6wUY9o5KczmqrXuWZ9POOar0L4Uufc/
	W+ELPWRF/366o4iud8BBryJK4xt7LBt9YUoTDByXsq2OwJmKy1zD3oxWCYg2Y76FXpj90uBUSfJ
	DPY/ZNEpJGwMKQjbbPnRhWZ2NNx4AsVEU6nOGxv2XjiKwDbkd/4jIeU5PTzpO3x1189HMzXra2q
	Hv7qri6Fs88Oesc0zO
X-Received: by 2002:a05:6820:6ae5:b0:694:96ff:d4b with SMTP id 006d021491bc7-69c9437169fmr13536793eaf.26.1779274916320;
        Wed, 20 May 2026 04:01:56 -0700 (PDT)
X-Received: by 2002:a05:6820:6ae5:b0:694:96ff:d4b with SMTP id 006d021491bc7-69c9437169fmr13536729eaf.26.1779274915807;
        Wed, 20 May 2026 04:01:55 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:9d48:e1ec:d837:6344])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eb6320sm840310266b.59.2026.05.20.04.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:01:54 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:01:44 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
In-Reply-To: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: STiaP8SJyPKhrex7svWnyoE91WZKNoa0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwNiBTYWx0ZWRfXyYsEHd1/T4m4
 gbKhjvrOfNBcTME7dyPA6au7X1O6ILT1gVnt4z5mkttsnrxtR979ee5JCUkHDL8NGIrrmhLkzgA
 DZpaGig6PjhIwmH8K4WuWkpM7iBcMXbuFIyO/j78JMvndqZKdqTxob9ojjunlFBiwYpFeuUlRDX
 mbZ8lW0SX0uHdW/RfDM1J3WPIS4k1mSK/gmtva1YLv71oGoJ3vioE26BzvNDt/qaVzJMYHVaWxz
 ncW3ftMd5oMXHOEQL5u7mkXM1qP2j/jXlMEyQqHuAl+KWDEBrUlh4rJ/Rr/ym3LFuPXgQ7jGxUQ
 EedeGVA/klmKEfk0WQckUKyFZg/xJdoKmrgslSnT5ldm3vdw2DT6VlNc3TkT8a4hAQOCCZc3vb0
 pyYB5P+/skANBhnWicZtMctyrDr02IglUugRP2zWntgytP7Eq+xiYJw80fYzX/HJrQeCCSPgr2E
 k58OPoo34AMltBcNgdA==
X-Proofpoint-ORIG-GUID: STiaP8SJyPKhrex7svWnyoE91WZKNoa0
X-Authority-Analysis: v=2.4 cv=C4LZDwP+ c=1 sm=1 tr=0 ts=6a0d94a5 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200106

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

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07244d185abfb1976d9 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
 		enable-active-high;
 		startup-delay-us = <20000>;
 	};
+
+	wireless-lga-connector {
+		compatible = "pcie-m2-e-connector";
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
@@ -408,6 +441,22 @@ pci@0,0 {
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
@@ -500,6 +549,12 @@ max98091_default: max98091-default-state {
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
@@ -540,6 +595,16 @@ &uart7 {
 	status = "okay";
 };
 
+&uart10 {
+	status = "okay";
+
+	port {
+		uart10_ep: endpoint {
+			remote-endpoint = <&lga_uart_ep>;
+		};
+	};
+};
+
 &usb_1 {
 	status = "okay";
 };

-- 
2.34.1

