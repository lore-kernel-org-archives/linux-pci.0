Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661125;
	b=UtrB6ImJTs4gS3rZfaHpH1JHWsC8aQe6lRVGurEukMtb/6ZiPXDsLwJWcyuBeJDjv0Uz
	 0EkzaB8DhOOTXHL8GiywvcgtYVOAZ46BfCiZbTgvMT3p/mjrtA33LxYjBfX9fwZubylKV
	 swsqty/pwnCt6drHOdIlfx6gf7tlBImxRjeF7SScIY7D5oeqPo4vorNzIPS0ulfTS7AWS
	 Q2jN9NBdJziy0T0HKoryJW0cFawuo5muKNloxtxoLD9eu1q2vY5NcV0WUQ0Y6A+cJVP3A
	 uHi1bGixPzdTjAiz3XKz1UxBU5KtJjDk3/c12hkVzHKwE4kqsRPMjr5rVw0MhA8YwbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661125;
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
	bh=21fUvT5UlSNJ9uKz5ElP96zZ2Qyb7d6eacX885ali0c=;
	b=F90XCIvKqruAC4yHlMILQrVBWLgmmo/wh9IdAIn2SvtLHPuS2+zmhnKmE2sEGjPoaW+F
	 t/+V/GsjHkewjXQ40AdUYQqMlxxj000tbgjj0dvgQ3QeVODNznylwwzWbRW6FDKa37d3b
	 kqlLYwKOCJKVNvKpziXej0fpn2QjXm/+ck4TowX2iuWTPlUAYz4wQNW/bFpxqg8niHsvn
	 qtoiNa3Y5K3ouw2coN8yuv7Dn5fDkT1Rqo8LRaRy/aWlCXHGta/GRXqwU39TgQvdOoU+R
	 Ih3w9diKNkpnoTtRpfeFz5ox0cGQwRMxkJPLOY+OR7SSBoBz/E3iJsfD+/K5T4IzPKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aq7Snd+C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.25
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA9606A331;
	Thu, 26 Nov 2026 02:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78FA9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aq7Snd+C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apqmY70N31LZd6YKTsMi480AwNukYUcjJmbNMS7nBigNAQaInscxWsJyBX+AtLSc62n8w9I87JmA0qDZ/uPdlyzWpwiGO4WyOjOjHyBX4ERVI94OowTweS0/zytH4LKmiyfZUhltUYyDm/Yrxn4Z8HJG//Od3XyEVaM6qsTOWHhi2qwVHYy2DKw4mxR5mm3U7fvKuer7mhAIgetTqAOqVSpq2XYEUf0wH3sv8qAgk3ez/MJ0I1t5z/1t364y3sYa+MHJXXOnG7aAOw+oj3rvdpUFGfxKVyM2wMr6bjenjdcFUOS/zwy9JOObHQk2DLjzNjxpjyu7qFaQGxp2tg3Njg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21fUvT5UlSNJ9uKz5ElP96zZ2Qyb7d6eacX885ali0c=;
 b=YWVukoLy6JJNlEvsIwgnzNYRLZkuzVJAeKwVS6Hb1O/7vJj5k1BNT3muZtlOAU62VidjSlH6d4rKOfPJKrRrL7fpXU6zfEsw8jOHC3uOOCaBmSUGFM4hIOMYK5QaiD1kdz2SOZvSoCF1208cmPIzKtCsBWyeV57cehPj6iYVC4hiPWp0XtxBk2pMPmTXdGAc45evcmiU9w7f41ngqcfM3L2NNFQG5HCohY0rBYl45coF5pmWOeIziidCWJwTGwI9pALyblK7i3F3VFFq3/slIxSfuHmJyser0SQu8Hn8iUWdoSSoRSD8FM2mnGSIXOFIFw0jh+pHZPyrBERGBnT/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21fUvT5UlSNJ9uKz5ElP96zZ2Qyb7d6eacX885ali0c=;
 b=aq7Snd+CQhhKxQuJ9XOcbZo3b0Z+9omMizWjPnpmPKy+KYsL9jdppZuuxB0GcqjjjF0U9rFgh9Rq0rye+gV4zs4SXMYuE37DILOJzNrmF0supyaQ4O7pzY1YKkM+2aQsH/ESXfklFRcjpjguq/V4r2NeTfM9GdQBy337+GDrt76aGIhdLseeJTHzjtsJKiy3Y9Ok2k9zpT6W0R59HlnUZLP5mg+TcW/q538qWhAWwUI/1cqgnLY7DmTdck7H4wV0UUmzv5lytHsjnVCzxEsJYIq6PAOMP5cDklsR+8knf8h/8LpCprXTCykjHVtnsSCBg4tI3ihvzC+JDBLmUbjV2A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6)
 by DS0PR12MB999264.namprd12.prod.outlook.com (2603:10b6:8:42e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 02:45:19 +0000
Received: from CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b]) by CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b%4]) with mapi id 15.21.0639.012; Thu, 26 Nov 2026
 02:45:19 +0000
Message-ID: <abc4a0e3-2478-4b12-8a06-ffc81196bd20@nvidia.com>
Date: Wed, 25 Nov 2026 21:45:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] vfio/nova-vgpu: add the Rust VFIO variant driver
To: Alex Williamson <alex@shazbot.org>
Cc: dakr@kernel.org, acourbot@nvidia.com, kvm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 linux-pci@vger.kernel.org, jgg@nvidia.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, airlied@gmail.com,
 simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, jhubbard@nvidia.com, ecourtney@nvidia.com,
 cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
 ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, linux-kernel@vger.kernel.org, zhiwang@kernel.org,
 zhiw@nvidia.com, boqun@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, work@onurozkan.dev, jgg@ziepe.ca, bhelgaas@google.com,
 kwilczynski@kernel.org, dri-devel@lists.freedesktop.org, peter@colberg.org
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
 <20261119215046.2892839-10-xinmengs@nvidia.com>
 <20261124201931.55c65263@shazbot.org>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <20261124201931.55c65263@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::25) To CY5PR12MB6549.namprd12.prod.outlook.com
 (2603:10b6:930:43::6)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6549:EE_|DS0PR12MB999264:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7a733c-02d6-41d7-6ad6-08df4b674ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|6133799003|261009223027099003|18002099003|22082099003|3023799007|56012099006|4143699003|11063799006|261028144727099003|261102123227099003|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	kJEDcitHsV3l2lBgtkpSpRr1XRINVrnI8ZTlqgx7QHRe0XkmubO2XHNkIy6/P+gj1fvYO2NznjA5lM8ESRhUeCiuONJVTmddcFUC+WGaoMeNgTz1L3dH0y7rzTp9eazj0UXizjdg3OdQRvhliLiFfuVi3mj5hZCIeXMfRlol4HFLs/9jeTrss07xOyX4TUpJrJPt/4QMQnwTDyh14LPPfDKGQKKxeIYizXWEKVKQztQKnIs8AY3/ZFqecpmXCsVpBYC+GQGYcMUsr5qjr7jFlly0398lU0drhANt9I1wUNXt5r+8uKc/M3yttRzjJabmYUkfoq9Bslt1ERzzrW5Pu5PQmY0FWU+rnpHHjS6M4ssIQJY1eZW4aogj1PkPiCgiX1NZoL6ZaXBHKax0jxZ+z7edHKNYkBffEzymd/aiYXUV9QQg+PDfSIQQzsPw07T2War0x3m0gCEa0oOP1cKrEJMu7A/Eg6BWpMQhVgjN1WsTDEfC9QacxsIN8vWSWkbdxCewxSNWwaodmLHufvC2f1DjLPzxHOUvhYWFjewXVKGXYpXffFWyNz2dd8kkztuRUz8zDg3ZrZqGgnvi7RZa5JhHN2c+G/rkjvHa+CIqhXOPMVUbIHLRClvEOQJEjX3y94VMwILET5Op49I0YLXtKZsXB6wRCWtnfwY+OE0ZBm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(6133799003)(261009223027099003)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWp2bFE4VEt1anlVaWR2WEVhNWRoWU1RWjU3cDkwOWwzdnMwNjUzRCsyODdw?=
 =?utf-8?B?cm40QVlJTEdiMXI0bGNxMCtuRHVOcS82K2lMeVJBUjF4TXZoNlVtSVZ5aHQ0?=
 =?utf-8?B?cXRoUVhzQ1M2OFRBa2NPNXEzRXRvU3YxSWRuRnpoK2tqUVNEQ1Y5eWtxK0VL?=
 =?utf-8?B?YkI0bkZTK0loWnlaSXJwZG9iaHNoNXZJNWRlSFJrTDlTelVBOVVYMGhDMWxu?=
 =?utf-8?B?TG01cG1RS0lJT3h5RStJV0MwTUl3RnJPcE95cTZXYzBwVUhLL1huTFptUkM0?=
 =?utf-8?B?UERMOEIxY21NRXJPQngzb0FGYW5jRzV6S3MvSTlENVgzOE1RRmpxL2NQREdH?=
 =?utf-8?B?K2RGTXFBakFWb3VxUGNSVDZvRkVzS1JCYXBwbFE0ZWhpYjl6ajRkeG5IbjdH?=
 =?utf-8?B?aTc4UkpOMHBWdGNuNmR3em9rQVZDV2wwVDkySmlVTTVvT1N2a2Q4c0JIRzJl?=
 =?utf-8?B?S1hyNk5TYVozWEhWWjlvRDRodGxpRFVtb0pUSmxEaGh4V2Q4aUZRcVBnM0g5?=
 =?utf-8?B?RWxBQlptRGljSWpSM2VOWXhNWW5iWUlHRVB1emFBVVBUcndHOE9INzRFcHRU?=
 =?utf-8?B?YitSZWpvT1ZFOGN6M3lhZmh4VUs2MmJ3Y1R2UFNKSHBOcFVXL29XTGk5U2gy?=
 =?utf-8?B?TnhkN0N6WFZJMzUyVlYxQXdzcnAwNUhKc1Q2TTAwRVRUUWoyeXpsdmpnVkRT?=
 =?utf-8?B?TE1pcnBUdDVsdlZKK1ZNUHduUDJ1L2oybCtUcWJUdm5CNi8rSEEraUdmdldP?=
 =?utf-8?B?MEZkbFdJNnp4MlFrZ3VoRXRvYjBkK3g0MHFzWmNqTVhMeEg4WjFmeHdWdkcy?=
 =?utf-8?B?UitFY3k0WlVNejhzMUVIK0hXUHBMNUJXZ0YwejN5ODhsQ0MrTEJMcW1TNEtN?=
 =?utf-8?B?OWwvTmpmYXhKUFZGUEJYMzVQOVNxYkMyUXdSOFBHc0lpSnI0cHFYUGljTzl0?=
 =?utf-8?B?Y2xBZERrbDVlWTRqb1QrRGJpcEVaK0w1ekxnNlA2OEtlZTNEMVRDTVVBc1dH?=
 =?utf-8?B?VUIyK1VtLytOQ3pma0Mvc09WNHFnZlVGUkFwWS8zZUVKcVVDY01aeS9wdmlZ?=
 =?utf-8?B?eUEwbmttRk80QSsydXBsUmdjNTBZZFF6cnJjM1Y1MWVCWTBpZk5ZUHpiaDFJ?=
 =?utf-8?B?QlNlVnl1WnBxbWYxRnBQdVBvYnc1cXZNcm1PU1RkeXorRlFmcFVJSnFuL01S?=
 =?utf-8?B?T3ZLVU96QVpLS1l1Ry9DY1plYnNieDQzRldaZnl4NUhlWjEzUHQ3ZnlaNG1K?=
 =?utf-8?B?U2ZxVzRaV0V1cjN6SnU2OXdjNWZvRkRSZUlWV3VkNzN2Y2dRQk9LbDl6R1dz?=
 =?utf-8?B?VUU0QnBuSEl2emNqZU9jUGtoS3hkY1NndW84OVFMWFhnWjlIelpGMVhTMWx0?=
 =?utf-8?B?MGVZd2pzQUFPenI5MVlRdVlPMC9OSVUvRmdyUEpaQTlvL0o2TE1LaERCYUU3?=
 =?utf-8?B?cUZwRnFVZmpkeC8vUkZ5cVYrK3ZBbmVOR0cvelg5YjRkN0g5TGI2SEpHT0Jn?=
 =?utf-8?B?ZnhQQjNSSkc0dktuUmlGNnBpampGbXp3Qkk0MHRWUkJFc2Y0TkNZU0wva2JM?=
 =?utf-8?B?OFpuTGFqNFowa2s5VnIrOGRLL0dwYktuL3d6Vmd0WHhydmVteHdSL1dYdnlK?=
 =?utf-8?B?U2xRQVY1UkIyVVdNSC9kR0pVRjJBaklpWnhVdEVKc1lWYjE1STcvcmptTWw4?=
 =?utf-8?B?Y3E5SGs1dHYwTWxIUmhEdTVsM1o2Tkx2a0xFS2dzMkh2MlU5UGZmWkRibVVH?=
 =?utf-8?B?MVExbVQxdCtoWWIrNjBFelRLekQwZitDNDJmbDJoeGgxeTRPNG45TUMxeFNG?=
 =?utf-8?B?aFB3QmZDK3dMMm95VGtGNjIxbzVieVlUUnhvcEhwVHU4a1NYZno0bk1OSm9G?=
 =?utf-8?B?bFlWV2RBcWl0bk1iUGswUUNFcTkxNGI4YzJxYXdGelFhT3YyWlYvcytTcE8z?=
 =?utf-8?B?REk1T01ldDNlc01LTlB1eThjbFpQaEk1OWNjQVlHNVZNTTZVYkJnQmJUOC9n?=
 =?utf-8?B?cHY1UE0xNDhXYzdoSDBGS21LcktrbzMvMGFzalE4WUNRdEVMTm5xY0QreWZ6?=
 =?utf-8?B?NmQ5cjFRN2ZKdGl2S2lpL1k2dTZwemZBRDdjUUhmWWczMiszY2VNbVN5bDJh?=
 =?utf-8?B?dXU2UEJxcjV2MWd0eU9tUER2NXdFc1ZvcUErRERTemcxTW9BZHo3RnVhQlZW?=
 =?utf-8?B?MWhVTE1qMUFQOHptYUNHM0dCdTdDTEpJYTlPNEFCdkRFZmY4dEt5bGdIdHVt?=
 =?utf-8?B?NnZPa0FLenNPUUVJSWgvRjQwb2xkTTBqUmdMRVo1VVYrTFZiNjF1NndWa0JC?=
 =?utf-8?B?dEQ4K2c5d05Ma05ybGFBZFBEd0ZkS1BWUGYyVWk5dWh4QjcyeTFVQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7a733c-02d6-41d7-6ad6-08df4b674ef5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 02:45:19.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/2iYWHuzhygvAi5M9WarFcwgGPoAEQVX6fpyMUQSvX/5G+RSRijMyZybXPGwxg6xxqkRPy7cBferjtcy/VYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999264

On 11/24/2026 7:19 PM, Alex Williamson wrote:

>> +    fn bar1_size(&self) -> Result<Option<u64>> {
>> +        let Some(instance) = &self.instance else {
>> +            return Ok(None);
>> +        };
>> +        let physical = self
>> +            .registration
>> +            .pdev
>> +            .resource_len(self.registration.fb_bar)?;
>> +        let size = instance
>> +            .type_info()
>> +            .bar1_length
>> +            .checked_mul(1 << 20)
>> +            .ok_or(EOVERFLOW)?;
>> +        Ok(Some(if size == 0 {
>> +            physical
>> +        } else {
>> +            size.min(physical)
>> +        }))
>> +    }
> 
> Does this provide a power-of-two size?
> 
currently it does not, we can add a check for is_power_of_two:
--- a/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
+++ b/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
@@ -120,6 +120,9 @@ fn bar1_size(&self) -> Result<Option<u64>> {
             .bar1_length
             .checked_mul(1 << 20)
             .ok_or(EOVERFLOW)?;
+        if size != 0 && !size.is_power_of_two() {
+            return Err(EINVAL);
+        }

on a side note, i think vf bar1 of 0 can be a valid case too, so i should remove that check in next respin

>> +
>> +    fn limit_bar1(&self, buf: &mut vfio::UserBuf, position: &Position<'_>) -> Result {
>> +        if buf.is_empty() || position.region_index() != self.registration.fb_bar {
>> +            return Ok(());
>> +        }
>> +        if let Some(size) = self.bar1_size()? {
>> +            let offset = position.region_offset();
>> +            if offset >= size {
>> +                return Err(EINVAL);
>> +            }
>> +            if size - offset < buf.len() as u64 {
>> +                buf.truncate((size - offset) as usize);
>> +            }
>> +        }
>> +        Ok(())
>> +    }
>> +}
>> +
>> +impl Drop for NovaVgpuOpenData<'_, '_> {
>> +    fn drop(&mut self) {
>> +        let mut state = self.registration.lock_instance();
>> +        state.active = false;
>> +        drop(self.instance.take());
>> +    }
>> +}
>> +
>> +impl vfio::pci::Operations for NovaVgpuOps {
>> +    const NAME: &'static CStr = c"nova-vgpu-vfio-pci";
>> +    type RegistrationData<'a> = NovaVgpuRegData<'a>;
>> +    type OpenData<'a, 'data: 'a> = NovaVgpuOpenData<'a, 'data>;
>> +
>> +    fn open_device<'a, 'data: 'a>(
>> +        dev: &'a vfio::pci::Device<Self, Open>,
>> +        rd: &'a NovaVgpuRegData<'data>,
>> +    ) -> impl PinInit<Self::OpenData<'a, 'data>, Error> + 'a {
>> +        NovaVgpuOpenData::new(dev, rd)
>> +    }
>> +
>> +    fn ioctl<'data>(
>> +        dev: &vfio::pci::Device<Self, Ioctl>,
>> +        rd: &NovaVgpuRegData<'data>,
>> +        _open_data: Pin<&Self::OpenData<'_, 'data>>,
>> +        cmd: u32,
>> +        arg: usize,
>> +    ) -> Result<isize> {
>> +        let reset = cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET;
>> +        if reset {
>> +            if let Some(error) = rd.state.lock().reset_error {
>> +                return Err(error);
>> +            }
> 
> Is a previous reset error effectively unrecoverable?
> 
yes, currently the behaviour makes reset error sticky, we could make the the vfio driver to be able to try again, 
so errors in reset_prepare would be stateless and allow vf to try to reset again, something like:

@@ -171,14 +170,8 @@ fn ioctl<'data>(
         cmd: u32,
         arg: usize,
     ) -> Result<isize> {
-        let reset = cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET;
-        if reset {
-            if let Some(error) = rd.state.lock().reset_error {
-                return Err(error);
-            }
-        }
         let result = dev.core_ioctl(cmd, arg)?;
-        if reset {
+        if cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET {
             if let Some(error) = rd.state.lock().reset_error {
                 return Err(error);

@@ -260,11 +253,10 @@ fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
         // close release this mutex before entering the VFIO core.
         let mut state = rd.state.lock();
         state.resetting = true;
+        state.reset_error = None;
         if state.active {
             if let Some(vgpu) = &rd.vgpu {
-                if let Err(error) = vgpu.api.reset(vgpu.gfid) {
-                    state.reset_error.get_or_insert(error);
-                }
+                state.reset_error = vgpu.api.reset(vgpu.gfid).err();
             }
         }

this also remove the hot-reset check and address the comment regarding intercepting hot-reset:

> vGPUs are VFs, why are we intercepting hot-reset?  That's a different
> class of reset that VFs don't support (unless we're running on s390).
> 
>> +        }
>> +        let result = dev.core_ioctl(cmd, arg)?;
>> +        if reset {
>> +            if let Some(error) = rd.state.lock().reset_error {
>> +                return Err(error);
>> +            }
>> +        }
>> +        Ok(result)
>> +    }
>> +
>> +    fn read<'data>(
>> +        dev: &vfio::pci::Device<Self, Read>,
>> +        _rd: &NovaVgpuRegData<'data>,
>> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
>> +        buf: &mut vfio::UserBuf,
>> +        position: &mut Position<'_>,
>> +    ) -> Result<isize> {
>> +        if let Some(instance) = &open_data.instance {
>> +            if position.region_index() == vfio::pci::CONFIG_REGION_INDEX {
>> +                let offset = position.region_offset();
>> +                return position.with_temporary(|next| {
>> +                    let count = dev.core_read(buf, next)?;
>> +                    buf.write_overlapping(
>> +                        offset,
>> +                        count.try_into()?,
>> +                        u64::from(bindings::PCI_SUBSYSTEM_ID),
>> +                        &(instance.type_info().pci_subsys_id as u16).to_le_bytes(),
>> +                    )?;
>> +                    Ok(count)
>> +                });
>> +            }
>> +        }
>> +        open_data.limit_bar1(buf, position)?;
>> +        dev.core_read(buf, position)
>> +    }
> 
> Why do we virtualize the subsystem ID on read and the device ID on open?
> 

This is done intentially, as core viratualized it in vconfig, where it is set
at open, while the core read subsystem id from hardware, will add a comment: 

 // A VF has no device ID of its own, so the core keeps it in vconfig, where
 // it is set once at open. The core reads the subsystem ID from the hardware,
 // as a firmware update can change it there, so replace it on every read.

>> +
>> +    fn write<'data>(
>> +        dev: &vfio::pci::Device<Self, Write>,
>> +        _rd: &NovaVgpuRegData<'data>,
>> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
>> +        buf: &mut vfio::UserBuf,
>> +        position: &mut Position<'_>,
>> +    ) -> Result<isize> {
>> +        open_data.limit_bar1(buf, position)?;
>> +        dev.core_write(buf, position)
>> +    }
>> +
>> +    fn mmap<'data>(
>> +        dev: &vfio::pci::Device<Self, Mmap>,
>> +        rd: &NovaVgpuRegData<'data>,
>> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
>> +        mapping: &mut Mapping<'_>,
>> +    ) -> Result {
>> +        if mapping.region_index() == rd.fb_bar {
>> +            if let Some(size) = open_data.bar1_size()? {
>> +                if mapping.region_end()? > size {
>> +                    return Err(EINVAL);
>> +                }
>> +            }
>> +        }
>> +        dev.core_mmap(mapping)
>> +    }
>> +
>> +    fn get_region_info<'data>(
>> +        dev: &vfio::pci::Device<Self, GetRegionInfo>,
>> +        rd: &NovaVgpuRegData<'data>,
>> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
>> +        info: &mut bindings::vfio_region_info,
>> +        caps: &mut vfio::InfoCap<'_>,
>> +    ) -> Result {
>> +        dev.core_get_region_info(info, caps)?;
>> +        if info.index == rd.fb_bar && info.size != 0 {
>> +            if let Some(size) = open_data.bar1_size()? {
>> +                info.size = info.size.min(size);
>> +            }
>> +        }
>> +        Ok(())
>> +    }
> 
> BAR sizing in config space also needs to reflect the virtualized BAR
> size.
> 
right, the BAR sizing through config space still not handled in this version, sizing through
config space will still return the physical size, in the next version, i will add code to
return virtual bar size to match what region info reports.

>> +
>> +    fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
>> +        // PCI holds the device lock, and VFIO may hold its memory lock. Open and
>> +        // close release this mutex before entering the VFIO core.
>> +        let mut state = rd.state.lock();
>> +        state.resetting = true;
>> +        if state.active {
>> +            if let Some(vgpu) = &rd.vgpu {
>> +                if let Err(error) = vgpu.api.reset(vgpu.gfid) {
>> +                    state.reset_error.get_or_insert(error);
>> +                }
>> +            }
>> +        }
>> +    }
> 
> This seems very wrong, why are we calling the PF driver reset in
> reset_prepare()?  Isn't there still an FLR happening between prepare
> and done?  Does it do anything?
> 
It will not reset the PF, vgpu.api.reset will reset this vgpu instance behind this VF,
the PF driver would ask firmware to reset the instance and scrub its memory, then FLR
follows

>> +
>> +    fn reset_done(rd: &NovaVgpuRegData<'_>) -> Result {
>> +        let mut state = rd.state.lock();
>> +        let error = state.reset_error;
>> +        state.resetting = false;
>> +        rd.reset_done.notify_all();
>> +        error.map_or(Ok(()), Err)
>> +    }
>> +}
>> +
>> +struct NovaVgpuDriver;
>> +
>> +kernel::pci_device_table!(
>> +    PCI_TABLE,
>> +    <NovaVgpuDriver as pci::Driver>::IdInfo,
>> +    [(
>> +        pci::DeviceId::from_id_vfio_override(pci::Vendor::NVIDIA, bindings::PCI_ANY_ID as u32),
>> +        (),
>> +    ),]
>> +);
> 
> Whoah, this would break a ton of users that are assigning NVIDIA devices
> and depend on the module options supported by vfio-pci (that aren't
> supported here).  This entry marks this driver as the preferred over
> the vfio-pci driver for any NVIDIA vendor ID device.  We don't want
> that blast radius.
> 
> This should list the specific VF device IDs we want to claim?
> 

True, i will update the list to include only 0x2bb3 and 0x2bb5, which are the 2 GPUs we currently claim to support

>> +
>> +#[pin_data]
>> +struct NovaVgpuData<'bound> {
>> +    reg: vfio::pci::Registration<'bound, NovaVgpuOps>,
>> +}
>> +
>> +#[vtable]
>> +impl pci::Driver for NovaVgpuDriver {
>> +    type IdInfo = ();
>> +    type Data<'bound> = NovaVgpuData<'bound>;
>> +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
>> +    // SAFETY: VFIO hands the DMA ownership of the device to userspace. This driver never uses
>> +    // the kernel DMA API for its devices, directly or through helpers.
>> +    const DRIVER_MANAGED_DMA: Option<pci::DriverManagedDma<Self>> =
>> +        Some(unsafe { pci::DriverManagedDma::new() });
>> +
>> +    fn probe<'bound>(
>> +        pdev: &'bound pci::Device<Core<'_>>,
>> +        _info: Option<&'bound Self::IdInfo>,
>> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>> +        try_pin_init!(NovaVgpuData {
>> +            reg: {
>> +                let vgpu = match NovaCoreVfApi::handle(pdev) {
>> +                    Ok(api) => Some(VgpuRegistration {
>> +                        api,
>> +                        gfid: u32::from(pdev.vf_id()?) + 1,
>> +                    }),
>> +                    Err(_) => None,
>> +                };
>> +                let dev = if vgpu.is_some() {
>> +                    vfio::pci::Device::<NovaVgpuOps>::new(pdev)?
>> +                } else {
>> +                    vfio::pci::Device::<NovaVgpuOps>::new_passthrough(pdev)?
>> +                };
> 
> My LLM tells me that the new constructor installs ops that don't
> support get_dmabuf_phys, therefore can't expose dma-buf to iommufd,
> therefore cannot support P2P with iommufd.  But type1 uses a different
> mechanism, so we would be able to map the vGPU BARs for P2P with the
> legacy backend.  Is this true?  If so, why?  It needs to support
> dma-buf.
> 
yes it's true, the vgpu path has no get_dmabuf_phys, would it be acceptable to add this in a follow-up series?
P2P is not in the scope of the first verssion, and i would rather add it together with a P2P test

>> +                let fb_bar = if pdev.resource_flags(0)?.contains(Flags::IORESOURCE_MEM_64) {
>> +                    2
>> +                } else {
>> +                    1
>> +                };
> 
> Nit, why are we setting up nova-vgpu machinery even on a passthrough
> device?
> 
no reason to touch passthrough, will be skipped in next respin

>> +                // SAFETY: The registration is stored in `NovaVgpuData`, this driver's bus
>> +                // device private data, which is never leaked.
>> +                unsafe {
>> +                    vfio::pci::Registration::new::<Self>(
>> +                        pdev,
>> +                        &dev,
>> +                        try_pin_init!(NovaVgpuRegData {
>> +                            pdev,
>> +                            vgpu,
>> +                            fb_bar,
>> +                            state <- kernel::new_mutex!(InstanceState::default()),
>> +                            reset_done <- kernel::new_condvar!(),
>> +                        }),
>> +                    )?
>> +                }
>> +            },
>> +        })
>> +    }
>> +
>> +    fn reset_prepare<'bound>(_pdev: &pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) {
>> +        data.reg.reset_prepare();
>> +    }
>> +
>> +    fn reset_done<'bound>(pdev: &pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) {
>> +        if let Err(error) = data.reg.reset_done() {
>> +            dev_err!(pdev, "VFIO device reset failed: {:?}\n", error);
>> +            data.reg.error_detected();
>> +        }
>> +    }
> 
> I don't know what's happening here, why would a bad reset_done() return
> trigger an error_detected()?  We don't have that idiom anywhere else.
> 

Agreed, other variant driver doesn't have this, i will remove it in next respin.
>> +
>> +    fn error_detected<'bound>(
>> +        _pdev: &pci::Device<Core<'_>>,
>> +        data: Pin<&Self::Data<'bound>>,
>> +        _state: pci::ChannelState,
>> +    ) -> pci::ErsResult {
>> +        data.reg.error_detected()
>> +    }
>> +}
>> +
>> +kernel::module_pci_driver! {
>> +    type: NovaVgpuDriver,
>> +    name: "nova-vgpu-vfio-pci",
>> +    authors: ["NVIDIA"],
> 
> Please name an individual, with email.  Thanks,

will do in next respin.
> 
> Alex
> 
>> +    description: "NVIDIA vGPU VFIO variant driver",
>> +    license: "GPL v2",
>> +}
> 

