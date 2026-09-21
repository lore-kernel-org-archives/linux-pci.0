Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9E4A3F21;
	Mon, 21 Sep 2026 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999773; cv=fail; b=ES5SoRKZO4esQ0Wcb9qgPAOoVWwtUwfDc7DRTUbtGuKPs5m26SXE3N1wQJj4du0wDIjnEreZQPB+z1CNLEwUitLZXuYXFSiNR4ckrZcx8MZvncfiPQV3fGoYtaZf1gKNPtPc/cJY3UF0B6OTmsSQuQSmUFrl/uc/r/qAPW4VkA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999773; c=relaxed/simple;
	bh=ezl6hu/PYlBSTrbp7gqmgaIyl/IsWAfzu6RBandvF8E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHJB3b3f9I8lACPhmhmlhqSDSwSkTjmf5TdCYAH5c+PRZJ5/9wmxZN+Vp5XoDh9qB3z5VkVZwamGWxBFZ+EgeNKeV8gSCew0+vzkP2gueus8e6a/9b2sZl6jOqnUtsdbH8HbGzgFRvgNgsReK0B2a/w1TovMv+8dCqNrulcGmkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QrqLEtv1; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QrqLEtv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hvci7PuPEfzataSnbnEvRLaicVm6HwkVLR54Q2yaJqxZcWRaz5ioPQVWB0pwv9l8Hk/UUaxVfiEtbrfDiKyUgllZoKMhoAtgtNR4lFpa+hnBm6MPICx1JkXB0Wm87dMNlYNq6/l5RQfrxjpoAYMG7DuNdIjmEHrTJTyN/Cs6DItsqWXWsVKScQpZwb8RNXr6IZyOO4r25a0OtoBoWRjxFF7USBhOxswZEGwGDsbSyw4dM1j2uDFeBfqMn7fGA4JKZrNCNqOSQ6Jh46HA3D1g/9wBxqOrwj+tlUtguzKD4RHmC/e5b10oskeFC+0hfYAmtO4CBHLkidPlO0M1U/lNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAvNKyw4jR+5GO2E7NWgplkAu4S8ZW4MB+rp5ocTqMg=;
 b=BUODwvp1V8Xx3Bu533xAP1+y/5msRIcOwWOcQ/LpPOadyYCpvJ0gAotOWe9XQSArh1SCJNmfSX7aK/8BmeU2rntaaRLfZeprXjoYWP8WqTjmEMWutbCjgI3l795Ng+MzQYFgKVVLw8Ezp3Yx7kAwHVT3+sTH4967TwHwJGnzkPdkHIGlyVWbElZF/MbzZqhAIThh67UzDBkWjf33Cw1x72qYnGUgf3NgbJb4LognkFRtm4ulfyUanzfRwLI7EOU+GhKF+nc2Z+iBuEBxZ5hOaAksnUwFI7Achw91tf04su/nr6/Wcy0bF/dflfsNsR1Q2DKfXOjn9R1vQVJDGBR7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAvNKyw4jR+5GO2E7NWgplkAu4S8ZW4MB+rp5ocTqMg=;
 b=QrqLEtv1uEUOL/JCervbfGtj7tAWTGS0Plhm9I2vwVZ4xLWcV3TSOrl7vWQFJvmb2U5HhXPPH+3fIwIrNcAgsjoQmvgTB6YkFje9B+bdq2gAIWS9MNWEnIB8BY8MpvdNze4F4Z1pLgSGDvwDllDFKtOt0FodeCq2ZhlsSff+lgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:09:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:09:24 +0000
Message-ID: <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
Date: Mon, 21 Sep 2026 16:09:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260921134924.GB1507824@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 432d80df-c616-48c0-6916-08df17e9f07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	p/QIaG29wiQG5UtvpcfRRvUDQ8Scv7zrkxxtJj7EIv4F6pMcRhZjplgsYVQsD7xheeJHQYCf0/1HgLC4FbKAK8KlMJmmVGlgU3YWw/+1zk+otg23rMOfbKVVo9Y/ijSdgi62khOc5nr+gmFV0SGyyyfCfVrQH4k+DPZmsBnsBR14r7XCaLWCFkTrKO58H7389XUNg9SrIukZ5jCeh5Le/PFmTBzIyzNNS1tKUXb3w3K3zz4yjVTgN/prs5/CjvBGg8R17tWLQGq27JNc2JUDMuJWLFvLOovOSZhzHuwel2XwroI9DqZJl0rLc1X8z4XeUXuGB5Zwgx2sCbk+QDH9E9ikqiDWL6qwBs0bwKsH8po+hWiTG7O4YVAWxrfbzZjsR8b2wDT6Uo68MocgqneBCxW9F4tZCSCghL0mhns9SEJtd/YOwgnsZpwxft1khi36qQCSLEP04AnapIaPmILcbSDqSHnJwGbvNY5CwNkJsN2T+xHFn5HNKnGUMSC89d9ENyrGKhD22+1fzpI78mksjPeK5pZ5gi/wTtjVitBk0ecMyrZFHgLQSW4O3WRCWxEjMIojV/VZZDSmsyTYAemW+bTh4vlWV5L0K0Hluqi7ox5US7QSaorPnLVBjlZKobkNrRd0ml9ma49A1hTWOdCUib7ar+0oSa/DFirvOhwYteM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUQ4cW5wY1BrNE5XRTVOWUVxTFErM1VNN0NnZUh3S2xXT0djTHFVcGtRY0Ji?=
 =?utf-8?B?ZThwNFJPRjQ0MjRlZEdnR0NtQ3Ewclg2UVJhQ1o3VVpmM3FoWE9KcS82UlBI?=
 =?utf-8?B?QVhHbWYrMm53dFloVFNDU2xVaC9Tc3JJang1SEN2eVB4VGQySXQ0eW05SEJw?=
 =?utf-8?B?OW0wZjVSM2RMRElBaWJjSDNKQzhuL0c4Ym03Rk9CakdjaUVsa2dXYk1CSEll?=
 =?utf-8?B?RHJBUlpLTEJBQUpiSGV6aloxZXM1THA3cHBYSWY4ckg3Z2NGaGhxNU1WRjdM?=
 =?utf-8?B?OERlWEhIM1ErNHdqUGRPcjd2VXQzRUVxT29rRGpRVzZNTlBGamMyQjJOQVlS?=
 =?utf-8?B?TktlanRQVHpWMkZUSTRCdDN5UE1RWlA0eUZXLzVRYzZndUNMRmtRWVVZeGQ1?=
 =?utf-8?B?Wkd0b2lac2NSMmI5eEZaYTRBZ3orSkdCbDNQK2UrZ0JURzY2dkJ2NDZhRkxS?=
 =?utf-8?B?anF2REhWT0p4dDZZaWhMVGlKZXozdHdOMHhQZG1hYWovaUI0M0t6K3Y3V25o?=
 =?utf-8?B?SjNpamxmcmx4aXhCSDJsTTB4Qk5BUlBDeVp3MnByY0hwWmdna2dwemdmZGNI?=
 =?utf-8?B?YTl5Vlp0ejd4anBuN1daTHhQa0ZDUFVLRTEzcFk2cVZ4bFlzQXVZNkZXYWVQ?=
 =?utf-8?B?dGtaTmM5NE1qS1NrWjNLcWh4aUpTcEQ3UUFmVXAxbEJyYWVpc25WdmFDajRQ?=
 =?utf-8?B?aTZMMzRvWVBzeEU3NlhONld0SnMwRTFaYlVNQzVoUFN2eElNK0xNR1RpZzhI?=
 =?utf-8?B?cGNJdm15VTc2aFNzWVNDN0thbW5BaDlvZTRydGFxOHc4T2ZtMXNLOUVQZ29q?=
 =?utf-8?B?OTJNdnRUMEdZZjM1R1p2N1hzS09OU0haWTd6TnkyWlk2YUV1ZVprU3R3TnNB?=
 =?utf-8?B?OTFQVVdIMlpERWJxODc2Yk9SZ1RTNUxyeWJ6cVZrYW1XMnZxWlV5allJMjJB?=
 =?utf-8?B?bjZGclh1VzZ0U1FZckwxMUdTVEcxMThqMmxUK1lvWVVUcGZGSWMrNFBaaGhs?=
 =?utf-8?B?Myt1bWVZdUdBM2FTZ29ZTXNtZmEyaXc5U3ZnVTJFaDFuWjZEcFpXVDE5Sk5h?=
 =?utf-8?B?djJVdlcrTDFENGVRK25YM2dLRTY4M05DTXRMUWdFaDZMd2I4cFMxQVAvdFRF?=
 =?utf-8?B?T3IvU2t3dmp0aFhnNjFMMjVwV0lybituSmpSR04vYUoxbnpZQ2ZNeFR5UjJN?=
 =?utf-8?B?UXVKdzZaUWFKU2docU0xWmxVT0FCVXNwUmhacmxQeHhnRTRWMDl4Rk9uVlh3?=
 =?utf-8?B?L3E4bHFvcWNad05vNEx2cWR4cVdJNWtPQ2Q5ZURyUyt5MkE1YTJ4R2tpTzhQ?=
 =?utf-8?B?NjViSnJWaHEzNWxwUEgyNEhoYVVybGdFNS9tSk9KTHpvTU1CRFNkSWtEaEVN?=
 =?utf-8?B?dktkZTNkWkREaTNrbzlvc3djZENOZjdMbjZ0T1Fza0lnbTZPZDZ4enJMWHFR?=
 =?utf-8?B?dWhRUHVQZXRxam5LNFBQVVp2ZjNyZU5jd3ZMSDNxNHRiMDFVeWxHS0xhSXNV?=
 =?utf-8?B?K2hHcGFPTk56SkJpSzEySDEwQkdhaml6UzNiQkk0S200QVZRQlBpNEU4Y0Vy?=
 =?utf-8?B?bnJUdlUxRjlWZk5LZFRlMDV3ajliU3QvaHg5bTh0YjI5NzAwWkc0Mkw5c2VD?=
 =?utf-8?B?cEJSeFBDV2dMTkdUSVZmTnVuWm5nMzViVUQwbitZekJmOXNYUGNKUmpieEZQ?=
 =?utf-8?B?UjdwbEYvUjBmcWZybHpWNFJtNEZocjFBWU84c0hqMnM1L0EyK1FZL1JjamI0?=
 =?utf-8?B?YWJJNnA2emZVYUhHQ2dtTERzRndkS3RQRWdJY1orUUZLcHRxVkR6NlgyTGJ0?=
 =?utf-8?B?a2ZESStUcEx3YVAzRjBhT0VNVDlIV2RVNmozMjBXQjhPOXdodE5nYVRXVWph?=
 =?utf-8?B?ZDI1MGlhYjVmYk5UL3lWaW0rTzdBWmNVNDI5U0lZMmlrR3pVNHo4c1JDbTRH?=
 =?utf-8?B?c0hvQWMrQlBBYUFxNkJCN2gzVndHZURjeiszTlR6eUIrdDNlU3UxVzFjeXJ0?=
 =?utf-8?B?NTlTb1RmekN4UGdXZkN4RndpczhhdGFvYlUwTmZDNVRFZnhUOFJwUXFTS25s?=
 =?utf-8?B?QjVTWGJWV0xqYU5taDM5QkFxUGdERXh0bFZmbC8zSCtLNEVzbmYxTFFZSnhR?=
 =?utf-8?B?clhtV1o4YlNCTk93TklJRE1ucEFxbmYrd0Y0SENybWVlVkNXanNWYmpaOVF5?=
 =?utf-8?B?ZHBVY3d2dWZHblVTOWJqSm8rRDBsM0ZwbTJUR3NtaFpVYjltODQvaDZPK2k2?=
 =?utf-8?B?RnFTNFRWcmQwY2hwWWFlcm8zVXZtUWZ3ZXhzY1Y4RHU2NTNLV3RlQkdxcmNX?=
 =?utf-8?Q?FZ39NQyZ90XD5CP50n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432d80df-c616-48c0-6916-08df17e9f07d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:09:24.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxhuZqEjTqa9KTN22iNW1/+P3pTBiNHSnccIU+Po6KwDihHKfVUFRuNmH+8zPTDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559

On 9/21/26 15:49, Jason Gunthorpe wrote:
> On Mon, Sep 21, 2026 at 03:45:28PM +0200, Christian König wrote:
> 
>>> The right way to view this flow is VFIO permanently revokes the DMABUF
>>> FD. Then instead of forcing a new FD to be obtained it replaces the
>>> existing FD with a working one.
>>
>> Well that is a little bit problematic. It could result in a race
>> when you have multiple importers.
> 
> This is all a "kernel protection" scheme for VFIO. VFIO userspace is
> expected to have unmapped things and is not expected to do mappings
> while also doing FLR.
> 
> The only kernel goal here is to maintain kernel integrity, not to have
> well defined semantics for illegal racy userspace behavior.
> 
> So from that perspective the races are OK.

Yeah as long as userspace can only shoot themselves in the foot it is probably ok.

In this case we just need to make sure that the flag is properly protected by some lock inside the kernel.
>>> That VFIO re-used the FD to make a new live export isn't visible to
>>> the importer at all.
>>>
>>> I think that is where this "temporary revoke" language gets confusing.
>>>
>>> Call it "VFIO reuses the FD to create a new live mapping" is clearer
>>> than calling it "temporarily revoke" which sounds too much like move.
>>
>> I would avoid that and just re-create the DMA-buf fd from
>> scratch. The extra overhead is negligible and one way state
>> transmissions are usually much easier to handle.
> 
> Yeah, maybe we should have done that. Might be too late now.

It's already uAPI? 

Christian.

> 
> Jason

