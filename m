Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0D393DF9
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582705; cv=fail; b=qAMOhWCB/kvw9tamCxKvq/yuY1ruIAG++QaKvxNzoMUzJ/WxAnoqGmkEnHsuKgMhg/cSQTWtwAqdnB0eY9TB6XPjThpo9eFziRXspPHUYNEfGA69q9PPt+9ZXXwe55pj+3wSS/txDz6IMGNQ0oSDMi5Qb4EpCzdBbWvfnqGjUvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582705; c=relaxed/simple;
	bh=DKsqJete20SBdBFV0zTJMdW14Ygf+J/enWoy49pxvcw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTb30kdB4NePnQVZqG81r9zsfXbGZd+NZTuxC+ZOVEIewJQXtUTlS2EA11ipT3lNRG47aghjUKyRYp9wnbARVYDtt1VgVVoU36ddpGzXWQ1INAkJBFL2yQA/NbGp+mVesYxQ95WNtuxJD0wMBSwzIux4OStNs4BACNQ3j6yxKN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2W35hj8H; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2W35hj8H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=up0X+76aEbb9vZWLh9B60Ku2802xpZkoRg0dc4VJm3deNZcAIBnQ4L3Crny11hctJwgmfKnJt1BP282zgnUablbQILsqvVY0xNnUoCLlFVlLK8dlOVLoe78ax5/Bny47/XGHvsIqJtKLLpP7UFvd40TXJYFkzlMYz4UTAlxFXJBK9scKPK0mDejRersDUdmUWcA6EYb+qYYwMVS705CJ5n4rgoUhv9j+kk41hmRoLYcUsnFURtsL+f43BYaumvnIKlr6aUdm6jn89l2pqNtrLYAuF50RAINW7um2sk+420VMoAnYxOociUU2iyL/0fQ48evFLcIscKlju1E5SwBM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfFD3jS0yzGNyr8yYjFvAeCEYNB7Cq+Ruhb4pth53Ps=;
 b=dAxNUJqbwyAEN475z3qGX8fZJUa6xiK+UtNlJpHJknM4LabhPvF51OYC2FMB2rdzzhhS+nvzIlUuEmJ7LXt4+NDalLN2IeVNbQk/51aaoVNjG8grHGQILv/+bREEoHv3DAqXrQZAjClkQ7YKGgJssTnb0R1QTFFkSnsfpTYbBVZEqJCUFNE95G98Xp1zHNXZ49r01xMLQxRuuFklb2d7GPBQbID8N6Elj9n7SOpgtf9kBLbL/mwJQZG56bOWl6VT5irdG8A9uzLOs8KPommm6NmSNHHqkmAlmLB5DoJRQuel9dJ/FbIQqb6ll0Y/rAdj1cAsmoc/LSQ6aQgXQaPPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfFD3jS0yzGNyr8yYjFvAeCEYNB7Cq+Ruhb4pth53Ps=;
 b=2W35hj8HjtyTvHJPau6XV7Gr1Wh6uLyxaTolo4GNS6iXKQb22/O4IWRoZc5n7KKVzoBKtG9yICOFHdCWRzidGZYYo3fmeeZKBIY7ase3acbjusjZUIhKodvj/YH52x8FBqCKS2GwjlStb6b54rCFmrquTcyEefL6nfOAUxhcxY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by MW4PR12MB6804.namprd12.prod.outlook.com
 (2603:10b6:303:20d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 07:38:19 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 07:38:19 +0000
Message-ID: <39809986-74dd-476f-ba61-a0a9187862d5@amd.com>
Date: Thu, 9 Jul 2026 17:38:14 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] PCI, device core: Add private memory access for
 DEVICE_TRUST_TCB
From: Alexey Kardashevskiy <aik@amd.com>
To: Dan Williams <djbw@kernel.org>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
 ankita@nvidia.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dexuan Cui <decui@microsoft.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-14-djbw@kernel.org>
 <f8b5b966-ea36-4b4a-a9f5-58a20855a6fb@amd.com>
Content-Language: en-US
In-Reply-To: <f8b5b966-ea36-4b4a-a9f5-58a20855a6fb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY8P300CA0001.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:29d::31) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: e16bb370-c801-4c0a-ff6f-08dedd8d0c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	8xf8UVgC7AjkNU0ZNi4zVUcPbZ7JGSptYkaU/xdWMpJziKRh9WjMhy62vczvduCBbxf2jHPtBk79wZWIeAA2mXVIbGGMZQkznHo0R9Vf4NgMfbXf9c0bl7naJaW1CH/tqIxRW5Q3ypWsReAk5K3dCmngXxm/l85Y8GEDU2xOpl97CIKEcfDy7kBa0IskEI1TKDVjQUnqG32a/c/gAJ1oQpBLKAlViMc6TjpGcRazmgqxPNp1C8uLbfmVHiWoVmUUyWa6sbfgXmB9wFhRrSr6aYTOex+RbcPCKw7B0975brBe6gKew/YrzDoON+OYzxJGsADhvHXQt3YQ0ciN+oVqYLpocrCHnD54pvX4SMT2G2gwqsABj4H3CBnlLbVJe2BC7PXgLnSLiWL3hm0qdLyyezIWJVtM8PWZK66aNWQ3WYkGFEDwERbZu4NnzFiI3+J0sW3Lb8+110kvd18Y02f/0ESJTSDSha61LXgtFj7XiUg/PBdWX89EuoyHFNL2C+14bgnrNOOokEgOoJ9ztUJzs14V5XsWeSzodZSXt5iRa65/ZV+rYQbMHIp5ONjJPjEiZW0LyLxR+sL7tBR6hpi4x+NNS8fRLMlTDpekV+q3OQVUpmPNDEOutsNiKNW1Aky0pED6l9lKNHqDKan4XAJ2kaA+TYwT3ZIzCCbFZ2IaKqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVB2UWZKeTRyckJlTytHNGIydzgydmZYcU1tNmlxQ3ViOEdGdnZnRG1hZUU4?=
 =?utf-8?B?VnIxOVo5N3ZMVUtncW9MdjdzVW1rdnNMei9KN09YemcvenBvTGl6VTdJYzlT?=
 =?utf-8?B?Y2pHME9pd1VwWXJRQUlnNjNScWF6RWJwaWh1VE5JaVRSTWdHaHNNNFg0a2lR?=
 =?utf-8?B?eDJZNVp4eldVZVljSVBmYWpsdmcrbHJOR2lwdjU0Ni9NdGkxcDJOTDRrTitC?=
 =?utf-8?B?VnVUTXBBeExlODJMSXBzVVU1V2VxNWc2NnJ3WFdMeUZVVEJ6aFIrYUhndDFK?=
 =?utf-8?B?Qk1QZ0VPTU11SUVjYVA4RzJrWjI0eEVpd0ZFVXczYjNTbEpPZDhsSkdsUVJC?=
 =?utf-8?B?MWxzY2NNY3NPVW9iSUY1aXZ4TXRJUzJyWVAzS3UzWHRPWUJHTjJHSTk3NzdQ?=
 =?utf-8?B?MDRCSEV5bEFPdXMrRlN0SVA1VnJpbG92M2VlYUNEbEZ0dGZPZWNlOUIybGRR?=
 =?utf-8?B?QWtqaEg0L1RybXM0cENIQVYwNGlDdTFnZ0lFWGhWRXpsRVZwbWwvRWdVZ25W?=
 =?utf-8?B?SWpMTGJ5S1E5ajM4dnRsblBLOHRPang0V0s0UXp2OHJtVHQ3UStsd3oxbWUz?=
 =?utf-8?B?VE1DVDVPeWpxdnBoU3J1Qi9naU1EQTl5YXllSFhtbUU0aUhZWkdjeVhGOTJy?=
 =?utf-8?B?SjRqWUhGcTQwa0FEM2trcEltbnkycENlVllqak5CdjhtR2JCV1JVdFBHYTl1?=
 =?utf-8?B?NzNuTmVVRDVqNEdMeldRbllsbms1d3NqNW5LYmRHaE40bktyQ1lGTndFMGZE?=
 =?utf-8?B?b3lRc2EvSk5Oai9nbGVlL3NoMm9TNVJobmYrQklDVEJkbFRzTWFqcVRzMUpa?=
 =?utf-8?B?SXlxQ3k1SW5RTnNsUFVnMlRyUEN1cGlaZzRKeHh1Q3ByRkdDU2gzekNrSlNq?=
 =?utf-8?B?YjVEMEoxN3V2SXh1UHMzY2pMUjZYZTU0S29RWHFsb2U5QU9nbjRqN0duOFF0?=
 =?utf-8?B?cGEvVDdDTWs1ZHZEZVBaYnRiOXVkQlpWMzdENG8wTjJucU5rbk5tQnlwUHJQ?=
 =?utf-8?B?ZlBEdnRNclIrL2RtVWU1ZzZCaWcycDNVWFY5R3VsWU9hNFlVT0RpZnA5K0xj?=
 =?utf-8?B?eGgxR3B3c0hvOW0zck5EZUxMd1BKbWxwc0V1aEFaVCs0NUdQKzNIdHlMWlhl?=
 =?utf-8?B?Rm54VDJXWCttM0VQaEVsZ1JBek1xSnhNNk13SVRjck96S0orRDBSK3VNV0pU?=
 =?utf-8?B?Q1NjM2pycXpJQ216SXBUNXdtZVkxRTF1YlJJRXRYU0Q0WUROUlFOWWZHc0da?=
 =?utf-8?B?RHZzUUJWdkhWYzVlaTFoVXZZWE00T1dKbEF5UGt5OUhQcE9rendQNjNKc25R?=
 =?utf-8?B?T2l3TzV5UlJmdjIyaUIrRURCZ2FWTVJBM0FzMm55eC8zYkx4a3pqWjNtalZE?=
 =?utf-8?B?WHZJZ1BuWm56R21UT3JlQ0lNTjI2RDBKZ1dLT2VuWStFbWtGZG8zTVpnRjZM?=
 =?utf-8?B?VGxjRitmQUdHRFF1TTNDZWdxYmpqUVBqWWtjamlOVjdZZENqc0VjSXM2NGR1?=
 =?utf-8?B?Njk5ZkZLcDJxNjFvTW0xeVR1ZjNMMlVXWVdZWXNTSTFrWFNaTUZXalpNTU5K?=
 =?utf-8?B?UjVjTXQxdmVQdE44L25KNlVjdi9MWkc4K2Z0NUhvbys0a0xjQ09PK1IweGhj?=
 =?utf-8?B?c3Zuck1aeHU2eHZBdnJwcWgvVnBkZUlsKzArR1VlVkVoc2NOdVc5d0VBeHNs?=
 =?utf-8?B?S2tDZ1RWQS9CMTl6dXgzdTVxN3Z6Q0xKMFdwM09wNTgvRUg0UmtCK0I5dkJM?=
 =?utf-8?B?UjFwSVdwWUdaMzNyZ0JkdzcyS3JIWlBrcGx4c244bGxJQy9SM3pIdTdhL0Fm?=
 =?utf-8?B?S01ybm5ZNVBDQU9TRFJsekU3ZWU5cjBjN0hHbXMxTjZwV2pTRVRqZ1pncGw1?=
 =?utf-8?B?d1AybXIrNlBRenNPd3pYcG4rWHQrNmhxVWlydVUxdDZycDJzeVZlS3hkWmNB?=
 =?utf-8?B?RDkzQmxsNHZibHdXRFJKcUJ3T1JlRlNNQ2ZUZTI2ZUx3SzdjNjB6akRTbEtq?=
 =?utf-8?B?R08rYy93ZDUzVDVKMHl4K0JzYlF6YW1rdDhScWgzNGR3aXNHYVhHUURndnZS?=
 =?utf-8?B?b3c3eHF3eTVDejR6dTVRQzNPa1ZGYWFiUzRDVFpmZkkzdVpVWnZuaUVjQ0pO?=
 =?utf-8?B?UFlNdHJhdG01dFdHL1hPMXR0MGQzbWVaTjBld1MwVndSSFBDelVUVEo4emhw?=
 =?utf-8?B?Sm51SHNyRVNBcC9Eb2RMKy8xWnF3RklIak11V1RvdkZQM2FRSEJXbmJHUzVi?=
 =?utf-8?B?bEtROGRwK29TemlJVXg4a2pNcTN5bVQyaDB0K0RwU09KUnFVbEJ4MGREcm5K?=
 =?utf-8?B?SjZacThFcVJaTy9OcVh0SmgzRmQ4WUlhYm5YdGhGRXdSVWdFeEttdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16bb370-c801-4c0a-ff6f-08dedd8d0c0c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 07:38:19.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wi0Oa5WaB8FWc4sI0ei3zLF7vX/bCX3hgBT3OiZX8jyyo7K5w218NZjrQWsHi5GpmZwmNMsucqJ1AsxStsACBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804



On 9/7/26 16:32, Alexey Kardashevskiy wrote:
> On 6/7/26 08:08, Dan Williams wrote:
>> A device that wants to access private memory needs to have its trust
>> elevated to DEVICE_TRUST_TCB. That trust is established either at compile
>> time (unlikely), the bus knows the device is within the TCB to start (some
>> paravisor setups), or the device is dynamically added to the TCB in
>> coordination with a TSM driver (primary TDISP use case) and the trust is
>> elevated by driver match.
>>
>> When a PCI device is associated with a TSM for security services the low
>> level TSM driver in the CC VM has the opportunity validate DMA access.
>> That validation happens at ->dma_configure() time when the device attaches
>> to a driver. The TSM driver is responsible for proving to the platform TSM
>> that the VM is enabling DMA with respect to the most recently generated
>> evidence. If that fails, driver attach fails.
>>
>> When a PCI device is not associated with a TSM provider for security
>> services, but the device is trusted there are 3 options.
>>
>> 1/ Arch requires all DMA enable events to be acked by TSM driver
>>
>> 2/ Arch does not require, but admin policy is responsible for knowing which
>>     devices need TSM coordination to become active within the TCB.
>>
>> 3/ Device is approved by a paravisor to operate within the TCB, no TSM
>>     coordination required.
>>
>> In cases 2 and 3 if the device needed TSM driver coordination, but the TSM
>> driver or association to the device is missing, it triggers hardware
>> errors. Those errors are a configuration error that the kernel does not
>> actively prevent.
>>
>> Architectures still need to fixup force_dma_unencrypted() to call
>> device_tcb_trusted() to tell the DMA layer that TCB access is granted.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>> ---
>>   drivers/base/Kconfig         | 19 ++++++++++++++++++-
>>   include/linux/device/trust.h |  4 ++++
>>   drivers/base/trust.c         |  8 ++++++++
>>   drivers/pci/pci-driver.c     | 25 ++++++++++++++++---------
>>   4 files changed, 46 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>> index a4233bdf9804..3597b39ee0e3 100644
>> --- a/drivers/base/Kconfig
>> +++ b/drivers/base/Kconfig
>> @@ -304,7 +304,17 @@ config DEVICE_TRUST_AUTO
>>       help
>>         Typical historical driver model, devices eagerly attempt to attach to
>>         a driver and deploy all available mechanisms to allow performant
>> -      direct memory access.
>> +      direct memory access. This trust level does not include TCB privileges.
>> +
>> +config DEVICE_TRUST_TCB
>> +    bool "TCB"
>> +    depends on EXPERT
>> +    help
>> +      Devices are assumed to be within the Trusted Compute Boundary (TCB)
>> +      with access to private TCB resources by default. This requires buses
>> +      to have trust awareness and opt devices out of private operation,
>> +      otherwise TCB integrity may fail the device's access or escalate to
>> +      terminating the execution context (kill the CC VM).
>>   endchoice
>> @@ -330,6 +340,13 @@ config BUILTIN_DEVICE_TRUST_ADVERSARY
>>       help
>>         Deploy mitigations in the IOMMU layer and driver to limit access.
>> +config BUILTIN_DEVICE_TRUST_TCB
>> +    bool "TCB"
>> +    depends on EXPERT
>> +    help
>> +      Devices bound by built-in drivers are assumed to be within the
>> +      Trusted Compute Boundary with access to private/encrypted memory.
>> +
>>   endchoice
>>   endmenu
>> diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
>> index 283d3196e5e6..24951f5c56ba 100644
>> --- a/include/linux/device/trust.h
>> +++ b/include/linux/device/trust.h
>> @@ -13,6 +13,7 @@
>>    * @DEVICE_TRUST_NONE: Blocked when idle, cannot bind
>>    * @DEVICE_TRUST_ADVERSARY: Blocked when idle, constrained when active.
>>    * @DEVICE_TRUST_AUTO: All typical privileges granted
>> + * @DEVICE_TRUST_TCB: AUTO privileges + private/encrypted memory access
>>    *
>>    * Devices flagged as adversarial are the ones that can potentially
>>    * execute DMA attacks and similar. They are typically connected through
>> @@ -25,11 +26,13 @@ enum device_trust {
>>       DEVICE_TRUST_NONE,
>>       DEVICE_TRUST_ADVERSARY,
>>       DEVICE_TRUST_AUTO,
>> +    DEVICE_TRUST_TCB,
>>   };
>>   #define DEVICE_DEFAULT_TRUST \
>>       (IS_ENABLED(CONFIG_DEVICE_TRUST_NONE)      ? DEVICE_TRUST_NONE      : \
>>        IS_ENABLED(CONFIG_DEVICE_TRUST_ADVERSARY) ? DEVICE_TRUST_ADVERSARY : \
>> +     IS_ENABLED(CONFIG_DEVICE_TRUST_TCB)       ? DEVICE_TRUST_TCB       : \
>>        DEVICE_TRUST_AUTO)
>>   struct device;
>> @@ -37,6 +40,7 @@ struct device_driver;
>>   #ifdef CONFIG_DEVICE_TRUST
>>   bool device_untrusted(struct device *dev);
>> +bool device_tcb_trusted(struct device *dev);
>>   void module_driver_trust(struct module *mod, const char *val);
>>   void module_driver_trust_init(struct module *mod, bool require_trust);
>>   #else
>> diff --git a/drivers/base/trust.c b/drivers/base/trust.c
>> index 8efbe5c51250..21d374affbba 100644
>> --- a/drivers/base/trust.c
>> +++ b/drivers/base/trust.c
>> @@ -23,11 +23,18 @@ bool device_untrusted(struct device *dev)
>>       return dev->bus_trust && dev->bus_trust <= DEVICE_TRUST_ADVERSARY;
>>   }
>> +bool device_tcb_trusted(struct device *dev)
>> +{
>> +    return dev->p->trust >= DEVICE_TRUST_TCB;
>> +}
>> +
>>   /* Driver trust policy requires modules, builtin drivers always attach */
>>   static enum device_trust builtin_driver_trust(void)
>>   {
>>       if (IS_ENABLED(CONFIG_BUILTIN_DEVICE_TRUST_ADVERSARY))
>>           return DEVICE_TRUST_ADVERSARY;
>> +    else if (IS_ENABLED(CONFIG_BUILTIN_DEVICE_TRUST_TCB))
>> +        return DEVICE_TRUST_TCB;
> 
> 
> No plan to override this via the kernel cmdline?


Just tried - my test guest kernel has everything built-in. Since there is no module parameter - I did CONFIG_BUILTIN_DEVICE_TRUST_TCB=y. But now every driver gets this level, including virtio, which cannot ever be "TCB" (as anything emulated by QEMU). Thanks,


-- 
Alexey

