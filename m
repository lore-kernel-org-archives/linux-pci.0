Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012347255D;
	Tue, 28 Jul 2026 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265986; cv=fail; b=ko8aAGty+EOTypViL4ROjilLOu0bc/G7HFtgO+mgTHfhXgHpxiUreHWIvN7Hs0mHu2K0Hlhpl7WNrycFxu7EZi24w2Vpdc9rBUrlzL0RwfFBbBSoHuUHwSO18MZCgVfvnh1wkBkVz2j9txxW+YbVHX3tuo1nSVUZUEklg8Rg/sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265986; c=relaxed/simple;
	bh=ixomk9kBwQS6JObSWEot54DABADRER0c9+ri5R/Vvlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VK/NRdO26neQIKz5zLI4Ml3ZvjC2Xc3w8Xfxbjx7hiz6YUAH6FkSSjck4ggzUHBQbxG9dXJkU/8WO+GqigO/8zhrf4z5m1qJBwWLOQkxPt5jTyxDAL0G/wpAAL3dOyMYeEQwBuk8zvHRhilNdgraD1rAs1X397DM6nr3oi0Otfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JP5mmQ4/; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JP5mmQ4/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJAKFU/WKn2WqSHKU85DwgdJMQq2K8gKW+hLbUyvIn2B0LfUzdjHPtNAlrECpxbhBzZbZ/KR/5kYd73HmLULY2SicGBBUAbfWapNg+ik3eG4LG7FHmd9pEWQ9vN0UmdmeOYNR5XsFhDgisoHrytnnE11Yw+ZaXWZ3lCHhZnonKTBRZiOFErOKvJdh5mIx+smr+eUwV6nIRh1Zu+nLPTqBjwswhEy6nczy1+up7jpI+GnBYaSFtDxv9CNgx8RNNLMbfwzZOQxl001oCPPlgENzgGzA+xGwIa2H49di24USzQ0n2ScmSagGNlAIXvDOwmAxCsHzpsfj/ibBQBLUetWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afQVO/aZnVbGHZynbZBWb+7z4pgv58XyOghumq2eEzo=;
 b=mEaK3xILNzbwxhClF74NjrPPolgAXyGqgDjRREq4edq8k80jdNrDUYN+7OGKPA8ZXUHpa+ZrMlHr+7PhtARnSxRB+nxiUGxYI7Iyjceg/G0oSx42ibuVVhCQfvvhUqtSabji45T8x/sx0I2dPHWhLSgzGLaa1IoskQix0VAET60fSk9b0uPGT52nJl7VxIT2LUBLLc+n6+MJBDtLcW9PWQGiyjVqsBGjQksNhBoG2p2W8AQAqvOm41JviJEBvn5tPqA2NOGyXOXFGt9BgUqZqMY8Pn7Ls/EIz+3zRVyhiSJR9IRnAiT4IIIEJQw3XZmV24G9v0/ISYNTw+0CTDpkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afQVO/aZnVbGHZynbZBWb+7z4pgv58XyOghumq2eEzo=;
 b=JP5mmQ4/Om6copP+PoEw0a+2z8zNJc6IR7G4BDckz/XuyDrzrdxUlo1KyDp8twvH+IX86mYA7aDHGyEGyLcUI/7jpZgON8xFLKgCitr/DzjDc6sBeyetjtKbo3lLsOFjVFLx1/4LNtQPVPDyV2plYPqlW9LdP4Rk5bpI0a71vwDzP/8Btk5UR1o1te5GUxmbVzGkeO2AzovdMg4UE6L9XdhCtcNCJ51gfualBvPa5o+OO5oFpPYfaJ2ee0jwy+Lmdk3rIDl1haHq3YSjrzKycRKw4I2xmCeKhQ2KHxisp7mgUyPR0qmCkXi3tcB4FdDHU7n8P4JSojhfLibmdNOaMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 by SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 19:12:54 +0000
Received: from LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4]) by LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 19:12:52 +0000
Message-ID: <4c82ae0a-d424-4aec-8423-3efdf95fbf63@nvidia.com>
Date: Tue, 28 Jul 2026 12:12:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] rust: io: register: allow explicit base type
 specification
To: Alexandre Courbot <acourbot@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
 <DK6LF1ODPWC3.3QQV3SXQ55SXP@nvidia.com>
 <DK6U0LR7D57N.3FW1CZG9R42YF@garyguo.net>
 <DK93SOJQHSVI.1UCSJRLNZORJB@nvidia.com>
 <DK97C0MWLGFS.3D544FUPW2ADF@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DK97C0MWLGFS.3D544FUPW2ADF@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To LV3PR12MB9412.namprd12.prod.outlook.com
 (2603:10b6:408:211::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9412:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d891506-e149-4c85-456a-08deecdc38e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|7416014|4143699003|11063799006|56012099006|10067099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	h3h9XgHmF/E9EqcwVY/DvVriRuYvZHsA205QuuqWaO3lbD8AgJSETiAqU4OdHG6Kb1YlW24JipbfyNN7I7tqvG14EWwr5AQtRgyx+zPInV+gkQYu40wOL2/k7aUJ5GwladQ6v0uw6Lck82ja4VwuoBj2r7SVfouyjUjlpOgH5Nc81LzAF5l2M8zZsRUhuo8l3UHSM0u5Gc5waSII3T5UD4vNS4IC6gilDIRpo9k+WC9hJaQZCMlsFExtJIyiWg+T0dkus3qoroX/GG2iNSYaQKxrT68cLV+DrNOFe72f0dt7audhIki+Y42wQrU1FRTmdnQ6UI6PcHAGk1eTZAn1UGtne6TorgFdEpo+HDu8+hexZPAwBJ88kXwNlXFGoA9FwKMNSheZesKQ209gA5Vlckc6YK86QIzDTE1bbDErqp6XNqanuEyukdKxCtBgZi0u98qkOgCmUdqOivdfec8iJCWnBzYGNhtsFLvbrTdVHHkS95JncWeVpjCsozH1JCvjjIcatb50vmy8PePadmRfpZ+bERrUEhXY88sOR8egGY7NuR41Pd3LFF9R+Se+l67JI/dmFaSI5Tpv7yKEMPnyQmFMmq3f9ILqNmEztU9tj6yMAn1DTLR85uB6bAGHeDbqneRaR3Iech2MYfgdqMiB14f8SEz4AAIEGLcK/jSEmfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(7416014)(4143699003)(11063799006)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnhrSHdudmVxVlA3WGNJQjB5SDZ5bUp2ci9FNWRSZ0F6U2dJZnJ3UWE1cjdN?=
 =?utf-8?B?dXFNWmVJWTdxbDFRRkNUUlhSYzRmdTVTaE9vcVJobFZzS255ZVYvVU1PYUtv?=
 =?utf-8?B?WU9wZStOVWJNWWZ0R2ZXQXc0Ulo4ZjZHRmt0ZTAyaHR3azk4K0RKVmNwVXI4?=
 =?utf-8?B?Rk1sTGZHZUZTd1BDSmYrdnhtLzdNZm5BSHFlYkpnN1A4WEh1aTU5bE1KV2lu?=
 =?utf-8?B?MnlpV29lcHJjMWQvNE81bzErd3Z6RGF5U2duOWV6WTAxWjM0SDFhNUdWMVRl?=
 =?utf-8?B?czZuNXU3ZEpRRXJFNTBWcWhWWVhtK2tiV3Q1RkwvODJEOFBNQ0tIZ1VyWGdI?=
 =?utf-8?B?TVY0SEcrQUNXYjdJdTAxMVoyeEptOENCSno4QzlhRnBkcVRHVUY5dnZWeDJG?=
 =?utf-8?B?d3VzMDRiR3hZNHNKZ2FtekpkTUVmd0YvVS9vOUpDR2N6amlZVy8xbkdwN0hK?=
 =?utf-8?B?dGYxK2d1UjJrenpFNENINm44UkZBS1hSVFBrdTFad01rYTI5Z1lsdi9oVjR4?=
 =?utf-8?B?WThBODVRTGVnVTArSU1nYXBFemtGeFR2SVZJRzczV0tEVjF4bG5TVFBnQTB5?=
 =?utf-8?B?dE5TVk42TnRvZDh6NFhlUkMvaHdoZHg5TVB3emVYWUlDY0g4Y3A0ZHNJaEFV?=
 =?utf-8?B?QnBrTzcxaVE1ZUN6Q1IyZGtMb3ppMEI1dGZtUk80eXYzaDlsSFZSeDZVQWhy?=
 =?utf-8?B?V1UzMjA1bVE2VXdmNXNZc3hiYmloVUxPdDNPUHIvVVdYVnNrRTdwSzZjUmdD?=
 =?utf-8?B?dnRoMHZteFc0cVlmUk1JN2pkZ1FZWXlJUzFINTJvak9KVHVndXkwcnN5V2sy?=
 =?utf-8?B?OG16K3ZSODNOV1hBeDRIQ292WU5TMFFET2FoRXFOdExSYnY5a01CWEc2cFU2?=
 =?utf-8?B?eXVPaVZIOXI3cmtEcjdkVllUZVhFWEljeE1YNGtQMWlpcFo4aXRpcHJYaUg2?=
 =?utf-8?B?cnB1UnBObTlSSjR1MHRPNS94UG1USUJXSTR6VXBEMjV2WDNUTE44WWQwZENq?=
 =?utf-8?B?TVZrTFVDbmt1NGdoSERnNG9CdWJKUTlPN3hyYmw4M3grZDVPNEp4NVhFbnMy?=
 =?utf-8?B?QXlqY3hrWnpZNjd3TVhVbjBqTXhacmx4bFZYdDFmNEFNaFVDdkk3aXlPRTNY?=
 =?utf-8?B?QkhaRm1sT21MOG1NZWp0SFNuMWJ0ZkYycW1QaDYvYmpiNDdnOFR2ZVFzd2FQ?=
 =?utf-8?B?Q3Y0SEtUNXUzR1Yza1VHR21ZeUsvWVl1ZEJ1Yzlkd0FwazczeEQrODlESmZs?=
 =?utf-8?B?L0V1ZXRxYmJxVXVXbTkzZlJNbkhqdTdOREdPRTRXM3hQOHVXVW5xeUZTaEdj?=
 =?utf-8?B?ck9DYk16d0l5eU1yYUhMaG00cDUvSzEvUEd2NStmTWVwMDUvMTJZc1hFaUVk?=
 =?utf-8?B?N1B5N1pZdTEwWks1SEg2MG4rQi9udTNoOTY1OVRWekJlUGw2dUJzMWp6Tkdh?=
 =?utf-8?B?c1k5TXIyZWw4YmhHOGZ1aUpOWG9zbHhZRXdDNmdBbnkxTE9waXBxdWdOZHUx?=
 =?utf-8?B?NHB4QWlqdWpiTGpuVXlRbEgzdEJIOXMveDNuMW83VWFCQUFka01NTVFRNURH?=
 =?utf-8?B?KzhMUmJGcnB1QVJicnRTdUcyV2tZQ1BNQThQcDcxelE4eXdnYk1YNGhzZmNT?=
 =?utf-8?B?WWdiS2JvVFprNVpkNEQ2VWpHTmxrdXFUaUlack5GNGF3SE9HWFhYNmVpUDQ1?=
 =?utf-8?B?dHQ3cXR2ejhiakxKSDl4U1ZPNGcrcG5IaTVLcFhTeU9md1dtZWVFUDdYQ2oy?=
 =?utf-8?B?ZmNrNlNFTTgrNjRlQkw2NzdDbU5CdDF4MkF5ZGFVVGJuL2l0ZHI0SGE5TlJh?=
 =?utf-8?B?SUZ5UThLRVFla2w4K2dKWmV3OG1pTXQ0bmhvcWJuZzNDenliaWtzNGl1T05t?=
 =?utf-8?B?ajVkQUxNaHF6c1FoS3NwL2ZHY25ob3A3Ly96SzVWd01Pd2tydHU3dElTNlNO?=
 =?utf-8?B?TjBXWlc2bnZyeDJJM1QzVlhXTGFIbUZZenFSYnZ3Ni92OUxWblNhK2dCdTY3?=
 =?utf-8?B?RGI2U2s0SzI2SGQ5RUNHdllYN1lkMW1FZmd5ditBVEVHU25CRkVDVkNGVFNn?=
 =?utf-8?B?eDlCNTBMWXI5aEJpTFNTU2s5cjh5a2Q1RUZvM1hXRDFWTkdKRU1SckFvMDBW?=
 =?utf-8?B?Q0FDZ0FjVWVaZUhJUGFsME02anFlRCtEV1ZQNHNMZE1yWDNSQ0t1S1J5K2NT?=
 =?utf-8?B?czJyanZ5Vk5vODBCTUJzWmZLNTFHaGsyem5SSWZNY2FtUk5STkIxdWRiVnZ1?=
 =?utf-8?B?RDBpU0NHSGtzbVNySWZrc0hUWFRUK24xaGtPSmJMbnRCUEdyN3JONUM0anFn?=
 =?utf-8?B?bkZleUJnQjl2OUtVTmw2SjBJN3dZeVRmbUlmaXVvMUVmajhzb1U3dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d891506-e149-4c85-456a-08deecdc38e8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:12:52.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KfIDch2sN9qlG9HUa0feEN6Y628Sbpg5hGDi1gQAyQYJH3ZggDS9cjuMBkCHAazBtET8Tb+RCNV48D3bw7QPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798

On 7/27/26 1:14 AM, Alexandre Courbot wrote:
> On Mon Jul 27, 2026 at 2:27 PM JST, Eliot Courtney wrote:
>> On Fri Jul 24, 2026 at 10:22 PM JST, Gary Guo wrote:
>>> On Fri Jul 24, 2026 at 7:38 AM BST, Alexandre Courbot wrote:
...>> It also feels natural to me to specify
>> the space that a register is in (Region), and you can decide what method
>> you access that region (Mmio, other, etc). The cost seems to be that you
>> need to specify some region on every register, but afaict you could make
>> that a Region the size of the entire BAR0 space, or a non-sized Region
>> and just have all your accesses fallible. So it's a bit noisy but otoh
>> it's nice to think about what space each of your registers exist in.
> 
> In the case of Nova that's something we might actually want to do: as
> their name suggest, registers are split in large blocks (PBUS, PFB,
> etc). And we are currently trying to move every register out of the

Yes. The HW ref manuals have already set up an extensive taxonomy, and
it's probably a "feature-not-a-bug" to specify which region each access
is in, actually.

For NVIDIA GPUs and other HW, that is.

thanks,
-- 
John Hubbard

