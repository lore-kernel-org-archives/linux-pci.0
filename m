Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013080.outbound.protection.outlook.com [52.103.74.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19A481255;
	Thu,  3 Sep 2026 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439631; cv=fail; b=cSFmF2H/f4gGr/B+mRy/tKxQsM4JbK0GtoUY1nVbyZAebPaN9qQu2iKogZ+PHierXuObcuqO8uVIltHaUPijGIjDOntVJXjbj2pyJw0nm/jlaQOTUYNzWV8KzRJf8H5UNziJxSse2wIYgNdnngRPnkH1hI75uLPYAaAiRIJrT44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439631; c=relaxed/simple;
	bh=K8K4bj+qcbMQ7yOIvocpHsYHXps7ut6nSEX68bgKt+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bRl+b7/HSNNuR2Jpd91yDd7MW271KJvPQqCMILaomJ+ISB/hl7JApnENzQjDNkLkuA46/1ZwjCptoXW+/DZAmhH9ZFb+yheJ5bZ5fxoHOJoAy6s0MK1BgSnpTRCsRRofh3gmsHlQB+Bciwv+FKMF46DKosbTAaBUAhcnRPnyGOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=frpbRYlZ; arc=fail smtp.client-ip=52.103.74.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="frpbRYlZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyG+TIU/767Vz2sVUbZLEv6+RWcNrEbQVqoW/rCWmUgrSjtIt3UIS1SrlBwfrK6cvZTDojEM7t2002kkRX5uFn843aCxjtI3b2wvkifwlOT7pjsYu8ZsSnLsaDtWVG5uq31D37RxRVu4fj2Az6WbjvX0hOSh7N7/+EqQkvFGqRA3I0iYjGrVmuWnb8GqrGoZhT/axtdcy7R3hR+vOO62d03e+iqxYNxc3zqoptXYn4NUoKmu5XViVxDBlqM/yzvfs/3l1cOFAWw9v239XEfNrZHfmH2FWVlnEEUx5K4KgvTbqkpztuH1k4FYH8BR9D+SaMBINYK7wDqcpd37NXRcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agvJ8Z2r6S2iTrGv3xWNNtuqPZkkRxNrY/R6ayJ12vU=;
 b=eGG/Ds9Y6EX/4YuKrQ2xpgBZ7gnq6LZDlpCr7vMP787miUKYPPbfQhqC/g2dCLM1eWOaK8mJvlvjUKvqeur7fm/5kjzKCjAUiPvRkrDeWGap+EngVJOJQqswqWPn9ZP7QZhVYhu2UuSqBuXd7gR0ChW/KPtD3cvzOt9j65535hfoihm11G39UrdCFVD7W7zUbrcrjGeXiBJwc14POyBQm6y1UCIyRW9qCNcfJXrIwjCOotjNWaR2SdXMLjqnHc39Zfmyn9J9ZS1W2LnfB1felMm2ejNogmA/9aDNzVP3XUTovA3VOq9RA8zBA2+PC3gy4Ub7k2bYz/CngBRjmfhfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agvJ8Z2r6S2iTrGv3xWNNtuqPZkkRxNrY/R6ayJ12vU=;
 b=frpbRYlZKIKt4cQqe9CIvMy9QguDDm3vBjLaW4R3kUtxAdhszj0buItsxhoueGmi+QamGXgmNPfQ5l9rr/5kQdRm5vG4r1Qusv6nBADQyzu7JU+Ez+2t4Xfnbfm6uqS/UiYD7lzgN3pGuampNOHh0B4Y/IuPj1EO8Ct0E8r+lAkEu+c2dMIJdeu6J5gAk/7RyFexwl3/nN8lhLSQ7Y/qMhpZOApinNpI9qoPqkmqz5IpFirSzsXCICUkJF7en/eNog7/yAWRwub2D5IVEjnMr5xzqtY41V+OfLKCYM6IklsSthGaYJqDMyamEG4ywkLMK3TKEr8BAO8C4XfnAA9RSw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB4535.apcprd01.prod.exchangelabs.com
 (2603:1096:101:86::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:47:03 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:47:03 +0000
Message-ID:
 <SI2PR01MB43933D84E2DDE0C3F4998D1BDCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Thu, 3 Sep 2026 20:46:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, jgg@nvidia.com, jic23@kernel.org, error27@gmail.com,
 kwilczynski@kernel.org, rdunlap@infradead.org, akpm@linux-foundation.org,
 bp@alien8.de, alex@shazbot.org, kevin.tian@intel.com,
 manivannan.sadhasivam@oss.qualcomm.com, LKML <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439314CABFD64FC0586F2FF8DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <59e3d834-2628-7ef3-b07a-33ce6e7dd482@linux.intel.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <59e3d834-2628-7ef3-b07a-33ce6e7dd482@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0136.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::11) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <f4de3918-da09-421a-8056-f8748911e774@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5506e5b2-5e10-4681-2026-08df09b9734f
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRlUMF+bqfOb2T6ZrVSLVUtXU22rJYTx9HROdoTlmBWu+HPABRNccT7TZ4JaOuSekzJcNuwQnEahEzo5wt3Ehrf77nbrg+aMFHncb0XJgu9V4Wqq995Q2nujOHctN6Ub3LZ9mtunY3TaTyfBrJVzr7HQxbdYwS22bOb0y62Qbz2K2hchgoWvY1RXorX/djoeEXUCQQIWc6paHOBhjZaz46duWLQ2LyPlc9mUFemctZRvkovK9EyGw2DsVWKtZUfpmEncKt9HIbnLX54qmVjUdDuKyjacwQb7hQLI8Pv4oJCaes2GXFW/jxdcf3eK6Ey+T4aoqstR0Nqa0xFWfH8cxU9exnQaOuO51a3abczcIWB1i8wnOx+d8uGqUt9VP85YviLQDhn7dhd7fBa6yORkzW3HIjFTXZgBVxntKTcA1D68ThU+Y9qC84+IU33CUgMGwDaCfH8P6oGMU7yR+JgRuZkPgEg+degBmQbo9qHo8g4M4HbNbOf64irQ5S36HdCVJSPMUErxQULrHO38fkuzypAceoX43iHU2tHqSjINhVuxyH2g1SFSz4NEUstnBouDoprShuEqAanm+QuyxlbZzB6XcPYIhyb5/wUsHVbED4kvvk0QlPs8TtIyNiUjq1F/xQuisZxuwOc5MHbE0G/98pigKvUWZsehiPpYICvtNhsEL4ZZVqveG9oUjtS3XjgRaDu3ArtUAetzEapGs1C83PigSQXvRkDmvBBfIFTukUtLU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|45011099003|2604032031799003|51005399006|15080799012|5072599009|6090799003|12121999013|41001999006|19110799012|8060799015|23021999003|37011999003|25010399006|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0tBc0NadjdKako5Ui9kWVhMUXNaVENzdHlZYVMrVFNiMG9odUtHZzhBUlgr?=
 =?utf-8?B?MFkxSlJyTHBscmV1b1laN2Q5OEdHTFFwak1KbU5HeklJczFIMm9BL2dLRHJF?=
 =?utf-8?B?RDRISHBsUUJBcHM2bSt3L2pOOEdMYTZKT2FRYjZ3dWxyMm1TV2VENFZ5VnJo?=
 =?utf-8?B?V0ZocFlrR2FycVNhT1Fhdkdhcjh2ZlF1Mzc0OXBTZEVYcWFtRDREbGNIOHo1?=
 =?utf-8?B?ZGF4aHluTkNzSzFxV2lISnhnTWpyOFpaVlhTbUhxSDliVDFDbVhJVlpua0pu?=
 =?utf-8?B?V210TTZqQjJsM2dSUmh6Q3o1RHVNdGo4L0NtaHpUTkM4Q3d4K1QyUWVGNk9t?=
 =?utf-8?B?cXExK0RZOFVFbjUweERrSzBLSk1tSDVnTGZrcCsxaFNMb1FwNkxVYlpzeUcy?=
 =?utf-8?B?NU56NXRxejFUM241OVNxZVU5SjdZalQrZTF5WlEvSnNqZ1RrSjRQUGVPdzdY?=
 =?utf-8?B?Z1p1QUQzLy9qTnJsWEZtNXhVOTRHdXJrRXYzeTl4aFRyaFhna1BTMjhhUVIr?=
 =?utf-8?B?eVB3RlBnSFB6MDdGYUpKSnJ4NXFuRGZBS0lOKzBldjZkQ3FjZ3V2MWdzY2t1?=
 =?utf-8?B?VGY3TGRDUTVPWHc2TnkyNGRjRWsxK0xXZVR1VStBME41NzRHbmlQRjMvcTN1?=
 =?utf-8?B?RUdZajM0MUg0c3d1ZVR1TW9IRGtDM250MXRjeE9HY3Q1SjRYUlF4UHpLbFRB?=
 =?utf-8?B?ajJsL1BNTEhBNnFBc05oZ2kxK0pnN1pGcThhQnRhZ3VlZXluMi9pWkpHbUpn?=
 =?utf-8?B?a3R1QlQzWVpiTDRHdVdwbHU1SGorZjlPUGZBQ01OeHEycGVGQ1N3OTZ5NGp3?=
 =?utf-8?B?eHk0a0RlVEVWZU43cjhwTjhTYWo4SzFIT0l4YlY4SEo3VmFGMm5jQWxVc2Jv?=
 =?utf-8?B?dVlRaXF5Y2M5TjFMNVZwWWp1bzhEZTZUQ3B0ZHRZWGxOMUZrUTUxWWZSZHRB?=
 =?utf-8?B?cDl4ZjVBNHVJSHJETW9XcTRoNEVWcDhZSmlVWjdUSVJHK3I3TVBTSnY5Wlh4?=
 =?utf-8?B?OWJsV21HNFdGUVhaemFDWE5Zekx5bmdEb3o1VDh4M3RXVmF6Nk13UVpVRjds?=
 =?utf-8?B?cFEvUWJnclNySkhxQU9nMytnaW1TOWFzendkOHd5dHZMNkxwek5xVlhkdWp6?=
 =?utf-8?B?UUJ0cEgzbGVMdytxVEEyQ1ZHS3pXbVJyTUNldGN6eVE1b2Ntc1RuNHhjamF1?=
 =?utf-8?B?OU10clp2VE9yRndUN0xLczVNOWowUFFwRUNLTkgzMDZTSngrZHlpUGdGSEQz?=
 =?utf-8?B?bXExVW1UbWMxcERTYkNTZ1JjWnFxTDIvZi9mV3ZwYkMrSmxKNTBkcXdRWUNG?=
 =?utf-8?B?SCsxSmJHczVuWVFsaUFrZUJNendqejV3TG8xK3hYRGJPMzVSNkIxR3VkbkJS?=
 =?utf-8?B?bHNMWXZ0Nmd5a3hwK003WDlJK1Z3UkZOOXlSVUc0bVVwVmdkZ1kvQWd0VGpo?=
 =?utf-8?B?MlJhalhlUlYxbUF6eUw2SlZRcVN5RXdhYXRGRDYvN3lGakVzUHZVNVJtbHZF?=
 =?utf-8?Q?ZMGzPI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVVYcU9yL2NuQnhTQzRuSXVhcnJtT1VIWlg3clFFZlBCbEYwZEhPVUw2QjA5?=
 =?utf-8?B?TTN2c1dvRWpxQ3pISDFCdzMzOVVKcFpsdWZ0RlZJMVJycFFpb29JcEEzcW15?=
 =?utf-8?B?TkRDSUlHMmxnczFuSFdyR1k1NzQrUGJNaDJmem9zOTNUREtYTUhQazFlK0pm?=
 =?utf-8?B?Z2puK3BEYkI5a3l3ekg1bFlYSm1EVnpKWnRmRjQ0TWhhNlh0ZFpudmQ1US9p?=
 =?utf-8?B?S0NJVTU3a2IyczYvRGdxTlQxT3AreHd3ZXdpc0N2dC90S1RTbmVWTG94TUlZ?=
 =?utf-8?B?TXJoSHpEYTVDbmJBTEFnb2ZrUGkxNDVjVG5BS2NuRUhFQytmRjd3TVRqYkU4?=
 =?utf-8?B?RlFHd3hrbGxabC9vbGF2NHBLL2lHZkxzMXBlb3NVd3lWcFhxSi95RVpGejhk?=
 =?utf-8?B?YWZwTDBoYlpJdGdmdXdFdk9TWTQ0WklqSzBSbnNFOGJnZm9OR0h6VGIxczNq?=
 =?utf-8?B?dVU0TWZRdzNIZ25LOWl3ejhUOFJWS2Z1VjJsRnVqMHNpQURKdUdRNWQ1NVdy?=
 =?utf-8?B?YkRCY29Rc3NsSnZxS1FOTTlrKzBQRVc5MzVtT2wyQ21WSUM5N0FRdUR6K2tL?=
 =?utf-8?B?Sy9HMktsdVh4eThmZDRKQ3M4ZE1XUjNxNi9qZ3lxbkxPdEJFZFI5bjVuTTky?=
 =?utf-8?B?Z3BIellIb0wvQTF0QmdkeCtjSTA4dU13UE5mQ09UUXVFVG84dTdCTGZNaU9j?=
 =?utf-8?B?TGFSZHdKSkU1bkY0VmRvbzFhMFNUckRRSnQ2K2p6dmdzdDZzcWZTTEJNS3Vh?=
 =?utf-8?B?cUpha3hrL0xIdGRSdGRDaXVqYlVOQ0d0M2d2VktPQlF6alBTalZxd09JZzF0?=
 =?utf-8?B?WWJnaCtic0wwN1FObElJcmNTWDRVZUdNRlgzZ2lGSTIweTFlbS9hNGt6Mkd2?=
 =?utf-8?B?NDVNVzRCWnRlclgzOHB5UnorRnZwUFNXbnl4SzlrdTJ2aUVlV2lGS1Ayblh3?=
 =?utf-8?B?MGo5M3ZhWHVYK09RRWxFZUZLTTUrbnREZ045UE9NeTV2OGtNb2pLRmUxVmNh?=
 =?utf-8?B?MG03N2pxTmhvL0N4bHE0STBlLzk3YmNTd1ltam52K24vNDUwdmpZKy81aTNw?=
 =?utf-8?B?UC82R3RTQTZ6czYxYUlyUFpyVS8yK2VBTFVNbzV2OXB5TG1kWHJ6V0tkVWZL?=
 =?utf-8?B?TU9zZ2VlcmdnUWR6VklBamphUm9FRk5yTFI2WW5nVmZLQW83bm5hL3ZmdWJz?=
 =?utf-8?B?TllmaWdrTWJZbXBhMEsvUmw4dUhGK0NhUWxRZy9jUHBJQ3dteVllTkhvcHg2?=
 =?utf-8?B?dTFMNTVCZks5ZlRvUW1Na2tteUQxNHJOVlRFMjZyOTJYMVZqcnVXQ1JEYmd2?=
 =?utf-8?B?OEQ5SVBtcC9zSnlNdWhEM3NTNHZXajlsU3ZNRytJalZvMWsweDZYOEVaYmJI?=
 =?utf-8?B?d2JvZithTG9FbU05KzQ5MjNWM2tjZU5HN01JVndtTDNHMytiNzFzdkJzWGow?=
 =?utf-8?B?QkNNL1huNTJzYXlYQUY1MWRVUUFPL2RESVhkWGllSCt5WVFidDdjNHh4Z01k?=
 =?utf-8?B?R28yOGdzRmNYT2lVUFJ2WWI3aFlpT0Y0VzJVNDlITHJwQmY3bVVIVXN4R0Qw?=
 =?utf-8?B?eFJaOW01RFNZc2lsUStzV0Nhd0tMa3ovZzg4cVdFQmZQU2VnQnJFcWJyZ2p4?=
 =?utf-8?B?a3RTdFVCbFJCa3ZVOHBDVjZQZmRlTWZhYi94NGFSY3lHSWJod0FtaEMrYU9B?=
 =?utf-8?B?TmxXa2ZRVlN2MUdvbEV3Z0tvcnZWTmwzcUd1TkhiOHRhc01sS2h2TzUxTzFp?=
 =?utf-8?B?TnBWemRhZXc1cW9BN2RvK1B6TWVOVmhZaDF5YldrbVhzMTJlbnVGV3JDYUxZ?=
 =?utf-8?B?dXRHZTN5K0xRakpqUDdLY29vQzlDMEFJZjZrczQxWnVLZDVYeHBMdW5RTVA0?=
 =?utf-8?Q?ImieLv6gxcakp?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5506e5b2-5e10-4681-2026-08df09b9734f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:47:03.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4535

On 9/3/26 7:09 PM, Ilpo Järvinen wrote:
> On Thu, 3 Sep 2026, Wei Wang wrote:
> 
>> The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
>> isolation. On devices that support the PCI_ACS_ECAP capability, the
>> controls are required to be enabled properly:
>> - ACS I/O Request Blocking needs to be enabled to avoid unintended
>>    upstream I/O requests.
>> - ACS DSP and USP Memory Target Access Control needs to be set with
>>    Request Redirect or Request Blocking to ensure the Downstream and
>>    Upstream Port memory resource ranges are not accessed by upstream
>>    memory requests.
>> - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
>>    areas that lies within a Switch's Upstream Port memory apertures but not
>>    within any Downstream Port memory apertures get redirected.
>>
>> To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
>> support, pci_acs_enabled() skips checking for the capability.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   drivers/pci/pci.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 50a3b61f9898..b951195d5adc 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3648,6 +3648,57 @@ void pci_configure_ari(struct pci_dev *dev)
>>   	}
>>   }
>>   
>> +static bool pci_dev_has_memory_bars(struct pci_dev *pdev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>> +		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
>> +{
>> +	struct pci_dev *upstream_pdev;
>> +
>> +	/*
>> +	 * For ACS DSP/USP Memory Target Access Control, either Request
>> +	 * Redirect or Request Blocking must be enabled to enforce isolation.
>> +	 * According to PCIe spec 7.0, the DSP Memory Target Access is
>> +	 * applicable to both Root Ports and Switch Downstream Ports that have
>> +	 * applicable Memory BAR space to protect. So if the device does not
>> +	 * have a Memory BAR, it skips the check.
>> +	 */
>> +	if (pci_dev_has_memory_bars(pdev) &&
>> +	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
>> +	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
>> +		return false;
>> +
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
>> +		upstream_pdev = pci_upstream_bridge(pdev);
>> +
>> +		/*
>> +		 * The USP Memory Target Access is only applicable to
>> +		 * downstream ports that have applicable Memory BAR space in
>> +		 * the Switch Upstream Port to protect.
>> +		 */
>> +		if (upstream_pdev && pci_dev_has_memory_bars(upstream_pdev) &&
>> +		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
>> +		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
>> +			return false;
>> +
>> +		/* PCI_ACS_URRC is applicable to Downstream Ports only. */
>> +		if (!(ctrl & PCI_ACS_URRC))
>> +			return false;
>> +	}
>> +
>> +	/* PCI_ACS_IB is applicable to both Root and Downstream Ports. */
>> +	return !!(ctrl & PCI_ACS_IB);
> 
> When the return type is bool, !!() construct is unnecessary.

Good catch, thanks. The compiler already does the conversion for bool.
