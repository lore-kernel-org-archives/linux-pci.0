Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012061.outbound.protection.outlook.com [52.103.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AA392820;
	Thu,  3 Sep 2026 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407226; cv=fail; b=tyBMEb44P2jQuqoYxMm3qYTceJzJA7leqnd/knvgjKgkm8272p1DzqcGrFDmLlA2g0UGQsWPXWIJv1AtsQ2owQwvoCg59aWYZ9jSVaWQbZ6N8kq/y1LrNNKqybjfeIoI+fL9i79xAE3OH0nyudUFn3jj2z5m4J3lokiw1onGmVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407226; c=relaxed/simple;
	bh=1COkft2QkEHvSZG4jONo33lvgZ9CAv7/H2XxI2jVkJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nx8ovYlthknmleh8ScWZPaPGttB+eSRToz3HSSSlfabHPjw6ll1cohknf4tOoNrUUYEYQomfUF3OAO3vggq1UAoj7NAUMc2S0yormYi1m61VXTc/lWvtFU/42h/gUbLNdSV7ALTRstyfKrc7YY2zGiehUvjJRBUu6wPVxHmGbso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=KKh6Zu1X; arc=fail smtp.client-ip=52.103.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="KKh6Zu1X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD0UPRK0J3FZpYG1hdrq00fnFw8EOrb/DuUZ5K3q04pliQqamfHfHIAiHESDjkaPayS8nlkjHCqZGS/2pyWD7k1mDUgL17+HXAqQFSj28e/VkX4mWsbNx7/zSJCN2KkK0rsik7Yj1rIZevI13UtE6CNrC7Z9THGZXdPU77LzL6tJWHEFK/M5mPNQ2wC9hrtnKMtGfswBtNd+lAOROzW04EWDMZkuluBNCE0dgVXlLwqo2ghotIW7P7DLi6cXjhxrbgIBzdLLGSf6SF6cPv9TaOhWOSY6cjPjv3PMUltsC/EW5DJ6b47jp9PZxNu4b4jq+/xPbynCJu5eEiFsFvlgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmjAr3sLKoJIzbLJaaHc5wAmrtZRgCtM0dH/yQzsXMQ=;
 b=ewtlN/Ujs1gEgJc3c1DVuToG6QxmML+55HOTAxsJovHgAz1Wp5ZBeJeG9upLDJSx2mLn4gPGrgQKL/TG5T/OQXB2JxGlTNtT8e7ApAFmbw61CMeI4oMJG+trlPHsPSE86rUa52Aw1aGGEhLui9Vu+JW6P8O/iY5Oy4MsGjXeu1YeHF5ukY6UmkZ9a6PGi/j75DH4ohBQl5ruKhzj+m0vYi4bf+5Fd6E/cnS96/xuL16Bth/gVzUtPPfCatmysoG3EKRDIEUYzBogfEBlPr5qnJ+h3Yq+KxSZ9c9fkZ8VU2zIuAetiiYpMnU56B/0+V2iHY9FZboD5clbg9fA4fo2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmjAr3sLKoJIzbLJaaHc5wAmrtZRgCtM0dH/yQzsXMQ=;
 b=KKh6Zu1Xt50PxUVkx6Bfp0SDJvxE4RvGRK9dLjhwvAalG/wssdUPiIgaWDMmo9XNrtcume/Y1tqzLRbgkpH1Yed4JsdsFFPd0TgAinR00m+UgE0+tVLw880fHSLxFIPB/yFQtYm96551S6fruKYcL7R3Lwhw4mwi3eNQNmGQk9p/mBtAiZy4rfRBCjzF3kt8ctQSiypjJ2BYGV2FXFEi6EeUFn5E23U+hXeMz+vP1KqXrL1bN4KIqx+2hDIXTW00qMXOxcBJzVxyvEZWJEA3OhHZi6GcolPW7Amie2/5L0cx9jY6Y4e2MhMdC6DEM2Ik7eSQxZxJH8YME7fFqPJ8og==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4278.apcprd01.prod.exchangelabs.com
 (2603:1096:101:41::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 03:46:55 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:46:55 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v9 5/6] PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
Date: Thu,  3 Sep 2026 11:46:17 +0800
Message-ID:
 <SI2PR01MB43939FB8FF7F1239925023C4DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0092.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::7)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260903034618.1100387-6-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: a058587b-6da2-4f56-9859-08df096dff32
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|37011999003|23021999003|15080799012|16051099003|45011099003|41001999006|51005399006|25010399006|19110799012|8060799015|5072599009|6090799003|2607281247196008|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU5odXZjWVFYb1dUM2Jza0lCdVM0SkxXRHVYM2doUkp1YVZxbG56amdaWTBS?=
 =?utf-8?B?VGZ3UEFUbk9WbWVpcW9mb2Z0ODhuTWdtZ01xRjY1bGg5V05Yc1Y3b0ZtWTBq?=
 =?utf-8?B?bWdjV0g2eXNTbzUwT3JUM2Jhc2NER3VtLzFzaW8wRWp1N1NFVmNRVlM3Z1pD?=
 =?utf-8?B?RmJDQ2pQbU04SVNtcVJxbkVRU0liNVRKdzY2MjJKZE5RaEVqdCszbG5HVTVD?=
 =?utf-8?B?U293eXBvM29BQkFMbVBjemtRMHcwVm9rNE9zQUpnaXJBNDRybGQzQ3o1MzJS?=
 =?utf-8?B?NkdYK1VTN3NEdTR4L2hqWk1kZzJiOU9SR1ZTV3dHNFZNKzB4RDJFK3VUWG9q?=
 =?utf-8?B?OW9ZV0dHRTJNdENUTUFTTEFNMGh6QVJERUFkNG9hT1loczZUdjRnRXFzWlV0?=
 =?utf-8?B?amZ1akpOY2J6TVQrUDN0cXZoRUZkcHQwOG1sYjdqaGdGUkFDTXE1Q1JvZzhX?=
 =?utf-8?B?dTR3Mi8yV0FzZ1BSYS9wcWprU1pTZnhiQURvVnYwUEFTVGFmS3hsWTBVeFhS?=
 =?utf-8?B?U1BsY3lnc2tKampkWlRScnNVdWlVZVhLRHNoMkVmUExPMkRtQTZTOHBkdEFS?=
 =?utf-8?B?OXh0WHpxLzhKMmF1bHRYME1pNDR1OW9CMGhnWkdGQkdlYnJuZW8vaFhRM21l?=
 =?utf-8?B?U0hsNzJIek13aFp0emFGcldCRThsb2xUU0xuVkhFSmhJZUNDTUpLR0JZejFS?=
 =?utf-8?B?M0RSU3ZvbW5TL3gzNm9EdnFmNlhDdVFuM1lkMDdUZEZicDlTWEdjdUt5SVZi?=
 =?utf-8?B?cFFiWHZvOElDd2U2N0ZwMUhXNkZ3eHFZb1BoaWM5TmRVOXEvTTllaEo1Umgw?=
 =?utf-8?B?RUVxOGhPN01rNFZMdUVNMXY4c1JnOCtlZ1NPMDFJMFZFZ0paT1IxeFo2NVhL?=
 =?utf-8?B?RStuM3FYbmxPaFVyT0ZicGF0MkhJcktwckhKVWp0SlNaV2lDaVg4RGcvcnVG?=
 =?utf-8?B?TUxxMHVEemowaEhBczFSREh2R0RKSjVKa0NZOWdWSVNNUWpVUFRaWmM2dkF3?=
 =?utf-8?B?WUlxeENreG14cWkvVWtoV3dFMU10YkdvcUxzSkN6MGwyVFJKaXlFSWR5NzM0?=
 =?utf-8?B?OU5GQWN2TE1UZC9NdzZyQ21uU05zejJUeTRnSm1tYmd6S3oxNTN2RmM0dk9X?=
 =?utf-8?B?SG5CajJ2UWowNERxTUdzUDIwV3ZtaFNobGlKeTg5YVN3UWxlc3p6QzZWbDEr?=
 =?utf-8?B?RS9QaGlFQ3ZROEI4ZnlqYVpFTWZISWJrUVJ4c1BJZXV3R1hJaFJNTnl0T0pB?=
 =?utf-8?B?NnNHYlE0VzFhdzNLbkNJc2NiclRsZEtEU3VGV3Q3TTdpRlV0MzVGcVR3WE1p?=
 =?utf-8?B?OC9SL2FkL0JvTEEzRWkydmhCU3F1VElrU0FhUzJHanZsMEdWZ0RUSklyVGg0?=
 =?utf-8?B?N3NnVHViejRjcXpWdzJaekVTSXlSdXMwckUyTVhHQTZnWEZCY0M4NmVCWGFw?=
 =?utf-8?B?bFVCSm9OSkZiMGUzeGl1eFlNeTg3K2FQSDZEVDFxYmVIMEhlcHpXd05yS2V3?=
 =?utf-8?Q?wQVz0cAcPgFkcOK1ItJMvZn5Ihr?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUpWekkyVVN3WjA5bThtMnpCTU92L0dBZjNtUDdET1I0TXlrNjBBeUdhU3Ir?=
 =?utf-8?B?Vkc3bUNrMUxydlljQjVmNzFPYkNmNHczK0tjRUlMWmxQbG1HVWJGcDZEc0ta?=
 =?utf-8?B?NDM5QjdMKy9zWUVMQW1UcjgyT2tYN3lkRXkrb1RCRVVyVXRsUVZGRzBKRXUz?=
 =?utf-8?B?WStZajcwMWU2N2ZSYTZ4VXVzRzRYZTZTRjJDbk81Q3lXMzBPTVRuQ1pWRHpu?=
 =?utf-8?B?Q1BZNm5rcUJ6SEQ2UE42ZmRkQTFFY0ZNem5pWHE4bjd4RXZTSXpqNmMrTHFW?=
 =?utf-8?B?MllDaVJPb0dkdEpJYXVhcXNEcGd0V3Blb0hSZVJvS3RpSVZCYzNFczh3blNQ?=
 =?utf-8?B?b1pkYm9XaEh3M2ZxQk9ZKy9qSmtmR0tSNlNBY2xQeDJ4MnlXYzVYUVNNZFdW?=
 =?utf-8?B?RjB6VWZyMTd1OEV2cFJWVml4RDJybkNJdklFUWYzNVJDWm82OStxRUtsUG05?=
 =?utf-8?B?N1ZPQk42V01wYzR4T1VQTGZaWXpCUlNHdDA5Nm5sNzBkWEY2MXRyM29qUE5l?=
 =?utf-8?B?WTBRZTBZRlVsR01QQ1pBVlcxNTB2Nkp5M2xDU0RtKzdTekJYSEVLLyt3MCtP?=
 =?utf-8?B?V3RVSDNNNmNuYTJTeExxOHZqWG5oUVlZTlAwVWFncFAwbk84SjlhQWh2U1Bn?=
 =?utf-8?B?Y0VzS1hyM1NvL1paaE5FR2t6SituVElsV3U2SDJhem5Qb1lnVnJhbUIwZTlr?=
 =?utf-8?B?NmJxQ3pqazk0aThDZVZ6NlBMcEphOGZFa0h6cTd5M2VnMXN1K3JyMlAzckxU?=
 =?utf-8?B?dld4RzdQajBHam1nWjBaYkdNZjhNQnZTMkR3NTRNMXk5azFKMXgvdjJWWWtG?=
 =?utf-8?B?YVZ3YVlheTRTWVRaZnV4MDlPdW1jNTFJSzV3b1J3SW1mZHEvSDVzVzh5RDlE?=
 =?utf-8?B?MzlmQXoxaEdnUEgvV1VjS0liQnZScnJTSkNJVlJsYmJjYWRLTndjNmJjUjFx?=
 =?utf-8?B?aGN4cnFKMXYyMkxRcm5Pa1dOMDFPcHEwV0p2WmlnNWErUUVHb1l3TlhyOGFV?=
 =?utf-8?B?c3pPQUptOGlZQ05CNkJUNUdXOFR0K0ozc0RYTzhmZmlRT2hybU9OVGtFMEtw?=
 =?utf-8?B?S09EOXo4L2o1YTlVZkl3UzFiL3hWV2x0blN5SGhqdngxbXN6dHIyN3l4S0tI?=
 =?utf-8?B?RHZMUmdFdFJqazVLUFF2dVljYmdacWNBK3R3bjk5d25FMzQ1UEF3d0crZ3dt?=
 =?utf-8?B?SmlkM0t6RTZlempIZ29CYzMwbCs0MGs5WURyVmZIR1lRbklIV3ZtS25aVjBs?=
 =?utf-8?B?aXc2djFxQjNtTU0rVXFTb09pTmRMdkd1ZU80YVRacER1S0VpVHVxWDRIYkMr?=
 =?utf-8?B?Ukc3dDJZTlF6QWlLTHp2Nnhpb28wblRkVGhmU1p4cVpZdmpPSjRTU1d2bGJW?=
 =?utf-8?B?WmVDOEl0THRleFNvVkZDYm5yZDVkOWlvL3hVeXNHV2JnSlFvWUQ3TVQrdk9J?=
 =?utf-8?B?SktGYjBjS1pJb0J2Z3NiQ1VyeERsMTR4NDJ5YWdCRjFKK25mMDNsUHUvaTJl?=
 =?utf-8?B?cmduT0QvbXFIOHlmZjNXdUNxWFE3anIrdzY3a2ovK0NuRDBMN00xdkZINFFt?=
 =?utf-8?B?ZnpwYTRzcWdIMmR6YUxmcEFFZmt4UkJhdC93WXQ0VUVGTDVSTU54VlhoUHpL?=
 =?utf-8?B?RzdSYUlIQURkZ25VZWpQQW5rNGQxMUF4N0xnbGU2YXpkZW1ZVVJxaVUzdk1i?=
 =?utf-8?B?U0owaDN4MVNMc1BYc0EwOE9LMlhJL2V2QzA2bVNRR1lBbExaS1FiM0VxZlkx?=
 =?utf-8?B?M04rK3kxKzgrbTZNUWViTEdjYUJsTStsYkJFTG9mVGdLMDN0K1JWM1N4N3E0?=
 =?utf-8?B?TTZmTEZkeXY0NDhCWXIxMWRPS0hoazgzWHNVQnJQcm5BaEQyNVIyYzRCTUhE?=
 =?utf-8?Q?vK3OJezkGCgOu?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a058587b-6da2-4f56-9859-08df096dff32
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:46:55.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4278

The ACS Enhanced Capability introduces several new access controls to
improve device isolation. These new controls are particularly important
for device passthrough in virtualization scenarios.

For example, a DMA transaction from a device may target a guest physical
address that lies within the memory aperture of the switch's upstream
port, but not within any memory aperture or BAR space of a downstream
port. In such cases, the switch would generate an Unsupported Request (UR)
response to the device, which is undesirable. Enabling Unclaimed Request
Redirect Control ensures that these DMA requests are forwarded upstream
instead of being rejected.

The ACS DSP and USP Memory Target Access Control and ACS I/O Request
Blocking features similarly enhance device isolation. Device grouping in
Linux assumes that devices are properly isolated. Therefore, enable these
controls by default if PCI_ACS_ECAP is supported by the hardware. As with
other basic ACS access controls, these new controls can be configured via
the "config_acs=" boot parameter.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++----
 drivers/pci/pci.c                             | 34 +++++++++++++++++--
 include/uapi/linux/pci_regs.h                 | 13 +++++++
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a2563ff69f51..9019dac26b17 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5324,13 +5324,22 @@ Kernel parameters
 				flags.
 
 				ACS Flags is defined as follows:
-				  bit-0 : ACS Source Validation
-				  bit-1 : ACS Translation Blocking
-				  bit-2 : ACS P2P Request Redirect
-				  bit-3 : ACS P2P Completion Redirect
-				  bit-4 : ACS Upstream Forwarding
-				  bit-5 : ACS P2P Egress Control
-				  bit-6 : ACS Direct Translated P2P
+				  bit-0     : ACS Source Validation
+				  bit-1     : ACS Translation Blocking
+				  bit-2     : ACS P2P Request Redirect
+				  bit-3     : ACS P2P Completion Redirect
+				  bit-4     : ACS Upstream Forwarding
+				  bit-5     : ACS P2P Egress Control
+				  bit-6     : ACS Direct Translated P2P
+				  bit-7     : ACS I/O Request Blocking
+				  bit-9:8   : ACS DSP Memory Target Access Ctrl
+				      00    : Direct Request access enabled
+				      01    : Request blocking enabled
+				      10    : Request redirect enabled
+				      11    : Reserved
+				  bit-11:10 : ACS USP Memory Target Access Ctrl
+				              Same encoding as bit-9:8
+				  bit-12    : ACS Unclaimed Request Redirect Ctrl
 				Each bit can be marked as:
 				  '0' – force disabled
 				  '1' – force enabled
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6cffdbba99d3..50a3b61f9898 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -983,9 +983,12 @@ static const char *pci_dev_match_config_acs(struct pci_dev *dev, const char *p)
 static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
 {
 	u16 shift = 0, valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);
-	u16 invalid_bits, enabled_bits = 0, disabled_bits = 0;
+	u16 new_ctrl, invalid_bits, enabled_bits = 0, disabled_bits = 0;
 	const char *p, *seg;
 
+	if (dev->acs_capabilities & PCI_ACS_ECAP)
+		valid_ctrl |= GENMASK_U16(12, 7);
+
 	if (!config_acs_param || !valid_ctrl)
 		return;
 
@@ -1026,10 +1029,23 @@ static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
 		disabled_bits &= valid_ctrl;
 	}
 
+	/*
+	 * DMAC/UMAC are 2-bit fields where encoding 0b11 is reserved. The
+	 * final value can land on 0b11 not only when the user enables both
+	 * bits, but also when they enable one bit, e.g. "1x", while fw_ctrl
+	 * already has the other set (e.g. "01").
+	 */
+	new_ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
+	if (FIELD_GET(PCI_ACS_DMAC_MASK, new_ctrl) == PCI_ACS_MAC_RSVD ||
+	    FIELD_GET(PCI_ACS_UMAC_MASK, new_ctrl) == PCI_ACS_MAC_RSVD) {
+		pci_err(dev, "ACS DMAC/UMAC would be set to reserved value\n");
+		return;
+	}
+
 	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
 		enabled_bits, disabled_bits);
 
-	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
+	caps->ctrl = new_ctrl;
 }
 
 /**
@@ -1051,6 +1067,20 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	/* Upstream Forwarding */
 	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
+	/*
+	 * Enable Unclaimed Request Redirect Control, I/O Request Blocking,
+	 * and Downstream and Upstream Port Memory Target Access Redirect.
+	 */
+	if (dev->acs_capabilities & PCI_ACS_ECAP) {
+		caps->ctrl |= PCI_ACS_IB;
+		FIELD_MODIFY(PCI_ACS_DMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
+			caps->ctrl |= PCI_ACS_URRC;
+			FIELD_MODIFY(PCI_ACS_UMAC_MASK,
+				     &caps->ctrl, PCI_ACS_MAC_RR);
+		}
+	}
+
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..aeab8e5d54da 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1016,6 +1016,7 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
+#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability (CAP reg) */
 #define  PCI_ACS_SV		0x0001	/* Source Validation */
 #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
 #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
@@ -1023,10 +1024,22 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking (CTRL reg) */
+#define  PCI_ACS_DMAC_MASK	0x0300  /* DSP Memory Target Access Control */
+#define  PCI_ACS_UMAC_MASK	0x0C00  /* USP Memory Target Access Control */
+#define  PCI_ACS_URRC		0x1000	/* Unclaimed Request Redirect Ctrl */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
 
+/* Encodings for DSP and USP Memory Target Access Control */
+enum {
+	PCI_ACS_MAC_DA   = 0x0,		/* Direct request access */
+	PCI_ACS_MAC_RB   = 0x1,		/* Request blocking */
+	PCI_ACS_MAC_RR   = 0x2,		/* Request redirect */
+	PCI_ACS_MAC_RSVD = 0x3,		/* Reserved */
+};
+
 /* SATA capability */
 #define PCI_SATA_REGS		4	/* SATA REGs specifier */
 #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */
-- 
2.51.0

