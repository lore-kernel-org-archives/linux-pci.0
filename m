Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013074.outbound.protection.outlook.com [52.103.74.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AF3ACF14;
	Thu, 12 Mar 2026 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306433; cv=fail; b=MYGLtbpUeYWJ+CXWfU8YPicEQ+gcMeuzPMAn9c+DAGy6AHZ3dAGHm/T96jKVPPLd5qQeXqxPsXG5PKsfNzCT+GZ3Br5qYIVWbMFvhWCagyJ8nT6h3Wi9KlWVqzRhpzL4q2tVaSaPSbXDxTl2x6sVzP64CUmWN2cW17wJgAXGgfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306433; c=relaxed/simple;
	bh=KJPQTIuknzrxxDXkmHExfY9C9oDq3ffC7GBHCMFuqK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GCtxMo5pzuhzPqIunE4vjWfgKkNJ5Tt/CUmcR3EUNJiEtG/bzO9MWtrBZI28/oguNHPdUO0o8vrui3FZwBZL/PAaUaHO9ckZF4ViO51i7RjKqzsu1BnEAzzKcDCKxK/d6a+2YOLvlidNfPtLmg2EocgcgIlrSGUmUyyPYNKKkEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=n/uV/O6Z; arc=fail smtp.client-ip=52.103.74.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="n/uV/O6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNfhB/eONi95XgGk+6iFVeL2KYcyihxtXVFg7tIr7K2CwMcwTusaMC1xoIB5IAVdjc5Za6lTlAGLl2CqXs1miCdDMhSj0Vs2UANj9JvL6kF2qa760VKnYmif5XGoINZJNcbEMX4Fxuj1k9DNVZgjBpZy8HgdgGXQLKIhDb5KbkwSsNOyXLDAr7f5lBrKvS7I69c6zcL/qtTdGu+bgo9qFApGQkOsZxVhWBK2Yd+Eaukuifs6mHvjuO3bSn3HU8BZnXPVycNyeK0vQ4juNCwM932/vb/+AvYGod6U7dQCLz9fSpHguHtK1TkKf+8L1k6jiFvR00e/1lHgFtuuywNkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55BteN6Cng/et/O15sTZABPZHNi2ifW3JCvehxIqfy8=;
 b=h2sIDuLRY/apnOUN1RTxVtK55+hGkyCLdK2jzKp6xQ7264R7Vd6LctjgNsFjkO7/TcE8NCviH7EO9Ih7+J1HxLN9k3npQUQihdgfOxIRzX2CZfJoNEFcVb9bSyIOT1bPeAs7abGCCac/b0PNw8CpYC1NYtU9PdPxE7aX9yPYFjaGPBUun9GdozkQcScMp2mVUKtckhIKyCNou+n1VQ6A6I7OQP4LWZIV2PhqPPGlmgjn3lAKl7K7UW5ociCaCctDXArRLJdG/GNhumABx1PFwUfTYE9tuvhmc5tl2g8tyQbAeHbjPPUSScxFxXN75JO6n1R3DLnkN5rOCPuZ/kGDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55BteN6Cng/et/O15sTZABPZHNi2ifW3JCvehxIqfy8=;
 b=n/uV/O6Z1PROotHUEtF6e4XNtop2AYJnIsL267DeLO825uA7I6HHlRqIjq6bAfPpolO0GgZtJoWfC348hm64meaITVlfp2UYO/uY8dxsmiFrZWX3kSuLWxEtBsMT42GS8a6TlaFxjcy+miBvZtUgQXjZ0k7jNuQAfACgvRu0VlmZizYxvhaJfZe+7sVjzVPN1Pdl5LCSVwAfj39SasnCggcOLfyiJKn93Mvixrd/v++zS5dKi7bO6nnhnB7wSQIQFboDWbmlAJ5VSpXFH3smNJ7v8HG73tvG1yGLhwvaTKAYgoSKxAbeUvcF0SH00T0MMoU1/uhxkjg0NIC/ph1StA==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by KL1PR01MB4704.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:07:03 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:07:04 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v6 5/6] PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
Date: Thu, 12 Mar 2026 17:06:36 +0800
Message-ID:
 <SEZPR01MB4399C1508D17A3ED65127289DC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::15) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20260312090637.71548-6-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|KL1PR01MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: b5337f6e-c1f3-4879-0f2c-08de8016ba28
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|37011999003|5072599009|12121999013|51005399006|15080799012|19110799012|23021999003|8060799015|461199028|41001999006|37102599003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk0wYk11T2ZjZmRFZjZUYVNGQnpnZDRIa21zNEwrTkFoeTYreGZwdjQvaXdo?=
 =?utf-8?B?N0ZrcmhjQ0cvWWNGK2NFVzh2U09xNTZjcnIyQTFuS1pQaEU3K1psVExDU3FY?=
 =?utf-8?B?Y2VGQ0xNeG5WV28yNVdTbk4ra0l1NTBRcmZ2NC9XSzNjN2hab1JjeUtmVkwx?=
 =?utf-8?B?Y2xHNk5TaUp5MW9iSitjVlorek5LOUFyNWxzZkkwRkV1eDFIYW9adlVvd21Y?=
 =?utf-8?B?NVVUMGVxbFM2OWxIQVN6S3B0TEJ0MWZzY01RMkJYL2h4dWJ5S01oN2N5cHBD?=
 =?utf-8?B?RWR6TW12R3I2YXBvTnRjREp6ZUM2KzBMM2hrWS8zekpvc0tSZmZ1aEJrbEVG?=
 =?utf-8?B?RnJuc2hLVk91Si9tM3pLRUJLaUFLUGZvbFFtYk1vUVh6cGRwZ0x6TkZMbi9D?=
 =?utf-8?B?TVhhMWt3WUxPOGlJbWgwbHpFZmF4bzNtbGpOZ29RVExDWndUSU92Zjg1eHM1?=
 =?utf-8?B?aStFZi8yV0NKT2l6Nk5QZ2VGcmR0c2hReFJmYS9RVUZrMmhuQllrQ1drYVIz?=
 =?utf-8?B?QUs2aW9JNFY1dTRiM21OQytVamZ5T3MyTWdoWHRTMWdPTCtNbmhZU21FbjYv?=
 =?utf-8?B?V0dReXc2cjk0bldpM2NoaThTYndkU2NqQ1d6Z1NJdUxzMDNDQ3BGTWY1bFNI?=
 =?utf-8?B?QnFKU3RkMGdabVQwTnJUa0xVRGN3c2RCb0FQcnYvOFJ5b2pxSkRDNnBjZmNN?=
 =?utf-8?B?QWlwc2NscE1aZXZ0cVhQMVQ0ZWgzWmJZWjBTbys4cjk4Rk9teGFmenQyNy9I?=
 =?utf-8?B?Kys2WmZmc3NxYlFkZ0docTJVOGtaZm1uNkhORTArcXZwRU5UYUxYaDNuM29W?=
 =?utf-8?B?T25qcXcybEhuYlBHZ2VHVFFXR1kyS2haeXRMeUFjc1pQcDZjNzlhZzVYSnhB?=
 =?utf-8?B?b2EzZkRiTDBaMFJLZFZDb3lPZmR6UVd0R0srQzJoQlJYMjhYaC9ncVdHQW8r?=
 =?utf-8?B?bVk1RUxDKzdFY2tJdlJHWjZHTUxPWWNDanJ3RlZNcS84WGVBdWVKV0tBMU5k?=
 =?utf-8?B?bEljZTdwMGMxRS9BaTNsK0ZhVHQwTXpwV0ttWUczWlFROVloakdYRi9COTdv?=
 =?utf-8?B?ZDVYaEcxa3lZUGFUSWttTHdnY3NRaWtUZUJwTWdHbHhoTFFROUZRSTNYUll1?=
 =?utf-8?B?dC9hQURBZ2tJTGZTejAwN3VpUGkrQktwbGc2OE1mRHp3cW15K0JFVzZub3A2?=
 =?utf-8?B?dklCWDZaWVpkNnBzc2N5WjRYcmpRcjZpTHl3VGUrOWpIdi9CTzdnVXVLbGhB?=
 =?utf-8?B?T2N1MUpZdnFtV0tZWXJORm9NUGJ2SU9KcG5GaHBrK01nZ05EVmpuVTdIeGxR?=
 =?utf-8?B?ZzNYdERRNnVWMkxqeEVJamcvWnFiQmNvUEVxS0U0cmkvRWtVTWtRTTFkQXhq?=
 =?utf-8?B?cjB4MU5KSHVkYm1paEtIZWg4S2dQZ1E5K0pISzJMSXdNRURiOVlYWVkzK1hO?=
 =?utf-8?B?Qm5xR2VNMlBqYnpxZVVzVU5KTWRGNi8rSHYyQ3RRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmErb3l1UWF6bitpeFo1cXpkNVRscjBXRjdsZUhYNzgwVzlUQnNEbnFNdU9u?=
 =?utf-8?B?VVl3NkVoWTVsaDFhY0FWNk02YW40alNpK2VqeDQxQjcvdUYzWEQ5dWQ1c090?=
 =?utf-8?B?ODRVd1ZENFhuSk4wa1E2OTVkT0pNaW9TamhXTEpENGRJK1lsUmpWSFhUNHFm?=
 =?utf-8?B?TitiRlBieHhGbXRib252TUdOOVBOaTJXS0dPT1BUc2pRbjRYdEs1VE15bVBs?=
 =?utf-8?B?Qy81Ujl6OTZtbTIxVnNJdktyZStMRCtZSTl6SXlKWmZYYk9JWURvY3JwbzNG?=
 =?utf-8?B?Vm1tQmpYcTFJbnJ1bndYMzBrbm03OTh1RVZrNG4vV2UrT3ZpR05HbHp6NDVi?=
 =?utf-8?B?N2FyWG15d25DMWZBbktGRU9NZXpGRVJjOGFReExHZ3JUcHZ1RTV6MFdaQ09x?=
 =?utf-8?B?VzZKZ1hha2t0clczakRIbnplQWdTaklOQmJrVGt2V0JpckRYanVoY0QwYmFJ?=
 =?utf-8?B?azF3NmpKWVVjTFlmQ3AydWljbmFVbEVwaEljdE4xRm1xVW4wSWozWDM5Z1F3?=
 =?utf-8?B?bHpFV3ZLTzFjN0Z2SlVhS3hrNCt2Vkl3RTY5WXpOV3h5Q0VYbmhxc295UDZn?=
 =?utf-8?B?b2swNENycmVyZTNrcWcrdVhxMXFxN1h4bGI5Qm5YODA5WmFzL2NXSjFoTHVH?=
 =?utf-8?B?ZnNCQWJhdFgvRUlLSWhjdkFyc1JSVUFBSllGU3RaL3hndE5HRktTQXhhY0V6?=
 =?utf-8?B?T3FSZW5KaWxWakFHdk16NkQxTmpSQkVsdkdHTDlEdHBJMkZ1MVJMT1NhOGZG?=
 =?utf-8?B?SFdrbTd5d0tVbWYyZkNRRUpTMXJIbkIyK3FiRWdUMjNNdTgzbTFra1IzMVdF?=
 =?utf-8?B?UzJaWkxKYUhLL1FhUndlQ1ZSSjc0RkpnQ2QrOFczaER3YU0rSmtnUWtFS1hO?=
 =?utf-8?B?UlRsbDhQRENBbzJKNW1oQ1BEaS9DRUszbzg3aVVPejViN05veHZWaitMRjJw?=
 =?utf-8?B?OFk0SHp3ZXZNakFYMDZkR0pFR1R5M3JzNDdsU2tJRXdOMVdWMHZ0TFZBWGVl?=
 =?utf-8?B?dFI2NnV1OFZ0ZDh2Y3E5Z0NPVERTNlZvNCsrbmtNeHlEeTd5TStKNm55MHA0?=
 =?utf-8?B?Y0JYekFKdE9acEVsVFgvM2xJWlJWQ1Mra1RaZkFHNTF0d2IwaWNWNTArbHI4?=
 =?utf-8?B?dFAxTnlVVG5SY3BoL1V0ZkhVY2lhL2NhY3BNOWJrdE42cURETzA2L1BuTnRO?=
 =?utf-8?B?QnNkYWxYUUFMSU00OWlyb1F0UjdHYnRXa3pQcHBadHVXUHhLMzlHbVhCdU1q?=
 =?utf-8?B?MEpzSzVnRXF0TFNXemZEUVBQN0YzWmcxOEtybHZjbUxpNFBrajlJa2tVWkNK?=
 =?utf-8?B?a1NjeE10YmcwcU02RFVwdGVGQ21qbXk1a0dKak43RDZsa1YrVEZhbGVBeWxP?=
 =?utf-8?B?bTNablpwYklEQmY3U0U1VmthL2o2MFd5RzFteUFGYVdkTXdPMHdiUEd5WGhY?=
 =?utf-8?B?Ny93aGhRdWk3QlNnc1RzdGZZc1N0dlpBMnVvRDFsQlh3M0F5Z0VDWWErVVBo?=
 =?utf-8?B?SktMaExBVk5tQ3VZdE9YWndOYllaWEE1NzlWYlg0eFdnb2luM00xSFh5QmRB?=
 =?utf-8?B?bjFGOU9MUlVqc2lOcnNYeVlHVjlhTk1IYTZUSEtOcW5XM0J1Y2QwK2VCRXF1?=
 =?utf-8?B?UldJbFNFTHdyQzZ4ZWpYZzNBQ0pUVHFSTkFVd0lLZ0dSWjdhOUFqOThlS2ww?=
 =?utf-8?B?K1dYM3FNSE91cTVSeTAzajZ1ZVFWYUVmYmFLTmZ1aUFpR0syY0hPTHVYRkhi?=
 =?utf-8?B?Z0VMSVFtNDlueUNNSGdzSkVjUHZOdFdFWElEOU00QUIwNWJjVGJmV0JPbjdD?=
 =?utf-8?B?SHhQbnhyVnZrZ1JzVmNOKzBuVU1SeFZObUZ6QTBrWjJIM2F3WTVxcy9PR3ZV?=
 =?utf-8?Q?z4gjFPQH7SVp0?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b5337f6e-c1f3-4879-0f2c-08de8016ba28
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:07:04.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4704

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
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
 drivers/pci/pci.c                             | 10 ++++++++
 include/uapi/linux/pci_regs.h                 | 13 +++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fe24e5cf4cd0..2da8b8e2ace1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5308,13 +5308,22 @@ Kernel parameters
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
index 66842df07589..2b36dc792d10 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1042,6 +1042,16 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	/* Upstream Forwarding */
 	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
+	/*
+	 * Redirect Unclaimed Request Redirect Control, I/O Request Blocking,
+	 * and Downstream and Upstream Port Memory Target Access Redirect.
+	 */
+	if (dev->acs_capabilities & PCI_ACS_ECAP) {
+		caps->ctrl |= PCI_ACS_URRC | PCI_ACS_IB;
+		FIELD_MODIFY(PCI_ACS_DMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
+		FIELD_MODIFY(PCI_ACS_UMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
+	}
+
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..b8e188eb06db 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1016,6 +1016,7 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
+#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability */
 #define  PCI_ACS_SV		0x0001	/* Source Validation */
 #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
 #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
@@ -1023,10 +1024,22 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking */
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

