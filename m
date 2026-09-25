Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06D43C7B4;
	Fri, 25 Sep 2026 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335478; cv=fail; b=C5iisBBioYoR8DLRTcrG6enHFVxchHV+wgkQ9w+vZYxW8QDv1zEssAKSpK4E0WJO5imWITpb7ekaFqgVaOfXdcoiKYXKPlYWsYmlIu4/cV4q0O1O0W2lqtXHZ1gSf+Y3eVmeezaC4WJGwNoHWE27yKGKc5vlgGeDYBSKRIvYrqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335478; c=relaxed/simple;
	bh=W2AKZq8lZ28M4epRXgcsBRGfFDSNrk5fwMHZn4q7MA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XpE8IEd7Bq5UXr+F0V/0WTd40QrJqJpX/53kdLMX1IJN2H7FBhdAhqWhR2aulr0PHVkUzSdLc6R4wvHHl3U1K30FBa6Ye8VM8YrRWJQlvYJDYWjxhP/2y+l+oajY9wj76kcIeNHzWYi2sjXmg80iZdG8mK0SDhO6ilvdWO25Tyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IJDWxEFM; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IJDWxEFM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHc/rUBGOOP5aDFFvNv8enkuNY1nRaidswJwOgAIJ6Uxxm3Fz7FMs6f+Op5PyEB1h9aWS0ECcNdrt8ULsKnKrft6xcAH6UKvomy98PV3zTrxiPKqaMwlEloBG7M0xg1OZ0SbPjUk5BfMMHYLzB1ohZRW/Hv6PQgVi1TEmcyCQR9oIGjweXUjeiHMHSOdUTVmz6/hHt511xp2j0v4rBpcBVFXGxevhy1E6/POcqbpC+lpaaWABLFPlUwq7K5ZkXS0II6gBGiZrzANaURqoLDhr1oRGXX03i1jfDaJang7eoxEAxh+2CvoRiVhBqUVJjR7Go31jEsTP0butMbwrMy/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YadiSynCek25fbcF9pB/WFx4cs49aRq2lCOVpx8kWJ8=;
 b=pslpmLg3DKuM1apd6bXUmo+gW33O4MwcUjp4azN4BlPkWWI6icvXs2A8gmZELhgUtj9SR4uvwrQ/re4bUr1xw7o33rurQ9ZrhllPVw0dRovfNjGW8ihapZE5CsGdTdVHM7CSas7Tg7H0DqDkg5Oxn+zSVMXHxjpXYXoYAG4u1P7pjbQ3Nz3nPeBuMQVJIFqvnJ4d3kzUGnojrlTJKWI9Co1RpzAeTDb66B0KgiXeCX03op/wCPSUaW8mJclUe3Gw4JXpekNorpRnOU2BMYIJ68J2jxL2XrdwJbl4FbHHJzDTPODOt7MXIJdwE7bIEjRDXrDytiT8jN1rboeAw7Qi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YadiSynCek25fbcF9pB/WFx4cs49aRq2lCOVpx8kWJ8=;
 b=IJDWxEFM7I1g2dNYwJ+OFQsuLEKj46Ac/rkXz0j+ntxfxAIEqOLb1bCOJ2E/82fwUHQPS3/mDwwv8wV3eXERXtJcgiVuKZBlFdc4lwU9wqA7Ngmg5hPMdxyOS0QmnM0OIekpxoUAye3tjjWL5lcfydBbgju2U3PhrPqb31saFAI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:24:34 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 11:24:33 +0000
Message-ID: <adef80dd-67f3-451d-9595-f75c1685c0c5@amd.com>
Date: Fri, 25 Sep 2026 12:24:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/12] cxl: Add CXL Device Reset helper
To: Jonathan Cameron <jic23@kernel.org>,
 Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-7-smadhavan@nvidia.com>
 <20260912022617.47860862@jic23-hlaptop>
 <9ea4b1cd-d801-486b-959a-47e6d1914005@nvidia.com>
 <20260924014526.3cd5a375@jic23-hlaptop>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260924014526.3cd5a375@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4dd68c-6314-4c24-3837-08df1af792fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WH2BKPVeOFdc7z4ZUqwB5yqaSaq3lr2gU9pziTpF8jBb9mJ8DgkhbK+AICCeFWzgI+rBSQtr2jDetZR/Mbk8YAVrqY3R8XJ1z3jaRv2xMkltSnNq5fSJ7srS+c0kNfOd7FsSkLDxvLKsxavbXXfXYjpHXrCi55qgRE7ZC7MbIZbq0WE2hS5HI1gKLcrlYY58zq56W42FhRRHKl3z9c/wrFYdIA3xLbKhcsDxW/yu2hksrHDnuYKwU22gK+v+ljstxKstNgaRDpKyQr00WAJg5BZElPAMqas3NV9Fv2gLY/V7Vtr/aO9y1A3YfhRSVcJWSU3tYpnxM2433dHwIqvQRxZZL+vIdpP/+pglhTTbH1UkbN0wZMXhQg82N4t6BUJxxEjRYyZmw2Mq4NP3JTCw3+sUNPdoT9rtOy9nv+P3NcotpXsynX0iA70vQ3GrJjBujpdE4ok6o0zqRED0o7iYxdPmBZl4O9GVTylJrlKz8doLvXGTjYDrU7cReijeL+vGIM/fnoeEpYIzsVvgl6k9GiqTvN90ufaEJMxe31MVHhGTUWTRHy0QH9mHjBmYHcSViC5ZRYPM//L5o7OY7mKZrXAHHytt7oo1j6fi5+NoLdpBkNOID5ALsOTiOHeYvc9qOqedzpVGU804xaBg3IHMpv57WfLk1Zq9VTmj9Nz2hYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2lnLytNMGJLR1l6d3ArU0tnc2tlbXVjSUxRMEc2K3NkL0tSbE05Wkovczls?=
 =?utf-8?B?d3c5YVhadmYwcWpyencvQythdHlVc3BvcjRLdW5RQ1JWeXA0UUJRYUFSRHYx?=
 =?utf-8?B?WGpIWXJ5ckErbWhRWVh5TjE4dzdWUzhWeXhxYlpNNXdsbHRqQXFwOFJYNmdU?=
 =?utf-8?B?UTJuT1hBckQvck13Ullmb1lKN0N0NDVVOHZWNXpDOHNPNkRMSVRHTXExeE1Z?=
 =?utf-8?B?NGNwaG0vMzF1TjdIRmcvYzl2cWptMld1OGtzL0UvUit3WWY3TjlWUnZ5K1Jn?=
 =?utf-8?B?WnF1cFI2MUk0dlNPNTF2QmV1d3NjelEwK1lGZU1oazNVRXAxaTJuQTkxa0xR?=
 =?utf-8?B?TXhuRFp2M1VHZHBYVjEwdStYNlgxcVAzak1NL2x5SDB5MGtDdDRvcFg0bGt4?=
 =?utf-8?B?NHRBOVNEby9TRUpZb3pJRVNLT082ZFpQTUxqQ29XNHB6YjdWNHlGY1h1TUNR?=
 =?utf-8?B?czBNMzI4MEt5OTd5UklBQ1JFazRDd29hMUphci9TSnFsRDZsZmR2anZiVklw?=
 =?utf-8?B?SFZod0VUOFJMc2RLSXF2L0ROV1Y2T0NDdnBQYng5Wlp2dGJQcXJQSm9UR3Nm?=
 =?utf-8?B?SnFoYmpGZThkdTZkNHhLSUpSOHpVMXo4NGlydXk3RlFGWkRaei9Sa1dlQWlC?=
 =?utf-8?B?dkJvclgwK1NsSGZQT25pb2R2RnIwTDh3UEhZMG45aUpuZXJESEFrR29VblJV?=
 =?utf-8?B?YkFsNExZWHoza2RpMldGSmVxekdybDNxSWV3QkxpWEY5M0dSb0IzWUl1V2Fv?=
 =?utf-8?B?RWxPR0FCRmRyVkR3SXJYUy9FSWpWZktGNUJOeTk0ZmVjc2NmYnIzUWxMWmdh?=
 =?utf-8?B?V2k0a3FxWmQrdWNtTlBIL0lCTjkyUTVBTUh4T0V5WFU0ZENUSHdoLzF2UWFI?=
 =?utf-8?B?T2U3bnJ3SWlsTEtEZURxUldBdmU4UWpReVFBUEpNUlJqcUk1U1FFLy9mOVBj?=
 =?utf-8?B?ZDczUVdETHZNNUVveFVmYkpzNTJFQk1PTHVwNERidW1EbldnQy8rS3R5Z3Bn?=
 =?utf-8?B?S1hqRUhrQW1INWdxQk5qeC9LWnJLZjBmVzBFd1pCdzVId20zYXpGazM4MllU?=
 =?utf-8?B?U0FTU0V5QWxMWjdxKzZGY0NzbWE1TStMZDFLWnplQ3I4dHFoOHBPREJ0MDVO?=
 =?utf-8?B?NE1vWGlYbWRLdGhMNDk3alJYaHEvamxmVjR2N3RpdXhVSm9kSC9iOXNycFpw?=
 =?utf-8?B?eDZIMWl2ZUVxekFSczdnelpueTUwVFgrUXN2bkErRWdNRUtZRmJTZEkrS2x4?=
 =?utf-8?B?aWlqZFlYT3c1dGJMcHJFSUx2WWMrLzFYd29rd1Z1WmhUOWptR2l0SVFYNGV3?=
 =?utf-8?B?ZWlCbExTZGNhdDBSRE1Sa1FIb0M0OGk4ZGNsRTc3bm5zWEZYTWZURVFMRFl5?=
 =?utf-8?B?amlRTlNmRVFnSUgvVXJIa3cxazBkQWlzR0I0dmxJWmduNzYyYVI4ZmNDeFZQ?=
 =?utf-8?B?SEhkc3Bnc3NQUEVDSGtLL2pSQzI5MWlSazRNbkt6c2JFUVk3eUxzNS93REla?=
 =?utf-8?B?U1EzcStpV2hmWExwaUx3ZFZ1aWZFcUplbUZkZm9oQmZrcHZzaldoQzZidTYv?=
 =?utf-8?B?V01tK0sycTkzWDhEbGQ0U3JFcGt6SlcrZDBYWDZnbHA2blFvL3lRa2t2alNS?=
 =?utf-8?B?S3Z6UGhtSXNadFloZ0s1VCtKZ0FUU2t2Mk9sQ3QyVTRGS3hhVVdPODRYbTdy?=
 =?utf-8?B?RWExUDU2MDVzVmJBQy84MzY3ckF5Q1FHQzM1dUxlMHpBNUpnNDBYd3RYU0N6?=
 =?utf-8?B?RkxQR2lnTmFqNHdOSVNpNTIvSUkwMzFmQWJWZkR6ZTBLcWZpcGExazc5Z1gy?=
 =?utf-8?B?TDdwM2g5RWRPeG1oNUdZRG5nV0xtdlVmN3BuSUR0K2ZLOC8xbUp3Sm5oU2lh?=
 =?utf-8?B?dDF3YWRyODFKTDllc0V0c1ZOdFcvYjRlYnR3bUgxZkQzSTlMMTRhNmh2N09h?=
 =?utf-8?B?T0tDVGJGdytBV0NPRnhYTzJJRkM4K1BIc0J0V3NFNFdkdEVzTkdNVVJ0VGJj?=
 =?utf-8?B?cm1URUJyY3E0MDhiL3YzWTZTcmJPTzZBVGJPK21KUW44WEk4ZEJuWDQ1NnJM?=
 =?utf-8?B?UVgvVWh0Zzd2SGZMUi9vYSs3WklXK0huUGc4VFR1VGxJT0IwaThHS2NqN0pB?=
 =?utf-8?B?YjV6aW9IMlBjNmZwcDRlUmRpT2xXRGZ3RmRXUHNwMFMrVjdnUUlkc2hqL1Av?=
 =?utf-8?B?RmV6czIvZlFCZVB6NjZGTXltN0ZHUWZ3UUc5akhlblZkN3JkOFgySlZvcFRy?=
 =?utf-8?B?RVpzdFk3alJ0dHBiclh6UjlEZkorcEM2bEZnUUp2QmlZNU9YR1lUZXRpWFox?=
 =?utf-8?Q?uHGJNrhwToN9WL8IUo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4dd68c-6314-4c24-3837-08df1af792fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:24:33.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGlh6uTtyEtwBY5h3csI7vcTFsBYi5RCf7jTce3Tp1DZbObpuPj8Pdo2FjC561/w43Agu1rTz6+kXxnaVbKJWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156


On 24/09/2026 01:45, Jonathan Cameron wrote:
> On Tue, 22 Sep 2026 17:20:06 -0700
> Srirangan Madhavan <smadhavan@nvidia.com> wrote:
>
>> On 9/11/26 6:26 PM, Jonathan Cameron wrote:
>>>> +     if (dvsec < 0)
>>>> +             return dvsec;
>>>> +
>>>> +     if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
>>>> +         !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
>>> Why do we need them both? Sure that's type 2, but a non
>>> class code matching type3 would I think need the same infrastructure
>>> you are building here. That would have cxl.mem but not cxl.cache
>>> - I think some of the CXL SSD prototypes fit in this category.
>> I did not yet address this in v13 because I did not want to expand the
>> series beyond its original Type 2 scope without settling the expected
>> eligibility policy first.
>>
>> The current check requires both CXL.cache and CXL.mem capability and
>> both protocols to be enabled. The reset sequence currently assumes that
>> CXL.cache is active and performs cache disable, optional writeback, and
>> subsequent cache-policy restoration. This might need change.
> Yes, we'd need to sanity check if CXL.cache is active.  Probably need to
> do that anyway because we might have a situation where the driver code
> isn't done for CXL.cache yet but CXL.mem is in use. I think that's
> the case for Alejandro's device?


Well, not exactly. It is true the driver does not handle CXL.cache, and 
it does not make use of this capability, but the protocol is enabled and 
ready between the device and the upstream port.


I think this can be a bit more complicated since that upstream port 
could need to disable cache as well, what is what I did comment on 
discord yesterday. Current firmware/BIOS does enable CXL.cache between 
them, assuming here an endpoint connected to a root port, so the 
protocol (and the potential and uncontrollable path to host memory) open.


If I am right and we end up disabling CXL.cache in the endpoint and in 
the root port, I think the reset should mimic same paranoic measure 
implying to restore (and I guess to keep/cache beforehand) the upstream 
port cache state.


>> Is the current policies (HDM snapshot, range synchronization, and
>> restoration infrastrcture) adapted by these patches for cxl_reset also
>> apply directly for type 3? If so, I can generalize this.
> Yes. That should all apply as a type3+ is a just a type 2 that doesn't
> support CXL.cache.
>
>> But if Type 3
>> requires additional ownership or lifecycle handling, can we please
>> address that separately?
> Agreed for anything new that is needed but I'm not sure what that would
> be.
>
> Jonathan
>
