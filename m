Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794371301;
	b=4iVhwwSqKy362ejWIw6ZExdHqkUq2GnOZSTZyvS/ZOW3x3qMbc5F7N1uNbd0Wdr6kQym
	 vy3/psp1vjSUHuL8vA6qoPxiaxIs/fXe2504ZjLPr8DjznoYCyZgQepw8df+PDc6W2OB2
	 YzV1tIC38SWJjdmX71nEpj26v23BQqGew7aayzFLo9VihQDurl5owKlMq3ubvl3CwDW46
	 jyellStFK6dLV5jmVRtuB8yAzHtz31vCPxDG5J94ssVp0pS7YUu+d0h1aQndRnZTXnUJH
	 LbifT7YDkrZtkSvXfBlMul5hh8QSz6VpEnE1SW/U1m8AKnleF0PgYAOCmU2vleKIOqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371301;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:Content-Transfer-Encoding:References:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=35Degn5zt/JvR3C+BCJBZuEB/iHP5SNZh9EITfG2lqM=;
	b=MVc+ZkMhjkF8VK6tcJXxHCSKxoykIVEGS7Ynz1kk0wi39/JoIJtDsb+yKpMwx2KOxwI0
	 KYY/7RP8uske7bJdNqXTeSP3tg87Sul9SUDOUL6nZgjrz/hLcXr6JchZ5rcxChc3vEwCf
	 AqKGczN4VfAXP8VS3bVuhVF71QlGK7B08yGYc3YBgUe6JpB2SJ30OruABUx6nORqQqYav
	 s1oT3RIECjZwSYKQ0FRDF4XzVf5+t/aPv17bixJIj34jwnFgVoNu7TYtXo4YjorcwjGow
	 p9ZgC2hmJRUHRzsnp3v4zg1dO9KNRlxXQjkgl23llNkj60EMRz++3uECbssEQeRxSag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Zf8t1MC1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.19
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532E606A31C;
	Wed, 11 Nov 2026 04:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1532E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Zf8t1MC1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZmbS36SHDu+4778+TH4otd7TWptukjSSlU5j0YQbDdloyqG/N9+tXE05iwtSOXkSH4ZRVkHsGrDqDV9WoqWB5lMgkevh+OJWBtfHXTtV+ctNnyXL2WuT3rQW/vrJBhnUWgwT2wuxhwvzvt1rywAxU2faYLBkxzf7iiuOWfUTb1NVoI9B57uRU8zPKvGIBmIq4WT9FeuCnu2tPqFaDmcBnXbHhOODGcmlVHY9bmDCv0V0Y6a1fm4E3Q0xHLg6tnkY+roM86Dz5HUCRlFL3UQpZLJREGPT05XG7yzghGTHneWQYKzp1v4m22zLr6btFTAjepV+Ox3BK1oP8uXBgd7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Degn5zt/JvR3C+BCJBZuEB/iHP5SNZh9EITfG2lqM=;
 b=ep5s1tdVfaJnwjKc/GHCtIPzKS8oCRdaXbx3QhNLlpqXTrgiS0i0qbkFOSRBLuCYyo4/bND+ldpTG5UtAZyofXuOYoL6wgYPakhj0NmjjQOQ7ohwtTql2VECbGnzLNdcR26bjMYyLWpje5QeBob1UkRjxA93XbUOARbl5lSIVUME87gnlT84F5CYaBjFPtUxzIy9JD+tA/35nfl0LT9iT6IFbwQKowqHN6LvDfk6hK1KptZBq80zokeISJTT1sjgREkH0FuDUmj7dK86uuPXnt3ehUQvrN91Q/l9sqRnM0z3zfl16WJsAbpUml7aTcnAR5IZtn8kGZXz8AA8INPoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Degn5zt/JvR3C+BCJBZuEB/iHP5SNZh9EITfG2lqM=;
 b=Zf8t1MC1FyjHj+srOlDzrUH66UKXKVKszposQ744cAqvql4pUKYvqKAVeVrsFb/gxV3RENllgVUGhiZ2J9Ll/W+3SiarJ80Dr5QVepOHbUv0kxfarzHETKhNOqNyStpnysAOQH5LqiX+dKMTE1nIRY+ld6EvdgpqDM6xP2FOpsxeJpE00Qo7C4u9l+MGtTQYDnfBV/WBB+XJwd1NfSdcoKMq+Cb3KvK2Mk0mYLjoCBrS1PqQuvkyN5cCtMURs7ER0Lwz6uQEv+4GdYHSQaNAMntXexcHVCxiHmqWC6ERW3E06iCx3iu3FttPFNYEJNvsswh06ScFkyJGg1P4z1pFDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by EAYPR12MB999131.namprd12.prod.outlook.com (2603:10b6:303:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 04:28:11 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:28:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 13:28:07 +0900
Message-Id: <DMS3J9S13ESW.17NXIIGFG34MT@nvidia.com>
Cc: <dakr@kernel.org>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: Re: [PATCH v4 04/32] gpu: nova-core: vgpu: detect boot state
 independently
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alok Kumar" <alkumar@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <cover.1793906667.git.alkumar@nvidia.com>
 <ec70c38e3160a75ec2727a2261b4a1d21de33c4d.1793906667.git.alkumar@nvidia.com>
In-Reply-To: <ec70c38e3160a75ec2727a2261b4a1d21de33c4d.1793906667.git.alkumar@nvidia.com>
X-ClientProxiedBy: TY4P286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|EAYPR12MB999131:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa1ffbb-f297-42e5-e42e-08df3fac3183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|261009223027099003|10067099003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4QBBELDdwSf7+tZKp7tJL1t4a/eymbd8nbKAJ+Do0LyfQeSyIC5slaJS43fBr0sc1UnS25pF+bvTd9bIl2cqJc2RySuSEpTPEt41AXy3qXr0FJHh+ltBgG8ItzCpDB2/sQZwdBzrHus2f6KArDEuGGVLtcqdLXH+cL5+L+OMxAKJrk8U+C3B8zgu72fWh0nki4+2JRAnyzpVTMBnWS4VuVgZIGatRfUiZh9FOvVuYx8tsSblQucgAytSMVqSXVFtMbuJ9/s3Si7f5vJyfB+aPy5Bj/A7miDiOCx6eUZQ01poIhrYdrlMEvbi1ym/ymg9kg8sbH2TbFoTvhElbqUDu8M4JEx1pBpcJLBmVmslfAnkxTyL6ecnbZEMGNQxkiMtrO5iO1NvmnZFonNYCEjJL3DP2W8fwynZY1lskT7IESYjTRcT9/TqxhmJIIyPQPuPNb1RRmmdX2WjTCrvthgGX2IEnrRIo7n341PtmwNQm558uy1yeaW7HnpO0i7WsCpx0b3+PCFsNh/gFhlAiEPONRvHl+RcpvvzzCgrmbQwP1w3SUzmNjmYr4K4dJb4eaqwkp5n0UAIp4LRkvaOMrxWWXQP7Yn1bn6RBwHTKE1rpCggC781r4L+lsjhC7GEW3JDMJ88M8NeZhvgLci3e62iQ1TVGd6Pywfr2YHERKu6IQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzVLQm1vRXdnNFFDaHBRK2xubVN3T3NyUE1rdmVjVldPbGt2VVJSeGhjb3do?=
 =?utf-8?B?QjFOL3BJZXZNcllvYzRWZm0ybjlmZmJVaVFVK1RBcjlENEUzV09ubThTV1Fp?=
 =?utf-8?B?Vis1SkdPZHRpelNnOXoxYkZuOGZHYzVTM01rSDU3NVJQak5md3dWQ0JYV0t3?=
 =?utf-8?B?bTZ3UnVhYytuZ0RSYW9iVS90aDRXRXM3aS9oR1lPT3pIeU13WGRXdVoxNy9m?=
 =?utf-8?B?cHovV0dIR1E3eUphKzVmNTUwMzNqR0tOcThuZGFUZ0trWHByU1FaWE5mekd3?=
 =?utf-8?B?azlyTU1xeUJMODFSUDJIcWY4VEFHeVVNVExIdmNQOUtQNytJeDNxOTB0WmQv?=
 =?utf-8?B?YmoyRDhtQ29FcjJoUW1MeEhUZi82VHhydVFsUFVWbDBGNXlwaURydUhKSDRZ?=
 =?utf-8?B?RkFrN1N2TzM3OUI4TFRKTlE2K0JKSEVyaDRPWHQ5YXJZc1hWMVpLaUprTSt2?=
 =?utf-8?B?OVp1eC9xUzd2VSsrNW5aOU9CU0IyTE1sd0xkZFRlTTRpamU3a1BTNFp1RG1k?=
 =?utf-8?B?aUVCMlRyM3lFUzFxRDhnOFZINTZZL01WM0syVHVFQzRZVlB5cWNaYTZTWXJB?=
 =?utf-8?B?TmdBcUZnN3I1THVmR1hWeDU5UU5BTTZOM0M0Q2o1bVFXNitwREp0bUMySngy?=
 =?utf-8?B?ajVZck80ektSdGluOHlhWllUQXJSYThGdS9zQ0VvNFF1VkJpNDd2K0dlVERV?=
 =?utf-8?B?VDljQ0NzbTZUVFAvTUhLQ3VhM1BQbDRyWTAyTEVwZXhsZGhhemFzVnhhMFh4?=
 =?utf-8?B?eC9Jd2hCSi9iSFp2VDJLNmcveHM0U1M2bU41Q2dKK2lzaFR1SVUvakwreHlC?=
 =?utf-8?B?by9nVFVmMW0zb0R1SUdlR3dGTm5CMTlxUHZDT0lDTDNmdzl5dFlaQ3dJWkg1?=
 =?utf-8?B?SlRRL0laRkozb0pEblRpcjZkdTRkLzZsQUIrQmV1Z1N0RElkV3hTVEVOQXVB?=
 =?utf-8?B?ZzZmM09vaGlGTFhLZGVycHFSaTBML1BZM0pka0hoM0x4d1Y1Rkk3azhkTjIz?=
 =?utf-8?B?bllCd0tXOXNKN2E3QnRoTU01ekpieWFaa2x6OFlpeHM5Yk5YbU4vNlNhUzRV?=
 =?utf-8?B?TXRSZ205bjg5RHhFVWdvL1JFVmFoSnd4Q1loalFuRVZ4elcwOVZQS1NQTy9r?=
 =?utf-8?B?dHVUSGRLM1FNNEdES3RhTnNaK2wyZEN6Y05JaWZOTmZ2NFlVNnBIYU50T04r?=
 =?utf-8?B?b2UwVVc4QlB0eStpd2VzSFh0MW9aN245Z3F1N01aQVJyeFdxR0RqNWNOdVVs?=
 =?utf-8?B?QUtONmo1VUszanVFeXVMM1p3VTNGRi8xZkdPOVEzRHQ1NlVvZU03RFVCYjgz?=
 =?utf-8?B?d2ZFRGJVT1JBSENYZWlpS0VlNnN0dWZVTGpPcXVLbkk3U0w0UEhBQWNMeWhH?=
 =?utf-8?B?dGY2Zk1KNEQ1VzQ4QTJxNVFkK3JsOXdKVVRYR2s3cGIzZnB5WlNhbVRTVkE3?=
 =?utf-8?B?UGduSFdlQTVla0gzUU4rbmNRLzhFNDYzdFRmU05ncXZoUG9McnNDUGtyclZz?=
 =?utf-8?B?Z2hsb2kzbmNITHJyWTFHMXpsSWpGODBnaExMQnp3Rm5MZjd6NGFkc1lEeWUv?=
 =?utf-8?B?QUxLU3JGai9TcHcvckUydm9TZHhIQmNlK05GRnZxL1loVHVQbmhpRUMrMTRS?=
 =?utf-8?B?NWRNTDJxd1NzMjE5a0gvTlU5YkpHTXQwL29Vai83Y0RSVnBzaFNkL2tNVmdv?=
 =?utf-8?B?bmZhTm5SNVlGd1ptSXhpb1ZEL0NTMUQyQ29GN210c0xNVXBlVGxrWXdQa0ho?=
 =?utf-8?B?dlZRK0pPUzNwcFM1VC9XS2FKY3Q3WU5OUzBNY2FtZTZjeTM3YmhEUU9kLy96?=
 =?utf-8?B?M3BYTjFORWFRaGpnR2dsWTlmVUhHSS9LSGd2bTA1cnlpb25QU3JNRmlQSnhQ?=
 =?utf-8?B?T2JHZ2Z0S3NCTGRJVFp6SVE5ZVJpTVRBQzd6ZlYxSmp3RzQ1MHhIZCszQWpK?=
 =?utf-8?B?dFdrcjNhRzVSdVBLMmZ0WE10ZWFPWG1HMTliVGk5dmM5ODd3RDFvVU5kb0Fj?=
 =?utf-8?B?ZmVuS3BKdytLcUpwcCtrSGZFNTFJd2FHL2xmc3I2UDA2Si9RUitQLzRPM2Ex?=
 =?utf-8?B?MDlzU0xwd1NxR2RKR1pFNVpydVFTSkYwSzdKQVo4aFp3WW9VZ1NVUmh5ZWFJ?=
 =?utf-8?B?ZlBCd0lvckRJMUI3ajh1emlqL3VoUGJXZ1JPNktKWC83ZzNERFk1SHNjMFFR?=
 =?utf-8?B?TnlhQS8wRVVVWHhPc21PdXBnTmFad1h2c1RjYnJsNmM2MFlLNFA4TUExdndq?=
 =?utf-8?B?UlZWYkNhejNPWnlOVFUzTy9SY285UktwVStib0tWNkhEamtibmt1K1U3SUM2?=
 =?utf-8?B?aE1YMXY5VzV6cGNJSllMNkNKK1ZhVW9OUGRLdzhkSmhPYnQ1Qlo1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa1ffbb-f297-42e5-e42e-08df3fac3183
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:28:11.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qwmevf0wqGWIeisz/YPhrlLHizBKnfRHqPHeokMOhq6YfYfAWkR3Xe6mWSEXc5AEW9EGq0EYH52oPEQPAPJgWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999131

On Fri Nov 6, 2026 at 2:39 PM JST, Alok Kumar wrote:
<...>
> diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.r=
s
> index 905b3a7331fd..b405ba49c490 100644
> --- a/drivers/gpu/nova-core/vgpu.rs
> +++ b/drivers/gpu/nova-core/vgpu.rs
> @@ -30,19 +30,16 @@ pub(crate) enum VgpuState {
>      },
>  }
> =20
> -/// vGPU state manager.
> -pub(crate) struct VgpuManager {
> -    state: VgpuState,
> -}
> -
> -impl VgpuManager {
> -    /// Creates a vGPU manager by querying SR-IOV and the FSP PRC vGPU k=
nob.
> -    pub(crate) fn new(
> +impl VgpuState {
> +    /// Detects the boot mode, falling back to disabled if querying the =
device fails.
> +    ///
> +    /// Call after creating the FSP and before allocating GSP firmware r=
esources.
> +    pub(crate) fn detect(

I think `new` was a fine method name here as it is a constructor...

>          pdev: &pci::Device<device::Core<'_>>,
>          chipset: Chipset,
>          fsp: Option<&mut Fsp<'_>>,
>      ) -> Self {
> -        let state =3D Self::detect_state(pdev, chipset, fsp).unwrap_or_e=
lse(|e| {
> +        let state =3D Self::query_state(pdev, chipset, fsp).unwrap_or_el=
se(|e| {
>              dev_warn!(
>                  pdev,
>                  "vGPU state detection failed: {:?}; disabling vGPU\n",
> @@ -51,12 +48,11 @@ pub(crate) fn new(
>              VgpuState::Disabled
>          });
>          dev_dbg!(pdev, "vGPU state: {:?}\n", state);
> -
> -        Self { state }
> +        state
>      }
> =20
>      /// Detects the vGPU state from the chipset, SR-IOV capability and F=
SP PRC knob.
> -    fn detect_state(
> +    fn query_state(

Here as well, I don't see a benefit in renaming this method.
