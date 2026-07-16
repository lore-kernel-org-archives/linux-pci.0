Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011237D123
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218734; cv=none; b=I6uLMxkVJPam/RmxjNSnpfgSrL7JjQxxwDUEBjRSprDvLAk2F0x9XhogRbyGiMh3Tga5LeQSoUt51ktLEE/XGofkv9gOMb8ioOix1vtfOJcJRmxz/bh0RwLd9Dg6X38o7vYN2JZEArjfhKrlT64Qm05Z4dfJA+Ih49w3R/6BDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218734; c=relaxed/simple;
	bh=AKJ2rYuq3UXtw84o9Wv2rgBoSN8Fv9N585Y291G3LZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZwQqCmufIWFrNLmP4VXWzIOu0CESJGvY7zmkWkZC6g2aMUh+ptvrof9aqgCGoXN2tSa4X03Or3NPQ2s8XfIuz27MZ2gY0jdmdmNG13Eqkp0IS8Ah16KCHfeZLJK4jBk8TgElbxhWiKXESI4MSTd53F7hjVQceNZFttlN1oRmeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iASYWyQi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Om2F1dG/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iASYWyQi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Om2F1dG/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJefB2691552
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lSQgtm9Gy/goYjkRUPvH4fsLeTRSZbUNnPPwbkXFunA=; b=iASYWyQiOGz5VgA/
	XTn0KGINXOl7iwun+L+oaK4UAkSppUti72AQRZkNnhLuR7vlGMy9mYHpJZTlL1AS
	UCOFvEyNexd/9B8cYqhNYm874EsqBHlM2inRvqdW77kI96fLNTftVFb/lYiKLtsG
	izL6/2U1hmISKnZKom+b04CJLrwYK/woloqfhSEsBa29akkHZBX4MrQzNyd+LEbG
	YONpu/dlF9TLwyHAXLY1UknVarwA3a50abYjFz/NLt7GhRneucqbDGu+n6johAq5
	POp/1A0LGxxHL8eQfEhXIKFoL1sxcvK77aXu5LiRBgZT/jAy/9+35RjtxI8XPFoE
	ub5I5Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7teef-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c19493ac2so119581571cf.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218727; x=1784823527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSQgtm9Gy/goYjkRUPvH4fsLeTRSZbUNnPPwbkXFunA=;
        b=Om2F1dG/TPprhVLtTTu84HBFuIX/VLA9V87H44omjhwZIjIysE7EYRlxEr87JCDAND
         Lyvua9Gm7DPR+D5T2bSdvsU82niwXyLs0UeI7DlnIRwigEZlKDOXlh+dNuCB8owPzNWb
         Z23l01uio9zw5uNvp6dZNcj3lyU4wikcXhBN5PhHOIXMyTBbX9cV9BNcv64/LXvwHDDO
         rNZ5Vldv8KuMQvOg7EbKc4dMfyzMzO6YHm6RwgmHTeuyYvCPSCJ1gqKLCKAaE7cf+apf
         1GF1aT6Gj4HnETHq45DgeFSfYsxHfcRdTXXNy8+bKvauPVtC86Io/5eRhdZvXv79hUJy
         3piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218727; x=1784823527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lSQgtm9Gy/goYjkRUPvH4fsLeTRSZbUNnPPwbkXFunA=;
        b=UcPfop6P6DmYWp9BB/WQp/aQX0bPqrCf4f6XiQSyE3bIiaKb7X1MYzZN+lNRJUyEV/
         JJTAs0AeP8CXc6lVeZkCXO+QxmbNfw2fhxXoTrV2Djq3qtZId0Hq7dy1g5lPDW/NC5kF
         oKdeWf4umg2QiqHtwPorpdunaCJOLWDA6W/am+Psz5bO8osAEZZqQqBy0eoTGQvGdX8g
         0fVSnUo+RPJFzU3oirSASinl3+bkO+xx6Iub1N7hsrC7sbFE7mr6emvZ1dyk1tWJSILP
         67oBmoYe5GPFxDjgvJb/kKRfQg8F6Em+sOH1lJ5DbB2mfFV8MwYGwR8aKK+mIoVNj0G0
         cUJw==
X-Gm-Message-State: AOJu0YxBGKi8gxkbiRA+pyNu+0oWpv1gKtDTvBJt8bqsSxpKBLSg3FrZ
	ViX1xh1EYq6ADadJlrBCXLXVKtPtYHgz0SbnJl4BBmvtr3N1RmeE/wonxtvYHyLhoYkNDBTqUY3
	CAeNYcsxMGMPA2JpqoNAWVFrUBFd6q+l1sfyC+vKhS04WaMXcoTlGiZN5ObwdXjM=
X-Gm-Gg: AfdE7clefG9O1UcukcoD7kSJu2LamDekIfw03JSI0vtjhN64JGd8VWe79/7MB19Bp9F
	nhVkAwcYJOhg/JOT1+n7XoFcK817uW9lDPgMrbMu4vpqWLcZ60c8VAiDx2xV1YozIXF2ULB0S8y
	YkzBxIkFoMogZNLUy5hAKLzpOVtkFlmr4vSXdvvpAAjE10HTvwZRR4UeEAZVnzUcZ7EBa2KascZ
	BaHOmQO06K/IY4tldreHHFR537+8reU1rFBG4TI7+sg8RW4BEFFOa7hfHzlX2tBp/jeM/BP5t1Y
	Xsjpn9zNyGz1DvVPfBpRvZfWPZXFDXVbZ2Qngj3uRetd8AX1qsUiUV2iZqb1ge8cn2fRu9aiVkH
	M24TT3i49iUb72GV6pMdrDK/0AN3ZtGY2Bc/LD2lCXmVGhcRMuTiIMrpyD+i5W+Dgy/NfxBNLIj
	rAAieT7vXyUISmtfdvNGn0zIML7QGEADYaHUnkxUgKpeDi1SBZ83g=
X-Received: by 2002:ac8:7f92:0:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-51e424dc615mr122134691cf.65.1784218727544;
        Thu, 16 Jul 2026 09:18:47 -0700 (PDT)
X-Received: by 2002:ac8:7f92:0:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-51e424dc615mr122134121cf.65.1784218726995;
        Thu, 16 Jul 2026 09:18:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:26 +0200
Subject: [PATCH v4 09/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-9-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX2jo98fZRxYyy
 TZUX4oA7yx0KI4fgp6HIvXm7QI5CasGcHyw0oencgwERITNpbkdaboNMOQt2J/iuoyJR4lhjV69
 Rvc0WTqV1y3EJR9baFVAMmC5wbOLL94=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a590468 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX9w+rrjaoBB/X
 adyvKLtcnT15GmWjrTgjVvsJSdlkd6ZhZ8yXq+Zkn0QzaA5SDAKs9YOJm+JJbEapbmVUO0BYFkM
 nuBK7kkJIaDWqzSN4r5lPTDsRUUTAHAZREmf4P7s2PDBEQVv9tk+rb4VYDxpFB90SRtXjuoTB3K
 U0Sgy6YNaqaktCgkhcAI5oRkwRgB1NDLxzRxwVh7icsgibq+END3WouWt2xqLtLDspR/jgmJHNf
 qrthNJxefqkduDw0kYTyzAxfC/JciXq3T/+cvp8VN+1/RClZOUGFwf85zzUUEq4PN9L1e/xkNBW
 5dLn2C+JqLLkAaisogF6Sl37dVAR6qTsspRy4K048XTaSLh9BcGzN6ryfbICt/+1Nzk4CKMyg0g
 PFJiOi1Mus6Vp7GOoxEGsptc7ACip198pIeQCd1lGDjhHld8b/neZA7UrMkAU/qWNdAJrt+hBwx
 gmvqvUdbTZxgmkanmYQ==
X-Proofpoint-ORIG-GUID: pcsoFO9ccyuo7EF2foKbbrIfIw0J1ZAT
X-Proofpoint-GUID: pcsoFO9ccyuo7EF2foKbbrIfIw0J1ZAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160167

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

