Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792786038;
	b=2I12jq/IOT+AE7VTJoCaDTMnV01KW2+Pb6Z8uPROQkfzz/OEU3gNWZjK4E6ZndITfSFM
	 N5fawQzkvL1THFS+nRw3/tzptRwbwZlgUSxHml87+N9Hr1uukftzP9m6EmyzsvvQK8Gtq
	 P/UdPwYobUHnswvk7W3kA+O8o5d+zGqLOF/2bWHhxuCYEKQxxKShLNdTq+6aTazyXAx7m
	 xtSlMJZGuNvGkwTBVzk0tiBgoEx8/r9uAaDITvOEsOCF1GdZwGGPsGEtnQDkxDwbOikyi
	 Ch+2pFY7UOG+/DEXuqz9eJLH5qSqPjik8d0TJPnwf9Vm7FNO9/DV3KI7Szm5eW1c0YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786038;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=zFxmDs0W4AddHtK56Gr2S+uctg4ZEJXOdFOe6X4Ay8A=;
	b=1YDUTOae5HmBxhHd9OW0Ed/OjQ+K3fQgQpFibpb+uTJ5kqJDhli9Xn6bve4yixNnCWTh
	 oC+Tg2ffgt0GqHLEPb1zQJGlGXbtbejaZFkMCPEmx8e1/0EdtoykLmIVb241xAQoWbqq4
	 FspDmLD5WCGemFfZqUT7daV+r9lzDNbcaQdx01gfYsIj89Q6BFOKeJMUvrrUnM3npdAHN
	 lWb+lTg0InoC+tr/XNPxDmm5L9q3c4exTYqPw/hQ5NkP03x+Lx2A95JdBMCd+QQao82L9
	 aN40avU4q9g+k/UyIG/VRtceusezodIHjO+9/MZ3uoQcrbaH7ljGzh4wkdiA9e88O3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b="w5QFi/om";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.140
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020140.outbound.protection.outlook.com [52.101.195.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC536606A31B;
	Fri, 23 Oct 2026 20:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC536606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=w5QFi/om
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW1aact6CO0uzxEAihrs9ZoNze8wJHCZl+Gxn9e1GTTtc/1CgqkJ8rZ7OYlxZhyRYwxb34AIoG3XQ4uGM0Qk4S/RRV3/yeOqMvQ9+LAYgWZg93MXA0aIC6py0KBZhqTWU7jAQlEnFZ8S00uqoGNSVE7/3BPZ7/gwY7BhlQt28uJMiyOculP2pRQKN1U0gACguiu2ZfksSdY7iZ8zqYKpLX3iQ33phknDB+0U6u47JU5GmnMnK+uNB9P1DJIQYw4boGolHzmsSHOX4pkMxjJHTvdF5hwRO16Z8AWStph7NYNDNPm60QUzVFacb4vXxRnixbM5hAm4u7rTxffliH2NgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFxmDs0W4AddHtK56Gr2S+uctg4ZEJXOdFOe6X4Ay8A=;
 b=ItwQHSdfFd6zjG+nAkla/E7jD4TjoLlkk3lUqfROtRHOYYE6O/mE095+ZgW+BQdChES9AK8RMzJ1YyXNEL0u+p0YztGX6Cy0pOcDrZE+MWJB1MjZJS5sHc8s2UxGJpRgIjAhZOUvpXoMs0usmOZMFaquYfSJnKKKaGdmaaaPTgsH/q27kxYqQ35gkIIyoAVRBVUkSvutyFky2T5ZHYManb6zS1K43rA8DVY0Ir8rH2MTN95TohfGUrhnxwq8YSF7T3rDUnHx8hskUZrDCwgMedsY37Tm/YeMwsfOrmTP/ax2eVsabupfEsX/TFCyNUxjLxhGjyufHAsIIqFRE+8t9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFxmDs0W4AddHtK56Gr2S+uctg4ZEJXOdFOe6X4Ay8A=;
 b=w5QFi/omoWZlF0rabEi+AkCswuFJzxNvLuNrCKbozzOa1oRb0nWbnXwaNvszZ2k9a+i9MJUZ7XWLO/6QGqPVa5Z0fUPM+fxcrnMBb89Uxw56GFbU4Hhwr1DUIXn7HLtpwoNAJNMy7m0ikgXfRMOA9swC8bq4Z6YXTqNl0253rT8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LOYP265MB2400.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 20:07:14 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 20:07:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 21:07:12 +0100
Message-Id: <DMCHLXM8XVPO.3UDJN1SJR0JHY@garyguo.net>
Cc: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
Subject: Re: [PATCH v2 01/12] rust: pci: add VFIO override device IDs
From: "Gary Guo" <gary@garyguo.net>
To: "Simon Song" <xinmengs@nvidia.com>, <dakr@kernel.org>,
 <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-2-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-2-xinmengs@nvidia.com>
X-ClientProxiedBy: LO4P123CA0384.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::11) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LOYP265MB2400:EE_
X-MS-Office365-Filtering-Correlation-Id: 4255f6f3-8d3a-481a-62a3-08df31413ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|4143699003|56012099006|3023799007|261009223027099003|261022075727099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VXMCn/c/MV6V/EKwZ73ZP/pY+LrF0WeYdEdDy+7bIw0B6K1tkxtI4Gtz/6iZ63rxJ8YPpteXbs7zGK/dJJrFbpVnogyE3Uw3gZoMjogSosdmvHYfvZN/PDZPaUJ64C8Goq4TlrTtnZefdxOgNrwdqNWcSYTerwyFRHbClaM2JhkIF5T7J3GolNsGpGn2JPb5/KlTPjaf3dqi44M9zgiNtJi+s6yHWc06TqMU6k8N6jS364B/+Z5hhELsn+BWgmnjRis0Tmnp8f3rFR1OyNaPpVEb2EoQvaAAEfDukbQ7M/ggQmV7pHeTqg6v3Ni7F/3vdmt2FHkU7QKs4sy0p9eSbRBcSZ9VgnOM01Rc0FI5rS9w6gtMZoxs3mh4+DGZNjoKX/EQa8grswhpJ6F+1wuMbMxJzOq0hFVO3F/02FvjzjjGR1NR2A3xresd9yygCgEkHQ7yy/5A5szf5bKldO2ufY9VFwZ6M20bLI0P79Agil1ENCDeEI3BpG/ggJRFaaUA5tTYei/jvRTmIM6XorLoBlvcnTK9doQOceM/YTbaq4uLXOd4OLTGE3A+Fe0WmXcfbsk4d79Tl4+VAEe6TIj/qvs7NGHzWg0gC73AzpawTgPtLirF5iWHwd4sNbMMy7cTi41qp2ZTbOTeVzqu3DkEk8w4NlHs625r59Xd1kknDjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(4143699003)(56012099006)(3023799007)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elljZ1FMbmk0SGVBV1lYSEhEY0gxRHZUZjl2SU9ibzIxeVRwVkpHWmNHY3NL?=
 =?utf-8?B?d3BKMEVUS0V5SCtQRVhzbDcrTk9yS2YyNkI3ZlVud3pERThzWXV0Q3VtSHBR?=
 =?utf-8?B?VmZzdm5jRFlKb0ZKUytuZmR5VjZ2SUdURHQ3ZnMxOWlNcjFLLzFkZDNPMEli?=
 =?utf-8?B?VXl3SFZ3M0tDZGRNZTQrVmQvSmxkUGU3ZVQ0ZEJlMXZwNW9CcklMVjF1TGhj?=
 =?utf-8?B?VWVjZ28wTTU2bENOREVDckk4aE0wYzdWVG82TVRWSk8reHJoOEJ1Y3hWd200?=
 =?utf-8?B?TFVKcVJNR1ExMWNPU3pMT1h5aHVhM2dnbjQ1RThaUnFTOHJ4VkpHQnoxM1dZ?=
 =?utf-8?B?VVdlUEZVQ1FDRmtaNWZDa2ZvMWJwdmhsb2k4eFRheG45eVhicmIzQXZ6MXV4?=
 =?utf-8?B?NlhhYWZrTk04NnVMNlR1RndXV2xZMzlOZWZYdlVoT0psNExDV3F6MW1CYUpC?=
 =?utf-8?B?bG9MTWR2QzlDOWVxVE0xWVgyNTFvakRHMzlrWlJHcmhuRnlOQ2hxUURLU0k1?=
 =?utf-8?B?UkpuRkp0WE8wUFV6YTBlUVJkeWFxbDUzQVhVMVU2cnE3aUp5LytPczNPd3JG?=
 =?utf-8?B?NnBpaFhWTHJZQ1hPU0FHOGtpbmtDVndTdUlGWGRzV2NValFNTjRYRUtRR2hY?=
 =?utf-8?B?VkxyUFNSU1FVMEJ3RnNJdDlUVWZWOVZiSTg4NmlKS3M0b2J5OHNpZjdQTGxF?=
 =?utf-8?B?cDF6Z21xMWNuTU90MStGRmpjQkV3WDdZTDZjeENGSkdvQmFCRlhWaU8vUk40?=
 =?utf-8?B?aExudEVwV1lJS1hlN1YyeUtoTEZ3OFBIWmRWRzNXcmswdmZiWEIzYklBQ3FZ?=
 =?utf-8?B?TkpJV2hYVFlaQlQ0V0dSUkR5clRqRGVkTGJYZkRtaHY1U1VocXFIZzJiVVFT?=
 =?utf-8?B?Si9DUjhqTmxHNlBzTGU0Z2xTeGdlQ0Q3a1k3MGEveUVsS0FtOEF2UklBbEh2?=
 =?utf-8?B?OGpXekFXUm9YNU5BdFVpNzVrdFkvNWlZdUI0bEc0elJ2TXhNSFZQbm8xaVk3?=
 =?utf-8?B?cEYyZG5kTDhVNzU2Si9nRmJTSVdxRG9RQldkbitqTVgvVFBrSktPWjAxS2g3?=
 =?utf-8?B?dWZFV2JyRVVqeU1kZVdSZmVQV254RVlCN1FOZ21DV09oVkhyb3o4Y2s2ZTJh?=
 =?utf-8?B?MFg3RnFRNU5hakQrUlJhR3RxWVFpcEd1WnFFUkp3RFk5QWdQRlcranNFd1JC?=
 =?utf-8?B?Q0hTS2tLWGpTOWpSek5DRUlXeXROQlVPclExNFNKVEVnTUViWm9vdE90VnBm?=
 =?utf-8?B?M0hJMWp0RUJNYjcyeG1CQ2xJbTBIUWxOOUZFMk4vcFBKRkphUm9xNHdoYUIv?=
 =?utf-8?B?aUVVS0ZWODhDbFRyelU5eWtibWRFbWN0VUNQdVgwdnh1eWN6ZExOWkZTUmgy?=
 =?utf-8?B?U2JoRUtocmNNUnUraWlnRllMOHU0K0F2TktKVUVTM0tPS1RMOVc2THQrV21a?=
 =?utf-8?B?c1ppWTFDZEtMOHZCNmRSclBGNUU1UUdobFA0Q081NlJSSkMxTjV3SGZkcEVO?=
 =?utf-8?B?WGlwVDRMZnppcmYvNzRLY0pYcGR1QUliK0F2M2R6bmRHMStuc3RkYXJiN3NZ?=
 =?utf-8?B?NlNlU0lmbGxCWSsyZEx2M1RGd203U1pzVE9GRW5PSFNzRENRb2c2ZG5STDJZ?=
 =?utf-8?B?NW02QkFHeGVjZVBPTkVzUkNoem15aG11TXI3NDNMcFJhUFViT0FaVzZFRW4v?=
 =?utf-8?B?TDBhQXVQQnZIb1ZrS001bjhNemZTK0RXR0hpS0wyVjlXeThkYUFEemkvUHVy?=
 =?utf-8?B?aC9OZlY4ZHhOTU5aNlc5OGtBbjJZbHlyMWh0ZllKMkNrSGhlMUUxaHQvMnZK?=
 =?utf-8?B?RFlORG80SHlERzZ0Z0xVMVc3Mkw2RytZZlRVaVZqNlhNamg5a3JaOThQeXVP?=
 =?utf-8?B?c1Y1S3YzVjgzWlBaanhndnE0Q1drVVFLTk9WNG5ZMlpsMUtTbmI4UDhvQ3l2?=
 =?utf-8?B?dHVBS3Z4Q0NJb2t5eG9UU3JoV1lYaitRVnpRVGZnUjFQZWVQUGxmVTZnMlYv?=
 =?utf-8?B?RWxkWVl2NWoyOG44bnRBVk5TODdBaWFQVVhVc2VBaDFKTUJYUnVwNnkvU2pa?=
 =?utf-8?B?aGRlZGx3TDBwd2oyY0gxMTdqS3BZMW4zWW1zeXMrd3g1cmVCYXhkVVRlVXRy?=
 =?utf-8?B?M01MbXNrSmRNTXZadllKTDdSZnpvRlJyWWhtZFl2VFM3NG1VVTFUS2E5cWNM?=
 =?utf-8?B?YVZiMXY4RFZPTU5XVG1ZbG4zbXpSU09talEreG04bGgvV2FOMnNnRWxqdUtD?=
 =?utf-8?B?ZFBWMmNNRjhoM0Q0eDdYY1lpeWQzSVFNWGJ1Ykd0cUN2Y0lVTmFhS0F2Ukdv?=
 =?utf-8?B?Z2lETzVGTStPK1d1NDJodGRDcWJzR21jMjJyMHJYaFdVc2puMVVMZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4255f6f3-8d3a-481a-62a3-08df31413ac3
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:07:14.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxR3gbjQ5OSmVuUW8ihZ6mfOLVe3dxQlmuTAP3MrfsmYu6PzXaTJAArovqh1lPgO1E7bk5Oc9wPckh39Z187eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2400

On Fri Oct 23, 2026 at 4:39 PM BST, Simon Song wrote:
> From: Danilo Krummrich <dakr@kernel.org>
>
> VFIO variant drivers need override-only IDs and VFIO-specific module
> aliases so userspace can select them for PCI assignment.
>
> Add a DeviceId constructor equivalent to PCI_DRIVER_OVERRIDE_DEVICE_VFIO,
> matching a vendor and device without restricting the PCI class.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>
> ---
>  rust/kernel/pci.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index d83492e06ce..10864ffda4e 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -206,6 +206,13 @@ macro_rules! module_pci_driver {
>  impl DeviceId {
>      const PCI_ANY_ID: u32 =3D !0;
> =20
> +    /// Equivalent to C's `PCI_DRIVER_OVERRIDE_DEVICE_VFIO` macro.

The documentation should primary describe what the function is.

The C equivalence is good to have but should be secondary info.

Best,
Gary

> +    pub const fn from_id_vfio_override(vendor: Vendor, device: u32) -> S=
elf {
> +        let mut id =3D Self::from_id(vendor, device);
> +        id.0.override_only =3D bindings::PCI_ID_F_VFIO_DRIVER_OVERRIDE;
> +        id
> +    }
> +
>      /// Equivalent to C's `PCI_DEVICE` macro.
>      ///
>      /// Create a new `pci::DeviceId` from a vendor and device ID.


