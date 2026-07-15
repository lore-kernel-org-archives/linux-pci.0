Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ACE47F2D9;
	Wed, 15 Jul 2026 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128458; cv=fail; b=B1FIuOCBeQuNcSnyzMtRy8GBi1gPJuMvw85glc/OqzYhV/I7lFIQBWTbl65hbTy9f7BaFKc3Rjs1Hf0ZXvFJH08/MO4T9BbAj0N7i9dqo4RX6IrJzENgHL9fUnCR2aI0/XjrZJJc1oAdxuhPzZAzhlARU0dFkM27/J5GOQZIQOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128458; c=relaxed/simple;
	bh=9dn6jk9BHDHfW2iFNSat+M76aT5nsPuk48OeooEBZzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lsZsbbO6RKp9/DJqNYYgoC2KZ3ynvpfhEkchvxugN/pUsC96JuOz0VjYMitLDyl5F4OP/98qtNy0LFe1DoXlmnvfds/2NJLolpybznwBxDmmIUulEyGKqEOxKHoXKVOLFebsyfQG42XVVI30y/IvHymgNhg+QHS5fg/1HoNnTkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vQDBWEle; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vQDBWEle"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWAIULJCWUTrb0bl95f3hXFNgbMRDwVSsy/l9ZZHX0cn2+gPFJrjhhzaUg2wch6CcLCTgN+LuswtzQZFPXjswBqROslbqQQUiiRIyq++9U9Gk7DJ+eP+gPFPxXj4a2NxNXWWvyQIN6sSoMVjG6b7oU+HwMnMG33deHf96Was7d24HlM5ZjqeMPXyeQF+QDWBxMjYbWwFd4/yOZchnOR5eR9FOM2D099QlGJ8RMsvVRksU+4/RaK+U0jpHTCU5OWLBlqWaP/JWpgA/M6LuZs/zDm2X/Pv4QWYUZXZKazDgesRaHnb2UzGJiUGnCGdiyJksgBzT3+ibGK9SPbMguRjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb9sud5eKPCqCeWjhHc0HR9b1riJR14pA2WsDtUCeZA=;
 b=Xjxn24DMymZi0yrtQrgoh1JGq7wcCS4FPkQF57RxHdy0WYwcka2VO7xryVrnkcRYixYnLKqWkQwuoOrZ/q6LdBB2gTBlLzkguezbdvDXvtMrSFSL7lUiuqGqVXj7uYKwU2YDlFHjkTVFEbMHTqUe3YfJOeQ0qrP1qEBIFYfV7vDIdJCY4+AbrG09HBWa5YdZUXyOH7ES3ZfNV/KFJLj4jw7LygDBBrfCYokFY5lk0i+cyvNP0JWdMtJTc+RP7554ZRmMVdzexatCBlziXuBgZSE5QD+o8SF2UIxpye8a/0fJtt68/vQbSTo+xnDrbBteEyiW9wxSHK7mQ1F/ChbMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb9sud5eKPCqCeWjhHc0HR9b1riJR14pA2WsDtUCeZA=;
 b=vQDBWElerDBbvdpTCBaCjoF9Ehi1Uw8RiPEYQ2w08NPhGSsMvintWCVXu+PNGBDIL8YMiSa2za3ABF081MlzkZDPNLqUkF0qckIJsDa99jiL3IW9ay/FU0pherXC5ridD/+axw6b5BOBllleiOpBqsOG3w/40UjeQQQia9YOQyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Wed, 15 Jul 2026 15:14:10 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 15:14:10 +0000
Message-ID: <129c9445-2b65-4052-a484-136f0641c3a4@amd.com>
Date: Wed, 15 Jul 2026 16:14:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/11] PCI/CXL: Add CXL reset support for Type 2
 devices
Content-Language: en-US
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com, Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260709010304.680422-1-smadhavan@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0446.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::19) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: a6320f6a-dc2a-4700-37ae-08dee283b8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|6133799003|18002099003|11063799006|56012099006|921020|10067099003;
X-Microsoft-Antispam-Message-Info:
	X4smwm9jaioBZ0Jez7WraytWivAgXVreTV9Lq2Dmy+6PFrVsQfKdMzNMh6N20V0vBm43KRKWvkilkv5BeDZ6cwVkbTIB+++Ki3tRTT5BFbm2+3XAEnlD20oAT5GncoQMKybcTI/IO7XSV1ZhhV3Fv9w/BbLNz/pGmtxOxMPPpLGa7JIp6z/lj/OWgcvmhNyoGXWWmb96gZPoUSHQr4PL4aG3iOxjINxyW+23mM6jABC8skH/6iqH5yZuPPvttQTiYp6GkDIb6Qzi+c7+ue08e6CqSZbqTmqokHngYo3ei9dE87k16BBQuCP60Y11hKn7ioKK8a0waFNYED6XhaJ6TqmPcs71Yx9rje7D2UCN5Kg3jIxbke7uhJBF9CpFrJr1lxFn+4z2ltyxRc5CfUeM2yEaHDh+QhsbPd2W5Qi6eg9tfY170JBgEstjolSsYLaEZXGYt/gccQrDRRHkA4bNfk1XtbfaUTZLj/Nz4KWe8qENCBHY+dDultozaqJ58+8/Gpn3DgmZaYudUDhQiXYtxY4ZGLbfHE0RygQoP8mviXdQE5SpcElhHBNfLg7VEHKi5JyTI1RHyc1JeLf3wherNXhlZR/assrFLDCBuNeBElRGwzzQXDzHLhkmQy8GYqCNjtIUedFdUeDoAHIL6UqxK4rPAz5cLrgVf4vhCA/lubbpYgVvfC/tOLN6eRXg3TMGYGFp+rBYZKjkSoeiAeMdmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006)(921020)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHlZYVM3SEdOZmFyK2hhbktpaTdYVDRNNDQzSVZlR0tTZndleTZseHFjL2dO?=
 =?utf-8?B?LzEraHl4aWY5RHJrV0xTNitSOTI1dGhBc1ZxdGZIQTBwM01SczRGNEJJZk40?=
 =?utf-8?B?bVlsOTkvbGhRSGtXbjJpL2c1eUMwcEw4NlhWV3lpUUtzcU5QNHJQbzZlbTgr?=
 =?utf-8?B?a3RoRDNmN3o1VEEyYmV3cU8rbyt6UHBUUXUwYS9kUTFoZFRYcVZEbFh2VXht?=
 =?utf-8?B?ZC9DQmxBelFOWE1wZStJdHQ1eW1qYXJacitKQ3dIU21uTUY3ZTVoeFVHbncx?=
 =?utf-8?B?bGRqTHJpRzJXLzJyQ3pZSDRremt2dWYyejhzKzdZY2lSaTJhVkZsc20vR09a?=
 =?utf-8?B?ZThsUVdxZGFrVE9QTWE3Sk5abk1iMlJ2bUhpMnVLUmxScitPbWdlWEJnMktV?=
 =?utf-8?B?bWwxRkVWa3RIVFR2UHFlNVArUkF3REhPYnk3dGRnci83eW02RFhSQm1waFUw?=
 =?utf-8?B?MUNXY1Rub1o5SkFtQ3BuNjZYb3pCWERIT1hoMGZtYzNqUCt4bzlteGZkeXpk?=
 =?utf-8?B?MjRyL0x1S0lxblFuczR6L01lSDJMU3h0bVhJVmpoQTJ1R2tISmk0TWIzZUl6?=
 =?utf-8?B?MjhFSFJtTkhETXZ0TVNKYWFiVHp5T0EyYU05RVhiT0xLaUN3TUR1RnZFdWNP?=
 =?utf-8?B?WG1vTkhBQ2R3MUJwaUd6QzZlNVV5TU1nMG4yRnZqeUYzRmF5ZzFFTzJ1aWd3?=
 =?utf-8?B?dmFUelVmNTFtQnQrL2Q5L01qQmp5aWRsVEpzWndKbHdSVElkcFdiaWxGZW5C?=
 =?utf-8?B?RzFGQTBWK2dhbkRiaXc1WHppeTZBSHNFSWNxVHhodkZEK1QyYjN0NExUUFQ3?=
 =?utf-8?B?eWlPRVFoZTRJVm9EZjE1WmlZNTJKU3NuNUV0ZTBsTHNoT3hOaGFxYTg0MHVs?=
 =?utf-8?B?aytZRkMwM09Iam5iYjJXUnRTNk5pT0JnUi9lbE9hcS9UdTVFV1FPeTQwSTZj?=
 =?utf-8?B?N2EzMEl2cnE5K1RCYnpyL2h4V2ViVHhRQjg1UWZ5Z3hjdFczRjJJMmtqQVRi?=
 =?utf-8?B?SEtOeFlNOVpPbFNIMmpHSmp2M2VyMkY3bWRUdzBPV3BJSDJJeWVXWUx6dzlz?=
 =?utf-8?B?dENTZyt6SjVhS1N4OGVUbXpqSy9XSkxnUDhDOVNFVVNDcGNoSmE1NFBzdW93?=
 =?utf-8?B?UFJoYU0rc05NWUlGemNzZ2VJTVRoNlY1cXIyamNDUFMvODZtdzRzY29IbGx2?=
 =?utf-8?B?c0RqZ0gyZGVYNmVZMkMyZ00wcVUvQWFVRGdFa2tSc1BBeTZUYzFoVlNWaUUw?=
 =?utf-8?B?REUybE1FQU52cFQ2RFJ4bzUvOWNLL0NwbTZBaDNodjZBeHpneWNuWTVUenlF?=
 =?utf-8?B?RFZIaW9GQXR4VUdLS2tnS1kvSUc3M05keHFSNTdWTlJnaHU1VWtXWEF5RGJR?=
 =?utf-8?B?QkNvRFNBRmMxdi83eHJuREtXdlM3WXJ6VFRBNG1wWnJjRkt2U0lWRWdleVJJ?=
 =?utf-8?B?SlJYNTlGRFVPdlNoTlNLcXY0V3JsK0lIY25heVVKUEcxYlBRQXJ6K0ROTzcx?=
 =?utf-8?B?bmdYSUFVUTUzMHVXNTdZR1I4T0djWWhiVGtmM0FJM2RXT1V3Qk5iSUpoZm9O?=
 =?utf-8?B?U1BDeFRyVGpiZ201UHpVTEt1eEw2OEhFMjUwZlVIWkdrbEhyZGtJRWR2d1lL?=
 =?utf-8?B?L0tpTEVQd3owTk1wSEcvTTBUMjZqRFJkTkNQbjBId04vY1dqbkJSSEJES2du?=
 =?utf-8?B?bm85UEF4Wi9TeFFXb0pLODBCSmozZ3laN3RMU2NBUitnOTNVTTN4NEwrWVBQ?=
 =?utf-8?B?K1EwWHJVN1lnSXJJUzJPS0NZRWlESTQ2MTY3d05PQnNwM2g1MEJqWlVZYTF3?=
 =?utf-8?B?UG83eW5ibXRnVEtuUitJVThDdG5zUysrUkZ2NUZyUmRIV1NQYk1oNzhtVXNM?=
 =?utf-8?B?KzB2cGFJS052SFp3WFk4bkg5SnhHWElXS2QrakluY0xWVXJ1Q0JVODVYTW1a?=
 =?utf-8?B?RWJVZURqMTVjL0FLUjkyNzBsOHhTdTBZazhZYkg2S0U2Mlk5MmV2YUhlTUdN?=
 =?utf-8?B?ZnZrdi9hK0tMMGVkYVBvSHZDVGYvS01vU1Vnd1VLakRpQlIrLzhtOTFUSGNB?=
 =?utf-8?B?K09HeFhZelcxb3VYVnM1cHBva0dabTF5MUd5MGovS0N0ZjlnV0t5bW9RUnI0?=
 =?utf-8?B?Um8reWZFTlNYMjJBUWhPbVNOYU1Mc0QveHF1VHU2RjduVkNYRlBtZTVNL1NQ?=
 =?utf-8?B?WjlZc1BtMzNDdTRzaHQyeW1peERKMEovb29aZldXVEJNSHpyRDErcmp2aTln?=
 =?utf-8?B?UnU1V0ZQdzRCdElRc1VNMy9kOUNDQ2txenoyUHNYZTZ2RnF2RExDdndDOCtM?=
 =?utf-8?B?UHhZamtINUZ1amk2WTJsMEpXa2I5SW14TURzR3pxSTgxSExvRGhYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6320f6a-dc2a-4700-37ae-08dee283b8a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 15:14:10.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmC/gZhMvHHWd9C8ShEjXjBiMW6H0UVkx0YaCDZydL8XA53hNO2ACZ0zoTd7URQeYp0f0JkS7jwahzFo2w/yNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435


On 7/9/26 02:02, Srirangan Madhavan wrote:
> Hi folks!
>
> This series adds CXL Reset support for CXL Type 2 devices through the
> existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
> specification [1], including CXL.cache disable, optional cache
> writeback, CXL Reset initiation, ResetComplete polling, and ResetError
> reporting.


Hi Srirangan,


I'm working on understanding all the implications in this patchset, and 
I have to say my mind is on adding multipf support to Type2 drivers, 
with a RFC coming soon to the list.


Some comments below.


Thanks.


> The userspace ABI is the existing PCI reset interface:
>
>      /sys/bus/pci/devices/.../reset_method
>      /sys/bus/pci/devices/.../reset


Not sure if this will be available in any device PFs, but I think it 
should only be available for PF0 as the specs define this function as 
the one having the CXL DVSEC. In any case, the reset will only be 
possible if PF0 is not attached to the Type2 driver and therefore the 
memdev is not there. With the multipf support that will also be the case 
as any none PF0 device will rely on PF0 CXL driver initialization and if 
PF0 is detached from the driver, so will it be for non PF0 devices.


Note this is not the same than the "Non-CXL Function Map DVSEC" you are 
checking later on.


<snip>

>
> The CPU cache invalidation step depends on
> cpu_cache_invalidate_memregion() support for the affected address ranges.
> If no runtime provider is available, the kernel emits a warning and
> continues after the affected HDM ranges have been reserved.


Because no memdev should be there this step should not be necessary. 
Maybe as a sanity check.


