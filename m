Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429549;
	b=25QnzTWOky6Vjc6ovcPPlNSwG+FChCz6Okavz/zOjqM/Ki8BYf9YM/2ac/0Tr9O/8NGD
	 YpxDlh29oHGhN1lfB4KNoEIQKET42KcllAnZJ0SfqBo+ADd0RiYijUmt660TElvTdyaX0
	 Zu6bP6DYn0XYVIzL7mFQKryolFkDthV7XGuZYkmw1hlKJYWa1+N0GGl1Azl+w219svakm
	 6k5FPOZDwwdQTZoO4IGLiNpa3w7//IP2Pd0z4oo/YpzcjrP7xUVI2dmUVM4+U6odNynv/
	 X8YMxTvleYRMrdsfo0P/RaS06HcHk6Ky8cgHYpoKRCYAaDbESbn2Z2D/iDYbTL0tDrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429549;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
	b=PAkirMRkIpVfuM8kKV/iHdNDWDGQFohjHRtSaa4vV2gXzawuVQzMF82yBZeZLY0xMRy3
	 8j6Ckqln/CcFeT9GHV6NraLKgr5uvAQFvB1nfh701+8XSW9X7j2sWbinGBAWVYRLO2tBh
	 CZ9MnIR3MGf4GNcLu7ce0jB88oAq+FPzycucj+xDBD4PM7JUP7ofXm+MXJS5Dt7XXUYIg
	 9paCjUSs4Okx4lnGgfrMg0toEYVuodoRUmmPs0h0YvCwN017rQvndEL4/bbIUk5GPkK4r
	 n5UTK52oT5gryX2U1ETT6SaZ2QuECF1zYrijN7t3Fivv+niKTFuoSswmB25sK27/S3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PG0catFr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMZSX80K;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55060A263B
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B55060A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PG0catFr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMZSX80K
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9Ia1S3490991
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=PG0catFroHWUpcO8
	1ZieIvVdt7o3wG3I/57gd22yhfoX/Ns9c9eA2XY+mRgEM4uuU2CJFtIdL3huZGG5
	8pbfBDO8D3MnOM78UNW3OwemZ0B0O0YuSoayd5B9CDH9QVRUjx6O5/ayV2SW0XIz
	I2KBPeMBIRKY6cl2KtsMl151L2oo0tR0awxHTubgim+fmAay2mwOrjgBuxKFIlDg
	5GSUbLUG3sJZBX2OM23hyVbMeTF7FUbZQmZcjMh6swqJ51RqE7p4ZPbCEe31G95G
	6vGfadHesgz7OcG58VZakx/85fHdgtyp4pkl6En1lS+cDIBfoH1hV7KSCfE/NZ2w
	C/UX9Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evsh52y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so807205585a.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429548; x=1796034348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=TMZSX80K4huuAHvPAe9qssG5wgmUmh7eeC6RQHLN6v4sPudTMA2U06e5s3hrnKQjEf
         pi8fwpNbGc7EE15d0RaQhwABZeHGK2V95sK7v19r3y7m5niLZZuDaQ6Ztuj+qd4B+/UL
         GvWwc7cmE5v262rI4bUpuF/Kl+40lrAGPSWcTDOwkAxHrC0BrHdPO09Ep/gIL6an5fd8
         B/zABLOSQlX3WAp5irnERObJyx+WwVbLO8xluL0CT63LPkKUtrWEcJpworoH+hMcc9WZ
         +NF4f2Zw3QIDTI6MAJcl32qQh3USQ5yKKvX+MwWNccfjGE911AeggC+v2aDVCMY+iknh
         LPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429548; x=1796034348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=Guo8wmh4RgESrYFuFQpuHlAlU2nySef6LpynqRu3+I1LCc0scCbDPYvuH4hHL38CKr
         nBDkjUY3q2SqU6c0s53iepRLLP2Rgle39W+7dj8bdfLMMQBSTZQ1lkrYaUS2exWda6JJ
         7vnuPJR+XuBg00JjOQAFDQhZK8Ipb1mKYkhXHgvQCO4ExC1Wmmc2Mm9/rNLI6LumR/Iu
         NLz9yGibou2yX8yvQElr9qsZerScRCTVukPr7JZ3XrxNbZymU+dGaK74t0nVCeYOURK3
         6HkrH8xVw+SD6a3mBf0aRlNKqNyAJ0/E0rS1a4pp67WuiYJhhTArdUwtifL23UptNmNW
         LHOw==
X-Gm-Message-State: APuU4Z+8Bpp02hN9H4Ja4x5Z9omJEBt+hKqsz+jpGDVpH9He+F0+8bYD
	I4cdhq/AQ6H4OBgd5OPX0qyEVpjsSemn8TlDQ4Rf7IpdGOsthn8d/8y3vCSrZTTCsYOdi0419h4
	zetO8bLwJuQwNnvytcA+WbKZR9EN+3kMRaSVeitHk/15k0n/gWPVftHCANJRAzIM=
X-Gm-Gg: AZFdTZeHwVfZXg/L8JVTxw9YsGzzld1ghtgtcP2jC1tsee7UoCTH56AtySz7yiyH6Q+
	PXWpKPlU73si7EEt4OFj45GR4Ix4Y5ppXZhpGPV47+s5SM2L94HZDD/657XUhEQcQt6q8ntXpv7
	78G0eSLsZpG3XcLLNrnjDCeqGEVueb3yIR/CYRH7wfzP1k+9L1zGd5jQ6DAK5ppzYSJXjuCYJA6
	a3cqFVL2enzBHk+r2ifY5Bok6qdrXej8i4yhjmr2775ImCaXndlngMWUVyTUBCok8zf9zF1bnLM
	wro1KqP6OxmJRELbal+cV2ppWXI2KoppA7WI2/I/lo0oOzs8IHFtUlxjZWOKQ8X2bHkggsCrBvN
	IBnIqq+D438RT8c4ICeeiUonPRPYikzjiX3xc8z1iTUp/bwvGYMseYy1hftmYyy9j9lLO1ZuIH+
	VGU2ZGe9Vvk8RBlKdUh161/1d/3kMkwdlppybpEwpbuSIWeh/1cyErKnVSLNiLu/+qoDm3KFDnF
	NqlleZe9N2lIeeV4NfjhBcc0fwd
X-Received: by 2002:a05:620a:2b45:b0:949:a7d0:9fbd with SMTP id af79cd13be357-949ba9e2668mr1901700385a.41.1795429547607;
        Mon, 23 Nov 2026 02:25:47 -0800 (PST)
X-Received: by 2002:a05:620a:2b45:b0:949:a7d0:9fbd with SMTP id af79cd13be357-949ba9e2668mr1901697885a.41.1795429547152;
        Mon, 23 Nov 2026 02:25:47 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:46 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:38 +0100
Subject: [PATCH v8 7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
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
Message-Id: <20261123-monza-wireless-v8-7-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b0414ac cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TYdKoQidPzFzfLpLj-2yK6XuNQwiPEtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfXzkTCMYOi/lkL
 J2acu0+Z5vXS7oXj41c9P1p2P6tlXtvERlvwyMGUHKNxdxwMnhICyLqRmQzp9OKDLhZpl7lCZR6
 Z5NJ/e3vYe33HokQMalia19SijKfARVic5FD7zOyIMqXoGsxkpzSW08We4fVvTmSwAihcw78YjR
 +b1s52gVqLIpDjYiCt1aGa/qd1s3VXB2X1B6zUIqP/8/w1WMVdKdjOfidJSAH6X/vQKFwlZuUrt
 npY84wLYEqAVFZXmM8o4ZUqbftkhWbiAO2lXRPbAB6tZWBTR/n0Jzz8oX6hkQ1a+BYvDwYFT+jq
 ACuwMKKMgBJC3JswDa9R652mpYakToWcIKc7pd+u2G5HlBGYqd4Tl/k39r81nRpiyp6DOtgbPFY
 D2ukQivniykK+qe4cgNPR0LEZduKZxl6muZzR3Q/ruYZV4hnsuCmH8i0zfgbN8JfMm1vkwg6ha7
 iEmCrZ1voe0xhzw6V0A==
X-Proofpoint-GUID: TYdKoQidPzFzfLpLj-2yK6XuNQwiPEtx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX1yBgRShQGGXT
 rJCo46raDUPwBtFIB1qvxApKrfcN7eEV3HH7tD4xZcaT2GCGg+thH0g6tVzJJ0z88WIdETI2UTE
 7C1NjhOUNXY9WEalcVBh0NFUFPCjlgA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
Arduino Ventuno Q (Monaco Monza).

Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
The Lenovo Thinkpad T14s.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..ce6173a0ec41cfe8ab4a5780940999c18674ab7e 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,13 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+              - qcom,pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1

