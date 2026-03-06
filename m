Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E386344D90;
	Fri,  6 Mar 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789142; cv=fail; b=aIf5zuT4/+94FzQSyh1t3c/PqDvnP+nY0k0wS7kax1uLleyYOqbUDD7M+GXvqBXQ1vQBzTQfx+KeKrVfoenLVnnNhsQn1LZu4f5HGWHvHrlRQStnHontImV0u8bZqGL9YlBEi+RaL66YBkkJz8T0LFW5MoiN+g4CV6sPmRuYH90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789142; c=relaxed/simple;
	bh=X5sIhf+e3ZjLRXa1130XvI/INBYR87xDVkvIUIeZTWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtDJ0HfpEgI714fmsAtpUkMDJ4vJ+g8LTNtB7rinkn0fSh+0qCMdPipAhX7rWERROgqSPqWW8zh3eK60KGf/XK05FhyJV3O05irjQ9lRjbCcVzdBySRzc3LTPIOFe6B5BbXWSWGcNoDApUb/Mp7f36jRMKl6kB/4i4E7NqSorAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOsOLgMQ; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOsOLgMQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmAHeekWtUCuP4+tSEot0AZC/LxHr0odzpeBIdATzitq/l4uFabMUDGCwZT7v43c6FiLE7qA+YqqBW4dtF2mgquu04FTxS8HxEOamARUJUA12TUOt6iqkr+zVlRXfOnBR6zuVV04zS9/D/nGOwB1dFKQ/HZa5eZNaT62vp8Iw7m/8YuHI8cbavKxDv3pPVDf/1+MJ5UEL+YBv1RXUX76tVEG9CGVFwfmresVL40RwM3Zt4PdDCtT+hd7qgolRLh1CRjnksJS7ueh1q+8UyeyQtwY85kVT1LjKki+IWs084CemDR/UTzvawzSdk8kRobAL7n65jIp29ps0yYY8L5DLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmXr85LV5cChAmOgugBADGJnMPhHC6PPxaxli4+H9tM=;
 b=P9FwQhToFneLQZMo6Y8SDTmzc6oimWShgpf/pAA3QK3plyasgaklSmH6QjJ/gL4pgewLyOIFsT4Y+xy3Dac9u7N8uW/MdlhmHBJpxi4KugLmAuVJJ4T1G5cp9ym5CmG0nIFd7+iVo2lAMYuR7/BMvlQtcY58IhZO4aH3HZF9dPYsK1hIwFkMpeo6ue184F1eXCGZ19b1lwuSJ8mmZyhgwpWO4rFQiBpmoQNwfJxeM+ceq3N0BqzYmbtshZRJLSW7MBCP1dZpDQhbWv73xxf0wGuoKBIHCjlARwJBZPsmUoOeywRSpDWLW72rnOBcS8T4bgqkU/ZfameR11b3nzqC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmXr85LV5cChAmOgugBADGJnMPhHC6PPxaxli4+H9tM=;
 b=FOsOLgMQdon9g5PGMkFvKiSGuFucoiT0BTL+W0LgBYGTaVA7cdgLVy7kFnrcRMDsQfnDfoysDwf2NWZU38ZGO80cmCzyReElaGF4yVZzuldfIYEQTZiozSJT5QPM4GCKWxb6Ob1z7c+7oI3hCHKq8qZWEUJwrqbTYaxenHOo46OKSOXS1m84GNExlzI+9kShy/ZBf00qKSQTUFde71/KRH63UtaRK+lZcXAGPE1aS3Ylb/gULG39IlPq0OZQjKosbkBx8c2EFyZErfDKFY9uC8hGFB8YuPGL4fBxJ0pWKqt8f3zgcDZoX/e6Yu2hOuzTzTQrkSjW7mYqsnMi+bHKcA==
Received: from SN7PR04CA0102.namprd04.prod.outlook.com (2603:10b6:806:122::17)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 09:24:22 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::76) by SN7PR04CA0102.outlook.office365.com
 (2603:10b6:806:122::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 09:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:24:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:57 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:56 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 6 Mar 2026 01:23:55 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH v5 5/7] cxl: Add CXL DVSEC reset sequence and flow orchestration
Date: Fri, 6 Mar 2026 09:23:20 +0000
Message-ID: <20260306092322.148765-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306092322.148765-1-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 865ac75f-b835-4b92-5455-08de7b6226b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	uh9w80WpCl7UUo0VpqbSUu1tPfU/j4Ni8a1FKKz4teo7j5NPEtm/rkL9hjuNqn5sbA7e0xSmyDjf06vJiNe0tWr3/ern6ItCDDOuZFgOqOuOh6Xo6b1n3LIG3UoVbCkU33ayCv2AROaFm5wcckGJzRRcyAMBWTJ8+n78NCgiR6KQghs52Swrikyk+WsV3ta0tBpVC5bIjWtjJ0hfBpGC2wgPTRKnxrvNBH6UZtq59n2Bp1BZuoyPTle9vXX3+GV20rGOKJrnge24hkil5uXPJAmf9tFHjp2XN+cszlJG+k+eeuDMBC8+TukVaj3lc2mtIdl001QY1LXn0XZkd+RdbS3aXbThT2r8I7U+oS3VfNDot3R7NQoXfjpEPEUzf8AB/0VGXWiEVrwwCIvETZpgs+CPotKkda+NaItd8bR7NJD6SoT/MxdZubm3CSfHjubFM5gfUtuHAKX0BmVFQm6rgCWrPJdImNv2qv7BLXCxLrTed4ZQYZjcfUrJNjFIzWvceHTxJLSf3w7ovrvcVs8Rl9wtyY4lULuCMdooWagebHsR+m/U1nbNgLPxNXBNLZHl3XmN8+q+VIMWv8993LlPNt1nEOigJfw6HgGp1kI7Q2wArTPL68pLKXBl6qONmIY/lfJ6fKok1uBUWVPYbMjd5aFtlb5Ac841QUilIyBlbHpEr5wSWNFAXlRGtbNfRaRYQkDYoS+QG20MSpd8IOaIRNli2/s+je/khZAQnEkWx8V/jccq2MDGmYhH0RXtUwNYCeGidzxRy8DfltNuCC3Neg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uvuGuuAqDPcvLUOt387XR3TnT/IsBX79uwGV9bJDHZyWTGmSQlNSCR8OWrdvTshIjZdydhZmJgCjx2ZrRf6Z2OZJx4+Y7FlpM5Qbk5ymOq4d2mun5sGwYLTnKcP9+28y1wpIjrOdE621IIOPo5LS6sUYehqTU61Aa2b7qPky5HmMmjnDVjjMhLAzgWHb63oRInM5a8CkX16AV0gRumSFKDWm8uctC3UuNF6uie7RrCc/vTZEL8CDxBaSfpgLzqWhgOB/tot3hHz3Hu2Wq2I8wN+favJqpa70DSc6pnO4x0PtcIvHhdUwl/6QJj13hHFISk77BdVZ2PqXdlQ7UgOgYAed1BMI8F4bkXAjw5VzWrK2RwGVPqfqDt8cv6fRK7RfXQH6URh/fG2FubHL5NBZhn5ztrqIqG7AablwTDfLI2FUl2CYN96kTUwhOiwq/7kv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:24:21.6463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865ac75f-b835-4b92-5455-08de7b6226b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

From: Srirangan Madhavan <smadhavan@nvidia.com>

cxl_dev_reset() implements the hardware reset sequence:
optionally enable memory clear, initiate reset via
CTRL2, wait for completion, and re-enable caching.

cxl_do_reset() orchestrates the full reset flow:
  1. CXL pre-reset: mem offlining and cache flush (when memdev present)
  2. PCI save/disable: pci_dev_save_and_disable() automatically saves
     CXL DVSEC and HDM decoder state via PCI core hooks
  3. Sibling coordination: save/disable CXL.cachemem sibling functions
  4. Execute CXL DVSEC reset
  5. Sibling restore: always runs to re-enable sibling functions
  6. PCI restore: pci_dev_restore() automatically restores CXL state

The CXL-specific DVSEC and HDM save/restore is handled
by the PCI core's CXL save/restore infrastructure (drivers/pci/cxl.c).

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c | 181 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b6f10a2cb404..c758b3f1b3f9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1078,7 +1078,7 @@ static int cxl_reset_collect_sibling(struct pci_dev *func, void *data)
 	return 0;
 }

-static void __maybe_unused cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
+static void cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
 {
 	struct pci_dev *pdev = ctx->target;
 	struct cxl_reset_walk_ctx wctx;
@@ -1103,7 +1103,7 @@ static void __maybe_unused cxl_pci_functions_reset_prepare(struct cxl_reset_cont
 	}
 }

-static void __maybe_unused cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
+static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
 {
 	int i;

@@ -1116,3 +1116,180 @@ static void __maybe_unused cxl_pci_functions_reset_done(struct cxl_reset_context
 	ctx->pci_functions = NULL;
 	ctx->pci_func_count = 0;
 }
+
+/*
+ * CXL device reset execution
+ */
+static int cxl_dev_reset(struct pci_dev *pdev, int dvsec)
+{
+	static const u32 reset_timeout_ms[] = { 10, 100, 1000, 10000, 100000 };
+	u16 cap, ctrl2, status2;
+	u32 timeout_ms;
+	int rc, idx;
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return rc;
+
+	/*
+	 * Disable caching and initiate cache writeback+invalidation if the
+	 * device supports it. Poll for completion.
+	 * Per CXL r3.2 section 9.6, software may use the cache size from
+	 * DVSEC CXL Capability2 to compute a suitable timeout; we use a
+	 * default of 10ms.
+	 */
+	if (cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE) {
+		u32 wbi_poll_us = 100;
+		s32 wbi_remaining_us = 10000;
+
+		ctrl2 |= PCI_DVSEC_CXL_DISABLE_CACHING;
+		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+					   ctrl2);
+		if (rc)
+			return rc;
+
+		ctrl2 |= PCI_DVSEC_CXL_INIT_CACHE_WBI;
+		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+					   ctrl2);
+		if (rc)
+			return rc;
+
+		do {
+			usleep_range(wbi_poll_us, wbi_poll_us + 1);
+			wbi_remaining_us -= wbi_poll_us;
+			rc = pci_read_config_word(pdev,
+						  dvsec + PCI_DVSEC_CXL_STATUS2,
+						  &status2);
+			if (rc)
+				return rc;
+		} while (!(status2 & PCI_DVSEC_CXL_CACHE_INV) &&
+			 wbi_remaining_us > 0);
+
+		if (!(status2 & PCI_DVSEC_CXL_CACHE_INV)) {
+			pci_err(pdev, "CXL cache WB+I timed out\n");
+			return -ETIMEDOUT;
+		}
+	} else if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) {
+		ctrl2 |= PCI_DVSEC_CXL_DISABLE_CACHING;
+		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+					   ctrl2);
+		if (rc)
+			return rc;
+	}
+
+	if (cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE) {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+					  &ctrl2);
+		if (rc)
+			return rc;
+
+		ctrl2 |= PCI_DVSEC_CXL_RST_MEM_CLR_EN;
+		rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+					   ctrl2);
+		if (rc)
+			return rc;
+	}
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(reset_timeout_ms))
+		idx = ARRAY_SIZE(reset_timeout_ms) - 1;
+	timeout_ms = reset_timeout_ms[idx];
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 |= PCI_DVSEC_CXL_INIT_CXL_RST;
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return rc;
+
+	msleep(timeout_ms);
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+				  &status2);
+	if (rc)
+		return rc;
+
+	if (status2 & PCI_DVSEC_CXL_RST_ERR) {
+		pci_err(pdev, "CXL reset error\n");
+		return -EIO;
+	}
+
+	if (!(status2 & PCI_DVSEC_CXL_RST_DONE)) {
+		pci_err(pdev, "CXL reset timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 &= ~PCI_DVSEC_CXL_DISABLE_CACHING;
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int match_memdev_by_parent(struct device *dev, const void *parent)
+{
+	return is_cxl_memdev(dev) && dev->parent == parent;
+}
+
+static int cxl_do_reset(struct pci_dev *pdev)
+{
+	struct cxl_reset_context ctx = { .target = pdev };
+	struct cxl_memdev *cxlmd = NULL;
+	struct device *memdev = NULL;
+	int dvsec, rc;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENODEV;
+
+	memdev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
+				 match_memdev_by_parent);
+	if (memdev) {
+		cxlmd = to_cxl_memdev(memdev);
+		guard(device)(&cxlmd->dev);
+	}
+
+	mutex_lock(&cxl_reset_mutex);
+	pci_dev_lock(pdev);
+
+	if (cxlmd) {
+		rc = cxl_reset_prepare_memdev(cxlmd);
+		if (rc)
+			goto out_unlock;
+
+		cxl_reset_flush_cpu_caches(cxlmd);
+	}
+
+	pci_dev_save_and_disable(pdev);
+	cxl_pci_functions_reset_prepare(&ctx);
+
+	rc = cxl_dev_reset(pdev, dvsec);
+
+	cxl_pci_functions_reset_done(&ctx);
+
+	pci_dev_restore(pdev);
+
+out_unlock:
+	pci_dev_unlock(pdev);
+	mutex_unlock(&cxl_reset_mutex);
+
+	if (memdev)
+		put_device(memdev);
+
+	return rc;
+}
--
2.43.0

