Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793315017;
	b=R1w+Uf3gVQZ5Ul9zz99W2Czw/ho1t0N0YRRGv1y7ddVZ7QljVv6/0aDc9IgLBBLdf0t/
	 LXlhzAQKpHN/ArnrfSeTR3alvlNqQF5hQbf4uR12MX8L/JcFoUoVlbmNp9bM4k65gDrdH
	 RvAL4AhBz6FVSzufHV34ohdSuuUd0OXPlYlQZPI9UHnrrqx3DRa0ok5+bIHwmzeOtZkuu
	 Jhx2nKoMnXWxdXVHFAFxhop6I95YaaCq4VIoiStsFTgkLGibSmp3zFNbbQRIF4YWamfmh
	 Rb7bnZ1jYGuxcpzMh3g07bO7AKSFlpFYx10axxebRPi6B53M0HZyr9qXVFdvBSEWhbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315017;
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
	bh=jp3gBtP9U2Jy7qJEmev7QgkhUKcWBdJ1xdV0oQdqbRE=;
	b=PwNQqD5MkpT0uzeQM//7XMVbb+xzgJuA87IFKH23mcin0XSvlM60XTo4zdCVhySq2HU4
	 NhlDgJ8iJ3VUzuOL5v2gMidHvqzyDeOhVI9M+mHdP2RaBddFqGp8vwzF9+uyMXLVoQQ+u
	 9pcfLKh0zCfadKHTEGm4ThStt7LYltQ+mD3WiK+DmqkT0HlQ9payabrUI0WJy5yUPtcc8
	 nN/m3ooEdCX7lH0Sqmtaf1I/VR1Z16fphbIqeQyDw9MNPqTYOKnOj1iJ6K8vpE7d9oNoN
	 Q/WsHSHa+/cJetQed+NIXUQhByJyh3p8Ma3Ffznxf7cXWv4FzxnwC04C0wu9MKwq3gA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jUBc1gBV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.69
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE3606A31A;
	Thu, 29 Oct 2026 23:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ECE3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jUBc1gBV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThW8NcrxnOzRWHNzycWliRbI2rysxM9p8/Ac87YlGVfz5tBf1j++BTOs/LXitdj/bWh/dD8MEcV1iRtH027fOcmDfcTCXd2Pbs+R4i3vlaq0GeMablSKQDejyjVR1WQRKTMrHxM7mwrgu7gzaNLzyWFbrLdmUwElCqsg5HXYkkjACs+2qFFex+L/SLjIWHuhKqBUpVdqlPyuK+cjV3yyr68i6lWfP5v3gl1ITIQN68yi3KADBkjhxe91fjKr8UM3zp/zJWOCNYOacIqlM4BAY0/UQ+Asl1jrKkEdGgH2GeZ0JHFnmRfrvFIStd+XGD62rnJfwwmy6tp/V+To5MrS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp3gBtP9U2Jy7qJEmev7QgkhUKcWBdJ1xdV0oQdqbRE=;
 b=odrmbYRGkAaQV8k5CLMpZq4mkcTk7sJMvVX3xTsRbgrXmYmYqMC71G1hCxmBCSFvxxdup7GR/e/MJaqiqIpfQm0NiS06xLF0W+IlAMdOmyma/jDRkXbhYSgIRaSZSwUFHeN0NYKZtR7PgtoqbJ9tciI/DsLLu8AvHWMSYI/caZ8FptZXvc8tbRt5sp/jepJdcsYrJH8XtozVbY/DgTgdZwHSBkD+G7aq7+19d1piZViaZNHz14Mtc0WacIM2iNmGm4TMEuyIwmzEKuRzZWQZHa7hyxEHmff1Jp/qrZQ6gkcyKWTnAI56gW9MpSdj7MGFKpSOR4VLEC/LfX/+Lp7T/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp3gBtP9U2Jy7qJEmev7QgkhUKcWBdJ1xdV0oQdqbRE=;
 b=jUBc1gBVPb8ZtqjCefgqX4rt/RLrymc6Nekjb9z3OWZbDNZsj8kueuYuBHjjMo5BnE9hRKoRqr2xAGkuOAP0Ab/1ltWmBq73P/oFVPgL30t1//E9jMlMOjSfw/hUGq3VY+s8guedlFb2FG3eEWiwpSbdN6QmwJbn03zxXtgARLfT+igOrrcUbW+TXavQg72yIm4YqvqUasIY0I9e0d4QSoXLfTqTUJPlNwv/pe7OfyHHYGP1C4XAd1fGAFVNEp3apRWpznCfpc7pJM0554uMjON1xPr3krKYSo3KvAsHAwrX5XvnnKSJUppt06+hablhnqAw0BRIM3QyNSx4nkh7bA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CH3PR12MB8458.namprd12.prod.outlook.com
 (2603:10b6:610:155::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 23:03:31 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 23:03:31 +0000
Message-ID: <2858c262-13e9-4b21-b650-9bc2bf964ed4@nvidia.com>
Date: Thu, 29 Oct 2026 16:03:27 -0700
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
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::18) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: d8deefb0-1a4d-40e7-2362-08df3610d99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003|261022075727099003|261021121427099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	mbuaSJT3VvlyJffZg5vhBtq12FbltlLBJVuQpe7qb2RVQghOw6YfsWV2LvPHMe+gVWaFJyW0blU19XWA94y7VRazs3F8TFIlw9tCWAG3wCNThFWllInZE84BH6jJ/pxpx7RJw3+AwYZlbnvCoBM1j4tZOEmiyKf7WLsrWDHbn+rVGWcxTpJR6wCmb/9dOEO+tlBjv9nD0fkh4cS9385Gxg2zeo5j9+ZkOIuQaHa7m7xM1pZz4TwuF97TRmKqnpzY5AV27M/G9286qqF6ZxGM5+T476t+POkvlPtMahtu046w29RQtp5sRMJ3oAZ0LEhdjchfodQ/Qw0NvCaTUO4HIx05rljxYVkvDz8yyiM4JN2lHSoup6zSvyz82wsTUTOuZm44lP0U+6jHpQ7LTfLmWpYMKV78Svz7mo52eif6RbZnORe5jOYVbqLpBxlbJktPa00KaS5oZXcgO6u4l6nyAiNVLlZeh7WEwsabVCuieo257Z5XXtBkqdzMZ0DOGey0IWSa+aqlZ4WOuRKgrj2zpvvNI/6tit7JmtziBO5lrJAopQO6hdxcboQLjy3/Yisl+LSyO81N3J2DlR9U1QZhE7zHiXp099vGXWfZk1uSLltJzZRacEYlRY/y6cogwwJOGCJAgWw0kdZfYC9WybZxDdmZ3y0xBLdjHxWcu8cOMcA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003)(261022075727099003)(261021121427099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnZKM2RQYXNCQzMzYkVOaW1sOXRJK2U4SEZUL2Qvb0t6aHF1SVpxMmFqZ3B1?=
 =?utf-8?B?VnNnWFNlNC85QUcxUnh0R0REeE1SUlc1ampONlhDblcrWU0wcFFDOW1wU1hR?=
 =?utf-8?B?SmFOL2kvNjZDcWZDdU02SzRNWEhnWXdYM25MZDRSekVTSnlNZFNHbzRSUklm?=
 =?utf-8?B?L0dNVzBUSHVQTkV2Q0xJMnhkNmxyVE1pcUcvUExWY21oSXhrTURkSGZyalpO?=
 =?utf-8?B?VnAycm9naTdGS212eDdIVjZpZmJVb1YxYWNOSFN5VEtROXN5cWNYczJaaTdO?=
 =?utf-8?B?SDRsbUZld3RoeG9CVVVvOXROaDR2RndKdlJtZkdkdkhBSFozeEI0UFM4aGNi?=
 =?utf-8?B?a3ArdjBuR1l2T1dzMUphaDU0bnRWZndydmk2R3I3NnE5Q3F2YXIxeHlXV1BU?=
 =?utf-8?B?aW85UEs3VHdoOE4xSk9WRDhiRk5RLzJneHZtS0N5UUxVYXBXNlBjMGIya2gy?=
 =?utf-8?B?SzM3T2VRNnoraUxzVGxtWkdyU2c2dHNTV09rVnlxZ1ZkSzljQzc1YnRXZGxR?=
 =?utf-8?B?b201M1U0NzA4aGZOL3Y2ME1uRnVpS0NPQThnTC92NG5ZSTcxUFpjZExIdHhW?=
 =?utf-8?B?NmRFVlJNMERtbFRxdUpXN3Bjb0EwNUlyQ1BpazREa0F0SnFvbStoemszSEsz?=
 =?utf-8?B?L2ZpbGxSM1VpbDhhSHJ5a2VhRmR4VHJQbjVkVHJ6a2xUTXUxZmtKSElHUmYr?=
 =?utf-8?B?S3diR1pHN09qY2ZyODRZSzVZb3Z4WWVUMlpUNFRCdTdkd21uVStrSS9lNmE0?=
 =?utf-8?B?c2hPdWF3ZHBrdHRpN0xBTlR0dm5OcDA2d0s2R1JKUk1mYndyZHdkUERsVU5R?=
 =?utf-8?B?Sjlkd0d4MHB6REt1TVlvOUc1U1BKVWpaNDdoTjM2cHI5TWw0UTJVU2RuTENV?=
 =?utf-8?B?T2t3V29YTEtXd3oxUENNS21VYXo2N3dkRzZZYmttOHljUS9pWDZic1Q3Wjk1?=
 =?utf-8?B?ZUNYcGUxSXcwMGtyaEJYbmZLdTVaL3RZci9zUmNkZVA4bTRucDRwSERIOFor?=
 =?utf-8?B?Y1FQVTZoQ1IrOXZRZ1AvbFNLekEzcU1tS1o4VTIrZVV3MkFCVDNydmpZL09O?=
 =?utf-8?B?WldOSkRBZTJQTjZXMktsTkFsUytleDV0TW1TZ1dvYTcxOUtoMzdaY1FoYSs1?=
 =?utf-8?B?b2kybEZoUjh0ZzdTOE9jU1RabUdwQmVKMUs1ZGdUazBTcjRBVVo0c254aC9M?=
 =?utf-8?B?SnA1RmgzZmZSQTZMZitnejArNG5mWTd5Z05FVUFzQ2RXK2oydm5WSWlSTFdX?=
 =?utf-8?B?WG9aN1lzWFpVdnZDaWVhYmFDNmo5WktnQWJianV5RlVMVVhpcVZ4TkVNTHpq?=
 =?utf-8?B?ZEJlM2FLbDZXRHYwQ29lcE1KUS9HLy9ybFJ2YUFseHQzdllodnRzWVVVanVy?=
 =?utf-8?B?UzNobWl6eDJvYkc5d3ZrcXA0TXFMd2E2c2U0Q2tGNWtVbTczQzNJbnlyVVQ1?=
 =?utf-8?B?K3JMT0FnWE5GYjFMVlFDZkUyb0dQTW1LUU9yR3RaaW1WUi9LQysrdWZ2eU1E?=
 =?utf-8?B?YkJzQ0tyUE9WNGZzSkttZ1pDNnAzUnhLc1FPWWpXRXlncEIxQy9NQ2FjTmtV?=
 =?utf-8?B?Zk9IYVlSeEhkYzVBbzlNTkppUFVvZmlKa3d4R0dXMTZQdkYrOTMwOER2Zlgz?=
 =?utf-8?B?VUwzb25IaHN6azhINk9ZRU01bWxydDRidkQvMHJUMmhPd3dVTXgxRmlTaXA0?=
 =?utf-8?B?Mko0N2wzMVlJbUZ2N25vSDcrd0MyNmEyNzFuYVZYcWkxa2tILzQ0bzRTMmI1?=
 =?utf-8?B?MXVYWnFFUFpEMlhqMlVPdll5WDBVZW1JNXQxeG0wWllPcWhBekxuQlR2WTAr?=
 =?utf-8?B?ZXhyaWk5N0Y4K21KOHhvOElOd3lLMGJ2Mml1L3dTa3VhbzA5c0FMa3VmODZ2?=
 =?utf-8?B?QlB3S2JNYXNxY2RpZkpxZnZYd1hKakNZS3hQWXprb0NGSktObVVpY01JUHl2?=
 =?utf-8?B?Q2RtSzk0a1ErMlVEeFFFU1NSNU9KalhtREMxNUcxcHNTY1ZaVExoMXhKNm53?=
 =?utf-8?B?em9XTnRTaDB5eWd1SGZNeEg1N2oxL2hQRm11cGdiUWRVVmpRUWNSNUoyTFhK?=
 =?utf-8?B?SUJ3NTlZSm9Qd09XdjVmc25hVHZrTVkyRE5QL2xPOU91cHdpQURCRm9FK1k2?=
 =?utf-8?B?K2pFeVJCb1pnTmM0NDc3TkY5VTliNmF4MG1PT1pyVk9Yby90ZXBBd3NGS0Ry?=
 =?utf-8?B?NDF4d2t3cDUvZTBFUE1WMnQ2S082ZnRVZ2s1WmpRSWRpdHZpbU5ZRjZFMzQr?=
 =?utf-8?B?YTlkNlFMQ0VDR1hXRFlzN05PSlN4d2FLSVBVL0habFJGREFaRnBNNXB2OE83?=
 =?utf-8?B?RkpvZlg0Tll3c3hHV3g4eG5JbXJCU0tWYzV5US80anBzaER3ZnJJQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8deefb0-1a4d-40e7-2362-08df3610d99b
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 23:03:30.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KO6nix5BEqDuNf2MmVNZiHxRVf49dXxm5IMtbdK2WvjvBN2JkDwHIukQBDoT44j+RK5btIwjbFNs9GbcAvKIoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458

On 10/29/26 11:58 AM, Alison Schofield wrote:
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

Hi Alison!

I’m really sorry for posting v16 before responding to the v15 reviews. I 
was preparing the replies today and had intended to respond shortly 
after posting, as I had done for individual review comments on v13, v14, 
etc.

I understand that without those responses, you having to compare the 
revisions. I should've responded to the prior thread before posting 
this. I'll go back and respond to v15 this time. I'll be more attentive 
going forward.


-- 
Regards,
Srirangan
