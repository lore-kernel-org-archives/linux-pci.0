Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896157;
	b=ecqzSic96kXw6B25jm9SMPCDaF14i7fwcVd311dmptltt/5HDyZ4yKSTgQfLScU9CPv0
	 NRVp1Ad7by+uNzwJ8og7qwG/HYwBWzdj7i+JpiPHoQrnX/t3sC5ECi0e4Gl9lIDOFIiZw
	 rc5pjWFsnXQhhjY3LFtYQGdgZZDWkMPHrMszCJ7Knlfa7dIDig91JAvm/bXXkZ02QS58L
	 rsnzLfFJo5ijKzWAOhjv9h0yCkzPBTy5drxX5hh45Q6c/TIr7Phd18GuucJFjD7MbW1Yl
	 cDYn6Hfcbzep+WBO8SdWMVjZBI+bZCFNZ+qNKf+3FzUTx4NPyxFZNbL6nFqHfK0+SFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896157;
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
	bh=M0pQ9LC3kYRH1ywuPVXSgC9dSjcafheLeHHxpsAaAZE=;
	b=lQ+Z1Qnco5K9GzbZPxbG2sQlceGlXewVB2Bge03IRXRJOT0ZF90ziEAPF82BF5JtzSxK
	 b4K4RO0bg9cW2crXX2ChVST/30vpFRKmX8UHq6am3VyIneX7IfVfI0WeiSOBdl6G2iz3T
	 FjcZ6fYej3kaMfUyYOwsMymJmRTlWkhwb5bUzXc91Lz/xWwPivoePtOP1mZ61dDllfd8K
	 Uqgtk37NxuyMKkwPMA95bvMYlx+d+N8f+OyAW3whBFeCeTrXpYOp7xuod2jclUJxsU/al
	 wtfMcnvIQ79yZZiSL3sAVgPq0/BBkGW0heq5u2i66zvsw9rzxWQSi3T+F12CqcFPM3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GlJlGZ00;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.4
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EDE606A32D;
	Thu,  5 Nov 2026 16:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2EDE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GlJlGZ00
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0cFYrLOjS8cNX0hv8IZ6TVqg4wwzvm7PCDygQbyoimxtO2ed4Ron+BLEAqJS1T78Snv5LyWz5kJ0aQCQKaGnFw4F3IRKjkFA3df3QOi1sqTRw7xcti0tfMoOGNzVg22XfGQJVseqDx60RGmEW89TwPZ/toJhlyj54fWDo37zGfVtIUAeU8rpoeTVUUJ4m+tchhZ4n1QcUZAgj4siIyGZtG1a2BicVWTj78Euhj9ytE/kp6x995NhyeySnqoNH6EIPN3o/3tQx6xiBl1FRNarutHnfr+x3tRsQWPXoeb5T9fpiG1no1cU3+LEwj+PowKAhCD9zNqTSEQ5FzbMU2rMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0pQ9LC3kYRH1ywuPVXSgC9dSjcafheLeHHxpsAaAZE=;
 b=y1ZoRj1kKxukCyZ8ZwEn8zV9DWQI8ZjRtp4GoI4e+IrwiTeMydIZ64ZvqW59Xsyx40ebVG4pOuZ0dtcC9faba/Xh+XEUy9+eoLTv1cCP3Y34uP1FQz16VjOVV6WKTBQIzZWOMI5KDrCahsKGR1gRCpCEOZiYBlFng9pCt0+9Ibyr06nZDd6KZ2PYv0pNTU0JmLaypJM40G6Zqt4NIPcA4AY0zea27C/zo/daup1s2v+BCyQOWCXNsbrmxOy091c6RXCy1ubtTQsDkxy/kD9f3xAsVqm6FBik4MPDgLleFj/OOzPDbRP+rYQ9Go/bJSrSdm8K7hLDPgSZc0qxhg2g3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0pQ9LC3kYRH1ywuPVXSgC9dSjcafheLeHHxpsAaAZE=;
 b=GlJlGZ00RHxMy176Kvows3JQLFvqYtgzNr0B3mP76toxCwPwbAj60qOhDXSGXjn5JwdfQxrTJHdoV7Sjc3rbkFvRuh0UgzQ2vXNQsVDsOfscdDLxIfikhRjgYu3rK5eDxBM2tWAiICSP+twZPmKv64T34cLCNgBerH0WhZPsxW4iVaycoyECnjzIHsqpQvwEJD7RVH26tUbG3AlDx1aeSOeONMocih2feYT811bNXAxLkqiXzNoBypE7m/Jrtx3D8R8S41rYrWRV/s264R/qftLxqy/9e8g70QBemqkkCyI50vPFqtpiL0DWtx4uURd45kPwva+yObZ3BcLhxXWe1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MN2PR12MB4358.namprd12.prod.outlook.com
 (2603:10b6:208:24f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:28:36 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:28:36 +0000
Message-ID: <a7faa147-8df5-4034-a4ab-5540adce9ede@nvidia.com>
Date: Thu, 5 Nov 2026 08:28:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 13/18] cxl: Validate and synchronize HDM ranges around
 reset
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-14-smadhavan@nvidia.com>
 <auQRSOGWEDzB_qjF@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auQRSOGWEDzB_qjF@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 888c7132-67b1-473f-c499-08df3b59d771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|10067099003|4143699003|5023799004|11063799006|261022105027099003|261026121527099003|56012099006|261028144727099003|261102123227099003|261021121427099003|261026140227099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	9iHMDcakpiFY2oqjmq7+7O6KdupVuvDa+Uu7hVxpJgXOZebrE2sERxhQZyNXapIVWjklcRk1Ke51J0Yzzg/kd+DVgoVKf5BqxReo3TET6scokM/Li825yys532/axel5YdwkeX5tr+5QF1vWMCPBEi6DXSCfNsUgGi/Gye8HSB/w17dXkrNISzwyz2bWKMbaJQKco9ek7TRMQg0MufrguIMdVQcG0aWvVH2l3NDqvB10/s4kfCQ0PtThhLngx7Yqw//YmvZmSuQMuvNm8x1A1Qa0O2L2Ps97Xa9ALb/ZnX/WyNl1xLULpEqZRYxqNbh17Szw+4Eh6akO9e6v6j1W3LoP/Rs5FSKaIV6JTU0Nc6Xz/ePKKnSBJa+8LIGcQ7+TRsmLfZySNuuQI8CH0Y/vCq5cy8BDYZ8dMLQd8Cx4u+tTsUu60ziC5oBljHcfSJb4ggqEX8TjNwiL3SNMrwfbdIpR8JvuhmqeGtrfhnK27y9PhTVS15uIGnICEVNwC5FX6ci58cleozrYa6uWalK228xzNDBdYBohZqNVDovsx5kh9C7Ls0a2L32WPXXmiK66mT1iuezwggifAh7p62tCdUraSC2cxNkzqGLhoQ+ifUHx6XNT++WqvawhMARppZ6t/mhQBRN6D/WJWIBWh6/RXnDpLfwpY/hlEf1v8zGs6r0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(5023799004)(11063799006)(261022105027099003)(261026121527099003)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnpyUlZDTjhjR0d3bVZvVjc1RmgwVm1rK3BOSkpBYzA4MkRWZTQxN0VLQUdu?=
 =?utf-8?B?bmxpQjNxNW9UdWs3WW9IdXVBZnFQTE1JdDdWVXhJWlJZRXI4TWM1ZEVDeC9G?=
 =?utf-8?B?cjh0aTZKU283eEU2bWdvclhMNHZuYnlwanpRc2RWSkZpbmk1SEtRUDU1eTFK?=
 =?utf-8?B?YmJ6U1lhbzhmRTNhbTN0S0VwcWY3Q0NEYURwdG14RGFCNWV2TWx0V1cxMWIv?=
 =?utf-8?B?cHpTODg1eTBLd1FFMXIvSzVWUkRIWGI3WXJmL3l1U1BSSFNxT3NZMWRCQjRj?=
 =?utf-8?B?OHMzeWJ1Y1BxWC9yK0NZZlVHMGd2UzdBRjhGa0t0Snhzek8ySWY2ZkszNks5?=
 =?utf-8?B?cDU0Q3MwRkF1aVVkcGpBZXQ4Y1IvWTc4UW1paTNCMlpBZnBuUUsvQTlJNlAw?=
 =?utf-8?B?RUx5ZGxPenBDRlFJRmtVajZJNzI1QWJqSmFNdjgwKzNYSVBWU3RGd0dTS044?=
 =?utf-8?B?NjJRMlh2aTAzV3didnpsVzlqMStaY3JNSEg0TE1pUHN3bDZhT0M0MWRZZHNY?=
 =?utf-8?B?bG8zZk1YSURSb0xLTzJ3Mis5am13SWxQZldXVEhhc2JGN1llNmJNTGVtWEZT?=
 =?utf-8?B?cEpBRjdvOUxpVzRuMFpzUmtrdy8zWFJqWW5kUVpla1pOczl4RHh4Nk1xdC9p?=
 =?utf-8?B?U0xaMisvMUtUVWdtM3RFb3V1YU45K0p2RzZWTm1iQzdkVUcrMjJIeE1YRG1U?=
 =?utf-8?B?aitnY0dtK0RyalNSRE5OaExaejUxenNzbGlHajlBVEt2UlZZLzNBQlU0c0gr?=
 =?utf-8?B?b3ZTMTF0UjRWWHNyR3BrdXUvdGd5dXE0VmM2TC9IT3BpRXJBUUZ1aUJjOHBs?=
 =?utf-8?B?MzZOdUtxc2M0aEhtaFBpOGxsdFQrQUg3REhlUVZvVmszWmlpRDRhVlBCMnk3?=
 =?utf-8?B?RnluODd4amtndDU0cGRkUWhETXVYYTVjUzhFSGRVVzVYKzNyU3NlUzhyckZs?=
 =?utf-8?B?ZFA5UlBMWCs4eGwvbXNzMndjeWpQYzRyOWJneUtwWHU4aDFpTHZub1ZEVlJp?=
 =?utf-8?B?M3RyT2Znd0RudGU3MlJKWnh2ZGtkcnFoRUhYS3R6RkV2WWR5eDhqNm11dkcy?=
 =?utf-8?B?cVlodlB0bjJXVGxqNTRTQ2tNV2tDRG5iK0lWZGhJMlhvVjFKOG5YOUErd0FV?=
 =?utf-8?B?akIwSHovVU02dGE3Uzh1ZUZnUHg5TlE2VVF0dTRnVHN2M1VvNS9ZMjQ0NXg1?=
 =?utf-8?B?bjNCSnZ0Z1NJSlJjaDhoU3lPNG83bVdwdkNVSGhmK3R4UXJRWlNxM1ZzNTdZ?=
 =?utf-8?B?dGhHYTVnRFN6MUtnK0lhVlFWR01VMElCZXJidnN6eFdJTCtydnVVdEtxSm9Q?=
 =?utf-8?B?SmIxeFk4eElzdFUva3czV01BakRNMDUrZlNYZ1hwVGlObWJiUWVnZ0NtNUNT?=
 =?utf-8?B?TWZUQ2dDUUg4Um1mYVlDWFNDbXh3NHNwTEtpdldzaG9YcHB2cTJkVmtzdUYr?=
 =?utf-8?B?MkpFVUdDc3ZmUG0zUzFTYXVPQmZWb1Q3TUN3cWwwT3FZcGs5UE8zeCtyd0h5?=
 =?utf-8?B?ZEwrQ3h1TTE5YVptOHp3ZE5xU05hV0Ryc2hpUldQdk5XVmd4VHNDOEc5TTNa?=
 =?utf-8?B?VGhyME5pcTI4bWdmc1l4eHN3MnJGT0dCRVdYR2I1SSsyTG45YXZmVXpWUURv?=
 =?utf-8?B?TmpLcFBhcUJyd2o0MkxnQzNuWVBrM3J2MEYxMnd0SjFHRlpVQ056SlRqcDdS?=
 =?utf-8?B?ZndTTm9PbFVaMGswQzc5ckIzMFVpeDdCeUgrVlJlY0RFNklBRmpDaGRsS2wz?=
 =?utf-8?B?RHJieTdGTWk3Zlo1YkNTRTJJMk5DajV1NFJFVi9DQWJUSXhOUzJucFRFRzRB?=
 =?utf-8?B?a1MxWUxtdEVsVHJHVVNuTi9hYnVzVFkvZThiVGNkbzhEcmpIbE8xNGl3Y0M4?=
 =?utf-8?B?T0N1U2R1OG95cjI0cklqaWh0QUE0dXgvYklBcitVVzA2SkdadnErTFVTZVhw?=
 =?utf-8?B?SWFBajVqaElhMXNjUXBFQlM3V2xLZWlLYjAxc2hRc1JMTnNrWTJ5S3YxemZp?=
 =?utf-8?B?bCsxZC9sUm1OdXR4T3dnUGs3allnS0tGT1huOGFKclZoZFQ3eStNQzhndTlH?=
 =?utf-8?B?bjdObmVJVHdKVml1Ri9Ic21zQjU5NVVKVUlNclhwRFBpT1pRc3Y5bzZIVUJo?=
 =?utf-8?B?U0diWTh5NU9nNXZ6RXpmRjdVUXBab1pqWkdNRmxsTzM0aUEyQ3RHV1RPakFt?=
 =?utf-8?B?eWJZZ3VxN3Yvb0JSc2hSTzVVdFk4dzcyY3J1dVZ2MHJDQUxVc0tYNTlhKzhH?=
 =?utf-8?B?M0d4dWRBbklSWmpzZFAzanlYNWVpTEc5Tzhod2dwZHZ5UFZ6NnY4STIvZERq?=
 =?utf-8?B?eDRrczllanVmS2Rnd25ESzE2aWNVYVpVQloyN2JOYU1mRVZveWFzQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888c7132-67b1-473f-c499-08df3b59d771
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:28:36.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnCphDhIRc0F4v9YrYcYJT6SWs6njsQ3guuxL1/DCAngItS/Er4CBgEG1RBoLUMGUBaTJT+5McHh0i/iYazRJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358

On 10/29/26 8:45 PM, Richard Cheng wrote:
>> +static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
>> +{
>> +	struct cxl_hdm_range *range;
>> +
>> +	lockdep_assert_held_write(&cxl_rwsem.region);
>> +
>> +	list_for_each_entry(range, &q->ranges, list) {
>> +		const struct range *hpa_range = &range->hpa_range;
>> +
>> +		range->res = request_mem_region(hpa_range->start, range->len,
>> +						"cxl_reset");
>> +		if (!range->res)
>> +			return -EBUSY;
>> +	}
>> +
> Hi Srirangan,
> 
> The spec explicitly requires no outstanding or new CXL.mem transaction after
> the affected HDM ranges are offlined.
> 
> For this part, I don't see any guarantee that a successful request_mem_region()
> means all outstanding memory access have stopped and no new access can occur.
> 
> I see you refuse to reset when resource reservation conflict, but nothing
> offline memory or directly stop CXL.mem traffic.
> 
> I wonder if the implementation provide enough evidence that when request_mem_region()
> success means no new mem access or CXL.mem traffic will pop up ?
> 
> Best regards,
> Richard Cheng.

Hi Richard,

You are right that a successful request_mem_region() does not show that 
no CXL.mem traffic can occur. The design expects userspace to offline 
CXL.mem users before reset, as discussed earlier. The reservation
enforces that for claimed ranges: the reset fails while a conflicting
resource is claimed, and nobody can claim the range during the reset.

It cannot see code that uses the range without claiming it. That case is
also covered by the offline expectation, not by the reservation. I added
this to the patch 13 commit message in v17 instead of leaving it implicit.

-- 
Regards,
Srirangan
