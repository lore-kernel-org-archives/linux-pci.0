Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503F4ADD8C;
	Tue,  4 Aug 2026 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871866; cv=fail; b=cMKOu9B3razTRW0guGtJHNS6a/5gSheY27XTZcXPfnxNufeyjv5bnWnkfbS3pcmFCi3UrZLwbu7ze/1K8m7Ql4sMxVo11kyeYNdBmNhupB+7b2+gUnRZPf6738C00fNA1m4hcdo9pP/bSK2ywPIig2y1XANfGKFCg4rX5uUYJOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871866; c=relaxed/simple;
	bh=8UBooBF09GCc8AV7xzxQ1G95IvyakY89dXJpJwOP/Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tv6JX7DLIzq00CrwE7w6Oll/IplhxLDyNOX4qxlaLQX+CA1djbW/nGMleJc6mWlFRfmDAuy1BwvdJ66VC6r11djBY1Zf7WM+t7nSpgGZ3p5sdC3CwlDjl29TJ+wOAjENapd1ra3gmG2kZLV0F9g/T86lPBYBnD0ILQechfO+4SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O9lH7bF5; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O9lH7bF5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jt+vLyKCPuel+gESu2diVbqywDC67g0FLkIzHRn9ZQYsHx0YSYmLLtJ8iSXwa5ex+jRhHIwnT01CTYTaQyulPrTC0sBPbhSaCbF2Ym0cSyG9l/SWCKYRvYrwR7upgy81JvOU2GPU5SDne30hEJBdR5j+C/6Pc0o8hbzDaa6Q4MZ2hb0n87Y8c7DDVVet+Z+0JtUG8xDx4e336rxBMmjmpZo4BM+EPduArpEKs8MBkFNmPGyqiLRlg4BUxG3qmVAWi9+MJGDMQuLyRD7Y2Qe3YfVmlLT7MaO4hEtKp7MnKoPOEJohrh9IzHHQRpXD1mr+m8Jtwmr2sa3r4j/QRipedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haRNGRrjGPoZh1/GP4HDBiMOMjyhfSIWSlbyrsERk0E=;
 b=Weh3KGQbfBv5xits5zf839toj94Ov6IzN0yQzhlOEgRFnjcnZhu2IYHlFnyLNvbL1+nxdmj7ZHjuUqgwY4NujMEewF4oa2DbtsxwDxbzfnyBZgBkOAu4Nc9UM4GTQ3Eyig3+SMyEuLYdkk+r068Y/2Omk1Hgg80D510c/SC3/f7HL1iG98N8eFYvR4aYtA1LkMEbWyT/An69rtN0lRJcgyKZU2yx9M0xXTEJKDUPbn0RA//4Da0lJFAWiD5ctnmPbgMyUGVF9D9G618BzEjwJIf5Eqm6JhpdwwitPN9MwKoDBc6lOGXy3/1FxNe2rJYVdHH6kUNB7cf6gFYLCLrOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haRNGRrjGPoZh1/GP4HDBiMOMjyhfSIWSlbyrsERk0E=;
 b=O9lH7bF5eqVqTw7U5UZEkdyZpQPKft7myUTiblDSKchix3uBiV1xcLXIDOCvVawZDhVLaalI8v8ShBy+DjomPmX0JqNDR/moKjuGLe4OWa92i8D4kNh01TuhBkAYVkmqaM4mjlwAgEGJ76Xiv1VOEFoc+aA4zgEx3BkqELzgWGhydqI5TqGHrtLZPJitY2yxuh9YK8vAg3uD7xBXkaUW5TkeFlsBUYpkRs6NpR9FOD4e/Ehoy/hMzM3OQegdpU/hoIWuSIP9bql+ODZRujuk1BtqJ9FC7s/KRpxIGirW+ZhSk8ASjQxTzuyMMCH9M+n5Pma65gAaaWpxP6iCej4T9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 19:30:48 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:47 +0000
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
Subject: [PATCH v10 11/12] Documentation/ABI: Document CXL Reset PCI reset method
Date: Tue,  4 Aug 2026 19:29:57 +0000
Message-ID: <20260804192958.1823952-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a03:505::23) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ed3b5d-7df4-452f-8b8d-08def25ee283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zlvvrFh/CS5XzbAbAkxjvsQd9PM8WtApcAFilnfoaHWu/co2inoP9Z2Hlnp78OrazbqtB8h1yf6CoEvTjm54/aKKJ+1W6lTnFUTDE+mUnFRzIb/8jcgGLfcfDjZYwY+4mjB584zUpIKDU8a23Ub+iFZKR4vepgHRfthatWIqUHHSlK0YNB1Hy8gWZwisaHL6gngWvdeVY0qu2EHYuE3lUId35+lNslSTTxlWVcjhVDypO7VO7V5360Dreixcx4pNHvx67PwcxTSu1Dgcyj27S6JCgEgZ77hb0bCyeCReFmckac59FUru2ghmfm4753tq9ROIgM98m0e6nBfy1+o9+AwzsBDGMsBCfxTjtI/IylvchoYxvrZgILmEiNvIgyAxOWPKjcs4d/m1FOAyobbr4T/mP4luemktgTjje4wl3ql8Zt5a6I/RSaEmpwBlKkctbzSHcX5JJ5GhwtDwjKQZCYij5vMzddqZLHubY2NODqBLnEVnzFAL+/XXWue7+3pgqckEzmChZDQQt499RHAzMyS36cBNmsIFWaXvYCrP7ke0VpusZ8FTWw5TIovTqyaqXM3nK4EHtmvQI4q2eig4kcuh7fzC0XIoeCet994gtapNFC3OiBhkG2EYU/wxMchAmDewcSF55E2kg7YJ5KaTExNWvLPJ/mI16qwDEgJ4F38ts4U+MtXOxJ4Amfdboci2eieYwC/MS0VWBPAqNb1rcA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgNbAXk4A7ZY4xdjS5FXPoqHJgpgEC5aYQHxSo9FF841/HTYfQVq+OFKpXgE?=
 =?us-ascii?Q?/TgE2E6t+dyt1UbLpeLX3nyhVZriS5DopBde7bGvvPRKiX7UtEpa3vKMTpyM?=
 =?us-ascii?Q?Pyegdl8j6cv5zaD9Oo9duRvlHbh64cytJ6Pu1XOqqVfZbn52sDsYCPUQCuC9?=
 =?us-ascii?Q?vgUMhVSC5ex2N7iklDR3YhpTBGuWr6G6k5PCs2bGmSUff7PqfpHwWzZp12YR?=
 =?us-ascii?Q?z4/CFxLkBNEFuzlFCtzxP2Zy7rcdE1Hfq8+ZwzXBFwEUWGdFPQRZ+w0ipczP?=
 =?us-ascii?Q?gWhqmLXld3Iphhy/WydIkOZPozmfEQl59szkr9jqyLrpZ2DMkBqhqT7AeffX?=
 =?us-ascii?Q?hDcryUXl3yUhB4ToH4u+VwBeXnQnaJhxS2RCEdP0ii21zVteib4DtbNrFFY6?=
 =?us-ascii?Q?XNz3kjTVuqs8l2VW2uHUPUxndeSqVQN0I2uy1smdAFNUCM2Qp0rlE5vtKgXA?=
 =?us-ascii?Q?QXHIYkpPVJA3Me59oXFO+eQ5+pvLq5CygltlNdTckoGBUXz8N4mYoY1OKlui?=
 =?us-ascii?Q?Nxy5gKsjR7CszxleBGO6TgGjd3FjnfS3gEfxBZ0pEEha72hERgKUjOUGYbai?=
 =?us-ascii?Q?xKiJizL+FZYpYGjgjPa8RIQQCBGy+8UkHA+mZx2NrU/0KyUPfwToM6KakB6A?=
 =?us-ascii?Q?Xa+j7FFjOREqIQ+KNTqZNjy8PaF0lfqO9BxZySvXwjAwCl5dmlOZImZ+kCVk?=
 =?us-ascii?Q?EgLp3du6cPWszv10h6ABdhlVAchekm0mLof3YMrVXt1M+S0Z4DLoXBlFnzlo?=
 =?us-ascii?Q?dTAih9Lb+e9gfGuGBa1beyB8c5kxmCeKt2ndDsGfp262eSxZj/nTkmE7GTPm?=
 =?us-ascii?Q?1zcK5BPgCKboO5IsFXljGiyIetXM0uLn/gC1YrqOUc+eIHQnkT1bvPKk88bg?=
 =?us-ascii?Q?sss+HCa3ifLMs1MyomSZsxpo+mZrZ4F3iXYG0hYL1wOFMRMVfdh8aF4+DRI2?=
 =?us-ascii?Q?wIfpRxYheENT6Pxoqd4J29mwbfZPK6dENAvflJsCPg2GnHOMzy/GqD8aBaBB?=
 =?us-ascii?Q?0jaIRgKVZyrYtnI9HSKdcQlTyn3TPW9J2knB/J7hUorcDINKhYnVQxRMWLsR?=
 =?us-ascii?Q?RfPcwPA3HiOQ/haP19PZIWE4UNp4Hb5QwO2qbaej4MlJoNQNXGWdB78muKRh?=
 =?us-ascii?Q?zl4UvxMp/ck17PwMg5ZL6F1j2rzASFaeid5JKDiRt5HEwQFIi4gsb3oN25LU?=
 =?us-ascii?Q?+L4t0Xw1vAyjxLq0Uf/M4IqnfNL1bFWxjDY12L3nvkA3tv3HV0taT1Rglobu?=
 =?us-ascii?Q?wsvjOE6uJGFRH0LWrSwIXkrTZuf97J4mfCdMlO6aawlfOnpJrM0xmQa62gNH?=
 =?us-ascii?Q?jky495vVDyQTDBrBZjPMxNb3WqtUqUgAseITQzEkitf3jEnGCri+0K+2uVn4?=
 =?us-ascii?Q?SDm0YBAHsdCy0AE5OrOlR1przVA2xHZ4W8n91lhB2GqzQnB4TMQYAob9vri1?=
 =?us-ascii?Q?ft5JYiodbUhugTSSu+RqMw1C7pkbNazXhXeAvhTVETmHKDWJbUQZLJGjNPub?=
 =?us-ascii?Q?8LKRsiuM9ipNSCR8r5nOqanNEwm4E5oxIuRrwnANgyZkmIjv9Y6KZ3UnUkDy?=
 =?us-ascii?Q?7yrISFxCEuyjozr7Z5gD172PEaSVBSQMMgugUxLVCX+nKnrBOFINazNMZgx3?=
 =?us-ascii?Q?MUlQ4/m8EDX82bZ11ov4hJMSAQse7M1TZUlRP9vDq+VEcYVdRjuz+9JbRB2U?=
 =?us-ascii?Q?7WExjqAZc6WXei0yc6bmf0z5DNKVLG8YoUfFXPoGDEHIIyQtXDsacNn1InyW?=
 =?us-ascii?Q?wfRO4/jpvg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ed3b5d-7df4-452f-8b8d-08def25ee283
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:47.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUMVzLbqk5tUpu40fXpeRrqHcPJ1k5n2uKGXNhRU3LzhZ7gSY03Y853eFXGz1ompVwLDk1H7fp7jSJAT3hTffA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices.
CXL Reset is device scoped, requires affected memory to be idle,
invalidates CPU caches, restores cached HDM decoder state, and does not
request Memory Clear.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index b767db2c52cb..92e3f5840775 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -153,6 +153,22 @@ Description:
 		"default" enables all supported reset methods in the
 		default ordering.
 
+		If present, "cxl_reset" selects CXL Reset for CXL Type 2
+		devices that advertise CXL Reset support.  The method is only
+		listed for single-function devices so CXL Reset is not exposed
+		when the reset could affect another PCI function.
+
+		Before issuing CXL Reset, the kernel rejects the operation if
+		cached HDM state is unavailable or affected CXL memory is busy.
+		On architectures that support explicit CPU cache invalidation for
+		memory ranges, the kernel invalidates CPU caches for enabled HDM
+		ranges; otherwise it warns and continues without that step.  The
+		kernel then disables CXL.cache, initiates cache write-back where
+		supported, quiesces the PCI function, and issues CXL Reset.  After
+		reset, the kernel restores PCI config state needed to access HDM
+		MMIO, restores cached HDM decoder state, and completes PCI reset
+		recovery.  "cxl_reset" does not request CXL Reset Memory Clear.
+
 What:		/sys/bus/pci/devices/.../reset
 Date:		July 2009
 Contact:	Michael S. Tsirkin <mst@redhat.com>
-- 
2.43.0

