Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9116356A37
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969050; cv=none; b=BMbzkmHGKo2j9wZDskC+KDrWrgQtyMurQNVwA0kCZfMKPTpKceIw5TQ3i15K9fmlsrgA16hlrJiV1IRESnLTSHD7IVoirvr7tUAg4QNvk3p5g3yAPlzbZFb4yGiW4AEISo5YbhVoUGlAZIwAQFsfaIUWoOohKXFNf2oXFnJ1Tjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969050; c=relaxed/simple;
	bh=rEmkU9DQRb4PAWWg+0bACMsXTOWY7FITna6x+ovdYCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5I8ggoAudyNKy9auyVcO59PIyi0WtjNFxAJ0ScMOaPnPN+usxsDrB0Q4hnnt9d519GcnU2mYvG4yHBjsRM8whpiGpjsMXMZn+FkGXScrGRUGjrXsCQRN03mvPjiZeDrM3T9ZItsSEmK+6NtMEG+bRIFeclqzAOUFDnt1UugYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l2dvJoAq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UDXbvMT/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l2dvJoAq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UDXbvMT/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3YwWU142180
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0FPMuF91C+gTp3QKEhcnOpTmmme/QPbI76IyuUls7Fw=; b=l2dvJoAqpZCWGA4X
	fD/pQzSbEKlRYZLR0afg40ObttdK0pDO+Nj2LAilPas7HYuqJZ05roJs3I491XHQ
	GQ2aty6TJhYByjYWB/Sjq9LksG1l+eV47UE8h1mdMkRGjwC+wVoXU0s/94mOFN9H
	+qGVD1fZHEcyE0sr1bfwekKpw7wSEhDTptVBq/KI1IdWXAMoI7qpn5d2wJo7l59f
	FpCaciy7RXflfCnNdjYDtZzCQODxIJC49c4KuAQrtvCtPWt04w3P8lh2749f8fx1
	1xNYEYblVCM7u2mOgxu/pMkM2oFEKk2XA7HLUXqYBzdCsJn+9qTejPSFkrDnRTPy
	rqCrcg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1egnf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:37:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8538a72b430so2749329b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 22:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789969047; x=1790573847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0FPMuF91C+gTp3QKEhcnOpTmmme/QPbI76IyuUls7Fw=;
        b=UDXbvMT/jfaP/tGv6Ns1/kJe5yIqtg4HtspoR9BIgU6KzuBgFvfXMOZpkIwFcWMnA2
         YxjFgJcwr7tpL68PP9iidgsaIYX3ZEcOn0Q51F48CCjE4hXxXiq1/bBktLmGaw+45TXt
         DfewvXKH6YLhKHDQCR7KJRifdGBPWZ0z1wKu2VcS/gK8o3DvzEQLvR0Dm5o1FqnkaclB
         wrLV0EbF89g8gcc+0EYoV2vDX3GqBNMOIgjTFtf4As00BRxYm9iQPGbTQcrkGgbIQbR3
         JzDqob2T5S/T4iKQr36fiL68M2F+GBgpU0lSPtVBsdsaI9As1MgADBLYJtxUlPo/PKd4
         /NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789969047; x=1790573847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0FPMuF91C+gTp3QKEhcnOpTmmme/QPbI76IyuUls7Fw=;
        b=QUzfS+1d8CgfiMlHYEWniTV/+FuyC1Hfh0oOfC/zpjmyY6JDqFSV0EkvbuDFHroH5r
         kXZYQ+lY/l5T+fAefhz12POiSVxkywUgKxZOdmE1CGGXv9gxtxp/cAbt8X2xHjbFq0qU
         eOnYKROxklfhcCt1hHveFlPqdymHkrBFwBCHturv2SLSawCcPj39jTON2wPagNiIk5S3
         iiszERLl/uGkC7HM5edqtzQK4FVSqXmA3CmCclNTcme3cYg3YvqxQlS6MYkeR6erJKzC
         CUXehNR7zzIIQQQLfgJc2vACVGX9AaYRlQiSA5C1DsGOdmBRxSsGmcdSvcihkDwnGJPB
         ue8A==
X-Forwarded-Encrypted: i=1; AKwUvBxAt8b7TWsvXKZJVu6wULTnMjZndvlM76pWsjqAgLU22UKIPjx+WHPEXFWI539Olob0uKG0lk+QhGk=@vger.kernel.org
X-Gm-Message-State: AFuF++lFFiBu3hqzg2KSdAjClt7dCq15A+OMVlIXIyjMcpCzJtHX+6B9
	w3XTM+I39pTm+3l10w9s3T2FBF6ZB19EviELH0ghOUcmR4tnpOXgGpBxt6iOfjE1inIO4K3hEQi
	CX7CmE0JUxtBnoVKdhIez0ttDdMHOdj4c2uzK9VMIUl8UU9eT162PEl15fh0hWIk=
X-Gm-Gg: AYBFou2ggCsJUljwdfW1tw2xUQNuk5O0qR35LOITgAla8EmMV0pi8c3YNQkWObvhll2
	anabIj36Y8XJCssnW1rYmmMhHskcUso8KITTrX64H08iRMUAtJLnHaB1CClSZPOcPChOoeZJwvS
	z+mc7AE2ICyd0cmd6HBXPVEEddbhJYJsU2BxmnjILqufFawud04GkzkLzMr0RvlJYH73nW3O6jA
	vKpXWx73dgMGUj8OghtnHplV1hPrzYaFKotbZyT0jlWLEbKARq4GDRW/tFqzBbd99mFbxd5SJWS
	0IUsgyiTswuh2mHnk/EWF3JZnNKwNs0ampgRUtQBcdCJOuqUhNsaFM4oTINwtP8ByQ9AMrvuLQR
	92v1YKphqXnY7yu62cmvSTFOFpke2mvwBHg==
X-Received: by 2002:a05:6a20:2586:b0:3dd:85aa:452a with SMTP id adf61e73a8af0-3dd8c53aa87mr15756804637.37.1789969047334;
        Sun, 20 Sep 2026 22:37:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:2586:b0:3dd:85aa:452a with SMTP id adf61e73a8af0-3dd8c53aa87mr15756771637.37.1789969046756;
        Sun, 20 Sep 2026 22:37:26 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55d45a6sm15054568c88.9.2026.09.20.22.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:37:26 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:07:09 +0530
Subject: [PATCH v4 1/6] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-nord-v4-1-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
In-Reply-To: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        shengchao.guo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789969033; l=9712;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rEmkU9DQRb4PAWWg+0bACMsXTOWY7FITna6x+ovdYCg=;
 b=y2mL/XUyPdHnhGpPMbERFOrAf48ERzkgW6EZtHhXnSAKj72dNi6MsDLy7KuZcTJALXv3IDddf
 6NwNHqXspxhC/cIg6apqrl6U8wdWC4KTgaGehBQFMpHiLcI7fQkjgIK
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfXz9wXTQCYi97P
 VcDlhUImNo3lghLwpVdGwy3yw5XUfuW8TCWkDTTAQRcU0x5RD0aPNuTY/riSG4eCe6kWEPacxd/
 5AuA3hyhchJTIi32PQMXX2Wzq6H+38k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfX1Esm/Ri0+YKM
 U2JzFlaoOWvjyLJzV+KUB83tJe2uEi4QwCTctTIj44VE69/ok1ovPQGSllTGacxIrRqkQUrnXKo
 Oatys0c3qq6MUbezG0qR8o+nQNS2usXBHE0DtNfEpuGTq8b98HsbUnLQAzhi41bMSyU1sejkOSo
 hl83D08t3pdopcIpF7fmFZLdCr2v5TBNJYD+WnIYeAPtZzPIXKe1olQQqP7aXbVjJCrkiEHz8CB
 oqbaAiG1AhLeVpXZdu2cXmhMfZRGt4ouE/ndWsgD4/b8jFiQMbg7y2qvjH0/0ng1GV6BidTrZjF
 LC++7FauQX4OPzpTygVyIwu+NsI8+/u7P4VcR7s8niv246X8ieoZAs5UFKt4r91tftUszWHqukL
 pbinELYkjW48C+3tandWcfUxdTEdA3W6ambctBFd2NM+SpSv0MyygP/8xQZqBU4Bt0lu91Udo7y
 glttZYH6iq0+RH/Y8CQ==
X-Proofpoint-ORIG-GUID: Oaci5cblullbP3ZrQOzBqIruP8mzPziV
X-Proofpoint-GUID: Oaci5cblullbP3ZrQOzBqIruP8mzPziV
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab0c298 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=m1JAq1APDOtiVc4_LWMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210078

Document the PCIe PHY found on the Qualcomm Nord platform.

Nord has a 32.0 GT/s capable QMP PCIe PHY that can operate in multiple
lane configurations using four PHY segments (A/B/C/D). The active
topology is selected by firmware through a TCSR configuration
register and may be configured as x16, x8+x8, x8+x4+x4, or
x8+x4+x2+x2.

The binding describes the register regions, clocks, resets, power
domains, regulators, PHY provider interface, clock provider interface,
and the qcom,link-mode property used by the driver to discover the
active lane configuration programmed by firmware.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml        | 267 +++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml
new file mode 100644
index 000000000000..e8a779bcfe83
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml
@@ -0,0 +1,267 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Nord QMP Quadfurcated PCIe multiple link-mode PHY
+
+maintainers:
+  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
+
+description:
+  The Qualcomm Nord PCIe PHY is a Gen5-capable QMP PCIe PHY composed
+  of four PHY ports (A/B/C/D). The ports can be combined to support
+  multiple lane topologies, including x16, x8+x8, x8+x4+x4 and
+  x8+x4+x2+x2 configurations.
+
+  The selected topology is determined by the PCIe link configuration mode
+  programmed in TCSR registers. Depending on the selected mode, PHY ports
+  may operate independently or be grouped together to form wider PCIe links.
+
+  Each port provides dedicated register space, clocks, resets and power
+  resources required for PHY operation.
+
+properties:
+  compatible:
+    enum:
+      - qcom,nord-qmp-gen5x16-pcie-phy
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: port_a
+      - const: port_b
+      - const: port_c
+      - const: port_d
+
+  clocks:
+    maxItems: 17
+
+  clock-names:
+    items:
+      - const: aux_a
+      - const: cfg_ahb_a
+      - const: ref
+      - const: rchng_a
+      - const: pipe_a
+      - const: aux_b
+      - const: cfg_ahb_b
+      - const: rchng_b
+      - const: pipe_b
+      - const: aux_c
+      - const: cfg_ahb_c
+      - const: rchng_c
+      - const: pipe_c
+      - const: aux_d
+      - const: cfg_ahb_d
+      - const: rchng_d
+      - const: pipe_d
+
+  power-domains:
+    maxItems: 4
+
+  power-domain-names:
+    items:
+      - const: port_a
+      - const: port_b
+      - const: port_c
+      - const: port_d
+
+  resets:
+    maxItems: 8
+
+  reset-names:
+    items:
+      - const: port_a
+      - const: port_a_nocsr
+      - const: port_b
+      - const: port_b_nocsr
+      - const: port_c
+      - const: port_c_nocsr
+      - const: port_d
+      - const: port_d_nocsr
+
+  vdda-phy-a-supply: true
+
+  vdda-phy-b-supply: true
+
+  vdda-phy-c-supply: true
+
+  vdda-phy-d-supply: true
+
+  vdda-pll-a-supply: true
+
+  vdda-pll-b-supply: true
+
+  vdda-pll-c-supply: true
+
+  vdda-pll-d-supply: true
+
+  qcom,link-mode:
+    description:
+      Reference to the TCSR syscon register containing the PCIe link mode
+      selected by firmware. The property consists of the TCSR syscon
+      phandle followed by the offset of the TCSR_PCIE_LINK_CONFIG_MODE
+      register.
+      The register value selects one of these topologies.
+        0 (QMP_PCIE_NORD_MODE_X16)         — all ports combined as one x16 PHY
+        1 (QMP_PCIE_NORD_MODE_X8_X8)       — port A as x8 and ports B+C+D as x8
+        2 (QMP_PCIE_NORD_MODE_X8_X4_X4)    — port A as x8, port B as x4, and ports C+D as x4
+        3 (QMP_PCIE_NORD_MODE_X8_X4_X2_X2) — port A as x8, port B as x4, and ports C and D as x2
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle of the TCSR syscon
+          - description: Offset of TCSR_PCIE_LINK_CONFIG_MODE register
+
+  "#clock-cells":
+    const: 1
+    description:
+      Selects the pipe clock output by port index (0=A, 1=B, 2=C, 3=D).
+      GCC pipe-clock mux parents reference this provider.
+
+  clock-output-names:
+    items:
+      - description: Name of the PHY A pipe clock output.
+      - description: Name of the PHY B pipe clock output.
+      - description: Name of the PHY C pipe clock output.
+      - description: Name of the PHY D pipe clock output.
+
+  "#phy-cells":
+    const: 1
+    description:
+      The cell is the index of the sub-PHY within the active link
+      mode, e.g. on nord, 0 for "port a" and 1 for "port b" etc.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - power-domains
+  - power-domain-names
+  - resets
+  - reset-names
+  - vdda-phy-a-supply
+  - vdda-phy-b-supply
+  - vdda-phy-c-supply
+  - vdda-phy-d-supply
+  - vdda-pll-a-supply
+  - vdda-pll-b-supply
+  - vdda-pll-c-supply
+  - vdda-pll-d-supply
+  - qcom,link-mode
+  - "#clock-cells"
+  - clock-output-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,nord-gcc.h>
+    #include <dt-bindings/clock/qcom,nord-tcsrcc.h>
+
+    phy@1b00000 {
+        compatible = "qcom,nord-qmp-gen5x16-pcie-phy";
+
+        reg = <0x01b00000 0x10000>,
+              <0x01b10000 0x10000>,
+              <0x01b20000 0x10000>,
+              <0x01b30000 0x10000>;
+        reg-names = "port_a",
+                    "port_b",
+                    "port_c",
+                    "port_d";
+
+        clocks = <&gcc GCC_PCIE_A_PHY_AUX_CLK>,
+                 <&gcc GCC_PCIE_A_CFG_AHB_CLK>,
+                 <&tcsrcc TCSR_PCIE_CLKREF_EN>,
+                 <&gcc GCC_PCIE_A_PHY_RCHNG_CLK>,
+                 <&gcc GCC_PCIE_A_PIPE_CLK>,
+                 <&gcc GCC_PCIE_B_PHY_AUX_CLK>,
+                 <&gcc GCC_PCIE_B_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_B_PHY_RCHNG_CLK>,
+                 <&gcc GCC_PCIE_B_PIPE_CLK>,
+                 <&gcc GCC_PCIE_C_PHY_AUX_CLK>,
+                 <&gcc GCC_PCIE_C_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_C_PHY_RCHNG_CLK>,
+                 <&gcc GCC_PCIE_C_PIPE_CLK>,
+                 <&gcc GCC_PCIE_D_PHY_AUX_CLK>,
+                 <&gcc GCC_PCIE_D_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_D_PHY_RCHNG_CLK>,
+                 <&gcc GCC_PCIE_D_PIPE_CLK>;
+        clock-names = "aux_a",
+                      "cfg_ahb_a",
+                      "ref",
+                      "rchng_a",
+                      "pipe_a",
+                      "aux_b",
+                      "cfg_ahb_b",
+                      "rchng_b",
+                      "pipe_b",
+                      "aux_c",
+                      "cfg_ahb_c",
+                      "rchng_c",
+                      "pipe_c",
+                      "aux_d",
+                      "cfg_ahb_d",
+                      "rchng_d",
+                      "pipe_d";
+
+        assigned-clocks = <&gcc GCC_PCIE_A_PHY_RCHNG_CLK>,
+                          <&gcc GCC_PCIE_B_PHY_RCHNG_CLK>,
+                          <&gcc GCC_PCIE_C_PHY_RCHNG_CLK>,
+                          <&gcc GCC_PCIE_D_PHY_RCHNG_CLK>;
+        assigned-clock-rates = <100000000>, <100000000>,
+                               <100000000>, <100000000>;
+
+        power-domains = <&gcc GCC_PCIE_A_PHY_GDSC>,
+                        <&gcc GCC_PCIE_B_PHY_GDSC>,
+                        <&gcc GCC_PCIE_C_PHY_GDSC>,
+                        <&gcc GCC_PCIE_D_PHY_GDSC>;
+        power-domain-names = "port_a",
+                             "port_b",
+                             "port_c",
+                             "port_d";
+
+        resets = <&gcc GCC_PCIE_A_PHY_COM_BCR>,
+                 <&gcc GCC_PCIE_A_NOCSR_COM_PHY_BCR>,
+                 <&gcc GCC_PCIE_B_PHY_COM_BCR>,
+                 <&gcc GCC_PCIE_B_NOCSR_COM_PHY_BCR>,
+                 <&gcc GCC_PCIE_C_PHY_COM_BCR>,
+                 <&gcc GCC_PCIE_C_NOCSR_COM_PHY_BCR>,
+                 <&gcc GCC_PCIE_D_PHY_COM_BCR>,
+                 <&gcc GCC_PCIE_D_NOCSR_COM_PHY_BCR>;
+        reset-names = "port_a",
+                      "port_a_nocsr",
+                      "port_b",
+                      "port_b_nocsr",
+                      "port_c",
+                      "port_c_nocsr",
+                      "port_d",
+                      "port_d_nocsr";
+
+        vdda-phy-a-supply = <&vreg_l6a_1p2>;
+        vdda-phy-b-supply = <&vreg_l4a_1p2>;
+        vdda-phy-c-supply = <&vreg_l4a_1p2>;
+        vdda-phy-d-supply = <&vreg_l4a_1p2>;
+        vdda-pll-a-supply = <&vreg_l1e_0p9>;
+        vdda-pll-b-supply = <&vreg_l1e_0p9>;
+        vdda-pll-c-supply = <&vreg_l1e_0p9>;
+        vdda-pll-d-supply = <&vreg_l1e_0p9>;
+
+        qcom,link-mode = <&tcsr 0x71050>;
+
+        #clock-cells = <1>;
+        clock-output-names = "pcie_a_pipe_clk",
+                             "pcie_b_pipe_clk",
+                             "pcie_c_pipe_clk",
+                             "pcie_d_pipe_clk";
+
+        #phy-cells = <1>;
+    };

-- 
2.34.1

