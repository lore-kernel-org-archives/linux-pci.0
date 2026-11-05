Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905803;
	b=VwFLSm5RdTK6uS9j+IKNszG86Z3TkvxFbUvrVWniSmHom+OfJZRqKCcV+t5ZOb48/o4H
	 S/yC050h0BGwqyodkrxRKh9l4WI+oVov1KqPGEjm2UX65MoZo1C0ypj3K3SZoFcQBC2KX
	 MyhoWI4oaAzK7o8lhrjeyilMMuCYehiPUflJKhSXV/bxVCx7ryv4gC/0BOcL/NpFZi6Uv
	 s14QluHy0fnOXc2N+kUf6BbKrIgRAXqJu+0zVBlQXs/b0CGIAGYqa9snhsPaqcPwM8iRj
	 KZvGlC/icSQJgeVnqZUqSLHnikOGxPBRfq+vrh7ceMMK0KJxmbW0wcsslBjrlB5T0ZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905803;
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
	bh=mlUQcdgEOnuS03PHM+i9afbfgVK8KHwDLKSkYINMR3g=;
	b=Zvd2U75BIQpubacEaSypnEzruinQsVIiAeTAB+KPsjZto+T1LHBbLqNY3ZTKCJQtRyJF
	 wMmchiY37OFdBD5rmwrXgYcIBcSSLSISualepHmmVdwMGL5oB1BvSbI4+3iHaWT79kLde
	 LmxRinJPnSYvqf3U4SsR19nZFhoDylcJ70ukQ93HOxWoWdElHf1h5hCPyncD3CFkb1Qf8
	 HiJwx57QCbmTZDKdzHLz1rhFOSLsnWsgBrij6GsOhMWmS3Un8o9zREZQ5ZtbDz3IKfwQ2
	 S31Pjd2HNhoMXqlgx1KIzvNfRDlNuE1SSXiGn9lfQrzL67JuBGn54dLmc1HTdmtIU3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="n/0n6LTG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.52
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA18606A31B;
	Thu,  5 Nov 2026 19:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA18606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n/0n6LTG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mesvWRFLdgJjXGkmBI8FdhWURSzX7bETbgmAZRg45//NScJXjQpHzNupVWVCzCQRUHk8WSL1opxZjrqO5/1BJumaq8nzurmXkNHzo+xoF4LFM6KHaVV+3SuwU2X4GS3ktHBvq4hkrbGOJbT/VIGuF3F0MQMeLEDr9Jf1DPWrbkVJrlyRgfjqf3UeXmVSyCKuWM8Ra1EIwds0VAlkI69iPkhAwA5Nqm62TCxXnhQHc7xCBhoxz+X+dnQ7pE1PUn6JCtpIgtmlNFt2RLtc/d0CVhRyu22suhK4XspyrMiCe2JdLEEFQwSps2UV4MZjnQ3kIZ4Mq7nb93587qxHIfYLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlUQcdgEOnuS03PHM+i9afbfgVK8KHwDLKSkYINMR3g=;
 b=S6VnJjaRbjeDn2Sa5Yr3NrEhRDBYQ0CayMKLeLo2A4DcSkF9kjhjPurtLzyHAcnkVE7MfxcPVT8ie2gMcnElFewt57RcNBvW0QOh3D7Qr+7+B9d35byLfNNIMUqFChg/raZF+UbbXHtSlRLQiAvNhKsucfWwy/c4627ibLc3hxjWQrhDe2vhf87nTr5nafQUk/nSKo8gDJnm3K3T2J565ClFxiup9SQGryE1cbjmMAxtWBJMukpcQNLfrBiZSXa8SO9lJl4a4qh+icN4eF2QV0eBlupD7eDv0xAaeXoeKP4dYbvBsZZrucDRvpS4h/M2y3nRRRwdR4OXwHyclIcQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlUQcdgEOnuS03PHM+i9afbfgVK8KHwDLKSkYINMR3g=;
 b=n/0n6LTGc4lNZyovnjB8fhofCaCUrtTYZnaQCN4zUBmiuiiAddVhI5Y9IQNy47M187zarUuJAFcLnORRB3iPH8jqQeFlx9dy1F1GA9AF2+hdEIUkJzMOEPk5Nd6UBnFwbpsK6nkgeu8n6dukIYSzET/nlgG+oKRUBei/u2crTFlcq76xtcmY8nOSt/tG7p54hOoTI9xV0Am6dvrEBKLoMa3clZ/8ldgTVVgKNd0BHejVIr0iNM86igoDbgj5TXADnFf0QrB4kJ7YF2T0oFUH5oTgH7siYxQ1HpKy6scen5FKdj4ocYP1q2Rqh+j+GWlohVVukzxy84sGeEQKVeP2cw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SN7PR12MB7884.namprd12.prod.outlook.com
 (2603:10b6:806:343::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:09:49 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:09:49 +0000
Message-ID: <e05d04f4-a5d5-426b-b6e2-59eef53c277b@nvidia.com>
Date: Thu, 5 Nov 2026 11:09:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/18] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <auOXW3BTb8CYIh4m@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auOXW3BTb8CYIh4m@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::13) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: dea930d2-ecb4-428f-ed49-08df3b705cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|5023799004|4143699003|11063799006|261028144727099003|261009223027099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	jv4h0/ZFoYuUY/TzYaNxDyCOijr6M1X+uue3RssI0uHY89Ic8ED6tGjRSRz+WiXqe1dW+cstZ+dNM49sRE5Rr3z7+R25T4zTX/G7QK6aB30/J32Aq7ps6PdNrFQqIHRNJvZO5pMEPZm8lukEA4IvL7G9WbyO55OZzO8eAQA93UgaYdmXC5IPz1MkP5UmqNqDlPh55kfxGCVyVjM9PXAaqNgl2/UDWknF7fROcWTZB5XrATrvWJuh4dpJH/Wx2jyWlC+LbIhewS3/dVnZ6JLAtpfO8JUDhOz8aga67n/B92WENF0q7b34TGl3D0z7rJuV956ICvYrY219YEUsTNOa89x2U3aJxupzCJESV9RLy3U0WXnywednO7G3kjDhYhm6l6GqTo5J/5O6ZvsIzwANXJwvNZIkszqyW18p0PS1fqzak6JA2VrWBTcOuAN8hWsOW+1h8A8282F7FqI/ZccFGPaFfga9JT4SG+WEJoiFidW0C/vDPMpMS187i+TSoXNDMIVMRMSjH33Ti4e8BDUweRvxuqKbbXjNmgbOeCB+pBJQns6VSBfl/45JQviTJ6+uVGdvnlYEEIA+4aNQPotg2Hmm8fPjHZpx0iwAsLSOWufrg9effl4FnHLni+HED35ECPppLrjf3MSREl3Jw7niobO29/Xa1Rp1Gl1c+U+kWXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003)(11063799006)(261028144727099003)(261009223027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTUwa0RwODV2NzJnUlpubHdCejdQTEJyUStST1dhODhxaCtyQm5SVkJwMXlv?=
 =?utf-8?B?ODNsYWNCNTNpMUJRcjh3SUliWkJkUk10WmdGK0FGQWMzeXJ2UFBKZHFKcUNC?=
 =?utf-8?B?TjU5STkxNnZlOHgzQ1FmQ3ZHUVhMYUNCbncrUlpEUVVReFV5Q2JlUUdNdXNH?=
 =?utf-8?B?RVdZOHdrZ2N0U0hKaW5VdWZhQk5lWDlBV0FJdHFZVjRwQ0dadlA0TjNVWHRT?=
 =?utf-8?B?YkQ3b0RpLzVpNVQ2QkhzMys4bGR5V0duSEY3VUpvaVovYWVoK3RzbSs3WUMx?=
 =?utf-8?B?Nnp2UkRZaTF2K1ZiN29vZk5oUFlkeXkzb2NvTlErK2NKbC95SW1BY3Z3V3FY?=
 =?utf-8?B?dmpDNkVrSEM5WmtGaFZWSzMwNEpsdVMrSXVBNlVkU2g4NG1ra2t4cDJYSVZh?=
 =?utf-8?B?djM3YWhkZG80VG1SU0FlSlF5KzhHblhkK1VqbEtMQ2dCakFIQm1LS2R3SjNX?=
 =?utf-8?B?bWw3Ulo0ZWtOcE1MOGFBTHV1MG1pZ1M0VnFtZkl5anJBVjVzK3lXdGIzWkwz?=
 =?utf-8?B?cktSSXpYY2xqdHlGaTlsMGxRUUFMYUg1VjNMOUluRmduV3lhcmVoVjRXeHlJ?=
 =?utf-8?B?SjljVytvVG1vWVV6UE93OW1ZbHhvdmRKeVB0MU1ZdC8yVFpDZU9jODYySW80?=
 =?utf-8?B?dkNYcXJnaGF2Wkg1YjJnZnR2NzM4VjJsandaVmY0ekN5VWJTaTBTaTU2Yld2?=
 =?utf-8?B?VHV5Z09SZTRUUUJ1dFZsaUVqY0pSTVpCdzZXeTJqbkJBNzNZeHAvS044SHlJ?=
 =?utf-8?B?cXJLK0JjUXFxZHhHaVFBUklxcmxKVjRpbmM5cDlHY3p1Q3NvbWN6QThCVFNw?=
 =?utf-8?B?cWdhbHRMNTNZdUtVVDNnd0FFNUpWUkR3SzNIbnBBbUQ5aFRxV3hheFJmUFpr?=
 =?utf-8?B?VGNMNVZzelBGcC9sWFYxaStiWE1uWkZuaTBhd0NqN01YQ1RJOFl1U1dDNXNw?=
 =?utf-8?B?QVZXUDVzOHQ2SkUyZnp4TzZoWDBURnVybDFveHVtRlQ3azNVTGxKNm9qb2Iz?=
 =?utf-8?B?NklFR0tvcjJYZ2FYU3l4RkhWOXhwdnQyd0ZrbGpVZWVhOUlIVXpRS0F0MkVY?=
 =?utf-8?B?VDVlWVBhTkUzTll5WWlJZmNndjc2MldnT0JRUHZQaHBGZDdTQjROMEYxa3Fn?=
 =?utf-8?B?SU53RFRiejhOUHpTN21JVkkva3Z5SW5FZlVySHJseWxnV2VYUnlEQTdKTkx5?=
 =?utf-8?B?MUt0ZVlaNktobVF4V0xiMlJjZlBqWVpTZW5uTlhiRUVLRVBzM0JWSkx6dGZO?=
 =?utf-8?B?V0ZaU0J4ZkpWdG84cXh5SnBXdzg5a1FFMDIwUTZ4OG1ObkM2Z2VpQU9SbWph?=
 =?utf-8?B?RURoQkxXaU0vTHJjNzd6TnFMOFRIUmIwR2tYejBGM0t6MnVjanE3NStJellu?=
 =?utf-8?B?NGVNVml5bHJLb0VtWEZrMmR1V09Kb3VQUFZRcisrWXJjclFmdU9DaFVqODFj?=
 =?utf-8?B?UjU5T0h0aHVQcUZqQ2dDWmc2SS9IQWI3SEVYU1R3Y0k5UkQ2WTk3TDZnbi90?=
 =?utf-8?B?RmFVeFBKQjZGeVJBWWNhS2R5aEFMYVhiU0M0bFFQVThtYWRaQ1EvMmlVRS83?=
 =?utf-8?B?dW9MQ2IycXpGR0NBNTR3bmFsNXo0UTJoRm5HMmxmRDZHN2V1OWs5SUFGak9Q?=
 =?utf-8?B?cTVwS3U0dUhLTXN1WTZ4a29Va2ZBbWRWb1RscDBiNzVURm8wQ1ZlN0xhN2Ny?=
 =?utf-8?B?dHZHbllwV0c3cms4V0ZjcHFEbzF0d0xiQWx1bjUydXFmRXJPajF0MGtSNCtS?=
 =?utf-8?B?WUhuM203bWhmUmc4QXhsSVV2ZVJZUXFmWXFpMTl1TytibG00bGxYVFhoYXp6?=
 =?utf-8?B?bVdmMENIMVhiM05vZEpPU1ZZazdYa0QxQVBLaHZyZS9Dc3ROcjBaYXhNY0FG?=
 =?utf-8?B?M2Y5RjNRSHZ4RXptdTFpTiszQS9ySzB4dDBNcVQ1UzVFSmNuMVZYb2w0MTJj?=
 =?utf-8?B?b2JaVDVOWHE1ckVOSDlzYVJzcmRXV0R0RTMxcXA0aC9ERUlKUEExMi9VTlpB?=
 =?utf-8?B?OE9DZVZXTWQ3ZEVpL2xEODh5NFliWHA2TWVOL0dINDFlSUZQd1JOMUtkWTVY?=
 =?utf-8?B?SlRkNFRRRFBNVjkrQ1RqSWdVN216V043bDNSbmJ3dW5JSjZoaTRMcGpSQTVy?=
 =?utf-8?B?TWtvNlgyM3lqdTYvTGo4V1NnV0t5V1pXallISlpDNTZ4RzZHUEZkMVY1eU4x?=
 =?utf-8?B?WDNrRHZmU1NqMzZZMXBzSzl2TS92N1YvSGZGWmlvdFhOdFJQYjFuaDBXM2Rl?=
 =?utf-8?B?aXVFWStLSjNsRW8yMXNnKzBYbUxVb3JHMnV3TVpGdGVJT0JYbzNpZGRoYyts?=
 =?utf-8?B?a2tZQUNVNWtobm43REVsbkZYSHQvaUFLRG1LS3g3azZ6NWhYZFNzZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea930d2-ecb4-428f-ed49-08df3b705cfe
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:09:49.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K60D3F3cHJ/c6CaECvT++Od7mNwY7etAf129dxWeXuTAZY3wam8DJzD/iaZpdluqqHOYtS95jKUnCZhC3TVtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

On 10/29/26 11:58 AM, Alison Schofield wrote:
>> Userspace selects "cxl_reset" in reset_method and triggers the reset
>> through reset. Following Dan's v6 feedback, this uses the PCI interface
>> instead of adding a memdev-specific sysfs ABI.
>>
>> For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
>> callback when provided and disables PCI I/O, memory decoding, and bus
>> mastering. The CXL path reserves affected HDM ranges exclusively and
>> blocks IOMMU translations where applicable. It does not offline memory
>> or revoke mappings; it relies on CXL.mem users retaining conflicting
>> iomem resources while access remains active.
>>
>> Changes from v15 [1]:
> 
> Srirangan,
> 
> I notice you posted this v16 without responding to review feedback on v15.
> 
> I've already compared v15 and v16 to see which review comments were addressed.
> However, that exercise is no substitute for responding to reviewers and
> resolving the discussions they initiate. Rather than me repeating the
> outstanding comments from v15, in v16, can you go back and respond to the v15
> reviews before we proceed?
> 
> Reference is the guidance in Documentation/process/submitting-patches.rst,
> under "Respond to review comments". CXL subsystem contributors also often
> append the reviewer's name to the end of each changelog item to identify
> whose feedback prompted the change.
> 
> Thanks,
> Alison

Hi Alison,

Following up now that I sent v17 out. I replied to the v15 comments, and 
each v17 changelog item ends with the name of the reviewer whose 
feedback prompted it, with links to the comments in the per-patch notes.

Two v15 discussions are still open and are noted in the cover letter: 
the scope of the region lock, and the attribution for Dave's reference 
branch. Please let me know if anything is missing.

-- 
Regards,
Srirangan
