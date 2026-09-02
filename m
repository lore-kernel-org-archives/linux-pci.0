Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F13EB0E7;
	Wed,  2 Sep 2026 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334125; cv=fail; b=LpS8ldo3yniP+IKPCs+9jncpkbXvkeSPGIaSwX0qmvWoPTlctb7KWrBYI4q7j/H9yL1KfrY4GFuwry9AmDWxJ/5+JsxcVqTNdIZLolNtu+Yctm00K/tnDBi2/T2Z7LLtyEHqp7QhejDDd7YzyEYHk8eVeh7zzRQTgMsUp/4INGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334125; c=relaxed/simple;
	bh=ssyVmiuBbCglYu1gFdONRbjBcLVySy1etBdnpAGekoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAuTks67liBV7hFPM4QoIcuC3O5TBytMQSJtgUHYKPF4615jM8ofruZB4OidqlQvfoF11Pa0ANccMAKmnWyBqWoZ4TNaLjRYdaTAARhDNvaW9C+6bciopHzUETcSIzGVHhOpVMM5tqrtQypP919S4KOEbjDOFzo+0o8v0Hds0UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cupy9eKq; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cupy9eKq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uE4K6o7HPF0psooRA5+6A8lk4HD9VXPbZ4zP0OKtKMwlufyz96iNVgr9+CFxNFRTcESmyrdpclQGqSCA0TWpJ3BFKE5nR8EG4NdK9DxXFOPY/34IG/DylD9FL6ql0ZqSqjtw9VitWFVG+t8UMp5l/UhiirmFzXJ/1BgI0ge8vvkKv2AoFQ8FLhLAAxbBik/SoAco2+318b9rrCfe6hfNNSB3irdkZiT4jMVuRHJY/OccRleWD90sfLi+ewYUj5pTqbXUhDmZwqlS1SNQivfFevv4km32lqVztQ6Md5PF6n6FrtnmPJLKpZrXiKaCO31SReHm+R2oCwfymL2vH3MZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMOigEhjahiaymjOZH6GH3+dV/oWy4+4I3ZPw325Avk=;
 b=xvHPTz8bELMCYmOcFqj5gpp6QMuS/JWgXtS5z/NKE//7oQ5haxwJkqV0bpeaS+fbNTpUgly3eiTjH0OrlC3y3xm0TxOMZCPdbm0NoImF4mmYgiSVXCQesoesYGC+/9WP8kCEQ+t27PQFOXuhxEypTXlC1dFRi8tgTFkskr+tdLItR8yd5aXWDtNQFtdzfrNt6H/rc8yqE7s+TQN5h0a44CQVm9cS+wN2t5+jP9h+4i5l6Mmuy8L+mBXu7vX3PltRvntaecX1IiajJmtMXF8zAreJklGujUEWUEOY6bYvq0VMDqOYkUMVbyKIai7fM1gwdLkETIJ55trJ0uVsgSZQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMOigEhjahiaymjOZH6GH3+dV/oWy4+4I3ZPw325Avk=;
 b=Cupy9eKq/o0F71dCU7na03sl8rOh/f2yb7FbXm5YCUqAYpuandk1FdsTBAVIg8vDQlAj74/2MnsAeeu+wuB2ak9GS6ujUCMz1tNbu/MUd8SGxH8Tnaj1TRv2SjH+iiImlvtaPz6SDOcBmX7KnnVTLpAAgvtvIRCbnkuqpfrcgp0z8qcD9X2fB5dQnxOAHORQwYVTdok5dGXYG/LuPT5yW4L65a9NCXHZA3U2LTF0Bv9oyaXe0J7andZ64FunHGsWXTVVYb75PTYBh+oqKreJI/iRYmPva8+Hy4V+PhBHLJKNt5EX4yFq0fgifpWHylzaH76Vcc1MuoSxvU3q3EfGZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 07:28:40 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:40 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v11 12/12] PCI/CXL: Restore HDM state after CXL bus reset
Date: Wed,  2 Sep 2026 07:28:04 +0000
Message-ID: <20260902072804.665639-13-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:303:16d::11) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: afc2a227-a16b-4c27-6c96-08df08c3cf54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	lFbAgFaicu+PGFe/MQtVOaLWg17GLyNFjnzRDFKD5P2mswn2EnHUUrFQYb0KnTYxnb/rYEGreIpfMiwiRGduIVP7wSXj35deyo9r406N3LLCfSn1/ISDErYfWK73nmjy7NJY1rMmFD+Y9XYzMvWQEvcE87FQ450rJTLjpKJAF1+4FINzbkaJVA6T6dp/V0SRi614qSabbaCt1lfyhFFPuIPSpNA1Q4bVUPvpFX5bVkjFzg+UPrLwrYDqIPiOOr51yLG7OM5nJ8u00PUjb5DKP6XaMumR84HvJnBazixzRZvtng3xEaqMIHd0sS056WuO9JmxBXWnBluom6m23HPaoJnan8Y5IQhph52Tcuc27K0iTl7NYpnwC2JCwAFXX9gOBT8KMf/97UfGV8BCwd0MWBeSKxF2bqMmAljOw28miamFFuFQvSZAUXdnCcoC59LzeOHSQd3MGPL2vAOMihCguxiwdbe0e8nUMzfvHFCrbjCUJJl7JsZ2O7tYm7ssxirkHbjst9V1USNzaAXeYPBsfgxTCvl7Ukp5h5wIZBMTG1vdpxgdPiT+W/llJRFMTOlj4glfgO9pJgbTtSUU9hMWQAgjrwD6zM09IzYrO4NH44we1z35X2MP9AMnz4rey3i3NM7no+GvVaqX4Z1xuCKs3BIsTYXU97LB9X4JCnLbLpoav27fx1G2nT9mZoN+pAIgU0cOAwNZrQ8TDO7yeHFxqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WPN2GHR2c3ohNPosxbCTdLfr2rEV4FWOYA6eCeYv4/GoFwaZH2ooLa8pJ91w?=
 =?us-ascii?Q?XgLYuJ5Xhsm0Zbe3W0iMYL3YS840yDwwCkUhttfCaA2jiKDJHRuqPtJRFVsC?=
 =?us-ascii?Q?ILG9f4T5IWgLWApnpGMd5wxjV0IQ6C73LmyYfEhs32SlVbAqZ3Etin8WtUCy?=
 =?us-ascii?Q?Gvg9z0IWub4UD0+P8EyjWRqNtQxfjr5ffxBbkBLmXOB0Qks7MFhW7PxSOF9Z?=
 =?us-ascii?Q?5wjeAGB3xxy7NRAbeYCbd4NUU/MiqzlcNK25UQJlLrsm6dso7qgHck1nO1ds?=
 =?us-ascii?Q?7sqHXqYVrzYuetiCmafkL9CvQmzA51TUWGh0/+brBl4GPbCpNU7cl930aZfS?=
 =?us-ascii?Q?Ukirt28530o/TflLwDwglCFgN3boSQh6Foke5PY9F6LzUevN3WbgbjAtvWiU?=
 =?us-ascii?Q?DVRxn66ic2nKN9GADT3Euf3dAeL+dPYwPvdDcHv4AO4dvXd2Ask0gQceuSNf?=
 =?us-ascii?Q?98mQzOmYChGV/iThLf3Lgg/I0hygO7Ypatzd7E6JL1xKlCZeL3BJQHul6gjX?=
 =?us-ascii?Q?B4dKIoFlfzmRBlR5xC2251teui2Vmm1Cn22sPO9+wOZPKfrm+ZU78y+WVmRu?=
 =?us-ascii?Q?HTlcdQyJzU7eB8BqVdVbh9FiKgnwiC9n0kG+x4OrIXCxq0YC5vdZfRAsX4kH?=
 =?us-ascii?Q?nI9LbAn+zzMrPLu2MnrdAOdfFmosLU0FD1/fgKTixJ1TaFk2NEVFGVHibuff?=
 =?us-ascii?Q?EiVr8T15m6O3caD6/gUvl4b6j/F5E/1xrsTSU0RHeGHQwhMgaaRKofnOSocu?=
 =?us-ascii?Q?D2zy82PA6mQS8oJqmK6SY3/u2SwiBqRS5wKY4zUCYbIubljdhLC+Nzr4QP9O?=
 =?us-ascii?Q?D9ouvihoCd4NEM3kvrL5kTVFWA4+N+xMdCei+9nhQ4JYFyuxmqAK1yTX8xC8?=
 =?us-ascii?Q?S5vBvn+6T6wwDqxP7T/BsZ5pnHXdmkbEhriGDqTta42AHLeLPH/iZQJlnPNe?=
 =?us-ascii?Q?cvfaj43wp8k/KgjjikE8Tj0ptEnuskETnE8UhNg82X2gUXFhJ/bOIDBkNp5V?=
 =?us-ascii?Q?iqT/ZZuxaS8VXqHbXtUG/G1VjtuoIOMb9Jc+eSwKU9NIyWVnLbKX3v67nRl5?=
 =?us-ascii?Q?XMJKNzXX197dFCTqhQtoTmPdFflB3c1QceAczQ+LgzJyDwJQ2mYInOKJXmJK?=
 =?us-ascii?Q?9Sacg2DJPG3RLyPIcUl07b7r36Qk8pge1ecaGowgrFt5goyDA/hDCok8HVU4?=
 =?us-ascii?Q?zf7XavWxtTUKSzXIM9t1YovqJhXUmdiVf0yuDOwd29/1y3R/E3rymlZUWfP/?=
 =?us-ascii?Q?/eQeFGwnu2tKuSwHuSWzCLawxBNnoe0r3xR1XVpEdUqoB9SdfB6zv65sHGKY?=
 =?us-ascii?Q?6M0BZ2ikyp4l13QyiN8wm57vwPdFA6QcMdu34VortuEj/quGrj+jwc+LPIHz?=
 =?us-ascii?Q?0HpM+SymL33ewumGknXxu/94lc6WvEPCrAvD0a8f/vUsg+vyF0516KhA0Hlr?=
 =?us-ascii?Q?U+Q6aL9cWvxpk/R9TZfMm2ze+K2j15JW/R6Cio1oONOq+w8DQmsDrgVvnDAM?=
 =?us-ascii?Q?hUkPR20aLtlJxwiqotGbpbJACu20aJD62RZLQnkQDAa4Zw5EMCR7KbDZiu3J?=
 =?us-ascii?Q?G1Yco4TAp4sP5L1q+OJFSCwOaF0fhVdICFi/YQWXMQg4z/b0iKCuXgRscq5j?=
 =?us-ascii?Q?j2Tl0NER6sX+/YMfJxUik3UM06DLArqV80pNdTdfKFPI7855aVv6N1FeRAHI?=
 =?us-ascii?Q?VNdP24bD4wJbsJgsEE+Gia+XbJLD6h87FxslvxmT1sVehXlRFHRVhEX3lzP/?=
 =?us-ascii?Q?Kab1u5zStg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc2a227-a16b-4c27-6c96-08df08c3cf54
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:40.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfYRYjhMZEUwaT6x29n8qDL+pwrvbU5kUhrif7cASv7xLUwUxhGaQVX3kyovtfmZ2IDDVdboyjW4ar79Oe5VgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

CXL bus reset can clear HDM global control and decoder programming.
Restore cached HDM state after a successful cxl_bus reset while the
IOMMU reset block remains active.

Restore PCI config state first so BARs are valid before HDM MMIO access.
If HDM restore fails, save a disabled PCI command state so later PCI
restore does not reopen bus mastering over invalid decoder state.

Reject cxl_bus reset for multifunction devices, matching cxl_reset.

This restores only HDM component decoder state. It does not restore CXL
Device DVSEC range/control registers.

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 18 ++++++++++++++++++
 drivers/pci/pci.c           |  6 ++++++
 include/cxl/cxl.h           |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index fe330b825c0b..92d56d8baeb9 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -850,6 +850,24 @@ static int cxl_pci_target_reset_prepare(struct pci_dev *pdev,
 	return 0;
 }
 
+int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
+{
+	u16 command;
+	int rc;
+
+	device_lock_assert(&pdev->dev);
+	guard(rwsem_write)(&cxl_rwsem.region);
+
+	cxl_restore_pci_state_for_hdm_restore(pdev, &command);
+	rc = cxl_restore_hdm(pdev);
+	if (rc) {
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	return cxl_reset_save_restored_state(pdev, command);
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 157f06c576e9..0a3ffdc70466 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5027,6 +5027,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (!dvsec)
 		return -ENOTTY;
 
+	if (dev->multifunction)
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
@@ -5054,6 +5057,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	if (!rc)
+		rc = cxl_restore_hdm_after_pci_reset(dev);
+
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index d07afb789d63..c8b12f50f71c 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -162,6 +162,7 @@ struct cxl_hdm_info {
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
+int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
@@ -172,6 +173,11 @@ static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
 {
 }
 
+static inline int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
+{
+	return 0;
+}
+
 static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
-- 
2.43.0

