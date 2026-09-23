Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75A1CAA6D;
	Wed, 23 Sep 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122216; cv=fail; b=al/vJd82ba4DYmWvVBzPvPSFzUK5+1yExuMqKMmH4ng6rug/D+FIp6MV1uWg13LnZbOP/7oIfqZUkuepR9Urhl/kCgVKYkCP4BXRK1/fz3B5vGZ1STMqdZYCAbI+ZzqxLVhhcyXWzzWKZQwhOF3D1mX5tAe4jhJ5998Vua6SJkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122216; c=relaxed/simple;
	bh=Ct7xn53WIV0Kxztn7WLdwpAC3Hspkz7TaciiTG364I4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JsGGys5XhL1RzCMmLDJOIQajljbwVy8dKZe8RYyQfH1PbG8eaBUD3GhgLZVH37Nz+fDko/c4rkCLQ5Qeq+wgtS/c3Mqsgo50lTHQ3Gd8CfVsI3sm4WGbVGypaLulWQ7Tdq6Cai9EhnzFENMu3fgDw0TF9RdjL5rW2Kfs2krtmdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ePuwJYt0; arc=fail smtp.client-ip=52.101.48.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ePuwJYt0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIoMM3pRnHLEfvekt7aixSNKwwrFuJdTp+iTfHU3xkEd+NstYRoa6h7skXcD2TjTlLaVl5wdUmqesc9oOh6K7AznsidkcJXUmRyuMuIDYHQlJN5BXMRq85a2kH64oZZUyXpVgXQyykdPF2VIK6l0DqFPfoFoMFhUjiArSBcKDrKZCvjdhdlGNd3M7pZa1TNlsJhxTPjzcQ4zapvvdz6py9BATjcpsiLpIa0/clpdO6GKx8B/yMiTDFVDKhATafYSSxMeS5rkSAET+U1aSJ35n9ETpg0G19yawH0bHkF5WG/z4udKsIA3imu9Tc9nzq8sv1/BmCBofqN0Jl2V9fBvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf5hkAtYDRNdANONGLlLOOom0ifbGeLrlmJHORu5slE=;
 b=pv97f/ytrQiOhqSaXRF93mGBv2yL+wzovHp9/mpLj+wF3GmXs0Mc0RnEp5eFraEL8TqiinpLRJrtuB1mwkeqc2TdHj5ZKsabtV/r3vtMFRSsRjU7davMJ0rtVKr2HZ4xMMyFcezQMWcOYL6QuMDSFRoQ8FTaDkMvDKedFVotxWkgmoDTyem7nOKzcxmMKudCUTzJ2XQr4bwlDZdSWZYdsn0a33mOQsmms/EDNffXfa/HYtHZeObsFVCnJ5If+H7oGVgYQym4d3lHjPHTmWQ28/i5meUKPea26aIOTLsGKKQTSwmaPcBlRs3S00Nn4zN93y8KAU9mPKV2cXOh2XUuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf5hkAtYDRNdANONGLlLOOom0ifbGeLrlmJHORu5slE=;
 b=ePuwJYt0LEQIQrGrFDtm0e2r76HP6DROl8qmrkiJuHl1DWz/JFdLCjLTvPrI6u4v4fVINuWBBpoMnCyDUPzLj4bjT/5ykU7QGKkrmNjwf2ojFYnPZ64SCFqjdVJItFLnj/myNXepXb8udoE/GCe++MbHCLSfLnZ8ef9HWc9gmCa0KRn82czV5LLq/uqGBqMVz97Nnp6O07zA6v1zt7VK+OKcOYLecOFZ2z6hYX7nRUqzsSGECLBHS+N6v32ff3fF+zGtEPCJsQV5S/tmLUWllEvxtSvHHxbsW+LU2q44dNfC7fJ+RcwuVhx5rA5sHXYe4woep1dmUmJM8gf0dYMOFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Wed, 23 Sep
 2026 00:10:10 +0000
Received: from DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f]) by DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 00:10:10 +0000
Message-ID: <b7c0facf-f1ec-4108-9a7a-fe5fe8fa594f@nvidia.com>
Date: Tue, 22 Sep 2026 17:10:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/12] cxl: Restore CXL state after PCI reset
To: Jonathan Cameron <jic23@kernel.org>
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
 <20260910070808.1444264-10-smadhavan@nvidia.com>
 <20260912024332.17a19b2f@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260912024332.17a19b2f@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To DSVPR12MB827618.namprd12.prod.outlook.com
 (2603:10b6:8:3e5::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB827618:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e29154-f031-41b0-22b0-08df19070811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LT832vb7WW+9gSdn/X6On1jH5xnb//04CCC4r0RLQwnDEvqRmYo05hzb62fn9Ga9DeNO5fR4Zzdo1/WLbtmaUmp+TYWhibKTdJgqcmZqUDZKI1CDlK3++dpuuoZHoLrgbIRE063EfJEHL50iHkJjDmn0oZIdPS8SuPDEWTfS9YUu/eQJB16kvlsrj6pA58gFzE4Nc3Ypi7A5/ngR+i2mFaF1FtQVlu8X/u9gUBa1l/3S2v40cdN+dM2EH3z1f/wIq/749z+uzLyYLfzG/47JUaKifQfBVxvu9i3/DIv8wQtw0gKf3fHG4+wdktzSikeIBgY1JP8x6oA6o2Pjp1hQH/aAmHGrrOb4JFz3WLlxDNZHI0Y+QUc3ZWxmGJyULOT/0RuGDMY1tsPNDmVrzRScJqvPdbFUN5y/kcCf/Cz8jxfi+3TI7IqcsZgBvNcOFX2D0UBLLMesz7VWjsbFr0RloXn5kiwtEtapDMU7I9yY1ZMzQJiA10/AFQQo2q8TqMAt8o8lPeE0GMv3B2Bk0GsE+x4uDlhzccV9anqZ9ybfi64eY3HYbyshtPTXXOm2QOhDPnGM7WzRpj682ph5YrVvsph/LjUf5YD94tD0iSzDBwMQgzuswcclF65ro9LguWR1j6PJdWbgD49TPwr7R5nCpBixwZV5DJY6etnB5pgwEvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB827618.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmFCYVoxb1ZaQWFqdkV6bVVNSnlmM3F3ZkU5NzhpQmZLcUtoUUdQdmxnVnRk?=
 =?utf-8?B?MzVlRVg4N2hxS1BHdVRhZDZ2VXNpb1FVL1VqS0RhelJwSjFKWWtaZ0UrdEdX?=
 =?utf-8?B?VmQwZm5jelhnc1NYUmhmRDdIK1NEdjhiY0FrejNsK3g3YU5iQjRQL1c1UGtU?=
 =?utf-8?B?WnR2Y05OeFJzdjczN01rdWozQmlyT2oxUC96dFlaWTNaSFhOdXcrZEdSMDZl?=
 =?utf-8?B?c3dOdmRXeUViMzZjOGZuSFJ3eHBodlRwK2xJalBQS1BiNkdmZUc5akh6NXNn?=
 =?utf-8?B?Q1VOZnFoRnZlam9YN0ZEVWhZVXFnVkw0SDN3RWg2ajdsaFJFM3pUWk1ucVJm?=
 =?utf-8?B?YXhyN3hTWWpTeDVRd0hHT05jZmRkbUNjOERaNDNDZUdjOEZ4ekJYS09wTXVo?=
 =?utf-8?B?T3hGNFdXc2hBQXNTalFOclpnazUxQWFCSmY2cm5waGJjNU0zWXJDaC9jZkg3?=
 =?utf-8?B?MkpnSzFPQTl0NDVWL0RHOW5yK0MrV1RVY2VORlMvQVlGcEloeE9CeG1odWNw?=
 =?utf-8?B?V1lXcXlwSjluRTJQcFhaMTRYd2VBSStlT2x0UlpzMk1TQzdmZmJmK0M3UERm?=
 =?utf-8?B?MWh4VXRqWVprQnlQWmtjZ3BGa2lzTU94ekVXT0cyWWIzODZldVBtSGdTSWxV?=
 =?utf-8?B?UDcvRUJFeVJGTHp2RTJmY3QxVHJYbllpeDlGdlJWMTBSMUdsNFBDd2xJY0lr?=
 =?utf-8?B?RFFGK2ZOTlVMeng2ZU9XbXNVV0pHNW9VQ2M1aDVIVVJtUThEdXZoSkhTa2tk?=
 =?utf-8?B?bFE3NDAxNWFvYmEzWVNESEk4ZmZKNVRwaktDSlhtK1ExYnN5OE11VXRFczZl?=
 =?utf-8?B?NnZtMFUvUWIzS3FIVmF6aHdzanRyeHRUbG9Hb25jYmRQSXN2WDJRNURXUHVN?=
 =?utf-8?B?MHhYUjVXL2h2c1FmLzNmakswMVNnZlVoUHdQMWN5dUt1V1dMemc3ZmYyekVB?=
 =?utf-8?B?Q21DN3lieGpzNHdPWU9uODZ6cVlDVUE5SG9zREI3cjQ1SURPT3VmandqM0VV?=
 =?utf-8?B?WUN4bUxTWVdUQ2hKVmhCbU4ydHhldlBpcEdGSVUwYUxkdTJVdXUrVi9kNlFs?=
 =?utf-8?B?RE1HdW1Wa00ySndRMExvbzlCZ3c5bnh0cCtjdVZqdWdJRmJSQlkzd1pJc3da?=
 =?utf-8?B?U3BlWUJCNDMzOWtMKzlOekVIcjR4bzlSd0Y1YmR0ZFFnVHlXcmtXZHVveHdX?=
 =?utf-8?B?VjJzU0k4ZlV5STNUbCtlZGtTWjIvSWxwaGUxOXM2NHpCTjEzcko1SnZlbXdP?=
 =?utf-8?B?dUdmcU9IRFRwRUIwT3hiT0lQa3Z4VGthZ3BTWEpSVkhIZ25mb2M4RkkrRDJD?=
 =?utf-8?B?b0N3R3RpcDlrN2MxYnlsRzRlYjAxVXdLTkNqWkRJN2ltZ3QwTnhJZ0NDTVNJ?=
 =?utf-8?B?UktVNTFuYzR0RkVReDN5OWZRYW8rdG0zVGE3eC9pVDZ0b3Q1MThJS05sdmFS?=
 =?utf-8?B?T3hiaGFyNWQyT0RGZzRWV0MwYnppcDBMa1I4dkdVeTFwOFgzYjc0V1RHUFNj?=
 =?utf-8?B?UGNFRHh2NXdYQmhVNVZ6OXBGdGFEL21NMUFKM2ZkWW1qK29pdkpTamRKMzFN?=
 =?utf-8?B?anlQYnBkUFJvbzBmSy9JQjNqdVEwWk9ka1A2czc3My9HdWQ5b012ZjA1NzN2?=
 =?utf-8?B?TG9kR0IxbGVtSDJsVXZXczJQdVF5VVdHcmtpa2hnbnpHVldHcWV5U1BJZ0xO?=
 =?utf-8?B?TFU0cGlXWEwzdXBaVzQvcVQrb045bXlzRHEySkxib2FjRkVBU2M4RmV0amJk?=
 =?utf-8?B?aFFHMnBWTm05RmRaMXd3ZmFnYjU2ZE5vOS9mTFY3T01OKzAvc2F4ZzBtTHB1?=
 =?utf-8?B?ODBpTjlURU43V3FPVU5PaDFudFhoZ3dNNHBuSEMwR2FQMi9pQ0xGWjVaU0NH?=
 =?utf-8?B?MHN0KzhTMWRlTEttYjhROTlaaURCRTc0dmVyTmNJY2s5UE9PY1VGdkxwcmV4?=
 =?utf-8?B?cjBoVUgwaWxmaktlYUxndHZaYkdSK2JRVThXU1JkMG5TSURXS2xsNGN6UlFj?=
 =?utf-8?B?bmxJZ3VTUzB3N2ZJT3NhV1Rsb2dDU05jOGs0ZnFHSXpsNzJVSHJ5cmtXMkRO?=
 =?utf-8?B?WjMxTHNIeXJuVHlkeWY0eElVeDNNekE0OExlVy8zR3l4MitYamdDSllyZTFq?=
 =?utf-8?B?eFdPSXFiNzlUeDM1WFV2M3RYNWd5TVRzUkJMUnE1c3R2allmdTRJTkw0T1BN?=
 =?utf-8?B?UHhwWFZqVWluTEVaSDlzb2lES09ENDdYYXJDOG9STS9zdVdUVW9tY3ZobGEz?=
 =?utf-8?B?a3RnS01qNTBMUEZSaEx3cHMzaXE1eTkrZ0F1akNiUlNPLzltWExZZjEyOTZP?=
 =?utf-8?B?a25yTXdNRGVhOEU4bUVERTlkNGdkUStvUHJWK3pGMUIwMGZCM1J1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e29154-f031-41b0-22b0-08df19070811
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB827618.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 00:10:10.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrZs8AREE7UlCb/Y0Q9nROtI3nk+MB6gCWuvCShO1fUEg1KtGwnWKosh9xOxEA8taKLTw/b9d1lfc4w0mtKd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781

On 9/11/26 6:43 PM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 10 Sep 2026 07:08:05 +0000
> Srirangan Madhavan <smadhavan@nvidia.com> wrote:
> 
>> After CXL reset, restore PCI config state enough to reach HDM MMIO,
>> restore cached global and per-decoder HDM state, restore the cached
>> CXL.cache and CXL.mem enable bits, and then run the normal PCI restore
>> callbacks.
>>
>> If reset clears a previously locked decoder, restore and commit its
>> programming before reapplying the cached lock. Leave a locked committed
>> decoder unchanged when that state survives reset.
>>
>> Keep the target IOMMU reset block active until CXL state restore completes
>> so Bus Master Enable cannot reopen DMA before decoder state is valid.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> I'm nearly out of time for today and have given quite a bit of
> feedback on earlier patches. So this is going to be a scan read
> at most. Make sure to take another look at this and incorporate
> the sort of changes I've asked for elsewhere for v13.
> 
> This seems to carry on papering over the cracks after errors that
> to me indicate a broken device.  I don't see any reason to do that.
> If a device needs quirks to say don't run a particular restore do that
> but if they are real errors, just give up - your device is not going
> to be useable with only some stuff restored and you may be making
> an obvious bug a much more subtle one.
> 
> Jonathan
> 
> 
>> ---
>>   drivers/cxl/core/resource.c | 411 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 396 insertions(+), 15 deletions(-)
>>
> 
>> +static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
>> +                                struct cxl_hdm_decoder_state *state,
>> +                                struct cxl_decoder_settings *settings,
>> +                                void __iomem *hdm)
>> +{
>> +     u32 ctrl;
>> +     int rc;
>> +
>> +     rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id);
>> +     if (rc == -EBUSY)
>> +             return 0;
>> +     if (rc)
>> +             return rc;
>> +
>> +     cxl_restore_hdm_decoder_state(state, hdm, settings->id);
>> +
>> +     if (!(settings->flags & CXL_DECODER_F_ENABLE))
>> +             return 0;
>> +
>> +     scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>> +             rc = cxl_commit_start(hdm, settings);
>> +     if (!rc)
> 
> Use a helper function for the stuff in here so you can return directly.
> 
>> +             rc = cxl_commit_wait(hdm, settings);
>> +     if (rc)
>> +             pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
>> +                     settings->id, rc);
>> +     else if (settings->flags & CXL_DECODER_F_LOCK) {
>> +             ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->id));
>> +             ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
>> +             writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->id));
>> +
>> +             ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->id));
>> +             if (PCI_POSSIBLE_ERROR(ctrl) ||
>> +                 !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK)) {
>> +                     pci_err(pdev,
>> +                             "CXL HDM decoder %d failed to restore lock\n",
>> +                             settings->id);
>> +                     return -EIO;
>> +             }
>> +     }
>> +
>> +     return rc;
>> +}
> 
>> +
>> +static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
>> +                                               u16 *command)
>> +{
>> +     u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
>> +
>> +     pdev->saved_config_space[PCI_COMMAND / 4] &= ~PCI_COMMAND_MASTER;
>> +     pdev->saved_config_space[PCI_COMMAND / 4] |= PCI_COMMAND_INTX_DISABLE;
>> +     pci_restore_state(pdev);
>> +     pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
>> +     *command = saved_config & 0xffff;
>> +}
>> +
>> +static int cxl_restore_state(struct pci_dev *pdev)
>> +{
>> +     struct cxl_hdm_info *snap = cxl_snapshot_hdm(pdev);
> __free(kfree); looks like it will make life simpler in here.
> 
> 
>> +     bool restore_command = false;
>> +     void __iomem *hdm;
>> +     int first_rc = 0;
>> +     u16 command;
>> +     int rc;
>> +
>> +     if (!snap)
>> +             return 0;
>> +     if (IS_ERR(snap))
>> +             return PTR_ERR(snap);
>> +
>> +     rc = cxl_hdm_enable_mem(pdev, &command, &restore_command);
>> +     if (rc) {
>> +             kfree(snap);
>> +             return rc;
>> +     }
>> +
>> +     hdm = cxl_pci_hdm_ioremap_current(pdev, snap->hdm_bar,
>> +                                       snap->hdm_offset, snap->hdm_size);
>> +     if (IS_ERR(hdm)) {
>> +             first_rc = PTR_ERR(hdm);
> 
> I'm not really understanding the keep trying and paper over the cracks
> going on here.  If almost any of these fail it looks to me like
> we are in a bad place and it would be cleaner to report and give up.
> 
> I restored 'some state' isn't likely to be very useful to anyone
> beyond maybe making the breakage subtle rather than major and easy
> to find.
> 
> 
>> +     } else {
>> +             /*
>> +              * Restore global HDM control before per-decoder commit. PCI
>> +              * config memory decoding is enabled for MMIO access, but bus
>> +              * mastering remains disabled until HDM restore completes.
>> +              */
>> +             writel(snap->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>> +
>> +             for (int i = 0; i < snap->decoder_count; i++) {
>> +                     rc = cxl_restore_hdm_decoder(pdev,
>> +                                                  &snap->decoder_state[i],
>> +                                                  &snap->settings[i], hdm);
>> +                     if (rc && !first_rc)
>> +                             first_rc = rc;
>> +             }
>> +
>> +             /* Flush posted HDM writes before PCI_COMMAND can restore BME. */
>> +             readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>> +             iounmap(hdm);
>> +     }
>> +
>> +     if (!first_rc && snap->dvsec_ctrl_valid) {
>> +             rc = cxl_restore_dvsec_ctrl(pdev, snap->dvsec_ctrl);
>> +             if (rc)
>> +                     first_rc = rc;
>> +     }
>> +
>> +     if (restore_command) {
>> +             rc = cxl_hdm_restore_command(pdev, command);
>> +             if (rc && !first_rc)
>> +                     first_rc = rc;
>> +     }
>> +
>> +     kfree(snap);
>> +     return first_rc;
>> +}
> 

Hi Jonathan, this patch is now v13's patch 13:

   - moved the commit-under-DPA-lock operation into a helper that returns
     the result directly;
   - stop restoration at the first error instead of continuing with
     partially restored state
   - leave the PCI command state disabled when restoration fails, 
preventing the outer PCI path from re-enabling an incompletely restored 
device.

The snapshot is now taken by the reset caller before reset rather than 
allocated inside cxl_restore_state(). I kept its cleanup explicit 
because the caller has staged goto-based cleanup for the snapshot, range 
  reservations, IOMMU state, and cache policy.

https://lore.kernel.org/linux-cxl/20260922083924.2451158-14-smadhavan@nvidia.com/

-- 
Regards,
Srirangan
