Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08D185B48
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196385; cv=none; b=PrsAeM+fTstBkaDkR2z6luU4KStSftHUte6z9D6LVmvjOo+tSWfnLK8FoysaRP6l00KJ97iLmoIqTijMaXJlUHjkTj3A6ESeWu9kc2flDruAzPhWuyMYzePHrgp4jIw8B07ZX40sNVZehY7OPcw/m9ecg3hTiaU8b2ZJUDYi1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196385; c=relaxed/simple;
	bh=IRWpB8GewnE2+G/U7l12XdCBveZfS+MSxwF2DEOaQw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGO3jb8laOCzacJ5ulLcy5qvMM8CdWnsAnmq0wbpe+Ej2qYiT+N9iFNdL9WsYgpPUsZ1Nak2ltsCHFoOevxDUqG0nLyXc95ChR6LXkXueMVrrsjwVWt6qMJLVI03HE+mpvUKy4lL+1OYfqiJb/a1wVuotqpY+U2LnwtEWkY75cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=J9/HX6yJ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="J9/HX6yJ"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BECju22241299
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 09:46:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=mjV1JPJZgyO6zER9smScw/osP/KPl9XPFLfl/CjHm9Q=; b=J9/HX6yJGmx+
	qRCncatR9S3BRifQzKGbAnEk5CG/EZYF8lH2wM8mUDhL9B6LGl0Ut2n5uXDvP1HF
	9KMk5yBsIf0eVkvffd60cZ55GoKOHWSoFQ1STEHxfxDoqMqne4OloBGSlNopONAG
	6oQ0g08BI48V2NYfGiLsRIZp7x55fWl/JnlOSV/e6Dg/lhzohqhT++taT/TETOr5
	2q508bxEYFnYgLFpMtFnrF0Gd79qWgHkSbmLHO1xveQXYC41718wp1lPgSDsrINe
	zNkT1A/wIWCDt4WRjgV/EAjCMcEwZIfyO+vxbfmmahHyqhLaogsgWptJ0obn70EP
	u81jzKQ8Jw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe81pqcy-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 09:46:23 -0700 (PDT)
Received: from twshared90953.15.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 11 Jun 2026 16:46:20 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id D4BB33DD3635A; Thu, 11 Jun 2026 09:23:40 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: <netdev@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
Date: Thu, 11 Jun 2026 09:11:17 -0700
Message-ID: <20260611161546.4075580-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611161546.4075580-1-zhipingz@meta.com>
References: <20260611161546.4075580-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=d8nFDxjE c=1 sm=1 tr=0 ts=6a2ae65f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8
 a=K7z10gKaAp536EQdUv4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: R5vDQpibLbsq37uT0r9ADYrw5ec6ER7a
X-Proofpoint-ORIG-GUID: R5vDQpibLbsq37uT0r9ADYrw5ec6ER7a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX8p0Z6WHkEXsC
 CrRYNm3ymEshROQXkD4QI6tJzbrY9exFPQ0SUxxnoOPJktIuxf1W5Kb+bemij8wxgUQAzRUK/F1
 ZuWJUFPejQct6BcJyXlmXHIGCpKisVg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX6fajntc1gbA1
 iUu7s33uOKS8KzP6elBRuOFryr7RCcBnjKqpQJevv6lMV3bM1fmhauXjRoOCFNeD6IHQxxhyy3o
 LWePkgM91L2k4bFDoha/z3fTFTsoHfwowu6tCLbm4ia/DbL0WvqPV3i9+KIQzWoThWHMbK0rPKd
 mMaNJWMx++tL3w4pNQX63Mbef47Bcui9JAZc0REQQpRIlhDGhAucfauKhyQI1P4cw8uLlY7UWHQ
 NnbqxKex6g48GCz3tbDfKUULgHkB6P9d7rfK9NEwlBrnaP3BXmwTl9SX77iJZdO+itGfMx+Sr0D
 Vk5tz7LDwu3wHf5Q+h1+eC9lqPdbBUt8h7tuz3PX3RKx0Dd3f8pSlRBsOjaU0uRrcrbCdtv8Z0m
 88N5T8W/Czklq8i7pow9BkOcvnJP2xyGPDOffgJf/DBdgodsutpDFY/IqucQ8QCpD+x9BqGGCo5
 Q/YsSnBKDfwILEoQkZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01

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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

---
 drivers/pci/tph.c       | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  8 ++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..4fe076bba953 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -174,6 +174,49 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
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

