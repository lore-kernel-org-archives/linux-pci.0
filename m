Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6529CB24;
	Tue, 21 Apr 2026 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793713; cv=none; b=IsN8MxERE8i+EjLc9knJ2s+M9tMukTilFb20D7/dFWt3aeJpL1lFu0xSPLFJuVaXZMHebSnpl5nWkciG2jLYW1uudgDdC7PVv2R/xJt2A7sg0lSoU5KcIj/qs0JpnmvD6txifljcGnWxWZJrVg67eTqG2tqZsw6EMaH9C/nRL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793713; c=relaxed/simple;
	bh=K23oW1r0/klN0f5vv2ruCFnMybzehjjymAzKaQCwHyI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DR8hIQcJLKq+48+L4hyy9yiD7pNKqL5vRzG3+l51wu2te9tTOKuEydpD8uF2MtyaGIog0Q+sVBP4HNx+JE4jrojtnaYF2xkBt7CbAIZn8fPusGaMlJOWk1scDa11Yfr/YBYHK+9acdZ1sEQX3JPRcLQJZHcuEkZ3yXHkFQmznKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QzNZFg6m; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QzNZFg6m"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63LH0rGJ2930348;
	Tue, 21 Apr 2026 10:44:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=97lJG01Ra6fETyE1mK
	K3yMzNQjXRpBT+P6Tyhf4twEE=; b=QzNZFg6mi6ILZBM7EqaGfNdqtn2ERpM1BH
	kECR9cYnM90vhQXLSwkE7ga+gOQP5qxJ5otVTq5jCoxYbCnoEswJJTaQEu7Ci6dQ
	DcdbJVPBNC2rxszvc0v74Ua88UMGzz6rF3iaLWJuuD/oF1aN+HfHeeCSErgOA/2L
	2M5gbENJcGgd6O8j/dJGYj0P96oqViniigj3Zca7yVhqjKZ1MOCftPco4GKRRmKx
	yL8JYUOWlA5rEkJhTbW3VE7rZ0Oo54WOmNhXX8OX3hnthTcmeIQM+vVO/MdBRL4Y
	7XYeoCJJgOoB+03bA9oNFpGCHD6Ky/eaBmCqLQIlMMl1AN7A9o0A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4dm5emj275-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 21 Apr 2026 10:44:07 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Tue, 21 Apr
 2026 17:44:05 +0000
From: Matt Evans <mattev@meta.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe
	<logang@deltatee.com>,
        Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>,
        Alex Williamson <alex@shazbot.org>,
        Niklas Schnelle
	<schnelle@linux.ibm.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI/P2PDMA: Avoid returning a provider for non_mappable_bars
Date: Tue, 21 Apr 2026 10:43:51 -0700
Message-ID: <20260421174351.3897842-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=fcOdDUQF c=1 sm=1 tr=0 ts=69e7b767 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=LxoKb0BkxeglHS5Ch2kA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: XHgDKY2zrfFiT5hrQpmjCjKg1w4BMaTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NiBTYWx0ZWRfX7AcGpgQDDK2c
 7m6OCbGHRL+4WfRekvAGK8k1Zr+flhGDrXAstQhVV9PRjGp51CkxRd7n9QtGqhTCasE60/ZPOig
 qOV+6KK43MUsGYaHRH30tGNKf2+bBKxMe8KMotBhv4ZHW0UIVYBESC+D8J81e5aLHTNY8zJdVBD
 KCfWcu4CY/MdHa3nou08CO/uJOhevFc1lYfnnzdKc6Jf1haqX4rnT106Q6F/rpCapLxgnky7721
 CgXUDE3VRkQDi0zYs7bO62xVnDSWzCfLiWHU7o0uBApQMrtGOfXjFhYsZ7KuZ5hoyFzyFCLLoce
 nvSC+ERyu1jya5dT4/jsMJrYUoeETcbHZKuq1R/LjC8igsY/dMODahqLw6oYkLUcnmxDnVLnzzX
 uc9VhpRy76Ufrm/mjHQXlYem8p2dev16vBodmeYBUXdAbh/AMVSKDuiInYQ8wrDcIU3DKnzOy0l
 2NG1Mt3CPRBxa9qzQpg==
X-Proofpoint-ORIG-GUID: XHgDKY2zrfFiT5hrQpmjCjKg1w4BMaTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01

Extend pcim_p2pdma_provider()'s checks to exclude functions that have
pdev->non_mappable_bars set.

Consumers such as VFIO were previously able to map these for access by
the CPU or P2P.  Update the comment on non_mappable_bars to show it
refers to any access, not just userspace CPU access.

Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
Signed-off-by: Matt Evans <mattev@meta.com>
---

This arises from Alex Williamson's suggestion to test
non_mappable_bars when getting the provider, with discussion here:

 https://lore.kernel.org/kvm/20260415181623.1021090-1-mattev@meta.com/

The goal was to prevent a hole where VFIO could export DMABUFs for
BARs marked non-mappable, and to fix for all users of the provider
rather than just VFIO.  Alex observed that non_mappable_bars should be
taken to mean BARs weren't usable by the CPU _or_ peers and,
considering that, its comment about userspace access wasn't quite
right.


 drivers/pci/p2pdma.c | 3 ++-
 include/linux/pci.h  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7c898542af8d..4a783413f466 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -318,7 +318,8 @@ struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar)
 {
 	struct pci_p2pdma *p2p;
 
-	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
+	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
+	    pdev->non_mappable_bars)
 		return NULL;
 
 	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..1e6802017d6b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -508,7 +508,7 @@ struct pci_dev {
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
 	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
-	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
+	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped by CPU or peers */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.47.3

