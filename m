Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85BE3FB7E1
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089281; cv=none; b=tz8gb3LhFx/iuD13E5Ob7B0JrkfQMkTw2Kr790+a6Bz1mkbcHfbP6i3RscrRZmS72VLFAncEgKIfuX1duZBAKog4G7Hz/3eJKJMDuBeXZsIqCf8zP2FuEJO1vZYBd508uJPHWV5yxCV0Wveir1GRxDSKATfybbSLBctJAtJayt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089281; c=relaxed/simple;
	bh=kv+0+DQsZ+5rw3Z+LZdvu6rOcLL66oeZLjzWJ4X0ekw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n88/esUEKfx+xAafCvCcB3mgZuhlps3Scalmel5hJtMzSHpZ4s59gXGOkbvsGGaStCdzUXHphfgu8Envs+4dacPlndajDf/VdY3mJjQlZNd1SJA9IGH0+pwP35mca8G0dmjhBxaPN42WEkaYpE8a5kPsmBm2u9GY/5KOkRQUenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XhJ+FBb7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aCKV/HRj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XhJ+FBb7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aCKV/HRj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7hrxI3151703
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mztJEPWEdcGLc1Up2sWWykyke71b1U01clS63f8eofE=; b=XhJ+FBb7BtferQl1
	oUZpCLII+p7dopAMttFCpFINWfIWXT/FZ5D3dnbqLCCsGtkVEQ4+bT6uGTA7pzOm
	gwVn0nSBMtizyLv9skycrp3niT7SxYzgwKg1akf2H2Lg1aUj4dmuhnoXEcazr1At
	plyROk17Pu9kQEvkzq7Q9d7Q4H/zA3segJjvacKAnoJZdYRAKKr50pvJOBwdkToy
	8NmT0HzWsx22skpLTHRtiK1SgaXm/yR/+DwgJNAO7rSaL/K10PffFupQoaV9x/Yl
	dzMJUp0vdtoh1b9GmyEJY9E0ia0WDl0K32KQjE53BgGUBM15DINaKCw9eRc4CKA/
	kT7UQA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnet43s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:01:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso107832215ad.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781089272; x=1781694072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mztJEPWEdcGLc1Up2sWWykyke71b1U01clS63f8eofE=;
        b=aCKV/HRjPL/NfQHVyZL+BA5alewphlhzX29NXQoEzOiXeSHjo29Vz6kGDlHuQejpJi
         dOe48mH7Ka8+ck9lErNmv2ngNxuDvtwjetS6vovFRLP06NFHE8KhzW8wRQuI36fYlINi
         aZtJnu3l7ssHxhrprhd3vYoZLU92ybtod/+egHScPoNU6jWWQ9QgrzXPohvZpHv1jI3U
         kjxOINwMYFculTWJuiuGNWF/8oaNbTLCzj2HYhAhX6Y+RRYM1/p5YwY55EPmrQDUZpCI
         pzm6WGOV57SGtmMUpzUviEBiqIuAdy/rP4EUHaCEeqBG4iFLhmkvu913A1JqilpjApe1
         /htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089272; x=1781694072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mztJEPWEdcGLc1Up2sWWykyke71b1U01clS63f8eofE=;
        b=YO3pV6dX5a5s4HNhyRTtabfi5G1IHX2rM361wrEIaHNXJhmNxjnBoOV2Kdjqa2BH2B
         rHVE5/558Ydjan7QMzWeLY85gEDHmgYtPwmiDNRuqLRdjZJ0O60arbxfekIlpq5sAALl
         YpXhhu9Uooctiig+1P6ZoEf2khg2fDKQK0XD75N3uiFPuc3WYnUDizdkhf4vM2D5Siec
         3XYRxf4o2Rtjh8cb4FEi7zPAFIiiFAB/s+8QPOC6mtJkYBhLOtBRSebSK8D344td2SJz
         PC0FeamVK5cTch4DjZ7a7oVU9ULkgcuu+9myQQKkKpwY0PSqG+PnFvrAIR5CCPu5Tp3w
         eP3w==
X-Forwarded-Encrypted: i=1; AFNElJ/hiL7K+HZg61k4Qh2ZPb5fPs1AXEcOMu0EGCa2+MDRmv/f2PocTBDbs1atpI3qjPuIoFQZ5zeHbQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzCiGmdeL+EWYO2lbycG162HdNt1ijoWjkumtqcRxPFhoLwtoQ
	r5VndzOvQoHUgd+phKrVGr4EZKSWxBgwDmie1QGwMXtyuwcK8dnyHTXIDlE5wXx8c1TGrEZzi4Q
	yiQedCep5cCZH51Q8iebw6BP3pfFQJvEXSiVSeqccfz8NPpbz67iKyNWsbEPK/70=
X-Gm-Gg: Acq92OFXHrHuLiHJeMGo43jn8NHe0vovWtgqUvKgfmR8hpfd1ekJwir/6DBndRZ8JBz
	TL6Jflu8dpH9rGJjCkI4jWgEv2su+VsLp5LSMnZOSNnzTymOTzYMUWz7NX7yYwEiUlYfdTBuRXX
	uOSr8wvNr4g2njlOhV15ZJ3CovGoZCg+XxRWVRL2VF1YyEF6BrJBo+pZVO0LDIARf6UyOyspg2t
	+CdY4aXB+5Zwi/4m/rgzaIxUVSf07nPoguQ06Os/TDlEmKhl82Fxzlz/2+FJgk0c85evWo6wfqb
	1PtaxEKv7qblAd1hLRiq0SxukHij2Gu/++KpRDuIfbyWx6dY5I14Shjk8ONKlSimD/zH62li75L
	eUJV5qGO6ImigpAOlQGKeu49StaQiC/vLzmBqrcETcnIe3hcIv9NF46dKq/NV3qYGKjsdxVztHI
	bKc7dMuSJmLjXlHGEPchTMkxEmGora9qvSA+c6VnftnSskDvz2yLYbRGvjW5lk0M51POs=
X-Received: by 2002:a17:90b:3512:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-370ee82fa3cmr24460457a91.1.1781089272229;
        Wed, 10 Jun 2026 04:01:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3512:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-370ee82fa3cmr24460390a91.1.1781089271724;
        Wed, 10 Jun 2026 04:01:11 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-376246afe17sm3535131a91.11.2026.06.10.04.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:01:10 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 16:30:54 +0530
Subject: [PATCH v2 2/2] dt-bindings: PCI: qcom,pcie-ipq9574: Document the
 ipq5210 pcie controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-ipq9650_pcie_binding-v2-2-69e27a1fbf1c@oss.qualcomm.com>
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
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 7xIXCmNiJsGCt_m3R6oUavF3fQFZICtk
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a2943f8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=dAbVbwp_SXptH7tlJ5MA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 7xIXCmNiJsGCt_m3R6oUavF3fQFZICtk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNCBTYWx0ZWRfX+OgQ6tBHzzbo
 /gX0m3ITvdufphQ5S8rPlckfAbBS/mm4JRt5g4fNJnpc06tDJ6NsgZoO8Satwf8PqZG78KkeZxM
 ufzAAPtBY3sFtC3H2CdMGc8SeIUhEJajeWWLaAuUFPgPZeUZ/TqrG4Pp0Fr8Fb2T15doKMklyvj
 2NiBnXPWuCve+td48Bw4b9SM3laN37sxaiw3RYJulTwNNrOfnbM2+K7bssEuiC6lINf+0yaDucU
 wSXDZtXvL6fHv4R9UHPoVutkb/WSqmkMZMSQKnmrUqhZ0A+NaZo0pLUdCJ/0Pu8H3mXkMRb8p0A
 DcQvKeGL62kmAu1HrcXI60r7O6BxgjmWO3AabynlYi28srUrEk0ABDJClmpr096U1GKYZPwS3Sy
 EE6ibcY6qFmQv4VTLz7raIN4H3B4r7pXvHTDobnFZz7uemGD5lq0DcRhpdLtrnOA8BhQVJ7xz77
 n4FlswD0BPzOCTW3tRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100104

From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Document the ipq5210 PCIe controller using ipq9574 as fallback compatible.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
index e92acddb969e..533079811881 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
@@ -17,6 +17,7 @@ properties:
           - qcom,pcie-ipq9574
       - items:
           - enum:
+              - qcom,pcie-ipq5210
               - qcom,pcie-ipq5332
               - qcom,pcie-ipq5424
               - qcom,pcie-ipq9650
@@ -88,6 +89,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq5210
               - qcom,pcie-ipq9650
     then:
       properties:

-- 
2.34.1

