Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B7388890;
	Thu,  9 Jul 2026 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559024; cv=fail; b=Mt5hOJKwKGXiNQlq5yK0xm/fMMVPBarMVVTBMbPgmrgEYjeP9d4FAlEiO13tEV3psOOl/GkUHzJw9ogBmjaGfWj4q5gvcCsgbNzPl5fT5BTpV4JmW+L0GqQaooErzyzTa/RVgxrFzuhsr2LvED9/kxBjwcm/gC+EVWvd2eVvLxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559024; c=relaxed/simple;
	bh=gQ1M9uIXTeqJQK1Y7kCN+Hgo+q6bQDyF0MJZhZGYntw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUcF7mUp+7GcoZ67k6uvGhxPRqOHLlpirr7RehssLY0HkQnLYTLYxhpvWSoY2YejTyOIfIoF7/DuCriAQ1ntphy2BzVxqWaJEg0K9SOb/hXanQ1t06xIFJ9tuUWY6cEXKbah4J6XQHxdnE9kkPwzbAjAPpul5MfISEkrrmwNxhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F1wWW3Es; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F1wWW3Es"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqaHs2QT4VRz9YLiJvUW9gpS5YRMbmSN6H6VwDw+gTFoxLCVhkFR+KGpaA+004N4spQE51BdSigWxE1g4+lNs0XMaOj8bIVWjP1Pc28t+jmM2RGVDxJx2AwZug3x4G5iTmb2D9MxGxcviMV70a7MyRdffE2X4ISHbD4ERe65Er2CzM8f1SODpkijUCyrqhU3nAKuWc11OEPPuYt5wIDurVAToNt1k3nZ+AvbUOy7SKFCwJttLAo1u+dUZE5hE24tdLirQDKddEnnctztZexuq97JaI9qbT+Ch+JCno9z8DdB0M7cQcFexlZFqIFKqM1h93+x8/nmSQrYXN+zJQEWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G//Dlp8cex732/sNn+Hs7HNcInYNQHrgPsz5ea6kM7A=;
 b=QZOXBpq9P0J/8uAULsKP+5f5vU8lvn00R76V6QZHiY+96gjHT7k/HJ1c+K+xRa2HmeoDjqGC2MoakqbILl3j9C+iWwCT7ylNuWJ4bNROzO0OuVYPwFjU02b4s8mYw+SdIMesAZUR1MLAyO9dEhyp3OtpQ3mVuQWxbjrO16Y0+4T+0nT16synOv2INvBcucDBZzQrZU5k+oMzo38An1CLvMLkPF3LYIsl098UJo81N11vkKyugeh8MbKabNjNmrEGO2aF4KXrhzC2Jtoeg7nEZ+g/FkeS6QkZzg9JUn5j2TosuMgIS4OAqNbbB47buNSzYYyowLUIl3ppbFnlYldbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G//Dlp8cex732/sNn+Hs7HNcInYNQHrgPsz5ea6kM7A=;
 b=F1wWW3EsmJ7RJs5/uisSjvxmhPVZqgTPF6T3RojEmvY4wbfrEnHglboEuQgyCumuXZb2SrwvidgOrlTDYEQR5TyH8V0JtOR3iqyHpbjxBLBprJQtjeMQB1enIuk/t8KFCb9Qo9ekfx32tnjMIk+5FCph7F/lnbszM+OFK+dc/MPbfI8lvzsMjprLEmmmDswDFPY6AIlpeM9NELm92DnGzZlyVw/ZCKW/26zLXYgCQhHQtZ9wd5wZZDwfkyk9pwRQyURnDmLuWB5efvJyF7CiCs/qTutPv8twSgy4To3ONuJxV6q/KUOMl6v/0breFd49G7QIZcVwDtL1MJWE/Wq/kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:03:40 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:40 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
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
Subject: [PATCH v9 03/11] cxl: Share HDM decoder decode logic
Date: Thu,  9 Jul 2026 01:02:56 +0000
Message-ID: <20260709010304.680422-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::24) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: d2329858-e519-4769-14d6-08dedd55ea2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	GJivrXsCT/kFVzrKvnsOFWZVhKwaj8z+tafjfdKDcZmyX/2Y+RCflAMLDqF9wehm4kHcqi4gBB/Aw+b44zsDnWWCF1kFSkbbjvUKC/opXNH+66grR33nmdne/9C9pKZV6pMOThtSDREH6sSwl6hFDJ9YsjuOO0mVERqbfbFcYPUK+gbmnmxqBZTdKmpQh7ok4sLy5aoX6DJrDc6qAEFqopaC/iztJDiPznshe2+2mDsa8zC1e5ANcdZwo3wt9Ep2ra0hjsBrCsQ8mxkA5cuRRMsIwscUk2+zHTl+CfqUV+W/mNJLjx4xjE7BwtYIalYYDkak3eEGxYQFPF1R2hClYRc6WqFKRCjRc6F2S+HMtiTW78J3dXRGhsHDN83M2ojcVMEyhY94Z1PCaX7MFoc7kYpRVhB+n6mrm/YhSCS3D4OBf+X6ax7/F7LIcQyfqxzU4BbFnnQ498hc/DErHHXCVizoV8BDIZQuBk1MeYLVYNALN/DjykEx7xDoNpbDbLxrRms8Xxc5N6GJD4Sw7/vpIWJP0UxUTxyUJliDvFbOsUSH7mM1NFUWVb09nKW8VYW57WQpbRO4M4i+zPimUqEXfjMH9Cl7xC7Uzcf3AHdYLdcCDCKkTqXc0Zteh9ydgorp3RJ+2+CB3vHZHtmdHy0ULMiwjVvn3HbZB2B+3v1lyv/6fv6ppOLP784cnY1y18HuPA9ZBOUuUI96gD9LNnbjPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IpYXm1xZPxcfnz7E4ldPvyW6vjwQvb4NHWs3sS/4eumzTmedGZenw+zSqvoD?=
 =?us-ascii?Q?ertMX6sBzPxy7WFXkNSnHlK91ri62hl70DWhY1YrIFCOuSxHla36lYC9J0NB?=
 =?us-ascii?Q?GarLs2XDFhHGkNckQ+a2X9Y2u/jP4Z8UkoKIjoQDTHMHtU18T0QJbds91IHz?=
 =?us-ascii?Q?ZrYTP0k9GqsccmgW4u8L+TQ4uEKEepqisVXLFhMwSaMr+Vc+R5zbyoJetmZ0?=
 =?us-ascii?Q?uif5zTTVeTuxgzZRgGh7zZdVDp73jyGmMoerBEAzx10WUQ3lAnGGtvtDZKdh?=
 =?us-ascii?Q?W4o9dY/79CpBQf+K3It1+Ox+LOoFXwW7BI7B8SY8v3FOsWtY2u1uiejjIKKw?=
 =?us-ascii?Q?6PKVZH/0KnfAIgMAR2pyXHxCZLmH8inbZVIuby8helHblvBx+Hr36Gz6KQKL?=
 =?us-ascii?Q?N3YJ+kOo/4F0OsnwyMiJrqWs6Ulfhh4BFdnvSpwC4lnFAeLEP0oVypmlvBF3?=
 =?us-ascii?Q?KXk8ki8dKJyMHljhcKKm6X6HF33f7m0DDNZfbzuXUZ0/zxyklQYSOSbKtptO?=
 =?us-ascii?Q?oa+z8ium/+F0K2gRA/IAtUCUktgRm5ykXBVhecdjMNdih7gYPyJwat93r/2q?=
 =?us-ascii?Q?no6gKUa+XntK9GnLqHRhicg4/36W4nfLQIaOFX1vvmZWKmMJ0SiyPdX9e30Z?=
 =?us-ascii?Q?pbmJOlKXw269ixkZ/CvXgIS6Lkf/tDwcmjoQbN3NlmQFzv94d/G10/xTm76N?=
 =?us-ascii?Q?kwjVoGgjG6rnquSL5NPMXVrn8NOaotwFPcApkMKk+3HoUFh31vsQ7TiNnFCO?=
 =?us-ascii?Q?Wk+NwiA/n6mjJvy1Wdj7XviNn23OkgzHDgOrSK6J8p89KYD+6cDl4yOAy9Tv?=
 =?us-ascii?Q?7+ZjIo2sgzUOLQmsMkCuHzaaGEiwbODwDYmCYnh978uBNjpIUCMJcSedNOwJ?=
 =?us-ascii?Q?1LzI9ms1H4JC67mLrnow686oE1vo++j952khSPO4BnmPaUxUyPdf5p8iNGD4?=
 =?us-ascii?Q?Pszu6QNXGn7Wy84k8Fbk4Hx3StbeJX0SWSdIu2aXmY6UvnScZ5Shi1Jg2yKq?=
 =?us-ascii?Q?zDrAc/RInnTJekdSUYGZ4wvRCakPvnPK/LmRtuRSftA9DkgUp5DI5Dw9b4X6?=
 =?us-ascii?Q?g9ZTm7jfvjC7zQNO8rZiQ7mFzE3PjNjpgl9OMT/jusrXTySQ3XGjSVXAa5kx?=
 =?us-ascii?Q?f7PH2WZmMX2j7bkHlBSNP73Ma6VzSgTE39zZ9WXH+edYhCcXq/1SwS1q293Z?=
 =?us-ascii?Q?pz/UPm1a0Wnh8+gAc5m21obTbRIai83ctX4gmSHSIPA1LRansFLYU+JsZMU+?=
 =?us-ascii?Q?dRq7Z1jdSLrGRSUbTXVfcFO3KmHMK+R8iUeOW0Refc0FeuUoUNqUbMZhXH4+?=
 =?us-ascii?Q?a6UXPerHiV6PfQ4ARmH5in9GzwbR/QR2I9Xs1tbqnw5B1EpwsnyLgI1dxozR?=
 =?us-ascii?Q?HQAMl5gNhCtdvL4hLTxUMHblLNkk3n94T8z0SLtMIw2s+OOE8b1LZ3W16TEA?=
 =?us-ascii?Q?He0WwUQZ4sMUfRjGa7dNmFWx1x2JfSed7ItdRlnOOlaW6LwteusqGXC8rUaE?=
 =?us-ascii?Q?WI1HiSNgLMvO/6yUoiHuPCmBSiOzTFWHuGXsgoTbq/ALKTQictuU0oL7aTCJ?=
 =?us-ascii?Q?g360qRLBlSA48W+022qMg0CI5aSUnga2Oq/ElfQirBxsE2pjBoKEVfpCIsVy?=
 =?us-ascii?Q?Qdb0ta5ea33LimPw6xYjRX4uS/9+wFgZSw53SHhyKanUK0gTFyWhw5sctZDh?=
 =?us-ascii?Q?b9LL/Y9T5p35p85FCtl7doqbT/HEQ2fLsJycHexqaBLVejsKX8Ik3+9g3YBE?=
 =?us-ascii?Q?FQK8X+Fp8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2329858-e519-4769-14d6-08dedd55ea2e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:40.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVbWH8RxXr1auGe+oQOjd56Rh25d2wvPjnyflC+4Sf0vD2Ca2xXZ9QvEQEhtbVvTwKyAL+lM7luDn/8geNz8Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

Move HDM decoder register decoding into a helper shared by normal CXL
core enumeration and early PCI HDM cache setup. This keeps validation of
base, size, interleave, target type, and enable state in one place before
adding another HDM parser.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c   | 61 +++++++++++-----------------------------
 drivers/cxl/core/reset.c | 45 +++++++++++++++++++++++++++++
 include/cxl/cxl.h        |  3 ++
 3 files changed, 64 insertions(+), 45 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 83cda63f76a5..e9e00c68a0ad 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -952,6 +952,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	u32 remainder;
 	int i, rc;
 	u32 ctrl;
+	struct cxl_decoder_settings settings;
 	union {
 		u64 value;
 		unsigned char target_id[8];
@@ -968,35 +969,28 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
 	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+	hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
+	target_list.value = (hi << 32) + lo;
+	rc = cxl_hdm_decode_decoder(&settings, which, ctrl, base, size,
+				    target_list.value, &committed);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->id, ctrl, rc);
+		return rc;
+	}
+
 	cxld->commit = cxl_decoder_commit;
 	cxld->reset = cxl_decoder_reset;
-
-	if (!committed)
-		size = 0;
-	if (base == U64_MAX || size == U64_MAX) {
-		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
-			 port->id, cxld->id);
-		return -ENXIO;
-	}
+	cxld->settings = settings;
+	size = range_len(&cxld->hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
 
 	/* decoders are enabled if committed */
 	if (committed) {
-		cxld->flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->target_type = CXL_DECODER_DEVMEM;
-
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1036,32 +1030,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
-		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
-		target_list.value = (hi << 32) + lo;
-		cxld->targets = target_list.value;
 		for (i = 0; i < cxld->interleave_ways; i++)
 			cxld->target_map[i] = target_list.target_id[i];
 
@@ -1078,9 +1051,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			port->id, cxld->id, size, cxld->interleave_ways);
 		return -ENXIO;
 	}
-	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
-	skip = (hi << 32) + lo;
+	skip = cxld->skip;
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 14f024098e82..4c977fc47f8d 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -116,3 +116,48 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm)
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit, "cxl_core");
+
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed)
+{
+	bool enabled = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	int rc;
+
+	*settings = (struct cxl_decoder_settings) {
+		.id = id,
+		.targets = target_or_skip,
+		.target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
+			       CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,
+	};
+
+	if (committed)
+		*committed = enabled;
+	if (!enabled)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX ||
+	    (size && base > U64_MAX - (size - 1)))
+		return -ENXIO;
+	if (enabled && !size)
+		return -ENXIO;
+
+	settings->hpa_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+	if (enabled) {
+		settings->flags = CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			settings->flags |= CXL_DECODER_F_LOCK;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &settings->interleave_ways);
+	if (rc)
+		return rc;
+
+	return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
+				    ctrl),
+				  &settings->interleave_granularity);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 84924ca06e52..80839517eabf 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -133,6 +133,9 @@ struct cxl_hdm_info {
 	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
 };
 
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed);
 int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 
 struct cxl_reg_map {
-- 
2.43.0

