Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794446954;
	b=yJlwQwUY99kn4T5FerGQsJkCI87erVTMHOhU10CEIg/gD7C5UYjq9BKTA53NzadaIYzU
	 rEZ+2WEGmcCuqaQkpgLVvk3NVcZ5LVsdtFTZaPIPRrWhGyQDtjDye7am0uMoQo1jaa43u
	 uG7o3KsfuwIAGRdPw1S06rQGQuJ+DUr3MuSyfGpxEqs91aeksLj0tCzuyIfbvGJsyqVLm
	 xQtxcRS8PYcyIETnkIfhuEKA1KMZalBIvteYBtBoVpBvf1oyVeSOA2wj8dzCFcXd08D7f
	 xrkPVJ3eRNwEJYk5KC5HpVMX0QpnndaLpZpCtB0eS5bB7gEGLCq+CAnmz6vq6WytmOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446954;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=5QT4EvniR3uKlQ5VCj6SkbHLcRDV3VjZA1rynJzvH2E=;
	b=wimzSsy1rEVK1fIGmRAmikP5fo86GQOGm/LuQIZOM2Dgtxcbw75ibvrN6l7HjUDLRbME
	 W263CzIRRffnXD2BelY0rwoeRigK9UWQ60XErDcAYtpfZcwL2WZK/QFtJEvWV2vpK2HvM
	 yK5RRQcoivKlpM2grscXyJqpyeOGPYlgZDiwhJvDbhOo0usaILJir6WjMN6w5Q8qjxK8L
	 8WrXlYKDbNvXOyklcHTCdIuiNcKP66v93v94HpOSxuvD3rIsdFVaUaCipR66lt8t4jewr
	 yUcdf57YS2c2lOqsipviFzhRVhx5Y846c7Yvg08blqHRxan4p7xZP8Dzg5hWK6PcVdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kK6RIKZj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.59
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4E606AD71;
	Thu, 12 Nov 2026 01:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7A4E606AD71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kK6RIKZj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIJ4tTmArEZaMBnwVd98vgPbqPH8mZR2X2beXu1V42iuLKZBr9JUTaFX2R6a1NpUXn+dGU6iGdRFLB2HERa1rJ6DncG7xVSDt1rrMyaeJLB6NKzLryYnFXaPMac77ud4qnclXaSICSQv1qWS0jp0sK9kow4dBzaTRDFaYXGhLEeY8OgMEles9Li+fYO2ZYQvjxJPtTVOwxyGia59a5hONt9pmXSM3QBbQnu/gyZ5sbnCedPaY+PbXot7KU+jPVZNdWGoPA3jK2vQYmq2grLT+On9gdR7Y5VPP4WWTL9FhdGirS/qX8bVhGT7WOK8l6KtwbRqRMcw2NzQ23KkGx8/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QT4EvniR3uKlQ5VCj6SkbHLcRDV3VjZA1rynJzvH2E=;
 b=plI2pjgs1MD90aups4tXaZOaAeqbXoYc4+3/9eUqkqbLyGiHi09EthasKlaFudhFAus/52SUGAIwbIkinrwKwlcZGAcniTP8yJC/DABOyUhdBIZ9675BQGvI6F38FHAk9VbQd+e4/rTvL5qcHyB8otQzqkXcE8Yrz6luo2y6w862V14+0Gy2W+aoKpkV6tPJp8j44yD8++HB3gkcv52IEWvE6N+BBo7SCOg0vxEayAhQT2I3VOf2p+UyJwQKaJMzu8zTJ/VVXPJdBwv0Y13STHatSuRMP6MskXvzHSdAW1FfESKK8qAi4ojOYapS5rMS2Hjy2uPx/7e60E+9lnHbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QT4EvniR3uKlQ5VCj6SkbHLcRDV3VjZA1rynJzvH2E=;
 b=kK6RIKZj+ld5KLYGLSyEYZwBglXaOnuKtyq9vGSC3ixov6cIqCAd/KFtJR+/X7E0JXD1iJ0X9oFxIMROWVE/K/CFgPu0zBEZyUVL6sga165eU+0GmjoDPdztXpKIyHiuOhlWYxXrEEiRanDHgAzKH8pNDHlvqidR9ReBWs8HRQLciw8HwPsA+0UZmVGOBQLk8Z1v6o5Tqpps7DPTPJTwGum96Z7wjCgcLf/JHU3mxkIsMVZ5sP8FH4atVr1Wjvvma6tLMADFXHl1JryZDWRiR4wsVL557uZEtqgjZ7esWjyF7Kx/AJwSVRA7P+uLBz7uGW6VeViP3DM9cYN6WK2cIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LY0PR12MB782425.namprd12.prod.outlook.com (2603:10b6:404:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 01:28:53 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 01:28:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 10:28:47 +0900
Message-Id: <DMSUCI9KUSGF.2L3H9TW3JAY5O@nvidia.com>
Subject: Re: [PATCH v2 1/1] rust: pci: add domain_nr() accessor
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Timur Tabi" <ttabi@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "LKML"
 <linux-kernel@vger.kernel.org>
References: <20261111200549.160806-1-jhubbard@nvidia.com>
 <20261111200549.160806-2-jhubbard@nvidia.com>
In-Reply-To: <20261111200549.160806-2-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCP286CA0374.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::9) To MW4PR12MB6873.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LY0PR12MB782425:EE_
X-MS-Office365-Filtering-Correlation-Id: d6955cdd-4312-4e67-f491-08df405c4e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|10070799003|376014|22082099003|18002099003|11063799006|56012099006|4143699003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ESwJOoXgokRzCjShHp17//gwk8Q7nvs4W3fkGJfIMCnN2pOk04JJ8BrOrHZrYhhuq/b1Xmwa09RJHBF4qWJ/qFScSZdPvXWJ68zfhXNMLM1qQoOKyuymiQ1k3GG2ATVPFvbKRc3LYUUhqfbo2enCHXTMA6sSReGqQEQ6PcQBuWZr2IoxlWbQBEP5iZCbq+vwaTtCFmOtNzqgUhy1j1g9cn8Grunpugodq9D6uyfhQTXzJ3m7arGgg6+pGqKD9Xs1OedW4zrwH0TyVLTinWqQjgIhUSYsxJRvAKA2UMOmWczMJj3rGIaOdqY+uyCeLZl963vJTCYy+1h9Oj9QmJaUnCA9s9qYUdMeIBjWZE9E/0k+KC+krQjJI5J0QH4u38gl5A6WS8FRdvCrWUubq7h5Wj0ME897TOa9WoPmb/9YtB4SpwdWOEl1F/4yEnu6ymseiboNx1iANSiDfytow62Hi9fVsVC8cL2u+7JNs/tJsxwJPNHb5D+y8W7YepXbNvhCt/y7ozRjfHs7fp3v99OfWo55snH2/Pl8k8n6mbO7SLf1AJ+ceczH+Zk/jHArlSj7WlFsqTjon7Lr2ErznAgzkk3I9VYgDnADUnmsU6FPuGa8oyYcIFJnGoBuhnU4OGSQxOpUaO6WNZqFsJuuzi0bjFlsCellM4U0BPA8/joSGSU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(10070799003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3U3WGV6Y05mdlMvWXREazBjSlh4bUUrQnhkUGRIM0xwUDNqVjdGaUc2d3l1?=
 =?utf-8?B?VTc5a2swSGVPM1FmSE04emtDU2xYQjNhc3M4ekFmS1d3dkF4NGRhWTZFeGhu?=
 =?utf-8?B?SzF5dndCNFVGMHREZkxFOWFwdGVpUFJnSTVjUzFHRXlwdDE1S0RrZC80U1Mr?=
 =?utf-8?B?UHliLzUySTJjSmVlT0lsdmNFZGRyN1RtSXZXN1VkWDduc0N2c1JwRTlSMHpn?=
 =?utf-8?B?R2pBN1ArS09xbmJ3WkRlQ0wrRkRZRC9uLzV1NHJUTFh3djM1TjR3dkxRQWZX?=
 =?utf-8?B?a3hXK1ZxRkEvN09iMVpya0VHdlk5UldPdXlrcU5xWGl0dXBXY3NQN0FLZWE0?=
 =?utf-8?B?RHZ2bTR4MXFaWms0SnVRcm5RUk9XS3JVSUZkb3RJSUNaWVBYTW0ydGkzMGlv?=
 =?utf-8?B?alZiQi9HcU5qTnJHdlk1OG9tcktMT29JSVcvcmdRckVWNDYrWmt3TENXY2pB?=
 =?utf-8?B?MzdLaE1ONGtSQUFRMURRdWFPWXJPREcrK0lROFE5YWE5QnZBZDN4REJkL0Fj?=
 =?utf-8?B?OFVDL3hSNjUxZWl2dFBNTDlGaW5vbGM1TVpZc0hINS8zbEk2VEFoNjgyL1U2?=
 =?utf-8?B?MEpYQUJGYlZCa3ZlTXppU0FVNWJkamJwalVrOE1McXNtaE5vT01nRXVPRlZw?=
 =?utf-8?B?NGsvQWErMUxnSGVLNjRLM3VyaUZaRDd3Q2ZDd2tBZG9FY2VEUU5yZmplTFdx?=
 =?utf-8?B?RjZPWENRWHh2QUg1c3JPRXYzb01CSnRvVUtzV0I3SmFkMlpwclM4L1V4RjUv?=
 =?utf-8?B?N1lrVkY5U1J5YU1BVVEyQXllS2M1bU1xYTl3SFQvM2ROZ2EyL2ljVFROcUlC?=
 =?utf-8?B?ejcyaU4wbXNyMWxGaExienZkUTk4K2lWUUVaUnNHSlR6T1diRzFPaUptNUw4?=
 =?utf-8?B?K0V5dXlCVmtnQkYrclhoYjRKRTZzUm04VE1BY1FUSm5KWHNVRXhMUEUvNkVR?=
 =?utf-8?B?eWxPelVOYWJxSlpXdFprcW5WYjFsTjNRWGlPYUcyeU42NHc5N1FFVElYdlVR?=
 =?utf-8?B?L0JWL3RWS3Q4RVhhS3lUdHlzbm1GeldkMVhoWllpMmMyZDNPY29ySnZKTEZE?=
 =?utf-8?B?aGZsd2NQcGd1VE1jUUhEcThYYlVwcUg5dy92L3VFUFNuNmtJdkR0Y1ZaUDNw?=
 =?utf-8?B?QUpickRLdlNTN1NoSVZ4ZEdMMlA1REFnOWg4UjJENXhPR3VPa3R5YU9rcEVH?=
 =?utf-8?B?K25saEpCSjhxVEtzMEF1ZGxyelZVdGQ5TVRkaGg0WjRwajBFajVvbG5VSWlG?=
 =?utf-8?B?cHV5UmMvVmpZRVdQZXgxQUVCSU9WTE1pNjd4MkR1ZTF3Yy9xN002NU5Cbmpk?=
 =?utf-8?B?OTdFTUNPb0NRL2JQRVBxUFllajRITHE1cEZjNlRDT2tSSTh1YTBzN3lhSHRF?=
 =?utf-8?B?cTJ1czVrTVAyODZDZXBqTTJlMU1WK1F4Zkc5Tzd4bnZTRGF6R245VkhpZDVp?=
 =?utf-8?B?anhLMnphTFFJSnNZdm55UTFUQ1lacXY0QUtCM0tIWXlLVXpXMEFCNWZUdzU4?=
 =?utf-8?B?L3hCaXQxenNQL20rN0lscm9jcnVNOW9nZGk4Z1ZQUHpBRkQxSTdyS1EwdCt6?=
 =?utf-8?B?NnpqTUdMeXNDK2hLeGQ5cWtUd2MwMEk5SmhwbnNuYXU0T2NpMytHbXNOOFpT?=
 =?utf-8?B?eFAzSmljZXpPbEVmeUt3VGt0WnI0c096dEIwb2R2L2d4UmxFZm9oWGhOTmdr?=
 =?utf-8?B?Vll2TDYzTWpQRVRKNWF6QlRVMTd3enVmTXl5bjNRcmNQWnpQcXNKaDlzR0kv?=
 =?utf-8?B?K0lXRDZybHRrdGpDdHM0Z1hDb3BLWFlNV2ppRldiVTFnUWFqWkRCRDdpRFd3?=
 =?utf-8?B?dTN3bVFGMVgvUW5TMWhScFJYYW4xaHdjMHVYMFNuZTZFWVJlNkwyRUg5emRN?=
 =?utf-8?B?cGtPSTkzZ0l0cndWUi9DZ2pidE1taEQzU2lrbkZXQlFMbk0yZ29NampQSSsx?=
 =?utf-8?B?NG9ScUdtbGNKZk9peG9GS1RFYWVEUVd2eVg4NDhEOWZOTmZpOEp4YWVHV2hC?=
 =?utf-8?B?RFNxUG8xeGNISlh0MGhkRiszaS84ODFhbmhMLys0WFN4WWJZbUtxODQzc1pa?=
 =?utf-8?B?b2lneUIrZEZZdnMxQVF4STYzdzFyYXlWRjk2TCswSHcvV1M5cHRyd0NuV0VG?=
 =?utf-8?B?OEJHelJBeXQ5VjhDc05lZEpDbzZ0QmZpZk15NGpFU0lLU3FhYTQ4dG1PQWFw?=
 =?utf-8?B?U1NGNVh4Yy90dzd3UFoxMy9oR0lGYW9Db3E2ZUZvM3IyaVV5dFRSdUJjbnBT?=
 =?utf-8?B?cmdxUk4xV21QcXladDVxR2hnbmhHQ2RIOFhsekpJRDVNRUMybWhaaUZvRG51?=
 =?utf-8?B?L0p0VkNqVkRVaTBMaWtqSlBMVDdLaTQ3N2E0YmZwR3R2WDZpcWpMQUVFYi9E?=
 =?utf-8?Q?T/Qop0Df4huitKfS537LaapU0ZSssMJwYbCHe/2MRbMQ1?=
X-MS-Exchange-AntiSpam-MessageData-1: h5tPUqJ8ombPBg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6955cdd-4312-4e67-f491-08df405c4e96
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 01:28:51.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvCWSzIUemXyQCb4/GUtwl6tsjGcICIqhZ+8IgIjj3082AANd+I1E8zN/qlG8VzbDLcJhTTLyZaKq1Jp2XvddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB782425

On Thu Nov 12, 2026 at 5:05 AM JST, John Hubbard wrote:
> The nova-core driver has to send the GPU's PCI location to the GPU's
> firmware as one word that holds the domain, the bus and the device
> number.
>
> The PCI abstraction has dev_id(), which packs the bus, the device and
> the function into one value. It has no accessor that reports the domain.
>
> Add an accessor for the domain number.
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
