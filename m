Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795511171;
	b=otN2zzakAepscD4NlArQFC4HctGzEdz9XBwDfxN5+UhcVoS0vCZpQkOjlMFfeP5mMJmi
	 qIW9JEfqk3NPnyNggjZjB2/dTFpdP5+rgInXIl0o34wzJYgwzZoHHfAFj4tz4ncDguQ/J
	 j+H23rX7xJ3IhXqPw4/Qo5U7VWvHCojMMAqTbM4LylvPYdg5M/tApvZHt9D/4i/ra03rK
	 wmjiYxckbcQEb1/O/aPyrmUdscHqx6JCmbjRUsSbVJB7lGEHRKPfY8hV3t+3QT9huPybj
	 bQIFyUvrNi6NttMKtoZOcvnko7gRBtqao/4uto37F1WoCdPHjFuBi8zIyIm+QoYm79Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511171;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2kGcBOx6s+pYGLZw2MTWJ8i6+2dz0ngn8tGR103AcNs=;
	b=znvzAnoWk63gXsElzkbO0lFcI8zH74X+HGgLOUU3oxnDn02Awm9uuAyt3iMSlN4E8m5p
	 WzFr3n2cxKV5NPVD8XFhVWZ1x6PnLNC1De2aeLGYd1DrOzi4JoqR/IkLmMgVIqpyj+lVx
	 MjaQ0Up2gEyqtpX2LT8DfRyM2/uuEUnA+DmCkPYNGMqfVMFpDvVsjQurvr3rA39ed/Bis
	 dL5g5soxQQtDgQA7yuvb571T5yIOxycJGwPS0gF85HAiX8G54FH5DnMPU/Ag3mqqiExou
	 wBfGr1ZcEoMSCCTZkDlq2JNDHRtJG9Pn/tyPJumNMTg+atcXxXaEuUQDx4PnfFVM4cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VWkPthUO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.67
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7D606A326;
	Tue, 24 Nov 2026 09:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1B7D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VWkPthUO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXbNCExuIJ+tN4B9Yp05ot+RN3zxHMBb1PcAvi2yMnHG6hJ1XQKtUfqCo33QR1IY9bJqjiZLqZGD7ZmqZgWpc3SZoNWnocwgDuvDS7x7hVsftsai3hs9+rR9nmc+AUtBxJUSD3nydoSThc5RLVXwo5SRry+hX3KKYZm0tdIPcpiGvDhA/kBUFiUl3HUFXvaoBYwr8jUstD23TdJiucAlDErgDToIMWJlHRhzRobBDmuaaCTfmab6JDurLhlcQTp3bo78GqlRmW1RBmR4rpzmX3moo1bxzEidm/CU1kdGcqo07T6rhIZhnLO3xAh91dugAqAxVbR78MPE+JEprW7tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kGcBOx6s+pYGLZw2MTWJ8i6+2dz0ngn8tGR103AcNs=;
 b=EgS9hGtEjS+fHWLoueX5oGOU6NNIMfAqP56BuLSsHZiSPAhifPFq/+kNLBeMKdiSTO1Eoi98Ejw0H6/KvLdR9F7Kpqg3NIjG6myIRhrD71d87gme5MndsZTi8OV/hF4u2Pjx11sa2Pf1qhYsqQDsf8DHaweWUgEtn0StpeABSgVxDu4doYdDPmhoIUA32wE9N7iCyDKcn+2QOCch4cEHQS/oGlR6uTTH/7zgKPgstnTHJhG/oNGXreBFbfBxi6kUz/b+WKkr3I685zoClwNDPip/+xw0Fmbtj4Yj0w4UcCkt0iN6LTIX6ODxam1j0UXmeHWwHymwF+gm5LDvOnXhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kGcBOx6s+pYGLZw2MTWJ8i6+2dz0ngn8tGR103AcNs=;
 b=VWkPthUOXrQXcThWp7l3H3vIcUrRIVEmGGicgvlkWf7IhipZBcOnUf2DpLK5Y43FVWaoGsb6ZFh4vVBs7ZuOvnSBS+q70oUp22XUZSXMsB2tstqT/e0x1tKNfCOvIOw1yd/HpTWywLhdq4FoCWdiu+AuxCekB3ru98goitcJ/bj5etL+UmTJ5eFXhSMgCk7iOUKhgfrazB6uBYzwpdTLcV8Ckind1a0/mmp5KByaRw1jSbwqcfwqkmHrMTMqAEc113lJ2dJW/BJ1ksowgO4X4XpkUxq+t4sHcPPjYYY/y01XoGEd7sbS5hfz2BVnn55yw472rzFGR9rGYpANJC8Wrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Tue, 24 Nov 2026 09:06:05 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:06:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 18:06:01 +0900
Message-Id: <DN3BL4DRGG7U.2A12KL88FS1C5@nvidia.com>
Subject: Re: [PATCH 5/9] gpu: nova-core: gsp: fix resume_gsp_rm()'s error
 messages
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "LKML"
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-6-jhubbard@nvidia.com>
In-Reply-To: <20261120044704.165223-6-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCP286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7a300c-a55a-4732-47ff-08df4a0a2bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003|23010399003|261028144727099003|10067099003|4143699003|11063799006|56012099006|261022105027099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RsDdzcXSHqqjkc4mHcxC+n6baNcf04QNpq2dUiWlgHdAZgMvva8AGtULQbAV2SgWDI9zVbAXoWXcGG8C1y4LETx7N7/VtkLTfjseQEs+fyTh+/pD6vl/7qGSm9TeTEGNhC/t1/TjWquPGyiMkY2XbtGJZBOzTn11MLJWk92lUx9yDWMOtZzVLvwlZuQGqID4qQoexQqTCdBAzMj/AdhpcbNF0uhN4C4BF0d8OHgRHry+h/yVXc+iJR6A6T2clNGmOmun1z9jld4jZ4h3kbf085r+diCP0Ku6oV7o9NZntyI+Rz0vlf1vNkyW/qglVXJqlyDwJ7UOTHjLMyxbLgvllnIz2lKvf1keQ47LTHVbe2/9SzxtfGzsptTg2tiONm6J15Bc039AVaIu73hu4H4Qd8s8KDWlScxWK3myEZU0aqBltsAGvQPsug57o8t3+Xz1QM3dCp7+AWWtE2rMwOYKGd6xdZcbsR/5IePr/dqeFEAAkAs7DtUeoXq21EQjGd2mMyz12Z5dT3yDtX/RWcmmo0vWVxGSnznE/k0RfMgBikOXcjeLT7jtF0CkWplgrzeXBhbfTRRON+ppHuLxMMPL3+aluKHy5Eo2GWU3APnUxD/emG8XMYjIyiofk1FWJoz4diYpxd3Oe2GRUorXTTnAqpLsra+E0hyGcY0FM/IrBlE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003)(23010399003)(261028144727099003)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHlMbUV5UzlSRVV1RWZpMEpOd0MzK3RPUzlrUmwzWEZXaWRQcUh6TXFiL21L?=
 =?utf-8?B?blI4OCtDd0V5UmxPZ3p2ZFVpeHVkbXZTaWRwS2E1VjRJdDIyaVluK2dBdTlV?=
 =?utf-8?B?SzFXRUFSOGNFMlRKSmdSWVpEOGJHcVo5L05vK3hSR0RocVlsSmdZYWQwYUsw?=
 =?utf-8?B?OXpYcTdjVjI3bHMyTno1UEVESk9udXJTRGtvVkNyZS9VRXRBYzRJaGpaZ0Jo?=
 =?utf-8?B?TkpiaWp5VFBaSWlZU2Nva0czYTNHNFdMVkZKRDFrZWI2elc4KzVlSGtKNUtS?=
 =?utf-8?B?emh3bCt3dXNVZ2YwRGhNdjlhaXNKeTBiRXQzUkVNRWVQVTFtYlFQQUZIRlVE?=
 =?utf-8?B?NW1idkNCNEVxeUU0YVVxdHBhMGVXUDlkNTl1YzVhMXFQb2o0cG5BNHJqY3p2?=
 =?utf-8?B?K1h0TDdzeFJMUS93QlRUdnBTaUF4cUJUQ0V0VmtlT3ByQ2QvUnlDQjNmRjJC?=
 =?utf-8?B?M2Q0UWU1azRrVFFWb3lsekpTSklVdVNFeHBHeWJ2UGJ3NnlqRFlPWm1tMGhw?=
 =?utf-8?B?amJqdjVTVzQzTFhNV3dpYVFlRUUwSTZaL3k1MWpXVUozMCtsWnBSOThHS3pU?=
 =?utf-8?B?WlRudCs5T1lQa2QrQzZlSXp1cXlqeWc0cGkyL2YwR29rTUJEbXVzcEtlckYz?=
 =?utf-8?B?QmFFU0FyMlVZK2l3S3JIODVKbkdUNWhDQ096VkFJVFY1NUFveHBxNlR6V1Y0?=
 =?utf-8?B?NHUvZ3RLSEI4QjdOaW81U2xmbjV1VUIybTZoaGFSK2VWNHM4TytLUHdrVDZ5?=
 =?utf-8?B?WGcxSXMwdjFtaTh3ZzlDWm1GMzhGVmo1UUtKM3o0dU1TSWtaMzhRbldpbWRi?=
 =?utf-8?B?emw5QlY5WFpCay90M2Vad3NNVUZUS211RUlRa1BRQnNaUjYyVHZ2dHBSK1Q2?=
 =?utf-8?B?K1VIVmNtTXZ5dldMdm5BVWVTS3UrUmtibEV4UFVDcEVRdHREMWd2YWgxNC9Q?=
 =?utf-8?B?cldtK29WdDY2NERELzFDdWJ0UStxZmVQdWMzbFpSTzB5U0doRUptNHhtNVNC?=
 =?utf-8?B?NzJjQ1dXbUg1SUNlNmp0Sis4dU5Bc2lpTGVZVXo0NWx1VVdwNkM5TExXeHhC?=
 =?utf-8?B?dmM4dmVlVHJUTnROY1NGZDdxbmFndGN0Uk1EMGRNNldhVFg3UjRYSXcrYkl0?=
 =?utf-8?B?SWMwZlJ5Qkd3VG53TmFEVE5FYjdmblRGNm1hMzVXMnlsOU5QbmwwOXgwaGJM?=
 =?utf-8?B?MW5mdXB5M0xPZDB0eVBERGxBK212ZlZQOE5ELzIvaUU3MmhYbDZwdXZSSDM5?=
 =?utf-8?B?ZGtVN2Q2M0U1Q2hSdVZtaEdWUnJVQVViZlZWUzN3aTB2eXUxWlVtRkxzTmRM?=
 =?utf-8?B?empCYlRFcXE3bWE1K1hwZktCMWJibjhqQXQzSkVsOWd3ZjFRMjdjM0c0S3lT?=
 =?utf-8?B?cld2Z3ZHSnkvNjN5aVV5R2xUM0ZVMmdxdzFNRWE1bjJaZFN3VjI4SjJIblZs?=
 =?utf-8?B?RzNpODd2cDNESVlPKzJzSDZuZEx4NDdxdlkzT214cVpSa2J6LzJOOFlPMGFQ?=
 =?utf-8?B?dWZQSVFVY1l0RlZqVlBmSDJPd1Y5RHVaaytQS0RSbC9PdkVPUDRuN1BwNTBR?=
 =?utf-8?B?S3JtdjM5OEpzVlhFVkRDZ1B1cnNQNnJrNnB4WmhmSDZQbzM5a1NYT2pGR1VU?=
 =?utf-8?B?WTFoWGxhZWVvL0wyWGpSRGZMVy9jL3dIb2thK2NWbnlTZnh4VzhDdW1NOTZY?=
 =?utf-8?B?eThXdDMxaGo2clhzNTZFLys2RXBhNHNZclQ1UldzV2dlMTE4UDdzRGdzNGh2?=
 =?utf-8?B?VlNpNGJUZTNaamlYWlUzRXViTUJERWRyd3piM29LWnRLQUY3bUc0NFdVNTBZ?=
 =?utf-8?B?aDV0Nk5ma2JIQUtiVEk5bDJCajhGbXEwMFVQUWJBSDRSNWpsWnpBT0NFSVR0?=
 =?utf-8?B?bitUYTBQVWFBS0RKL3ZSMDJ4K2R3MjZmSWlnL29rT1ZoZWFYSWptL0V6d2lU?=
 =?utf-8?B?NndvV25jVjVwTytKS3E0QjBvSUM5akVEY2FoZGpPcEwwNi93S0t0QWxkYnlM?=
 =?utf-8?B?Sm9lMGFLUWJlditDZEM1bWltL1dyTXdCandld1VxeGlnR3l2OW9LRkxkYkpJ?=
 =?utf-8?B?WkdxajFZc0VKUnN2RHV2aFFvSnZVUytvbkNZK2x0VnhvTXArakNtckRBamJH?=
 =?utf-8?B?MEgrUHlEWVZBdEtYVzk3UHNaTUVFZm9HV2FEOFNQcnZiQzBRenVRYWxYSjJo?=
 =?utf-8?B?VWFqQjN5UEwwczFhOGRIYzZzYzdEZlJ2amc2V1VlcStEdFFyNzhSUURVN1Bt?=
 =?utf-8?B?Qmd1bkVaZktFblRuQkFqSVdwOGNGdkMrK1RjZkd6UlUvZmVSK2lSMTU1aHNG?=
 =?utf-8?B?MWtxTk1jNHAvVmN4SG9UTHdWdGp3RW15V0V6SnZrT0pDSUI0d3dsWU9SVUJt?=
 =?utf-8?Q?7mhep8kUpQLDakfQzX4+jPwR/JIsJypulpf1Eo9ZuREzl?=
X-MS-Exchange-AntiSpam-MessageData-1: xhLyDcvVAFMSnA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7a300c-a55a-4732-47ff-08df4a0a2bb6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:06:05.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XnrKrhVFgc7pa7RwrCFMgv/9sBBLUtrtTAainjfUeiZv2W+pBN4HGV0mLUUc0ZV2UR8f8Vgos9odNw4tt0fzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374

On Fri Nov 20, 2026 at 1:47 PM JST, John Hubbard wrote:
> resume_gsp_rm()'s error messages have two problems:
>
> * Both messages open with "Sequencer:", which assumes that the function
>   knows which code is calling it, and that that will never change. This
>   kind of tight coupling is almost never desirable in well-structured
>   code.
>
> * One message prints the SEC2 mailbox value in decimal. That needlessly
>   complicates looking up the error code, given that Open RM documents
>   those values in hex.
>
> Remove the sequencer's name from both messages and name the GSP-RM
> resume instead, and print the SEC2 mailbox value in hexadecimal.
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
