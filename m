Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119889;
	b=pPoY3ixKa6fmmJ58r1K2ynVMf7JCUBZFxiMGirUQtu3cyZzNfJnFWRYXQsMyKGJqFX6O
	 cVmBRCDxfmOyNajucxpmW7ItRS3EWE0rbz/KVnLN2As3LNvpDGcxmb9VbJmbZbq/N5BHd
	 XjeE4K28+ZxcTdPGijOAAoWXid7/1J3L6/wmjEzQF5psnquCBZKWq2JIJRUtB+YfcV9uP
	 TvUrGLCh1OIUoZaPP9WmmrvXVgWnmKoKqFJxJAHvy6AVHWjt6EjgKAiyHfJxMoVEGBzH9
	 0+Ds2DV0Z/h8U6yPoB/cB9I+XD/IPQt1hcLqxsT+hzvX7zPH2y5goeP3MVCGDWGh/YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119889;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fMzlxWqutZaJ7/YU1mR8qrq53N9/UIVBx/lUwYACqlg=;
	b=jL8MsXhNUje7mhlaZcBDK+VaZkopgQijmF2rrYQlzbDEgvPCeje3cHgDSAv5WNKtxxBg
	 JvC9cVBSimml31ji+esn/6cGiAWlH+VXmk8teBGx+QnAyyMi2WFUfH5kicLGOCHICmyvE
	 w5+0UYIwYvGrPc2zLqdeSKlJ4KqnSPeV8heQ//wVRG+JMA4YAVOnc2SRSIMo7ByYa/jw+
	 Mqmu6HhAbApj8O8uyk8r5mbwnUwO2gpkSq7J53wozNmwKQ5qpPYAXm2SA0D1HUku8eW9n
	 WQtD3mCKw0hGc/gWJmdJ+JFv3SbXOTeG3Mtjhu9iK1nAkMssGDSvVteyZqmH6bBBoCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ReIxIFiy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.56
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14A606A326;
	Thu, 19 Nov 2026 20:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E14A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ReIxIFiy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkp6/hsdEIYgUMzFErTyQOK+8dUMKdrMq2NW3YuMjhbM97mK/0b0ZpKfr/cWDNC17LfZGKfvG5bufyoYY3ldy+XNOgiT8zuBi65LIMhn8iMtMMq/pPVEZqEzwNBstjd4vRWMP0e6nTeso+xJJZBq4CQQ9bAz2hFse34pU6n4P2ajXj0Rtq2s6yW1lRhbNhyH55zcEv4L2mVAjoeQmnLsG5PCeQZvtxTOYmMYVLr+1iVuCT97E5Urj/7C3tQwJz8rlwMTGZ3UINDcpwFIo2ItO16Jnj6hY5gFCbGNyxAPgXXkUs8V6X8sBOqRzH3Tf53bgt8axLCci5NY8eoTqTlaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMzlxWqutZaJ7/YU1mR8qrq53N9/UIVBx/lUwYACqlg=;
 b=NvOzaCd3SL8mzkLIRDD2uNYA+9AYHKe8qg6YHUVH5oUjt0jSnCc07sKgOcbcOiO/BjfnJjJLnuZDSdLP5LiNxm219GJGuu37ohqKSt2DhtYe3DJ9ED8GuwEirSb4ZptwdTBys+6eJlJxpSjlThBXlHumCssanP6WBebUbcoUNni7Jez/xccDCvqnOcfVe1xgRW6aXuYo5mPMrhmUC+gdq+BAPmMRkAZje9L9wAn7Hc+zo+fRbU58r+UoSpnp87kvmthFQGUl4vrPeGJuEt6+7fls/GLS/rOM1vwiVMxJDUgfpVHiFHSVSoOvLimSmKmlNQjgFB91RwpsLt9mmVq9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMzlxWqutZaJ7/YU1mR8qrq53N9/UIVBx/lUwYACqlg=;
 b=ReIxIFiyYr2MkDkDxznQD8xYLOcA8Sg4AMdbO4+KmTfh0dEWKGi4cVz7zvH9fVqtdayaC0HMv3uNOI6Ci9gZacc6WHYCVG2Zwn9uLLhO5DZb1xXSixG/TwjqKMuI22HBR0kYRBNI2gOA0iJBTT8eRGD/9EruiaG/tl+GmFPMCI8=
Received: from DM6PR02CA0132.namprd02.prod.outlook.com (2603:10b6:5:1b4::34)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:24:39 +0000
Received: from DM3PEPF000265B9.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::8) by DM6PR02CA0132.outlook.office365.com
 (2603:10b6:5:1b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:24:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B9.mail.protection.outlook.com (10.167.23.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:24:39 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:24:37 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 06/44] dmaengine: sdxi: support the full context table hierarchy
Date: Thu, 19 Nov 2026 14:22:42 -0600
Message-ID: <20261119202321.1734355-7-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B9:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc8dfab-41c2-40d2-7149-08df467b231d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|82310400026|376014|36860700016|6133799003|261009223027099003|18002099003|22082099003|261022075727099003|261026121527099003|261021123027099003|261021121427099003|261028144727099003|261022105027099003|261102123227099003|10067099003|56012099006|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mk4EPc6SNzEKCYDYLw1cQ0wfvQpCP2AvV5oUpESlhis2x1FC4Eqfmy5KzAqFWEZ4ZjnL5Uova/tU5YduOhap/z20ii6e2tp6n8Evy5nO5WuEwNBasCF5EbcPJVFVv2csjys/tyDYSgNWA1yDlRoXMEgZZtb/NkODAEk6eb61EsQpA9EtQWDHGnnKH3e+n/9psKGf/hDM3fv84ZZFnboJyjpSp6LLwjWyg68qVf1vVuV/Bet4nONHa8ikNToAVMtoO3p6HAvyM1gpy3XwHwXOG9cPRFkdpd3Iq/8n4fM2qNKa5s7wPMZ7KVLgeRoK1x5VLq4tNwncwxgF0pE6qL8ubMihe1URWYX/Yw1abt4j2Mx6tA6byINlkoGkr45cTPQnbhEy0+pOtOuciHQwVoMPEGj9+nK8YQcaL9fmPjGm/CFme/jdFktB601+Idsp0oqkjaA1kOU+QvxtPd4/RM3AnuQOKRwtsk2J8anMXvMRQ6MkPGcnTAkuSGaZ2+WpVTCX5xXbxYkK0rjiGktBYq3b0+bIlWOwYvJS4thxg2l71rbdvpFaOJzXy79Z1wWnPwuGQBu/OLDnvnZXOQw1P8n3NjghHGrVyaCupVjY2Gr2eo1dhganHbsYH5EQwq29umhDxRNVVlD2WsZ3SNXx1bvXVcF26MEU6G2fTyfWSQbqifoHl+/IkZooCQLj6WlE25ZL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(261009223027099003)(18002099003)(22082099003)(261022075727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261028144727099003)(261022105027099003)(261102123227099003)(10067099003)(56012099006)(261026140227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3Si3wm6r2whsetJEFVmHXDsk2GGmqNuMJWo6DbaHS7ocsYxnISv2fM4JXQLmBpSqwjOCRDYAkADltdl6h2eGJkVeTZBWAs6iTnf/VDGxLgtnFeWKPcj6f6f2XWuRtNcRP54HoDqc/LL8NUt45XMRGDxiPSoJv/q3pB+7UsxN+Jwwp0EeKmF7Keo9adGRLxP0iOLikfi0hXfyuor7otyE4mqW/CxgkIayj6thgqDFoQFyZgMo50adcap5SBoyg+P6wuEpUqMRg7f1DqBvbl8JK31udWnFY/YyN7HdNnUxkG8N8iu5KA3kLpeIEKFWjqz3NqrjZbBUHqrqxxRdxTDoFqv/JpW/dYg4wRJuIsSxjbKiJeC1e0y7QjmhdXUoh1/1Ca2dKtcmFACDmuZDcypQaK7oZAFz1BuiJpJ6a4Q+Ynk3ZRW4CLSOkSyxReFShW7R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:24:39.3150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc8dfab-41c2-40d2-7149-08df467b231d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079

Remove the single-L1-table context limit and allocate hardware L1 tables
on demand for the full context ID range reported by the function. Keep
the existing xarray as the authoritative context registry, and serialize
table publication and teardown separately.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/context.c | 78 +++++++++++++++++++++++++++++++++++---
 drivers/dma/sdxi/device.c  | 28 ++------------
 drivers/dma/sdxi/sdxi.h    | 11 ++++--
 3 files changed, 84 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 0979fa35346b..d75668e89e61 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -286,13 +286,51 @@ static void invalidate_L1_entry(struct sdxi_cxt_L1_ent *ent)
 	*ent = (typeof(*ent)) { 0 };
 }
 
+static struct sdxi_cxt_L1_table *
+sdxi_get_L1_table(struct sdxi_dev *sdxi, u16 l2_idx)
+{
+	struct sdxi_cxt_L1_table *table;
+	struct sdxi_cxt_L2_ent *L2_ent;
+	dma_addr_t dma;
+	u64 lv01_ptr;
+
+	lockdep_assert_held(&sdxi->cxt_lock);
+
+	table = sdxi->L1_tables[l2_idx];
+	if (table)
+		return table;
+
+	table = dmam_alloc_coherent(sdxi->dev, sizeof(*table), &dma, GFP_KERNEL);
+	if (!table)
+		return NULL;
+	memset(table, 0, sizeof(*table));
+
+	L2_ent = &sdxi->L2_table->entry[l2_idx];
+	lv01_ptr = FIELD_PREP(SDXI_CXT_L2_ENT_LV01_PTR,
+			      dma >> ilog2(SZ_4K));
+	L2_ent->lv01_ptr = cpu_to_le64(lv01_ptr);
+	dma_wmb();
+	FIELD_MODIFY(SDXI_CXT_L2_ENT_VL, &lv01_ptr, 1);
+	WRITE_ONCE(L2_ent->lv01_ptr, cpu_to_le64(lv01_ptr));
+
+	sdxi->L1_tables[l2_idx] = table;
+	sdxi->L1_dma[l2_idx] = dma;
+
+	return table;
+}
 
-/* Publish the context control block and L1 entry to hardware. */
+/*
+ * Publish the context control structure hierarchy to the SDXI
+ * implementation. L1 pages remain allocated until device teardown so a
+ * cached L2 pointer can never refer to freed memory.
+ */
 static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
 {
 	struct sdxi_cxt_ctl_cfg ctl_cfg;
 	struct sdxi_cxt_L1_cfg L1_cfg;
+	struct sdxi_cxt_L1_table *L1_table;
 	struct sdxi_cxt_L1_ent *ent;
+	u16 l2_idx;
 	u8 l1_idx;
 	int err;
 
@@ -314,9 +352,16 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
 	if (err)
 		return err;
 
+	l2_idx = ID_TO_L2_INDEX(cxt->id);
 	l1_idx = ID_TO_L1_INDEX(cxt->id);
 
-	ent = &cxt->sdxi->L1_table->entry[l1_idx];
+	mutex_lock(&cxt->sdxi->cxt_lock);
+	L1_table = sdxi_get_L1_table(cxt->sdxi, l2_idx);
+	if (!L1_table) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+	ent = &L1_table->entry[l1_idx];
 
 	L1_cfg = (typeof(L1_cfg)) {
 		.ka          = 1,
@@ -329,7 +374,15 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
 		.opb_000_enb = cxt->sdxi->op_grp_cap,
 	};
 
-	return configure_L1_entry(ent, &L1_cfg);
+	err = configure_L1_entry(ent, &L1_cfg);
+	if (!err)
+		cxt->sdxi->L1_users[l2_idx]++;
+
+out_unlock:
+	mutex_unlock(&cxt->sdxi->cxt_lock);
+	if (err)
+		invalidate_cxt_ctl(cxt->cxt_ctl);
+	return err;
 }
 
 static void free_admin_cxt(void *ptr)
@@ -561,7 +614,9 @@ void sdxi_cxt_submit(struct sdxi_cxt *cxt, struct sdxi_slot slot,
 int sdxi_cxt_exit(struct sdxi_cxt *cxt)
 {
 	struct sdxi_dev *sdxi = cxt->sdxi;
-	struct sdxi_cxt_L1_ent *ent;
+	struct sdxi_cxt_L1_table *L1_table;
+	u16 l2_idx = ID_TO_L2_INDEX(cxt->id);
+	u8 l1_idx = ID_TO_L1_INDEX(cxt->id);
 	u8 state;
 	int err;
 
@@ -572,9 +627,15 @@ int sdxi_cxt_exit(struct sdxi_cxt *cxt)
 	if (state != CXTV_STOP_SW && state != CXTV_STOP_FN && state != CXTV_ERR_FN)
 		return -EBUSY;
 
-	ent = &sdxi->L1_table->entry[ID_TO_L1_INDEX(cxt->id)];
-	invalidate_L1_entry(ent);
+	mutex_lock(&sdxi->cxt_lock);
+	L1_table = sdxi->L1_tables[l2_idx];
+	if (WARN_ON_ONCE(!L1_table)) {
+		mutex_unlock(&sdxi->cxt_lock);
+		return -EIO;
+	}
+	invalidate_L1_entry(&L1_table->entry[l1_idx]);
 	invalidate_cxt_ctl(cxt->cxt_ctl);
+	mutex_unlock(&sdxi->cxt_lock);
 
 	err = sdxi_cxt_update(cxt);
 	if (err) {
@@ -584,6 +645,11 @@ int sdxi_cxt_exit(struct sdxi_cxt *cxt)
 		return err;
 	}
 
+	mutex_lock(&sdxi->cxt_lock);
+	if (!WARN_ON_ONCE(!sdxi->L1_users[l2_idx]))
+		sdxi->L1_users[l2_idx]--;
+	mutex_unlock(&sdxi->cxt_lock);
+
 	sdxi_free_cxt(cxt);
 	return 0;
 }
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index e3fa39ee9988..c5b5b39a7fe5 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -321,8 +321,7 @@ static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
  */
 static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 {
-	u64 version, cap0, cap1, ctl2, cxt_l2, lv01_ptr;
-	struct sdxi_cxt_L2_ent *L2_ent;
+	u64 version, cap0, cap1, ctl2, cxt_l2;
 	int err;
 
 	version = sdxi_read64(sdxi, SDXI_MMIO_VERSION);
@@ -344,12 +343,7 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	dma_set_max_seg_size(sdxi->dev,
 			     min((u64)SZ_2M << sdxi->max_buffer, U32_MAX));
 
-	/*
-	 * Constrain the number of client contexts supported by the
-	 * driver to what fits in a single L1 table.
-	 */
-	sdxi->max_cxtid = min(SDXI_L1_TABLE_ENTRIES - 1,
-			      FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1));
+	sdxi->max_cxtid = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1);
 
 	/* Apply our configuration. */
 	ctl2 = FIELD_PREP(SDXI_MMIO_CTL2_MAX_CXT, sdxi->max_cxtid);
@@ -367,26 +361,11 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 					     &sdxi->L2_dma, GFP_KERNEL);
 	if (!sdxi->L2_table)
 		return -ENOMEM;
+	memset(sdxi->L2_table, 0, sizeof(*sdxi->L2_table));
 
 	cxt_l2 = FIELD_PREP(SDXI_MMIO_CXT_L2_PTR, sdxi->L2_dma >> ilog2(SZ_4K));
 	sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, cxt_l2);
 
-	/* SDXI 1.0 4.1.8.3 Context Level 1 Table Setup */
-	sdxi->L1_table = dmam_alloc_coherent(sdxi->dev,
-					     sizeof(*sdxi->L1_table),
-					     &sdxi->L1_dma, GFP_KERNEL);
-	if (!sdxi->L1_table)
-		return -ENOMEM;
-	/*
-	 * SDXI 1.0 4.1.8.3.c: Initialize the Context level 2 table to
-	 * point to the Context Level 1 [table].
-	 */
-	L2_ent = &sdxi->L2_table->entry[0];
-	lv01_ptr = FIELD_PREP(SDXI_CXT_L2_ENT_VL, 1) |
-		   FIELD_PREP(SDXI_CXT_L2_ENT_LV01_PTR,
-			      sdxi->L1_dma >> ilog2(SZ_4K));
-	L2_ent->lv01_ptr = cpu_to_le64(lv01_ptr);
-
 	/*
 	 * SDXI 1.0 4.1.8.4 Administrative Context
 	 *
@@ -445,6 +424,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	sdxi->bus_ops = ops;
 	ida_init(&sdxi->vectors);
 	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
+	mutex_init(&sdxi->cxt_lock);
 	dev_set_drvdata(dev, sdxi);
 
 	err = sdxi->bus_ops->init(sdxi);
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 0bc08fc6ae75..6d2b9ba88182 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -13,13 +13,16 @@
 #include <linux/dev_printk.h>
 #include <linux/idr.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
 
+#include "hw.h"
 #include "mmio.h"
 #include "version.h"
 
-#define ID_TO_L1_INDEX(id)	((id) & 0x7F)
+#define ID_TO_L2_INDEX(id)	(((id) >> 7) & 0x1ff)
+#define ID_TO_L1_INDEX(id)	((id) & 0x7f)
 
 #define DESC_RING_BASE_PTR_SHIFT	6
 #define CXT_STATUS_PTR_SHIFT		4
@@ -77,8 +80,10 @@ struct sdxi_dev {
 
 	struct sdxi_cxt_L2_table *L2_table;
 	dma_addr_t L2_dma;
-	struct sdxi_cxt_L1_table *L1_table;
-	dma_addr_t L1_dma;
+	struct sdxi_cxt_L1_table *L1_tables[SDXI_L2_TABLE_ENTRIES];
+	dma_addr_t L1_dma[SDXI_L2_TABLE_ENTRIES];
+	u16 L1_users[SDXI_L2_TABLE_ENTRIES];
+	struct mutex cxt_lock;		/* context table serialization */
 
 	struct dma_pool *cxt_ctl_pool;
 
-- 
2.56.1

