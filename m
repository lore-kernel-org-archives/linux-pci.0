Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1C360ED2;
	Fri,  3 Jul 2026 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058303; cv=fail; b=rx+dZbJsGd9sLSqK9ga1/bB8PDooS5VjXngilIahCpKPDwBjqBbQOrZqf6NnLjRlqNnClest5VUwEjmPhHdqjSbE7s6tchiqQFS+wHIkYKtmCzCjq1ABJEOUpf6DLTx01JQG389WN46Qg9jSoaGW7AnpPCyOGuxLcrcqe4D5nik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058303; c=relaxed/simple;
	bh=XfVYlBkQ3VIIt7tEHkupg1xLjhooSfEn+I3J9Np9fjU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=PlcwGpKBPq20HVUq+3XzvQWpxRY0JCF9Z7iwHj7x1/M2Be5xF/AiRHEgJpifXxpfwRXjY4vm9CJPgDZnAVR788ujSDNE7cy6MsvCdJjcsTr8rWZ9ddqq6c2PJAcz8WCMz6S9utTwYvFivbEQDRR+L133W5bEdP9FZin7lTcRxTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lu38gbqc; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lu38gbqc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI4mCxu6xyoOWfgu5hETD2650/Oyn8CzyAsvSfLxGclrp1k9CpVMpKItXBzAddwcs4JiO2hnmewfPISIFw+N3VajjVhLlAjFLsCJHrjl2aSV8oMliFpawreLRB84wgHACc/p57no33ucEXJwNXkdw5XfSBcB6R17L2/r10MnnFMMVRt5Ch3vaPc5v1QDDAO97LhIhiNBm7mTFxYSoChb1hwRqVCxjMk6tL9DvlmUfm/O7XjBxTFZg5Z1HONdXPgflPgyDNx2zq1mJvhNE/edXbW+ZUQlzZwgmx7Wn+hIK1dwwOnZfYehKd/rg4wsy7gfahG8MzvodyLiQXCKhDasug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfVYlBkQ3VIIt7tEHkupg1xLjhooSfEn+I3J9Np9fjU=;
 b=fTBYFsFiZUfuc+YEzY6cyQ/oRyhw6RhuWf1OuU42p0GZTqr4SDg7pXY7lzSGNE/mL9DBKVsAlmAL+OokXv2VC2jW5riPLa81Sc6eH/zLeuYZqvTvXKkKzeJC4ygH/ks0X4r033jegwpHU0Y4m+ufXIeBntWFX/kcEldwF+kyXQyIqGsXIPcXRbDpEFE93E4O8rBiqiYY/VlQwfogMkG/VqD7+BTkKvbQ6Fj2Qvprmj79cw6W/Uh/xvOcPi3mW4WgJliRtMJOA3YZHcHnmNGvgPTg+9VMJ6UTshWa9L6STfXj2CNYLxPsyUTyp4OWdfqBqltHS458CnVPDjm7D04NZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfVYlBkQ3VIIt7tEHkupg1xLjhooSfEn+I3J9Np9fjU=;
 b=Lu38gbqcJy9jJ819qjQLflZVE0Ui4wp+9rGkU3ibHdHETBG2dTGYLdoKY9wf6VMolX5l4XG3p+DnvnJ3Efd6GO4rXnESRr0K9nPq1qpkrV0JO53AGvojtoJAvKiFkIBfKFBStxfjZyAwRebir0m4nKkANQzFlU17N4SKNt5ealw0vEDJRhX4ZuiEGnSt0chpW+z0Et9wRtyNRbUhalzHzcKBHDeP2Qh8tA2fp4qhCK4gkfnT1zia1fyrw9V4NAudoVE9+iHkOONB8x4ErjQB5IAjL/G0CDi8TQvWWHAn7HUZMhKD/Cm4v73lf1j3qkGLAf3elomlAD+TjQNpi8lq1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 05:58:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 05:58:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 14:58:11 +0900
Message-Id: <DJOPEUV2F6Y5.18ZVVR83782TE@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 11/20] rust: io: remove `MmioOwned`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-11-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-11-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TY6P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: fa30d9ab-9812-4c0d-a3b0-08ded8c81244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|23010399003|366016|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2NQh9T1XXqGZaiEPCBoKAqG6GkTQsha1HN7MEjcaBd1F1xo7CUJG7UVmGbE91TpgWUWMGvnFt5IwBpNlXAy/UzbNp6PYzbliXkbAdLSMlsd0Fv/VyfEVDRo4If9upwBYzdiYkGITS76OFIGDNM1c7iZnnw4EjiHA6MWVdgWoPkdTTHe+Lmwkqfj2lhyAcHZ/Mqc1pNx9HideNsTVNtbRUMEm28PHBdepxJGgKiSck61N/uiGJizYU38w3CzXqPlm2Mpif5e+Q3dinOWQ4VY4auBDPiheclc03LJcz+SIyxzsJ+NWo4wFMuwScg31/vPGDm6oc8bfL94FZb/UgXeeuHrHQpOA+BV+cgR58bRt6V3iXp5OdRwy2VW5vn7c+qyIk1YkeVF6O4DGbJVZ4ctoQ4z3fCUIz/uSsGueXAJJ/PaZ3bjuKcyWzRPGQvYU7yJBu2g01k9rOlK/M1oPdoGQNDoOknCswrraUh9krCZ9Ya2VBx5ZROFApZ2cA6cqdlYO+5pVHjKm11cvMcHt8JxcmDb8GqO2RPwey7jNyiU0OcxQFY08t7I2ZC0udZRvx8VBfkdwVyhbixUOrJHYAgO5A6j2cbRrr0qtCsJJPbuiDZS/yCubSrk55XI4rnpvM4gZtEtOky4L8cKAFdXzJRSbZuNOlrLxJsIQJy3T2kIVE+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(23010399003)(366016)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnV4SCs4eVIzNnpVTE9pV0NaQnpOb1VGVDcxdHQ4MmFLM3BndlBCMFBFb1BF?=
 =?utf-8?B?UjFNSm15WHBhMnVDd2JPbXhMQU9ES01iQTk1M1M2RHJhYXlKcUJZcXJ1STlE?=
 =?utf-8?B?NGJEaExvWXdNUFRBaGxwd3hiSDZ6QkxBbFpLVm1odkg0cnp3Uk15WXBqaHRj?=
 =?utf-8?B?U1hnY1NwUHArL0wrck5ZSGlyTit5eVY0S2pURWtaWE41WnhIN0NCRmpuR0pu?=
 =?utf-8?B?ZjRwQS9hc2l5aFdZTnhGSjR5WThsYzdxb2NEa2ppV3grcFhmSWg4aUFIZ1RM?=
 =?utf-8?B?Qi9sMU5VeXRyblJPbHR5RDh0bDJQYWFmV01CZGhvSE03R1pQQnl1cDJsMnMv?=
 =?utf-8?B?V2pvcDhtc0dHbmczRU1LQldGVTFYUE9GZkhKNUE0dFdsbWU4TVVKUjdnc0ll?=
 =?utf-8?B?SFB2a1VTTmtDRW0rcmplL3JNYm0xS3hUbU5sQnh6c0kwSHRCa2xObFdVVVM0?=
 =?utf-8?B?NHBSMFJTRzkvU1VwTnNFL2YwWkZQUExzSk9RS3RlcVQvK2t3OURPMmFTbHgx?=
 =?utf-8?B?d3RKL3liVDJDRENRTHU3NkE1d2V6YTExS1hOYXVaZGs2US9wS28veXhhUlJY?=
 =?utf-8?B?VzZzRWVKZUVKcTViUWZ4SFI2QkV4RXltWEhNazZrTytFSmErc2FqZWVTUG5S?=
 =?utf-8?B?OE5URllEY3R3OFZFVDNKZXgzTkhNMGlBRUcxRU4veDdNUjFPS1JKc25XM0RJ?=
 =?utf-8?B?R1ZSQ0VkUGdPemNnaGZsc1AvcUdya1Z2MnVMSnIydEx3b0czM3JsVXRxNFQ4?=
 =?utf-8?B?U2hrbkZXY21ud3MrV0poc3FzdFlsU2Q1NlpYRUdGWHMrTFBiUWZiR0hXczQx?=
 =?utf-8?B?ZmprcmtSRzZMTnJCY1JkTkJzWXdMb0tYbHU5UWluSGwzOVdkeHN1c3pmQmhi?=
 =?utf-8?B?MkZTazhpUXk2Z2ZaTjBTbjNKZUtKcEl0R2lpcFlhS3hFb2lsaDkvRFJ4eUpF?=
 =?utf-8?B?TmRaUk51WHA0WFIzTkJHK1p0bUJ5WkNpUDZPS3pkQ0htQUhOdXZ6Y1BvdEd4?=
 =?utf-8?B?c0M4MnBrcHNTV1piVElxbjdkSXBVU1c1T0p2M2hFdlJoRHBLMUlTY1U4OHpD?=
 =?utf-8?B?Y0dyV29mb3BUUnNhcVBCaitMYnBjRzEyeFBySzZza0ZaVnJBWmtDRU4zNGxl?=
 =?utf-8?B?TlBxTmpGa3JpWEp4a2pYeU10ay9ScGJJYXBMaU1COGIzQ2ZmcVFXSDZNUHBY?=
 =?utf-8?B?aWlKNFB4NkxzMTkraWVTWU8yRFZUcktDdE4vVHRIZXlOS3ZsSkdxV09EamJK?=
 =?utf-8?B?eXh4dXl1dzdoQTMvSVZpQTFtRkFwYzJmZXllUkNtRmRaZkV1SHJPakJZNWo4?=
 =?utf-8?B?REpWVDBjL0ozN0g3OHEzZ2NEbEF4WEhJYUxGOGFjYWxTSkxjZU52bmtZcTZk?=
 =?utf-8?B?VUVJVlEvMTB3RGU4YXVPODNtOEpreHNzbldZOWgzRkorS2QwRFlwY0F1N01Q?=
 =?utf-8?B?ZnpkcEs5KytEdHRZdi9CYkUxSWN3Qm04ejdNaWJ3WnNXMld2dXlibzVSQXJR?=
 =?utf-8?B?dXBDeWJQU0prVTBYTW9WbytKNHJLdXlneTNZVGhTVzJBbXVPZW1sYldNYmY5?=
 =?utf-8?B?YTNzajVtRE5QeFIvS1Q1RXQ2a0tkRVJBSUs2Kyt5dkRlWmtpTlR5OTk5cG1s?=
 =?utf-8?B?c3hZTFR5aXBpOE5jTXd1WGVCVmFkRTZCYUtkNUc0ckJocEdwSFRJRjVhU3Jk?=
 =?utf-8?B?ZVBCaXBvOWNzRFhONUhBb1dGM1pqWDRPenpubWtPRExyemMrR2JSVWxWeExD?=
 =?utf-8?B?bTdxSGhVd0ltbllJeHZmWVVGdUUvUWxCd2kxUnFkUm8zTExPYmk3RzVyQWRN?=
 =?utf-8?B?REExY2M3R0VZS094MFE3eENqYlBkL1dFNFMxTkw3WG1LSW4xUmRBSUgyTjhZ?=
 =?utf-8?B?K2pSb2NLZ0JXZU45dnJoYkV2azhheXZqQ3dQYVRZVFFBbVpqS01yK24xc0Rs?=
 =?utf-8?B?WHFtWmJWbEZIZ0FhazJqa25oODNnSFpDV2w4ckx5czRVaGcvTmxSaXVPQnRp?=
 =?utf-8?B?RE9WSUt5a3o3SzZKa09ISzlHa25wcUdhZWJjQUxscngrNFRvbitIQzF2Z1hX?=
 =?utf-8?B?akFpaGxPcmxlUTd0QUdVYS9EaEVza044S1VDYloyWXhycjhaK1RpTG93d3FR?=
 =?utf-8?B?R1BwWC9sUjAzM0ZNYlRiRnV1TGtOVEFwVEJGWVpBOFArcnBvNWRHT05Yc3FI?=
 =?utf-8?B?dkVqT3MrcGUrV2luRXptOFpRUkhvRkhnc25wTTRyQStyWmdDbmJLTWkwWFNK?=
 =?utf-8?B?T25ReWpOYk95eExRU3hsYWNOQmxSNWRnY0V5YndzL0QyeitaUFRLbWZvUmhY?=
 =?utf-8?B?Vnh2MlVEOUpQYVBHc1hXbXBkSjZLN2UzNUVoeDVjZzN2SGxTM0JTbGdNV2Nh?=
 =?utf-8?Q?xdHveox5yxDrBUjr+WNmvJs/VLfloBPNYwmUtUhhxHJCz?=
X-MS-Exchange-AntiSpam-MessageData-1: qYXqwTTQ6eTWpA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa30d9ab-9812-4c0d-a3b0-08ded8c81244
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:58:14.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDYhVjbThy9MrkG5pvYeBhNjqUA0vK7ZPjuFPmhKaG6qd27/NxvTlf01n7mNxXnTMNo3HOo4RSO2/TnqEHSMag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> `Io` trait is now very easy to implement. Thus, implement it on `Bar` and
> `IoMem` directly and remove the `MmioOwned` struct.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
