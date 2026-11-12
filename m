Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472465;
	b=lgVBpzkAbkD1WMmBxm5dhLYRhtjfFAcngylfVdoqyY2kLNgv+C//30siz1WNLLGp/9GA
	 Ru5vfyQKYWDxLoy66la8/GIxuMigt5W4sURNZxFYuJab4Dfswb0ITMc+a4YVcejz/4aD/
	 Kp2l6vLEP2y1vj6dA+MQsbuA/tjYa1hSWICauli2ffW4lqYfMqq9ZGk7k5ECYxqWCfcTk
	 6e39bLa37Qi7ipgzo+aRr0i6QJ9ebppI5AXD94PltHX8Xz+tD0d2mlzncqoysHG06V6QG
	 HtuKQPqUYBiwaheIa8ALQW4ThJ0wxxD6J4HpSHL/hqXZgR0ExVU/N0ZHHr02U/7v4GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472465;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OAbrta4TB+iPwb0QzYQG8jdtrdeGA25gVf6eNvnXVrE=;
	b=pVcqlkWRjiBKPGVztlZkqD6BlDLnvSTUx0oHPGwcikEvc8OyPMS6ee+JTJAHA2b0p/vp
	 hBCfIw4Gk8s9Ar9ADEch+Afkp4pgoxm8+Pw6hKGgjG1aQnHGOiFaA7qkgPbuoRveD698C
	 BgHu5oFXFF1sr+c8qn90sf2G53dvVFWSYrHATZ3w/UOoCQqTZ0dsORVJQavHe/cKrqLZ7
	 NrlviGuz40vsJFhpw6k0nweRqDNZ8YBipIrFEXIL0kbnGP/78yZoivXvRkwzT9OEhlnPQ
	 vIXXXEeStcv94VKR0gYO0pTwfi4HkwrYSIW0edWFDzTg+65cxBsLZGH1FkuptJeNxAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QuewEtQB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jjRe49uw;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B160A5BC5
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159B160A5BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QuewEtQB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jjRe49uw
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZcQU903659
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OAbrta4TB+i
	Pwb0QzYQG8jdtrdeGA25gVf6eNvnXVrE=; b=QuewEtQBzkyQKHH5xPsm1UzxUYb
	mdF0QxOYSLbIWS5HuSI7elZDwmGNQe6KSk7fEjCFp+jTvPjiV6SQhahWvN5qGlr+
	2SHexR2vwc2fFm+xiWycTnsswkqgS5RdubHnnTLDcP3DjTlMEUfLmaAbr/AtV0Ak
	REpDiWd4jgH+RCX+JM6hjTBwkTjhjr/cLQ6d+VZ+YgNnLIq7TkgNJOB80+MzCQ7K
	ScMm0bB1GfKDQXiHElv1ru8f8ZtFN4+ys6/PRJY5xhth1kK94kZeUJLH1JG6zPO/
	ty1fln8D2eIEZvHM/fB72WnpGbXOQ5Zqs44tDbTm94JCEb0709NCXVuP0IQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1ubram-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb53f8aab8so148729a12.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794472464; x=1795077264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAbrta4TB+iPwb0QzYQG8jdtrdeGA25gVf6eNvnXVrE=;
        b=jjRe49uwDplY8BTQYjxwdJ4ilq7Qoz24B6PTjQylEYjfXYIpQf4L/IOPLQtlCXbWG7
         94NGnAV0TRKH8+qNb+5i6UK8VTWmOoaG6n9a+sww2diQFOULnJXVe4VcotL03TMTa10s
         a3tdyd185egryfkE63YGMX8C6fYuuOzfxb/9wKdB1/k33F1VzrgucuLPXgxyMDuoZiRp
         nyi1z37BDOxlIKbbsdzpeVUHrQjELhtVsEnFbKGoO06Q7iLFy2wdFX155c4T+lHxvLYC
         TVpv/bf9Jxpi9WwRSlSe5qcW1+Y2o0WiV9YwkFzAJAZjNyu74EXtAFWCWb/zZgHLuAe3
         V4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472464; x=1795077264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAbrta4TB+iPwb0QzYQG8jdtrdeGA25gVf6eNvnXVrE=;
        b=2OJtOVgjmP121E/Ut1jYljDup1mkgZf2QlwROe21rYchhcEj/ASwznOmrDVV/kCfDK
         wv617YMQ1gtqWbT7gKOMZ3vaQ9tlQ8vG8GFkZVpyaJDU+i4E9HW63StRHFrq3LqGLsp/
         5Ofelm3+kM8aF9jL7Ddwa1e/23xmOy5KzKqZpPYRSU24ARkDzk68duzWgrlVrxJGd9RH
         KVR/oc4p//2bhxsUHHoV0xEMexKk92u4VZWxUIcZPYFeON14L+u1yasfzcF5jmoofXgA
         AV1k2dGhSb51mKOdOdoHtAyD5doT7KbS7RM9mQ8kiksEGcUqjDWaJ1FWlPNTF5pRkF6V
         ImwQ==
X-Forwarded-Encrypted: i=1; AL+hErF0EldgzMLMJbxwHFQgAqGbEap91fZFqjnBAkITvPyfybRrqDkxJgrbZfWRcwu4x4wSz7liExG3Dns=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JzxmNiASsuNBWgbfGavV91zK7OiHfN2yKcoJo0UiBEFATtoup
	3zagSscsr4wjEsi9oAdhP5CvyO6YVtB2H6sJuEJGysvzisL55Vv/6xro5tSvWcxRijV2Ftrn+bF
	m1Rs/SWTFQ/Q7kVDR4lqPyzUkD3/woBe4pDsEySTGYkZ+fi8idyo0Yc7xW/K+CQc=
X-Gm-Gg: AYBFou1gyWc0U9kPgmOrlZIjP2LZlc+R+9dC9GGVwmLz0kd7WwuIWbgI5oVruB4Ug1H
	tK9tNhhw/05YtVLo1fhxzcCGlZEC5tGLkT+hhRgewd0oUmwTMzKVT6m6LbpBlJKfc5iF+ifqA/Y
	TwsbIcgGD8Hipqhz3+EnwIAWRexs1NQ2t/ztg94lP1zgVeqAEiDTp//qjeg4ObGn8PD6kwgJmj9
	eBgbkLS3Y32jFxKA3joZ5osMBSY12SrYBNcq909a/I0B22gpuQgFSVeq9ZEZINrByAEV0QbJ+uE
	m2XQfU+pgYPtqBOgBHymixWn9zpO/KxgWm2tRklkrWAnkFj9mkbODOG48QSGnMD6op1K25AdoHI
	qhrspMeimYLf9jIsaU3o/oCEBSdbYVVJTNfjE7l00LZln6qWQuTCuOVYDUSgYxX99ufOMsmyb0r
	HDxg==
X-Received: by 2002:a17:903:1850:b0:2ed:4b23:c41b with SMTP id d9443c01a7336-2edd774848emr77646585ad.3.1794472463556;
        Thu, 12 Nov 2026 00:34:23 -0800 (PST)
X-Received: by 2002:a17:903:1850:b0:2ed:4b23:c41b with SMTP id d9443c01a7336-2edd774848emr77646165ad.3.1794472463045;
        Thu, 12 Nov 2026 00:34:23 -0800 (PST)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b950sm29351705ad.13.2026.11.12.00.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:34:22 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] arm64: dts: qcom: shikra: add PCIe PHY and controller nodes
Date: Thu, 12 Nov 2026 16:33:54 +0800
Message-ID: <20261112083355.3884737-4-linghui.wu@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX3epcFqxPzhKp
 jVuvmi3w4OGNuwQy6HQpJiV+m+/kJhxsronsN2HNvbw1SeX1OF0hvpnsy6PuzbNMM4pcs55lSqB
 EALuL9Ans5vfSfgfShlqBDVQjykh8mg=
X-Proofpoint-GUID: tGGTbg-GGgvFrP5Q_oaIOV8iOydHcTNp
X-Proofpoint-ORIG-GUID: tGGTbg-GGgvFrP5Q_oaIOV8iOydHcTNp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX71PxmZSwl7aQ
 zNYOS7Gimb5Z7DoqwYr2EWXBZZsjRRj6A5nkeTaz6sGDoBwn0U7mm7i34P90ux54TcqN6MSRwPY
 Ax1bhV3KHutOREdjgYHy6pppnT1uhkorD7oONovtks1ftzgpX7hcHOiILVdTPXh98zXpFKceNun
 6Zc9a3pQPKi+1TpAWv/HmgYUmpHOAqUAL2DIj0yQav+Db6oB4+vsed/l31i7KBFgfOqxnRvT88M
 ncSRnRB/I3O/sxwJTThJqhoOvnXdii2Nw4/YQeCS/Bdne1Q3S8Kmq+MYRSFpTNoqP48pEDfLGtb
 e7By39jTc2Z0GEPcmXYKBlLO+QDTDCrZvIyl4Vom0fzJQ/g1i1hOJVQdCvB6OtOZ0WgOaTHKQ85
 t8QGkpiWYxXC5CEgTrn3ZeGzFKjE26zun2AIeB9x2ayIHVC6XiWo7fxAMyjqEVhmjaLecafSeMk
 t3T0ePahqxvnTtDXDuQ==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af57a10 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=_EL0bMPTzUm28oAMh2cA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120033

From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

Shikra supports a single PCIe instance with a 5 GT/s x1 lane. Add the
PCIe controller and PHY nodes for this instance.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 158 +++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 0a95ad5a5582..fa9b0d41a576 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1285,6 +1285,164 @@ rng: rng@4454000 {
 			reg = <0x0 0x04454000 0x0 0x1000>;
 		};
 
+		pcie: pcie@45e8000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-shikra";
+			reg = <0x0 0x045e8000 0x0 0x3000>,
+			      <0x0 0x60000000 0x0 0xf1d>,
+			      <0x0 0x60000f20 0x0 0xa8>,
+			      <0x0 0x60001000 0x0 0x1000>,
+			      <0x0 0x60100000 0x0 0x100000>,
+			      <0x0 0x045eb000 0x0 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
+			bus-range = <0x00 0xff>;
+
+			linux,pci-domain = <0>;
+			num-lanes = <1>;
+
+			interrupts = <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 493 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 494 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 497 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 498 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-parent = <&intc>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
+
+			interrupt-map = <0 0 0 1 &intc 0 0 0 499 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 500 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 501 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 502 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			#interrupt-cells = <1>;
+
+			clocks = <&gcc GCC_PCIE_AUX_CLK>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLEEP_CLK>,
+				 <&gcc GCC_PCIE_THROTTLE_CORE_CLK>,
+				 <&gcc GCC_PCIE_THROTTLE_XO_CLK>,
+				 <&gcc GCC_QMIP_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_DDRSS_MEMNOC_PCIE_SF_CLK>,
+				 <&gcc GCC_PCIE_TILE_AXI_SYS_NOC_CLK>;
+
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "sleep",
+				      "throttle_core",
+				      "throttle_xo",
+				      "qmip",
+				      "ddrss",
+				      "tile";
+			assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&system_noc MASTER_PCIE2_0 QCOM_ICC_TAG_ALWAYS
+					&mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
+					<&mem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					&config_noc SLAVE_PCIE2_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			iommu-map = <0x0 &apps_smmu 0x800 0x1>,
+				    <0x100 &apps_smmu 0x801 0x1>;
+
+			resets = <&gcc GCC_PCIE_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc GCC_PCIE_GDSC>;
+
+			max-link-speed = <2>;
+
+			operating-points-v2 = <&pcie_opp_table>;
+
+			status = "disabled";
+
+			pcie_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* GEN 1 x1 */
+				opp-2500000 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+			};
+
+			pcie_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+				bus-range = <0x01 0x8>;
+
+				phys = <&pcie_phy>;
+			};
+		};
+		pcie_phy: phy@45ee000 {
+			compatible = "qcom,shikra-qmp-gen2x1-pcie-phy";
+			reg = <0x0 0x045ee000 0x0 0x1000>;
+
+			clocks = <&gcc GCC_PCIE_AUX_CLK>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_CLKREF_EN>,
+				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>,
+				 <&gcc GCC_PCIE_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "refgen",
+				      "pipe";
+
+			resets = <&gcc GCC_PCIE_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
-- 
2.43.0

