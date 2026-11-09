Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.52.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794225233;
	b=QsL/XaWWtCgbYKZ1lvOLJWYCjMyEmFlGYE7TGqeRCcUbXMmANgXs40YnwVa3Dd5Uo9T7
	 CRBWDU0toPhJn17wiiwIqnzw469JCmNoxzpfEzp9nqs221St8bMsimEK2I84avG4F9xvW
	 ZHOiYjmsWOksS0VEwTInHEnwLcf0yCYJYnGLdMDZdCq0PYvVQ9B5FBOMXsApjPsFjWYsG
	 5ZPsRgX3IsPf/6YwPG0AoBY/crED4TKygpyJqL0PvfufUtYlOOxvhiXqOVfg1H4Gpe8RH
	 9lyK1ClDUtl3cy34LDu+BacMeBjzQLhoCe1KH54wgYZaTUoXbMw+4srwzuFKOMUFlww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225233;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:Content-Transfer-Encoding:References:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=NGK+mlbahpQCHyQGYJDW2S8VnHA50M9jboD4lSD50wg=;
	b=f8WI9ykWg6Txu6kYER2RpxgoX/uOilRAxABmhHR3N+pQ7v/giRg6e+4CmcUVrdaiG2/D
	 AV/tX8eOXZ3Xyi/s6ppM9t0y+HkPEUidlBLc576OViGV03N7moap6oxCBNpuSqum9tpqn
	 qcvfzt/Wr6Y8tnV8bIBu9EqEANmVevmow2veNBgaa3uJAmkoBF+RuQsRdq0BgTbL1/nm2
	 o1x/nLDeZRUxACE7U5BTJBFh8Du2Rg1W9V9PZ2hvDO31A1dADzA2VZ8E0nrN7WrAMjgaM
	 rNB4ZMsk4M9qdDedtDf8uxTWrjNG1sU0WdenkzZx7ZOEp+K/Puc4+vlYojQ1dFRslsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EfXrPhNH;
	arc=fail smtp.remote-ip=52.101.52.29
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6C606D803;
	Mon,  9 Nov 2026 11:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA6C606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EfXrPhNH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIWtqGr8L2VgjtQ7kGzRsjHP0QtbIy+8swxgIqNlgdXOjbQCxCLb6hv6A1o5FOLqjtKv+vha+WVik5BKGAh/z2o6OQ73vNvf5DJ75plPT4HSdWH5YRMRruoDi3lZnzjhA1coPybgk/+zCRxP8kYcY3HOFM39GaHGqZGbvdFRWQHztMtgKx1QZTWM2ZxlQcWL4VHNkcRNbyVagu1WMB5o470eoFppPd5se1T/SPEqaPG1RmqVIqkw03cA0+DXzzEWEmQJFcdWXlRceHd+UnGXto2xXrY+R/0bxUy/XNa5VjocsxmJoEGXGo8fkQgwkZsdrYipWUtYQPQZWpsoBep//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGK+mlbahpQCHyQGYJDW2S8VnHA50M9jboD4lSD50wg=;
 b=wcR5AgKKpBuDsAT2/ZgXFsK1scmWoTt4Pq77QbVWGbqWHTUe7O9D92jEautMCNeaZhLt6xdh4iURvP2u/tGCA0qEZnsvaaqziBaTd45gwE2+OQjVr5aqay0BvDUWXnG1Lwmjx2DBDOuD/fqe83pBGEPQyfCoeVsS3dq4oXXyc6Lvm1tQTXAWE0xnaUAg0bnz1DM8TePitr2vNVqd007M+Vg97EY2xVXQZK3oXIg3cINIpT9D7F/FgN/RhwAgYofQ6DLHfKUBu5opthO+UTUBZjvl6weBDo/bjLwVsNJcWeM/wrBHRftJGx6uHxKTlLlwlv1TfkfGYKSqCFr9WKybiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGK+mlbahpQCHyQGYJDW2S8VnHA50M9jboD4lSD50wg=;
 b=EfXrPhNH0o9rxJg1SYJHvFMUXwvHArxhqsUiIClF7nacBZkD5vD2H3eS+twpMWCmMUQ2Y9uBH7DuNGK/3nFASxAqpK1iA5oIwURmTbsN8k9rcejOw4XkyZNgdtO7oM2QTzuN5iCxpONvYDXHwP+ZS9CMtC9EC6N2IU2UnEuhEQ+G2w85OdEE9LUS1riwEbUzERruNxYR5pPS4emHTPUDlYWAVkzNFCBkUwyVqwtuaTQCA8/88YMbE88tou3J3ny6YjKw1r3tifUhVB5JOkrDQz1l2DdYSetGk64uQjzqKuTrIDq5EaJ4ykTxF5KpvUf8KMtCu7PtI+62mYa46SfV3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:53:45 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 11:53:45 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 20:53:42 +0900
Message-Id: <DMQNRC5L69WD.HVRMO4ATQQ99@nvidia.com>
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
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
Subject: Re: [PATCH v5 6/9] rust: pci: add typed SR-IOV PF registration data
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-7-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-7-xinmengs@nvidia.com>
X-ClientProxiedBy: TYCP301CA0079.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::15) To MW4PR12MB6873.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ccb831-b723-459e-979e-08df3e581bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|56012099006|11063799006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	L2wPAHE2AEYx2KVIWaBBDZkSWsU0Mwgouh40g+hxl7nuJUXLv/ySBVwo9e1LlaRa2yCftn1IkKAHAqtF2lxIBS2cuzt8vGx9PZjlGlXrM/Bm5EEwwK30G4vDX9o0ow/Xw3vQFnJJ9ctl8bX222WhTY5veKofq5rhs0CqaBWT84v5mDfJRRYxbHwT2DvC01yWghbNEQtCgiqqm8/3kuPLNyKVaMHxdvoFmU0BL1M0zqNT1OZ6gMq8xaKbfXhetNrXd9X2EeaUmFboABk3KdE9Zv1lvmN1gu7ufzT1qbi4zHJR6RmvL+vh9YRpezVd2zvOd4146OT+zrgVH0f3OREZO0c8qcgE1+0FJpOK8GW4+ov5hU3v5rM7DxDX97Txt3MRfNJSUixp9MM3hN7yOQg4nqFPd1MCi6NQdCtYGgbNAssrEHmuk5TuZYDG/thc3krtq6Z5Sk5YljZTTsfeLXNA0XLuj+idgpKaJQNBZ21o7ljYrKNTEaBExcPV3lOC6U8gR2MvQVwmWjmK+PACoxkGMIwRIDyOfrL7x7+DdovsvjKltsz12Gj96xNLTLliQIxcC+mFYDh4yayHGu5nkamtvIkH44ZQJv/t8mvSN5+QI0RXSUGXE1qohpXHIKjplX2mqc0KEvXa1oG5A3YyCXXAXCl5Q6FYhJVwFLtwN8Kk+L4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THUwQlZHbG9kWS8xeVd4b1RxcmhDd2RjVGRraGJUSGJ1MWhJVWVOTzcvTVlH?=
 =?utf-8?B?cnhMd1E3dERUN0FCczVxYXBqWEZLUU9mOGk5WXVQb24zcWN5QytQUEd3Z0Vh?=
 =?utf-8?B?aWMrVFA3UU5qall2VXBWcjdnYnQydEJ2ckJ3bG9vbXVWeFdwemM3Z09vTWFj?=
 =?utf-8?B?R3kzZEl5T00raWdKTk94TVJtMzRSaFdFck9IcENQZkhoT1NmN1FiY29Od3Rj?=
 =?utf-8?B?Wk9vZ3dINHArVXpYZC96TWxzSENubjZqcW42VjBCNHhGVHBVNGFER1BRa1Vi?=
 =?utf-8?B?VVFwb1VRNFZ6RDhRbkZPS2l4d0hkNG11Vys5WkJIendMeWFkdXBWSGZSdUZs?=
 =?utf-8?B?NFByWlpEZFQyTy9CWm5CRmZCZXQ0SmY3L2VnMlk1d3RQVjBNM1NSdGtJQlla?=
 =?utf-8?B?alZlRWl1V29DTGdMYXNwK0dNWXFaV0orM2lIMXR6QzA4NjM4cmJETGtQNkI1?=
 =?utf-8?B?bFkwNjJpZnErZ1hYUHVuWnZCVUxhWWx0QXFiYnBRdWpFb2VhRXoxRi9IWWFY?=
 =?utf-8?B?ODBJbklIQ1FXRlNFNmkydDZMaTg2R3VOL25SYVlId1kxalFHTzNRbkdLa1gr?=
 =?utf-8?B?ZC9KYi9WaU5iM3FIbjJKcWtNeWtBSE9tNlBSR3pzeklqK0ZWMUowWmp6L0tR?=
 =?utf-8?B?MXV1aUJHRzZOWGk4QUNJK1Zla1BhbFdoTHFRRDZZRTJ0bDAwT2I0ZW5IbzRa?=
 =?utf-8?B?T0pkb2FuZXREcnE1d2RGZWNxOXJkcGVjZXoxaG1rdVdHVFNrcXVhMm5jVE5R?=
 =?utf-8?B?U1hpSFoydGVBUFlTcVhyOCt0V0ZKVjU1QmllL0xGMlZydFdDTnd3Mm14NlV6?=
 =?utf-8?B?NE01Rk9OL1BDa2ZPN3l4MDVFbStoKzlFTzBVRWJHbHBNMGpQaFVyWitoWkpp?=
 =?utf-8?B?dzZGRDlNdEt4VHcvWUQyQjBid05QOXBWZUJpRXpRdTZiRVpKUjBqQVE0RHNn?=
 =?utf-8?B?NzNFbHByWlV4T0haNVRBUGVNREl2bWVYR3U2bi9jeHJkMkZ5Z0dFWGo1TGJC?=
 =?utf-8?B?cG9URk5yM21SNGF6c1VaNGZmYnI4bXE0TmxoYUNaWFJna0F2QUJQV001R1pU?=
 =?utf-8?B?MmFJa2ZrNlVUTVBNOFNoUFZFTjRHV0c2S21mK0lxdlJvKy9KNjdubk5qNkRJ?=
 =?utf-8?B?NldQVVpEYjhNMEhzaFJzNm1WRmppQ0hQL1VCZ3J4Z0FFMG1WQ2hISmNWRnVH?=
 =?utf-8?B?d3FGMTFqUnVZM1J2Rlp0UTJEYWtQYWR6aitHRlM3MHNnb2hYQ0daWjQycTBW?=
 =?utf-8?B?RHVoSjhtcWR4YUMvZ1FiUnFjOE85Zk1xN09WWTVMcGdTWkswTmthQS9ENTE1?=
 =?utf-8?B?bVB0SkpUQ2YxZlJpUlBnOFozWGFaZzltclM4bk5LNCtNNUhqZDhvTkxKMXdR?=
 =?utf-8?B?UGZoSzVqS3ZPdjRmTmpVN25MMFlnOEEwSzF0enk4Qk1tblVKQjRjRlFOWUhN?=
 =?utf-8?B?eGpkWCt3SVVaV3p1anJuVVlOVS9JMWozSVJzbHphN1B5Tm1ub2JVVTY5czQv?=
 =?utf-8?B?MHY0WmhVZDRMeTFoTzZybnQxdXd2R0RXWEVZeHZOajlOa3F1TmZjckpGWVZ2?=
 =?utf-8?B?SkliaG5yQWFPUGtRZ2J3VVVGVWxjN0NtMUxuWjhKS0VobFZVdGdlSmprUnV4?=
 =?utf-8?B?R09WV3QwNCswUkJmM1U3K0RxVDU2S21id0FBbWsvSnBEQzdmT25XVnkxNzln?=
 =?utf-8?B?WTNUU0lyWG41R05qNmJmT0xiLzhwTWgxZ0FHb21RRVRLVWYzeUVKMWVRRThW?=
 =?utf-8?B?aXpuYjZQcEk5V2t5aCtFUDR2dDk0bGNPV1d5ZE9OMmNNb0Z2cUVPOWNjdVJQ?=
 =?utf-8?B?UTF4TXJteEExa3BaakxBN0UreGtWYm9tUjltRmtuUTFXNzBhY3VnQ0tFblla?=
 =?utf-8?B?R3FIT3V6dC9LeSs4THcvVWJpRHpTdmhKZkRja25JUE9PVUxyOHBpUGQwM2ll?=
 =?utf-8?B?TUUrWXpPaDlpNldiVC95Wit0dml1SnBCdWF3aUhSWWpPUWVDREYyTW15K1pi?=
 =?utf-8?B?QkM3K3A2U3ZickYrYVJ5MzZ3STVoUzZ5WU9tc3paN3UzZkNmWFRaWU1MNEtV?=
 =?utf-8?B?bjJLQmR0MlZ5LzdiM2lydGdla2VDZ2dsdjRtTlJPSlg0RWI1SGxZVlRob3R4?=
 =?utf-8?B?Rk5zbU5ROUJrVGZyaDdYWGducVhOb3RkelJPVWgweHRoNFd4bkt2M3RNYm16?=
 =?utf-8?B?d01odkpHZjJtbnpJUVc3Y3RxRWNYeG8yNkZWaW00bTNvaEhoQXZib2tFdTV1?=
 =?utf-8?B?bjdVQW1DK2JZaHV3SndhS0c1bjNvdmtIamg4SFJ5NkhaQVZjS3BMUngzMXl4?=
 =?utf-8?B?NXhZaVU3dGFBMHMxTnBLV3lEaDBxdDN0Y0ZmVHNqdU5lU05GcUpBUHdLZVhq?=
 =?utf-8?Q?fWr3WdQ8lt0f0c5wV1cVa1sL9Drtc7xzpGOfb2Q0jDm9E?=
X-MS-Exchange-AntiSpam-MessageData-1: 3IsKs7CyCUWRhA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ccb831-b723-459e-979e-08df3e581bd2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:53:45.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKVTqrcr66/LYcLuqVRpQxOEm6D0tGSWsWoeb2VGd38ERS3ecQuxWi/KJDB9VQkqUwuTDM+O4M9UpEzSA3pLBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

On Sat Oct 31, 2026 at 2:12 AM JST, Simon Song wrote:
> From: Zhi Wang <zhiw@nvidia.com>
>
> Rust PF and VF drivers bind to separate PCI devices and may reside
> in different modules. A VF driver that calls PF operations needs
> typed access to the data exposed by the PF driver. This data must
> remain valid until VF driver removal completes.
>
> Add VfRegistration to register a pinned object in the PF's private
> data. VF drivers can borrow it after checking the requested Rust
> type, using a higher-ranked closure or a covariant lifetime encoding.
>
> Capture the core callback context in the initializer. Reject active
> VFs and an occupied registration slot before initializing the payload,
> then recheck the slot before publication in case the payload initializer
> created another registration. Publish only after all fallible work.
>
> During registration teardown, disable SR-IOV and wait for VF remove
> callbacks to finish before clearing the pointer and dropping the object.
>
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
