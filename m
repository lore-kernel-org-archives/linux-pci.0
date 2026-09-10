Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615E3E4C90;
	Thu, 10 Sep 2026 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024148; cv=fail; b=CBblr1OldWbnERbvzRP47gRP+Ig5NpxWk24l+PHB9R/vSTrqxs4Mr0WV+VyM1edRdty+Bmc9vAr9bwftt1LXEl0PnVGddeyK8JpasHCEIVgg+6ej7eSOESrvD3ui1srxwIwrXhP/gdI7pSwA1APvOH9yzrls7IyMbtMtqpnWiNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024148; c=relaxed/simple;
	bh=OkxTaCH6pFQv+omXwggPMUMvqH5/ehg9deXU0BJaOl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0xf2I8J3+9uNKLB22jJuVt7cYohfV13DBR+e3Jd0/YXZWdcjkwuojOxQ+vbhOwn+I0FUKVE9cX/Ts9i/T38QpZg7/iuSD7U1YbZv9Uq6cso0Kj9uGR96LWsHAcdIzDDvvnv9gaQc/KkMgSeLsEY53r16iYeV1i9XV7lr6qYF5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TOdPUjAu; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TOdPUjAu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAQ+xEdyL1/UozoKsszPcfblGqv4EODSiEetb2W1ZH/iaoDlyLGGLZV3GcocI118tQiItauUQfI9M2uNQqq/RUYESyqjubSO3/7NG3JNU8xycGrwlXmigHEp9agWNjWnPaprMUOYUbR7dL3cznI2caemVeo2NpwOrTvWjVnWvitV8ikzTZ65siNsjk6jNsHZtDzlpqVOOuoapXIFTYxVtIFOkubGbVyfebpQ5oyjMn1/GhPNpSYJZKl4EuANyECYHKpn6xs4GiPLEYSjmv69POYt0prXnGdto4l0J33byZid8lbMf2EYB/zQKGbBYZ9XZfjDBdUpx/zl/KNwUZmohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6f7rICvfy9IruPHa3pXFprCOWPckEioL4KN8kU5eVA=;
 b=hKacIAB2QCQFk0JZ/dGNttVUUk2tjH8Uf73l6L2Zuz0wzcvRkQf5Y6nsJT1SDU/7jFZk48wirYuQgwIyyMfHwAgYAz7Yirkqv7maABsaOkAdLQrm2xMIF62H66Mh2FBv9agDh1O0P/+HQTpTHjvGprKtI0aeqAyzxJDIyqVM29qbXPh2p8Llq8ObFIu330WhbI2rlvBBOiydmS4FfSy0oEVKD5gnbyTPUOSBiKPsfiCFtg4AmrJR0jIRNDGfHgBmYfLkyuyTgI1vZnwu/VjM70Z2tkymKrclkFal87cY1kjuJ6TEJ2EbRweEsp6iF9/Xnp30GVWxcEzKGrq1NWMR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6f7rICvfy9IruPHa3pXFprCOWPckEioL4KN8kU5eVA=;
 b=TOdPUjAuKkEF7ciLEz/xVGf8TdWfw8f4ajn8RErzCszJWVRafc2C1bYHwgjIjZ/BG3pdgSoqIq53uWeqhKbjp/tHH3mb0VfdEMe3JWtBpzWyRt+Xy8etwTP19uAiTelWpfN/ktgj2TnbBUo6VLZaoQLI+J8BE0f5vHxxxEbnTr9vcGYEeuNV87tNp6VgNTwmxB3niAiPgxTuMbMo7dwqubVCM/CPdy4IvkRFJivsQbuyi1kJxiRXlt5MAW8+kGvh7XTGZV/F7MtpE3kXNfX2zIOVEbRbCrpSwlw/JHIIreVp6XY62BdCq53aQMisr1w85NJDaR2oh7Xn5QEWIoqBwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:57 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:57 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v12 12/12] PCI/CXL: Restore CXL state after CXL bus reset
Date: Thu, 10 Sep 2026 07:08:08 +0000
Message-ID: <20260910070808.1444264-13-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: cd689305-2447-45f1-a0fb-08df0f0a61e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iZCdMCW2wFatfaZL3YAjgrNEjwLfhpErVDXhtfxRRyPhhejnOUOpvoOyvPT0XGt3nmWw1ukS45zS6joJ+xK1fCPYchTFqDxKBDAwK+9W3Bn6FPUfdOVN93Zz1g3FrdKlt/sQK5fsMtAnxf+JQOjRgYB+Q6ozoIL3EDUwF1YVpX0tBuFkDufKHCgBKDnIHLd3WMy/ausEI/5RkP+EzPdHRBPM6/BYyOKf4crm9Qxwcej2Kzfh/8ddu/s1eJ+mnhQve7qBskKTfXFH6gXgqhTGqxl6GCEWvLg43WGycsU75D4y39n+P53+zrvzOGfLMZ0lKpBCbKYmlne0zL6TUhthBlTWRsl+Lmv6dcWdlbfdN3cfs0RGTodQsgLNumyTJxyRs6T7OHoALKLag7/PjLvWyMeghpbjC/PMacqvp7g3Cdypl0GzYwe4pxGHaOCUT33jLM5Lt8Qn1zQkM2ifpCRVcvshXNtzXC21o5P+o0rvzPR+rUaDEP+LdIqarvdMhC9OZrVR0XfCmg2CGxaRrfNNvZAIt2JKQBix/5a4eNvaRGvM2YKk5kWcHbYmDdYQXAKam3AH9YqoyQi0DfDJEq2IOhKIpMIkPMifaByLlvSAJyHIgoyKk/8UeAMTWsUym9zxFz7Eg8s/pp2LKN4fBSpVVR6CtKNXN30HBl7gwOH3xzGI6+jc/m35MM4yBeX2Wl2SqGzEyf2v/v2yEmi4SxFJag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z8r4Bi5pc1smeSk8O91QG0hOMeiM7L1cQ+KaKXVeEgiBJfn577zqfNl95BL4?=
 =?us-ascii?Q?S7lE1x80FV2B4bBtjACcnR3ugRicm0z8N3ULrxEs4YMHoGvVrTd+4yI57Vp2?=
 =?us-ascii?Q?sWYCvyYQrJLb0KZmzFfHD750IOr5fuKMODMKGFAhWomrVdA/71Kygtx/Php0?=
 =?us-ascii?Q?a7lbjFHHY4p4IMU9+uLwyKSndrYg/YEKucAjJTg34o40SbLFN2vOWL/A02uq?=
 =?us-ascii?Q?BIBXUKf3uCSwGiyRzO/wLj4J1mX3V6A7XTTUeT17tuVV8KYKWfRX2GvASy3B?=
 =?us-ascii?Q?0iGnnMYaPXREKqd1EtqM/gYcGsIQH/U9NGNUjHMZiwdN8MpKDYqgdpZRqsbJ?=
 =?us-ascii?Q?kGUPte5J1dFHWM7pWtcEFsA3BXI14yg7FhGQr9o77W/ZMuwtvCYRC5SiP1Qg?=
 =?us-ascii?Q?2wDTrUIZenYXG5c3nBpAPSv9f1oCb/7Jo6HqvDPem7PG+2tqxkeREMPtPl5z?=
 =?us-ascii?Q?Q48Zk995Iz8JdP076bDy53DBIcr6iSIOmfgbrI6zaTTXxMjzWZG33iSyEH2d?=
 =?us-ascii?Q?j3lLfsirIdTn3F5voYQOJ3VpYbwKumqyoKjkojl0D/zRHS1LpDkSaK/3nEEI?=
 =?us-ascii?Q?Am+q1KO0itttlTrSU+QUSI0LWJYmmUB0QwLE0ve1GiIkyj04cFn/sOsvk1y8?=
 =?us-ascii?Q?D7tcaQJIELK1WJf9h7p2RLs6JMvPF6tvge8GA++R6dyIGwmEzO7rJ+zeyB0V?=
 =?us-ascii?Q?idQnwCTaAsn4ACJpME1uFFrT66MZkBbjluWz1LgFtrUl/AcQFSKmnucSGbbz?=
 =?us-ascii?Q?uLxZZbZBXfRugVX1+DOAjRqoV3qcLI53Vuwu2uIc+wb6kZ4B/ExhIy8cU2E5?=
 =?us-ascii?Q?51vZMRnMj8L3GTpuE9F//fcFiQv3RuTtUYASMxylTmywpEo/zQuQObjhRDvK?=
 =?us-ascii?Q?nM5YWFtJwB/W1x0N3TR3WiR3aOQRzeibymTsMAYRkfgnYUZpNEEaBgPtsECX?=
 =?us-ascii?Q?EnJlg+PoI6aT1Zw/lbOPhdQsrOto0/y+xYauFBwaEVOYf+OSHcJLCWKuNgtX?=
 =?us-ascii?Q?+utXoLtDIa16knuYZQz8GlurV/68diWcVqHO92wHdxQ/Iqya1aLbo5U06qEH?=
 =?us-ascii?Q?RUzmA5qklhJlPDwPe3o5SmGgFdSFpOq7p61nI3WNZxP1VwFG9mkgmVNqIL43?=
 =?us-ascii?Q?jX1MCwgdBrdLHTsVpFO5ywAbPEc685/VBoDbBl5JmxxymM8gsgzvXeghWvss?=
 =?us-ascii?Q?WP2BFmNyVAjl84+vfvYxXTYZ9mU0P3SUhltuGpDuzq2S6GhzoapC8RyvHvRo?=
 =?us-ascii?Q?Ivq6s+DO7xx1VezMabavQmjXnPiagW/2AAz+lIy/E7arT7Kesr94OpcVL4GS?=
 =?us-ascii?Q?caHxUcYogDSWbCTHcaJBCUmOgzdvFwWFKuXv5xUdPiGguHtnNd9ryqZwylzP?=
 =?us-ascii?Q?QHrO/kON4sSgENYU1/EMZ2jAKoxcGcdY/lIbRxHH5Wor/0TYcnJHD7eNE5i5?=
 =?us-ascii?Q?XblyvqMc2OnTRlkflI/vQGesriXJ9klrc5CYeLfCIIPmEmgyB/XgKdtFp6ev?=
 =?us-ascii?Q?6SxfO58bwaWWikUbRMS2pBrvf03sHK2WZe8eGGOdy94tRJI2RMt9IqSShjpw?=
 =?us-ascii?Q?fJ8ZZBA0Co82iufX0ZEQ7Nhh0/q18XefWN99P763BMYBPcdg5bqf+kFgy5/y?=
 =?us-ascii?Q?hSzcPw9XBpYLpTp/dq7+P0EmIcSQvXlTXLEVHI/4iC3bUA9j0tnPFn1yI4qz?=
 =?us-ascii?Q?dXzAnMJzRlY6O2JSl8z/XG7hhJVCfwJBlVICcRTepYy2jtM2WY9AI4sAULak?=
 =?us-ascii?Q?cO6gEJdZvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd689305-2447-45f1-a0fb-08df0f0a61e3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:57.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq4O4RHZKGs6mj7nzOZvMC6Xi2SaGxsPn5X+JOHaeAeyuo8BgiyavCCnG8ptfe+684sY8sSig6yL9pICNKRFqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
protocol enables. Reuse the common CXL state restore path after a
successful cxl_bus reset while the IOMMU reset block remains active.

Restore PCI config state first so BARs are valid before restoring cached
CXL state. If restoration fails, save a disabled PCI command state so
later PCI restore does not reopen bus mastering over invalid decoder
state.

Reject cxl_bus reset for multifunction devices and PFs with enabled VFs,
matching cxl_reset.

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 18 ++++++++++++++++++
 drivers/pci/pci.c           |  6 ++++++
 include/cxl/cxl.h           |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index e1d09f9042fa..d3491e20c1ca 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -894,6 +894,24 @@ static int cxl_pci_target_reset_prepare(struct pci_dev *pdev,
 	return 0;
 }
 
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev)
+{
+	u16 command;
+	int rc;
+
+	device_lock_assert(&pdev->dev);
+	guard(rwsem_write)(&cxl_rwsem.region);
+
+	cxl_restore_pci_state_for_hdm_restore(pdev, &command);
+	rc = cxl_restore_state(pdev);
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
index 157f06c576e9..a3ba4c28c62b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5027,6 +5027,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (!dvsec)
 		return -ENOTTY;
 
+	if (dev->multifunction || pci_num_vf(dev))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
@@ -5054,6 +5057,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	if (!rc)
+		rc = cxl_restore_state_after_pci_reset(dev);
+
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 856abbcd5f18..a02792969e0a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -166,6 +166,7 @@ struct cxl_hdm_info {
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
@@ -176,6 +177,11 @@ static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
 {
 }
 
+static inline int cxl_restore_state_after_pci_reset(struct pci_dev *pdev)
+{
+	return 0;
+}
+
 static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
-- 
2.43.0

