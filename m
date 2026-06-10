Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFF401A38
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089273; cv=none; b=pop6ct0FJ67NhTiJHeNxtm4RKrwP7E4fylV9ABvLqqurq24Fuh5Sp372tYTtj01M+2shsrM8oXVR6DiB7HrkFJnkVGHFBqoTAcaOHyB4StHlVgNPVhfntocgNs9hSx+gxh7143DlC3ZsjtawXHJBCN6p/FrN4Hxrfky3y0NBByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089273; c=relaxed/simple;
	bh=1CpPw2eZrHS5NhoB2KKi4APIiWeEUM8K7bQ8hFcdrf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p6Ih5M5xwPWguHaW67oQOlhlOvMkMuG44heQd7Lpr8WRVdijcKB1VFjn8i9fp2A7lrwzqO34ujEtU6xKccB8V+232hiiDQk4682ReuXgQ4OTMw5mAZ8Pw5+JieeevnPAOAJ9eiApbHLLgzZey9IeXZf3PGIAhWmV0c3Ax3AkKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+2teSjF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YOS+qZYW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+2teSjF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YOS+qZYW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7htmT3151748
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=salhqSuItVvrpsXRu2WH6h
	IO7huOCzSeZ94qvGl+a+Q=; b=E+2teSjF6PvcAIa22AvkSPFc9rQReRAUInxKOE
	lzC3yyE01Rfk3emtFQV2rCraWUz+AG5JxQK0XZhbiaP/8poduhvgRoAYaI6MpF7Z
	dtevulTNP97N9D5REm9tgLWBsQ5N6VMwvbPnj2HAKk7Y6wF5o0E5o1unTGqHUcit
	P8QTzzVXlA4PMo2mb7JH4lzslUwQFjVZIpCZdcEb/+1beWBLnywED52e70ubUNJe
	Dr5Nv/k43PGpT+owkfgkPMrjlVRtVQiMAlK65rg675JuEKuDLP9Bv66OBHaMIN1i
	2AtcQ7cGAUoVUp9aePPP5cxVseWkyfGCzB8vN0xdEPBH6VzA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnet431-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:01:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36bc54005a7so8732564a91.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781089263; x=1781694063; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=salhqSuItVvrpsXRu2WH6hIO7huOCzSeZ94qvGl+a+Q=;
        b=YOS+qZYWEE1hf24+kq04J1Y7Apo3LUefybq36ObIU7fXMdVFu0WJCWFp2wHjxPSKUQ
         M7tvW/CZdKRIRc0Oil1mq2SWW+i8QWl9rSGojtx/ApKKxKFKp9br/rF9KWDvZ32hQKxX
         jwxqSFFKvRN5mfR3uFftikkLtDFJvf8NxcpqfvPVzOVKNL3sONX2JlCYFaj4Ekd1K/Jl
         M2ZPeiEY8Ji0W/8WDzDHvXTI8sgkq6NaZqh0ntOcwBz4cOgdbjv7Q10uPALw3V413adz
         ILrI3VQnYfkri8w7APdVAr5JhoP57YJoukveE53x9/g8Yv1Ti79BXIktarbO9PkAlu1X
         hOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089263; x=1781694063;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=salhqSuItVvrpsXRu2WH6hIO7huOCzSeZ94qvGl+a+Q=;
        b=KKAyUvC+CANkpfbnhjd2n8nZOLs83j9HPLCFdkSqtVAS2r97uyvVJUyrMccgPpLtZc
         xwwnYttExWKE+CFrhy8HMhVvHaPsCY7W/Pbx7XwbgC3EGfCCjT7UqRwUbnI5qCbBDEgD
         qno9eSEGduN2befiYEcxDUFGqqyJQmW9FqcezG28+L9IHbgFCxxNRLRJ8G8WKR3GBUQH
         G7jyWlHr6MmMW4tQjXnIGZVWVmhIFK2S/FDDjMR0cQh0TipC0Pw1EwzWn6B9P0vmvmDu
         /DL4+zZZWHYfsVAE/4Opv0ObWLd0iQvteAxfY4ScZddA/mKVARauA/EXvLx7QdAdUZMn
         Ysew==
X-Forwarded-Encrypted: i=1; AFNElJ+1z2orA+E/ATg6reAMsodp1o2c3oTt7iUFxYBxOVxXbkZVhuKeKZ2Q02/Nn0WsRUYFybtmtJ4+yrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRCyt5elYbl2um/0O51DC0zPfwX6ww3PJskB9VvoBdi4z83GgA
	50Gl2wrQofzN2kmchh7LjroyIdM+OKHJTEktFVUbSaFGUVD6ioDcDIyDXr8R53y0qJlqOqwbSNK
	KqFuJmD/o57pUG+VJhpDMmeLzLlrmXuigYb1SpJr12hY55XgaF2GAcNDm2VHRbN4=
X-Gm-Gg: Acq92OH7ERzY89ZOExlLC0Jx/Z1y1uATpFZjNo9zFhsIhjr8+aUfAkydcoyJSW9l/x6
	QepRZHn0g+P0lg1A5HdN03wuGmsh4ARMirwlHGFkIGCC16642nUan4t8d+kuY3YAnH4Sj5Fp8u3
	KOayOw8B1KBTk4Bhp+cu8nN+QDwAJ5+LJqy4ijwI/uLbaPmhnPNj/NM228WQmmOCyvlxWNWte25
	IL8GX6PieEJXuW9mndKcWR3tLZ9p1ZRmuerG1It7HPD3C1jSWR8qBd1Md44ZxiJrnBGGBJRR/f0
	20P+AunqApUwG2YbN+ezmQGQYGNMvdhLoiV9v7+d5S/WjS+VRvl+JApmUqxIN8gQ277iZ6k7X4z
	B2GMLFKyp9v214k4Y/Mh8IPfUd0H7sq+tIsUbQ8gDOe48Fa+EFDK1VQxjSThUio5cE9oEjppSJl
	RThQvDVn/k2Mwf5u4ulQWOfitWzHEt8v4wvw03oAVlygBplZkuqFP46WaEAf0yfm/Lggk=
X-Received: by 2002:a17:90b:57c4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-370eea202f0mr25353081a91.8.1781089263334;
        Wed, 10 Jun 2026 04:01:03 -0700 (PDT)
X-Received: by 2002:a17:90b:57c4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-370eea202f0mr25352974a91.8.1781089262036;
        Wed, 10 Jun 2026 04:01:02 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-376246afe17sm3535131a91.11.2026.06.10.04.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:01:00 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add PCIe binding for IPQ9650 and IPQ5210
Date: Wed, 10 Jun 2026 16:30:52 +0530
Message-Id: <20260610-ipq9650_pcie_binding-v2-0-69e27a1fbf1c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAORDKWoC/22NQQ6DIBREr9KwLgaoUOmq92iMQaD6mwoKatoY7
 17UbTeTvGRm3oKiDWAjup0WFOwMEbxLwM4npFvlGovBJEaMMEE4oxj6QQpOql6DrWpwBlyDqb4
 KIrnkuZEoTftgn/DZbx/lwXGqX1aP29fWaCGOPnx370y33qEQhP1XzBRTnBdC8Qs3qtD87mPMh
 km9te+6LAUq13X9AXZkckPRAAAA
X-Change-ID: 20260521-ipq9650_pcie_binding-1c76095954d9
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: iombqKKY5XAOetRlEE257Em9ZfDLUSYg
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a2943f0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=n0z3TVQIEMT6cdfUBsUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: iombqKKY5XAOetRlEE257Em9ZfDLUSYg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNCBTYWx0ZWRfX6M3Jd+o6rDYz
 bhCAHvDcvH8Fg2Bl18Zw7zLEzktBK2J7Sji3QJIXKqrjWFYy+OX+q2g+fiQHuSF+yp3fWw5jiZb
 mwlps+c3NIQ/f3L7psRknBhtS5G71t12vgH5H9A6/6GZK8asmlNWu5OK2dOj+iRvK/wtJaZbwll
 VGb8BvGn1wD0QFSLG959Wd/PsP8/nZNXaIP2yNj8akBkF9CqJp5i96L8HeJjolZz4Lp/eLdBfqq
 K9y66MK+dQnBASX33+Bo3fVp3LcgvORIl8skk8O35J3bbtA1ITj5T3/EBBTZDWpansnZrPYsAA0
 RLQqTEOtZYbO1hI/ByRBVcQhhj8ZmiEnez3okScbD+aQh6NMw6SBR79uJ0Mkgl1S/jm9fXIy3g8
 sD3xn+M1CKHdydUCppMh8Ng6CTNcBekkVurSZBMk04yxxFpGvbPfKSlu9AOhKQITqbUGMd/IrH0
 t1PAWitBp41ZjyoPVoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100104

Add the IPQ9650 and IPQ5210 PCIe compatible to the IPQ9574 binding, as the
IPQ9650 and IPQ5210 controller is compatible with IPQ9574 and uses it as
the fallback.

Make the global interrupt is required for these SoCs.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- Made the global interrupt as required
- Incorporated the IPQ5210 binding change into this series to avoid
  conflicts
- Link to v1: https://patch.msgid.link/20260602-ipq9650_pcie_binding-v1-1-486a535da8c5@oss.qualcomm.com

To: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Kathiravan Thirumoorthy (1):
      dt-bindings: PCI: qcom,pcie-ipq9574: Add IPQ9650 compatible

Varadarajan Narayanan (1):
      dt-bindings: PCI: qcom,pcie-ipq9574: Document the ipq5210 pcie controller

 .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
---
base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
change-id: 20260521-ipq9650_pcie_binding-1c76095954d9

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

