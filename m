Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F43CF043
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080538; cv=none; b=ANPi1YdRfgkvdP1f5I7BO7eqrgvCE0ihs5iQv588DgMVeXZmUfV7vTVqDAqe7rmEOOyHlaV4X27yrQgNV9JjtFbGtlhTV7/HAaZSWPqrlfO18AzZqJh0lwAKLR4ELT+L5XfYSTxlBVBCZD8xhivhxauZdbLMVF9+UX2JH0Z4Odg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080538; c=relaxed/simple;
	bh=5V7HWccyjDE1PHzPXsSESrD0TYABSrEnhJQ1xPdGWYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZsFX7q4In0CyoTI3a94EAvU5nN8i+bor25HdV+bh4H+GGJxnmQudBACWy218FAt0+cU1E0Km4Oeezo0/ahMAWqm3A39pUocH457tzGhoRiBuVkJCTum5DvPZy83pGXdSQLgU+jZIICwjd7dw9EfYJECQVnsnGRKKoeoCZk9rQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okwbLleI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DdTix0RD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okwbLleI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DdTix0RD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BNetw2994867
	for <linux-pci@vger.kernel.org>; Fri, 3 Jul 2026 12:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u8d2V1J0QbYdhiQA9M9vo6lfgb+kQCAkNzZdrKE10Kg=; b=okwbLleIILn08seE
	iseaDqo9uGQ14EEp5eg63/lUn6m9EzBaz0Upd7SuVI84STt/xCR+tE/MJU/ZE4i5
	CvQUTa0iuSxmeGlBnFLP4k6emqLDeDFEgLCjYsbN07njEzLceIEYrSavppzW0317
	XT43Yc7rVqnIqFPnvRYL/B/UnIKhtfquSAaK1/U/rVBwNkYzgkxWfjyqjLWtomV7
	ImMiSTKpHzYGwgnYDIPUuEuQh3+tsQmurUXpN+PdCyYwHesrtTsrhVIAquey3Uqe
	j9xcV+Fld1RI5UltHW0QP4oQ3pQAtC4xYIYzxK1yunmJh30TVw5m9rn8o6b6/4eg
	mQ4tVg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n29xv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 12:08:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88ab059052so585283a12.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783080535; x=1783685335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8d2V1J0QbYdhiQA9M9vo6lfgb+kQCAkNzZdrKE10Kg=;
        b=DdTix0RDKqCL+qdpxWzgjJtYs7loULc3w/t28syzAIhDn1W1R0wQgHQaA8nC/ooQtk
         S7tFCXcCVURV7hxuUzvSXNRHR05J6KWjWgVgUupSkk+PPYlCJ7lAdsOsozNAOs4KnGKM
         kZmgCdKPgQNTLoV7I2uWX+iNVBP+2/diLhz0hE1J9LRumlm3xfID7THyDuM8AqhgwAXo
         T53FBnSPYhH/GArUmbmTpsy8Hz573tBv33DA1bzfQtLufW23qCgVUIwaf7bW/uTIajSh
         w6b+vNIZFOwZMdg8bzT4PGbG+UdqBlk4tWX+f6SxSXmo4kwVZq2r/L4eWNITH/xzkygY
         yqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783080535; x=1783685335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u8d2V1J0QbYdhiQA9M9vo6lfgb+kQCAkNzZdrKE10Kg=;
        b=piSFOg1icQdGG3iwdnb7oaCXl0roKyc6he1CkIlMJ8AJKPViM06YTg57eerEqw3Bvj
         CaQd8iZS/5vhk4SkLUOYUD0Z76GSuo83Q345jCObMIiDbsLE6dXEsBNw+ztJ3hR1S9sE
         Q3ccZuy5Wfx6Vcf+WzbzLCR+C1dMJGDeZfNAmF54qgZ26UbcbGURmOcImxCT5MKmzrMo
         rmFFuJZTPaKLJmaNCeTdZA8PWlL4NmWpd7CvXtKs93djRBsNggSuxCgH4DaOH+iKQ9Yj
         HJ+WpboV+oBEP0Yf4Kq/mBW2aVXpjCDWsXDRppANM445elUMX/wAWf7WUQLx6iPn+uRS
         DZGw==
X-Forwarded-Encrypted: i=1; AFNElJ8HM/VXnebLa9N7Sm6IhUhBouSCjtX3KM73w7fN7qq2Glc1fhkoD2tcu8J5Ms4Ol8ivcjUW0fFkSwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaM7YkCmdzlhKt/Wxw2JjgZcHe74rCjZTIDbib5U9OmZFkriIX
	UF1wevCdnDWEdgdw/fn1KAPS4XMJLt7x719gJYMMgsMdhLso+txlVJNH4gZETWK+6D0kOpwlYUt
	++K0DNmM5mTD/Yzv20QWweG8FJ02MnGmLL1Y2faL6HvwAs3l/ucmF8KEe7oN+eMY=
X-Gm-Gg: AfdE7cn9o2a9znU28LMu7beOMJRdKxpAtDWnwKD51e1Q1Dlcc7f2wIv16oqWOL8B23c
	Ys71vgUY7FA2AZooxfekrTunYqYA8xdd6NQeuicCD7Sd+lzuUXvisJ2AuKvRBQlnAWlm+9EoiW4
	kY/iunKi7W/CfR4L3a3+r8lC0KUccngni7xyx9epv9Als0Bi5EQ5b5/MdACXh2NZ57Bk6OSnqOi
	pmRbxGarHnIkEu0d0HZiciGsb+JtgV3xEVva9zIWle0IMPxnkmB5433wzIJMJUfnEtvBuWXXJ74
	pCJMmdK4tfnAixf+e4d56U6vD1I2AefdWWFX9bxNJ9hXv1WQKAiwFuZIybqVZOKX6sLSfYxNhhQ
	IicavKjH+vbT2JAcrJrnw5XWOpRQpzWKxAAzzk+YdqpFDLAdP
X-Received: by 2002:a05:6a20:7489:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3c01caaccf8mr4338110637.22.1783080534561;
        Fri, 03 Jul 2026 05:08:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:7489:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3c01caaccf8mr4338059637.22.1783080533846;
        Fri, 03 Jul 2026 05:08:53 -0700 (PDT)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb10638sm2530779a12.2.2026.07.03.05.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:08:53 -0700 (PDT)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 17:38:40 +0530
Subject: [PATCH 1/2] dt-bindings: pci: qcom,hawi-pcie: Add Maili PCIe
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-vdev_maili_dt_bindings-v1-1-c9df0916cd5e@oss.qualcomm.com>
References: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
In-Reply-To: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783080523; l=1283;
 i=vivek.pernamitta@oss.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=5V7HWccyjDE1PHzPXsSESrD0TYABSrEnhJQ1xPdGWYU=;
 b=J4GGGQ7hcYdgtXJBassBT6Xw5rLDeYRwM7rV0JCtvJzey5nqajrHDYeUihNHUapO7wgdAt5e+
 Lq3SS+5iq//AWGUj8V/QkT/kRdmF+LWBJVxg/h6qhD3F6X7gH6bK8VX
X-Developer-Key: i=vivek.pernamitta@oss.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExOCBTYWx0ZWRfX+/k9hdfjbqeZ
 Nix6fy4cjAjcn/+oVH8L3b2eK61pzA01//GMNEe0RVh5gF8ILYZKEoZNC2T8SfZ5+ZWrwOn5b6I
 qN8LNn92j5gRk4C1Nt1FI13xOsK19SI=
X-Proofpoint-ORIG-GUID: DlB2mwjmP47aR0BPLQKEjjc1hrOWskMq
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47a657 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ELRmBhIVfrytVPIx1VcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: DlB2mwjmP47aR0BPLQKEjjc1hrOWskMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExOCBTYWx0ZWRfXyO0dZNdIKKNh
 XakbFsQ5vzm42Ti7p0ULGccCYimJ4JIlysKzhBip/VBcKv0GgjHI12FqmRKQxRdLy0T5eriMjiE
 7S6MwuHiVRpzHllUHlZ3gVXea1HMvDSnkQrMj7A7TnO9iuA/F6S89+jBelQF1CbCQcAe+6OugHr
 5m1WvI0hS8eSbm+3HyoU1W26403yMzp3rofL+bxylIUX3OmK8Y6f5a9rIrkPZDt2PEGlz5/8xbw
 UFCvh31YbJKHJoBterORkiiBibZFCrvKyCUWeSEBXL2FajAGVqtol9CGfQTXQN7oaIRfGfs3uRm
 vGpGFSXlr0HyzEfjRF9oY8LdyFtrnKqafFVdhz8WbfujNTmPbW8ulMes+U2kr9CCMxRDdPQNRox
 GLnsFTk1xYw9C8xD8o0bk1qXtPBbMp4UrY/J3yqrTT7/wcI4ePjYEc4/JJe9w20bOrKPLbqJYe+
 Zy8UbcM1HDUZ44moJ/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030118

Add qcom,maili-pcie as a compatible string that falls back to
qcom,hawi-pcie, as the Maili SoC reuses the Hawi PCIe controller IP.

The Maili SoC is a derivative of Hawi and shares the same PCIe
controller architecture, allowing reuse of the existing Hawi PCIe
DT bindings.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
Dependencies:
- PCI: qcom: Add PCIe support for upcoming Hawi SoC
  https://lore.kernel.org/all/20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com/
---
 Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
index 2c999ca6b2052760a192e9c464d86b73e86d3a88..aba89b59915528ef112e74982bfffc79ad6f93e0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,hawi-pcie
+    oneOf:
+      - const: qcom,hawi-pcie
+      - items:
+          - enum:
+              - qcom,maili-pcie
+          - const: qcom,hawi-pcie
 
   reg:
     items:

-- 
2.34.1

