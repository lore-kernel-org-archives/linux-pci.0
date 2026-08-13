Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3B449EB2;
	Thu, 13 Aug 2026 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614023; cv=fail; b=V8UTK0FzfSqwAd1DtAMbKotPUks3qLslCgD2hb9+W0PJSovNuVm5ittuD9Bq3ccbLuawE35XSN/LMkmuhlmx2qtYxXSsKl/mrjNpPnShn/ZOBUze6LR1K577Zmhjz2dal6rr2oT48LP7ckjJ5plGzNtIjKpQVvZ4c5lIjLE3g/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614023; c=relaxed/simple;
	bh=/kzl+6hNDuOo+W8bi/DacYmU0NvrzP4rivcQD4v02hY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwFWvUnmwuIrIuOxSgykJkl3HYnOt+rk1mAaHeIyli1lL8w8ltHpIypoGBdUOmWEpRHTcD9GTGqXMmv5KEaDATT5l27R7oRI/HxUbhmvRc4KOCWA91bbCrXKoVlZMRIYIKCcQUxnyBCd+f5GEWHyk98Ps8VIACjyg3f9gova6TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FPKZKi1t; arc=fail smtp.client-ip=40.107.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FPKZKi1t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brCKqy75ZXfCdqlI0ECyaqB+Kbgx0j/80taF8EQOtu63vC9NrF+R3/pWt6U2/Oz/40dWit2K4JlsCE66y1lb81g48dFkBHTwoQLkn6AE0akxTOl8Y02C8Ji5FiZ8mghDV/EjdecDLEDIQY7NvEAjJ7CcNan6XHLXEl/urRv4mRYMJQncVAJn/UzGtn+sKRVfbhxTVef0nSpg9yjeWy2haDsmHkv6cEkxtxk2BVFoCefab9h6XSLZlG5S38Au5jqL/Ng94MhIcQB52iPQkHkQJqf4ckhKpF8p6aOsvwoKNRNZn7NiIcereWa6+pfIKLONTkmQz7ybre1NR+N/m7Eb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBG80J9eCR0ceJ+k773FPj/NeLfXmpQ2ZNUdlrqShI4=;
 b=ubRgpTHZwaJHl3pU0qgS2cSwLEDyVmZLm7m62mVo+6PSXGLVCBz4rD2PXK0a81v7/yT0SZnWgZ0SHmuM3jU+2ZBaHa04R/6Ld3ib5ETtSc4xV0UWX3wQ3AdhfHO14rfQ9PszTCusu+4idJ+M2Cbwrko3l9YpOW+WLywIO1HwQ53vWv7BzyFA6SKEEWEFlrmCROrCMLeCdq1+RlwvVTd9fcEgqJeI/ENNUgCoogQuB9ylw4eG74T+tY+TFtMkhVQRd3TzyjmMCbXH+vTmDvunrRftXOsrTbHtMpaq5Yz25EM8SbA2rPh5PtLzn4+s258IKOnA9LdcqgoIXUxzt4R1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBG80J9eCR0ceJ+k773FPj/NeLfXmpQ2ZNUdlrqShI4=;
 b=FPKZKi1tMiso33wDlt6xXB31TCht2G5vUIVNTzK2RefqQEliY1k0fEodVFKX7NHxgcoBfWT8haL5ACzpWtlPhzr7nqy5xVZhsG92LJtBkqn/fzZqZqo88dE/cVwWrQTT/DYxw/st6NrePM92aAkwskisaEdsSeTxPCiasnvKx1Xd7/MhAWleFAY8GrMV1FIqubM55/brNXL65+moE5cHhANXC3kzbe+mXwWx4q+deqF2VGU56E6xVeOsRSDcaFHen9EWWxugh9pywrjUcTScTiZoLTbXZn5g3y8Rcm/IzLsawETDJroAZKm2znv0YRGltX2TGG4YwPL5pQrY+9o16w==
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:40:13 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::8c) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:40:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:39:53 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:39:43 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v4 17/27] vfio/cxl: Virtualize the CXL DVSEC
Date: Thu, 13 Aug 2026 15:06:21 +0530
Message-ID: <20260813093631.2288172-18-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e5468d-1bc6-4642-d500-08def91edfde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|82310400026|1800799024|921020|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Gg8NTPxcdp1AxPnWdhOB4yaXdjJts40owFlbLKEKBhFcsFxRZWQhu8QUfQQx1yNWeL6xblqYcndxA+/pklOiiO0wjVV/D/ljQaIN5Ko1D1Otyhv9qR8lkTsO0dMXy35um9t/YEaPbg+UXG0DI1/MLOOQ/x7pqYDprogsKQQkKAvFcrqvATRxFxbZwQ1m2hOkEV3We7BLaTyI66Hs7OpXugs7PzKuioTEyhJp3cL8Dlaqgf5Kl0gtqCuhSYCuywRWwmjmcExBVPFMvfv80CR4FIJGzA+b/rUNO+fLgDsG5y7hkmOMzNi/JQE9Q4y17e2kaiLZe9ZZdh+Q2uyy253NJiQtzL1C43gVl20YyG/6XQReIdB8fRXRSD0oNeIhe65uCeG+178MCtfD2YebxOPU0z366AmS9xqdmfxQ3QzdBmK5h+bPI8TQ8+aryFlgLTV0jjWN98OH3Dph+o4j+R2iq2fisjtoPyaOd790JMyzzuh9KRJe9CgBN6K8K8tpzeykJfkORxc2BBrrHypw/lwYtuYiJWBwZQM67jSuq0XjHuFqIBPV544+JZYolI2npiBzgdgrEGzRbmQ4RSuVC1CbuDhr+HYkaNxVJk7yKlGKUwPXojK3ux6W7eLptH/ivusaDhCaEfJORp54p0xwhPYbpe2HcUjAi50du4mZrH8GIfZowH/BJFkKWVNXBQeZXPpSj1sbTxzP+KtVO+NQWwqH7Bfz6M+roTclbJbfbB6NMvIK6pgeJq1up9VnX6eQDaBt
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(82310400026)(1800799024)(921020)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QiVPZ0+LYbeGqcBqcivOREYZWl0GhDnswfCB3iqKx94RBe2p6vj6B//ZcAoOPNhyGCB//5p9YeTavV61y9vYvibf9AstZhJcSllNo3F4zoUlbRSED5vzD79y/AP+U5jFzg8ZeeukJbWWRFMYQa43pTWe4Gllt7NUuNvJPpRbRLSEDltOJ2kpi/DmXNfRdiCg76mQNuDwja9fO+zbauK9go2M78DBjzFgK1b5B04IsRZt0wTGzMrvfQFdbdIy8nFlv3K8HbzRjkG53RAsrVgn6m2lceKC//lvYW6sUWlPdHG9PIrBK5y+XJw1QHhHsxndvxqkVAAQNsZVpKI0UuDmp1Lnw2WzVl0ROiHhTxNct4GibAI+VLPy4cYMi4nJJkR8RViM3tL1EHZlbqdUWT91sKaOZP9vkzdZZVsuDaoJJidlRlUMY6UEzBIRxcrGw5aV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:40:13.1589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e5468d-1bc6-4642-d500-08def91edfde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

From: Manish Honap <mhonap@nvidia.com>

Serve reads of the CXL DVSEC body from the per-open shadow and keep guest
writes in the shadow rather than letting them reach the hardware, so a
guest cannot reprogram the device through the DVSEC. Accesses outside the
CXL DVSEC return -ENODEV and take the default DVSEC handling, so a device
that also exposes a vendor DVSEC is unaffected.

Route each shadow write through the CXL r4.0 field class rather than
storing it verbatim: Control stays programmable, Status is
write-1-to-clear, and Capability, Lock and the Range registers keep their
firmware snapshot. The guest can no longer set Config Lock or scribble the
capability and range fields.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 88 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_config.c   | 36 +++++++++++-
 include/linux/vfio_pci_core.h        |  5 ++
 include/uapi/linux/pci_regs.h        |  1 +
 4 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 2e516a0929c6..9fed909cb9d3 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -148,11 +148,99 @@ static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
 	cxl->dvsec_shadow = NULL;
 }
 
+/* Read a 16-bit DVSEC field from the shadow; @off is DVSEC-relative. */
+static u16 vfio_cxl_dvsec16(struct vfio_cxl_state *cxl, u32 off)
+{
+	u32 dw = cxl->dvsec_shadow[off / sizeof(u32)];
+
+	return (dw >> (8 * (off % sizeof(u32)))) & 0xffff;
+}
+
+/*
+ * Apply the CXL r4.0 8.1.3 write class for the 16-bit DVSEC register at @off.
+ * Control is programmable, Status is write-1-to-clear, and Capability, Lock and
+ * the Range registers stay fixed at their firmware snapshot.
+ */
+static u16 vfio_cxl_dvsec_field(u32 off, u16 old, u16 wval, u16 wmask)
+{
+	switch (off) {
+	case PCI_DVSEC_CXL_CTRL:
+		/*
+		 * CXL.mem stays enabled for as long as the guest owns the device.
+		 * The HDM decoder maps the guest window to device memory, so a
+		 * store to it while CXL.mem is disabled completes on the device as
+		 * an error that the host fabric reports as an SError, which is
+		 * fatal. The spec does not pin down accesses to a decoder whose
+		 * CXL.mem is off and many hosts SError, so ignore a guest request
+		 * to clear the enable and keep the bit set.
+		 */
+		return ((old & ~wmask) | (wval & wmask)) | PCI_DVSEC_CXL_MEM_ENABLE;
+	case PCI_DVSEC_CXL_CTRL2:
+		return (old & ~wmask) | (wval & wmask);
+	case PCI_DVSEC_CXL_STATUS:
+	case PCI_DVSEC_CXL_STATUS2:
+		return old & ~(wval & wmask);
+	default:
+		return old;
+	}
+}
+
+/* Config accesses never cross a dword, so a single shadow entry covers them. */
+static int vfio_cxl_config_read(struct vfio_pci_core_device *vdev, int pos,
+				int count, __le32 *val)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	int boff = (pos - cxl->dvsec) % sizeof(u32);
+	__le32 dword;
+
+	if (pos < cxl->dvsec || pos >= cxl->dvsec + cxl->dvsec_len)
+		return -ENODEV;
+
+	dword = cpu_to_le32(cxl->dvsec_shadow[(pos - cxl->dvsec) / sizeof(u32)]);
+	memcpy(val, (u8 *)&dword + boff, count);
+
+	return count;
+}
+
+static int vfio_cxl_config_write(struct vfio_pci_core_device *vdev, int pos,
+				 int count, __le32 val)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	int idx = (pos - cxl->dvsec) / sizeof(u32);
+	int boff = (pos - cxl->dvsec) % sizeof(u32);
+	u32 off = idx * sizeof(u32);
+	__le32 le_wval = 0, le_wmask = 0;
+	u32 old, wval, wmask;
+	u16 lo, hi;
+
+	if (pos < cxl->dvsec || pos >= cxl->dvsec + cxl->dvsec_len)
+		return -ENODEV;
+
+	/*
+	 * Place the guest bytes and a matching byte mask at the write offset,
+	 * then let the per-field class decide what actually lands in the shadow.
+	 * The hardware is never touched.
+	 */
+	memcpy((u8 *)&le_wval + boff, &val, count);
+	memset((u8 *)&le_wmask + boff, 0xff, count);
+	old = cxl->dvsec_shadow[idx];
+	wval = le32_to_cpu(le_wval);
+	wmask = le32_to_cpu(le_wmask);
+
+	lo = vfio_cxl_dvsec_field(off, old, wval, wmask);
+	hi = vfio_cxl_dvsec_field(off + 2, old >> 16, wval >> 16, wmask >> 16);
+	cxl->dvsec_shadow[idx] = lo | ((u32)hi << 16);
+
+	return count;
+}
+
 static const struct vfio_cxl_ops vfio_cxl_ops = {
 	.init_device	= vfio_cxl_init_device,
 	.release_device	= vfio_cxl_release_device,
 	.open_device	= vfio_cxl_open_device,
 	.close_device	= vfio_cxl_close_device,
+	.config_read	= vfio_cxl_config_read,
+	.config_write	= vfio_cxl_config_write,
 	.owner		= THIS_MODULE,
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..f088e4ce5e07 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1102,6 +1102,39 @@ void vfio_pci_uninit_perm_bits(void)
 	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
 }
 
+/*
+ * DVSEC accesses are dispatched to vfio-cxl for a CXL device. It handles the
+ * CXL DVSEC and returns -ENODEV for any other DVSEC, for which the default
+ * handling then applies.
+ */
+static int vfio_pci_dvsec_config_read(struct vfio_pci_core_device *vdev, int pos,
+				      int count, struct perm_bits *perm,
+				      int offset, __le32 *val)
+{
+	if (vdev->cxl_ops && vdev->cxl_ops->config_read) {
+		int ret = vdev->cxl_ops->config_read(vdev, pos, count, val);
+
+		if (ret != -ENODEV)
+			return ret;
+	}
+
+	return vfio_direct_config_read(vdev, pos, count, perm, offset, val);
+}
+
+static int vfio_pci_dvsec_config_write(struct vfio_pci_core_device *vdev,
+				       int pos, int count, struct perm_bits *perm,
+				       int offset, __le32 val)
+{
+	if (vdev->cxl_ops && vdev->cxl_ops->config_write) {
+		int ret = vdev->cxl_ops->config_write(vdev, pos, count, val);
+
+		if (ret != -ENODEV)
+			return ret;
+	}
+
+	return vfio_raw_config_write(vdev, pos, count, perm, offset, val);
+}
+
 int __init vfio_pci_init_perm_bits(void)
 {
 	int ret;
@@ -1121,7 +1154,8 @@ int __init vfio_pci_init_perm_bits(void)
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
-	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
+	ecap_perms[PCI_EXT_CAP_ID_DVSEC].readfn = vfio_pci_dvsec_config_read;
+	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_pci_dvsec_config_write;
 
 	if (ret)
 		vfio_pci_uninit_perm_bits();
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 7354dae1dd85..b9202cb29d96 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -72,6 +72,11 @@ struct vfio_cxl_ops {
 	void	(*release_device)(struct vfio_pci_core_device *vdev);
 	int     (*open_device)(struct vfio_pci_core_device *vdev);
 	void    (*close_device)(struct vfio_pci_core_device *vdev);
+	int     (*config_read)(struct vfio_pci_core_device *vdev, int pos,
+			       int count, __le32 *val);
+	int     (*config_write)(struct vfio_pci_core_device *vdev, int pos,
+				int count, __le32 val);
+
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
 };
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4f5942ebd29b..00ca1c777b44 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1359,6 +1359,7 @@
 #define  PCI_DVSEC_CXL_CTRL				0xC
 #define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_STATUS				0xE
 #define  PCI_DVSEC_CXL_CTRL2				0x10
 #define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
 #define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
-- 
2.25.1

