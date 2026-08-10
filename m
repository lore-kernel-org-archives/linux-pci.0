Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F53B6352;
	Mon, 10 Aug 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354262; cv=fail; b=dT5bAYGdknovZpSo0oIMyhgc7gfgPdTjArjc21yO+SwCOnZO1Fi1i1z6wgm7uvHUBKRKULfHJnEHaaIT0L33M0Lu1JKI0SsQ8uG0VF0GX6TaT0r1CvqujqGRtBTsHf7PLLwAFmf1Srk2X8a1LR8XlKMqsx4TbqqeLhMUab4zoBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354262; c=relaxed/simple;
	bh=EOXJTMbAHDyS51DQ9MiIP7TwHK0bfBWqCOLRbl2y2Zs=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=eIGnVAoXTeZbdgnhSfKs2YYe38tlzWJ1v+U/cluQEZqYeyBq7W9cIenZ38PJsLrnbv9p9Tsdb429mRZb7/duP42r/+kjLRFZboW8/3RNlAp5fJmXEHJ8TmOgwphR5kfVSv1wx9htxpVRF1tFoEvNKCWhQ/g/F6nkMX8YKgRNcsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tj/5i9sJ; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tj/5i9sJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvLwfZq7kwAOlSDDFbU588TBUWnoL1e61qSA0xOlFiKbd3l3IepwnfUQ4wMvI0if30OP74rRCHmgASsbX8caPeKpqmet1dxzRNXAX9a0LLkHd5FrubBgJXZuw2U+0jmM3HnLVPiq0zTOOOtKuGM+QdCKdzLBRx8K583ht4HMPM6wXoYbUY9m6aIrAV9oJlt5okPkaGSBxCWlKWctw2txGmjmeFvOE1gJ2F8UDfwg1r7wL/msg4OaOhgNgWNOIqXweorrrmzxlhaY2E9Yydd81/PwSzYOPMbtJ63JATVjkr+BOMM/qRZw4NY0cxxpKrcVs3n1hrZWWdP3qTOuF/rHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOXJTMbAHDyS51DQ9MiIP7TwHK0bfBWqCOLRbl2y2Zs=;
 b=mLLXlP2uZccRW8N014wwakiB5DqurXepfcpmAhNIqWaz691+j0TaEifYrbIKckVwpqmKqhg/mZHN8u8FGkoN40s1NKCUkfoUxh/lHzYA1hFXpLe26pZTIphReylDpKMOcd6X6dIUfIWE5oH586ONE3/9ma+zcSH0Vorr1Mov26oT/GoxSchUHF7YH7l1WI/nu5DHjsyol07wvM8kpUzJ943xVAg85UdOgyqCbO+6LN4+T6drBAkE6nfgAaJCn6cBEpr2Gtl8EgTVnyamkbIKZgIcj7S6Ac6EaUcUZiA3HLktxDlvwfxctVlD/64Xz8vSJlvi3CywXG3V4FvculYbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOXJTMbAHDyS51DQ9MiIP7TwHK0bfBWqCOLRbl2y2Zs=;
 b=Tj/5i9sJyEow2ZfTLTR9DXrr/6VnjwESm/8At1HBtdbGrTylNuh0wsAVXt+iDeEAAgjRfOEe8NQ/SuSzGi/6I+YKsztZ9MsP3WkgHXkqKvRHuyV0tX74zqDyR9kcDKbiWbd8s+YDcPfunX4lr5qnE4lliwsH0/SLEZVRFuGn0nBQHkH0aO0/Vors/iW4rWtRjaskt1tyrMsIynEY19GXgRzLK5jwoFLdDleJ4eqY1SroL8rv6EraL9lzCA+/HyDnw2QIa0MdMLavcKgOkqgoypS+bvsBiwyVn0bmEqOZ1sdasoqzdVU3OdSjRd1M/lpoSj+uVGrHiRccLsmluktprw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:30:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:30:55 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 18:30:51 +0900
Message-Id: <DKL5QDZYECG0.F0GU1NZZJ1ZP@nvidia.com>
Subject: Re: [PATCH v2 04/16] rust: io: register: handle one register at a
 time
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-4-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-4-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:378::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: be3327a8-c981-4d11-e3f4-08def6c213ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IBMqAaibySdrLKmvsfqpvv3RYWcjMEune5xRn18Xf9jCcqQeKbHN6yt7fmoBWOXQp2N/Ehn+PDtpJcmWQ+Hf+W4YmaV4R984PN8ywRf9wMW+PXFtpCc3/xwRGWnhcneh5iD3YGCDw0BOQbhy3K3ccPyfzXMLts1S4fNIkofRdomxv42mvnmH7rO3FSD8GXjlwbtOTmXUbiEFb0I+BQ/dXOchODKj9QSFOH6L69klxSwKQ2WTiXbcFkyIXLiKhykX/OQ7l90jYdoj3iDRhDsEk910YHuJKbqoC1TgCBDe3Wo3s+cYXGMLTzwSzgiKSSOjn4fFG8Eye5nfp2bqcvLbFxcobRxVm3H7TCtXn744khoiub1MdXYwFBNj+u1MdxxH2w4UxV7TXkb3vNTxSYwlGP4ZjfYc40J7b9OuvLYDlshCy+Z9k8+IFuvxbvAQeLsrBGTT0oDaUSRBbsB39O39aP+XUItK7pXm+hEPM4nNUJKcWO2FrxLcWkpPH+p9s0jGIhnhIFy5MqxmBLQXjkvXLRcuf9fH94V2dHx7ZRfX4aO4duDW1av7ko6WjxiaYIgrQmugrXHqzOPxbeASWWm/ykzDG2hTwMuxqFl8SktnD7bYRBSnIGzQ96o9B8/z9ndome1stu+F+5h6xY5aus93zmmgrUDiWXp7Mj6ncuHn7eg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YklnY0pXZk9Ka2VZaXh3bmZ0dEJ6azhmYzFTQ1RVN0tYNTlHZ2w2TGE2RTdM?=
 =?utf-8?B?bllVdE52UEtmMEhEZnFlZDhMZmxsdlZyTEdIMmJ4Y0c4TDQxSWxSTmxSNVFJ?=
 =?utf-8?B?NHBuUmFYVXVQdUU3cTF4cEdub2NTQjZhcTgwbjBaVzREVkdMVWh4d3RSSlc3?=
 =?utf-8?B?NFNpcnoxMFNHaXl5ZlFUZUVmWURIejlubGF4N005UzY0cjh2eXRxK3I5bU1h?=
 =?utf-8?B?WGpibWtrSmJXZ3NKbXR4ZXNicldZY0ZEZnBVbkZsZ0VBU2hZenlZZXJoNVhl?=
 =?utf-8?B?NlhzZENPd1J1Tkdldk1tTTZJTjNYMk9SYm5QZU14ZkVPaWx1bzJMVmczV2ZW?=
 =?utf-8?B?NXBqbkpnTGJGRlcvUXJDTFFFYXJ3RUFqZ3NMNHByNTh6aXJIUU5ncTdCOUMy?=
 =?utf-8?B?OG90SFo3dWJoZGhYTm1WVk5peVp4SEpaQkV4ZS9KNnNXY0RGMktETHVpVUwy?=
 =?utf-8?B?cmVYZEFrSjJ6aWdOaEEybVR5SWppNzUyMmV6ZDZ1cjhTNVowRzlYbXFHM3Rj?=
 =?utf-8?B?M2tvaXNlWFUrNkZJTi9yUHl4bkwxQXJqTGtYdUZmVHV0bUZsQUk0QnMxQW81?=
 =?utf-8?B?NkJlaVRwSUpuMWpENXhQYldFN3dHM2I1S0VzYkpkWFNuOWRDT05YVmppaGhR?=
 =?utf-8?B?anM0amV3a2d0WkI5TnhjTlhGTTJ6cTRhNlFzRStjUTFCajJKaERCQW1mOEIw?=
 =?utf-8?B?aGNyNGJnR0VWTDhiUlRIdFE5dTFTZmpyQUttTUpJVWpid3R5QkkxSVRsdHNp?=
 =?utf-8?B?T054ZzVQeENzL3BLZGt6MHo3bDAyOWJVMFIrOWgyNE51bkQ2azJ0Nk16a3J6?=
 =?utf-8?B?UURwVUd1ZzRmWkg0UWhmTUJ0Wkl3YmFjQTExNUJMTm5jTk0vS1ZhY1J2QVo0?=
 =?utf-8?B?SS9kUFJqZ3U3cnV1NGRJQXBRTkM5R3dzWTFjamJJYTFzSmw5U0ovVlZIYXk5?=
 =?utf-8?B?a24rSVdaRldBdjVrSVpoeTBHT3QwbjNBdlgzYXBpUXNQS3E5LzhmUEZvYzhD?=
 =?utf-8?B?b25MTlpEODJDRTdGekhNakRHWFNlVzd1ekFYSnpMVkN1NStYUkMvMDNsN3pX?=
 =?utf-8?B?czRtSjdhS2ZYamVDMGxMM1h6UVJ1UHRkSERTUkZzaGVhSnR2aEZlWElYNjNU?=
 =?utf-8?B?SWJJQ04vR1JVYVVuckNkZjdLUzJHUi9sY3FXQ1Z6ZzFqblBZMXBQbGVsV1lL?=
 =?utf-8?B?RjRSQjVXOUUybHdtVnJPT0o3Ylh3QmlPVktrNWlPQTZtYmxtMCtZK2NKTEVl?=
 =?utf-8?B?dEJOaHA0T2pKNTBpNHl4TUZXakhMWXk1Q0ljNis2TFhHVkp5Uzl3eW9xdVl5?=
 =?utf-8?B?T2xYVnV4ZUhhYXRFZWxEeWc2M2RhazMwT2dCY090MHgrNTNLekpLL2dXT1pK?=
 =?utf-8?B?aC9ySkZINWNhbWxEUVJBbXBvWXNuUytGZUxTQyt6aWRBL2FabnNuYUlQMlF5?=
 =?utf-8?B?T21ldWMzbW5IM0ZOR0ljcHpmMW41MUhwWHBHcFB6ZDdpOEpUUHJ1cXkwYWhE?=
 =?utf-8?B?YkdpQ0Z6RlVwUWIwZWhpcEFVMDNmdnZ6dzlzYUhsNFRmelBLYTZGTmJ5REJx?=
 =?utf-8?B?dUhzc0ltMzlJMStpblFTbXRQWmNLVkhYZjAwTWRWdUExVktsRHBPV2wwdnVz?=
 =?utf-8?B?VHErZjBPOVV6ZmZWcWFqMEdVVUcvT3FUTHB5M1huaGtoM2MxRGlKZkVuMGhl?=
 =?utf-8?B?d09xWE9BSXRJSHZlKytzQlJMSXlNeTJ3dUJjRkZRSW1XS0w2cmZBb0hCMVY2?=
 =?utf-8?B?a0NWTGhnQ2g3SEo5dlZPZ29FYmpaNlJKVm9RRG1qWTAwbnJ3c0ZHdjhZUHk5?=
 =?utf-8?B?WTFwd0pBcS9WVGZFQ0c0T2JTRFFmRVBmNDRFUWVFby9PcGpjUktRZUJRTU8z?=
 =?utf-8?B?SnZadlBmM2wzbUpXejk3ZTRIZGFVN3pmMjR5d3lkd2xpYlV0UUxTOVVsbUtx?=
 =?utf-8?B?cE5xUU5hNkpMYkJzR1BTc2tTbFRuaG5wcytoei9Jd0tucWkxTEZnQmJHZXp4?=
 =?utf-8?B?R1U0WWZvSDVjQzQrRWNGS2ZVcnFSS2k2OUh2WXhqY1JQeVp6bEx6QjBOZGRR?=
 =?utf-8?B?ZktZUlhpS1Zzek85Y2dEVUFHVlpYTExSOFJkRHdyWjNteENEcVlTYm9lcHNi?=
 =?utf-8?B?a2dMNDdLVTFiRk5NMDlvUUVPQnY3MVYwc0ZiK3g5UVNKaytMODVzZnR6N1Zq?=
 =?utf-8?B?OE9EeXpPZm5wUlRtMmN1aGY3eVluU1QzWnI3dE9xRXlKaTZuSnlDNTJMd29I?=
 =?utf-8?B?a04vbFFTWlg3K2cyY0VubFRQdjRXN3hpU2I5Z001SDVLYnd2YWlUZFVYWXZB?=
 =?utf-8?B?OHhOTU5rRG9RenhqV1hQbU1wYzMySW9NYit1VEJxS3owTElBamVYdTVDSUdG?=
 =?utf-8?Q?irOGxDOl+T6liIB/85ENrZtIZgHijGvdh3f2ZDZ5TJD1d?=
X-MS-Exchange-AntiSpam-MessageData-1: IQuYKisAQFcNMw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3327a8-c981-4d11-e3f4-08def6c213ba
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:30:54.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4ACiCVm+r3x4sLwsX/ZzEMosQSwI8sQCAvVPh7sAISg4h5QgdKiEwUxm0JtGyNZhf+kZ2e2FxIobgTCgMKc1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> It is easier to change rules in this form, as there is no need to define =
a
> single rule that can match all possible register definitions.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
