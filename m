Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B98E1F5825;
	Sat, 25 Apr 2026 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777084817; cv=fail; b=FmtI5IHVhDeCcEn0t9OQVSo1AW9SapUV6/XqaHV271hu5+MEYicuDJiJcuFGyGMy1ufZlrO2gIkAEKDpkiAezSp/JrU1Aee1UB3OMPQ4VW249V0z4JWowylTwTAwetZdiT40fVd1qeet/7XCTtzjdyI2TFjqDeAeIm5iQWS+/QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777084817; c=relaxed/simple;
	bh=0zG9v0EvOTLyU2XXyny9TLXijcM7ckMQfJMIOG/UcvQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IlnBsBpnLBkivFo2hXRqnS8W8kq/lWW0TxSe8bnagvJU4lTluLs5pJROtcsOYbLJKjCOXZLvellP6GAYxBG84soWZB2rRJnFoxA7IzVy/0J7PaJNeIOb5EJPWtHkzlpEnjbMrKJS832+p9y3hGpb+HD5y10WvlpiwbPDUXRFVA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pKKFvlzr; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pKKFvlzr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+kgvrMoD7Dg+RsqzCiLRsDw0JN3OlJT8PsXC63FCHnSbBrfHpC22+LW97vs89ngKZt5RQMArvszcXncy04a6aBH9p3DauvGBk6VLxxJ1AIB86GE4gNU8XI5ahoSKdmvMR7F8Vkbu3xy/swbyKxKtKuKbM8PxzNI6RSxyq6KPNZbMLO4OpFaF3YpVdXCDwvJP701RiuUm8dSWLu1HciUlbzVlIAi8tkoTvWBQ1q18v3d6ZURftrOaHXcbeaVwhgfkSPzG9tWc5Xb7cF4ItD2Y83KNthF9BMeQEsaivqxFvuFaGgqSVWyh+Tv/T3czP7a8OEjKwATeTrtQVZ7fx04cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1QOgcTJXNsPYmgf1Jxr73Lv18N1eV//aya88DJL760=;
 b=rKCrTPLSBJMjBrx1KKp4fQCQAMqs2LdxrQDCWxpqkBdQj9eH7J19URbOC5JJHb4pkoFQEDMLwdfECmPIzYKk6ZCJyTdE5Gbsr6wxfrSAt7I6ttz8ArvuxZ7prGtZgHfnUGqsu2Vqp9z2rH8Z+PSqk+VxgmCwYwNTKDdY4undAITNyBgy0wqJcGqtHPNiRd+Si+kgCSbiH5J5mlg9PJ8od21oIbuNb84eeendsSqaAp5l+OoqWV9/0BqT66s1+uTUhRP6DPfLgwk3X74vtlx6vXp2uhhwKJXNNssufbJX9Wl8C4LxO/P8SjmaUcNb0MTwGMdJ70DGZpqx8beuJWoFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1QOgcTJXNsPYmgf1Jxr73Lv18N1eV//aya88DJL760=;
 b=pKKFvlzrPRl+nRHVIL/HKjchDwI+cH0sNUvUiyzoxKN+jn1+ZXzLf91C+3jdm2yRvYumUn6D7Nyf2++6YwY7F1/tzv67kV2rHcw2I11f10ZsTcrYMsLY4VfddbK9jsuHJr3rpggl/Zua3gJOqO7xhEM1MFdvX69Em1dHwItnBlBJjszFH92jtmvYnHjBs2PdOaK7E95HqzJrtRaGp2mytcx9NSo+6ukhehGQ792/v/wVHkul0sPWbNXPipOM0hiGfQVxb6oEqBL3+djmmuOCVAyk+jiR7WgEnX06LRvLKGc30XV/a8Dv9voA+5h+mKZq8E8CH6QRGgnjY23+h1tKUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 02:40:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 02:40:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Apr 2026 11:40:07 +0900
Message-Id: <DI1VZM4BO6GI.EKJ63AKOUGX0@nvidia.com>
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
Subject: Re: [PATCH v2 4/5] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-4-2fe54963af8b@nvidia.com>
 <DHYQGLYYXEN6.11Q3FQGZMWCJ6@nvidia.com>
 <DHYWJ32M02N4.2954OSJXFGD1G@nvidia.com>
 <DHZMHF1YVBI4.F11YKDDKBNTQ@nvidia.com>
 <DI06KFG7C6P7.1NR2L62JY2RSF@nvidia.com>
In-Reply-To: <DI06KFG7C6P7.1NR2L62JY2RSF@nvidia.com>
X-ClientProxiedBy: OSAPR01CA0228.jpnprd01.prod.outlook.com
 (2603:1096:604:28::24) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3babfeed-0bc1-403d-f3b5-08dea273f999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YIDcxkdo1PJS6JQzbPatf1q9BEfo/UOpZMHJjq/6kze8UgDAIzvgH+bJQ0IQF/N4NJ+JXtlEQFFN9b4hcO+uvhs/10G8JTno9ztd+aw0DgN+e4FnLC4H9pHhRVbypwla0f4wHjbtFrD3+PeZPTV9SgmF3xOHp42LkL5ltoYi01e45ka70YIeU8MVT9jL4fzlKNBpgOobPfZfWyw/sldAm/RhsyfDPT53GSgrVBPoiANBqF8Xc0xHhRHmNycX6LhtFHf0UW1KLHK66rOYqTthsMF17w4PvYV3dFIv+2qnJMPMz1CtmyQ6xFRwaSHEe265spfocMgqu2qrWu7Eas7dZNvG8XwAp9h3Ry4uScr8eXWZt+RFXViFikAFEksQ3j4C+6q1NMVeI26gZy2LkKwEzhc3rUp5pwNhr8Zsgt/Hz7T5zTIGaRjzG+WubXehkDtpa32hAQTUboA6FCVrZs3nN0GX2jUZEJUkjesZKIvqExcqXM+bK3PHenlJ7bqSxFp1OlQQg1XAbsHBqaV9kG0JLlBQ1WUnahRV9ru+vr+OMv2GaL3KN9tnCRMuk3DzzZEymMs/JkqA/8eaGMQOk4wGwcDYZUkxuXVogmAKRqfG+P2YsY7dbtTUmx7RLpZOBTS5drHSpdzD7Lx/RAin6fKBCA9mGZnzn0xyvM6SlVRpTw3dostrF6+TYHq1dvA/f3t25MoDVs+6h8OLpd1x9S7OHvJ3+XxVR3PRG5mBHU8yS44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1B6QmN6OVN4bDRMQ3lrSEZaeU90NjNnc09kaWZScUR4Y05DZG9udS94NWg5?=
 =?utf-8?B?c0xlU0NpWkJ4cExSNmErSW1TWTdyQVdIeVIxSlgxRWgwZnBlazIzK2VERzNo?=
 =?utf-8?B?dGhiVXE2OWNUMDgvdUs3czFqUlMwUHJ3Y0poaUZDNFhOWW1rR1hjRXlSMm9w?=
 =?utf-8?B?SmtKUUFVL0Fjd2ZJWU4zVU4rcWxUMkJWcmNCL1lEREZGbEZvdXBqWDRFbGFN?=
 =?utf-8?B?TnUrd0YrZlpSaVpYSFZiQTRQY0EwdDJTMmlwRnhYbnNyU1ZkcThNdmxiS2Nk?=
 =?utf-8?B?VnVpQzBHWUZ0dXVXamk3WnN4MS9XYjFTNUt6cVZJcVhuRUpLTll6dXJMR0wr?=
 =?utf-8?B?MlBZNzdXd0lpVUxmQXpBNWRxSUJRUG53MEsybnpTYUR3NHVQc094Q0V1Ukhh?=
 =?utf-8?B?ektUMVlqR0NvRlFmQnUvdVFwUGZSbEFvcHhmVjdLMmFCak8xYjA0cE5CTkRO?=
 =?utf-8?B?U2RqWGl2dURoclVQQklGdnhXRjlFMWtwamdkdG9va3pOY2RWaHRxMlhlWmZT?=
 =?utf-8?B?bkY4MDluN0Q1RDQ3QUxzNlJiK2dieVR3VjhVOEZYVkxTaHlndkNXdGJSRnNS?=
 =?utf-8?B?UUgyMmczRUpkMmhwNTVEanBCdnFHV1JZaWNzWFRHQlBwaVNpYit4Z2o5aEcy?=
 =?utf-8?B?bHpId2xTTEVSUGh2TWpKdDZpNXJQcjQwYk1PZGJjQmR4cnpVekxFN3g5N2Rl?=
 =?utf-8?B?djVadTEyV2I0c0k0RkdZU3ZSczFnYnpTWHluOUFZbHlRQVkwaG1zUTExbUg5?=
 =?utf-8?B?MEJZVjlITWV5MWc0TDM5NnJyK1FpSTd5ZWNDcllDYzhtYnpRTnl1UkhaRlNX?=
 =?utf-8?B?aDRGdkFQN3B0RXEzTmxScVJzMUIza3dsZHJidjNhRFdKUm94djRwc0N5Uktz?=
 =?utf-8?B?L2pLSmdidHNBQXFTMTdtbXQ2d3F2anhRbDIrUUs3OFY1dTZPRlBCd3BGNkpJ?=
 =?utf-8?B?MFhadWZvRUZCakNkdDNKbUdGUXNscm5ITFNWNWlROXVacWdiQmJNRVBsUk9x?=
 =?utf-8?B?dkRMc1N5UlV5b1lxVTBaR1NVN2lQZ0QvVkJ2Q3lFOGtpaU1VcFZRSHNJaEla?=
 =?utf-8?B?VUswY0xTSThIK1pYeWppUlRYWlFDZEJ3cG5YYnprZ3d3RGdxcis0RVZDRUVJ?=
 =?utf-8?B?U3ByS0Y5dXdSektNTVQrNnlIcUtQNDVGdzZrdzRSc0pUYlEyTEx0T3pjdzNN?=
 =?utf-8?B?WUovTEIydkxja0pFREo0V3poM1c1cTR2WVRvRUl5blhsUmVSVno4a1BlMkFq?=
 =?utf-8?B?WmtvY3l5V3NJT1pKbVpxcjQ2MTlKSXY0ZlBWSFpXeVNKWFJHcWlHR2ZKWGRB?=
 =?utf-8?B?S1VXZHNMekxwZ1lvbGt5MGFRZVJDZjBXU3RFMEp6MWZBNWk3K3I0emIrT01G?=
 =?utf-8?B?c0c3Q3NlNytOTmt4U1ZmeEdsYTRnTXYrYWtSY2VUbENwSU9CN2xXcWxMU0da?=
 =?utf-8?B?cWtBTGJ5bWNCVkxPaVhwNHZwTE9YaTdNNHhIU0Y1QjJOdTByenZveXU3VHc4?=
 =?utf-8?B?SGFMbGtINC9COGhGNytZay9WMEFoVkdjVWRDV3VHTkZYNXU2Qkk4RFNJK0Iz?=
 =?utf-8?B?blNBcjVydTdRWCtZWThDdWp3anF2YitUT0x4d3RZelFlOHE2bU1xTzNwK2JC?=
 =?utf-8?B?U0MwRi9yRE5PbFUwcGVMK09JcnpyK0k2bmk5Y1VCbmJjb3NIT2w5TXRsZWZ1?=
 =?utf-8?B?eCtpZHJQQVdNb2pUUU9VcjFJVmlQM3pvUElSWVBIdzAyOGxVT0NCN0FXWlRy?=
 =?utf-8?B?MXNSbXB3aC9XcTFXdUxidk12Z25mZFl0cS9QZE5CMkR4QVZBclhjTThrU0Nw?=
 =?utf-8?B?U0lwVkx2bXNRbFhxYy9rMUlvWStxRkt3MDUyMkdXckRhY1U1VURvYkZ6YXNB?=
 =?utf-8?B?Zjk2MktwT0hEamFndjYrUi8xOEM5amNDRzlGOW8wSHoxbU1YbTJodnV1MWRz?=
 =?utf-8?B?MWJlZHdBZ1Q4RHArcHhackRNL2tkWitibWM2WjdLZzB0WUtVMng1RlBaTy9n?=
 =?utf-8?B?M2JtZVJZbzV4TDRBRUlWN2FDRFY2cFpGQnVJTk1ldE9od2VKK0Y0QnNiVkQw?=
 =?utf-8?B?dFVZc0R6ejNyeDg0b2J2emJjSFk3OXgxZy9GOXRRc3BieTZ5dkFWTmNBZjlH?=
 =?utf-8?B?L1g2VHJzZHVmYjVtbXJuMHZ0dWNlcGpSSmh2cDZuRXRtbUVsb3EzS09MZU1P?=
 =?utf-8?B?NlJjZ3Z6SE55eE5Mc0pJYjdxZHpqUHRoR25ONnpsaVpXa21jdFoxTlJEYm9I?=
 =?utf-8?B?UWFvSVNGNHBOU2dDRXZJSDlNRzVOSFdiYUV6RTNaVlo4QW5Qc0xvNjFBVUg0?=
 =?utf-8?B?THUrQlNOeS9oRDY4QU44Q2JCK0YwRWlhTzBVblc3Y2xybWJKSnJZR1gvcHVw?=
 =?utf-8?Q?XCpuz/QkIYi+tWl9wfXnbM70zkg864ORjlkvnNR/n/PMK?=
X-MS-Exchange-AntiSpam-MessageData-1: krPgZ53GtSJfWg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3babfeed-0bc1-403d-f3b5-08dea273f999
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 02:40:12.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaSN5ir4aql0hkY6OCUaludojrk0fZF8IiSHa3FVo8nPxs8vKjCN2z6HWq4pxwXDCO+VUwBTAHx+qBSJUEq40Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774

On Thu Apr 23, 2026 at 11:32 AM JST, Eliot Courtney wrote:
> On Wed Apr 22, 2026 at 7:47 PM JST, Alexandre Courbot wrote:
>> On Tue Apr 21, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
>> <snip>
>>>>> +        dev_dbg!(dev, "GSP shut down\n");
>>>>> +
>>>>> +        Ok(())
>>>>> +    }
>>>>>  }
>>>>> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova=
-core/gsp/commands.rs
>>>>> index c80df421702c..fb94460c451e 100644
>>>>> --- a/drivers/gpu/nova-core/gsp/commands.rs
>>>>> +++ b/drivers/gpu/nova-core/gsp/commands.rs
>>>>> @@ -237,3 +237,39 @@ pub(crate) fn gpu_name(&self) -> core::result::R=
esult<&str, GpuNameError> {
>>>>>  pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGsp=
StaticInfoReply> {
>>>>>      cmdq.send_command(bar, GetGspStaticInfo)
>>>>>  }
>>>>> +
>>>>> +pub(crate) struct UnloadingGuestDriver {
>>>>> +    suspend: bool,
>>>>> +}
>>>>
>>>> This feels like it only makes sense to call from within the gsp module=
,
>>>> so I wonder if it can be pub(super) (prolly a few others in this file
>>>> could be too, ofc not relevant for this series).
>>>
>>> I'll review that, we do want to limit visibility as much as possible.
>>
>> Mmm looking more closely I am not sure this is something we want/can do.
>> As the driver expands, it looks likely that some of these types will be
>> used outside of the `gsp` module - in particular some of the responses
>> can be used outside, I think this actually happens with the MM series.
>>
>> So I think I will keep the visibility as-is for now.
>
> I think some will be used outside yeah. For UnloadingGuestDriver do you
> reckon it makes sense for it to be called outside of the gsp module? It
> looks like it should only happen on unload and needs to be a part of a
> bunch of other tear down code to work.

Agreed, this one can be `pub(super)`.
