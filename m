Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023114.outbound.protection.outlook.com [40.107.162.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893293403FA;
	Tue, 11 Aug 2026 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477445; cv=fail; b=WReoYleATv7Pq+ge9VYbXrOjnFnUgKUD8HDQSad8syym9ZNK3pHZLpFmPSyAiH0OrT2R07u3c5X0qELaS0ZXUl+iF8cd1uv4CeydZHKYbdsFsHbZuvqCsxocTV+a6DkEakqXJPs6oxQJqO1NCfXmTVONie0CHiAoSed1lE02bTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477445; c=relaxed/simple;
	bh=2FD1D4pmunTZUZc7/XPWbmJJz0fvUPya7KIRLwuAlio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mpmBp9AWhHkpheqWLkz7RfAsG41Tu8wNCA7UWd0xsol1vH2po0fhQKmAYE8u08PxyWHoq9WIahQ18X16x+IcX8LwXFfm2U5kqFGULDXGi6WAZqvR//iIhMcemb+KWN547fl0GMhrCKdm2uGWAi3P3FaqTHL+BJPgcMxaSuPS2z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=qmBf5FD9; arc=fail smtp.client-ip=40.107.162.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="qmBf5FD9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yECU/sB+oG7N4NUS277OWHxoAgAGWFpeDolKYIH+o0tZMqwhmmk/zPOQe9/f048q245NBTVHJIq6i19DG5qBCcfOqoD19KFwonjpxudjhImLzeXd/ok4Xta3AQXuFiPS/BsL4zfzIL3LaN4tpNVY2VLjYTGwtqIa47HYUipu3p70mkBwYwnqp/NEZRkX0ZzDa+q51X8IzafP6w1+cH6lZxXw8Q3jbHp5mZoRzsZ/qVxv2OYX1RsIZ03h61CNEuXr7xF/vM4SsMi57Cwxjmc+Xh6VLV3kBLqjiqGlY0Zr6ei8mUFaCB1XLiRYpyEV+vJSy2LyO0gQSbV9qhzVh/iXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNFkO+x0mjF4mAfDJy/FdbQ6Cn0lxAaHjOtiBN9eQY4=;
 b=DLmjXjUBNJqvaMTraEawPLYyHMqgb/Px5CXgpAwOGC6DqPQEp2FseD3voLlxMUcMfd0zqiGYTQb790ufCK+zKcSEcPQm/N89SK4XE3BEbdgbFESs82RSczUFXDFyS71NMvc8DW5zcueTehpEaTvfX7ZLArKhSCUAdeiYoPL5nfnzPoPgcbCtu9RobEl29UZ1wApRRx6/0MmnZgwuAISlwg+AJB2EuzQiBm7xgdciK2uPQVnp2/E4y4P9ne2f84CM2ELXHa7gSzJHnSXr9dE4KouWvHjY6NaA3VGGvAZQlvvg0YGcddzieD6bwcy4wG9h9EZLYevCa5FHHNnS9HYWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNFkO+x0mjF4mAfDJy/FdbQ6Cn0lxAaHjOtiBN9eQY4=;
 b=qmBf5FD95vB+GbyYjVxvCHkFDDoYQmYCGmutJaCZn2GcV+pKcD+9xgVkw0zjg2i3Q7J9b7kNcRTIqy6Y3KaplFR0P0/3b4CWX9PIh7zILt072IQ/Wlfs+sKWh6172U6EHTP2eEJE34fS5s5HdDW7+uU7+z0jjYIg6tYlXWv22sNQ2uQJeIKehUzPAdvljErFYft87huf641JJLR4A5RSbOIAsiKttsI6ev+t3rmYtuqPbWFbs2ML3aIgKJnmbmq5tW2o0lmAEVvJ8tvQp6IuQ1PqJeDS3EIbGQjHqUqkoorhHHDm7wvnp0La5U/+FmdRxx5U6wNKIsuTIES7a5IdGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by PAWPR08MB9891.eurprd08.prod.outlook.com (2603:10a6:102:33b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 19:43:56 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0315.012; Tue, 11 Aug 2026
 19:43:56 +0000
Message-ID: <8e235c79-9b16-4f06-ba46-da7f28a2804a@genexis.eu>
Date: Tue, 11 Aug 2026 21:43:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support +
 clock
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <CAGXv+5HrDw8GWb9zp1AaQU9UW+0FGcr7jOV2jt_zi_2KgfgBqA@mail.gmail.com>
 <20260807152059.GA39821@bhelgaas>
 <CAGXv+5GNvV0yfX2v7E9HxvFpm0xwhGMQLjec=_xV_6YipXFcbw@mail.gmail.com>
 <CA+_ehUxa6U+0FEFuptJXQZ0kwbthYjshZftx32CmwkisAyo=+A@mail.gmail.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <CA+_ehUxa6U+0FEFuptJXQZ0kwbthYjshZftx32CmwkisAyo=+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0075.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::9) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|PAWPR08MB9891:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b151501-2933-47f3-b41d-08def7e0e160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	7BYloVijwKGKvQCAlTJW3JvY7iVsWDJb7nFRiEduo5BLB47iSAmsYX5wqdVLxwaqp9bi6mlqn0lg5ay6CSw7HVzwNVKEI0XyyRq5zgneXivd78QQJSQsr9s+rLZz2HNWknBZHGUvlOEcVntm/pB0rriQ7Q5Xj3Gd248ARCMFIkIVlMmwAbBwj1C60ysIsNYO7VAtnBiIDxAlvONhQuD2Y+/JSIrv3BbG/bfcng+qhLoiByYpNCWDRyr2IIWfRAkFJq1YHXz33Igj/U8qG7bPoSf+5CJlDGNNlHGrj8np8hDvVgl0XN9NiX/h0IHtmUuVuqktFHThp2JjTmEJXasbiFuX3ORHzD2IoCjvBkkBLEzMW54DXBz+hJQ8MYsjuFD06yF1QcBhZ2xObplyIlw4wXAlaHenM0b27YN8kxfaEUCXfiCknL78T/D2BV7A6V97QuijxGcsv7qT+orbUWyN0bMCjrwldqFPkxFNY/f5UencA30XsSJDlXxEK7gILKQFYFCeh9M36NZY4EU3UjAH/N9a4NuZIyHfv5pLjMO2r4JmGS26/+Jkqe+xFE8nSzwEwqh2atTT9RkctBk19wE2Yb/BKyQCrz/BhNGI8+IxktzZKAmYKCMbbBxL1LG5W/choYaxheTZ3JCfTQ7EMGznX4p2lCz8VMaLxqVxN6+3lmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGdDWCt2U2lmR3pGeW5aeTFjbU5lUXg0Rk5RbDhtaHNFSXV4aFpsWlVCY0Ew?=
 =?utf-8?B?YmlpWmtxNXZ6TW8xODlxZWJvVlVFRUQySysvdENPQlZMNkVrZWMxRW9aQ0N1?=
 =?utf-8?B?YVZDeHM1cUhGcmE3dG44NjJBQnBqL2I4YWJxNkVUUHlZaVo3ZWJodGVEaEcz?=
 =?utf-8?B?UUwrcjRaWXZjVkxDK1h2R01qbnpRSUpmRHpXSmRMWGw5WFFZNVpzcSt6a1pK?=
 =?utf-8?B?L1J6dUtETFl6MlN6a3cvR0djNDdIcTVNcWovNk1MOW1NbHFEZDNMZHU5ckhC?=
 =?utf-8?B?SjRocVpZNFJRZzBaZlpLQkVWSE8zOGRXSno1SUhUYVJZUU8xYzg4M0JJMzlv?=
 =?utf-8?B?TCsrOGJxdWMvRFMzZDNNN3BiR3BjZ1VtNmNJaTE5WmcxSStCL1dtM0J5NHFi?=
 =?utf-8?B?NGVYSSs4ZitLK1k2WXR6SWRaUEQ1b001dWpEQVZWVzJ3VUIvbVNzNFE4L1Fa?=
 =?utf-8?B?OE9uMkZDMGNTaUw4b0dGSnM3cFM3TytNdkhIVGFFODczQXEyNVBGTWFtMUMw?=
 =?utf-8?B?R2VzZ3JGOXkrYUxJa0ROY2FpU3dUdU1oZ3pCV3lEYW8zR1BrYmRNTFpOUVpq?=
 =?utf-8?B?OGNYY2s4NVVodzVmVGhNcUR5YjhDL2ZaTThrcTAvVmNySWoxSFJqN2NmMzlC?=
 =?utf-8?B?ZnY4OXVzRU82SlZPSlVjN09JNFJaSVYrV1k1WGx5MDFuOEd4VisyYzlHRm1a?=
 =?utf-8?B?R0J5OVdWRGc0VGp5UGQ4bkd1WEJqbld0by81TVdUZXhNS3pxSFFxdmVUb1Q4?=
 =?utf-8?B?M1dSQ1ZhRVgwVk9PcEY2a2NoVXNpZWlKV1JWRDdGb0swR0xkZ051OUFwWm44?=
 =?utf-8?B?dVpXSWxod3ZHRHRkNy9sRkpraUFCQlhSK0c3NFRsQ09FSlhKTEh4N04wMlBr?=
 =?utf-8?B?UVBDWFFZSDlMUmY2UE5KVUlxWUJtWUxWNE1uV0R4N00wZWF4Q1pmVmVDSDYy?=
 =?utf-8?B?QXplRHVLL1N0Ym9kY1JyR0NRREZXZVh1RXhtSkZLWXNsNmtZeXQ3MHVaR014?=
 =?utf-8?B?WVBFSE84Vys4WFRVWHNLenk3TnEwMkQvVkFtL2k3SDlUZEJEam9NaUo0RmhH?=
 =?utf-8?B?WXZ5dU1HbEVYdXdRS04vQ1krcm0zdWxCQzFsSXJoWElCTEVRSm5hNVhJbThj?=
 =?utf-8?B?VXZXUGVxVVdIbWhNb1VrcSs2bE5UeU1MVVdaaUw2OVVFaFlsRXkvOFptL3ox?=
 =?utf-8?B?SmJVYXNoeHNVZTY3ejZwcEt6MUF4dUZxN3RLd1pJeDlpbXpTWTJIYkJ0TDh6?=
 =?utf-8?B?L1VMekdjSEliRFJwK2Irb0dKeVpuak15T2xuOUI1dTdFSnVFd0c1RGd3MGd6?=
 =?utf-8?B?aVRzTGlQWDFHVUZ1V0lHQUNYMjdEL0tCakM4ZUc0VUJjTFVoMnRjWDJ1dHBv?=
 =?utf-8?B?bzlYQlMwRElKWjBKRkZ4T0ZlRXVzV1JxR3d6cUR0UGhPTTZxM1pVUkErcVdo?=
 =?utf-8?B?ZCtxdDJYb1NCWDUyS2Y2VjFabDVUS2ZaZCtvL25IMWxxUUY5YWhjdVp6SHZk?=
 =?utf-8?B?TzBkM2Y1Qy9xaWlTM05SbkcwYlk1RTh4Smh0R2Z4WURmUW9sUUV3Y09VNkc3?=
 =?utf-8?B?aVhjY1NrQTdZcEJuUWY5M0gzZWtzNmZPTW9XcURseXBmbS9ZdkpDWlNvM09l?=
 =?utf-8?B?ZlZqbkdOcDlhSTRpSkxDcTlVOE14cStpWStIUzYvRXpxVGFUUzcrSGx6RUNw?=
 =?utf-8?B?aHMvb3drYUU5S1hMdkp3cDdna3ByWEVRZEFjZW5vODdIWmd6cEpoelRLL2Ju?=
 =?utf-8?B?YUpQOFliUU9WSXhZbHNROTFFVk5QTGU1M0lFQlJJU1ZobkVGTllrcHd2Vjl1?=
 =?utf-8?B?UlgvVEJtdTdqUEs4MlgwZUFuSGZvTUMyZmoxclJxeTZoekFUZCtrTnE0VThh?=
 =?utf-8?B?cERlM0F0cHFnTnJ0a0drSkVuUEM5bUVyKzYyaGg3SkMxMkZMTy9uWHY5cVM1?=
 =?utf-8?B?TlhpblVqMytLaE9vN0huWXRPWHM5QkRIYjhUMjdjakJOY3AvWkJ2Wm0veUds?=
 =?utf-8?B?QkxKNE4reDRxUXdKZk5HUWY1c2pob2dUeWo3N3Ayd09IdHpqWHpqbzhMRGlL?=
 =?utf-8?B?dGxuWjcrbEQ2YzNpRUExa3kzZDJzYW5TYkpueXdqc1NHa2k4bUJIMkFpdEFl?=
 =?utf-8?B?RDdFWWtMY3d0d0g3eEozL0hjZ1p2aEpIL0dudlZUTVF2ME1DdEtPZ2ExRFBH?=
 =?utf-8?B?YjJtZGc0bitTUHdEMzN6OTVRcEp4THdVZHhCemlIenFXNFhDTktNTnVXWVg5?=
 =?utf-8?B?SHlkeFcrWVk2SWhQSHZwaTZUN051eHF2d1dWd0dQVytDN3g5R3NhM1hJS1JX?=
 =?utf-8?B?QnR0RXVYc3hoS0VhMHd6Sk5SUzlsQmhRcEVtVkk3UmY0UjlJTjA3Uk94T1p3?=
 =?utf-8?Q?Xpzv6s5eHQDXlhE4=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b151501-2933-47f3-b41d-08def7e0e160
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:43:56.2996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ye29xgv6lqewVT3HkIuiZdm5MwwlEqFioE8zJ3iOYp8tVoV30Y5fy+KrkjGrJ6u7sw50UNw1vezBZ4gCPThjVsE0zqg18aIJQ18BkYEpNB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9891

Hi.

On 10/08/2026 12:55, Christian Marangi (Ansuel) wrote:
> Il giorno lun 10 ago 2026 alle ore 12:33 Chen-Yu Tsai
> <wenst@chromium.org> ha scritto:
>>
>> On Fri, Aug 7, 2026 at 11:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>
>>> On Fri, Aug 07, 2026 at 11:24:09AM +0800, Chen-Yu Tsai wrote:
>>>> On Fri, Aug 7, 2026 at 12:53 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
>>>>> This small series introduce support for 2-lanes mode for Airoha AN7581
>>>>
>>>> Just a nitpick, but I would probably name this something else, like
>>>> "cross-controller lane-bonding mode" or "lane stealing"? PCIe already
>>>> has 2x lanes as a standard feature, so this naming is a bit confusing.
>>>> It's not like dual-LVDS display in which LVDS is only a single lane.
>>>
>>> I suggested the "2-lane" and "x2" terminology because I assumed the
>>> result is what the PCIe spec would describe as a "x2 Link" consisting
>>> of two Lanes.
>>>
>>> If that's not the case, maybe "cross-controller lane-bonding mode" or
>>> "lane stealing" would be more accurate, but I don't know what those
>>> mean, so if we use them I would also like to know what the result
>>> looks like in standard PCIe terms.
>>
>> Benjamin pointed out later in the thread that it is just bifurcation.
>>
> 
> Yes but as me, you, Benjamin and Bjorn people who weren't there with the HW
> team at times the SoC was created, and given how the internal documentation
> these are just assumption and observation... Everyone can be correct and wrong.
> 
>> I would assume "PCIe bifurcation" is a standard term, so maybe we could
>> call this "Support un-bifurcated 2-lane operation"?
>>
> 
> And how coming from PCIe bifurcation to un-bifurcated 2-lane operation keeps
> the standard meaning?
> 
> This terms is equally custom as the previous "cross-controller
> lane-bonding mode"
> and "lane stealing"
> 
> I want to be honest... I'm not following why we are trying in every
> way possible to find
> a standard meaning for an highly integrated PCIe controller for a vendor SoC.
> It's not like there are devices shipped with PCIe slot where you can
> insert whatever
> card you want. (there is only a single RFB board but that is really to
> debug stuff and
> develop)
> 
> The SoC is designed to have WiFi cards attached and only a subset of them.
> And some of them require 2 lanes mode to work with this special configuration.
> 
> Even the DT bindings are not that specific to the details... at the
> end of the day
> everything is modelled as simple as "num-lanes = <2>;"
> 
Hi, I agree with Christian here. The property num-lanes will be able to 
describe all possible pcie configurations of the AN7581 and AN7563 SoCs 
(the AN7563 is using the same pci controller if I understand things 
correctly). Adding more properties will not make it less complex.

MvH
Benjamin Larsson
