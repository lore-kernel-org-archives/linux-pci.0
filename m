Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9B30F7EF;
	Thu, 22 Jan 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077543; cv=fail; b=c5H/oIN86VjjkPytDWz9odV8/jMXYBN7YDN3hI00HivcTs9lrVDRoe8orsiQSur8EiajSWZStTIsL+FU7XrD/+536RST110PsVEEovKDGYszJ7Sm5ZULGRvFz7TTfZY0LvlQdfNtJX5wifNA/uA+jjiwovapFDxBF92zyf5iDyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077543; c=relaxed/simple;
	bh=HKEGjvaf64vjQAgCkZSimOGSeWgrw0gUCAYVLo6qHAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OpA4Zd2kRR0B5MKhnaFf5H1zwd6C0CYF/LXxW5R/2jJWyaJm5UjReZuNpNjuonGgwX+uyPXTbNqd/d3+Iox+Srky01FPiqyQ2Nqd3qIcbHWl4g1WUF0EjxzeV2f3l0Q+R5IhBlGx62x9pwXO6ABl0VBYCDVnPe99ikQ1nXIHOds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=15mqkIwh; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="15mqkIwh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX6roxmy1QPbTnYrCOmqTFeaoE0nJzIxFzDhZ2GqHh65Y9I/imWDA9HZXahDI/gQvG88rznwCXsCj3j24Jn61TYjxrg/XQE/mOaccFMVf1UsaHUZAzUpY7gXTWkCKD/sdsQs7WyNJzNJX1pbhHZPrXIe5Ppe/NDSsvCJEJJzKX7o/1pj3RbhZJRZqAFysmRbxUPi+4naBqJCdfp+0oNGCujtcvb/Sok4qbVELLihJjaqRSQSl8a5QQ3u8f1TpdxfzIxie5AHLFjWDIvwNPpjU+n8WHFim22uB2ztvVeT+ZE6xgdJLZTDjDaxQGLh5tdWJcYo78xWmtkA7XUHKQNJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXDPqyiLdtmkhDH20FlxniffaDaFHsn7ICjIijsgMVg=;
 b=aofN4Sq7fHVrvOi5S7ttncSq5WM44vyd+FNulwU8cOi6BqCIiYxk0xc+TxPXugx8tdtgSNZhUC7Wk1JrTUg94hpEQTElIqpXmiXaFlb2rTdpFhFldYBE//dQZ68U2OsfMQHC6LB7RmD1W7tq6O/KCbspcFMPabTlgX1lpPn0v44BFMagS/YoPH0VEla06z4H8aaYZXJyj8fXPRLYOVV8f2WbL9vEEAbgQWDej1OgqizkxsQsjkXaAfaVO2fasJx10xJAdkHLo1wzH/Zu2w+m/pjjZZXQkGkqQeeieZ0qszjkAvqrXK+Dh0I0MkCVek/cgkBSIHyGDH6Wl/dE9Tp/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXDPqyiLdtmkhDH20FlxniffaDaFHsn7ICjIijsgMVg=;
 b=15mqkIwhrW9rHMcZmEht6XgWgxbbhJhsfGJS0Xs7oRcFXCeAfWKkX74f/U+3jg1kf0DovFQsDngt0wBkl9391uqbksg2/eaiXJXkZsY7Wz7UBSXDqdtLK6NBHWyWapXCU5CMDC8S5P1Ds0HmeveN/IQMbi2ZeMU4xvNQC+dJEwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 10:25:38 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%6]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 10:25:38 +0000
Message-ID: <adf64600-1124-4e9e-9d31-b0f18f66496a@amd.com>
Date: Thu, 22 Jan 2026 10:24:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com" <praan@google.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-cxl@vger.kernel.org
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com> <20260121130315.GE1134360@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260121130315.GE1134360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0263.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::28) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 133c675d-a8a7-4914-c44b-08de59a0886f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WStpUlJ2Q0xXb3FyNWFvNlJlMXpzemZZY0IwUzVzbTdCQWxwRE52VlVRMDhn?=
 =?utf-8?B?bTdyWG5VcThqRldxTzZIU1dERThGQmNuWGxYRkVaWkFJdFhvVy9taE81SXM0?=
 =?utf-8?B?b0FLK04yRElqVlFxbWlSWGZaRmVNWXd3YUVYUjFEeGc3SmhEUGdSeGVoQUVP?=
 =?utf-8?B?Sy9Kbm5CdW5zR2Y1UWJSM3B0QWxlR3JQQzhYRlkwQm9NVEVhUWJvUSt3MEt5?=
 =?utf-8?B?SU5zZjJvYjlyZ2wvaDN1M1gydEpBejVSQ2JNRlo4UlJMWktzalVlTHdiNVlT?=
 =?utf-8?B?eTBjQmdSUnloV3A1T1VSdGU4Wi9SZXlaRGlWM0ErNlh2YmJCRVFTTXFlcGxI?=
 =?utf-8?B?T3A5N0JySU50eWVKeFRwSkdkcGVsWDFKRmFkdlpGa1k4Q0thc1JXajVlYzJo?=
 =?utf-8?B?SlZ4SHpOOXkwWFVUaFYzNmZnUDJNZjM3TkZjUW9QdFM1R0xJbXkwdzFIcUho?=
 =?utf-8?B?enlZY2orK2JBU0xpQ25RSnRRcTNaU2ZZSkhkUitZNWQ4bjBaUDhybTdPcE4r?=
 =?utf-8?B?dWtNK0lMdExRTTdYeVcrU3o3MEtvbXJWYVpVc0RzTnBXRTlsZFVYUzIzWGJN?=
 =?utf-8?B?K1RiQXlYOGg3UmkraXg0N29tbSt1WW5KYWVuS3JlTzVPVkVhMmlpR3RTa1dP?=
 =?utf-8?B?NlFvd1M1SjQ3Z1dBRERTNmdISU9mV2Z6TEh6Q2ZseFU2QkVKS0FvdC9UbXBM?=
 =?utf-8?B?UGRIcytJZnI4VjNvSE5jNDFzUTdBdngzaTk3eDZraGJwb2NEaTJnWHJBWTMw?=
 =?utf-8?B?YzBlUTNWdFc5VytjamlhSlJEd1pIZlQvOU1wNno2czVoOGk0MFhNWXJCQnY2?=
 =?utf-8?B?WDBnS0pNUG95ZFFPQ0JBcksvczdJSlRTdTlNWFhOZ2dzY29PbjlOV1pBTU9k?=
 =?utf-8?B?a0pTa0RkRGNPRGc3YmhrR1cvcCtUUXFTYjB6L25XRWg4amliTjBrdk9ndFcr?=
 =?utf-8?B?Wjd6QVRha05xMmZTWDI0ZkhwaGF6VXp6V2ptanBPSXhvRGQzcVVrdUpBR2lm?=
 =?utf-8?B?TGUwMWdFM2VLTUl0S3FvYkJRNEx0b3haWkRpT25BTytwR01RZlBJSXZKZlp5?=
 =?utf-8?B?SlBlWW10RFlDNDhrZ0pucXNrOFlhUDdMblFXVHRmT2xEalpOcU9COUlUSTlR?=
 =?utf-8?B?YVM5TzZDYVZ0YlptcW80ck9KMmhtb2dnd2QvcytBakpETktrbGNlK1dheFVr?=
 =?utf-8?B?Yko1SVFmNEh0UWhYZXlRVmVSVnBKdTNWYTJIdjhVaG9ZUlNtVTd4QkVaejJB?=
 =?utf-8?B?MGxRZTQzM2ljVmdIakZ4eTFRaGgvOFZKK3pHK24xWTlib1BabmRibExjRUdh?=
 =?utf-8?B?OXNJZjN4blJob2xvYXE5M0p3bEd1NXoxM09SRy8yT1NZZ0x6VGlvNXlGV1M1?=
 =?utf-8?B?RkxFakhpVU81R1NiMnIwdWh2MWJiRC9JYlJvTU4ySkxvWDBsbzJvWkFpVEl5?=
 =?utf-8?B?MXMyMTk1QWR1cWM4aW1LdXdWZE1wT1I5VU52cE8reld6a0F4RXFaSmRzWFQ2?=
 =?utf-8?B?SzZSeHZuNUY1TDlsVE52cVNZa2hJVTZqRXovR3BmYnIxdjBlaVJyS3Qrc3ox?=
 =?utf-8?B?aHZwQXVEQjRmV0x6M0kxZmt5UW9uS0lHYlBpaTRKQmg1RGErTEtHcWZoK2xB?=
 =?utf-8?B?WWEzM3JmNnBHOW1nRVRtRitHQVhXUXY5WTdRcHdNWXdicjNESXNOUTdTSWR1?=
 =?utf-8?B?QWFncEY1UVlLcWxZUmxBMU5jY1cwZXBESys3bjcwaHlUWHlMbWpndk9xMnNO?=
 =?utf-8?B?UkFVUDJWYkhnQ2ZEUURGZHAwekFsWFVDbk1TNyt6OEpIdGRNdm9yTTYrTkI1?=
 =?utf-8?B?N1I4cDBkUWxEcVVWVzdJSWhBK1VFSXlLSEtGNHNZNDNwNzZQT0ZPY2grb0l4?=
 =?utf-8?B?eEM4eHg0U2dxOThrVkFIVHptTHNSNTk1WU9DM29EUWh3RDk2cE0weE50QWpJ?=
 =?utf-8?B?SHVZbTZHRlNOOFI1Zlc1RmZJYTNMSDdkbXRkOFZFVFBSZWhzcDY3RTc1ajJE?=
 =?utf-8?B?ZlhzNjBFeXRoTGxxeUdSUWY2WFl6VjRzdE41dElHUldGbVYrU3hGcjF1UHli?=
 =?utf-8?Q?3anO6f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2FBYWllN3NKaVpjcGg4dysxQ2hEQTFmamNTZDF3TlY0Q292MUd6RXJqVDdV?=
 =?utf-8?B?Q29DSTR4eXJyZnhpR0Q3ditkU24wSGFEalppTHVLWWZnWXRlMWVQa1oyZ3Fy?=
 =?utf-8?B?VG5HK0RvRWEvR3VWYUV3RHdydVUvd3N3UG1MNk5sRVhNcjduYnd1bFIvTVVk?=
 =?utf-8?B?cmJ2L0laYUJlK3k1U0UxSzkwN3hTTUc5RXVDNG1UUkttU1B1eVREZWRrWW1J?=
 =?utf-8?B?Q201MUw1Z2tuRHoyUm1NZHZYR28wZU9TYmdmckhsOUF1L0hNdGFvdERaRVFw?=
 =?utf-8?B?TGU0Nk52bWJBandCWU9vZmw4Vi9RZVdGalBzYmJFbHBQNkZMUVBVb0FVU0lL?=
 =?utf-8?B?dFFEOTdvMkxNMENBckNwa2laK3B3TE8yUTVMR2hOOXZIMnJmbXpucWdhNUhv?=
 =?utf-8?B?aEMyS0dIa3IzcWJrKy9iWWJRMHhrUllmTDZ3Ym43bCsxSXFlWlhRb1BKVHdu?=
 =?utf-8?B?OW5pTUI4UTFkQ29jNWVpeWFERkFaOHo5RFkvYWhHcWswVnpJeGJEbkJ5NkpS?=
 =?utf-8?B?NGY0Y1JsYU9YZkhXQ3dreEZ5UjJWQUhmQVpyeDkxQjNmdkZlYTJ4SUV6Z1BH?=
 =?utf-8?B?OEJSY1RoOE1oUXlsRFE4U29RNTNpcWtVZlVIdkhzV0RBRi9qc1NMSmpKemxY?=
 =?utf-8?B?SlZTWmllVy96WEZFYlU4SzRra3JDL3BaekFiZExiQXFYR1VyMUNWKzV6V2tB?=
 =?utf-8?B?akFBK2k4MzYxVEpDaUV4dnpFbEgzMXNhK0pJbU85dDRMazBhWjN2cm5yV25E?=
 =?utf-8?B?OGV5aUdVK1BhNEZENkNnbEJENFlwUG1IWE1EMUdHODJtVjlTcVJTWUJWVnND?=
 =?utf-8?B?ZmlqRTZJeFFxVFFyNjk3emNnYWI0QjJmU0tYWW8zVGdweFB2U2hyV3QzcDll?=
 =?utf-8?B?YXBNRXVSQ0FmZEVZL01pMXFnREhjOThzLzQ4ZkZtRlZMM21tckh5Uk9OMUpx?=
 =?utf-8?B?VHpTeHMzT1ZKdER2SHNLVTVzSTdQR1BiTTM4TVc4bERxZGNTbVhMZENZcUlw?=
 =?utf-8?B?dVpLNlF6NGNxbi80Y1c5b1B6dGpyeTlkRE1nZ2pwZ0pKUXFRRkFPNmoxc215?=
 =?utf-8?B?dzhRclFRRjl6OVRXSisvbmhJWW5ZU2N2TjN0cGt5bm5yWGRlam5oak9hYURm?=
 =?utf-8?B?UjU0YVFHNHBCQVV5OUpZZVhjL0pFNUxGNlJlejR1SWQ4N1ZhcmpQdEhPdFZD?=
 =?utf-8?B?YWRyQSszQW9IN3BBdFZCZzlscTFkbGkxNEMvT2tSeTZTYmd6ZjNpVkxwWDdM?=
 =?utf-8?B?QkxNbzU5L2NzenRNbWh3RnFSR3lJWnNhOHM4eHRkV3E4aWQxVmsrTlBCaHFI?=
 =?utf-8?B?Ym5hbXpBaU1tL3Q4c045MFZMRFltT2YyZnY4Yzk4dFlPY2Jaa1dBVDVyZUlJ?=
 =?utf-8?B?RFhubFlYVUU2SXhWQkFOUGJmblhWZi9VWXgydEJTeHRlckREaVFOSGdJUDlw?=
 =?utf-8?B?TW16eXVRZVpyU0Vtd2JKVTNTTktOU1U2U1ZCRitYdVZzWWdnZ0JTRWc5UVBq?=
 =?utf-8?B?ZVNsSkF1a0VWMXJEOFVVKzNDME5VS3MzRlNZNEZJYkc1YlFiWU1FenhtQTYx?=
 =?utf-8?B?TERDWG9tQTFXdkFGQ0xxUFIydTljeitwcGdYSC9TNFBxRUYyUXR5Y0ptNTJi?=
 =?utf-8?B?cHlJamMyREd6UjgyMGhEU2h5SHVGL1RDSlpOVHNMSkg2a0hlWGoxR2wzdW5W?=
 =?utf-8?B?cGxrREk1aExhUmFWTE1jSXM1VW9yaTNiWWs3RXRsYjh4TlJxUElielpSblEy?=
 =?utf-8?B?RnV2NEJQVjNzWHNWRFNvMExLeThrOVMwOE03M1hSN1VrTXpwaE1JOVl0Y2F1?=
 =?utf-8?B?dzlnbXZ6N2JEZUJqWG5MRUlwSEVIb0hqRlRPNFJTWGtFblZUMk1BSEwwNVZK?=
 =?utf-8?B?Q1VnS0JoVFZxcGN2d2hWQ3doa3NlNW4yZEFSbGFLOGJ1Kyt4QUVOV1lmdTVM?=
 =?utf-8?B?WVJFYUFaZEUrRG9aelo2d2w3RjBBbE9VeWJqVkhKV1AveWxVY3IxbEtNOHAw?=
 =?utf-8?B?VjdNaWFjSzBsUGl3UTREcnpPN2JydVk2WElXQW80Z3pqUDZ1NVM2SjFieDhm?=
 =?utf-8?B?TVVLb2FUR29QQllPaFRQSDYwTFBQNlIrZHZSUzdtWUYxR3lVdnRhcWdrVDJY?=
 =?utf-8?B?OHVndzJ5VkVhV1dCOUZJZ0VVWjlBY1lGaGpjcktLUlY4L2xUNndTMFhSeHVD?=
 =?utf-8?B?M2VhWnB4RWtIUFM2RU43MnRGa3hJK3pVMFEvdGEvYkc4WG1oOGNFM3NtMHgr?=
 =?utf-8?B?REM5QSt2dEMzUkw0TVZCczVWRHZwakJsVEd1NFlvUDE1aHR6Y00xZjMxM0pE?=
 =?utf-8?B?MXVlNlE3L1pHRXpzTUQ4L1RobitJMDc0UmttOWdoWGFGd3JFcDZ3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133c675d-a8a7-4914-c44b-08de59a0886f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:25:38.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBGj7luZOrz6HeYDU0yjS0woIXVAlS/GAHI6Kv2onqCfzthhqLoRuHgcVp4zMqO5iJUbI98SE7p685vwNy//ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710


On 1/21/26 13:03, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 10:03:07AM +0000, Jonathan Cameron wrote:
>> On Wed, 21 Jan 2026 08:01:36 +0000
>> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>>
>>> +Dan. I recalled an offline discussion in which he raised concern on
>>> having the kernel blindly enable ATS for cxl.cache device instead of
>>> creating a knob for admin to configure from userspace (in case
>>> security is viewed more important than functionality, upon allowing
>>> DMA to read data out of CPU caches)...
>>>
>> +CC Linux-cxl
> A cxl.cache device supporting ATS will automatically enable ATS today
> if the kernel option to enable translation is set.
>
> Even if the device is marked untrusted by the PCI layer (eg an
> external port).
>
> Yes this is effectively a security issue, but it is not really a CXL
> specific problem.
>
> We might perfer to not enable ATS for untrusted devices and then fail to
> load drivers for "ats always on" cases.
>
> Or maybe we can enable one of the ATS security features someday,
> though I wonder if those work for CXL..


I raised my concerns about CXL.cache and virtualization at LPC: 
https://lpc.events/event/19/contributions/2173/attachments/1842/3940/LPC_2025_CXL_CACHE.pdf


I expose there some concerns, although I admit some could be due to my 
twisted understanding of what CXL specs states, but regarding IOMMU/ATS, 
my view is ATS is not safe enough ... what I guess is a matter of 
opinion (trusted device based on vendor confirming it is an "official" 
device not enough for paranoid mode with vendors subjected to 
governments "agencies" actions/pressures). But this links to what I 
think Jason points out about ATS security features where the IOMMU 
hardware can be configured for checking those translated PCIe accesses 
as well, if the host owner/admin paranoid mind decides so. With CXL 
cache that is not possible since the route is through a different link 
and AFAIK, there is no support for something like this by current 
implementations. I think it could be implemented without impacting the 
gains from CXL.cache, but that is another story.


So, FWIW, I think it should not be enabled by default.


Thank you,

Alejandro



> Jason
>
