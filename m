Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190F4A9D4D;
	Thu, 17 Sep 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636208; cv=fail; b=Y/i1IEBz8vrqRABo1fODY4p9vUVycetdDkZOvAP16/xTFF5DFTbsf6Ts3sV8B/AB9l0ZhMLge1+6uv0MCOojQ2Pe1LetUBZOe1V86QcRBUujI4Gv1sEgq5YMQg6DY5Zhtia+cy3gDwJOIZGKmyCuLYDcpZ5OVWdtphkWr8Pl4Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636208; c=relaxed/simple;
	bh=nhcmB7DB1feJ62UtK0934kG+NUZN0ozWOsNJEh8o/FA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gr1UPMXi5dcLIrn3oYKPd/pFkBD52zCBZ25cp+qRMnBXpZYnmsfvNgsoZCUpQLk6hlrBQ5kARavdCfRBi5px0OWntLp9M+hUd+aHaJJgPXzdWUQdvFL7q8ERvioWP7atJZBSsbe2hSqy7eDPATCdjUuGeU2LvS40RPWi4y3zbes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qd01UYKB; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qd01UYKB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qT/YY2pVx4sxKBUEbRzpL2II5to3jdXgCZgFvO5LML+2sETEvRMgb+PELewUTfJXKyPoAnpr3EI/VZjyYgCTCVMmKbO+aqMF8A1amsJpMJOPkpczjndtISgYdbK13+htviE1yze5VswAO6Zftb/Uf8zNhjorM8MEvG99CQMfWhOPklP6WAwGfw55fG2Sj0qmfLRx6cGUTlPdF7snz1McuE2EmGRXtdv31+dVCptQi7r5p7s0oytjXRMmdI3HpxmbZ+AnqPRvLYerClItmMMWNEI3VlyopgUYpzLsoKD56G93gJzDBBtoDZjRDmgJfu78pjgxmDeMcjbZ9lAt2TNGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PtSng4w2uuAzdj+m3UuU6WwXI4nXuKeovoRSIxXMWs=;
 b=D+UhVgx2Hoom1oef1YbtUbHP1GvH1nw+3sOKzOQh0GU8nqG+Bd/me66Hi1K2ytI/Q95EA8zruhtecRcTmcQHPw4diPGCHUqT1fhYBMsM5J3a469dvMZkS/0DBlDUaOcdtZ7rpuBkEoC1acBFL/jnEQQv0VdX8XecNFTRH1T7PKYoEw3uEt9RVruAS5Os3BPzINd/iDKij60UnhZp0bogwTP4LefzPNzimGwXC7z5ze3cT3hxd0A9eNTVpNWRODxcZr0DFDfv7AwNTLS+Whn6W5FuorVATaphxFDLShz451lUjSWrRG0j6yrAaZeqWsZxW+gboSk8S3itInNSTf0kqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PtSng4w2uuAzdj+m3UuU6WwXI4nXuKeovoRSIxXMWs=;
 b=Qd01UYKB5ZB0kTBNY6c0qwtlh7M6wLRAHN3iD1ZVi1snxsxhv2Mo4O257HwHTE1Y1aydp2/bpA0ddd45oYlDny8oAKV9mwImKMJW7HPgPebHGOUD1rSTHgbT7D3LuyNEG39emgxPBBm5ZbgYPItCrX8CVn+o+b8Bcnc/z6/FKqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 09:09:57 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 09:09:56 +0000
Message-ID: <9e699d88-9cb2-4e5a-9e77-d20e4d62630c@amd.com>
Date: Thu, 17 Sep 2026 14:39:50 +0530
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
X-ClientProxiedBy: PNYPR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::12) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: db205023-7b9e-42fb-d267-08df149b7165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Iv9MbcoD/goh5I/Jjp39wUhlw8oiofnDiLFV8+MxaZ0XirXnHIeasGVxsRgQogV1a2nOG9B79AnvPhZiS9oxqVzI83m31gkClTx2uhdaf0fFcmKejXjHcPYH9M4m28uycFkeip+JQnRF3I8NrwwynfiiX8d3TYpuYiAv2yb4HKoOLFCb+cDPr5xxLHEqF3rRYXaeivVfqsB7EPKsemSKVl1fIavRHIb5UKVyGTOqriWz7pStrb7WARkuB+ZRsXlxHFBzO5GaXLuAeqRSavTvUyrvntS/cQJLrsM3DY2kc48Cl3pt3y9z3lVfDmJQ5GQbdh6e7WJDmueoVNhqjJcNfG3qJUWq0YPheZ/oO9WF/kqeXE1PiaIQ8CcfvO9Q2WQejaCIj1RcuoJMW6whWJdL1oTY3pAYBAwhYnwra6MW28fy46bn2rGWtQVrz0MzNCobeZo+WnG5188QZOwZvK/qnqQGheZGFuuHCFk50QwBnV4VxlveHyz8Nc4QkitrBcM1SoDQ2H2pTrsImcEfHVQ5AUm3GALO4hy0WCSpvqtPkM+JZx/WUqh/gjkLeHlLEsCmjUfeKFCX9+4CwSCiV7Ivigvzwbvn/e09hpPdPZ3sPU4mxHUvDLvNqW/E/P10laL+envjLc1YGjmxLjelt7ZwHveQ4/ANt6E/Gii0Hv5bGY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0lKOHh3REl4SXQrVS9YdXhEcXI4RzU2Q3NxeTJPME5QMXhTeEN5dUZWb2M4?=
 =?utf-8?B?ZFRKeDBGOUtuSm8zNzJuaXM5Wml6RzFQd3A2U2djZkRZa1R0V21IOGJqNW9m?=
 =?utf-8?B?dE1YVno2aDlzdDRWeXZEQjI3b1RvRjVyME9pQlM2QjgvaXNMYWtWRERqWlNP?=
 =?utf-8?B?QTJ3Q2ZvaVc2clVnZHNFak1GcHM3T3JORWtlUWxocjFhRDZwT2x5ZGZyMHpj?=
 =?utf-8?B?d2ZId00rQnNDck5xNWxrbjhNbHFtbjVodmNnNm9XL0prS1czeHc3ZzZQRjV6?=
 =?utf-8?B?K29YazN0R2pibFE1bXVrRFN6K1JZV1JkU1UvUjBaeVMrNnpKWnVnK0lpSU0x?=
 =?utf-8?B?aGFLOGU4OGFhbUkrN1RGeXE2UWhNK2tEQWgwMWxFa1AwY0w3RjJZMG1Ld2dy?=
 =?utf-8?B?cnFrUUt0eFpLM3JVM1ZKajFIRkRuaDdxUVhWN2pwUkJDNmExZ1lFM0drVXhQ?=
 =?utf-8?B?RWEyblY2aElNbk9JM3dYNEN4UWJVSlN1VjI2cUR3d09UYTB2Z2ZVYW84d3dB?=
 =?utf-8?B?T29MVDhDd1NhMlhVRi9zRmloYk5NWFdOaXZNK2o1UTlNVjk2SHZzczB2b1Vu?=
 =?utf-8?B?L3B3OWVMTHVmN1o3aVN1NG9FL2VZcll4ZmRMajJ0VnVOejRsQXE3OFg2cFdh?=
 =?utf-8?B?YzZGMDEwQWovaUFtQUNFeUJEWWxBMkFKMXBseWJSZitDWnRTNHZMSi9SdWdG?=
 =?utf-8?B?QU4yOFpyQk5ublViM2Fza0VtbHNRNERYcGFvUTUvMTFxRDUxdlp0TlVqNFAy?=
 =?utf-8?B?M054a3ZJWFFXdENKaFhhMXpZUjVrU1prcll2Y0U4dGpieDFPUzFSclVrbnQ3?=
 =?utf-8?B?a0w2aTFVQTgvWlc0aWh4R1Rhb0thWVNaRXF2WEtUT3Fldy8yMHVOcUVUMmgx?=
 =?utf-8?B?TjQwdTNxVUxqbWdWTlBBc2R5Uzk4d25kK0ttU3FFd2JmY2tidVdIWnZxVHh2?=
 =?utf-8?B?ZHNqMWtNc0hyRGNDeVhpeTJOdHROMGduKzlIRnpHRzRmb0w1c09zdy9xcTM5?=
 =?utf-8?B?N3NlVjMwZWkzcmFMZjh4ekhHQTY0cVhFbW5lY0htSHpiNm5IVFBPMHQ2NVVR?=
 =?utf-8?B?U3VpMEx4cDdLUkJ5a2lKOTY2MjFhcUNibUhWUDR3eUlVVC9VVk9scWVYUURm?=
 =?utf-8?B?WXd4MDdVUklyL0hJQmxhNmlPNW43bHJPSC8xU2ZROEl3ZU91UEpxS1VPNUM2?=
 =?utf-8?B?elV3VXlyZ3FUWTllbDZjZFNwTmpsTUt5M2FwcjJ3bFpaQ0lqRHV2N0RsYWRS?=
 =?utf-8?B?UVl5VXNyQ2V4S29RWHhnNTFHRG1xdDZKaGNnN0VFUzJ4ZkdjUzdRSHoza2p4?=
 =?utf-8?B?alRGeUlsNDVzWDB6ZGcrMm9NenY1QW95R0ptWnlUbnRydlJZdDBiVWxVUG1V?=
 =?utf-8?B?Wk0yaTNxSDRTajRwSXNOVkkwY3FvTThWell3dUMrYW1mNVE4OG41V3MrOFA4?=
 =?utf-8?B?R0JTQVBMTnpjSGNhQlFXZGtlcktLWkZ0V05TVHorejFHVWxKZUs2cEhCbEZu?=
 =?utf-8?B?NDQwaExDRFQwNjl6a2IwQUhRcG1tYXdQNEtpV1N6QWF2b1pHN2hJMFNjbkxn?=
 =?utf-8?B?Rk1vUEpkT3VHTTFudGszUXB3d09UYnpGWkd5bCtGMVJIcmRqbTNNcHRqVFph?=
 =?utf-8?B?UGRDNTk4VS9oSUZKQWY5OHYxRmJHSHdyQWhkRENyRGZzSElwN0RYZ3pFa1du?=
 =?utf-8?B?bkRleExEdGdOSjUxNlVTZjZqc3JWeWw1a3dndnhQLzE3SUp4cjlGSU05elpJ?=
 =?utf-8?B?MlREbk1rc0p5ckpSNFlBZmZjN3E2NDAwaUNxMG9qYU5Ra2FXY0ZxaGlFSkRD?=
 =?utf-8?B?V3RSbTE0ZlVVc2I5cEt2SURFQ2RxSXY2MkI5aGhhOXhDSk9VS0taTmdtRTEw?=
 =?utf-8?B?MW5DNWhoY3ByRi9ObDdMQUhHNjZ4UVVBWWpncnhDMkRrNDlGQ3ZndGVUdWdJ?=
 =?utf-8?B?OU5XaU9rdFRDZEl5WGRPMW4vVjE4dmFyRVMwYUw1SWNjbVZIT0ViaXNwRGZS?=
 =?utf-8?B?bC8rRDNNQysrLzNDaEoxd0tVaVhjWWRzS1h5S3FSa1Jtdk8wSTFuM3RvVkhq?=
 =?utf-8?B?ejd3TkJ5UUFlN2x4TmREYUgwQXhJNTQ1Tjd2a2lScmU2U0NJckJub3pad1Jy?=
 =?utf-8?B?QVY5cVlaYzBILzVHSGdvaWJaaC9DclRidUlaeUhwVXBiRnNzd1RxaWt0U3dw?=
 =?utf-8?B?M2cyMGM5bENDQlZ5OEVKdGtRcy9veENxY1NseVU5ZXkwR2ZzRkNUTGRsNytR?=
 =?utf-8?B?aThkNENhU2Z6VTBLZm1COTlDQWdyNUtZSlI4cVRhK1prQVhyVy9xODlkazVj?=
 =?utf-8?B?d1RqVmtPS1laZERzVnNiZHhpVkt1b0FoOW02NGw4T0sxTE9XT3ZrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db205023-7b9e-42fb-d267-08df149b7165
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:09:56.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9P2zGgPNd7DxFNGGTD05dV9Z+Q+cfmdduTG/5dvNdUctn/sLbPIX5ZbV/8n+Mzy4cQQECI0kQz+1/+/foV7fyQ==
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

Thanks Frank for the suggestion!
Please check the v2 of the same series with updated titles.

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

