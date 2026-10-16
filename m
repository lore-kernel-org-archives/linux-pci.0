Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4630F55B;
	Fri, 16 Oct 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136748; cv=fail; b=LWm79gspMsCbFoN/IWwP2rjzYL86TM3+Nkwl+MbwQsm3xOklOv9y4GOL6apo/wea2wnx6jOo+LIPgYmTWe1vqOAos3SCKQukyhuDXA3CBSShc2MWq5OkHKkT79j/DNL1cgyZhp/Fubo4ZBacjHvd3BFVdG418kGewKm/MQfgzt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136748; c=relaxed/simple;
	bh=1eb7eK/z8KmhspKevlsijMN8IX/ghszjICF62VNabWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ltx9qIdLRZqgJWDw5o26vu0X70ttvAE601ma6YvXi7iDRmWgNubNkdxvMyr4+kptmg8Vie16CikKx/FIsuZ+0CT4pNZISiJfr4J4ZO+uRU5ROP/6J4Z1FxX+XCf1IqUJGp57EeM927Pq7ZnIXpdkBcugTufvV2jo4vkIelaPbkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tdNzk38L; arc=fail smtp.client-ip=52.101.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdNzk38L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRtRIAPN9umxGmBZtYoShzkYTsPymI9YmZdUVE6z2AGPoIzQMbQxZiJfIDmvDmSc7baO2+jNmq35MeYi2o7V/jWyu7ncEHvLZDPDXG1ahKxRg2BPL9CtSZZSqYbryQ9GVab1GVP7c7puhSecK8LiJpbx/4fDem6DxzsYzei9y5KYokooj59TXplC/nAKJyRhFHf0JFSXx/gsN5sWwZQX7xJ5oz9AZwnybFLMuDSg5UziWs39YOrdSQK42bIaU1vvGfSqEp+OcPwm/9YXVCJPce7RbTQAwWcK0xpUsytiRpey1aweOKEPQqqIb6armdUp8F+gnh3JaCM9DZLG3YdJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSZJp3pmGfT8sGd3uBrAmgVmEQ9345NY9yP+SQc4lrM=;
 b=Chv611IO4uXvBKUK6JlZYge//l5QPxMywlzAlWc7iiZrZlKglEm1MxEvGGyXC+y/UQ9FBt+0h6+VbDckgD1dR6dWOSFwdbMShuu3YuiBHXRUfMgkaCZ5dUNEUMdsicyB16Q3Ku+1foiSmkuMNkTNzyR3hf5fq9YQyBL5BIkJm0CuvmvgQS1P4/4jecybhvocKtABf84+RqLLp38L8yy5X71DZNz/iDY6hsnIQxQ8/7aiOCwMIXREuuG/1yzq2f9nLBUSvLetWQR1+swX/uhveRQyS6QhOZZ4puyCIuvTTA78ELVAOBbVB1OLdZ8V9MzhntFyTbeLxZw7PPHf5GnwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSZJp3pmGfT8sGd3uBrAmgVmEQ9345NY9yP+SQc4lrM=;
 b=tdNzk38LiPlU6F1uVz7RpachlED9c45E3vZz1au5lYqtwnFQeFOZ+pL4YZptIBbZhGhz9HNRVlQXEQaoNHZHNuTXlIRwojkgrLrVcJ7YlWoJkQzDZs4ev+3cGvp0MGoa2FdxDI3vHua7ue5uRoxd6bljoenhqbEC4PjIu0FSOTrtZBWPzWucUZXu/xqbb22pU3HLRNSQcPo08weeO+EdPJos/WOkHCy7T+Q+n7XpTiHUDElDgSaff7r1ayx4sBvKpHhLz3dOF5yFyMVEPIoZmRJAK56DFFbcE9zQ7aqRcxD/n+ovG1knRh+GMRHwhEJyqFVetCmds3dgyM28hexReg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Fri, 16 Oct 2026 07:45:42 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%3]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 07:45:42 +0000
Message-ID: <cc413ec5-3d69-4fee-9bad-1e6c152b789f@nvidia.com>
Date: Fri, 16 Oct 2026 13:15:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] PCI: dwc: Clean up RAS-DES and register field
 handling
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 Niklas Cassel <cassel@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
 <179198416084.63727.13083524527951291207.b4-review@b4>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <179198416084.63727.13083524527951291207.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::15) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: a0918519-6ab2-404c-60d2-08df2b597add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|11063799006|4143699003|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Onhyov0ET5XJmcxHoSxcZwXn/Zw/+D/AXCChhsV46bmX5n7jWmEJ5S+lV4B26hlDo4LhfA0TfT/DFlLgpZirbwL7sALvVAjBdyTUoEt4J5kaElZb2SvEtEFkM++JzmiWD5dICSfg1xpI7HyO2s+W27/5KbL24qtTdPgnBG2HITdStP1mwBq97hKOQ3IBVHEeMqnRA9jRDfk+PcounPh9LqqgrQ2wJHCOQ70U3+0d1y8IJwaibHOCGfE/oEoWZiIKB0UKzFmX1UVsdEx97HY/KtsRBNOrjed/AmmhuCLgiwEdquhHmMQxcKOLwD22Gds+0eLuPgF5X9jXzl+j4FzW/Hm60c/nppclHB0RDrEn/f5NsHFbYV1wmEq/sNOWCI5vBEfBc7uAqc+a8JCnRzPzA66xypAkkBg6LBTOEaiGO9Dl8tiTFuoFe9sWhQt/Lj4tzb9SEYuJxLQV+GMtJojxCDPCO1yQ1Nwnzu0jVwR4izkFqtcydtCv9gGiE+vziZByNqzXlMhUoOmBH22PamX1iHUW5aR7PaIREw0waSEAu8Qox05JIyN8KgvIyGOXtx4CLauKFPg+ZGtrXxeQT/l3BEw9BigGUZWZQaSAq/g1Hgi9slYAxmFFQKYsEOic1au5b4Go1+pM9fMhF946+Mn1ZLhR0Sr8Gxvd+RFD8FOp2vE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(11063799006)(4143699003)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDczNDVLME90bXp6eGFsYkh1bGM1NzJGbHpWSkFSMzg0YVhXT1ZlMHAxdDN6?=
 =?utf-8?B?RXQ1aHFXTjBHcC83VVJyeWRnZFFuNS9EbzZpSGtzcnJxS0I3NGZTWkk2Qk9O?=
 =?utf-8?B?T3JmUlpndm9KWFdKY3pNR0xBenJCWklvTkJnSHNUeTFVSWxiMmdsVEx4NnFk?=
 =?utf-8?B?eURSZHd2Mlp1N2tLb25HSDRZMlptUmtpSlZ4TjkwTk9IQnZSVmRnWldjUm51?=
 =?utf-8?B?RkpFK09DZERCWEFZaHZuQnY2WjdaOXVEQThwTUJ1RUgxSW43SzJ3ajlzbDFP?=
 =?utf-8?B?L3Y4Y1hjTk5yT1IzNUJROENZK1BtRXZWZUpNMzgzTVVCazA1VldNVDB4eUxj?=
 =?utf-8?B?REx3M1pMdkZMQU5PZCtTVTdqV3F6V3AzUTB6NGtyS2grOVVpdWNTcGdMUjly?=
 =?utf-8?B?L3V4KzVWcXptU3BwNWNaemdkRE80clBhL283eEYzUDBOQkRTUkxOcHI4V2xX?=
 =?utf-8?B?bVM4YWt2N0FhR1JWRStQUTdrRFNuS3ZobUFlQmRxZWtZckw1czhYQXlOLzgv?=
 =?utf-8?B?RGgvMnB6dmszekk1UlVaZzlCRUg4U3JRSkMxajVxd1BHb0RlVW1iMmNOTlBV?=
 =?utf-8?B?ZlZQeGxDMTRJUmJmWFZwdWlGanhBME5UWlZnU0lFMlV6VlZ5TDI3N2FucHNH?=
 =?utf-8?B?QU1RVFNzYW9YNWJ2b2lPNlBLUkhkeU5BdGwxb2tWNTRoSE5vbEVlL05mRHor?=
 =?utf-8?B?czV4bHVEOWVVOTJOaVJBQjAzVEp1dTgzVVV6RzJZUnprQk9uWVV1MWFUb2hu?=
 =?utf-8?B?TEdDbkN5d0k2bVFOOVRqTDFMdzVTdDE1UGRSQzFEWlk4blNCUEJXanE1akJP?=
 =?utf-8?B?b2NyOVVnYzd0enVScVhxMHlQRnl1Y05TQVYyR3JBdERyWjViMWFhMkNzbnVD?=
 =?utf-8?B?Yll3OXJqNjl5NitzejNvSU04UnhWUWtpdjZMYUthOGprUW8vTDBDdWtHbFQw?=
 =?utf-8?B?WjBJVVFKdDBuUGpKeXZNM1dhMFZYMzZnZ1I5dWNxKzJwc2hlbEx3cC80bTZy?=
 =?utf-8?B?Z1NYZHFMcEU3UDVWNkZ5ZUZwaUhPR3FZTy80eDF5OFpMeks1OVo3Z1pPNzZu?=
 =?utf-8?B?YVhDcy9HbnovYjU4VE4zcXRNZVYvVVJ4VkRLRDIvUzEzcVlkVXd5elZwZll2?=
 =?utf-8?B?eTNaazBLdXlub1dhdGFsTklldFQ1QlFqZ29FbjNxZFBMaWZDYSsxYU0xU010?=
 =?utf-8?B?ZHduSTNWanJTYkRodTFySUlpeVlUR1I5Mnp3bmd6Z0dBOG56WFNHOVVBS1JC?=
 =?utf-8?B?OG9TWVUzeDdQQlZJTWtoODRhOXEyZUUya1NnN1JZWjJ3ek16dWtMMEp0aVp4?=
 =?utf-8?B?dllzKzhVWjdKOFUzemVaK05rNzZvS285alFFSEt0TjMwVkwvWTd0YTNZRXlu?=
 =?utf-8?B?b2RxNUxmUkJRSlZSWlFXN29qdzRNQ2F3REt0WUN6VkZJOUVpRTU4Y1psYXls?=
 =?utf-8?B?c3VYdVRGNllSV2RKSGtudmNjRWx2d2tzMlRENEdxZHlJNzNlMjdkY3NWZk15?=
 =?utf-8?B?RUttbFY3ZG5qdEhYUHlqdHl6YXBxcFdtcEZIdENZUUp3MmNrbGx0MmlWWDBE?=
 =?utf-8?B?ZDJmcUpyOExKaStKbk0vRXcvbVV6b2laNG50S1RiYlhKb2k5bFVNdGxKK0hL?=
 =?utf-8?B?ZHNQdDJuNEpFUU9aVXkvK1BJaFk1Wk9WNkFxRi9ER1MzdTBWdEY5Y2VqMmpD?=
 =?utf-8?B?TFJic1lTcTgvRXBxSUFiUUErT3BMMWUwdnA3cU82TVdON1laWDNoV2ZCN3VY?=
 =?utf-8?B?UlFDaTZ0ckFJTDNCRVFnQlZwL3drRVRGMkFXSytIc2pFVG1jeU1NbEMrN3dZ?=
 =?utf-8?B?NjBmQzczUHd6TCtkbUpjVnJyUDc1OXFmR1JPYkVSNTVuU1ZDUDZqMlUzQ0U2?=
 =?utf-8?B?RUcrUldSVWZzREpTd0RYNEg0K0prNGcrSVd2UVZsWEgwRDlWL0w5RGFzZWRX?=
 =?utf-8?B?RzRBQllkbEV2L045Uk5RUmpYaEJ4M0o1aXJBckl0MldMVXVnRVVKVFVOUjl2?=
 =?utf-8?B?Z29ZT0QzSS9WdDcxaGhGSm9KMnFpd2NwNUp0RTB3L09PL3JYNGh2MHU5ZXZF?=
 =?utf-8?B?NjlkcGNZS1Y0WGZJeTNGTFBlb1RocmxER3hhVFUwekhnYWIxRVNtWklET3Rv?=
 =?utf-8?B?eS9vMDg0blZ6VnlCT1NoVHNuTVlYMW4wZ2F6NllLdENVcmNxeXhueW5pbHZp?=
 =?utf-8?B?WFEzbzRUa1VwM0hyYkU4S05oU0ZSbEZ1Wk1PSjNVWExGcG1tZXJJYVZWL2N5?=
 =?utf-8?B?NGliSVdGaURITmVpejIrYml5WWhHajhqRmtoZXFaOFdlU2ExVjA5dmR0ZVM3?=
 =?utf-8?B?Y2MzUWtVclhRL25OVlFnSTBzZ1ZoTE5INkEwMkhscmtSREIzenFuUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0918519-6ab2-404c-60d2-08df2b597add
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:45:42.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkSsPLEeZ3GyTXd08re9ndXQZFyMmRDYRmEKg1Rl34eMnHdfbWEBOmEzQBaRvVGwZS+TWpdqK91mWAjckmqgnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978



On 14/10/26 6:52 pm, Manivannan Sadhasivam wrote:
>> This series addresses review feedback around register field handling in the
>> DWC PCIe code and the Tegra194 PCIe driver.
>>
>> The first patches add shared masks for the RAS-DES event counter fields,
>> convert Tegra194 register programming to FIELD_PREP()/FIELD_MODIFY(), and
>> drop shift macros that become unused after the conversion.  The final
>> patches make Tegra194 use the common RAS-DES selector definitions and
>> consolidate the event counter field definitions in the DWC header.
>>
>> There should be no functional change intended beyond making the
>> bitfield programming explicit and keeping the shared RAS-DES definitions in
>> one place.
>>
> 
> Series LGTM! Please rebase on top of pci/controller/dwc branch and resend.
> 
> - Mani
> 

Thank you for reviewing the changes.

I rebased the changes and posted V2 at 
https://patchwork.kernel.org/project/linux-pci/list/?series=1187061

- Manikanta

-- 
nvpublic

