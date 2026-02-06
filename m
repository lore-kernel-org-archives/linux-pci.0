Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020137.outbound.protection.outlook.com [52.101.196.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8C2741B5;
	Fri,  6 Feb 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390183; cv=fail; b=ICUTfobGyUpISpNIHy35cWha959sg60o8+yola6g7ETaiFEPRJZ57doHeDVTFZcvuiUgy0k6Vz2IoXCpKUhVQUjD6OMD4MZojNJy9JWxD1eOAYYOUUj8HF6g8g5mm9YI6JFl6brl28GZ0JzgvT0cAcKo/U1ah/BrsIZoujAPjFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390183; c=relaxed/simple;
	bh=OP2XoAyVJ0h0Mez0pXT1qgitwpANvxJWDCnz6STqL7k=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fWMiStcUtEIPgMAZ7bvj9xLOwwdo9TMRk91cgbXgREqeflx4cinNe5N1895jSpcl/b/I4//Ev96PqwNESQmQor+3P4a5rhZOYS+7DR7pnFjEehoAoY3cuXhBASfJkBYhXT2AtX9ApDYxuVFzlpCzuAnbN4VnZs2ewQTkE8GIYCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=c82VPFXM; arc=fail smtp.client-ip=52.101.196.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="c82VPFXM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO5jPdw5FNQm4uhz8nln40IOgt1OvkZrmRFVJiZF+kWfFgfZBKxHqKj00Xur85wNZocgoojfay3b0/lzyJtT5L6ygAz21HymfLUAX7x0GY9TrhzkTLjZyBKrN9lY3mDa5jcmGWG8a1/L/5VjBo58n3VpeLakTyL7sacREQfbIosM/4UL+H0PpaRiCsOD8P9NXJxaKFzWt+xtuTA6sFZ9FpF8mCDWynVV0goZ4JlZ57S7u6DgIdyS61DBRajeJAp+jIiBGBRG9b1tNueXgoqw/A93e3X10hEHQwYRn0xGbbki1UYhx7RJ+rc6MB6MNBdLFeqBx241QDzO9YogoNWiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+jOyuhidPbi0argzvsoLZn/R39otbPwlek71zlY4EU=;
 b=w6yfaFY2A/PZE3KB32ZLAe8c0NH/e/ekpIcV7V0/ovWe975Z6eF9WLs8eJRoKfC1FUsKPo5QWJZ62cbO2lPq7nylqgW36T5SHv6ZDdWLUXbWZdbqzdT15KylKK9n5qs+kUeuDyB0+GYzINwm+atSukTXEj1Z7oXg9E7qkOwqBOFcS71DtG21A55g3koCPDZQuqdiJ86/KNQCgb68xI1ufUAFZILn7JUg+qmPiRypZeGGPcFO5UKnGXOLGCRMn+B9GoeJQKaf2GwjpJmkCIbPqM50NoQze/7GW4bBkn4kU/nQ96YsMaoPh9qi3nhqr3zM7wFCBhGEXVzMeu51uSQVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+jOyuhidPbi0argzvsoLZn/R39otbPwlek71zlY4EU=;
 b=c82VPFXMoQYe1xhcgFDTf8LJ/xHjZ2mhzq7F5Y3bjWZy1pxW4cj+jHSBArEaRx/ypETdrkIxbi7HhRK5WERIGSch4N2ZZpBTJBM5HkCvQyRQhpV3HHPHT83WjrZbnu6HZ0GQuDZZa9LuwoS2USVpCqeA+CnhPiZuUSyGvkarmlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB5395.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 15:02:57 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 15:02:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 15:02:57 +0000
Message-Id: <DG7YXVIJHEWY.BFPZCOIAK1UR@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Lyude Paul" <lyude@redhat.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Subject: Re: [PATCH v2 0/6] rust: io: turn IoCapable into a functional trait
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
In-Reply-To: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
X-ClientProxiedBy: LO4P123CA0480.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e15cf3f-667c-4f34-4d00-08de6590d019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eStuNUhYdXZ1NnNidHVFQUE5K1JWa2ZSaW1zaGh5QXZSODU2WS9rYUxoY2JW?=
 =?utf-8?B?OUNnYTh3eThKeUUyQlFGcVpLNWdvbVgvTmNIRXdsbFMwZ3VaNDNEUnNQMHkv?=
 =?utf-8?B?WW0xODA1OU14MWJ2L0M1OHhHSm9iYU5iNFBoMUx5cnJvV0JwOXp3cTd2Mlk5?=
 =?utf-8?B?bm5KdmU0aUhYcGxvaTlCOHdGY1RUb0N0dzMzUm84VmdPbU1qKzFRV21PWGdJ?=
 =?utf-8?B?WXFhK2o3ODc4ZlpsaWthTGtPb1ZsUlovM01WTFl5SUpaMXdNdHBZSHVzMzcr?=
 =?utf-8?B?aE9jTUJXRnFMdWFUcDRpaHBiYjB0aHQwQ012YmdyNGQyMTZLMVE4ZGlFcVZL?=
 =?utf-8?B?Q1BTOXJTalkxazliWXgrOVFhSFZSUWVvR2JRM093c1pyaUljUitXbGxqaGww?=
 =?utf-8?B?QWlOa3pHOVdUcmJTWnhObkRCVFZnM3ZzRHhJUWhranpVYy9ma3VGaVByUlE5?=
 =?utf-8?B?MDlSV1dzdVRxcnJ4NHpJTGlQaFRzN00zb2hJTEw2cGd3anNyU3hnTndwL3Zw?=
 =?utf-8?B?U1FEazhWWm1RNWloQ2YvMU9XRnF6SlpIU0Q4RDJPRUN5cEhxclNsWTVJNEdC?=
 =?utf-8?B?YVc5T3BzZXg0USsybU4yc0tscTRuNEtzQ25TTVpoajdEallhOGlFZGpwd2hT?=
 =?utf-8?B?eWVXLzJhQmtwU3BuSWlLUjBuVW9HT3BMY3hqaG1zU0VId2VuUm9tNFBYNHIz?=
 =?utf-8?B?Y3dKRGhDTDNNWVFIR0VoQTd3MGZkYzE5L3VYRWhzVHpnazZWT1A4ZnF4UFY3?=
 =?utf-8?B?OEhCWU9nOU5FUzMwRTFRRVAyaFNXWmxKOTRyN244c01mQ1RsQUJ3Tmlja0pt?=
 =?utf-8?B?d1VRYmsxQk52SWRzbGM5WjdMZmJhZXVqMXNrRllnSWdkRW40ZDE2ZmpJUytK?=
 =?utf-8?B?cGY5OFhzQVVFTXJCejlTbXNodEkrb0l6ZE15dkhBcWxVeDFucnlTTkpBTFBJ?=
 =?utf-8?B?cjFNZE9jVXN3VDZVYm1IZlNNR09UOTFjOEdBNEJtcG9DQXFqZnFtUkRMMmdS?=
 =?utf-8?B?bjI4WkMxd0d3RDJsakZEZVlyR1lLSGJ5NHZLcmVJSDR5OU5iZmx5TDlFMy9x?=
 =?utf-8?B?WHdrbGpHM2VsSkUyTUMzZkIxdUNKdkVKOWZad0VXaDhYbE51R09Lb1BoTVEw?=
 =?utf-8?B?VjUzYjA1Vnk2anM3T3dTaVVwQlBMMkEwRHl5ckJ0R1kyN2FmUTlhYlB1TkZl?=
 =?utf-8?B?cmFmbGRoOUJzdlVPUWwwTURtVkxiL2ZDbE42TnFVNHA5cm5CVFR2bGRYb2tE?=
 =?utf-8?B?S3FoaWNVeXJRY2hyYzVpbnB6M0JvbG5CSm8yWlFwa0FsTXNoL2lXaDdWWHcv?=
 =?utf-8?B?S3JVekEwanpieGsvalkrcUFNclBRcjZtbXgrNUVVZVZacjhySE5mT3kvOXA0?=
 =?utf-8?B?YmpEaVpVYndld0ZmTFlSRzhPcXVicXowQ0dMVHdnNWM2U0JYQWp3ODBUdTJN?=
 =?utf-8?B?WHJveUpISEhTN3dJU1ZNdkN4QTdLQldoUDBpS0g5NkpMMkoxTnA0aFJSSXJi?=
 =?utf-8?B?R3MyZElaYUdsTEpzVm9nbUo5dXdacFVjMit3dmIxUlhUbk1FbTZEbHBvSTRw?=
 =?utf-8?B?bEN6WllLT1pwSUVCRlRka0Y3OXF2WnFDRjJpYmtLd24xcVI2MnE2QVloMGNt?=
 =?utf-8?B?Q1JYUlhpemJEY3pUVUc0M2ZmMERuTlA5dUovYUh3K1RYa2o5cjJzaXhNUEx2?=
 =?utf-8?B?aVhlSm9FTEp6K2hLUEtkaTNib1pzQ0Rmd3J3Tlc2T0VzR01xN3BXRFVkR2Fm?=
 =?utf-8?B?cFY0ckxRalhxL2g1cCtSc1llT25RSUhQZ0hqRXcyT0hSekxtRUNTNk1CUTJ4?=
 =?utf-8?B?cXRGVWxxYWpoeGg5NUh5MUl6SytLVWtHOE54M1Roc3BtYjV4UGVxY0RrYjhR?=
 =?utf-8?B?V3l6RCtaYm01OHlPM2tXY21qS0tlQXhKWEFyajFFdTVMMWNqTXFxc3VWZm9j?=
 =?utf-8?B?Rm1ocFlUNzVOTUs4S1FEWVVFK2RiZWdTMmFrOHdkSjdHRFVhbW1CNFpSbG1t?=
 =?utf-8?B?VWtHVTdialowU2N2UmN1UDYxcmd5MHFtbERSN0N2OUt6aTJUbGVtZ3l3b0No?=
 =?utf-8?B?TklzWk96ejFyZTkrOEVSVWVUYjFlbEh5Mkc3TDBTdzlXNmJoajlhUWh0NUE0?=
 =?utf-8?Q?MOzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm9VQTRiMnIwRFVQbUVQYmV1MU1nSFg4MlZXcXdralhOdUVSSDJMZ3UxNnBx?=
 =?utf-8?B?VjNYK29kRmhDeFlIRnVlR1UrOVlTeUErRGcwZmRES21yVWdWTVRHT3I0amFO?=
 =?utf-8?B?NGFQZWdOTGtUdlRnMnZCOVlWNHhkQ011WGFEcGo1MlNTMDEwam8vVUtPYzhm?=
 =?utf-8?B?aGdNbWxIdUc1cHd3OENnZldZQk9aNVFtNFZ2SFJzWGo2L1N3Qm1KTGpvTlhn?=
 =?utf-8?B?Sk80cUVnNFdwenZROEhDaUppZmR4SU9QUGVYOXZqdFhBSTZoakx2UmVTRzhZ?=
 =?utf-8?B?QTBpTCsrRHVPYjY4U2hNVFBHa2p1R01MblJDMUFrdXB6YUt4blhjVE5zemNL?=
 =?utf-8?B?NEFvYlJmMmloZDhXRUxqckZjcWVqUEN1bWk2V0crT0c3cWVYYUY3Z2kxQ1Nk?=
 =?utf-8?B?WUFIbzAyVVBoR21QTzNXZm9kTmdOLzB1TUVDbWdlWXRzZE45T3AzZUdQVkFD?=
 =?utf-8?B?M01DN213UWQvWi9jcGJlSlZsL0xiNWs2b0ZVRnd1cmxGSDdnem9CLzF2Tmgw?=
 =?utf-8?B?VzI0K0gzZGVueFBEa01LckQzWEZzeDVZczQyMXBrSXpNL3dweHo5UU4rSmhK?=
 =?utf-8?B?VWs5cWdjaElFMC9qQUFHU0pIOXlOQ0x5bzRqbStNZWhIMGZLdzhzaHZXa0FL?=
 =?utf-8?B?VzNySjV4OFJhTFp5RWJmN3VhMlp4d0U3dVF1ejdESGRTenZIeWlIMHUyZ1FY?=
 =?utf-8?B?SENyT0E5T3JYcngxVk5ubm1TaS90aVVmYlJPaUJJenI0dVBSanhIQmJFamRW?=
 =?utf-8?B?WWc5UEk4SFd2NlF5UURId2lQWG1rbVlEOFBlelE1V1ZJbjhyM2ozWitNbTdm?=
 =?utf-8?B?K1dYYmh2N010MlRYejRzQnNNSXNQc2dZbkU2MW1ZV3YxWmhWTWlwOWdmUHov?=
 =?utf-8?B?K0FYUTVncTQ0Yk0yWmpTZmduc0xqNkIwQjRmeFVHazZRcnBrTlNRcS9jbVZZ?=
 =?utf-8?B?SGc2clQreGxkRExZTVk0Qi9na2FNbExia21pNjdqSU1rL3NlL29tdXhXdGNU?=
 =?utf-8?B?K05zUWU3V2sxWk5Rc1Q1cERvYmdTakJTTnBOZTNYTzhONG8vYzNWSHdaaHkx?=
 =?utf-8?B?MHF2bmk0TlVYR1Yxdnd5RVFQZEFKWThrSjUySEZrWWtWOHZmS1pBMTRGWUlx?=
 =?utf-8?B?WmJacFovQm10TjEvcmltVVJoSk4zQmRIaE9OTzgwQ3dpamlPUU1aM2EzbXlG?=
 =?utf-8?B?YVV4U280aDB0QUpJR2hpb2gvT0lDaDRCdFVGSENqQWt4N1hmVWt0dUNyT2Fn?=
 =?utf-8?B?aDg1N2phR0V6UElJVmk4YThFRzZoYnowTXNpUGJZMkttbXRkeEtGcEFLRFZF?=
 =?utf-8?B?QnFLcUwzWmllSFpoT2NJYWw4dzFSeUpiZTZuK2hLOU1uMzl3cVJ2aW02NmYz?=
 =?utf-8?B?eVJFdGNYQldkYXM2ZEYxUGhjYkJOQ3Q1SzlNS0VHYmFDZkRQcmN5R0VnVjd1?=
 =?utf-8?B?K1RBR2ZDWkptODkwRzExMDZHMDRHU2p1TTV3Y3NEelllbmluTnRTREFTbnBs?=
 =?utf-8?B?RzJuUlpNeThtVEZGRXoyajNKeTRtdU5xRXZTelVGRC80NUtkT2NDdTRLMzli?=
 =?utf-8?B?MXRTZjRmZXdpZFNwd2NmZW56UkhQZnAwcFB3aDlPSTI2RWxpRVd4YlZqUnFC?=
 =?utf-8?B?bWFDQ0JGeUE4ZnlRaGthRncycXJFZ29ueUE4OUdySzZpOUpvREVNZUZtcE9s?=
 =?utf-8?B?dWdYL2N1Yk5nNEpYaGpyTExFWlM2czBXeFBzVHVoNk5pbU5hS1M2SXphSVYw?=
 =?utf-8?B?VW13a2x3bkQ4bG91UTV1MHJWTHZmdFVGRndZU3NGRmFicEYxODhpeERYMEZy?=
 =?utf-8?B?VTEvTnlWNDFkSHFLb0c5SmllOUw1S0xzcjMrbERaYTF6aU5LQ0N5TE9JZ244?=
 =?utf-8?B?Ky9wN1lUaGo3NTJ3bVc5Y3hHVW1HdUt1eU9WanNYUVVwUnF4Sk9rMnhzaXl6?=
 =?utf-8?B?OFdjaTdzYmNML1BESVBjb1VMOFJMS0JVUkVDRkFXU0cwQk43ZmNnSVU5TFhD?=
 =?utf-8?B?M3dFUFdlZjNWSFVxd3BuSy81YlJRaFJSd3VpREJpaS9FWE9LRjN3ZFo5WUVF?=
 =?utf-8?B?NE9GYjFYbTF4RkhiZGdVYXFCLzJoZjJ1c1JIT005cGNnWWJvYXNkTDRnOURs?=
 =?utf-8?B?TVJVZTRwWTRJUk1jRFZQeTVCTGJITXRlc2NJNm03S2dFSU9zVjVRa3hCbHdv?=
 =?utf-8?B?T1BOOUNIQm5lM2o3WkFMblo1V0ZGNm16MmRwVnJ4Q2tSM05uL2lpS1NjdHp4?=
 =?utf-8?B?eVEzaXFKMzU5Y05Zc0lGZHhyb3E1SUpyUS8wajk0QnR0aWc1dlN4aG5VTXZa?=
 =?utf-8?Q?RP8/PHJOnGTZkW8FEX?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e15cf3f-667c-4f34-4d00-08de6590d019
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:02:57.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8M7v9riMeKH0IFFW92tRGBIYA0KsWL1o/IGuNrXlWe1nfsjCu0BbMSe5ndL4imPfZI8VoM4y2wB5SxQSC0Z4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5395

On Fri Feb 6, 2026 at 6:00 AM GMT, Alexandre Courbot wrote:
> `IoCapable<T>` is currently used as a marker trait to signal that the
> methods of the `Io` trait corresponding to `T` have been overridden by
> the implementor (the default implementations triggering a build-time
> error).
>
> This goes against the DRY principle and separates the signaling of the
> capability from its implementation, making it possible to forget a step
> while implementing a new `Io`.
>
> Another undesirable side-effect is that it makes the implementation of
> I/O backends boilerplate-y and convoluted: currently this is done using
> two levels of imbricated macros that generate unsafe code.
>
> This patchset fixes these issues by turning `IoCapable` into a
> functional trait including the raw implementation of the I/O
> accessors for `T` using unsafe methods that work with an arbitrary
> address, and making the default methods of `Io` call into these
> implementations after checking the bounds.
>
> This makes overriding these accessors on all I/O backends unneeded,
> resulting in a net -90 LoCs while avoiding a violation of the DRY
> principle and reducing (and simplifying) the use of macros generating
> unsafe code.
>
> Patch 1 adds the `io_read` and `io_write` unsafe methods to `IoCapable`,
> provides the required implementations for `Mmio` and `pci::ConfigSpace`,
> and make the default I/O accessors of `Io` call into them instead of
> failing.
>
> Patches 2 to 4 get rid of the `_relaxed` variants we had in `Mmio`,
> since these are not usable in code generic against `Io` and makes use of
> the macros we want to remove. They are replaced by a `RelaxedMmio`
> wrapper type that implements the required `IoCapable`s and is thus
> usable in generic code.
>
> Patches 5 and 6 remove the overloaded implementations of the `Io`
> methods for `pci::ConfigSpace` and `Mmio`, respectively, while also
> deleting the macros that have become unused.
>
> There is more work coming on top of this patchset (notably the
> `register!` macro with proper I/O), but I wanted to send this work first
> as it stands on its own IMHO and is more digestible from a review
> perspective.
>
> The base for this patchset is `driver-core-testing`.
>
> Cc: Zhi Wang <zhiw@nvidia.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Eliot Courtney <ecourtney@nvidia.com>
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

For the whole series:

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> Changes in v2:
> - Turn `RelaxedMmio` into an actual wrapper type and make it available
>   through a `Mmio::relaxed()` method.
> - Link to v1: https://patch.msgid.link/20260202-io-v1-0-9bb2177d23be@nvid=
ia.com
>
> ---
> Alexandre Courbot (6):
>       rust: io: turn IoCapable into a functional trait
>       rust: io: mem: use non-relaxed I/O ops in examples
>       rust: io: provide Mmio relaxed ops through a wrapper type
>       rust: io: remove legacy relaxed accessors of Mmio
>       rust: pci: io: remove overloaded Io methods of ConfigSpace
>       rust: io: remove overloaded Io methods of Mmio
>
>  rust/kernel/io.rs     | 435 ++++++++++++++++++++++----------------------=
------
>  rust/kernel/io/mem.rs |  10 +-
>  rust/kernel/pci/io.rs |  99 ++++--------
>  3 files changed, 227 insertions(+), 317 deletions(-)
> ---
> base-commit: f55ae0bfa00e446ea751d09f468daeafc303e03f
> change-id: 20260202-io-81fd368f7565
>
> Best regards,

