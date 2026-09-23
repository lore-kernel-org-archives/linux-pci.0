Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00C53C3C7;
	Wed, 23 Sep 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188641; cv=fail; b=j1RC+HZk37gpqTItdsXcqtr0PsZDvlCxY0KTlNtdtG9zUYjnP8g7HwYTHtoLIvlCT1r26xlnZ46LMcXrsSlx04QmJzYkgu2cKMLh5EebboPMH7hWCfeiaWpeoRe0c5doiOK3e15UZ+N2gYGkj5Ewd4h+UyzTdyZ8hSCJ0VVNlhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188641; c=relaxed/simple;
	bh=s1eb+1znw8O6owasj5dtnfoLXkfefzMNuAyd59t9ngo=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=i9Vte7rF+lHzrz+h2eji82eo7mtfT3YzhD7iszimGvusnQ1DUSPPb9CeUkjOhtiiLhJGIRQ8xtLigdPOJ3YW0n0XdsGe5DxejZm6m8jg+lNDAT1HHF/96epKY5syOeA3IRd+z4p2aicVatTkGxX/v3lIni4BbuFvej2c0581Or8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JTJ3eyFb; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JTJ3eyFb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4HY6JlVt4UnJsaGycxIRDwG+cMBxJU4CPTkXJbbWQnbaD2NAuJsBTYJO4pClDV6NRSmx/xWxmvY/TGfF0C9KNCrRaBpzpPMbX3zrQDlfxZ0OqZC5Ds+PWmIo+BaScrRL3U6f+jYfz+8CI53AcL/WfQM19241tkTZfiyUXmsAK9tXEyLdRCSHVmz6ZUSn4rmCOmIBJTpt6+TJwx0agwIJ2Drxn0Unr1W1eJvTxIlf1Vb74vwxZG02fL2rTxohAz2vqYxdAonSYkVtoPqH/XGFqkQsUwQHA4fYWkGOiTpxPhCfPwUb/LljgJVMZaucOtpxZk61y2IajTNxFZxdm+nbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNdzs9xKqi3RYd4oivu7dGTS/vkSOkGZvusPK67GHyY=;
 b=N52bFH3VSwZfygM1HmtZeCYr3jlTmSow/KZn5kb99l/XfQBb4ni66+6POebHjVs6iycykp2v6tDPQhBtjmwe8EbX3DtU1D/+Mxups2Ognm2/mIJkKQbVrxX/bx1c4J4qi7ABgeivFgxZEsidF9SxfaLuy/Iwp9FcvpMOuvPUeMoY3KFc09yg5XDFcjaoDyxWignBvO8UJwbpcp0T5EUsRi39mCgkTKWwT1MN+qSCpXSvNojlLUgWjIeLer5QjtIC5GXIrvq2V4UYnCx/XjsiJqFBBlBT6qP/sLSNYdL2bP3FZNB0Isy9xxf+xB+rcPLm7mqi3WGW/aXnLwjAruncSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNdzs9xKqi3RYd4oivu7dGTS/vkSOkGZvusPK67GHyY=;
 b=JTJ3eyFbN9ZctVWYtu2pcpw8al1gMcsGxLA1ZQyBwgDI11SXzLoh620RqO6sFFeEbB0laA5pylOgK4V3PYgsEkdEDroFAR+JAOb7TbGsICT5Xu/8d4+xobIPfnW1GbSTMsrYRUvzlgG00oO1bFvrqu8OKxRuKWkl6TLZ80wWbPhArvKY6O4SnE68bi6cx7pQvgLIhYQWtT1bVkwpQzvI7UEHd5r7BWED6Z1kwHGpwPcV1a6GF9OUPOJ4Eoue50dsKgXmK8xBwv7s4KwQgpkVJc3LqsZ9b6ivZ9I8MnoX0NPSAIwnkJJxTX2b0PWET159r64uZAJLeWNnMIf9xRg7+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CH1PR12MB9646.namprd12.prod.outlook.com
 (2603:10b6:610:2af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:37:10 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 01/15] iommu/arm-smmu-v3: Disable the impl before
 disabling the SMMU on shutdown
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org, 
 bhelgaas@google.com, praan@google.com, kevin.tian@intel.com, 
 kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com, 
 Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com, 
 bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <3747b39aa5898f450535847760d9cebde37684e1.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <3747b39aa5898f450535847760d9cebde37684e1.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862535.3334538.16960845232883709349.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 03698bb1-1666-482f-7a07-08df19a1acc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BNly1/cO7TTSk8Uq7F81vndxL95AxLa7KlQJb3+PxPWkJ2CDhpb8YVGJU+5rv7vDtBXaftyPUn0TpGEsAbpc4ZRdjw+BnB9X7Hq1licnVTXTSTuO6+yvuh+ynYMqMnCh2WiLIIlGgLbMn29Rx1m1dFZDUVRkEkdLuPc6EsCIxnitJKaAIHsP+Y3oSslbkSIwLWGbXLXY7WLHm6q+O6oW3rfY4FgNLAIHinaofM/lEBBkMPqMqm/TbAqF9KPYO/0PADIowFgfHt39b4xPKiz3G4Zzn6qGz35Tkqy7M2i5BAKhz38AdwJEDZYEXoqkxzOpAtirmL/AGzOlZsKfUkQHcaLlYFJ9441dHW7DH1sZA7x7c4EANi0twMeYfWRMuSwCZOSKFUJL1ciI3OoyzEzApExLZ3iPtMG+5sCMuACOV9mqOPQSkDn3XuEFx8RmE9vDDEWO3GvRZiz3DjhPH9oWkIpbnnkhLHh74tQSdp3xK4G0kjRzd0Y9quwbhOOGdAX6wRzor5sqxc3FBN63u6p2e/BIFWnlO4GtaRJzMvDqMdnoCkVwkk0Bm8N6avksQGRKUBX6F2HdZLQlS24acDOFuixVyteAszDki9/rn0L1a4L45emZca2SMvY5NTIDYic5ynryjQZr9YKP5JIZ9ZwQJkwkuUJ6GSmYjZq3PxGwKus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3JhVDlhTGN3aTB4akNPTTBvVlFEZFFrejIzRWJPZDdFbGlXeUEvWnQvcFdx?=
 =?utf-8?B?R0Y2WGU0OE9vYTZFUVpCTHppd3M5QkhlSjQrWEJ5d0NhU3BteDhwUzZ3ODNa?=
 =?utf-8?B?NjduSXBwdkRNRm5ORlJHOTVHUkloZWdlaWxvSG1FWVovZTU4Mjh2VlRHcmgy?=
 =?utf-8?B?Y01ZdHZtM2piaktuRGdJOEtkR3llSVZDSUZmeG9OOUF3bDU2cUR1RVQ0WVYv?=
 =?utf-8?B?Z1Q1dHJpS09kL0VES0c4RjNHNCttMEE1Wk10cUlncHNkQ1BuZTJIRXZVcnBF?=
 =?utf-8?B?d00xUkZCbG5CK2NtSE9uUDR6c2tCeXQzUVJaM3gyOVZvOHY5aTRsaE5pZXRR?=
 =?utf-8?B?SUhQc20rSURjUDZoRnJkcjZ4K2dHOE9GdkVWblBLNzdMaTdOU0kxSEJTR3Nv?=
 =?utf-8?B?U09KUUZjSkFVRWNZZXczd2NOY2VPeElkb1NzVjI0SmQxeWJ1emE2eW1KVUh4?=
 =?utf-8?B?MnBtNnJTTElodFV1ZGNpcmN4RStPaHdCRnBaaFkzR284MlN1RVNpWjNTRTRX?=
 =?utf-8?B?SmI1QUVxL0FpU2tDZjhhMWVTdnZUcWFyUVNKdlM4aHdkYm5YcGF4aTR4MVVz?=
 =?utf-8?B?Z1pOdklQcDA5U0NCTks0bVpVNmpYY3BHTlR5S2RoUXg2UFpibDRTRE5RcmdL?=
 =?utf-8?B?OUxmR3BvZDRUOWx0WS95aEx5bnF1Ti9YREdqZVBQblArWUE0Tm83V1RzU3JZ?=
 =?utf-8?B?NjU3NTFDRVJya0QrMlljbEpJV0ZUMXFPUDNGY3JmeHhTUnhSL3NPTGhwL3JX?=
 =?utf-8?B?Q0VFdUZBUk1USUorRkV5Vmx3eHdabXMwZVJiN1hEcSt0Y0M4dnlDT3UvSkln?=
 =?utf-8?B?UlhmSjZNbldrWURVckUrMytMMUdodGZSMExWRHRBQWRpS3p2WTBEUGxSSkJo?=
 =?utf-8?B?VksxeEU4ZTFFQW5vUDUwQzZsZWtzME9kTGZuaWhtNTlGTlJoWFZmMXJ0M01T?=
 =?utf-8?B?L3JuY1ozVDU1RmFSRXpUcU4yUUUxdjVjYW5VdkxQVVc3cW1PT1M5ckZNRkhP?=
 =?utf-8?B?NThkaXF0WUFzWmZYekthbDFpUjhkd3BIOWQ0WDJYa3pCcDRua0hvZTlJK2xi?=
 =?utf-8?B?KytWVU1MSWE3dmVhenEwamJ5OGNUZ281WGdjY3dOME02bGVtNVdBOHVKMXFo?=
 =?utf-8?B?OEwxdXp2TEJJdDMyZGlTRk5vQTkzMWRwQ1NsK2lJdGVXa1JHM1UxbDBIcjQ1?=
 =?utf-8?B?WllYV044MUFsRHY2c3VnTjU2aFFCdW9lUkIraGk2MTBSakF0MGUzN1hKbXls?=
 =?utf-8?B?MDJuK2ZuSUwrc0VLVGRsc29mVTdqclJNVVpMbjlFeXVKRFFWRys4cEQ3YWhm?=
 =?utf-8?B?dSswL2lKMnBTY0FIa1EvWHpoYWFkN0xsMEhYN2FnYXdZTXpkZXFSUWIzZFoy?=
 =?utf-8?B?Wkh6Y1RxMyt6WkUxQXl5L2JsZXlVUXhhZmZsVW1lOXB1MVJmRDNkVWJJc1Z2?=
 =?utf-8?B?V3JaVDRtOEloWlU0Z0dzMEU4T2tvRTM3OTJSdWhSYjA3YnVWaEhoUXQvbzJF?=
 =?utf-8?B?ODk2clhSQzVWRFpVanhYd0I3N2RncnZnWDZjaDlmRG40MVFQQzdpeCtkblBy?=
 =?utf-8?B?OVA1U0ZNVnRrWlZsVmRUNHE4UStWdTJ3ZS9kMDNzR1JlQmVwVnZjNW9NSDlY?=
 =?utf-8?B?NTJ6cTdDSVVvK1dqdDFhZlExTmhzTWl5Y1FaUiswK3MveTg5TGJTUStWbmJ0?=
 =?utf-8?B?b3gwUWtkVDk2L3ZkQWZBSkdRSEcrRFJtT1d1NEhCZWJUQUVTaDBuVDFaaG85?=
 =?utf-8?B?MDhHYkFyYzQyeHlYU0ZBRWZoc1FDRzlhUkZUbHdLYTFRWm9rNE5uVnNZZG5C?=
 =?utf-8?B?TXlaUzFjcWx0Vit0VlEzdlpTSnpPYmplMHhhc2F2b3JrU2c5TFcxTjlQWnFP?=
 =?utf-8?B?NWtyMFBjb2NURk5FRHhwWWtVQXJEcjZtWkZwYW5JT0FoM1dwU05QeGJvdThK?=
 =?utf-8?B?NjR3R2trYjNUSFUzVlpWdExiaDR4R1Q3K1NLRGRlWUF2Tkg5dXArUndrQ0xR?=
 =?utf-8?B?R3VZbi8zclNicUxFMDZLUGZzb29rZGEzdXQxSFl6YlVxMHlVNGtUWlVCTkE1?=
 =?utf-8?B?YXdiU3NocS9nUnJBVFF0WkxxWElxRUVHQis0NU1uQkJyZWFTV2pvQWtWUVBr?=
 =?utf-8?B?cldFbURLUDIrYWFGOW0ycGZlRkc2OURBOUFFZFQwTEJJYzNHYXBNTFVZeUox?=
 =?utf-8?B?MU9odDhCVDAySUZGeE55VmloekNzQUJ5bS8weHlyRS8ySWxFQUNMNGZ6b0Zm?=
 =?utf-8?B?cmZPaUtDcVRkSkJSbC8zNkRyUUtBRm12TlR1N3FtWVNUcVNoMTc5cllKMXRk?=
 =?utf-8?Q?9FInMobQat/NhVaNry?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03698bb1-1666-482f-7a07-08df19a1acc3
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:08.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqHn21nbwkddrwj3vQiFP3SF1m5SHBgT0/V8I2Fqzjj8g3VJrQxlCtYjn12M4pmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

On Tue, 15 Sep 2026 09:38:13 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> arm_smmu_device_shutdown() only calls arm_smmu_device_disable(), and never
> the impl_ops->device_disable() hook. On tegra241-cmdqv, that hook quiesces
> every VINTF through tegra241_vintf_hw_deinit(), which issues a CMD_SYNC on
> the shared CMDQ while it is still enabled.
> 
> arm_smmu_disable_action() already runs this hook before disabling the SMMU,
> to cover an unbind or a probe failure, and no devres release ever follows a
> reboot or a kexec to run it again. Have arm_smmu_device_shutdown() call it
> directly, instead of reimplementing part of what it already does.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
