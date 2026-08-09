Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021110.outbound.protection.outlook.com [40.107.130.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67652475CB;
	Sun,  9 Aug 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289268; cv=fail; b=iF5WwwB20xbE2g+oSVzOAJuhtnR3OBoAF+1CStGRVqtcOpTJaN0PMR36bvW2NHX0lg3Mk43XzDL9E5r+ZOqmbjaHrDHNmqL+A3PxlbLgzCwYkDuz9+X0h4hyjBZhk4iZe+tQhdmzGPWymPKUuC5XyRS8N6rr9yq0hOljWIUSMyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289268; c=relaxed/simple;
	bh=3mwvCLCiKeT2ahtH0eejxQ71+IdJaeR1SeX75fECtvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ov1fLch5TwofOFp3sUj/aDUdny7HpZpgv6F59GutqPsp4yB+o5Ewd8mYqh3bKsbO6TdeR2b71e4Y1CdRjIiQGGFOI/HEdsY0hd+zPFlvFhNZpotYzcuK4Wyf5AhW9+ijPRp4B0bWPqcm3Qvd36T+oB2VEj0lDeKRKw1k1kpIlLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=nrendF2B; arc=fail smtp.client-ip=40.107.130.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="nrendF2B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjO/7lkZ5etQcycVikAq8fRZf7ibCpiJcdrsw8Tm6rL6H/F9dvCeyybANBt1+tgVxTM9X8y6X9fl4Iz/i8k+/gDbG5K4l5eVWnZTPdHFUnDhO8cj4xmbCXa7JGda9pwKgSodv0PwMQC1DsNJTsVw3NLPJAsyWMeOmXfcVlonAxPZ64ZvQZdrdp5dgSNGfnWL6bB/lTnkSNfqhLuJnqCzwWXrQMP07L43sasAITFQ6lcoC8hetFJMSzEQQetFxlZNIsYHIPLsMe6/+JRqiCmJGpImnw1zDHkqs/nnlYI7ulAvI9zPmJOYFAgcMo1sTc9gln367NZwmSTpSuPnLGwHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDjt7gWNQH+X+Oj3vf4JG7rITV/oQKZi0fsrDfUmfhc=;
 b=MPQaiBSSMIlzmxSsGOvS6IniUI6U0r7IjXx6tPpPoZa5lCjV5VvqIt0U+17LJSHeMPJI7zKo/m3PDiPT9pa4wvgpBGOly5JcQviQMM525P3UTFLJhMoaH77ceMjDLx0KF+pp1dPkW7e+oAltf9w0sqWRQ3z8SNuXcqZXYY1xA0zls8dV9rIbCDkMTvfrhj05HteVssYxac0UBLNWfJu7ZbWIH3KZL74/9nUHMYcgu3Bvf034mTHRyhUROQpAjdgZS9wp0eb6MsQClhw1oIR7FFpQgv8tdL4QjcvNCv0Fikkphmup4f2NcsssqjLCfM57rTYOMsMs11a+KgJK/q/8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDjt7gWNQH+X+Oj3vf4JG7rITV/oQKZi0fsrDfUmfhc=;
 b=nrendF2BiG+4uVrnc+YH+m7POfyMEyiRSFpRm0Fa94YBqqtygV1T9rCGF5FNVsm477kGS7L4WbbNVQumLuWHe2lwsDQzO7zM8cjtUUt/09V4jvOhQyFmMcaOtFnPFz4My4qm8UmJtFCRtL5mQDgZ74GidzAj3xVXt8vuYfzkHNOBiBwjjvwn0oOZbMDhAuimCRMC0N/VNTEC0/CIyRWZ+ypKfWaFMikICR1fG3QrECkOYRBdJOE4O9YRb+VsFWm47AXE4FtZi8wxO19DdH2ea8U5DrAjBLmHBcMkcOAaVtppzEDbFYPmkJtXe0CKB1cWwN9EUoxK0X70Je73L2hNfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by GV2PR08MB11254.eurprd08.prod.outlook.com (2603:10a6:150:2f6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 15:27:39 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 15:27:38 +0000
Message-ID: <655f3341-afb7-4026-a1ed-83dd772b25da@genexis.eu>
Date: Sun, 9 Aug 2026 17:27:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support +
 clock
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
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
 <e41835ae-b575-4364-855f-6708b15b4db0@genexis.eu>
 <CA+_ehUy6bAq564+1c6KMV+egnXO8S2GGaLrRq1aDik9gWrrKyg@mail.gmail.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <CA+_ehUy6bAq564+1c6KMV+egnXO8S2GGaLrRq1aDik9gWrrKyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::23) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|GV2PR08MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d0a32a-b1e5-4fc1-71c3-08def62abef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|4143699003|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	meJc8NFrBFLRm7u+J2A64SuJI3szICqo+9XDt1KvEJqJKNIaCTavIUsGofLolrQYCudKMi5/TfShbLcuJW92Kc1kAiJvNtJa6Mm9Jb9FevXBveZ7THQBUutvGwIa/WFUWNwrbWez5In/HV9BjmwQkPEW/c6Gv8ZhVDwA2uxhTgFF2b0fPsnE9G0/Elqq2ufZOx5zpfMfNyVFbHXzi/9nWHicKjnHaZugzEqBPgV5ZwIpq6RNy2KR3lMQzyFLPJaJBWwRgg3UaqegrcVACZWvrbEqjwKK8ziU1P05sPoDC5BY5iFq0SUAU3wYEqQcngIK2mWYj+woWwlvozn+W2J5Za0Ttq98oQT6deV2qXOzSzppiUtAAtKEEplWiDkkI4FUmXtd9q+hfIzCNtFB7i0Fm4hAG91TcQXwANOOWWyPU/DuJMmZCBXmV/pUhNVAmZoMFNk4QOrnH6d4V46MZCtjFIkscXftbNPM3+bnW0HvHD/saQcRlNzxXpyiu00+eS/UFJEYVDdzDz6vV/nnLKZtNHFGRNT2R4G81ex/MFjYAkjW0TFnt4EBZhAdLzbxaiQnf4IGpKtf1bq1jo30YsZKIZsttpYQsqtX2JnUQ9+66nsq7gWtsm+DHh9OvN7oT4uJKEpoJr1r3WdNSIy5H5NESj5TutT8StWedpA67tXe2cM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zis1RGRxa29yWkdpaE9GdTc0V2E3U3BxT3l4R3NzK3BxNmY2KzN2anFQTFJl?=
 =?utf-8?B?VG45OVF1OHgvV25vZktxMEN4aUZxNTJOQWNsUFpNMlhRWW16dkw2dTNYMGd1?=
 =?utf-8?B?VXczR29wTEdhSXJQZjd3c3ByazJGbng4TXQraThyQ2lrWVE1RkRtRFIwYUg4?=
 =?utf-8?B?Q3QrK2ZiUlZ1QjR3cktvZ2ZOaDVCS1hJek8yQ1JXMnp4L0JpRFZFcHF3R2N2?=
 =?utf-8?B?anZpZmFDWS95UVlEMlBDS0NVQXRrVFNZa0FVRGFrL0JtYXk1NGwvUThDNXZx?=
 =?utf-8?B?QWZXOTFLV1ppNVpPMG80V1ZMV2pNR0tGWVJMNVVTVHczQkJDekZ4bHlMeDIz?=
 =?utf-8?B?YWVLakxncTgxcGRQYnRDVjVvckZJTVVTVnBBKzZXU2UvRnBhSXpxdk1wbC9y?=
 =?utf-8?B?ckdDenNJVFB2VHVscG1lWTZFT0VQSTUvZFY2VGdWZHFvVGhBeWYrdHRJdFR5?=
 =?utf-8?B?WVoxTldiVDRSdGlsTjVLYUFqcE03Nmdxa2NOem9JMDBwVVNlaEZBdlVYclFI?=
 =?utf-8?B?NFB6ZGhvcFFTb1h1djBQdXh6TUJIOWtFZGZsbzBDUE5oczd0V0lJT2RPUkdR?=
 =?utf-8?B?TzJHbUlENis4U1JkOGZuOVdmQ0g2bkNoMXdVdlpOWktyL21WQzN4THJkdVlV?=
 =?utf-8?B?K1FlTDR6bjgwam9iYnpDZ0FGcmJmSVFSUUphUWpzMmtaSDUycFdPWTF6LzNt?=
 =?utf-8?B?NVR5OWZYU3hhTmt5OFVSRVBwMHdoR2t5OHlhcVRxRklIcGRjWFhBYXJ2TXVQ?=
 =?utf-8?B?eEdheDIreVRCbHRiSnYvaTU2aGpHNFB4cWlTd1JWelhyeG16NXNSbDFBM0U3?=
 =?utf-8?B?Tjd1T09MZ2luQWU5bERLTU9uR0czem5uMGtrNW9rdVVBY09pZ053WUdUY1Rv?=
 =?utf-8?B?SWQwR05pUDl4TGU4U1B5Z3I1OFBMbWRVWDJ5cHhucG9rQ3NQRWkyRGYzcFRr?=
 =?utf-8?B?WHVZemFnMUNaTEZ1bXJidUM4bHRPdm9QNTRPcnY0UzJnRTJYb0cxMzFJVk4r?=
 =?utf-8?B?clZPQ0hXdWJCY2gwZVlXb1cxQ04zWW5GZTJZbmI3TTVnWHF0VW5EMzFlTGMw?=
 =?utf-8?B?NlFCaVRaYmUvamJsUDRHYWE1RHF1b2UxTmdtYkllZHlCOEczdFQyZjl3OVNr?=
 =?utf-8?B?S2U0OVFrR0ZhcEkzTDhBYjNlaE56UGFKYVY4dmJ5VEgzeTlObTRBRWZnaEV0?=
 =?utf-8?B?cFExLzRMUkV4Rm51cGh3bU5zNXNpUkpzKzl1eVUvQzl0Y25rTGZNWThtUDRn?=
 =?utf-8?B?VlNUSnZETWlhdWJBQVJzWlhxK1VYSVAwSEJQN2phMWdBTVpxcW40Q3o0a09I?=
 =?utf-8?B?TjJLUHFvY0FmdTFlVEFtWDlLbk1zSUUzTkU4eTAvSnkxcmtMcDNSbnBWdjd3?=
 =?utf-8?B?R3dYR29xNXc1b1R2d2VrdGxSTFBKdUlCRy9uMlBzU004WEd5SENtL2tRbzJy?=
 =?utf-8?B?U0MzYjl5QW1WbWpYWTNCZkpERFpqMURZUHo5eXRCdWpaV290RVFXVi9CL042?=
 =?utf-8?B?bWVDekI0MHBXN3QvWWdQWkpGbk5PRy8yQnpjck5qcytDSXdQbmZZWmVNNnB1?=
 =?utf-8?B?SWdUeG9wQzJlRlYxMGlSVFV1dG5sQ0taejNWNUJ6eDJpZjREYkRrVU5VUjd1?=
 =?utf-8?B?cER2YXMvTThTdGJCaWtTWXhhdnlnRUdNMzlqb3h3QWo1K0NSYUpYWDRvSjVG?=
 =?utf-8?B?TS9aL1BCNWo2T1YxdDhyaWdNUjdvTEd3Y0JuU3VBcSt4U3luK2RDaFJhUi8y?=
 =?utf-8?B?OXJQVitqQm1YanBnOTlZSUlCNkljK2Z1a0dQcEljWjhQQ2RMVm1jUy93ZG5E?=
 =?utf-8?B?Z2lGWVZWTXk5NEVZTThJVHBhUkFLSkh2VS9ZWlBwSTZNbFZoWTMvTDZyc0ZY?=
 =?utf-8?B?ZTJWYlpJdnBVNHIxRXZUZmFTd3NSTlVJZGJQRElsWWU5QVEwSzV1WUlFTEhT?=
 =?utf-8?B?eGpXekFGZjRXclhHdUNxK3pLZEF4NnNldGczWXNvd2JGcXMxUzkwdVg4dEZt?=
 =?utf-8?B?M0xIVVlKTW1taXRRVTNtOVBMQ1FCZmNDUHpmQ0FjbjBLd1llM1BCVS8yTEdS?=
 =?utf-8?B?UVJtbmtUQUZodmlQSC9rNVdxaFA2TVRzN1QvZTFKZUxodGdBR2Z4c3k4VmxZ?=
 =?utf-8?B?TTJJazNBcE5Fblo4SGhxL2xkY0F6Yjd1L3RnbkJkYTUyZGYyRkRHblk5bmJC?=
 =?utf-8?B?RkNCYUZhV2ZYOFZhQldlTU1qU0ZJUHJhVmhWM1FkTTVRMVR4RWR0eWYzR24z?=
 =?utf-8?B?U1RjWnhTMGdxMEZhL0tyU3lmYU5OVC94VXF2Z0RpdC9LajZKSlZ3c2wydWEw?=
 =?utf-8?B?SXozekh6ZzRjS2JvbDFmZHFnZTJQbmtiZ1VzU2Zoc1U2YlVTVTBQYlo1azRH?=
 =?utf-8?Q?QL/Bz1yEIsmk/XEk=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d0a32a-b1e5-4fc1-71c3-08def62abef0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 15:27:38.8281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDzLXk0TP0aQwVLSzbmCVC6N+RCRY0+4XYcIjZwbeL5Rh9xXrJv+Y3linP7UzUTxa48ai/jtuTrsz4zF/qwoCx2BbnZDemqNdEj+IBvqPPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11254

On 09/08/2026 16:14, Christian Marangi (Ansuel) wrote:
> Il giorno dom 9 ago 2026 alle ore 16:08 Benjamin Larsson
> <benjamin.larsson@genexis.eu> ha scritto:
>>
>> On 09/08/2026 14:12, Christian Marangi (Ansuel) wrote:
>>> Il giorno ven 7 ago 2026 alle ore 17:21 Bjorn Helgaas
>>> <helgaas@kernel.org> ha scritto:
>>>>
>>>> On Fri, Aug 07, 2026 at 11:24:09AM +0800, Chen-Yu Tsai wrote:
>>>>> On Fri, Aug 7, 2026 at 12:53 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
>>>>>> This small series introduce support for 2-lanes mode for Airoha AN7581
>>>>>
>>>>> Just a nitpick, but I would probably name this something else, like
>>>>> "cross-controller lane-bonding mode" or "lane stealing"? PCIe already
>>>>> has 2x lanes as a standard feature, so this naming is a bit confusing.
>>>>> It's not like dual-LVDS display in which LVDS is only a single lane.
>>>>
>>>> I suggested the "2-lane" and "x2" terminology because I assumed the
>>>> result is what the PCIe spec would describe as a "x2 Link" consisting
>>>> of two Lanes.
>>>>
>>>> If that's not the case, maybe "cross-controller lane-bonding mode" or
>>>> "lane stealing" would be more accurate, but I don't know what those
>>>> mean, so if we use them I would also like to know what the result
>>>> looks like in standard PCIe terms.
>>>>
>>>
>>> Mhhh I don't really like the term lane stealing. Also cross-controller
>>> lane-bonding
>>> might be a first. Even if correct it would complicate identification
>>> of the feature
>>> that at the end of the day configures the HW to provide a 2 lanes PCIe.
>>>
>>> Consider that in such mode, the other PCIe controller gets disabled (this is
>>> handled in DT) so it's effectively enabling the standard PCIe 2x lanes
>>> and apply the HW configuration for it.
>>>
>>>>>> SoC. This is needed for correctly functionality of Eagle WiFi Card
>>>>>> normally attached to this SoC that require a 2-line PCIe card to
>>>>>> correctly work (and give the proper performance)
>>>>>>
>>>>>> The first 2 patch address a limitation of the PCIe implementation
>>>>>> where the PERSTOUT reset were indirectly asserted and deasserted
>>>>>> all at the same time (for all the 3 PCIe card) with PCIe
>>>>>> enable and disable.
>>>>>> The 2 patch address this and introduce correct reset to control
>>>>>> reset line for the relevant PCIe line.
>>>>>>
>>>>>> The last 2 patch add additional logic and support to assert
>>>>>> and deassert the PERSTOUT and also apply the required configuration
>>>>>> for 2-lanes mode.
>>>>>>
>>>>>> 2-lanes mode is implemented in DT by adding the required property
>>>>>> and by defining the "num-lanes" to 2.
>>>
>>
>> Hi. Isnt this just pcie bifurcation?
>>
>> Logically bifurcation would need to be disabled when using 2 lanes in
>> one slot and enabled when 2 lanes are split between 2 pcie slots.
>>
>> But I'm not really sure what value a bifurcation property would add.
>> Isnt the current schema enough?
>>
>> The mt7987 will need the same logic as it can also bifurcate one pcie slot.
>>
> 
> The documentation is not so kind on these kind of details... and no register
> for bifurcation... maybe it's the mux one? But the mux settings comes from
> reverse as in documentation that SCU register is a good 7:0 bits of
> data value...

Hi, yeah I think the SCU documentation is wrong for the AN7581. At least 
for the W1700k v1 device SoC version. It works without the SCU PCIC bit 
set there IIRC.

https://forum.openwrt.org/t/quantum-fiber-w1700k-support/222776/280

The vendor driver has this:
https://github.com/merbanan/airoha_pcie/blob/main/airoha_pcie/en7581/pcie-ecnt-phy_7581.c#L1671

Maybe this is the only bit that control the bifurcation?

MvH
Benjamin Larsson
