Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793680196;
	b=2mkjdpVGIVSZY/DG5768n/j9IS3CoYP9z5gmn6A7TMmwPJ4T7f/THMnbRccM8AzqLWza
	 5i6dKm0XKJn0huo/NdsmhN6igMbkpIUQ7h9UV5FIJmFwbaZ17+EZGv1mfoYPx8J2BtVrd
	 1TIkWZAgmVceVOOdRvL6EKSuD+dfKV3yFakCsJo6J9L4tTspYbHW1A6XoK6/zgp5noLc0
	 TZyTo2cuE0xLlO4ZhQyvUroRX9M9+vlpz4IsMhGO3xdNGMMIYJ0VC7hEEGf5VdZixVhGL
	 NLG3rN35REQ31zEjzY8OEGQZFux0BZD/UA2bIAEzQTSMLcdMBPA3hiDubOb1QbJG/zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680196;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:
	 X-Nvconfidentiality:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=t3Tg1QO7ZdVVLM1ccC8Yjrhu62e9s7NNZXVPphWLLjs=;
	b=UXfYXMRY6eAA8lnchb1gjmkN6J0dm2HvKZ0m5OtIX40uS7dIikckqA/9o0wF+Xs+5lo+
	 Mos5liokQigQpqr7aGnA+87vPX2SUl2HcpsUUHk9OKb/cYG3giQZfyLxPgslbNi5434F5
	 Bd9cv3vBn0K/d+us7pdANl8uD5Jhpzmm/0PS1+fU8FJh9+WY5JHRE73fqkosFNjvoSC/R
	 sufSV7lZlM83XG8RLfVzM60+0AjNL1ioMm8KzL8t7ftdnEPoaO1HPnqonKktVnvT8dO4l
	 Jrlpt7RvA6iA1CM3NyJVBgJjlxKffNn8hPHtugWt5grHYw6R0cnxafL6/e5WZAbIO3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ByQW+teC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.9
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480D606D815;
	Tue,  3 Nov 2026 04:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9480D606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ByQW+teC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxQI+WFkrGaZathRconI2HWRt13di8AarBx4AZj8VxMr7v8rv4RmgiSjtH/sUlVpx5ZX9AWED6x2wMnNPrF5LHVHnwEUJbXWr56N4F43FWRrjkJeMfGbs1jJHsgZSHn2hsFFYdY20MiX/OBzvomOx0sayLpr4zGSNn5vrFirxs2dCGTKz/+jprgVSG1RdPu+kMhJ7gwCrnX2ycxyqoGzqflXvzPt4UQAybINi6YEwzwKFy5rveMGl9VDrBqssVpCXQ0RnTzyWPcV+WSg/vUC2XT2Q8IyqG+Nq+NOZERLnj3c3c8fRvp4DDcjrqfqqG89vvT709bnroSYDlNE8LfJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3Tg1QO7ZdVVLM1ccC8Yjrhu62e9s7NNZXVPphWLLjs=;
 b=RTfG042To4Z7/tH5MNl3TwF83nonlVpp2t+1QuZYGijZcA6E6tcpcSiMBulX4zFCq6EhLB9oqMEX7y42/q77xAKu2iQ/YIsVMWZwMlY/qU7G4o1cAzc7DF/REhcNWmah9vO2oJe72tXo7n1UeIkCE/IJ1yuT86LNJGdehoBc33hsP0OG31+vfGrTdHb0TE4b5ReftiB18LMcGRN6Yvr7qQxvYHVspa3EmYik/ew1R4ksHrwBhgHeJaCiWMp8Nop5NikGMHNFyuBLXoB9I4nqD0/rP/htcKzpzjIhUDAth79YAtXokzvKq78te/e7SHi/6xs1nZ6NXSUklHQCfjmGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3Tg1QO7ZdVVLM1ccC8Yjrhu62e9s7NNZXVPphWLLjs=;
 b=ByQW+teC79092MImEmT7BPAspqPM75ZywxEx3yZ3NFot4Oe5DWS4xzUhHhMJaGVzHakGr/wYxqr4VaOG6jinlUOfEZFL2bkceekX0MuTMJSflgWWcS5yZnW35VfnHzPVykTsn1b3ZD1AcufuwPRQTqxutgeuqjDCPb6Oddwgd/5Yi/Rc/KeabN69/J1usXLg2QhdETg7ncRCGyFL6ATEnPP9Cf5eKyOgI7GBTiFIFmVZ5BFoRu/C8NPOi3ajG6bjF8rpFYxJeIeyXt6YA2VvSlAMWgE7AFXXzizOvYpTDCpBlmGjHPDPWavB08A9KIacjFE29B4Bmr4sqKPMHXiz2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB257519.namprd12.prod.outlook.com
 (2603:10b6:404:22b::7) by PH7PR12MB7164.namprd12.prod.outlook.com
 (2603:10b6:510:203::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 3 Nov
 2026 04:29:52 +0000
Received: from LY0PR12MB257519.namprd12.prod.outlook.com
 ([fe80::89e:d21:20ab:ae5a]) by LY0PR12MB257519.namprd12.prod.outlook.com
 ([fe80::89e:d21:20ab:ae5a%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 04:29:51 +0000
Message-ID: <b76adcea-305f-42df-af27-8b738a9d859a@nvidia.com>
Date: Tue, 3 Nov 2026 09:59:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] PCI: tegra194: Add PCI_ENDPOINT dependency
To: Niklas Cassel <cassel@kernel.org>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "mani@kernel.org" <mani@kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
 <20261102111450.4010818-5-mmaddireddy@nvidia.com> <auiqSIKbGilCYxDT@ryzen>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <auiqSIKbGilCYxDT@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0083.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::11) To LY0PR12MB257519.namprd12.prod.outlook.com
 (2603:10b6:404:22b::7)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB257519:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 190b229a-7a40-4340-c12b-08df39631a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|6133799003|18002099003|261026121527099003|261102123227099003|22082099003|261102130727099003|261009221227099003|10067099003|261021121427099003|4143699003|261009223027099003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	KrI+CqcgObmHtGFw9gfRBcXupV/V4SSQ7ZkuqBzkzxBdphEgmD2FYsOu+xKa4Jo1oODwzStMjJZkkpwbxcpHA/LmF2mh26rJbRYlHLovvWWylymQdktjfMkkkWj7kGvjgvdeE322zOaKFg4zvHOgO23YSFLl9mPb7M6AJTCjaA8foBFYlBcMOJuX83YKnyb3BV3F1KJhTMjO/50/t29B1Qj8lMUyrVOwNVWsO0653tC84tv+Fl99Zw6UMwC0C5o1oOc3KczptGqD3wTtWeyeBXYLsbmtfhqGa2m34nr1h4bUOQb8MoBcthqKqYw7LBT5dT4FUv+1ILmWaypcck546tTak2pJM4QWZ7TuYNFgAodIi2OLsScaqV/fTWRp1qsC7BGygGVwbgGGgtdituKmU+bCI9P/L3nFFsVXTm5NWtdY36E2t7RliVLcyn9ycO2eurcBUS+87P8/UdWhGlGzDoBlyswAKces+SW9m36PJUFLegNUMIJrngmzz6f0imIjH8kQ2iLNa5Km7tXJ09ne7Q6fEPKFK3QJSLA0YPAeDqDY9JRa2K8ix1HbLySxHfYb2zpIEGeFNliz67fE0gG6+/Qo29sFN5WcBUa01XH/9AnjpL/WFr/hekAknDc4Fp2bqdm1nXYu5siOiM6+sNbxP7PyV85u3TV5geRFDk8u8MY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB257519.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(261026121527099003)(261102123227099003)(22082099003)(261102130727099003)(261009221227099003)(10067099003)(261021121427099003)(4143699003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVdCcFhJVTRqK3MzUmFhM1NZcCtpM01tTFRIYmppMndGVHlZZTFrOEtHajBy?=
 =?utf-8?B?aENXMVFVVStzODhKdHZuTmZTNDEwTXBqM3pUNFRESllqV2t6ZDdqci9RV0hC?=
 =?utf-8?B?UEFxbVJKOEJCVFJpd0cvWlppSXNSazNSQ2VNUUtHeGlLN1RkR0dTM1lGYkVM?=
 =?utf-8?B?RWZ3OERWWGhmTzZUWjFVN20ya1pTT0h2UXpzeWlHR0Vjb3pRRDVDQW5ORTlr?=
 =?utf-8?B?Rmpsb0lNcnVLYTJocUs4Y0haZTF6bmUya09iNHRPR1IvZmVTekVOMExDUkRM?=
 =?utf-8?B?cUcyTEpBcE5sR2pWOXhBdXhTRHlFM1JNZllaLzhsL2NOZDNRWi92UFg0ZXh3?=
 =?utf-8?B?S2dOK3dObDFENm1Eam1GT1lzd3hhbjc5bE5MRGFJamhVVHJEUTd4M2FveElt?=
 =?utf-8?B?MjdBYzdselE2bU80VlFNNG41alpDbE10dlVONG5XYmlmVk9SNndJb2tLdkJR?=
 =?utf-8?B?bHlIZEczSlBXd2VpdTFQaWZueFBNd0VBZG1UT2pLZ3MwYUc3a1ZvWkhyL210?=
 =?utf-8?B?NHEwVHVmZHZSd1cyb1NBVWgrd015UXNvZmFlWjNGNFUvN3JUVEV5K1N0S0ND?=
 =?utf-8?B?WmZNK2VHZnpFRHdSVTlUcjVpdkQza1NZR0UxajAzLzRrTW91Nzlyb1lpUmVp?=
 =?utf-8?B?N1gweXZ2ZlhoMjhJdnd5VUw4U1doTnJiNXVmWGJteXRKb2RKUGdZWkVPdnV3?=
 =?utf-8?B?eVlSLy9GQUdGVVhPeTNSY0QrUjliV0ZuWU93WDRIYmRyWkFlSHZ4M0RrVGdi?=
 =?utf-8?B?cExZN1EyNG5ONlE2V2syakVsVXVXdDRsWFBTakVKdDl2dVdzNE4zTHFIenB1?=
 =?utf-8?B?NlVxWDJVMFlEcHB3eWxYcERsYUwzclNxYXdwODFYNGRYbVBIY1UyTzJacWw5?=
 =?utf-8?B?T2xxVE1PR1ExVGJxOC9HNVZmUlYyYVlWKzdTZE1QYkRSVzY2cmxGN2lzeVZw?=
 =?utf-8?B?c3R3dnZmVDJUeDBGdDNZaUtTTk5nOFBpVncrWUxqQW5jYXFUVTFyYUpsbEk0?=
 =?utf-8?B?QlRnUHJaUDBrcDRLK2dSby9jVDBRbTIrSEtIRTZvWUVmdGZDRVBTQW5iVnk1?=
 =?utf-8?B?dkJmZzMyVjZLd0pmMjlwSG5OdVFuL1NGWmRGUHZ0bTI2WjFLM3V0cHQ1NFIr?=
 =?utf-8?B?U0RDRmlsZVV3V1dHRldydmlTK242SkE1U2FRa244UjhOUnZwMExmdkdFcHA5?=
 =?utf-8?B?Vmt6cUpqbVFPVkxsQ045NERNM2taTFRCRDIwNEE5S0QyeGpvb2U1RTZjRlg5?=
 =?utf-8?B?Y3RCUUNpV3luZWk3Q2pOa1Frb3ZxMlJiL3BSWG03Z1hvQVUvdW1oODBkNVN3?=
 =?utf-8?B?bGNDMkQ1NFJHY3BabzlsUmlsZWpyc0pOb2g0VTFQVXJWUXpHejA4Y0FuMGxQ?=
 =?utf-8?B?a2EzWmdEWi9aN0dRdTl6RmRxNVF0UlFVVGlKZFZZN1F3N1p1T3BwNGJLWW5Y?=
 =?utf-8?B?OHFaelJhV0prb3FhUmdzaE5zNUttSEZ3OGpBVzBTS2NLU2Y1emVQZzBYV3cy?=
 =?utf-8?B?WHNDaDBEUzVaeU5aMUVSc3I3OGpJaS9wUGhEUWxwNysvUTZycXB5SkxjQTRN?=
 =?utf-8?B?MlhJQ2x0YVpTcjdFc0hLNzZkMkNNOTJxcFFGMnQrMGdSdWx0MC96d1NGNmlO?=
 =?utf-8?B?MmpTVU5KZ0ZtdFJ6blJYemlEWWNScHJ2eXJFNHArR0I5d3VpWjZQdm1RalBH?=
 =?utf-8?B?TUVMSk1wMEFQWkhRZjZsMElDRGl1cjlucGhOdkRBT0dadFlYb1dqL0ZjMGlT?=
 =?utf-8?B?ZE8zNXBQL3lnWC9icXB3SXRVZm9rZkNCbUpYMjVkZUNZcllQMmtzNkc0R0pi?=
 =?utf-8?B?VWVGMTI1MVV2K1pxK0E4amtQTmtYanBQL0ZMZnJkYVJGUnYzRzZKNkQ4TVlr?=
 =?utf-8?B?aDhqdm0xa1V5cG5Semt0VVg1S2JIb016ZG1ZS01wTEtlMXlvZTJRTDR0WnVP?=
 =?utf-8?B?dmlXL3dmbklVU0pKTkNRWjBuZDBCclJTRGZONnNKZkphc2Z2QmVpeW1UUFBB?=
 =?utf-8?B?RmR0bjdEQXBrSEcza2ZaSytuZ3JWWWllRlk3TjQ3OU4zVzJRd1A1VlFVUU9r?=
 =?utf-8?B?am8zSXhoZEs5UDB2OUlGSVJLV1ZHSHJUYWV2MENwMzZMSzVlM2hKRlVETWRm?=
 =?utf-8?B?dlkxRnJKUTZyRC80Ym5mR2xMZ2FQQ01YczRkVjNCTnprNGJvaDNFcW1DV0ta?=
 =?utf-8?B?dXVjOVBpejJ2RUlsQlNJcmdMaXlScm9kdGhBQXhLUHZtSHlHNUdEMmtRc1ZG?=
 =?utf-8?B?TTBZNTAxZ3Y5Q0NpeHNLR2xxaEl1ZlFkd296NktDYTJySGY4Sks1MzBlMHhL?=
 =?utf-8?B?SHBRT3hmd0dGeXNFTGhPVFgweDRtTE5xTjJFYjNvcVVJdTJLVWlUMG02U0pD?=
 =?utf-8?Q?wJwcGeMX4pPIP0b0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190b229a-7a40-4340-c12b-08df39631a46
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB257519.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 04:29:51.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbFO/LbeloNVbpgf/HL5zjSws6QWw4X5v8leHgY/IfknKE7HOpMZDW8h3EA87NsxNTg+h3cmuoVxHwQuY9U56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164



On 02/11/26 8:50 pm, Niklas Cassel wrote:
> Hello Manikanta,
> 
> On Mon, Nov 02, 2026 at 04:44:50PM +0530, Manikanta Maddireddy wrote:
>> The PERST# assertion handler now calls pci_epc_linkdown() to notify
>> Endpoint functions before powering down the controller. This function
>> is only declared when CONFIG_PCI_ENDPOINT is enabled and has no stub
>> when endpoint support is disabled.
>>
>> Add a PCI_ENDPOINT dependency to ensure that the endpoint framework is
>> available whenever the Tegra194 PCIe driver is built.
>>
>> Fixes: bf644226574e ("PCI: tegra194: Notify Endpoint functions on PERST# assert")
> 
> Where is this SHA1? I can't seem to find it in the PCI tree.
> 
> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202610230923.2lf3BsLs-lkp@intel.com/
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V2 -> V3:
>> - New patch in v3: require PCI_ENDPOINT for pci_epc_linkdown(), added to
>>    the PERST# assertion handler, to be declared when the driver is built.
>>
>>   drivers/pci/controller/dwc/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 0a0d56fcf0ac..704134684900 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -245,6 +245,7 @@ config PCIE_TEGRA194_HOST
>>   	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
>>   	depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST
>>   	depends on PCI_MSI
>> +	depends on PCI_ENDPOINT
> 
> This looks wrong to me.
> 
> If you look at:
> include/linux/pci-epc.h
> 
> you can see that there are stubs already for e.g.:
> pci_epc_init_notify() and pci_epc_deinit_notify().
> 
> $ git grep pci_epc_init_notify
> drivers/pci/controller/cadence/pcie-cadence-ep.c:       pci_epc_init_notify(epc);
> drivers/pci/controller/dwc/pci-dra7xx.c:        pci_epc_init_notify(ep->epc);
> drivers/pci/controller/dwc/pci-imx6.c:  pci_epc_init_notify(ep->epc);
> drivers/pci/controller/dwc/pci-keystone.c:              pci_epc_init_notify(pci->ep.epc);
> drivers/pci/controller/dwc/pci-layerscape-ep.c: pci_epc_init_notify(pci->ep.epc);
> drivers/pci/controller/dwc/pcie-artpec6.c:              pci_epc_init_notify(pci->ep.epc);
> drivers/pci/controller/dwc/pcie-designware-plat.c:              pci_epc_init_notify(pci->ep.epc);
> drivers/pci/controller/dwc/pcie-dw-rockchip.c:  pci_epc_init_notify(rockchip->pci.ep.epc);
> drivers/pci/controller/dwc/pcie-keembay.c:              pci_epc_init_notify(pci->ep.epc);
> drivers/pci/controller/dwc/pcie-qcom-ep.c:      pci_epc_init_notify(pcie_ep->pci.ep.epc);
> drivers/pci/controller/dwc/pcie-rcar-gen4.c:    pci_epc_init_notify(ep->epc);
> drivers/pci/controller/dwc/pcie-stm32-ep.c:     pci_epc_init_notify(ep->epc);
> drivers/pci/controller/dwc/pcie-tegra194.c:     pci_epc_init_notify(ep->epc);
> drivers/pci/controller/dwc/pcie-uniphier-ep.c:  pci_epc_init_notify(priv->pci.ep.epc);
> drivers/pci/controller/pcie-rcar-ep.c:  pci_epc_init_notify(epc);
> drivers/pci/controller/pcie-rockchip-ep.c:      pci_epc_init_notify(epc);
> drivers/pci/endpoint/pci-epc-core.c: * pci_epc_init_notify() - Notify the EPF device that EPC device initialization
> drivers/pci/endpoint/pci-epc-core.c:void pci_epc_init_notify(struct pci_epc *epc)
> drivers/pci/endpoint/pci-epc-core.c:EXPORT_SYMBOL_GPL(pci_epc_init_notify);
> include/linux/pci-epc.h:void pci_epc_init_notify(struct pci_epc *epc);
> include/linux/pci-epc.h:static inline void pci_epc_init_notify(struct pci_epc *epc)
> 
> I suggest that you just add a stub for pci_epc_linkdown().
> 
> 
> Kind regards,
> Niklas

Ok, I will add stub function and send v4 series.
I will wait for few days for others to review v3 before sending v4.

- Manikanta

-- 
nvpublic

