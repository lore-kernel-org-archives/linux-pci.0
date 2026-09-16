Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E48F503BF4;
	Wed, 16 Sep 2026 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568398; cv=fail; b=Igh0ZcFCPFVchrABe4fQhBDwak46xL7dZOodONKWEiU8vNzfk7Rc57t7cd0WqiIaU6HPEbXWaIGi9FeeOiWZFB4uduVANLkGLdgodYCZAwA4dSOE/2O8/utzUk4pYigZMcC4G66azwuGPElUAPneqmJ/CKyKqjiP4G+eLmVJOTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568398; c=relaxed/simple;
	bh=BxhX56BUpkPSw/N3+YlCOS5urWiXmf5ujnnYHmykEdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=goidsOvEHNVQ2iXSLyoue1umaOSjf5nJz1uJPqIeFyPtpAaVXoD2NJ7KKu1CBBP92u+97nc2OTbh6ulNJKuizqjnfdwHM8/ltaOL04UwoUIF8Oz13Z/Pl5udqGdWzO5MkcpR8tPBTLkTTPXZDF60KaKrYRVLy5b28kbFJwtAnvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ej0sekJC; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ej0sekJC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPoILQSrenkA+SUp64FE91643hajIvZAN9ZjhRNceUcrsAG49rk2QLWjiUhtRcTxIjy1bXmbvHMnpsqVdFVIOA2ZyGpAuLe7+ihsexWrelzuw8rv7/nHZ8aO29hkgZaWnoiECUxS5AnfYuVY5YR+SKAuXip5HMbmW27c1sCl/M73ivR6aQkKL3sDXArQr3LHoMe0D5ptRs0jSEnyOLkJyFrFhPs4RpfVfv09forFkq1dXU5txTfCoINiLznXNU4900vJ39m8/DwiniTomgO8BVDfsWaJak2HxUVeOD6v0E7G9qnTBMNSwkVdKnst4htJd/DkPWR/FdsdB1K7OAd0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y49uP/0eWsPU5T4lWBH2LsBH0cDLkJdWpiNqboe1DJI=;
 b=XBHqujz2sr1tUTz9eJrVlqOy51AfmgiriwzwMWsfcesbTM51oKQMyM8oy6U8FLgAtoCHosVC6cfVuNk882tat91qf1gI6UU7E5a94rNPV1YDvdszatAKruYUIvs0tNSzp/aYXlLlejXQG/2xgasTxKb1/lRPIC3rR1nxLkrHz0QgRGsFbN+r+VWv4xYVBpTJEnPiFuuhAd+vV5yfGRJwjOsphw75BrykPVxc4XAOP0ZOFJNqoNSJtddr04XWxoRbQf7GvukLs8rQF7p+fPXJ+hpHL4koisKf5BE3QPlH7bmCxgIvTyPq4ztdIJ+r/29k+sQrSjSd6jqkmjxDO0go+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y49uP/0eWsPU5T4lWBH2LsBH0cDLkJdWpiNqboe1DJI=;
 b=Ej0sekJCuV4quyl4aa8ElDB3iFYXnFCHjvXSUetN0lloWPff9k8CDVwv6Rv2cPZ+9ylqfuhh30p33e8D4iClHZnhDuHKFvUJZJ8BzYDl36AOBX9Q0zTEyNvB26fLCYP0B75Vsf774WodxopGQiojeE3TGK1UsyqvgihdM77YggU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAWPR12MB999142.namprd12.prod.outlook.com (2603:10b6:806:4e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:19:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 14:19:53 +0000
Message-ID: <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
Date: Wed, 16 Sep 2026 16:19:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
To: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org> <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com> <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAWPR12MB999142:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c24e63c-f8f0-4e04-124d-08df13fd9350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|6133799003|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Gzh48wIsnjdl3NsBGzB0KDZEcB4NSlPC14XbYDHDQeuykH68Jily1ku3s14abFQbMnYUH5NkXVkYT1mdVdhZbDwtJVFolvIQa4zdnkbfgxRBFznzedjoXYP2tB5KyVOWFeHx46Y9jAZLTFdkBA845mztmPZaO9oR66gDhRiUWqAG3ACoZzoKil1OEFQ+y6UJ8FVx/KpRPNQC9DGmVEvlcTK2f09z7FxQJats0lUUn/8t2CZAhoKBEGMGilM/EjvIx5FJOInuYPRuI3Xk+SjO2ttzGiOHcjK2+nrwtdQNTAOnsbX0a8YcChJtCapwhbzM3c0l+jY5gZvlBACK64DBw3aVjR/mmxY4Nfwjus+/bTUeiApglnj6hh2ilFR2uRcURDD9ho9N25tZEpzMEVh1TNawahwAgvre3nHdXk2IIP0WqHE8gIbd5qqSiDLBcPVltz6CvYzCa3oRnsXTsp72IcER28dJxSgmagSXeuPtZfzcbD8X9eUzB3z1jZyqomcT4n24tGCzQgf+70e08BwrQdEUPITQRq9wyNb5Icu4Snxqc3ouBKK+p2qhnm42YkZAOohzs6omw7xTX54c50dCQCnJlAKcUNB90K0KaMNMBlh49Lkk8NdkA4b9JW7gkiaITkY0+fE3x8OloPAnbEQsb8Nz7b/yqoVVY/oe/gE2gIw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm96bFJuWDBiSzM0RG1yV09vL1lpRWI5L3ZHYVB4UnhaNTZUdjlYQi9pRElo?=
 =?utf-8?B?elM5ZXd0VE1uRUk3WENsQ1VMOHBCaEdnZUVOL3l3dnVDYjN0Wk5BeVlmRTNo?=
 =?utf-8?B?MkRIaUwyTkJPVlJsOTR1QlpMWXY0aHlsNHk2S25iN1BrYzNRSi9zamNjM3BR?=
 =?utf-8?B?bDJZWVA1VC9yaVdOY1VvTWs3UVp3dDkxcnI2cURtY3FZMldxbnhpV0xmNDZ3?=
 =?utf-8?B?bUprUytsR3V0UzA4dHM0bzN6Z0Zoa0lUMWRoU0pCbThYRlo4anFuZEliTlBL?=
 =?utf-8?B?Zm8vajdXMFkraTk0bzErbnh6YU8vQ2p4cWs0YnZVN1NBcW1sbFpBTEVyMFdO?=
 =?utf-8?B?VVNSQ09UaVc0RTFFemFkUVBrd2pEVEhyVGtBTEFBU1VOckNIZEswRVAyM3lp?=
 =?utf-8?B?cDB6VDcyc1FuZkw4R0JXRXBhZUgwd1l0eXo1YTBVUkJpZjJMUDVmeVpyR0Uv?=
 =?utf-8?B?a3M0TnZhM0g1NVQrZXg0K1Q3aWJmRzB1QWxyTEk2YlAwZ2NDRy9mcENpakFs?=
 =?utf-8?B?dGhFeEZoYi9JWkhTUDV4dEE5S1pqS1k5NThkNVB5S3Rpc2ZVaHZ2cHZNODVk?=
 =?utf-8?B?Y1Z2dTRYc0NBaDRoNWl3MnhEYXNkdU9Pb1ZkVHhsQjNjQlNsc3FtUGNXVGg5?=
 =?utf-8?B?MnJqSUtuZHN5dzRWSG41MUdRM2hiMTZWdkxhMHhMMmE2TFo0OWJJWTl0dmdl?=
 =?utf-8?B?ZVg5MlNhSG9SZWtNbTBJeDU4OFNHMzZ3SkRrcHJ0alcrYTE2dVkxQVVvcXlH?=
 =?utf-8?B?TE9XdmNoNGNCUm15OUJzRWdnQ3J4cnVrSitweFZtTG52TGNkTE9zSytpYXRI?=
 =?utf-8?B?aVlDdTRiMFZnNlBOWHNIYXNIYy9VQTBXWDZUZEhQUzd1WVI5b2hpeVB2eGZM?=
 =?utf-8?B?TXRDTEtzODg4ZzZPNlhRTDVjN0lrV3ZkTTRjeHV0Z1FSR1Y5blhmaTgrNWRS?=
 =?utf-8?B?amV2S1B4RXlnUDhqMlVJM1lZSWcxVTRDN1N4Z3Q2UkZub0NHMGFPWFBFelMz?=
 =?utf-8?B?cDFJVmxMQ0Qzd2k0NC8vVWRlTENCaWVKOStGRU1TVFRuUHdsVSt2cjUxVWd0?=
 =?utf-8?B?Y2dOZ0Q2eWtPWGdacUE5alBWa1FCbkMyTjJsUDl5OUUvQ1FLZ3BhZFpvWVlX?=
 =?utf-8?B?WnFHVXIxdTByVERudkJ1alI2aHVHeXRwcHNVYmF2amZaTW4zZm9PSklGbzI3?=
 =?utf-8?B?R0QyRWVMb2UySFluV2MzcnVMWTFSL3lPeEkzWVZYZGRsZTN0YVJKYWo1cGdI?=
 =?utf-8?B?ZlVWbmpLVzhtb3ZWdFFtMG44b1UzVkR6SE92RnRkbW1rdmlubHV1OSs1Q2tQ?=
 =?utf-8?B?RnZFWStpdU51K0JnVDh6WDgyb29YOGZmaU4wbnJpakdrbUlvS2lRZHk2M2ZD?=
 =?utf-8?B?cGdwUzdFQkUxaFBsTWNhc3VtazRLYnRtYngrSDV4Z0p4WVJCRndoVXlIdWpL?=
 =?utf-8?B?aXlsUXl2bDRuTnV2eDkvcVBmVDd1YnM1NTNTSVgrd29KT1BWeTNzMFNNVVFQ?=
 =?utf-8?B?WnNCWkZkTWNWdWNvc21uSGpLVTRUMUQwWWRJOHNnMDMvTjJrM3ZwMGdPYlB5?=
 =?utf-8?B?V3NMVUVwMml4YmpsdGEvMUZsWU1TcjU1d01rVkU1VWVuLzIxRnJCU2lGZTUv?=
 =?utf-8?B?U0tVTWdCd1RRTDhaY2ZKUDNzUldrelhpb2ZScy92S3lndEtrWGlZL2ZpU01h?=
 =?utf-8?B?ZlloNWw0ZlpSVGwrUU1ZTFdFWnRGeEF0MXlUeTh1cXNtZFNtb3p5bWM3cmRS?=
 =?utf-8?B?L05CZk8wOVI0VW5VZEZFbm5Ud0FVaWd0aHI3SHhhNmZpeUJBd1FEbVlIeUZ3?=
 =?utf-8?B?RjBUQ295eGhva0Q2VVdWeDg2Y0l0dS9pS2RUOHFyYUVxWFg2UDA3QS93TjhE?=
 =?utf-8?B?RXJ4T2VKN28zVlA5enFmRm5mOHg5L1JBdzUvMTc3U1VIT3hRN3hYa05PTEx6?=
 =?utf-8?B?WHJFWjhlNmJhNlJRN05CVjJKU1o3SllpUUZYTzdjRm9ZK3JlUXJjL2d1UlVI?=
 =?utf-8?B?QXhHUEVrZlJpeGtFcyt3QjlHUkRQbDAvbnUzUXIra3dNbTVNNFVrQThDaHlW?=
 =?utf-8?B?VThwbmpnQVp2K20xd3dQOW9jdFQwSlBPb2lOUElVTmJLSXFaS1o3bzRqbjlC?=
 =?utf-8?B?YXF6TUZDZlhCc0lxcHhabm00SlZyQ2V6bmlKUFdpcno5alR3R3pRQytlZDhq?=
 =?utf-8?B?OFZ2THRzQVdjaXpxWWFaZitqS1NabG1nblRTU0NiWWQ4cWZvZE5IdWVtdjVv?=
 =?utf-8?B?UXo4MDRoL3ZQSWxoSnh0aWtrZ1BpNitpK2VNMS80ZUNsaUxObUlDZEpyT0RO?=
 =?utf-8?Q?wPLtfozIyym82/Vf2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c24e63c-f8f0-4e04-124d-08df13fd9350
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:19:53.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d2sOgS8xSRg7CSLEMcMBxWqsvGD8Qg+vSJB6xGXdNnMOMtPn9XX+KVuAhtJ6CsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999142

On 9/15/26 16:22, Matt Evans wrote:
> Hi Christian,
> 
> On 15/09/2026 12:13, Christian König wrote:
>> On 9/15/26 09:20, Leon Romanovsky wrote:
>>> On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
>>>> Hi Leon,
>>>>
>>>> On 14/09/2026 12:54, Leon Romanovsky wrote:
>>>>> On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
>>>>>> On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
>>>>>>> On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
>>>>>>>> Expand the VFIO DMABUF revocation state to three states:
>>>>>>>> Not revoked, temporarily revoked, and permanently revoked.
>>>>>>>
>>>>>>> The thing is that "temporarily revoked" is actually the standard
>>>>>>> invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
>>>>>>> for VFIO.
>>>>>>
>>>>>> I think temporarily revokes here means it is revoked from a dmabuf
>>>>>> perspective
>>>>>
>>>>> My guess is that this is more of a "change owner" operation than a
>>>>> revoke operation.
>>>>>
>>>>> The main issue here is that we have to guess the semantics instead of
>>>>> having a properly named and documented operation.
>>>>
>>>> Apologies if the cover letter for the series and patch commit message (which
>>>> cover this) are unclear about the motivations and semantics.  On the commit
>>>> message, can you suggest clarifications:
>>>>
>>>> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
>>>> ranges previously delegated to a subordinate client process: by
>>>> revoking, the driver process can ensure that the loaned resources are
>>>> made inaccessible when the client is deemed "done".  The original
>>>> DMABUF is defunct, and BAR resources can then be safely re-exported
>>>> for use by new clients."
>>>>
>>>> Given what I'll explain below, do give suggestions please.  There is more
>>>> context in the cover letter (the volume of which I didn't think appropriate
>>>> for the commit message).
>>>
>>> 1. Do not mix "driver" and "client" in the same description. For a
>>> non-native English speaker, "driver" has a very specific meaning in the
>>> context of the Linux kernel.
>>
>> In the context of DMA-buf it has also proven vital to clearly use the terms importer and exporter to describe the different roles a driver can have.
>>
>> I can't count how often there was confusion because people (me included) just used "driver" and it wasn't clear which role was meant.
> 
> :)  I see where the quote can be clearer.  FWIW the "driver process" was
> referring to a userspace driver (which is a legitimate use of the D-word
> with VFIO, but still).  I'll clarify that, and will indicate this
> mechanism is used by userspace to influence the VFIO _exporter_ behaviour.
> 
>>> 2. Explain the lifecycle in the commit message, and why "revoke", which
>>> is effectively what the importer does, is not sufficient.
>>>
>>> 3. The more you put in the cover letter, the less likely people are to
>>> read it.
>>>
>>> 4. Commit messages should describe the patches themselves, since they
>>> are what remains visible in the git log, unlike the cover letter.
>>>
>>> 5. I would call what you describe as "temporarily revoke" is actually "reclaim".
>>
>> +1
> 
> I don't follow here, sorry.  Would you please elaborate?
> 
> Currently VFIO uses the priv->revoked flag to track whether
> it-the-exporter had previously done dma_buf_invalidate_mappings() on a
> buffer and is now causing all .attach requests to fail.  Do you mean
> that (even without this series) you want to call that concept
> priv->reclaimed instead?

That sounds like a permanent revoke. 

> Or do you mean that you don't like the words "temporary"/"permanent" and
> are looking for another name for a temporarily unavailable buffer?  (If
> so, I find "not revoked", "reclaimed", "revoked" much less clear than
> not/temp/perm revoked, as such names give no hint as to what to expect.
> But I may have misunderstood what you're getting at.)

Yeah it's pretty much the naming I would clarify.

The original idea of notifying the importer that it need to re-create the mapping was resource reclaim.

But when you have some IOCTL or sysfs or whatever to disable a DMA-buf permanently I would call that revoke.

I'm still not 100% sure what a temporary revoke should be. If you have some IOCTL/sysfs/whatever to temporary say to importers "You can't use that resource" then that most likely won't fly.
 
> From the importer side, there is no change from this patch: they might
> observe an invalidate_mappings() and find attach() of a given buffer now
> fails, same as before this patch.  This is only about guaranteeing the
> impossibility of an importer ever being able to re-attach in future.

That sounds reasonable.

When a resource becomes unavailable you seriously need completely destroy it, re-create it and then import it again into other drivers which want to use it should it ever become available again.

Regards,
Christian.

> 
> 
> Thanks,
> 
> 
> Matt
> 
> 
> PS:  A hypothetical alternative way of doing what this patch is doing is
> instead to have:
> 
>  - existing priv->revoked
>  - new 	    priv->revoked_flag_is_immutable
> 
> Then, the ioctl triggers an invalidate_mappings() for a targeted DMABUF,
> sets revoked = true, and revoked_flag_is_immutable = true.  The new flag
> prevents a future vfio_pci_dma_buf_move(false) from clearing revoked.
> For example, a reset doing `move(true); reset; move(false);` can make
> all DMABUFs available to attach again, except for those marked
> immutably-revoked.  (That is equivalent to this new "permanent" state.)
> 
> 

