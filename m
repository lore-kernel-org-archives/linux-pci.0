Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020085.outbound.protection.outlook.com [52.101.228.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34B3BBA08;
	Fri,  9 Oct 2026 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521709; cv=fail; b=ZebMgXvUSn9pEyjblGmpELaBONuG46C6qdlndE+zP+hwHYzaqvCTjb2CDeMQd5qtTBftxtzfl/unkDpYMS3iKrZaJiZ7wijX70BYCrKOGCY3RB9CBnuxcTUmHeVAOyr68EhIFEyQIRjGI1Uld45RNZPE9cZTgMzBCXk3vKd4sjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521709; c=relaxed/simple;
	bh=z87uuzue6oCS6+WhNP2x7CuBTiZSI2t5g+DYRgIbZBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KT8stmTBR5dJxBHvng0Gp958t6RZr3ZPgFbbyxSxf++PWhUKXiFFNQaZWThRPf89YPGSRvIta2B01zDLj6XqF5PlEfBj/lGtXd+G3qnpN0Ic2WATVoHD4O4UaRaugiVYscjaclwDiAuCnWFNbCaqgumDgMGdHc6Hhy29ZaQ91q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NqB2Fl74; arc=fail smtp.client-ip=52.101.228.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NqB2Fl74"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq+YIngMNw5jCEnXcv7Ozk4TU7kUXSnmlKzOA0xUXGoO1POo8EBTAANfG1yB/tU9tQfgKIVcdskL5lUN+t5axrXv9CKI4gB2PG+Rsyt8ZN06c29onVd9bzCBvKAq1X04c9t0OkTrvAonfn9PMhOOpieluPLYE1+LrbIj3g6ysic9hNKLp6jyZMUVTIuguORi8UwaCpKVGr5l/Zz16XQ+DY4L+3yLPNY2b8R4BHaWWe4y13Gp2O+YL0K4ICZ0nZGeu0T94jMd6tlJ64iqkPdfd6wssc02Luz/egv1gbpeyHIkxBeN/vi8ESXgHlmhDrT1x9JZZHKDCFR9zeKoJ54N8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qddKPouX7xPqwQrkMelPbfTRAUQ87yI+6IPbzWr+kiQ=;
 b=xmz9/MA9RQI12u/1rf0gwVq4RQZOI9+N0yfQOJnQdmH0H2vIKMepMhx+mAydywDYqDtW0aCzNgL+xBadYMW+0bmbv9v7GrVxQz1EO7VB0OYonV+WsSGCsplz5iYkAEgO/AsK/9zEIp/1mo25LbeGLANHvYzJn5DDak6eZzNR1cCiLCF/m0XLyUstUPNZ8vpN/Ob3VyfDmPrxfWvxNVY3pkWzb5xjOzziw9n2xLfq023csCla+0AGmNV1+qu5cYrvGlenAjFIQnGSH+WdSINiMrZdJh+V38Tkctii2meL5bfxSBi3/JeshwO+2mG5Mg9bocqoCsmThHQUy716oyV7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qddKPouX7xPqwQrkMelPbfTRAUQ87yI+6IPbzWr+kiQ=;
 b=NqB2Fl74L4dfKEw2F8mApajBYIKposCekVlwRRvKRshC8fEBj05xfGjs6+l6SmIb9maSArfSfG7EFCHH+UAFQIgwNjVbc5Mw+OTkTOO/ZF7x7bl779PV6HhQUbXTiLGnRcXtEUJyaFZajOqwnJKutzXx/rM24B2NKHTZAuRPY8k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB3079.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:55:04 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 04:55:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alejandro Lucero <alucerop@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/3] cxl/port: Convert PCIe link latency to nanoseconds
Date: Fri,  9 Oct 2026 13:54:50 +0900
Message-ID: <20261009045452.1107921-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045452.1107921-1-den@valinux.co.jp>
References: <20261009045452.1107921-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB3079:EE_
X-MS-Office365-Filtering-Correlation-Id: af7b89a9-0a0b-465c-7103-08df25c17b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/jnIT3bl6KKJJiBko2Ws1VjRAe1BUSDELZsEaPBkSg4IfMfYxZw/5BG8GC+t52R+GLtp0V8FmJ+lufeHNRpFujZFbMK5vcpGKqxchbCcnLD09R/YqKUR9Zn5290IwCdJdDHQd0I4s5Wrfu2sbS51mSOib7xDJAM8QqsMMMM45JROp+BfJL1jABGne+P/J3saEyardCA9Aa4bPimMrMpuCJT4jxu1YWYpkvlnpMJ8nXfTM03j9/Qhp7NGLxZ4tIqQSDKmqbfWBnUL5i6nrzkmK8mWaqoehipAUJszrLt9G5sn8WOegS1dIxWt4h4tc5xZxTc1w+L81kPzfrtC9cPlpoEm914sFVIwkgPVJhlSh4zJ463fVgSOiE1YFi97rDwiSggUVaHMC5jiggr61zWsWoyDS70+ynXU7fWazStQT3g/pSZB8mPVjf99zyphfBViLFzt24dLVsA8iab6Ts1rPv1dew53MQ4IQ70iRpcu0J/kE0de6ctepcP2QdqE9RMRt/nEaWurnLuzQOWX/O8kheSBcwYtFLXhHEuT5C4qLuAE+ek9rqM0Aek/yBehBduE1B6GyaTBaggzQqf31mILapkiFvepynx7zxjuaATH9TO9GDQJFFcR3kVTHvISgvM71TEM78lCwjtxqkh5b1nni1JXf/a+G26J1udLm4BhY3g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qWGggguKsUS0OIb4SX30r+IxmMZD1jf6NFOWRn+/UyMRvdW+4mNqfjpmvry7?=
 =?us-ascii?Q?dnNwDcWbEr+VsL/80i2GA1CacmEE3V8gCk4DyDllQChfKuuj4+Pa2LKNeGnv?=
 =?us-ascii?Q?u6vvlbE8tq8XSE3nbzQ3zAgT5derRcPN8dOa+nOYcxbjte3JMvd61V05uTST?=
 =?us-ascii?Q?QoakAX+mN6i4pNPX1v44nlh+JkL5NsAstcx17/dntNdLfOHu5o7CbOmZDQ6k?=
 =?us-ascii?Q?RSF1mA1KktFVl4zDsQpRbYFTdShQ5f/z1jLX17DpeD9kIWFARWyST/LRm4Qm?=
 =?us-ascii?Q?mf91+YVcuQbNZ/NEtex8mXA/GkghJd7fkYF6rAmZytjrApGCGQkDHIYFrUsT?=
 =?us-ascii?Q?Rgeb9kosrEWrMY0DQsFoQKoafGO1e3i6uyOE6k0ojPA61bF6ALz8+d8B0e6o?=
 =?us-ascii?Q?eEeIkSTpOh5pnmS3L5/D/zweCOudhuAJvgsq2iTNsd//jLB93uG759OeUAuZ?=
 =?us-ascii?Q?TznNj4AnRhn5H/5ZRDBpteJWgFgGadoISiS65oWOWP9ttk/hFEFEMehujJCq?=
 =?us-ascii?Q?FdTAPsiWKB4AU6letO8uN8Aia+dfFZBDKD2RpoBT4Qd4smZud006UcncgTJb?=
 =?us-ascii?Q?5IiNpVbgXFOmfogK7aXIoiHc4ktDUm0SJX66Ig2TtNrIIDHBTC+we0uCLvZY?=
 =?us-ascii?Q?T6wxCJZQjMhbWE0yrgUDnms91uwiinrWtNOLlV6jx9x9mZlZieiiFTtmJ+K9?=
 =?us-ascii?Q?YZeAubShb4M5CwhN6rzai37TZRWrOU+Kq5aGhJsiZ2nHDyc10mGmLpXcsxtY?=
 =?us-ascii?Q?myKsQIJjx+VXorAI7mwD7giNIFyjguZVLShAnza/xgBjnP2VpF74mLlazxIR?=
 =?us-ascii?Q?UasDGTqfF2LnPRTaLa/aWSywSnh1yqPO/FN/lswNA/3HsCI1iJKZsS531Dvz?=
 =?us-ascii?Q?UGb0s2g6o6WHjI18R5AlfhaJDGvZoZTwfX/S8TiAsPXJWgBOu7Rs+ajaXuT7?=
 =?us-ascii?Q?CQnvDdxfF4ZzjcnNzyEOyHQGNaxvXWux1n0/60iybr2JzQub4dCo/td/4AzZ?=
 =?us-ascii?Q?QnJlm4utjESmTqgLDIBG2k0aTU7+3wDaHuRzVUra+UipmJFzy8NvCwqoSwMA?=
 =?us-ascii?Q?iI9jElUgIWO7zLz4DO+hWDgx5tvxOtCew/aOArdErJ4WO7EQyeerm0bgzar6?=
 =?us-ascii?Q?FPrruVa1E4AnxW6GYQbwDxStkxNOPj1PxKxHCNDraCFbqYeurDMOekYTYlV5?=
 =?us-ascii?Q?o9Rsu0YJ3UACQ0JnZRIPtUlkq3hewNK/K5oICqmOKcxnhZrMi87hK+1TaMrT?=
 =?us-ascii?Q?3lwNOCSze1YMScK/1LQ7PTRz1GCsVwmUCQdIXda4aubwHgLTdxBmOnEMyY+Y?=
 =?us-ascii?Q?4LqANpDqNJ14TvjJRPg5iZm6QYCceVjEhpOHwsIKEWFYrWI5aqy9FERoTD/M?=
 =?us-ascii?Q?VP1tE6HlVPhS1XRaaCDr5GFK09rmhksDjBpxrWg7D8jm7pKs1RsqVd2lcVdq?=
 =?us-ascii?Q?VJrSQQ+P7vSzqyJabSTtqnd2ahcZIE/99kL1AZMoAHjjogFI00OiKoHq/m50?=
 =?us-ascii?Q?Jo4fdf7vXeeq85vdwP248a7E+5VpzqUSeZljlo3VrbfePqnwRUNU5UeeAXl7?=
 =?us-ascii?Q?P5yG5lqefjWTKHYhoadLfbop5XS886AzxjqleohdlEzBJl7qfSAA4U+tJOuR?=
 =?us-ascii?Q?lmxYcmydsFvGbomk89vr6EPW2WXpsGBAaNxMbbkBLRuTJdvXNIvFiMkC7K5N?=
 =?us-ascii?Q?lo3J4YtAtdsHcAFtzA6WcqZYwDZzv5QniGJENMPapkLe2dLmJNWUGpa91j1/?=
 =?us-ascii?Q?KKUTLaRk6k4IsWYackdxJpittpXqUPrb1B01hB46pHgR7ssdPu8O?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: af7b89a9-0a0b-465c-7103-08df25c17b65
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:55:03.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2KsxO8qpgB96sq8VDVcuVaJto+RIbMmAdk8ZEvLij/mZ1AAzCd6nkCIVfk3VTenj78dhbpUzzuO2ToR/KzBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3079

Commit 51293c565cf4 ("cxl: Fix incorrect region perf data calculation")
converted CDAT latencies to nanoseconds and removed the conversion in
cxl_region_perf_data_calculate(), but left PCIe link latencies in
picoseconds.

This inflates the FlitLatency contribution to region and node latencies
by a factor of 1000, exposing incorrect values in sysfs. The resulting
abstract distances can incorrectly reverse the memory tier ordering of
nodes.

Convert the FlitLatency contribution to nanoseconds before adding it to
the access coordinates, rounding up as cdat_normalize() does.

Fixes: 51293c565cf4 ("cxl: Fix incorrect region perf data calculation")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/cxl/core/port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6024bc9c1376..08d9a7b8855c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2339,6 +2339,9 @@ EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, "CXL");
 
 static void add_latency(struct access_coordinate *c, long latency)
 {
+	/* Convert link latency from picoseconds to nanoseconds. */
+	latency = DIV_ROUND_UP(latency, 1000);
+
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		c[i].write_latency += latency;
 		c[i].read_latency += latency;
-- 
2.51.0

