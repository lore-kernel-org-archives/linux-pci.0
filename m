Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C833A9CB
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372352; cv=none; b=sVIgbNNkjHR/gGeclSQR2RNKHsUUJ3SgxHIo+s2WRAYzUADmTWoOC8X6aJsnDJyXNsd/TIt1rdcWwjdYd7+GBJ2L4xup1DNvOLgEaanXUXGXWU8VxFS3T9mQ012N8NXEQYCkpgW0l1jo5B7DLTJnUS7cfSCa/p5lkp/cjhBpwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372352; c=relaxed/simple;
	bh=KbvKWc2i7M6oa2rYkaVuWth3gGp5j7Zm102Iol4S09U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlPHLR4DrVMJGYdSd3NeBy2wxdj/KRQ3gOoafym5sB5n5BZ2UPfxJ0yVrqOjqwaJpE+AtWvd1FH79n2dJyyu8FN509r2ZOdRT6lSaDNaTd124fRmEqAlFANuihsbcLkBtW+VhFzeWCT/iraJjhrOtp2ItjAboMkYlVSNNi9c/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ah4AhSUo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MsLjabm+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ah4AhSUo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MsLjabm+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99xJL2632717
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1KOeBbeA4B2MtF8LF/kTfTdB+LXRgfy08AkH+2O9Qho=; b=Ah4AhSUo19nCEPdF
	dApV6Obv/ew9zjZD8p9IZRno2o26Am842Gz5NM4LoZePeV/Eo6z/t5JMF73DETBs
	SOQA4EAq2DeEBrgmtCy49JWKBIW8zydZavWtv6QDy92fT+yjeUn0QVSIfC64dYBT
	XxMq6Sw1yjIlDHhyQWi0C6B65Z/mqSq7TchqBa/EIcVJ/TdqRFoYXpVfrKyJBCxA
	NKkHXRjtoQcZ97sRIKOHlOXO+cRlfqAimiiba9EbFiFhjuUOiJniCQQQNiwpAz8G
	9nCZ7UjX3m2fOZO/8FIl44teOlumc7beK4CNED18WugE2zNQYgErIPJfUwD2fQms
	EYSkjA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8dc2y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:05:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso61200295ad.3
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779372348; x=1779977148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KOeBbeA4B2MtF8LF/kTfTdB+LXRgfy08AkH+2O9Qho=;
        b=MsLjabm+2TP3/3kpSl0lbmw97+/0gFNERpunx/+qUHSdX8iZ/hjMbmzuIafbEVvgUU
         ln1bpXGBRaaHskX1i7gRiTwV7YCw4ZtDJomXDwe6HZUXqQVMqls33qUoUGw1b/tE7kQm
         EPIuryDn6SbOjy+Mg1vEswK/4/RrQMm/IGYUNo2DUnmCFL2EtGGLKFhnqPr8R5QfPBRc
         8pThBqhK6PkMDSj1R/8d6i/XamlNkr6sA47HWQXZA8e499VCVn+P6q19W2edF3PUMyO+
         BYOkj844oKbTsNIHTXl416w3kbFrQfTOheMAh47uBmXV4lDYXyz8PQcmVfIfNMBaJiqO
         8TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372348; x=1779977148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1KOeBbeA4B2MtF8LF/kTfTdB+LXRgfy08AkH+2O9Qho=;
        b=DLrfvJArPnV+Y+jcFmvdQvSddAbJn+UW+diHbb+alPhlPGo0lYOLAQiH+a2BrKfN1x
         AHm0BGOYOIBYaGPy6TZvRjs9gKvr98O7vsoOnd9HvtjIE7GBU0F1GYisZb1YLQF+wo6F
         ifJBZukIGZKVz2AzRg2oQkZGceYhShEwU//j2orMAJPgKEkyikElckxcxlX5KDO8sjsI
         jbxXJaEmEZVzgnw9u/gCo/i/YBdMKKdTtp5PnTY27af4KdgwJ3prh4/YH/UdOVg6ZQ4r
         peN2ys/wEEug5l+uXSmrlrRrRRckFK7c0wNsRXC/nNTeaV4FmK6Auq9Q6keT1Nj+4ru+
         j3/w==
X-Forwarded-Encrypted: i=1; AFNElJ/Ri1+3ISXKG9xirXY82Smqbax9O8Fqm7Iat4MBW8DcFRHKb5jQ1jTwsx827atrCv1tVeOCorCJLi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+4vOuYDaC0lG+nENmfJ0Fg9MGSNdev5tvfpZvaYW/z5Q7XUK
	uLkmXOubuxZle2eDrch8UZqmbMtsVVlg7gLQc4x+KtBtkCMRCLcd4Mt8N32tZ3e6P8cecQQeHYX
	2i6hl4ONU++XAeqzJzFHXMdLTEzSjyBgZQtiQuemjY5Kl5eEt79NQZDa6OgmjnSM=
X-Gm-Gg: Acq92OFmV9v79o9T5H7Dz3xZ7a9NzX9rugxwePJHCl5SxRxoIX8GL8DukyRNByl8wV/
	jSBmkUX3jt+4Jpl9SFpjPujY7vZRhUsFsF9wWJ5j8ZXvERTvGw4558NjPQr0+s5o03QGc+lo07c
	rn+ckOhvsFyXAvdGwipnuJmnEFAz79Fgb39gHcYRBSlPlo2q6bnH0T2R1ZfqWkQASbyRR+gmYS1
	9fvUUKrrYfVDp9c0Ql8/05XAvmrB+8pkNZ7aIFnSb9mPf8YJDXLNjyHQ2Aa0kunK6OWdO3ao5E/
	kiXWkC8ZRDvX+32lLZDxT8I1E8iWKkICQrpi9EYNM4qYTowb76Hf3LoYZUVHV4ETaqo9g/KUgKl
	htWMBj7JEbc9+Eikj+7vYvssybLRTVxvUAeCGPlj6dRW8WHRufnGaMGZT
X-Received: by 2002:a17:903:19ef:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2bea2fc6c78mr35802425ad.12.1779372348123;
        Thu, 21 May 2026 07:05:48 -0700 (PDT)
X-Received: by 2002:a17:903:19ef:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2bea2fc6c78mr35801745ad.12.1779372347586;
        Thu, 21 May 2026 07:05:47 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9287997sm13189765ad.24.2026.05.21.07.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:05:47 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 21 May 2026 19:35:30 +0530
Subject: [PATCH 2/4] dt-bindings: PCI: qcom: Document the Eliza PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-eliza-v1-2-97cdbe88389d@oss.qualcomm.com>
References: <20260521-eliza-v1-0-97cdbe88389d@oss.qualcomm.com>
In-Reply-To: <20260521-eliza-v1-0-97cdbe88389d@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779372332; l=6265;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=KbvKWc2i7M6oa2rYkaVuWth3gGp5j7Zm102Iol4S09U=;
 b=EHEF78AeTAdflrWS3C6DJ/VS3Ta/HGE5MWxFwKYrbQlpz+2UFhKNPyaAaa1EFXs78y5nBL+Q/
 wSqtgyuupppBgALURG2Lq/SktPWiApNasz4ghtg1N3Aj18amp05zgV/
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: futWkgKjLKxG4Li1TEsEmqanOZcJq8_s
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0f113d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=IDOmrVdmHV3nBiBHXysA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MSBTYWx0ZWRfXxbGLKhx6pWRU
 EbhlmGwhmuo6zCz/BLpUfxRVixSE8EW+YhhpQVnutGhlAyRB6+ooJNq5DOs3jciQuaYXdGuOb1h
 5IrwgN9heCZLbZ03XGBPMNcD9UQitPFMBwXfX0dE11TyITCB3pFYr9IjPQDw4GaAmx1Jyvn0LO7
 fnD+cJlbwpr+2g/urx6qYOeZiWaYrWU6ez5ppMfSxf8YPOTvOJhgAWwi2PWXVF2fOYEWAe6sRxg
 mOW03Xgqi4u1qhwArT5ec0yagq5Yb7paoKwIMaufSNU+H+HRBsT5dVmUU5JW91fSxDm2Tee727T
 KxrP3ge6onroP+iyp9CkHa8P1KemR4ALROdXA9CsK6ifZW1VbHnt+25N7Gmtuq/sYE+WnabP8dm
 s+AzUtknvYoO8a2OC7rTa2BsUIowBW0HCRWlXLwykogAykHJFtwFgmz9H8eB8zw8qbOoQhFoQFc
 HwnNqKrWlak/IJ6/D3g==
X-Proofpoint-GUID: futWkgKjLKxG4Li1TEsEmqanOZcJq8_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210141

Add a dedicated schema for the PCIe root complex controller found on the
Qualcomm Eliza SoC. The controller is based on the Synopsis DesignWare PCIe
IP and requires a platform-specific set of clocks that differ from existing
Qcom PCIe schemas.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-eliza.yaml   | 165 +++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-eliza.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-eliza.yaml
new file mode 100644
index 000000000000..826e2adf4fda
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-eliza.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-eliza.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Eliza PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+description:
+  Qualcomm ELIZA SoC (and compatible) PCIe root complex controller is based on
+  the Synopsis DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,pcie-eliza
+
+  reg:
+    minItems: 5
+    maxItems: 6
+
+  reg-names:
+    minItems: 5
+    items:
+      - const: parf # Qualcomm specific registers
+      - const: dbi # DesignWare PCIe registers
+      - const: elbi # External local bus interface registers
+      - const: atu # ATU address space
+      - const: config # PCIe configuration space
+      - const: mhi # MHI registers
+
+  clocks:
+    maxItems: 7
+
+  clock-names:
+    items:
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
+
+  interrupts:
+    minItems: 8
+    maxItems: 9
+
+  interrupt-names:
+    minItems: 8
+    items:
+      - const: msi0
+      - const: msi1
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+      - const: global
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: pci # PCIe core reset
+      - const: link_down # PCIe link down reset
+
+required:
+  - power-domains
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,eliza-gcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interconnect/qcom,eliza-rpmh.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c00000 {
+            compatible = "qcom,pcie-eliza";
+            reg = <0 0x01c00000 0 0x3000>,
+                  <0 0x40000000 0 0xf1d>,
+                  <0 0x40000f20 0 0xa8>,
+                  <0 0x40001000 0 0x1000>,
+                  <0 0x40100000 0 0x100000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "config";
+            ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+                     <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x3d00000>;
+
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            linux,pci-domain = <0>;
+            num-lanes = <1>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+                     <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
+            clock-names = "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "ddrss_sf_tbu",
+                          "cnoc_sf_axi";
+
+            dma-coherent;
+
+            interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 537 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 540 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 653 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "msi2", "msi3",
+                              "msi4", "msi5", "msi6", "msi7", "global";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 0 0 564 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 0 0 565 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 0 0 566 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 0 0 567 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+                            <&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_0 0>;
+            interconnect-names = "pcie-mem", "cpu-pcie";
+
+            iommu-map = <0x0 &apps_smmu 0x1480 0x1>,
+                        <0x100 &apps_smmu 0x1481 0x1>;
+
+            pinctrl-0 = <&pcie0_default_state>;
+            pinctrl-names = "default";
+
+            power-domains = <&gcc GCC_PCIE_0_GDSC>;
+
+            resets = <&gcc GCC_PCIE_0_BCR>,
+                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
+            reset-names = "pci",
+                          "link_down";
+
+        };
+    };

-- 
2.34.1

