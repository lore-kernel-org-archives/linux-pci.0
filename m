Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE23016E9
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820045; cv=none; b=CaCRB4pFa1h9Q0WwafaxN+RmK4MFixbM/7cUcn4qvO7ae2rcMrG/bsQlDJXPEeen8bIXkDmQ/qYmpralc5sbMwZWLKl0LJIHl6ObdcJZK9NgRfpjZqIaUKbxEhIJ5VrNbNs8ARlcGZsCB2eIU4kgvhvbYOVRkx99HKXwvzj8HiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820045; c=relaxed/simple;
	bh=h6VN9igtKI9aq+/SVm0t5+m0FtDU71HqlJW2YJM8HVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jw4eDGPCAD8PE2ah++xZg7FgpplcExxl3VP3in7zfxI3IVu7gsqbw7NfKm1Jm2b9GcAUiYtQkmVioesh802aNn0YiW/LoiQ/T4nbqZhtoiqBV3B3/4noakjY1Zr61BamH55VQOz3efjjfuB++Rog8vdRQnfJMC+Ql41b7V2O/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ML1c5myD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=buQE0X7E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ML1c5myD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="buQE0X7E"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ILsNdT2819714
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nbKrEr1Y7XrK9od4gILNb3lHt+sx4fwLqMT5Ub5jpBc=; b=ML1c5myDIOrU1KIY
	f9ox/5ll6fLcStiogwIPReyKUv5rlIH64SedIVZJ1R+zkGKzHs9/NScnajDDG0OH
	iA36Lep1MqxOOK8/7M/qyxIu6cbCj1M/SqLIh1Oy06oKWHbTD8WVT2+Ru035dm6H
	4U/ylq40Hfl7UHSNBB5mbU4XU6Mb55cwx4uQLDXFlVUv7tjkzL5t+eaTwaduPoJA
	4JjboOzKH9X4Ws6E/OB5KwbhW61jA2Rwjwy+8lYVzfRco02kKqzRG0BxZTUyTyzm
	GQafPDSHMJBurRdrC1Qig7a0bJtni+bxuk3hlwFfHLTE+yNrjKkiIyONhaMo5wJz
	0SDjXw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6s8tnr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-307fd7138b1so2366451eec.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781820042; x=1782424842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbKrEr1Y7XrK9od4gILNb3lHt+sx4fwLqMT5Ub5jpBc=;
        b=buQE0X7Eny7A2b9H599jgpV8rW9zmlNWz3Tjqx78KStz90PebTujPiTKGX+nar8vJg
         cMrV2qFZUUa1LdVJRuij3Pj7Npjzy8gOACWd5NvLH2R9tLzpu8F0bLydkzExsRoNhI4F
         22KAN3ZQEOdCQ8cc88JaX9pgsK2pX/6qxw7uptnfxvPy/ZpJO3eaoHpPdLkeG76R7oFW
         SMmHePOOPF3cMxVbiKEtk7ekTASH5pxgOh9o/EZrUmaY1F4gRRy+tN8BoZUBAXl6zm2o
         jzjyetGdKSAwuI6EBjDwR5r9M2aGjFqxllfz7344hDbvra7yqRErcW6FcCo1C80e6NHS
         lbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781820042; x=1782424842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nbKrEr1Y7XrK9od4gILNb3lHt+sx4fwLqMT5Ub5jpBc=;
        b=GOs7us2q8JJJ61goC1hJTCpEwcdLLQqCHJvKiKrDChTJGS09lDYNsNJ7delVnS+qgr
         3IuHrW/71ndNljq0o6E5FX01txiD2xcvMwxgtoGdRNF30MKACUiBrAqNqtnkJZSHNHdv
         D0peSfuZga9aEUDE1KaRp+1elxQVd0o0WdgEwmVRmoa+Iic0wYtEph4cZ9rkvWbJeD3d
         CbFmKlCeCYAzHk5Jx9b+cQ0A+4+Sp/Ei0tTIpE7QMIGE8i+MgVjqqNiUj6B/l8AqcQ4u
         1ztC7wJLJqcSLd81mx5PhS+re7J3RZnfRssLG5VfoGkTKW8Uc4p52jzj4Dt+Dk8whMlX
         WuYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9M9N8S6IU6xP6bGzNbVc8sq4LNfR1nKjJT5xyKsIrQAS1euf/fzHJtsWIkoAOsoJq5XhXrW5Svl3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Yzt8+SQp4rxUIit6Z13ENnsicRmOwbmf/G+jCIvHmDXdwg8h
	i3omns4GowNum47/RJKht3Lf6zu7PMPLJMZuv7puQjA7t/oJxDOvWZSrMID5ObKzlo8Lrz0RYGQ
	RNgBYGtAG5+dxBsJb3ZeOqRZruKyCetpQQPlw6V+uYlHt6jRZpUL/xcQzFNKsO9s=
X-Gm-Gg: AfdE7clc8jmGH0fmkRBTtXk7918y1kfXwG+LM8NTvRNV0SAcsAee85yG2QsMYjmCeG2
	FAPsd12tTAqKk18YYpDwMhv8AWhWLo+N5G5tXuWFYmsPZz2fOXsfTEtw6+3RBuu+EMBplJsi/ML
	wnFg/PtQavcBGEjS/reuWAjQ6xisO9OemF3daZOSRBVENtKoakv5r6RtoPmo3yLbzCLZd06sLBM
	qOrBtQcATgZVS+6iuftfTNNNuyvRC9ff6BleFuJn+UC/UuhOUWzeZD5jZUWtGvfkLTbwmf8NDhK
	hTAo/zfsNquf8Ck0g16YtZcfsHfLiMYnzovpa4Vi59PkolC6gjm8SiBdrF10YlqjfO/e0v52Vfj
	bM0jhMYaBiG2zeYw5WcYn2HJCFOQpNQY42oocm42M3Tze8d5J
X-Received: by 2002:a05:7300:7b83:b0:30c:ea:add4 with SMTP id 5a478bee46e88-30c0714d302mr1017427eec.23.1781820041295;
        Thu, 18 Jun 2026 15:00:41 -0700 (PDT)
X-Received: by 2002:a05:7300:7b83:b0:30c:ea:add4 with SMTP id 5a478bee46e88-30c0714d302mr1017389eec.23.1781820040572;
        Thu, 18 Jun 2026 15:00:40 -0700 (PDT)
Received: from [169.254.0.3] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c0670a1b4sm628436eec.8.2026.06.18.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 15:00:39 -0700 (PDT)
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:00:32 +0000
Subject: [PATCH v3 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-hawi-pcie-v3-1-f31880bfb3ec@oss.qualcomm.com>
References: <20260618-hawi-pcie-v3-0-f31880bfb3ec@oss.qualcomm.com>
In-Reply-To: <20260618-hawi-pcie-v3-0-f31880bfb3ec@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Leung <matthew.leung@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781820038; l=7158;
 i=matthew.leung@oss.qualcomm.com; s=20260428; h=from:subject:message-id;
 bh=h6VN9igtKI9aq+/SVm0t5+m0FtDU71HqlJW2YJM8HVY=;
 b=Ypm4JQUIxI2dhUMNcG9BmUZyfHFg8KkX49KgrFCZqaj3u0A0OXEERAulfaanI8Sk3Dja8i3Qz
 BjO5xBKCxCJA1KxU7xFSuMya6VONIXUN1ub/GiRgIlt3+0n4wlbbReq
X-Developer-Key: i=matthew.leung@oss.qualcomm.com; a=ed25519;
 pk=aT25ggJo5PMHLN9N+TsZ3s/BVU++kEYuiFebPWe21+o=
X-Proofpoint-GUID: sBCJcI4LUMj11CnohpqEzG4e9B0gUJTJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfX6xLP5+bN0MLr
 AFk86UyAbnjPKUcZ0bVKP5i/SR/ALl6hp379auAqLw8w3ZQYH9dYE+y4/Oy/V7G51reJHkhdpUX
 4xhEGy3td8tI7PP9qjeuF5oYfJiD5JMLTBySEE4/CbT722gmphguan1be0p9xpm577lkrk7vDkt
 lsDkr7GJ3WOww66ZG76HmGQZjJ/9PA2hIyCE6XkkrFdJR5La2VOuV9btHpmSvr3Pczc0z0D6EJP
 JuD5fDiu133Cj3ILs2wU23VvIyreOMQuFMwZTyT+cwtZ/tiqNXDwFZybxW7aanZRiBkz/OPRkFa
 sgCeowIArCe8kyFbnvzfeNrKrdcWrNp/E+CfRIt8HsGSkqzTAri7nvn/5FA9n4r4FP75NLkyEYI
 +Bn0FzlEWvUDE9hqfWE/jwqvXtH09lbDsNFtEAH28LTxyd61iIefgTyX92BuaIU6Dzh2PpWnsDW
 tBqi9auwPfbHOA3EZuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfX0Lac6M2lnSWP
 Y6pGF3tiDQDrWOMAc5LI2YevsGv268rsP4TWhiGQgw9Hiy73YjwYNhI1pkqof7n9FHWHA/m9z+r
 OFWITTEn7GoBRuUroQ+XQTp6V2wdNYc=
X-Proofpoint-ORIG-GUID: sBCJcI4LUMj11CnohpqEzG4e9B0gUJTJ
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a346a8a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ICk-tmyBBRKrNCK0fOMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180200

Add a dedicated schema for the PCIe controllers found on the Hawi
platform.

Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 202 +++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
new file mode 100644
index 000000000000..fb3145f89f7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,hawi-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Hawi PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+description:
+  Qualcomm Hawi SoC (and compatible) PCIe root complex controller is based on
+  the Synopsys DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,hawi-pcie
+
+  reg:
+    minItems: 5
+    items:
+      - description: Qualcomm specific registers
+      - description: DesignWare PCIe registers
+      - description: External local bus interface registers
+      - description: ATU address space
+      - description: PCIe configuration space
+      - description: MHI registers
+
+  reg-names:
+    minItems: 5
+    items:
+      - const: parf
+      - const: dbi
+      - const: elbi
+      - const: atu
+      - const: config
+      - const: mhi
+
+  clocks:
+    minItems: 6
+    items:
+      - description: PCIe Auxiliary clock
+      - description: PCIe Configuration clock
+      - description: PCIe Master AXI clock
+      - description: PCIe Slave AXI clock
+      - description: PCIe Slave Q2A AXI clock
+      - description: PCIe Aggre NoC AXI clock
+      - description: PCIe Config NoC AXI clock
+
+  clock-names:
+    minItems: 6
+    items:
+      - const: aux
+      - const: cfg
+      - const: bus_master
+      - const: bus_slave
+      - const: slave_q2a
+      - const: noc_aggr
+      - const: cnoc_sf_axi
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
+    minItems: 1
+    items:
+      - description: PCIe core reset
+      - description: PCIe link down reset
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: pci
+      - const: link_down
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
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c00000 {
+            compatible = "qcom,hawi-pcie";
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
+            num-lanes = <2>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            clocks = <&gcc_pcie_0_aux_clk>,
+                     <&gcc_pcie_0_cfg_ahb_clk>,
+                     <&gcc_pcie_0_mstr_axi_clk>,
+                     <&gcc_pcie_0_slv_axi_clk>,
+                     <&gcc_pcie_0_slv_q2a_axi_clk>,
+                     <&gcc_aggre_noc_pcie_axi_clk>,
+                     <&gcc_cnoc_pcie_sf_axi_clk>;
+            clock-names = "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "noc_aggr",
+                          "cnoc_sf_axi";
+
+            dma-coherent;
+
+            interrupts = <GIC_ESPI 205 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_ESPI 206 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_ESPI 207 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_ESPI 208 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_ESPI 209 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_ESPI 210 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_ESPI 211 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_ESPI 212 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_ESPI 204 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "msi2", "msi3",
+                              "msi4", "msi5", "msi6", "msi7", "global";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 0 GIC_ESPI 213 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 0 GIC_ESPI 214 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 0 GIC_ESPI 215 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 0 GIC_ESPI 216 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            interconnects = <&pcie_anoc_master_pcie_0 QCOM_ICC_TAG_ALWAYS
+                             &mc_virt_slave_ebi1 QCOM_ICC_TAG_ALWAYS>,
+                            <&gem_noc_master_appss_proc QCOM_ICC_TAG_ACTIVE_ONLY
+                             &cnoc_main_slave_pcie_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
+            interconnect-names = "pcie-mem", "cpu-pcie";
+
+            iommu-map = <0x0 &apps_smmu 0x1000 0x1>,
+                        <0x100 &apps_smmu 0x1001 0x1>;
+
+            pinctrl-0 = <&pcie0_default_state>;
+            pinctrl-names = "default";
+
+            power-domains = <&gcc_pcie_0_phy_gdsc>;
+
+            resets = <&gcc_pcie_0_bcr>,
+                     <&gcc_pcie_0_link_down_bcr>;
+            reset-names = "pci", "link_down";
+
+            msi-map = <0x0 &gic_its 0x1000 0x1>,
+                      <0x100 &gic_its 0x1001 0x1>;
+            msi-map-mask = <0xff00>;
+
+            pcie@0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                bus-range = <0x01 0xff>;
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                phys = <&pcie0_phy>;
+                wake-gpios = <&tlmm 104 GPIO_ACTIVE_HIGH>;
+                reset-gpios = <&tlmm 102 GPIO_ACTIVE_LOW>;
+            };
+        };
+    };

-- 
2.34.1

