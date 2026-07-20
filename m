Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3F3D1715
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534670; cv=none; b=PkeONmposQP4gRf87A7bP39pq5yzMO8E1PmfyIRCC1B34nV2cdt5jIitLoLZ7eXaQqln/0C1i/VrIPAZQjNWgvGH4gLepUVbBsXuW/cYYhgSsaYcyWdWM4rTvYkwDYUhknVF8D6zai6pMOYtmkL+1e/VsQF7tPVnVv8ClNmKWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534670; c=relaxed/simple;
	bh=xbR26F+2IK0SwAaQUmAO2+Xe1VwKVtt+NKXks4bobiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gt+yD9wM8BIJe69iZmeLiSFR5kfJj06Sh9/qgeuZNsiPd9LMz9tXLId6D/JJSGebW1xa9+VlT3Xl9Sa0dTsjkmuy1rKpqAa2G8/98Lpaa9sBtSSW08K/3/f9/2lQsU7eyHXvUn5zl3VX8060+PR7AZJfFrQ7aIkPGuFwHCzzOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zzb3Uuxb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=My88WpM2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zzb3Uuxb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="My88WpM2"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RUZI1665556
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=Zzb3UuxbLePsf19z
	VswifbdogvpjyA5p1PavnkbKMv0olLZEgWqdiK+G9OQgGtvnnjfeLWtOCPPveOv0
	5n6sZeUQzDULQK+9/Xe+b216bmSzI2a2Cptuab1M7QgBLYGs1RVivj5Nzcbkww13
	yJH05x2VQJ327Fdx9k1EeZ0pxQDB7J2/nhXJ4wUeHLYaZbkyqVARlvipZif19H+5
	aMjIPznq3xl7JnKyH+ALRWFjchDANKMT+wllLoJ20Eg0EsBo5pxV8nnvjPoMpF+u
	a2L2Ccz5aq7GoXdIUDghFrtaILLXaGsTxg0wQ+d0I3IsG+tysUH+uPKnTWF8uBWZ
	EHDVjA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04v2ua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0f0a0760so235537521cf.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534666; x=1785139466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=My88WpM2gr1AKY9vCuENEKESZBIi0XiDf/Sg15JkBKm34RNH/j38nsOul0MPreU/SH
         OVsEF8kmB7kXjpaqnesKjQSXzXdiQBHVDzT/ibIbMLUS6dRU/L1+y3YjxjgEllM2QvVQ
         fGdB/B3ApquHMkPj2qZ2Qv3kzgh6689fl6jdRucaLNBmNPzzw7MKu007nN3k8LEC+BuA
         neKKXcWIPNpC0sTgtEk7k50QYvNevwGLCY+sgWhKANjfmIWBbalkWbi2G0j18l94Ui6+
         KYqYe5iUv3MZSv8Anf9GHFfETe/0AKoVbUFvumdjqEaN6gU+Npn2P2jrYAuNQZWHMXIm
         rUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534666; x=1785139466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=YKDm/biGfLgw7VqOuRmSilxDZuiKOgR5JQ02DFNB5zXsp/bOIm/rC6R2pTW7KK/jRF
         hnEwcp827w6r7gWhGoIBnjK0TUPPGMF40iU1h/m5NuvFunsjSpnPzqUKBHUStX8qFhTO
         kdgVWwj8fRzQeRjlNYBKxRJ7VxFbZTw0ktudACFYBdyp2FBBfZg4CFykwO8p9ojXLQki
         ZvHQluMiEgM7LdKHA5qysP0ZCrf/j15ANvk+WPKPOorM5ZUeDNKqbvUe5sFSLsM5C7+T
         DsrqOV3MCfxLs+IgsexABJ7dlx6xghs8HORfJB3wzlZYmLCgpZF2rKtz0fqAgrPfjPW+
         YeIA==
X-Gm-Message-State: AOJu0YyDNGWhoyhS279FvAE859Zg9zemg6V9U8Tp4DfwtnvVnOCjnXX7
	k2yVz0GFTMA8f9BaG+u55/Cd/aJEemOQZphn0a2C2yCKOBtLouLt6lbT8yvU4jlOUuwUgmAfhmX
	gQ5golOBZuX2XwHrglGGJWUq82ygx6cIVmqqv/uO41XAhQU6j5YKwQda5I2TT0lw=
X-Gm-Gg: AfdE7clqiUpS/necSYC8QDtNtDIMNkA0m8CrpiYHGrRcDOIYwx6/KIY86es6zYzeG6/
	Ed+2yRIqMLc3R/v4KSVXoBAOP3B7Rhcf/Hy/DFzf6C0IhRd5J7hu1ldeCv+nra31FlnIlSi0qs+
	lbW8x3HvDiagJyWRlap0S7IJ4Hp7JEnAHNqSGTh24cKU60qbMsnvNaY7m6itmVsuyQon5V/2T4U
	ugBPUTyd7V2zTZ+VwpolSzAP17dcJ6HiqvfB9n4ujKGAajj1zK3irFgUuxgBcuFhYcrWheZg6ZJ
	l1mKCKin50GQqMH74Mx55Xc7pJs6uLii/AZC+/6KEhdzNkXZNFCN1vgJ9LIbydy5ZE0YhiswImW
	WCFVruUEMsDY7Nby+iv2ztCTZWDoHXClbYNguzSGxsF5o2g1v4iR58r2pO3eX/g6CyYdjAzf1pp
	hx7wF/f7ttzxxUmA2+P5kxuRO84tfDcqypEzFnMoSYP+LRRdI9fzo=
X-Received: by 2002:a05:622a:1b88:b0:51c:1027:34d4 with SMTP id d75a77b69052e-5213c8e37a7mr124754331cf.11.1784534666042;
        Mon, 20 Jul 2026 01:04:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1b88:b0:51c:1027:34d4 with SMTP id d75a77b69052e-5213c8e37a7mr124753971cf.11.1784534665522;
        Mon, 20 Jul 2026 01:04:25 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:24 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:11 +0200
Subject: [PATCH v5 09/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-9-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5dd68a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX1zU3XlCa0wre
 Z7l/wTkChhIqa6LdhdghUq25t0SGw4bpsAyOiUK6yqCXoYapQq2HF6y8PEA2ruEpHdRfgK7HEAB
 oiVZPBtnZQT09XhChpPZ873tsT/bE2wmopBlFxhdNyMMzltuSlPEPzMVRhadx2S1FxWlcKyu5HF
 PfKI3rbKmGbtzNrFmnGSci4q2qDWuuBnVwSlphUbz9oue/5+qBreiHzawtgD8e06KBJ3jgHwp4n
 XcT09anHwIV79YSfW+IGgg6NHjp9p/DXWws2myWyuZhJqXZ1+I4IPBZa8d6jrGySTY+DNida8AL
 XBH1fugnSveOVvUtpFEl6typaDxc721TGTyoqLX8T5Lq3OECQVN+XTULD/jIq81EIIsgtEb2im2
 e5Y1mr+2quNuXARolDDgZJU077kGMTTPqjW0Lt2aAqdqWWv6dJib4RqBfqbJRuycoTvprtzA0+p
 Jo7M/gyjJvcza4EH5Xg==
X-Proofpoint-ORIG-GUID: b1dlNdCorBohaIwqjC9jjEIEWsNITK5Q
X-Proofpoint-GUID: b1dlNdCorBohaIwqjC9jjEIEWsNITK5Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX4OGh2Gt6nrDw
 cUroYjBRJyiE90Ats217OqYmdMUqIW1wiBNumfMGcFBclx743i/9gg1FkHDBjefDTF174Ts5Bdb
 8NNv/SjymtNzjBnzORAbJqXqUfq2EVM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

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

