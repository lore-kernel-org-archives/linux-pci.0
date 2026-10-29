Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285857;
	b=2aVblXpoBa1M86nqWuFabk7bHHP3H96YNwaJJHGBbHnmEds+WrPupBBEuus/9rSkMQyy
	 4YDw/C5/o+jeUfhQSeFCKvmw84jco3RZbTUlJfNydzpC6z/Rqf5NWTVIi5NlWcFvNQ0dB
	 xplNr0WRrIkmsVECYDrB02ltPq0TFthhFCVkpByTNr/KCCvoQin5mn2NZDqXCdEAwwxYH
	 FusU5Is0D9cRCJrmBaR1h3wlbgG6SMSiNsfF8WguPuqyow3uhDIxE8faZ0oUEktLvz7sN
	 yyrHtuFmbcqkHT1ys7HE5BerSzWAPA6ay8dgpze3cOAZeU3Y0i8VcX9otlpEI+yBAvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285857;
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
	bh=JkpRAlFKj6Kw6LrpBGV+HBUkpItv/EkaKDXORQp61/Y=;
	b=OpqvkzR21WXvtoeY3lSr3aVz2D7dn0k0NISX245JthL/AiiYRZOR//e6yKv3NRVMIRby
	 H/Y5rbgsn6Skdlpuusl80Rva6QUyUb5YEeUqJztEWfmeox2UfXilMggigDqe2AocD4EfK
	 aafjRDAY34RsgAjF5yq9VL0UK0ZtEVgm4f/YghOGGofKtDB5DkaDWs/G/5d5A/CAWKRnL
	 c/qjzMG/hEl86D203Fj/41gTF4piiCPOgtfwpTDOkMF1BD0mFZPEcuOojdb6ZOafRibjz
	 yUn20K9BlADTbTdZD8q3TkTkY7Y9sIBxaLp6hyIU3Y14I2b5M+SRO0lR2OnUzvRh+hQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CGbpcGWv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.60
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC7606A33F;
	Thu, 29 Oct 2026 14:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16CC7606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CGbpcGWv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYXfzn0FfTIYAPgUUsxJZxzJHwjGB95/9EaM9Mm+C4i2UnZSTu6hNevNfI/kMvxyLY00GWKsY0yK/ivWrIuWT0e+vtU+22aaUvsV/D7LbAJIUnBjX+ruK0hKZ839mEMp3TOF+SB+MFS2B3trp7N4ccTAMU/Yz1vWq3kmtZPmy8Jftd8kNkoL1P3p3w1IX6Kcg2xW3LzmGU+sWD5eRRK72ZEL0JyyrI/djIQCgqwL/t+qHPmMl2g56mX1okOxI+UU9UgPuSlif5OaVOG6VgkONmb7T6/ALsb9ZH6Yb13MprFiLFaxwM/wcHzpotOaWSv+xRjKUzRQlPu/RePIBW9j7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkpRAlFKj6Kw6LrpBGV+HBUkpItv/EkaKDXORQp61/Y=;
 b=xP/EN2Tv9NZzDyk/BW228b2t0oJv+Pg8yn0s8WjPM6TkRr7VaZwxthO+YSbmiTlfi+jHphtRDC9KA07d+P9NfCvtiasTGGaaJTLpTLh1nvJFgK/6GaHLzrnL1xvaSpD+xfT72+YP/dOJSZopc1xinntHmyDuMUqazqCpT3qinmyAy5v8BpwehXXa25Q4smqsyeHeZ63VXp4J8Evumku1yeU0IOqOl7lBwnUiaaQ/rYF1PcjIjlfVDMSV7/Om0+Pw65rIn05dnnk0Yx39Tdsiu+Z+XcOFiqJujH++N++//894U7tEtt+Wl3VbJK1u33RCcXDGsvqrf/BMROYNKekrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkpRAlFKj6Kw6LrpBGV+HBUkpItv/EkaKDXORQp61/Y=;
 b=CGbpcGWvOHOR/M3/bRWnT9aT8VNYV2IMnzQ7tMNqKZkso3UgT5g/dJ2wlH8S0aeY8/iso5zJLPRuW4x6usbOYmYwBZmmCdO3L6KW0X4rI+248B2QcE6JimUuYB/2bYuwQyzT4iBwkLLu9d1rLnDUb/6b3PlRUsPmaE2PpkSxbltlfyxa2PWleCKVTfIU2pBXA1zl/eScjIwGGbHnSpJSs2eDKlePAK+9odUjYtT/e/T1iCvntxRul/klv1ceYGyGrcHB8Y5K5UZe8eiziF6fkrT39Ua1ZcmK4V3hn9IhYBE62OCVnZrHugoNv7LDQubAdflpqKHP8QFMDIJWhMQrZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB6014.namprd12.prod.outlook.com
 (2603:10b6:408:170::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:30 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:29 +0000
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
Subject: [PATCH v16 06/18] cxl: Move HDM decoder helpers to built-in code
Date: Thu, 29 Oct 2026 14:56:51 +0000
Message-ID: <20261029145703.2185231-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 73de56e2-0556-47f7-a2ab-08df35ccf422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|261028144727099003|11063799006|56012099006|261009223027099003|261021123027099003|261022113327099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BIwKhjRrcphX2BDyTdtkizGUedsn7ukUfnL5K5J953iY4yGKaQbas7QsT46WbQcRFM+2SoElSdyHJxcSDWh4LCtIBzm2G32CnMfC8ypk53CYUznOKMLrqRLosnpUszca9ewoEfGW+eESzo0WYYdWn6dIKhtxTi7dR5jTUiJa5EgfByGuejYzNfJuCsRy8/bfXIdmhfJpepgsmM9LEmLdnZAQT2HrQZpD8APC2lIvTiDWb/T4Cg5PaFJHcEUqnZ0MUgmMkRVnRfhDbj0YKUVHOL5MY1MjY2y7dAz28MfC1I03m+8CWzJPwK0RIDavXDkLCiWJu3w0DZ2X6Db4QUwnrdENId3rIymeCsHWE3vj3gXd3DEc6SO+6c48wqeX9fCa+OhtTWgtJiIAaywJgTBMCBHKGL6HX8nxmLG9mzBCqpsWHPryMhUrjNN+O0p52XGEe1iQBsW0vWCPNd/ni2tLk2GAZiiCgWR6+LFbc0Jt9u0JJk2Fq91eNMHjMpDhx4vTI4kQ65+e/Onw78VBwfh3PLdQaPT65a/gWsF2yZLGVmhp+z6jDxA7IEoJJQMDyv8tCKpVGNWYRRjzCR4gn1OyMHO2h154lGZJUfFN7OZKIlNfGxr3R0ir+CzmGwobVEbRbJZ9ZcmJlZ9BxCbICKeRDjCQgJxr44Jc2jkaIS04l+h3hv1Cgsc3l6wlC8+SJt5A75p2V0luv7e3WydZQRdWdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261022113327099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uashNrEwDnAOeuKV6X6XtSOkE6UtsEakoa7F7uvKhqcnW6rZR12QARnuf8KC?=
 =?us-ascii?Q?664CEbEGqXJ1e6HHXGQNflkuu0IkeL+EkGE/YiyWgrBX4i1rL043By+okv/X?=
 =?us-ascii?Q?gca6mVxadtoim3VHYUkO0Jw50kqK5nEqx5k8CJ6+gWvTTn1nlKkrmVjM0Bnb?=
 =?us-ascii?Q?vd9327QDzm75jcifp2hsya74LQq+LA39iaYPRGdSGMvbSWULtk+T4LVETlVn?=
 =?us-ascii?Q?XokFOBDqEGk0qmljYJ/yX58ZNrTi8Pqi37xSz9XfIXZejV52GGm8kAF/6F7I?=
 =?us-ascii?Q?o7YF1wXTnZiWv1zPYrs/y+/RmrAdmedQ2rMw8u36nmISfM4vdLDqM+IT7qiz?=
 =?us-ascii?Q?tLteWrq1nCCymXHzv0SfK2Xf9LArXP1Bt9kggPPgoIFHfxVnavb6Ri0m+sjJ?=
 =?us-ascii?Q?kkZBIn5iyBN30FEUQ1hII9PXt8qMv7SO/Gk4CTqmfYNdCqrEjnhu7fgoF896?=
 =?us-ascii?Q?j1ds8j2FYRQhUW4HBU6VST3Pf1kuFqFMUsr4PEhHPRjH9Od7gWzB7cHjh396?=
 =?us-ascii?Q?xKaDnZHalo9fzlHovwGRGZPgpqK8u4svGv9nyWKCko3aFy4jUgBRBVTayp2Q?=
 =?us-ascii?Q?vKAy+5I+0i2Yi2NEbpdPXEPuPJX8NxTmf1ee/nr5KE6VvaFcTwrVCDiECSAC?=
 =?us-ascii?Q?ElMknIqsk907uj2BNTk6apejzNNX9WPB0E7C35jFnjsNi2YG81zdMmNlH2zS?=
 =?us-ascii?Q?xvJxcJRSMAXRDe5P8u72E6ROVk5uoMc9X0DHnZ7tVvj0DEtroabeSiQ8oX3Q?=
 =?us-ascii?Q?4qEH/O3wlGeaMn9TiUaAGIGKWDloV7Gno8wsHMTzo9qQZFyJDr9Fw/EPka37?=
 =?us-ascii?Q?G48KMAvtgLiPqY7actfOCOjvOpUR8uSLZ2/GvKpqz1oD3TUJw10TpR1GPcT6?=
 =?us-ascii?Q?6+AG/05K58QZXqHlBSqCWyAjG5oxNSG2UYRTP3ukRIwLbMCSMSRtPFT0uJbw?=
 =?us-ascii?Q?cGaE2HgIH8c3k4y72Gq3EP5RAfUTL7nz5BjQibNnqmSIhVLZfEndMFyCRinr?=
 =?us-ascii?Q?n+0maCZ9ZDQz/j46zL+t2vnDX2s/Wtysr3uA3nH6kYQHmy82WpLJRme7eD0B?=
 =?us-ascii?Q?RSpYAwJHsT1Rj2XiyHZLCYP7OaoH91UkJIyxDMiva+62zdM4+1m4jhZRJ2OC?=
 =?us-ascii?Q?u3BAxHkRFRwM9W7g1YNMqlF4dITKK8gWSCFeZvelV5UGM6bJcEVp7V1xhYib?=
 =?us-ascii?Q?U/w7irPCuc0Lka0rXbDVFv5quhvq4J4VXVFPPO6upWWO7wBMgFLK2lrohLg5?=
 =?us-ascii?Q?9dyHfHJUk0067vkyqWJ2t9DoP+aSJLlLQsF4jHdcJuwlSf3Sbdx9rXwKw2f+?=
 =?us-ascii?Q?jU1AJSh+nMNUHL/1UsB/KJJnEaV+NHkA1oKLIGz/N1yYx1lBEKdVGerpjmJV?=
 =?us-ascii?Q?bPoln142eY663EtN8SteziazsPmSvBEzLdEhDyTzJoRqzYYR8Nqsv6xgLNJd?=
 =?us-ascii?Q?45RYCob6yBeB6p7k4FEIchaadoVKbpXrTMXHnGJHbwQNchYWe7abaY0d98c1?=
 =?us-ascii?Q?oINS/Gxyxm3cAHlYO/GXNMNBNfGBqC6Bf00rDc9YNXGTdOxm2dJZEuW4SEQ0?=
 =?us-ascii?Q?+MREKZRqFBnkBMLuFyTZMIEFg5n5w6XJZCbo4bAq8ih8ckiI6/utZON3sIAa?=
 =?us-ascii?Q?8Q8WAfXzimcWvrRToFd+dvWEudZL8uyINdRk4zwpgVHh9C558tCDDs/4ydvv?=
 =?us-ascii?Q?BMB6F4n6bS1OIpDp52CMt6nmuzSmSYGCdhplOUTvlWyIfWeCItXIuofdKXmZ?=
 =?us-ascii?Q?wbkTQ3cusA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73de56e2-0556-47f7-a2ab-08df35ccf422
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:29.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKPvXkqt/qOgErFsXP/q6k5/sZVT5d58qHoQYl4uOS248S5AYAPvvGcLsMFhvVgAGKoY+2A+RQKUB8sCWyiq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

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

