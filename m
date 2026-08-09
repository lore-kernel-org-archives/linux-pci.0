Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023129.outbound.protection.outlook.com [52.101.83.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D71F16B;
	Sun,  9 Aug 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786284531; cv=fail; b=c1qe2pTtXQoLpvdW1qLJnv7IKzrM1k8hHKcjoLUvvaWB0gclhtbFS7gGOQ45ueH4P6lh1H3KAi6H/aMiuvOAvRdL5hWZdpepNVDSo4v/jVZk+DapVYAZn1U3xNbcRq+qVFX/jsMybXMnstJiQK5sMFt5hs8Oo/ulKPiRzJ/5mKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786284531; c=relaxed/simple;
	bh=VLKs55XGts04Q80Hn0KViltyZ1qa2RM3iFIdcenC50E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kp5Dga8kSMj/0AJQFcvd6aelfU+SBVlsQI4mdltii+jHqtYDUY/y5nrApTdOjSTrBT8H5RfDcB78sNP56x8HJc6F97eOTqFRyF5WBm2V5EsTlE+1eWc5x+B7sNOjWFg3Iflg8H0jrVs8ntYupAyB2aIfGCGwHX/owiGZJF2g9Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=aIRb/x/W; arc=fail smtp.client-ip=52.101.83.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="aIRb/x/W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQSkgnDHMNaTShPQGDRAfSjZoISJKrdFx6Dx8Vme10glbSYwlxKh8cmZ9P29fV1jC5k7Wt8hxKSnmup8J3YNMgm3yuqOw7iYDbUE6RZEPvdX7ZwrcGtCTn1XIbYZJonvwQdJbsJx9/jZzUZ4pXO5R3ZNNwQLRJLj6B3PtwZXcmRuePVQ5DUDss/YB2V4k6L1n0/1IVKTsZSfKVLl9Um4hhNOycTVUrZmyKEcNNmFSFaTfVkclD4Tf4+nWLgPgJ12HmAp5ZPIFh+HRiSIBALbTvTkGrXJcNCGXOaCjrnN0Hq0tYjJ/M5LD6zwLhzCYbRNGlZ1cBbl2PRzoaKzv5FWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyFlQ2l2xC614jbWju8ebHb0zQMNZZVIXVVFtz8jOHM=;
 b=f2/u7fezquDcU9+uudwQgs1ECLznO7kLipGQiBnaggb3kIxoBHpIwPfFDCKgzSqsTnsXMzEY0YmkbLeAOk5XhoOhlL6M4N/Ub8cnFMDPN2XjkAhLtvZLALI6oBWRMcNL2M3CCQbDt1/g6UVQNv3wW8c1AydxyH46H55e68ZXr6UHw4NCdREKyU8eikJlOTjt4+VMiJeQmi2rhou0vmk2h4EXdqPIsYvufRLP1LU368U0J7FPidGnPFZLvhs5udWeF5r5GQ68K0Iu+8F052dFVYcnnwsgjzUilYZB00s5OK/nCfxdKKmY0H2bh2zJdRDP8r+2NQvUvsncZZUBmeISRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyFlQ2l2xC614jbWju8ebHb0zQMNZZVIXVVFtz8jOHM=;
 b=aIRb/x/WDunS4twcZCYpf6sUEunXzCaRH1jK9zVLvJHZxPGxQFXV8RsggRj9hk50UFwjRqBBXVCJ5eGtUM/vQY2/zKIH+0r6vQzjo4pxPs0gTIzpprwPILcnTaGPO4EoMs9Xh/4f2Cb0LWux67NDJIbpenmsWsLOhTm0cMumK42ka/3J/A3tHa6JDxIdyJtnhdJBjliQH7LBcKFNrwcszLGqMYld07NbBLw91aVmoGZ57SD92V9LQu6YIkd23X+HTjGMy7NbVkdIk12CZQWm19HedhJr0x7nZAn44H6v8Rogtgr1JO9hUR4j0FESsPBnXByA8wKZQrLofplhbGIi6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by GV2PR08MB8414.eurprd08.prod.outlook.com (2603:10a6:150:bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 14:08:42 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 14:08:42 +0000
Message-ID: <e41835ae-b575-4364-855f-6708b15b4db0@genexis.eu>
Date: Sun, 9 Aug 2026 16:08:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support +
 clock
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
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
 <CA+_ehUxQfWRRec4q2ZvC12nYAeV2VGm1xCFrTWeN6sEL+qkXBw@mail.gmail.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <CA+_ehUxQfWRRec4q2ZvC12nYAeV2VGm1xCFrTWeN6sEL+qkXBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF0005F696.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::12c) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|GV2PR08MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: ec28b40d-0271-470a-f252-08def61fb7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	INKDRXRQrwo4eqPG7tBnSFaTSn05HMfFzKrSn4Qy6vPJTeCEow9I2FrUhNFbOQt4qss26hes32OO3ufSaXJxiC9VbreuF3f6ooJUMG8qEaLNhS3lDPzQNAuw2hpq/Jm+427v44Pegy7uX++XDmXa8pG9Y7HaJkxB4ryZeT2xwqdFqIQ5sq03qcE2Q8kDiE7tRrutC68b2FCPUpl28ZXL//+MsWG2UuSxmpui70czc3PB3etBkHsuCX/52MkfGQDU1iDJa8rhW08/dgRtsmclggTcZ2IQHWmXmzeMMOvKlBGyJASM0UZXDlopXBIklJcmqcIq8lfklh6BkmXqUXROsuav4+jLRnkA345Y7FkIFzvQYUNuPLBdb7R2bL9qboVDjzK4NEkXX9igeKbSD3rnBxTu/w6a34PAESy7rynbLwGfYhU7rlp41NThQduSVdbHK0ABhSBwMpo184pvxA6E8VGDF9TfWq3j+oJOVDROPuKQiwQf6dmC63GiRWN54LLmusK9jyjdnrm49c+yWwXJicUuVhvgkyu9ADTYoYnqkPqaUxqXM53sRjFw5LqrqzgJbPc+IWCq4s/3oFTYscn+EzngGngwC2PrS107bpWz3Pk2/Man3FYNZl1Be6OYlNG4IM1bP+zK+ewI5aAzQ1eoxR6c4eksVV/QC1LYHLm+Vdw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0hTL2czQVVQTmlBYk9pRm9HdzIwVUVxbnI0dTc1N3FNcVU4ay9CWkVpYnFB?=
 =?utf-8?B?dGpwbWdhQ3poOWVJeGlnU2lkWFZhUitaUG5UbEc3d1V3aTVYOUpZZjd6L1lR?=
 =?utf-8?B?ak1rdlJTVlBwZ09TdFZGTllDcUZId1ZiOVBXUi8rcWFMWllzdWg5VFVxYStY?=
 =?utf-8?B?T2g2RFhNQUtveWcrU3c2djlmM01lbStWY29HeUFlSHRtWkxTMGpaOXlDanhi?=
 =?utf-8?B?cEp5RDZNMFRuSnYvck1rSmFxOHZuOERiRG94bDJkaEtKREhwVkJHY2pVQ21T?=
 =?utf-8?B?ZTAvY1VlSHdMNGlwYjJYUmFrZTJtaTBnSi9qeFJyOFcrbGcxOFkwL1lub1hi?=
 =?utf-8?B?OWNxWjNTUzB2R3RQclR1WDJwb3pISmZzZDNLTDJnTno5OUhkYmFya1hoRmY3?=
 =?utf-8?B?dXdDeTROQzNqUFl3akdnZlljWW9PMm1Od2dJVGZQa2VCb2trcVdSbXhKaFlx?=
 =?utf-8?B?N2R0Z1FIUVpxUFlhR2h4d3daNjdwSjNjYndqNXJ4UWVCRlo5aERpT0o3Y1Bp?=
 =?utf-8?B?VTVvR2hJYXYvNTFGemhuZTlnS1RraktHbmYyUzBwUDdyZ2Nya0NaenVjZjhZ?=
 =?utf-8?B?TEJIME5sMzBqQWJrc2N3S0x6Ry8rY2RRTWNWMXJXckpwSG01UmduL2ZOWmVt?=
 =?utf-8?B?cjNHOG5TV1dHYUxMM1B4MnZCeE9PZVQ5QTZ1RmEvUWpjazdkaDN4WHc0VEpO?=
 =?utf-8?B?RndSL2poc25QQTMzNjF5eXcwZGxaK09rSzUxRTF0Y1pFcjJrc2tkcm8zaHhm?=
 =?utf-8?B?RUxqZWFDRytkbEYxTGJDTFVhZjRSUXpUdU80RGp1MlJJY2sydnZHelZsN01R?=
 =?utf-8?B?ckhQdGsvdnJUa1lMK1pZeTFZUk9ZVGhUSlRXK0NMWG5hSGxpNDRyd2dvTC9E?=
 =?utf-8?B?cHJJR1hMblVCcE8zOWNQd0tyS1VjdEwvRFQ5RGV0bWZHZUxSSGNzeHlTMGRl?=
 =?utf-8?B?cGJhR01wWEFodll4Zzk0Q1VXWllLRVh0Qzdpb3lRUm5nUDNFV2hFeE9TcWFD?=
 =?utf-8?B?dm9OUG45SXNLOFZ0V0RLQWxaMU9WYWdlV2lOK3lzSzBvNU9BTzFicm9SazZq?=
 =?utf-8?B?SGwrb1dNbERCcDFTTXhWbi9ubjUvNG4yN1BpaFpZZkU3SGUrODlrQVVFZUdq?=
 =?utf-8?B?RzBWUVc0NUNCQVZRWE9yN016UFVKWGlPVUtpSHpBdUhlTHNXZ2F5Ukh1ZHdC?=
 =?utf-8?B?anMzYWxuS0pqNW9oU1AyblNsVkpMZ2piN1l0NXVVWTBrNlBGenNYN2VCdGFP?=
 =?utf-8?B?dHhQTlMwRGdoeTBua2s3RCtSQ1dnK0pWMkpGSVp3cEVSVC85UUtQYlpSK280?=
 =?utf-8?B?T2xUMC9nK1VEc2hMakxReDNyYS9EMG9aYXVJaEV3bjhRUmlONmNtNWROWHRB?=
 =?utf-8?B?dGoveXZqOU9JWG9EMGJzSzBjd280KzBRWGMwVHIvOVE0eWZFQkIvek5UTTZo?=
 =?utf-8?B?TlhGOGxBUEhUM1dieDFKWENTMXhtbWlUa2tONXdrRWZmVUM1Y0JqMHlpUklk?=
 =?utf-8?B?Wmd3azFTUFA5M3B1MW1ycGlUYXRaczk3dmlGRi9LdHExc1VDcFI2TzNGbFUz?=
 =?utf-8?B?VGtWdjhpd21MMFgrYjdhYmMrR3J6MEZqTnpDbUc3SWRMeHdFWkNPQ0puVUZq?=
 =?utf-8?B?OGVLb0h2Q1ZPOUNhaUxZUmtnSmRxNHY3UkVFM2ZIU1J3ZzNpeVNRdGVhTmJq?=
 =?utf-8?B?d21jMlVqVEp5bzlHMGwwT0hDVDZ3VHorZXJ6Wk1JVzh0Z3J1R3o2cnVNUU9L?=
 =?utf-8?B?OHFZdDcreWd1Q0pML3NUNHhFR2VyblJPWDVXRnBxWDFrRS9Ca282bnBaZUVR?=
 =?utf-8?B?d2NPbFU3ZWVlVFlZVW1PbVFJWDBjN0JTSWlHWUJ1ODFYcE0wVjFPU1BNcjlw?=
 =?utf-8?B?bWZ3aEFzTVpKYm1ReCtRQzFUTURwczN5NEVMUmJCdUtPTnRFMi9icS9kWjRy?=
 =?utf-8?B?WGp5amFkU0VDWngyNW9TYjkxM1ZFWWMwMjRpYjkzaXZ3Ri9rZXBzREVSN0hC?=
 =?utf-8?B?Ryt2cjJxMjdhYjVreS9qbXJkRzZsYUw4UU4vVitjRXFnbXUzK3ZUeXEyNWc5?=
 =?utf-8?B?OWo0dGZNMFdYc0o5WE1wcU5iUCtqUWlBdTBURGM3ZlgxRDJmdWcyejBTbERw?=
 =?utf-8?B?TlB5QjVxYlhMNlBjamg4b0h3c014WWlCajIrcmRrUTlwOVlRUWZHbjNSeVRQ?=
 =?utf-8?B?ZWN5QWZ2ZEVHVzNRUHNIOGNrS1NPUjRWYWlEQmJBT1pyS2tBeEdTQjlsM2VM?=
 =?utf-8?B?eVBrM3JNK1l4QlNYVndhQUZiVk52ZW5DKzVzYVdSdnVFbTQyRVVDakhsbnJ0?=
 =?utf-8?B?VktRRHRiaDNnSkh3V1ZLbHVPYUFwSlQraTg3Q1o0WndmYmY2MHZJcnV2WlUy?=
 =?utf-8?Q?1yiYvWxMHITA0+vI=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ec28b40d-0271-470a-f252-08def61fb7e1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 14:08:42.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJfKvZpGOmwfWBf4XfhokFUxLV6GzOJAoChZLzbZRJp1oSRln2yqmqRmww4dFv/yzNyQM6Je/AjTOsCKFcWogwGov59b2YQpfzxZ4cTk1vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8414

On 09/08/2026 14:12, Christian Marangi (Ansuel) wrote:
> Il giorno ven 7 ago 2026 alle ore 17:21 Bjorn Helgaas
> <helgaas@kernel.org> ha scritto:
>>
>> On Fri, Aug 07, 2026 at 11:24:09AM +0800, Chen-Yu Tsai wrote:
>>> On Fri, Aug 7, 2026 at 12:53 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
>>>> This small series introduce support for 2-lanes mode for Airoha AN7581
>>>
>>> Just a nitpick, but I would probably name this something else, like
>>> "cross-controller lane-bonding mode" or "lane stealing"? PCIe already
>>> has 2x lanes as a standard feature, so this naming is a bit confusing.
>>> It's not like dual-LVDS display in which LVDS is only a single lane.
>>
>> I suggested the "2-lane" and "x2" terminology because I assumed the
>> result is what the PCIe spec would describe as a "x2 Link" consisting
>> of two Lanes.
>>
>> If that's not the case, maybe "cross-controller lane-bonding mode" or
>> "lane stealing" would be more accurate, but I don't know what those
>> mean, so if we use them I would also like to know what the result
>> looks like in standard PCIe terms.
>>
> 
> Mhhh I don't really like the term lane stealing. Also cross-controller
> lane-bonding
> might be a first. Even if correct it would complicate identification
> of the feature
> that at the end of the day configures the HW to provide a 2 lanes PCIe.
> 
> Consider that in such mode, the other PCIe controller gets disabled (this is
> handled in DT) so it's effectively enabling the standard PCIe 2x lanes
> and apply the HW configuration for it.
> 
>>>> SoC. This is needed for correctly functionality of Eagle WiFi Card
>>>> normally attached to this SoC that require a 2-line PCIe card to
>>>> correctly work (and give the proper performance)
>>>>
>>>> The first 2 patch address a limitation of the PCIe implementation
>>>> where the PERSTOUT reset were indirectly asserted and deasserted
>>>> all at the same time (for all the 3 PCIe card) with PCIe
>>>> enable and disable.
>>>> The 2 patch address this and introduce correct reset to control
>>>> reset line for the relevant PCIe line.
>>>>
>>>> The last 2 patch add additional logic and support to assert
>>>> and deassert the PERSTOUT and also apply the required configuration
>>>> for 2-lanes mode.
>>>>
>>>> 2-lanes mode is implemented in DT by adding the required property
>>>> and by defining the "num-lanes" to 2.
> 

Hi. Isnt this just pcie bifurcation?

Logically bifurcation would need to be disabled when using 2 lanes in 
one slot and enabled when 2 lanes are split between 2 pcie slots.

But I'm not really sure what value a bifurcation property would add. 
Isnt the current schema enough?

The mt7987 will need the same logic as it can also bifurcate one pcie slot.

MvH
Benjamin Larsson
