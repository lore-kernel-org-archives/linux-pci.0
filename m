Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1036D51F
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244207; cv=none; b=tJgs9eTBlK/z2VSN1zMLYcLukEWqoAIQ13TjgwcrnQqjHGaftLtj7A44CaW6ANoyqoyTUk6JgWGAUz1HAxgKfLAD1TOclRSKclnv9l0ycGBkxVLix0Qx+FiV+RGU5E8wXFcDNhTB7G8acEZCqbhB6UKoNcx2uTiC3iCfXhvxJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244207; c=relaxed/simple;
	bh=RnYZxOGsa+mCQhaXimkmXMcqyAGJ/zUTqL1MBZy9xZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CepFq1luS7oD0RMQdzJ66WjFMXNbQJp4di3FICEFHpJcP3RWQo8IqOi06xBB9gI9xTLGnKfriudr2L6nIMq23/aHs94B6AprFAjGrjU7nri7oBSw3IFxNWyuy5/W23ee631byg0a7bUHnMg7qJL3H/hSsy/kG9K4FnF4n2enX48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hEAPOrAP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/+PGRqx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hEAPOrAP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/+PGRqx"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BBhi6p2677054
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 15:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=n0zBKnpre/A
	VifMQIjMP6sp+9Bc+YCFuHJyoCZtCgTs=; b=hEAPOrAPW1i03yZZKc1uLUc5Mc8
	jCitr5K900sVwctNz6ouq2oXEqXcY3ofCBsLe122knmkJ+t1kIseBcT3c9EPsNC/
	4y256W+vBzru1GxmnvWWTAGsSFu1bdkaxezYWOEauwCn+G1rLjyEzCY3YJtJd6xK
	xHgKqbjnvCPMjXr6IEuLzucOmhUeuxW3Y+TNQjZU24KK9hXYFgRkvIqpGcR4MZRj
	AJ2WAU5qAuiAq2fkXyuf1zlehFczbgbdWl2mpHSYPsAb4PlK5kdafziOlg7MHuyQ
	I+lI9njMwSgyc3PsP9KWDwverFX7Ud/N5oz8qDrm/5OG3xgC77onyeWmNSw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu3cd235s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 15:50:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd81be6f05so2179290585a.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773244205; x=1773849005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0zBKnpre/AVifMQIjMP6sp+9Bc+YCFuHJyoCZtCgTs=;
        b=W/+PGRqxlJ/ziJ1/KBMbQEROOowExLeexkrd+h5iHjIHa4e3cZVCOJqqsBSuhMt77Q
         s3kYbKcw/5G7guII+15Kt0CSNlS4HagWa5EGSkHh6XcuQCLVJphsUkH58jYWyHsstQtz
         NgKVk7XanL1rW5qKHNarZsPzqGp9E02rU0ye0hZIYUdhVAhQxqmSqCySWxS7mzUme3Ft
         Z49lembO/cCdo2Dx6wlUSmRkKx7x6Ee+/rONkeZEE1oU/J7zJ3JsDQogULtrh4MRW4/C
         Pdb+8nEh+pCuO1mu9siw5304dLPeXnRD2adLpWmHooKoENH3uCey397mdFA1n447K6y8
         A1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773244205; x=1773849005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n0zBKnpre/AVifMQIjMP6sp+9Bc+YCFuHJyoCZtCgTs=;
        b=XevR7Q2QyDFAwAQ6otazx8rZnngKTc4+qOkLFdGQAs3Prwpwsiqtn0PJLX7JGzNx8e
         97jQN4AdtGGv50I5dPwO57WEPZ+J8YWE3RWmGMDYgsjMURw7UnH11Zg9qH3ZPYfYoq5E
         MpYrahan7RG+OjwpC292DkHXo7KzRoY7tpeJm7UFawkvFEXNRLi/HB8zbzZPjpNrkwEl
         PaQA8FOFw8u6lmJZ7kRb5Ylm+/KZ1hCYeD8+S1A6gh/fUwL+1Hrnrd25UpYbWdnR54Zt
         b/nTvmhwTSwhpJFK7F0ZszRM5yebFbiVKIXxxibG3gObYW6DseQ3vykXDcVyTTSBmKqj
         ytIg==
X-Forwarded-Encrypted: i=1; AJvYcCUAUdWbjagxNrOWW2DDXiU/x3ZKG8bdHvRzIILnlB7Tn8ZU+UTrXj0/Xix49+0KnOj/WlGVsOl6Chw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz48YUYqbc/VChbKW45L9cG5nKB3P4tj/CM204V37ZQmKm9OdX
	nc8CsOtOU8LQRgo38xTGt+rvqSMJ8kvUtmkixXO0owIh0M3BTu+Tnap7Qh5JQtRyF+3+s9zB6jH
	0WZ6dwfqI2hqAIyZ7PbYkxtL0ibkjzXUvHeyLjvfK2bpEnEgCXhFigohpMb51J6Y=
X-Gm-Gg: ATEYQzwozRnD80a43ZfqpCbD76JVzMdgzVM7wYk0Y0uRqqhqKZ3zWnIflrGS8H/kPlA
	vvDiJRZtv+ClXkkoDVmou3ZD7A9q0VChomMnhkHvDezEobQkCQmbWMbVNZUeGxI1F4InPHy7b4d
	RzarPXzBZlChNP2s6pgT0WhMiBfi9LSv8fzSuVT778EruoYwpTWATfzbdNGWQY9lYPqw14mQ+s2
	1k9XGNGwsFYDgMXQLeD2GyHN4qjLaU0uVxAemP7FihiVnv8m/BM1DV+Dg/3kiBmviBho1unldah
	h2MjHo12KeFAF6NElrDKolbZKaKFqsk95KLcFWEzbVmNbIIrL22ZlqNFKygKTkYhaDa/BMiv6/H
	WQHOmwaxix+kUYCssOcTXZvJBVJHtt+ia8p+n
X-Received: by 2002:a05:620a:45a9:b0:8cd:7ba1:cb with SMTP id af79cd13be357-8cda1adcf02mr363892485a.72.1773244205094;
        Wed, 11 Mar 2026 08:50:05 -0700 (PDT)
X-Received: by 2002:a05:620a:45a9:b0:8cd:7ba1:cb with SMTP id af79cd13be357-8cda1adcf02mr363887885a.72.1773244204626;
        Wed, 11 Mar 2026 08:50:04 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0c678asm25127285e9.13.2026.03.11.08.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:50:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/2] dt-bindings: PCI: snps,dw-pcie: Drop deprecated reset-gpio
Date: Wed, 11 Mar 2026 16:49:57 +0100
Message-ID: <20260311154955.145120-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=RnYZxOGsa+mCQhaXimkmXMcqyAGJ/zUTqL1MBZy9xZU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpsY8kxlRmURdHdtI8/0HVlJa7uUHbEQraOatEn
 +8Kw/6+6XeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCabGPJAAKCRDBN2bmhouD
 1wgND/9pfGkjEbEGF6IrwzNP4yJ24xfxyBFJUjvptxx/Sy6yznYf5jGO2gGp2gKf6eqFuP/4MOu
 Pt4hYMKECVRn8Xd66fqUavLMHj3DO2ws09f23c7BQ/zYs6hS1XU3Iv+dMsUZkFI3mrEwzf4jNAP
 dVaMhL6WiYPW7WfyfdVVGUep+phznFD51bSL81AmGlePRnwQnEuKwG1cJNHQMzoeCFzUGf7MYAh
 weRp6YL/+8mU9lenv4I1BZSn3QoTxnOS1pZqT+9bXFtKEytBTHQNioC8paw/50soFcd96P38vOI
 5KLims1oV6kPqPJyS1qcjzXxLUl5WNoeLgmRccv5LLKMN0nymWYRGz4JoZ2GomridKt6Uz019Aw
 lYuZZwAPPU6ZYrmtwKPXsz7RbWIqI3f2xXJ22YAV6rmKwYizQL2I199UtiTB8ApSboh6+s+iDuc
 O0/cN5NHgI3x+99M+NpaYunGdL6un/erDicM454JieZT6+qE2j3UkLWEJ2o8f28b2cxVy4OqZgP
 aoM4ORtYHorWhHo5GSGveVQtisdIT+ozV3Cq8k2WiQvW+mpXz05o2gArmjQG7vD/9oupKhnwqSR
 ahYcxMJ6JCHcQBT+Pl/0JeRK5cgjoZI8Wza/4/7ww3+erA78/AL891X8rCM9QYUOXrN7RUXl4oP pRypIFiHNZzQ/VA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzNCBTYWx0ZWRfXyitUj+wf88Z6
 yl3hwr4bVSW9ptp+z/2JT3vpqyNMHGhVO89Wk0KNWnZ7Nwdy1UsxoWDpl07FdLOjqUQuhQohCWZ
 9sPVtzjxDtOjS8NuvIUgv+ZHFG/dWZiSAkduPZDe4p3ZSalny8uB9hgLcBYVwjGBY44PLYU2e4P
 S57XmlM3N5VnNBZqbu1D616HHWwifDpNovxDutPCwas+it3HEcPw5D1bcoYbsecCgskSV9DtXtR
 6n2gDaqMzQYGjiuDnMhW6D6Vhvlx9PQIhW82UCS8M+Xcec7N8XIJmz297nDDg1n+82i/7MHqqz6
 7Qu9rKhMhqjSmHxv5E9CVwBwJVJwVn+CmWpvgIHR2UDUwMOJMRG4BulFcgUFnMAA+Dh/9gWeuCL
 /sSs1UfzAhXFWCOWuYBiU1j7C5jOnA+zTcSedBakESvw6Fz1ZGTcPtnrYXWemhRA/GXn7xrg8Vt
 8NhRKFrP5y0UAk5YKkg==
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69b18f2e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=BpcZMUz7IwU92FFy25sA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: B1SNEeObWi44by6fN-9hlGeMjOnuDpcK
X-Proofpoint-ORIG-GUID: B1SNEeObWi44by6fN-9hlGeMjOnuDpcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110134

GPIOs with "gpio" suffix were long time ago deprecated in favor of
"gpios" and this particular property was documented explicitly as
deprecated since commit 42694f9f6407 ("dt-bindings: PCI: add
snps,dw-pcie.yaml") in 2021.

Linux kernel supports both variants for a long time, thus listing the
deprecated one is redundant and instead legacy DTS should be updated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

I will fix DTS separately, so after applying this patch there will be
bunch of dtbs_check warnings. That's expected and fine.
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml       | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 2c4dc04f9984..deba46d7a924 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -209,13 +209,6 @@ properties:
             - pattern: '^p2u-[0-7]$'
             - pattern: '^cp[01]-pcie[0-2]-x[124](-lane[0-3])?-phy$'  # marvell,armada8k-pcie
 
-  reset-gpio:
-    deprecated: true
-    description:
-      Reference to the GPIO-controlled PERST# signal. It is used to reset all
-      the peripheral devices available on the PCIe bus.
-    maxItems: 1
-
   reset-gpios:
     description:
       Reference to the GPIO-controlled PERST# signal. It is used to reset all
-- 
2.51.0

