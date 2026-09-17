Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261E495AE8;
	Thu, 17 Sep 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636445; cv=fail; b=QZQj8Xhm74FSFiDocsFc7vRHjEv8h+whlzq8ZDtZvJ/zFGItSe14sJs4D7kP/oB3qZ1w34xo0JNFwSCRm6EuOWepEehd5I4LzIn8eV9rmxV/39K8IDdNMM11g92fI7hqWjvCi6MVu6O35VoNmUgjhQThRYAZg/0rUE5V26Dx73Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636445; c=relaxed/simple;
	bh=EAKiBs220ZwPvDcHQSpK5vFGT+uAPOI4HclTtRCAPLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g2ujkzspKSc8CLU6T3g4xtKYMUKInKxV9uZmqa/vkoaxuGcb88nRxY0lj16D5226CH6/i+tdr7pcs5nYv+NZ6QGt/RsDVFpt8vlbpaBDgZ2344LCf7Oco7+5ooOLJQ7Tm4vBOCtNx94bTJH+ahArQ/yNAcTzFqkbXoDMhnHQGbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DFHtNIxp; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DFHtNIxp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0im24aBK5eHe+o55mbEZUEc+1n0kuKftuaFsgT5o07D7MGzIoMOaqCkArFQgt8kMjhW+kjiaLhtdBH2BDMZ+XEtHPLPE2FxrHh9xmYfMg54Teo1IfFc7Y9VsRuBZxpU0GU9uLGJr+3gPc4855w9/i1XEIdcGqyHJWiaeYSy6Cy+2jvO/oBwaAN9hsCsFENJMszAx7py4/t7wlzdfI7KkMbezfAnnEtrxb1unKScAQL72TaiuAxaYXX0ranK6aD/ANwJGGRmzlqrgoZzPfRLkiCyONA8eM2bDefO+Zcb3fGK4d4p7tlAlewUbmWcHypJPcM+DWbpCVjktXjCxJlsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su1rfIRsKkMmgbGb6XJGSY0JIEhPpcPuhhqaF0gfWI4=;
 b=CiaQp2EfQ3yDmZeo1Z4qCkekp67jbjPMzN62GSuaPhfQ+/5lLs5a462YuPewo233cWJXAm6jQHj7OIYrOKjtvv9WmbdfrFVNVqhGpP2e8UzPvNuknUjHgc1gc/GI8szkbTl3ZwxRnPbKlYvCm/kk1zchxD5DM/SqtbThm+9p5EEw5ozI5p4UVHZNFYCWe4YRhnbDbjH5bKAh4GpEeHBKZl+c/khNeMI/wHJuMNRG0gGSOjIbTc89vuiWj/Fga+q+/iy9XcQoahr8aZNEmz+Xcj7OV3jOb7u860DrqYfRQRCGOWRcAADM4Mw+PZCnNi+JUXKp5dXz4QeLAbnNMJLG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su1rfIRsKkMmgbGb6XJGSY0JIEhPpcPuhhqaF0gfWI4=;
 b=DFHtNIxph42A8Q/mM09IPVy/Wq60GnLeI/R8EskVFlH5JCPiyCzb7aD0KXks6ILNGALvvlMmx/mtZ7JDI60M+AK5bHxOc/LIooA+YAKVBx0Mu0txdrNNx1OPEJ2Rw8lyCb3qCh29YtnKeRvn/p5Cp1tf+khSmPLfA1H5MoLdtoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 09:14:01 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 09:14:01 +0000
Message-ID: <2b6e2d5e-4aa7-4498-b63a-f549f1bf22c8@amd.com>
Date: Thu, 17 Sep 2026 14:43:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dmaengine: dw-edma: IP name corrected under its
 struct
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260907105453.1940646-1-devverma@amd.com>
 <20260907105453.1940646-3-devverma@amd.com>
 <aql2nUwXYLOXrLM6@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <aql2nUwXYLOXrLM6@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::15) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: 559ad408-6d69-450c-c493-08df149c0328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	eWy1zHRd7yhu3Ag0C1qwxFUThmjI59cmWdq0NuhbKKkC6Ltn590OZXUQlHlfdhjpuQtL6esKNikTr9wujQq5EkY8SIjfbs/eF6ewb+vo5gmzCMiqgcIOUeL427dcZZV2x1eg+QC/0M57kMsyXOxFlx7hJ0weCZ1y+x0nxuH//MHpRK6hytn9DOSvGazllt1jiXkP/d0Z1Sb3bsqov4O7PqemKyhS5g8GPRDvvbP6g+lo6Sfs44C5h/xWTdlocbDfrqUFskNGizdKdSBtZkoi9+OLwrgfB57f+otzJFgvKR3MGf1BtpHy54lYjfgzuJpgdZhJS5H+bSEiSzW9KVNrilJ/92TICF0tc0Xek9kUOxAYL72y//t3o4oDBFbBS6/cfOG8nK5qPip+kR3z0/lEwiYVkDvtSR3I7Ayl0ip/XjavCuCtvv0BIx7PXOn+9Te4BE/5tM9E6h9MswHco69K0xfJVjMbycL6xO8R6rxBfxQjhb64DAFMrgaF1Bf6qboboTneOOBksPIr3XhM4fy79jCsmBSuWCsZWun8oXaSMWMyJUTOJxjY0kWEAo9FkEpGKEeyNEhlm7v0N+W/HNoNYI+djFxsXmjotjcmviTlbblmwSK1ykSGkxDGDphJIB4/TG9CWFkeTDIQGYSOt0aRXW8r+Cthn857DuvAjua/fM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnprUEZnWERrYVJpZ0pMc2RiT2J3YlNnUDN4STJtaGo0VndzUWpFTXRad3Rt?=
 =?utf-8?B?V1kvcVFWcWVSZGNpbE9JeGEzWklaNDRtNjdyOU5CWDNsYWpPNGE3dVhSUlpN?=
 =?utf-8?B?NXk4TVIyaEcrT0NhdnIzend6RmhnSWo4YlMrL0FEUVh2NW1yUnVsYWhFaExW?=
 =?utf-8?B?VHI5THZ1WUk1UmFuZUlYZ3c4dVhZV1dFZHNPcC9pNUdCd2RMczR3VU5sTUFZ?=
 =?utf-8?B?Zmd3Y0h5Qk1RYnNiNGRPekJvN25NbFlFSnQzSVh4bWFvRGJoRXN1cVNMazMw?=
 =?utf-8?B?eW1POEZicDB3QURsMDViTlF4ZllaamwwMGRheUFRSlpIT2V1R2w3SmNzejVO?=
 =?utf-8?B?MHFLTWt6QityU2NiY1Z4U1E2QWVpRXRCWC8zeFMxeVpYYmVSU2dEbXpTbGFi?=
 =?utf-8?B?Z05LbGdYZEs5ZVhxUUVOaU8xeitHM2FzRERoQWZ5Z0JMbERtOXl2UzNIQ2xt?=
 =?utf-8?B?TTZ3eVFkajBoek5CbnhYSHNrNjRaanhPdXFHZG5RVW9vZm5kWThlbTNhMHBN?=
 =?utf-8?B?Nm4wTkdCamJrRnVuV2JzMmVNdTM0ZHBIcmpMaEZKN1U1OERhdVNzV1BGSVBD?=
 =?utf-8?B?QWhYVG96WGlEMVlxYkZleUg4ZWhLOUtScTVKb0dWWGRFTTFZNHl3emE2UEtl?=
 =?utf-8?B?eUhCcE5xRERGbVN6QmJ3MXJ2eGp6cGEwSEZ5b2QvTW9iOXFPOG9OOExqOHhp?=
 =?utf-8?B?MG9nTXNKc3ZrWkN5OFBtbjFKREV4eXB6aTZSdmVOUEhKQ3NRMmlNU01IZjc0?=
 =?utf-8?B?ejRZZ2hPamNqdCt2d1ZGRGdrK3Z4WldDMzR6VmNoM293Vk5UK1FxQnVwK1JZ?=
 =?utf-8?B?SHlFQldMYTB0YnR2Q2tRRUZyR0U0Sjk4UUUzUDNTT2t6U0hSWVhacjBCWWVN?=
 =?utf-8?B?SGhmYXB6ZHFSM2JrT2FaSXMxRnJwUVB5VDlJOWdKWWFhcEF6YmErWDdZTjNM?=
 =?utf-8?B?TVZrNG1PdFkzdVJTQWdsWnFQREN2STNqYm5WVis3T2pEcDY4WDFHbFhaYUdu?=
 =?utf-8?B?dkR1RG8yUVBHaFBBeXR0TG5vdDMyb0RCZG1BaW5KZ0FuWG14c0RDdnprVEpn?=
 =?utf-8?B?aFpnZWF5NTUwVkErRFdadWRHV2RWZElDUHV2YTZkdjFialdCOXgwNmJhcnFi?=
 =?utf-8?B?VzJPR2kvN0puZHA3dnBHS2FaZkhObFJCeVNRTVpCbVh4YXVsSG1ORExwdlRH?=
 =?utf-8?B?VS84SjU4dmtETVp6Mm5TUkcyRlNHVm9GS0RjekphbG5rWHlPMFAvUUgwQnZI?=
 =?utf-8?B?L2kzMElZRVVqSkh0cWF0WjYybHBSR2FicXY4ZDdVQ2RpdWxhQWwraTc2M0Zm?=
 =?utf-8?B?cEN3UFhkdzZ6ejlqS0VHNXFVQjk1NlJiY1BIRTYxSEFWZGkvSDl5dXBsWksw?=
 =?utf-8?B?dEZFZThCdUNzeUs1dXBmT29IQml0RHNFMk5LZE8vd3Zud3djcGRoV0VsSlQw?=
 =?utf-8?B?L0phYkgyeG9NaUx4aGhLQlROMXNWS0tjWC9qYnp2UEdUTEpaRFh1dW9YelNh?=
 =?utf-8?B?cjlvako0ZlZaN3JhSXJVc0FDZmhOWUcrWHJ2cFRjMHJoU2xycGo0UDVQOHdy?=
 =?utf-8?B?ZDlqS3BCdjM0Vkl6dWJXaHk5c3FmQXdJSzFqbjA3a3MxcDlTUVdCbERpTUpW?=
 =?utf-8?B?TUFyVml2dGI0NjNGbGV0c0pwVXdXNnVSRVNjd0F5Y2FsUG1NYkZIYWFPemdU?=
 =?utf-8?B?dmZoSkRmZ0ZXaC9wTzdKQ1I2UlExV0ZQN0sxWWoyK1l2OFpWeWhzVGpoTDFk?=
 =?utf-8?B?R0o3K2Y0RnIyM0ZCY1ZzamJwL3BXazh5SlE2bWlGQitrcHI0R1V5eXQwWHRZ?=
 =?utf-8?B?SExxOVRFNlczNHYxbjNpeEU1Wi9LY29JUzI5dSs0SE02T3JhTkJMUjBsN0c1?=
 =?utf-8?B?clJ0dG5LcGIzUWNUdnVqcVBaVEordjlCZTdnWjZFcGdqZDJzSFg5TnhCbWUy?=
 =?utf-8?B?VmRDaVJycTdhTS81QXBDL3dxb1VvK085NHBtNklYQnF3b05xSDJCT2FCck1Z?=
 =?utf-8?B?L2dRQlJkZXo4ajNUS0xPRXplbTd5OEM3VzZKMVl3NzNoOUVBUnpuNXdnRUxX?=
 =?utf-8?B?MVpYQ2psejFVNWg3Y3N6MkViSloyM0NkN2taMWYzVXZkNng2QWRtclRuRWJw?=
 =?utf-8?B?bUdBaVZyUFFIRWxtbGIrMktnK3BXaFJRN3lMMHlkZVhQV003dFpKNDU2NUdE?=
 =?utf-8?B?RjVzUzlJVWdWOUFYc3hMTVA5U2RPaFFRRTdQQ3dvaFZnSVdBenZjM2NPenBu?=
 =?utf-8?B?L2FjQkZGU29BUVYwaXE2VDMyNkpNOEZZc05TN2ZIMTZTZlBjbm80YmtEMHNh?=
 =?utf-8?B?ekp6LzNabjJrT2xjVWJiR3pqSkx3TXN1S0RlUDNUS0ZLbXU0MlF3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559ad408-6d69-450c-c493-08df149c0328
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:01.1353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l52YKtuKc2oGIMAgtXsjdHF0kkLBK0VVBXyTDEwZIkhXFnAUdL5sHMGXedX6Q6KxTpCeEcnYWf2Qpw3yEaxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569

On 15-Sep-26 22:17, Frank Li wrote:
> On Mon, Sep 07, 2026 at 04:24:53PM +0530, Devendra K Verma wrote:
>> For 'xilinx_cpm6_dma_data' struct which is CPM6 IP, the comment
>> under this struct has typo and mentiones 'MDB' registers when
>> it shall be 'CPM6' regisers.
>>
>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>> ---
> 
> dmaengine: dw-edma: correct IP name in xilinx_cpm6_dma_data comment
> 
> Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to fix
> the IP name typo.
> 

Thank you for the suggestion. Please check the v2 of the same patch
series.

-Devendra

> Frank
> 
>>   drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index 006dea7d6322..762a693ab55b 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -146,7 +146,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>   };
>>
>>   static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>> -	/* MDB registers location */
>> +	/* CPM6 registers location */
>>   	.rg.bar				= BAR_0,
>>   	.rg.off				= SZ_4K,	/*  4 Kbytes */
>>   	.rg.sz				= SZ_8K,	/*  8 Kbytes */
>> --
>> 2.43.0
>>

