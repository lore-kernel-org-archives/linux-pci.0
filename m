Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794955883;
	b=wctTESJMgfpppsLg4lZnwvYdSAefZgsLa5a+VkLO9TS5jOe/ZqtaYvrd2KXvPMNwMRp6
	 iAIdODtzvxspdzM/7N3YmcgmTHcl9CiN0kkfQiFk7wW4ptVmP1DZKKhTNXHUN+/YsP2kb
	 47V97nSKy/H181lQkkc5XDs4PX4g2rStbZb20NDe3m4hwXMvnxx/fo7JzjOlq9p2vLEyT
	 3yWUwbdV8h1ePXMaaT3YOEYyLV8VsGfPutE4FMVpyR2lsd1pbSNmRgH+UB0srMgeFcofy
	 g6vXW1GVxPqwPyLMIhsdxEc0BvMZjoUa7nreWmuvzcUnd5kBUtC/rTwOurZasNH5p/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955883;
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
	bh=NVyRDR0H+lkRz3v40K2M7Kogl/9zmN4MTgBUbPYA+W0=;
	b=Hz5AnnF0bzRlrGhKU8MO8gRynF9rXFSCb494aeX/hRvpE+eM01/mxOgndq/bJt5XKvqR
	 Q+a3SznBk4pGbTFiAluYpT8kDwYhhuXJd/KFucaOnryLckFK5Hz9qtKjVrF2wY5k4aL8r
	 0TT+itBnakR3qrg8pkqKKzbU2UnZ2VfkipZf7XWx7o4XsRTsc6gVBH17YUF6bMjdxoFzk
	 sClJfgu6oGbBNjI4sPOpKJ5rsVHwej7dtWBZcTaxEjZkzDleTYQelGDBC9ogY8vbMpH0F
	 CHC4q6bf9A747gHKtycUVyOk7L/ud/nt0gX9KYgx2A46+fsliifGiY0oqWX5EIDMjPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kZYZPwuB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.67
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938C606A31C;
	Tue, 17 Nov 2026 22:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2938C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kZYZPwuB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gezDwUVO7SLxe1LgMbLusRPZimFh9r2PUDgkrZcRVoqLhPHc52Za6kgAQcAYVtgQQP5b2WsQ7PQapfjhrA2qZNGiCHAdImYCk5k8hGv0XdcdEVChnRiZjG+Jn5d4DZhaRqxfFtjEr1Id2NCOlvBKYWDggJjYyzygCJzeofqZ8DNx9rbK4IKNaLHgWA7FzIENZPsTy6fPaN9POoIluWnOqH7dfLBQCORCOAME1mYhdiwBWITF+iGP46XY0ihDZ46VC0pfGAliAzZ1y1nJQEWLsyC5g2cuQ1jnDey9eys+8YkavCpP16X9P1Bvj5l27DOXoP3Dj5Ygl+22S7/Ml+CQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVyRDR0H+lkRz3v40K2M7Kogl/9zmN4MTgBUbPYA+W0=;
 b=afUPWyLWoitnX55krg5K9cB9bZ8fotOtJDlkaF86xiwfEsng08oNZQfYOMPj20ywCCVjfcQiuUpyu5W1ZRVwgRdCUW9dY8kZkbhib3xK2FP7k0+eEmeZSHZYxvHAv5nD40rckNPbCqmXxJUYUbgCIAB62qFTsT5TFO1DXhm0GwnI1Bav7rHyWRNea5PwMU/fb+JWUHHLZmdRssDEdA1B0XNEUW4fhXhxYdMCdIVHoCpdQ0WJ46ZChBdq1pv82YcmHh4n2AZJucB9s8iLWfb4r0FjbExh7tC7tNcjYRgZDks1Xg5XKD0Tqo0JpiP4N0ZhQO+U5oisbce6y2l2ieEqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVyRDR0H+lkRz3v40K2M7Kogl/9zmN4MTgBUbPYA+W0=;
 b=kZYZPwuB43X7B4I9G5gefi/bjx70HyU1jsxip9+NZJI0o/99wxIIgLQPuJPNAG0LAzuwn4VjQnYXLMus0rLpd9lrwq0QQI2zl+nKiH1lh/HWKRm6Mw6a6CfvpV2YYDAluCPZh0t0WBjXOtVpcHDqk+AIK3QqdXOUD7LVfbPCKkE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by LV8PR12MB9155.namprd12.prod.outlook.com
 (2603:10b6:408:183::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:51:17 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:51:17 +0000
Message-ID: <5ad83fd6-b1ae-460c-92a1-0c8a1797cc33@amd.com>
Date: Tue, 17 Nov 2026 16:51:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/25] dmaengine: sdxi: Encode context start, stop,
 update, and sync descriptors
To: Tycho Andersen <tycho@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 John.Kariuki@amd.com, Jonathan Cameron <jic23@kernel.org>,
 Kinsey Ho <kinseyho@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>,
 Stephen Bates <Stephen.Bates@amd.com>, Wei Huang <wei.huang2@amd.com>,
 Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-19-3668ccc7aab8@amd.com>
 <auyz2Zgdfx9VdYeo@tycho.pizza>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <auyz2Zgdfx9VdYeo@tycho.pizza>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::17) To CHAPR12MB999249.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3e4e02-9386-42d2-f1bc-08df44fd4a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|261022105027099003|11063799006|4143699003|56012099006|10067099003|261021121427099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fwVhV//mper5I+HoPwuFlGXvP8b/BMq8MDe6s/4UYFb+MsT8jJwBkVNDh/YQzsS9+KwIvpYq1HiAfRQqqxNrpkTH42lF1Qc98jyQn1sEYQSuMP/c7qo9j6tfcWl859mJrqYB/B0g/6CLsV5K9Hh0nsvx6W+p1xhamr1GNuEZ8HN3CUXmdlBpp3ymFbc5JeqnCtXCdMMXLaWORoBnBlK7ZUTroO/RBqw2kjnQ79Ku/W58cS/lmNaj3U2IWDbENQiktQ9I+ogj9PaT5iOr1BglJAXYY+CeKs4KByHDeN5pp+vEm1oZlMeM9KTVz5Z+jFaBYJZq4enVzVL43YC29W959hfH8JffA7NcWVhfn8h0XcWAGQIFfH49M6FOjzvxggy5752NB8f/XgQIakqqDAeav7MC7TGUfc0cArkUk1G0IelOMYpV9MQSi8Dyh5tjqsAvqVKgPFfYGQxwdKXIApTc5eL9fJiceb1Lk+SE8cSGDL7we81WHZtt/Hvql39iNAHajzF7M1jmoEgFRpNsO1slsFARSQ0ZQpRJXZ3AQ1Ccc1NEht16q1yNAQvHDy1ZoOyqexZ/dtzFn2EmMUvDIkM84pDtE26Hqwf2ufXiDUW4JCvLxsMwrvtZdVo+I+Fx+J6W4ZpBvAl1lzm2b5Pp3xf3QdyQArJJoGDjoFRnwK4Y9tE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(261021121427099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEVJZ0Z5UDlyalRCRU1hR1FpMGYwNEc2SkhXQUN0TDAycmFidUdueHV5Sy8y?=
 =?utf-8?B?NW1LY0VwdnpEUWV1T1lLemRId2EzZ1BUcjJ1cThpS0sremZoQVc1b0E5a0pz?=
 =?utf-8?B?eHMwQnJSdytJSDN0QW91OWFhZ1dHWk5qUVkvdEZaNDRaR0k2cWQ4eUpGZERa?=
 =?utf-8?B?OW5tVXFXazM1Mlp2V1RsbkhjN0lnbnA4cU5kbUVHOTREN1ZLbGpXZERTOVE2?=
 =?utf-8?B?U0g3bGw2TURCZzhGdTQ0QW1rb0h6L1JWb0VvRXV4WDBjdVVWbXNOdDEyeEpM?=
 =?utf-8?B?VTJOQzlGZXJHS0RWZHJEUEJWZC9QZHFLWjZSTitKTjFlU2g4OHdrNVhhMCtj?=
 =?utf-8?B?TElCM0Mxa1NIMXJLaVdmanpTMHFLNndHQ25uendSdjdHTW5aODFqVnpZZnE1?=
 =?utf-8?B?dkQ0M0ltTDBscTVTYys5d1IzYTRGdVNRY0h6cHVKcSsvclB6TnR3TzZSaERI?=
 =?utf-8?B?a3VPd3lBVWxSbkZxME12WHJZU0lCWWo3K2pUbC9xZE5KYTBRUnFLZW1vT2dz?=
 =?utf-8?B?bGFQTGhIeW9nZnkyTXp3NjUzNTRKVkZHcllyWUlPQWcxNzRiT0pONi9Xc1JP?=
 =?utf-8?B?N0dGYTZ0dGMrdS9UeWJ6L3dDbXlBVm8vdTUvY1k2TDhjYVFqSkU3YU85T2lu?=
 =?utf-8?B?VmQyZE9pMkJuQ0V2ckdFUTRoZEtFOEFzTFc0T2JkMXhGN1FRM1B6aUFQNU5s?=
 =?utf-8?B?U0RRMFZCeXd1Y29uNkRTaHRKVUdlUTVKYjRsY1BTWHhiVm1kNmRaM3FJaDgw?=
 =?utf-8?B?MGJIcjgxWlYxZDZoUVd4d2V6OURURGUzTkR2WGZ3cWY4QktacnY4NXFTbXZC?=
 =?utf-8?B?dWhNWGVvYnpOZHZiMUE2V1d5aVk0eDhiNUN0Vys4ajB2bkZabzJUM0MweG1T?=
 =?utf-8?B?ZXBPU3JsbWt0cmVqb3ZrL2wvT1J2M1BCc3hEREdOSDhtdVNIMTJtMHJnS2FE?=
 =?utf-8?B?aEVQckxNSnpPdm5XZWRQL1E2N3RmaWVuMkF5MGhucFNVUnJFTUNDaERoMEZD?=
 =?utf-8?B?aTN6K2FVY1lsUjRjRGlWS095TjNHK0U2U2JvVjMyWVQ4NE5QVytUaEFlanNC?=
 =?utf-8?B?eXNpcXp0UUR2VWRnYnVvK2t1V1VJUGNLNGlCVzBUZ0o1Nzd5WUdYWWxBK2Ny?=
 =?utf-8?B?YVFydXp6ak94Y0FKSGk4ZzlzQSsxUHVMcFlBcE44TExxVGdyUkQ4YVVCVFFi?=
 =?utf-8?B?NUt3Ri9sZ1d2LzJzcks1TUtnQjY4Z1I0Ry9kLzhVWGhGRnRadDJKZ0hOTDQ5?=
 =?utf-8?B?TlJXVFlRSEs3S2xoTlpDNU9YT3M1ZG9LbGNDQVA1eUxNdG1NeDRXQmZqZFB5?=
 =?utf-8?B?Z3Z5WHVrY0l3SFB4TUZEUTlzR3pGS3B1WUNBN2NYbFY2bzBHS3VkUlpFcXlB?=
 =?utf-8?B?UUdqaXVYTFJ2Y0Y3ak5NSmpxNzFEZjIwa2wyK2c3TTJqWnhXb3VpVGpnUTM5?=
 =?utf-8?B?dzZ5TEdMbVZGaWo1TXVHQWVlbkh5VklRWFFiQUpCcjY5b1lRRXRRd0RBMHA4?=
 =?utf-8?B?Ulp6Y2xSbHdhU0J6MXFXaUVLakJVZU5XdmJscVNsYzIwOEJTRTYvcEdtTWw4?=
 =?utf-8?B?Q3VndzFRL3A5S08wTFkxOFlLUWVJMGNUUHl0cit5bktIbks1SEJITXI5NHZC?=
 =?utf-8?B?RXhRYW9ZZlJlM3VYRjQrU1dtbzlnb01ZVXB3TVM5MHI0alUwN0N1SG5zbnBH?=
 =?utf-8?B?cnBPbzV4MHRDZkdOLzNhNUJKb1ZOeG1iNjAyb3Z2YVFITjlMSjl5TWJjWmFn?=
 =?utf-8?B?TTIvVUNMeGV5cDJpakQ0WkNpTnRQdys3OXVydDBDZ0dvb054RHk2SU5VN2ov?=
 =?utf-8?B?RmxGN09rV01uOE1WaDA5eThZcG5LeEM0ZG1MZHFoY2dkditqK3VEVXcxMUNH?=
 =?utf-8?B?UnI5SW1kVEpYb1I3eW1IT0VXQk9rY3NLTlRjYyt6NFFMamhjemhCNGJYMXNn?=
 =?utf-8?B?Nzh0WUZNWUcxaDh4TUxDdmF5MmFEa0NwUkVRRGl1S0RUQXFlaFExa0dwaThO?=
 =?utf-8?B?N0Z2VDYxMWNJRW0vTlRUZFFrZk9LVFdheEg3bksrNHVyOGR4MUFsQ0JrNEJP?=
 =?utf-8?B?UWdUYlVOM0t5NGNnMUZxMEdBeE1DUWV4Q0tMTnRDaDFkdUM1YllUUTNTT3JE?=
 =?utf-8?B?OVQzRDJyMnB6aE5jdEtKSWJ3L2tRZ25XQ0VadkxhZDZqTnJaWTh4YWNWalUz?=
 =?utf-8?B?S2hRQXA5NnJHUG44ZVBPWlNJai9taW9taFM3MFFsamVvMEIwdXFvUnV3WHo5?=
 =?utf-8?B?VXR6U0k5V0Z3UndLTVF2WmxOeGlGTFpSLzZGWkJRWUxnUDRJbWEwSkFTekhB?=
 =?utf-8?Q?McZ/jFH1UFJJVuoZ4V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3e4e02-9386-42d2-f1bc-08df44fd4a29
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:51:17.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFW9/iDPcr0Sbkm802cU9WO5yt6mRXyppfAb6L0MuNnBT1wTgWHO5qRMi+l4HK/vKTN/FqXTqv3zZv2tivdfKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

On 11/5/2026 10:52 AM, Tycho Andersen wrote:
> On Tue, Nov 03, 2026 at 08:50:00PM -0600, Nathan Lynch via B4 Relay wrote:
>> +int sdxi_encode_cxt_start(struct sdxi_desc *desc,
>> +                       const struct sdxi_cxt_start *params)
> ...
>> +int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
>> +                       const struct sdxi_cxt_stop *params)
> ...
>> +int sdxi_encode_cxt_upd(struct sdxi_desc *desc,
>> +                     const struct sdxi_cxt_upd *params)
> ...
>> +int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params)
>> +{
> 
> These four can't fail but return something, and their return values
> are never checked or used. Maybe worth changing them to void.
Sure, I'll change these and the other one you pointed out.

