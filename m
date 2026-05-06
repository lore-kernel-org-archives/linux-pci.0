Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013085.outbound.protection.outlook.com [52.103.43.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9A4921BF;
	Wed,  6 May 2026 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076664; cv=fail; b=u+ETYql4tI20cTXpFYInMdevn9bCK6+gzudLEkXR0Vj1KQ/vVecNRlzTg5WZfyLEUREMNh60vvFpwN+dlv+7mff9GCt6/jN0blqE4AY5uJVe5oQ7VzRa+Myn3ox/hKcdwCY0P0wUrrrQ3YaGwb6MuPprPvjdl2KcYNRducDt6vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076664; c=relaxed/simple;
	bh=CLmBlYUv2LR4DcbrCrdJbxrRyFlxZoQGygkxKddqVWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FY91lTuZorV8b5oBJbk3j/sQkJEG40mZf54RHApTcbNlFw7lufk5mO8R9VBu8LHy7GUIXqVub1E/eYDfIq+mTNYrSLZ8UjXQfI2OPdtLvdcXWZ1Vw45TpUgttIRtYkp/hd+Xb0iilxa3he2KkPcWAuNxCSXXXu25LV4nqVQE9Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=tpdkj9qE; arc=fail smtp.client-ip=52.103.43.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="tpdkj9qE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EC++RQrAnS6pwCXXSurEjS7M8u2NmwAXS9iUJe/3bzB1PZyiZW39od+pUFVDZlqo0KCg7YNyHOtS3mA0UNezZ+ed6zioqxBzXpcmpo9iBhdXw4dPoto0T0BIObOAhEJGoMcz1Rd71w9alD0fKkDZ4pT32Mmg61CZQaokHO5PQm3rguslbTvbSxm1xpAtotOmX4bh9xFW4C6isU3BJG8rTIthYMU0e5WJsnthb1prZMM2F0dzPJC3PPzzelAEDW6SP7niOM44QGLGNHr+BpwqsuvWcLg5oXawxz5aZo3zcHdfVm+vnJW7u+vKg7YOQ4HQbNpydB2EoQBsjgyvXHP/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XAjjx0zDw1RdHfefDwhU0O5f9UlDtOyz2Oy9By+s7g=;
 b=tfo4MhqA0Axngr9hEO8zrGyC6XYmNZAXGm153g82T7a3tdbuiKWF04XOH2v2v3qTA8DeJrqSnWKf3I8qxSSOk55oPZexEzEbqM0Lh4pVCOYNUo+PPK4QNoqDtbfefUVs7NQjm6cChC6T2paS8X9l4ADUyUPc/9Yw52i6fCG9qgBfY8K4A26qM+LF1xBLGUyNDJ+FckvqLpuMQP60FgQyxQ7QHY6gb9zekVdgSvi+qS3cEO2WL+4drWvS3xGq+pBcJPJrCSa+IL6H7Hu7UViU0ZRRCQrFvfdjh/VGNW8/V3AVwxpMHmAe1Ecvuwg0CC4TBdpn1T0XR8dMvhW8WhgKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XAjjx0zDw1RdHfefDwhU0O5f9UlDtOyz2Oy9By+s7g=;
 b=tpdkj9qEzpDMBmVjmwxf/GcgSZVYFKv9mTdiW2xeajsh3KlkNJgXn2MLanT913aHQiwXP9atR3+mpNA1plHV9+AfQ6QJ8r0V0xpNgSRMgaF1EXgF+k0RtjjBOCrQqJdczwVhX1u0fosjAPOER19cKai20vH22TMWj94do3+i2obwRwX+eYWYxVC0KnGWhs2wRMJ6y6phFslUSVwHKE4wb7wocXPXhPnmLDi6Jb2u0W5BnzqSuf4LFrfXrddGvpjgVT/tWj8THwzsUvDFG9iL7TtNi/d6GeBK9FORyLGDpXlG+fl0/Azt+I+Xwd+IhPzglaKSLGOEtEOpKFM+4WyAFw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4454.apcprd01.prod.exchangelabs.com
 (2603:1096:101:70::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Wed, 6 May
 2026 14:10:58 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:10:58 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v7 4/6] PCI: Refactor disable_acs_redir and config_acs param handling
Date: Wed,  6 May 2026 22:10:32 +0800
Message-ID:
 <SI2PR01MB43933B1790A24957EB7DB79ADC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260506141034.1738541-5-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0631ea8f-c522-4f64-b5d3-08deab794b7d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799015|23021999003|5072599009|6090799003|19110799012|7042599007|15080799012|51005399006|16051099003|12121999013|461199028|45011099003|37011999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnNtM0NibW9JTno1L1hwS0dyb2ZkN2FrVWppaUwzRUoyMHRENmYreUNXcVNR?=
 =?utf-8?B?MGNERWdPaTY0NU1JOG5RN1pNL0JXQUNnUUFXd2hDVFBpMXhyblhKOHZHQkFx?=
 =?utf-8?B?OW82RWplSi8rcmpWQTFaQ2x6clYxSWZrbEhaQTJjcUVPR2JYQzZNS3N1Sndy?=
 =?utf-8?B?UFNteUQ2dDNQZzJZZFJheHRxeDhVYXlCY01NNXRtbmhZVnVoanJYdms5ajgy?=
 =?utf-8?B?djBLOTduMjJxTityM0FFMnFRMlFRYzVUZU12RzZnaEVYN29XTDNhbGNKRS91?=
 =?utf-8?B?ZDU0TUJhYnNubzBwOTBHZ0dqU0FmN0FoU1NGQ2F5czRVSWNvaWJsd1ZaV1E0?=
 =?utf-8?B?SlhaeCt2THFEbVcwS0NhcklnS1FqclA1MG9CVG9lQ1U5V25LMFJTUytISXFw?=
 =?utf-8?B?TXpaQWlrVzc5Sk92eFFIRWk3VDc5b2tWV2U2N1pWcnk5UmNRRXVVSTBvZnpr?=
 =?utf-8?B?Wit3YVpFd3lHSHl6MXpaWWx3ZitGRGRRRHRCV3dOcTZjWUtlL1FtUmFXYnJF?=
 =?utf-8?B?Ylg1SnVlQXJGc3psc1Z2c0tRd2lFQmI1WGp0NWVYM0tFMmRYQXNtWmhwS3hZ?=
 =?utf-8?B?WDRxS0VsMXZrRHRhZmdkRmpmVEJnRFlrTEx1azd3OWZHT3lPbnEyYWllb0tH?=
 =?utf-8?B?Vm5HbnZ6UkFNZGZvSVl5Vm1YSmpZbUNUaGFuZUJWbnFBYVdXblNydngzZk40?=
 =?utf-8?B?WkRTZGpRLzgvMTVoVmszcE9FVXNxN20yZ2pUVEpES2JRV0h6YjBKS042ZWgx?=
 =?utf-8?B?OHpGNy9KdXdkSE9oQ3VBVXJubkg0VXhVdWV3QzdvZE9VYXljSlpFQmpnR3FL?=
 =?utf-8?B?RlMxb09tR0FWYm1lUERSZTMwS2NhN1FOcm12QS94TkFqVmJjWUh5Wm1ZaHB2?=
 =?utf-8?B?K2JJWHR5MkpvWHpVL28xTExSbmVTSmUyZ0RXSlBwUzhOdm9GK3JSRW02SU9l?=
 =?utf-8?B?ZDl2cVBuM1pnckdITGRkdzNUNGhzcElteXlSSnlRWGZBMTlQZXZIYTRBcWFJ?=
 =?utf-8?B?UFNyeXNCcjBFcjYySnNLL0NsZnRJLytsUzVhWWhoZHM2NzVZUzJ6QzJSVW9O?=
 =?utf-8?B?UHZVQ3J4RU9xUjE4Tmo0R1hXWEdSV1U1NkVWQ2N6TWliQ1V3YmJVQzVia0pX?=
 =?utf-8?B?RkdHWi9JUXRiMldKYTRPMGlpS3FSa0ZqM3FMZGNGcTZieGdEUlYyempqVGZm?=
 =?utf-8?B?N1ZQMm5vNW5GMC9Rc01NQmx5S2VkT3UvUWZ3T3VnbGZzdFM0NlRSaHRMSXJE?=
 =?utf-8?B?c2dhbndXZEt3WE9FV3VyVWJROVkxUm5JUjdGMWlxS05kZFJrdDcyVGs5WXUv?=
 =?utf-8?B?Mnl0K1dYZXY4ekRPbTkvUWZtL0wyQnF4OHFMYVNyMWVqTGdhbGt4c3hJcFM0?=
 =?utf-8?B?eUpYR09lRkdocEdGRG9KVWMydlRKUE5HaTVESVRqQlpOTjhLMGRzSGc0Sitw?=
 =?utf-8?B?RVU0QWUzKzlDYjNGQTJjd1lQQU5FOHZxUzBHakhGZWxqTzkwZGlvVlhKZ2dN?=
 =?utf-8?B?N3BhSkVFUnA3dzNoYnNpNk5YTTYwaTlmUEMxS28xRjIvbER2RUJxTTRFamIy?=
 =?utf-8?B?YTZrdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHVEV3Vkb2pnMzFnZzY0c2lzUkVJMkdxLzJOM3h4TFIybG05WXVMMzY3U3VN?=
 =?utf-8?B?MU1FcVZ5NHE5a08zYm0vNzU0UU0vVUJrTEtjMy9NTm1icEtRaEljU1BsVExp?=
 =?utf-8?B?ZzRyTi92RU4wYlJWUGZRZSt1VWRXcEZlT0ZxTVFjYVFydjgrVCtxNlQ1K2Mz?=
 =?utf-8?B?WE1xQ2U5bm1BTExyZm0vWHRncUdDSjJSUTlZcGwvbCt3akJEWHhrb1RCS25E?=
 =?utf-8?B?TVVlVW5zZzBiOUtucFNWS2RyRWFIWno2Q2REeWRsV2pBMGgydy9ja3gvMEIy?=
 =?utf-8?B?QVRua1JVUDFGcng5MTgrbTR3NHd4QVdtQTNPcDl1K2lFc0x6eGU0M25Yb0ZN?=
 =?utf-8?B?N2ZjUlMxamtFUTVsZWxPbEw0YmpCSzJpTGJVamJYM2pNSE55T1E5L0xhVkVV?=
 =?utf-8?B?YlpMV3hKQ0lyS1VhdU9EMG9xMFBUSllFaytrWXViQURvamFsOXdyOVZMY01w?=
 =?utf-8?B?bk1WbURWNnYrR1lTQ3JJcTZEc0xHUkFzSzI4bVl2MXhKSVJqRTBDTk4vRnRX?=
 =?utf-8?B?aDFOeTUvd0NmbUQ3TFh3QTN1K1E5WHBEN0czbjN2Q25qUXJqRCtNdVJWVEJj?=
 =?utf-8?B?NnJjR201QXlOVUwrZ0JrWGNnd1kwSGE4VWJ5clBzWTJ1OWlwbkJldi9jSjBZ?=
 =?utf-8?B?ejdCb2RqTnp5blR5dVJoRHpqYjJnTUo0NG1xdTBnUHNxR2lRZmErVmdpZTJD?=
 =?utf-8?B?WDlUR0hOOEIrdG9KM2VXMGllcXFpcWpwcTVxZWlzazk4ZEhNSERUSEF1VXZr?=
 =?utf-8?B?QU1IL093R1F4M0cvZFR1amZpb0NheHIwd0Y5bFZqaURZaDNGL0tsejN0VjNJ?=
 =?utf-8?B?VVZTQ0hqOE8xN2tRQmZicTZmWmdiTVdkRTZ0UVI0WENvVWgvOWp2cVM1b1lF?=
 =?utf-8?B?T1grdEVTaTJ5NFk0UHIva2JuNnFadFBIdXFQWTJVTUFFb1VBNzhQclRMY0Nu?=
 =?utf-8?B?aGIxazlSVjE5MnFVMkpEODlhT09SVnAyNWo2R0M4Skh4Ni80SUZFVjJtc3Q2?=
 =?utf-8?B?QU9nSXVUUmI5c1BWWlFMaDdXc25nMlVLeE14UDJheXBFREhJSVU3S0FQY0dK?=
 =?utf-8?B?Y3BGeEpRQ1crMGlaRlc3S2RLbnE3Vjh1d2x3SXVnTWVHaEdJdkNQNkN6OVNz?=
 =?utf-8?B?SGhlNDdZYWpCNmg4RkRnUnB6Vjk3a3lrcE5UWUVGME9iZ0xJYStQL3hkNi9s?=
 =?utf-8?B?emlOMG9hRDBkVjlLeVp1RnFJSWRDbGZObzI1ZFBuV2hDalFsUUhZWEJRWVFa?=
 =?utf-8?B?cDBnLy9YRGx6a3dqVXI2QzExVFVwYTI2UTR2cXJ1MUl3dThLL0xsdC9SOE9U?=
 =?utf-8?B?K1M4QlNNSjUyWGR2TmFrZDF5ZDlpUGpiazluV1B4ZldSUjVkWHZIQS93eGhI?=
 =?utf-8?B?dW0yeUpZMDZkZlRhazNuTjRQMmhvOVFvK21PNE9QNGxPaGlSblRKUnduNjdl?=
 =?utf-8?B?L2hGOWtUSml2RVR2bVdtTU14WFJHZjRaL01YcmlCREJINVJld0trajhIT1dG?=
 =?utf-8?B?cW9YQ0Jvb3haQ21CODhMeSt2SkFkMTFVWDJBbXFUOWpkYWx4MmhWaU9qQjJq?=
 =?utf-8?B?ZFN1VlJsNk15UTQxaDBFVDF2SmluQkZjNjczeDlETzA0T1k4bDIwSUYwUk9l?=
 =?utf-8?B?QlR6VFowcTVoSDl4QkhZU3pQNlVwK0RBbHBXKzB6UlBBU3A5M05veG8yOHVt?=
 =?utf-8?B?U1NsNjl4NWZzVlpIenB6N0t4TmNrVVlOQ2tsbFFqV0dwR3RlM3l6M1VuM3ZY?=
 =?utf-8?B?UWNGdmRaWmNMOHFCOTFDbHVXU2J3cGFxVFdXdi82TjRxcW4zNkNSdnpta3Jh?=
 =?utf-8?B?OUZCMFdzWmtieUd4djBWQTYzb2drcUxnZ1c2aE5rTnFCOVF5N2tLSktjcC8r?=
 =?utf-8?Q?Mw28Kboy8kE9P?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0631ea8f-c522-4f64-b5d3-08deab794b7d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:10:58.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4454

The current implementation mixes disable_acs_redir and config_acs param
processing inside __pci_config_acs(), using acs_mask==0 as an implicit
signal to switch into config_acs_param mode. The intertwined logic is
hard to follow and easy to break:

  - The acs_mask==0 special case is non-obvious and obscures which code
    paths apply to which parameter.
  - The interleaved logic is fragile; changes intended for one parameter
    can unintentionally affect the other. For example,
    pci_dev_specific_disable_acs_redir() is invoked on the common path
    even though it should apply only to disable_acs_redir.

Split the two behaviors into dedicated functions,
pci_param_disable_acs_redir() and pci_param_config_acs(), making the
control flow explicit and easier to maintain.

The new pci_param_config_acs() implementation also improves on the
original logic:

  - It searches for the matching device first and parses ACS flags only
    for the matched device, avoiding unnecessary work.
  - A switch statement replaces multiple if/else blocks, improving
    readability.
  - Bounds checking (max_shift) prevents overrunning the device’s ACS
    capability bits.
  - Variable names (enabled_bits, disabled_bits) more clearly express
    their roles compared to the previous mask/flags pair.
  - Error messages are simplified to reduce dmesg noise.

This refactor separates concerns, improves robustness, and makes future
extensions to ACS parameter handling safer and easier to review.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 168 +++++++++++++++++++++++++++-------------------
 1 file changed, 98 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ebd1e81264d2..54f702ed4c96 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -900,87 +900,117 @@ struct pci_acs {
 	u16 fw_ctrl;
 };
 
-static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, const u16 acs_mask, const u16 acs_flags)
+static bool pci_dev_match_disable_acs_redir(struct pci_dev *dev, const char *p)
 {
-	u16 flags = acs_flags;
-	u16 mask = acs_mask;
-	char *delimit;
 	int ret = 0;
 
-	if (!p)
-		return;
-
 	while (*p) {
-		if (!acs_mask) {
-			/* Check for ACS flags */
-			delimit = strstr(p, "@");
-			if (delimit) {
-				int end;
-				u32 shift = 0;
-
-				end = delimit - p - 1;
-				mask = 0;
-				flags = 0;
-
-				while (end > -1) {
-					if (*(p + end) == '0') {
-						mask |= 1 << shift;
-						shift++;
-						end--;
-					} else if (*(p + end) == '1') {
-						mask |= 1 << shift;
-						flags |= 1 << shift;
-						shift++;
-						end--;
-					} else if ((*(p + end) == 'x') || (*(p + end) == 'X')) {
-						shift++;
-						end--;
-					} else {
-						pci_err(dev, "Invalid ACS flags... Ignoring\n");
-						return;
-					}
-				}
-				p = delimit + 1;
-			} else {
-				pci_err(dev, "ACS Flags missing\n");
-				return;
-			}
-		}
-
 		ret = pci_dev_str_match(dev, p, &p);
-		if (ret < 0) {
+		if (ret == 1)
+			return true;
+		else if (ret < 0)
 			break;
-		} else if (ret == 1) {
-			/* Found a match */
-			break;
-		}
 	}
 
-	if (ret != 1)
+	return false;
+}
+
+static void pci_param_disable_acs_redir(struct pci_dev *dev,
+					struct pci_acs *caps)
+{
+	u16 acs_redir_mask = PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
+
+	if (!disable_acs_redir_param ||
+	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
+	    !pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	if (!pci_dev_specific_disable_acs_redir(dev))
-		return;
+	caps->ctrl = caps->fw_ctrl & ~acs_redir_mask;
+}
 
-	if (flags & ~dev->acs_capabilities) {
-		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
-			(u16)(flags & ~dev->acs_capabilities));
-		return;
-	}
-
-	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
-	pci_dbg(dev, "ACS flags = %#06x\n", flags);
-	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
-	pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
+static const char *pci_dev_match_config_acs(struct pci_dev *dev, const char *p)
+{
+	const char *seg;
+	int ret;
 
 	/*
-	 * For mask bits that are 0, copy them from the firmware setting
-	 * and apply flags for all the mask bits that are 1.
+	 * Example: 11101010x@0000:01:00.0;101x@0000:02:00.0;1@0000:03:00.0
+	 * Three segments delimited via ';'. @seg always points to the start
+	 * of a segment and p advances to the start of the device id (BDF)
+	 * after '@'. Upon match, return the start of the matching segment.
 	 */
-	caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
+	while (*p) {
+		seg = p;
+		p = strchr(seg, '@');
+		/* If malformed string, stop parsing. */
+		if (!p || p == seg)
+			break;
 
-	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
+		p++;
+		/* pci_dev_str_match() updates p to the next segment. */
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret == 1)
+			return seg;
+		else if (ret < 0)
+			break;
+	}
+
+	return NULL;
+}
+
+static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
+{
+	u16 shift = 0, max_shift = fls(dev->acs_capabilities) - 1;
+	u16 enabled_bits = 0, disabled_bits = 0;
+	const char *p, *seg;
+
+	if (!config_acs_param)
+		return;
+
+	seg = pci_dev_match_config_acs(dev, config_acs_param);
+	if (!seg)
+		return;
+
+	p = strchr(seg, '@');
+	/* Parse bitstring backwards from '@' */
+	while (p > seg) {
+		if (shift > max_shift) {
+			pci_err(dev, "ACS flag bit %d exceed range %d\n",
+				shift, max_shift);
+			return;
+		}
+
+		switch (*--p) {
+		case '1':
+			enabled_bits |= BIT(shift);
+			break;
+		case '0':
+			disabled_bits |= BIT(shift);
+			break;
+		case 'x':
+		case 'X':
+			/* Skip this bit */
+			break;
+		default:
+			pci_err(dev, "Invalid ACS flag character '%c'\n", *p);
+			return;
+		}
+		shift++;
+	}
+
+	if (enabled_bits & ~dev->acs_capabilities) {
+		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
+			(u16)(enabled_bits & ~dev->acs_capabilities));
+		return;
+	}
+
+	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
+		enabled_bits, disabled_bits);
+
+	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
+
+	pci_info(dev, "Configured ACS to %#06x (FW default: %#06x)\n",
+		 caps->ctrl, caps->fw_ctrl);
 }
 
 /**
@@ -1037,10 +1067,8 @@ void pci_enable_acs(struct pci_dev *dev)
 	 * Always apply caps from the command line, even if there is no iommu.
 	 * Trust that the admin has a reason to change the ACS settings.
 	 */
-	__pci_config_acs(dev, &caps, disable_acs_redir_param,
-			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
-			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
-	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
+	pci_param_disable_acs_redir(dev, &caps);
+	pci_param_config_acs(dev, &caps);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
-- 
2.51.0

