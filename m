Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726593FC5A7
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089277; cv=none; b=PW0Ra5slrhWClLZSSRPGAEtxaUC49LdRe9Hvv65tkNkn1eUv9IqJS2oohdZz8NQZNDFXCmbImYU5qWn/5j8ZiRIIAAX/IN3AW9o84gcg/iBK93LzqEAjE/qrMQOQf5NkJ9AOh+WHgtGOMn6J7U7c/cGUqBFubvROFj+QwLU3hSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089277; c=relaxed/simple;
	bh=DQeBUDvNNGZc6Uir8xeAY9ErKWDMp38iSK8aZbPCGrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Koed5lK03Is0stqMvjnK+ZZ1OP0XqfFIBmewQHpkKHCBbptgS0mueXURlEW9lNLqR36F+B42tESiEBR9XmdcgHzHoDWrb2BZdLYHrVmsCtU0VkmqDZP9ykD4uv8deTeJKV03zp2dZkyIJc3YafA67ZN2ZeGBn0wSh0Cj4KhdDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ExgKfyF/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S3qDU8FC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ExgKfyF/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S3qDU8FC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7i84J3152070
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tV4HY9ZnY5FGjZHgR32ng40+lVhKsXil6i71ZkDu+yA=; b=ExgKfyF/B6d5N4/K
	E3elJAuK68eRJAYBJs159Bw8pCqMjyxm1M3HK4mitAuE3IJZMGSinauVYlUkwugh
	PUPIP7KI4xiQZAHMLAYWZSQDj2tC7Fivc/uR5owrhpnIRVqZJAPUB1i4u2cQfBia
	AwzaF/f6x82dCfnT435+BL2ISq647d33+7LLhljyrdkTR6T7RzZ/kfoRpIjFH8h9
	f8/Zotpp+uMdqWsr7kB7dnFF3T8bAl/c9qagTh75KWa68m4bJ612LeF5viPlY/gS
	45/j/1/CwbCYg3b7BXOnWXVGqRUZXBCGQLBO6A6hIELEC8kq0s2l2fk8iW0Izwa1
	Inc/SA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnet43b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:01:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d979441eeso5744852a91.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781089268; x=1781694068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV4HY9ZnY5FGjZHgR32ng40+lVhKsXil6i71ZkDu+yA=;
        b=S3qDU8FCK9Plh79wtMZzuK9OtXqsFE2UAWA/CGlcfASVOKcx2F/wIBy4LWOVSCuCSj
         HL2ht8UdSvGLU/qDyt7OIDAoj5vvU8m/g62eqqWUJFUQkm+w78VBQMHikC+UAcb2lWGN
         yhT6sOXPX9+hAnB3RWHeUIiPc0BT9CLG/BlyO8+jK9o3qc0o/PyBHU8WasQuAl/QAokf
         H/6oU5+zbDlKBw0I9rYnLAEDDA8kwD5+dNwuBkGnjeeakRt9GHvghHRx6owsnH/D3Pig
         v22z6+Q1e5fWdk1gjGpuTTwJyOfCHtkB5TP+6+omGvjVDkX8b6Cy2+qlg5W2DmGfkZCP
         zf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089268; x=1781694068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tV4HY9ZnY5FGjZHgR32ng40+lVhKsXil6i71ZkDu+yA=;
        b=cgRWV/gLg2QGnkMy7Re0WrWQYuBK3U1o6vXHkSeKBs9Ohpos1sY0sdp6dz5UbHwDop
         Pfr3nJWAaW7Yl5Vp9wZjwURsr2+p7WVXx+79q+BVMerI6sU+6lZwfOOTh/xcRPR0IY3D
         x1pEbUUzKJks9uj/3EExvju7qmsnrJ+y1mvqlpIhLM2aUSIdUK26LZz/6ryu+mSk2i27
         z/7pvfUtfmyhfJldK2mBBVZjRqmu0zSJ8YQC85106fNSQ4F6BR/7wPtqqsgtwnH/ZDkJ
         xCitOsecdrpWLywxe6kznGX2TSEOppSzagRWW8DbpZ/ZdU/z7fbdEnM1Fysa+RgAlO7v
         gwTg==
X-Forwarded-Encrypted: i=1; AFNElJ/udQKYWWlj0FohYqgcwO6RH5cGzs9+U59ZjGRuEuQ97HLivG5EiegakZlvglwRFPI+6veLNoqa4Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/G4cUBVEDXBuqinJ/hECBb8RSYF7HvpQT2WwdR9OuR6A0XdK1
	qa4Q6dmOCenXvqZXCLQL4G/l8pN3GCeEFKAZLKECYh5JB5/GvqSE7dzbIUedpdZvEd9bZAseBA+
	EDW1PGFFHWdGUGji0p3GHxNoMYCqmGAODTQIN9U58hjlPGVtYW3ecUVIm5lw9ZaU=
X-Gm-Gg: Acq92OG6uQgExPe99HKFVIGwdU5INxw/6OjNoWf2/cnxflouobJYrHOj/aiym4DZN7t
	I+O2LeGnEh/3alkkDZWuViZqop1ZlLCrh650nQQo+n+TKDfSYuZ5liUIR348Row0AVbgoTfSwAP
	+rN2/qPjFY96du87c+oHniWKaGCMatLvWhMW5TI9JI61orxHp+L3sxfYYdfTQw5SN1T62VhNq/j
	PfZmKInS/ZO56RJXi8wZgsCmP7rLM8l4NDQS7xNWBuIb/Q8x+iRemVMrSuOrc0dqUTM9W73WpkM
	1ilE01yjsXKKUwMF1e0t8QLDb4YD1svhQQaeKrqFMz37c7U9fGqGP9ucoi2iiphv8+AQ3kzuhcg
	q03mJDqECCaWK/ye5Mn3QvLCpN+V61UgBBd9SbTsJ0khtWDMB5XRQK6+NLM84RbiSabhYsoRbDD
	Uy2povBmIu31U6sePf0ypvJ+zKepV1hLAAk8i7VSjEazRsdfICqro6+cW9BOa9gpnU1Nk=
X-Received: by 2002:a17:90b:5787:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-370f0284a87mr25709405a91.14.1781089267431;
        Wed, 10 Jun 2026 04:01:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5787:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-370f0284a87mr25709301a91.14.1781089266711;
        Wed, 10 Jun 2026 04:01:06 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-376246afe17sm3535131a91.11.2026.06.10.04.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:01:06 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 16:30:53 +0530
Subject: [PATCH v2 1/2] dt-bindings: PCI: qcom,pcie-ipq9574: Add IPQ9650
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-ipq9650_pcie_binding-v2-1-69e27a1fbf1c@oss.qualcomm.com>
References: <20260610-ipq9650_pcie_binding-v2-0-69e27a1fbf1c@oss.qualcomm.com>
In-Reply-To: <20260610-ipq9650_pcie_binding-v2-0-69e27a1fbf1c@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: l0ggubkB9z0BnsO5r03YFuNy1TPKgIEH
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a2943f4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=txNWhIGMMpap704yvqUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: l0ggubkB9z0BnsO5r03YFuNy1TPKgIEH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNCBTYWx0ZWRfX3HS/RbNtU4W5
 gJTiWbg9sCQJs6U7H1HWI+XxpFC22zqxNyhEqadX1+yI254x+P6xa7RN/1IjFoKhqGmJ3a3RP+f
 IgnF0YTSP1vYCnN3U8bcu9OO8F49gkfGHCyDdIhhMQinF2+DZ8fQb0FWHOFDQRyR2gTrsu6Kre1
 e/XsXYcTMIPx+k54aIV0Bd9yO7dxDut2gvuUrsASh9TTkUzq36C2HpIRNq/m/lZVqrnZ1kUdJY3
 EHeJBVDKAihISzYkHfojhseg0wy09Vnp4PRBz8OdUhQoURZQqARce3V3eXfwDihIW4KOQDdL7Sn
 EZ2eFo7SWrVVVjb09ocsfXAlEvGyPcFEGWB2laJXtkOcSGIT93sdCKi53lU3/4WTVXxvCGz8+JQ
 nVP8CS9Q8L6PsU8Pft9rszPnOc1jzJRgXA/GfuMrisoVbUU5DEa+tbP8jzWYXeMMKW885blOn6c
 b6vvQTf9JgE2Fkq0FlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100104

Add the IPQ9650 PCIe compatible to the IPQ9574 binding, as the IPQ9650
controller is compatible with IPQ9574 and uses it as the fallback.

While at it, make the global interrupt as required for IPQ9650.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml          | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
index 4be342cc04e1..e92acddb969e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - qcom,pcie-ipq5332
               - qcom,pcie-ipq5424
+              - qcom,pcie-ipq9650
           - const: qcom,pcie-ipq9574
 
   reg:
@@ -82,6 +83,18 @@ required:
 
 allOf:
   - $ref: qcom,pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq9650
+    then:
+      properties:
+        interrupts:
+          minItems: 9
+        interrupt-names:
+          minItems: 9
 
 unevaluatedProperties: false
 

-- 
2.34.1

