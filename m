Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8815A85A;
	Sun, 11 Oct 2026 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791686289; cv=fail; b=Hadsmtdea/tjuEgSI0sjrB57hXQYlIw2cth07XVffLrRUQ/DI3UC8aKKmRjYPoDxdnVgpAqEFHpt61ajcYALlQxpvADQxJHZUjCZ7+AEg32eploplycxnu62zNjq5lj5mtwsedINaxT9WqTCDEI+lyzkgeneuf6pDHtoZA3QVEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791686289; c=relaxed/simple;
	bh=5HQ3/JPLfFto50zHwI7CaIgzwfIO3mKSrzL/K4GU7Mc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXuYb3yVFFw02MfKn3xKQUo67SyHvY0xEk7daQVSD/TGQR/99SeMR43+3pY/iIN/b/EvdqpxJ/ZnINVQ31Xzoqevn9zsZpcwpXlUZIpMoLH3PObLr5HCOo7ZR5FV0b+VzxYLSXdfeCKQVebLZ9quS92gHdG7FpbCSJbRUWWpIco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lbTz/XLY; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lbTz/XLY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNp9if1zGecwOZroKCCJEc9ZXo6GdzOoi4Gr1ZdvdHCANHhc2IP6dpTIa4KJ1mUa+zMqzinXGXC3jzEim355iExb2WOufF1xSLgtLETQ1ZX73LYTP+mCWtJfL3L2gsDxXw3HVNd5oF/lflD1OSyoJGUKep+Ev/K7n6/coczjCC0IV3iotwPH8Twfsb+LNHl3scO++/rM+bSjC5m4ueieHtElWfquodyVjSsDPrmW7rFwZfU4NaUT0f6t94a1qEy0JUc3mjnUTNh0ThK45F6J6dtbnSrJ4Km2FzIr8stY5C2MXuMP392lwqyvlzlxsozXi926KCSupVnfr1qYAnG18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RevYdIe1eD3eBkv7I9lvypp+HzMeXjwFpeGwDpgal9s=;
 b=ipk3hHOgcFNEYhqwtX2mBxjxrmZtGo4DGFf4qkEWKTeqNLdx3XfFS5aPdaxNuzUJGRRgpuJAsRdsPv/mcVDRK0pRBlRjS8h89pVp32HpH39xRwfh4LJVDTP1wVhsjZc66sL4+qszZUAI5Rd98O+jBOdEir0tTt/3ROZBtOKSXECxa/y2px82xH77Data7Y9j32i/+Z4lEDXK29jKfsGFHQtMSQTqqvDaqPCKXiHV01538yt3irBst+CWanqtJhkoNq0knRIaGsFT+TWD3+FMn/Q7iGdrK2p3FaGNs8DNSqPuK8kAHugnKQbRPHxG6TrDTlvO5TALmileMu2qPh2rTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RevYdIe1eD3eBkv7I9lvypp+HzMeXjwFpeGwDpgal9s=;
 b=lbTz/XLYympoVhyY5Ed559Q83NWeHMrzfDETAbRYqxWI1Eg2flZ0wIfLTDxvwqJcaetOmMWKNsqPSrR363UY4GSpPbYHXmU+4+/btFkItqpf9ti+dPOJozX2DB6/4IFILVx1GMBRZ32Jlo7JYJ4PhjGwZQqnh9MUMdFIEjHeguApUjiwp/DZuY6JGblRMepT3HflY70HhrnoCVPyexWhOgoxOp8oWvkYWPA1C83dmJ0+6nROvub/WqznUH5RM96+kXhGGfv5tXFh9uE2vuaQGL7QYoWZ5FytHyInzRTLLQJAq2WKKeCE9BAeqDR8njoZFEhMJVSUy2MhWyESWtlhjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DS7PR12MB5838.namprd12.prod.outlook.com
 (2603:10b6:8:79::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:38:04 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:38:04 +0000
Message-ID: <de39c363-e4b2-4742-ab6f-f3cafc8d9f31@nvidia.com>
Date: Sat, 10 Oct 2026 19:38:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/16] cxl: Embed decoder configuration in a
 standalone structure
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-5-smadhavan@nvidia.com> <ar-DyY5n-40PVCTI@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <ar-DyY5n-40PVCTI@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:a03:338::27) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a4db7d-dda6-40ea-1fb7-08df2740acd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|10067099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dqY+wMSMlR7ON2MrYn8E7Er83rFvn1U7ucFUO+Zd/LRL9dqGPN+tazMD2yK6nHgAB3jKyUOkZj38t2mC5O1/uZ2So0u7D6Xs5V6Uqj3IO5Au0cKrh3LwAPZmxpwCcHnwIInRG8azU4ofVEjlSS8j6zAAejRgTAQb8i4/3oAKWgrrytz027hIL9MhZv13UZIHiCKDy8+o/ICSIEnH53sVXNFbQMx6YZxAhDczEl9x5xacNP4EJOHq6aqtloHWG+hK9le2xUH7mbp4Z3rJb6G+SEeW1XdLIcuRMeVOiGouth0i0iEBTiGQDllsj0Rh0rhgSISPzpL22APnheu0bPzOwIM0ot15QgTsDV51H9u0rofHjWhjMGgx+envJMWeEWcaKhp7VLtub4TM6IeCeNwAAsTv5XRNUWuU9UQnD076I0JOtQGt6AQNK4sS1vVbIcv+yo6SRMXV4Y5EL4YdeYN4CyeCPjjXQWYsGx2n3Hq3kIitquYLPMGk5+zeZ1ROFO+Hy9Uu3PbYFQVMYj8cZc3ecP/Sp1y/TBHZ2SkBtUeF7QolhM8qmWxeg0ZN0hSCiTYPI93b91yuZz9/xBr+eDx0j9m1H3N0fW4K8O6QA488ElT7CxgBeCRet/jksfjnBmFbQoj4FyhZqBT/mvlRMAkl6aTQvqX4jzLNVsAoTVNZI4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnZ3QUlmNW9ZSmhnVEszMk9JV01NekJhWHZBOUl3bVBtR0s3bFk4OWdVdi83?=
 =?utf-8?B?WER6SVVKcWhoVXVIanpqVG13NW0xVkRGVDJnL2RtdE5wdlJQMXlUSWFGZHhz?=
 =?utf-8?B?QnJaYmJpVHlrN1FTRGRxU2x6ZnNURVdsZERITlhRYzgveGhuREU5bkJGbFJn?=
 =?utf-8?B?QWpqR09TMmtNMXJhNDJRcWJWNk9zWUpBWVpKM0FaY1JURXY4V1N1QU5aRGsv?=
 =?utf-8?B?ODNKNUdaVzhuM0NiRGlCeTVWbmJlYUVTRm1jcTFBd005RmVla0dsYmxqOThM?=
 =?utf-8?B?aXdoNnhoekxMTlhPYnVZUVhQRUs2V0k3dkJJVVFPSmNnZGJ3Z2tLWDVIakVI?=
 =?utf-8?B?ZlJId0djcVlkQitYOHFaTm5PRitJdmNVWlFzNjVzcDVlMVdpaG0xZklHejhn?=
 =?utf-8?B?RlA4TlBtTndUN3MzOExGVVpnOXZ1VFAyd1kzU01ONkgxUHloRTNHVGlDRXRn?=
 =?utf-8?B?bytzdDNrUm5aRFVzK2JqVU1EVVFIaS9zcUpncU9rd2w3aDdhSGpsK2Q2N1Ri?=
 =?utf-8?B?R1gzU2pTWnduanpSSm9YWXZqVzVwdWVYdUUrNDNXbEtZNVloYnpHb3E3Q1Zw?=
 =?utf-8?B?V2tEeGVlVytkYzFOWWtLTHZ2dWhSMVVOaERwTFpPQ1d4VHE2R2dUWUtkZ3BV?=
 =?utf-8?B?bkhHZ0orNHF0Tmx0OURQb3ZlVHV5MEcxQ09Eb0U5NW1wTW9XRitmM3lGelNz?=
 =?utf-8?B?MWFXSWJUWE9seHJOODAzNXFKSU1OZ0lveGRnSnhtMktRbzVPLytERmkzaW45?=
 =?utf-8?B?SHBpU3hZUU05TjhLR0VYUGF1TkJSUkU4dzMxN2NtRGZVVDA4cHBhT1Z2dmR1?=
 =?utf-8?B?SW4xYWhBcnVoSEhZcmpTQ2hEUm9YUU5VUzFvbGtDWWxvSFdzTHBoN0d3bzhn?=
 =?utf-8?B?RTNpY3R6dWdwYUMyMEJtZWJwak0zaFlFbHRoQXBJdDVoMXdDaTZOYVlnUng0?=
 =?utf-8?B?YXFGelUzNFpqUnFEcU1URU1TVXJVak1IYlI1N042bGRyMHpCTlBWNWl2K3M2?=
 =?utf-8?B?d1oyMnpud3VCUURFc0RrS1M3WDhmaUt2MjFBamxSSCtXMkVmbk12VEQvYnhN?=
 =?utf-8?B?YkRUTUdCWXdNYlNSSmNNUVFwZENZUStKb1JqaGdSRW9kb1R2OStPanQzUnJQ?=
 =?utf-8?B?djRjMTdBRVdHM1p0cXpkNDl2UWl0VE1OV3ZWWmtDQVdTSnlEQnRPSDNqc2Vy?=
 =?utf-8?B?a3N1TDBxK2xBVHRpWENQTFo3SWVoTnRkMEQ5UjhhYTQxY1FGZGZnV1NscU9p?=
 =?utf-8?B?ZEVhNWVCeFZWejNyQUhWNU5yY0VWSzI0QWh0dXRlTjVFb0xUS0FHZXFTWXVh?=
 =?utf-8?B?c2I0ekx6Q1FGRU9IeGJScGtXejc1N3ZSWTdoUkJtZDM2eXVrV2ZQN1lBd2NI?=
 =?utf-8?B?ckRTdDhUZlpxQkpuTG1oMGpCRDlBS0NPaDBnUXFXL3BOR0Z5em9RVWg1dlNS?=
 =?utf-8?B?STJiSzFRM2xDeDVtc3BNSVdqVktEL1hjSENxSGNVMm5HWVR4K3RIU0NiV3BM?=
 =?utf-8?B?dmI5MkZRa0l6dUJUd1dOMWJFaDNLQWZqanpPYmdCV3hsdEpiL2huSmJkNmhs?=
 =?utf-8?B?QjR3cExNR0poUTVMRHp0MFJYVVF5VWkyN0daTEpNeDdBeFEyb2FqUTFnSWJj?=
 =?utf-8?B?N0VUdUF6QzdoWlk5WStRc002SzF3dHh2cXVFc1RlSWRrT3poemlIMmY5bUxh?=
 =?utf-8?B?eDhPZ1FUMDRmTGNWanVhMHdSSU1sYnRQVEhtd0xUOTRmVEdmZlpzbDlUMi9n?=
 =?utf-8?B?RnN3NVZaTERJeEVMZWRUdzBPL1BOZzVjSGVDUHBuMXRyTEpEZENwVDZ3T21l?=
 =?utf-8?B?cEloUnd2d2JCZTRVSXFIWTFJcFo1aGUwd09kWEt2azgrRU9pM3kzYy94UXBR?=
 =?utf-8?B?OTc4cVRtRVRHOGFXTmZ3ZDM1MUwyb21kQ1pkTzhZL1puUm9oQjdkV3ZmeHJ4?=
 =?utf-8?B?WlJ6dmx4U0k3ZFlCM2EzYmJOcmY2MWlKdzBhL0MvTEdpUDJkallXc3VQSnFr?=
 =?utf-8?B?NzFmT3p1RzJsQUIvOVlNN0JLNnhNcHUvWjBjZW5aVnRNWDN5Mzk5anFFYlB5?=
 =?utf-8?B?S2pGTFNvUUlhUVpybFJqNFFqd0w2ZlRSTENDcGN2L1BDTE9KTmtzOEFuRXZP?=
 =?utf-8?B?ekhwS2lCQ0hZaVM2c2pBVGhJTGxFOHRJOTBQQ250cE5DaGV4NTdXSHMvcGh2?=
 =?utf-8?B?b0MxdGNiOVl4VXRpQ1ozbllNQ3paUWRjaUg5RlluSFRSc0JsYUFKRlZGQkNv?=
 =?utf-8?B?K3p0WWd6SisvNGJ5c01RWGhCem9Hb0krclZyWDBiMCswekJDMlFMUXpCRncx?=
 =?utf-8?B?YVFXa2RiWnFiUXBNSHRlby9GRHVFKzZPRksvcE5FU1NIcFZySWZXdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a4db7d-dda6-40ea-1fb7-08df2740acd2
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:38:04.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fDovNbhio/WusIHWXFXQb+fAQ/lCLRNo0c47cI1elGnS6jDY5vr9hLW2xv+IQCItZnXNxeKFdsfCDntJoAL9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

On 10/2/26 3:17 AM, Richard Cheng wrote:
>> +
> 
> Hi Srirangan,
> 
> Just a nit, from the first glance I would think this struct would match
> FW-config decoder setting, but in fact this is more a common linux representation
> of decoder config and state.
> E.g. id and flags.
> 
> Also target-list/DPA skip values are handles separately.
> 
> Maybe a short note would helpe readers understand this isn't a complete
> snapshot of FW-programmed registers.
> 
> This is not a blocker.
> 
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
>

Ack. Added the note in v15.

-- 
Regards,
Srirangan
