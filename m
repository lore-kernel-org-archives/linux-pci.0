Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C16846F
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841766; cv=fail; b=nyKvouya5ZXg+85DAwpTKdb7QfOz3/QezREZnuyZ2cWvYpBo1IP3fUVhFbIrXYSKnesLi1G9yJFxObY9/Id6MpwKwikkmT3lkCfbVngvZTAn0oSaHsr3vwegEdeN1HCFTkOIav+uZN1QUlNbrKdCOSBcHjgkdJ9/MJRMYv+NeCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841766; c=relaxed/simple;
	bh=JkRBDB/GW6zfx3EBev2umFzOSI1rzg1V339/Gp1MDVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=snKtRRdDndw+rVGhAGertBdEKOx7LpZRtPlpz/LeJsMsdFy8yXgqSt7nQqfh1lGilwR72+5zdZftmdlmJURthdpduQB7gZe6VJ2slSqFTKp1u5WXkA5FdZS8puckzhHiNSuzvxBMiT6DXU+D+RTOCu4hVF5UhLeJJqKB5BtZjlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CzZcUJMI; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CzZcUJMI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcPzpM+as+fI7nZE0BoCjw9dhvgrYc6tyiEzgsrukRLsCSPRlNu7o/4t4dHpNkyJIDG/nnrRfhPbyxDeMkjsRMs2KignuU7qZrcmiiAq4NjuI4XNgls7YzLKfwT4l9o1i07/JlkhSCkjxItAEtGaN5GO/QnjZUxVXZ8NuiDX3vj0IdcLOJCUUteClXlDT4ZbfWbtzovSezBtThtgtSxTPCCkKsu175gQOpkWbeYPgLH8gEdDzvkjW20t4eS8ZokrI8soqrYWiBp4bgP9IjLTN5DIzAYshZzTBptZvZrYuj174fzkQs0Rxcq8JOqn/NVCqhUOAemIdzP6hnIaiENprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDxNJc9adI0VDWwlghpAMWLwZBWQz/yvIjrpuKR5iTk=;
 b=AbExGMC4JwseVqIuDPh5LeTdPTJqIRmfwewe1fFUsYYRRFdWmh9sWWP1ZYFDtt6NqUXk97IHJR/qbttMNoV75zBKz9NAynXFP880JVQPHql0mxWatzaf72ircXOarJztUugN03arrHC1PanXyCPz/yqvyDH2iYwQKNIN8+IaoFc87teZg7dRIgfXFBS+AoVjjEOq1vbGIrdNftCSggRubW0mBnkvP0KlIVsx7whLwH6mHtSYF2wI1GAwF+JU8YwF7f1hKd5DzTmaeDApxrFz53Oclbfw+CkHXcONMMbhpF6+1k1HIZN6v/aYU5iv/7iPTxriBr2LbaLa3bG22Q4jRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDxNJc9adI0VDWwlghpAMWLwZBWQz/yvIjrpuKR5iTk=;
 b=CzZcUJMI5NjWnEhiBG29MzJRbozC4WijYWNBq0/0H6SZ3q50+Kc0hIg7ohADIGi5lPWViLAd1FBYMMlArSLNcH+4nSfwoyqltQgtf9O+ltK2vE+3Netomfl5xwXC3aSWQXPTuVVETcccuxN8sOKOnmDQC3OUb/ylPzrSNxsByak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by DM6PR12MB4403.namprd12.prod.outlook.com
 (2603:10b6:5:2ab::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 04:02:40 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 04:02:39 +0000
Message-ID: <5f151d04-7364-4355-8fe2-122ee4e27227@amd.com>
Date: Fri, 19 Jun 2026 14:02:31 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/TSM: Resume device to D0 for CMA-SPDM operation
To: "Dan Williams (nvidia)" <djbw@kernel.org>, Lukas Wunner
 <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: Vivaik Balasubrawmanian <vivaik.balasubrawmanian@intel.com>,
 John Allen <john.allen@amd.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Yilun Xu <yilun.xu@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <7bdfaf14d7e5a466f3f650150c688a60e947a7a9.1781527060.git.lukas@wunner.de>
 <6a3189272d3ce_9b8551008b@djbw-dev.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <6a3189272d3ce_9b8551008b@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::6) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 9485f25f-5c4a-43dd-d4cd-08decdb79ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	eT8T9CorZyK3fvaMtICYRRHkfP+sLzqfW5Tz5sNMlQLx/f8bhv+GhQoDk1EzIe4IBtWarivmdSkdPhq8rPx2LZK1/l62rNuamCz1L0EHkrVVZuBEeG12nrzlpgto9O3U1jMIY6VvYGeXKomi30X04xen6PFGA/6Ol4AgZed0vOTOa5L2VziQBflskGLO+kuFhwtVeNj3WwJ2QmD0qYLWQ86sGCW4f2wzzNkz3Nq8Fa5h63DIUMHRXb9q0sT44Au/0wif3XX/81Cy3WX7MFsL5I3ZlcAzDGgWo8VEJP4A6RBOzPO+Z7uKcQeH9Z14UASMYwZEDgtKCs27DoWiYeH7wcvFsNihXa3WWOq1+Jz0hmGHDVljdmGxa3F0n44p6LXOanycxCklc7M2oJPzZsPK3g/FNBC3BbrNj3Or8HpfS4yqHz3WrxMDyg9KoZqSETO8fy7/uoGIez9YzZp34eOgKwy8yQ5xYIz+kccMFfqxElr+v+ALGU5ssDLVhvxJ0r0fIN3nrJDyJXgftDRsNxV0cd+Am2huUqbA4YxlGxGa4MSj4200gxxBblDCHjfutcIBgCVCojZakqCVy6SduVpKkGFAzslr5WSA/iDodiyBjCqspSwk78KfaqvewC1wmwpB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnJ5ZnNCV0RVVmE0d01LWElPc3VQQ3hYeUlLbVhXZ2k5U3FXSkhUbWFWQ1Fm?=
 =?utf-8?B?V3ExOENpeWdqb3prSVVVWi9TajVXcjhYT3luc1VxLy81QzU0c1dWaEN1Rnp1?=
 =?utf-8?B?OGhBYm8xOHRZbFpuMFZEcUdyTitjQWRNS0gyaTFlaGF6QlRYcVRWdjJmbFZu?=
 =?utf-8?B?Yzkva1o2TnJJMVpxUi9UWkhsVGJUZkVRRGpYMkljT1hNWm5xOTNoRHFBdzNa?=
 =?utf-8?B?b3RIQW9NeWE3b2t2dHVaRHExeW5VUUV1NG1GVDJna2NWMURJbG5Xc3RoYXJZ?=
 =?utf-8?B?bnN2RFlQYVNzTThOSXRQZmFDU3J6eTRqTGVFY2lMaVhOT1lDMXB5TFN4OWt5?=
 =?utf-8?B?MzV0WjgxbGxyVmF3bEdWSEc5QXRnYVRIQjNVTWE3U1BrUG9qSWM4QUdjQTdZ?=
 =?utf-8?B?aW4yeExNaDRuR1Jzb0MzMVBmNFZIR1RPbzZMOXp2NFVsd1VvUmdSYXU5VW1F?=
 =?utf-8?B?NUZqSkJGdjRON01pWm9QWGtPWDY2UW1lbUlDbm5zVmNNaW1lMVB5a25oaXYv?=
 =?utf-8?B?eVdRaktVMWZVZzJqRFhZd3l6aFRxRkdwQm05OVhYV25XOUxMM3hoOVorQVBO?=
 =?utf-8?B?SkdIemlubmtmaWVVQmcwMG55RlpKZUNTQVRVT29ncXhiRVZhRUJqRTJwVmIz?=
 =?utf-8?B?L1NNWjZxRHRuRVNBUjQ4RXNWcFNMMWptSStqdkNQZWxsTEpqaVdqOGJyZEtJ?=
 =?utf-8?B?WXZiMzdWRE5MWVVKVG5OWWZQNU9ocjNKMGFJMFRwV0VNd1lSa0VVaFdieGk0?=
 =?utf-8?B?SGRadlFBdnpMcjlRZkRWVUd0VnY4cHVhSzZMNk8ydmppRTM2OWdPWEI0djNQ?=
 =?utf-8?B?bm1TOG01OHhYU2Y1YUNMNTRmQUl4dkZITXRCemN1RjNIQ05jdnA4VXV0Qi9K?=
 =?utf-8?B?UGEyazR2WEVYRzVva1JoaUVmZE4vZzZpVGhEdFgrZmt3ZGljWTJuK01NVTdn?=
 =?utf-8?B?bythUFplc2p4VEVrMG9vL2xFbk9uMTRVN1FuenhKL2FiN0ZvWTE5VmlpYyta?=
 =?utf-8?B?MVROUlU1UVQ2L2YvNThtK25RaFVmd2NZbjhtMENPT1NtbnNlUzZBR01oZThH?=
 =?utf-8?B?aG5UYzQyZGFFdXNnVysvVGcrNy9EV0xGNDNKcms5Y1d4NFdrRytXT2FzWGUv?=
 =?utf-8?B?ZDVSc0VoRWtLaXA1dXNmSENFck1walVvbXdYMkpleE9lSWFQRHlESk0xajRq?=
 =?utf-8?B?RXBWa2poaHlRUzYvM1hoV21mVDZHend1UDZiMnJsRGtVRFpYYWZlSUlxUUNL?=
 =?utf-8?B?Qkk2ajgraEFEY3IvWmNoaTYxNmw5R1lKWDFMWWRUZkhTVEZsZE9BMWhPQ2tk?=
 =?utf-8?B?WFVzblpHMHRYZk9aNHowNlEzbVA5WlVNUVMyU2NqcVhUTGFwM0lDclF5UEVP?=
 =?utf-8?B?SjVOMy85R2daWXFzS0gvcCsyb0ROTXU0eTA1WVhwa0l6WU1JRURta201Z3FM?=
 =?utf-8?B?QkUrWm5OWUo2V0J6NkQzM3RmYXZYTDYrWmJTTkVSUXdpOVJtdUhOYytReUZ1?=
 =?utf-8?B?NGFSQTNHMCtZSzVyV3l1MjhMNHRVY1l0RGFSdnRwNXg4S1ppOGdsc0NJaCtK?=
 =?utf-8?B?VXdjb2ZqMXZaMktRc1VRNmFRZ1hNVFQ4WFY1aUR1RVpVSnRramM0QnBRaCto?=
 =?utf-8?B?d1E1K2tKcGVlRlpXVzdaYmU2V2ZrMlo0bDl1ZzlrTEgxbnU0TndjV2l4K3ZQ?=
 =?utf-8?B?clNoMmNTakd4bDB6UytrOVZPWWVZS3NmbHNuaVJzM05uVVNyVHpDMllOZGNF?=
 =?utf-8?B?RVl3MUVlNnNUaVNLY3F0N3o2SDhGaEFlTGdnclYxSEVWeEZJdndtOWpETDZv?=
 =?utf-8?B?alFBT3llTFNJdEcyLzBMUE8xWW1vcmFsOW9UZUpyUEUraGVLbkVoL2VkM2VU?=
 =?utf-8?B?R2NULzNVakJ0ZGtqaFhuZ2tUMmhrVVhkMHg5a1NuN3BSV3BQajVicEdBdy9l?=
 =?utf-8?B?QVJUbEtmS25kWjRkdnRoMHlObFY4K2RESFZlZVNLclhzSW5xMC9yRXJUcmRB?=
 =?utf-8?B?SUF1RUZtQVJySmxaaldnbDJnL2dseTdNOTFjYmZjSWJHKy81OXhZbXI5NXlk?=
 =?utf-8?B?Ky9rb2IvVmh5eVluMjY3Q2Q5YUNnYXB6RUswOGRCUXB5NmlyY1FOWStaUzVC?=
 =?utf-8?B?bkk0VXByMjBwNWhzdFU4VGtpMjFIT2FhcW52TFhPdjBrK1kyaXM5M2hKMlJ5?=
 =?utf-8?B?VUQ1Q2xoSFhoMjB1K3FmcGVCc0hDcWFMMi9FM2QrVVR0Ykg0VHA0VzNXRTRp?=
 =?utf-8?B?NytkcXVjV0F2QVArSFRZamNpZVgwMU55SGlsWHdMVmNYZEhZSEkvam8wZVVq?=
 =?utf-8?B?YzR2ZHI1L3U4RnFkNEFEMTZra3BjWGR0V0JvNldTVXM3RjBVMWR4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9485f25f-5c4a-43dd-d4cd-08decdb79ae1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 04:02:39.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgKsDp5OJymHJ+7Nq+UXJN1kBawjVVZr4iMcRhTPUBLrH4e+od+ljrzu3H4NXjwW1ajZqXJGTMXH/4p/i2Gc2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403



On 17/6/26 03:34, Dan Williams (nvidia) wrote:
> Lukas Wunner wrote:
>> Per PCIe r7.0 sec 6.31.3, CMA-SPDM operation in non-D0 states is optional.
>> The spec does not define a way to determine if it's supported, so resume
>> to D0 unconditionally for the duration of a CMA-SPDM exchange.  Vivaik has
>> talked to Windows engineers and they said that Windows does the same.
>>
>> Note that for plain DOE operation, it is sufficient for the device to be
>> in D3hot and its parents in D0 because config space remains accessible in
>> D3hot.  So CMA-SPDM goes beyond the requirements of plain DOE and hence
>> resuming to D0 needs to (only) be done in code paths which use DOE
>> specifically for CMA-SPDM.
>>
>> The pattern used herein for runtime resume is the best practice introduced
>> by commit ef8057b07c72 ("PM: runtime: Wrapper macros for ACQUIRE()/
>> ACQUIRE_ERR()").
>>
>> Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> Cc: stable@vger.kernel.org # v6.19+
>> Cc: Vivaik Balasubrawmanian <vivaik.balasubrawmanian@intel.com>
>> ---
>> We're in the merge window for v7.2 and this isn't super urgent,
>> so it's targeting v7.3 via tsm.git/next.
>>
>> Technically I'd have permission to apply myself,
>> but I wouldn't want to without acks from Dan and AMD!
>> Thanks for taking a look!
> 
> Thanks, Lukas. A few questions:
> 
> This says Fixes, but I assume it is based on inspection and not a
> report?
> 
> There are no upstream usages of pci_tsm_doe_transfer() yet, but the ones

I am not convinced this is a very useful helper but I'll post a patch to use that instead of calling pci_doe() directly :)

> in flight would suffer from the "D0 -> D3hot -> D0 -> D3hot" bounce that
> you described to sashiko. I.e. the runtime acquire should be done at a
> higher level.
> 
> I think the natural place to add PM_RUNTIME_ACQUIRE() that covers all
> cases is withing pci_tsm_connect() and pci_tsm_disconnect().

Agree, although the AMD chunk of the patch would work too.


> I also think failure to power manage the device in the disconnect path
> should not be fatal to performing the rest of the cleanup.

+1.


-- 
Alexey

