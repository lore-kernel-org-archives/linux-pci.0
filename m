Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A632AAAB;
	Fri,  3 Jul 2026 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051714; cv=fail; b=ePQ+nQzYjl2Kz1+91szgbC2vpJII/O0EEQdIytVCI9lmoAnV6aHaIX4fGNC0f738uQTKrU3XgCpkROUVdCOvPDD1ed6sLhgK6NfRcWBRIlBhvKtyutScTFRuy2h1sc59hfUeMLpd+jtzRLZvWUjUAp3DyTnMjQT5BIdUHmD4tAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051714; c=relaxed/simple;
	bh=QQLLPzINK0k4O419kqKSsQWnO0R1iVLPawd6tNxd8g8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IigPRboxZc6aSWmF4cDuzjpT38B/hf4sp6iCYRdJ9ZB9xaot1lcGrMoDy978NvdJWrHekJ6ZL5Qroe/TCjOUDV2sBt/W1vkCbcr7qAfEZy80rHeVpAUN+ZgOjJY3k9tJei9hs4E83zeBv1lJbRc2UcDKl4FUgEE8W7s6BVgygGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gig7kecM; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gig7kecM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVP/GYZCOFncP95kxIFrdoKEgfhZW6zXdfausjjJQ9LPgQ+2rnUsDy+OX+58D3cQ3dhD+yBz0wQ75LrpSAU+O3bMx8UOfkH3P7DztyG5jLCeETLHVPiw78BZFBEs/5DE/ls8yt4a+nltx0SvFbQ7eDYyLtm6P3slgAiqm2O8sHitNJp9c1n01jkUv0uuuEK47AEMywHbwoDH92T7ABZla9sppSthGoB1t9ZSLREYMLYRkv5r5mKvch+k0cRfeHaVfjR9QY5KKx4bhWEfvPR1aBBlA5lR9V5Nkjf6buBTRlmFadk1E/h9vTBfo6nCb4j9HnIWWjGVLuVwQSQ6hW34xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LohWKwYF3JxEUVI29Te/uH9OM3c8WXtpOa3jpnEQBeY=;
 b=qqQyu0zuSGjFwGzaRKbbwftgj8fWbZp9pI359+vdH99Wsfs0H9Y5lckzIc0NmzZxU9Y285QB51ODRDJrDkYqFGPgfbGWUnIH91po5/AtTGZYzdho0CQLPnmxjvY87YiEXkO2lr7qyuk2kaGx3qN3qvcv3R0Vuxnijz26YwQhAXHzIUq2+DfFcgO8wSTsrI8EvKJxMnIz4ue80F/1Y74LPuo+wKsbYXN/UIyAXqJIo4hYYjlfOK0mLRskxxNytjgeCAjqkXuF/u6CHPJfPfy79Gt/mbAKw0H1GHGInJFy0kaiZy4AGMHBzszqc9edOxFmKNlx/z6CY+MdDXhz/43BOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LohWKwYF3JxEUVI29Te/uH9OM3c8WXtpOa3jpnEQBeY=;
 b=Gig7kecMQcN3P9inCoMgl7ZjqqvPuaWs7Q5IVuf3xHLc+nzT2gQA4+K6Z2YV2eispUYJmzRuRHVvVXBLdRRHg5SScl3Gr4PFP3gAyUSEaJD7wfjME1IAqI881GNCX8ZfCkXLcei42UtwPWX8swOxHdm7nPz0p30UHCTkg1hdspy/6AIm5GgrwfEP+uxssOBClJCNj1q/PTAvUF6GsgMbFhrykDBJq7EwyMwMIYFZkA0sEcY7sKRRhiylph+yIphvk234BJ+g1L0v+e8ubhvlG5UlWJkQ+Z54M3ws4x2Lmmfl63IGWw4/H1n2FGBj9w6YZSNjiUiJo8V4YyXqW4gAUQ==
Received: from CYZPR17CA0023.namprd17.prod.outlook.com (2603:10b6:930:8c::29)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 04:08:10 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::38) by CYZPR17CA0023.outlook.office365.com
 (2603:10b6:930:8c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:08:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v5 15/18] iommu/arm-smmu-v3: Add INV_TYPE_ATS_BROKEN to skip quarantined ATS masters
Date: Thu, 2 Jul 2026 21:06:40 -0700
Message-ID: <18ebcb530ae161c5f4e37394ed1d69c5bf010667.1783044582.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef02506-6319-45b5-d6ba-08ded8b8b1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|22082099003|18002099003|3613699012|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	S64LoRd+3Fb1XZpK6XcGQsA+tJgUFaokKitnBLlL2SQ1M4AKsniPMF4pn3RtG6KIB1W1LPKYAgXJ+KYSh6miPadqADHd1/dV1RjbrAd55FEdgzka9VhZCxvOAigndjB82j7WHbPvVXQ5rLAIwKkPA3JTZ05P+POj4lK+bhP0lYyI0NI1jmz1hQfQqA/IvbLz/87FBcuIFVtVNEuvP7A3bpPntLQdEUwMyKbSZ8kVZxsn4ZxNzCgV/+ar9rw6EZzwHNU4XM2oDhxggRgNnAZVdU8Nf/ZZg9PQQok/P+WO329O9x4MYojn+YQfGLpF2Qnr2qaaer0IVC3wPIjDLE+3nOXlT31bG9sE8ozz9cYswcA8T5CyHjAqiclMERWFUh1byN7/J4tTIXs05NgHI4s+UDkeWpHwBpKR/GPEBGaMDpCdp/hV87ANtgl3NSVMydUy07NuP/BOqBWieddxNJ/jc7zUajVv3v+qJ5oipEP2Bjh9P/keIj4CbC2RVSIpaNrcDFHYunItb0EADyJlMKgkCmNA0oR2LTJnvcOIPw3S8EL0TZcKhQ04jX4+YPZ358jVUIyeK4PcTApaZ5bNBT9k5pZzpg6j8enfoUwFEk0Yti63deTlzn5Yg31XwELmT8qJ4XJbGmFtjjj/CZdaqNJw2aQ4giyXgLTw006xZxGHobs1t94W9ujVnwGaLLfN2GlpWSUvImbgOmvZN+iUuwMttHuBjxP6X1xekw+T0cmpBWC+I52xrSuqpUt0ET173zZf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(3613699012)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tAuqqoxlc6VKanxggdsKr8fKnJ00owBazSD/lLwmL8XQXmEJFgwsYsKPcwqdUW7n6HK0RTqjv0DF0QVvNRUrosySUiQcQZKl1bqEM7kur3fCQEJFckhBnYU6YsDYeDl5pRqucDApvRljadz6ZiRQ+pl2JS9H+Glwz31sbLsJfRkKFeb0VYB2w3zmw8XOLQg/39VIJoekOVcL5BiZWcRsMCHAuoGvyxkOqXZ+pNrnNjbf8+Qg71CA7M427X39lokYTmenQqgXAL6+QLsxslY9f2fsaHpj3mlzmSZGhHIUGJ9iSIH+n+ODgNMfLLv9w3NxPKij5krxa647K1HZnz/BJ/Jl0Ii+Ufbjyfmxd4bffW+rx7RreL8Ef9bxrM7MFJdvrOjsDNsFlmxnzODOm2ltGelKzpKw8tGC/UZt+rb3kCvNenzCF0WoLWjejZxLHUIk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:08:09.9341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef02506-6319-45b5-d6ba-08ded8b8b1b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330

A subsequent change quarantines a master whose ATC invalidation timed out,
marking its INV_TYPE_ATS / INV_TYPE_ATS_FULL entries in that domain's invs
as broken. Clearing STE.EATS makes the SMMU reject the device's ATS but
does not stop the driver from issuing ATC_INV, so without a marker those
commands would keep timing out on that master.

Add the INV_TYPE_ATS_BROKEN type. __arm_smmu_domain_inv_range() skips it in
its switch without issuing commands. arm_smmu_inv_is_ats() recognizes it so
the iter's batch-boundary logic places it next to other ATS group entries.

The setter writes cur->type via WRITE_ONCE while the inv_range iter holds
read_lock on invs->rwlock, so its loads of cur->type and next->type race
with it. A new arm_smmu_inv_type() helper wraps the load in READ_ONCE, and
the iter and arm_smmu_inv_cmp() read through it. cur->type is u8 so the
access is already atomic; READ_ONCE annotates it for KCSAN and matches the
cur->users pattern.

arm_smmu_invs_merge() and arm_smmu_invs_purge() also read cur->type, but
through a whole-struct copy of the live array that cannot be a READ_ONCE.
Wrap those copies in data_race(): the u8 load returns the old or flipped
type, and a stale read at worst yields one more ATC_INV timeout, which
re-quarantines. The hot-path WRITE_ONCE and READ_ONCE stay; data_race()
only covers the cold copies that cannot be marked.

An in-place flip of cur->type to INV_TYPE_ATS_BROKEN must not change its
sort position, or arm_smmu_invs_merge() and unref() walks would no longer
match it against an incoming ATS / ATS_FULL identity. Treat all three ATS
variants as one sort class in arm_smmu_inv_cmp() so a flip stays in place
and the flipped entry still matches its pre-flip ssid on attach and detach.

No functional change yet; the new type is introduced but never set
anywhere.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 12 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++------
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 56e9a94826a12..8eb5684696316 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -736,6 +736,7 @@ enum arm_smmu_inv_type {
 	INV_TYPE_S2_VMID_S1_CLEAR,
 	INV_TYPE_ATS,
 	INV_TYPE_ATS_FULL,
+	INV_TYPE_ATS_BROKEN,
 };
 
 struct arm_smmu_inv {
@@ -752,9 +753,18 @@ struct arm_smmu_inv {
 	int users; /* users=0 to mark as a trash to be purged */
 };
 
+/* cur->type may flip to INV_TYPE_ATS_BROKEN concurrently with readers */
+static inline u8 arm_smmu_inv_type(const struct arm_smmu_inv *inv)
+{
+	return READ_ONCE(inv->type);
+}
+
 static inline bool arm_smmu_inv_is_ats(const struct arm_smmu_inv *inv)
 {
-	return inv->type == INV_TYPE_ATS || inv->type == INV_TYPE_ATS_FULL;
+	u8 type = arm_smmu_inv_type(inv);
+
+	return type == INV_TYPE_ATS || type == INV_TYPE_ATS_FULL ||
+	       type == INV_TYPE_ATS_BROKEN;
 }
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 78e2559bdc491..a18a56ceeb7fb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1029,13 +1029,21 @@ arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
 static int arm_smmu_inv_cmp(const struct arm_smmu_inv *inv_l,
 			    const struct arm_smmu_inv *inv_r)
 {
+	/*
+	 * Treat all ATS types as one class, so an in-place flip to ATS_BROKEN
+	 * preserves the sort order and still matches the original ATS entry.
+	 */
+	bool are_ats = arm_smmu_inv_is_ats(inv_l) & arm_smmu_inv_is_ats(inv_r);
+	u8 type_l = arm_smmu_inv_type(inv_l);
+	u8 type_r = arm_smmu_inv_type(inv_r);
+
 	if (inv_l->smmu != inv_r->smmu)
 		return cmp_int((uintptr_t)inv_l->smmu, (uintptr_t)inv_r->smmu);
-	if (inv_l->type != inv_r->type)
-		return cmp_int(inv_l->type, inv_r->type);
+	if (!are_ats && type_l != type_r)
+		return cmp_int(type_l, type_r);
 	if (inv_l->id != inv_r->id)
 		return cmp_int(inv_l->id, inv_r->id);
-	if (arm_smmu_inv_is_ats(inv_l))
+	if (are_ats)
 		return cmp_int(inv_l->ssid, inv_r->ssid);
 	return 0;
 }
@@ -1121,11 +1129,12 @@ struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
 		return ERR_PTR(-ENOMEM);
 
 	new = new_invs->inv;
+	/* data_race(): a racing quarantine may flip ->type; the u8 is safe */
 	arm_smmu_invs_for_each_cmp(invs, i, to_merge, j, cmp) {
 		if (cmp < 0) {
-			*new = invs->inv[i];
+			*new = data_race(invs->inv[i]);
 		} else if (cmp == 0) {
-			*new = invs->inv[i];
+			*new = data_race(invs->inv[i]);
 			WRITE_ONCE(new->users, READ_ONCE(new->users) + 1);
 		} else {
 			*new = to_merge->inv[j];
@@ -1247,8 +1256,9 @@ struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs)
 	if (!new_invs)
 		return NULL;
 
+	/* data_race(): a racing quarantine may flip ->type; the u8 is safe */
 	arm_smmu_invs_for_each_entry(invs, i, inv) {
-		new_invs->inv[num_invs] = *inv;
+		new_invs->inv[num_invs] = data_race(*inv);
 		if (arm_smmu_inv_is_ats(inv))
 			new_invs->has_ats = true;
 		num_invs++;
@@ -2635,8 +2645,8 @@ static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
 	if (cur->smmu != next->smmu)
 		return true;
 	/* The batch for S2 TLBI must be done before nested S1 ASIDs */
-	if (cur->type != INV_TYPE_S2_VMID_S1_CLEAR &&
-	    next->type == INV_TYPE_S2_VMID_S1_CLEAR)
+	if (arm_smmu_inv_type(cur) != INV_TYPE_S2_VMID_S1_CLEAR &&
+	    arm_smmu_inv_type(next) == INV_TYPE_S2_VMID_S1_CLEAR)
 		return true;
 	/* ATS must be after a sync of the S1/S2 invalidations */
 	if (!arm_smmu_inv_is_ats(cur) && arm_smmu_inv_is_ats(next))
@@ -2672,7 +2682,7 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 		if (!cmds.num)
 			arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd);
 
-		switch (cur->type) {
+		switch (arm_smmu_inv_type(cur)) {
 		case INV_TYPE_S1_ASID:
 			cmd = arm_smmu_make_cmd_tlbi(cur->size_opcode,
 						     cur->id, 0);
@@ -2706,6 +2716,9 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 				arm_smmu_make_cmd_atc_inv_all(cur->id,
 							      IOMMU_NO_PASID));
 			break;
+		case INV_TYPE_ATS_BROKEN:
+			/* Master is quarantined; skip its ATC_INV */
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			break;
@@ -3256,6 +3269,8 @@ arm_smmu_master_build_inv(struct arm_smmu_master *master,
 		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_ATC_INV;
 		cur->ssid = ssid;
 		break;
+	case INV_TYPE_ATS_BROKEN:
+		break;
 	}
 
 	return cur;
-- 
2.43.0

