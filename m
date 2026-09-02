Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945673E5A31;
	Wed,  2 Sep 2026 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334120; cv=fail; b=GfKyuGxEQIwOcnWRUGg9SONccbKSjiNXRGjHIJDl+fiMuN73iAv6rjS+TDEP0EYeX5wKRtqOswpvfufBEEADnp++bDGNdWpZnmd8VdTher5hoXdk+OxF2ggqwX2jLfgopiJl3PU5i3f/Y0+vYB8631UOt2NLO+h051zuqEbOBtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334120; c=relaxed/simple;
	bh=lUKaqJ7VLPKbO/slGqBfAJStutG87DuHJtwcP+kSvm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SeO8SnPPqFZwyssABj1lDtGgfj9Lop+K60GEyb8TJZ+6GJNOpbyNRdqDDvsGo21yEuVTri1fotqPLEW5l1+Ualeqi6P6dkMxChDmAJPotcz5Bz0a4dHG4G4KI0Zi9mEzBYTYYtgeLlR+jzAzbVIAG9KYRg8cLVjVCBa24gby5eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JjPt7yvR; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JjPt7yvR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuHYpKYdG8GF8fEYh/C93PTB375D6zBj9m/PCtX7yc+uvKRGfaIRTISm/TQj/14dqeXp7b5hpAIvaAA7Upf+AdOMZhiJj1AjtZXKqclhGFshzxFcd0oh6iNA4bvjqZg+fYeSrZMP5BjfN2HJIW0QmGuX5rKsHTx4QNpgORWc97xwJVkTcZVdcKVGNb9sAwNHUfzcmsp61d2/0nIGdKaylKUE+bzYgUFIBz8ag23E3ptYxFFBiiTLM7SYas2JR7TJ7KwfaBpYRP4SZkA0neXuupsYngRmVt99+Aqv/Hb+y4IaITG8GIxTUIy6IlnnLcwZOoVv3MBv53Pks/Vd6gU6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVM6QfDn5oClncGCOo3rIO0x6K6dt0cyZzrTgxy5WtI=;
 b=pJChgEleD1knuyCTGHy6dnCdVlwP7YPWpvs1DBXONuke0r3oDAi0ShZ0Z/VjBOtWcvbKremXbq/Ppm9L/cpPnOTnXm6KjXEl2cN5w/PTOE4Gk+PcqbmF7PE2u9ssUwwVD6Lb0FoEZn4f2icRABK30c9Heb+l1TIO9knPhTUyoD+AEhQ1wKxqVNlbfePtrN1HxUcXn9tX/jeyWx5CtC9yw78wS9kL/cBOQbAqLGM+eYvKOhmVQaazKnbfcj8vpqBCJJsnevKMQsrPHWna5Iq88YaDrxSrLEsGgmCNqKHuyMq1kWT4sp7aBvvMivnCmurX0LfOAaZ+Gp5KLtJvz7XAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVM6QfDn5oClncGCOo3rIO0x6K6dt0cyZzrTgxy5WtI=;
 b=JjPt7yvRPC3C9KYRkgUNwdtptiDx3rj/uIN/K2o9aowgD4FfZnv8XRr/olcTrTr++OM67x8YoWzcXaMzJa3jd89A9cssegFIW1ADpsLk8Y8CTMgCOt79UgvO2LeqkFluw9GKO63hnxdeFFKV8yMiygXLehKdNcRRW6q0ZTPgtfNyxhT1zn7MPc0K3YRnbY/bLu4otHScEFQ6uke1qIBdzFXfZo6DWOzTMjIF+i1L1M57IbBe4DiH7/7ru0SbRiVhmmdB4LlfzITeoNhPDlf8MJaVU9oNcLvs7bVmmXKcCpFwn6E6EZ8DyeGiV5B0V1cC7LXRrwWCfiWSM1UBFZZ+Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:29 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:29 +0000
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
Subject: [PATCH v11 08/12] PCI/CXL: Reject CXL Reset on multifunction devices
Date: Wed,  2 Sep 2026 07:28:00 +0000
Message-ID: <20260902072804.665639-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4cb41a-a198-451b-ace1-08df08c3c8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JJsiIwT1PmJaF4WhSUxabSipLBc+eUgmTTcTVMJVQb9Z2D2uJFAcE+dcS7g16/TWxaJ77p0IIavDKokYAsjqdu1XEqif5QPjkE3Tn3hk59DXjSSGUobCLSClTJZAEXhlo0A32H5sS3B3mioWZkXSdZfwVfLG70dUtFJq4IfOdNb0kUz8rjfio6zW+KIUENDHhNGi8aa8DWNhS/c8lHYiMV5YsBcjcmzLag+GI1e7if5PaDIEJf/R+dvgYiSkGFUbeJzceoXZ5HedwztvKwzIeY7Nk+9g+pEvaLcg4bOqILtmHs4nGwJBoCXt8ARgdHmKGdo5wAMVl75FKVlwnkqnb3AzWpUJ2V9aZsvkNeOUHWL9agl+d3BmbdK0zGsr4gK8l9I3KxhsikC5wbp1vZdLIM9ZBu1XImCK3EkPVAhT9xo5MkRbgHsPNJaCTeMjhAhp1t11sSGOSV6AHyHBn18IP6mjS6so3WK4uq+828jXalNABBCerNt7cOk2V3V8ofn3LCxEuKjJPa0P5MSIztHT3EC/iZ6FgJ2AY+MfXkvPkBTTnzadxwuGzVlZz4YYQZcrcbs88JWRo5vqhdBqxkVEkyO/O7DRrWs6fNPYAGVnwltvcxB9BkizXw1EJvBdMuDG7fZBIs2izoxMEo5e0SNjaP6/ZpxZwT2LRUYuISBqg1Ho/a3GNZQmxM8bV2+QK5qkn/wyTsvnGR4bga48s/lYpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19kNvttNqOzy9o6aQYErkBlFIFLPb1voWLez300ueUcq9ffsc+s2HvSRx5ZV?=
 =?us-ascii?Q?he/HHjnF3Cg7cMoT7TzbQ2SVdkTLWvaYMqKaCqDRM1rpvSwv7uJS0KzF5awW?=
 =?us-ascii?Q?SqIUTV9YHa+FR5dsAIj7PPulLwlhrgTitWpPwv32PPqBLrVe0tLv8mkpxtv7?=
 =?us-ascii?Q?nK1NmTWji6HMqPUIY2IBpcRAi/4LiwJmlGo4AU3zTfUXbNgl+09RfFWkLZKp?=
 =?us-ascii?Q?epj12Xc5OuW72Jlc72s5bNZKlT6QPRIouR7xU3CDDO0v2G0Hrxwswsb4GDXq?=
 =?us-ascii?Q?DmPBpw9D+6x2fYmBtx+2HzsQOPk/0TNHjITtM5zecVTv4oOalFjOmT0qggyF?=
 =?us-ascii?Q?6svkvfGAjMfe12I2hBwlfPbdOOcWx7NdR2DC22UWwnfC0SHF7DVG8MxQekUe?=
 =?us-ascii?Q?xMnlKai0BV6i7aLujBWjn4KVveQGph4OFCn6EtjBKYeDMlQya94SIX6/yaEv?=
 =?us-ascii?Q?O2Yv3XtDBSkThrmkI8SDHsQlovgd2SA0toyvHO0n1cD+2jTc1oidEohm6ZRG?=
 =?us-ascii?Q?V8T5bGucti22nJtOYCjOTvboKdWYI0uCKilECMwqXfPfWnhqQoJlg2nGWoS2?=
 =?us-ascii?Q?H9wmVc1i6oz4fRwaXcqRIgwIDGg2TVYCWhVmQlsRMi00FCoAHisHyN2430FO?=
 =?us-ascii?Q?XQQTMHRpFljo5J38So32FLbEkyx31BR6bOs6MZx5auDAv8TY5Ig4SuE+Cd1R?=
 =?us-ascii?Q?kBdMLflYlC8tvC6yf6kSVqxEWwZoJZYIBXIDZR8tD0ZgLl00hhDIEG4x/VQF?=
 =?us-ascii?Q?wpO9INz27McZ/MkjUkSCbTi6EwOcxZwo9FAETyQCDSllWhHx+gxC4zlhCJq9?=
 =?us-ascii?Q?VRsulSywQ+F6stNmK7B+MPrrPK/22itND+xfXOaCRhwwlOU1Fb6+FfR03EIx?=
 =?us-ascii?Q?kj/tLxx7BCOCVUck4kcEOAqtB9duY+pCgqSgOQr7k3PkKzOsMENs9jsqb4nQ?=
 =?us-ascii?Q?Apt4qotefrPnp4UQ6DUZE0iZRUi9txC7E+12Wrl2bOMoSLs2hE8b8mVTG2z8?=
 =?us-ascii?Q?NJ/6tuUSFB15uJzi3aJums7cgkQll0qxijic1+bDDMoHgM9hjetjYGkyV1GV?=
 =?us-ascii?Q?hy7ckNzZ7tJFWRjWIg1aaWR1SguLAant++F2PTn+HOtR3pYx1P0ubJjbRy8s?=
 =?us-ascii?Q?1RgOdb90wXOWU7RbkusZptY1uk42mK7x6aKHfYm3xLQ0e8WQ4HVBh/NhMIue?=
 =?us-ascii?Q?5yywloIfp5WYWR+0kkjY5l2EyN0NJQRt6ipkxyzc5qYASYePJ7U4Yo9WvR0e?=
 =?us-ascii?Q?uDL34zhH81UIqgWDmd7M/MT07w1uT8tAJegHSg3nZQrBfEOIYK8Vsizb6LIY?=
 =?us-ascii?Q?wg4GmKeKh9IZaRpbbGPsQVSe2B6i6+5thmm954t70gmm+5wZm9gRl5nsE0nt?=
 =?us-ascii?Q?GC8AA+uqcb9OEKoomh/UoMc5FG8J8PtzqxTKKFDovilhpyiOEOfpgTQKnNqv?=
 =?us-ascii?Q?TNNLNpU9522I+6+5SrKTYxBPyHlqQLjd64rIu8FWXLZIDPX/2sJDjMCKsrVy?=
 =?us-ascii?Q?nHCo1Niu3mCTxZqULmMSg5YIWWeEXk+rauSLkZpyfHyLsE5Vrx6KvBxffQ7m?=
 =?us-ascii?Q?aXT6yhRROK+iXiz02qjKH6tOE8Mamw0dDoCZaQJZOYbaH7sVcNH0XSo1tvkO?=
 =?us-ascii?Q?Llj4hjpql22tSBpAHY5avyveNkb8NrWfqbmGnrKQzWbTk0APXyVLeWs61Q11?=
 =?us-ascii?Q?gzm7CVxhVYuQLTimKyko7ACTBFLEMR0VIrdIAsjBh1jRZzttBKivUTHqHRRF?=
 =?us-ascii?Q?tIRp4TUizw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4cb41a-a198-451b-ace1-08df08c3c8f7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:29.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2H2fwE2Q6EEt68+jJAZwww5SdtIeNlWEg5CQsy5JPyvyoSl7TeqYwPq6b7HC7fcA+zqgZO3UcNDEA2PLDJUJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

CXL Reset can be exposed as a PCI function reset method only when the
reset is function-scoped. PCI reset-method probing runs during
enumeration, so walking sibling functions there can race with functions
that have not been added to the bus yet.

Reject multifunction devices for now instead of trying to infer reset
scope from sibling state. Systems that can prove a multifunction device
has function-scoped CXL Reset can be enabled later.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 13bd0c3faf7e..79227ce70169 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -979,6 +979,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (dvsec < 0)
 		return dvsec;
 
+	if (pdev->multifunction)
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

