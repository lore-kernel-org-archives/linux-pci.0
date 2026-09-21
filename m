Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0D48B398
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988320; cv=none; b=rLDOG9rNgX9onB9IcKaipo0dHVBO9AZPYhh6qq2g3QobXhyr8JoBznLosY+rmnkSRfUGPOk9srrrmlBrUEHO7iNs2Loiy1gUmVsjD5/NR402rLEzL7ZBef92Qwc+Ox4W6B5wuhacWp6aKKqjBbVSRFLh6ghHfrKS8ggjGpRF3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988320; c=relaxed/simple;
	bh=XqGrQUh0pQxlI5u9LP+UKJRIL43iT5tX45CHxhXgMCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=od3wON98iejQqIj/kBSalzs1i/gDACz7CDw6eBE6XJGaz53tjFu83Itn4ujcC1oFkTMoju16Sbk5Ny4tk62khXDhzfB7RA7wwwlWTpHWuDCWM25jERV8hplMEOPC7XumBobgAuqtpE55GU325YyoQk0Weta+3uonrrvFNWmyqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXVi0W9p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c5I34Jf5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXVi0W9p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c5I34Jf5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdtgo2091243
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vo3Y19h45VaNjy1xkCcVniHXb1WIEPxZlIG7JByPcWk=; b=oXVi0W9pQkk1wheu
	JS4xAcTjV0cGGIJqVfAmx0C09R24AVEkfafyG2JArUZAi+Y/dIdgB8jaIz64A8XK
	Pui+pNBWYCatVUNdnBTrD5bKoJILoWUn5/N/MRp4T2xvpU7IhrxTJfYujN2Au5ov
	k6XjE8JvzNOunP+yMLEJ9hzeQ78YDOT9Cngq2TFSkyfk1C+8ab4WRsjTt3Anddke
	wGRF4caUQhy/+nl+z5xlw2X2gYNHnd0xGHKDxO2Grg5k+Cfpv5NBJf08wyqPdYPm
	pBRnI//mq13zO4QmvLWOQROZm1D54eGljj7rCma6HZeVW/fpRQp9baNWBvrgl+Pu
	2vYE3w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3wt094-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:58:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so6650245a91.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789988317; x=1790593117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vo3Y19h45VaNjy1xkCcVniHXb1WIEPxZlIG7JByPcWk=;
        b=c5I34Jf59yRQb/379zR0FJFQ4OGqkETbUedxF6VJMUlvF4DA8A2PDGQQT1ENwtyGqc
         FrFRjNuwGaEB0kdfi66x7IyNQxkprnOdda2LsL1/A24Zsp2RD8pl3ZRlkVdLnK6kuwPp
         UFC5Dpmi7vHXT9afPwHqUyiOeU5UP3BDMVM2KXT5OdbGapesHg+1aYnN5H13uz6SSUIC
         ExmbK1fptif+1LFovXtCn+QknLZ/b4Th2an0r0KARbFjeZPlORbQNPZdqO45XJ+gNqPJ
         Arjk55gP4P27u52BG6yl6tsCZE61AppmKfJK0ZQi1Qo7JGcOR88P4PbWm6MVwRFDu/Km
         +8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988317; x=1790593117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vo3Y19h45VaNjy1xkCcVniHXb1WIEPxZlIG7JByPcWk=;
        b=wMEfsyhvU4d6Oiqm0ND6wPEv8SupYZi1qCENlKtsQpB49VAr9FBuWXh5uS40skyqFY
         /jQy4bXnuKeyuTzi+x5qpw033bnvKpFv+oqooGTtm2DL3l2th8nsbJNkcASjjGxlbSnz
         W6HLdH/EG9ooPQRHhIx4OHtlbZJf/+NWqZ7yk6Eo9U3WQ0IJsD1/OA3UCds7fakokmpW
         jLLVyzbjrpKTrmVStHLZ2IS1R05MrDQYF02z90nhRE3h+0JjiT5jRJbaQE83PziHSj4v
         XwzTL/28EM7GHIXBN6QR+oV5a5CL3/puUgoCZF1zk38PfDHPOtA+/nv+tw8yzy+VkEkM
         esDA==
X-Forwarded-Encrypted: i=1; AKwUvBwuECO99XKz7o3UKvcDG7QsRecJ5r96/Du8RC6O9+YcwZAnmk0zSCuYLhmTEZ19cCiVRMoj5FGzPQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++mf07a2UL4q80dTIqmWmd8jTTaWqNkmmCP32F8iv/OS3wjddTGN
	9INUxXIaUVDx3iMdaF1zzqH/xSHPwkRXytcBCRe+H8jN5OjS3lm6zOy9ZqFajkVemOISzjTbtTy
	4dBBt04H6HGPHm6bxg5/O40hMCoHIaXO4OxnoYlih4LX/SoMU5QE411G753OQt6Dn6jEiXs4=
X-Gm-Gg: AYBFou0rI/C/3vm69/RmgXk6QLZOX7eKhdSSl9tsbgllyLkzBAuy+pP3NWiMK/zIoOW
	HeYytTBPAut47hjflVNMaYFYPAe7s4zcOo2nAdO6sKTrvcgrHM7h8gWprUBTdUBX4mzQO9ZI/wR
	6ykWEs9NsHVgw+B2Kp3xuBOv23Ep89iaMjQQVVX0wRJpAXlHbreEvqyy6uXzkyrQAgV/7q2UU9b
	YbVN9ARB1BYl3kP72MJ7m7+SwgIHBjzgu+V0DebSGfyXJjKuucMSKLGHWF6B0wOPKote9cd7OE3
	MZRxa1DRzN5gX6qTglimtkkybNzHEtv+/fhP/1JZOZBRxCnGDaYSvU8NzWqkmWbRSM0Y8vE9Veb
	x92XrMctY5vMJKk3GWSp5zDK0Y5htOOnmpg==
X-Received: by 2002:a17:90a:e7c6:b0:39e:6a82:afd1 with SMTP id 98e67ed59e1d1-39e6a82bbf8mr10312548a91.35.1789988316509;
        Mon, 21 Sep 2026 03:58:36 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c6:b0:39e:6a82:afd1 with SMTP id 98e67ed59e1d1-39e6a82bbf8mr10312527a91.35.1789988316117;
        Mon, 21 Sep 2026 03:58:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d55cfsm23544128eec.30.2026.09.21.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:58:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:28:12 +0530
Subject: [PATCH 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 qcs8300 16 GT/s PHY
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-monaco_ep-v1-1-63c5282fb0db@oss.qualcomm.com>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
In-Reply-To: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789988304; l=4836;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=XqGrQUh0pQxlI5u9LP+UKJRIL43iT5tX45CHxhXgMCk=;
 b=TXphv9z96EcWO2ZpF3LQqu/44x8GLI5vZQ8CVlLbonzmTdfKTFy+PSBhIjHLrtx+XhdbWCe5q
 igdGK1BPtRsBJYvL+TnOeOmiitsQ/PzGJX6r69ZzUz9GaAJmz9leqpf
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE1NyBTYWx0ZWRfX9yZorQdC4E+B
 L0I2+m1sPKIvi/BBEkrhecEpShYoVXnioIISACNS8kfyCAOXsFCGW1DZTnl+F6fbMLzir2uKcAA
 fXKkFG/jr30WyfBTIjk/z7zKc6PTtbqldptwIs3x7UzxWx/GKy3ky/aiKLYEiVIEcaYnZkuP2Ie
 rU9gba7vdBCZhG5riE2VpgX/L92ODXE7t1iZWUccPnoONC1KIO8nsvTWdt2w4m71g359+0o+1cW
 sm0prK5Qu+gppPgYghtVfqD32Oz5B/6BkNjn7DWk6rISKUy7VKpAWwKlarCrhWGHHA/99aECxon
 JHZG4mHikpS4MpFgtjOJVMTyY200zBlm718dzvkGOAheqy6OuofwguA77x4nYLPKJK0kh7CIpmN
 J78yXj90L65sKN2HMWKQiWdHdXKsXyPjtgj8ortQ+VbsJvCIl2Iv3Xisf2T08i5xVjEZE1dalML
 NvVi0FDNFL4WFTced6Q==
X-Proofpoint-ORIG-GUID: 1W_8jVSSE_3vshWPd7H39HDeuL39GIQE
X-Proofpoint-GUID: 1W_8jVSSE_3vshWPd7H39HDeuL39GIQE
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6ab10ddd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VirKNbUofNnfAjYdglcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE1NyBTYWx0ZWRfXxNyOSpU1EAis
 9lW/ONBkDfwflc/BiRp0RaWU3gJ+5XRpgWs7xZMzWnrdUUKBJee84UtlnspRap1L3Y6WDcqHdE+
 8SMSRMYC7JUW5x/7RMch3sov1QzR8Fc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210157

The QCS8300 16 GT/s x4 QMP PCIe PHY was previously described using only
the qcom,sa8775p-qmp-gen4x4-pcie-phy compatible, since no QCS8300-specific
compatible existed for this PHY. This was a mistake, as it left the PHY
undocumented as QCS8300 hardware and indistinguishable from SA8775P in
the binding.

Correct this by documenting a dedicated
"qcom,qcs8300-qmp-gen4x4-pcie-phy" compatible, with
"qcom,sa8775p-qmp-gen4x4-pcie-phy" listed as its fallback compatible.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 87 ++++++++++++----------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index b353b7bfb839..34d3a714716b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -15,47 +15,52 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,eliza-qmp-gen3x1-pcie-phy
-      - qcom,eliza-qmp-gen3x2-pcie-phy
-      - qcom,glymur-qmp-gen4x2-pcie-phy
-      - qcom,glymur-qmp-gen5x4-pcie-phy
-      - qcom,hawi-qmp-gen3x2-pcie-phy
-      - qcom,hawi-qmp-gen4x1-pcie-phy
-      - qcom,kaanapali-qmp-gen3x2-pcie-phy
-      - qcom,qcs615-qmp-gen3x1-pcie-phy
-      - qcom,qcs8300-qmp-gen4x2-pcie-phy
-      - qcom,sa8775p-qmp-gen4x2-pcie-phy
-      - qcom,sa8775p-qmp-gen4x4-pcie-phy
-      - qcom,sar2130p-qmp-gen3x2-pcie-phy
-      - qcom,sc8180x-qmp-pcie-phy
-      - qcom,sc8280xp-qmp-gen3x1-pcie-phy
-      - qcom,sc8280xp-qmp-gen3x2-pcie-phy
-      - qcom,sc8280xp-qmp-gen3x4-pcie-phy
-      - qcom,sdm845-qhp-pcie-phy
-      - qcom,sdm845-qmp-pcie-phy
-      - qcom,sdx55-qmp-pcie-phy
-      - qcom,sdx65-qmp-gen4x2-pcie-phy
-      - qcom,sm8150-qmp-gen3x1-pcie-phy
-      - qcom,sm8150-qmp-gen3x2-pcie-phy
-      - qcom,sm8250-qmp-gen3x1-pcie-phy
-      - qcom,sm8250-qmp-gen3x2-pcie-phy
-      - qcom,sm8250-qmp-modem-pcie-phy
-      - qcom,sm8350-qmp-gen3x1-pcie-phy
-      - qcom,sm8350-qmp-gen3x2-pcie-phy
-      - qcom,sm8450-qmp-gen3x1-pcie-phy
-      - qcom,sm8450-qmp-gen4x2-pcie-phy
-      - qcom,sm8475-qmp-gen3x1-pcie-phy
-      - qcom,sm8550-qmp-gen3x2-pcie-phy
-      - qcom,sm8550-qmp-gen4x2-pcie-phy
-      - qcom,sm8650-qmp-gen3x2-pcie-phy
-      - qcom,sm8650-qmp-gen4x2-pcie-phy
-      - qcom,sm8750-qmp-gen3x2-pcie-phy
-      - qcom,x1e80100-qmp-gen3x2-pcie-phy
-      - qcom,x1e80100-qmp-gen4x2-pcie-phy
-      - qcom,x1e80100-qmp-gen4x4-pcie-phy
-      - qcom,x1e80100-qmp-gen4x8-pcie-phy
-      - qcom,x1p42100-qmp-gen4x4-pcie-phy
+    oneOf:
+      - items:
+          - enum:
+              - qcom,qcs8300-qmp-gen4x4-pcie-phy
+          - const: qcom,sa8775p-qmp-gen4x4-pcie-phy
+      - enum:
+          - qcom,eliza-qmp-gen3x1-pcie-phy
+          - qcom,eliza-qmp-gen3x2-pcie-phy
+          - qcom,glymur-qmp-gen4x2-pcie-phy
+          - qcom,glymur-qmp-gen5x4-pcie-phy
+          - qcom,hawi-qmp-gen3x2-pcie-phy
+          - qcom,hawi-qmp-gen4x1-pcie-phy
+          - qcom,kaanapali-qmp-gen3x2-pcie-phy
+          - qcom,qcs615-qmp-gen3x1-pcie-phy
+          - qcom,qcs8300-qmp-gen4x2-pcie-phy
+          - qcom,sa8775p-qmp-gen4x2-pcie-phy
+          - qcom,sa8775p-qmp-gen4x4-pcie-phy
+          - qcom,sar2130p-qmp-gen3x2-pcie-phy
+          - qcom,sc8180x-qmp-pcie-phy
+          - qcom,sc8280xp-qmp-gen3x1-pcie-phy
+          - qcom,sc8280xp-qmp-gen3x2-pcie-phy
+          - qcom,sc8280xp-qmp-gen3x4-pcie-phy
+          - qcom,sdm845-qhp-pcie-phy
+          - qcom,sdm845-qmp-pcie-phy
+          - qcom,sdx55-qmp-pcie-phy
+          - qcom,sdx65-qmp-gen4x2-pcie-phy
+          - qcom,sm8150-qmp-gen3x1-pcie-phy
+          - qcom,sm8150-qmp-gen3x2-pcie-phy
+          - qcom,sm8250-qmp-gen3x1-pcie-phy
+          - qcom,sm8250-qmp-gen3x2-pcie-phy
+          - qcom,sm8250-qmp-modem-pcie-phy
+          - qcom,sm8350-qmp-gen3x1-pcie-phy
+          - qcom,sm8350-qmp-gen3x2-pcie-phy
+          - qcom,sm8450-qmp-gen3x1-pcie-phy
+          - qcom,sm8450-qmp-gen4x2-pcie-phy
+          - qcom,sm8475-qmp-gen3x1-pcie-phy
+          - qcom,sm8550-qmp-gen3x2-pcie-phy
+          - qcom,sm8550-qmp-gen4x2-pcie-phy
+          - qcom,sm8650-qmp-gen3x2-pcie-phy
+          - qcom,sm8650-qmp-gen4x2-pcie-phy
+          - qcom,sm8750-qmp-gen3x2-pcie-phy
+          - qcom,x1e80100-qmp-gen3x2-pcie-phy
+          - qcom,x1e80100-qmp-gen4x2-pcie-phy
+          - qcom,x1e80100-qmp-gen4x4-pcie-phy
+          - qcom,x1e80100-qmp-gen4x8-pcie-phy
+          - qcom,x1p42100-qmp-gen4x4-pcie-phy
 
   reg:
     minItems: 1

-- 
2.34.1

