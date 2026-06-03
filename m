Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095593FE663
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470847; cv=none; b=kIU2MU0qAx0VnkKDvj7+QO5RdPwv8AB1OVZnjpssqA/6d9j5QUvhjAyBlMdM6/Aqn+vHPTp9z3ll3GPfFz1WjADYn74/2xOK7LYe0hfqfW9gOtzMaxImHUM9ORw05GlVb3Vk7gLqcil6ITWDGJp5973e4cEjJ1w/jKWFKO+/N3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470847; c=relaxed/simple;
	bh=phzhKGxsD8t3YkGlCEmeP10wiLTAREuNp3sc6yMT+Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MMHmyRKZPp0Vpm5WGYyFit6bjF4q2j+1CPJOYNYcSGFbwRQdKTAMvRlkHBbmN4VYbCrBa/5IquZqlZGgp6rTheBthUfj4ONyTAwBvlkYv/ZWzdDwHmiP+8WURBORQ9q4QfzDtP84t7wBQBXqj3EbO/b0ofYOV2CTU78FLMUHICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GXbIxEvx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TDYRqXc1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXbIxEvx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TDYRqXc1"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536v6vb1755385
	for <linux-pci@vger.kernel.org>; Wed, 3 Jun 2026 07:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FIwRGbihw9ibmdw2sFBiy3DnC7QkudGEzjZgfV2uv2w=; b=GXbIxEvxJZ3R2frZ
	6stlexO8WRGPESZ0wsEi2i2X1lAQ3qFn/DMuvCS9B239Q9oTVr9wk2A5V0qOTGWj
	ylLZebYRpx19HKGx86cn5+onAL3CDJ2OopNBk8MliW+jR89283TVCo9tLu74gMEm
	RHzU2JYyHcowHchYTFgn4MDv28ef2r2JjAAKONNESS65l7NKcmN3uO9A1AnhRK4R
	xZWQxRufYYatXtNKaeF+Gh/W0yjQsQQ8QWpbLQLExIR+RNH+IrIZt+4Xaq+D5ieV
	7qoAmGitTLFT/Ht5EQGwqZgD2ADb+Ut9Q1zaAvMNY1ctEAJGl/ylXsOXEsCEmBWJ
	v3qagg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejff002ad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2026 07:14:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so61613875ad.3
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2026 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780470843; x=1781075643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIwRGbihw9ibmdw2sFBiy3DnC7QkudGEzjZgfV2uv2w=;
        b=TDYRqXc1WbwBbZf+0HkksHeU2HlgRTJm+YjBvpex8FnRwX3FnB6c81ZE6gq2/YYSAB
         mVHCUyeTPGcYgKrjuygjqBQINgNQ9eOQ3m+4HsAV4wxZ/XDaGtd2D2gxumYjR63xkQut
         X8aX+6PnZ9/ROzlqyBOY1F/8tl0q7EmbHCJwDsyN6MH1Owbvaq7c+fEf4GvS/PqnUYAb
         gCUmISq3AsifTMxJE7ST0kUn1qnhP6OPsxLRgrcnnOgp3G27xTzdipPgDHccL4LlkK+y
         cRSKhBbFkhquEj87tM4jEZtPzTSQJtrcvXd1mT8xQiE6NM1+3uxLuJLXm5OBOp6Mvgkj
         dJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470843; x=1781075643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FIwRGbihw9ibmdw2sFBiy3DnC7QkudGEzjZgfV2uv2w=;
        b=CssVnhnsryAzleHKMVkb/nPTplMEZJEJ4NiEI8YrKetIAlL21iucjWVTEt8lRZBkyT
         fLJlDYfzv3XEUrCDdI3w/n8lSiY5mmG1pdUCU1XqsYGrvIw85hvDuUeX2N4XBdVkuaea
         zjqq1WINsJTKmUJTE6XgzCFk/sGm6gPInLsq1eb4k/9x1v8zmIA2yD6XCkQc82PBlVsG
         Ru8hZpa+bOXd2g1/oepTqlIjxAxxYiDwo/hjJppw1HmksNFze/74OhPJGrmfT3/m3LW3
         1w5530gJtoP4nRRUk0I47Y5PItg3IUXIuReqjO0bbuNDWhEw4BDe+c02NGgLNBG3EfEb
         PIyQ==
X-Forwarded-Encrypted: i=1; AFNElJ87t/srZ7ocHAheOYdqhh0apXgNdEmHkt9uRkgOkBq/RQiA6OOeohSx3kytPPKSJCMVX2r+BW30vHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGIwU5hqxx/N0ZeGoTJ9N9TGMnsXWaBGFY9VqFB3e/2oS353+
	d1nvqUBGHfGfTufSr+hxJPTA2Vu+Tr1UAyU+j7e+saS9CFoDfsZC9kP/XwiblZhiSScNW33NjFr
	sZw1l3c643yZmfK3sAKcthhp3Zc+BLPybeZECBtR10tQnMprLrf1SpnL+q/lGx0s=
X-Gm-Gg: Acq92OG10KxAn7reBiPIWlHKCl37gMVixZhfs/HRg9iYvknA+TzAed6KxjY8KLkLnfp
	ZrfIw0zRtSMdJ8L4bXj9+1kchL6WJXn88kmd/nd6VDQOklmRHudODsFKRD+P91zvd1QSuq6sVAg
	8BOp6jmMb//B7u8u1W/SrsKTej1ZOkQ3RpvNfwTExVwPXUJPsMB+7579LUJSZPC86P7KN623GlT
	EjS0voPm+wmFu0Z7PznU3YV7NvEQgslznntjrwMmj4p6ekBZHamRHZAD/SlfgjDTOKjKWKQl0FU
	8v8dlahtCQZ4irC+FmLoXwd4sSRfe9bym3FA+/MXCqnXXp6iYi0Qy3d0C1l+q9QwOGJp/kc8tQF
	ZNiBT7w7t/xGyo3ngCrZOOrVRQVJuQ4PdXkh50EwXI8vp/Up+r3dRaz7fCuNe6VAD1x8=
X-Received: by 2002:a17:903:1209:b0:2c0:dd75:e834 with SMTP id d9443c01a7336-2c163a242e3mr21686945ad.5.1780470842901;
        Wed, 03 Jun 2026 00:14:02 -0700 (PDT)
X-Received: by 2002:a17:903:1209:b0:2c0:dd75:e834 with SMTP id d9443c01a7336-2c163a242e3mr21686495ad.5.1780470842370;
        Wed, 03 Jun 2026 00:14:02 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8429fsm17249725ad.18.2026.06.03.00.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:14:01 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 12:43:12 +0530
Subject: [PATCH v16 1/3] of: Add convenience wrappers for of_map_id()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-parse_iommu_cells-v16-1-dc509dacb19a@oss.qualcomm.com>
References: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
In-Reply-To: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780470825; l=8692;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=6WwVJdgDC+Pm2Sux0Nsas8KIvED10B5HRfeqtTU/lhc=;
 b=NUPQpvQ7RA71Z0dDCaP8zprJ7zJ8CDz9jnCa1HrYhXvHAGE5W9jsr9K5BqrnxQzWJcs6EHugw
 ySdvNc2zYrwD35BUEPlG8BE8sURF+1SDFW7O+5k/3NMbvz7+/hD+trF
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-GUID: r410skmIXIETm9KDLE2hmwRpfpnlXGuP
X-Proofpoint-ORIG-GUID: r410skmIXIETm9KDLE2hmwRpfpnlXGuP
X-Authority-Analysis: v=2.4 cv=LYwMLDfi c=1 sm=1 tr=0 ts=6a1fd43b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=f4O9XJQV64orvU1ydW8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfX2COpahNVZdCM
 Nf3zkHnx0IZJtjVvhvPHd6CVUKEmNdRZTN9WLVdwW24O5VMsej30zJriHEdZ7Cw2Kg1t5ZhxdAL
 r3xzjGQowoS2KcTF9XiPU5pkEJTfHqpCIPSLLXcZYONdzNUE8w/XLPSau30bBpMECqoSAdB01uo
 blPbjO1b739qocz1np+2HlIv4mQS8/y0q6OGJurAL762XSFPPVOGC3vWghXDPV6/Ihf9iGMkUfW
 o8Vmf1Z1A6XhCp0X+lEw5GaU4T5Sr1EJ3HAnSfQlNuyfXS6g91AajaKfvFaJcm6M/Ep+FKBxrhs
 qfKQy66XlcdDC/PuiZKhJ1R286de1nqgwbwPjuqh3LiXvCVj2VEEEL3loOOY1SkmYMIv0UnFDir
 Ig5v+Of7Ajjvs0wL53i8GLryWhnRlS0t+qZXGMDYNZIA2DvThTpTemwQGeqqhfMiVqNnI4iDYyz
 n160YP0qO55y2O3l5Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030066

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

