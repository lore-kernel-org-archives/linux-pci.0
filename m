Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905217;
	b=bfICh0MZibAOXRnO7E6v9Wp7FIXVllU1K9d9YuAqB1lSe7r5rYawvC1787zrCu4tJQx4
	 N+x/FmA/4m3O5epeZT5mN4XRGM9g72jAmPP3Y4aHZrHSj817/bYQgdgau8ZPyDAdRnNHp
	 sHIkgNUIV9qwpIxlTrqWWJv/fukfQh8sh8aB24PwNxdASITOkMDeEsW8LrPyFYzGyN++m
	 Qdl6MqJBhLpuWTVSKc1lq/kgm8cSmpVPIWgmli6it7eg2myIfHeQC2drkgshox+SBfOwG
	 Q2P+agwgkkK0snJmY5rRKmc0IWlxSYSeB1msqafcgy8CyPxOMh9/FlrTYLlQHUmJbIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905217;
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
	bh=CdKW7kIQRWj+os4DktbsGjA2gUGN9j0vaKtne4jIsqE=;
	b=wKXHh08xAmxWkrmiApBcOqsXvhyKnEU5+D4fmFiU8eZdey++4efE1e2qO40K57t0JmJO
	 dqGwpJc3p34fsfYtLmktVYjYYMbn/LtLR8hK7vJ7TwV5BOtEehMcATwLngWrqkdvV/ghn
	 P5wy4etleBvpR5MgoKJdwnddx5VvtWoL084nsrTmmKrn3jTYjhBzKuaIo7qTqoJHcSxFq
	 RguHjRHzkmq+0yokvgG2MvGMq5j07TsmYlC+rNX2bsJ835ijV4uAHDZi6GHklu96m9/Xf
	 IgFrsCGmJ7qJD+FD6k6q0B//r3chaVieJNozeNa/NJ1Mn9O11hC9R5TktUftyaFloQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uAAJfblX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424B6083632;
	Thu,  5 Nov 2026 19:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8424B6083632
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uAAJfblX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z54rpUHeCqQQxntDTuq0ZdFPnAYj/z9mTUXR0x4HhhT8mzobjbsUWhnxgEKdEeR/tERVfBzi2x2JgHXrwH/KwPjZSgDyCbXNwKa4tAqevYN4ml9acGfdt8RmEypwZmAIfWFfFrsTVkS+a0TU/9O06mz0K88rt4WKTJCpk218UBqUsGwHUK9Y4exuQNhEl1BmBTqZrmKjpfKIh+xQYEu5GBupjMfHspYHBYfVu27BvdVJODHXErBW5dOYmJw61IphHlH2XqapAjw8sHsqioY7RJ74NH4W2jku8fGuhvAWmDS4mUTKEYF279gygB8p7lOh2OtnxEDgjdwpW7kahOUtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdKW7kIQRWj+os4DktbsGjA2gUGN9j0vaKtne4jIsqE=;
 b=MaTqClVOtHfP+q5zxiwlf/dsjZRi8GJbPAsXkKroljP/EkGTIag0gPw8UnVFuLZh9i8zO3M7ST+KWpahDsct970AhSQPl8FayMpQI3jyBbnKb/teU4/AuqQLfz+C9BFbHQo3GdIbdbnkzmBtUD1fg13f9qg2IOoDgGblsLEsXmhJFbR9HRCcGRjiZx9mlDBFfJbDC6QigpsJqC7dNyhLsnvbhCN8165CfECLF29760W41/l6ju6IrweZXZxdFnAfCnAfYXHHrRJ1mRA3X9XEcvyB1jxlPmC0iHuG8h12XSFdXi9UiCH0mnaXTzp7DWR1UbnQNpe2T8HdxZrk4KHdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdKW7kIQRWj+os4DktbsGjA2gUGN9j0vaKtne4jIsqE=;
 b=uAAJfblXQB33eTRe4Gz/BIgwjZvyDMjJDhSWQgMXfSxuVJ2Kw5Gt9RiwvtsMt461vf1BmMif5gKwf+uIsxVNeoQqRJ9Vn/fuXMl26YDc5Fy87IvFjEW/mvibbLuqMacQA3iEyrZYKUqA46rEL+reTpo+KXb5eEYCKdxejGXdmUnx9z1MDLbtwj79TFxDUyNeHFTBtOn2jn4CPPTJRhMltCv1eBzuSCnFZ7RPV1h89IjOaa42Xm+zU8uUgghTh2ok3lWsghHfK1gtX59xiY02WkDJSOGD3nQxEPTUuiPXXOZWczU1MiW/2ShKJScmf9yTzC0+pDV1Mg4BdxKIDgSdhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB733495.namprd12.prod.outlook.com
 (2603:10b6:408:423::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:00:10 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:00:10 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
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
Subject: [PATCH v17 19/19] cxl: Add KUnit checks for HDM decoder unpacking
Date: Thu,  5 Nov 2026 18:59:17 +0000
Message-ID: <20261105185917.2667656-20-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::20) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB733495:EE_
X-MS-Office365-Filtering-Correlation-Id: c066a26f-e807-40ac-f9ae-08df3b6f03ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|11063799006|261026140227099003|56012099006|261022113327099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003|261102130727099003|261102123227099003|261026121527099003|261028144727099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZlFHrmMB4IS6jV36M8lhJtkauLtl3BLhMWmwvNAeqqnyWDexcidWouxb3PY9P6v+g93sAMYnOAfdRtnLFL66QsY/YtNX26MQk4b3UO+mSygs2jGgbvF4F1CInV8opj5FEDNTwyJqfNcRoqBo7+zheQeYtuQkQSoVqXxzggTcveeMCwoiyA3JGyOTOGEFSVClu5NnuMf6zEkUzlrvoEMVtaq3r2MEGG2O5NnMIjCKsaLeMlI+5cGl6j7YpNbfuLtXtA2Fmaez9XJxH61FCu19U1mFOOh+W1W4HGN83kyIkAqa6kAlZvgjQ2xBmqVF1LhX3OW2UCpmuo9ApC1I5HJn3Y/yqHzZmDYZeY57ZAXv3irH3NfMCJrq+YnhT6lVCPY48b2234Cy4VPOEkS1dFAybcYrOA6tAGDYdJ/yN54c267a4jddDj3hJ4yIZPrfa9SgS5ZKX0jf1rYvZYn5I/XnQLBu1AQRzzmwVlvytBj3G5lRXY+ZrFgk5Iz3kgmexCr9nbIXQ8pGL80QUVjIk4J5pm/rIjRYw4gX1gnnNBWw5mtr12j+ETwAAN+8SGMXlkTl1OzL2EE03/fgE7AE9WmkvtNuqiXTYxpoM1bYpBcU4S869R2Y0RK33tcbvAei2Yac0pRpdsQwuPIrefwa9V8qtgAUup4xRJuGe8bNOHg6Punjiv4QqRT/21QRgaza24c0wJF0o8/AQyRNmAHVFuY9kQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(261026140227099003)(56012099006)(261022113327099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102130727099003)(261102123227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gz5We7/RqXHt2gpjQ6EL2AmamxU4iWE0bNaFuSG3Xi9P7t+IToFm+/t73IP2?=
 =?us-ascii?Q?CqAeIi/wm/z02TLmFkhiog60ZuSTBaU8GLOgyiapQnvolOW+NKb8oTztb6LS?=
 =?us-ascii?Q?IO81KxpYV8VtRnxsi8+sQGJ4SxWAzzvmA9xfuVyOcrzSPVZZsjmcN1+32wYp?=
 =?us-ascii?Q?eof6u11/O50k2JBaqldofEL19BvJjPfay03e4xRpcFV4zAOMH/RkFQLpPGfH?=
 =?us-ascii?Q?Q9sKqjWRg6UjU9aQP4vrXCydfZrBXhngP7PiVd2zxAkqUGbNviPpZX/G26fk?=
 =?us-ascii?Q?rh4OYNyrwm6QTMDPuovPp/Tcbe7TmZcjMzpubT0rxzBbt91+QRsgsCJnYeUr?=
 =?us-ascii?Q?rkRCe7iZU8uEcVHajr7Hy2TdQrvyLcS8MaGCSAv8DYemLMzRw2+wneP7iCdU?=
 =?us-ascii?Q?kEz67NR3og39KEO7blXNfjG+vLJ1RMrbqAqcvl3rpQIWICUdJIglnf3VjmSq?=
 =?us-ascii?Q?giui/c2sJigEuk1NOcI3qxvFHlcqKF9oW1k060VX7OG68ev37PwCUpGaJQOZ?=
 =?us-ascii?Q?pNuGDzSbw9+m+f9wU9tOl1uVYUsCFszRqzQYrf+99VrHU/yh8q8fAlkZNuSu?=
 =?us-ascii?Q?AgeLmjKGsI7NaBR5mJp263bBTv5fqTGQK6oIsKit9tJYLEYE+Jd2c+COj/4d?=
 =?us-ascii?Q?nq/iSb7klFzGk6xRotzOFRVG8Anp+1DXJ1ihVqVxv/+bUwjLiXaT1YjzTy3b?=
 =?us-ascii?Q?K6zUZzEthp0vH5suLTxbZEEG8j/M5GtmOyaszi5iJ9YHLzRqZG1PHRZ2erJx?=
 =?us-ascii?Q?CSowC2MZKbLmQXIwVlY3tiHGHQLLOK7tvqzzniT4ZZbfO4uVwpRqG7p0vGJn?=
 =?us-ascii?Q?49K8g2KOZgick8mKosAYlmoC5wVpinPhmQGqi2gUP3UPO0XtDt620vJ3sFso?=
 =?us-ascii?Q?pleHrLVE+PWTM3Ebzi38NfkTkIwCaALptIMZcZ6/OqzLQBDuLyP4+NLLnWdF?=
 =?us-ascii?Q?+frUg+yM9rxCttQbH2ggHEsFGZ3S6gpj7PdMyy4gw//UtSm0zH1trsRmeDuo?=
 =?us-ascii?Q?OOyn8+r0IDjsEfl+s8taR0MIJeQ6o+518vhWi8MrTg53DBMD6PFw3bzMbEAU?=
 =?us-ascii?Q?NBTXJf5kODMCz21UgSL0aGy7jfYCRTgIFDgDroylg4R3UBgzMokuIy48kPNm?=
 =?us-ascii?Q?Q6gwDYqZ97O3JLEizg12mid5s1fuBFRwu/ENMowZfCBUENc7euiELrQVVjrb?=
 =?us-ascii?Q?e1S8C0XKIFXbTbGJt1T93qFoAzZx7iAo7ksO5zbSkK+PB2t47r6hP4fiUeqw?=
 =?us-ascii?Q?OkJjZeWD/nmSErAGtz2PN4fjNWZhuFxcAENbbzcMUWmug8ZiS9rR2reRywPf?=
 =?us-ascii?Q?MFrVSFETAffxQLdrz8mmGkuGZKCjCejIekVp+VxtrXoRVEV69oYKX4sNZP48?=
 =?us-ascii?Q?cLc1uvEbre6jAk9QAj0IGRU5UTGAWWDLx0c5iCQTRDalk2w1I4n9aH2RvplU?=
 =?us-ascii?Q?CoxLORmWWHtgPo0MEZJFjrnHQTXc1r0vqkpCZM+/zX43DNQkkIlqPLSC8V/4?=
 =?us-ascii?Q?uxUCIljMe7osQqKKFO8tOkhhJ7Y6evMVCY6GDD2TWcPLFfSeOQiH2pLkk0rt?=
 =?us-ascii?Q?o57oavwls5/93N+GcpqdcSuZv8Swy9Bs9WAVXb/pnU/Tjwj5EbHFQncfcQG5?=
 =?us-ascii?Q?nsStiM6DuXEvq+rkVz/Ar97ZL7aPsgf1tRl3qM4ZmhDuJJO8jm0uND5Cr6Se?=
 =?us-ascii?Q?XSVLhmcBfp1t+JWmv20fPfuarNQfLpeHj7RtukL70z6Ftewg3GYE1f3sGNlr?=
 =?us-ascii?Q?MCvIGST7xg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c066a26f-e807-40ac-f9ae-08df3b6f03ee
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:00:10.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL3G1ajsmH0w4FMHlaNwOtkQRQdr66TNrvV4s+1M+Ongj4DKdVgcs09GjZ74i/hrBawulDKHKe3FvK8n3W15fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495

Test cxl_hdm_unpack_decoder() without a PCI device or HDM MMIO. Cover
range boundaries and overflow, an all-ones base, zero-size and uncommitted
decoders, and a locked host-only decoder with 12-way interleave.

Run the checks as a KUnit suite rather than during cxl_test module loading,
so a failure does not prevent unrelated CXL mock tests from running. An
uncommitted decoder has no meaningful target type, so do not check it.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/.kunitconfig             |  4 ++
 drivers/cxl/Kconfig                  | 10 +++
 drivers/cxl/Makefile                 |  1 +
 drivers/cxl/core/hdm_regs.c          |  2 +-
 drivers/cxl/tests/Makefile           |  5 ++
 drivers/cxl/tests/hdm_unpack_kunit.c | 91 ++++++++++++++++++++++++++++
 6 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cxl/.kunitconfig
 create mode 100644 drivers/cxl/tests/Makefile
 create mode 100644 drivers/cxl/tests/hdm_unpack_kunit.c

diff --git a/drivers/cxl/.kunitconfig b/drivers/cxl/.kunitconfig
new file mode 100644
index 000000000000..4fee684f5ff6
--- /dev/null
+++ b/drivers/cxl/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_PCI=y
+CONFIG_CXL_BUS=y
+CONFIG_CXL_KUNIT_TEST=y
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index e927e69a3f7b..7f70f6babd74 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -213,6 +213,16 @@ config CXL_REGION
 
 	  If unsure say 'y'
 
+config CXL_KUNIT_TEST
+	tristate "KUnit tests for CXL" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Build the KUnit tests for the CXL subsystem. When built as modules,
+	  each test suite is its own module.
+
+	  If unsure, say N.
+
 config CXL_REGION_INVALIDATION_TEST
 	bool "CXL: Region Cache Management Bypass (TEST)"
 	depends on CXL_REGION
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..d57fb0e9e7da 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_KUNIT_TEST) += tests/
 
 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index 4f5e843cd141..98b37edf5590 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -188,7 +188,7 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
 
 	return 0;
 }
-EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core,cxl_hdm_unpack_kunit");
 
 int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
 			 int id, u32 ctrl)
diff --git a/drivers/cxl/tests/Makefile b/drivers/cxl/tests/Makefile
new file mode 100644
index 000000000000..c29dccfa9b24
--- /dev/null
+++ b/drivers/cxl/tests/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+ccflags-y += -I$(srctree)/drivers/cxl
+
+obj-$(CONFIG_CXL_KUNIT_TEST) += cxl_hdm_unpack_kunit.o
+cxl_hdm_unpack_kunit-y := hdm_unpack_kunit.o
diff --git a/drivers/cxl/tests/hdm_unpack_kunit.c b/drivers/cxl/tests/hdm_unpack_kunit.c
new file mode 100644
index 000000000000..c1131e145757
--- /dev/null
+++ b/drivers/cxl/tests/hdm_unpack_kunit.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#include <kunit/test.h>
+#include <linux/bitfield.h>
+#include <linux/sizes.h>
+
+#include "cxl.h"
+#include "../core/core.h"
+
+static void cxl_hdm_unpack_test(struct kunit *test)
+{
+	static const struct {
+		const char *name;
+		u32 ctrl;
+		u64 base;
+		u64 size;
+		int rc;
+		unsigned long flags;
+		int ways;
+		int granularity;
+		enum cxl_decoder_type target_type;
+	} cases[] = {
+		{ "valid", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  SZ_1G, SZ_256M, 0, CXL_DECODER_F_ENABLE,
+		  1, 256, CXL_DECODER_DEVMEM },
+		{ "overflow", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  U64_MAX - 127, 256, -ENXIO },
+		{ "all-ones base", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  U64_MAX, SZ_256M, -ENXIO },
+		{ "last address", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  U64_MAX - 255, 256, 0, CXL_DECODER_F_ENABLE,
+		  1, 256, CXL_DECODER_DEVMEM },
+		{ "zero size", CXL_HDM_DECODER0_CTRL_COMMITTED,
+		  SZ_1G, 0, 0, CXL_DECODER_F_ENABLE,
+		  1, 256, CXL_DECODER_DEVMEM },
+		{ "uncommitted stale size", 0,
+		  SZ_1G, SZ_256M, 0, 0, 1, 256 },
+		{ "locked host-only interleave",
+		  CXL_HDM_DECODER0_CTRL_COMMITTED | CXL_HDM_DECODER0_CTRL_LOCK |
+		  CXL_HDM_DECODER0_CTRL_HOSTONLY |
+		  FIELD_PREP_CONST(CXL_HDM_DECODER0_CTRL_IW_MASK, 10) |
+		  FIELD_PREP_CONST(CXL_HDM_DECODER0_CTRL_IG_MASK, 2),
+		  SZ_1G, SZ_256M, 0, CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK,
+		  12, SZ_1K, CXL_DECODER_HOSTONLYMEM },
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct cxl_decoder_config config;
+		u64 size;
+		int rc;
+
+		rc = cxl_hdm_unpack_decoder(&config, 3, cases[i].ctrl,
+					    cases[i].base, cases[i].size);
+		KUNIT_EXPECT_EQ_MSG(test, rc, cases[i].rc, "%s", cases[i].name);
+		if (rc || rc != cases[i].rc)
+			continue;
+		size = cases[i].size;
+		if (!(cases[i].flags & CXL_DECODER_F_ENABLE))
+			size = 0;
+		KUNIT_EXPECT_EQ_MSG(test, config.id, 3, "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, config.hpa_range.start, cases[i].base,
+				    "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, range_len(&config.hpa_range), size,
+				    "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, config.flags, cases[i].flags,
+				    "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, config.interleave_ways, cases[i].ways,
+				    "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, config.interleave_granularity,
+				    cases[i].granularity, "%s", cases[i].name);
+		/* An uncommitted decoder has no meaningful target type. */
+		if (cases[i].flags & CXL_DECODER_F_ENABLE)
+			KUNIT_EXPECT_EQ_MSG(test, config.target_type,
+					    cases[i].target_type, "%s", cases[i].name);
+	}
+}
+
+static struct kunit_case cxl_hdm_test_cases[] = {
+	KUNIT_CASE(cxl_hdm_unpack_test),
+	{}
+};
+
+static struct kunit_suite cxl_hdm_test_suite = {
+	.name = "cxl-hdm-unpack",
+	.test_cases = cxl_hdm_test_cases,
+};
+
+kunit_test_suite(cxl_hdm_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for CXL HDM decoder unpacking");
+MODULE_LICENSE("GPL");
-- 
2.43.0

