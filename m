Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE358563298
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930979; cv=none; b=UunqkNABhDIZVP+fPLFxeRLxGHsYQ3dN8MoPriqlpUbpAvubSC0Uop9RRUywpm6BMOKs1TTPbU0+R+LEhAFqYIq1cZz+QJlzUSZrJx3eSJKXHL1iiavOiJODkxcQJj35n2/G3emNdGWAH3kg+sEpN9IhEDlpK1B/kFpRK8IFzp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930979; c=relaxed/simple;
	bh=/Ohn8M1wfo42saMAZlm8BHiU36t6V1B6mZZJ6fEu+Mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfweDA/k5nJlWdCiBfT+IXY9qNou+VLOZbOoOZ+bWBTXxFaaFXAIy8MHMezCdLULtKgfaht03KsdziDa2/7KR798uI5WvBphzhiiRjWGYgfJgplc2OAxp7EBWaJs9yObuHb5nH30grE8V8N8FPbQPTT7b7OAujj09rFPFrUbjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IXn+iPYx; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IXn+iPYx"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DKWPGO610125
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:36:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=11ciqoNzryubv81w4EwgfcXUZZJqEdjWU7J2L
	GoY9IE=; b=IXn+iPYxoUSGlirIVoatVbUwvj6XI4B1FuMjr1+z7MbLsPpQyqKcN
	5Z9o5+063NqKe2u2CdmuIvAtGqqKSU4nhoEeyglRQdQQHh1rSrPYiBROzINYmepw
	GF7ihDKS/I+jDL/snHQ79atmUXBbA059DVYMfRA2ZafP+xuvcGTzqU10js4PoUUE
	9TTyi1j6TNmW+0VkPOh47Zf3mvvP0CKQYfg+FZBVHDqYiwzBFTEzkJnBLgndj3+/
	hJOhc5yMmYifJvWBuzhMsVporHIXMPe4QNTr7FguWXuJinlKSC2bQIs3ckakOs3y
	VCYBHiuSbY5tdkvyFtkD/nDQbQOlmUAvw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h860hy7mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:36:14 -0700 (PDT)
Received: from twshared9243.02.snb2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 22:36:13 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6EDF22D52CB7A; Tue, 13 Oct 2026 15:35:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <changfengnan@bytedance.com>, <linux-pci@vger.kernel.org>,
        <tglx@kernel.org>, <namjain@linux.microsoft.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
Date: Tue, 13 Oct 2026 15:35:42 -0700
Message-ID: <20261013223543.395054-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261013223543.395054-1-kbusch@meta.com>
References: <20261013223543.395054-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX/38iQhY21+gj
 wf1tjhaEKQFsqfyU3y35VPy7aF2Jrpt+IeD3s2wKr29O7V5B8yvyeb/44RrRXI3cFVVXgzAF/BL
 oA3oLlDV3VExJym3oZlhW1FUEpk+YnU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX4mcfUt0kVzVP
 M6QaS9IF8XbAeBVLmFXRpAx+gI6koMYWS11TEcS3+KCR68OxOCxgylS1VpojEFJ46Y023DKxnZO
 hXk8fyEk6YG6Xrdt1skJTAV+wA7Ehxya3YlGl25f/fIn2XKIxrmnvkDhOz+0LofjIPdqlooIn6N
 BBirWG10KCzjPTEEaVTybH8nXtYiudEx/1yHgKvFZ4NfeJmAPok2vkk8+3+09I2Klp9JpV2m3Jb
 KEl+vWOv/b9SMXsyVAG1rtvWvcxSQ5ByDWFhMTC3kob4qmkwYj84Snns1m3tNexAjc4WyoAQGZ5
 MAihqKOt+P2rugMd1xT4YJpjd9UbVRic24GwWlU+9kZh5SdyiSgsZzd9WURV77y30tH72Hm/gcj
 +C1njE8R/cdvAGGPMsENpSf4BVYpSHk+GNhxQcKIHXnyhntPNyXtrV4zZXdebPngnBfAqOtrNfa
 ktqOHN9icmWIglmbYiw==
X-Authority-Analysis: v=2.4 cv=cJx1IVeN c=1 sm=1 tr=0 ts=6aceb25e cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8 a=zwF_Yp6pZpUqULGlHS8A:9
X-Proofpoint-ORIG-GUID: c0Wyy92CVbljlhmpkASnFAXwV_5owiEF
X-Proofpoint-GUID: c0Wyy92CVbljlhmpkASnFAXwV_5owiEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Skip the read-back that flushes the MSI-x mask write. Parent domains
that mask on behalf of PCI/MSI continue using their own irq_mask().

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/irqchip/irq-msi-lib.c | 1 +
 drivers/pci/msi/irqdomain.c   | 6 ++++++
 drivers/pci/msi/msi.h         | 8 +++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.=
c
index 45e0ed3134ce1..bff622b4839aa 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -126,6 +126,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, st=
ruct irq_domain *domain,
 	 */
 	if (info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT) {
 		chip->irq_mask		=3D irq_chip_mask_parent;
+		chip->irq_mask_nowait	=3D NULL;
 		chip->irq_unmask	=3D irq_chip_unmask_parent;
 	}
=20
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 6e65f0f44112e..92a53c2772659 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -162,6 +162,11 @@ static void pci_irq_mask_msix(struct irq_data *data)
 	pci_msix_mask(irq_data_get_msi_desc(data));
 }
=20
+static void pci_irq_mask_nowait_msix(struct irq_data *data)
+{
+	pci_msix_mask_nowait(irq_data_get_msi_desc(data));
+}
+
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
 	pci_msix_unmask(irq_data_get_msi_desc(data));
@@ -182,6 +187,7 @@ static const struct msi_domain_template pci_msix_temp=
late =3D {
 		.irq_startup		=3D pci_irq_startup_msix,
 		.irq_shutdown		=3D pci_irq_shutdown_msix,
 		.irq_mask		=3D pci_irq_mask_msix,
+		.irq_mask_nowait	=3D pci_irq_mask_nowait_msix,
 		.irq_unmask		=3D pci_irq_unmask_msix,
 		.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
 		.flags			=3D IRQCHIP_ONESHOT_SAFE,
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 0b420b319f50f..337ff9d9da0ed 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -40,10 +40,16 @@ static inline void pci_msix_write_vector_ctrl(struct =
msi_desc *desc, u32 ctrl)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
=20
-static inline void pci_msix_mask(struct msi_desc *desc)
+/* Posted write only: the device may still send an interrupt after retur=
n */
+static inline void pci_msix_mask_nowait(struct msi_desc *desc)
 {
 	desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
+}
+
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	pci_msix_mask_nowait(desc);
 	/* Flush write to device */
 	readl(desc->pci.mask_base);
 }
--=20
2.52.0

