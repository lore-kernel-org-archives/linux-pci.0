Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794987246;
	b=OLKTijIE+awogd6egd1TZWsnwIEh9wqKn0zbKQUTGTq84MuMaNxYbKISBKtZeAiPKxwh
	 feHo3hTJxkk5b5ecm1mLf0H3hKktt4DxmBPetWLI+lhbjy9evq5x47COVySOTf6/1b7rT
	 +NYsZxUfaTBlhBbD+R7gWJ7xGbx4Rz6PAVU5vur0x5SsuvGHpMt4duaxtbyBmXZ7tzgbH
	 foTrFb1bGzknqeaYJyvQELR2H+lCE/If/nZTjv8bwlsXQIT0d78u8AB9VodgNg4sxKzN0
	 +n/UZtUXozMEdjGCIRQs50/EqQdGryOH1TwpqQnMv5FzdOeFZN17KzuLmm+cz701tGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987246;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=71OmnO+FWbA4EhJ7EN+OTkAqWLzkAt6SqNvR5q45ls0=;
	b=eWFzZylNDUN9G/EPJL1xJTIJ9NectpbAuXk2oFVzMpwEqdVPKO01h6RMNDog5v7/dd3K
	 VxbojwFCH8+k68MU2r46Y41xgYmaBtxav9S0WK5B0Be3CjAxSITohoHOtkYfgBdq46kr1
	 7Ima2+J7ytlOjn8wNKZNbTJVKbQtColiBh5eRNH3bECTxd4BcnX3oci0io1tOUp9DDdX0
	 mko2FY4ikOmB+P3n1oApbCifrGd9tUGrieVvhO6WSaXpaODz5o5Jc+BjgjI/pAVegz736
	 IeofS5CTHrjuqiTPwuTTnogqz7HSX8dmR5+kCpNcIcHalFf1N9G+ge/D2qYfI2zYxYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oKSIu2Qc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.70
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EBA606A31C;
	Wed, 18 Nov 2026 07:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85EBA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oKSIu2Qc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdKAIEGnqdhU/EHEpEmLwUWftF30FTizR18CjiJZl5OBIk0Mt9CG67kYJR7Gk6R4buzoOL87F3MjSjywAeZS093GSZZSUk+vaIR1zn0ny0+uCoW5e+cr8PfgmP6mOvgkc1DJIXmN0cXEme6LPs6hBcSED8TWSjSVE1zwYRxXP4CqSA94cthB3bYSfbtHFvR75mVyAWA34Yc5M9WEb5AadMEcyr5j+ThXOjxGw6X1pqWl0YDncXC65EE4l4ZBhgQbFwZHzwgWdT8iBJYJcDalRyI6SX0nN3oNNT5J9Yq8ty83n1RxQiyDhuYolL9TtFgC3J1YLxuyDfDtlXUs5Zjbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71OmnO+FWbA4EhJ7EN+OTkAqWLzkAt6SqNvR5q45ls0=;
 b=PFJQTaorj+btu/GQHbdEdVWzRzrAdxnBaERWNdmr7kgPjY5VAd0aYP52PJObcll1c52ye2vQmfVuiusrB/R1yKMWTd2j1N93dL/3pSSEnt7z5J1C564dcgDEARaK9gCRy448OInC9kpTqvIA+E65nsl0+Xt6dGNdpYVYr/XnUCTNigBIX0GPzp8HP/C5aO4bOfbIyViVc5T0jEKRZ69h7DHso00WLVuJQZVN6JH+ikur98bH3Jk7dcjVFves2a3PRZA8l+W7G5dN95mMKuBELdVrlRGyaHbDYCDmIJhouZeFJx4gnuJt3JNNfWqn6zd69w2XW7z6rgAJoWBDnFCKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71OmnO+FWbA4EhJ7EN+OTkAqWLzkAt6SqNvR5q45ls0=;
 b=oKSIu2QcuIBY3gBoAslJAehQIUbvqoFOn3cbCza/8IKjn4ieDrICYeaK9yZQKCjJwJRoBNEdSeDR1UrRMfis5tYqVwhvBj913hy0sRevca8+7okw961lmfbzmJllF/Um0IqrFliEZEpdmLrRpNKGpW+VQxiitsfyZHTk1N+OLm0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by SJ2PR12MB7866.namprd12.prod.outlook.com
 (2603:10b6:a03:4cc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 18 Nov
 2026 07:34:01 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:34:01 +0000
Message-ID: <fd25ed52-e3ea-41a2-9f62-2397d5d9e8c8@amd.com>
Date: Wed, 18 Nov 2026 18:33:45 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
To: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com> <20261110122237.GG8635@unreal>
 <b4c2538f-8021-4abc-be2e-fcd1596f84ca@arm.com>
 <20261117124801.GD124972@unreal>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20261117124801.GD124972@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0131.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::7) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: bd85bdef-bc7f-4f4b-6fb7-08df454650ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|261026140227099003|56012099006|10067099003|11063799006|261009223027099003|261026121527099003|5023799004|4143699003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261021123027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	kZxqGkqBkyBWGddz7J43Pl2uxsBLycER/2T8xvGeAlMFBYBrqILCeo2xLkvd7irsvHU3dkvMSuLYf8YFAGzYLW5ITQqs7VrwHfg6ge9RLBWA2rmzvXDJfIi+MQarPcP8BLXI5lLOEReRYrxmkgxEKTO5X4dRXJvXy9iYHC+W3Q3eIKuc7qPScMtYS4mt4k5ydQcu8Gmn0ZrZ1gnFrMQGDEvMhHZGJh/GzQyYtkuxknydptTCtMEIcOgbvKz9911rwFxWWvBgWpCgHkn6yQYLvXdEXuE4EG2OZWZ6fx7xSL+UyyUFQVtUgjP9539uPO/lf6g+GMFPTFgT6VoNqio9L1ZqJmf9ABYL4V8mkKK5SLCrJSWdWD9+wzlmgOnk0mY5zbVQMj7ICC5KgJBsg0h5eTNtOvza4IjsxYwVqWTNzsm9c7XbeppZdFHC9gP1RAKywD/PeHoJjmWA9d3jLvRViv6LihiaFYlzln9Cv+HOgLXkUcenh6cZcL48JPafpaRfO4RVUE5qUEuXvt54ePYY5SslDAT/VJ8+zA+uS/FoZE+zXfqT2RV7Ad9CclhY7Zkb5Ofs587wGOoiFn4CdF1cEkDeJXpN+6Mormj5WThJej3v0ZlWEKW1kyMxVysEzZuGCt8Z9uWhM0Xji146/E8TgFiYQfla2tgcOJxcOPKtbZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(261026140227099003)(56012099006)(10067099003)(11063799006)(261009223027099003)(261026121527099003)(5023799004)(4143699003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261021123027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djU3N2JoaG5SRnpKelptR3lmL2dSdG4zTEE5enJuUVhWQ3ZIa0dpYmQzekdC?=
 =?utf-8?B?NGhLM1AxN2tWV0hFNnJJZW51cnNGS1dLeFY2d1lxQVlsNG1YeDhjT044RTFa?=
 =?utf-8?B?aWxhSjRCUHNERXJPczJFZDZaU056UkJEZUFFYlFMbEdqWDVIbElsZG1PUTls?=
 =?utf-8?B?MVRZWEJGbjlQSzE4M25qeENiNXhpaHBmYVVOT3QzQi9QZm0rYmxCbnMvM2FW?=
 =?utf-8?B?UmpBSWRZSUwxTjJMM2RsNzJtYzBrZmJJZCt5UkhFRVo1OEZjTXF4TmJ2anI1?=
 =?utf-8?B?V1hrQWRTUjkzMHZYenh5UVlrYkdPNHVUNTVGWFZSUnNUYyt0ekh5d0loUzRu?=
 =?utf-8?B?K0NUcm10TENvekVtWTNjZlUwMjlaL0cwQmp3VlNsSzJBbHFpUW5CNFlnOWNH?=
 =?utf-8?B?eHNuQWhCMWdJVGpWTzBmek9qeStINTFWR1k1OUxia1RzUkxrRFQwSzRpRnZS?=
 =?utf-8?B?NW5RNHhsd254Qm1UcFM2OUhiUWphdVZxU1Jzbi9vK2xTa1pMU01iRXR0c210?=
 =?utf-8?B?NGpzNmlaS1RCdHUwYmVLWDdsSHNCc2tWbWF1NWhrZkFJbWV5UFRMMDhKMFN4?=
 =?utf-8?B?MUxOWW5mTjhwYitQMXpCdDRYSFc4Rm9CaWtqTjBVUEd2SzlROU83NGhQdjlG?=
 =?utf-8?B?bVZ5c2hBNmI5NCtLTHY1QkFRTldKVlJzeHYwNFAzS0M0Mkk5OGNScTg0M1Bo?=
 =?utf-8?B?Zlp6anduTUFjUVFUeGVtYVc1RzRXMlZQSHFoSTlVQlZGTVA0a2xxWldJRkI3?=
 =?utf-8?B?NG5zL1IrREZLWU1PZ3RIQ1F3T3Zmd3Z5Mjl0cHh1S05xSno2NlNHTTBWVWJ0?=
 =?utf-8?B?OUl1V2srdkJzai8xbS9BcUlGWUFRalJKTVZtM2NCMUYvM08yc2FIUVFjSzFJ?=
 =?utf-8?B?Q2JKcVlQMnVHMXd5ZG5xRzdFb2x0ZVVWNHRxcE1kU2hsMEQySHpwQ1JFemcy?=
 =?utf-8?B?Mkg3V3I0MkZScVVJSEhjb2YySDI1L0NiTmlNSnU2NlUvTHR3TFJxbFFsSXAr?=
 =?utf-8?B?d1RIaTB2NzBrNjlCR1hDZ0k0NVd3MFRDRjRWWXdLTVVyWGdkNGpIRDRNODF5?=
 =?utf-8?B?bXk1VmJ5NVFKR1BGbm1NRkRpM0VnNjlBakRYQ2twZG1GRTV2Z1dJQ1Z1WXJj?=
 =?utf-8?B?bGRMeGsrWnpnYzFQTnVkUnZSMEl5YWs2bmpiZjZ2TUNyMjV0aTAxb0tqWXV3?=
 =?utf-8?B?Z3lPcEZpdzZIR3FUMmg4eXpyaHdBdmEzTGZSMFZ0ZzM1dWloMnlMR0FGa21z?=
 =?utf-8?B?N3laVWhZZU9vcGpTQitqS2xydzJhQ3VLeW5GRzR2VXZUa1NmZmhISWNldDZB?=
 =?utf-8?B?cUpDT0d1cXpIckpjT3AyNE1UNW81dVdEZ0dhaHlldmh5NFVKcmNhOEZ2VFRX?=
 =?utf-8?B?L0REb3QxSnR6aTVucXJ5elZvcXZGTHBxUHFnWTJEQkowbjFDdG5FQkp4dE5q?=
 =?utf-8?B?NWhlb1AxSGNwVVk4ZGJKcU1hd3NlRWNNTHRmMFZ5cVBROEhvdUxocjk0bmNu?=
 =?utf-8?B?NVBUOUpkMTNQd3YwZFJ2MkxXK3YvWnh6UGhETDAwNmZtNGxOei9Oak5pY3Mx?=
 =?utf-8?B?L3lOVWZSdVZiekZhUnFlak9tZFovbVRJLzJGcDB5c0ppOTNmbDhFbzB3WnJx?=
 =?utf-8?B?bmRXYllkYjJoUEZTa0tjOU0zbVVpL0MrdXRtUHJVSWFJT0VRc0N5TGhoNElT?=
 =?utf-8?B?VFBQQk5ZZXJlbjAzcnVuem1qT3JFMGhoMjZmS3pFR1AvTHBibVQ1Q3FEbmsv?=
 =?utf-8?B?M05tZERoZWxyVjUvbUhNRHRuOFMxaFc4VVI3R0V2dHpiK1FvYjhvU0E3ZDJz?=
 =?utf-8?B?MTRSUmVUTDlsbFp4WkFOM211UUtyMU9mckllRFM5M054a1I4YXlWQmJMUGM4?=
 =?utf-8?B?SnNhVTdlbUxrYVFyNVVUNVZuN0VNVGlqc3lhdk5GYWp1Y2ZvWEJjN2hSSHhI?=
 =?utf-8?B?aDd6WG1NajdIVWtiSGRrejBSL3U2K2pITmsxNWJYcHRobjFxMGI3ek5FWk9O?=
 =?utf-8?B?aXUzYjdGZU5FV21veUxidXpVN3IyNkpxeExGOS83eEZXaWcrd2V1Q3pxYUVI?=
 =?utf-8?B?RUE2SjJ2M1paWTRPbndkS3JmVTlNOWhXMEpRTzltVlh0TS9qYlNzclh4amhO?=
 =?utf-8?B?eGFteFZDZlhHN3BmT2xoaG14d00ycTF0enB1ampSL3VYNUlIa2ZJNVF3OVF3?=
 =?utf-8?B?aFlRV0Zxa2UrZEM4SjBkT3FZd1JMTkhuQmtTaEtCb1VkdnN6UkdnVjVyVDFG?=
 =?utf-8?B?ZXNnYXQxS243MkwxTjhvVTU4akRremwyemlkbjE5OUdLVkhsQlFvQVZibjdj?=
 =?utf-8?Q?2pFLH8CnXLePCKoejg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd85bdef-bc7f-4f4b-6fb7-08df454650ad
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:34:01.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CclyQk6YPOQ+Exb7LflDSdMYo57jIk9mtHPrVn1FJzl+16k1BeAm8LItqcpegYfmjW3EVUh2jaWqFXUiteQxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866

On 17/11/26 23:48, Leon Romanovsky wrote:
> On Mon, Nov 16, 2026 at 05:13:59PM +0000, Robin Murphy wrote:
>> On 10/11/2026 12:22 pm, Leon Romanovsky wrote:
>>> On Mon, Nov 09, 2026 at 01:53:02PM +0000, Robin Murphy wrote:
>>>> On 09/11/2026 7:33 am, Leon Romanovsky wrote:
>>>> [...]
>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>> index b486b8bbd1fcd..8be2a246d4903 100644
>>>>> --- a/drivers/iommu/iommu.c
>>>>> +++ b/drivers/iommu/iommu.c
>>>>> @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
>>>>>     static int iommu_get_default_domain_type(struct iommu_group *group,
>>>>>     					 int target_type)
>>>>>     {
>>>>> -	struct device *untrusted = NULL;
>>>>> +	struct device *restricted = NULL;
>>>>>     	struct group_device *gdev;
>>>>>     	int driver_type = 0;
>>>>> @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>>>>>     		driver_type = iommu_get_def_domain_type(group, gdev->dev,
>>>>>     							driver_type);
>>>>> -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
>>>>> +		if (dev_is_pci(gdev->dev) &&
>>>>> +		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {
>>>>
>>>> I think this should be the generic device_is_adversarial(gdev->dev) now - in
>>>> fact probably all the dev_is_pci()/to_pci_dev() stanzas aren't conceptually
>>>> PCI-specific, just an artefact of the current "untrusted" flag being so.
>>>
>>> I wanted to do the same, but iommu_get_default_domain_type() may be called
>>> before the PCI device's trust level has been set. At that point, we are
>>> still in "disabled" mode, whereas device_is_adversarial() checks for
>>> "adversarial" mode.
>>>
>>> The below is from AI, I asked to present me the path for that:
>>> --------------------------------------------------------------------------------
>>> For a newly discovered PCI device with an available IOMMU and a new IOMMU group:
>>> pci_scan_single_device()
>>>     pci_device_add()
>>>       device_add()
>>>         bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)
>>>           blocking_notifier_call_chain()
>>>             notifier_call_chain()
>>>               iommu_bus_notifier()
>>>                 iommu_probe_device(dev)
>>>                   __iommu_probe_device(dev, NULL)
>>>                     iommu_setup_default_domain(group, 0)
>>>                       iommu_get_default_domain_type(group, 0)
>>>
>>> For a device whose initial policy is adversary, its state during that call is:
>>> dev->trust_policy          = DEVICE_TRUST_POLICY_ADVERSARY
>>> dev->trust_level           = DEVICE_TRUST_DISABLED
>>> dev->trust_committed_level = DEVICE_TRUST_DISABLED
>>> dev->driver               = NULL
>>>
>>> device_is_adversarial(dev) = false
>>>
>>> The active level changes later, during binding:
>>> really_probe()
>>>     device_trust_prepare()
>>>       __device_trust_prepare()
>>>         WRITE_ONCE(dev->trust_level, DEVICE_TRUST_ADVERSARY)
>>>     dev->bus->dma_configure()
>>>     call_driver_probe()
>>
>> OK, that seems less than ideal. Feels like it would be better if bus code
>> set the initial device state prior to device_add, so then it only ever
>> changes later as a result of an explicit attestation/acceptance process. If
>> the initial IOMMU probe still has to poke into bus-specific code to avoid
>> always making a worst-case assumption, doesn't that rather defeat the point
>> of having a generic abstraction?
> 
> As Jason said, this is part of a very large series. Each series is an
> adventure in itself. Even Greg's seemingly simple request to convert the
> USB authorization knob to this new scheme has been extremely painful
> because of AI reviews. They keep pointing out bugs and gaps that are
> automatically attributed to me simply because I'm touching that part of
> the code.
> 
>>
>> Even with the slightly dubious argument that this series only intends to
>> shuffle the existing PCI code around rather than fully introduce the generic
>> abstraction that it claims to, if the PCI behaviour is still just based on
>> propagating the internal "untrusted" flag plus the new global override, both
>> of which *are* known at add_device time into the common trust state, then
>> there seems little excuse for not doing that up-front so that the new API
>> *can* just work as expected.
> 
> I would prefer to keep both PCI and USB out of this series on device trust
> levels. Let's see what people say if I drop them in v3.


I'd rather you did not as it is going to make experiments with CoCo VMs harder.


> 
>>
>>>>
>>>>>     			/*
>>>>> -			 * No ARM32 using systems will set untrusted, it cannot
>>>>> -			 * work.
>>>>> +			 * No ARM32 using systems select a restricted trust
>>>>> +			 * policy; it cannot work.
>>>>>     			 */
>>>>>     			if (WARN_ON(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
>>>>>     				return -1;
>>>>> -			untrusted = gdev->dev;
>>>>> +			restricted = gdev->dev;
>>>>>     		}
>>>>>     	}
>>>> [...]
>>>>> @@ -616,6 +608,28 @@ static inline struct pci_dev *to_pci_dev(const struct device *dev)
>>>>>     {
>>>>>     	return container_of(dev, struct pci_dev, dev);
>>>>>     }
>>>>> +
>>>>> +static inline bool
>>>>> +pci_dev_default_is_restricted(const struct pci_dev *pdev)
>>>>> +{
>>>>> +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
>>>>> +
>>>>> +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
>>>>> +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
>>>>> +}
>>>>
>>>> Unless I've wildly misunderstood, I'm not sure this is right - if the user
>>>> has set DEVICE_TRUST_POLICY_DISABLED to explicitly override the bus-default
>>>> behaviour, but that leads to the IOMMU layer special-casing all PCI devices
>>>> as adversarial and thus force-*enabling* all their trust-model restrictions,
>>>> isn't that pretty much the complete opposite of what was asked for?
>>>
>>> We have two levels: policy - that describes the default of all devices
>>> for that bus. level - actual decision on how that device is going to be
>>> operated.
>>>
>>> "Disabled" prevents driver probing until the device is authorized,
>>> "Adversary" permits probing and requests the available protections
>>> for operating an untrusted device.
>>>
>>> Both need conservative initial IOMMU setup: a disabled device may later
>>> be authorized as adversary, and authorization does not rebuild its IOMMU
>>> domain.
>>
>> Urgh, I can be absolutely certain I'm not the only one who is going to be
>> confused this way... I see "disabled" and instinctively take it to mean
>> disabling the device_trust *mechanism*, as the logical thing that people
>> will reach for in terms of "I don't care what this new thing is, just get it
>> out of my way and let my drivers work like they always used to; I want to
>> disable the new thing."
> 
> I completely agree. I was under the impression that these names had already
> been decided, since I picked up where Dan left off.>>
>>  From there it then also makes perfect self-consistent sense that
>> "device_trust=full" would be the opposite end of the scale as in "Apply the
>> explicit trust model 'fully', to all devices regardless of their bus-level
>> default."
>>
>> Now I guess you could name it something like "device.default_trust_level" to
>> attempt to make it clearer that it represents a value the value represents
>> the "trust" *of* each individual device itself, but TBH it's still liable to
>> look backwards to many users - similarly it's hard to guess that
>> FOO_POLICY_DISABLED might mean something entirely different from "don't
>> enforce the policy for FOO.", thus rather than try to contort the naming of
>> everything, I'd still be much more inclined to just flip the meanings to be
>> more intuitive from the outsider perspective.
>>
>> Say you upgrade your kernel and find your boot is broken because it now
>> flibbles, but at least there is a "flibble" parameter whose values are
>> "disabled", "wibble" and "frobble". Are you really going to spend time
>> straight off reading up on what flibbling is to understand what wibbles and
>> frobbles mean? Or is your instinct just going to be to try the seemingly
>> obvious way of disabling flibbling, and then getting positively annoyed if
>> that only makes it flibble harder?
> 
> What about: blocked, adversarial and unrestricted

yes, that's better.

> instead of: disabled, adversarial and full

may be simplify: blocked, restricted, unrestricted? Thanks,


> 
> Thanks
> 
>>
>> Robin.

-- 
Alexey

