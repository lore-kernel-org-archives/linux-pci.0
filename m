Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64873FF1A4
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677474; cv=none; b=fS4pbHzup/0QMbSAkct7/bVL3a9z+1PD5KDcs8b9wE1TSmwxUl7xp3DcgYhPkDs9U1xgDOqcLm8MRj/HwZTDewbnSOSOxKgpq6Zc5shHWGTsYnWtqaNFS2L+x2MLo8LAYoBARzTAeiGjBw2U2Czp6LKywiAz674hi0VFT1C5gwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677474; c=relaxed/simple;
	bh=GEXkKTQcMMDP/edNVqpiosVSMOlJ5AlopPURs9YheQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vp8Bu3w+YkN7IKiv1qXAp0dZSqtYQr3UGYbJA1gEaduUfnoPMraIgdCL8HxkEujzIOJfn9Io6NACO1+bmZ1ewVxRRqq/MPW3060Qo6Zz9cQu2HmVydX/cRnOGrddv45T0TfmWgyWRyWovnGAT81ZOR8uFT99aOLTGx36c3YJNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTfkrBSC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a3EHxBYK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QTfkrBSC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a3EHxBYK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dWFJ056455
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PGp6Gz4cU4q54LW0ORFzAwYhub1+CHS+HnXdjrR+z3o=; b=QTfkrBSCtwQYBIgA
	9/BP+CdDEcojUzMSbjD6hDcxDj8iBVqDkA/tXoLBhE5W51fgAlZmwbyXbWKUWvBL
	kzc1IECbrgNOXxhmMKGBQhMMz1ZMsdNX0wchJ1cbCfzFBskfe7JwuFYh4PGX0Ax8
	JejxBKj49wmapeykb4tvy/J4a8fT5DiRfxZTOergejvB7gc9TLk264PGv04zUUjq
	lK9pV0nXrZUkm0DUswJvddkTB94HlwmZtg1Zuk3p59SBj2OM5kW6tN0yJDpoP88f
	VLs4nyBA1zWz+iwb4+OFt0psbr9GyrAKA2ke5xPWpiixmTKG05dyi4MY0NYFDZv7
	wX7c+w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwtafqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1e6f602cso12350601cf.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677468; x=1784282268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGp6Gz4cU4q54LW0ORFzAwYhub1+CHS+HnXdjrR+z3o=;
        b=a3EHxBYKq7aRCD2vIozgBsn+Jp2M3HaBecMXWmXWuHjFcsGAACLwNNh5Ogypyk9qe1
         CBrs20BUrV0LXTBjhgNDAKtvuk7WRJCD4CfEHfCeo2AkCrEwwW3cS9KMuyp9ShYY3rKT
         1zU/S0FHCmoQJHx7TlBrrc7Hmd7KgExVFyrYrj2dr/d4u4zrw+B79StqQpRtPnW4hOgx
         gfZu67f6pA8kYbRFLzVErOzKVwO3OQFa0DvQc01GLvvvWTeFNqRhAabA+iEhXcZWhbbi
         nXcIfeSSYB1GoIelL+LxBA+ZG8itzQsZtDchZSfb2yRFGPm1iw6GkycUOOWW1MiljkYN
         DSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677468; x=1784282268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGp6Gz4cU4q54LW0ORFzAwYhub1+CHS+HnXdjrR+z3o=;
        b=nTjQi5HVn24O2k9d0nv3rvZ2J+dezYfksdFP54IkPKwLcgztf3c2qFxaXHCGI7zbbP
         1QwiNpW4E6IwI7K/3me/i9xi5QQQDw3wZkRj+ozE+l8BV6/5XGx6xvKQCfhfxQh4+/5b
         HERG9zsVV0IE+oOrOy6vbML1I+PfdyPqbXO0bNTceAiOEZHF0oNc1KVYPNjFeyZpqGHt
         B/mnWtZtUA2vVcy/Bn1GSwt3E6TgKB/Dh+yj+Fbb2JL3ztlLJjU3eJMO3Ud8WtAFFeMp
         /9edvfk9MgEnknpDlYr/bwCBDWypeyGONTGRZC3sRiEtnykxsDumKRkyADXP+KFy3/1u
         0vAQ==
X-Gm-Message-State: AOJu0Ywv0ngTKAC5ytz0qJkLchCix6QEOJM1XZrvyR9n4yrFsIcHhf55
	1CkkivO42LKsKDfkIR47nqOjhTHzdBwU9mscm1/eNWHoyrAl8DiJlRRI2PrF4EvlDGOrTbyPmHt
	MJvwiUn787yzIa0dHAny3XtHsvQVSSALbt8texS4PYcY7gqf/Whm6YFXp07OB0rw=
X-Gm-Gg: AfdE7cl7EOPHjRtNMeW6EKK1rd18Tn5m84EzvLjOtQgSe+NZfnN1oMkHJgr3LznDyZt
	BBfn3AkkUpvoSKpYhE0tCl/JX5sgZq4+/xbRSlf92qKpM0Q+dSLyhDzAuHkgX6KGnsb69QlAy6L
	ytl0anIn7XwNRyHOUJWQfYlj8VDob7DEt/9TIDyNrTy20CJt/af6jDE7kLWWivtPsAWsQOZeyOJ
	KuvtUCg55QhcJ9tdLyUB2JNs+wtQ9w0+4hO1SUoTyF7QjjEXuLtGdSsr1rz2R+dsel84IVmvJSk
	RJXNmdJ117amsMo+/Npe3ycTg4CMCEOM5vUj9WRreDzljD0u/6YxbqW9HpHMviz1C24pHJK4JSW
	ZPeQ7KupzQc+hE2TQVxCdpLBH0g5Dh8KmgBpPFlatHN4rR/m2c1BXTfxpJfwb7yNUtrjXJBDx3t
	h6FXiNj7JMij761KVgB7yIGLyUZvu942BnxQUQQHZiJXRPyVb8JNGhqiQDxGliWhM3WVSzHuG9V
	32jXWv0FyMkvejFsvhp
X-Received: by 2002:a05:622a:5809:b0:51c:7b12:120c with SMTP id d75a77b69052e-51c8b4bc4a3mr138323681cf.74.1783677467999;
        Fri, 10 Jul 2026 02:57:47 -0700 (PDT)
X-Received: by 2002:a05:622a:5809:b0:51c:7b12:120c with SMTP id d75a77b69052e-51c8b4bc4a3mr138323431cf.74.1783677467625;
        Fri, 10 Jul 2026 02:57:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:35 +0200
Subject: [PATCH v3 09/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-9-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a50c21c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: _Hz0WzC7Q6FYtxjCVmwV3HyGT-j7DccH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5OCBTYWx0ZWRfXwyEFq/dxhdZL
 g+MBT+K81zrjVMuqbNs0GUtks+KzHNs8Q1yeLvWXBMgdeknJsTJ3myXTWP0O1THL5EX9iuAwsfd
 rGVwkBkBikaNe7UITXVT5t+aHvO1uWI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5OCBTYWx0ZWRfX2u6RpgSEEi2V
 JVfj6cEN35wR9JWlJJrqGUD7HSBH34TVJLrVks0DuaVh/mOBYE38ZMbJagnLNdtlqhZXD7OtDCf
 hxdiXoISrhDtP9cvzpbmdFgJVW7N9kgBz8WOU3ZlFtjZ1TsRqabZgh5FPxDQ9Njbg5fvc9x7hDO
 xreS71jmliv67tFLx27lBrGTmv8GWaQb3Sc/U/9IfoBwiw3BrtcH4VFSF/iLMTt29VzvpX8QKok
 Bxl5hu6k82+in3qPCj9yJSlnCQO6lYscEnmOfL5Ht4CoA2QL1ZRLiqHoiG547JOYpTr0qssv8tQ
 xtBicPi8SVNFpi/UD59DAnh4H2/aMK53WkFYGAZLrkCAUEjbRbhNBORvns4Zsl+/t5n2Ss91tZa
 xC+s5AWEbEA7T87ESHN0g060xWzuHYzLgJ/k9uoksE2rmLB5Httkr/fTlW4gjU5MfTzxaLxafd/
 AnJsWLfYXvNYzHG6lLQ==
X-Proofpoint-ORIG-GUID: _Hz0WzC7Q6FYtxjCVmwV3HyGT-j7DccH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100098

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml         | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..0282c6ee9272446064a99ec6314a5ceb1721e0c4 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,12 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1

