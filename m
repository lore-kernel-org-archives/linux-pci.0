Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C233D953D
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222407; cv=none; b=DjKuW/3IdsjSEsgSstn7ZDRtq+miWKHHl7dFjWH/onebp5Ixp2oQxFI8kdxdNCMtTPdIwYTsv++uRRksxzEb9qnOBLaDyfi8iUdg/NHufP4aI6cTRU7gS+h0FbQ4EI1Ejf6B3et0cXpRSDcRQOIB6XIfVEO34IyqqjHD7+/fpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222407; c=relaxed/simple;
	bh=C5M1E+YmUcs9AY4RLjgkAzdle4UtMia2apOxFdvce+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1B7IN5zaJhhDfj+1rn335mL+e9XqyGbDlt/97GRk7iJHM4Sk9GTLDBPaxL1hNpr7RF0371OWD5fbCVPQEE4LaUHR48wFkQz47SgVIJva7W9VLG69DsB3T24Uv5PUv7WSs1BKXAjS9F5unoVT5Dfj6zLFqSax0z2VEEIXfZ4zOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDCNg0q9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e43CcqSH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDCNg0q9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e43CcqSH"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3b1Op1701740
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 07:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D25icGtZCtH8olzz8dwJsRElTRyEHceOXbeeGXnsvjA=; b=XDCNg0q9ltdhaU+J
	gyzGFl+YCZl3C3FUlP3c+yS6VlmDxAvhOz6PCePvUG6dRegDassH4+mmNgy01IMg
	V3RcPx/gCNSjWj0UJ3lt5K7UnEJusiTfhgT4sg/Uu10Ax2R3hgCU7ckEISPD0ZbC
	GHLGtC6RGZ+F4d0SRAgp/vIg0j4UjTxEHwaiR8brnAu5YY1EtRDRBgklAiiHKlse
	SijHFxy0o4f1+BQL4HY6jyuaOlqYlsRjO7VgYTmeathM8g7O2Yd3aiOXjuLLE0JK
	OKAJw7XVWqpX9r5DTghGPVrIB0XLX0ViYSyfcaJ2yY0Ijd2P9MehQEZtJrl7xPI8
	YUuCgQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7hehf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 07:06:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so8796516a91.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785222398; x=1785827198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D25icGtZCtH8olzz8dwJsRElTRyEHceOXbeeGXnsvjA=;
        b=e43CcqSHgC7eii/TIfKO/GiaplwxHa2fhxsuS9GvOou3AMDJq1AUboWhLJaTlzV3b4
         i5iQe0hKLnW/vLmoKqhdP0GsNZSoPFNMezgUIPVOsgC/n7UT6VGHd7C626oK0sWdvOJI
         ahKpsXhA4/hhpTocT7P/jYOMMkuY5D1N33iveWAVkZIPsSLUQI5zzyKYpaxv6qc/dmN4
         BQI+foVqCobCkLACOVZ2L1TxBJiPRANcVs17UuBiOl13p3gtZPxhWAZlHq2F2bwm1Ku+
         b3JyPdOhLyC+g9pYi+w4e0yiICHA6Upb+jtPeYYPgweRTKNYlUIBKRyOOjj18eLU1SmB
         QFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785222398; x=1785827198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D25icGtZCtH8olzz8dwJsRElTRyEHceOXbeeGXnsvjA=;
        b=eZUn4lL1kzgliRPQ8uu81fgW9IYWicOQOYNSLf4DtsvNMN0wCVsGOMtr2pI731Utxo
         lGJgrxaYT7bnn/Ww1qsZHQDksaS1DnW7oexxMlgwHoe1lm3Oae3Umq60hiRKkAU4VaBx
         2EyXZO4BRUo2w3Cvva3IB+zpeqH2IUwGmMeOaYGqY0r7/aV1p1Y5p6NFWC1Z5h1wCSKo
         nOOkwkR+YON5imLnqYEHijRbFNo1oIwaW83zuZfsUFDsc1v4i87w3axtPGgqQSbMDrXL
         Dh1Q2rsmQPE+uzz/zJIbREYW0XFXwjxVR/VpZc2wqgSVVDCbiNLDaFq5aUQe5yCaJ7tW
         Qplw==
X-Forwarded-Encrypted: i=1; AHgh+RqmN5ehypj457ABDZGWG9F9V0USt4VJJi/P5bf7pt+7J6lI3ZZ16/jGolQTKiCHy2X6Et9EXgERRns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvNAZj/4YwJjexIGciDnN/GyPt4zSa6qau9O9GDPn5eOa+z+0
	BEa5D57MR0+Pi8Wjv7skb1syLQuvAEvEPoHNQvM0IcgsGjiztVUIwGMniRXMp9yDgsgBnx3xNip
	1OFVC1bZLyA212OVzSXG3uPB/y0ca6Nu5t1R7ZqhxEPBFjAAmwmd6DKjYPTeDA54=
X-Gm-Gg: AR+sD10Bt/75bOT5OC4duHBgfR5vD1YRqFmBPKL0gv6YimOyU5fICUOAlk3DcPbEUP8
	O3dPDoSn+2sCe/rwzsZZAwdgrcOBx+KUF6lP9RnMwZo1X+BBVac/gy+gsXDOlHI2C6Sxdhi3d4Z
	UjHkAXNazpw96QRTVKOzinvW4QyvBMjculzEe0biJsEjHiTnrsbf3d5VTKjyLd/OecUQ0miOCSv
	PGrQLhSADGm8oPePUWDeUFHK8a+C9vhIxKn4h/vd/aQ99AosncVUj8uUMkfC7Z1B2GJEakjEZiE
	B5QtdJvkOvB99XYgNn6FnksFFMNoBMIQcx52qy08kPwqJL0MdgOPaMCU7R0gYihEZwYBJHIY3oH
	sckaTJn0osSaBpPNCGauDL+ez42IhR0e4aLY=
X-Received: by 2002:a17:90b:1806:b0:380:fead:448d with SMTP id 98e67ed59e1d1-38f6a40bd7cmr1544959a91.13.1785222397641;
        Tue, 28 Jul 2026 00:06:37 -0700 (PDT)
X-Received: by 2002:a17:90b:1806:b0:380:fead:448d with SMTP id 98e67ed59e1d1-38f6a40bd7cmr1544915a91.13.1785222397193;
        Tue, 28 Jul 2026 00:06:37 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm59846776eec.4.2026.07.28.00.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:06:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 12:36:13 +0530
Subject: [PATCH v4 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-eliza_evk-v4-1-decc7fe5246e@oss.qualcomm.com>
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
In-Reply-To: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785222387; l=12425;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=C5M1E+YmUcs9AY4RLjgkAzdle4UtMia2apOxFdvce+k=;
 b=aA4Aa9cQVe0tQVhBCDN+itb76lUA4yLciaou9z1DBPFl96O7ZV4lDSppAzmopDvOtM6rtSZaS
 a6qHcQcVZV8CPj7m8y50R473Xfae1lczSJeFE5Toi7sbpxZVHeSW+Wu
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfXxx49YB0uUNEz
 WztU5hCei7crEv9j2LQl7cuVrg6At6caT4wTHNziCngudiEGmuEXRg03OCdjT0+o/WgTSxmFuyA
 Dydrj0FS06FJ09fKfWaQiwVxO5GGTx44ga1Mvltaft7sQvchggb1QD6ReDW/O5LBHOobCztMXgz
 XTqCe+CFCOTOWqu3T1SXA0xGGg59bo33CQSlCUhIj+WoplG4bf8US3lkiuWnMvOhptxywU5ekD6
 q8QomoDrHxbJbHFhmSbODY2pFhoM3+/nAzjeSGnPZ99qUnRrmyDwkKuTRdBBPrN1LY4RRg8vm7d
 JFNa5Y6tfzFhc0XbnrtAdsmY/vgbVaf9n3xwrx+wNF6Ne9p6FbRyG9pffHhlrnRi27wbjQmc1Oo
 OIzqZTiYTzzsnKKzaOwsQ9VggYBWjYmqboIQiKqVypiRWIXjmIvHtCCD/VfCE4uyoohBUVnyAPh
 6i/3rCsznC9U/5nzZGw==
X-Proofpoint-ORIG-GUID: fKSlcrqjCcdv9pvRMgkWiLVCme4j09bG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX1+FKqRjk9Gqj
 t+ooPrQTdQKlRvHK7GpFdR7ox/HkBy56HZZ0Eu/3i1eFQ4NlpTIgxaO0G5PHnSKJ3iZxzZHYbSB
 zNo9o9G7s27FyMdpvkzWZ9906xTJKU4=
X-Proofpoint-GUID: fKSlcrqjCcdv9pvRMgkWiLVCme4j09bG
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a6854fe cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=OqFm7pk_RYcY2ZoNfNAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280061

Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
(PCIe1). Add PCIe controller and PHY nodes for both instances, and update
the GCC clock references to use the newly added PHY nodes instead of
placeholder zeros.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 413 +++++++++++++++++++++++++++++++++++-
 1 file changed, 411 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index 977de44b816e..a54a956531e5 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -640,8 +640,8 @@ gcc: clock-controller@100000 {
 
 			clocks = <&bi_tcxo_div2>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
+				 <&pcie0_phy>,
+				 <&pcie1_phy>,
 				 <&ufs_mem_phy 0>,
 				 <&ufs_mem_phy 1>,
 				 <&ufs_mem_phy 2>,
@@ -1786,6 +1786,369 @@ mmss_noc: interconnect@1780000 {
 			#interconnect-cells = <2>;
 		};
 
+		pcie0: pcie@1c00000 {
+			device_type = "pci";
+			compatible = "qcom,eliza-pcie", "qcom,pcie-sm8550";
+			reg = <0 0x01c00000 0 0x3000>,
+			      <0 0x40000000 0 0xf1d>,
+			      <0 0x40000f20 0 0xa8>,
+			      <0 0x40001000 0 0x1000>,
+			      <0 0x40100000 0 0x100000>,
+			      <0 0x01c03000 0 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0 0x00000000 0 0x40200000 0 0x100000>,
+				 <0x02000000 0 0x40300000 0 0x40300000 0 0x3d00000>;
+
+			interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 537 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 540 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 653 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
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
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
+				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr",
+				      "cnoc_sf_axi";
+
+			resets = <&gcc GCC_PCIE_0_BCR>,
+				 <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
+			reset-names = "pci",
+				      "link_down";
+
+			interconnects = <&pcie_noc MASTER_PCIE_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc_main SLAVE_PCIE_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			power-domains = <&gcc GCC_PCIE_0_GDSC>;
+
+			operating-points-v2 = <&pcie0_opp_table>;
+
+			iommu-map = <0 &apps_smmu 0x1480 0x1>,
+				    <0x100 &apps_smmu 0x1481 0x1>;
+
+			interrupt-map = <0 0 0 1 &intc 0 0 0 564 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 565 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 566 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 567 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			#interrupt-cells = <1>;
+
+			linux,pci-domain = <0>;
+			num-lanes = <1>;
+			bus-range = <0 0xff>;
+
+			dma-coherent;
+
+			pinctrl-0 = <&pcie0_default_state>;
+			pinctrl-names = "default";
+
+			status = "disabled";
+
+			pcie0_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* 2.5 GT/s x1 */
+				opp-2500000-1 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
+				};
+
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+			};
+
+			pcie0_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+				phys = <&pcie0_phy>;
+			};
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,eliza-qmp-gen3x1-pcie-phy";
+			reg = <0 0x01c06000 0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
+				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_DIV2_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "rchng",
+				      "pipe",
+				      "pipediv2";
+
+			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>,
+				 <&gcc GCC_PCIE_0_NOCSR_COM_PHY_BCR>;
+			reset-names = "phy",
+				      "phy_nocsr";
+
+			power-domains = <&gcc GCC_PCIE_0_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie0_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		pcie1: pcie@1c08000 {
+			device_type = "pci";
+			compatible = "qcom,eliza-pcie", "qcom,pcie-sm8550";
+			reg = <0 0x01c08000 0 0x3000>,
+			      <0 0x44000000 0 0xf1d>,
+			      <0 0x44000f20 0 0xa8>,
+			      <0 0x44001000 0 0x1000>,
+			      <0 0x44100000 0 0x100000>,
+			      <0 0x01c0b000 0 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x44200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x44300000 0x0 0x44300000 0x0 0x3d00000>,
+				 <0x03000000 0x4 0x00000000 0x4 0x00000000 0x3 0x00000000>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
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
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
+				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr",
+				      "cnoc_sf_axi";
+
+			resets = <&gcc GCC_PCIE_1_BCR>,
+				 <&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
+			reset-names = "pci",
+				      "link_down";
+
+			interconnects = <&pcie_noc MASTER_PCIE_1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc_main SLAVE_PCIE_1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			power-domains = <&gcc GCC_PCIE_1_GDSC>;
+
+			operating-points-v2 = <&pcie1_opp_table>;
+
+			iommu-map = <0 &apps_smmu 0x1400 0x1>,
+				    <0x100 &apps_smmu 0x1401 0x1>;
+
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			#interrupt-cells = <1>;
+
+			linux,pci-domain = <1>;
+			num-lanes = <2>;
+			bus-range = <0 0xff>;
+
+			dma-coherent;
+
+			pinctrl-0 = <&pcie1_default_state>;
+			pinctrl-names = "default";
+
+			status = "disabled";
+
+			pcie1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* 2.5 GT/s x1 */
+				opp-2500000-1 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
+				};
+
+				/* 2.5 GT/s x2 */
+				opp-5000000-1 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
+				};
+
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+
+				/* 5 GT/s x2 */
+				opp-10000000-2 {
+					opp-hz = /bits/ 64 <10000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
+				};
+
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* 8 GT/s x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
+				};
+
+			};
+
+			pcie1_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+				phys = <&pcie1_phy>;
+			};
+		};
+
+		pcie1_phy: phy@1c0e000 {
+			compatible = "qcom,eliza-qmp-gen3x2-pcie-phy";
+			reg = <0 0x01c0e000 0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&tcsr TCSR_PCIE_1_CLKREF_EN>,
+				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_1_PIPE_CLK>,
+				 <&gcc GCC_PCIE_1_PIPE_DIV2_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "rchng",
+				      "pipe",
+				      "pipediv2";
+
+			assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			resets = <&gcc GCC_PCIE_1_PHY_BCR>,
+				 <&gcc GCC_PCIE_1_NOCSR_COM_PHY_BCR>;
+			reset-names = "phy",
+				      "phy_nocsr";
+
+			power-domains = <&gcc GCC_PCIE_1_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie1_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		ufs_mem_phy: phy@1d80000 {
 			compatible = "qcom,eliza-qmp-ufs-phy",
 				     "qcom,sm8650-qmp-ufs-phy";
@@ -2843,6 +3206,52 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 184>;
 			wakeup-parent = <&pdc>;
 
+			pcie0_default_state: pcie0-default-state {
+				perst-pins {
+					pins = "gpio78";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				clkreq-pins {
+					pins = "gpio80";
+					function = "pcie0_clk_req_n";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins = "gpio114";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			pcie1_default_state: pcie1-default-state {
+				perst-pins {
+					pins = "gpio54";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				clkreq-pins {
+					pins = "gpio52";
+					function = "pcie1_clk_req_n";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins = "gpio53";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
 			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
 				pins = "gpio28", "gpio29";
 				function = "qup1_se0";

-- 
2.34.1

