Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F636681B
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392989; cv=none; b=sKcxK6iVrGrAle3rT5s/xYYD7ZJBZ357rJdFXFK8ED+jHE59rF+lsdU0B+ilSRzIqvVLYTIzW6JdJSUREeO9f99qKeSc3tRRdqeysdDSpe6O3v1APb4xB17My3u6ih4ZqIzjTcfJrxtAAYlHFKehebtd192mF/fvGIp/d9hXx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392989; c=relaxed/simple;
	bh=nz6hPl3LT8ptNw/NZmZMzPEW8KpUvz7yNcIiWSAfvQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a6KxvMudLSd1CwMIX8HC9w+NqRRcRw4xLZKnRxgf9LOH0wUPK5VsPQNUsMzFhSoxiSD7hDixDSQpjbBMhkJGfr8aU/YbcC4JoqqmipPkdaUuRumOnvRSG3Q2CO0m8rUPF1TeM3QVQRPHmHe95Z1MoJBKL1mpQ8PyXtkFSBvjT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G2/Juq1l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NX1moGKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G2/Juq1l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NX1moGKN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6525tdiO4012510
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2026 09:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=r7oSzQIF/40QBt9Cym+JUS
	BWjLP9Fom/phGPGm1A1tk=; b=G2/Juq1leseNr55Kb5hlln92rWxZ+QqaCEJfK1
	EPNMe4s4lxRhky2aTLMo308qeMJH/XKEJxCC8jtULFZH8YCtPbFV2rPKVnhqqlB/
	tJO+mzKuKKVJD2qKtw6xZyNbnfjOaPzTv+6oE16zqiSYcF7c2HXbjJmGPWzQWlof
	BUZo3K68xHAv3gbFAz8fJLpNsdRI9xlXvA614e+sbVpHtkOg8Tc0aIeO8KUwalR2
	CJjwD8I+1/JWG8UpaxTJzOZklwH/ySleeLx0lGa3Y3k38eIbOhHr4JRZ08uzUAy8
	54PkT6gnjGfMKwWlUE9TB/x7xbrk/S1dqWzLNv+1l+c+FKbA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf4gx4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 09:36:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf32259e0eso42555475ad.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780392986; x=1780997786; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7oSzQIF/40QBt9Cym+JUSBWjLP9Fom/phGPGm1A1tk=;
        b=NX1moGKNShCFTNvzTocsXlceRQFuNesnfGFBioCi7j9Xlw8a7rIYhYRt3h2GSoZAxm
         8SsywofhkzqQ3ProFGt6jk3Vy/74xgHLXwAvjWkEDEFqGtpkqOk0+NGxdlPvJ1bJClEu
         tdfX5ZN0fwGf6zbFTWiJKzcveX37mgTeM1aMFtMVJlNSnbWFhnRkAaxzyK191AkzLYvb
         r3CZTG45bjgDpPVGyAmOH2vSN51kIWfIKSgvxSa95sc/QPfzRbaIiwOFf1cxjnDLcrwh
         jDcNLs9w+NH+Zz6i6ckvHxW8oQ2KQbYUjWmQqr082EARmvPLL5zYc/h9NbNmWuuKsSVd
         yIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392986; x=1780997786;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7oSzQIF/40QBt9Cym+JUSBWjLP9Fom/phGPGm1A1tk=;
        b=j3AGhJKEvsrbCgMq4m4rqFxVnF4Vm+eY6Wy/tviE/XtPE7DF6WTSInSukhK+vJFjq/
         Y+h4uZcr7gpn8UzjZ7FbE2/PYmGBcycxwk6pRIzHUFahxV/FaHQqyHSa3HsPL8LZrEZP
         iuRxsozuvMkVqjrBTyEYfT+UJNziARD1Pql+0w6019nAxmgpu43FdU9tUxVG0rMv51cf
         SxhxJFMhMMNJ2/BUnxVNWT6sngqmf4z4Jt3FoTOqOqhuO/gxI72Ol1xbNapdGCE7gOaW
         EvDVLHVgBDGVq5PIcVf++4zNaR0RZKwg/jnYKyai4a1PuC1dsxPvw+8h9Q+xtOBmrR2P
         bB/A==
X-Forwarded-Encrypted: i=1; AFNElJ/ykIhH859hEo2iY9AkVUCmvY7LziVqEs0M3xgldklaNSWAKFVrvTnUbhVg6/GcOIkDeja8vHgOsrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xzwUk298XjPs/+tWYDn1+qLJ7c/AJbm5Sa8LpYEeyHxCI6ui
	cSUUydKDQLWkgqoGBy38DgiPY8sNupxEq8zi2+5BWG1rdxU0Pczy6KNaB6xv2Q+4fWptGagjQ9j
	RgOVNk7J7xc4UzAuPjSA8oc9mwfFHTvqf30LjxnnRK0UInnEQCmry3RWSwzHvQS8=
X-Gm-Gg: Acq92OGis2qMepxeqcTDqMUiCwbLK+dsIIupZpk87vEoxq7tORVI2hhWZdgguxVt9xX
	PKPmHL3BrU59JEeMo95A9y8hGQVY3X/86sP4lPG+LjoEP6sweeO1LHTDLX0ZCirnUGpCwFv6kAL
	DSjiYZ6oLUWFqstX1y1bZuiTUo4XAIYZ/6t0V1WlEZxeBG6DdNZA3qs1hNY250bW/AYw0UqexQQ
	+wtwU5p+W1QD4q8V/KoO+0w33L3dDNQ4iszA+ZJzbObz6dQR9fTTapPqbLS5HLSZ/jheXVe6GoM
	z2YTKHZAJvX7bNWzMtL1mF5pFbvcNLYNNiircAkd6KTsc2qosZF3WQOEhIwyKYRq7QEZtuxWreW
	sT7hGLtmmZwidEIe2uIXXDTY0EE78JEtyhlMY3QVIy9h21zKn63qaDeAP6o5ejSCXN0A20r3Re+
	r0qh1v4quolFPrUUxI2oeK3bLJqcL2dpYfZ9TBmp2l629/MFBteLGtWT/zdOYpowhaHRw=
X-Received: by 2002:a17:902:e543:b0:2bd:8395:fed8 with SMTP id d9443c01a7336-2bf36851283mr157586415ad.27.1780392985845;
        Tue, 02 Jun 2026 02:36:25 -0700 (PDT)
X-Received: by 2002:a17:902:e543:b0:2bd:8395:fed8 with SMTP id d9443c01a7336-2bf36851283mr157586035ad.27.1780392985356;
        Tue, 02 Jun 2026 02:36:25 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4fef9sm128353485ad.79.2026.06.02.02.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:36:24 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 15:06:18 +0530
Subject: [PATCH] dt-bindings: PCI: qcom,pcie-ipq9574: Add IPQ9650
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-ipq9650_pcie_binding-v1-1-486a535da8c5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABGkHmoC/yXMQQ6DIBRF0a2YPy4JkIKhW2kao/DV54BSaE0T4
 97FdngG925UOIML3ZqNMq8oeMYKdWnIz32cWCBUk5baSqOVQHo5a2SXPLgbEAPiJJRvrXTGmWt
 wVNOUecT3t70//i6fYWH/Pl+07wc5Qc80eAAAAA==
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
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA5MCBTYWx0ZWRfX5NIioJhlMOd5
 /wvvcEoG3gNUAK7gF37Wavh+g7ciyppNIA9fUw3tljTih2gj9tvPb8BJP15zCbyD4Oo1WQ0S8LQ
 kZjO9xmrKAyczEAPN7CQcu46wS70MsTJcmHU3x+AbQHlGdbsHsbSqYgpTxO85XM3E7yroI/WWSB
 QC1ioCD1F1FOBC0nqLjWYp78k1eYFHci5W9eOOqpGcvDvQujv6ke61v2c0LnKegpS3pfc/+cCl4
 L2mxjcxH/h/zkqgM3v2XRTqsV9Fkj0tOyTIoXm1norbltggDwlCmfOEnsuT19CcGO24pfTxGD/V
 0mVF+daWzrbBQkud45MeekWg4iDiaLNNHE+ay/BYuBNsuP1jBOgpo2Kd14C0h2wo9ziJj2k0k17
 OKL/Cn3IQRrIx/RWc8KC7im1lFwIlEbB8/COoxASr0t1xy5P11ftk4WkhBZ+LV9jcQIgnRsQEJr
 y8Dm48FJntWKe5vW12w==
X-Proofpoint-GUID: 08hzrfmVyFWtLCmtvfsSrTQZTtv8R6HP
X-Authority-Analysis: v=2.4 cv=AJZ7LEvz c=1 sm=1 tr=0 ts=6a1ea41a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=svUzretivSU0ezUIxK0A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 08hzrfmVyFWtLCmtvfsSrTQZTtv8R6HP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020090

Add the IPQ9650 PCIe compatible to the IPQ9574 binding, as the IPQ9650
controller is compatible with IPQ9574 and uses it as the fallback.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
index 4be342cc04e1..7fc629bda5b6 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - qcom,pcie-ipq5332
               - qcom,pcie-ipq5424
+              - qcom,pcie-ipq9650
           - const: qcom,pcie-ipq9574
 
   reg:

---
base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
change-id: 20260521-ipq9650_pcie_binding-1c76095954d9

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

