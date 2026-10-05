Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4F47F787
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202923; cv=none; b=S49uhRx0znlMMf4yfttlDGuSP9vo/y2hJQAIinYJHuHKb9dZQ//Usirquztg/esmkId4e4zDSpdXm17kNDf4fOE5+4PH49m8th0xxYlbBqg/IRVMdRErOCvgoKtkeQGO08EOVxQrS+Rlsx+4JjlRLUNTx9c6nVTOT20yU64DlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202923; c=relaxed/simple;
	bh=xbR26F+2IK0SwAaQUmAO2+Xe1VwKVtt+NKXks4bobiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXwC8dBVNyx5ozaFnn8aIPzw1MjV4+9dnGursHYX3fHz1eluyJsr8NdofPkgOiJoV0kjXGeMheRl91mNZRzD3h9yiueE5rbe0sviXNl1s2jgJAYZ5VdW/hJIkDQdOlpHqKZdVKKjog1ZbdP1qQM3kuX2aM98rkMWMcm/ffUAxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ioHZLbTk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iDvie8WH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioHZLbTk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iDvie8WH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFRot1068614
	for <linux-pci@vger.kernel.org>; Mon, 5 Oct 2026 12:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=ioHZLbTkI8HGv28H
	tNE8ptOu9b5+s59oYIITySvzWwj5tY2S24RnKztunJg8SeNDEFBvRiQh0li6LWsB
	3VdoHkyRU4mIgHljog+f3M2tXUyn2M6QPvAl0abTpvkuSWyzm811fCPoTyyuQTxe
	rQuXaR0x/pZ7mMwU2aGe7JTLdE+RbQejyRN3qkiGlzVlauMBxzngl/Br0BUuiqmF
	zXfKXPNvNH7igZRGtBXHv++Zo5s0F7Ad5HEe2huz2tz7MiXM82m6XArMlcGRJAXN
	RtnVxV6RwFZC8W098RkvT0w47mLbK+J4mzZypAVZBjkHSTT+IcaPNS8r/9VABFUI
	ugJFpQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2u08nnrx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 12:21:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93dd3c3badbso357780085a.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202918; x=1791807718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=iDvie8WHK1AtDSaV7haK48Gv8S47yGjzY/83q+OHaWyvAN8+uuG0KpGA6veR6eGLOo
         zWcOZK1fDaIgwhqM2EiQeVo1ZApPWFC+cKk5iHO8L3p6hFBgUuwg/LL3nlQZg16A81vd
         pZVwcVpqMXb2Ukn8zupGWyNzC0OPW5fVnLY24Hu03LMqtM+B4YZPq+7RFfXTo99ilPKA
         5tTX4KFLCoGJY22o/woI32I4gVryp/itKQBOumSrEb8B5w3MnMDh9XfvQcz1jbGQPBVm
         CRWQPoVU9ZNZ7B5Cmg1PylhXAXACdxlmPJSS9Reg0Uc4ycO2uZOkVdP8Zhi9nglNLWEr
         xUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202918; x=1791807718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=psfTBjp2fxF7QhaAFO2KMVroiXi9S4bqzPyAwDTqWq14GqnS2SuEu4gTQ0UZ6rWEE6
         5xDOHl99nTAPcnlRIKTR+w/D+m7RbYp+v6bQlOkOhqUPpK49cBzmF8w2uLnJRBOH/ymD
         Mv1yP1VZGG0neX6igHn8EIREQL7KiEFZsDdt3KCxFsfxGNXsHA1fz8osgC9jVhrHLPf8
         7L5USK5wOHp/h1UYZs1dQCXBEqRsrzofQDgS5WDTZZZ2FtV38K4ulX4fMMz1eM2PKl7r
         bSABop8Qr+DpUEcWjS+JFeZ2eFVAUHPnTnhpFt7I1DSnyia0AajpWtE8pZ5lwuttayve
         pOVA==
X-Gm-Message-State: AFuF++n6Sa8yCW1v3HrB7yCqmNK8BA+qsfOgNXQbfIa5RWzwOV9eiZtu
	QJKOE5P2IaLPhuR4a3fuQYQZq3udf8Unv90Hg7QfvAah4woVuOV/9UXT7TF/4tzQHlQenVts/QK
	62OJnSlTyn2P75KAORA5mzYuEx5hyDCUzcjaPHORSyQ6IhWypF3GpKAgvv3ZlzCo=
X-Gm-Gg: AYBFou20AgpCWbg3gh8ExUZPU0d0D/48flMUEpy2o4XZ1vsMVLcgInDDp0zaVDFYScI
	IdwJgyLdFT60wyklDS0UXOEjct9Uo6kPSODtPMKoaN9keAi4tAv/PDb259BAMPxQW6SeOMwDG28
	nf9WeZTwLw97vdfwXjoKrxQgLJAr5U94z6uEfl/Ih56XDgjxeSIK2WhGOD1kvADXiQZRnzgDQSP
	FBsijtbmi0yeqQxaEcn7x7e0mDvC64J7vQbrEkkHgcYTJnjYLPnluuC50emk+LKd+su2xBXLijy
	YYHsd+LIqr0cWnYAtYde3LMGOGLCE2zXVK3NRiitFUPC6l1HwR3Y7RzuqcOFUbz9r30l0vunmhe
	EX0gCXujjSYu8cUtqJnOLzHNmFMuF94P867yk5VWzAQ48KuqKXu4ck9nRE/DfzaelvOVgtR5Daw
	4PcHN1AAvYuFobXVjtYrGiy28RIMIF4DIQH8bjiBAfYornUOfLyEImdyVNZbnIcQ0/lAVzQQ==
X-Received: by 2002:a05:620a:414a:b0:93c:bdb4:2be7 with SMTP id af79cd13be357-93e510cc94amr1222902185a.60.1791202917816;
        Mon, 05 Oct 2026 05:21:57 -0700 (PDT)
X-Received: by 2002:a05:620a:414a:b0:93c:bdb4:2be7 with SMTP id af79cd13be357-93e510cc94amr1222897285a.60.1791202917216;
        Mon, 05 Oct 2026 05:21:57 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:56 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:37 +0200
Subject: [PATCH v7 7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-7-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: gYJd_be0v3AeVWknepWrnV0vBnLFEv7I
X-Proofpoint-GUID: gYJd_be0v3AeVWknepWrnV0vBnLFEv7I
X-Authority-Analysis: v=2.4 cv=JqlkP84C c=1 sm=1 tr=0 ts=6ac39666 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfXzG3eqnTbGKjJ
 /ks9sEWqqBsdns8avv/fgYBePlf60pTnFyFQQF2OabbtsoFUcr4Te+xfUmaO481v1m/+VsCWnSI
 jD74OtvILguVOReLmkfFrV2hWamWVzc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX/iZfYQkEn1AG
 PQYpPBZdYcQbXBFtsvm7LNHLcGzbHbibRFPdwqcwM59vcy9p++5TzvX9i3ytSnlw+p9EecDQFMC
 je3RyharoOE+GM/JAH3MvZCLBLewdxtmmjcBEKwh94yjz9X6AYralrRsrN1QxMgBFp3vyD4gFJR
 T7M84LB3k0aQwLajIHV+3ZPDOygFcTW//SEy+N4BzRzAHm6Fre5kYxJEJSnyC9fux3FabAo5s76
 ws23KtY/RXtoxAQrHvB18mYam7qtEXeMFmy9oesnm7muAGapBoqsF7bRpfmKmUHvJ92XobT5jXZ
 pESh4rNyS5eE8DscBTei4p0BB1f8fjv2g8J6rjd8zQo4LBmX13gVjKSgC8A4qbbZW2RriEhv7Dy
 Y+AWdwhJ67yMLSlSaUnToEwgfTgFqtHqwGM/9wiBF+zGeCojxv6eit2wU89UqWGeA1cWix3bNkO
 Q4PFrZkFe0+7j2cnNSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

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

