Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020103.outbound.protection.outlook.com [52.101.196.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8F04E3764;
	Thu,  2 Jul 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003435; cv=fail; b=IxQ5GCRNHp9Zlfkup2rtYvtePd5wNFfHZdW6IwpgGGRVejxVTc/D/N/YjY/w/LLrO+bQtTtmxhxTQSSu5+1vdpX3AGKBx3EWTuf47/k8RygxTQbxUw4m6qZhNDWx9YisHm/Djcv2XMkvFkeq2/YrRqkYtrtymWOxsqpbvNil5nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003435; c=relaxed/simple;
	bh=LyKGIt32ZypJAovSVyJ/ozwTRz7yi8IVJlebvSkzU5g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=BaKXigYObThvPE+zFmLdiGE2qhkNR7EjpFEhgvl34r+lminkhityAfw3remor9xW4Gk8egM0ktiB2SaiZPKjYZ/Ddh8Sirh7MzRn6RF2MACGZRhMZ50MPL6bk7QPrz42sf8LDSuwCYkRTHIHHtir+bp55YmUQGIvyI4Hu7e6Niw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JWgfyZaT; arc=fail smtp.client-ip=52.101.196.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JWgfyZaT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFAAl5x6cvkBfKew5AuqQgAJKqCVtlD2xDZj+bymVSm0Wj+MBxWhfATZMpe9q+mVRjucxNaIUZ1j3CspiIXoSNiBdmaFg9tG1tTSnFtX6yEUbk8u0LeB38QOIUyRAxSWXLchVIAYRK5OE9gabHFasev80ivaskr0CvU31a3aUer39RluxIR9pKcBWcTWSy7MN/7BWbgl/vDUbiQrAOPhUKWSrr2wb87HNSHPS4OVWQ1olz+N1nFMD9NW3pFQ2G/r3onH8GvNUaxV1rK2K8UQtlT1Jsil0rNFQ7A9m6e1WLOZV5lNvKMBsmaai1oNKFn8XE7s8PBFLsqiXYXOn+0KKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn0pMf4msYoF96Spddk7p84rGYcXQ3AzBpaJQeReMgU=;
 b=dLlzAp14V2mzE3cFffoh95kjGRuwHUyVopMy6GVv/sKZW5wuHZAHShnyL6Oa+l5vYo5eNHNMC6RAa7yEL/i0N2Ro1ZSh85E5h/zfBGqlGirW9xtLy2hen5tPaf5xF74jx4WP7YQlMnHS90eYgDu2SsXG1dyVdebcLgVE5tl+AxFnNn//Zi8j8GPS0sV8azdnHrLLzb8EBcsYrUylRmJgRkMQzK88yeRBFwFpkpTk+/zUdReMrbNMsw4CPNTNXQtYZ1EA7hQhWbxZMuB9uLh2CYLPTsET94Fuce+KyPwaLFv8Z3dFnwnsCXFZtIcKIQ202Ehc0ipmu8A5XpWcela9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn0pMf4msYoF96Spddk7p84rGYcXQ3AzBpaJQeReMgU=;
 b=JWgfyZaTSW1kDD5SJTfURh8vx2J0V5pzQ2pgweAU6nY2dapk/MZdmd5hczW2qDGAATwDSZejVKFg19t58kVHqKgVjVVxW7AghmAg3UOds6OUbJfKqDtt80ZdBb44oUvQM7K9V01lB4IDfzsb38Yl2kumvT7UwxQ4MDLvKWtOPNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2844.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:175::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 14:43:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 14:43:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 15:43:50 +0100
Message-Id: <DJO5YS7LPENC.2BEASZSG6IEEF@garyguo.net>
Cc: <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] rust: completion: add complete()
From: "Gary Guo" <gary@garyguo.net>
To: "Maurice Hieronymus" <mhi@mailbox.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-3-6fd6684f2c14@mailbox.org>
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-3-6fd6684f2c14@mailbox.org>
X-ClientProxiedBy: LO4P265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2844:EE_
X-MS-Office365-Filtering-Correlation-Id: 639128d2-80e8-4f02-c56b-08ded848551b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|921020|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r79opXy0B7mHPy7CuVw+b7kjGi44sFNZNRU/rPFFkyssenQCo+wcS6ctZZpjfVoeGI5XQtXt288654h/uR1XBbj35MpQr1NMNUJGX8DuRO61U7hHFApCDBIw9mHPkkweGArkx7R3qjUn2M/mbtadlPoU127mq7JW7PxzjfhD/aUD92Ebw+DkycHR/l+dLql+UdIknCdp0x6P5xufGA+QbsvziUB1IueSawaJWrd+U4eVff3BLEblH6KT2Cf5TAPbgG1VF8eDKcbq6a+qgrVrTgGcgWzidTQm950n1NJSPvtNgdPh69ib4/cHn/Hyp7uwqiXGfoa9YpTe4Co/oBXodGU5mvgaEzCWMflZqA8bT96pleBLJbnMwFU8rRo0ttKo/NmB0/XptWLAFV/rVAJCMkK0nBP2j+HQ9lgbw5gvsdrPxz68XuxBAXmXnxV8BnIO+hz9eUFolCzBon86oKrZrwQwWGwG4n7vJULW1vZNGhnRnbnY1aH7uW5bBy/Ki0KTRI/OK2qqx73XlTlS+DmVZ2H1lAhUVKnkRX75La1oN3C3Ji56sTmMfcWWRzU/G175edHctX5jjFZH3gXYiavSEbVWS/h9TsjpqJsayBZQnGZ84Zqku/abAW1kK/7CjZxqUWo5255G0PTm+fV4nA2cVHeqC9If9CXrINZApH3jbrO7+XUT9JfHkYIKwB6VdOXMIYSBa+5tYj9gbXDBlybd4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(921020)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmNPNGlnNDdPd0hGeDBKT1lyVUh6TnZzYzl6aHdGTTN5bVBRVVhPeU5FSTJ4?=
 =?utf-8?B?ZGNNcTk2U09RczJEVllWSUpsbmp1OXZEYU1sTVB2cVFZaGNJWitLRUVQZGRu?=
 =?utf-8?B?WFVySjU3MVdWYXg1ZWFqa0t1ZVdUV0NieFRNOUU5V0VVdG1TQS9yUDRZRkZX?=
 =?utf-8?B?UkdLNFFVVWFNSFdOL3BPUThHNU1ZazloL0pwUFROTTducVVZZ2hUc2lTOXBx?=
 =?utf-8?B?bm1Ydk1idDBDK3dIM29qcWlDdXJTSW02MEtYNG5nTnlNUHR1a1JYT3picm9a?=
 =?utf-8?B?b1QxNDR1bVp3MWVXb21HbG1kQjM2YlN3bUtwRFJLampxQzdUWmZTd1F1Tyth?=
 =?utf-8?B?SHRZV3pib2RFdjQvdmdXR2t1d05ZVVdZOXQxT3o5SURSTkFGendwaHFMWDc4?=
 =?utf-8?B?T1NpUEZUa2FVNS84d0RXODJSMGNlTGNRQ0lLY2Z1L01lUWZaRUgxdkNDMVpo?=
 =?utf-8?B?YTA2TS9oTWY3Tm1jS1RySkpnZWdsM1g5aDU0MjM0SjgycWRrcGdQZlBpNWxa?=
 =?utf-8?B?aThlQWpWWE9DeStUaFhKUkFiRUc4OHBpak9zcmQ4WFR2TzhiMDRvMmZlWW9E?=
 =?utf-8?B?bjQ2T2tCeDVUdVVRWjc1V3NtQjgvaEdhRDk4V3MrQkE1UGpMNms2SlRab0R0?=
 =?utf-8?B?TTVvS1F3SXU0SE82R0JPaXQwTVpqblJjM2RGTS90bFc1NE02bk8rYUxqMTh0?=
 =?utf-8?B?dXRMaEpHQ3JIbDhPaktPV0RZcldYRVRTc3hoQzZJK1J3TkZiWEpVKzRTa2pO?=
 =?utf-8?B?cGRUZkdNV0MwN1BxeUVnU285a3Q1Wk51VFRFSFA2RHc0NXhwZXZCdHN6Y1My?=
 =?utf-8?B?YUpNVWhXeVFvN1pMaWcvZWVuT1ViaFROclRBU0RpMFhIbnpFNnlsaThIWkFT?=
 =?utf-8?B?UEl4Y2R1S01SdkY0QTd6ZUZ4Ky83bTdpbjVFMi80cGFlZC9ZZlFRaEQvYzFj?=
 =?utf-8?B?NStNM2NkcUxLQ1lBM0xoVEhQeFJsYzdsS2dlbnB1d0pleUR6K0dxOW9NQURv?=
 =?utf-8?B?aUxBdWdhdkNpZDlQUlNvVnhhV2liODV2eHMyOU1OVnNBQUZMM1ZEVXppMFBm?=
 =?utf-8?B?NmNEUFoyQ0c2OHl5aGE5M1NZREZNUDllMExacDhmajVKOENSQWdWQ0hXMXVk?=
 =?utf-8?B?TnBqQkVnYlpkRmk3ZUIvRnVWVFhZeTFOZDVDM2doY25HUTVpRDJKWXRERjRa?=
 =?utf-8?B?U1d2RHB1WmJURmQxVUc2Vk4xdFBJcG42TlJXd0ZyU1RkS0M1bkhnMUplWURJ?=
 =?utf-8?B?ZzhseFNyN3ZrWDI5YUFNeHZVQVQ1cVZEa1JQOHBRQXNVQjFDY2Znb094OXg2?=
 =?utf-8?B?UDNoMG9CQXBRWG5ZZ1U5R0FrTk42MHYrNE1DcmtoTDlObUgrb1J1Q3FKN1RR?=
 =?utf-8?B?SWFhVytxYmJKQkxDUXdhdFBUNEhNWDA5WUptTDdDKzNoMWJPSVNHdEhxVmxz?=
 =?utf-8?B?cVh3aUgvemxVV1l2RWcrUnFOSlczZmE1UWhNRE93MDBTd3BTSm9oZHB5WHdn?=
 =?utf-8?B?VEZmV1JyaU9vajdkajdYRm1JYlFYY0tpa1BkN2dpNGJRZ2o1Z2VMWm4rdndD?=
 =?utf-8?B?cDJHQ0Y1UW1ldVA3MHdRM3M5Tm5va1FscjJpZjRvRkdhaHdJOExudXk5c3pX?=
 =?utf-8?B?QUd4OUhiMGk1cVdSLzJYMkZBanJMTVpoOFROTE1OTkpsMVRuUk0xQmlsZFUy?=
 =?utf-8?B?YzJ2dVFJNVY3bUo5U09YNmZkaE0yVE8wa2V4K0xYUXA2ODgydW94elMwK3Vn?=
 =?utf-8?B?MHNuT1NPWlZ2dzFzb1pnejRPbzhPZXFwN0FWZENGbGNqOTA3ZVJodFdhUEpW?=
 =?utf-8?B?c3o1Y3Bnblk4MW1aNFc1YmFmTGV0Y2taay9ORjNYcSt5NEJpR0JyK0l1Uk9N?=
 =?utf-8?B?QnJDT3FZalRTVDhBQmhJQXZNc1cvVkQyNzYrZ0o0Q3RKMzNTMm55Y053Ymdr?=
 =?utf-8?B?NnpxYmNOaUo5MXd4TW02WTZqZHJhMk84UklNSzVSVDR2VlR0NHJ4SDBqR2N3?=
 =?utf-8?B?bnorSGZULy83MGdZWVpyQk9xNERvWVZ4blB0bEsxaG0wOENtcVRCcElXWTJI?=
 =?utf-8?B?WTVRZjVha2RYSmhHWGpQdXM0OHEveW9EWHdKK3EwTlN5NDR2eE9JQ294Q0Uz?=
 =?utf-8?B?Yyt2RFZvMFg2OFhyK3F2bFJraXVCNkZZejlNZkhsQlkvekhLbFlTblAzNk93?=
 =?utf-8?B?S3FDTnZZZVBHSnJtSlArK0l3Vk9ISmxmS1JSRTR6TGNUNnhjTGN5bHZPWmky?=
 =?utf-8?B?dUFadXgyV1NHd0NHSE9ubXdzN0xZWmFUUVhGYUlqZy9wTE95RHN5ampNa3Yw?=
 =?utf-8?B?TUlCT2JQRUpWQ0NHTHowVzYrN25DaG1NeFByNWt3d3NFanpxeEtUZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 639128d2-80e8-4f02-c56b-08ded848551b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:43:51.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0KVZhIALPzO78NCFuiRdWE5aZwyuqrSVInygHtc7f+km6nBeozUXRDEXlVcg/7kDlSLWe4DGEO7TnwHi+aWUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2844

On Sat Jun 20, 2026 at 9:45 AM BST, Maurice Hieronymus wrote:
> The initial completion abstraction only added complete_all() and
> wait_for_completion(). complete_all() marks the completion permanently
> done, which makes a single Completion unsuitable for signalling the same
> event repeatedly: once complete_all() has run, every subsequent
> wait_for_completion() returns immediately without waiting.
>=20
> Add complete(), which wakes a single waiter and increments the internal
> counter by one. Paired one-to-one with wait_for_completion(), it allows
> the same completion to be reused across multiple cycles, e.g. to wait for
> consecutive DMA transfers to finish.
>=20
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/completion.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)

