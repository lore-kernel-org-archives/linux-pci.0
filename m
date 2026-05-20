Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD836BCCC
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264212; cv=none; b=BWGmf4yjAm2WOaUQxssqDkui7oSB5xg8IkzTj8e7oijD/hYK5gcnuqyINpjCuHkIR1JgyB2kAmsycNQKLaHLNKKNtkM0txVpuN6YdTSiykRPMTTINP3ASee4qtPpSuO4qppzcZhXh6/lhs/jMEIdyJ6nMuR7dTedo1ZmnfoGmvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264212; c=relaxed/simple;
	bh=phzhKGxsD8t3YkGlCEmeP10wiLTAREuNp3sc6yMT+Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jnPZnzF8p2yjiNY9/QP5XLGCTpKzsRuX6UPoDDkAvGC6p0p+Gj49iAJvQNU3aXtRNImsyzJ5/UWYhnYu6vlJV2TFBuVEFMVeGcnF6cy3D2MD7YuQxU3xkV54kce6YN9i+Z+GlPwlWI9dQ62XOqv1DF0eC6lnHd8U9fuIvVQpXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aWVwVHnz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FBnSydwF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aWVwVHnz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FBnSydwF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7ABQ72143761
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 08:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FIwRGbihw9ibmdw2sFBiy3DnC7QkudGEzjZgfV2uv2w=; b=aWVwVHnzTd6YLtiG
	xH4Okt96JuBzSmgt2+3v9vv4+yIWWzx/kbLxCpSsuaik5jk5SIPN0GjHNwXMinHs
	OBVnw1Z/CxjAbcvkecP+wPx/Gw/R7gcFU6ctu2+uj4mwYOB9WDcvNQTVyh/jOYId
	XRuj/5eTFHfO0UcC9SEfkKhzxQseCU99nGmzI5ZEvR4KkvWj9WEx/Ze1XGpaCtNw
	xAUtc1fp/YLFs42biudgbkKKi9ALDsDE6BpTCKzdybU+KR3e1HlEwzPGVQm17cL4
	A9sP0MeX9FNDV/Ylg76eYqJ6u8175Sm7AjjnNSLm3vwKq3pLFuDs4Cb3NhlDHh+e
	2t9XQg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3tkq7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 08:03:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-367cb6de61aso7999110a91.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779264209; x=1779869009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIwRGbihw9ibmdw2sFBiy3DnC7QkudGEzjZgfV2uv2w=;
        b=FBnSydwF9vP8DZTeXxFG+Ik3Xp6wldf+1RQszb8kH/WS/4ORQwPIqxZKon20O6FhMo
         FZWVyD8zwCd0b4uRL8uVXjDvnhTIYVzzrTnZ/uRp0zePZME5ThCfSbJZ1YOST7UE0Gm7
         CAxYXGXWmnezzF/Fleb59aiScf+Tw9sE8uptrZIzL6yKpNGhuA6S7IqX6IOm2yTqj3wT
         VEmuV1jmsb5Yzs142g1jJwMu920aAyiRzmmcYw/P+I54Pg64LUeenby2IJ+6vulUR6t+
         sG/ytlTvA1rUeMqNd3wITgTHBachPfvmzb4idbskXTXbkcjkgZasInu+PpYjpmZvnXXf
         sbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264209; x=1779869009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FIwRGbihw9ibmdw2sFBiy3DnC7QkudGEzjZgfV2uv2w=;
        b=jhw0z8fKk6NRfw12VsXJ2s7qI3wREAgIO1B/lPNkS49HQ+ciDNOZeTWphYOyZ7jp/r
         uc+r6KqH0JuEvvUKgy5yTYoWW0Ah2TX1SNnroYgIlLSHNU/elpJG+/re7sLTT9mpTimo
         V1ClHoRlbAu8rlyNWIo521sW2UOnvz+KROLkwnB0sqA90kfCVi2WOPhIC6Yv/Su/qXL+
         GURh06lIlUAHW1/lYmGp0iNg/Mas1ZKjRLvQtht8R3dxzLTx8k1Xm+JryS/B3sOHB0aw
         4ctLa/gUiSliJAvqWEvxLHAoW4RhDiyNBpQx1YYZS5nIAAlIlOf8H0N8sM/WTFN8Yv03
         bVpA==
X-Forwarded-Encrypted: i=1; AFNElJ9DepdK506C7Oeg0MI/tKW6tE6TbhMcbY8DvBUGOJg3X6f0q0702U0pmdg5mnDJbQxwOP7BTuYD5R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYmhbTECZ91yRY0RMmrFd3b8GsZcdQiAqAb7SBD5vcTPwsscLN
	CX6kPqq2pRI40bPA4f3ycNck8QGuTqHMUTRDunSW3fa6SbxjRgWqN3P7C8O3SV/GVT9hyR0mvBz
	Ggs7Qh2DDeVoOC4EQlo3+t8EihoYK7ueBNveL+XCd+Q5zjlffaMupjYzLrmgEbtE=
X-Gm-Gg: Acq92OEb5TyPEuyXkU0uHYXRxJnhUtuDqpUart1kKI9sBCA44zW8VUHoEAwLWgCs0io
	VMBncpF0/fQdPoek5CpFDDfJ8E6jnleDAizvDl9sDzROkJWBxQ1aYhHNG/A/9F2Di4BRNZp0KbW
	MKUi0WYaMnFbrWssg0g5yeceAfZdV16zNOwCkAcJGB7dlwrsHylolU9UHUVwA5OeX456MkS9IOA
	7UY+IjxghEH++V3TzIkI+pXMKjJf8lWd48NQdNPbaV8WYU+aZgj+6w2s2FSs+ACMCJmFajRTVvC
	InQsV5cZjdW/y6TNUM8wBp259Ktzdvrh4wbvGGPLAQSAkGBHIQulGNVO+WAvpLPHx3hR/Bz5QIr
	K64RfC08rkHKNs20j3RdcDenamvLXjGw0ZVzFyCNfp2rLme6aExtAl4fN
X-Received: by 2002:a17:90b:260b:b0:368:ed92:6f3 with SMTP id 98e67ed59e1d1-36951b89773mr24767426a91.18.1779264208464;
        Wed, 20 May 2026 01:03:28 -0700 (PDT)
X-Received: by 2002:a17:90b:260b:b0:368:ed92:6f3 with SMTP id 98e67ed59e1d1-36951b89773mr24767391a91.18.1779264207963;
        Wed, 20 May 2026 01:03:27 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517aa6f8sm20889290a91.11.2026.05.20.01.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:03:26 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:32:40 +0530
Subject: [PATCH v15 1/3] of: Add convenience wrappers for of_map_id()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-parse_iommu_cells-v15-1-b5f99ad4e7e8@oss.qualcomm.com>
References: <20260520-parse_iommu_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com>
In-Reply-To: <20260520-parse_iommu_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com>
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779264185; l=8692;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=6WwVJdgDC+Pm2Sux0Nsas8KIvED10B5HRfeqtTU/lhc=;
 b=Avwv4njbY9ZiIIe1YQtbsdcqBiwZRYWWqv+UaxTUCSBN/Un8571eB3pAOLYzMSYrhdxLe30qj
 87MQDMJX7ENBWSVj9dLyx0medcxa5u10fEAW2+WnBP1fCf57QH/sMpV
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Authority-Analysis: v=2.4 cv=feCdDUQF c=1 sm=1 tr=0 ts=6a0d6ad2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=f4O9XJQV64orvU1ydW8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: p-14nV3H9ab99m3B2QRD9LJwedCfOQfz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA3NiBTYWx0ZWRfX5AHrEi6QRmN0
 PiDkps8gnhSAu4oOsmBTmDMEq1gsJcXC83sLr1fIpQxWghR6e3HvVWuV5CNempSLfMfL5PLHcIM
 sH/JbhgG96EBG2/NJmHpOoqToK8gMw7RpTHybH+1FHOx2AukoVqsftKkLjUMBiBJmUbyaRrQeVO
 LswjJPko8NMKOHXyfBxupfmZe9UmuMeEzkgThN26TLNgjghz3lx9zczQVSAEoGfY4TUToUU/M4i
 HxFJvuiVAHL/zWd4STMkZCzI/KiWrCeCIgw0UySZ79GoKMEMJcsq4k8Deq0o8YnmkXTgnAzmPYO
 Tmno8WsiCDakLPrfXyg19NcTXzm+P94c/SfxZTcMebpvGVJfOn7fTtFo/7k+GPaLJBv45+J6pJX
 kn7O2geC7cEw9cNuTOzrP9kirSa2sxaLLDMdtWobf6ibn9b+YHNvwiBkJiEz2YTA13ntD7mmQJA
 4KpH+T6bL8M+XGoKlHQ==
X-Proofpoint-GUID: p-14nV3H9ab99m3B2QRD9LJwedCfOQfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200076

From: Robin Murphy <robin.murphy@arm.com>

Since we now have quite a few users parsing "iommu-map" and "msi-map"
properties, give them some wrappers to conveniently encapsulate the
appropriate sets of property names. This will also make it easier to
then change of_map_id() to correctly account for specifier cells.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/cdx/cdx_msi.c                    |  5 ++---
 drivers/iommu/of_iommu.c                 |  4 +---
 drivers/irqchip/irq-gic-its-msi-parent.c |  2 +-
 drivers/of/base.c                        | 38 ++++++++++++++++++++++++++++++++
 drivers/of/irq.c                         |  3 +--
 drivers/pci/controller/dwc/pci-imx6.c    |  6 ++---
 drivers/pci/controller/pcie-apple.c      |  3 +--
 drivers/xen/grant-dma-ops.c              |  3 +--
 include/linux/of.h                       | 18 +++++++++++++++
 9 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 91b95422b263..78edb7308856 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -128,10 +128,9 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
 	int ret;
 
 	/* Retrieve device ID from requestor ID using parent device */
-	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map", "msi-map-mask",
-			NULL, &dev_id);
+	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &dev_id);
 	if (ret) {
-		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
+		dev_err(dev, "of_map_msi_id failed for MSI: %d\n", ret);
 		return ret;
 	}
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6b989a62def2..a511ecf21fcd 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -48,9 +48,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_id(master_np, *id, "iommu-map",
-			 "iommu-map-mask", &iommu_spec.np,
-			 iommu_spec.args);
+	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err;
 
diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index d36b278ae66c..b63343a227a9 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -180,7 +180,7 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
 
 	struct device_node *msi_ctrl __free(device_node) = NULL;
 
-	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
+	return of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, dev_id);
 }
 
 static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index a650c91897cc..1e9b9692c0d9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2221,3 +2221,41 @@ int of_map_id(const struct device_node *np, u32 id,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_id);
+
+/**
+ * of_map_iommu_id - Translate an ID using "iommu-map" bindings.
+ * @np: root complex device node.
+ * @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
+ *      stream/device ID) used as the lookup key in the iommu-map table.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Convenience wrapper around of_map_id() using "iommu-map" and "iommu-map-mask".
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_iommu_id(const struct device_node *np, u32 id,
+		    struct device_node **target, u32 *id_out)
+{
+	return of_map_id(np, id, "iommu-map", "iommu-map-mask", target, id_out);
+}
+EXPORT_SYMBOL_GPL(of_map_iommu_id);
+
+/**
+ * of_map_msi_id - Translate an ID using "msi-map" bindings.
+ * @np: root complex device node.
+ * @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
+ *      stream/device ID) used as the lookup key in the msi-map table.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Convenience wrapper around of_map_id() using "msi-map" and "msi-map-mask".
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_msi_id(const struct device_node *np, u32 id,
+		  struct device_node **target, u32 *id_out)
+{
+	return of_map_id(np, id, "msi-map", "msi-map-mask", target, id_out);
+}
+EXPORT_SYMBOL_GPL(of_map_msi_id);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 6367c67732d2..e37c1b3f8736 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -817,8 +817,7 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 	 * "msi-map" or an "msi-parent" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
-		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
-				"msi-map-mask", msi_np, &id_out))
+		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &id_out))
 			break;
 		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
 			break;
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1034ac5c5f5c..c863c7b02289 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1128,8 +1128,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
-			  &target, &sid_i);
+	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
 	if (target) {
 		of_node_put(target);
 	} else {
@@ -1142,8 +1141,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	}
 
 	target = NULL;
-	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask",
-			  &target, &sid_m);
+	err_m = of_map_msi_id(dev->of_node, rid, &target, &sid_m);
 
 	/*
 	 *   err_m      target
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 2d92fc79f6dd..a0937b7b3c4d 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -764,8 +764,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
 		pci_name(pdev->bus->self), port->idx);
 
-	err = of_map_id(port->pcie->dev->of_node, rid, "iommu-map",
-			"iommu-map-mask", NULL, &sid);
+	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
 	if (err)
 		return err;
 
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index c2603e700178..1b7696b2d762 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -325,8 +325,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 		struct pci_dev *pdev = to_pci_dev(dev);
 		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
-		if (of_map_id(np, rid, "iommu-map", "iommu-map-mask", &iommu_spec.np,
-				iommu_spec.args)) {
+		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
 			dev_dbg(dev, "Cannot translate ID\n");
 			return -ESRCH;
 		}
diff --git a/include/linux/of.h b/include/linux/of.h
index 959786f8f196..721525334b4b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -468,6 +468,12 @@ int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
+int of_map_iommu_id(const struct device_node *np, u32 id,
+		    struct device_node **target, u32 *id_out);
+
+int of_map_msi_id(const struct device_node *np, u32 id,
+		  struct device_node **target, u32 *id_out);
+
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
 struct kimage;
@@ -948,6 +954,18 @@ static inline int of_map_id(const struct device_node *np, u32 id,
 	return -EINVAL;
 }
 
+static inline int of_map_iommu_id(const struct device_node *np, u32 id,
+				  struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
+static inline int of_map_msi_id(const struct device_node *np, u32 id,
+				struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
 static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
 {
 	return PHYS_ADDR_MAX;

-- 
2.34.1

