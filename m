Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905179;
	b=fD0fYz9zdPMQ3MR4M0tLa9EYvK0q8dJo32pYiM3e1Sv6eiU0H4ljzUKzkzd0HUOVwNPl
	 sIcOdfQ/9YSIQg+ODY9w9haZlgH1RBhcMIC4G2hJfqN2IHQsgj0hAGp9EzrW3MgbydHiF
	 piK4aKIoYxz7rTq88fTrf++fyL0EYsV5jSwP3OpF3a+Wd680F7z03UG8iP9buwl5BGXWM
	 jKWLfjDTbPQOj59D44OrachSrvJPzVK2FqnvEBDW/IM3F/ZPsjd8X3FcVASZ9Y7wfQJgm
	 tPorw1xnuvbwpZgz+DAbGkHiKpZrmZZopJSorIymeDuHXakQqAetOJvVQmGjMFFpzMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905179;
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
	bh=7t0NHwciqotYgoAEt9njABPXmUJ2kdg7+CuRrdg1ZL0=;
	b=xY68BMl0giVxgCAeiHFJtwAUwYl0s21TWGoelS4E0S76x3K7Y9qwJDkesoUuJp2xBv8W
	 EWIP0OQBewEXI6188jVFMIuJGAPOsJ0cfduzZRFcRSePCgFb+87LgcNEsnsXg8gqNzjDw
	 LhEYV412L9m0xsqtwHj7E82BDd4w98SdknEMnAp3oberHtckDSMjcXLGcYFYKzmvBq4Zn
	 yjJG9eqfnAsUhxaA040Sc9RGszjnD9a81krq6nd0WpZLr44uAmEnkNwQxOkK1WGMhBsUa
	 AWNFoDnwpblsTVuU0EOeKJ2Aoe2Xt/AaKqXxGEucATElHXkCHP6uyT2MeYa7w5FUDRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ko70VPyG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.19
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968C606A328;
	Thu,  5 Nov 2026 18:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5968C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ko70VPyG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5xhK/vmQfjGKXM5b4JWbxc+wqkyny/TSvJCjR7JugW8kj0fzdtMyJV79cvyvN+0XFrs2wCAwV1NYMUvQzRThDJYUkdcwfU3+MP9vBx0bTIW2TQaHQ/tsiTyYPUB+KfN+FmjPk7R0RHH2/eoynfkCYvVGkRJ0WqYVfOjCbmzdJYTugD86KWlWlNGwHKfqgp7Pg6bxWi18lby6LuA0ncPL4XA+EINuPC5OBYEE7nQ6nR0VRt4z2YAC8qOMNtaPNIRT05n3C+TAftml/ATyfKhFhVAl/c5cZqqxpNbgBRTqhxo9V6F8JucaIYKRnEwCbgjTjFK36A1keyWuPAARBtPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t0NHwciqotYgoAEt9njABPXmUJ2kdg7+CuRrdg1ZL0=;
 b=dcn3pglJV5UDZwtoCQoWSsBGumxl81ydBPIe8SQjyjxlCEzdXeP7ej3Bwr2t43K9DGx8kqtOsMSgxjeLL/WBLWi43Ta/4hvPt6Ofb8VMaRHm/o5fBi6RdDeu9XRmrxay605qLbj4NfDO2NM3vhxoNsNn8J0CHFl7xP/lCG9/oVhWmZiImLOu2ZMUyAhrOPJd9QBpoF+WY/Xajj9kTwcV2PNSUHK0PYPRqHiBDxPrf0zD1bMDzKGp2U/sdOMkg71h7Pkm/cT408zOP2X4oXpIHzI8CFXznxiiVqiKVs4N9FMBdZs7hevap4FYtaAj8WCiWKIXLZeqZ+tV2oxvW+GC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t0NHwciqotYgoAEt9njABPXmUJ2kdg7+CuRrdg1ZL0=;
 b=ko70VPyGys9fB4IKYKpz4dmts/0zsmum2ncF6NfaOOBJKfFz6VQCDZIo7k9R8+qHk34d231TpFYvf4F0c4Kk3FhR7T5MNV6nXZwnOnhiHE3yjG/zj7l5TJiBzSk72LUftA+7pCUVNG0IFVzK7dMKXlPtMjOIz8iLQxz7nEVociCQeHgHiiCkxRuEFfu2lyUfftUQJXctZkvaE+lLGld23qRuyjTQAvhoxSdqYvWiE2Y8rWFRdx1sX0pZGk7/B/hW6chlpHnB/JuN0VZ0HOX57mhbmIO9fT252eiLmdh/ZdiMSDaKB4cBgH2XguL+W6Z+VL2Bx2zuAW64+kP7TSJoow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB733495.namprd12.prod.outlook.com
 (2603:10b6:408:423::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:35 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:35 +0000
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
Subject: [PATCH v17 06/19] cxl: Move HDM decoder helpers to built-in code
Date: Thu,  5 Nov 2026 18:59:04 +0000
Message-ID: <20261105185917.2667656-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 688a1249-a92e-4321-b34e-08df3b6eef0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|11063799006|261026140227099003|56012099006|261022113327099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003|261102130727099003|261102123227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	DscA2BTnRNHJFqA96CU/AzxgUOej0UN1C5tmO4LsA4By0xiBGOmm14Pf7kUA1zWWgm6aVFIeSCpLbbe1yP8gPnAsR96PIlDApz674K1mnff/0UPCUiw0vxYe3TK7ON0xf7JEB8UX5ZmBhBRTTp2R3pceBALsegCxCYCyDNZ5qOILef5GJnuhVHgI+JIv+ACyOZROSYHaEyVvOGnlM7qZ7iZ3FJLA1Lf7G9eWJT3b5aNmZQRIgtzY7cml8tYzBXXqEg3qyHhVbao0C/jL9ZW58KJF4fFpm6PojtaxtLuwMbUz42i0YayAEXBnP9MmfybkvIGvPR3Sn/dBCaLwTdcEH5Nzm1iaD0xyZE0XlOfiMJqbcK/81VBgOg8zBGO8frWC0rxke/WPDDcOODv6DMTGFEry9LEHajOFzJnr7KjwQJZZsDOLa0hI214ymnfXRMGgKKNW6U7/4VBrYa670MJoDffIJ3vlDG3zVgBvcsTiEz3NqAazf9sUbcntrR454M9rySBmXrvWhhrfq8QD6XO18h9u4cI2xZNT6MKuBfkdZ4sxQXstXyXp2jsvvmE3WBkvM7rCXSFlpFvUZ8j+OG1nHA/VEAaShhvgiD+0NucP46T5eYK6dTc+iwKSv7m9OjWz35V66jizQczF8bzSW8EqOCnw9VkjOKfxMWNYlHRyS2lPGUERBrHslBWZ1ZuoVfQ1aBDcM48HaR5Ls8vcNzWNEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(261026140227099003)(56012099006)(261022113327099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102130727099003)(261102123227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2uQCwNTFHiVORCwxuoLCFIbtQHIMgP/rrUdxJFkLW0i8QAWEfTaXZf6DGGNt?=
 =?us-ascii?Q?vprU0W1sEcZSc5k0WT/yloET70aXTJkNWIfb9235mfUSKKEIiomQ4fUpG8l9?=
 =?us-ascii?Q?KUWYcIaEtlu8n2GtQ4pRRL7llZda4wyD1TWirtRrrnxCFNZUH1e9uoKS/ZZT?=
 =?us-ascii?Q?b4ReprCWwYVHxSuJ5R8fFXd+OoGrI7QlT8QV/TTMjX+ggyUoo8jssDRpm1Vt?=
 =?us-ascii?Q?j+85PJX8KOYy8pLO/j7tC3mLrLECjzVrgBn3GLiNtHKgqJrgmwpKHhjzzAd1?=
 =?us-ascii?Q?nPLsWrUyKA76EG6Wdqr5wTKis5sWgAmSF0bDBg6kQQ1TiGZb/oqFMmq99/P3?=
 =?us-ascii?Q?QX7/wQU3F7zA50Xy3i+fUQ4eVtrRaLipqkdK8K7ppsbgWBIhaJWt4oOVqBKS?=
 =?us-ascii?Q?TzDli1jGRJfI/aV5SrlOstMCVIajMfojpVaZQVQuA7qr9h2dBzp2Adufg4JE?=
 =?us-ascii?Q?pwuKYEw1L1/IqC9i+5Hk5ITR7MOrym19YJaBcXPBe0FRJVAgFvVB0Kr9+wwI?=
 =?us-ascii?Q?9zpd9pW6R4vasy2nAlNfEO3Y4qxYFzmnzJvUaDlhdPAEjh6k73KRBuC4XjQ1?=
 =?us-ascii?Q?tUnUbwetbBUzdw+6Z9pPjO+A3CT/WsF4DdVMcXsXeOmzGNxfJhGCuuijDclG?=
 =?us-ascii?Q?+OtS5p4Dlicd6cm98dZoAIItwbsK67panSYC/5InLElATm+8HpnhENjqYYwE?=
 =?us-ascii?Q?Z9mFkD5WpZ4e+yitYpmPOEM+SbEC0KqRF8hfXDV2f0gEGDGtiDRMG9fhpjb6?=
 =?us-ascii?Q?OQY1wNge1N+lwf5MWweROTSmDfyAmgLeoXKF16TyiM2CFGVSnuy8k7j80so0?=
 =?us-ascii?Q?M9NaTfClUD/qhgJqdRSEJ4pYAKW3Bcxu0mOAEEC2/v+eH3Q2pH6WYaleJhcU?=
 =?us-ascii?Q?anvCxWbriqquSrnw7sMFuGTN3kdfU2BMgeCI+0worZxM2ZUDQcCuHWmHabbk?=
 =?us-ascii?Q?iahs5yxi8paQT5Gj3Gl+bXLnNfKhtCuLqYqj8L2C79SRwUR5QYSYo50uf8Z3?=
 =?us-ascii?Q?zwNmJUFaUmXUkd9iywfC465iO9Lh6W3xwAsDdcyzlKQlnpHHD08SmXedjR3a?=
 =?us-ascii?Q?j7EnOjkOsNLu0keJPlwhgkOQItsLFlzZWIca1O+zlj9PPlJYOsJoySae4DvE?=
 =?us-ascii?Q?Y0toS04Z+8IjXvdoYpNM7Hz2z+wXjy7QeuWTbX4q117qtLuUeTELGtoCYSk4?=
 =?us-ascii?Q?6nwXs80UxHZjWqmWK4Fq4EtQmy0RQVwUshYoyyLpVnMdrWzCY+/Ea2Cj1W6j?=
 =?us-ascii?Q?5E4Z2XeMCqi5O9PxlKL+po+7JMiXOOzEy7SiSw3qg/KYYLQLTTwHZ2KX4hKa?=
 =?us-ascii?Q?5fg8LuD5J9u6UKrWnFbPlO2fIyDLvsm2zZvKzogsW7Ig0F44vd+WUSrUq9dW?=
 =?us-ascii?Q?E7wVRYPvR2+Z8WEs3y329Gd+5j9r9QekQVfNq54or67I9XvXHObmno6fD0xy?=
 =?us-ascii?Q?Gb52BdrbLrIVy228aDMX9HIU89zyWspxzX9xMhB0lFaBaYl0FXi0xTfpQqSw?=
 =?us-ascii?Q?a/I7NQLdNBeyZrhsfhQTpbgfnlY5IlvAiV7jajnVNUsgFV65s5QpAwGNnhnW?=
 =?us-ascii?Q?nEPyJ69sACFw5ah+8XLAnz3QO8lvaN1Fy6Tp6ApYLgtFOVqGht5O5YZL286L?=
 =?us-ascii?Q?AKhq2/uHdaMNN4NLOP3YTtWSquN+YvP+XOb5+HoLMJR/oT+C9XRdY0gAG2se?=
 =?us-ascii?Q?AAnImqJqs/60MqSalEz0KXPgHHFBLpPlIrpuX7V2M9SlTvGEeTXFNFILAdsq?=
 =?us-ascii?Q?UkadRRQiGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688a1249-a92e-4321-b34e-08df3b6eef0d
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:35.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kpz60Cjuut7sJwgAuIPycOO6UeV5pCb0y9j2H46eQxtyT3MdGZemNrFBmQwej/UE7q/sK8Fg6+e94syqW780Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495

The PCI core will restore HDM decoders after a reset, possibly while no
CXL driver is loaded, so it cannot call into cxl_core.

Move the HDM register programming helpers from hdm.c to hdm_regs.c and
build that file into the kernel whenever CXL_BUS is enabled, including
when CXL_BUS is modular. Export only the symbols that cxl_core uses.

Keep the DPA lock assertion in the normal decoder programming caller so
the register helpers do not depend on cxl_rwsem. Leave cxl_rwsem in
cxl_core until built-in cache management needs it.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>

---
Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=e0b476ea99567fb5aa416eac0cf61bca20724880
---
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/hdm.c      | 102 +------------------------------
 drivers/cxl/core/hdm_regs.c | 118 ++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 100 deletions(-)
 create mode 100644 drivers/cxl/core/hdm_regs.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..6703c1729396 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index af445f1b9798..2c373dfbc070 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -708,35 +708,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
-{
-	u16 eig;
-	u8 eiw;
-
-	/*
-	 * Input validation ensures these warns never fire, but otherwise
-	 * suppress unititalized variable usage warnings.
-	 */
-	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", config->interleave_ways))
-		return;
-	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
-		      "invalid interleave_granularity: %d\n",
-		      config->interleave_granularity))
-		return;
-
-	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
-	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
-	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
-}
-
-static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
-{
-	u32p_replace_bits(ctrl,
-			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
-			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
-}
-
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
@@ -759,77 +730,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
-/*
- * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
- * committed or error within 10ms, but just be generous with 20ms to account for
- * clock skew and other marginal behavior
- */
-#define COMMIT_TIMEOUT_MS 20
-int cxld_await_commit(void __iomem *hdm, int id)
-{
-	u32 ctrl;
-	int i;
-
-	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
-		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
-			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
-			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-			return -EIO;
-		}
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
-			return 0;
-		fsleep(1000);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static u32 cxl_hdm_write_range(void __iomem *hdm,
-			       const struct cxl_decoder_config *config)
-{
-	u64 size = range_len(&config->hpa_range);
-	u64 base = config->hpa_range.start;
-	int id = config->id;
-	u32 ctrl;
-
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-	cxld_set_interleave(config, &ctrl);
-	cxld_set_type(config, &ctrl);
-
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-	return ctrl;
-}
-
-void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
-			       void __iomem *hdm)
-{
-	int id = settings->config.id;
-	u32 ctrl;
-
-	lockdep_assert_held(&cxl_rwsem.dpa);
-	ctrl = cxl_hdm_write_range(hdm, &settings->config);
-	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
-	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-}
-
-void cxl_commit_start_switch(const struct cxl_decoder_config *config,
-			     u64 targets, void __iomem *hdm)
-{
-	int id = config->id;
-	u32 ctrl;
-
-	lockdep_assert_held(&cxl_rwsem.dpa);
-	ctrl = cxl_hdm_write_range(hdm, config);
-	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
-	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-}
-
 static void
 cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
 			      struct cxl_endpoint_decoder_settings *settings)
@@ -846,6 +746,8 @@ static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
 {
 	struct cxl_endpoint_decoder_settings settings;
 
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
 	if (is_switch_decoder(&cxld->dev)) {
 		struct cxl_switch_decoder *cxlsd =
 			to_cxl_switch_decoder(&cxld->dev);
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
new file mode 100644
index 000000000000..53d2f236e49c
--- /dev/null
+++ b/drivers/cxl/core/hdm_regs.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#include <linux/delay.h>
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+
+#include <cxl/hdm.h>
+
+#include "cxl.h"
+#include "core.h"
+
+/*
+ * HDM decoder register helpers are built in whenever CXL_BUS is enabled,
+ * including when cxl_core is modular. Callers provide any required locking.
+ */
+
+static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
+{
+	u16 eig;
+	u8 eiw;
+
+	/*
+	 * Input validation ensures these warns never fire, but otherwise
+	 * suppress unititalized variable usage warnings.
+	 */
+	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n", config->interleave_ways))
+		return;
+	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
+		      "invalid interleave_granularity: %d\n",
+		      config->interleave_granularity))
+		return;
+
+	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
+	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+}
+
+static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
+{
+	u32p_replace_bits(ctrl,
+			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
+			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+}
+
+/*
+ * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
+ * committed or error within 10ms, but just be generous with 20ms to account for
+ * clock skew and other marginal behavior
+ */
+#define COMMIT_TIMEOUT_MS 20
+int cxld_await_commit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
+
+static u32 cxl_hdm_write_range(void __iomem *hdm,
+			       const struct cxl_decoder_config *config)
+{
+	u64 size = range_len(&config->hpa_range);
+	u64 base = config->hpa_range.start;
+	int id = config->id;
+	u32 ctrl;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	cxld_set_interleave(config, &ctrl);
+	cxld_set_type(config, &ctrl);
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	return ctrl;
+}
+
+void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
+			       void __iomem *hdm)
+{
+	int id = settings->config.id;
+	u32 ctrl;
+
+	ctrl = cxl_hdm_write_range(hdm, &settings->config);
+	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
+	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_endpoint, "cxl_core");
+
+void cxl_commit_start_switch(const struct cxl_decoder_config *config,
+			     u64 targets, void __iomem *hdm)
+{
+	int id = config->id;
+	u32 ctrl;
+
+	ctrl = cxl_hdm_write_range(hdm, config);
+	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
-- 
2.43.0

