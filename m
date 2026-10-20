Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792497848;
	b=tElg0s5RzB00cChsNKdb8NswdisZIXEsHTavwr8V09sL6p4HQoh37XT282iC6KFE/dhY
	 4/VZTCsBM3spAevezb5ByEevjuP+REeYatQfCuxYJOOMJ1IctlDXee9JV3hMFaR22KIlT
	 VVXT8Ix4AiWl+bJYQppq+oUk4VyRI8KmhkIhtKD647jIr22oH0VquenLbIrv+58/+w1z/
	 5+ga9Z1StHqgLq5gF6Bb/IKB6llVa3woJF5B+Mk/atr45IbaRec7EmzNu15H466MI/nj5
	 +wV6e0KdamSJNbUGGXdbyEBOH0mMh3WEXuc3P66QxeZUYJQ69rfHsVU14kCyjoPAv5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497848;
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
	bh=KzFXl+AaErNTI2wD4mE4/DRpMDEgy0gi3JWR+vO77XI=;
	b=aKu6FBjbNc4SNOJHgFYUsOmtJ1C77B0MidGiVADxznuyT393QzG21J/YptJUBO1sLhTR
	 xO86e4olNWHFBeALhnuyd8GY6HYXkEKqqLj3Awfg3Z0siKewxCM1od0z57cf0NLsyKASC
	 K3kN769uKvsTypuIC+xCgtu+A2fl0KP0e3loc5Rt/akHG7NyUuAxyHpMjNLRUyQtOfUBy
	 U8Z0tg93fO5kRQZMVUeiOua+Ev4Y12AhNTDM+DzKuDs3D7uLzhIe81kSwt+R/37ykQQo5
	 Oje3ZH2+5FIKmemCBfP8p9Pt0scT/vVmIr8EhR12tkh3QbtlPEeCZ2YyLFtg0g/u1yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=bQXR8Qf5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.84
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020084.outbound.protection.outlook.com [52.101.195.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5B606A319;
	Tue, 20 Oct 2026 12:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14F5B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=bQXR8Qf5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHNWVWMZvBUlMFWTt2RQ0qM2Ucm8qGKy4ky8FBjgOWgjFhUHcCQiEyHqdT4GoS8togvlhKUabKC5ggQgbYqPufY5gI+j8Umg20Y0glh50OGPmyWBuAVCJJ4QBEh9NF4H384paICboTzgm5fQIlb8LysLuB0JWyNm7muO7IyhKiNCI+nbqJpm4nh8BbjBC4eQZxRhgrqi1UmE4alIIwCtyGx6R6uol23aZJ9X4M5O4jQGTmDCDCSja7br3OXelAVp66KasDiRFReza0k2eEh9nYuljS/UnocKoewDs9D+kCGx1EmJVZZ1DvyTk3GLZXIS0+70zQ1JO5sLZNI2pZEZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzFXl+AaErNTI2wD4mE4/DRpMDEgy0gi3JWR+vO77XI=;
 b=BqLshxeQ3yCBnbEBWpVvhSlkoFcL/K1ri0pY8j7Itmo+p1ceGORYGP8cHBpu9yQVuCbNgLz5XuXN07XMsW4HD8Qqo4VN6APJLYPN17JOed17t5Q7AsF6JZgCSLokJgolKwMQ3JCMN4uiSMf49MrbUZfrxSufYDJifs5CHhfsQnS2i0JewjKmipI5xOV+8qhw4OAhTz5Bk3BjIPrPj/XOvyXBLa71aFI+CVBPfTzqiQuOeSsEFmuhlk1AAH58ly+/Ti9G+KhXvXG0g6JF8TkMq36FbddNIuU8yon06xWhoKwr22NVX4/1U8hl3Eqf539wewBAxTTGF7Nc+/XG7f4QKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzFXl+AaErNTI2wD4mE4/DRpMDEgy0gi3JWR+vO77XI=;
 b=bQXR8Qf5aZVm/TscbTXhSn1IpNhEOnG/AeZymOeVtPFrd2sv0uKWgC/19HNQAQLXAzxNKA/QX9p7bN6a+tefB79GTWgJm2qn0MYTrPhC5fNCAupt96wZnBq98Pox7EA7IgU2KTIh2qz3jaMzTmPzMbpQPvKn5P9hLX4eDf776e8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB5650.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:159::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 12:04:03 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 12:04:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 13:04:03 +0100
Message-Id: <DM9NGD5R8AP9.C4K59HIUYFDQ@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/7] rust: io: split IoCapable into IoReadable and
 IoWritable
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-1-93611b84b5e3@collabora.com>
In-Reply-To: <20261015-io-access-modes-v1-1-93611b84b5e3@collabora.com>
X-ClientProxiedBy: LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6cbdcf-6e57-4606-4e69-08df2ea23c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|366016|376014|1800799024|23010399003|921020|4143699003|5023799004|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M5YHZ0ZyG5zUaLKUVxi4s2DNmA2RiH+ZZlkR5gWhq9idwFlEnQ6pSBskTC2D+BzmoozQk77rMXJHCzhJH71pBQDrAol73wGuNZc0A3R/4CK8gVduALBnqyTXgRkHmANcEF94+VEj/VjP72DCo/cVmeUhf9QbUNQdslMBK3CH1QfwJTQ0iKF5VbxFOQC+tmzae6h3RD4UvXxEzHCE7RHwnrXJwmHZNNNu5epFdWLCObFu/IQGC170mCfnDKM/12VtWSIKQC/mJ1s3a8D/jLPZFGUiboVS6Zg65dZaPDXXGIykvoCnH6TJ3hruesu+ayq2ZbS1VZg03qptEBo2/XGTSXJEmjlmUBOv5ERvVhFRgZRiI0aHK85xELc/BdHONzGdz4LThIfDnuSzoEg5g7Zjo1kQ/qBkp1slIOBlDY6apceWpRmVJ7KOhOtdNStsWK0mO+eyMX5WOBoAjectG/JP7tMXmSdnRwGcOGj7otapr/TiiETvrOmglNQjbJ/DrhRAqcHWao3kBMsJRsB4Pff4gMdfgNFUmRN+F1B5dxp62hp0pDX14BWtuoRrYjOaqIrfsYj71/C5M21cHqTVFkosmZCfKPZOViOPf/Fv5w4IcgR0NFEC0P1B/gaje42c08/mqz2bi6emGoac9NUH2X1sPRJeXRRpODAT9QUukzIUrKAF/6nyP5ivbLuovrWbZRqiHKMGya8F2Eu/ssoINq7DQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(366016)(376014)(1800799024)(23010399003)(921020)(4143699003)(5023799004)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUowWXdwelZQaHp3NXRHNUZKZm1TeHYrR1JsZkgxeWNHUGthelFVMUphNks3?=
 =?utf-8?B?WkdxRENtZGFWb05GT09kQytHZW4vWkJ4cW1IL2t0NG8wTldLWnV5ZDRva2ww?=
 =?utf-8?B?Q3IwQ3JyZjlKd1QycEZ1MEhYNGY4UEUzakR0WUgvaVpJM0piQTI5eitRaDJl?=
 =?utf-8?B?bjFTS2xFeFdmR2IyQVJKUGc5Skk0Rm15OFlkU2hVS2JWN0IzTzNyR2g1SEZF?=
 =?utf-8?B?Mm52TVRvZThIQ2syR1ovQmRyOVV6Mk1TMkNmSGhyMjhOSS83U2M3RVoyZjMw?=
 =?utf-8?B?WS9IYUFTbzFHaEMxZGlRazVFR0VWWDIrdWtHdmlXQjJXZHFDQ0xITFJkSDlZ?=
 =?utf-8?B?bHlGS1BiRUdRTkZpSG5OY3Q1WFVndC9XZmw4Smh4b1JFNkJIN2F6d2xwTW5I?=
 =?utf-8?B?b0orN2x2L1R6S25NMUlrejhIYW5GSUxKVUI4RDJYS3RIYzFsLzllZGtSbnRV?=
 =?utf-8?B?VkVzd1h3MU1WNW1TdGN6OVFTOVNZakRVLzRFY3pSV3QzM2E2VUhkVmIwZk1z?=
 =?utf-8?B?OWxZYloyL3hHbUMydStFbWkyRW53aU9SdStvaGlQdkVjM1VzTHYrSmhvUHhC?=
 =?utf-8?B?TkYzdVJUWjlKZ0k5RExqeUlud3RTYWh1N3gva1Q3M3drZ2J1YmdQZUN0R0Fl?=
 =?utf-8?B?OG1lMkwrY2UxZFdjcVlGbEpiODFPTXBxUi9tMG44d0RVeVZ3MFd6Y24xUEpM?=
 =?utf-8?B?Z3FhRVhUTHBhTnM1bmhmdk1UZEwvZEY4Z1piZFJKWVBOVTdFVFJSTTN1WXlU?=
 =?utf-8?B?b3NIeldOYWxoRnJiTUNPZTNrREUxOUk0SjRXZ1FPelhjbWgvUUNNOWIwRXA5?=
 =?utf-8?B?SmRWOWk1QXZxUzV4d0xWOFNsNG5tU2J4SHRlRGZtdG82eHJKZWcxUWZoeXpP?=
 =?utf-8?B?WHBlVVZpVkRpUGhwRG0zSStsSG9PNjJaV3ZaZUUvQ3c1aTdUT3UwbTdURUtq?=
 =?utf-8?B?Zi83dE5OWnVRd04yZUMvNlVDOXJVUVJuMk5maU9VN01CVWNaSXhTSFpBN2h3?=
 =?utf-8?B?Z1RPdlUzaUtlRjJCcFFJYmdLVk9mOWlTeS8va1NPcU9iOHluQ3ZoRm9PNDVq?=
 =?utf-8?B?c0xRaEl5a0s0eWs0Mzh5b1h6VmI2d3M0bzBWTjErTjFkUzhiN0ZwbGdKa3J3?=
 =?utf-8?B?SXF3QlJlbDBFT3Nhdnd6WGcwK1pOdTB6R2hQaXoydmFDK0NDeWZrRHJnZXk4?=
 =?utf-8?B?SHMzNGtvcXkzUGF6aisxMlhKdEMwWmZvT1crbDY0N3J6WENEeGFrTUMvSEYz?=
 =?utf-8?B?T1VxTUZycFM4eXJhdU13ZzNHbHUvVWxwTjBRSk50T0RZMVc2ZVdtZXFLOXZV?=
 =?utf-8?B?V2ltVDhTUlRPMXJJbWhvdm83ekdPanVENEFQRFdSQ0JMeVlzcmsvVW1tTlpj?=
 =?utf-8?B?emFtNnJNUHZVNHlmRGl2UWI2dk9EaTgzeVhXN2lTR2FEVHdpWGRXcjZmZ0RK?=
 =?utf-8?B?Z0d0L0srN2llajJBVGZrbFhWWXF0Q0Q5UlRJTElya1JEQTdPUTVseERGTUU0?=
 =?utf-8?B?T3BCQlBSRXNKaVlaaXFHa1llUmZINjlPNWlUTXZidldpMG9VWGI0N3BSUWIx?=
 =?utf-8?B?MHB0VmVBKzdIMmliS1RNNFJwd0lFeStvLzB3NjZTTDNoM0gxYUdITHdMeUgz?=
 =?utf-8?B?NWRMVzkyMXhWdzZzTk0yNEZlZjYvWXByUGlkcmNIT0NpVUk4LzNFN1pTbnF0?=
 =?utf-8?B?WHFYdkFsZHY0NGxNZ3NGNWpPR3VIbWFEMjJPcE1tdHhob2FxOXliTitGNWQ5?=
 =?utf-8?B?NlRjZEYrOWxRQTVKYWFtN3hrNDZmVEQ0ZUd3cy80ZExoTGlPdG4zZGdyendD?=
 =?utf-8?B?K1BwQ3UxWjFpQmNodVV5ZkVSL2dJQjFYMFF1cTlKdms1QmpxUGMveTBLRi9j?=
 =?utf-8?B?WUpNUHJaVjdvNGRjYWVxMzZaa0QxUlRVUVhESXRjSk1xRklqajJyeThsY1Rn?=
 =?utf-8?B?N012cVJ6RUtveE1UV2txbEh4NXFGT2tPbWxPbUwreDdsWWhtb2h3eXJVWGwy?=
 =?utf-8?B?WDFTUmNXRk5ZRWNOaHJ1ai83VHFsdGN3QTc3QTRrVFNSSlJ0eWxSN2ovUTNs?=
 =?utf-8?B?cm85ME9sVmY2NVB4NWNOMTBZWTJYMjZDMXI1Tzl4NlpDazRHdzFLdkw1NjdL?=
 =?utf-8?B?S25JYVZHcE91UlZxVmMydGk0U2FmU1JMRy9ibTZ4ZzJabGlwamxnR1NCVElM?=
 =?utf-8?B?LzFLa2I2K3JPUDcrSVF4eEZEbDVXK3BtZVdqVG05VzNzQ3lMUjRhRUtqUDlL?=
 =?utf-8?B?RWtzYXlNb1djQjZMdzhPTThxelRxTFRld2V4VU10ZnpqRGloNldoTkZsMkY3?=
 =?utf-8?B?WnpoZXhjSkhtbFpCN2xIU0lIckxOcEF3RXVZLzNNMUNIbmdaVXRyUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6cbdcf-6e57-4606-4e69-08df2ea23c11
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:04:03.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AREopS8yX6bF4JmvpG7dcg8HlywIPBq1r/rG6Ukj4sLpkUXp3GWTlTHn9KZsWLDFp0cyOLucmLVARbu5Anxw+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5650

On Thu Oct 15, 2026 at 1:39 PM BST, Daniel Almeida wrote:
> `IoCapable<T>` provides both `io_read` and `io_write`, so a backend that
> supports accesses of type `T` supports them in both directions, and every
> (non-copy) `Io` method that reads or writes a value requires both. There
> is no way to express a backend, or a view, that can only be read or only
> be written.
>
> Thus, replace `IoCapable<T>` with an `IoReadable<T>` trait holding
> `io_read` and an `IoWritable<T>` trait holding `io_write`, and implement
> both for all existing backends. The non-copy `Io` methods that read a
> value now require `IoReadable` and those that write one require
> `IoWritable`. `update` and `try_update` read and then write, so they
> require both.
>
> The copy methods use `IoCopyable` and are not changed here.
>
> No functional change intended. This prepares for read-only and write-only
> views, added in a following patch.

I think by Rust convention these should be named `IoRead`/`IoWrite`, but we=
've
aleady named this `IoCapable` and I further made the mistake of adding
`IoCopyable`...

So I guess I'm not in a good position to ask for name change, but we should
consider it. Apart from the name:

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary

>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/dma.rs    |  12 ++++--
>  rust/kernel/io.rs     | 101 +++++++++++++++++++++++++++++---------------=
------
>  rust/kernel/pci/io.rs |  10 +++--
>  3 files changed, 75 insertions(+), 48 deletions(-)

