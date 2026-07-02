Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3133A6B8F
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016171; cv=none; b=o7uLCQbXOXvwzvvmw4ydmYeNsedJk5RYQJdwtq10fmeY1HuaxfZ4noOD55RbKf3R8d2KaRCXyWzJ52niWiB26DB3/5+gczkcBIeBhTSoyLypSTWB2hnt6IYphD3UOvYZloB+rzjwEZppPkQ/GhDOR2R/NBmdcxD4Uz3w5fCryIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016171; c=relaxed/simple;
	bh=bbG6+QmFVNP/YnoXzRENXF3/gCL3vZIFeEY5nqrNto4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwyHqJrhUNgxT2Be0VXzUVlcO5EDbmzjDZvOOaWctyImvhXYMp/OPtZiLsh5Q4MeCf0kSVh23HL5pezM8LX/QZEWG8RSc7EhXSjQc8rnQOU+ajC9mtav0USRrSpmQ9dN1HQsSDtbzThZNVwQkMuHL1tPutnGlkaBcHP01cexcZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dl7D7WYL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dl7D7WYL"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662GoDSX3664291
	for <linux-pci@vger.kernel.org>; Thu, 2 Jul 2026 11:16:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=EI1AQGcRtMowZGpULfpK0Vp641YsGLWv8U+k3zFxilw=; b=dl7D7WYLqLnU
	gNg2XM22oxYPHYVdLA5lo7a1Uh2JqqIwIqo63A8AbF7vz4keyFc+DEu48Biqa7Jm
	Pv7RtxxBnR45GOi2XLR/9Gwi9I/+DKXpESNwT6TnAe/RWyOHLKzouXQZrqusYwGo
	SONasQwbtqOkdOlL9UeyG3LQKWpJCwDvr3ZbVGOj1NIBNBJZxSBNQPh7xf4fMH9j
	iLkxqWsZAdYAzsfPkAhL943XMGUo6RktPLUFxQCUEoeB2b/Yis8t+i5B0qmfEjoX
	J3Dt0hNP6C9WHayyekBwfOcWwuOtXpEXILRG7WWppIe0+F/L/0hSK38ARtBeirZ6
	aAAMucMbUg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f55rea91d-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 11:16:09 -0700 (PDT)
Received: from twshared96086.14.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 2 Jul 2026 18:16:03 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id DAEDA40EEE79A; Thu,  2 Jul 2026 11:10:26 -0700 (PDT)
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
Subject: [PATCH v11 1/4] PCI/TPH: Add requester/completer type helpers
Date: Thu, 2 Jul 2026 11:10:14 -0700
Message-ID: <20260702181025.2694961-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260702181025.2694961-1-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE5MSBTYWx0ZWRfX0pPa2LMX6c2k
 OcKTcZkDGOJfKEIjBkKhl85BGp+pBoj27L0JSlrZL4MWLK2+RFGPtE9aqABiWkR+RbWmODWtNza
 SvS6vkN0agsfAOGE/RWaQZfr7bTJgnRI5KgU6qmf1N22O260kPM5SF7uKxCAX02zeec3k+bTM0D
 LCVL6YYxggjPeWghQghKGmZaMuaJ9b9Xx5xU0IUd8JDoq9up7iNe1v3zxaaG9i1Sgc9xDumB7UW
 6IQHM/X0MmnKu1pMaDxxlnKK/mdTrz6QAH2Uoy+BbVhmAVrCh3wi/zAaz9fjMglYfEWfOWx6Vz4
 efo0IHOEjho1naSK8xBQ7rC4GCZN2XL4kxdDmw45MRop9nQcdX24weqbprcfX0tyoNhp+Bi96Gd
 IBkiRBTwLEjtylFFnpp4DERaJsvdnW+JmcXfHAsFTkurrJvE4JLTfkc1FNMBZjwf3BTRE1IKtNe
 o9hcs94E22Sh7p3MVhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE5MSBTYWx0ZWRfXzeukCBQvNDRo
 l07w9kSg6HxW98yPfoETnyNTRqxGf338wa5XkEibuXSngyTLaf4oQhlR0gXCxXrB/QV1I7gQ6qx
 woLKzQ08YAfjKKrGkdmk1pSxA8dlXlM=
X-Authority-Analysis: v=2.4 cv=H6rrBeYi c=1 sm=1 tr=0 ts=6a46aae9 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8 a=K7z10gKaAp536EQdUv4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: JnMKxBWSG5U1UxlOfN3as0HtrIus_dQJ
X-Proofpoint-ORIG-GUID: JnMKxBWSG5U1UxlOfN3as0HtrIus_dQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01

Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
requester mode without reaching into pci_dev internals.

Add pcie_tph_completer_type() so drivers that publish TPH metadata for
a device acting as a completer can gate on the "TPH Completer
Supported" field of Device Capabilities 2 (bits 13:12,
PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
state. Fold the reserved 0b10 encoding into NONE so callers only see
the defined values.

This keeps pci_dev::tph_req_type and the completer-capability decode
inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
callers.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c       | 45 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  8 ++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..e7693fd9d676 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -173,6 +173,51 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
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
+	switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
+	case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
+		return PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY;
+	case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
+		return PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH;
+	default:
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+	}
+}
+EXPORT_SYMBOL(pcie_tph_completer_type);
+
 /*
  * Return the size of ST table. If ST table is not in TPH Requester Exte=
nded
  * Capability space, return 0. Otherwise return the ST Table Size + 1.
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

