Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148F481FB4;
	Tue, 21 Jul 2026 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634097; cv=fail; b=hGZcIvg1TtWwzv9qa5IF0fy8LpdAWaaS7FRlpS9Nm1iBmh5OE70LFKte/QGv8XkGqihTUZonC2CPWY2IPCZiWafle/w2FJsfxJ5peGz3au1H8Wz2rlL+qmwMx7c0glD9OiLgl5FAhUtj0Af9f4iH0FjO7bZzxMGK/Fk3Y2wXblM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634097; c=relaxed/simple;
	bh=EqFD411cb7qmCWg8qDTXfbn6n3oWjj2rvuIddC0oXVY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fCsgycQ175cwlLtrEDeSmc1kS3BYd5DN+qDXOyhbkk36thDd0ZobaOJTuH01ulnn6SVoVUyRuk9HLTWGxWvUpZPvCKYrhpS25CMpIvq/lq15jaMi1gcwO9pwSD+48rT+gkXrjsWORdwaHHPmt6r9rBvuYa1hGdQE69LZikLdArc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d7tayDTc; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d7tayDTc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJrdjLAre/rlcfVyRN4LrisFdmouLDpASqq3fKD6I8WmfYYEw8lvLTxufDkGBxq/xLxIqmgHTUYq6BbD+AV4ydXqowZnd5eT+jaDvSBG4yTrZN2Crx29pyW9I/Kx4VWDh/6+b+1B4iskeMIe8np7PTsja4i9Ge+SSaKBslo3/MfwdJl0CmonLLcqIz90XW+jYprdm+PVarU24EVP5gHab8h5xM4MjiEGysOxz9QFtzLB8GNmEie8Jd9xVQqpUgNXNAvS2CbtvIODZV+El0MYIhqfuGyQ1GqpVsjZDzVLsY/vc7tcBh3cIvxSmgAFfNce9i4pKutjhQ2qnJh4L7QZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzWX9fVt2vxfAVcMrqcjB+iULnnIjSmLAhd1MYc67uc=;
 b=xNTXGNzxLiJW6d9QyO0cNMI6LqhRQN1IDqtxL+cf4AgEKVNqq8yhjtYe7ujNUeP78wtQlwgQQxaHJhe/8DdmypuqwtDxEWL9eWXDkbSKdo5xTqqB7xDmyTCYAnusoj3SCEZNFb3IK2/6/4XrklbU5JU3dQUDYq8NPeIxgLAFWfE9G1SgRXnbNBQMN76uDtIqMGX2rCW9gPXKzFmUiXon/ySDBCLtBiKCHCLPRXkMuS4a354M3bQ/KmZ9x8HOahHDclFDOmv8diqgoHgba43ErWHIV4uhxcrTKz9qE5R+1PvjiaGhL44hy19m4KiBFPdtYgNYkcqZr5m8YLhYBIghPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzWX9fVt2vxfAVcMrqcjB+iULnnIjSmLAhd1MYc67uc=;
 b=d7tayDTcYnZT7wThLjSbibNPw8MIqSeYgiEjrvIEoPAfCM5PeQ/P9b3DhWIhcDGQ04MW3kDQ4wfkEHnXXHAWmSwSaJ7E0xuBILZ8/z8gl0L5N064gh6UicxKKtdzNXfbAauxfCouyvHqOiUzcHuBgoiFEsw8gGA+GAAshqFUmM1x9f+tV+9z3QX5NPt4Nv1QjbPbSqrtbPzNyv4oLKJ/XpY/wvP2FCTtAppmWUb2ORaGBTBa0x8WtEhcJK1i/oouXdbJcCdFyk4M1Y4f+gaOIwcC0bp882FbSQIZCJ8wpCwZ/9OGstygveZy1dhzLJBxhb4HfkauTKMGJ/LbZj2+LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Tue, 21 Jul
 2026 11:41:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:41:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 04:41:19 -0700
Message-Id: <DK47ZE37V1V6.2TI766FMIXYBC@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <mhi@mailbox.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: irq: make Registration compatible with
 lifetime-bound drivers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260719153631.559341-1-dakr@kernel.org>
In-Reply-To: <20260719153631.559341-1-dakr@kernel.org>
X-ClientProxiedBy: TP0P295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: ee651ebe-56e1-480a-cc36-08dee71cfe05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	4mVGl0NwVPRpdHV48qhSNV/dvc+7t7Pg3OHxJ/WUvLon87GhGDLd5v/8csOhcRMJ7ij7G5Ham9zHlaM2C+gniwEdDl3y3XWs6ApOR4xM5M5B1mc40UEq4cEGF7n4CPpD2ngoXx01U3J6mP9niCn1yzwf1RtU7LS0WpEjvPBrMmbEVxxdXZUb4G1NU0gC4edPMycg8MW+evaaLhL9wa9KaCsI2Bgz+ni93XGjAnucl90cwb8IgZLIf/UvcQJe3cJp4gZrL6gSWOvWOfIBNMzOs2VPerXjogJVGYqAoQ7AvjfbFe07MGv38cNpi4IP+Fq6CrAUC8D1t2SQ4AYepFCbAIlI7EapywxY3Hw/WOWKiVhfM7TFhbHRHLvn/zbrYKZNYuV2N+6nW/p4mtWSBkHLwmrGfPTjoUY5xCNhyuBtJeUbDA4e/wvnQtTevDmR+FQJPju/nTR6qVW3vU+M5Qpaz/40nEXz00NRC5hxJQdWXx/W+O6Oc6IpTTLqDEgdbG4QVoQ1AiPAt25395f4JOWGq4gVa07dN1RoeU3yOgaWGFUV4OEIqxwnT41gXoqqaFcz/r26QUKuNaDdyZSmrwknkhGCOHoaX4CUIwA7D8SEY58SZM8LkGXWqw+0jmW+1oRvQnuMK0aYUy40MMp398WGwBdoZJwmeXUNt4Vym7ii3Ug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2JBQk0xTmRncko3UjZDL3pseTdhckU1M1NvMzhYdVB5K0JMMkx0WXlnbWJ5?=
 =?utf-8?B?ZGFyeGYxNlJ6N3BDRFV6Zk40akJIU25NOEdha1Znb1o1bXIvS21ZSkRzZy8y?=
 =?utf-8?B?b2VzZHNVbVVENGZaT1FyYiswWHlCTXF0RHlMcWg4dm5IZm4xTGx1V2xuclRI?=
 =?utf-8?B?d2l0K3liamg4bk5qWWEwemYxUFRkTStjRWNOdWRMRXJrL2V2ekg5U0ZKL0ZU?=
 =?utf-8?B?T1k0Vkl2THlFTHBZenBKWWwrVnREUVlvcjdFK2QxUEx3NmtwNmN6Y2RYU1ZT?=
 =?utf-8?B?M3FYclZ5YnNUNlVjSGNpSTlyaGxVZitFdzRkMTdqSW5ZaVlPK1AvK3ZsSkd6?=
 =?utf-8?B?cmc4Zyt3OU1NOWNUSWJ3bzhPUURYUDdqbmNRdHRCYzJwWUM5dHUxcHdkU3Nq?=
 =?utf-8?B?M2FTZjVNWFFMWmJaYlQ1T3VXV1NqaVRIQnE1aXRrczFvNU4yYTZzeEprT3cz?=
 =?utf-8?B?TkJKbkxUcWEyWUxTcXdpY3hYUWF2c0JHSFhHNEw3MnU4cVRyNW8xb053NVI4?=
 =?utf-8?B?eUN3Y2JJZDFTNDM2cGlOdWhNQjVva3FId21jSVZMR3NRUmhra29yQTQwWkha?=
 =?utf-8?B?REdxSE5SOTBkRWhkRDh1MFdPUVZOK3ljOFQzUzVsRjR2MlhKTTByY0NMRGJ1?=
 =?utf-8?B?dTIrN011RUpmdEdIdEVMRXVFWkgzcUlGbTFSNDNxMVBSNGZ2ak9TWStFRkYx?=
 =?utf-8?B?eGNEa2UvM09RandKUFZzUHBJem9xTktUcUpnWTFTNk51TDY4Q3hSYW9tenMr?=
 =?utf-8?B?OThCNndyTzZUaUQwK2xCWjNEZUx6RzhGZjYwZkNNMUlzdVNjRHZLUHJ4ODhT?=
 =?utf-8?B?R1ZVc0lYMnpxcnpnWDMxdDFPWkV4eDZoV1BhNmFHUkQrTk5kMXgzM3BaL1Vn?=
 =?utf-8?B?NlhDZndBanRvaGE4Tk5XNnMrRTNTcXBpTWhyZHUxRVgyb1BBNm16aHpReHJk?=
 =?utf-8?B?ODVzdVJ4ZVNvU1NOZ0ZzMjFjTk55ZnVvR3k0M1pMU2ZwNmdpWGZkaUpoQ1Y1?=
 =?utf-8?B?S3F4dTBtQnlQNmMrK08rRzJaS3BHdUU4SFdac1I5RDRuNEdWMTRCN3lJdTEz?=
 =?utf-8?B?ZE0zNk9HeW1kd2U3TFVFMlQzMGRpTkxiaFBOaU9xR205dlBUOEU2cW5YWklz?=
 =?utf-8?B?NFY3UkI0emc5cEJRNW1WVzJFSSt4aXpDV3FGUnNadmYzTncxbE8xcDJFT0t3?=
 =?utf-8?B?ZHNOQzNJYmdGTlE0bEdDeWxDR3BvQldYd3BZTVNzemd4Ri9VdnUyOFhRZFdT?=
 =?utf-8?B?WUtTMTVGZVVoZ1dJdkxkejVpTk9XZ2lxRHZDRFc5WjI5cm0yNGVjMzJrdWtQ?=
 =?utf-8?B?ejA2aXg2SkhkUUtVb3lVNDFyTjVhMTFZeUJVRG1jZHBLOEpBQ1dFbTNoK29K?=
 =?utf-8?B?WFBuUjJlOEgwWFhLZ2pXMGl5azc0eEhSVDIzSFNQUXNOU1dNOXE2b3k2bU5I?=
 =?utf-8?B?YjVrbWNuSi9ZZUpwNmNUaWdKN1BhaXV4NFYwSzNDN05oVEdEUi92SVRWTW9l?=
 =?utf-8?B?U01sa1lCRkhKUWdJT2p6dGdKNXJVcWtxODgrRzhtNWNJaElvRTZGMGVvRlZV?=
 =?utf-8?B?UkdkVWlUdmdEMUVobDJTM3lYQkRLeENkSkdoYURFcW9kbFNHSE1zK0NwTUk1?=
 =?utf-8?B?NDJrSisySFBPK1U0QnFrcjRyZ0J5ek1OenFIUmg2NE5teHk0d0J0MFJJZndp?=
 =?utf-8?B?TFlYajNFdW9ZN3B0dXl2V08weW5JU2x4WnZBRXhTRG9DSWQ5bGwxR29JU3pM?=
 =?utf-8?B?enFhL21hQ3h3czlwcVhNRThPbElrTXNlQW8vSzBOeWZCQTNJTi96Z3NKd21t?=
 =?utf-8?B?VHdWcFJ4OTl1K1dWMk5rbVU4M0djcTMyYTQzS3Z0L20vV2RodElWZGI0WTVy?=
 =?utf-8?B?bWVKdWFuZk11N24vVnRzZXEvR3RDRmVDU2FzbzJrK09NeHJpRXN0OFFmZXBU?=
 =?utf-8?B?a0RjYW9IYjByUnh0cUMyclVWNDlhdnFuTHJiV2Y5OGdBcSt4SlV2YUpzUW1h?=
 =?utf-8?B?Wk1OQjFnNUNvdG12S3FEbTA5MVQrczlxNlFsd25XVjRoUUNRWnpVRlNpRjZ0?=
 =?utf-8?B?MXQ1WFBFd0RNcVkwdGN1WmVIV1VETW9LQzlLa1VXVWtKUUJOSTlVQ2o1SkpN?=
 =?utf-8?B?RDFuSWp1L01wRWsrQnd6TUh2TnR3Q1pjOGFmZXlNSUtROHM2RFdITVhpWW5U?=
 =?utf-8?B?akxWQnJxblJCQ2dBeTh1SHdMaHFiZjlhMXEyYURaUGFZbG1lRkhUY3FWRGNP?=
 =?utf-8?B?bHB0andmRnpiZWFlRFZLbmRYd1puZVFLb2FTQVJXMDdTa1pneDVWVEU5eVhk?=
 =?utf-8?B?UHJuR3h6TVRSaEdEMjJUTEttT1ZtQVBIZEFJWDR2dEoxS0Z0aXJudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee651ebe-56e1-480a-cc36-08dee71cfe05
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:41:24.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hogUoOgFAqCRJbi/6ApZ9J2NZVlRdujQUT0yMMSKaSqlN8YSjUpx5QE91Y/Oq1Wqs5s5buXo1n0Q8aKvpDNavQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771

On Sun Jul 19, 2026 at 8:36 AM PDT, Danilo Krummrich wrote:
> Adapt the IRQ registration to work with the Higher-Ranked Lifetime Types
> (HRT) device driver architecture introduced in commit 2c7c65933600
> ("Merge patch series "rust: device: Higher-Ranked Lifetime Types for
> device drivers"").
>
> With HRT, driver structs carry a lifetime parameter tied to the device
> binding scope, allowing device resources such as pci::Bar<'bar> to be
> held directly rather than through Devres indirection. However, the IRQ
> abstraction required Handler: Sync + 'static, preventing handlers from
> embedding lifetime-parameterized resources.
>
> Remove the 'static bound from Handler and ThreadedHandler and replace
> the Devres<RegistrationInner> indirection with direct request_irq() /
> free_irq() calls in the constructor and PinnedDrop.  Registration<'a, T>
> stores the IrqRequest<'a>, which structurally ties it to the device
> binding scope.
>
> Also remove the &Device<Bound> parameter from the handler callbacks,
> since handlers that need device access can embed it in their own type.
>
> IRQ handlers can now directly own device resources:
>
> 	struct IrqHandler<'irq> {
> 	    bar: pci::Bar<'irq, BAR_SIZE>,
> 	}
>
> 	impl irq::Handler for IrqHandler<'_> {
> 	    fn handle(&self) -> IrqReturn {
> 	        let stat =3D self.bar.read(regs::STAT);
> 	        ...
> 	    }
> 	}
>
> This eliminates the indirection previously required for IRQ handlers to
> access device resources and aligns with the broader goal of expressing
> every registration scoped to a driver binding through compile-time
> lifetime bounds.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
