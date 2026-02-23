Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A387080D
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771819586; cv=fail; b=jhZndF+/BTp3NjEFQQf6NcXATk69sWGlBDGYnWMZiATG2HHat5fppem6E2o8XKmbsjVQ84sO4vqV7Q/vhnPIRpuQgpCUZZc31rDVR95fp/6kkWqeYD2hLyon9vaohJsGKtY84YpRPG9H8tROEx2LrLrxRTSGvLCraE6HvcQfdm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771819586; c=relaxed/simple;
	bh=MllB8fdd/Ev54sMoKAYo6EYiC5VMsgAsCsagomoZEyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gruu593BlfQjKdQ4FHvtkm4+6AeZsIE+l1YjTLxic0mgbdGkiWFVHiqhDa3tyC2hduBN4IZISfbYjKSoGpu19Hwg+AZFr2sdXDP8M2W+CBfQ4VXv9xXweUKlfR+mZnzCj6E4+LvTfeDZXaAxPJXiG+xQLsInRQXa5GAjib9rXvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oSBAH/uR; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oSBAH/uR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYw/pTx6wGF8xg7BH4oHqHNZqQ+kd6wmnbKyBR2Zb+37Ih2PnvfIyzPgg0PHi6+5iwoQ2/bgsQ0F5vuXIUOeTP8OjB48Gxl8hcmsqaUPYATotU+QdxadtqDYTyv9oBrWPIYzNF9H+URqY3NWN0cWAMz5l3nETDww8+17FPSdH7kuaPJNCJ2PQultzSe3N3gtGI9QYKW8UczeTDG/Ec0KfPEcNmYZo4JGFib3uFCTrgnMdHb+uEMCax8iFltPA3lf4CzV41HhLekWGjRe2dJn2ywFGm3ZyRH7K06tLF0hcycDB7PPk01MJlqtap3Aaqwr8HnQOf7OVmMibn6Hcvx5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07wR6XjZu9mGBUEgCq/3J5nBa5d2kt/yUgpO5EQRpBI=;
 b=Gvim8ZOOkclljbl+3X6KvZkP0L4hGUhXK6pZFRwbfx7TIS4Qgul3YeE4dqsgrwrgJRerEogL4R801jpohL9jXqETKWkK7XXOMppwHgAPM0JVsro1VGMxrWotEz0sDSqaBdJMu0cjVaHKGjGfKvHoV3BcsiuTCKNOEQLRIQEUDMt/Ow+Ftda56OpJjAwBqbz3ZNmvvvJ5D1gF0breM5DMy3BX5X4upnsvzWlyWttQB00eKfnirxWpyxlWNlis/MYmZldkN0ut2ks2pZXtAfAjAzeF46h3+SxB5tk3VeWUCeq6RvD6IB2gV4HSr7NmekyfyUBhcUu3E8BcEopjcehCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07wR6XjZu9mGBUEgCq/3J5nBa5d2kt/yUgpO5EQRpBI=;
 b=oSBAH/uRs9Xt01VZYBm3oLkF3N1vcuIH78z/pMyYqrKJ6GzRpzcUfNCRcMtkdo2oqymcSWpDI4zDRNleiD2EJANIc975NyyUsmNScbR38NvTa4268TNfkW17ste/I0itqgl1STSApb5oDX6djxVVlUaYpSVDvJ8/8S4cVWTpPVWCxaLRon4IKmE47zLS+t7V3Xp3NU76UigPrrubcvMjDTwkpVod8zNV2qUIkj1ohKTqnUXcsgPXZDpxgt0IoRIXOc+t6smnUWUo/uA6+X6EEKgT9bUYRawZ7KNM1XCv+xeUApgbP8H8ZqZIoy0XuVHvy6THskXBt96racoXn3XM6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 BN3PR12MB9596.namprd12.prod.outlook.com (2603:10b6:408:2cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 04:06:20 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 04:06:20 +0000
Message-ID: <54782b60-cc49-4eac-80f2-15557ccec818@nvidia.com>
Date: Mon, 23 Feb 2026 09:36:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] PCI: endpoint: Describe reserved subregions within
 BARs
To: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Koichiro Den <den@valinux.co.jp>, Damien Le Moal <dlemoal@kernel.org>,
 linux-pci@vger.kernel.org
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-13-cassel@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260217212707.2450423-13-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::6) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|BN3PR12MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: ed09c96d-2181-4abd-5da0-08de7290e6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGFQY2lSd0lJY3NDZlphSnFBY1ozVlZlOC8wZ0xLeXhIOStxejBzanBIUG91?=
 =?utf-8?B?U0dTbUdBMnNKY1JJTjZvMXY5ZXhlSFEya3BCSWxydS9paktBRUJiVnc0eG1z?=
 =?utf-8?B?aGZUenBGb1dFcEowdURtOXcxZ0pHMzUvaHptRVY5V3dHTzMxTWhNWXpFSWc5?=
 =?utf-8?B?YjBsR3RwVSt1SHUrRmgrQnFtY1IwUGRXTFVqZW9qNWFSL3ZjK2poakZvNlgy?=
 =?utf-8?B?VDZLR0Q4V25RVU1QNXdiQ0E2c3I0bGkrYWF1Um1HSVdtTm9TcVB5UE1oaVF0?=
 =?utf-8?B?YU5wWE9kb1lxNVpZcnh2Njk0M1BtUnJHZWJSbWlMN3lZY1VxNVVvZkJmUFRh?=
 =?utf-8?B?ajcwcUNQdGEyNEdCNmtITHkvY2FXNk11N2d1OUorL3R4TytZU0lNQnVpS2dn?=
 =?utf-8?B?UmV6TEFidGtlZEllUGxId0RxQUp3U29La1NPOUVoOWlGVHlxQnpreWIvd0pG?=
 =?utf-8?B?NGRvc1NKZy9XZVJlbzVWaGFYQXdodXJ6RmhteUl5WjJwOGQyRVMyd29HUXRz?=
 =?utf-8?B?NE1mYmxWWGt4WDFNU25Rdk1qK1FaTEVhY1VVc0JyYTgzNFNSUnYzR2NtcnZG?=
 =?utf-8?B?QmNhd2dhbzN3T0E2MGQyc3MrT2tubzlrS3p5K0VGRjVqTWdhWDExN3Qrb0Zj?=
 =?utf-8?B?Sk84SmZnRlFISURjTG9haXJzanJ0ZlpZbXAwWDA3eDdnekRDRWo1YTNuNGZS?=
 =?utf-8?B?SXduZk0zbVpkSDQzejhWMDc0MzhrZUJvMTJtcmlYNWhkeitRSGRneG1pMEpD?=
 =?utf-8?B?R1NKZUVnUnJGaDZmaklxcmZrTlFKTVJEUysrSU8zVEtJWGhlUXdNbUF0Sjhl?=
 =?utf-8?B?cFhnQTM2ZjRoSnZTZlNPa2NxQWxLcjlQdDU4eCsxWFUwM2ZjYWc3Q3ZxcnZY?=
 =?utf-8?B?MXNnRWJ2bXhXWnJNWXZzZlRlQk0zeTM4OXVUdzROdUt2SkUzd3p2ZkRqNElu?=
 =?utf-8?B?N3BFUk1BQVBCeTVtSWlNZW9yZGllSy9zTVppVmFQaVIrT1YxaXlDd1ZlbWU1?=
 =?utf-8?B?L0VWU2hhREJYbGYvckQ1czNJQlAzWjY0dEJ2b0VIeTY4UERzS1puRWlCUVZW?=
 =?utf-8?B?UnJFMUtXN3p1dlh3UDVhNS9kNE1md0lURlpNdHdhd1F0bEo1TG03VTRNQWNT?=
 =?utf-8?B?Ynh0VnNUSlBFTzhMMWU0Zkt6NFk2UmFEdUxJNUc1eFdLaWxPSTYvdVl6Smgy?=
 =?utf-8?B?OFgzOUZJUUFDalBEQmZOUTBXc0ZCMUF3LzN0YTdnZSttV1R5NHIwbU9xWXlI?=
 =?utf-8?B?MnFIQTlYcFZndWFteG9xV2I0QldhRDVOVVFNMHRLWW9TeGp2NlBvOVdhT08z?=
 =?utf-8?B?RzlZbVFPcmFUOFJOQVltWXY4OXlMekE4SXM4citQaFFwM1A4U28vVDRqbHBu?=
 =?utf-8?B?Njc3bmpGaXNLWDI1Yk9hVnVHYjRzOEd2ZmZoS2tjQVkwNDFvZmdMK0RIdnlz?=
 =?utf-8?B?d2ErYWlleWZPZ0RzU1JFeE5WRHc5YkVJdjgyTTY2b3l2Y2dZM1lPK1dzMHp5?=
 =?utf-8?B?a3BGalo4VTI1T1ljb1RsMU1WRXZLTHlaR2wwSERxdWIwbTVmODFMMDNLeXk5?=
 =?utf-8?B?VTZSN2ZBZ3BDRDdTb0lLSDRVeXI1TjV6MkwvT2lWanBXMWpnaHJzZDg0VkNT?=
 =?utf-8?B?ZVFlY3RNZGhqcS9DZENJNVVIMGV6T0NKS1k3V0I3UHBYYzlZbkYzTDhCRlFP?=
 =?utf-8?B?L25oMk5BcEV4NmNXY1QvMDFZU1lUR3J6bEoxK1c5cWFTV3lQaVFZRk5MTmVY?=
 =?utf-8?B?ckh4Tk9ua0RWcHQzZlUrclphZ1ZSTHdZbURiN1F6RXNqU0E4TzdGcmdvR3dP?=
 =?utf-8?B?R0h2Zi81dndIZmpoZTFVZFNEa05BL2h0R0ZRTmdVV2NCQnBQSUlTQWI5NjM3?=
 =?utf-8?B?ODdBQ1VPSnYya05Nc2hrMmd4b3FBMlRqRGtoMHB5djh4OENmeXYxUTRxN3Vw?=
 =?utf-8?B?YjNXNDhMVFlVc213eStwNzVsUGNOVktOd2djZzhmREdmQkswVTZZSnVESXNu?=
 =?utf-8?B?VDB5NE9zMG02dmV4dVlwbmd4WTRPeG82V1NsbkUwUDZWUkE3bzBJQUxYbXVy?=
 =?utf-8?B?NStYN3JsWFlBTjVMK2sxK01oQThTTFpQTnVBdzlJVHptWnE0T3FDdWhza2ZF?=
 =?utf-8?Q?g7Fs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXo3L24vNVFWM1ljckNaR21Oc1ZnM1NIR24yTVdHNTZmTFpGbWVHbWpnQk5Z?=
 =?utf-8?B?K1lDSGFzeG43cEFmUjFzOUUwODF2SWFPd2V2Zkw5UDJHKzczaUFtU3NFaHU0?=
 =?utf-8?B?b09aN0lUVmRFSkRSU0ZneTBNUWtPUU42d09yblM4Tktvam9MOUhxTGlSenh4?=
 =?utf-8?B?bzNhNEF0aUs5bllLNjNJa3lwSkJmNG9odkhQb0tFOGNjUTVtL1lKNGdYVVBZ?=
 =?utf-8?B?RWo5ZjFKM2FTMjRQWXZSZ0JHZ014N3Vsbzc4Y1hYcXo3MlBhbTZpT0F1Vjlo?=
 =?utf-8?B?b3NhWTcrNmpUZHBQTWllSlhXYm93K1BxRFl2bmNzNUJxc3lvaFlEa2xWMjVZ?=
 =?utf-8?B?VVp1cXhrc0NlWkVENFB5TitoaFFUUFV4ZmZnUkZjWkxiQlZ2Q2d0aE82MVRa?=
 =?utf-8?B?aHJ1TTBnZy84OXhid0thV0ZtT3ZNekFiblZ6dlBaSUsxMlpRaFZOcFYrNXdo?=
 =?utf-8?B?NHJrcDd2a1ozSnhoRHh4VjR1RWs4dkdvZ21YOFJPRlo1cTkxYTRmY0JzSEgv?=
 =?utf-8?B?SFZ0aW9KUGdiTnUyL01wOVI4cjhkd1ROVUYyQm5lMkF2TXRtbjdzU2pQcVZZ?=
 =?utf-8?B?TythQ3lrM2FhZVZVQ1AwWDhRVzdvN0laL0EwYW9iYzF3TU95K2JLelVldVkr?=
 =?utf-8?B?a1ZvQzR5c1hDUzRWZjBiY1VnczB6R0M2RmZSYkZibXVxY1BDMUl2K1VTVzZu?=
 =?utf-8?B?NVdWMWxLNFROMmdHMmNNMFVGcjE3dmNIeFAyVWpmb3dXZ0p5VzBSVks2ZHFD?=
 =?utf-8?B?Zm1XbFJySDBWWFBrbjRTaDRXVjVHbnh2ZUpDKzNVNFZUQlNrMzRtV0tpaUVu?=
 =?utf-8?B?S1lZQjNFcmVFelJzdzZCM0lRZ3NEWElmeEtBblk4Zk8vVG5GUDJJNFczUlI3?=
 =?utf-8?B?L2JReWRLNEdkZFdRZXBVaG8rKzJpSkNOL0Q3Ty9vSklDK2M5ZVN2WWUxcXVy?=
 =?utf-8?B?RUZ6ajhFdTdUR0Y4WSs5SUs4SWJSQ3hNR2NDVmZ5dHl2WGJrWVpFR2VxdG10?=
 =?utf-8?B?QVlERm03RWlLd0Mwd2FudXRUaURDTmo3VG4rTW5KOGUyVElLQUtuOGlDUzlw?=
 =?utf-8?B?ckdZbGI1clNCVFplYlgwdDkvZTZybi96RGllbzFwY2duWjdUbkFNcGdtNzh0?=
 =?utf-8?B?OTJRUUJWbkFnb3cwbXc0R3RjaDBSTXhDa2ZTb3FuUWhOYW9YTXJURHVBdzM0?=
 =?utf-8?B?SWhDT1psVjFheUQrY2F4RGxTTXhLZmZjZnJxWGttZVdrbWtQSEp1SmhoaGNY?=
 =?utf-8?B?Sk05c0JYTXRGSTJlT0J3ck9IOWRlVkNzYTVuMkpSaUl3WXBwbjMvRk9TTFNX?=
 =?utf-8?B?UzdvQ0o3MnVrZG5iYWxBTERJQVZpOXJCWDlJbHdJYktUVHhPOHRjdjNIZncr?=
 =?utf-8?B?eFM4aVgyOGU5SUJPd2Fyb2J1OUgxaUFIM2dNYnBUUVRrSmNXNkU3NUs3bzVI?=
 =?utf-8?B?QzBoRWU5dGNJNlAza3NNdVNXTGNDUzZWZzNhUFJ6ZnorTC9HbDJ0NE96bkpa?=
 =?utf-8?B?OXlIcERtSWtIUUpmaUNOTFJwVDFnMnhRODN6aUVaSlYyTkEzMUw2M0Q3WWxl?=
 =?utf-8?B?UkVwUEVZUVlOUmVuU043Ty9SK3hxTkxaSWtSTkRINFpERExuTWxEalloSEFh?=
 =?utf-8?B?ZFNPMlR4K25McDMxZTk4aG1KZTlzQUNtV1h6L1dGbXNOSFBjaVp4R2dxK0JU?=
 =?utf-8?B?bkxXRDB6alo1a1cvRUdVRUpQU01IcXo1WHN2em02Q1RlNTVIdXc0MHBqUy9N?=
 =?utf-8?B?ZGtjKzNjNlVxOUIwM0Y2dTdXQU9vTEFIWmVTLytxRkdKN1VNeVg3M2tHOThR?=
 =?utf-8?B?akdIRzl0cHJnQ1lVaEtvaDEzQ1NVNmkvcm1yWWp3Smx0ajl2eTJiVnpwQlpE?=
 =?utf-8?B?UU56V0l1N2ZPd0lYWHl1N3I5a01OeDFBOWczYzJGeEJmYm5NT1p4ZlJsWUFJ?=
 =?utf-8?B?T1ErVjlhL0ttY0VtVUNoMm5ydStQT3IwM3dWcHZva1JWU3NaRjRQWVNJNmFO?=
 =?utf-8?B?cUhPamxxVXloQXBHMm1ISVY0Y3A0b1NCVXFtbkRlbHhPY1JDUWpNRjZ5YXd5?=
 =?utf-8?B?K25UbzBhRUxCY0UzZFFQTUpiYjFIZW9MOWFQOWhFdUc3cE1hYWlEQk1yVDl1?=
 =?utf-8?B?MHI2ZWFZZUY2aUFXZkpQREkvQzBrS05sQVM5T1J1bHBBM2hpUHVRb25ub3BR?=
 =?utf-8?B?aW5MSE9kY0V2QVNEYXhLcHp6enJ4SDRoVGRxeGlUWGo0SGFvNDljTkVnSjFa?=
 =?utf-8?B?enRlODRSMGs5RDEvcEE5NkJwWHVPUUFxaFRUU3N5akxJT0xrL0VWVzVCU0dT?=
 =?utf-8?B?VzNUNkxzSy9JTE9MQU9UQStaTjdNSDY1MGlEejVtSkZLZG5IZ3R5OTZja0Y0?=
 =?utf-8?Q?X6tFGVxTj+GTTvTo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed09c96d-2181-4abd-5da0-08de7290e6a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 04:06:20.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDpFAmVyCAPGmu+wGSdEbHhtt73LWPkbyw+2QHFULXZYs/mwZnxZiQPVR1dnR1IrJ7kAJLtBY/HzB5pAF9G49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9596


On 18/02/26 2:57 am, Niklas Cassel wrote:
> From: Koichiro Den <den@valinux.co.jp>
>
> Some endpoint controllers expose platform-owned, fixed register windows
> within a BAR that EPF drivers must not reprogram (e.g. a BAR marked
> BAR_RESERVED). Even in that case, EPF drivers may need to reference a
> well-defined subset of that BAR, e.g. to reuse an integrated DMA
> controller MMIO window as a doorbell target.
>
> Introduce struct pci_epc_bar_rsvd_region and extend struct
> pci_epc_bar_desc so EPC drivers can advertise such fixed subregions in a
> controller-agnostic way.
>
> No functional change for existing users.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>   include/linux/pci-epc.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index c22f8a6cf9a3..f7f48f43d370 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -203,6 +203,30 @@ enum pci_epc_bar_type {
>   	BAR_64BIT_UPPER,
>   };
>   
> +/**
> + * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
> + * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
> + *
> + * BARs marked BAR_RESERVED are owned by the SoC/EPC hardware and must not be
> + * reprogrammed by EPF drivers. Some of them still expose fixed subregions that
> + * EPFs may want to reference (e.g. embedded doorbell fallback).
> + */
> +enum pci_epc_bar_rsvd_region_type {
> +	PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO = 0,
> +};
> +
> +/**
> + * struct pci_epc_bar_rsvd_region - fixed subregion behind a BAR
> + * @type: reserved region type
> + * @offset: offset within the BAR aperture
> + * @size: size of the reserved region
> + */
> +struct pci_epc_bar_rsvd_region {
> +	enum pci_epc_bar_rsvd_region_type	type;
> +	resource_size_t				offset;
> +	resource_size_t				size;
> +};
> +
>   /**
>    * struct pci_epc_bar_desc - hardware description for a BAR
>    * @type: the type of the BAR
> @@ -216,11 +240,15 @@ enum pci_epc_bar_type {
>    *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
>    *		touch, then both BARx and BARx+1 must be set to type
>    *		BAR_RESERVED.)
> + * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
> + * @rsvd_regions: fixed subregions behind BAR_RESERVED
>    */
>   struct pci_epc_bar_desc {
>   	enum pci_epc_bar_type type;
>   	u64 fixed_size;
>   	bool only_64bit;
> +	u8 nr_rsvd_regions;
> +	const struct pci_epc_bar_rsvd_region *rsvd_regions;
>   };
>   
>   /**
