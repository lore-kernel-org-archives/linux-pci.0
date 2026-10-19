Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5F4AA3F0
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401964; cv=none; b=R6IvwerW8EcPjmbuW24JNlK853DS/AnYS6b0Qt0sEX2nFKihspMvGjbS912lPls6T2yYC5hyxPwAMVEyMaQrbCGzb0pPTGOx8AJi8va/1iniAeEC1D+ZywkdGV4wzzxD+ap8QcjbyvV7IaTd8cFY18n7CCYR+OMyQtCYPqmjW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401964; c=relaxed/simple;
	bh=QQjgZjODuP7hhVx8o8nUzoend12S7wxNrmIDVLN6/EI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/rPXBoC/YRqvCCF8vTWsD4VZLoq0Kn0Ecycik1McHK/uobjPut8POxLT3/2w6qSM6JKzMkDfsexOwAuXYsnJe056wOoieOp5Sh9siO84+2cubykKmvoRPfkXzR4S5MUUXQ8FaYbbKulRGX2EH3jnr+Nu0UwCLSiKp94rXEwtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VfNpL+Sq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gNJ1pKom; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VfNpL+Sq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gNJ1pKom"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Oupw1665669
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yneraFtfNzmUal/3Wx1LaAn1j7QA6EjbSSPtCDfhHdY=; b=VfNpL+SqHCFLgkZU
	/nmhS3Kb8XV0caCFlh2txOAWseHatOGnSrL5nsmmh2qSnyybsDytTlit/Y+CNxdm
	Q26Yj1yKbOphmNzi5mTCh/kk6542yOctWKu71fynKGtVfosdU/lhYGyA32aKDqnJ
	x4OgEd/lmQaUb5o2MwgTz/8fuD5CLHchB42DybbHbQm9YkEpQtrTroDey7sYoNuT
	xY0MFh1hpCN5q6SVygbMOm7q9gvQzIUdkECB6l3xp6256cvxcJ+l79CrrmnFRxAZ
	+ZID16IFc7B765Nu0yftEj3Ab6ZZ4Gzin7+9vJOG53InxC1nuXAZkbqjGfG/9nb4
	ajJuwg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0c9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:26:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3552883bd19so5135618eec.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401961; x=1793006761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yneraFtfNzmUal/3Wx1LaAn1j7QA6EjbSSPtCDfhHdY=;
        b=gNJ1pKomRchF5EOhrk9q1HpSe+DP5FQB7GT0K7HIQXEszdm7ucaVun4I7VbylJimA4
         ROmIRm9tXrdZZuOB90HJCRt4Ri2/qGO2xLMcOf1T4I3DcoUL7v91yO9nMG2mQhODBkeB
         PfNnj1U9ob1RsT1Gm/aUHWoDSxlm1d5KelENjr3/8ifxP3nyQ2QqJ2mgWi+XRzsMt0Ig
         H2SMaB0THfl14SLEeURwW/xnxxubu6aVVkg7bsVOcPHFnVPDUzdmCSjV7m3iXLkGmC7q
         +Wr0lEtAz1ReGlJFtUe3hAcujwbD42n5tJAtv3X4CMtKks/3F/qRO8KypaBJDO5CeFMZ
         c+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401961; x=1793006761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yneraFtfNzmUal/3Wx1LaAn1j7QA6EjbSSPtCDfhHdY=;
        b=lvRGXR6Lmu6jX8Lyd1YPFcbx5sWnbiP8N2XbTfF7eOfi/PLkf+1c7f6aK1ZgCNGXxi
         2whMvuBsWLxGe5LOZTF0K2qIWtVgcjLLeMCu9WGU3Bj5oB7e/PbuewL8shW1N9EAzM4h
         vkBRgvcj0wku+h/q9K4NA/8M7TvFFZCILV63lZ1zY2EgRI6lliTs4FNwiBtKKOTL3Mcm
         qFF0xbI9NGWPF7G/8A9aN29CYBaYRHZeQLlfsrZAgvuQYOX9vSlLCQtLF+OrXPSSkiRc
         XWb0XzIRxm/IrKOMSkG/OYAkg+SHogpfXzoybnjDjwbWcm+NFlHnKwmx0EFUW7aKbsrV
         yn0w==
X-Forwarded-Encrypted: i=1; AKwUvBy4yKLEPYMhx+Ykmo4wgSw7BxQhH1yr+quqZgpmFFejpnNT3QQDMOIc36mk3cNWOrSaaJtBZ7FapcQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpbDfHoQ6lg4U1yvjtDwXUd5qIyul34K1AgoLj5IPn9mdr2Vvx
	s6fPkXlLNztx6+YMNyXgB2AFPUzoktbFkTMV4fosSm+4Vso8wjosqsUfJhONQx7G2tbRXsDaoUF
	1Fn8Xx0ySBr7oBgV89iMrAuOhz1Y8eZ8MrlInPx/Sxs77UFdVeyUz+iXZJMjRsxE=
X-Gm-Gg: AYBFou0XfiMJQ0LPA2QKcLU6mE8udixPqxU3dBVPsIFWgWxWJgBIhT4/ZpR6ypNu/6c
	Iydx4/9x0g7UEBb4pD1sGvfov8t/ua2IhHQCDrXbF5zyOg0lA9DM926t0P5oVJDIQxmAG9OGY+4
	+q87zKb8pljtBSdj2VCkZ/sMk+bnPHELCrvJ13zNeaGBuColB5P1fKcjqHYkZXx9a3C38YHmjhq
	NSQtQoOgtsRxfNLezkv8rq+2FmyuccueD+3VneSl7uaG+HkpjsOHBWdL19wogWy5FJxSSklXSua
	KH0LCqsz0fjs2CMXrGES7ELhZDl5Mamvh8v9zOVRuamyzZ3g2y2SnzQQtVm4YvqzU8tqr5O75C+
	HXywY8ck5iBKKXrmE7NaQjNC3J0wAHcUxtA==
X-Received: by 2002:a05:701b:4559:20b0:185:1640:5536 with SMTP id a92af1059eb24-18516405571mr10494516c88.19.1792401961031;
        Mon, 19 Oct 2026 02:26:01 -0700 (PDT)
X-Received: by 2002:a05:701b:4559:20b0:185:1640:5536 with SMTP id a92af1059eb24-18516405571mr10494480c88.19.1792401960341;
        Mon, 19 Oct 2026 02:26:00 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm26682584c88.21.2026.10.19.02.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:26:00 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:55:14 +0530
Subject: [PATCH v2 6/6] arm64: qcom: monaco: Add PCIe Endpoint nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-monaco_ep-v2-6-852cb9f5d012@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
In-Reply-To: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792401919; l=6008;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=QQjgZjODuP7hhVx8o8nUzoend12S7wxNrmIDVLN6/EI=;
 b=z7m+XMbkt21+9eCzUZdH8SNmIbKm1ID5BOSHcoGEu4MtxC8Uj1JLiy6MSJOugr0gHZZu0Svve
 tNU62Bi80yeD9PQ2GbM7QoiThZ211AYgC6UNdnsX6GVqfvwMPvo3GJ6
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfXya6RD4pE3JLs
 CVw2u3Wqu3x/5qs3dzBcQkmwmmV9BIAM/Z0iy2xo0kuCwBtd24VLjvymHVu4HF4p4hJeFsb6+TT
 xytfUuIeIdGILmIGGDmftD02UQiLEg4=
X-Proofpoint-ORIG-GUID: bRhlgeaon48NpEfbCi30ZWYHqI2fKj02
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX47BYpOHlZ05h
 SWREN+jJ3GFD40A05KtvE9TnSddfeHgb95n3r6hBs3RDA9uds0hpdtsBNsk4VTfobdg5QkBZ0pI
 rx/GTELdMoyLes511eF+4DDpreOj77bTCy79UwNKWEXbKAJW3WqMY8uDn69cdgBrz3jkRcvJHUR
 VTAJG/NL+mB06MELrpHGdbnG5xMCmGxlAk0G4Wfr9rXythoJwoqs9ZABf10xzT6as5EdE14PArM
 VqFvyuhZUHVf4tbGEWYLI7HqQdO8xwPpC/0gcSv3JWQjuH8IJS9GZ7MT0QWdbWDDhEOdk4xRxPB
 VTis9TBDo1Uob3A3evBcuOLxFBwpItrKqHCp2QOrxxFt0dRrkz9B2ZmPD6en4R2CACCcMAgankj
 DS1DMgSeJTuyx7sI5UfvKPlaKcL8PR6wdITMsKf5bjE3kOFF7Bw/TUyvAcL8AiNfTb9obFcZEPN
 Z/KR01j2yqoGCl138nQ==
X-Proofpoint-GUID: bRhlgeaon48NpEfbCi30ZWYHqI2fKj02
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad5e229 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hNZP5i6h11z2s_4BSHIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037

Monaco has two PCIe controllers that can operate in Endpoint mode.
Describe the Endpoint nodes for both controllers, including their
register regions, clocks, interrupts, interconnects, IOMMU mappings,
resets, power domains, and PHY connections etc.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index d7d135e87a8c..12cd7d5f37a3 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/qcom,sa8775p-videocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
@@ -2405,6 +2406,57 @@ pcieport0: pcie@0 {
 			};
 		};
 
+		pcie0_ep: pcie-ep@1c00000 {
+			compatible = "qcom,qcs8300-pcie-ep", "qcom,sa8775p-pcie-ep";
+			reg = <0x0 0x01c00000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf20>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x4000>,
+			      <0x0 0x40200000 0x0 0x1fe00000>,
+			      <0x0 0x01c03000 0x0 0x1000>,
+			      <0x0 0x40005000 0x0 0x2000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+				    "mmio", "dma";
+
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a";
+
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 630 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global", "doorbell", "dma";
+
+			interconnects = <&pcie_anoc MASTER_PCIE_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_PCIE_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			dma-coherent;
+			iommus = <&pcie_smmu 0x0000 0x7f>;
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc GCC_PCIE_0_GDSC>;
+			phys = <&pcie0_phy>;
+			phy-names = "pciephy";
+			reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 0 GPIO_ACTIVE_LOW>;
+			pinctrl-0 = <&pcie0_ep_default_state>;
+			pinctrl-names = "default";
+			num-lanes = <2>;
+			linux,pci-domain = <0>;
+
+			status = "disabled";
+		};
+
 		pcie0_phy: phy@1c04000 {
 			compatible = "qcom,qcs8300-qmp-gen4x2-pcie-phy";
 			reg = <0x0 0x01c04000 0x0 0x2000>;
@@ -2596,6 +2648,57 @@ pcieport1: pcie@0 {
 			};
 		};
 
+		pcie1_ep: pcie-ep@1c10000 {
+			compatible = "qcom,qcs8300-pcie-ep", "qcom,sa8775p-pcie-ep";
+			reg = <0x0 0x01c10000 0x0 0x3000>,
+			      <0x0 0x60000000 0x0 0xf20>,
+			      <0x0 0x60000f20 0x0 0xa8>,
+			      <0x0 0x60001000 0x0 0x4000>,
+			      <0x0 0x60200000 0x0 0x1fe00000>,
+			      <0x0 0x01c13000 0x0 0x1000>,
+			      <0x0 0x60005000 0x0 0x2000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+				    "mmio", "dma";
+
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a";
+
+			interrupts = <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global", "doorbell", "dma";
+
+			interconnects = <&pcie_anoc MASTER_PCIE_1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_PCIE_1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			dma-coherent;
+			iommus = <&pcie_smmu 0x0080 0x7f>;
+			resets = <&gcc GCC_PCIE_1_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc GCC_PCIE_1_GDSC>;
+			phys = <&pcie1_phy>;
+			phy-names = "pciephy";
+			reset-gpios = <&tlmm 23 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 21 GPIO_ACTIVE_LOW>;
+			pinctrl-0 = <&pcie1_ep_default_state>;
+			pinctrl-names = "default";
+			num-lanes = <4>;
+			linux,pci-domain = <1>;
+
+			status = "disabled";
+		};
+
 		pcie1_phy: phy@1c14000 {
 			compatible = "qcom,qcs8300-qmp-gen4x4-pcie-phy",
 				     "qcom,sa8775p-qmp-gen4x4-pcie-phy";
@@ -6225,6 +6328,50 @@ tlmm: pinctrl@f100000 {
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
 
+			pcie0_ep_default_state: pcie0-ep-default-state {
+				wake-pins {
+					pins = "gpio0";
+					function = "gpio";
+					drive-strength = <2>;
+				};
+
+				clkreq-pins {
+					pins = "gpio1";
+					function = "pcie0_clkreq";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				perst-pins {
+					pins = "gpio2";
+					function = "gpio";
+					input-enable;
+					bias-pull-up;
+				};
+			};
+
+			pcie1_ep_default_state: pcie1-ep-default-state {
+				wake-pins {
+					pins = "gpio21";
+					function = "gpio";
+					drive-strength = <2>;
+				};
+
+				clkreq-pins {
+					pins = "gpio22";
+					function = "pcie1_clkreq";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				perst-pins {
+					pins = "gpio23";
+					function = "gpio";
+					input-enable;
+					bias-pull-up;
+				};
+			};
+
 			cam0_default: cam0-default-state {
 				pins = "gpio67";
 				function = "cam_mclk";

-- 
2.34.1

