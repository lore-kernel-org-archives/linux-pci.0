Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA9501F53
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536575; cv=none; b=m4P3tEtyDGdcm4ecF2aDrWPWeOAVRV2BTULYyperSwNdDKnTtKb6pyP/yKlK0ogyevfmxGLKN1GIw12lfoxruaxtrZfOPWW1lyl8SAVGK5Tl7AAvlUiM2BZpZWBNqLGDb2SKyQV51NvyQogib10wxarmRGl2mMO+AyWlY0qPrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536575; c=relaxed/simple;
	bh=xbR26F+2IK0SwAaQUmAO2+Xe1VwKVtt+NKXks4bobiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmwW8vOJ/RTA8dvDSBsIZRXDOMJGrFw2LegIng8y25R3HRcomck6SW9a6We6qoJ32J1PYDVFXm0K4OFFSuVBMNlWcq9fg9YwJXSnHP0MICBcL7yot0XJqemwMqDuH0SLKawG7GOn3CtGfbXP3SOLcWtGS6baBEsGNyuf4r6CfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmEHQOFp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C78XCQ05; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BmEHQOFp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C78XCQ05"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dh0KZ3121498
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 15:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=BmEHQOFpvXB48fJ4
	P1WQHuWfNgNBcd48t263ya3ZJ3FjhhfBm4wN2SuGwdL1U261fXC64ttaIDYxEqmW
	1oUwVFtMAx5KKiJ63MSHVAfIIC5dNLddFLwAAKvvd7/dM68VDCUGOYJvbrMoCPtQ
	VQvXNTvIcP+CALYLBm6YOhSrWbzs3krdf8wFvIfz5KzB+yKtvZVgwDLF6Lqqc6jB
	7yPUDMc1gl7psTUCFJW1mOXNw9irpd9wH5OpCx7l5LMO1rWtb/G9mTnVB3ZdH3Ce
	+wqdtKMygx87w72zbuR2KGWYJ/2ngYaqJXH7WKzPcKQadp8lYbhcppfN+yytyocL
	s1D+og==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp1fjn7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 15:42:42 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7475c666b20so1166212137.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536561; x=1789141361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=C78XCQ051C/5zkLm85zxYNCBpzTL6jT/I7Cfftz4GuGn6Uuudg/0AMGWPdXIhRgATv
         FDYluS66mNea4TfdCjsfxSejf2xE/nJ6nH14oIvTRmtiD93fAnA9TNKS1Hxh4O5UC3KB
         VDryFl1e1PuEGC4ZO1ATwQoU8tdMuDyRcCAT4FUcmHJCK2/Wm7sVmHMvPmnW7J9D/3F0
         N4WRujgQ6q4fd+Du26J8oqxF3XRVTJtvhQ8gvgy/oivbfbe5HeAYX/+xejPFsxSb96ta
         Wcy1ZvCY5RRJg0p1I4QQPTLVzAPSmNwqQ9NyfNXW64h+vE+zlS50ztbTZqueXsu/EXUX
         QYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536561; x=1789141361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=T4UDfr3H5OasMZtgqUyuK9SVKQMYFPZBwQvtJFaik87bs+zHX7ntWHkF12XlothdXp
         Uufrbm1f7ULOXP9XNGZsESdgxpzqcTmYI5A40+mzv21VALhltcMUzC23Ch51AUAXkiwh
         pnr3xAv4wffZwoaZS19X6SZNi76qefGLUd05bwVSQV1G8ayHUxshFMnba0MOlHLXEOBN
         OcWVKECg2XianvRae0K2gQHYBocA2sk/cDy0vog0PMT11q9Wc0DMvwYr2QUEHcnv0f8W
         mImPOIRB1IfZao6JAihG5D/QospO3e4llyCm1DIrAFDrGw7Mb8o6O/Zbduaq6HEfh7Q0
         NgjA==
X-Gm-Message-State: AFuF++kZSUrnGAn6KWWnXD+CHLAv3efK/QAjCCgorWOdQue3KgEjRwP0
	PzX10rBBcDPTKpms1/Nrr/CKxKI7pusWaTW77KAjMFfH+ooBWBUyEeR9J5+opNOqZmi86yKI5e7
	YnpM0Ya8X6+vcAWZWQItPBHbv5xC5186CxD7qUTnrgq5f1ZFFsh3CcgOBB8l0iB0=
X-Gm-Gg: AYBFou21PJaQPUxloMFhiEdio5O8QudDGV0EzAh85DowQjshsvweSgdgDr2aPhnQkKU
	HhqN1RlpNNm41vmYpxG7dKG4CVmlU9lsNbEdZyndh2IQoqJv3yEr46CEim/Ys8pXhCBdj9Mcp9l
	szAy1apzky9Vq04B5N0I0mHtxqdFwi71HFJURkDLu5/beoamI0ETSRvPACJ2ZA5LWu6NPxmk82b
	e87fPbEhsTdbrO+eT9BjcNDJyzAXhGtOUgDhEmL/RmuZACCNF2zExhNKF4YcK0E512Fa/TkBgBK
	kBrR731cK5WiKg2zlFBcxh3PeIf8Xh7F+4HLFim1CDdecWI42S7ZVWqchkgm9/tr+mK3/0g21IZ
	J5OtShFMcpyAM059xqhEJIXHK+acKleL+ANTtv5hYlGx3ZvFScQ+g7KE2l0N7/oDNrTc2xZjc6P
	GMfUEZxycnwD7Kf1QvFmK7gXps/XofQJ7TNNHabbVDzDp8ki4vVBs=
X-Received: by 2002:a05:6102:570f:b0:785:e444:15de with SMTP id ada2fe7eead31-78a4a8b86c6mr2764705137.6.1788536561264;
        Fri, 04 Sep 2026 08:42:41 -0700 (PDT)
X-Received: by 2002:a05:6102:570f:b0:785:e444:15de with SMTP id ada2fe7eead31-78a4a8b86c6mr2764676137.6.1788536560793;
        Fri, 04 Sep 2026 08:42:40 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:25 +0200
Subject: [PATCH v6 10/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-10-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=F+xnsKhN c=1 sm=1 tr=0 ts=6a9ae6f2 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: 7eEGcZusvCnJhU2FVBHuQ9-5F72Z9NYX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX44XVeEe0GVqa
 3KopIB+CKIVPqvHO1NRj/KPm7sf4W1kgfcZ1dH5PdV/IobZA7V/9RXG3UOrlBok+5fJAs7hA4kF
 H4rnCDp0uIzZX0FgCd1PbyUy3aDiDbI=
X-Proofpoint-GUID: 7eEGcZusvCnJhU2FVBHuQ9-5F72Z9NYX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfXw5KFJ92BE0es
 jlmMyVUXTwEy2Ik0hN7+TUrIjXR32rCW7229lpQhEkue7mNp/h9KOdoOd8QUuLUiVZQQVoPmCRf
 JdwuT48+cjoPvBGczCLA1pcn74E8PpT9McmXkyJ/piOHZLgiMdhYSg2REK2cK0hW+BPAJj+siYh
 PpIlsI7c0A1dkSWm4uOQBsCY6FZqNvSrZBrxM5AGe0QoLDawF2XgqjAydOVhqaAHF6TdVRKeURR
 5ZpUvvRM/Ww449Q3guYZx7T/JVn349oezQTSQoPey7BpcbCklCfpbUUwZkRdXZemX+2B4ZioTc0
 HVd8RF3lWvrESrDKp0b45R4AClJIxhlKbb9qFoq/Cl0j0x8Clf9ZRSYS6YexaVosloG3YV6QdJD
 oURxUF2P+J3n/BrcVmYQ43/i3uoArv8RWKV8C3shNQjKkQ7clzus2EEwCyLG/Gds28v5s7d+I3w
 AY2G/W2TX/LhSIcShHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040143

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

