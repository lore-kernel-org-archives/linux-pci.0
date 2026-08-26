Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358823BB69E
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735489; cv=none; b=aQ56DeOHm5qeJt21dGTqNE4x3LrWtuBNjFXcnDQ3SUakNf3fp4mq63o9oNFlR+KacEUjpE2fEyod/pRmZCFObx/eLgumuxnAIG1ue9CGKZuD5BusNUGMieyZYhIhYVPsUqGBxw2bcCJxvtKyIsOXMUWriuy/TGCGNsvVAckWJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735489; c=relaxed/simple;
	bh=FO04MYu5xYMvmHI1o+lBKDuU5vr+aSyDwUsg3k6TVNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=okfviuiAvePDxXzvwZ/St9m6/MZ+1CgqL5p2RHiNbFPF7ZJw483IryISVDxeEFM5VL/d9zQlsAS8mej6eNr0bCTcLkXmiM8gq0i0A2sKrylSG4Ry7xhTooQzyo0saqst70+h20VkUCUnvkQBPqQLt2vfVaLCb7e2qL0Dm0k16hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gygbVIUG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hXmKEvgm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gygbVIUG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXmKEvgm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RcCP105917
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 09:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=c9gU0MjggGauOYh5Yo/g2d
	dqRE2PE5fm9ROzvurmbGE=; b=gygbVIUGRbNz4b/JIJet1rFjTzIxBJ5gS51N4c
	2r5qHETyV2UYD3667NyhjHTkdXxpXVbfn2z4V+5g83yeWf5Ivml+YgO52D6s0SXK
	LX1IC87ikxxy3yOkdLas4ngeAqgZWY62dnk7hNnfJ0ArFfoXwT8NPnoEjd4smYnn
	76u5G94jFEpE6aNooEqAoIbsUbM7Wo8NSUJNDtp6I0XAgHbjVHNEoU7GHHj2UXjW
	XvfHYTx+aMBP4AE6pXBrfuAZ7l8yRq+UETk38VB5bNlWOcUwzFKR6AEvI3thrqXp
	AicOqXvSAEKvw50qw9RU9chdqlvbSCKL6BobGCmAqIzkCgNw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k1ay4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 09:11:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso10095745ad.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787735487; x=1788340287; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c9gU0MjggGauOYh5Yo/g2ddqRE2PE5fm9ROzvurmbGE=;
        b=hXmKEvgme20kBqEkjk2MkNjfP4Wyv44xQh2g30bRq0k6KXSIlJMifN/JQTdNXkx1/0
         GJv+eo3jtnKTIyn/ux/PZ+K75VugSECVvIS//UapE8GfYgsph2StB1m9mpGHo0nvs7t+
         FCtQpyU5wlQ2yOJWcSsr0xDdfeTBx62v+JWuamKK7GbOhTOs/WqHJrz7sanEtdM4yv+b
         PB97ZHr7Afxixcdwlpj8W34jySYeNGcxim6r2xoPKXvJE9WQil78qj2RDvl+cbgU7rug
         NIeApap4yfzvC6GtcN2CSaQRDn+4ZzfyC8WdzE2pk2MEyUR2h1ZH0797jGAHkjdpWySO
         9X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735487; x=1788340287;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c9gU0MjggGauOYh5Yo/g2ddqRE2PE5fm9ROzvurmbGE=;
        b=oZ+TyU2UvTZWigAL/TM+epYNpMBVZECVzYTj52UYYILCOP13jEuuRVpt5C/1yuh/MS
         kj8iU64v5Ub1yZBldD/sgEBhEFERtSD5s2lC4yUFXoavUemwuIR5SMYC+yl5ZxLo+KYP
         AA/hyebMIZ41yjSj+LZwfSVgXtrWwP0HEjftywuf+S0zXFVJZl4xKowCnfyMmDWJeECs
         OrRY/zYbPR0BiSrZ9EZ85Dc6+3qH8O+L4S7MKorS8nsvzQx7nSC3fyWUvJ0utuVXf7TS
         p8Xig/CRU5t0BcJ3QO4YASxyOJzn5k8SlmbozAsTLCFCKZu1mswJx+jvMg+yRZ7KV9gc
         05QA==
X-Gm-Message-State: AFuF++kVNqAP+0GwGIPT2MX8+8JFIwr9aVfkNNjt90V5dfXfm82bw1dS
	it/zV9wTJV9xLVD76+74a9iUojbD5rR3Qx7NzKqpkXZO4n2RPoMj48WNXwDVHCDqyh79w8UqAbQ
	ElYay3Q7p0PAr1HFZgCgQMPOWNSpGb1AxoJULUnP3XNwNlGqXw1o4Q6djVdr4hOA4c5ocRHE=
X-Gm-Gg: AR+sD108caCfabQ/YsXega3CSzfk8ZX1idrixI3pxnAf19VyPgSC7W7cPFzit8jshOq
	5psK+XoznUW/24IOPmbCUXk/aMN2L/ks72/CC43+EN2vKdA6sgUOdk8zBKR4mB4rFnzyQVsgEkH
	pgmp2a+1JZKgWVlFPhLOW1ntGs38IsogbAUG0/IpzExf3Ggi8YP0+9vf0/rz0gwpFkb+cnznPN/
	2S0M3HtOcVwj1tIF0g2YmAEcFFdch7axGZGOyykQ7EJjHzTzWJ72Dje474pb8jKZRRHvKs4TFxx
	+yxtwkPZ2ruFelOF/2h6/t/dMM7qpRYdhOABkA8sNrOVfBnoGjGYVAKyTi4VXUFEhWxU0HyEpAO
	4VNsa3EezXSFRBlSxD2s09oZDTg==
X-Received: by 2002:a17:90b:1845:b0:395:4e0d:bc60 with SMTP id 98e67ed59e1d1-3966d85dd8dmr12103374a91.9.1787735486567;
        Wed, 26 Aug 2026 02:11:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1845:b0:395:4e0d:bc60 with SMTP id 98e67ed59e1d1-3966d85dd8dmr12103242a91.9.1787735486003;
        Wed, 26 Aug 2026 02:11:26 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f16dc1sm6124566c88.4.2026.08.26.02.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:11:25 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 14:41:20 +0530
Subject: [PATCH] pci: designware: Set DMA_BYPASS bit in outbound IATU CTRL2
 register
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-dma_bypass-v1-1-3a53dc748ce2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALetjmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyMz3ZTcxPikyoLE4mLdpKSkNItEg2TLxDRzJaCGgqLUtMwKsGHRsbW
 1AFwFpY5cAAAA
X-Change-ID: 20260826-dma_bypass-bbbf8a0c9af7
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735482; l=2297;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=FO04MYu5xYMvmHI1o+lBKDuU5vr+aSyDwUsg3k6TVNo=;
 b=oXz4VZcns8tAs5wbkmoxvvfV1KMlyANeINciRT3oTCpYFeaWzktRZbams+ajTq2Lei+Xd8bnc
 EEv0dZyXyq+DvV09qNHys6fujtz1b0Db9f9lD3e/3S26tKUo0dlaEvj
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8eadbf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ur41RvxIfyTRKVJ8EwkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3NSBTYWx0ZWRfX5nTlgIN+1hOZ
 pEzDqos16vnFWeU1qo7wfLUWdnq2+AuI5Y3TG/iVqj7sJRGZVaJQ29C/yrY3dkUYP6IQ94o5n/v
 ed4da28BBx5k88hKZ4uX65AuDsMUrww=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3NSBTYWx0ZWRfXzBMursUVTHWU
 spe4kWSuvOcTr8s7X7nu/L5AV6zbDzUbvgE7/zHNEAHKUlzd+ZH6hMMpEvt/GzNdg9ex1Tbmigk
 UKb9jeo07NXs8r6PS9bZBz41MYXBAYR6BrqAaniFC5NOLkJvNr7IVo1hUM9Z06GMEJPdAx+mm/3
 ND95sQbfQgn0/Elp+29jLfsXH1AP2TsH7oekkgocH2eQYuJLNcSbG+96YpRER+rVq0norip7Ovb
 Xunf/N2sNYLyC4rKv4iFgWH962vAe3EXXl99B1jM0WE9QC8GfkyRWm680jSsbXWIgwmLMSYHSon
 hgROWhD7SFVSy1HNubGV62011iTBNLFVBLM9c+kE3xBdKt1MQNKU+yH/yVXwFc5gJdwHE/ZL18g
 Zu+ELA9nLNf7DORlJv1u73mE04JnafDXoIBt8bx5fPIXoGLH7g9VDGJOCuVfOoLuVlamQ74+J8n
 1+PwC5xwXeKqC0yiwQw==
X-Proofpoint-ORIG-GUID: 65LvG9mTiIhjCsgUZm1OyLXqJOvu5YJT
X-Proofpoint-GUID: 65LvG9mTiIhjCsgUZm1OyLXqJOvu5YJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260075

Outbound IATU apertures are configured with local device-side addresses.
When DMA engine transactions use destination addresses which fall within
an outbound IATU aperture range, they get unintentionally translated by
the IATU, causing the wrong address to be sent on the PCIe link.
This results in data corruption or IOMMU errors at the host if the
translated address is not mapped.

Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when programming
outbound IATU regions to ensure DMA transactions bypass IATU translation
and use their original addresses.

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
pci: designware: Set DMA_BYPASS in outbound IATU to prevent HDMA
interception
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 593388f29bdd48381cb04710f445042aaf2be29f..9297d0e607e3a1caaeb585b23742f9a29607b7f2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -577,6 +577,8 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		/* The data-less messages only for now */
 		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
 	}
+	if (dw_pcie_ver_is_ge(pci, 460A))
+		val |= PCIE_ATU_DMA_BYPASS;
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae94092404bc2976af67a58f6842cc5e5c50..668a5ba1c6f59aef1aaf15566b77a649bd282ce0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -201,6 +201,7 @@
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
 #define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
+#define PCIE_ATU_DMA_BYPASS		BIT(27)
 #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008

---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20260826-dma_bypass-bbbf8a0c9af7

Best regards,
-- 
Sumit Kumar <sumit.kumar@oss.qualcomm.com>

