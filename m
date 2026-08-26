Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343783ACA60;
	Wed, 26 Aug 2026 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743512; cv=fail; b=lJ1q7W6bQZ9FFjIPZKXUzIcM+zTGhev1rKjBhr6mXBh6PaPsfZVt8S8Mm41yTjkhxuFHS4bOZiSa60uwfY1N7taqgelDQALtWsWIXo89W2LqOo/APamMdZ7fzv+30MZQYzTTRhwW2i1usOPau7/chMWOvH4bk6TkN6uH6xIUU4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743512; c=relaxed/simple;
	bh=G8nxn45OpisCxbjTa+s/fOYoesYNsiz0IwAUsNyq20E=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=kBl1nqSCYewZIcEnJnCrViuJo3tAVyi8qEYq54ctZtRtKjS+eXdsJ6TFyWcT06Du8Aj1GwenRuV7o4d/dWTw9YO+PvNTDwvUp1WXfcOdiDnc/1c6+CEOyBzrP5xH32YBMUePc6SY0Wc95lIoiJlwVLZmLbApECUpP+0ykXzgPTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tqXftJrj; arc=fail smtp.client-ip=40.107.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tqXftJrj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYDllnW4pZ2TOLWD3kaZJ5s7zPmGoPHSWwCeK4oOJEcF2V7awJ3pCN4PdNYsVl9AXEZnioi7poEcMVgmNQBRyJjFDGrrpBjU4ZN/WQYjCGyDcoWv/zrGQh8RREc56AcinsqSBcX82WV9Cl05wxpPpdXJk3Bt9Cb+I5iaeb2irAK2jHcq5VHL28ny81w/wjhpOEUlNhK+jQDV36+tIEe82yTqqzS47Heh+7OCI0O7P0TtLwRbOJlVYuAJqS8I2Sdciih5dHLDgz2Dank/Z+ACQMlI60A2L8nXAIRhVozXn7YLyPk1+5iAstFQ5Kw5tZW0ySuAj80giwUEJKBxipT/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1uUNM/hKKdfDoqSAtx1n0kwuLf2DpVbnxMvxPjc/A4=;
 b=BkKvXTBilJwk6g7iCM3IU0pNi/vH+SJDsPnviLqEdbNnm5nZxDjudSCxx9WSV9F15k/fuzfCaB2BK2Z8O76ITS7/vVPRVWc/EDjauKEmX7ZWQu48QulIRf8M9zjCQKKKt6PHqqtNtmzqMbxh1FLKae+Yq1WQ1EPVVWuKlY9wd3FePmnY5husBWq4NmQ77e9EoZXMca36SNw0DzVdlNc4VyPPX1h0hVx0hHV0sPujAG+A5NlOm3Mi1nV56d4n1M26RujPpiP6HX+QjQNkMiIgJJpbJBmZxklP5Srk7wjlscvo6Ml77LizRN81wwJnKEZ7Kw3l1lDiADU6Rr9t1tHPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1uUNM/hKKdfDoqSAtx1n0kwuLf2DpVbnxMvxPjc/A4=;
 b=tqXftJrjxnNO11R+iCx+fZWU2/JC7jcJKfx0XVeGwBSbure45lI1TLESfebiV4r3snBbm2vbXFmLxDa3iM5x2JrK0P8MRvQe9lh9DJKH4wfBzB2OrYCegdOdDpRDgm+aqoeUi3hd1CnjbDziPDZNxdjtJ64/5UABEAQV4rOzEozVhtPD1/AUBQNY3LQCNcQCYLzJMc7F5PEWADT4v45OW/FTcSZrQ2kCR4Gje5Vag1JJhrwbssEilA6IC3fLyCMQfc7ulYn5QR6eT52XogTxwpteBCl0mk2r3u+4BoM6OW4YoAg/srzFWYShH1J8vRRIGdFcW4gCx0l16IvP2iXMKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 26 Aug
 2026 11:24:57 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Wed, 26 Aug 2026
 11:24:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 20:24:52 +0900
Message-Id: <DKYU6ELNN060.154BHE2QG442C@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
In-Reply-To: <20260818084633.1673214-2-zhiw@nvidia.com>
X-ClientProxiedBy: OSTP286CA0112.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:225::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 538e126e-9444-400e-2ce3-08df0364a7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cL+G4d6qY0/bheof5BTecevOJ+tendYxZWKXoIp/0Dw5UA5omZObKH4jyQErbYhjlhDZyOWcB3PXbL1KHo6+ExPo0d6EmRsYJqsUN2VSk/wsBShsbzu1PA2hR47djoOAr8GX1Xww7CGRkGNjPixgfJrEAdB+iYCa5zawcHzVIxHMy+rn5eATa4YlQ+q4ctnm3y03A5s2uIWLVNWBrmHlXVh6QCLm5OuL48RijF9zj3rMwid1Uvg8Z/12EagumEhbOrl7c+CbZgPy885jiwaduVJ/naVc5tsTBTCM0QKWQFXLk2YVxVjPsuV8uVYU4ZHMS7G1j+I71mD0ChhnrWv75gzcIGTFJTnwJR/TqHqFlDJz3LRmEtb8t9Ohkm8cqFneCP/+m8H0baIX+5CaRpWx96V/SNq4tvr82P5FuRDA7G7xeWgfYfBjKyEs5qmBv4sJkQz8GG36D6COnvU3MBUSaPNvnejUIl1Xj9+V7pwlML666pT0ctYz/225S44oDjPoWloEVX2Yr2PGm+VuOCpPkkruR9yA4pVAVwZaQ41MS7fznHf6uLdfpRDFBCGbQpcQr+vOU6zeT5yaccqP+wvCZv0/Ic12fOlFWGVCZpQLAhJMm6+lidAKV+/FkBTPFzbRxRdrX2fVEmg8PEduq6d8Zozo0LnW0mbTGNSjXsQte1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFk1RzNORlVrbHZKUFVkYU04dUQ0UnMzL1Z3dVpDYnNGYjNBcUNIZFdOMzYv?=
 =?utf-8?B?aVo1ZlBPckJScm1BWnpvaTVTa1p5TzdOb0lFY2xHb3hxelY5SjF5MEJ4a3Ja?=
 =?utf-8?B?RXBLSFVROCtaR2YwWTFSZWpHa0EyM3g3WXp6aDBEa3ZKSnM0VEpuQmdqbmNs?=
 =?utf-8?B?M1lCVmJ6b28yamRva3lIa1BoY3NOVFFXMGsvMnlXdEN6bTdrcVh2N0pOWjRS?=
 =?utf-8?B?U3lqSlAwYUZwOUt0MEtFK1pPT2FRZmdXRWJQT0xWNnVXakpLNys1ZXFiN29q?=
 =?utf-8?B?cWl3VWN3WHdySGlCSnVtbHZpeWNHbkZqWHk1MEpCbkdCcWtFZjBFSVJOL2lQ?=
 =?utf-8?B?WWhrNkhNZVF1eGhKVERjTE5lek1EYnE4OTJHQzU1dEtwQm1wVlQxZTRNZmpa?=
 =?utf-8?B?MGl2RVlBdVFSbFRORXBPSVkrUUlZUkVCUEVkbXVKVGNFV01PRG16TkxZWXR4?=
 =?utf-8?B?WUlnU296a3VmV0k0VlhFVXFlb0s2TVJwVXd4M2luRE04SVhYY0RyM2IyOWRZ?=
 =?utf-8?B?amxuK0Erc0hORForZzZDZkF4VWJaY2tId1JxRng5VytNU05MMnFZY3drRzdk?=
 =?utf-8?B?L3IrQkFsQWt6WjBYNUp2eld5SVgyVnJhQjc3b2dBRW9LYk1tSGIzdWJnT2I5?=
 =?utf-8?B?TUNZU1V2MW1oL2RockU4c0VmSE9Ld242c3Uvai85MFUxQ1pIb2hhTkdrc0Nn?=
 =?utf-8?B?SFdlV1pTVWQ5QlVaM2dSamw4aE9sZTRSR3lEVGlSUjZmOHZNaERaV2ZuZklQ?=
 =?utf-8?B?VFk2L05waUw0V1NOMHAvTEJHbEk3TEN6L01wWksrbE0yQ0E3cUNVYmt2Y0x0?=
 =?utf-8?B?Nk1hOFZEZGJzQ1JHN3BBUXhBM2l2WHhta3BQU1RsUlBsQjV1UkVUQjRWU1By?=
 =?utf-8?B?TUhwQmxkQ25tZkNtUk1SQnB0M1dVN2tjWnNZeGdrbGRnZWE5dUNYUUI3WUps?=
 =?utf-8?B?UGR0cFVZZG9PUWVEdnR2OGlwWDNsRmg0ZytWSEhkWExYTWZqTlJaMXFyVVQ5?=
 =?utf-8?B?MmVSSjNkSHp3WWYyQVBmcUhNV2J4c0VvUXVNaDE0cDJFWks1NkllblhzdDZX?=
 =?utf-8?B?a05JY3RBSmdVSFU1aTVTMW80RkFzWFJxUE5FRGVZQTdQeU12eFIyTnlrSjZp?=
 =?utf-8?B?UGVxdUxGRm1mTlgwclNhd2d0UVFqcEo2bG9oUFBkcjg2b0JWejZBQUNTU2FU?=
 =?utf-8?B?UGJmcGxheUZsc3BKRXk3eklhZTByN1B2NzdueVI0WGFJbnFqVVdkOGVXL0tk?=
 =?utf-8?B?UXlyMWFXdDVuWFZibnlPUWVacm53Q0xLbnhhOUpSR3ZVY2Rjbkd4VWVyVDEr?=
 =?utf-8?B?M1duZFhmVFdyTDF6UGxGV0lsSzh5c1NNT3ZxQ3NuYVVEb3dsMmorUUVtR000?=
 =?utf-8?B?Ui9tWUVVQ3F5RW5hVEpWMUFOYmt1SnZjcjAyUklKVlNDOFgrSmhMaUQ4Y3Ro?=
 =?utf-8?B?NUw3TDlIdnBBTXdDbDVEQmh3S0ZCTUYzaEJ3T0lzOTN0SitmN21uMkxSNERo?=
 =?utf-8?B?S3hsREd2S3c1WDFmV1dmQThhYkZqajN1bzRCS2tldGo1T05ac3JxWW9iZGdo?=
 =?utf-8?B?M041QTJiRmNScDFRNDlpUk95SnN2UzdhMHRZSmVhN3Z0MkpvOS9YYm11QlJL?=
 =?utf-8?B?Z014QlY0VjlNTklwRUNyMys4MmpQVWxHWmo2dEVkQ3NacTd2bjdkSmtrTFl6?=
 =?utf-8?B?a0xZV3RscTVDQnRsMlRQeDhLMzVqNmtDOVB1R1hyRkQrQzRKejNZMnJ5ZlNE?=
 =?utf-8?B?UVJoaURUTm9pd3JwV0M0L2daYUpZWTlZZVNsazRsU3hYVnRpVmErTHJrZkJE?=
 =?utf-8?B?cmRJYllFSHA5WVFuL0p6eEF5ODBqeVBrMjdoejgyK09nZ1gxQkVtVVE0dmkv?=
 =?utf-8?B?bHUwa3E1dUs2SGE1aHJDU3BCWWs0RHJDaEZGZ2JZdXZHQ0RtQ0V3eFJUTUhk?=
 =?utf-8?B?V2RmUFloZzhOLytUL2NVVDVSRU9JaFdiY1k4cGxkQ0NVMUtlNVRNcmJmcEdm?=
 =?utf-8?B?UkZwMVFSS2NvcFlEeG5VZ2RaUEVJaDFuQmcxZzB1QlFMbFpucEZDQ1ZndjRU?=
 =?utf-8?B?d2ZRdTdFNGFRc3BSWkk3WlJ0TTY2d3FYdlZTbmRhRnpoWWNYaFV4aUs1NkV1?=
 =?utf-8?B?bFBHZTFJNDRja0t4NG4vSEZTR2dWd0tJRHRodlRkakxrL1A5RjJUeW5ESVVY?=
 =?utf-8?B?eGJ2SURFaHppWVdwa2t0MjdDQytuUThRRm5oeFVLaHg5RThpYmNlVkc4SVhG?=
 =?utf-8?B?eHBSWVVranM3dE1lSDM2S2hOMithem0rWllXQXh3OWJmRGtoeDIyTDljT2U5?=
 =?utf-8?B?SExtQjArOGs5UVNnMzlySWtXY2RkaWlVTDE0ckxYTlNuQStRbUNxNy9wU0Jh?=
 =?utf-8?Q?Cnt8pl/BTtVkbEvtVOvugHjbO+6oRGn5kNBkhJTSQ+bDX?=
X-MS-Exchange-AntiSpam-MessageData-1: Ia2/z+Q3M/KUsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538e126e-9444-400e-2ce3-08df0364a7ba
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:24:55.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViEbo+nCo6IOZEjh5hsW9bnKWt2EqlGpLbnxobNDTy1N5NWtBRU4CvekPHu5s23cMIAcdkFQClI+ejL/p7y71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

On Tue Aug 18, 2026 at 5:46 PM JST, Zhi Wang wrote:
> Rust PCI drivers have no typed interface for locating and accessing PCIe
> extended capabilities.
>
> The SR-IOV extended capability describes VF topology and VF BARs. Expose
> this information through the Rust PCI abstraction so drivers can use the
> existing typed configuration-space accessors instead of raw bindings.
>
> Define ExtCapability to associate a capability ID with a register layout,
> and add ConfigSpace::find_ext_capability() to locate and project that
> layout. Bound the view at the next capability or the end of extended
> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator that
> reads and validates all six VF BAR register slots up front, yields decode=
d
> BAR addresses and widths in logical order, and keeps the raw
> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT() i=
s
> a function-like macro, expose it through a Rust helper.
>
> Link: https://lore.kernel.org/rust-for-linux/20260804161612.776752-1-zhiw=
@nvidia.com/
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Gary Guo <gary@garyguo.net>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/helpers/pci.c     |   5 +
>  rust/kernel/pci.rs     |   8 +
>  rust/kernel/pci/cap.rs | 329 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 342 insertions(+)
>  create mode 100644 rust/kernel/pci/cap.rs
>
> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index 4ebf256dff23..b946b14d79e4 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const struct=
 device *dev)
>  	return dev_is_pci(dev);
>  }
> =20
> +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
> +{
> +	return PCI_EXT_CAP_NEXT(header);
> +}
> +
>  #ifndef CONFIG_PCI_IOV
>  __rust_helper unsigned int
>  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 9f19ccd5905c..008c2770a3f3 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -32,10 +32,18 @@
>      },
>  };
> =20
> +mod cap;
>  mod id;
>  mod io;
>  mod irq;
> =20
> +pub use self::cap::{
> +    ExtCapId,
> +    ExtCapability,
> +    ExtSriovCapability,
> +    ExtSriovRegs,
> +    ExtSriovVfBar, //
> +};
>  pub use self::id::{
>      Class,
>      ClassMask,
> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 000000000000..ddb3fd73e195
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! PCI extended capability support.
> +
> +use super::{
> +    io::ConfigSpaceBackend,
> +    ConfigSpace,
> +    Extended, //
> +};
> +use crate::{
> +    bindings,
> +    io::{
> +        Io,
> +        IoBackend,
> +        Region, //
> +    },
> +    num::Bounded,
> +    prelude::*,
> +};
> +
> +/// Number of VF BAR register slots in an SR-IOV capability.
> +// CAST: `PCI_SRIOV_NUM_BARS` is the PCIe-specified number of VF BAR reg=
ister slots and fits in
> +// `usize`.
> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
> +
> +/// PCI extended capability IDs.
> +#[repr(transparent)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub struct ExtCapId(u16);
> +
> +impl ExtCapId {
> +    /// Single Root I/O Virtualization.
> +    // CAST: PCI extended capability IDs are 16-bit values defined by th=
e PCIe specification.
> +    pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV as u16=
);

Coming back to comment on the conclusion: we have settled on a solution
[1] to handle this nicely, but it is likely that your series will land
before it. So meanwhile, please use the turbofish solution that I
initially proposed:

    pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::PCI_EX=
T_CAP_ID_SRIOV }>());

While it's a mouthful, [1] does remove `u32_into_u16`, which means we
won't miss it and will need to update the code to use `const_as!` when
applying.

[1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nvidia.=
com/
