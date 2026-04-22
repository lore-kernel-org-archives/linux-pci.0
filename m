Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731A3CCFD8;
	Wed, 22 Apr 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854884; cv=fail; b=WcXyP1TNiKF8W7hsdlAWcIxh4J0IbYsB/I/9RnsbOgrWGanOcXs+RL9mtTeEivrz0yBEsLsLPCR1/AVnvcpVmE3kDkY76CbfLTxrsfGL09cpF10yBgENPjAbyjekXHJWVi4893TZakqr53D5K5jYd211hmE1ObLckxfQcQH9s/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854884; c=relaxed/simple;
	bh=3rkRmejF4nrZppn6+ZXolZkqkthM84tNeCCMZeOvauk=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=Ib3j4nFDWtK3tuXWoZANEkKOfgcqICw8yf518nM+byTK+8U6KpAOjQMGa79VpghE8QJZHv1decNYDa9UMZq6RjiavPc8kq1eosvhRxt1Ui7TX+LeCfw0ftXqPmqTbO/7A5ZNOJh13u/TQ2sZ7LEMxqPoAz/sIvUkSG8IZ3MBZ3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Id+YpQnz; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Id+YpQnz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTTrs0sSJENrQOiPVmSY8n7+Mnm9S/Xfz84KGchbm6OYxcA6SQSklS4knE4GgO5wWl2odJLa21MUr1T1YcZ7NsGLow+lV1AGMl9eWmMa4aE1OxEwiVW2sNiXz7XjouFZ0a+3CFd9whoXYLToQruaIsSHLQR/XzmWCMvoPVkE3x561KSWUbONHl6+4Une9M4n4caOh1FW8aadB3HSEcVDTrLaYCJu46hoacsc1QH8KfUTpCLCukDJCrAvl36E0QrKbsJZepc2yH0UstHC9iItiGvxya6W3OhYDunBvxoZBmEg4ej5INV4sKgAcBcuD2aD8V24wmKs7n3sGK/3Y0EMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdnHCuDpVi+lIW0L9JskM5kgeRaRFqLC4IEKxq4ZtnU=;
 b=kwaPTrH1kUhxnH3IJja4vk2zgKAAo4pMnITOTKdGyvjeTFdllP7Mz1CjjSFEqE5bdAzvjIhmmcGidTi/g+zL5p+2tgitOZerj8qLlN9geZV0bnvVB+1zJhWx5ZOLbdOSZFWU0XSz3XF9FM6trPnnmD03WEQV0fWBC57Jh2IHrCLcsRQ6sxOO+DJLQZarmq8rVihlTJWhbzLqMHS9OBXo5usiZUSmx5Yca4Nf4VSAIUOHnmFYW+IyNpLv5BVC9S3jSKL3ZcBPUwg861lhICvjPY1sZuzwJ6HbjRGP4djFt3k4M9ffkSCkYoKYMavIWC4gie3wGTUDn9XIaJakkJh9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdnHCuDpVi+lIW0L9JskM5kgeRaRFqLC4IEKxq4ZtnU=;
 b=Id+YpQnzu2WF0anmn/Yo5DxYdTrXiTck3XlMbrjCgvgHosKcRPyWBPnpvPvrR5lhqyovahWhgR09Zcat54zeB6vyj3RhjahWWg5fNILC3dzq42m8YnfA6BXdrk6IpI8jHIDgT/yOOlUSkwF4DoemVsdokz19C2RPb0+aL9jM6eYB5KjlMMZ+ZJgI8a/qVVxOMq/qOeMwQoNkK1ZxJVVymuUAVwANeZi3OYmv3dC/VB7DbrSxsv/6y0l94G9BWJyq67YeKduBSJH9ToWkViYdFi/V0h8CwAcZwKG76T3bpk1EqzpK5wOMq/sXaLdPDrNRDJbiyM+IaUYZKHaiJMe47w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 10:47:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 10:47:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 19:47:51 +0900
Message-Id: <DHZMHF1YVBI4.F11YKDDKBNTQ@nvidia.com>
Subject: Re: [PATCH v2 4/5] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Boqun Feng" <boqun@kernel.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-4-2fe54963af8b@nvidia.com>
 <DHYQGLYYXEN6.11Q3FQGZMWCJ6@nvidia.com>
 <DHYWJ32M02N4.2954OSJXFGD1G@nvidia.com>
In-Reply-To: <DHYWJ32M02N4.2954OSJXFGD1G@nvidia.com>
X-ClientProxiedBy: TYWP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: a62d6df8-147b-40db-11cc-08dea05c9cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|10070799003|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FaYNQkJejaxFnf0KmCyl1VhifR7VZGrNbml9KjvEriH7QhQTgig6W4CVJ16EpjKyBSlUa0to768Y4JIce2SR9KsXq/8e4ujcmBfr3iuTU8v/z13Rl9q1u2dyBFNEovhjAR+YxSvO4WE746n0dnSiJ4kVra3GrY4jlQn5DPv0epB9p6yId9ii8M8KTwu56yWwLDxPd5EhdyeQFi8rbA86rJwBFvXHIl/GxYZfIspIXtPNmieH1nf5UX4pzC7ipD1L+xwmKTDLNSVHhxjjycmiim9/H919CAzM/8KlYodNjMCIbHqzpoZbz1kkX7T12CHZV/qpuqj7CJgm46mibc5sG2bmaO86PG2PwG8h/Z+QQzX8mkn+Ddw13Gxb+cFoZuMW7M091hSnH+MykzbWVHu4eVAgKqgSxah/Gmwyy6LbrvXVB0N/eRfI8fRuOcFRJNrXgqUvyBRPbkNPkEaXFTL4flC6dLW2Bv/ImToClAEcQwzDB8/hIQZipT3/8ZKu1PTAEgD/01ZKuG5r+2Nb7w4jTqCtPNZPdWDieBHLqcsw3CfQi6oBTWSwxmEkHaQc4vedrUAGiQGSnaZfMyfwi6f4M1WXFHxmO7zFLC+JTk8rmcw3hqEZu8VTBINrlKqsfvTC5VhWSSCbsOzLJKgr28qE4eRo9aXhswJp59yUOkzlWBmy4qAOoKzsYLKjUKx+BxiOgR+WMveiCGFFd06oJfD21weomfVGOHmbhyLOeqXH/x4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(10070799003)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUFFckg5T09QWU55bWhnSlVNZkthSk1RdG1JcER4VDJjdFV3WnRqZlE0THZD?=
 =?utf-8?B?THdKOVpVTWtxSDk5Y0VDc2xXRHAraHVoQUVlU1Babkx3QnZpYndiMk82OXVz?=
 =?utf-8?B?UEdXTGhzd08ycnJ5emNoZ0dveC9NeDVMWU1PK3JtanpjV2xNalNCNTVFMERJ?=
 =?utf-8?B?OEk1Sm1qazhoQUlyOGF4SWxCeXI1SjE4MXYxR1FxeDVLdFRUK3ArbTNVUWtj?=
 =?utf-8?B?SFlYUlUzWWo0RUZOY01vUElTOFB3bFFxY21FNWIxWUkybWg2UlE2Yy9sWnVa?=
 =?utf-8?B?YWNXUDNwU2NjQmk0Zk9iU1JuWjVtN3BQK2VSUXlDSVFkNlNGeDhYQVNORTNH?=
 =?utf-8?B?T1cvSWlIZUt1cEVtVXFNVTM4MmRUVjRkanpjckJFbFZYbnp2SjZGY2ZjTzh1?=
 =?utf-8?B?SHk5SVFpbE94L0pGU1RWandoZ0NvcnJMeUhKclNBMzlZWmRpdGtZL1RiUVEv?=
 =?utf-8?B?VExrazhpeWl3Q25MOUYydURJUmY3OHkxMjl3NHhId0Y2ZS9XK0kzaWNvRmR3?=
 =?utf-8?B?TERCa3RXUnJnc2hVNnFuZ05tTk1nQXhtQjBtQzJ2djF5UjJGVlg5MWVzd2RO?=
 =?utf-8?B?TjRoMCtEWlNCZEYxUEowMTUzc3diMDgrOG9WNGtNNEt5dmVHcDBMTm5NZ3Az?=
 =?utf-8?B?MytRRDIreGJCWW9mWHdSaDRlR3Q3UEdGdS9GcCsxTjVsVFF4TmJ3WDBzVTVu?=
 =?utf-8?B?VG5mWXBvSTVTR3J2eXVHNWlGR1k3cFZ4Mys0V2FSNEFlbG5HUVU3V0pTNzY4?=
 =?utf-8?B?MFpZVUo1VkpIM080WFVWSDd5V0w5cnBFbmNhMitsVWx1Z0l1SUlOZ0phSk81?=
 =?utf-8?B?MXRSTTNlOEV2TUVHSXpyYndseWx2QXBPcXh0Ky9pSVF1YkJ5N0oycUovVHh6?=
 =?utf-8?B?dVpVM210MFY1VWg5Sk5LZjVXODdRSzhMcFJRbkdLaXlKWG5NbG04RWhGWDVO?=
 =?utf-8?B?enJGam9zNFMyMUg1bEZseS9QemxLemlhK3BKVnl2dGgrenVvY2hkWmswY1g4?=
 =?utf-8?B?MGlPei92T05yWHFIQ0hkREFseDZrRmI0aW5YN0FtaUxvd2pyWVlIanFCYlVL?=
 =?utf-8?B?UUJ3S1M5ZE83Qk50UG1QeXhROXA2ZUVMbk1iTmJsRkxtVGhNck9DWTd3Zlkv?=
 =?utf-8?B?RFJ6YVJJUjFmNzArSUJITjdSRlBSRkNMc1M5ai8xbURtTk1JWWJkR3pMcFN3?=
 =?utf-8?B?N1dpK2h5MG9sSGFuM21paUNWRGJpeE9TMmdRNlhaOEpENXlSWGJlU2duQTJC?=
 =?utf-8?B?VmJIL1JjNmovTjAyb3d6cHhFUkRsV1RhVGZNeUVEeDlobkwxL0N3QnNTYzhU?=
 =?utf-8?B?cXZwK093QWw1MXJUWVlCVnc1d1lZLzc4MUF0WGZqT1VTWEZQbVlFRG5HQXk1?=
 =?utf-8?B?RUVMTWhtT1owV3BhWFdMMTBLZkpRaVNuSmxYMEc4TFFqUEJPRzlFK1ltUXNY?=
 =?utf-8?B?NFlmN005cERWK3Z1b1lPWjNJZHREQXhnZzB0MHkrWGdObDh1QUR1bDVrSUN3?=
 =?utf-8?B?TnQ5QXlvd1d0WTAzam9teHB3R1U4NWVwWmF4YlJLKzhxODhrMU13bXNrcitW?=
 =?utf-8?B?MVF0bnB1amlTdTYwWjNPcW5yRllDalBPWEozSGozdy9kdU5oNWRxanZnaTFG?=
 =?utf-8?B?QUJ3Y0FUNythM0cxTEFWMmgxditCUmxLdkwvZFpHRWtQVDY2NXljUTZvcDMz?=
 =?utf-8?B?Ym8zcm5iSndXclhYMGJNSXk5STRKRTVvNHZVOUVaaXlFdjhVNVRsVWQvbGlS?=
 =?utf-8?B?OVBWWEhCT2J6TWRsYUhrQlRHWTFTZHl4L05rR2pTL2dGa2NHb2huUGk0aEdp?=
 =?utf-8?B?REM2OHdQdEYzbXJQeWVUMzZtOXhIeHVzSGRPeVM5TmJpWXRGVVZsdUo5aXRC?=
 =?utf-8?B?b3dBdlJKWDdIWC80MWdHaGFxcmVPODNxSmFkbDJMUWtXeXUremtQRG0xcUtl?=
 =?utf-8?B?WEQwWC9VYm81c1NUMUU2aFJ3bHM2U2dtcWpPeWpwVlRUV1dLem9FOHJUWmxC?=
 =?utf-8?B?cjJBNk1HYmhUaUVNRW1ISU82ZmwycFAxUHRzSjdGenU4MUo3eVRYYlhpU3Iz?=
 =?utf-8?B?dXh1YmVPSjhCRzQ0cE9WOEVKMWptcFR0M0RGTFVBcTQ4dC80cVo4UDJjQjBa?=
 =?utf-8?B?cmsxSlYydFA3cVFNVDNGR0RFUEJodVZyQW5SeTIwelNXUnBZWnROYVFvb0dY?=
 =?utf-8?B?Zm03VjJYaG9EZndpQi8zM1p2SVAyaWkrTCsxcE5leHE3S1cxR2RjSk55NkRS?=
 =?utf-8?B?cmliVkJ0NkpQa1BtWWhsUiswZkU0S20wdkY2ZXR1WlM3RGM5bkZ3ZDMzTitq?=
 =?utf-8?B?c09JYzZwL2swZStldWI1dHhVTlhqSDBOVlZzMCtKVmNVYkFOK0FpME5YVktq?=
 =?utf-8?Q?5ScHQ3bYlDvtJUGgZPu5ygE6y88e3YtNUGyUnBIzJVUz+?=
X-MS-Exchange-AntiSpam-MessageData-1: 8LdU0nQHXnD0OA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62d6df8-147b-40db-11cc-08dea05c9cc7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:47:56.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWRcH0zgQTuCHcyIKIIeGqk7oPh7AxpTbp2zcuenK7aGnFEd2M4J9ghNQ3/ESngLjujwVl4/M8r2gj8wdruRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125

On Tue Apr 21, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
<snip>
>>> +        dev_dbg!(dev, "GSP shut down\n");
>>> +
>>> +        Ok(())
>>> +    }
>>>  }
>>> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-c=
ore/gsp/commands.rs
>>> index c80df421702c..fb94460c451e 100644
>>> --- a/drivers/gpu/nova-core/gsp/commands.rs
>>> +++ b/drivers/gpu/nova-core/gsp/commands.rs
>>> @@ -237,3 +237,39 @@ pub(crate) fn gpu_name(&self) -> core::result::Res=
ult<&str, GpuNameError> {
>>>  pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspSt=
aticInfoReply> {
>>>      cmdq.send_command(bar, GetGspStaticInfo)
>>>  }
>>> +
>>> +pub(crate) struct UnloadingGuestDriver {
>>> +    suspend: bool,
>>> +}
>>
>> This feels like it only makes sense to call from within the gsp module,
>> so I wonder if it can be pub(super) (prolly a few others in this file
>> could be too, ofc not relevant for this series).
>
> I'll review that, we do want to limit visibility as much as possible.

Mmm looking more closely I am not sure this is something we want/can do.
As the driver expands, it looks likely that some of these types will be
used outside of the `gsp` module - in particular some of the responses
can be used outside, I think this actually happens with the MM series.

So I think I will keep the visibility as-is for now.
