Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953329;
	b=ux+G8sqPVq1NO/zO3T2RwnhSfpqDtoiK1dmCUhPC2VeUDEG31pUjQn5EmNwBrFILPJkv
	 piUxH/ItCgwZtLpXFoseyF46q5XfX9U7sRoxDF9+aY1Der2WWw123wD6s/KqWLQVvDf/U
	 xJxnMK1+Q0g9Tf269Q1jDB2ggJksWYRUscrfNpfU9cikHaRSSeyPI4KYlfgTshkcvHJ0I
	 2zx0mSIP8KmLwtRhLvb1XSdANQKcRDa9CgB9it8bmaLDmsoCMSNks4gvr3cm7kG2sfBLa
	 WbYgjtlVp4xtL8XxSwb+obdVK5HlFTMYrJd1sv6Am+Hr6CLCXfh+Y7AfnqGkgDD3WOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953329;
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
	bh=y3UBIthvfo4zoD/KYshJDXCusHWUGro7TX6GfktXogQ=;
	b=fMpntHH35BJDDylLTnPyMySV4tY0FjKswMn6b2JuVlUcxFBS0SEfiZBAK6qKADId69GZ
	 OaR+gxu1x6gl3NQ5jNfOZQ+BGnNQfhvtebfrjmK6/3sqPoH3cWJk95QtlJ8XHktDZhoAs
	 eGnxHr0jqgB2wtBooSvdMeWrDsKyLfVhNremIjKlUFywFREIGObp+qPWJnFyoC5Jhx4Qd
	 wRHYYMuApzruB4JlbyRqeSAH5V49QhY+2QU5Iks+CAvpFiMiicUZx2hr/00ETlMFteinw
	 h8Bne4qHOimp1h6royixaWGkt7neZY3Ap+zu3hDBItPvRwrSxl1p08FLt8GH+4Liz7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FlamQ32c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.42
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA620606A32C;
	Tue, 17 Nov 2026 22:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA620606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FlamQ32c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwZiaGVnBjtn4dO3URzI30Dd+GvrJK4BgCt9Zi7DMvrm8l164G6aNKC4G99Pwp3AsFHYV5EFRw4GQqrLZ7aFkcPkwl6+JXzioJOjF99uwW0Y6vKkOmcKk7XcrTwT21bo0PTrFHR1HFrL2DKPo6pWkp4BX3vSHZjIr2yaZZbTTu5l/Sg0HihOJ2BFh6VmvG1ojK7joqLxxBn0P9PvVJatSiJhcgSDvroNj90l776NKOsO3BJ/RrIIV6IJY/8onyuXey/RC7xV4jiEbGlftLnLA/SlrPk1oXqNepoe4DU2Y7ujpVdkJZ3o+a2lRKMjfg32BCTKzBY0gZg0x+/Tc9y1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3UBIthvfo4zoD/KYshJDXCusHWUGro7TX6GfktXogQ=;
 b=gzImtOZVvj8gvo+WkqkjQoFBF0JsFPtSWhssKo/6pb5uCplzjfttMRMxkX/DNEyy8MZUGlIaUxzSevOgA34ZMQW9ffWqN8bhTVVOZHnAYLgqWPPqyvOtfhWo/bkkAB9JVR56Lp1ZxNUG581lbGXVis2cSQhvEbHnqR3Zntf63/UGEhYox1ZPPk2qjfVY3A+8n1DUP9Zf2I1FqTTIGkWsVrqlPLiszsP1dk+CoImW5wwwGymrAaWhRSuioVFphsPzsqDEyYue1cv7iGbA7YSDYrxmLSsszPbtCTCa0OaCtbsePLJELqS3MSLOIGYFh/UXQafiGXhF4n9bBsDIi1KfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3UBIthvfo4zoD/KYshJDXCusHWUGro7TX6GfktXogQ=;
 b=FlamQ32cndYicTf9KVGYy5Y+/KDpSxbm5ViVfYKIfOcdcF/SkN5tqfUAM0jyiOXfHAoqADsG0XlOiYbrULoq1jKckxMER0h7whE+qRSe/rnkxHPbrbqgh7JsxDR0ivkNCc7ckMhuLjzOfSrC5kBWElCmJ2LmDA5qM2+QdJx1Sds=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by DS7PR12MB5981.namprd12.prod.outlook.com
 (2603:10b6:8:7c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:08:45 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:08:45 +0000
Message-ID: <74301888-f0d0-47cd-b5f4-64a3dd24475b@amd.com>
Date: Tue, 17 Nov 2026 16:08:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/25] dmaengine: sdxi: Allocate administrative context
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
 <20261103-sdxi-base-v4-9-3668ccc7aab8@amd.com> <avY5B5Rifn-uSams@SMW015318>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <avY5B5Rifn-uSams@SMW015318>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0184.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::29) To CHAPR12MB999249.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e046064-6066-42dd-7aba-08df44f75929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|261026121527099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mA2ZdgsQdnX+RURFS+faPOYDh1mcI/0e26ThARoJp0vZ1uNXyce9GJepplg1Gd6emiWIqbkBYnZ7SYrzbNJUHrDIKHFNEnHvHqnMZgAZtHTHrxK7Tdcn1djmRFsAgNUK8Bzx98TFDgNLAeWcTVghSZCqFG09NFhwSwPwo7VfWIxf4iCXK13Rnh6ut4+bDwRYcKArzZsFlxYsi9Srj8+DuwQVJweVO5u98ZLv313iJnxg+Y59e4zk4DSnaeOPg31FoWpk6Eu7By4l4IhsKeUNK6IMVRP+6JLg3ZfV+ODkPQU5y3+Is15QZqcjBJeOK7VpSDbmAwsrgToClwhQjK+JCVHLEwrRgDdadM10n02zOCIcSNHJg29YiJEuM9AmmIUtWBmcx/D0w2twWwpt3crmzPNpEBqHTp32gu6Gj7OQfD71qgpgrRs7AcEBhbCStzti0CR2jvsCh/TDHoRAJ/looN/hyuGmurJ210nUVIiSiaoL0o3kZdi8095c6hz7L9nO+Giqm1v05WaSiq6+r0CKXSg2lNVICIkWMZE/uXAPpQubAJ7m+mzDXpmbZNCUQEV28OlMcx8X+c2mme5E/HQU4srb5btYrcayJI9S8LqgXTTW4kZNLtEvM1BPT9o5arjhqRpcwVnfjBIgGm+N/aV4R+6k6Q+hyE1YVDR08DUoaxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjdyV2U2ZXRCMHJVR3hibEZhWFZqQWp3cCtFYnV0OXVlelBhTE8xbnhrQ0Zh?=
 =?utf-8?B?V2haQXBBc05EUWtpcThwNlc4ZWlSUDJOUzhqVlk2aGp3eURnMnRRZGVxcHc5?=
 =?utf-8?B?Z0duOGFTR0hkRzY5elo5bG9jeHVYVVArMk5Fc0RSdEVhbVFiZGZSUE1HdFY1?=
 =?utf-8?B?cU8wMi82bkFza0FxQlhCMWFIbklxMkdiQ0hJUXFRMXNXcXFCTHQ2K0JiS20w?=
 =?utf-8?B?K0dPdkpRTTdQemM0YzlWMzRhQXRmOEFrcXl6dStmZHN0Q1VRbFFZWWlnNUFw?=
 =?utf-8?B?QlBiVDZzSTY0LzZlYTJkdFNHaFRQajBDTXU4bVZIV1VwRFR3dFJ3OE5kUnlj?=
 =?utf-8?B?bVpUckNNUTJEWkF0RTczYUZuZStHY0xidXdLNVlIZnVDUkhwdEFJcjhaOEh6?=
 =?utf-8?B?dVdCaDBhYS9OeGJjLzMzSWFub1BEOHR4RTBmVzRLOW9xNlYzRGx1eTBLelBU?=
 =?utf-8?B?blNIcUJhT3o4bmFxc3U5bTg4ejI2dlJlbks2Y2tmZTNDNVpybnF5L2h3Q1F5?=
 =?utf-8?B?NUtGZWJDN2xQdFdVZnpxUmg0OVJrRGZFcGpmSU82SGhaN1ZWdmtiSmY5cFdC?=
 =?utf-8?B?eDlweWY5UW9nb1JSeWZBYytSYTlmWmU3V0hBdCt6ai9zbVpIMGpSV0pGUnZS?=
 =?utf-8?B?WlpBd3p3UTZpTWphMk1ZUkI2VmxETUc0Mzh3RTAvUStTYWNSN2J1VHZqMk1V?=
 =?utf-8?B?VGtiQk5QQ2VNRUZoYTlPYzg0amlDWUFDaVBUNzlBRm9jTWhaTCtmNzNoQnk3?=
 =?utf-8?B?TEliSDN4VlFGM0NQSjRuWEp4WHlVcWNtMWJvSis0ZnRQbjE0SVR4bWJWYjk1?=
 =?utf-8?B?QUw0VzFhenduNmtVbjNMTHMyYjI0TjlwZGx5NkdLUmt0YVFWeFVOUmdPa2Y3?=
 =?utf-8?B?V2xMaHhhWHMzMlFlYlVWZXk5YTFyaEVPaC9GYnJwSWJKbERkUDhxMlcvQXlq?=
 =?utf-8?B?ZTY3ZzNWbXVybXlCNUliSVdKRnJCd1BRSU1aVUxZZWhrRTFPakJ3bmRQRVBv?=
 =?utf-8?B?UXhHN0NGQmxXN29xbWM2N2NaSWlMSVlsd2RLaU5aYW5wUVdqNW9ocnlYV2V0?=
 =?utf-8?B?N09TcmhmbDhGMXd4aXBneDVXaXNBSUJVS3NSSHFmK1VuTVlEYUI4bUJTR29J?=
 =?utf-8?B?cHI3c0NLTkxQdXJiSWNUSjQzSXpOakVuVUlaaitqS2phbTRNTWxITEN1UmlB?=
 =?utf-8?B?eFpNNFRLZzhwaG56bVBxUW5ZQmtkenBLZTlRZ2RkaUFtS2VLdEJwYysxV29t?=
 =?utf-8?B?dWtueDJENWtxNGNoUzFmQWNDcmtBK3dBcmJtWnFJcjZjSGpjZlY0b2pXZkds?=
 =?utf-8?B?K0VxWEk5cmlZaHYySXQ3RVNBTHE3WmZHbVVsRk1ua1hoSnowSis4MndrZGUr?=
 =?utf-8?B?Z2x4czJMZ3AwZjZpaExWbFhIeGw2R2dmSGE1c1c5VzgreGNpNU1WdWJiWTVB?=
 =?utf-8?B?Mlhnd0ZhUEFHRC82WmYxUkYvSjR5Wkc4RjREcG1CMkdTL1VDL1hUNFl2T0dF?=
 =?utf-8?B?ZGQycGNQaTNoOVpKQUpRVmtVOTczWFJtYSsySm1KeC94ejMzSWw1dFdKUDFT?=
 =?utf-8?B?ZU1sU2IrcXE3RkYrcWRNMFVvcFZSUGZDZmJ5Z2VZWHBPUStGQTN2V3R4M0cy?=
 =?utf-8?B?enBKS0tTbXl0VXlXSjR1SkhQcHZ6M2tYck5BZDZWN2NObjF1S3FNRUZ5NFda?=
 =?utf-8?B?cCtVSDMydnk4OWZEaC80SE9Eb0tlcitOV1FLZEY3anppNCtTMVVjWlpaRFJw?=
 =?utf-8?B?UVl6Wk91NG1LeHplbkJKWlcyWFNBM2JXY3oyK0JNMkpkOW00WWw3cjJRSzM1?=
 =?utf-8?B?UjFIcWdWSzFhMFpLUEY5RGc5bWZSZ0RLNHQyakxzVzZ1azBIMlI0RnhkZkFt?=
 =?utf-8?B?dmZPMkxhcUcwZVFQMXdsT1N0VUd6OFJ6SGdLbHgwT0tFeXVBbk5XOGM2OVdn?=
 =?utf-8?B?RVErMDduY0J1ZXplYWJ2TUp6Q2RtdFdUbTBibFk4Qko0dTVPc1A2Z2tOS0F5?=
 =?utf-8?B?MXRaR3ZwR1VkUE9uSFJ6S3Z3NGw1ZS9pQTBSZlJjVkR3Rzl5UDJzd3hxUjJi?=
 =?utf-8?B?Y2I3eVF4U05abzBoamVZTDZUeERsdXkxb0Y5M3JOcEJmWkI1azFaclVzUHZW?=
 =?utf-8?B?SVB6TnB1VXhoNmVNaW9YM25GQyt5Mlp4Y3oySDl1eG0vTmtlbnNTTzVNUXZy?=
 =?utf-8?B?Rm1OeFVvbGYvSlF3WUgwa3lKeEtTbDEwUUZOR3A3YmVXMlZwTzJZVXZobUZM?=
 =?utf-8?B?ME5ZM2NFcFJDSWhBd25ncDErOVlFakRmU1BaS3JYWk5Pc2FKVTRlb1p4OWVv?=
 =?utf-8?Q?/JcHYwLZqqwlr+aI6+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e046064-6066-42dd-7aba-08df44f75929
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:08:45.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB4DwtVavvXGlNCulmyXyt3+TJqFnFMenwVoJGH7K35qP51cIxbJSa0Z4dnoN4zELwmmGGXTHwreIfqNLY1ltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981

On 11/12/2026 4:10 PM, Frank Li wrote:
> On Tue, Nov 03, 2026 at 08:49:50PM -0600, Nathan Lynch via B4 Relay wrote:
>> +int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>> +{
>> +	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
>> +	if (!cxt)
>> +		return -ENOMEM;
>> +
>> +	cxt->id = SDXI_ADMIN_CXT_ID;
>> +	cxt->sq->doorbell = sdxi->dbs + cxt->id * sdxi->db_stride;
>> +
>> +	sdxi->admin_cxt = no_free_ptr(cxt);
>> +
>> +	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
> 
> If sdxi_alloc_cxt() only called by probe, needn't mix cleanup and devm
> function

True, will fix.

