Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285860;
	b=Eny8WqAdE49VLL5acV+LMGkspnfcYcS27YAcoaJy/nP1QF9T+epvug6BO1u4k1jQ4GYE
	 KCMvrrnGwkqUbLw/78OIUN+O4BllNwwTOvMn7BVrmpWBOJzFliOycsDjvN7eXjRn+NigM
	 rRpL85b0J+uHPavvj3GT91EK1XPo/Bx78POGEjiDm7aW4312tBhebAdgJb8c563eJDnMC
	 eH4L4TIedy3LJfBid8whdwbCvkuqDacCRR1FVruDWLnqfwAxv18IRsRRsuo3ZciwKy5uZ
	 yxTvATP8gDx6fJ6BDEX8rkAeQVFHMh4vhXA8v/02lG7hs18grPTLNasDtOMecm85+Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285860;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BMKxxrJu4VAFT+E88D5xAEwcjEN8MpyZq+DQI9uoOhU=;
	b=qsJi5m1Cf9ULcPZ3H3SFnoRm5N36l/Kq8oZBFqm3SY1O3oLqaM58Od/aq5lAw0/GUCVg
	 WXx+Nb34+NHRuEV6x+dtYelOB3JA2veEb5bK421JLSAiIOM0iiib1mMi12oKKtZhtA/sb
	 rjbA2/Z2jrjB7C7LJXL7XBHW7SBORwgAAeWVq+McAzSfncCIVOe7Dk2nUeuKc84pz/z6d
	 QvUn3zTrKlBSK19sVhCliUcMUuA+NdaPYr/lsXmHn8uLqgVtoyYCNPFdBlQG/RH5R91xS
	 LqxrxtUmlNQC5FsBbTdJL+HctBQxFOZqEJKqwTv5weTKnY6J/X+IVhdT61FCxO/4M6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LA7gpEv4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.45
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15960A2628;
	Thu, 29 Oct 2026 14:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED15960A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LA7gpEv4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWwZd1b3MPcPdB8ev2UTpylY+UmIJVDPgYTbAX6rbyjeGiN63olX2LAG0FznjVzemcGbLd+06C7D0H0cEdiJ+GDwkMTQDyzXxCJviDgvqY9avu5BNFmiM83sCJx+rWq97jJfyaz5Wq1QBcKuEaGIyIuGekPC9acA+aR9JuYMYWnxqiXxDNzrnN+SBQYMqLzcSCXzSMTKI3t8p+szf4lPJVa80GFWdd+SSVvg5YjtlH8UqfMh1hYyjuolsXjVVmpUSi4J0SqRiaEWaNc1ICceRiP+bYdE0FQmBxwps0o7hqs3iF1hE37mr3ghj2Fa4O2xfLaWlkqqO9I2Y3KVcdW2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMKxxrJu4VAFT+E88D5xAEwcjEN8MpyZq+DQI9uoOhU=;
 b=iqhTfJk3lgu6rxp/6qxR513e4hL9tzg1g38a9/hmnuWmORAGWNaGLXDj+Sd9ACeIfmA4Y8d/rSSZnKVxQmwAy0fKuxqwZ/Q0UFcUeJ+4x2E3acbCmexcTDWUeCTDiC2yMtiAzCaguYrWN3ikoofCR6Ndyuj/YIDv1VCaN54nh1yk+ngTWXoyfu7RaR5VX44UNcm5Ani4PiFmmIPpSqBN8lmn2SLCO8ZzPSYVwnYW1Dg6er8yaw5SkXS70t5ngSaORvm8JRd/NCZOa5Tq6CK922eohRHb4rlBsCBN5ty5togrcD3a4X/7fwvNQjuQxs5/q20Mm4DV5pCdLu2TLrvVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMKxxrJu4VAFT+E88D5xAEwcjEN8MpyZq+DQI9uoOhU=;
 b=LA7gpEv46o07s9X6J6RvBU1K8LYCorp2xIYdZMQ4VH6kuNZqcDx/efQf6UKROvM38mUU2Qu1pD73Iq6RW3uOy0pyXSGsNpmnQs3tvrKTBru9GwYzsHr+sG+Cw9wQCGK7uZLpsKE6TWf4SKeFJtoKTfE3KTDK7rjuSlJC9DitqvzYNbBW6NoarQpS0KKyUtiDB7LYwAZTOaZ3jYkogNVi8A0Ygj/xxBWmvdXtsJWQIjFUk9CebHccBOtUwxOUcLXBsjx5hZ6AdGOZ0xCYjL6E3E30sTQC4YadrFrFA1msd6uJWpzL3qYFcvxyeK+0EYMkK7ko0O6O7Pt/vpEVE+AHIg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DS2PR12MB9821.namprd12.prod.outlook.com
 (2603:10b6:8:270::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:35 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:34 +0000
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
Cc: Li Ming <ming.li@zohomail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v16 08/18] cxl: Move cxl_rwsem into built-in code
Date: Thu, 29 Oct 2026 14:56:53 +0000
Message-ID: <20261029145703.2185231-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:303:b7::9) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DS2PR12MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: 6405df2e-0030-49ff-0af3-08df35ccf715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|921020|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|10067099003|261021123027099003|261022105027099003|261022113327099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	qjSpy59DGsZtzHjUdJe+e1Kgbs5UevbIa09IfjYNvG/OYY11VuGlryr4gBODIRSYgcnHsBBrGe0u0hp7wvjqlwvuRi6Ie782p06iJUU3RbVqtD+SYaGpgWCB+YHnM+i7JuEhHfquADZR8kZAxnHPTGwQCfkj6MMr0AvtijuA0LBHY3YiDDCsBVMSTEADLS9eMWCRxZ6pLlFo38MkdfCfeLgfAmDy/SHVToJ1ZQNKHTsKyF0d2/no5wyFP4o25gbYEN7K41vH5IcfGncKh0bxVYE4EJEsFIT/PI798X8KAharUnbW+mrrtHBg+JwXCiwM5QJwt1YiBIH2XAfCG2KmMwwT3uPIZOBSpfKRG8iKg4cou77dz4+BnzDSwL/XrOAILu70K0aIoG8ARq2xsfb5UIY7B3MDVGO5mulDMeCbZ4Su4162CvsNTcr79+6Zv+xbGbZYaQv9DXQXjhxC3jg3eOFGttLy7KDrNlagRgl06oyj0X1qEGx5+L98ziGQ+xr7w77BrBUiCRf6TbZaDLvPdsAJW2YmDZFm9fFlp3RfWCFmOug5AzF/yhc4EBlE8HlpmBdwS5Obyrbi4n/TBhjM+RuuMCmZorrvn0+uzGJ4Vyalzb1MjVKaQ/z6QjUdNa3aWY1+vAt3o1ktMicPEb+mZLIaqjlfLyZejIMkJrhd6kPRPm2/4uL3NLd/Mnns9CW8UcoR329jCuSw5YvpYUymzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(921020)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(10067099003)(261021123027099003)(261022105027099003)(261022113327099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HgTKk9xKMnXCRliyhIOgUnwz0ogtN2GAXluBCs+6ZgO26tqEnnIZ9M89Tyi?=
 =?us-ascii?Q?Y0lSkAqhiUK7gmEtEhJdt9rXFDhIN9Em/r/GDG2FertK79zMCSBbCRob2GTz?=
 =?us-ascii?Q?vut82JiCZPQSYAq8cgpqs2lSEi6+825SqlnLzDX6IyCnnq18Eqk9bSV29cte?=
 =?us-ascii?Q?cFT11L50EhDtHuOlDWzJDNCSPRlEhU531DKrhdc69Xuc4zMR55rVRjnVaupw?=
 =?us-ascii?Q?1e6QyTq87XUTuO+cUq18QBWyOlzMaJhIStWhLFG+jxU8x4wTqLIAM+VMi5go?=
 =?us-ascii?Q?iEnyX71r9Qo14sgwbrZK+cuxDa5jC+GqbQkI7lHPNkupMfPDAOg4a6SfQ2OZ?=
 =?us-ascii?Q?2bMvmUqms79uhTEe9sl+nPysx8Fowy/QQWjsKTPcbe9qwErZU5VAc93cQgT8?=
 =?us-ascii?Q?QVfFJZ4XPyUXZbiv3AnJLl94SKHRf1M+G0YoVK82BNEEfWyje0CEKQ9KlaWV?=
 =?us-ascii?Q?4icwUkHL/+aIfp1Lq1CJbUOibFLab3dG4APGAyZ2mvalMsmgH1qHAVPjF8iH?=
 =?us-ascii?Q?fw76kkQHBYjbzX5PHbRlbZwpfU0AwS3Jc1gCFMnwhvFGsQ4ost6/dPjFIHgA?=
 =?us-ascii?Q?MS8JHHXamhbXf/yOtgOK+SF2rkO4UADlCsrz73IopHi76ZcK8a9WML1sDOzK?=
 =?us-ascii?Q?/VLbyYc2LveEUf5edDOF+iNW5wf7zGKL+YfKKsRBXfItIs0OgnrmQw5jgHak?=
 =?us-ascii?Q?dwfm5yjtWXT3rUnAEIR1sQQXE636i3Qc0fUEaYdh9DBHVwpplNcvXQ65tYP2?=
 =?us-ascii?Q?NBqWOyTuSjSgQP/xAbiUIMCRry/iL+959wQ2KeQtdmU/saxQrbDfKhPiotz/?=
 =?us-ascii?Q?zMRir9zJR52y69MS9A9n9salZpjRnGNKS4qLQ1MB6LoyJ7OtWEsd8x3Y+549?=
 =?us-ascii?Q?fLe4ZNV3qhdfJgC2Vb9TaNS/HwVNUNWkpqRIrGJfPDWFxcIBipWU5L+BJko+?=
 =?us-ascii?Q?PENmh+NaRhZH1lj4yKEnpAEteWyXe4cVbRtM+BP5lhUDVVis+UIt7c2CqZWT?=
 =?us-ascii?Q?d80k3RzkO9y8qhjmonxs1AbN9z5N0HYICqz6FmWkmuVtZ9LkyfuwumYfK0ue?=
 =?us-ascii?Q?G5cXo4M/aKsQk/7KhqoW2HTu5QeDveOP0R9hKgbp+Zx0ah1cusukCSPhN4lZ?=
 =?us-ascii?Q?4KT9Fm59TLU4+wo6CRJqn/R7h4ZAuf2bhMlATdJ4V7klwOnFXNatzHH84uNV?=
 =?us-ascii?Q?2m8TgQ8rv9pvoO8C0aq2GpB7YzwkP4YpR3nGLCmJnzNMwCZKODyc6hB3xLbA?=
 =?us-ascii?Q?qrbpUC8y7VP8EF5A4LtWwPM6rgLBq6SFpHhV+78o9qKlrN6+Uy8alnBq24ab?=
 =?us-ascii?Q?W46YQ8RDBu5NVIMhIvgekHGf+RJ0A/qWuL97jNqGgDrAk0lT/h7IS9I9OsQW?=
 =?us-ascii?Q?c0XZkN+btib5FDsjysZ7C73st9e1ulDZuYkbP1VlSq/EFXxn9o8R2LlsaGND?=
 =?us-ascii?Q?BHqtmbgGpcKYQ2ijEZ1BM2pkamPVbb0MBlNgyUHKxAKTTaeaQA9sFFjkes/b?=
 =?us-ascii?Q?4cMX6B2cBiHfO2BSztO4UsNUhTI5i+LKarsUw8ML1ivVJ6/F2dZRjY5z6PI+?=
 =?us-ascii?Q?8J7zcmSKCHThlYHALU57OrV7zl1cnx3xtGSqR84bX+LX4S4qj60bBp5dLhb9?=
 =?us-ascii?Q?ubjIizp2rfb+o7GvZVfX7n75SGJv9btHrRPhB1p6UKSzSX9LhhSnni2b8G+t?=
 =?us-ascii?Q?ikxW8g4M+I3+bHyPUmhNbPJxS6S1pAgC5sIYj/1TsVZK1E5rcdfbF1mWQX3p?=
 =?us-ascii?Q?2m7DYjX5og=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6405df2e-0030-49ff-0af3-08df35ccf715
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:34.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7THUtMvAKxnxLi9XMELt2+0znxbwx4qhltRxfTOLKijmPSpuPDrsV0bTWP99YUOdZUkqo4qWZP4H6RmQokWDpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9821

Keep the region and DPA locks available to built-in CXL state management
when cxl_core is modular.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile    |  2 +-
 drivers/cxl/core/hdm.c       |  5 -----
 drivers/cxl/core/hdm_state.c | 15 +++++++++++++++
 3 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cxl/core/hdm_state.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 6703c1729396..9971efb237fb 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
+obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 5b5f5f22ea32..85f9abf58a42 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -17,11 +17,6 @@
  * for enumerating these registers and capabilities.
  */
 
-struct cxl_rwsem cxl_rwsem = {
-	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
-	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
-};
-
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
new file mode 100644
index 000000000000..c9cc019902ef
--- /dev/null
+++ b/drivers/cxl/core/hdm_state.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#include <linux/export.h>
+#include <linux/rwsem.h>
+
+#include <cxl/hdm.h>
+
+#include "cxl.h"
+#include "core.h"
+
+struct cxl_rwsem cxl_rwsem = {
+	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
+	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
+};
+EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
-- 
2.43.0

