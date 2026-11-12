Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472471;
	b=ylox2C2yVb40KyP/u4C79pMxmb9Irh9l/tNlxJvH9u9vRe7le94UkYnd9nFEzG1dB+xf
	 fDaYIqWQRe1dH37Wuz0f/RWpmf6mtPAKDhjjPS3UXbXnEqoJaBdRe7STWAZy+sLhsevGN
	 oayWTIQSSA1+svDYn3GkoYB7uafZ8sjaZOyKD07IsAfGowb/xtUO3XuP1bnzlnCwGBLPs
	 vAbK/+gZowOMLDcLkJBBV84eZCFiRquhmugMFQA6mogZ+7JKarNmutU5wHJDpcVfV6763
	 8ag9FHFQYDSiGDxQHHFYB7czJ1JkDYaKRkg1AcRbDnPuVwewGWwPk4RmJjrZ6GR3OFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+dBN3BYwT/AwSZO/OKO1mYAzM//vF7IgnIsQ77JDC1g=;
	b=T/YMwmjTZjsLMYJ7L8g09K3TK5uGGwvmtzS/QOmDBspQh+mHbH9LTs+MsJpBP05GeTQx
	 g54Uo3vi0mrR+zO5t1RRCKVu3pAnJ2yhVKKDsiyMMslJaQFlxiQVeVF4RoTxZf+TuB/ev
	 EvZhO/tXJaobKzTXkwmJc9Vftis9rYnMtC6rKAeyaLG7NUECWROvPfpFqPZycVMZ8MEQk
	 Cxf9iXIwnPQgUuBrGpj1bW48VYsMlShOtbDuHsxXFBJpBxNNSsTkFkJRZtxtbufPiVLrC
	 51abS1Q+wWeoCTVFaz42UrwbkyHm8I07Jf3EKNu8k7vQjm3MWwIiJk0lg+6LxxkHV/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QGZQS42u;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R1F17MXX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECD606B263
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23ECD606B263
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QGZQS42u;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R1F17MXX
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZaGU903602
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+dBN3BYwT/A
	wSZO/OKO1mYAzM//vF7IgnIsQ77JDC1g=; b=QGZQS42uWHioF6dGt1+XkHDpseT
	lJX98lsKWrgr4tRp4jzfobSkUtRQRtBnCTStpXVYFJkRkIiJBsnJSTnCcS8Ag724
	unc48SkCGDnJAam4phJFC+PmrMbPCe9tVHwDhL7nSyCK0DSOmoynMCdNt1eq6DCV
	yY9neCiO98h0waKcQ6FSLMedBElpGHyj2BFtQFviySvoMdAB1UbTaaWZJBSlgmBo
	XECUZLAS3bD50xW5/zJTjFm/29jeHHkJaVHn3VUxqEZX999yuQSL5anjFIBGfc91
	nLQx8QNtQ4w9GOYkeIZT1msDOLYOjFzy8E4H/ZpxDKMEMG9Xhx7T2uxpXmA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1ubrb0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eacd065b5eso2177675ad.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794472469; x=1795077269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dBN3BYwT/AwSZO/OKO1mYAzM//vF7IgnIsQ77JDC1g=;
        b=R1F17MXXgG3nT8ErGUDcbARCVCb3xVysalxkbxVvnpBlPsQ/DoQd2OtzYLZ8fZtZSI
         9TivwwYK3GrK9QZTp0UU6RRqM86r5vHk6LK/gSl/CatRkim9/5O1WTE9e+70XCBLC/rs
         I3tdWtejrfx5BXXLslLdywH91FmklFdPM0tZpj873h6E0VC4QTmnFuncY2/z75//KZMu
         tms6JZU2ZF0VD6TBuWdPAC9EnOQXnql4TkKUYZUmMmL5IWpT9g9xyzSHNRpL5s/V8fkT
         s9qNhrIgGDyd5CqnJrxeXvWx3px6F7QvFaFJrI6PYdYGeEBfcEzxVjRbNiyioIEhFnTL
         bh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472469; x=1795077269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dBN3BYwT/AwSZO/OKO1mYAzM//vF7IgnIsQ77JDC1g=;
        b=2mNXjFBj0+VCdN9mI6Lr0lUDioYz5vRDNRHNsCpK7KLWr/M7ueQdR5P52gtp373Pzv
         rQc0iwCl/3V2wXO1Q/JD5QFX2SKNWqdiMb/oq63uvbmdU8AS9ci7mL9dykEABmizjPfb
         4cr3mNyctcHAO/Pflpap1Xnes5DK/y7dLPM4UgmM4qqPgci9yUdwGTjUkqGoaqM8V8nB
         q43iKGrKi5M3pPcTjNUGc0bVvU07+ltx7+y6JGF6shA141bkPIwPzg+WlMjys4Y7Hgta
         C47EBo0LbJdH5VTho/fI1g0kk7tySeKMU8xZsk39nwo8GWPrHGKwuceUToyBYbtvWw3X
         2wGw==
X-Forwarded-Encrypted: i=1; AL+hErE31yr7g70mVRj0fKKb55GRrPNQ/GPJ/xbnD832LoJVrxNAwTc/eRFZE3X2GaySDALXjB10Qlr7kE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z90bFF9XhBDTs6So2j8t+v69kfT9km6ChrWNPZvj9htCqSZFhuo
	mO2IsJF/WnfZy3bGlACbf6q/IOXFxwrBcPbulMqRc3y3k+ik+fvSTHX0KIOEago0qoZXthINDl0
	34baDCINWmIoHHtFPpc9AeTMl5kwdBpBJlYc4ZU92wzIJsIOGmTs78+0TtKEUGfo=
X-Gm-Gg: AYBFou1qaXsP2YwJZjAqFFRg0C67K8URhczmK3uRZIEvN7itXJa1vDrgwvL6XxbPADu
	mrSkyh2iRdDh7LYLcAFxSPEjNbFHlRIymTwn9oztqHV/xs7TU7aVWMJ1qDXTMXNWV9phrmLdPiO
	GMQ48LdA/ZbU5MKUmzSGo9bCTqeuQkq6zX4mfQbPDzSUUoyS0thvtvHov1mmj92taF9uHvJ2QkK
	dAhVMJyhfsSQyeuSzfo9wduAY+3eOtAgnM7tUD9AO95/z7ZqxhctgjL04QvXcfMaen2mzCeXBnl
	g+JIHY2D96DNY5e9YqEQ2sMNGKCbg8RA2rffnITUExGIyccZXhHS7yLSBnFCEnMuK1a0FhmAolU
	6zTkcy2GKkGZA/j0tpccHLycRzRoA7H+abW1k4hhuFDnNeM/IPAlXE715is22hYHWj+2Cj+VYep
	eg5Q==
X-Received: by 2002:a17:903:3bd0:b0:2ed:203e:864e with SMTP id d9443c01a7336-2edd7451addmr81294785ad.1.1794472469508;
        Thu, 12 Nov 2026 00:34:29 -0800 (PST)
X-Received: by 2002:a17:903:3bd0:b0:2ed:203e:864e with SMTP id d9443c01a7336-2edd7451addmr81294505ad.1.1794472469056;
        Thu, 12 Nov 2026 00:34:29 -0800 (PST)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b950sm29351705ad.13.2026.11.12.00.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:34:28 -0800 (PST)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [PATCH v5 4/4] arm64: dts: qcom: shikra-iqs: add M.2 Wi-Fi and Bluetooth overlay
Date: Thu, 12 Nov 2026 16:33:55 +0800
Message-ID: <20261112083355.3884737-5-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
References: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX6AE7/9tMo7nb
 AsNeSzdqrFYq/02y6cuXP2L0Ng+Cf+MkiQnZlCit2bxDlrKujOeFjT4qXh0oQzFwL6zykSw5t2M
 ZDGS7ngUY8asLMCU41xdRrNQC0ZohIg=
X-Proofpoint-GUID: IO4YlRdvA0AbPbj9TUm457G0Cb5nenbH
X-Proofpoint-ORIG-GUID: IO4YlRdvA0AbPbj9TUm457G0Cb5nenbH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX5mixK9lvUuTz
 hkz87I/6GJUoObyeqA0B97ce7Fue9sTQg+1CP3923X5rXRj5VsjCaZxEv8/Hvs/+lshJ1H6ti3i
 b8nIONuV03TThIiABpzk21cNjnRW71hBT6S3NNUBQVaG0BB0ZZDFL3fTNY9uGzmXm8AiZH576/A
 U4B2CIqicbjE9JG+cGLC1m+dM2qTc9GVJzp85fbo7SgX3w4Q8dqVJFA4anD7Adm87416/3dXNGp
 uq3+MVQhl23eD4s68tWyaoeVHhXbDriLi0fer3LN8Unpwrp7aTHpno664Q3CE8B1FEPXJ7HNZw0
 Mu4LHCHYoiavTbOV4UZapeTjjaTgjmCV1v4OJEbar88/n33OG40rlGdlSDXe6j9ycm00tN51Wcf
 xQZPP7hPsKNSwbRUE7oLNX5Gpbo5gMZ9Qs4GU+ctEvkMj8N+P6Og8zdZ8Y2ltJ5LmX2lQhtm5LI
 MB8PA5YG8br5QmT37GA==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af57a16 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=fwK-b8I7k3kQTYbNoNcA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120033

Add an overlay for M.2 Key-E Wi-Fi and Bluetooth modules on the
Qualcomm Shikra IQS EVK.

The Shikra product design supports either the onboard Apache WCN3988
path or the M.2 HSP Cologne path at a time. The overlay describes the
board after hardware rework selects the M.2 path. Disable the inherited
onboard Wi-Fi and Bluetooth nodes when this overlay is selected.

Describe the PCIe and UART connections through the M.2 connector, the
3.3 V supply, the W_DISABLE signals and the PCIe reset signal.

The series has been validated on Shikra hardware.

Link: https://lore.kernel.org/r/20261102045815.2938940-1-linghui.wu@oss.qualcomm.com
Co-developed-by: Wei Deng <wei.deng@oss.qualcomm.com>
Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso   | 122 ++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 8329c06b60a3..037dbe8a39ce 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -410,10 +410,12 @@ dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk.dtb
 shikra-cqm-evk-imx577-camera-dtbs	:= shikra-cqm-evk.dtb shikra-cqm-cqs-evk-imx577-camera.dtbo
 shikra-cqs-evk-imx577-camera-dtbs	:= shikra-cqs-evk.dtb shikra-cqm-cqs-evk-imx577-camera.dtbo
 shikra-iqs-evk-imx577-camera-dtbs	:= shikra-iqs-evk.dtb shikra-iqs-evk-imx577-camera.dtbo
+shikra-iqs-evk-m2-wifi-bt-dtbs	:= shikra-iqs-evk.dtb shikra-iqs-evk-m2-wifi-bt.dtbo
 
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk-imx577-camera.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk-imx577-camera.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk-imx577-camera.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk-m2-wifi-bt.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso b/arch/arm64/boot/dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso
new file mode 100644
index 000000000000..ef0f197a53f8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+&{/} {
+	m2_keye_3p3: regulator-m2-keye-3p3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_3P3_KEYE";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&expander3 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	wifi-bt-connector {
+		compatible = "pcie-m2-e-connector";
+
+		vpcie3v3-supply = <&m2_keye_3p3>;
+		w-disable1-gpios = <&tlmm 61 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&tlmm 60 GPIO_ACTIVE_LOW>;
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
+					remote-endpoint = <&pcie_port0_ep>;
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
+					remote-endpoint = <&uart8_ep>;
+				};
+			};
+		};
+	};
+};
+
+&{/wcn3988-pmu} {
+	status = "disabled";
+};
+
+&pcie {
+	iommu-map = <0x0 &apps_smmu 0x0800 0x0 0x1>,
+		    <0x100 &apps_smmu 0x0801 0x0 0x1>;
+	pinctrl-0 = <&pcie_default_state>;
+	pinctrl-names = "default";
+	vddpe-3v3-supply = <&m2_keye_3p3>;
+	wake-gpios = <&tlmm 119 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&pcie_phy {
+	vdda-phy-supply = <&pm8150_l12>;
+	vdda-pll-supply = <&pm8150_l9>;
+
+	status = "okay";
+};
+
+&pcie_port0 {
+	compatible = "pciclass,0604";
+	reset-gpios = <&tlmm 118 GPIO_ACTIVE_LOW>;
+
+	port {
+		pcie_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
+};
+
+&uart8 {
+	bluetooth {
+		status = "disabled";
+	};
+
+	port {
+		uart8_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
+	};
+};
+
+&tlmm {
+	pcie_default_state: pcie-default-state {
+		clkreq-pins {
+			pins = "gpio117";
+			function = "pcie0_clk_req_n";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio119";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
+&wifi {
+	status = "disabled";
+};
-- 
2.43.0

