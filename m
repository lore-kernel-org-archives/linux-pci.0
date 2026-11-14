Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618832;
	b=jqkUqV0Yo6xNWEZqcZ1Ou8Nh6aIG+97z7xaRJ+T313yZ+4n4gqbY64f04It3tkyKe9I8
	 NKcGix8HzDJJnn7uNr4D+82pRDKdcNncaz04uJWtPHe94a+3xcUJpw3odo/ItCt3qcIvF
	 D3b1UxGUqW2ld7tAKm+fYzvsle+Bu95Tf6ZgEINsSzU+6pq1pL3rktHCR2TGRk4ZohDfB
	 xZ5bBi6ppGnCqwvfTGtbSzz2khQ/C4Qc/5OebSkz/Pecfy03+5gAC9GA0oSmwNKadB3G+
	 9lkHo/IRVYqceeX13mbumf+fcE8nUe4BUnni1NwI9s3aj8Xor6CgbmmCgnePFjZJCkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618832;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xa2yBRKrVwpDPP1DRDU0RWXac09ILbJ4aA8qjd/NqFA=;
	b=ycd4DSHW6lwbFVDtyrJa8mgpIC63892+pkZhJ8dwi1qQFYmZdLeeuSXurU053ocnrsko
	 ektMVyjFQbMHH+B+bY+tio916VfQntlcAE/8kTMVQkPpyip6XGTOuICVoIXmLIEiTX/q6
	 VetHRdETy7OhZKyuoL0bwdTocWrkqjmRge6yUMsmb14uxeq//GK0l3ZFmr6iyuJR0Vq6g
	 Ki6dld7N517jZXKCQlit2ALs6q6mwxo+SBZz2Ya4ZrED7xxRCMklOWX8mqBxFfrLxmdIU
	 wpxOVaFOSzH0JACJcScQfvExrAt3fwtGZrWHaPYw/PLXhFB1CNfoJW9cO7q57QUht8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TvXxghXl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Ph6aBd/t";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401BC606A88B
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 401BC606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TvXxghXl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ph6aBd/t
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADMax0o2312211
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xa2yBRKrVwpDPP1DRDU0RWXac09ILbJ4aA8qjd/NqFA=; b=TvXxghXli/NERShK
	lRziK11vQKFCUAa+qIOXMaTzIkMb4BTPYIV8G33dXQ+OJH7zkjmQNVV6M5paWk3P
	+nS1ozi3i2XQKnZ+aCUhJQmM8bUzkBQUT6WM7DmlGncUXHo9pw4VwDA06kQSeTAT
	hCC4Jn4OFLzUrKLDMWY3IiWcavGGZpP4m2YaTNx781hsV3yhSeRAHT4Y86muQrt6
	2wcakM3THVAMa7Td9kGNl5WMGjl5js0t81qUiy2jQuUBytT7+WbBygVQX2QXRg4m
	DOeLC3SaoZtJsPBE1cPOtcAJMrl7bZX3C4Rysx0czgeAcNtJrS86/8gmM2G10u+5
	T8AJ9w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx9pdgvb9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-378722fd4a3so1824079eec.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 17:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794618830; x=1795223630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xa2yBRKrVwpDPP1DRDU0RWXac09ILbJ4aA8qjd/NqFA=;
        b=Ph6aBd/tZf5LC3ho61DxZb/8/1LfdlCmNBaiMnAnqOTDF7cDJbV6J0H2JW+S2Q6uWk
         FkGhVlC30vPz7kj1Gmmcn3jja9jqF+Sp/Nc074ZRVBJ7foK48Xv+FWiUX5RfznSE7hEC
         bp7q4+Ar7TMfVCjhYnOUNTPVAomFHEn+oj0/tmEWUAcRnzC1vs74ebkvENCr6OLbwa8U
         fC4s9SZoa2XEFTqvuRuECtiY/ANBw9wjiDmbaSpuSFQcdtDRP6RjwZ04geIO2YSSLY0b
         WboWNFBFCxVUt6qQujVp7J62bZGsVQygyDFZcwYB78obTKQatCXggriVULbCaM2jEYqh
         PjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794618830; x=1795223630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xa2yBRKrVwpDPP1DRDU0RWXac09ILbJ4aA8qjd/NqFA=;
        b=NVnfPumHHF8bzOGlTdIBLouQrej55x0NYJBym6dFOjKAKedjUalOv7xneXgnDFDDa0
         eSmVBWU8H4++PXzPauzq8y1bXutPHhof4oFaFiF6S/P7BahindPxKgTgQvNa/SNHlxpf
         DOjtZlqLg0ikK+e3b5DFNdUnd6h3uEsG3jpOL4VO/9qwK+8WhB6VS9hD53lR+hTZ0649
         Wav76fyI6jAXDHq+bmGTZd9uqsaeXP1e2pwr5mkCfWxj4FCBjDjF+wQ6UgDr4B1s5vC5
         y4MR1GTSiR0v3RaKo7A7wtqzXavSgGpcnbRNJMY0V+3J69G8aYAIxtkTjMibdf5qufC2
         /LRA==
X-Forwarded-Encrypted: i=1; AL+hErHie7/BZPOXKJZYMNeTCM7/wofTjtbMaOyA82hyDsl6ZN8WQymgxvcPfg49t02nzLSZvcdd7L2wQRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PCWzWlVCx4A77TZS3yCam+rTXRkKDTUjcDKA8YQglBcaY95SG
	itxbptwpef1eMzHDtSUU0Wkf1WwhCqd4yBuLWMnue6/rOwJ4Wbh9976+lqxvZi6y63c6lrG1TCF
	B6YjwxH8qiw//kAfNxZUPjfgw5wDTcIjptMSQopxJwVoFNfZChKSzjU44AW3Jk4s=
X-Gm-Gg: AYBFou37z0rdtayrvkTGZzRFa53ympJfxPddm2nQm3Zz7Y4nhSeDQEX5PsGlwaZ8cFU
	RbgQBUHei06Y7FIEcFfzXZhuJkcr8pmzgUV3VNZQxmrZXQ8/5YDMUDITo5MqgDCLwvT3B09nIJq
	B3Zhz3HnGHvHRY2MrbqNTaHaZ5nsjQFQMHEP4JP4/ZOPLpmenNgD726pJ9EQIIebE866HkJj+oQ
	cyu75nRUsvI7ykGJqFdFaDqYvjNb97/rTYKm/Xgg6rMaf79em19SzS3CBlPfR0cpmJW6lN4XOeR
	c7F8jM4CQ0+rR8Nwwpfpdb9THdwMCaZsFyuZtbzasyDHGyR04YBtA0qdz8XbKCFP3R6gs706r0C
	8v4jlY/Od+/gbvtd24pbFA5QObB5PVDCAyviA56G6yZQTl2xKlAnCLR5RHOlw0GYQOqlQLoesfq
	hvaikzGspB
X-Received: by 2002:a05:7300:d406:b0:35f:2bc:82d3 with SMTP id 5a478bee46e88-379662913ddmr3152197eec.15.1794618829734;
        Fri, 13 Nov 2026 17:13:49 -0800 (PST)
X-Received: by 2002:a05:7300:d406:b0:35f:2bc:82d3 with SMTP id 5a478bee46e88-379662913ddmr3152165eec.15.1794618829039;
        Fri, 13 Nov 2026 17:13:49 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm10952813eec.3.2026.11.13.17.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:13:48 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 06:43:08 +0530
Subject: [PATCH v3 6/6] arm64: qcom: monaco: Add PCIe Endpoint nodes
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
Message-Id: <20261114-monaco_ep-v3-6-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
In-Reply-To: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794618790; l=6008;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=7vC19cFzK+ATwY4+JnGLnuv6fmnvDEYRfdiPC1jqRUs=;
 b=G/pfbCt2jLgsf31xuUH3byqHYChDhpZsp+OkgduHkcPs1DmC8KjFn2AQeR3/kTkn3Dxjfow/j
 n2mNYlPmIX0CaCNx8W6aPCXZQp1DW8LyXpGBauxMIiqtqCCYmNA1xk2
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: KMLt7A6ptYbKkLioI0rkeFItgdp5BzGY
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6af7b5ce cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=hNZP5i6h11z2s_4BSHIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfX04KgkwxGm9CV
 jFMnGRVVhewyCy9/NeW7Dj8dm0doXwMhAqqXKC1pXtM2c84xR8DRNT/N4pSm37PjtcTO6CYlO5J
 fzq66aD7jvqs4gAAT6GC8zDJFDexBoos3TDIDWn7X5aLumlphVysgBVshf5ss7Yp/ZjPPaXfJTK
 bmbtWPCKfG4OTmy40H4ZCzIw0nLq3D21hzsTwKTkZwW8yTNmrNsYnBxopLZJPbCYf4xKGwcGISn
 o/RSEpd6Ji3WdzFZwiD9ttz/vzCI1JU2uC082D0EZpZYncUe0VepVX1snjFIp4gUQDzqHCm9S/z
 A5cXjWtWsEH8DyVyGveT8EDLAFZ0VzGNQI97lOf2W3TwMdK0g7yVWiciPAM3nZm7XfGP0wLMZyj
 w1dw/k9jjq39VsPcSIcBEZ7+2hxC5uDIgdZzpp1UBpx7nVV4NvP2gw5aZq/tjWwW0hoO3VIyJfK
 d9+EYBx7cFb2b6n1Vyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfX1VWJaoGL+aIj
 jM6qyC5ztSATK4Y0tTcVbricefMnZgAxHckvkzikqgXMfGh3KMcvL2thb0cNS9MCgvTsz4zjQd3
 aDnQD6uZWPhq+XOhG5wMtHtK1vdwhvw=
X-Proofpoint-ORIG-GUID: KMLt7A6ptYbKkLioI0rkeFItgdp5BzGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_07,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140004

Monaco has two PCIe controllers that can operate in Endpoint mode.
Describe the Endpoint nodes for both controllers, including their
register regions, clocks, interrupts, interconnects, IOMMU mappings,
resets, power domains, and PHY connections etc.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index f27f0953ab9e..4a1325aaf072 100644
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
@@ -2406,6 +2407,57 @@ pcieport0: pcie@0 {
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
@@ -2597,6 +2649,57 @@ pcieport1: pcie@0 {
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
@@ -6239,6 +6342,50 @@ tlmm: pinctrl@f100000 {
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

