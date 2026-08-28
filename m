Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB221E515;
	Fri, 28 Aug 2026 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894218; cv=fail; b=lqfse9/e/1M+l7TbDjfiAzeNVhpG0qWrYH64NKLLAcTZFgb9qwzNMAyPHkDJUhAX1+FN0oGbmk483YXkf/542bveMRhloju+bkeUuKl5MBNxL1YMV7mm6j7XpFV7kQ3FhL3D2GT8yev8Z7tsi7CKnFXab8iJb+wVKQEWqEJBiWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894218; c=relaxed/simple;
	bh=dNO2y73tmxd+hucyNgi54ZT8T/H+u8B/n23dVRoeVXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bOeWrDlCrkyoVBiOAPpm7XCAJCWgCu1azwlHxIvIyj/FpF/3eR+Q/GT949vfNNK4+QuISmmU02NLOOlTsOAfrleMJIGOpA8n2UT8Hc+AlYmttL1wZmNz9n+sIwZ8AelLC0xk2qdvYMSHNe0YDqXw6haYK2xV+5LSBJRyWALsseU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d7ZIFA1E; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d7ZIFA1E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRGd5kuvwdNAUamgJTAt0oF198KaOtdWOxyEsdEz0+k4Xag+bOZ0Tpcla4ZCdKQ4zZXPBSKkL5V9FVsN8u8ohXsY0AULFtgFQcEe9E97nZGBpvE1BMxBl35wYx5LmwKe4kQJc+NPsGwoYe71XrlTWaH0sU0f8IEDkeNpK3hH09w+WI3/mzUw0zlPZ0AiRwfFNCtKXBPgpRdZ3SrXebc560jfC5FRhS/qkAuXzPb6XVQK1qQaend0GxxmFRQaWwuN80OmrXrvS6cBEou7niEDXq8kwCYw/B38QowiTOYcLy76WE+p7CR8XVWkazZl0IqcivFUlfUZ3qBLy97NKvzzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLNX5U3Zss6zZ6YcUmTwb8qzVP5SdczyuIQm/EjKdKk=;
 b=URnO6rqudDbgIq1VxFFg+0hHgpJUHFBL8fLCllgBCS5EOH5YIYTGDrERU0gcts36Pcjw/81bRZabIOvt28oBgSgQzfIz4s+eiZoJ3V/momMQz6qzva4LWg7tJ8MgmIqz1TjR2fyCZBZJlQEF7OVVx6u01cEQ9ORAKeTGa4Eo1ByrEMHl1Y+fSuYMAqpdlAFOnByEHMMUF2e/dZt7ND5fETxIpoPSgVT16AT0BQsHhzmkSxoS2QIkvYx3mqYwifJ122XnlwtCt/MARFi+LuLYhKRNLFMnsouvmKSXwXaSlZ7d6RFn+IMp+EPSMk+BlIwhBas1LgKNieUpT6R3TfIFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLNX5U3Zss6zZ6YcUmTwb8qzVP5SdczyuIQm/EjKdKk=;
 b=d7ZIFA1E23LJINSeMmTYvoEd9fXBXWGeWVd87nc0eTwtg4NqAW0ZLsel6o/oimiq2eMBmbm6JVsXO8aJeyt6rJjbO9bBuP/QKwq94+S0l2tj05nWMyA79MbhxpGb4hvwDCA7yShmgNovQ4V1ME78sLlp7OChX+kE3T1H4UObAb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 05:16:54 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 05:16:54 +0000
Message-ID: <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
Date: Fri, 28 Aug 2026 10:46:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com> <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com> <20260825175315.GD3325090@nvidia.com>
 <ao3oHn8HiXIx5Wrl@google.com> <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260826122147.GA3666382@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0357.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::6) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: f50dd465-f7e3-4002-91e3-08df04c392cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eRExMbH/8MTKE8wOFvL+/7aWyiZJ0WzKvgOSz4TE7bLc0ODxuK8Q32uym+A0vC7koCWGvq2KlZo5gsslRC0okaKukDEi8EAHrx3wZEY0lWB10hKMEYAXxGWJ+VFoIlBN14eECbDgseUpeokA7drYN/sNx9iGnLvznDxMDzs2FtnB/WmOmanu+p1BK5jiav/HczUHZ7sIH3h+ox6GlVNzoRpttvgYFUk0tkJ4taa/qQ597vIvLl5TwQ8GaDaZvbx7/WvbELTSrEd7Eob489lLKHXPfC88+ub7Sy9TXc+dS4hwHvx0dh2noITJiGCWru322akVoeow7Q8Yf0e8TIrE3qQhaAiVxgFG5xIXHLxPut+Tmyswl8p/B2wHHqHCrr9Vp0f/2tSwbK5RThGRVBZzeIt8N+C61tmcbx3rdSMIeHdM+U8lvgy3YVGQmyR5qC8pfiEh0AJ2gcOa9epADmcCGJxR4P7aQv6kbaVN+p7a8HJ/7xZpyl0VSfE5j3ifb+HI+wyQsdRRwxt+3TitTbdVwYGBIOZEzxLfWz4SkczGyQVl0lsWl9pBZEcGKATM2upI4xzq7kaB49H/YwS8+F8I7mZBZEAP8bJiEsZjVMjvo+b503LSqtC5ljpP9e9WW1FeDF6VsoA78fQ2ig8iB3FiXv1AmQ9pWfMDHGUy46cxGcI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkFocHdmSVhzS1NWU0dPdDAvN3lCd29IUGswOTNLY3AvcC91Qm5sN284ZDdQ?=
 =?utf-8?B?dndXa0NDaXBvd3BJR0tjT1ZYK1B5UnBRenVYbXltNGFSbllOUFVGNzNPL00w?=
 =?utf-8?B?aVJrNHE1Y0xmWFAzMmVOQkV5MXBiOW5hR3A1a3lRZzAySHNrRGhGUi82ajhh?=
 =?utf-8?B?WFhRUWdDc05KZjc4YmhaYlZ4eXArd0FSVW1yU1F0QmxXNmdoT1RZNU1qQ0FT?=
 =?utf-8?B?WEgzSS9ZZlZldEpvQ0xrc25wOFpWWjhsTlNNTXNsRWlXYVpEK0tuVWFjVGpL?=
 =?utf-8?B?ZExlL1BVaXpQR3lZQjJRc21kVlo1OC9yQnBnN2ljbGd1cVJGdGFWM2hEWlhu?=
 =?utf-8?B?OWc0MDY2a1NnOXJHclYwU2paVUIzbHpkamxzSHhOc3p0akF2bjFEY2RVTzI4?=
 =?utf-8?B?SzBnTGdnRi9PWERIWDlEaGpBTi9MaTlsOGpDL1lBUzFqbkt2SURBQlJLb0N3?=
 =?utf-8?B?UlMxTy9wdWRXK0hnbGdTRitiQzVZWnZVMGR5R0FqMGNDd2N1NlB0dHFEYlRv?=
 =?utf-8?B?RFAvVTlWYUF5QmlFZ0Q5bGE1eDVFSDVQc3lIL05Bak4zRy8wazFTMmJwKzJU?=
 =?utf-8?B?TThhOTJ6dVdpbk9FSmJqbFBUbEVpTC9EWXlma3lQVmU0T3B3anJoZjIxNTVR?=
 =?utf-8?B?d1EyTXYxUWJtZGhNTGFZQlpRK0R1ZlFNa3U5YTZpRDFJMHhHQUhSanoyNWZw?=
 =?utf-8?B?QUJZWGpmaG01QmdPbUJiWklKbEo5SmFhbDNvc3UxZXdnMlVDNVp2MkZwZDlB?=
 =?utf-8?B?bDhZc3JlUEhaVkluampaeXN4dzIzUUUyQyswYmFxK2FPQ2ZTN3I3akVKbC83?=
 =?utf-8?B?Y3QwVlROdlV4b1VDMGVYNVU1VU0yN1BjbUVhYm85QVE3MVRUY25nSG1ybjVl?=
 =?utf-8?B?YkxrYTBuakZid0d4alI0U0dqNGsxWktaWFRwRkZFN1ExazBUUlp2UEYzamFm?=
 =?utf-8?B?Z0VqUW5LeVluMlZIb2c1djN3TjR3MHlkV0NocXp6UGxPb1NIQUkrRE11RDFr?=
 =?utf-8?B?cnRBdThFWDh6bUo4c0h3V1MyUjlobGk3ZmJqTXJlbVpCUndZODlaQk0xUkht?=
 =?utf-8?B?K3Z2WDFIdmJBRDQzdDdIbEtJN2cxUXU4WEpSZkV3ZEdaemtORWlxeklpZFo2?=
 =?utf-8?B?bm1xVEJKMkVWTTcreG1Td3RGUzcvc3JVN3FLdnA4NUNJMUhIWGRUa01CdUJG?=
 =?utf-8?B?Z2piODV4UmVzMFh6QndVV0cyMHlPMFVIc0crMTBUZDN1WFd1OTBpVFJYTFJu?=
 =?utf-8?B?NU1FODRIZDUxbERVVDJJUUllUmxIT2JwT1h4R2lmYWZPNFhsZkIwWTRkam1Z?=
 =?utf-8?B?RWhZQ2ltQTd2ZUpFa2gzdXpxR3lncjRSc093TFEvUWozWTFOc01Hc1JESzhR?=
 =?utf-8?B?bXFYY0poTVppQUpGNi9EMnpWbDJ4ei9iRXF2T3dJVzNHcXlPYWxPbWYvQUx6?=
 =?utf-8?B?ekl1L0FJT0tzWlArOWwxaGNlN25oaDhrLzg0cE1TMFBIUStkRk9QWFJ3ZUx1?=
 =?utf-8?B?d2JwWlFZK01rVW9DSXZXektuOElKYWl1ajl4Z1RHeUJTN2hXK0tyN2xGTERU?=
 =?utf-8?B?ZEdLSklGaWx4OG5LTkYraHY0eGdRNHJ0dkFaMmpaMXVieHpuK0VPNDYrazZu?=
 =?utf-8?B?Qng3aUhOMFMyQkFxRTgrTUoveW5TdVhQUlp6dEV0eXVpZkJCVXgxZ0V2Ylps?=
 =?utf-8?B?OVRmUU1uNHNkcUJLVEtKRFBsaEtXV1RkUTNsdGgzQUJFNjM5a0VZbmVrWDZX?=
 =?utf-8?B?ZkxTcjNtK3pzOVI3dzVTTHV3cUFCYjdGclo3OUI4bzhJRkFqUytyNCtwSUk2?=
 =?utf-8?B?TjkwT2VhWGJWT2JMUGNKaUpGWVhYK0VvLzBubW12aFNJclNYdGpUWlJlNHRS?=
 =?utf-8?B?ZFp4TnJIeHBBQjZKaklsckc3WlN3N2h6U0hTZGhDRUE4T1FWeTF3cklmSkxY?=
 =?utf-8?B?MnhUZUdaSjlZdXhDckx5OEV1S2VwUXpPdG1JKzNwaFlqc25tOWVTck55dW55?=
 =?utf-8?B?b1cxOXozSnM4VXVTS3VSOFVyR0pIOHRMWkRLSGN4dVBRbmsvV3AvTXJKdDhv?=
 =?utf-8?B?MXpXd1VkUmFOejNaZFUzVlVHbjBmT0t0eHBUbnJCbk5rQU5HZTlwdzRUVGdr?=
 =?utf-8?B?QmJpVFNGMGtWR1RHaEthbkY5ek1TUk8yNEphTjA3UE94VzhST2J4Q3FlZUJX?=
 =?utf-8?B?RGFtTEdmek5iNlVTaGpGSStNZkVjUjBlSVRNVXI3Q2JNTGN1Q0lTT0FxVndE?=
 =?utf-8?B?T3hmQXpwMXd0TEp1UkVnbHV0azdpZzNEMDUwc3dPVTRYbFV4ZHNydXJIVGRI?=
 =?utf-8?B?WWltUWtlbTFzT0EySFFVMWlBYjdlSUNiVXRIYUxsVkJiRnJtUDdkUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50dd465-f7e3-4002-91e3-08df04c392cd
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:16:54.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byVrety+V6aqsuwqlboeuuZDMT/Hr/6r1WfW36X65GOhUPp+lnuoMTSiNoYcjzbsNEZ13K2Lc6liplCEv9nXmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062



On 8/26/2026 5:51 PM, Jason Gunthorpe wrote:
> On Wed, Aug 26, 2026 at 04:58:15PM +0530, Vasant Hegde wrote:
>> Pranjal,
>>
>>
>> On 8/26/2026 12:38 AM, Pranjal Shrivastava wrote:
>>> On Tue, Aug 25, 2026 at 02:53:15PM -0300, Jason Gunthorpe wrote:
>>>> On Tue, Aug 25, 2026 at 05:29:59PM +0000, Pranjal Shrivastava wrote:
>>>>
>>>>> I agree, but I wonder why the existing code used memset here 
>>>>> (in ignore_device):
>>>>>
>>>>> memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
>>>>>
>>>>> I was thinking it might've been done for probe failures in a kdump
>>>>> kernel (normal kexec would've called shutdown for clearing all DTEs).
>>>>> (I see this was added long time back and existed when PCI segments were
>>>>> added [1]).
>>>>
>>>> For kdump you'd want to keep the original translation running in this
>>>> case.
>>
>> If probe is failed then we can't do much. Why keep original translation running?
> 
> It might cause the kdump to fail if you abruptly change the DTE. The
> kdump semantics are to leave the DTE unchanged until a defered attach
> event. An error flow should not defeat that.

Since probe is failed we are not going to attach device again.


> 
> It was already running when probe fails, it can keep going.
> 
> The memset doesn't even work since it doesn't flush the DTE cache, it
> isn't going to actually change any active transfer with a cache hit
> DTE anyhow.

Yeah. We can keep it as is and it can keep going.

> 
>>> Even I'm not sure why we had this memset here, I'll just dig into
>>> the history once if there's anything. Otherwise, I'll simply drop this.
>>>
>>> Vasant, please let us know if there was a different context to it?
>>
>> Looking into git history, it looks like, during boot init_device_table_dma()
>> sets dte.v bit for all devices. So probe fails then clear everything in DTE.
> 
> That isn't how a secure'd iommu driver should boot..
> 
> In a secure boot flow (eg DRTM or something with untrusted PCI) the FW
> will leave the iommu setup to block dma when booting the OS. The OS
> should then ensure that it never permits an identity mapping as it
> boots up the iommu.
> 
> Having the driver boot up with all DTEs programmed to identity (eg
> 0'd) and then try to fix them to blocking after the iommu probes
> devices is security backwards.


During boot, it only sets dte.v bit. For DMA to work we have to set dte.tv bit
that's done in set_dte_entry. So it doesn't break the security.


> 
> Look at how ARM sequences it, the stream table (aka DTEs) are fully
> configured before programming to HW. First it loads force blocking
> then it does a pass to switch those with IOMMU_RESV_DIRECT to identity
> (see arm_smmu_rmr_install_bypass_ste), then it tells the HW to
> hitlessly switch from the FW configuration to the table. Ensuring no
> device that shouldn't has even a moment of identity access.
> 
> Since these secure boots have become very trendy now, I saw AMD PR
> about their version, this should probably be fixed! :)

Yep! We have secure vIOMMU prototype. We want to start discussion once hw-viommu
series settles.

-Vasant

