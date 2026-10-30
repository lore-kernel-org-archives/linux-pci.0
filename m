Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793324602;
	b=MJRWpak/UD3287BladJT7tAfY8YN9AWPVSXQaBAnUAkhDJzyCcQVhXy6fGkgNAEImbhC
	 QSvELWFn1B2MYW4YtRYD6PecZwn6xn1saDUO3Qz99gBbVT+hNr9/O9SrRhs5z6pd6jGLI
	 e41ho5mjJkruE15QTYX9wvCIDoBRSmWwawIUiHNYloXAfdzQdpQDNX9t2stBTQn9vCIFE
	 1xt8mmuKmqtTtPLCV2tmHXKcbttzQ9b5sOFOjNN3sThVDvodCt+pTBLaU1Q08Iww6Y+1b
	 RCmff2/SaPFbWAg/4HWjPFLt2CAJLjkodwnYeSDCZL77nmUyT2+Zff8WhVqf5XFjUIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324602;
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
	bh=T+bs7K4Np8uw1DIc4hQrwpaEzXt7gai50Oq93D4FsHc=;
	b=G7jq1OXKAjUXhWi5xoJhf5q736x3LKe413PYczgm7jrdTVDoU8fuGka9ziwyLIglTmPu
	 ZcKaknTkZdv6LEgtlMQJ4t7TCnVr5FI+VxQrdkmYBPBhsDMmfPqXbqP8UPo/fdUvtdDfa
	 YWd0vkEd+d3in9zRzIhaTHGh0RWlGKREw4KQy02rGWBThlk9fDpfdsi+WSapaz0p0fbq+
	 b7Q3/RZqAgEC0vMJvQFhSXPGnrz4mMEFx4FMUO1IKQap9eMl1mVDzdFNm1736iplDrDVo
	 Ymoy6XKe/eCXxWPV3L7Hyy4yd3196uCVtDNdwYIg2QQ2Rb3gdVF9njhfDr+VsxvHx0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M9DZLD4k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.46
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE0606A31C;
	Fri, 30 Oct 2026 01:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00CE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M9DZLD4k
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkS7V+wwK5w9yESOlJ0aIA6LbyXFftv7ykGnvIFv8SBShwYBKaVRJ+QsG5ueUkQKWwT7EWjX2vbFQtds0WKcdnFUw5vbFcwPtcf7JzYWNzegyLzZ7yX+LyN/BbHHqPZBLYhx2Ag68lKjExPSpzvXQH/KV1EcxmqEXnEqtxT80jvPP77oV5bd0GWTyxc4ZswpN9BgWD9yZdNpF7RBoWdbEn/w7vxWCmdZQpp2V+Vwfv1sZtWoYGOrAjM5peC2GQ/PpyanHPGgCU90pbA6QE7FZOxqbXxULri2Y+d9/7YNtrSydem7/Jd+1WQk5YdUVT7839K6HFwuMR8qB1xR5eGWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+bs7K4Np8uw1DIc4hQrwpaEzXt7gai50Oq93D4FsHc=;
 b=Z6kKvgt/bViZWqP9NHruddWLAMduP6+cNPEWc+CPbXUZj6ZYm9F7HhqFU84A1x0KmGMvcTvr7z/gP7T8lDk5eRbPVNOsbi0HTs4UyUqOT/wQdM4/Lms5+EAf0LOCQ/0GkKMypZP4Au0kk4zZJHuSLVGWHbcQV5G0K28pNfhAwdzTaE8lRi+drspBebZw6Olz/N5HW64OaFjhAD7l99GB8PozgbITVwujU/DhlFpWsDYh//KIsjddrcvBhLcM31wWeLaMXxF+Wt2m6NCbHwqJ6B/g9tQp8Pe+5IOMu1r0u8j3h0aztoHINqbL+SAgwVj57hC8pffsfanIiVt3hzH58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+bs7K4Np8uw1DIc4hQrwpaEzXt7gai50Oq93D4FsHc=;
 b=M9DZLD4kwveRocVjt0Tpv+UGC2yiEv/1v6DEYO9Ck8mApQ+TToycFaL50ny3QBVLGYEjE6Kx7WXFXn77gNGtTxYRNQo14ZDkoS8+KZwIfaEi/fDN40U3Y2RwSQk8ym0umiH+Bc0NFnwXOGGBmHaJBY51ILwSci+OEyHKK6xx47jYoZNUtaDtuo/jJFg0CVqbs4/WVowXy59GOVVE+EX+LhiZ7Vk+zKFoWV8Y4RXSaqiaW2ovv9cx3PrsDdNExaK5DZ4/Vfuf4ktUWASXcKUllpJ93hhrNpMoxyL4ngtvLohvNjD+Wytp1akBqGwhTsk+vdmVsmuTxuI6sM2zNZRbog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SN7PR12MB7417.namprd12.prod.outlook.com
 (2603:10b6:806:2a4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 01:43:16 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 01:43:16 +0000
Message-ID: <370ae30d-8550-44d8-9191-e9638508b291@nvidia.com>
Date: Thu, 29 Oct 2026 18:43:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/16] cxl: Validate and synchronize HDM ranges around
 reset
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
 <20261011021422.3428136-12-smadhavan@nvidia.com>
 <auApYR-A3qihqLbP@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auApYR-A3qihqLbP@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::7) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c8adfe-5f31-4e98-6dad-08df36272b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261026140227099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	0wSe8uoC1rPmKJOD0p6V2jMgu3QE2VyJ1WRDXprI+P1gYDyCwjRw0mxJgPsuBfjgPMYge/6/sUrbFWcdrfazkSB1DApZ/AnrJeg11aWMoKpw+PKiSGBWVUZMOLa5tQNWAC/EtL0XvC8dsveWfP7n+GQrmuoy9KQIJ7uMBpuX7JIvzDEW8k6bx5lBfaXpaYp+fmrPjG0wItgTpF4wwAE4h7qbb7xG4IQtLOfJ0sfX5e/JYSd/ujKdasak8x36IIHvZU7khVfQ+TKWK9KPd0r+BgIBanEj+u4LS6PwpWs6PGdkLlRpAfE1Hd86o0tUPBkm9Ki/8I1Gojl7H8LRLqK01yjMLKSehmk4EeP/lWm9Ec5XZuwZWAKWUwsEotLHOINx0+bsn1yOcv7gTiCH8p9WnyhgOTQHFvDhr79sWAKgkr0MQ1RmITYMM9+xWPALCNjC8L1EGJVjKMQkEaceU/rfFoNOiNdMKlQE6yOeltP64CyDJ8qHNBI2zn2drYzkWvGoacBDfweriJM9xOqc1KG+vvJvSSq8d7XhtmIcbQf9x+GgXFy8gfhNWXeqMY6WE03Rt7Cok4oofLREGlH7WATXMEbhhjDyIMiFppoaKIh4FtT0yWT3w0VMyMeCsTnAjlh2QUURMAA2xYpPGsTCidQomWu/AsIayb8aflDkF1fBPas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUFJT2VvWlp5YndSTU9yNENQSnVBU2FmTGx4N3JXbC9xUjZ0Y3NsUHhNQ3RQ?=
 =?utf-8?B?OHNvSURIVjVaSFoxVGVPZ0kwbTFaNHJaQWVtNVdoMHBjY1hMcWc3K3VONW5h?=
 =?utf-8?B?MnQ3cjJwb0FacEpDSWJqU0QycStwOGl5SDAwRGIyZE15RFBnS0NEMlNOcVZY?=
 =?utf-8?B?aGcxaGZ3bE11Zkp1QkV3QnpDUDdCOTJNdUpKbTVkNnpHVDBMTHFQcXJ0TVFn?=
 =?utf-8?B?bHVEUTc1eDlMVjNSR2pGd0dDbkFPSXpCUHpPUnpFd1lBRncreXlRZTZtY1NP?=
 =?utf-8?B?WDZtcldZQUxpSks3bVBFVUhFRUZzcjVCa1k2ZTJsVkcwSjYybStxUVJkSTht?=
 =?utf-8?B?MmR6OW53MFB3ZnVZbEhDN3R0bzdVVEFKdVIyOElTYldPamZZdUNQUnN3M0xU?=
 =?utf-8?B?aFdlWlFodWRhd21UaWp6dFBqVzdjQnAwbWtxZjZYS3RXR1paRUhYTnk2OG1K?=
 =?utf-8?B?NTNybEhEcnpsQnRTaWFmMWExcU5YOHpCQXQwTW5EcFZIbmRSYTNJNzFFaGkw?=
 =?utf-8?B?by9pcmxZeHZka3FhdEd5Ujc5TmZsNitxa0ZjaFJTb1l0NVg3UzV5Z3dsK0dw?=
 =?utf-8?B?V2xlQWtkZkpOV2dVYWN2R0lsR1ZZYnFSbVlaYUxCM0l2RkxyUHo4TVl5dEQx?=
 =?utf-8?B?NGxldSsvZTl2R2U5SVRUbmFIOHpyTkJYWE40aFpnV0RvNEVpUnZaK0pkQmRt?=
 =?utf-8?B?YVhyY0hlMEtXb1Z5ZGZYbHpPOGR5bzhMaEVLb0hSTVB0S1NCTXJFcWZKWTcv?=
 =?utf-8?B?U0RVakhsNzVxTUwzQi9STmxUamhTSVFlVWIxUmo5WEpiMnl4TUIxKzdYRHQx?=
 =?utf-8?B?UG1ueHdzTnU2bFptYWlZT1dkZC92cHlNOEdXK1l2NjZITUZoajVIYVVmcTZy?=
 =?utf-8?B?eVVkRW1LNDhkbjNSUzFEVHo3R3E5WEcwbHZ0WnFzdmt3YXVRT1puTFAxdERn?=
 =?utf-8?B?ZGZuQnd1SmV2NjNxNnlrVUpOaXJVa0hBOWVMYWNwL2RuM3Fnczh6VTl0VWxh?=
 =?utf-8?B?NFhKZWovMXNYNUgyVUE5ZmJ5cFJyVlE3dW9MYTRlVmlwaU5wTjhaVmFJMmdV?=
 =?utf-8?B?S1Z4WnhOempocjNPYWs5ZmNhckdWTW05RWxjaHptekdJU0l1Zm50R0FQMmd3?=
 =?utf-8?B?R3IydzBubVFVOVQzbWxodmJvQlhNdllEb2MySzZJS1NFZ29uT0o5VG1iTmQv?=
 =?utf-8?B?azJUc3haSUFGZnpTVWtJTm5WUkR3L3lUUC9zZWUwRTlPZ28wcDd3TTQrdklG?=
 =?utf-8?B?ZGQvQVN1TjRpcU9FZHpHOThKRlV4bXljK24zU1YwMm10TWZaNkpadDNCemRj?=
 =?utf-8?B?R21ZOTdaZ3dVSWRrdkh5SldZcjB1KzV5SHhMUDk5V1JGQUEvNDA1TVNyMWZa?=
 =?utf-8?B?ek9RQWxnMmh1cHFlUy9kZHF3bDV3TlBwZnhnakpxVjdHWDNXRC9sRzQyejRw?=
 =?utf-8?B?dHhXZTVmclg0a0VMQ3RZaHZwTThrUWV6RmlIL0pVQ1B2S2UwMnFYWVd3OFRP?=
 =?utf-8?B?U0thVkhwR0FhTkxTOEdHZXhYcmJxSDQySWMrQjAvalk5T2s4RFVRaWNQeEhh?=
 =?utf-8?B?UW44SldYc2xMWG1EZzlKMzd2bmdPb05Na3dpQjlvMlFzQ2ZoRDZqV2UrMitW?=
 =?utf-8?B?Mks1bllBVFBlWS9uWnVaUmYvZDhaZGNkUnpneGJ4VkUrczdocDFXMlhXaTh4?=
 =?utf-8?B?bFhSV3k1bCtaeWFGWlNOeEJkd2JxQitCbFEyREdKdmdsMVZObU9LOHFMbmk4?=
 =?utf-8?B?eHlPQ2ppbjFRM2ZvaUMweTF4UUhUZEFsa1VlK2FIUEZUbkhyUlo2TGEwdTA4?=
 =?utf-8?B?MkZ4enJZN3dMVXRMZkU4TktpNkJaTDU4VVBGQVFnVW5sT3FJbmZpZ1B6eGZY?=
 =?utf-8?B?aWhsUDlnRVVKV0l4ZGlHOFlxODFvM0FaYjNFRTdiekV3bVRqRHVHdWMrUWZS?=
 =?utf-8?B?OVQ4V2VyRnhJNnhra3RlZlV5ZEdyZDZ1dkZ0TkhSdE1ONTdUSFRpYkQ5UGZS?=
 =?utf-8?B?Y1dHa0tNcHBuOVd2c3ZMR2JUUkVkYjVGK2tiUlVMNlAxb0tRbGNUY0s1QVVC?=
 =?utf-8?B?blBMMVB2cW5Pak5Jcmk4UjJweUxNMmFldXBXQ0RKd21vbWZ0eXhCbUw0Tjk1?=
 =?utf-8?B?SUZMUVcyU055OXpCVjI0djV2RVppZ041SDVQZ20vRlZqM0tGbFpSMjRLU2di?=
 =?utf-8?B?MjVPUzluRTJMdzliM1JkYWpndFFRWWZPdVNWek90cDk1ZzQrZFZMdW1rbG9V?=
 =?utf-8?B?OFFwQ1FOaXAyQ2pMdjhUUWM0aW9hRXZVQzMxc3pGN1RqcGk4SU9qSGdZS0sy?=
 =?utf-8?B?SjJsR1dIRENlMlM3c0tNeWdBaU5ITFhLNitJTitJYlBjWGJabko0UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c8adfe-5f31-4e98-6dad-08df36272b25
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 01:43:16.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YE1Ok3TL04YikWxHRLWFKoGTRw5H/f9XUDCa//fAcP5EQlTRK/0iwiO/AqWEk9eWzNqZAJupdTY88OTMEgp7mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417

On 10/26/26 9:32 PM, Alison Schofield wrote:
>> The range handling and region-quiesce structure follow Dave Jiang's
>> reference implementation on his cxl-type2-reset branch.
>>
>> Link:https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/ 
>> commit/?id=5944c6e61f14c0dd28d54537be15edb2cadb0e8b
>> Suggested-by: Dave Jiang<dave.jiang@intel.com>
>> Signed-off-by: Srirangan Madhavan<smadhavan@nvidia.com>
> Hi Srirangan,
> 
> Please revisit the tags and the inclusion of a link to DaveJ's
> private branch.
> 
> If DaveJ contributed code that you used, then the tags would be
> Co-developed-by: DaveJ followed by Signed-off-by: DaveJ.
> (Assuming it was non trivial which seems true based on branch)
> 
> If DaveJ only suggested you create the patch, ie, you need this
> functionality, then it's Suggested-by.
> 
> I'm not sure you should include the links in the commit log since
> they are to a private git tree. Maybe just include below the line.
> Those links are on more patches than just the ones you added
> DaveJ as Suggested-by, so very that is odd too.
> 
> Anyway, that's for you and DaveJ to sort out 🙂
> 
> -- Alison

Hi Alison!

Thanks for pointing it out. I put suggested-by and linked Dave's branch 
as I wasn't sure what the right tags were.

I moved the reference-branch links below the patch separator (I can 
remove them altogether if they are not useful) and removed Dave’s 
Suggested-by tags in v16.
Checkpatch was complaining about Co-developed-by tag without his 
accompanying Signed-off-by. I'll reinsert them once I get ack.

Dave, the refactor starts at v15 patch 6; after the split, the related
v16 patches are 6–13, 15, and 17. Would Co-developed-by be appropriate 
for any of these, and can I add the Signed-off-by for the applicable 
patches?

-- 
Regards,
Srirangan
