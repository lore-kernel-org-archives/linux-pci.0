Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793321317;
	b=Ks5EzgZ96xA9e1jLzqRcH8mwtUqdniohFTa4VDlVdKd2zldtVIHsGrj+ICjuj5QdLAYG
	 hVSZ229Efaimq3Bla+zPtItYqBsDSs5BY83SwsF5NliW0u1Ak06z5DOyu+RmWb7ZzW5iz
	 j9SL2eeN85wgGjsRoPl/HDNFExaB72czwggX1RepswwZzFkJMalE27tgibxcuPuwlWhYl
	 WSYju59GfhWbJrSnv1pykgs4qP8z2+LSt5asnLpssVqYvyHJ278OQ6XrLZ/R3p14mTO3a
	 c2xct/s5zdxF5Js+KutdFG8A/r4iy3UKBQofZYP8i39ldDjuCmI1szeY9a+ma+G956A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321317;
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
	bh=IJPQdhmRsSlaamGkMfiLRnlmBo4pBG/G/o+eqj/+dB4=;
	b=0cWzpVRpInke4A3F+ptwhMKJHjEHXP3IhPbRN+hpprAq44Vh7lkG55VSU+6FoEA/RyEy
	 9EwFt1q2tKIMQJbkGBaPFd8C8ZsGDOVi78ZNgE6mm9L8tTEsw62pTF0RmsM9OQe+n5jbO
	 JeASpW7oZ0vu31bB9AwSGYEtx/N4A/gc5KpBVY3IV9/hU4O5vp0ZSzapP+VdBSEF4NIXQ
	 uD0IO50e0WB4CwwfjthWOdUY/wGXsd3mAXY12bSO4LxCiMAHU1cQZHYCz0oEYIONTkqWl
	 tiMRf2KybIXrvW56kaN1i3qnmNqojpku3rlb20aONaXWdTU9we1ECyFQGsytX5IHRmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UMLVpGR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.41
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F7606A31A;
	Fri, 30 Oct 2026 00:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F0F7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UMLVpGR3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4dBekfizm4aC/Nd4viVNUkplpwSEiLnocyWdEjqYN9ZJy/GEqu6NrnrGqKAWbvmhAb7vNAtMB/IDPtyE5ESAgrchEwLfDJRvBwKRqk3oQoS/NxYtXhYrO0W8U8plWzNTLmQ9uYCjCPdznL8XzErnH7TicWMhzPg30BIKfp0N+j8flGYac1MZ16veeRz/w3Qwqp3pOUW14eRsJ/ovEzV7ddWtR3xY8YAzMl7maEfN03cOh2P0uJwMvxGR0WhCUvtuZVCf637qJI5GWsUfsirQXsQySbSzcABrwK65tS27bdmUZUd/YZIIlJ52+cxwz/WwLp36xrpFFc97t+eyeYZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJPQdhmRsSlaamGkMfiLRnlmBo4pBG/G/o+eqj/+dB4=;
 b=UQbJNgay1bQsZ2a7QAx5Q/OajAbclHt/qzsNI3BYIV/CZyVr7MrukbNOzJUy5JjeKgfgMl38Jk2BwNnh21KAROkAMAng9+AyDRpze4x41DQhOtN0rxeGF6rO/KqzKgLTybjOhqAuApCteXCmLmO/Y3rF0FGHhKUkiO2bh58+rffiJ5TzfXtpDM/38G6l6nSkoCZfUVAtTd8Nre9jlS6jYbFJXUI2RC3Lo0TvpxmyrRyzKvZM5XrUtekknFhpWbUULnCMv4s4cQ6e6yJK2xeLiTpUB9fiPBQfyB58YG9VVQ1RP7K7APDKH0F3vud97ehhhlPPqp0nFdwr4GEiSRKHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJPQdhmRsSlaamGkMfiLRnlmBo4pBG/G/o+eqj/+dB4=;
 b=UMLVpGR32NoS0M989QbMacU9lhKShDfKtBE4LHa5f9kgbiQVt2c/8Hbm2iMbR7cbyPuHnIxWCoK7QYrRpodtQ9szxA+XBoZTNDdTKEA4MC4kbucPpmw+iEqKAdaY9Zy9acqHgAAI39J2CXV4qkMTXMCNAJZuE+5a0NAaCBjzojFKYNb/9Mvk++gX7D3kJs4mQmF4KSAsUpoL/vDTCofa88OMAplJhRnsAUbaUnSKzbKQKfS4c9f+uAXtbI6wUi5Rju8MY6XczRJ9hY6SRUFJ7INPt8Txvm/CkPCl4gle2aYj+XXvxc4gDRi8IllMDWyCkRwKzz7bj23bDnNXyycanQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 00:48:34 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 00:48:34 +0000
Message-ID: <7150bdde-f328-41a5-ae00-b30218c241fa@nvidia.com>
Date: Thu, 29 Oct 2026 17:48:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 16/16] tools/testing/cxl: Add HDM decoder range checks
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-17-smadhavan@nvidia.com>
 <auAPTn-iZCFGqDfV@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auAPTn-iZCFGqDfV@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::9) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA3PR12MB598757:EE_
X-MS-Office365-Filtering-Correlation-Id: b76b12d5-5b10-4999-84c2-08df361f867b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|261022075727099003|261028144727099003|10067099003|261021121427099003|261021135927099003|261026121527099003|261022105027099003|261026140227099003|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	xec9biAJd6YsLzuKMW5htNfUYCmmI7KbKf1gc4kuZ0u2qc1f+IZmmjhvDjf7/vzJnZuyxbANRLSVkzsF5xlby5dnymhk2dFxiSgMKKfWYVTPfX3JJMBJS5YH5j9zPaiPQF51vtzfy+4O/A65OuBYSpeDZi3o1Q6gAxRMkUS8QhYd8arqAwpvuriS6vJqCZwRoIagXy7xkFxvbcbZ8SYDyMeXas/YbTkyGuSF8N9+qhyJGmFmCWBxDoCLzJfUg0OIP7pR3zqSLcqetRBSUe8qnkUaEjdVAfv85uPNIfzr0cXyo8ZemOKYkydr4THddgFlJDFzKL0iDdniZg62iYxuekv5rVgQcKYJVV5Rzz9IviHzbEm9jkVLFNtFSSOu1JfSDYGFwo4moRLODS0Ucum/FhEZjdatpeo5BvZHHunA1BGmPQmJp4K+ugR6wA3J2DsZvlDAuBf0k40H/aZrFk8W1+I8F65xvKgVYGucc8WevTlX+eaoFquvQjseK1SEX0UaA09tNerhsqTYBhYsslIEjeWTAZ+P5JmLMjgNqHp4Funf9BiLT0QuqFeK8DZ+Umpc9m77vqQL9G4zjgsE5YV26ttqRQuUHjA4MB1x37Amgf1PWDs81rfeCw+uG4gCVJ9bQK2h7TzU35mwTxoPDIkj9I0kVjE5tDuYT4+w5dtv/yc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022075727099003)(261028144727099003)(10067099003)(261021121427099003)(261021135927099003)(261026121527099003)(261022105027099003)(261026140227099003)(260925021911599003)(260925022911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk1oTGZzMzNsVlNodGhsQlVCa1ZhMm1rbzI0ZFVTNHNlMG9JRmpGd3BjQ3J1?=
 =?utf-8?B?OEozTS96YTNqUzZHS1JublNUR3JTa01JekpyOVp6bkZNYTVXdGQyaGtrTXJR?=
 =?utf-8?B?VU0yanFwTTZvbEFZRXE4Z1NzNEl0ZTF5NFZvMmZXSVRNU1NrNXZQQjNZVk9S?=
 =?utf-8?B?M3F3RHBoZTlKaGN1dzFVYnlaZ1gzSCtKNE1mRkcrNFZFS3dZa0RPcm4vbHRr?=
 =?utf-8?B?QWNveXJGYWhFYUpJTjh0enRVR3cyUDhPOU1Eb1pkeFdnOFRFNHRhRjU1WTkw?=
 =?utf-8?B?RTNYWStFN1JlcDNoR0RnbHFZS3lmanJZdTRqTzVhd0hzTzNGOHBqcHI2S2o0?=
 =?utf-8?B?Yld0cUU0UC8reElvWUJFRmR1TURwblFBK3FBSVovZm5RcFFyTFlybkFTRE9t?=
 =?utf-8?B?d3YxNDd4Zk1wcE92bHBiMndVKzlBSXRMMExaemRsTDJqYVArQzJoZzRNQjhj?=
 =?utf-8?B?OSt3dmxwU3ExRTVIb1pEU2ZyS2I1NTJ2YUM4NGhyM1RDSDRZN1dBdlpTWTFR?=
 =?utf-8?B?SkFKMWV1eDlOVWFFeDY4eWhQaDg5bkRiWEtwU3lIcGtPUDd6OGRmeVBCSWJC?=
 =?utf-8?B?T1U4QUR4MTYyK09JYmRVKysxRklDQXBsdmtpcVQ2S21BY1hSY3p5M0k0aVhy?=
 =?utf-8?B?MjkvT2NOOW84WkZTdll3dVhWazNBbGJKZXpxbGRWOE1CMzNmYjQzUVRuQmlh?=
 =?utf-8?B?bnpwcnhzeGVESXo0aVlWWHVTNGRRVWpWU1FsT0JhUEpWc0x2SWhEN25nMkhp?=
 =?utf-8?B?d1NXRHB2cWVVb2ZXd083SkN5Q0ZKVWFaSklpaThFVFVnSG43L0ZaMVJESVFK?=
 =?utf-8?B?b3NnYlozREJJK0F4U24wdFNpQkswOUhGb0doRnZHRWRuL0kxNTRuZHZ1UW5B?=
 =?utf-8?B?ZzhONksyNlpkTEVpcExYeWxHaXg2UjI0TzJKY0Vjd0R5VXdCQmMzQ2hFMlds?=
 =?utf-8?B?YVBFMi9xQ3JUTmh2VmtzL2dldkxNckMvRUI4NEF5Szk2VUkrelF5U2lERUhR?=
 =?utf-8?B?T0N6R2Qyb09Tby9taXdCKy9WcWhxWTE1d1p4NE1VM3JkbXJkZk9YdDBYT3Bh?=
 =?utf-8?B?cFdnUVZ4UWZ6by9Kd3VKcWNSejJlOFZ0bkVTNXJXMVl2SFA3c0FEUjk3cXpH?=
 =?utf-8?B?ekFCNkpFWnJGbCtmeVpnQ1g5N092Q2dBbHl1TGtNSTQvTjdMMWdPN2s3S0lz?=
 =?utf-8?B?dVZZYnN5ODhUWndEdGRlMlM4d2kzT0VsNjFiRVU3VFZLMkpGY0hGdWJMSmZ6?=
 =?utf-8?B?THM1c3Y2NFROK1E5V3N6SDVyOVFyU21sd0xua0N2QTdxMWdGWU53WmZjbGkx?=
 =?utf-8?B?aTZLUTJFY1hPeGwrSzZxR3NYQVI0cis2SEg4S1NQQzlFUnVQNjZ3akw3RUQz?=
 =?utf-8?B?VEx3WUtuMERTT25zaGNEdXF0Q1NBcHhIdk1WZDY2WnZuZXN3TVVlazV1VEpx?=
 =?utf-8?B?bWZ1STVRN3l4Z2xPRTRXbEkvS3U4U3VtUGhPWGpuMW5VUlNWcDIyeUZDYlpy?=
 =?utf-8?B?d1FoWDJBQ3ZNZkJaU1EyMDNLWExDWGVyemFSQmwxOGorZDNSU2ZtL2FtOGcv?=
 =?utf-8?B?b2lmS2RUQUxDNWRvN1c5ZTBPa0RQRUtoUGdLSC9POThpOGhmTHIxMHBSUnlt?=
 =?utf-8?B?bTBmelJ0ZlBDbmh5SDNMUUdlVytyMnFLOXR5ekxUZUFaZitvZjRQczFaMmdZ?=
 =?utf-8?B?ZnFxbVhpbVQ3VTlsdE1yVVVqZEhmd1VOQThFOHNmdStMVm85UW9rNDF2ZGkr?=
 =?utf-8?B?ODJFTXBRaE5qUUFMaEpuUEF5MWRoMVZwdDZKOXBGYk80WU5QOVY2dUFFUmtZ?=
 =?utf-8?B?ZDAxa2x0SktRVTdXbFdMNjJiTHZLR01xY251S2NqbXpac29Vd1FPb1ozY3Nm?=
 =?utf-8?B?ZGpablpiUG9jNEZJbnhqeUNtNmY0RWNZL2MwdXFieGtLbmdSS1lrT1A2SXBR?=
 =?utf-8?B?bU0xWWdkakhHbzlnTmFKT3pOZ2IvWmxUaVA3eFlpRU0zNDkyQ0hGenhpQXFN?=
 =?utf-8?B?bFVMNXVsTU5Sa2dxN3lMYmJJajFEVkZLSlM3NWhxVmRyTHY0aWg1b2xyMzdY?=
 =?utf-8?B?dDgvM0lRMzE3bVpJL1AxSGp4cytIS2FPbU5yYXcwdUNSelFYOU53Y040VUph?=
 =?utf-8?B?cnVTMHpHcVprSnBBU0RDWTVaeVZUeWZlYkFubm1jU2xLUVhoaGgvRkRCbU1C?=
 =?utf-8?B?VWlvVXpLUUpucmkwT1FRekJFTDRROUJGUmxOMGZzbmh2TUxEN1g0ZFFBNkVr?=
 =?utf-8?B?SExucmpyT08xOFZMNnp6VTZRMWJ2U1VIdUJtYUh1MXllSUc4TFdkVFpRU29L?=
 =?utf-8?B?MVpKdWpTN1htSVE4WXUzWFNKQXhtY3BkSS9RVndZQ3FTVVZTVjEwdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76b12d5-5b10-4999-84c2-08df361f867b
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 00:48:33.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ha7DELU6Bv5dSqk1B1+e+25NoiHHoXb6j7qEflZSy9P87G/e8/gBAhe2gCXMYfI80sQmKj9yD1tcCCmqTdlgSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB598757

On 10/26/26 7:41 PM, Alison Schofield wrote:
> Hi Srirangan,
> 
> Thanks for adding these tests. The boundary and overflow cases provide
> valuable coverage for cxl_hdm_unpack_decoder().
> 
> However, the fact that these tests don't require the mock CXL topology
> suggests that they belong in KUnit rather than cxl_test.
> 
> BTW, but pointless once this moves to KUNIT, as written a failure in
> any one of these checks prevents the cxl_test module from loading,
> meaning all cxl unit tests would skip or fail.
> 
> Please take a look at the recently posted CXL KUnit tests. I think
> this would fit nicely there.
> https://lore.kernel.org/all/cover.1791949910.git.alison.schofield@intel.com/
> 
> one bit inline below -

Thank you for the suggestion. I moved the decoder unpacking checks from 
cxl_test to a KUnit suite in v16. The uncommitted decoder case no longer 
checks the target type.

The test layout follows your proposed CXL KUnit infrastructure and has 
some duplication. Once your series lands, I'll rebase these tests onto it.

-- 
Regards,
Srirangan
