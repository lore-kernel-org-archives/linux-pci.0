Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012059.outbound.protection.outlook.com [52.103.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D1220F2A;
	Mon, 16 Feb 2026 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771208842; cv=fail; b=SZaMtbD6i/UQAjpV/kGOMtAgN09m08rnVgu92C6mz+skoJpCbztV/GFfYPKfryXURJTLhpxOSLh939P9Gifsf4jXRw7r3NsdOx9tz2p46Q3ms2eYpPsJWV7Nk/QObyK22heq/42uUV1Lg04LKRzKI1yEWNgkqgzLmzdQe78ljJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771208842; c=relaxed/simple;
	bh=xs5nQVGPAGV6p210nd6mRn3KhvRsrRDI79ZawuvrUqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pN33pgn/PLRuR7ZwRiVntmHlrhpfD/cFFCeZvw91oHhtAXSoW7AOiZRUhT9d1SY1TvnnS1x4GPF6C4TZabqw09PPPkcMZLCPo/xRzyVa1ZLYbPVzVebS4i6X7DvkdZpl/+4sMNfZsF5bkw8sU97EiEkUnKm9sBAiCPRzekvN7Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=HvOX0Q8S; arc=fail smtp.client-ip=52.103.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="HvOX0Q8S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyY4Yx4b+fd9uxF1NqOinYVQd6uuQi64mDkd++wxcPwv5ioa9byB/cwiqZn6Xh4dPN8vn+VzsjmBg+y7zFvDbolwdMuQPD97JAgNP7SFcqlXyjvgIK5/YRIxTxq4QPCslLrMSJBKLEr48DP10gMnb4ax+THcWwSxRRzjKHOAzzyyCiZFdVIc3e8AGCoTY/eYegiDD8zjDFhk4nOS8e9FCdtp63lJ//MZ6WC11yEXYneDaU+EyqEAnFks0zCKXb+TLWd6BiETSpNQqFh1XmNwcljbv8UJd06xB0tzXEaaP/BDUTihBhlOmmPoBtEYv32cQ5q8fdqi9tI1YKz36OmF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7PLXq2SRHEq6nWilsnGkOfA/X1gkzlUkSElH1dAVfo=;
 b=dROtHtbjouj6i1Xb9GjI8p5zJUPo5qYO5ZREUS2iP3Una/g3ickXcGyuws5NzEtcKkiFsZwPIXP6nVtvQxbFFRkDjENCASKOlthtNXWW31qlx30jiHJk6uV6OV+Se9xh5jCLuGBZqHRcQM7pa7aRcFQ3aWqwcbXgb5UQBedgmsd2QR/6Rr17HKNKmQ9cqV9btK6/WwWAlu9BnL+eCYKHePbaQokJeP9hJseoz2LGsX6POTIL3Kz4hElgrlBbXu3S4TanOYGqrDHwx3ziQAL3YH7Y6VrvOfwQkYzATl3aUIZL8g6Bovl2EWf4vT+/3fXwPFamtGR9bZN51P8SO4Aa9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7PLXq2SRHEq6nWilsnGkOfA/X1gkzlUkSElH1dAVfo=;
 b=HvOX0Q8SSxufvjjTUIZmp0ftzJXLLouRC1/lMC0LZAc7g9EdELuUCKwdEE0JE1EnzWL/2Dpftojmt/4p9WpnzfS9XxucvOCc0cI5pvbcHOdfP0RxKLiMSkT46TxK/oXaQQAThIGbk7Pmo+RRLNTyZz+U9n0KcYrk0me5vVpGqG8eglp85iyhp4H/4O/xH+yKAfaJLztcMQjf66OKgKq78JoEJqj0jrT4JJObO2q+DluOOoc6r+T5/TgOVf6Yo6QRPP3bzhIwfNqiQtdyOhAUZzQKxoGRAkUQxoEUEEkjOAcZO/s/PCC9GWlIHc/oxGdIQtIyPkQabcPTK2BaEdU5fA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEL0PF89D6F6B8B.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::5b3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 02:27:16 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 02:27:16 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v5 2/6] Documentation/kernel-parameters: Add multi-device config_acs example
Date: Mon, 16 Feb 2026 10:26:38 +0800
Message-ID:
 <SI2PR01MB439374DAD3F3E7F95D72E801DC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260216022642.112923-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEL0PF89D6F6B8B:EE_
X-MS-Office365-Filtering-Correlation-Id: 731a1604-8f80-4fbc-4ceb-08de6d02e688
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|19110799012|23021999003|41001999006|8060799015|461199028|5072599009|6090799003|37102599003|51005399006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVpVRW9xMDhXTXBuRS9rak5ZZkt5TG4wUHYrMFZMd2FQS0NzeGh6K1d5NTY5?=
 =?utf-8?B?TDBMRTBkcWFhazZMeDMyL3FoRE1rSHpGdStGM3gvZXdWYU1PVFdMSXhzQ2dB?=
 =?utf-8?B?UHl0QnFkRnhTS3h1QiszdjhsYnlvb0Y0R0hMVkYzNHBUMVpLRU40UUovUkVo?=
 =?utf-8?B?Yy9sblNiWTl2Zy9yWWwzSVR5UVhEUGJPSzVWcUtYeXFkRktUOXFuTUVrSEE5?=
 =?utf-8?B?WVZYTXBSZmhkMDE4L3JIZU9FSFVwWklPVXZCKzl3b1k1Y3dhczlqREsxUWc1?=
 =?utf-8?B?Q0d3a2ZrZkJjWkNQQ1ozRjVKN0xBNjNzR0tzYmlCVVBNMWM2eXpjZFlhVytu?=
 =?utf-8?B?WGFFR2dZS2xVQVNJZW1MWlFqUm5ibGxja0RxS1dTMmQ4OFZkcW9VOHh1OG1W?=
 =?utf-8?B?TkllMHN0RzJjbVhkTFNXeW93TGhSd29Dc3RuMHJnb2Q2ZnRuYTVXZmtwZWMw?=
 =?utf-8?B?aDhNUXNZamMyL1VQcW9SZW03UC9OZEp0R1JhbEdYVjRsckh6dHc0Qnc5NnZR?=
 =?utf-8?B?aUVyN01iU01qdU5QbHZTNTVEQ3RVSVk0Zi8xdjBkNml4Z0NFTWRYamYybDN5?=
 =?utf-8?B?UVE5cld1bkY5WVVQMGJjNWVnYmZpdzg3VHNyemNaYVJSTXFFTFY1ekw0M3ZS?=
 =?utf-8?B?dzl6K091TlpaWHZtRlo2ZmlKWXFGRTA1RzNRdk9iMXExczhwSmJad0dvd05G?=
 =?utf-8?B?anZvWGNpdTBVdC9jVlQ5TE5CT2haY2RzZDJVMTZuWGYwM2NVZGF5TmZFYUx3?=
 =?utf-8?B?WVViblZFVkJDOVQ0OHo5VWhrTHVlN1lYN2FaaERwUTBOT1VPMis0WkljbTBL?=
 =?utf-8?B?dUY4U0xGbG1waVcrMGMyZ0VjTnFqbCsyTTdxeFYwZlphbW1oQkw3UGxwUml1?=
 =?utf-8?B?N1A3cVM5SWxFMlNiMWFpcGxneExVc0JMWGtVekNBZE43TUNPNkRlM2RqWHQv?=
 =?utf-8?B?L3FtVnJDNHdOZmd6R2RIUlV6UWU1a3IzT0NBMUhQbXFMTmpmaGRLU0V6Mlpi?=
 =?utf-8?B?WnJGQU1RMVNWR3ZtYjJQNlBDVG50SWliQzBhcWZBaDRWY04wVENZZnFOTFFm?=
 =?utf-8?B?Y2ZNNzg3VmVlS3NxRjBRWnpuWlZJY3M3MnJYbE5saEoxRkNhc29hTVZBOEJM?=
 =?utf-8?B?dGVMUzM4Ry9xSzJnWXZkdEQveCtWRUw4L3hTdFhjaDZBWDBac01DcllzQTM3?=
 =?utf-8?B?QVFsa1ozYWJ6V0x2alhlVkFxaHdydjZLWEdwaXRpenp4Z3VDYjUxbXIwenZJ?=
 =?utf-8?B?d3BGRHhKZVpkclBCQU5OUC9RNDE0NFU3ek40c3JudVVidVdlVWJLVUNjZThW?=
 =?utf-8?B?amNhZ0VRcUNhRjVCdTQrcjUrMUZxeFd1TC9pRHBYbUJaTkJiZHd1ZkxkR3R5?=
 =?utf-8?B?dXZxeWJua2tsUXkvRU5kS05MOXFsZERFQ1FFK1NGYWVpbnZVVE5VYzVkUS9q?=
 =?utf-8?B?d0FENjZOME5RZG9IMm9jK1QwUjhEclNBNGsxZlNUOEpBOW9SQ2tvVUJoTmZG?=
 =?utf-8?B?ZExuRHdUQzRqY0tFLzNOUTdtL2ZlQS91djlJYjlMbTBPTll1ZUR2dlhQWTJ3?=
 =?utf-8?B?NnVqZVhqWVBLMW15OTlrSVZZODhyQ1dHV2tOT2FRdWxnQXdleFNSYnZ1aFAx?=
 =?utf-8?B?bG9vWDVSSTdRN1lFeHhGaTU3K0hFa2dvZksvenoyNHA3STJRcTRsTzBBa1U4?=
 =?utf-8?B?dUF5Qzhyck9JSVpMOFRZeThHb0h6UUhuYSswKzg0R25sRnByODRkZmcwUXh1?=
 =?utf-8?Q?ls2e0jsladNN+Bc7lI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3o5c0NhRGd2ZlJQVnlqbzFySkJxZXJrUnpmdW1Ua205RGoxS2RIS0xIcXMw?=
 =?utf-8?B?WWhyZDNqM2QzSm95Z2d2MWZFYlZudHpKeXpnbU9BM2JKVmhvb3FhVm4vbHVu?=
 =?utf-8?B?a3M0bEpmekVuRVplQUFGVEdOKzZraEZ6VTZQNDliZEhPVFdpUmk1MHIxSHFj?=
 =?utf-8?B?d3llOUR5ZFl1RXFNVWhybnFNZ1RsUklUQ0FkdjBkekszbzBGNzN0T1hTUWdI?=
 =?utf-8?B?VDdaQ09MbGUzSWZRSFZvWHFCMGR5Q3lEalV1RkFUcTdBTHV3dmVTYU1rZHhM?=
 =?utf-8?B?dFd1SFFybW5pdlQ0MTlwUE1MSmdrNVJNTFExcEJ4ZTdmV2ltYlQwN0lwTHlO?=
 =?utf-8?B?cEZrTXZuczdEeEcrWEN4YWJjbklhcGYzcllXNmtCdWllSG0yNXZOQVZ3V2g3?=
 =?utf-8?B?bWpRTjdaTVpsU0VFRy8rbVBNMTBrTXlGcFNZUVNOZWtDWTl1NWhKRThmNFJi?=
 =?utf-8?B?M2hYUXYxOWxJTWFBd0NWRzlnRDBZTVlzQ2dzdVNwaW9SSWFJK1ROK3dMeXdP?=
 =?utf-8?B?V1l0dUdrcGY2YTZ5RDB0MHovZTUrRmZuQXF4dllOMmc0bHVvNWZGam9QMzFI?=
 =?utf-8?B?NUZxdEw2ZmJJSGMxUi83dUo3b2ZEaUtjbzBPZWw4aHFtRlc1OTQ1Sk9SUWt2?=
 =?utf-8?B?TkhvMVpwN2VPdkV6Qi9lMjFoV0Y3TVR3L2tOS09ZRkhqZVRaNzlpSGtxckVK?=
 =?utf-8?B?d3ZzeUZabVlwK0k2OW1ZeVAxeWhxYStQWTRsMkxldDJkU1I4cXJJS0QvNU15?=
 =?utf-8?B?WDl5dW5kVkNBT1BNak5UeXdvTFJFUkh6QW01eUFiVkZyR1o5ZUluQjZJQ2Z3?=
 =?utf-8?B?aFgydGJHSlhlWmlhYnE0NUdKTFZTSURRalVPekp3YzdjM0FiQTlOcnNOaVp4?=
 =?utf-8?B?SE5KOEFQU2FQMytHYWttOVVHemlLaGVTN3NUdjM0ZWRrL0FyWDJaUUdlckVD?=
 =?utf-8?B?Tmw4eUI5RnhuSjNpaGIwUG0yamdIN0JjaE9hTDZlN1JiV1JqZVBEZGxCTzBX?=
 =?utf-8?B?eGNuYnRSdHkxZ3p2THNyYllzMFNMVmRva3JEM2FFWVlZUjljSklQSUFodFUr?=
 =?utf-8?B?ZTg4T1hwZ0tqME85RitpQ044Ym12RFFzdjNMMW52Q1RuYjlVRWE5UDhzbE54?=
 =?utf-8?B?WC9sWm1vbUZySFBnOUlHOEtGNXVsSzU1NGx2RjdQdzFUNkpPUnNIdk55N2pN?=
 =?utf-8?B?bHlEK1VaemxJR01jUk1PcjlwSXMzT1lQditGaU50OXlXcVZ3THo5ZnhhVkkw?=
 =?utf-8?B?RDExZTY5VDFTVVBZakl2YytGbU1vaUZZcnk4QlU1azkyMmRWSUdGbXVOVEkx?=
 =?utf-8?B?K01SN2NVWXRHdWRVY0xKcWlZTzhLNllnbk9IWi9kd3NLNmNjOG9TLzM1N1hG?=
 =?utf-8?B?ZGtaQUtWWUhlTVhZemhZbEZWTjBwVmttSmRoUllycEszYlJhV3VqUEMwZ2JP?=
 =?utf-8?B?MkdjbTFmR2hReU5ZQmk4V00ya0w2cEtIT0s1b1Y5d093alJodjZrSGliOEtT?=
 =?utf-8?B?bWFmWFRLWEZTSnAzYVk5UnJFNFJ1YncrMFRRUHE0Y3JIemttUHc0YXZvQXdY?=
 =?utf-8?B?RGpWL1BUdjQwYm4xK2ZUMUp0TzkrWjZPd0NBMzU0bGZydzdyNS9aZm9SaDFC?=
 =?utf-8?B?WVVtYkpiSGlaT2NVMTdtbHllWUtGd2ZjN2hoTVhFWHBRa1l6UitkcFpPZEgz?=
 =?utf-8?B?T2FyMXpEanZrd0FSdG1LSElmT1M3bnJTNVcyYVhvNHIwNVVJQldmR3NGb3NM?=
 =?utf-8?B?MUtJb2Q5Tm44V2ovWWpmZzNyMG9tc1N2djVJTHZLVW1zYklZRHBLYXpnNy9u?=
 =?utf-8?B?enJDRjQyZ3ArSlJySURjWGs5ZGdRSWtxbmRKSldwRmFVNFRsS1M4TXhmYk0r?=
 =?utf-8?Q?7DXqBDJ6dSmjy?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 731a1604-8f80-4fbc-4ceb-08de6d02e688
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 02:27:16.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF89D6F6B8B

The config_acs parameter allows configuring ACS settings for multiple PCI
devices by separating entries with semicolons. The current documentation
only illustrates applying one configuration pattern to all devices, but
does not show how to specify multiple devices with different ACS settings
in a single parameter. Add an example demonstrating multi-device usage
with distinct ACS configurations.

Some bootloaders interpret ';' as a command separator, which can cause
the parameter to be split as multiple commands. Document that the entire
parameter may need to be quoted to avoid bootloader parsing issues. This
avoids confusing bootloader errors such as ‘can't find command <BDF>’
when passing multiple device entries.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb850e5290c2..bfd13197658f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5293,15 +5293,20 @@ Kernel parameters
 				  '1' – force enabled
 				  'x' – unchanged
 				For example,
-				  pci=config_acs=10x@pci:0:0
+				- pci=config_acs=10x@pci:0:0
 				would configure all devices that support
 				ACS to enable P2P Request Redirect, disable
 				Translation Blocking, and leave Source
 				Validation unchanged from whatever power-up
 				or firmware set it to.
-
 				Note: this may remove isolation between devices
 				and may put more devices in an IOMMU group.
+				- 'pci=config_acs=10x@0000:04:00.0;1x101@0000:84:00.0'
+				configures two devices with different ACS settings.
+				Note: Some bootloaders interpret ';' as a command
+				separator. If so, quote the entire parameter to
+				ensure it is passed to the kernel unchanged.
+
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
-- 
2.51.0

