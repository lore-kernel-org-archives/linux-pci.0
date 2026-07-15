Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E0377A9D
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148366; cv=none; b=e85/3+FULKFloZJDl36H/4Jo58B+mphToriDGFYstyrk1erpzVLeffpzMRbv8LTwJjnI2XY/Bb5JeJNDw9umbmOrSWm06qMvw+uvdulmplQKcyN4SxN/6qfweAZGADToFKvfYfOdpqY+q56mWZ6jWwCLZS5do+1g47jKVbb6YdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148366; c=relaxed/simple;
	bh=CxIAFZrQrMfyrJD798A2khL2NXf11+oUSp6ceco9Zwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyJw6LE2QIyMkldcDFI8Fpw/Cgs1vVu5Wdki8kLG5d+hczke/wKeMNFa2uLcRbst6BtRscz/3u8ivP1PcBDO0aRvhSAz6019Ja8T6jURWXw17vmtvVq64VW/uDBl1KEgNaM5z8VeOYfboFHetQfRSKV156knihrjxn4s9ub1MZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FIwiFHwI; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FIwiFHwI"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKQM90942698
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:46:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hnyuo+QLyIX78Ha3FzEk0mRWfvM2HTMwdWd3nP7nvPo=; b=FIwiFHwI5D2D
	3JGXKfkGy8bYmYBlsBg5q41kA5nkp8E3LTqfYi+CP3cntH8lX9cKnu+Z159FtihP
	369YoJIbC9fOPLY3fbP1CoJjVBVEC3Gi9bsKbQoTPvAvU14X+ubrmTxRH5yzXj/R
	LDgTFgVpeYlGP82B/o/vY3Gukpi1OhzAsEFdTZYDV/Q08j4viapQld2finVqeOue
	UX40S3vVXnmwhay69EOfvjnkwHpEDc1eWCxvImYButJo/pbPACJ+MPZkQQi21nlh
	EijMQysP5jwJKnIez1tnk4/LWLTBdSzuhPZMMUWk+ARlzVoDKts7Cu4iGyZ8BExh
	rX/T4Rce8A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4feamkk0qx-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:46:04 -0700 (PDT)
Received: from twshared4170.04.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 15 Jul 2026 20:46:01 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 541B2423AA016; Wed, 15 Jul 2026 13:40:10 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael
 Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson
	<alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v12 1/4] PCI/TPH: Add requester/completer type helpers
Date: Wed, 15 Jul 2026 13:39:56 -0700
Message-ID: <20260715204008.3911275-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715204008.3911275-1-zhipingz@meta.com>
References: <20260715204008.3911275-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfXwInu0wOlzUgX
 hyafvg87tsNEt5CW+DEVMKTydzGEuKC5svG+dRwPcM0BGPq6nhsdJUNnYA6jlcCKjJrHzZGlquG
 5KtfHyO6nf4YaSbymJm4bD3/OB/ws10=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfX1XCNtDtItBgr
 tA6/FWsxyMOf1fhHNH77BHf0LIeWUQZT7biZl2GFfBms6mN+y5VmB7svar4u/K56vm0pdBP6xWJ
 SdK6cTaYXQRdHZX7zKoHj4UQHyTqleETLVDLE+A3+OsfBxRjzoYNviu+QB9oB5RQeYx8Eb67ZOE
 LJCkKl14OtVsaRvG75nMiJ5WnW7CwnTY+DGMm+jfBLQJjySF8SPXOjaHdG/BVU0icDDMiyLQ2BR
 P3GDEpxRTxaj28Z6hx5R7tUQRGiLb8jmndc5DIxoUqUsIv/dYCKvDsuH6bO/bs6WdEgVoHvP5hy
 WyqVP8OYTpamiMV5Dqhmd8rswMyLuNZgf7ETVpm9zM4JQktOlxSyMtDShkXXRgV+AW+dzr3PhbA
 Q6aavaMHPqx1mwSIsw0BXNUFDtGJXjZdU83rKcGdQc+cfZ9knMJuoG/hhXizBDsBLCpVDjZLRap
 nDeejAnpLeRrVCy1aPA==
X-Proofpoint-ORIG-GUID: OBshQnc35fI2wu9my7M5ds6vQPZ52naU
X-Authority-Analysis: v=2.4 cv=bJEm5v+Z c=1 sm=1 tr=0 ts=6a57f18c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=74QsV7IkigCJGj90HksA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: OBshQnc35fI2wu9my7M5ds6vQPZ52naU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01

Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
requester mode without reaching into pci_dev internals.

Add pcie_tph_completer_type() so drivers that publish TPH metadata for a
device acting as a completer can gate on the "TPH Completer Supported"
field of Device Capabilities 2 (bits 13:12, PCI_EXP_DEVCAP2_TPH_COMP_MASK=
)
rather than reusing requester-side state. It reuses the same reserved-
encoding fold as get_rp_completer_type() so the completer decode stays in
one place.

This keeps pci_dev::tph_req_type and the completer-capability decode
inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c       | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index ebe1aa5ba5eb..64a6e1da99dc 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -230,6 +230,45 @@ static u8 get_rp_completer_type(struct pci_dev *pdev=
)
 						 reg));
 }
=20
+/**
+ * pcie_tph_enabled_req_type - Return the device's enabled TPH requester=
 type
+ * @pdev: PCI device to query
+ *
+ * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_=
TPH.
+ */
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{
+	return pdev->tph_req_type;
+}
+EXPORT_SYMBOL(pcie_tph_enabled_req_type);
+
+/**
+ * pcie_tph_completer_type - Return the device's TPH Completer support
+ * @pdev: PCI device to query
+ *
+ * Reads the "TPH Completer Supported" field (bits 13:12) of Device
+ * Capabilities 2. The reserved 0b10 encoding is folded into
+ * "not supported" so callers only need to compare against the three
+ * defined values.
+ *
+ * Return: one of %PCI_EXP_DEVCAP2_TPH_COMP_NONE,
+ *         %PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY or
+ *         %PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH.
+ */
+u8 pcie_tph_completer_type(struct pci_dev *pdev)
+{
+	u32 reg;
+
+	if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+	if (PCI_POSSIBLE_ERROR(reg))
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+
+	return tph_completer_type_fold(FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK,
+						 reg));
+}
+EXPORT_SYMBOL(pcie_tph_completer_type);
+
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
 static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 ta=
g)
 {
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..7743af6fe432 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,6 +9,8 @@
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
=20
+#include <linux/pci_regs.h>
+
 /*
  * According to the ECN for PCI Firmware Spec, Steering Tag can be diffe=
rent
  * depending on the memory type: Volatile Memory or Persistent Memory. W=
hen a
@@ -30,6 +32,8 @@ void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
+u8 pcie_tph_completer_type(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -41,6 +45,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *=
dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{ return PCI_TPH_REQ_DISABLE; }
+static inline u8 pcie_tph_completer_type(struct pci_dev *pdev)
+{ return PCI_EXP_DEVCAP2_TPH_COMP_NONE; }
 #endif
=20
 #endif /* LINUX_PCI_TPH_H */
--=20
2.53.0-Meta

