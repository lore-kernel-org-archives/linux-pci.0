Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F9125AA;
	Mon, 27 Apr 2026 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293394; cv=fail; b=iGkNbGopZx3ac9UFJ+zgs0VbC748pvOuVoLBbpZMt1NQoj4TVOYpAs2zV5UMycfrsGlXsUw9NYOMo+rhmGK5mmFXRqugYejZ1YVg2cJPWrXHw9GpzQZpYuQA6SSRKk1C3igVjHRGqjfPqcQU5Mokn01+wP5A7vr9koZdmgmtRWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293394; c=relaxed/simple;
	bh=kn94LxFqtKBkTRkE0DOvkjUSCShxGOmOx4REfPc4zq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g9ZzVMvtYgrB34eK81X+OQ6wrnf2Grn2bw59MRHegWTbFpgyV1Gc9Y8+31yYqHs8aN2h39RP9CAjfjVa3COkoD+JXquBJ9m8fywRxvI4cDv6yecIWpmlwrqOp8zOhLjSy5Y6fjQrYhjZmOzZmVvIcAEhJ02XQvFcMmWvpnmDNyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vC4KC4R4; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vC4KC4R4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPLQEU098dG/7FS++NfovCLedv5uRHk2xWt9lLCxrbgMd4NoiI8ZzzEM/C/gx/6KYm6vwxUhMjBz52Fk27OMzyAH8CfW9K7NgnqJOZA6J+KVe0elKe8o1R1sRSUn9RRMxNqXSISbILb4WcfjYc8vjIjQyiTTArT7T/6e5+qwCUpIzLcN+10vlIfgNp8HsPB3ue1TOk0eoNVbbHT0ZIfT43MtXe8YAFQcVuZW3wCCT0tFWK2IoZAzJQqXbt2oUbuYjJYZ7x+xTzHqe0XIxdvlIH5Rkke/YshYbyFQlePtq29azAsFBbfYp42/CcMBoKdGYvHmkjda/e0ZKOhvfY1QNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmUmCudsxxI2b9SjYepasX8HdwQ/VInLDnYGtgI7J2A=;
 b=CApjXaPPXLgJ0U/Sl6hdCnaLGmOltmSqOG20FEKlJ5bi7rmdrsjLigvd2ED9cBDkTnOHbJ6cJiSo8qTCKXkdKrEeL+axxqHetmWn0FdEw7utzblGCubFTi2gU0doXM/W4l5Mg/Jdjad8CjrqYUjAgxWxWyGisbkHMhHs/vHMnhBzj4Xm79Gzueg34iXUKV7hcU1DIsROsJ3oEd5Q2/p73BfML0/JkkbvuLvLo5HrqlmwuNeYzLNgbdPbzox96s/Nht5qDoJr7ofq597Yg2Y1G0LdctyXNq7vDyUG1VVsMwTWCXlY60WP+GwwiM0p6408ZmTyqbNk8PrWmjrDJUhhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmUmCudsxxI2b9SjYepasX8HdwQ/VInLDnYGtgI7J2A=;
 b=vC4KC4R4S+1aZlK8QeH95TvgJwur4fllchIccUDY199jAqbKO6BjvJnrhdZXNhP2utXYMmPqF9MGNKpdaHA0lPCk0WPzkxGgqx69IjRZl1gwgHJGEO9V2PO2qkJy/DUL8MCJ6lCtw0X+uurtf5qy4jTmNcJST+Fqpu+Q/qG4w7mHZ6XRggNnpdvthuKH6USZUxjhgi6oE4tTXGbWdAlr15EDhM3loStgzF3qf3/KIvCpn61J2Gw7YNEpAmai9ohoET4b4xCsjd0PbSMdnHEmtrqK9NJjTdVSMlFWKqmrb2ve+nRxCDYkqtQp+EM50XWay+3CxM1hm0WzCiMNDqwlFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by SA1PR03MB6670.namprd03.prod.outlook.com (2603:10b6:806:1c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:36:27 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 12:36:27 +0000
Message-ID: <45d7bdf6-3780-4bcd-a9b2-5c6ec9ffbbe8@altera.com>
Date: Mon, 27 Apr 2026 18:06:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI: altera: fix resource leaks on probe failure
To: Dinh Nguyen <dinguyen@kernel.org>, joyce.ooi@intel.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, subhransu.sekhar.prusty@altera.com
References: <20260424094913.522123-1-mahesh.vaidya@altera.com>
 <20260424094913.522123-3-mahesh.vaidya@altera.com>
 <11154ecc-d49d-40cb-8437-a4e6af1420de@kernel.org>
Content-Language: en-US
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
In-Reply-To: <11154ecc-d49d-40cb-8437-a4e6af1420de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::6) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|SA1PR03MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e492922-ff20-4690-2e35-08dea4599980
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	cy66G1YD0YeH1JJa6zEfMsuo5Z7d1THPg7QI0q2dBv+5Fs1i5eUiawZiXUSJG7BVGDmlA0VErRoY2uCUWrh62Y6V+pw4q6iP2cNzwZks94QL/liDdRUSxfX/Mu+HwQQstI/roa5F0CclNHXFXaLSgqnGmp9IZ3ks8J0Ed6tnRA4bAQJqMZJChA312dY9+hMBhyZxUqQMDGwXKK3iyaYl1iI7Hq4UhKfb6fK+0e+UUV22RXCpmCgdv8zEIuP14kxfsKTeWjZLRgi7ntMXiXFaYSjsDgr5u5BeoPFxDaER5P4LkOvdvMQcY2S0rtgd3vhq/1zLbzHy6gnAND2dheZlFJ3WaOp7vQFWkVRAFlyYZ+9pvfc718nU2ouIggkvOtdpMzOgK59i3uCuGEEU3IQJ/6J8IDPgOo6uexQ+cK4DPOE2i5dFig/jQZ2CqVBtV9Ycj6kXurMTd7R2vY3i/bvGnN3yrl4qjH1SLJ15/H+gpn5zxPhEkNTrcE4C1M1dfjDTUW1AAxBcp2BAGvIExXc3q1yj4l0kTFbBWtWkhA66ZSvKAGs+6iJI47HdgFRi2V69k0xj8A2wjS8/m0Gyt8QkLxLOI+ZWfhWWyTl0hhqBqWix15zcAGQDR+desEhoIjQOcAxBclRDOE0MetBHrR64cmi3DHvjy+zD12/OouwLY85Ej3l8XH/to7rxXSQA9yavyr4zBOb5yzNoTb4NdArHnjmkUvz7WFsbld0r02eEzrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHFPaHorc2REMW9MbytWUDY2SlFyZGl0MmdVcmVqb2lCTmVpRHlyZnB5OG5Q?=
 =?utf-8?B?L043RlVPWC9aUU90WUNpZStnQWppaVk3QnQvL1BTWEt3NHFudGJTTCtxMmFZ?=
 =?utf-8?B?QmdrMERSa3BlWEY2clNIL3hldjBaU1hyZjExTXpkV0Zoek5DTlh4YzlJbTUr?=
 =?utf-8?B?WW5yUitNMExoY3VqRjJJd0lDMHpwVXJLTVdEQmpGcjFJOHdhYUpUYlhuOWlx?=
 =?utf-8?B?VldwQ2JIbTR4NENUYk9ITGt0Uy9ROWZtSHdJWTdnT0hzamJ5R053ZXNERXRr?=
 =?utf-8?B?Qk5pS1JPVEFQTnRpbEFNSms5M0VLNlFHNHdpY1kwUWhkZ3J3b1gzZ01Ma0ZR?=
 =?utf-8?B?YW1VcVJtekt2Z3pSWGdIUlR4MFRSR0lsY2htc0hXZUsrSmRtZWhWeng1NzFV?=
 =?utf-8?B?WlVDNjFwU0pPWEo4UkN1dXJzK0xpYTRyeHQxT2hqN204dVA2UXNBdjAxM1d2?=
 =?utf-8?B?Qk5VYWQ0TUpNalJpTG8xZE0vaUtGTmVPSTlFWHM3ZTQ2RVFnNFVqd0JDWmVa?=
 =?utf-8?B?SGxxeWMyUWZyYzVIVEdGZWVZbUhFS3lZdm9mb0x2d1lzSkY2RGJoeWZ5Vm94?=
 =?utf-8?B?cDBlb0JwU1RPbFVDQ09icmxiVkFQTHJpSmhQTTZxNlVlR0xzaXRYMkFsMGdn?=
 =?utf-8?B?Z1RMK3NGVWxoQmxydURaRDBhQkUxbmlMcyt1Ym1ZRkxWVUFiNjZjWU9Wb3JX?=
 =?utf-8?B?SklPYUZNTGhiVTBCcytGR0xIdExGV0Y0a3ZGM2hKN05ON3VCUng2dzdaUmt3?=
 =?utf-8?B?Snc5bWNiMGhyWDNBbVFCYlBoRUZobEU2NEx0YThmaHNrZE40SXJzT3Y5OUNa?=
 =?utf-8?B?ck9zMis4UlpRQllxNEhZSmxWMDZYQitkMG9CNTRZVE1JeStvekRYY1V2cFFm?=
 =?utf-8?B?R0YyNXZxVU9CZGdXOWR6R1QvZm1MWk9GU3lxcSs5Um5hMjJlR25uSnpwMkNY?=
 =?utf-8?B?SHhxZDJnaVpsQzVkcjV3WGJMRnVScHJzdDExN1JmVUppNDNldkxaS0p5NDNT?=
 =?utf-8?B?ZVRQRTgxb0l0b0xvUXlqclRkc1VMTXZ2aytzNWc3UkRKVzF3T3RvUERrOTcv?=
 =?utf-8?B?ZG00Q3NGRGZkeGdyRUYwUEZ1UWN0dEFxZ0NRbFp5SnE0VkFDTE1SS3haOGQv?=
 =?utf-8?B?NzFmNVhobWkyUDkrbndhZ2lKbFRTOFJLK0VRdDVKemcwalBnWmRZT3EvTTQ0?=
 =?utf-8?B?cUtlRUNRaDdMK0kyMW05VFhtNmhlTW9TcFVGOEg1WTMvOXZta3NHaVF2VkU0?=
 =?utf-8?B?OHBtajFVdE5hR2RLVk12T0pxVmNhcG1SMnFnTkx4VnBvd1JYeDRYMWV5S2RH?=
 =?utf-8?B?c0ZsOTRMRzh4czB0bjcyVmRpN1VjY3I2V2NtTzFHb0pURXpFNGswRWdQbUxZ?=
 =?utf-8?B?a1hGeldTUGJ6L0MrMzI0eWVvTGZNbGhNK1dXSm5WVWNocWlwZ1JNMzVzSHJt?=
 =?utf-8?B?a0paQ2Q0cm9jeEtBTG9tdkxwWTlaNm9TRU5TdGFJZXpQN2VCYXdXbExIV3Ry?=
 =?utf-8?B?SXB5T1owU2lKZUdaMFhrUXFrNE04ZHBxZEtKbVRFbmhQZStNUjhKQmxzaWky?=
 =?utf-8?B?KzJZR1Q2a204ZkVTWFYxeS9RcXFDUUp1QXhzQ25MVE44bDFRTFd2UUJCMm9Y?=
 =?utf-8?B?R0k0UHBjSlVxWUFXRHpXNkR5SHh5SVc2dm90TnN1OU8zbFJ0ZHFqck5Kc1dY?=
 =?utf-8?B?YnpiN2QzSENzdzBkcjNCbVdFKzBoK1AyanlwMU5Zd3ZrRkZveDVvOGlFTTgz?=
 =?utf-8?B?eGIyN3RaUzNxcWVpY1JKVVVCck9ST1YvR2NZanlKV2F6UVBVWm1kV3FsOW92?=
 =?utf-8?B?VEVVU1UxYm1hek1veCt0ZUpkTXk3bUxDYS9ZeFRRaFlzTUdyTHVINFMvQWtD?=
 =?utf-8?B?RXVkQy9ueGVMUG1FMGVRTS9Zc3dDZVlMN1RzMWZvTlFramdFN2hSYnBaMGl2?=
 =?utf-8?B?OHI4YnlhRWQ0N2JCYWxlMmdoT0Y0SXFUS2Nrd1VQdjUvVC9HMGEwSzhTeGxx?=
 =?utf-8?B?MGpQZ1RRUjM1RmJRazByWjlmTzFIZkl4eXkwNzNhNmNBNkFFa0NUa0Iwb3ds?=
 =?utf-8?B?cXprZGVLaXVxaFZkcmtibFRSeWI4NTJaQzZwSWU0YmVRSnlqWlFhNkFRS1RN?=
 =?utf-8?B?Mms3cldiNWc4WXFyNVY0OEhINmdVd04vSDhOdXVzd0hLMXY1QzFNaFgwRnMw?=
 =?utf-8?B?SHRvdlJrcE52dHB4UWlTQmxCS1d1Nk1uZDBVSkcwaGdUV09Vb2xMN2ZnbGN1?=
 =?utf-8?B?NEpFaEQrRkZtQVpKQjZsUHNVVnlDWW9KeGYyYzJpMHRhV2w5TWNmaEhQdEpi?=
 =?utf-8?B?cUloVTAvUGZVWjdIOHlTbW9MaTBkcWl1TW5sYXg0d1c0b1ArZTRib2g2c3hq?=
 =?utf-8?Q?iEtUwgQ4aJqGtUuA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e492922-ff20-4690-2e35-08dea4599980
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:36:27.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7yhc1vrTqxqYYN7x1XCbpd5c4upMsTF/nODnjgGK4Vw+DxsvLQPEjtFPxsw+hQSyIo0HD7eUp7Kzeb6APSQNEn5pwAicQgEKsUpo/zVnLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6670



On 24-04-2026 18:12, Dinh Nguyen wrote:
> Hi Mahesh,
> 
> On 4/24/26 04:49, Mahesh Vaidya wrote:
>> The chained IRQ handler is installed in altera_pcie_parse_dt() but
>> never unregistered on probe failure. If any subsequent step in
>> altera_pcie_probe() fails, devm frees the pcie struct while the
>> handler still references it. A subsequent interrupt would trigger
>> a use-after-free.
>>
>> The INTx IRQ domain created in altera_pcie_init_irq_domain() is
>> similarly leaked on probe failure, since the existing cleanup via
>> altera_pcie_irq_teardown() is only invoked from the remove path.
>>
>> Move the handler installation from altera_pcie_parse_dt() into
>> altera_pcie_probe() after the IRQ domain is created, and add a
>> goto-based error path so altera_pcie_irq_teardown() is called on
>> any failure after handler installation.
>>
>> Fixes: 60f2ee5f1472 ("PCI: altera: Add Agilex support")
>> Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
>> ---
>>   drivers/pci/controller/pcie-altera.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
> I think you should decouple this patch from this series.
Sure, agree.
> 
> Dinh

