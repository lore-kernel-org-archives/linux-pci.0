Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794956426;
	b=VTqwS7M2TMATz/e02QuAfy6rks4jtwrM5Aa9nTapD/K5i4NTvCj+iqmYgMPjUfh7Q8Oh
	 4uFan3/Dc5JcNgCJloukYMErHyXXsEQTGBQBIFZ6Dar3ejSGmgRM5Vc8d+y3ffgaDanok
	 hj8Rk/oTiPSUZRX7IFySiqUXh0ghPPaMAxiiSnu6yfQwZrBfSHjE0ldaWpwu1aujvbg4w
	 kgDr30aSC1ajWpGhRuyw6Vie/aLLgUsaYGTYE1GrE6wtMGicV6ECFH4tgidq/nBv40daJ
	 5itKF20RvcR39oUF7l3s48Lim9kUu7WdCJMxt+P0THfxXiuoA/+YGtHEmviB/tr1Leg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956426;
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
	bh=yR+0jW95Z0CWoC3ggQ1II8lfkYqcV8Kwm0XIFAvC0V4=;
	b=p5uLcqsKF9Nj0lVGgyTchEpRg7TczLdmrKmz99FcbnBo9954sUBE4bChXN5hAAfkmWVW
	 SzO3+Z3qKUhov4oBtgVL3D7U0NWmsL5CtbWRa92aQde0VtrxXLvr6itWciQx2FIjcXYKD
	 YI+ur1eZWd8w3bU7Mtsp4OCYZWso1cqfdEPTmL7DQWYXgXuwaTE76Op7raeoBWjqwYnG5
	 9mxgH4iMy1SMn7jehY07jZHgnWflCsMmXOuc02VTlSkNRIo+1K74vZQwsPRTOhJlOWtLt
	 gG462dP39QbTq7fd+DRm/eYaZvwwpbDsIHIKcHSfyIO2oifpbE1RxzxYIUyEQr8frfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F+pO8dW9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.18
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBD606A31C;
	Tue, 17 Nov 2026 23:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00DBD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F+pO8dW9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5SfKHM59JHgj1YKGGaauZ1RBwg8rBL0sP8qcSKzXrXyHgNGzJQ0EnX20QKzVxMn+m1wTh7R/c1Mgv0ydgd/01s1055A0HvEMxxDg2eT+iLjc++9DPbRnFlPCjvKs3wcDZM/ACtK/LjgJ24Ab4HJVu5Iark/TfFle292WzMOEcQPyYr7anGe3Rb2MrcLenF44plP/Rzc/g7jTMjH7KhDAQkJIMLLihLWzoPjf5SDJqhl1Kk2E9LO5A9xmsouF8/Qj9OYupQ0s11WonmBRNu2SFjEePYIDno+U4n6FroEFw7P9JNDD5DYKhNxr66OTLoI/lpGUmc3cPAteP7UU+K3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR+0jW95Z0CWoC3ggQ1II8lfkYqcV8Kwm0XIFAvC0V4=;
 b=qY0Jngumic30t/lVxZi/gP+lma4hG7ZhypAU+jSVYiL3KAmuz6p4u/7wIOXdrou5IDV1B7/J8Np+bPE6Aobrf79VRaRfYuOK+DM4Ey+/AiLgrxrDuUTOJkr5cdIrWuPB8eZN8n09a7zaJxHxWsFGPMdMM1n4wrdqPv69sOif34YacbjYoZA09a1BMtegd03zdHlp/tLaCqfKvOjP7s+Sic4960XV8b8kMXu3sbqM06QSkPZD7wJe/bhnEOcRsViDPtWHhnJLtMgPdPZK9oL5ZRlpB9afbCIzIQf4xNkOa3835etmfkIR5rJ9MxsuHc1bRpmceOEvxewUVPAsPEfYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR+0jW95Z0CWoC3ggQ1II8lfkYqcV8Kwm0XIFAvC0V4=;
 b=F+pO8dW9AKXa9GSmQzHo7FgQHLwi0Ze9wK8PQg02PamJrIuyMBy97Zq2FeEqvidlBQQiTMmTaqbNeURNBIHoHxj8t9LttVZIq6C+NEL+8nXyAK8unAmNu3CoIamkBwo461E/SHKli24Bd6d6MhF3liMcqJwQYuSfge6qgepzrBE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by DM6PR12MB4419.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:00:20 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 23:00:20 +0000
Message-ID: <5d125299-468b-4aaf-b8e7-304fbed26ca0@amd.com>
Date: Tue, 17 Nov 2026 17:00:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/25] dmaengine: sdxi: Encode context start, stop,
 update, and sync descriptors
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 John.Kariuki@amd.com, Jonathan Cameron <jic23@kernel.org>,
 Kinsey Ho <kinseyho@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>,
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-19-3668ccc7aab8@amd.com>
 <avdGL_FiPYeBOW6Q@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <avdGL_FiPYeBOW6Q@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:806:6e::16) To CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: c56b435f-7c65-4bc0-0b1e-08df44fe8e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|10067099003|261021121427099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ln9ayHvfonowcp05KuA16ukgxS6pKTzYtbI6oTO87aqJ9WxdAu1eZC9uucX6srZIQ8oyzpPKD7Ll1F1N7ppyYx5Pqu3jaW3LXqEyavQC0gtXICAyTQiNH4MgMPHO3SK/U++TtporpspC6zC6HXLXfb4yfHOk5ywiVrrBRTgaVJDo8HMr9Ze5torAAqt1CFKBT5j3Y25eke8iq6MI0QszhI4xH0kWt0WS8MZuhkBf85Ez+NcLLt5ggFG1HJivP7XywLcN99OOXUVwhLkBgQHviBZ04Tlet+m9TNV0vfRozb9MrRKyuV0v1T710KY6wwJkofwm+xhE+g9iDXD8IJy0lnxx/d64nf6FGJgxybwDcgmI98bqGAyiJseHYhxmnqsO968ptWhQuxdq8VdpaUrG3cneKs/d9Zw3aVw6mlWCsHHzU8DY2o640ChJtaJeUQOabAbLDBsRLilVtWERE3sfiTWlRJjEp/2Lvur4wymhTq70TPK9Z5n/uwf/8fdQddzZyyglcO2fmxdNSHHqEGSLBYzGWtaRGBx4BcDv711S6BlhTkkIIfRsoIszxP7vR+/49GJjVi6u8cXSDMkGSUmCouQdTb5MD/JWlTjQkW/GGGPy7o1nTdwBSYnurZH0Xwz0GSqsq6dVdy9tSD7GMZLfVhPYkNxF7pRa7/SEvbVuCEk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmJsM0xkaWdzQmJkbkh3ZzFvc0xOb3VMMGhCQjdhaG1zb0hPNE5nN1BOUHF6?=
 =?utf-8?B?Q00xanYrbU5ZdStrYmdpcWorR3BHOHplNmVmdUZURHMzRThXMWF5V2lPOVFz?=
 =?utf-8?B?eG81bTVhelFxMnBMOFFzeVlVbkhsdWFHUmtMUVlFTDVCVkhPbjU2bWozTzln?=
 =?utf-8?B?d2ZXQmphSFFvNHBVbTh4NTJqSE5HUkt3ejZOS2pOTTl3QnR5SXl6ZllwUTdJ?=
 =?utf-8?B?MElGbFhmaURBV0w3dDBKNWNqY3NTeTNOU2VBRlhlaC9SY0hnQWZVVm5tTTV3?=
 =?utf-8?B?NGtKNGowc3FHODdDZFVnZUU1cHpWWXA5aUdKREhoMUlMWmRwaVdPUGhZUHZh?=
 =?utf-8?B?ZzdkNHhPdTJmNkVjN3ZJOGpWZExlWnlnZXRrdUdiUFEyS1haZ3BmaUFabm4v?=
 =?utf-8?B?SmlCdzBscXJaR3RlR0JvYzg5OFJFbUZyaXVBa3pYRFk5dUVlYVptaFh5dXVz?=
 =?utf-8?B?eXNFWWdjYWRxNXJNQlgzeEhOdDRENGNBeGxQQVpPYVJuR21IVEVqKzdZaG81?=
 =?utf-8?B?bnVjYTdQYUtaNytGdktBY29KOUxpMk1CbDNwV3YxMEM3T2VEaWV1NUNkR0la?=
 =?utf-8?B?V0dMaytLMWZKSWJsY1gvOTdZeHowU0FLVjVYMzFRSDFncy9zLzE5bUpMM1gz?=
 =?utf-8?B?S2dSUmhNOGovTUVRNzdSelVjY2Z1blg5WHpsL2dyVmFvc3NJNzRhNEdlbkFS?=
 =?utf-8?B?c1NaMm1sK0UrK283TEx3blBLTGdnZFBaTDRKSVlrY3BpM2IvMkdmeGlxRm04?=
 =?utf-8?B?cEdQUzZDUWVqZW8ra0JzV0ZDcVZIWGR0Z1lWdHFoVFNxM3ZIbHF0Vy8xclIz?=
 =?utf-8?B?Tys3VjhkQWY2dWh6UzFwY2hGdUNYRVczbVdCNWFocXVxb3ljY3NtVWtlaVdN?=
 =?utf-8?B?cFpLUDJUZDJCTFhML2FrMTNQaDVBMHhsZE5wUDJadk9IL09lVEtHRVZxOTFT?=
 =?utf-8?B?Njh0dCs2clRxSit6Y3ZjSEpUejZIOXNTMHcyTTVQOHpmSUtSOGprNnNJdFRH?=
 =?utf-8?B?R1E3RENBbjFUWHl5Rm44Rm44U3NVWjc4V1cxeEhhM0xEdzFDa1lEalA1NUhx?=
 =?utf-8?B?emUzZGhVY2dMOTZoVFFsdFZscnM1eXgyRFd3VzVSQXIwMk5kMjJ0eExmUnh5?=
 =?utf-8?B?V1B3NHJFTGtTN05paVdFM0FjQ0xzUGlMSkFMRVlhcFVCWXoxMTIrYmVrdmtp?=
 =?utf-8?B?Mmg3cGNNYzdZNkp5MUVYeDh2VGlLc1VHU0IwZjFkTzlxeFBWWTR4NDBGcVdx?=
 =?utf-8?B?aDZZM2FnbHhoZmRBbCsxYWIrb1ZEK1pLcVRVTWlzMWdsNUR6ZHhPVWxVZWxJ?=
 =?utf-8?B?bHU1TVppWEM5U0JSY3JyR0trNTNmZSsrOHkwRzhXcmMybG5zODRCVm5TMktp?=
 =?utf-8?B?Z3RvTFd1NjhBNnQ5ZkRab0pLQTlBcmNrL3R1bmhjMkJucWltQTBVcGNxcnVQ?=
 =?utf-8?B?U0F1RGJ2Q1diaVhuVkVYbjVzQk9vbEFWMFM2WXBqQ0M2NGMxSzdHZloxRnJQ?=
 =?utf-8?B?WFlzTURMTE9TK2pkSmpPYTZPMUZZVWRiV1RYVDV0SUFDUDFyQzY3ckFOcXpQ?=
 =?utf-8?B?Nno3cjUrSFA5cTdmenJRSVBpOXlOeTBiOFVrcEd5Lzg1dFdjOGVWS0hwZU10?=
 =?utf-8?B?WDJ0ZWlCbytCRGNUUkdCbnliMXNxWWFjVlIza2hQRCtEQ1pidDQ4OEN1cWNG?=
 =?utf-8?B?cXRrRkJwS21GYUVsamVjQURySlZqZFR0am5kb2JRTUo1V3doY1NTeGpUaDhZ?=
 =?utf-8?B?aU9VdWRrSGN0YlVCdTRhblNVUjlIRlJVU3ZqNjU1S3Jzcm52UFVUNURROEZJ?=
 =?utf-8?B?R09CSFIzR21XZDJIM3pFTkJhblpCQlJRVEU3d1hLRS9sQ1hwRlNaeGR2TzBF?=
 =?utf-8?B?NU9ETnExMm5keGhJQlM5TFdIbmdqWHpoQnFSb2hoWFB1ZXA5UkIyL2xBNWto?=
 =?utf-8?B?V0wzNVd1VlR5VkFHVUE3VFJvRXMyVTd4djlaQUg1cjJYeElrWWZxdGpneGNr?=
 =?utf-8?B?SGRUeVd2UVJ4UnM5NHV1WVRQR3poUkZ3engxRngrQ3BIdDk0SFFyUlkwZjRw?=
 =?utf-8?B?djV2eXlFeGZmNVVQZUY0ZnNESTgzc3N6YVJReTEydCs1QU55RnlvUm9hSDh1?=
 =?utf-8?B?a05kWG1mcHB3RFBTaDhPR3lsTndmRUdtSGVkbzZUMFVlZVpqcUFBKzRoUjNT?=
 =?utf-8?B?eWxJc2dCemRwVjNObzNjRGltZFRqK3M0aERzSUtvbjYvM0JHQ2lCbTMxZFp2?=
 =?utf-8?B?S0FyMmZhVmNVaCtISkh0djJXV1FabUVOSm9yeURMdFI2NGZjblhSOC9xb0pL?=
 =?utf-8?B?ZnRwM3oxSFRVWnNweFVwWUxHS0ZNMHpPUEZ6c3hpN3FSM0ZobFROQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56b435f-7c65-4bc0-0b1e-08df44fe8e19
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:00:20.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSXbt2zGynPKPGMyYSRXc+J/oD/7XptIguEx8C7hJBCJqnkG8rqoyo+/k9ya+fVpAzpnEQQKXfBJmLk8B0nBqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419

On 11/13/2026 11:17 AM, Frank Li wrote:
> On Tue, Nov 03, 2026 at 08:50:00PM -0600, Nathan Lynch wrote:
>> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
>> index edc43190148c..51b2bcbeca90 100644
>> --- a/drivers/dma/sdxi/hw.h
>> +++ b/drivers/dma/sdxi/hw.h
>> @@ -142,12 +142,89 @@ struct sdxi_desc {
>>  #define SDXI_DSC_SE  BIT(1)
>>  #define SDXI_DSC_FE  BIT(2)
>>  #define SDXI_DSC_CSR BIT(4)
>> +#define SDXI_DSC_SUBTYPE GENMASK(15, 8)
>> +#define SDXI_DSC_TYPE    GENMASK(26, 16)
>>
>>  /* For csb_ptr field */
>> +#define SDXI_DSC_NP BIT_ULL(0)
>>  #define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
>>
>> +#define define_sdxi_dsc(tag_, name_, op_body_)				\
>> +	struct tag_ {							\
>> +		__le32 opcode;						\
>> +		op_body_						\
>> +		__le64 csb_ptr;						\
>> +	} __packed __aligned(64) name_;					\
>> +	static_assert(sizeof(struct tag_) ==				\
>> +		      sizeof(struct sdxi_dsc_generic));			\
>> +	static_assert(offsetof(struct tag_, csb_ptr) ==			\
>> +		      offsetof(struct sdxi_dsc_generic, csb_ptr))
>> +
>> +		/* SDXI 1.0 Table 6-14: DSC_CXT_START Descriptor Format */
>> +		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,
> 
> Is indent wrong? suppose define_sdxi_dsc() use previous
> #define define_sdxi_dsc(tag_, name_, op_body_)
I'm not sure what I was going for here; I can make these parts align better.

