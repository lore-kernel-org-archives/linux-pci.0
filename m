Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460932E724
	for <linux-pci@vger.kernel.org>; Sun,  1 Mar 2026 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772354178; cv=none; b=jvXmPdQRBVfWPlVSrq/UotY8SAkHmT2ajbtFDPSph5ojucSJH/Eqicp58jvT6XdmkUPWC7D5gtuivwRWVPqOnBkWsaoQ8txlnDjiINDCQCdwP5diB5dAgjFkiAjdxH4HCZlWg8WKiK49v47csAUd7ISq+mMuMNUhu947dgCmx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772354178; c=relaxed/simple;
	bh=vNU3j7XZQACnjXB5cGDhUUFPb1wF58x7NP3EDYO9B20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YljPkv0B5olc0Bg6aDKTWgutpaaMJasLpCfjpmTEEM9OUnlrYqV6Nk6AbHboBfhgIcW7yRdhaXVN40q+b4ekvJOsGpKKHODVJy5iPdFbNkH8cIguRwHOfdX6DjxFfEQJZ8tzN19uX8tLyPhUobyJJFMhCJ2DiMhzI88WUBUFqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C7NeJH8K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T417P3bt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7NeJH8K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T417P3bt"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6218TTMi2012086
	for <linux-pci@vger.kernel.org>; Sun, 1 Mar 2026 08:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DPGZ2f1FRPz5cKw/lYBC8NifEzRRofLwMqRkmKqE50Y=; b=C7NeJH8K06j+LTBZ
	7LR40EB36WJwpFFTzjB9ZDJlkwJWGu6HWZfLkqId4jdSEhuWDuFKcdICoy0ocOiJ
	A5O+R76J5rU7eK49upDs8N+bAXhwYPO+K+Zu4fDztMUqzEMVc/ItxhxLDrLnEs4I
	1Frzbmk+s/Mfva7mpn0o8E4o3de83z4D/Steqx6aMT3tMA1brrCd/6pp+pIgtkjr
	6GR90Jt4VwP0f9bkobEW3+SR2iy6xaiZI9vm52ZpeIfFgZnyZVQTB7wh1u2SMpiE
	/68FnB1FN+LACGaR+iqaWkRegihbEOYZpU/0iSXl1UIC+SQ2pdu1qNRhE66ZlaSu
	2S3QHw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckshcjgj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 08:36:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35980a994d6so5330315a91.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 00:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772354175; x=1772958975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPGZ2f1FRPz5cKw/lYBC8NifEzRRofLwMqRkmKqE50Y=;
        b=T417P3bt/zB4H3zD3R7BmptOYv0hDUcCJOd5uGTQ1wwDlGGDEZbeZFsWzS1w5IBOI6
         30BUxLo6hymaiUpTVZaeSWXz50PMMhcQGGZxmT+zUEcvVI4Bbzb4uYZkwWZO4e7rFiix
         nQMc1AyvAsuyi6X18MF/BoHQopLMx3eM75MqGWJ6a0fWPybxauRf+5nxGCyWgYuG+Xr9
         hT56qyQwatQxjrmTqq2h2M3USrRBGK7PWVqlHnMcuHVr5EbCv/iR8r6FAqyXKNlWi47l
         7HhqZeYo0Kxs8gdH4dztWKWgFzeeuN38meVcEnlZXzeu/GyHDc6bw0Dr8NyjzbaqRei/
         i2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772354175; x=1772958975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DPGZ2f1FRPz5cKw/lYBC8NifEzRRofLwMqRkmKqE50Y=;
        b=HMClz3QVrfJ5bMO0y8ucUhUkhhc3I8y78MVVBSiUyx3pnrEov908L2/bIAQ6AcqZ4y
         /CRNLGNhyUyIG6+KHMrz6JN3ommfmlGOi4p+VxfOjc+F0UW1n2VMhlqIsnkVfBLxWUha
         /1pjLdb4TiRWNdObd8jA8mcwxKwaq/RksQACkd5C7UYXNSff4c1XWR3fd6hyi4qikD8B
         ng3hi5bPcbQWF9A/Gv4M6ZNWbuRjChvOJKatGXPe8FKEMzYaqwY3Au/kh2lC539UT0/a
         pXCZOYpJyDbY3eSmqD41sNu2MAnw4flbVH11HBZ3y+CCPJ1VNZNq8QkuGGEfMpIq6Zq0
         JxHw==
X-Forwarded-Encrypted: i=1; AJvYcCUU8KV2giFPwNGkjrBGzQ8Rb5GqsyNLHtvZdZZ/XUMo4JBparNAZbVZD9YCZ4nHvDG4Y9nVe43NWF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmY3ASF0OLQSnE7UBeo8qVHrbeE58xPBGEQjk0cIIPD92TOYfy
	5ug9q/hi94xxSY2rVbWpXqpQNKEwxqOlNNZLk+0lF7UTeWNKfxWz6HHegKfzWxCquFcxCaIJQpv
	ZN/gxQvKza48/OanJpFIxtyc2Y9hxW28TzO/+O0pFnhBJmxvlHC1T5Y0rzuA9DuY=
X-Gm-Gg: ATEYQzwm+CP/hpS43yO2Nyg7u6j3FXJxilZ1IyrmTUaPBS0gJAz6pE7daKTbtj+BIav
	3lvlRrZ6A1lLXDn1+ObjTFdWDRI3nN47axgok4vEAkUkTLZleSnfqk0dZhwC1cep+kL5joN4gA2
	Xl9Z3oFl+coXtsOg38i9XgXRXU7MF4kJluB7fKm4YMnY6yx8IM1SSHrBZTKzP2a61Otiw4ZKz/k
	/RaKbtt/9yzxCqLi7wpNfS2ajbKbK16/idplHNH4Y8hzc+IPAAr27X1XAs4n+NKgFz149yqurYw
	keKm2LYLbsk02C43QVkpnA76ljRrRU87YGLLX6ZQF5FsCCI7Esbc4W1fDn9p+s/ea5ugl2M+X4J
	2sz2j4jtPfI5iR82l3UJw3hKVN9xv8JFR/3pTdOjgagmexp3LYWLKWafd
X-Received: by 2002:a17:90b:3c45:b0:356:3cfd:3ed5 with SMTP id 98e67ed59e1d1-35965ccf206mr7771023a91.18.1772354175256;
        Sun, 01 Mar 2026 00:36:15 -0800 (PST)
X-Received: by 2002:a17:90b:3c45:b0:356:3cfd:3ed5 with SMTP id 98e67ed59e1d1-35965ccf206mr7771004a91.18.1772354174764;
        Sun, 01 Mar 2026 00:36:14 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82dd09sm9177300a12.28.2026.03.01.00.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 00:36:14 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Sun, 01 Mar 2026 14:04:19 +0530
Subject: [PATCH v9 1/3] of: Add convenience wrappers for of_map_id()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-parse_iommu_cells-v9-1-4d1bceecc5e1@oss.qualcomm.com>
References: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
In-Reply-To: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
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
        xen-devel@lists.xenproject.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772354153; l=6405;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=34KJIw1PW/qCZqrDovFnZs5F7MkA8lH3ZSq6PGA9s7o=;
 b=iPrFA0Mla+rfvrsVCBVpRZ9RWdwdgwTS89Lg21ZBrY5kmaFRHUg823viwJAJk6c1NGz4OkqG0
 bmC5iBdpD+FCSrT5S1eAy2UKywWw/UDcFmwwy35h1w6fxW83D7WiEy1
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-ORIG-GUID: VLIeBwG_GnrrsafnPrx8rISGrjKacsUW
X-Proofpoint-GUID: VLIeBwG_GnrrsafnPrx8rISGrjKacsUW
X-Authority-Analysis: v=2.4 cv=SO9PlevH c=1 sm=1 tr=0 ts=69a3fa80 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8
 a=wrOk0Nx1w3hKWqktZycA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDA3NiBTYWx0ZWRfX/4P8b/w93cow
 GcH/fvKwSmt5UJOrEfGLPhMMwpYn31hSmHcANpYhVtwnlUjYK6ATMCBqBAR0cAEzgtbctxOUTwq
 JwN5Dya7W5LnECtBX89bsWHJXVS7uhgpQenziokDZ6otwTv1DTnWW9f0jULBhYuXTehtP9DvmvG
 Q8aZZ50YLiVa2g8Va1ctA9GthCvD4liUlayhqpAIsiMcwWf0m10nMzMMqkxeIv0bFETcFaTnkpH
 2kiIdiohvxlvR/Xeip05zpjK15TWH442ZFwaIJrjWVcjd887H06yRAlmOIzNrpgYp9P/JQjxtG9
 bxLukw2DSgkWUQmma5RV7LuPe2TFubTyRzNbg9B1xxsxVk78l3ZrgDzrsqMeiA8sZ5pqodaYBM3
 /XHlE2AV+2NC8/b/75czL3caZYAUblOnVRjj71yiYVBHNsPeLouI1y5GWL2iajktmyngeWuma1u
 XEb4O/AcssWKMSv1p9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603010076

From: Robin Murphy <robin.murphy@arm.com>

Since we now have quite a few users parsing "iommu-map" and "msi-map"
properties, give them some wrappers to conveniently encapsulate the
appropriate sets of property names. This will also make it easier to
then change of_map_id() to correctly account for specifier cells.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/cdx/cdx_msi.c                    |  3 +--
 drivers/iommu/of_iommu.c                 |  4 +---
 drivers/irqchip/irq-gic-its-msi-parent.c |  2 +-
 drivers/of/irq.c                         |  3 +--
 drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
 drivers/pci/controller/pcie-apple.c      |  3 +--
 drivers/xen/grant-dma-ops.c              |  3 +--
 include/linux/of.h                       | 14 ++++++++++++++
 8 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 91b95422b263..63b3544ec997 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -128,8 +128,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
 	int ret;
 
 	/* Retrieve device ID from requestor ID using parent device */
-	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map", "msi-map-mask",
-			NULL, &dev_id);
+	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &dev_id);
 	if (ret) {
 		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
 		return ret;
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
index a5b8d0b71677..bff8289f804a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1144,8 +1144,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
-			  &target, &sid_i);
+	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
 	if (target) {
 		of_node_put(target);
 	} else {
@@ -1158,8 +1157,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
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
index be6ec4916adf..824649867810 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1457,6 +1457,20 @@ static inline int of_property_read_s32(const struct device_node *np,
 	return of_property_read_u32(np, propname, (u32*) out_value);
 }
 
+static inline int of_map_iommu_id(const struct device_node *np, u32 id,
+				  struct device_node **target, u32 *id_out)
+{
+	return of_map_id(np, id, "iommu-map", "iommu-map-mask",
+			 target, id_out);
+}
+
+static inline int of_map_msi_id(const struct device_node *np, u32 id,
+				struct device_node **target, u32 *id_out)
+{
+	return of_map_id(np, id, "msi-map", "msi-map-mask",
+			 target, id_out);
+}
+
 #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
 	for (of_phandle_iterator_init((it), (np), (ln), (cn), (cc)),	\
 	     err = of_phandle_iterator_next(it);			\

-- 
2.34.1

