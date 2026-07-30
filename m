Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADF428820
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412852; cv=none; b=Sa5MhkaN/LGwUAxxWf5fKYsGh8/FabPCCnoQa4NowQRGs1s6i52bR+FsjZ/q6qI724ZYQVOqXUqb7PRTYzn3J0kOQulrccKoMBxia6m3+NUMDVYPT6z6gCHyvbDjNesQnPHpsoWgnyLsXievsBbnZM45XgLVCsKvyUnxYgwH7sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412852; c=relaxed/simple;
	bh=hdamjN2RtZB3GrVKQNXZcWEgKcsU6vqnQnfY+Ah3bJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMLcs4IbfOVCLiL0JiICOEHEFPSVP7uY7nkJLjxEtURLJMdYkC/ECrCD6L1MMIuMdrjY5J36r77O5MK61asy/DADMRRnGgOkK4DcUR7vme7oSZg2grSNQIiUUV4npvp41UJopTZofaB2PsENED75sI/BitNKz1kctr7a2xWaZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eKyu37KY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VibZUUWX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKyu37KY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VibZUUWX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UBW9P01144201
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mldFWAYrKZEdlkWCYfZfFPQcsgRjSCX0lAxttfeZ9sY=; b=eKyu37KY2YZFYbVN
	bRKMyG+RueOa5qbFpwRXlpLR2o4Jv/tZwtQe/TijDhNMbEi5qK3FMZNaZUhiFW7G
	8xrb4jWbjyI67wU4HCFw/bLht8Zu6VPfWNCc/1I/BFCRsisJCbv7butGsq85f0z/
	4Y+SNancZmyvTsOSYF0UWENuXz9RRw1StJC02eu9K2E3tc00VXz+zaFYWPeKcf3W
	8i9SAhn4dLNwUZNKjBU+V/NTwGb97MP/kznfEFAT2tj0Sg15rLiPb3DfuWXxA89c
	ZDAEbwODzDsV7NeZo+x+Wxt6MzC7KrWj3WId+LL7rgfIOLjiMuEvQop9Pjvgr53M
	m1SLuQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr5tvr355-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:00:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso1912821a91.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 05:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785412850; x=1786017650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mldFWAYrKZEdlkWCYfZfFPQcsgRjSCX0lAxttfeZ9sY=;
        b=VibZUUWXXcCgnt/C9h+McDN340dlkV5XUgRTR7HETpglvqq9zysda8RZwZcREgQzfK
         Vk7+Kd3p9OuXmv9uodl5abNz73vQgmutstdqimwxFpLEiz4PXU91e0Nr3z2TdSPzbwg8
         EiRR4wr2VQzSv1+vuDl1gu4DbhBP4Ok151D5E9HcvsKiX7kKdjZBHePYtCQazIfGd96C
         LUuYGJaY8ocrbICJZE1QA1f+QWQoe/zwjN0U4XGF8Qhjd8qf22MT/aiANZxn1TF0Np9P
         GBaqhAp3ZVp+0Dcu0tGBFmocM3+cmYkh6/Tnh0yNebs8w4DHU16MFiwPr74koUXzS+ot
         IARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785412850; x=1786017650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mldFWAYrKZEdlkWCYfZfFPQcsgRjSCX0lAxttfeZ9sY=;
        b=Nr79T0/QFTic9uS4cqOEdXMjDq8dXRYyprfrnJFyW4c0oVi+CUzVYnK0up52IfW8BS
         ZiBIPXpnJ6jPMJwUsrSJWpjxMkwgrIsFck8XYdXUg3UsIG8O6umnBo7nThXfiHH5FXIg
         0K9AheAvkr2mIdjqGfUAETpHxdjDFnb043O+FOjdZvBsxk/fkukN9f4Y8pFWRmzfTD8v
         qgMVS1yQ1oIZ5AZXtDMaWsBWEvIVOnmeSkDvPkEtJ2IVLm1Met/Tdy6KEK3XN5x5pp5q
         L4H4O4MBM5Haulg4NbM7w3yMG94mFBTaVxvBCm84qXhkWYPNKxokOnvXSZeNovywG9eV
         Wb2Q==
X-Forwarded-Encrypted: i=1; AHgh+RoqknHD1wK/Wqt+uIAxFbZWcd0mkQKFjmt8FSGber+2wFw2kJYiatHHO4q89rwyl/7uI1p47yZOAcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC9At7gt1e5QwrqEn6txu3BIr944mKcic6l09DNPKf0+el9Kw5
	gWcXvLhWvbcb8lr7WjtQtERZY0jxs/YvQwLXEbIEjTVGwRnoxP9hJN5TinbFrTfQxPm4vdfc/ex
	ua1+QhFTn3I8eESyM2gMzK6s1FmNSYmTfc2JBPVziDo9s5CvxQ4dDZLCeTf23p+Y=
X-Gm-Gg: AR+sD105EVPfQPxG6PHHJceEk0xI0i1fu5M+77qvavx5z+uQGJnItv1bXP6582pC8xb
	jgMAgKPEWVudkLOxd2xP0Fyoc+jswd2iYcWSrZatqW8/IQjrFTE+IW/u0PZtrjp7R7Y/rZneWfA
	qia4cP0DKqmVCAEXokvLgfHr1InxNT/5LbgHOp2KhUoSiALJ8mv1EE2GcHngIenmjzzIgW7dlnr
	7kqqIbp4XpeAwIj3zyPs7LqejD7zzUBsr0C3WRyqLhtLX/7KDdyynjoxJfyva7PI1vDOsGpKrd3
	vz0PVHp9Lb0P08m6q8iRhBND4P9txTjGmfAd+v5KyF6RveQb467DZlifv2MlQaqAn+eKbd21Csu
	Kn4YeR/V3OVYQJMCMXvvJY1PN6IELssSNDsc=
X-Received: by 2002:a17:90b:35c1:b0:38f:57f3:4dc7 with SMTP id 98e67ed59e1d1-38f9c021366mr2236738a91.26.1785412848889;
        Thu, 30 Jul 2026 05:00:48 -0700 (PDT)
X-Received: by 2002:a17:90b:35c1:b0:38f:57f3:4dc7 with SMTP id 98e67ed59e1d1-38f9c021366mr2236611a91.26.1785412847122;
        Thu, 30 Jul 2026 05:00:47 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13f9a041e36sm7822776c88.7.2026.07.30.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:00:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 17:30:16 +0530
Subject: [PATCH v7 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-eliza_evk-v7-1-7ac7b66a3e6d@oss.qualcomm.com>
References: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
In-Reply-To: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785412836; l=12737;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=hdamjN2RtZB3GrVKQNXZcWEgKcsU6vqnQnfY+Ah3bJQ=;
 b=YG9VbyGPFN7Xa3s8DcJgsA7+cnr4s8Y9P0/8N/fW6GfHrla+j8x47ArFHkFbK4Q4qjBgbIYZi
 2Fr1P9ckxQOCoEB9yNgRVJEq9ywbwblrD0mM1eF8I/V1VM3yHRKvsJ8
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5MCBTYWx0ZWRfX2MykRZtYmula
 qh2m3AsTuMLxJETiqVAwxFcrzPOpbVMWKlhVw/XfWpCg1MyFnuJ076sHqPbKf+rX0vVw5ZmxbBI
 8Uggk9UU/4ZxzReqiyAXjRsbiV2yrUE=
X-Proofpoint-ORIG-GUID: 4RGQ8-LorPtNGRbDkNV8OqK3q-j1mRy4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5MCBTYWx0ZWRfX5M1x1oH/f/Cb
 +g7+E2gSNXaQH/DN/DKC4QxN3EBqLnIagI9uvIdS6JKxXSajbZMCYmRmFhf/DH3SI8cvDy3aNAI
 msSmLFJbvL6vfJzkxASJy2frW3AXlfxeH8cqC9oe/XlUJ4zmF3dAgPCVBptF1N2uBewOo1uyumm
 u9FQ02Ek9J5OJp8wXgQ1zvf/DL3riE7cngCi7PG/12+bCEv6AcFiYzLOtnKy3YiJzxv92rWQupf
 YndPkQ6kJNwMQyjdgE8uyZ2YshCVRRsL4JRiZviVwlONm9NqhDmu4PyfQvMGg975uExyAYLZiJE
 Zy+GC1xt3FQYR8V5/DAQ0BjnRCOHn3itCMu/LkvuMsxJwIf14zJKtoSH8KjlchQTRZFXxIQ9ofQ
 JFXDBxmgoLVY1p6c5RsG6CE5zme+x6eh17r84gZICTaiQNrhT52e1PycfWg7S00fOa0fc/guN1S
 0dS3G5QtwAU1+dPw5Mg==
X-Authority-Analysis: v=2.4 cv=ULPt2ify c=1 sm=1 tr=0 ts=6a6b3cf2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=BxXhfxRA4Qf77SbpDdQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 4RGQ8-LorPtNGRbDkNV8OqK3q-j1mRy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300090

Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
(PCIe1). Add PCIe controller and PHY nodes for both instances, and update
the GCC clock references to use the newly added PHY nodes instead of
placeholder zeros.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 413 +++++++++++++++++++++++++++++++++++-
 1 file changed, 411 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index 977de44b816e..cb6f36b8076c 100644
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
+			reg = <0x0 0x01c00000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf1d>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x1000>,
+			      <0x0 0x40100000 0x0 0x100000>,
+			      <0x0 0x01c03000 0x0 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x3d00000>;
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
+			iommu-map = <0x0 &apps_smmu 0x1480 0x0 0x1>,
+				    <0x100 &apps_smmu 0x1481 0x0 0x1>;
+
+			interrupt-map = <0 0 0 1 &intc 0 0 0 564 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 565 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 566 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 567 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			#interrupt-cells = <1>;
+
+			linux,pci-domain = <0>;
+			bus-range = <0x0 0xff>;
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
+				compatible = "pciclass,0604";
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
+			reg = <0x0 0x01c06000 0x0 0x2000>;
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
+			reg = <0x0 0x01c08000 0x0 0x3000>,
+			      <0x0 0x44000000 0x0 0xf1d>,
+			      <0x0 0x44000f20 0x0 0xa8>,
+			      <0x0 0x44001000 0x0 0x1000>,
+			      <0x0 0x44100000 0x0 0x100000>,
+			      <0x0 0x01c0b000 0x0 0x1000>;
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
+				 <0x43000000 0x4 0x00000000 0x4 0x00000000 0x3 0x00000000>;
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
+			iommu-map = <0x0 &apps_smmu 0x1400 0x0 0x1>,
+				    <0x100 &apps_smmu 0x1401 0x0 0x1>;
+
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			#interrupt-cells = <1>;
+
+			linux,pci-domain = <1>;
+			bus-range = <0x0 0xff>;
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
+				compatible = "pciclass,0604";
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
+			reg = <0x0 0x01c0e000 0x0 0x2000>;
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

