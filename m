Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43146AF21
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846246; cv=none; b=rCiicGdcdnczPeROyP0vNfYh8FQXIGcaooqJfjm2IxLIG93i3NLNPabEYd7zXBgIf/QL1z7tds9ujyBVUjfz7cBUHKJticnOsl0nZkRUYAprvQ9AAu46VQkcy0FaQxj85ys7349AIVTywZc5YddZARC2qjNWY99x88mrbyr9bQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846246; c=relaxed/simple;
	bh=i8Jdl2WiUlL3/xlUPB1sMuP/iZyKKJ+dGe+Yk7hYLjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzTNhlk84uB3Iviu58FjRaH4EVfMeV/dDk0Iu8XpwPgZVyprFTXwxY13y2PrZ0yNaTxSbSa/aHtYr7NTPiL+Q6I7asGFfCC4lgiBd7SeFzeH17i4xldWGoMzek6CjfSjW90QdAJaprstbM63fHAeGEnsd2NWJ04PC54wJJ6PaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iQY13eIQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ObgoOiMz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iQY13eIQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ObgoOiMz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UHkhw92733835
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MJzQYy9NeGXvGWgMiVeRkyydULurB3BuYT/jaTVqZGo=; b=iQY13eIQJj2Swzf6
	lFYC9I9GlAk2Zp6dH7KT9ZqhTVHH77VVJ3ymTGZUvKRwDBEA16hxG/N5ksQ4d8oh
	y/IeUDoaPg5U1VAVxEGXS6Sk7bZtGyBhoe/SHLv4mI0SRsM4cTBIlsVOQ2qIi5fv
	tzgolmi49ksXAzIYR8wNKWtU8nHUmtqscmXPmCqJjPqWd8k9vj5inNh5UR5EtUNo
	drH/Q/3JaSP2EVeu81YQ/cLm3m6+A+yWypW1LuAC+S5dILcysi+/LilIE45/RMkS
	k0DNIXOjAvrViJI/cue35pNLEU4LJPaXBeJhtfkXH+1TY6ZuuEE7qRYEN25dJePJ
	TM6sOA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4h0ary4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:04:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30ed53abff8so2507811eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782846243; x=1783451043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJzQYy9NeGXvGWgMiVeRkyydULurB3BuYT/jaTVqZGo=;
        b=ObgoOiMzKVzzG1PhodgXrJhOqrlKbAeFHHdkIMjyZUIzke+qNvLEi/HT/uHfrD+BNf
         wsK2GPuvy26RgCqP/ggSFAPM3tRNUNF6soEmOETS7FAHYSGz3j/8UdGabMTk9PiCcrFw
         4agrr7r0G8J2BZxeJ/KdJtOFaIgUI68WnP1vrABzpZezRuvJfpraqiraPVNv87+xZWyN
         lM3VwOiu/SXXpLyiEW8UG3AGYXBjzaTs3FjBtGsvfYvwLObP3EtYgIKO9ez+61DCetPi
         AozX84ugaadCB96MlgFuBctt+y6n8u6/BN+oXH6cqEvOBEjvGF3LxaswOL7i0cL4zoL3
         joUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846243; x=1783451043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJzQYy9NeGXvGWgMiVeRkyydULurB3BuYT/jaTVqZGo=;
        b=P/yC7aN6et8Aoy5sIb1akuchBOhUMIX2UBqfGPDnP/842NcRxjzlAPwsX3oeQRd/pF
         YgUUiLt65YJVb9KTgJwBWoytsJtqW6w6gP5P9Qq1k1hpXHyKFoJHqa4rWcP12xHCz1mu
         z/jlqL3OQVJ5/phYl7nfqAwAJtz+2GaFdUB9qxi7j+LpT15QAvQRZGIGDqHKBJj9VM9s
         zuM7w+fg/KWVEe4kuEyOfzJdjigUYnat++t6mdEF7xnDQLtv0WKNrVD36Ye0jtOOw0uu
         4QSQxs8DAn1TKgtOIZbapCa9G3KbNbywmwqGhoyCDtWShU8RJaE8qELYOJ20VhFfJl8d
         tGMg==
X-Forwarded-Encrypted: i=1; AHgh+RpVjMb0pv36CoL7QhDD2hcozudR9HY7phu8AS2do81yC8j8bthPaQfi87lA4VsPLnoYbiCvRFMcQv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gYtKTXHaqhT8Mdd02n+O0Vkwu0a5SQZrraA4E7JTw3GLArHR
	BJKr8RtOJ++zoIcpdjV0wdVu+Nr3M0I09xN+5JBe6deNlWklF6Fsc/Z7tAWlUtZ6AVRr+aNYKlZ
	qVMsxNI0l6FQIg8YrV8FoSLF3++92lYMbiAAelXYQ6zmCpIsNeVoZRQ/49lvae6Q=
X-Gm-Gg: AfdE7cmh6bUcTBNvTQV9ibMqatVsnNYVeAiVHRzklorc1TX8PVbi5xq8uESJxKgQU6P
	/FJFO8G7G+sRBtqyLZOJV73lAUSE1ZO7E8oBnIwNw2Yk5ZqKnUkMCQDi17Jn0n8wX36eK9pHRud
	p+ksCy/TAVjQgoWpauctVYvsnDN8auvM697LlBVlHe96Hg1Jji29TIDKgmaFLzketgyJvS6wW3+
	0qFCDH/Dqr2m11ofSQW2pm8uVn5z0Nmm/at10K7knVXOWsn3j3uq65F5ay5SoGAV18g+/pX/PjO
	xmlmRjs1eCthJXP+A7rKaK82T8clFYAnduNza6euOSGNjXQk6mjaKmBC3BhpxUc+Hejg6q4ukfV
	JrDLM1Lp7w6SULG7umc1qRyov01toW7MKTA8TcqiNcy6VBr8=
X-Received: by 2002:a05:7300:80d0:b0:304:997c:d4b6 with SMTP id 5a478bee46e88-30ee1365bc8mr4242301eec.17.1782846242538;
        Tue, 30 Jun 2026 12:04:02 -0700 (PDT)
X-Received: by 2002:a05:7300:80d0:b0:304:997c:d4b6 with SMTP id 5a478bee46e88-30ee1365bc8mr4242260eec.17.1782846241987;
        Tue, 30 Jun 2026 12:04:01 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm14963815eec.15.2026.06.30.12.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:04:01 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 00:32:49 +0530
Subject: [PATCH 7/9] arm64: dts: qcom: shikra: Add PCIe PHY and controller
 nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-shikra-upstream-v1-7-e1a721eb8943@oss.qualcomm.com>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
In-Reply-To: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782846191; l=5080;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=i8Jdl2WiUlL3/xlUPB1sMuP/iZyKKJ+dGe+Yk7hYLjk=;
 b=nKH00pm4XpSnA2IJzI2OB1m4FymqWLvziEtBlUCtRFRQ9VBgdgOGj9I4PShoQVqJU0i5RY2g6
 gi08NEv65s2Bg23ei43Nw828LsVorLAzxpAT1DeP0873ocGlzBuiQTq
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Authority-Analysis: v=2.4 cv=OuF/DS/t c=1 sm=1 tr=0 ts=6a441323 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CK1i0O_xw7d_XAuQu4wA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: dBpeZkPCn2Hi7WxTBBtwVRWCapsn6yhg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfX8IqIfDdd2S7L
 oDRXDcxbFcuXuV3iJ0hwqxsz/rPZ3FExULb/1ICJh6J9RonY2qaRiwH3q3Z9Y9nJRRSSyMlJ81o
 IbMgBy6GDkyYBx0sVReJId5URytDS6A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfX6jLbvMXkI7Se
 IEGZyZxE7iV7qUdy/xz38ij2fuBC4toNTwSUV6adnTIdzV/GFKc2QU1htJUMLUh+NXHfV1wJWv0
 Yfqaxj3pR1VRcMYDBm3Yqxvuz5oif1yh97QeqN7BsmEN7RLrwsyvykCsHSRYxt8ygZWLjq1smPh
 InUpbejPNqkyH4LBOSMREwXRlwPgphwfZ4zzMMLRXuPT7J338ZceQCO62oZ6Si/s433U+XcmPN+
 X/Wr5VOJRZpVZux4js1lrYcHjUw5QCXASAUA0qIigK/4mLLHqEfi1R4//04rOsRWcEZ+4Gh4/sA
 XNf8hX5o43s7B7yrotpP0y1A8Gvm3o8H70WZH76UhFHRRwXam6iB0O1vQpv1EMlJog5k+nhDuiy
 wn+9VRRbG0EvWtOHkCMUDEjxPY0DCLcEJOYCLREwH//tR0UOfpecco7LxofzC5CzeARDHVh511W
 99Sm6w5JCeLBGqrCUmw==
X-Proofpoint-GUID: dBpeZkPCn2Hi7WxTBBtwVRWCapsn6yhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300182

Shikra supports single PCIe instance with  5GT/s x1 lane.
Add PCIe controller and PHY node for this single instance.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 154 +++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index e67fe047a683..74d51ba5bde3 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -998,6 +998,160 @@ tsens0: thermal-sensor@4411000 {
 			#thermal-sensor-cells = <1>;
 		};
 
+		pcie: pcie@45e8000 {
+			device_type = "pci";
+			compatible = "qcom,shikra-pcie";
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
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>,
+				 <0x03000000 0x4 0x00000000 0x4 0x00000000 0x3 0x0000000>;
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
+				 <&gcc GCC_DDRSS_MEMNOC_PCIE_SF_CLK>,
+				 <&gcc GCC_PCIE_TILE_AXI_SYS_NOC_CLK>,
+				 <&gcc GCC_QMIP_PCIE_CFG_AHB_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_memnoc_pcie",
+				      "tile",
+				      "qmip_pcie_ahb";
+
+			assigned-clocks = <&gcc GCC_PCIE_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&system_noc MASTER_PCIE2_0 RPM_ALWAYS_TAG
+					&mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
+					<&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					&config_noc SLAVE_PCIE2_0 RPM_ACTIVE_TAG>;
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
+
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
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;

-- 
2.43.0

