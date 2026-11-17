Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794954937;
	b=P+Mvzz8Bd5A6mLGbLXNq8cmBUiXo5kLkvFPQNwkTgEjcA9KWjXNhXQr905F6euW8NaRv
	 5lEuXx4dKydqQh0IFMeQmtBZqYelgzMj5RvcpvTV7bFk7pPOREa+wfXPT+Kbu8Qj9/F3q
	 tagcdh8X/fqY7VOi+raIkVNlvPTDFVJ/U8coEZvgoCrw1dUWFHYilw9u/vIQWBdnE8LHJ
	 uUaTbAG+UhTuG6bw1VgRrFf4BR7hoZQDWtOFn4jBzK910WvYvT45SkBsPvslbjLgTn53U
	 AQU4GaiyS2mC/3eV9OD3p6rg0MtZUzb+a1XwRdJS2UGV3mWVIOF51vJFtXSgpBXV/Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954937;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=P3ca063rfo3r+Fj99IYeeSU9YDI5e/0MEb8JjIA/hIw=;
	b=yjdAdv6B8HHcJ9rhVMron+jDqetoszCwfb+HXTjMShMlRmlwJwLx5S38IK6axOglpd+h
	 aoh5nCX0rwFiZS5xWoKpku6mXyQyYMk/3a/981ttxdEf8jakU4V+uGSoD6YwalhjGLdY5
	 AWbzY4D6A2MtCVtypcdeKViQ6FjO5CjlqtWTexRXOMr5UpM7E0BVJQTOWERDMoMwjD8Wd
	 Px8C1009F4d0bE5VoDAu61pGoy+hayZAuT7fzsBp9sNa++QGjsTK0bEQuEZ3S25Oo2cPN
	 hxDnFUd++fLNmJ++nkfxbxE7bs32FmU52OEiTaq61dcti9JGnNyeSScryyQo1+v9YTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rPpOJtZl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.2
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2B606A31C;
	Tue, 17 Nov 2026 22:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rPpOJtZl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdvF0+qox/HSadE9HYPZ8e9Aju585VxhtNHu3uU+/CJM2BOTU/Qhkvohev5cJneZ4NZMnjgjc4p/kwjb4yHSrKsepgEvmZHn2dv/o30nfXkA/dB+py8mW4ZB8SOYgDNt6vdMpzWQR85rcYu+n5JZ7Y5qgGt2l0vTtyrAC0uCBPTDK2LSDb3zGVHKTEfRoUn29upcoSrt53rmE18ivJrI6+MTPAnBMMgXwOs6Yu88g9L3G4Pxt0UYZA9fxe5IE3jfv+pgGJWnPm7tbCHQBdv7SAgTYajfdt2VIIFWzw5nv2Mpyy1DJOvJIWFA3i4Me3/IUc1GU3cT5OsVIKuLoIapYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3ca063rfo3r+Fj99IYeeSU9YDI5e/0MEb8JjIA/hIw=;
 b=xT3yoeVx53RWeriDgySnLbLWDbGnp5EhOIwlztq5el/eNFZQmccSN7xI4EUFvfOBkgK5oeTFjc7TeKH4nTrnlV2rEAq4Yl0fglEBghVuaiFxeXObX7FNF98Ocg2kfFEBP3Fu/aId/Tapmo86F/dN5HiW0GkmBUdR8BMBRMxXQPBEisy6bn+WhF16p8GwFVPDom8T/udnGnfrLw3E5CAdgWfBi2aV9oti10l46HUrl3dq0GfOl+8fhzOmiPi64ZHnuL+XStpDQP67SFr1IBasqz5nZejS2L4C1IAbtyALhyhkBkZ09USH/Q2Lr2GjX+a442BTo9y9lEcQd7u1TUYZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ca063rfo3r+Fj99IYeeSU9YDI5e/0MEb8JjIA/hIw=;
 b=rPpOJtZlcyTUVQRtwI8elfHr2HOej9U+JHjJQBlPjSIKzkcsrlkvwLc0Xqkyys+YLo+n30Ga+51aB3vPIeyydaO9X5SMESzTBG0jFfBJmYyC8IlCPFuGzgaKzIvkFH/m1R1aGRrFDbRwfT7aUZ9z/AvuxlWUeyF3VXLztwJC38k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by IA4PR12MB206861.namprd12.prod.outlook.com
 (2603:10b6:207:140::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 22:35:35 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:35:35 +0000
Message-ID: <ab937eeb-e83e-4872-a323-3cac3c364955@amd.com>
Date: Tue, 17 Nov 2026 16:35:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/25] dmaengine: sdxi: Add unit tests for descriptor
 ring reservations
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org,
 Frank.Li@kernel.org
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-14-3668ccc7aab8@amd.com>
 <sashiko-outbox-196564@kernel.org>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <sashiko-outbox-196564@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:806:d3::16) To CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|IA4PR12MB206861:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e43a22-3f9e-4318-661f-08df44fb18a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|261022105027099003|261028144727099003|261026140227099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	jHcW1H+YidYqBZemPBSuxjDo0zLyb4JHOpYfWKHu8+KGrlWSYPLvrWABXOrlg0KQfC/BT+ZIjNQyDypswRO2WDStbIxcUreSi5OcDE6Wn5xNSDRb9vYKfhOGq+3g3UIRs/8STdIQ7QIzRwxUtDApR3SndIGFCa+Wf6WqDhIhOu4nsgmSnw20jHRC+YJ6aeGX8ct/an6yb9TvTdADSKmT+Z+wY9F8EnMYT9iK0kTY8T4H071lLQ73OQg5Fibw3qSobjdFAKovjEH1uTuByKXh+arSB0SbjrKc+rHu8aWOEXKOLCTDed3NlVMnqnVPv3wOvirX/dXeLawziHTITWEe1Nlgi8HII1GB4dlUbZC/bcwEpVykIXuT3UnD7O1Z0tlSsnQnUg0Vg9WNyT29ZMns5vM25ZIFGD2gSe4Vnhly9/Htid7NcoZuG3q8MQVMJrqlF+WuLw/MEW9PVJ7yw77ktMtu47e64L4zT3vFH23mKYBtTQERP4vZFFXkAuhsm4GQjrk4JecVFHoh0Ej+XIQO/no0JKc7IINXFJABuVSr9/Qd8HFOrQ97GXajoaoGZUAD7Q10LufCmUiUg2XML8hulBS6Jeoxy9bcSqOQYlronVqN/h5o1kXMZ3qpEnC+EHBRBJ3WQbwNsK+/JewzlpItW7CkkhB7yODhmTgEoJA7EtU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261022105027099003)(261028144727099003)(261026140227099003)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2RHUkVKbTVTOUJVYjE0UHB0cU5vM2hNcm9rOGlPTGh4VjJDMnJqYzhBR2Y3?=
 =?utf-8?B?VUF4V0RYdnEzaWx2S3c5bU9zalZDbU9iQVNIRUhURTdFZnhPVUlWTVRNQ1VK?=
 =?utf-8?B?RGEwQVExZVlDaHJBdVFGNWZWYTMxcytvS0h5RlU3aEN4MUdlc0M2SUVMZEdZ?=
 =?utf-8?B?MzVNeWN1VFJkclFhdm5lbmtkQ0RNMisySTlLYlpDN1VGZWswbzM4b1h5MTFr?=
 =?utf-8?B?MUlUcmdSSWkrdzU1aUg5aTRzcklQWnVOY1VqNTFuenVSVm1EVjF6dWFrUkxo?=
 =?utf-8?B?bE9sSXJpRlRxMFVkcjRNc21OZjVqREpnM1Q2VFEvWWc2ZitUcnNwQ0JZdHZh?=
 =?utf-8?B?TlVraW1ENU83T0NVZkRUY2FGOUYyNkxKUU4wd0xoM3Vmdm03TUExQnRzMDhW?=
 =?utf-8?B?bnR1WDZVVWVuL3hZa2JMcWl1UTBtUXdWK2tJdGlyZXl6aU51cHBhczVPTmFT?=
 =?utf-8?B?dnRydWx2TGpXMlpldDlCbnIxeFZjTDFRbm1UREx4aUY0Uk5ENnZVMjRPWU9t?=
 =?utf-8?B?a082R1M1TkdoUnhWNzVlUmR3Y2wzMVB2akNYaHQyUmdsaFl3akIzczV5SUpK?=
 =?utf-8?B?K2F2ZEEwTmtDMi9HRVF3UkRURTRCb3BGdXMvTmthcGQ2U0VzNE9oZTFESGJW?=
 =?utf-8?B?ZE5PRHlaUVhiWC9kbGNFSTF4ZXFIQ1ZTUUlGMFBQSXUvTDhkMDYxaFQzWHVi?=
 =?utf-8?B?dWR2WFRCY1hKSUdHKytHMmRCOUtTYXE5OUVsa2RxK3Y1ais3RFlFZXV0L3pY?=
 =?utf-8?B?bXpmbktGdmZ4ZG5FM2RrMW13SGk3VUozYm85eCtMcVljdDBscGtJSEQzZm9t?=
 =?utf-8?B?ZmRYU0NJU1F5b04ycGp0Qmc5THJDOGZkWG8zaGxBT2IrdEx4dks3K0xlRkt2?=
 =?utf-8?B?dDVsS1BJYjNhYmFzVFRIMFI1bjY1UHF0UmN6NjBvSTdCRW95Y2FoeTRqY1Uw?=
 =?utf-8?B?bmREMjYyMXhBNjB2OUlWZEdMeVNSbjRGbTcyZitJYzI4NXpEU0xGOVE3L05r?=
 =?utf-8?B?REl5NUZvMHhkcklNNmJqSXRlRDFadW1oV3J1aWtKb2I3SjBBN3JrT3hURW1J?=
 =?utf-8?B?WXlOL2xMUUFaQzh2SG5vU0VIZGtvTmF5b05hSkdPS3FoZzhaZHVFbFE1NHVQ?=
 =?utf-8?B?L1RlNHJ6VGpQSDRteWZrZ01DcWo1ZGIyWTQvODV3SEgwdW95UHJWampTaDJp?=
 =?utf-8?B?aXVUTXVodjAxK1F3Rit6ckgwRUZvK1c4dFIwM08xVWU5dVJ5MkNUNmtIOWIr?=
 =?utf-8?B?ck9wSTBiakNiby9tSWh0QzdGa1d5OGZ3bmh0VWFvQUNqV21NVGtFRFVEaHJn?=
 =?utf-8?B?ZXZ0Ny9ERmRCMi9UQ2lYYVpqaEw0WEFJOTRGcnJlbHdyREFLMk94b1UzWXhS?=
 =?utf-8?B?cGdPMFhIT1pSaW1zblBtZmhzUFYzeitwY0o4WFBOZWRjaXlObi8vU2NFdFd5?=
 =?utf-8?B?cXR4VG1iZFh6QWQvZXB6SHMvSHllZkZLMHMydEJaUG9lNi9zVXhZaGozdVNL?=
 =?utf-8?B?MGFyRmRGQUoxaVBnUHNFSkUxOTA4U201dXpVb2Rhak5xLzMzdXd6UGFHODl2?=
 =?utf-8?B?ZUFjZEVIYTRaZ3ozZTZReTQ4VjFpRkVUanAxKzV3c1JBeVZ1TldCTWs0YTRi?=
 =?utf-8?B?ZWpVcXVxMWdpUUVDaWZJdDMycGxOUlJScG1pTC8wdEFyVGd2R3RiQTRlZ2J6?=
 =?utf-8?B?Q2NOR0VMakRNSEU4L0FPRnNvUDUwYnVHUUU2YkcrZjA5WndRdWtBUVFyN1Nu?=
 =?utf-8?B?QzQyQTMyWkVlNE04NndIMjl5T016M0JWSy9VSysxL3orbm5OTDkwaytOd0NZ?=
 =?utf-8?B?bjk4U3pjTGV5bUMyTlZUM2V0K2Y1UjMvM2JFK3RuL0QvWloxWDl5T3RUUVBj?=
 =?utf-8?B?OVl0dkk5SVI3aWV1UFRNQy9QQXZYTDRSR1BHRGRPWVo2QTE3Z0RjMng4em54?=
 =?utf-8?B?VGhpdXlrb295TGJLZkFRWUxHN1UwbUxpVEVwQlBjdW8vdjhjRjZJY0ZqWm80?=
 =?utf-8?B?ZlZ0SVBsM0xFZEhzVG0zRTBFdzRVSU9lTzkvY3BaV0pKVjVmYy9NSzFkMlI5?=
 =?utf-8?B?NHd6THovRlNyc2lpOEZEVEtpUzJSY3R2NTUzTFhLTjd5bjlZQkU5dnY5Q1NG?=
 =?utf-8?B?TnczcnNMajVOeENFNUk4dFdwM3RxR1Y3ZnlCNWVWK3czYi9WWGxZUDZhUm9X?=
 =?utf-8?B?RnlUcER1dTRnOG42TTJIUjliWWgzY1ZGWXRRTnJocExDMWJlNXdENER4Y2Jn?=
 =?utf-8?B?M3Nwb0Z4ZkszZDBDL0RGTzRzczZzL1JoSHhJS3Byc1VFZisweEZudm1PVjN2?=
 =?utf-8?Q?0qvotA7zKoyKx1WLV0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e43a22-3f9e-4318-661f-08df44fb18a6
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:35:35.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFaNuL87pbueAGzmeIvo/D/BsphnTe06yrIzd4WpjfRt9GfXT84y8SJ9p98HKLW1IC4TYlmUeE1T9vLnoGzCYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB206861

On 11/3/2026 9:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dmaengine: sdxi: unused mock KUnit device in setup_device()

Valid, will fix.

