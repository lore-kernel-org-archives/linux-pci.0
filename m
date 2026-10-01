Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9324EDCA2;
	Thu,  1 Oct 2026 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846584; cv=fail; b=mvD3nAEplKMpKgI+7hv387KqMTZtO+U8FTZOkiG/UJJLjiqXttevF1EBTBN2GIK3TI2hXhXKJg6Km4VXltIxiYY0qIm8NYb0nlMxO9/saDMxnDxYCkqSIUHNGxYpIeY7fG6QSo90gqyxfgNUogz+J34yeRAOyQZM9FJqNZshO7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846584; c=relaxed/simple;
	bh=UbD91RXYpgzLSQ6R1CR///IMvgQq9FzK76nA0mBoGfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXLTshIxC0cBv9jRdQdQ4QkaSjqNjCgqUcyt79z1yNC4aMOglE09m5afBjQYenD7qxFSMPsSeEdaz4ddkG76cK6rRrDd+OpVcoN0aboccpXGF1Azb8BJGoNbcIHY6wnuti/IdRhyaGGmBOWFFQE3vbGF4Yr52tUZtc5dOcNRMXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QQlo9dOL; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QQlo9dOL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqgqQ+daPFAnywYsajxWbIpbULzxE4ZOuBa438VqSLhmSDqNGPpTx0mY13qTWkVfHFtHFcZ2W4XYdcB2vqYgCSvthGBNpvuDWxtUUmSL8aQ3oKqaiox8Dq2dkw+L3XDZgu2W9/Y0jTNuzj9m79Jf7+K9RNQuYcuxSmL0Uj5uaAc4JJx9FC69ZXaeHLSiR8X73vMdLVtg4Htl4zrDcUPWLUjh7bF2hkex7o8NDO7/iGuoiLKSDZ62qTqBqbKlA6Rupjpxj07aBHXLsTOQLtCQ10mR9Jp0mY+6DbaGIDimXaHIdyP7Bm2Nbs31zIC7MJ0XQycs8PKF2cqS6NyI1+cUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIsGZmZ/k3YZoOYnMaRtbcc8vs6/UMm0hqHi+i+5SBY=;
 b=mbe/UL1hLtEcIBcZUbkTyFjUiEuvegA6Py2YMRG2MlZzN0qpQkoKZcPJ0cTMxc9uAisSz8M58evpv2gsNkU59DJpDZYafAPwUU01UYhettTV+n9e0TTlEJUFkozTa0r5Bwj2Ok2a+xUNhZiZxiRIKEybX1y3j/gHYXd5Kb4qGyPL5vf9Ib9zMOCW+jvpVJcY2zu9P8jkxWekKMviwFpz7UGKktzJ/Tpwvm8s4HdTDGS947v1uLDn2BE70GMQzwYtIT7bUNwQ9RSYCYH4g9QHWXQ9RoCVS5RUhlltE+391BoYEVBIhSsSNX+lGSp44NXOsPSSQa+Vs3FGx1sT75KanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIsGZmZ/k3YZoOYnMaRtbcc8vs6/UMm0hqHi+i+5SBY=;
 b=QQlo9dOLg6oaUlBFaQswu9ta80WEreLZntACI6GPU1lnLPyWZb8uICoVcQCAHjJPM61RvGD+LBAEqzWix+ccaj0oLlIHhSNcVOjzdahJzZWtsmeLBdOf8BcNLBmy3jnlRMy5AkG9Ul5DO1VjgroFX1eEcV+0oWxkZ94MDHKsr7ApFlSBLTOVtuUtSudy5ZyKcYYlPg4+Oszn+FxugG7Th2wWXzZ5Fp1wSJNdbX59l0QCOEug+1biJVMbxekTB9TeNX/Gd0LugQI85aLxbI8C7KsHst5ezXkmtxYkFYzECzEaV0nEK2QpiV7XNkA4i7GKFpfUeOKx6MM7FuAPHcKjpA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:22:54 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:22:54 +0000
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
Subject: [PATCH v14 08/16] cxl: Reject overflowing HDM decoder ranges
Date: Thu,  1 Oct 2026 09:22:19 +0000
Message-ID: <20261001092227.3004747-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::32) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 5978e06b-f9e2-407d-d150-08df1f9d9307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QOrq0SDXddsbHuzrp+HwMZgi7ueK+k+toqJ6ljoHuaPjGWnqJG4vfZ5kRbX8eiiUgRKhFemUqbBjRxr81luOJmE2Ig+BY+xh5fawxsJYLJz8dDnYfcwFXWReIIkW0nUibZETjJQI0c278TcLCUaD9M/6Sv8ZaKerjbukZbeiFReJ6qJoG3XKfqVxAWoj8mX9QjjFthzduw0wi5jFSIwlccFnZn3/c2skHNNOyUfTAPrVh1GWwtQ+PgL67KknN9+wNMoiwyilwqzReNWrda635O69BVoEX1CYBbhXSYYXPKIaStxP5S2Q1bAo7vmbNeLMJShJ+rX8FSs2Q9O5AyI+zBVRBa585K+WMxgU+1ENRzHbv+9r2MPtZoPAHMyyJ3s1w5AQ1/TFU7nMlVHklcqa+VfTOQve5hkoQvNtdSfGNIoi3Dl0a3CuA59ODzBujYnvEG6pnVKG9tL9h4UA/YVOQ8hl0QUSYaysIpJlWNot8VxUTPZBFHOwUD+3+K4305VdootllpVUScoq2p1RzenVagjo3Uz+OFRQoQEEmtBKLaVnQSbtwAsJK8OmSot7ysXib+dNJKvm/OlEREpNaKcfdIvnAsIPuGXMspSKn4VTEVh8jZol2QtlhubkQeWvjU7pRMEpTlHjwObTxUDam91AaBN5bKJPrxlthtCFyGb3nrkwyqePwSxzm0dLzFjZGtF6L5DhFEk0q3kfyw/O/8jTSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(921020)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGEbpsQiGRR4GPaWYEyp2PMFKvO3KU0H+0dTOpgrQXOT4rodfoPW6VJCT8dY?=
 =?us-ascii?Q?BRYu5peGOhOlxf4T47pUdKUGt46xr2bRjGts5ukQelXMbj3VXjKcJqs2N2P6?=
 =?us-ascii?Q?jQgWomA6ESlTC3Xh3YYb98kub/vIWk5o31wHba3oiKTuG5ZQED+N10F4HL0x?=
 =?us-ascii?Q?TUCTB8OYX0ufTj3WdpdwO/J3ZoJX4RG9rcVCf8wOW3l3BgsN1t+Fy5w2ItuQ?=
 =?us-ascii?Q?lVmquiK7IWcgzrKOGtU1iMYVN9bg630cmA5gKis3ozSv5v0aDh3i8wg3oIph?=
 =?us-ascii?Q?oey9HxK71SVcMmZKu63tokYryGbldjKL5wrgXeaQmNa+Ytd+uiQpsZjSTtB6?=
 =?us-ascii?Q?CFuyfwtcqlpLuXIdpB7VYRLuCYrsjp2CbLtim/4jGt5DSHWBCJI6eZDUP3eI?=
 =?us-ascii?Q?yYULOCCaklJ0ybKNlQuX+FEog4JFuvqPzibkeajNx2vrPRPU31g83U6MlzPE?=
 =?us-ascii?Q?65EsgphBNzkR1Um/llqvT5HV1KcGYA8GntrjA5r6MaTe6QqOjALmjNpsdt+F?=
 =?us-ascii?Q?HNeTXCnfmWOS8t18qOE8YE7nCM60XYD0DanULQpXIHq0bNCzaum5WOPS7cZm?=
 =?us-ascii?Q?PpB2Ppamfp5iv5w7l6sRswbuxtYd/VP+wV+gdAhxNn35DxeLclGdc5psJUgn?=
 =?us-ascii?Q?Vph12NGUL2sPgxsqmPeVf+3EnpBlmZq8oLPTRH9bMsRBWB6MdtUqPZ4oGwWd?=
 =?us-ascii?Q?t04MQCQ0piOFXKOKbETHDGZ/54sSvogtN15HP+JhIHRbjBgiP/eJ/orYJjCP?=
 =?us-ascii?Q?mORBipQcCf4bvt4oDMSISOclW8oy9UKZ9VHcSzfyg+4APVRpboVzdFYtrRae?=
 =?us-ascii?Q?xT84qc5SObg4+CdzIyC5tEUPmNL+uYkB70Je1kBGiTcXiuX0F9I2fGWWypmp?=
 =?us-ascii?Q?iKjsvQimXNdjs1LyXAebL0TleQbDG7gi1Lrm4gI6Io/x2Lx1AjSltZud5R7h?=
 =?us-ascii?Q?LlIGpwc/p9Yv7GisiViXSAcNS48yuy78WY8fBKvuODPPNhrE2zmpkZ+oSeJY?=
 =?us-ascii?Q?T1Ulwxdyg9vW2sy7Dmj1UtGlifJu/dHOhwFfuiLki2xYb/DvD0JRM16A/ING?=
 =?us-ascii?Q?+cTUD4poPdoAlArDFslwpy+lUguK4BIC9lO5KVYH3U5LOi2N89FFRLZxbhvx?=
 =?us-ascii?Q?oXrxg3fPawahaPSm9GostPJe32thkW8UxFFwRp9D/77FUu07gzlnxPxQYMuL?=
 =?us-ascii?Q?ZU/Z9Fmptl8yS/Qzr//dXVy6Lr1HGxIImOnOAFhWBHLQVx2MteEMbuV2mJcM?=
 =?us-ascii?Q?65lFsdgwRMcR9q+dos/5DNZh0sb2jizxnxpmp2yyLMgH7daakMzPzSmDeJsY?=
 =?us-ascii?Q?cybCXh8W5kwHEWc1iubBCO6Anfeo7E0pxVomdSAJmueOeGkoIA1szLWF8ISA?=
 =?us-ascii?Q?+h6OrbME4/yhgB6wtdO8VE1iycnu7vbFBtqKSq2zpRVfx1jaEYnlEp0tFfnS?=
 =?us-ascii?Q?gLlDvyX+o5ijITKO2T2g5utHs/FDcSZt/WAiylw+k5KHvz3lEIzVU21kBfr0?=
 =?us-ascii?Q?RVeXUZ+VlXNLxo5nrHlvF/03p+Wl0aFqHF3V+gfy1R9Cpfe6cFQDl4Nn4+9h?=
 =?us-ascii?Q?SaPSJxkG/yJPeHnK+VS5AvaWkf+Z9JHsfdMrD8zWp+tjNo+mwCLTlo+G9jza?=
 =?us-ascii?Q?sypsqhibxJIRAZ01OQxTUyWokWpKjn/HZlJltI8/PHVRV6EQhu9nUswEu/9m?=
 =?us-ascii?Q?LwxRcOUQVXHp57aacQi9C+oGEfeA3i5c1EAHFLCtq4u3wqqEtN4t1Uh+hiwh?=
 =?us-ascii?Q?nVEjRZQugQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5978e06b-f9e2-407d-d150-08df1f9d9307
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:22:54.8219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXCfg/Q879RUr2mvYMX2ZQhjojZPyP8Gpr/gPn/sV7pcqEaaziIjgy7VINGYqMv6fDuzAsLkiLIfSJxhKXD+XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

An HDM decoder with a nonzero size can report a base and size whose end
address wraps the 64-bit address space. Reject that programming before
publishing the decoder range, so enumeration and later reset handling
cannot use the wrapped range.

Use check_add_overflow() for nonzero ranges. Preserve the existing
empty-range representation for zero-size decoders.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 8dfeb12de8c9..8d2fbc49a06f 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -115,16 +115,21 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
 	int interleave_ways;
 	unsigned long flags = 0;
 	struct range hpa_range;
+	u64 end;
 	int rc;
 
 	if (!committed)
 		size = 0;
 	if (base == U64_MAX || size == U64_MAX)
 		return -ENXIO;
+	if (size && check_add_overflow(base, size - 1, &end))
+		return -ENXIO;
+	if (!size)
+		end = base - 1;
 
 	hpa_range = (struct range) {
 		.start = base,
-		.end = base + size - 1,
+		.end = end,
 	};
 
 	if (committed) {
-- 
2.43.0

