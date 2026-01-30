Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C536A006;
	Fri, 30 Jan 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769583; cv=fail; b=RR3iflgK5L7fkizrmDcq62CyCj+ZymphyI3XNnNJuxCjsWbD18BEXvsVe3raBRuIIn8O/jfHH9QpznxTk6ZXgV+GjXl8ysFIkBJPelJUp7/X5nq2/OM1YlveqGR4oqub1drfPWFKgYaFDy7rPBspu3en7zr3IcTHFPpKBAIJcvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769583; c=relaxed/simple;
	bh=9XoNUypoHmFFt8FzkYvraGfPcI4qq3DL/9yF5vtSVn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=swas9RSjBuNzvtJwTbNUi7OUKeAhDN7d3NlQGYliGn3Z4KNftkx7n1tiuKevkQdbPO5lTyFjJYVQgKyBObKzzIvfG/VbZApqFUKfDHiZQqJqV/KBWMo6sL2vQBFKKCV4oMwXQSJJgA4UEwjyoVkmSdkT3O7uj+nnFMewj19SijU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r4v0OL7K; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r4v0OL7K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvHpr6Gtrkh2iVwLHkqUObbx/FChZCX5vZZLiFZyd+aZHHOq4nFrcx0RqbypqNi6x66yhYBI9QrfUkpFpdhj3zTs3za6PooXHhUhXg75Z4vjHQWiIFeXXSi1Y2YRRVbk7XJCL2Jwp6U2LRlIznpj4zw+Yu2x/o7QQKHuupzHaXp0HwQBJzpUoHTu9ZaZ/k7uQ1oMVWCw6HnPpvTkE5EfBI4bg8rBuO6WXLoxN5WJJValUKmbNvqGHa+OMDkeTOsR+GQUMdjT7RsjSKeUt/FIIa88jLgIV8QCNPFlHD0t/P3vYKy2jvH5A7+oHDaclr7KAfuTsUErlQDputp0MX/snQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f2k0eUAJ+WoGxxEj3ix45FmghNCjAFAgS30jb3Da7w=;
 b=cR9S7RowSus/yg7xlRoEGSzS7mpEltLrxGGlWOVCqLVWSrSB8wOOvVEp8N+fDICforFHHlwiJoGxox35efqLGaipwSYlV5Hre0HondJNkltoszNzXqkyW/gyslhgCjLanPSPiExccrwF+qLFh6S6ix/4jk8gY18GB9mwMi6EActIXfHmBrHUIzEIhItALvLpoMBtRiLwC+0xhGRTA9UknSKWBalLaj751rmyyJsmooOYFpj5iFoS8YHuis8EzNdQ0gGOrnsySwtf6efWp9Tfc4CUkGzYl6Emkg9exe7+ZkvVW4yYVkLzLqRgpo2dq0eMG70KYFJZFrK++Z1mUTIYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f2k0eUAJ+WoGxxEj3ix45FmghNCjAFAgS30jb3Da7w=;
 b=r4v0OL7KDMalAG81TVPNutG7q4zKMhgiyQKIaq+b3uWCjNl42mEYzbjxTqBk54H6PQXmKlnfbaJUPi4Ns8BBVrq/QZk+gaRJ7FK1O97cuS0HhrkFnTJVmYdhkS+qUHOBNFAOqErcxl/yLvfhj68f/l00s9jfJTwa+9S7jmaqBoM=
Received: from CH2PR18CA0059.namprd18.prod.outlook.com (2603:10b6:610:55::39)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 10:39:39 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::bc) by CH2PR18CA0059.outlook.office365.com
 (2603:10b6:610:55::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.12 via Frontend Transport; Fri,
 30 Jan 2026 10:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 10:39:37 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 04:39:31 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 04:39:31 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 04:39:31 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UAdRss1577884;
	Fri, 30 Jan 2026 04:39:27 -0600
Message-ID: <8202cb0f-3d04-449e-ac37-181afbb35fa1@ti.com>
Date: Fri, 30 Jan 2026 16:09:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
To: Niklas Cassel <cassel@kernel.org>
CC: Koichiro Den <den@valinux.co.jp>, <linux-pci@vger.kernel.org>,
	<jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<Zhiqiang.Hou@nxp.com>, <gustavo.pimentel@synopsys.com>,
	<linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com> <aXtrW7viGZfMNZur@ryzen>
 <4c71700d-e4a5-496b-825e-01f346f73949@ti.com> <aXx_oaBxCmAXAZQt@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aXx_oaBxCmAXAZQt@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SJ0PR10MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2ae216-e1c6-4621-b4cb-08de5febde12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUNDakFqTDJKci81RlFKUkd6MjdFMVhCNk1qVTg1UTNCNWtncHFMaEJQT3By?=
 =?utf-8?B?aU11dHpUODJUeGN3SjBTYXVBWmM5cHdTS25iRkxhRGRZSHVkTFpjclpIaS9x?=
 =?utf-8?B?bVZoMHFNWkdaNUM2Wlh3WldudlJqblNjNmtkRkJ6MU1CNXNYUGtWeDlBYWZH?=
 =?utf-8?B?NC9wOVk4MnN6OC8wczVKTnN4c2QwYkZmamkxRmo0aGtzM2hJajhtRVFseDdC?=
 =?utf-8?B?cFkzZ0tqTTh6R1N4dThka2dRaW1QdjJXd1MvM1RpYngzc0l2bW9YSCsyL0pZ?=
 =?utf-8?B?MDVKK0doZldjelIvTFdGQ0lFKzhzcm5aWmRRS1I1MVdTaUpIQkYrVlhUS0VH?=
 =?utf-8?B?aVhNcWQrVVUydngveFZzYnhOWXBGUzJuU3RVV0hZOFVHdTdsdkd2Q2hoTW02?=
 =?utf-8?B?Q2dxWFNLeS80RlZsT2hmYzFtYldkZVVGMXlaTTZJSFhlUWNpS2d1N1BlaVBE?=
 =?utf-8?B?MVdaWUV0T20xM3g0Zk1Wdk1PTzg0eWsyRXV1NFZTdmhnaXVXVVgwdHJER0VO?=
 =?utf-8?B?aHhjOEtFenFtYk1heWdFTytmL2RJU0U5MTY5ZjBOVlFYQTlpZjJ0MTFQTVFm?=
 =?utf-8?B?ZElvOHpIRmdMb01LZU1LNDVCV3llNFB0a1lLUGVZdlVDdGx3NkxiajdQRGZY?=
 =?utf-8?B?Y3MzZ1dVN0IySXZIVWdYTkVydzcvNVJrRURwQVpmMDAxcjlhdGFRMjhKOFcy?=
 =?utf-8?B?MW0rU010ZUF6ZVVuNDkxeGdBV2ZWTklnNldTMkMwVVpITnZid1QyZ011RW5F?=
 =?utf-8?B?Mnl0UzNyUUVoZ29JNnRMQlFkOHJheUd3WGdkWkcwR25mWVdhSjdvM0VJZHFh?=
 =?utf-8?B?ZkRvN1I3OVBwbll6RFVxR244U1U0Rkl2aUVGSXdDWU96ZTB0Z3VjbjNoUVo4?=
 =?utf-8?B?NzhYWEpEMHV3bGhEN2ZwZitrRlBSTDlmYVBFSWZMS0x0S2MyT3RMNWk4QTNI?=
 =?utf-8?B?U05ZZXgzb0lsS1VES25KaEQwWmlETDBMaFNZZ2lEMndhdCtrMllNTW5kL0J0?=
 =?utf-8?B?cmZtL3ZlVHBsK3ZNbTdxQmlZeExJb1U2c3FEMHpMcEVmWDdmNHZCRWtKZWdI?=
 =?utf-8?B?bXpIUm81T0R5NnFvblNjRlNUY0l0MDJYbExmNmtFYyt0eDVvcWR1T1JNNmVz?=
 =?utf-8?B?Q2VhdWR6NFV3eEF4UHlteTgxL2xvK25IbzNXeHlkZnBBWFV3THFDRTErejNz?=
 =?utf-8?B?RGtLWlIyekdUOFhMTVhQb3RZdFRyQlIxMTFMNGlObnZMZzRkc0ZRakd6REhy?=
 =?utf-8?B?UlpFOWlRR285TTVGYkg3WVNWWXh5bGZMVVFaWnh6ZkJCYmw1NWY3ZUxoM2VT?=
 =?utf-8?B?OXM3MWRoMkxUQTNad3lVOHYxK0diSlNIakZHQnNSNUZoM1ZHbnFVeEZHTlNN?=
 =?utf-8?B?bUw0eFdWN3FzaWhSb2k2d01GdkRkNStsZWNhbnY4OHJXdVJpQ2hlRkNkYTNR?=
 =?utf-8?B?WTc1UDNhdmtPNmRka3ZGOWNjNWFYcmRzbFRKZkw0VXRocTVPMWNUSnJwSWdt?=
 =?utf-8?B?Q2g4TEhiTG4zU2RjK1MwWGRxL3N3UHB6aHpnR3JpZWt5UitXSGFoSG9kWmNq?=
 =?utf-8?B?QW5xbTFFRGt6MGozeDNJek5TaFRScVRFRURWMVJkSnY3TSs0b3NRMkxVYXNJ?=
 =?utf-8?B?UzNSNUxKTkhYMnFUbmdzNkxyY05vVTNTSFJwcWQ5bDJYN2xiL3VKdHBkQlFG?=
 =?utf-8?B?WHAwR1NLVlBHbEduOUUwVTI5WEhKeXIwNFVrQ2VJamVocFRLbFRBdHQ0ZDRN?=
 =?utf-8?B?QWsrYmtmdXhMd3UvNU9DTFlPUnowZy9zVTVrbVVaekdJSUQ5NzZxTmtrdVNP?=
 =?utf-8?B?dXQxK015V1hRQW5LQThHTkFWWjNBOC9uQnpnYUlMWXdJYXBRbzJNWDEzc2xV?=
 =?utf-8?B?Z0ZuNU5Fc2g5RVhmSGwyY0pWR2hlOVJoNWRrNXZFb2xIQU9wTVpkeHFFNmti?=
 =?utf-8?B?WWErRmMzQTN4c28zODRGcmUzdDZjbmNWMzRPYVdVRGV1MmJWcXovYndCWHQr?=
 =?utf-8?B?ZlZmVGNoWTNTeWkvQ3gxY2JqMUhiODFUbmVKTk05bGVsTEVLM3grOGE3eXVJ?=
 =?utf-8?B?eHBoZmtlWVVUQUNZaXhqQXNBM0k0cTFRRnVMQ0FtMGVUV2NKMXpka1Y4c1Yv?=
 =?utf-8?B?Q0NKR0pVcFBrKzFuaUhLZDA1Rm5VYmFjYmtyQkVDUmp1SjBFbmp0WFVNQnB1?=
 =?utf-8?B?bm9nc1Erc2VHMlE3Q1BlbUpDOVUzTEhINTdCVm9jVjVPSEpyN0lIT0JpTVNZ?=
 =?utf-8?B?TDNCZG40SytVWTRURzJZNHRpMzlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L6XEk/P2h8llab9mBYP6BCF8AvdCvEMgz6XEqsAaZAVq8g6XyJT4C0hZqYAo62pQIBqvJP9E+z92By9zAMsUpHhWgbqgaQema8ekU3WONh64ql/F6EYLg210QVENYFje9Q2mI4TZ8OT11VosGgwSyWIMvTRajsdsl35jc0q6uqxt6jB+Oodj+EzYNkpxqbH7a6HQgAAd+VrIY7mdLCFhjaiR8Q0dYJbQqijoh9RyEhZiiS2hkbRcxwBHvqyaPblUL6+F73MnywMsT6FQARDQNhuf7wltYRVGif+qly3htEWDtphSFOmODCpJgaVv5ju/0TFxrk8oClpEQdWd5mxhuSrpnS2CdsudKxCoBBxwsDcm/gVm2J7B5vrgaVu5Z+WmV5zjR4R+Sjzt0m45YyO1tHcwQV8FqIj25c1GQlFAhL5Or028sJQessazaR0bj/R1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 10:39:37.9775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2ae216-e1c6-4621-b4cb-08de5febde12
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654



On 30/01/26 15:23, Niklas Cassel wrote:
> On Fri, Jan 30, 2026 at 09:42:43AM +0530, Aksh Garg wrote:
>> On 29/01/26 19:44, Niklas Cassel wrote:
>> > On Thu, Jan 29, 2026 at 02:47:52PM +0530, Aksh Garg wrote:
>> > > -static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
>> > > +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
>> > >  {
>> > > +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>> > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> > >  	struct device *dev = pci->dev;
>> > >  	unsigned int i, num;
>> > > @@ -152,18 +157,18 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
>> > >  	u32 *indexes;
>> > 
>> > Hello Aksh,
>> > 
>> > Considering that all other functions that you have modified, you have added a:
>> > 
>> > if (!ep_func)
>> > 	return;
>> > 
>> > 
>> > I think you should do the same to this function.
>> > 
>> 
>> I omitted this NULL check here because all the current call sites of
>> dw_pcie_ep_clear_ib_maps() already perform this validation. I felt
>> adding it here would add redundancy in the code.
> 
> Ok, but with that logic, shouldn't we also remove the NULL checks from
> dw_pcie_ep_ib_atu_bar() and dw_pcie_ep_ib_atu_addr(), because they are
> only called from dw_pcie_ep_set_bar(), which already has the ep_func
> NULL check?
> 

Yes, that's correct. Alternatively, we can add the NULL check in
dw_pcie_ep_clear_ib_maps() as well, making all the functions using
ep_func self-contained and defensive, removing the dependency on whether
the callers perform NULL checks. This makes the code more future proof,
as new callers won't need to be aware of the NULL pointer possibility.

Please provide your views on this approach.

> 
> Kind regards,
> Niklas
> 

