Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285935;
	b=h+ZUCaSTO565H3sRb2CMaH87IWbD7T/87njNoCkBex68pj8cdCpVHGkTmaYKZXrwJcED
	 3ieuxM7RLynK82mgXPVietltqEFotx97jXwGQfCzXCKXvLVqQDE9nwjGpwS74Uxf/VPW0
	 nho34oZwHPvEDQGiudEtniRwYpChhEtoP7znVHxmOs44Z3SiETxcjeSRwZp4F7UzNhNNN
	 5HFUNVXhQSqGE72vCl3yROyZnehJmSO21PmEpRg/1dkH8axclLCE06+Q+KRHdEecRvAZr
	 tEF0bcWf0J3/ycYRwbcmJeX9F5BCeNsnSJNGxP2HGPM/Ns2IXQIZsLGl84i72Z+36gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285935;
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
	bh=Jdoi5iGYYUNpjsjdpowaGBt1Z6vstAq/CY7iaW6SAkE=;
	b=TGeqTA3MiCj7gXaPf5fxnhzuDZJ4MdYnTJMazYzmfRvFUZqDqjHXsmGXsTdiffkiYXqG
	 4nyjQJ8QYkXbpRAeqMyl6XYTQ0vtqj+MjGCKzpDwc1f9lmAJRMVVLRV0PXNMmuk4PinbU
	 RsKI/JL20hGDpnRzwSr8W+KjPVMcqtU9RIiR8HcEm6U3bK6hFo8bNknA/a2MnU4H/pwwz
	 90n7EPTmUFs569REKkxuRlZOenSJhWn1CPQEhqAlWQJJEUSFFSN+OGVUePdN1bHPpIaHZ
	 w/FAPGkef+1xssEMdaGB9rAFIct5+UkMLhkX9kjYPXhPlJ5SU5jHJa2mDE5eCIlFzSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W8lEpCCN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.44
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4B606A31A;
	Thu, 29 Oct 2026 14:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC4B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W8lEpCCN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XL/KOpFQB8MUfrGADgsCbbj5RYnmddmb2cBR1GCptAFcSLsg5dGXlYGm/c/cNIsufvwAZiXfW0Hn48g0warpon65R1ZE3whNCZfUim2G4mU28EGZYbpd0ZIzEuH+SMMD06zEjCcQ0asH0iMxf7VncNqj73tc4uhM+ajBdvIEpFLaa4I68qBRLZmPOQFBK8g6YS2xFz3a2huhaqrqksMrHK9D7zoM3uSf+cVJ7NLLNlu6goc7Hb8rbdKh+YPqAXrQ2lfpTo+AC0TniOG80o3bbsci6JpQri2+crzrLU7WjA80U0/d/+93jgemXlFR+7zbcklEX8eT+nNxIIM2sZNu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jdoi5iGYYUNpjsjdpowaGBt1Z6vstAq/CY7iaW6SAkE=;
 b=iFzd4Yi5gMFXLAwtclalAhD4HyoyFs8GX6O3uyj6jkaDL3K41AIJSdGJqhTy6GLTPs6wazo691MsK0Stf8keXEIh4XeauDoQcmE4Zze5z6M0WIkcmzX86csYY9KKHSay/4eU7G2M03w+ocz1TiKgwMs6K8RgBKUKXyEpmQuG9JbAxHeVOFybzuguxLP7cEloSmRM3TVpeaUbJAtcBib91Dw5Pp/XDOz8cLU1td3aCMPW4cseRczs9SM4eg6XNBdE9I22lK8fniTacBlZlInDFGAQeVN7OlFG5t97QolSHFXq+mLmWZTx9O15t7mtmYceh8JWQuMJTYDaS+SQOq0Wbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdoi5iGYYUNpjsjdpowaGBt1Z6vstAq/CY7iaW6SAkE=;
 b=W8lEpCCN/ROqK6h7io6UUz3qzonZ0vX47H705RW5ans3maMJVSk27ZQN4n0sNk/swwTrS9JJ95um4jYZS3W0UliNsC9+eEA+ucOh69YEfgMdSN4IEhslatb/7fEeSDKdOzgBkFgzd3B+03/Sa7bYAlsuLQthGj8aECAeatWLp/XEm134QJJSNlzWE+aWuHIpkJt+PgGP71C2wlPbxmqANZfJRRi/OmnGQR4b8G4OJ74GGHxCrgzWF2xfa2svJliTLzq/SLA6TCNMycVSBB1+Vgo5720Hc029RUZ4f5MHWd1rNOoGAflmSGDNA+3kp65Drf85Klx3kJ0SfBFKh+60Pg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CH8PR12MB820196.namprd12.prod.outlook.com
 (2603:10b6:610:32c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:58:02 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:58:01 +0000
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
Subject: [PATCH v16 18/18] cxl: Add KUnit checks for HDM decoder unpacking
Date: Thu, 29 Oct 2026 14:57:03 +0000
Message-ID: <20261029145703.2185231-19-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:303:8d::17) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CH8PR12MB820196:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3b9a86-b590-49fc-e4b1-08df35cd06d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|921020|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|10067099003|261021123027099003|261022105027099003|261022113327099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uMttzPJG0/pBX/1fYeLvRotNrQRrYKkeuZsE7WfVqc29HrUBVgjJznFrSfEJ1lZZLYOiOnYT0BOnP7Xc6R3JNTV+KYgJEbDtsRuMFZDvoeHyqBExzpCi2JOzwKtzKkdS8YrBK+5SR3IMXEfnS2S9AZnib5wUo9GOqAGKFX0uBPgZmy8ebc1ttFZkKTWksbuDxS2eJaAAmjPzB4G+VkoDcq7IOnzldGhycuspnBct4ykodT18PHh9atAVLFyjP5zvy7RlIpw75E7myY4E0aLJmZH95YLffW6gX4OHUgY1VLyMMTnDTRYbmUrK967VCevkBDRJLuVf1CFDMs2HY3WDm1nqMsSOmt3SBJLijOOcOXfiptiZ7An4MMHs78gKqTQDDHRFu394/k2offa1KV3CoDJN+vp1Rr+chjo8ufO5tFXA30byQk5V+SYKKwTXufdlE+7bMCPACadBX34qTXQZIdB0FqhiMoX2uEJpPusy8FqqyKpdbLyIpGzY4AmdT8tcHE1Skb5rzAmauzLjctLmTjB3lfCZ8UXcvGAkX2nSGiSz87uUYb/51/VdJYO3X97Yg5D7/GBo460qLdJE4zlDB45OZK0mFwo6eXycSMQFFApYis1jN9N1aD2jHzjqOu8Pz2HmqCACrjr2E94wB6t/+GR71HW9gVsXPZ286XuuN7NAS6DuYH+mVit6UKN0Yl0G7zu1WxNbqGdDT5KBQObhuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(921020)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(10067099003)(261021123027099003)(261022105027099003)(261022113327099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RmVIjDua8fE/RO2Z1PAK9LxXo+Zk1+NpejpExICRbRGvtoPRaOvnf0EymqGY?=
 =?us-ascii?Q?tC+ZIeMI4GtZ5pjpK9yIITxqJECpBt2xjRXolRcGLKjG8TvcrUT3Zp2qiwyy?=
 =?us-ascii?Q?t/VFOugjq3vVD5uT2+u9S8OLt0j2I8niMZd8zj+uCGkdJ21KOiCWGEDg1DQ4?=
 =?us-ascii?Q?uuOSXQKK1038Kvg02pcSDNqIUvmZw/KhhkBKtSW4w+r7f5DkUqsojGv4hx4/?=
 =?us-ascii?Q?oPHDi78zZ9wqYFnDwlJcjoyHXAvgdYeltlXI21TbZ/tJOHWqSpC2naIFLua1?=
 =?us-ascii?Q?j9X4h9ZDqf8ZPQ+UCv8QRfY4CDUKcCrEg5AunF6sLy8BqebefTFnZyrEAQxc?=
 =?us-ascii?Q?nPGj3kQGpr+eCljLh9zRE/637B34KeOPKXA+xrS38YVHDe2ibvLn7rZuF1Cu?=
 =?us-ascii?Q?2ojynCZD6wb6PzQfWp9ee818WVDntT1cV9u3sn8QE58/iY49KkXyltXZaK91?=
 =?us-ascii?Q?KEBPm6z6cq8kgs9qufn12MHsPlSjGqQYz9Pv6bTmIK8IFb2tslxXBRStlmMX?=
 =?us-ascii?Q?2esISjfo/GS0RCDk+uVyRKlH82NjYwx7D/kPNvJuL+NAwbP2frQ/3z0hMD43?=
 =?us-ascii?Q?+4OgJU/TICFTottvqLZ6GGKi80Iop62Ftd9q/Sp7gRvqb1iEaMlK7LjKixv7?=
 =?us-ascii?Q?DweCE+EugGItiTRUbM+knDn/3sZE6VNoA4OJ5nvaXvfQZfFG494/274q72vi?=
 =?us-ascii?Q?soh9DwJMdbjynpma4/AZ8uCeqRRlEgLXnQ7jX4vrlazzf7lW7d14iHw7eBkq?=
 =?us-ascii?Q?dC0SuuZVhmPhhxAmfUxrYsx80a/divr8wsTz8Aec/ynTWOxo3qTYZWdIFh9j?=
 =?us-ascii?Q?KlLfWb2wqiUNbuyYsh4utSGm0Nq4QtS8Id8rtlLdYImxQ0SH+jXhT8akNj/b?=
 =?us-ascii?Q?lP1c21kg9VONUUrSx9leuRX1mIZojCZY6ZoKQOUaS8VGdrxKP86G+OCAZMtL?=
 =?us-ascii?Q?8bL/HJgQ3bc7V+eUgrsQvuuFITM0eiedu+mwYJqoIOSnKuSFfGKpc/OiHNA3?=
 =?us-ascii?Q?v0IujuaB/vtTQZG2WgR115RxZVighoYhDybYgJck0q+SCEzomLgXcMKxmrk8?=
 =?us-ascii?Q?z0DuMuty9jw05ODAiSNQgob3KuZnmcnFCiTTh3PHjGKLFkLpSKxI0ASTjZp/?=
 =?us-ascii?Q?UXJDkw1xGbL3rdkHZq3F6eDk50ga3A8J0kbrsOdwpq4Wi6/83L8XZetIsTVH?=
 =?us-ascii?Q?+EVdRaDBfbcgRf2LRILL7IsVVprG6CSm6klbMLP0qWqHHkFPbPac9Fy97Ew4?=
 =?us-ascii?Q?t7q9nvpD84pGxGm2BXpUbOViEbWg1tXXyf7ywPa5ILgXkKxNMUUHa88ktg4P?=
 =?us-ascii?Q?N0EuGbfH7eyCOqVNDs6TpfuVrq5jCN3OYV36gpR8N6HSbbNsptEekLVahodJ?=
 =?us-ascii?Q?1SVJ2Mf+twLK2pFstE8DXVUqRD+z8YsS8URp2+YsLNzrZEJ2n53HXQFkepuq?=
 =?us-ascii?Q?6MBV291kn29JcnMHtu7PYfdcKTiR8lwULgqU0jQQX8CGgEkxbR16Qp3jV3dE?=
 =?us-ascii?Q?6u599E4GsSorjhbJ+VyWwncanwVPFi1M1avzCRzO/NaDHHHWr8ltBZb/mnOI?=
 =?us-ascii?Q?ieIyYi0W2akg91Zu3dY/qw5/Wth49UJjCAwNyriqLqYnunvpXGuZEdG/oU85?=
 =?us-ascii?Q?CXELcj5u96lpmtlMLhikyzZbEbxDtnM8OpKVLweLFZVK0h3Ca3uHGWdmnbtz?=
 =?us-ascii?Q?HWFUdImnPhUJ0t2USddlnytKfpAItuSWe+4a7uCoQrWBuzQ0Ksiag+3TwH/U?=
 =?us-ascii?Q?t9Bd6a1GCw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3b9a86-b590-49fc-e4b1-08df35cd06d1
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:58:00.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kP4Ll6C75msTENFypZTx2YtrN+VXFq7dv5/iRsvz867CG1PHyO3ttkcbgItdKzt3Mckk4j4d66dnofMpbcm0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB820196

Test cxl_hdm_unpack_decoder() without a PCI device or HDM MMIO. Cover
range boundaries and overflow, an all-ones base, zero-size and uncommitted
decoders, and a locked host-only decoder with 12-way interleave.

Run the checks as a KUnit suite rather than during cxl_test module loading,
so a failure does not prevent unrelated CXL mock tests from running. An
uncommitted decoder has no meaningful target type, so do not check it.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/.kunitconfig             |  4 ++
 drivers/cxl/Kconfig                  | 10 ++++
 drivers/cxl/Makefile                 |  1 +
 drivers/cxl/core/hdm_regs.c          |  2 +-
 drivers/cxl/tests/Makefile           |  5 ++
 drivers/cxl/tests/hdm_unpack_kunit.c | 90 ++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+), 1 deletion(-)
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
index fe5e65a9ddb1..ef1b0e07c352 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -174,7 +174,7 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
 
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
index 000000000000..6e5b59ef6309
--- /dev/null
+++ b/drivers/cxl/tests/hdm_unpack_kunit.c
@@ -0,0 +1,90 @@
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
+kunit_test_suite(cxl_hdm_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for CXL HDM decoder unpacking");
+MODULE_LICENSE("GPL");
-- 
2.43.0

