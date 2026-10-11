Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9E3BB40;
	Sun, 11 Oct 2026 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791686745; cv=fail; b=pWRCW1swC32/e5q4Rd2pRKgOU7ePdSYsyVp6QIourj0CtlG/NdHclsKom9TFTi+RU16czhGUIle7GTwGJRM9oQljmU6y5V3X0iiMPH/gM5g2gIfy0L51QP0pBTL4qPilnhtoP3csmAMTE2yS42pe5dMs+Ysel6yYw+LprfYyPLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791686745; c=relaxed/simple;
	bh=PAeUWHoFNwChyf5cNBdHUmIK8GnU4usSOuwavEdYooI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GYLldnHrSf0V4GjrTO1sUl0KocrM+D/AsqrVzw1I1DpTNBrTq7mq6wB3xMuwSPZeieECFIvBST2lydgG+V0LINyzKwKTeN4/ejigw05tlUcpwUTCFHNiMaC2WKGSt5azGhORCZOydkT8u7cp2OkzG5u4rPrS8PKc2Ro0Inbm9RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=noVE86Az; arc=fail smtp.client-ip=40.107.208.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="noVE86Az"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZqzZaOVJKbATgw6ukP1+yO1v0qkTE2dq7p+wQxhgXFPK0znsYJWghi2WJcFQh6XWpgS+1PCTgd7/zs645drYlDz1GEevHzxCaibz9LFa7gccpZUg/4v49NMZJ5kqT0V/SyIMUjpaNu/MSSovF+ePHQU4b0JFbvuR26MhR3vwFKUXY1GK2CbmaIZUI2EFYW67WjeO+ua77AnCSDp1rM6cJ4YU8F6LogydYLuLXtrVy/7gOAqNZ7lpxkPeXvAsh2CQum87RoMq4XzY2FXvjNIoVKSwmwAN4OIBIl7rLsnsGWD0Z53F1pDZLgPd1vsPBP0SMyuwkj5JFHEaMQreZIxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg5V/i13uhUrI4u6lFzsB2F99PXsx3eEwNVQGZSYWc4=;
 b=ZXP59E9bJ903maWVOOYqqOAx/vJ3EryHw0JJLgLIqqvcBbXpbk68j0T1CtQAPlqZjFwFJL0+2KUQZswUgNzamzDWKtFMm6wLiB7UvsykVYlImavPnW+mSW+hOFExtBFwf/HfhQgj0/puuXG34hZb1psx01ibWiXsgEY2j4JPTp0zh7rFcMxc/lzDhxbiB7EmK/TVHdgGU8qAnlFV1tlu2w8ihwXHBN95dQx5z1OYqmX6Zve1PZlR/HljNFJN+Se5CH9yye0TJVBSAiF8k4g795RQwbzEcpxo8fqJHQLEKlDZ0w7qSP+RkS3uJ2KAn4b4T29ihC6aw3p6A2dnQJiVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg5V/i13uhUrI4u6lFzsB2F99PXsx3eEwNVQGZSYWc4=;
 b=noVE86AzufK6P4ePrLWrwvsAGvGOMtE8gN5+pzPhWq9MdxghZa4U49ZaopQPrUCs+BFqUUecqVgsAw6vIG1YtZFWeUuRn9KJpO4eJxHruVmlz2QH+IN0LNyVCLvpKbjRmNhD0zLZEXu7yMILgJZPAziQpiHAdegTsqcUPCDG5fmFzQZVo23M7jYqtjn2NViDKoH5IO1wD28LJbE+pXjj4tGpBboCqQNwxLnT2Id/gJzbVkHsyKQwLKVRgUM2nByp8/PpWt5eCOYkg8wQYMUex5uhgGGs17CWxLZ6boRnE55/BRv1Zyuk/rpNk8ZCLxrkViijZGPDRIux/HkZxK3y8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:45:39 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:45:39 +0000
Message-ID: <a5ab7bd0-a732-4009-9ad9-b60ea8d52a15@nvidia.com>
Date: Sat, 10 Oct 2026 19:45:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 10/16] cxl: Cache endpoint HDM state during PCI
 enumeration
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-11-smadhavan@nvidia.com>
 <bcc1d04c-fd5f-4c65-bafd-c17b8bfe5011@intel.com>
 <asafh2lu2PJ465gF@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <asafh2lu2PJ465gF@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:303:6a::10) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: b0289264-c75f-42e7-4be4-08df2741bc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|261009223027099003|56012099006|4143699003|11063799006|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	tdrUsL4MLzT/DKq5iUoV66ehGT74dyVxEZGEi/ydO+Dfvg1l8rrqkkOLtvTglCcePC/fbgYMBhnOkH/vmDNjur7QvD1wpA4vDNTnyBclv3ygM/jNaZoOKFHenE23W0UhcfMWA1zjgDiHPeTuOe0remOGVkESsIClzCdzawxargd+n43crwh4vAYvfYPmvs5ySVTsqLBRBLzfoPwCnEme7+2Cm+tFyT164fbkmWb7Zc8dpUEYQRf27K7AnDfIAwBoKa1EGpNdl0tx51DYHnCdI4o2wO8ywWbO9Bm2rY2nntDApGMDxC4+jApmyBvTy5qXVU2pWjaE/HdoABERYuCnAKr4hKi3e+/cunQAA1MO5Dz8viQa0iNp7sCMODjrYoo3ogwOYl41Q9riQ40260y4Gli/8fCSwGxEUvLndFBjhFtli/QXoxO8HGacfXr96Q7VRCIGAFMH6VeN3zyufszPl2YlgdcUOplere9FRBEeVUwbTvltLpgEyTQVDwsN01F1TUslDueHXy3dRsSAbYgDi7VWCTPMyrxPU9cy15qjXx8UjbBJGO8KrJdOV+usmJTRA4v0M6dhrwJWf8LcqLb9erE8viu7hClC0KO82OBeV/DdegxxMY3F1BlxGGWihMKxQJ4GQfPeMALwRJzTJduBNsW06qvkuXzZXJ3TRvuapJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(261009223027099003)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TktULzl0RXBqVWcvaDVLSExXT1FzczBIUjR2UWJGZW8zUWZKb0RnV0JBTXJQ?=
 =?utf-8?B?aEhwNDM1RCsrMjk2M0Q2T1Q1czFGbEJhWWZlRUEza1hpS1UwaDRuY2NYQXN4?=
 =?utf-8?B?ZW9lTzRKVFJNU1pmb2FBaUpEdUtVL0dzRnhudSt3SFk1S2x5VXpac3NnSHJU?=
 =?utf-8?B?M0prYkhNYktmKzBINUlYRHEzWUkreUtSZzNQell5dExJSzNJTjBvcVh3SXZr?=
 =?utf-8?B?YnloVWhIS1Y4dkVzSEVHRHlrenpqc0N6cndsUTJFWFU1cFZPRWJzanRYTTln?=
 =?utf-8?B?aVZSY2dFUU1TZVlPMXczZVRFZUd0aG90Mk1kTlgvTTNQUDVnbnlNaVhVN2hB?=
 =?utf-8?B?ZFRFZnhZaEtUaVJtN2xtTFRCSEtkT3YyQmF3NGYrS2ozRTZ4M1A4QUtZbU56?=
 =?utf-8?B?WElkRUFPVG4zSzJaSVVhTFVWQ1pjZnJKSVlmK0ZWQkQ0NGt1VCt2eFYxL3dO?=
 =?utf-8?B?WWtUVWFIVWFub29odFR4RnFuYlVlaGhUYk14L09UMC9EWkVYam9LK2ZwYzR0?=
 =?utf-8?B?YkJPM3VHYmtQWFlLVFh2NFVXVkxKTko0bTkybVZHK2hKWTR6bmRldUdJNHRs?=
 =?utf-8?B?T1VzS2R0Yyt6bkozRmtsdWZ0QlV4dGQ3bmQzajVLS0VWTlQ3NUFjWEM2UWNi?=
 =?utf-8?B?NHBnUGwvTUVpRDJSRUR5Ymo4RHBDWno4S05oZFR2YTVwUFNpcDQyeEZxN1d3?=
 =?utf-8?B?Mmxhc2sxQkYrZko3K2k2Z1psa3J4Z2Y0aDRaQmkvaGd4bjMvSHlRYnNWc0VD?=
 =?utf-8?B?c2Q4bXk1c0xnTjZ0aUxlTlU0N0R2UzlvNkt4NkovanFJWGRNdmZldXI2SVZi?=
 =?utf-8?B?RFFMOVMyb0VhSHV0TnVWSTgzZVdJVUo5ZHFMNWowb2w5dHN4ZGFDQWxXMVdx?=
 =?utf-8?B?QzZYYnh6M2doTWZWT3BzWEhLaHBNSm1XNXlqb3gvREtTeTNFeTJrVzNuVWVn?=
 =?utf-8?B?OHM3VTNuY2haQlNRUWMrR3Y0UVduRWdsYkZrUlJZc3NscEM3ZENQOUg3a0Vk?=
 =?utf-8?B?ZVE2aW0rOHNzYm1xUmxmUlRaMitLRUdGTkl6TmhMUnV6azdrd3pIa1dXNFVi?=
 =?utf-8?B?VEFIc0VVS2tvLzFObDZIeEtwY2xhZUxSQllEY1NUeFpOUWNaeUc2Q1d0cGNV?=
 =?utf-8?B?M3E1U3kvWUc4dnlydEFZMitsZWNPelJJVUlUd0drYktPVk82a3o0OTB4YmE1?=
 =?utf-8?B?dW00S0JkUGFja1NnVG5Sek13b21GNCtMR2xmaXBjWGRlWVlCNTFnWStDaFNr?=
 =?utf-8?B?L2dWU2Z1ZUpBMXordEp6MTBYMnNpVTdDRy9aT054ckFqenVIQm56LzAzRjFz?=
 =?utf-8?B?QlR5L0NpVTBTMEpSZ3UrcVlJT3M5NU9obzFMbnhiaFRnREtkTDJqUUdxUVB4?=
 =?utf-8?B?b0RBdks0ZWFmT3BPb290enpVdVVybmw2b0ptaWZOaHZBSm51NVc2REN0WXow?=
 =?utf-8?B?MzFLSEYvS2ZBQTh1d0UwbVU3cXlvNHBKcGxWY2cwbGNhMndUc0NSNmJ3VWly?=
 =?utf-8?B?R2I2Qk1CWTEzM0lyR055a0dNVjRxWXZZaVhEbExwaFA1elJXdjUxVFNlRTJ1?=
 =?utf-8?B?dGtnVTVxWFlUQkp5WTJoR1hJZUJIby95QzVtOVUrOHZYN1p2MnBESWFXQkZh?=
 =?utf-8?B?ZlZYNkhCeUpaVzhzNjlBWk5FYUxrNDIra0g2TnZzaXFhQ1l0YzJSeE90a3VH?=
 =?utf-8?B?dlZvelF0L1JSWDhtTW9QeThNMXlOUFNNcWdTQXJoZHV4eFVRUktjV1d4K043?=
 =?utf-8?B?U1d1Z1QvczdYbExMdHBSa3F4WjRXNGRHMm9LSHJveStDN0FjNWY0cVArYVIz?=
 =?utf-8?B?R0Z1dXNMUFpET0RSR3FIVjU0eC9oVnAvR3ZpVE1vRXVDcHdVVmRzQzR4eG5n?=
 =?utf-8?B?bi9BOHpaVFB3UDFsaVBQWXY5dFYzY05uRlkyanp3WmRjVlVQVkliWlRtTXB0?=
 =?utf-8?B?TkZkbWJqeWdzbU5id1NLVnBZYmRQSFZOd2ZFOXNFMDlwcFdMRlpvTHQrMHQv?=
 =?utf-8?B?RzFQMWRXbzNnVWNFc3JSMyttWElMd2F4L09MWGw5THdLY2U3cWpvZzdKRTZo?=
 =?utf-8?B?OXc0QjlFbnVxZTdvZEJ0TDluSFk0WXdtckl6NGZsWUlyRytiSFQ0ZWNRUVR3?=
 =?utf-8?B?Um1Kall0aGJTNkhSenNFZkNjeEQxTlVNcE5mTXppdENSN3YvQjNSUTVmVWFn?=
 =?utf-8?B?U3NjZ0Z1cEJpR1FPdkJ6WHA4K1k0dUlaZ05qY1hjelRLWjFPRFNYR1FsS1dt?=
 =?utf-8?B?NGF6c1JlTDlJTnZ2OGdGbzFHanc0R3RXVWJ3YWt3aTBsa1NuRy9ibld1WW9K?=
 =?utf-8?B?NXFmY2krd1dHdFg5Q3hteDh5VVl6a2ZoTi82Ky9wTVRCT2d1ME9RZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0289264-c75f-42e7-4be4-08df2741bc6a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:45:39.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rh45rRGvzzJ1m7mzu9IHb7JkoLpVt82/ipFRBhwXW+dYqvN2ltdpNcT8sFX8lvc2pjPSBQKhJopwQLoTXTd0Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

On 10/7/26 12:37 PM, Alison Schofield wrote:
>> In general I'm noticing a few functions that takes a 'struct pci_dev' that does not need that in resource.c. In the future, I would like to extend cxl_test to this core code in order to cover most of the functions in resource.c and the reset mechanism. Do you mind taking a look at if things can be reorganized? I did a quick refactor of your series using LLM [1]. See if the shaping of that is acceptable for you. Essentially I had it organize into 3 parts. drivers/cxl/core/hdm_regs.c, drivers/cxl/core/hdm_state.c, and drivers/pci/cxl.c. Feel free to use any or none of the changes.
> 
> Srirangan,
> 
> Agree with Dave on this point. We should avoid carrying struct  pci_dev down
> into helpers that don't otherwise need to know about PCI.
> 
> There are a few more examples later in the series where this starts to spread
> through the HDM/range handling. I'll call those out on patch 12/16.
> 
> -- Alison
> 
> 
>> ┌─────┬──────────────────┬───────────────────────────────────────────────┐
>> │  #  │      Patch       │                    Change                     │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │ 1-4 │ unchanged        │ Same commit objects, all Reviewed-by tags     │
>> │     │                  │ kept                                          │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │     │ Introduce        │ target_or_skip_reg_val replaced by an         │
>> │ 5   │ reusable HDM     │ endpoint-only settings struct with skip;      │
>> │     │ decoder settings │ switch commit takes the target list directly; │
>> │     │                  │  endpoints write the DPA Skip registers again │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │     │ Move HDM decoder │ New built-in hdm_regs.c, built with           │
>> │ 6   │  helpers to      │ obj-$(subst m,y,$(CONFIG_CXL_BUS)), so        │
>> │     │ built-in code    │ linking cxl_core no longer depends on         │
>> │     │                  │ CONFIG_CXL_RESET                              │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │     │ Share HDM        │ Unpacks the common config only; Target List   │
>> │ 7   │ decoder register │ and DPA Skip are read where they're used      │
>> │     │  unpacking       │ again                                         │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │     │ Reject           │                                               │
>> │ 8   │ overflowing HDM  │ Rebased only                                  │
>> │     │ decoder ranges   │                                               │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │     │ Refresh cached   │ Endpoint decoders only; CONFIG_CXL_RESET      │
>> │ 9   │ PCI HDM decoder  │ introduced here; two bug fixes (below)        │
>> │     │ settings         │                                               │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │     │ Cache endpoint   │ PCI-side code moved to the new                │
>> │ 10  │ HDM state during │ drivers/pci/cxl.c; cache and cxl_rwsem in the │
>> │     │  enumeration     │  new built-in hdm_state.c                     │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │ 11  │ Add CXL Device   │ Moved to drivers/pci/cxl.c, otherwise         │
>> │     │ Reset sequencing │ identical                                     │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │     │ Validate and     │                                               │
>> │ 12  │ synchronize HDM  │ Region-quiesce API in hdm_state.c, so the PCI │
>> │     │ ranges around    │  core never takes cxl_rwsem directly          │
>> │     │ reset            │                                               │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │ 13, │ Reject unsafe    │                                               │
>> │  15 │ scope / Expose   │ Rebased only                                  │
>> │     │ CXL Reset        │                                               │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │     │ Restore CXL      │ Decoder restore split into hdm_regs.c, which  │
>> │ 14  │ state after PCI  │ needs no pci_dev                              │
>> │     │ reset            │                                               │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>> │     │ Restore CXL      │                                               │
>> │ 16  │ state after CXL  │ Race fix. Found through testing.              │
>> │     │ bus reset        │                                               │
>> ├─────┼──────────────────┼───────────────────────────────────────────────┤
>>
>> [1]:https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/? 
>> h=cxl-type2-reset

Hi Alison, Dave,

I've adopted the structure from Dave's reference branch in v15:

PCI discovery and reset sequencing are in drivers/pci/cxl.c. Generic HDM 
register and state helpers are in hdm_regs.c and hdm_state.c.

v15 series also incorporates the other pieces like cache fixes and 
decoder refresh during bus-reset restoration from Dave's branch.

Thank you for the refactor.

-- 
Regards,
Srirangan
