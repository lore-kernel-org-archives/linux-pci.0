Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44852259C80;
	Fri,  3 Jul 2026 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116535; cv=fail; b=ftX9X4lA5DeoEtGmRpmOGpbNEavthyJ5UDJ0h2QySrNW6++ZRRdmpat0v/SEe9DJCIYS/suQIKrWJ3zJdDwZKcl4sXrZELZqfaeyPyi0ADBRHLQ+ycaxtJ05YxrzN+653Z+RtvaBNTW7SKu4vjcc1i1MwI2lB0w4uiEt/4eq7Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116535; c=relaxed/simple;
	bh=mJWJDx5AL7ywGmKHmiQnt10bL+x8CzQFq3idnJDQoO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/2XSO4Dp6fKiys/qBOCt8toiJ8vHWF9sTP6Y79TBzA1TBCk78p0g+znRoFJf0sEtKxDyYitKhyF6r5yR2TVdm7aIS3p9frC/ItoFxAu06jxxfI5iIadAvhL9LjwAq5SIqYT3QMdL4+WscdJj43J39+I4hvxyfAJzqoqPTCrwvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Im6aftbM; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Im6aftbM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSzeO3I6r7Pc3cd+nU8s8zbyfDROfoP79gTO2f02mdy9bh9grenNk6laNO831z1G+h8Vli2jzsDi/q3RSjhr65yu/Hd3QAW/dDhAe6i2MnCJ45sfaC5rEM3WZuZH7fGFRug8AfwQ1Hw19204NyvPuPybfAGTkAa8QOD6DyCRp1jeZvUx8bO0/NWbd6iPZzAMgi2VXpyzaarvs0IW5nQ07nRss9JPKrlBlgkxouAA+VCct6oeum97BHHEzDjXXGUVF6Wr3KcuEMMTgavDTMz71R3AyuYDTiki5hD14DiazFViaz5qIxbw60ZEBjsIdjj2SGbEBT6WhOcAWmCo3GuHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTTczYWLqJbtCoHKTbCTWL/CqSCjy6kBRfGkyqN0LQM=;
 b=dNfq3/myspbcmsBvlqaepfF2QnbZ0OGkwMHBGkTRj8r5HAI0HTcnt5Mh60vWLukrogb3C4R6IN+HPY13Ytf6OlEziU3+rpOw87X61X+O288nEHAP84iqPXN4kwV1WRz7EGYVazr+J0z/RnAouVnGDSuJo6aOlODb3xAHBtc2UqGcyTH/jW35yGi20oLFbtRwCsUDz/AH3p5fy1XPEX5VlY0tAgI73mqKm3ihDrMRN/sSMVwfe31cw/llfuxckgk5kGNVP5T24TJaAYiqDkc0IuvuQAY1al2XoY0afxnbXSFkC3NnLB/PMv1brlRpb/uqgSYDD8DD/6BaMwB45jKqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTTczYWLqJbtCoHKTbCTWL/CqSCjy6kBRfGkyqN0LQM=;
 b=Im6aftbMzVrfqNJ63mkzrSjHNOmnZGCZZ/62GXeyLivxK+9JJPgFL8RRsemACVGV574n7bE1PSGOJ4iyncR9BnYqEjA3dOeIZI+410fMYsos3n5yj2wVcJyqmtq1bNskmd0YAPToYjLLe4KgSI9Eqtk29KBtHfdLZXGpmXUTRmekZE9G0Ud/kUfF+aYxiNTNgLwiefgw9P12c/gedIMBOrP+C/tr2E8sfVp7lmkVYXUZbJyO0wPAOLi4hGdawkHxqv3ZJflHpKSciiPQkl2atoSdyUTW6KAIF+C3tJIbuW2Q46CA21iewWrN/pId/r6NcZZr4HM4sAZJ2hKfZR+spw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:08:50 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:08:50 +0000
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
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH RFC] PCI/CXL: Restore HDM state after CXL bus reset
Date: Fri,  3 Jul 2026 22:08:47 +0000
Message-ID: <20260703220847.546874-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 19718068-56d9-416d-36dc-08ded94fa97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	TprZtJDcgJ+Ifg6gUH2ze0is0Dleb1p18YvqsLejSNsWmwfs7tJfmO6e1kSyz1YfXQn2yuWx2yqLWrMbmXNiOzAdN4M/a3fSSYsve+pEWLiiDAmEzfPv+Cez03zuRQs60ykxmB/Ozgo5WrEuXG1cgSl4Te2bKDYcClEw+7EcI47ceLG269js6wpfwLL4XPJNRKMqQtjokiHJLHUnjuxkljDSqEpRq6IG2sOwpMm8UWyQoG5rw+Jbm3KCEEqN4aWk64XRDFmndxY6xmrmREIKJgR7pAw7dALTZyg4/bKsFMW1TLMmZGxnmTLNSCy+iz2epamqODI5VNmWC2DhYRGaWoHPO+3REWAIcIyFj0pSDVJrtiSn12QYs8JHZ1OsvdFBNB1K7oh986isjSCccWxC7V0XlzZJE++lQriPCGSOa0WubCj8z6vksegECZFn8N8YHBUgzPQPiBYcJMXdFGxqmPhSEwUMTH8lK8cXsHNjcY718WpZEYPCiyXKuU9apKMZQbVh1JKxaRM+jI8aDFoSdi9ZGb6MhbzRd9Nmwdu8N1tyHEeT6l6flYPHN+WnX/Rf8D3ARz+FYUG953JDl8w2220HAuEFzyZStWzJ9Ejk42GSeLqx0iQG79Kms4zk9lfXoB2YMqrMUKZzA+J18JIBGU3Xihj62KwXQQsfdkPoFvMUC6C2D/w34T2CiOv1CNDeVqkveCQu+3Hd1heG4t49vg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Meb38PQOr3nOthe4QMdi/AzWe0J2VAgsIC5RrLUFVCusY1hr+AtSxCp+LJWa?=
 =?us-ascii?Q?p4D1xWI274H2l3F8OEJdiMf8zfWs8I1RqGdm7Ic8WtojKZNDAsjUrhQV+WOO?=
 =?us-ascii?Q?zv2lWmQdx84o09tVlZ1bRJqG1n2Pjwd2fwC07IIVjwvJ8Wy+2sGiLN2ipknB?=
 =?us-ascii?Q?ElObJz7WnhnunHM1iVsGX6CDhDWAL6ZYOuSmYHBJCAacYWmhMP3P009ESt2G?=
 =?us-ascii?Q?1OZfOPA6MaXOMnQwolK9q0x1jFo0ZN+NdngBF2nemHP6UssJIB4N8GMYSqFx?=
 =?us-ascii?Q?P2RVUnxh3rznTmpETb7qzIGtH6eBuOImvWaYFmcq7z7nvcDkB666FTDDa/Tp?=
 =?us-ascii?Q?paVKB3LNp4t3oXw8NO+IKQ7tAMyzOj+V73Bge7S7cmAech3X6D2gqs3H5kHE?=
 =?us-ascii?Q?Sd/GzgRPWEFW7nERRBZiml6roChfq0l1LLsFWEXBHzG6fmCykoplnk13gh0a?=
 =?us-ascii?Q?bK+J1erLjIOHpy64IVmXkBwHkPKmFZBHQbI/2AGKxtCY8vhwGSoqrObss5Cp?=
 =?us-ascii?Q?YHNe1ZazazkRxV1FTd07sFNmSrAJnROxqpjWXUX/91Y/MfZ1KQVYkcD5LTWQ?=
 =?us-ascii?Q?VKKntVDEEklxcSm3ICyLlrNiACgwnBegwcP8iN8+S1js5IuIBo1l+194dDZN?=
 =?us-ascii?Q?RgOVjIu4uP07t6hHlnCSwYQLy2aOwJMx5WizoseoQkSv51RIWvJKokGNSUxo?=
 =?us-ascii?Q?8mG01Ru3T1MOUFAz/U7Qsbid7dhJYV2dxzNLNfQAD2jaM5/pPoQDhXaX4sRP?=
 =?us-ascii?Q?nfBL0U28EMHwTfEOnk3nSRk4mRWhsn1udCj6MHJAQtQDPG0FbZxM63Ri+VEQ?=
 =?us-ascii?Q?JiiD8yBjVd0PB6rk1BJOMrE+caSiF5SdV1tYd/de6QDJNGDXPSbmzTIGHKZN?=
 =?us-ascii?Q?gmhKWz2zU7YGr5G2N4ResZcBrF/wcv86mIPslNpSRtq7APh01E3rjNIJ3zNQ?=
 =?us-ascii?Q?7aeObm5uWuOyr+ybyM/3Ku0PVK79dTIrhR+G79Jk1Qt1StdvgUZF1LOVIyOn?=
 =?us-ascii?Q?UIPE7tw6lVu1Pz4Cuo8t0e/j5mRmiCuPwLbtP0IRbYtl1/oKu/SNqdB8Y3wA?=
 =?us-ascii?Q?pjnI9KLrU+VWCAjLO3c8qXYp58gHwWHXQcRMkJuhDJGaOTIUbqxMy8KGIBHT?=
 =?us-ascii?Q?IXN8xt9l5MVW1dGHhNtV4s60z/glFcKEnlnKkWX4SlAsJyOxX5Xr1F7bhDd5?=
 =?us-ascii?Q?axedYW10VwYUp017KY7jhNZ+gJ5Y+4P0QYZ4nyMgY9bIcfpQP6HqLV7BP+O+?=
 =?us-ascii?Q?E4VXuXH/3UAkXlpvYmXaBGQjQT2ADzY7I4xFAf7pJzhkHkURbD7aBnGquUIL?=
 =?us-ascii?Q?zf7/XbRERJT5KTJnuYPbjLEkoi6Oicx+dcTgtMw2FI6jViXUd0BOOlm6j8BL?=
 =?us-ascii?Q?hduxD51EQLo/rcO6QBIWdMAbfYHiFALCT3o7Vq5YaEeTDxG88UPtnrAfNodc?=
 =?us-ascii?Q?qNITLklAGRXTWyOJplKqbFUBd37zSNUuynNzP6+2jhvbjgj0FARtZxSz3OKo?=
 =?us-ascii?Q?O6zc638YA8rMXNSilT2MOnj+ed3QyOzhwUGoJWYia2K6AQtMtnkMgew6lngW?=
 =?us-ascii?Q?BTfwykwrUojk3ld16irHzb0+Y3BSVcZLpAWp/6SzFTF3mB12MnEFF8vnYlZt?=
 =?us-ascii?Q?DufQEYpbu946Q7QDCoqVoS9fHi58Wark7VqQf6ivL5miSx1uuctTJ8wIvngQ?=
 =?us-ascii?Q?8h9XwgDVKJELyqmvFOUVR+thEWrwPbiS3d4SZKlIHouMAHwHyfBNYHe3/o5H?=
 =?us-ascii?Q?QBoCRBVVnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19718068-56d9-416d-36dc-08ded94fa97f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:08:50.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciCYaB6s0s/yP5tJQcBlwx7+VH5kgxCWo/UbFqIDTq0qX2HkbP0iYwhfljbgKWCcXDb+qo/aPpSuynhchBh6+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

CXL bus reset can clear HDM global control and decoder programming.
Restore cached HDM state after a successful cxl_bus reset while the
IOMMU reset block remains active.

This intentionally restores only the HDM component decoder state cached
by the CXL reset support. It does not attempt to restore CXL Device DVSEC
range/control registers.

This was exercised with cxl_bus reset on a CXL Type 2 device. Testing
confirmed that CXL Device DVSEC range/control state is a separate restore
class from HDM component decoder state.
This depends on the CXL reset series because it reuses the HDM state cache
and restore helper introduced there

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c | 5 +++++
 drivers/pci/pci.c        | 3 +++
 include/cxl/cxl.h        | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index cfb9b5101c28..b889687d69d8 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -894,6 +894,11 @@ static int cxl_restore_hdm_decoders(struct cxl_reset_context *ctx)
 	return cxl_restore_hdm(ctx->target);
 }
 
+int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
+{
+	return cxl_restore_hdm(pdev);
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7521e705f718..88fa3117e0e7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4972,6 +4972,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	if (!rc)
+		rc = cxl_restore_hdm_after_pci_reset(dev);
+
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index de58f484b7d9..c1019e1b3b27 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -154,6 +154,7 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 #ifdef CONFIG_CXL_HDM
 void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
+int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
@@ -164,6 +165,11 @@ static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
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
