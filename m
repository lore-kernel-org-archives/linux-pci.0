Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD842C08BB
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335066; cv=none; b=psNsodNns/ubX1AUHjeUV+8YoKzayCm5I1pnz3inqyzXSpq2GX18vPEzA542sf5FNY5S5iZutGSgW1H150LFFxy8gRDeBmVonM5T+7d1dm5CVSNPQwy07KFMALcexOJPh1EuzjPLIs32cmf+jnO9hznjaKhLJi5vwx/dJmoQ0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335066; c=relaxed/simple;
	bh=Zyi6ZGL896jGON4iStDG4HYuocR8SRlTT1GS2O/Ts0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZTCbQatYZKFj8KC8Ji9wUT3i7CkeRJP1p5vhwlP0dHhCogkGEwH+Yb0qnR4La0jKW1LmQksIE5IFeahXv2wFSCxw7aLRUbEAf/2hFCj+8GKHmQm1rhW/T3ME0nquw7yGAeEKgPekJy2QohupMBfKcn5/YSloEzFMhNVezwAor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1/rujjM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Upf5ngjU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1/rujjM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Upf5ngjU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651FBmcm1258152
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 17:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xCwwzgX6X6FAk6K+BEi4rFbrCZI7XpDhhtoZrbnj3PA=; b=B1/rujjM/5EQKr4X
	lUbYrgXgDIX+FCKrQ3Hn3MW3Jfqz4Ita7YYgImO1R461MdboqGxaBNnXvv4lfMK3
	4feFCRAU9eekbl1K8MPkKZzLJ4CpTyHDUB5zw5H4snA/lx3XmfUdd1PfV/o7wkLg
	uD4dd7/OEPyYVHYPdSqR/XkhSI2lZM5Yqp95GnQAwfME0Wm3YSG5+WZV3XfPUzLa
	dmKotEzbUHtcxFCMWEOKxelDomUJjNe/2KgCHp34OdIodaNlK2EOmpWttrK2Zx+G
	MF2WeD8qPX81rGI7yKVB8jMYRUIMbecfiKVXntm7TYXP0X9YkLeaqT/B3ExpfyY7
	KIwvLg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sst77x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 17:31:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf30576aa3so18960035ad.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780335064; x=1780939864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCwwzgX6X6FAk6K+BEi4rFbrCZI7XpDhhtoZrbnj3PA=;
        b=Upf5ngjU+h8/1cab2nOUT2DbyvA3dnFC1yEFMvqVFeeI2BH1xjJza2bLFa7y/h2JhR
         lBlB/aPfgHJ2dHvgRG7EJUVj65Rx+eYr5R9BAQT4yumH98AiWeQYeKNAmVjzoQG6z9/b
         X2uxGcU9brHUduXQIO8NTYPvYnwp0/WKjdtG2+L6MqMiH6fCrIpeqojIli3Kxb0GeZdm
         K6Hi/yPFdXJyxZBW06AQHNQUfiDtR5kZst/gB3QY34mUYhvhfafkHNXz/Smm7BctDZAr
         7fmSbgDFIAkPJkbsrikfLzf1aUrtSNjObt6zFSFdV7xI13IOC+IVu4bqE59F4TntBRpv
         rhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335064; x=1780939864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xCwwzgX6X6FAk6K+BEi4rFbrCZI7XpDhhtoZrbnj3PA=;
        b=Uf9tnzQ/pg/9de2Qo7anGOC+o6F6DOnonE8lRFm0AkcTYHW+iTpCJe7sGD1q4D2p+g
         PSZVs+eKN7gUCEE9/UGNdsf7FHdOugD5g5vggrKz2mC2x/1iMhTAB7ggtg05Iy96HCNZ
         QNhqxx49jRZag5htjcwSJJY4ULOdYAbEOTN4AQSoeFs3cA1wfX07wWM8bCUs1KJNd1HD
         3KC4kR1SVIL/2pHBQ86cx/19ooaprWFhQCrak4Rojx50wVI2SV9CDhOVA7JAJGPoHC4i
         SBZ99MuJTgtbQEFHziD9pSy144JczV0UP4fAuTF+FMFhw/3KEyi9IQy41SVnNApCX+9i
         1EeA==
X-Forwarded-Encrypted: i=1; AFNElJ/sLLW6Ju2qKFFBm2U3bGwPQS1M6Ts9bA9KWqsp60CtFroNkdl+FGzR3wPIx/4bbcVj03Yz4gLg1xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqEVMaJ8LnhCKimDqKHztXSgnQAfyqG1+38Ofn8OEMG5yFqw9
	v9mW1eq9XSQuP3UOqUREVTACzcy4rjUAWZvVkDjVo8VE+GspEA29fuTB/75AxQWbrQeele6w5+L
	+I8DMobt/m3ZVVjpXN3LgbJ0Z/FiOC2oeBGSXR5qKHLW313EqT6NcZKWYwnzAld+17Y0and4=
X-Gm-Gg: Acq92OEQawKjKPqJ+r1CGYuMzEBwZDmaCjsWaYqQj4q1HJd9Mr9bipJuEAlGu8FlU06
	/CNrTKGJ1PeD8VGR6TIpY7mu1lS+RZwW+ACynd8T8JWnBxJgzgLNYfCppZoQCatK4pjPcwLUNau
	vQXmDTSkzSLXY7aTIuzBIoyokTpHXrSa8IA4sw1C7h4iuoaiX3eu9fma5Bzz0dvVfc9IhpS678E
	L/WBHH25v9j4GjxybgGOdJB372+7noaSR8c7rRd1Y9aBbLylrx7Yg1y3//7Ew9IOOtPG1dv6/SS
	3h+R+HrEyiUW22sFwz6TsARcvZAW67sc3f6IoCsDaYNnpSc0d6Dnc/PqSohKim2Ox1pmySxi2t5
	E8p+T9lLr/wi1JiBj9V+ULjJ5H1xoFs14BJoKmc+zh75ffLpWcUiCPpiVjlvxxXRUxIk=
X-Received: by 2002:a17:903:94e:b0:2bf:2d0:887b with SMTP id d9443c01a7336-2bf367bd713mr122993695ad.9.1780335059133;
        Mon, 01 Jun 2026 10:30:59 -0700 (PDT)
X-Received: by 2002:a17:903:94e:b0:2bf:2d0:887b with SMTP id d9443c01a7336-2bf367bd713mr122993165ad.9.1780335058650;
        Mon, 01 Jun 2026 10:30:58 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm149136085ad.41.2026.06.01.10.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:30:58 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 22:59:45 +0530
Subject: [PATCH v2 2/3] dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-eliza-v2-2-6b44c9c23d5e@oss.qualcomm.com>
References: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
In-Reply-To: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780335042; l=913;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Zyi6ZGL896jGON4iStDG4HYuocR8SRlTT1GS2O/Ts0g=;
 b=0Cr9XKqiuqEufsk3MnumP89WSaLaGSxg47BTJwEc37C20UjzDgXXyOejYZMYpvYjiWuENKAZk
 9WtrirmnKFNBkPl9gIi+eQg/CY5DJFxT6TFdo6IzLtpLOfTn/diUBhW
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: XClj6uOcIdGCNph74TWcedwIhu00ehy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3MyBTYWx0ZWRfXwVM7G8tFs/H6
 hfbNWaAbkI+5dzqsq3+30wFox7w73vcU4ZPcbY0r2at3zHeZ71lVcbD7L/c0tLBsVonld1yedTX
 5f8TxPosMbWfLbRQRAzLOFtqaMOCXHafTNx+VxTfguCNRjJFKotHC5SqrMuu2WXDHO7A53d1HQQ
 rDI5wduty6867wkSj7sL0ARcLzNK5/I2kSBGOUZSyACzqXdcG4e/JW4e8RsFMddUbYOaUdjSJ/R
 bymFF8D43aBPo+N6ICJscp4OhdEQrAS/qMaQ7WzJpNWZIVi/BVa0nBW8OJTYrTIVTpG6QltBvgY
 G6cKuyiupthXeBg4zgCeM6GGFs+u5DlageJhMuJq6TGWGJhqpzwxTmFUbokeAmhKS0t5yZpZ+hr
 NNmQSu8VBXiUwqblMof0TPgirH1v3fQiuAoM/aWXlJrYAr9NyMXjb4iZ4BrVJuzef0eoebh2O94
 O6SSJhBXY66mA7aFWGA==
X-Authority-Analysis: v=2.4 cv=O5wJeh9W c=1 sm=1 tr=0 ts=6a1dc1d8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ly1VyIkaSgMpB_u5KqwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: XClj6uOcIdGCNph74TWcedwIhu00ehy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010173

PCIe controller present in Eliza SoC is backwards compatible with the
controller present in Eliza SoC. Hence, add the compatible with SM8550
fallback.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index 3a94a9c1bb15..98b7e0612410 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -20,6 +20,7 @@ properties:
       - const: qcom,pcie-sm8550
       - items:
           - enum:
+              - qcom,eliza-pcie
               - qcom,kaanapali-pcie
               - qcom,sar2130p-pcie
               - qcom,pcie-sm8650

-- 
2.34.1

