Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381EB1D6DB5;
	Thu, 23 Apr 2026 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965495; cv=none; b=p9lMwTwUxeqdSejlP3X0ha/PdyfY/k/hfd24JSM19sQjjUyHm62taZiggPO3ITdCRHI47dnYQpzd2NChqzB9u73GlA0aMYuWEGTox3wNvhZ7shlcmeTJmjwYlHXS7AUFI6Na8sV/fAw+EWJQ5NY+irzXfXOxhPJf4U7v3EC9c/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965495; c=relaxed/simple;
	bh=5laPpylFZGIAGK4ze8/dFHPrMTjfLQovup6TursfZhU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PX7T2+hCx3PvQShbZMKBIVQQHPLOk3O//yxhjdAxyXXGT2W2CCv2fngP6+VNixJL8vEfRV2kTSHHNFyQ3/BHtX/HZQ6lxE8UNQAt/68J/ZY6fRKWoGkkxRmp959jTMZvZGRP3/kxs7IwNxuc3t6uVV3XWao2zR4LL5mzvAr9ioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KoSQJ4QE; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KoSQJ4QE"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NH8qht1825687;
	Thu, 23 Apr 2026 10:31:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=sl1X8lIyZ3uvIcv5XJ
	vNWiGMZFCkwqvQySCiFqrT/0w=; b=KoSQJ4QEmGtB+n0P5xENqiYPrxCLhFMRI1
	b1A4enVbbap7ZbKwFWzjGKnc9FQFu19txKMkiMQyunBlKa7iD8GZEiCO1WsOZ2a8
	FPnyYAKDrOu80K/cOYp4RMMm+Ee87Btgw6AP4z1juLix+q9FxCe8VlwNQrbbA86r
	Vq3EiKsRDCQsTgBSCt55Cc0zjbvWa4XAa7UUX9sh2hSBvSJtsP/7v2ReVv4H5kuE
	lC/pbQu9AEDU2Vdg5ejS2EeAt+oZ1Lm6+dcUdVrClWDRtf2SstJlo48HHNIEZfhr
	Z30F6Z4hReOFE56dvYn5t/aw9JvQXeQQWMg19tTiCqQaQXHCEulg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpeph6ax8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Apr 2026 10:31:19 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 23 Apr
 2026 17:31:18 +0000
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
Subject: [PATCH v2] PCI/P2PDMA: Avoid returning a provider for non_mappable_bars
Date: Thu, 23 Apr 2026 10:30:51 -0700
Message-ID: <20260423173051.1999679-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MSBTYWx0ZWRfX78pEYXaywXR9
 7nUdyoFEINho7IZ7lY2PU3MjFhjYqRRJFZ9HCp91oRwTbzzNRD036sEoAxiu5Sv+lsKlpeVA11W
 AZOqCFULlN0OQ3aqnAr16atEVlJuXxyHLgq1INxhdHrD+bqZansyiPNAE8F7Kn3qZngJlzqrsI9
 QozlFoRTEVaP80zReuei4g3r484p03S+fM5wujsDt5vuxaxSuFZqenZV0H/M1R5NwHocwRlYPTn
 NR6+LghgvIuB8W4YKUTgVMV2ZW+HuolNns0Ex1y7JC8+BaIMx64hEz67TlVwpc3UpHoLE/ZKfzI
 O2DUqYUauU5hgKqmzOqaZoVKYQBwuff0gxP0xQvYSmJyur3gIIhoALJw5VdbUainbM34IoKmZDi
 fENtAG/hoRmAvf8t3AqYfBbmNwh8gGtSWQjAd1QrzgRDhnrgg5VzseS98JtbMZCug2uBq/Szy2a
 zgmj8PtP87y0sMNo8kA==
X-Proofpoint-GUID: pr6pS-6pK0FJE7T4pft87PD_cUfgwYoM
X-Proofpoint-ORIG-GUID: pr6pS-6pK0FJE7T4pft87PD_cUfgwYoM
X-Authority-Analysis: v=2.4 cv=B8SJFutM c=1 sm=1 tr=0 ts=69ea5767 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=LxoKb0BkxeglHS5Ch2kA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

Extend the checks in pcim_p2pdma_init() and pcim_p2pdma_provider() to
exclude functions that have pdev->non_mappable_bars set.

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

== Changes ==

v2:
 - Also test non_mappable_bars in pcim_p2pdma_init(), as
   otherwise pci_p2pdma_add_resource() will WARN_ON
   pcim_p2pdma_provider() failing.

Niklas and Logan, I didn't re-add your R-B from v1 as (splitting
hairs...) the code's changed.

v1:
 https://lore.kernel.org/linux-pci/20260421174351.3897842-1-mattev@meta.com/


 drivers/pci/p2pdma.c | 6 +++++-
 include/linux/pci.h  | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7c898542af8d..adb17a4f6939 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -262,6 +262,9 @@ int pcim_p2pdma_init(struct pci_dev *pdev)
 	struct pci_p2pdma *p2p;
 	int i, ret;
 
+	if (pdev->non_mappable_bars)
+		return -EOPNOTSUPP;
+
 	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
 	if (p2p)
 		return 0;
@@ -318,7 +321,8 @@ struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar)
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

