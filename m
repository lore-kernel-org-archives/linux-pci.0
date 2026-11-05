Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793849540;
	b=A6h20PukI4lMGr6UvKUaM9u4vMf7f4iBop+aAkzalAptkkezUgCp0HgTIRJVgCFUL6h2
	 LqaRpZEE/kxPSuCy4FUH5hlzbGKS3tgXdVlCW6pFhvnFsJUSYdBv8xRpGYSO+7IlQMJDW
	 YVYZBs9lODZCc6QYKXBhoRZCzc02CyF1tG2YlzFn5Ho1pnUtBnW3TAZ7CSFZDptooiQUz
	 wQ6siplnn0CYsRu37P95qmdyATLGtyUww5g3QTJtsjvgtHMWqQvZ1ANBgbGwsY+f+4yyG
	 2i4FoF6rMB/TyjAiZ1Vobqy+S7Lv9xCddY2ySaxdi/OIsEFeJpZ1Xg8t8l2+z41x3FQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849540;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7MYestwEH6gs4526EB4JudsUxk0g4agf5zvx66ESjY4=;
	b=ZvQ7rPOHadq+PYD9VL99Qtbk//xZmMAOYG2G845uILswivtW4n8vv4GPILrKmYROPfNj
	 tKd/GTd/io0sa75sGKuPOH+/daOTjjiRiMvjXYkMKrlcwFuCMSQoUX+s2Lwtfhs6ttbDp
	 4gcRbS0RRPF+t+/pObWB0R68fNwlMaaQMTPW3VY3EGX/ORdDCt/8grna8CTk1pVTWm4aw
	 x6t7jqJ+sFV/OpPlgUGZcURrZyD1xl9ONpOFf3hz3pkB4shsU/sHu7JHZRKikwjWDQ+lj
	 ko8hcsw8GyB69cMLSNP0/IOWiNkVWZxnrj6YFydByxAL1MmBG1gO5tjcTnlSipfJgFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MT68VWS+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.43
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED9606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 03:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAED9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MT68VWS+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3qFiB/vxlt46D2MQKWzB2tp5EOQCiLF9gsR1mzwh7iDoQqymNIHAvEIDymPlSYA/E2ocnXHhDoUzIgkB7FFMGwefLgPYN7ALGl/E+GKT6OKQMkkRD/omshJ6NGz0c72SNNipmsztgzesAXBnq93lcda8XqjB+JfGPFDOP8VJoVEmQcn//4R9GNo1rvII9SSaAMSs/gW3NLeaxHQaJ3xyYwMUtArEeDj/KYHt4QNo5SK6F1CSr/8njclZNkwUixOz5duMNCT4tdCHeyKwt+MqYCy4rEqSp6BpAYKGp0EZK2sHieIJIgJ+9Fe6V2c0SMusJYYFeLBiTsexPfl1TlWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MYestwEH6gs4526EB4JudsUxk0g4agf5zvx66ESjY4=;
 b=QuD+7EnqXketY8VJB2wVLUzp6iljiP9nSAi2oR3mIL+SoAG7VtO+8mGCEKYMpr0521vXOBzuYlSej3SH1FCziUlaIAS44kovG6Jx1PzgiQHGwEjs2W6qRCGPdLms+Eaq+O4HEPaFAifH3Me70i66ZSuWagOgPZ3nsdtigxzsAWIdJbk2et0n+pe6xViwrKUV+2hz4hZe8Hx5OsdczNZYPRvmXEqKGO856PMr+s6MA8BrkMFYc4u02K6j0CPII8XnZhsCloOrUF4FZaXRpAfaarwpwd5sZLyHQtbktJikv04SmRAa/hQvE5eKUzIz59xJuhvZYi6zpIWkujFIjUS1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MYestwEH6gs4526EB4JudsUxk0g4agf5zvx66ESjY4=;
 b=MT68VWS+P4Pv4uJsTqEB8AnEv53MqincCZh4hrUx3YfUuwIgfwduLO+HNxDRLO/SV0HwP3PMZF4xYZt2Tu3xOTiXpjWZyBJGyeh66En7hLW1KXY35n9mZdA3XMrYEQFAAnwiSMDJC7gnlIxdURnw8oer1bey2K7Y/N6MvXXIYYQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CH3PR12MB647349.namprd12.prod.outlook.com (2603:10b6:610:365::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:32:17 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 03:32:17 +0000
Message-ID: <c03d9f24-789a-4f19-b3a1-b189df7b2d2b@amd.com>
Date: Thu, 5 Nov 2026 09:02:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Force identity mode for selected GPUs only
To: Arthur Marsh <arthur.marsh@internode.on.net>
Cc: alexander.deucher@amd.com, bhelgaas@google.com, felix.kuehling@amd.com,
 iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org,
 linux-pci@vger.kernel.org, mario.limonciello@amd.com, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, will@kernel.org
References: <20260824085821.5422-1-vasant.hegde@amd.com>
 <20261105024454.654-1-user@am64>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261105024454.654-1-user@am64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0265.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::10) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CH3PR12MB647349:EE_
X-MS-Office365-Filtering-Correlation-Id: 6560b525-1080-421c-2837-08df3aed63d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003|261026140227099003|261028144727099003|261022105027099003|261009223027099003|261009221227099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	Y372mMRWXCmfPT0uL3EXffo/Y70o76VyRFk9sNx8XMokWlZDz0fTwEN6QTtdvUI000c1w/8sHySNHgSTOIjvfHnh2OkLGiUDVf68wskq6UiyxtJEFv7OeWLHlrbUyfdg8doewEhCu0pZWrNC2rxW6+0/poWfAg4FX58yaZ4603nBpXM/qj1EGbrT0WkC6CGSu4XREAYy8owLuZIcdIp7XaUJwqhqWw3/OV0nzjKN8osAKvvnJRQlZ+KMbDEp0zRT2FL53+5ND/nmkrorptX9zq2+slAOmaIUsdbwYghxlFOxoDC2+29onYui7lEwS5g0v61d910zINPFIRFToB63eAgyfmNzHhWKcRGvvMbUJGkgwjEiM5UTUPjWcGcPaIAaxFgXlwVIvKPn7CvIHuCx4Cu4IFVVGD+zsMXOEJk05c3Sxgu/cpUi7YayKjHFttYygpEZ0C12Ggk5KTvSrXUR3aOSDdfy0f9QoLbZuZTsgiw/JmW8y96J0ppC87ArhL5RVG2zXQXoI7YNhSIHlUXTLJMUNg4Vt4Ku/Zw5h1gktE9KxMJ9skf/QaDyuh0nbWlaz0a+RBtMuIs4jqBBx5y0vco9AxXiVvUiZQMFjXvl13dHYheUj6JkiRzJYNxlYlG8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(261009223027099003)(261009221227099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3hUS0Q0UzNkWHR5V0wzZEgzZ05IeDhrWkpkajJCV1kyUDVQdUV6ZTdCcVdN?=
 =?utf-8?B?SktSV1M5Q2tzb0RwNzU4Nm1zU0xJeTc3NXhMUCt5ZmVmYU5JeVdlWGRSSENV?=
 =?utf-8?B?VlVFdTFoaGwycmRGSUVZcy9COVc2c3BFQ0NUeXBZWjVxL3FJcEdnOGpyKzV2?=
 =?utf-8?B?dmljSElxTmpLemNuR3l4R0FRcDFibzVSUGpVbHJIS0dOVmw4c3N1MUVQdHFh?=
 =?utf-8?B?WlhqYmpjT1hPdlBHM3RSTlQ3aXJtdExQcGVnejRIVGdkMmxLQWRTQzAxanhu?=
 =?utf-8?B?cGlidlFRRTdmZXpNeVRDb0sreUZoa3dkNHF0YWVEZmpZTk0vTnhYckQ1NjNZ?=
 =?utf-8?B?T00xUzlPME43b05JTm96RHZMbWhObnY4YU1BdFlQYzFqMXBhMXk0a3JqL0RS?=
 =?utf-8?B?b3pEOHArcmxudU9HWUJRRmRrNDR0dWIrZGVlZTZqemVYRlA5SjZIMzBMSklQ?=
 =?utf-8?B?azBMZkExdmFiZVM5K213TmFsd0RQS2E0Mkc1OEliR2ppRlBleHIyU1MyWnZT?=
 =?utf-8?B?djViOUc1VjB4Qjd5UDZLL0ZOME02VVR1V1lFQ0p6clYyUFhKV25TTEZCTURU?=
 =?utf-8?B?VVFEV2VaQ1E5TGZpeEV4YVBiTVZqcHROTVpiRzdnbzFuSjd3am1yL0V4M2U4?=
 =?utf-8?B?QVRVRVZ6QUNjNE1sa2hTRzhkMXR6UzFVazlSNlRTZVVxUmRCSUFVcVptNHQz?=
 =?utf-8?B?ejAvSXlSdUNpbndSaEU3Y09abWowcTFnWTVLYy9SMGg2NWYrSUdPTDNuTmtL?=
 =?utf-8?B?eUhFU1pwSVRPcFcwbVUxeUJMejJRdTlTMHM3MGtRVG44THZNYWNxL2xlWWJB?=
 =?utf-8?B?eFhUdU9yTmltak1SOTl2MlNZemErNHhpT1drdUpPWFhZdnVmSDlicEFaTy85?=
 =?utf-8?B?cHY5Vm9KZGhPZjNDSERLWjZ0KzBiVXhHYWxVVjdIQ1pqa1JxKzRDNFBESVUy?=
 =?utf-8?B?enRob1Z4Z1NCNHJhNUdZWndVMzZlN3ZyWFREdllRa3VQZUQ0Y09oZ3NiWU01?=
 =?utf-8?B?L3U5SC9oSFVhaGtNci85YisxdmZaYUVyRDRsR0Q2VkhSUFdIRkRualFIbmxl?=
 =?utf-8?B?ZXk5YkxKYkpIUTlsL0Roc3BlcmhaNVhuN2EwVk1YaTZqTUpJVFVyVnhnNmIy?=
 =?utf-8?B?elRHS0FYaEFiNHhKMVEyeG1MeWJQc2h4SkRhTCt1SVNIZkt0WTZqaGtyN1VZ?=
 =?utf-8?B?eGRhWms5QXJSLzZYcjB3Qlh2czRTZS9KeEZKa240WFZtWUNod2M3b3dVTlI2?=
 =?utf-8?B?MVA3MHBucENya2VHd3RGQnRtME5yb21ybjNqOFF1UmFpL2ljamtGcmFBdEVR?=
 =?utf-8?B?eWhHVnJ6MkdnSldtckUwcU56NHRPdElzbGl3NGtYSzd4cUlTeVEySmhla0pj?=
 =?utf-8?B?NmdUNmhQUHhwckd2QTIvSXBpVHczVzRjSytDOEFnUnRqVHdPWCtZMi8rZWg2?=
 =?utf-8?B?SzFaUHRCMkdjRlNTZStpVVZSM3B0aEFHVW9KYXJKSm0yRnlCWXdqdFNvMDFD?=
 =?utf-8?B?STFad0lta0dGbzRqRU1EeWpCM0haZ0hpd2l3MmN5Rklrb1J3VHpwdXh0VmlO?=
 =?utf-8?B?SkhHQmR2bnVyd3dGRHhPVUVxamVITHh0aUdtQUVIblMxRDBydDlEODFCZEJs?=
 =?utf-8?B?emJxQmNFTXkyVkhxR1dqQ2FkT2xrSDlaSS9KOVVQTzI3M1l4UTFQc2tpRHZ1?=
 =?utf-8?B?ZzVBOWljeTVsc0V1aDVDWFUyTU1TY2kwS0U0d0JUTWpHa0pzckhuZCt5V080?=
 =?utf-8?B?Rml4ZVVJNGcwVlhQYXhzdjNhK2U4TEREYmRMKzJ4cXMvSWdacG9pVWs0bkxF?=
 =?utf-8?B?WWNwbEJxZTJQZkRGSVNQT25GSnVhZ0NQb2swYzZSNDdTVGlCd0ZodG5NbUhx?=
 =?utf-8?B?eXVnc0VsT0l5dzBBdjRuSHdodnZUOXdYK2tYSko1MWVHSFluTlc5Sy9jNzBE?=
 =?utf-8?B?K1FpTC9jV3RwMWhHTGpFU2Q1d3R0SzVEZVBQU0tvZzYrTkE0aENxTlBzaXVN?=
 =?utf-8?B?Q3RGeVVPNjdSbjhDK3p2YjQxZzNzSldVYmpsRFRydmhMYnNnaTI1Qm9DWk01?=
 =?utf-8?B?a0RQSjEvTkYvN3NNUDlBNGQxTHM2ZmJ2QStwOFpjV0F2UDF3S0ZDUXMvUWtW?=
 =?utf-8?B?dk5yQjdJdFhtTHROZStrdElkaHB2dDVMZkdUTmhDS2Z2Q0dTY2xRNGQ5bE9m?=
 =?utf-8?B?QlExa1VVbEtQd3VkcmxLbWE0VG5LK3JDZUM0djBmeFdqa3hOam43SkNvSHZE?=
 =?utf-8?B?SDhoQ3B3b2llTFNqZ00xK2cxdTA2a01zSWU5dTBrRXpZcTlISjMwYlA5dVg5?=
 =?utf-8?Q?POFNF9s1UCngiMZrvW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6560b525-1080-421c-2837-08df3aed63d9
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:32:17.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLiV4lHQZ+GAny4phyODgTE4rgbZ9vLfvja1N5knsf/DVc57mEFLG5fgn8kRm1nyoOaWh10NAMy3VIyPWArqxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB647349

Arthur,



On 11/5/2026 8:14 AM, Arthur Marsh wrote:
> On a system using an APU (no discrete graphics card):
> 
> model name      : AMD A10-6800K APU with Radeon(tm) HD Graphics
> stepping        : 1
> microcode       : 0x6001119
> 
> I was getting the following, git-bisected back to:

Yeah. Unfortunately this patch introduced a regression. Can you please try below
patch?

https://lore.kernel.org/linux-iommu/20261103151607.435642-1-jean-christophe@guillain.net/

-Vasant

