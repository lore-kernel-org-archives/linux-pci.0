Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5994388E44
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825776; cv=fail; b=JrZiWP/HzFfMhSlUpS9etu7C3Mm1gQotQUzuTK/MHuMoBOvegDSMCqZxS7ooBZAqIc3cpkkg9W1H0xL+dtIN0B0DNlfCo4WBGUAVUhedIWjE8oYxSqqUycka7giXAEfGeAlIkEU7AvPoybVOGWMHhjRmqb6lzOl4CQpV1ewB21U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825776; c=relaxed/simple;
	bh=NPpuMJnenCeSKDMmr8qdFgT/m8KQppOxYzMcWruzvOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aq1ZaDxkuedulKFmLQvbyHNJTa+Kuz7qs/R+vVZgmI2wU46Yt4bkTcOFs7VXnAQQCBvwpcpxpcjb43+9nU8hTWd4GVo9HeYscxK0Og1m9BDPefg2IWAuWfmDiWjX1sy7xk/CsgHWjNgMNBuBHyhTyb+4W0qkCoS3iLoIkpU+4MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jujur2Q7; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jujur2Q7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvtnEX5YFCE3kJiHw3MbwGmD3C8/rR6gMVzw17y2RvzRVJiu1wtI6LqKHLev6Sk+PpLonafo/ZDC5pVcKLXfeMEGiZjYmIveR0uZ3FvBHQj16gu0okvXNCszn7JikP5cg0nnrPCkYz2n2oOfRDckBldjgfeC+Zme6C8ACzc4bYWsZTvxN/Fl4bPgFlSILHSq48v5ibsM37fM85Fl21HWsa8SP/8Xz1CG0T/VXEZuX6Monr3c7wgeGuymxgnNURdVkH4kR0dmpy3tmKa+kvfUXCVlEKcDn1pKkwtWMRaXY/H9JilBHicQyERjabfnLeQ2Z5ELlywHlsnIleoLLS7ZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djdWSwwZlBwm9r0/NtP0CDR+0cSdtVrxrzh17gMvdVA=;
 b=joaBTA6MnZsPTPKpGI1rLu9+LHAnol+rJGFW50eCos5myDqxhrhhXXgumh0KxNe1VVHl9DMd60kXEopokuOL+9hD3kn8SP90dODT0KmfaKuWSTlEYFU0wGD2BQF8swcHWHfgxSSWq16U/WfhQqM4c2xEmGq6J26Siq8oZpkNXjl20DJhPdhcWCb/QgH3ZZafgYc4+5z91wnNfNh+BK2SF4CFc1VxR6tQ06HqcwmtRpkLW0m0MctQT4jVB/WdOsYqx7N6Xx2zkhBhl39Aek3GpyGe4f+vAiFQGe/DaLtmv0tJ62a72uN8ahGJpNNpyJ1CjAPyhvJpvCcT6z2NSjYUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djdWSwwZlBwm9r0/NtP0CDR+0cSdtVrxrzh17gMvdVA=;
 b=Jujur2Q7gakcF5W0d3wo5b/ihnZ2EssIH6CIKv6j+raDloD/hpTvLqfBASqAOvohPZqmPW3Ycee3hWGYiL2j0EFaIGKhg12jF4iuN5pl7bXWYO04B9UbpuN6sLx+fUvTdu0PiExXKNfnqC2sAUk+PjRQtSW3yEjm1drb2IehTSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Thu, 23 Jul 2026 16:56:07 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Thu, 23 Jul 2026
 16:56:07 +0000
Message-ID: <a3262d2c-394f-43f3-9956-24c9490626df@amd.com>
Date: Thu, 23 Jul 2026 22:25:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, jgg@ziepe.ca,
 Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
 <20260723155912.GB836122@bhelgaas>
 <f2242b3c-5d2e-41cf-9136-72a90e86d17b@amd.com>
 <69bea169-ac78-4b33-b9ed-0fe974e0248c@amd.com>
 <e9595d4f-419f-4d42-bd22-c3a8964c370b@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <e9595d4f-419f-4d42-bd22-c3a8964c370b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::8) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 3793ff73-1c06-489a-e9bd-08dee8db49ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|22082099003|18002099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	zjLabd/YptNGhAYu3X67fkaTk+xf8ly2nIFN6YiGD3OnP/UXyCYsR0/Ap4R6/Bdpw/VMoTJ9v8pgCMhkSE3HBkf/j8NBLOjSEVZO/4C99FBXHFs32OU8Dngj2L8im/lx90ZQWxAhpNzS5GVqTsNdmE64+e+s3HCGYP2nYjcnTVMfCXJO7egA2Em7cSwzMViSEpOKwhaZRjW5XZsDEJevZlJ69ezv3yRqIOCWP8QWZ3aIRFiTi3fhO9xoJOPVK09Rbloa+f66aK4NeVvMmH1YQw2nVE9EQQVjLoxvtq5lJFgkUF32PHZQyC9idy0xdUTTHiKg2g8cHOcyqMHpiATBWCIzvbm2Vu7qJio2IJLsy1EUFtbTuVy06Akom5r2E75ukOgsT/aRMl/w+loBWSxDFyNtQyyJp6gauLXP2QrGJG8GG0TFnz1/VFrZTIpxYmxstNqp8t69QS+taPyMbBCzlVv68nO5RiXdGrbnNw9u94Dgt5fbOxT+m6/XqrxGDfDEWEk8rrvDseTfcmwZnYgXbphOmmiwHTPwMEC9gP30xqIOZDdK2wR/Xn9dBcgfKNcyeyRqtYnYCsJGBpqSBfI82/zY4YvId9WR0xVodwrREerpOe595V9MB7He6tsgTxqJfhZxNZTz9wQP/K3D+24FC05RcKkqgkdsY0I+DGoA0f8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG5GS3RVVlBYckx1WUI5emxrZ0hPcjRPNitIbURRbll2QVVRT2dyTlNETGQ3?=
 =?utf-8?B?TDJqOU5VMXJVaXFsK3dFR2ptV0NGenpJWGNQbDIwVlp0T3VzQ3RTejdyaUhI?=
 =?utf-8?B?RTdQQ3pveXpnMHlIQkNtdkpEVVk1dVpOaTJ4Q0dyT2FzT3JSYkxSQjBVWWU4?=
 =?utf-8?B?UHROR0pOZXVvSENRdm5Lc1hmZ2s5U0FUVVlxM1p3QTNQS25wY3BuTzMwZnF2?=
 =?utf-8?B?TlA2SWdJZE56bkFSa3hEeW5GY2RMS1ZUNUx3QWlHR2UrcXpFQjJhL2t0SWM5?=
 =?utf-8?B?UWtFelpMOEdwdGc2UmtIcG5NNXVHWEg1aUVCSTV4Y3hyd0d4RG5aUkpobUlS?=
 =?utf-8?B?ckcrRlBDV2djZVU0TXM5RlQ2b2oxbjZicDdSbGNsR0ZFZ3g1bXRBVkF4cWZI?=
 =?utf-8?B?Wm80Skw4YURGeTVvTkUvYmNhaVovUXFXZHdTSDhjQ3B2ZGNRcGdPUWhvOVda?=
 =?utf-8?B?MjdpcW1pVkVUSVFpTmdDaWx4Yzl1NGZKM3poeldtZ1BtWkl1cHhHZWpDbHVJ?=
 =?utf-8?B?c3RQMjhjUGQwUCtXR0loeXRPOEVvVkNqM05ZTldzeWxrdnZvWjlYalNydFB3?=
 =?utf-8?B?QlJCVDhYS09MVVF4Wkl3b1BobVA2S3U4aG9LQjFsY3o2NTU1dkluTlR0elV4?=
 =?utf-8?B?V3RnZTI1WjNMeHp2dTFMN1hnR0lOUVYrcnJyZnZ5d0JoaEhtdnd6RmFDWkVy?=
 =?utf-8?B?aUxvUkN0MEhYeHB0QTdXa0FuNG4wK3lNUjlZR2M5K3ZMODI2M2FPN3VBWmd6?=
 =?utf-8?B?ZEtkSUM2RUlSKyt6SW4xd2R2NXhwZXdqT25FNEp3QXh2WUhCSC8wMm5hMGc3?=
 =?utf-8?B?U01xR0NpaVRqQks1aHA5VTRFRStNNnJnL1hFaXNlUmMyN1BzRi9tb0F1Rk93?=
 =?utf-8?B?VzlYanp5MlVJVEFhanJTQkhHRE5kbkM2TzRISjJ4NG9vM2licnZ4V21uUTBB?=
 =?utf-8?B?NjYrSktlVkk4WWwyMHA4MUtTdktXaTYyQkxPRWhYR2JudUQxbzlqMVFVSmdK?=
 =?utf-8?B?d2UveFJ4c1ZjSmI3UXlRM1R5M2NOT0IwRG92UklBM2RrK0tXOHVDditFSnMx?=
 =?utf-8?B?TWsvVms3VHhKZk1CT3VjemR3VXRSdHlHT0dUS1FxNFBialdnQzAzOXVFT3Mv?=
 =?utf-8?B?TlQwZjdZdGEzS0pIdUxSZ29TZUhyU0h1YUhPWUpiLzA4RzZkZ2Vld3l3bHNo?=
 =?utf-8?B?RndvaUIvd0h2MFBXWFlWYVU0VnQwRlNxWEVnT3FZUUZiZUl0aTBEbVI1RlNW?=
 =?utf-8?B?a2UwSm1kSHhsSXYzSlF2bjQ2MDNDaTc1QUdyUVd2SXVjSDJKSUwrTWp3VkMv?=
 =?utf-8?B?dWcwQ1VZa1NiU0FrdHBlZkp1d1JlTzZ4dERiY2NuWnJUWTB1WDY4cmd5aWYz?=
 =?utf-8?B?Uy9DVHlld0hTcmNXbURwM1FOZ0FwMjBRczlJaVEwZFUwbFd1SDlXdjQ4Ry8r?=
 =?utf-8?B?RlllWVpwZXZjaUc1MzBidXZoV05IenB3aVlCenZKUnp1NGNtUzMxTGcyT2hk?=
 =?utf-8?B?Y3FBd2xoVmgyc25hU1FpZkhSQklTTHBMWHVHUHMyMEdFV2JrZnovaVNVaGNh?=
 =?utf-8?B?MzNUU0RtREFNTXA0TEpkM3VaTDhIT0NVTWIvSmtIYkcrYXErN2VCc2x1S2x2?=
 =?utf-8?B?ZzdidHcxTkdSVWF0cnVSaUFyR0pUUmVrQzJndGhndWhCaWExQmU1WlNyR2lX?=
 =?utf-8?B?VVlGTkYwaDJPYnV2cHFUdExCR3NkeFpmc3RFR21DaERrcnFtZXIycWE1cG1y?=
 =?utf-8?B?aktpSVpqYWpZQXQ1MTZFZDNTVExBQ3pNVTdhdTdKU1JqUnZ3Nkg4ZDVsajUy?=
 =?utf-8?B?encxZ2RFRkQ0cVFDblJoaUhVek1DS2VJOFRwVXdjaVlEazVaZ2Y2WWFIeDFj?=
 =?utf-8?B?SEtpekpYYmlDSEt1cDJrUUNWbUUxZ0NqMTlYalhGNEVsczRjUlhMV2RXNFdP?=
 =?utf-8?B?SkhEVS9IaWhuWGxqZDBKKzZJejJrZzErdUhjWWEyc2h6eFNDdkYyWElLSGVK?=
 =?utf-8?B?bkFtRGV3WjNBZXE0KzRnYW5XYXRmeC90UVB2aDU1SUFXcjJ4WWRTRVBvQTZq?=
 =?utf-8?B?ZXU1di9HM0RZVnMvM21jRDNxY0h6SVkyYkx4YXNkNWtQdlY3UkdJdWtIaFlK?=
 =?utf-8?B?cDVNY3N1anAwbkM4aUViSzFSbkJlSGZydlJKQ0FGUVNJSnF3OWFJRlhaa0JX?=
 =?utf-8?B?bnA2WjhJcC82TWNXNlFYQ2N3MjltdGpEV0xNNFN3bDBWRWxza2dBV1IxR1or?=
 =?utf-8?B?K1p2ZHAwQ1NmdXFjcG9hejhObWxoVXhQYjBDU0IwWmFJcHJ0UnFaN2FVR29U?=
 =?utf-8?B?QmhiOUR1M0FPT3UreXhybm5vb0VicEtaYllGMUhPOWFsSHVyRDRYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3793ff73-1c06-489a-e9bd-08dee8db49ce
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:56:07.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgAaCj3gVEDVifliMl//fXbcQGEYhQSG8wmNHBlc7zlsQA3SVXcx/AN+u1DL2clikUw90mWOZE1OMwIGiuOYWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

Mario,


On 7/23/2026 10:02 PM, Mario Limonciello wrote:
> 
> 
> On 7/23/26 11:23, Vasant Hegde wrote:
>> Mario,
>>
>>
>> On 7/23/2026 9:41 PM, Mario Limonciello wrote:
>>>
>>>
>>> On 7/23/26 10:59, Bjorn Helgaas wrote:
>>>> On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
>>>>> Certain AMD GPU's must always be in identity mode. Currently its enforced
>>>>> using PASID check. It worked fine as most GPU's has PASID feature. But
>>>>> this means, identity mode enforcement is done for all PASID capable devices.
>>>>
>>>> I think it would be useful to know something about *why* these devices
>>>> require identity mode.  And what happens without identity mode, i.e., is
>>>> there a user-visible symptom that happens when the wrong mode is used?
>>>>
>>>> Since the code doesn't test any feature bits, I assume it's because these
>>>> devices have some hardware defect?
>>>>
>>>> s/GPU's/GPUs/ (twice)


.../...

>>
>> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
>> +{
>> +       struct pci_dev *root_port;
>> +       int class = pdev->class >> 8;
>> +
>> +       /* AMD GPU vendor ID */
>> +       if (pdev->vendor != PCI_VENDOR_ID_ATI)
>> +               return false;
>> +
>> +       /* GPU class */
>> +       if (class != PCI_CLASS_DISPLAY_VGA &&
>> +           class != PCI_CLASS_DISPLAY_OTHER)
>> +               return false;
>> +
>> +       if (pci_upstream_bridge(pdev) &&
> 
> I don't think you need to check for pci_upstream_bridge() to be non-NULL.  You
> already checked that it's an endpoint by looking at the class.  So an endpoint
> will be connected to a bridge of some sort (either a switch internal to the dGPU
> or to a root port).

Ok will fix it .

> 
>> +           pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_ATI)
>> +               return false;
>> +
> 
> Make sure you leave a comment here about what true means (/* it is the GPU in an
> APU */) so that if we need to add more cases later it's obvious without having
> to dig up this thread again.

Sure.


-Vasant

