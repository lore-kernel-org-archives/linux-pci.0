Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17138E8C6
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928582; cv=none; b=fJd7SZv7+QMMQtS+B6zRBNbzjKlfoshtN8MPA4OLoJPa0aiUfFJAuEWRX564OsoshDYTmLKNVDeUmZQAeP2vhA1IH5jFslsGwDNdBdC1KejiB1dk8Ozkr1cY9j2OJ2WaSX14OJoXs6WMPHHE01HVDnTGmEGREyc7dcZUt+UyuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928582; c=relaxed/simple;
	bh=w0/1CPAj9OEmpYXqh1rya4kF5yYb0G3adRXi+35w65w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oYuFvb8cgS7LuCp+HQPdKjLorXotUuEZlI0bdzBPnXr8zMMz579ahxngKlpIQi613uzIN81LdHShRRkSSWe/LVDYbCb8Q9QK/fMaXq3GFp0e+6ACwiTNUOE5fqR4LYDTlw5ZQ0hoBgLFWp7kWOAQ80iciILH8xRIyaumBqRbsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GMwKisLO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ynp4KWEi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMwKisLO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ynp4KWEi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Nmpl507318
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=50PhvAGrAdZr+Emnp4Nz9+
	Kfj+hnrAtMN8ZqiEDpg4g=; b=GMwKisLOSyAdclz/N6eHyd4QShVw8CJDYwa1ai
	yyznPt7YKHIn1vChkWfg/LKu5j4tosoqSZCkC3nWmDLjSAJCF9AzsbnSQRrAs2bC
	mu8O9m1Dcar8XjJgghY9HyeSiaaMMBH0ijptWW3IcSyAB4j7xIo3ZT1Nk+6SMyQz
	0ObIOdFfiKRbthmUeh3sKwX1OPImjam7UG1cw4Oboe7SG1wP9QJj0P1ounVtF6Dd
	zH3m0HN21xqBYlKKizqdjkYlJRh4no9J7/gDRJzl/scc2vOcYq43UKSbxpT1xW24
	L+LfUO2FcB8P5AtbZ/H0QAmnKT+t7dIJyC1ZYRXcwr3CFgaA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8geay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:43:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c892143db7fso2698841a12.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 00:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928579; x=1784533379; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=50PhvAGrAdZr+Emnp4Nz9+Kfj+hnrAtMN8ZqiEDpg4g=;
        b=Ynp4KWEiqcCiQp+2+39bSVyOPCr6zSkM8jhrrVGqikoMH/APT/c3ylbLl+hSL9x2tB
         WbPFMWOBnmNAE5660/XMIxNCygYiT6J6A0dricV4EWK224XtcznV5kz9UVyLRL4+Feii
         acciwCGbqP3mF/jJuzeKs2lmObLKWjXbfwvELQdyaTPy/ZUSVW0yH7Tj82EDSEYtC2d1
         vfRvbTtZzduVZDIyCieg0WQArTKrhF6OY8+w3HcsYDdDSYblLlCP75c5Jn3nl7HBiYAb
         3NOKkmnP4Roll7Xn/ThM0xxCMdVVe6e2sSPqg3KxrSUkMN38o8YVjU9VPYCR6OTY3PJ+
         gWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928579; x=1784533379;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=50PhvAGrAdZr+Emnp4Nz9+Kfj+hnrAtMN8ZqiEDpg4g=;
        b=TdZ9CQsqHg618rxyX0wEbYXq51eWUqA6DiGn6W8x/X5TuqmfmmFoQ4zzxaCBXXUCwH
         1VEU9o4qf6fOGchUUnNp534p4BCSNJ8ZVmn2NlihYtlFekjE6QZDbjEMF7CidxXpi6NB
         FOOh4EIbhwBqjKAU/+uaHKY7tw2KSuOaz7AmhIXjUJEUbH9sI5ETPGCY0QrtPIEjwdCa
         uhwjMISYYsMkFsB3qcfIPv07bDK9Cj2s5aRR7w6DR+SgCmKyTHD6smxWnFShb6yf9zmW
         qiDNDiH52X5Hm1E9yVMuv5l94j550NvJ8lNUo6S37yX9ACZo5BDPMoDJcDZ0NU0DBlUu
         vmxw==
X-Forwarded-Encrypted: i=1; AHgh+Roaou0CGkGk5edMO55pAfXF0cU9Q/7wktFwkiRo/SDQRmfORAeLSecjes5ara2C76zXLFA0qn6YXQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58NjZ8dotMWIHxuKNjoxhuSi8yVFoBCyY+CpXdGn9TmnfiVHp
	KZS7jEurqyAUj1mlvmK/E5U1tdbNEeRo0TQ5buvaZxHKoJQwvOcN9b3nitFTt1szTLx+wwS8pxt
	Z1/7iBxpGACZ/TgjY1SHFHn1N5+8zMc3fS2/1t1vOQ9CK/O0cMI070MW5rOYS8G7KC7ednYc0yg
	==
X-Gm-Gg: AfdE7ckiybzgE57mK5hcDngAEfD6UsDqso9s/6mYUNOHjPcyo0uK1oBt+h1CYBBHQQd
	9hibEllWhVV4iLdiuS+PfTieRMqX4s5WCtUchB3uLv9rIrsdNahctFcitzYCaMwIOR5WT8ACKK1
	qF4T9mriHxEpo/vat1v6GLRyAZtV1vrSAv9oSAshZyCElf+RUSUuv7kGoh4Rs1GQwcff/A6Yzjf
	n6aXutQ4llsuJkzCB1G5Xopp/pTNnwcZ6N9r0PEpqoeeRWWfDorqgAmYK8+hvp4Zq7eBzxBkHLr
	GcrvIveLAwXCf/Yyw+QIK4wwhbBpaoqYI/3QN+gidWsrYivxIoKh8c5q8pIcaYTuUs4czrve7uw
	WVmIgZ9lQG5nSCg/hO86cVcf9mqetF/VX0A8u2vZTx3fA8idysEkrWlyrGg==
X-Received: by 2002:a05:6a20:1455:b0:3bf:6c07:b2f6 with SMTP id adf61e73a8af0-3c110adf3e1mr8816666637.57.1783928579472;
        Mon, 13 Jul 2026 00:42:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:1455:b0:3bf:6c07:b2f6 with SMTP id adf61e73a8af0-3c110adf3e1mr8816645637.57.1783928579031;
        Mon, 13 Jul 2026 00:42:59 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm61329797c88.13.2026.07.13.00.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:42:58 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH v2 0/2] PCI: qcom: Clear Attention Button Present in Slot
 Capabilities
Date: Mon, 13 Jul 2026 00:42:49 -0700
Message-Id: <20260713-b4-clear_abp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPmWVGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Mj3SQT3eSc1MSi+MSkgnigiLFuiomRSUoiEKUYJysB9RUUpaZlVoD
 NjI6F8ItLk7JSk0tABinV1gIAZlejTHUAAAA=
X-Change-ID: 20260712-b4-clear_abp_0713-d424da4dad3c
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783928578; l=1734;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=w0/1CPAj9OEmpYXqh1rya4kF5yYb0G3adRXi+35w65w=;
 b=Anjm05j+qaCVr2AxpQcVJDrKMxuQK4k/b/+IC1/o2/D1TRet7lr2yLnpD8/iqL5obpOixAARK
 +jx2UpiY6NeA2PrIT52eZdDwNI51PUZA+tXYRjuC4CkEwtaQZtrFiWF
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: YUXkiMNoHAT06wgvoUK8poWcYb3JfX5c
X-Proofpoint-ORIG-GUID: YUXkiMNoHAT06wgvoUK8poWcYb3JfX5c
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a549704 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=pNDaM0vVNsJultrfONsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3OSBTYWx0ZWRfX+SuHgzPHcf8A
 ppnrI/2CP9rPJVXdiVjNIU9n91LQPkBSuwun70VTCEj7h8Zz1EcV05gLiby6+eDjMy7OdplruMT
 gUmtR0om/QvBOahHO6HwWiQOLugsyUc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3OSBTYWx0ZWRfX7vgN2XPY9yQG
 /7Hsxf+cz6SKmGBxl0MdCQ1WNneGUohJDt2lO4PXU+ugOmTeelK+kFFUw2GSXhdYs3md+bwjq7D
 O54w4YUpfhPfOJHcc/MSrtY2+l2oH3QnmF0nhzC9iUhXtdJJi2Fk2C//xYOYxdiu0n/55FEuKqA
 kIwIjTKoAc+apKjgdJSqbdBJII6lghNxWE4P09dlthE2VJ7H0/qlKX2cHtotKSYFMcYU601jifJ
 rfYRUl1IPj/Bu5Dt60XAt05k8HtL9a8MWU9MQr9Uxl3hGB6VUUe43DpqoGr5iDdpQavRA9lD7u+
 OMLclBMLeLr8eSimQcfQxoB7umeBpNuL7MxHv/Vuz81yRcF5aJ7rOk6Hzc2Td9aPQghszhduJFF
 0KiLfDWSA9R61+MwmgZv1VNR3zOKnUxCcGnkZ8Ct0GZU2PtkoULgwoKyeLRBAALSfPhqTYQVzlc
 LBOi3+Q1FB4BvaroNcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130079

Qcom PCIe Root Ports advertise the Attention Button Present (ABP) bit in
the Slot Capabilities register, but the slots have no attention button.
This causes pciehp's pcie_enable_notification() to enable the Attention
Button Pressed interrupt instead of the Presence Detect Changed
interrupt, so presence detect changes are never reported and surprise
hot-plug detection does not work.

Patch 1 renames qcom_pcie_set_slot_nccs() to qcom_pcie_set_slot_cap() as
a preparatory, no-functional-change step, split out per Bjorn's review
comment. Patch 2 clears the ABP bit.

---
Changes in v2:
- Split into two patches (rename as prep patch, ABP clear as the fix)
- Added a blank line before the new comment block
- Kept Konrad's Reviewed-by/Tested-by only on the functional (ABP) patch
- Link to v1: https://lore.kernel.org/all/20260710-clear_abp_0710-v1-1-efd63ebdaa09@oss.qualcomm.com/

To: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

---
Qiang Yu (2):
      PCI: qcom: Rename qcom_pcie_set_slot_nccs() to qcom_pcie_set_slot_cap()
      PCI: qcom: Clear Attention Button Present in Slot Capabilities

 drivers/pci/controller/dwc/pcie-qcom.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)
---
base-commit: 3edb3a038d423480efeb204dbc6ddc9a292f8ecb
change-id: 20260712-b4-clear_abp_0713-d424da4dad3c

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>

