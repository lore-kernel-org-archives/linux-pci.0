Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033EA3043DB;
	Thu, 13 Aug 2026 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582733; cv=fail; b=t39SHcSdaR6WU4wKirjr+N/HcF8tJMQXvvmUg1CJz/cWPAXwWWR3bU6Dqa80DgL4E9MahrPoRyarlO4B2emrh8aO2vgihrtsblC5lMEJphNZBA3QfeIWoVG7C/PmLHEW+1I/r7vv5B+kLSUtuMEaJT34rx4vO/A2tpzoU1DOmVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582733; c=relaxed/simple;
	bh=v9VvqraAgzlixEQUEjrD1nrTeivh+12lzHLNBr8zdP4=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=hUSzhKBcuhVZ9DuEUYE7KYdiIdpfOWYGbMolTxjeUUhAfpOVrqwqqCrNqbdxeRVsmpgPPUjRC6+4KJlLlAMrzUxYwGFZNVmTX/SOULcjqq9LkRf3xazGvdokKUnVUPRv8GzHIzsWdZOUlmf2S+1XjksL2boT55dBxGxrf6XxB34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFHr6N0u; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFHr6N0u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7yoe1epUzphzebd/TZ39UNW+yAlGI6q2IalF3LfMX2ZiPXZSoAF3ye+gQPJaV1bXQtiWQTcveDfhjTPVkirCqfbjjzf625Ly2vaRweASFa6vsSgJ7YBiX7G6frBxc1d23/5B08C8ULNxiTScJu3Wcm4iQAvJAh+VnNqQSQoyFsbRYDA7FsNqUAnvYmX37dYA43y0GUhLhbvwv8c/+LjyzUirzkGfMcN6r3UJnWNISazWDhTR3js2i+qe/qc9Lu1m7Wn12xKk3dyvcCyAw8kR+6W1mI6Zf7xw58qQpFzuVvCvTrpF09Oguxr5llwjaWZJjd7+GYP7K+c54GqSf8ShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FtFGsUNMqjmZ22gwwPoYsL4qBZiIRkjt4zWSQR97M0=;
 b=r07/bN6Dev0Kd5Un+n4GQRKo25evxu2Qt3A/pz2gb35MWCy3HoZEN840Kz00x3PP3454RVRSuE8p5jnX5c7vfVBnC173rSSQ9yf0y0DJq/LyujQxgmMPm8Q8+6obWuCIk1QCIoXsRM/KCIzfqtIGZCHJE6rXzNxIvWbMDzDGuyilGozi8nAfu/0YpGJyrk4n4BOebbiM/u5zqd+HU+YmGt401ewspkLw1nsNAvJsDktlxdFRpXZo9xvtsAapcJcFZPYL0ES107ENkzAXQacRgA7O4TM6PqWvCfmmbDwb0j9AHCDFbq895YUq4O6k2kbiDpPMxWfEZJ1tPYTaLT1faQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FtFGsUNMqjmZ22gwwPoYsL4qBZiIRkjt4zWSQR97M0=;
 b=UFHr6N0uk8e+3kaMUxleiCuLe3sQgSRXGkib0DE+pHuPYZJPwv70FJs3Qy1iONkwmkf4R/2ENyUwUNtqE2WgcdHo9NOv588E3A+4zX9A76wXy8yZoipWok6F8cOhaFGa5aRdWvpUfZbgByFk90/ku9s2uvDbF50ibNLmFWvR91xRUUxia1uqAyYNj9dl6vfosMOs6yemA08zfFRZBHSzo2a6eewiuJXD1MMnMe0gktQVgaO0NQ0FWESFNyCOor6Xysx4jdM3etNsKSFC3R8p8QPicfKhDxNnqdPFPFDrsKFxFivTibioI0H2sIFSoaX7HqEXUrNpCOYECaT/Ke3/Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 00:58:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 00:58:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 09:58:40 +0900
Message-Id: <DKNEPVGACHOI.3QS8ZTDEPK3QQ@nvidia.com>
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
Subject: Re: [PATCH v2 14/16] rust: io: register: remove relative registers
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-14-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-14-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TYWPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 589232cd-f5ed-4b65-8a31-08def8d60621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|23010399003|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O1xq+n6T1OgAUza7+VP4LPF9ZzLBMWql+hhEWx+pFlxCstjSvnMw3T7N4YRGkJ2Oig5lmCav6foWBP0nU6eBJZrup0Vm0mYPy/AuEryQNLG0go6Jd8PFlgsTwcSh7Yc88dL516PMiJijZUj9A2epam97te2W7neE+fVbZIhYNVH194J9ZQnSFlgnS4RRc+zs6luj17aEaHIqM9PmC2CrRvxqUEYpjDzoPAPDlXmsWCkF1KaMGSEH+iV47K5Auiu2TDvpLjA/Fto/oxExc036NcUuqCdx195nf86y5Z0MB7JK7QyuPmrIcbO/ue+QuczGkTfBrSgpUawx+rolrFIq/xVi56glh2SxkWcByRs9CPwCB3SThz61SfLgzFi5xlYoI/OH4S2OxBTt6GewXFBVvas3YtYNbTJn0qGfMNHP16OUhhEgmY4CixqwV6Fskwci+JwUSC5MHao0ImXmeau8RtpxN2dz5YRBLug6+RfdZ89QwDKnYY3vULY/pqEgY1u+yNgqYZgA3t4pdUeWGHUzyVomSoDX2xmRdNh3NKdA0nR6+/6mQMQaA3h58T5AfzaD4lWJzPMWSccwpqKpVgojMsAfVJJkJuiYjgzPx1/hn7FOFDpYYsHlO/M8eHPC0IQDA6y2XwrWa16wTBm7+Zg1yK4lclxpJYjWPAVuzF09RPs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE1QbGhyZmF3dk5RUlZud2VBUWptSHpEM3hOTzZrUXZKNUJrQWJnY2RJanIv?=
 =?utf-8?B?b0FSV1NNZDB2WkxMdFpwTWZFZlo1cU5mTEM3bEkvendleS8xQnIzbUJBdENx?=
 =?utf-8?B?c28wUlgreTVRUVB0QjdzUWRWMW8xSHErNHQ2WVhNRmtZUXlCeHJsTXRxcGRF?=
 =?utf-8?B?dHJvVEk1a1NjbXoyaEtxbmdCRzFxd2FubGpXRHpiYWFxNUpUaEx0Y0hIaUJO?=
 =?utf-8?B?NEdxVnE4bVlQZnQxZkx6Q3lzYmZDWEJzUktTZE92U2NOc1FGMWlZVkFTWDhI?=
 =?utf-8?B?YVA4RFNKclF5aks3b1V5anVvRkRkQy9SUW9rNW9WbUpoblViU0pjMDBHRWZM?=
 =?utf-8?B?bjBVYUNJRXBIcGxJOWRydWZnVStwdkltQTkzTnVIUTl2SHVUZm9ndjVTOTdP?=
 =?utf-8?B?OWJPQ09naldkVjNDQ1lBdFp6VWJURjZrVzAyM0tOSVZEVklwQmk0Yy9YekFo?=
 =?utf-8?B?TVZaeWEzSDkyZDhmQUVtY3BTK3huVTdwT0NtRmYvTzhTc3ZxS0pDUSs3UnZD?=
 =?utf-8?B?dlRrUndqTEZKQnJ6ODRMTUs4L0JoTWpyalBtSk8rNFlJT0x3bUk5ZVdDUjFW?=
 =?utf-8?B?Y0liYjVuY1A0WldhbzdoeTdpZXd2eDFqTmNLZUh1aVI5VFlaWXpYVzQ2ZkpS?=
 =?utf-8?B?c0xSZnJGMDZSMjVyb0pIT2U0cXAvL0EyV0xoZWhDbFFNK0l1WnNnOXFJK0hT?=
 =?utf-8?B?YUNickp4d09HRTdqempsRFhtR3l0Q1R1TXR2ZWdUeXp4alVia0YyMVQ0OFl2?=
 =?utf-8?B?V3lPQnhlMGtrdkc1UWgyZmdXaUJoM2dXelRwM01UUUE3cnJDeGxsUWtPZlR1?=
 =?utf-8?B?M2tWVGtsZC90TlRUWFpjRUx5dit0bXhYdVV2L0NGNnEwaXI3ZTVlL2xsVC9V?=
 =?utf-8?B?Yjl3S0k4S3Y4bmozUzhpVUlhWllvYWtZZXFXZGllMUtKcGxKZ1Rzc1hyVUU5?=
 =?utf-8?B?UUZUVGJlb1F1ZEZvRVpBNHlNOEVFSkgvclE3NXk4RGtFRFg5eGJ4bFppcVZo?=
 =?utf-8?B?aU9vSFhadEM4NWJFMGxMczBjV2VqZEVYV3JkRkFTQ0NSSEIrMjRiKy9DZXQ2?=
 =?utf-8?B?Nm96NHl3MVcySklIbnNIRDF5WGQwVVJGMXBEamllZzVRSUNqOTlVMzc2UCtr?=
 =?utf-8?B?YVhmbU1pNDIvbG5ocFBmYTlySEV3MC9yTFlBQ0lxN1p3RG1lVGYxeXFIeGJX?=
 =?utf-8?B?aEN0K0w1bGRWZFpnUW9vQkhxK0F2bkVuNEFCUHcyczZraDlyOE13UFJJemZq?=
 =?utf-8?B?akVjMWxRVDlaallFM0NKSSt6TS9mYjhFdEVxUVpHZncvTEJBSHRzdGg5NklP?=
 =?utf-8?B?RGdmS1hueStseW42Mmw4RlFDNEVpeU4zbGRtLzFjZlBRbVYyRWpud3dRNnho?=
 =?utf-8?B?Nkp6Zi93YjNHKzhjWDd6bnNCWTdDcnNMR3RNUDdnUmlrNFloTTgxd1hnYnJW?=
 =?utf-8?B?WFlySVF5L3RwMUUwc0lKNnhwTENGc1M5L242bHVQRWhJTHBmeWt6Y3Z2dGJZ?=
 =?utf-8?B?a3puYTBWR1FyZC9qcG5sVjlqM2w4c0ZnMHRCelVZNkF6T1QzcEV5enNyVnN2?=
 =?utf-8?B?TUwrMVcrYytMOUFjandzSjFQWUVHQUgvOWdlWndIYkxKVnV3MFdhbHVMT2wy?=
 =?utf-8?B?L1NWd3doQWVhS1pLQk5KRk8rRkg3U2J6eVZabXFCNVRBbjNudUlsUkRXbnNE?=
 =?utf-8?B?bnNtOUkvZEFUY0ZiYTNaakNRdkU3WS9IUFF3MzRMNHpab1NEdkkwVDJUeEFT?=
 =?utf-8?B?N1h2LzVmZXNXQUtvYUdhTE9BOEVqN0xnS0dTNlNRcDlkRVdhRHBnYU4xdTR4?=
 =?utf-8?B?L2NMdUF0dFhFSnQ2Q3VuaE1KNGFwWkxTK3YxR1BXeldPeDJBNW5sTG0xZ3dO?=
 =?utf-8?B?ZHl6M0NYV09qTjFjSnR3WWhWUDVxUXM5ZUVmVGJDeTJ3Kyt5UVRNdWJSMzFL?=
 =?utf-8?B?REY2ZVp4SXdqQjJCQ3BxemdKaHlrMVJMUXV4T2RRMEM3UWRXQThkQzBGMVAv?=
 =?utf-8?B?cFFOWlVoVG9GM2wwdkRRcU9QWjB2L3pYT0ZqaXpWTUJNa2g3R3ZSM2tzZUFh?=
 =?utf-8?B?NHJ6N1RUN1l6YTdaNjZHUVJ3RjhjYXB6TjVYUG9jQWFjcDlER3hFL3ZQU0tl?=
 =?utf-8?B?YkFYbWNzNlZpUHVqNXo0TlcrTzB0S3hoQUx5ZzBELzBZWFFuVk1iRW1uNis1?=
 =?utf-8?B?TFBKd2U1OHk0TGlpaEtsdlBKSnBneTNEM3Zta2NxaElGUWd5UkRmN2ZzL2Fs?=
 =?utf-8?B?aFlMWXlSSlpVUVM4VnRBQXlQZjlkQTFLNnRVeXliZ1FHQUpDVHBYYWU0dThZ?=
 =?utf-8?B?Nld1S204QVdOaGdOMnI1TXpWbzBiR0dEWmc2N0w2MjU1UmhJMm9HTVNjdzdE?=
 =?utf-8?Q?DornhBq/VuB9RLJ6rOrZY3yzVYcf1nLs3FSnQuMQulO9P?=
X-MS-Exchange-AntiSpam-MessageData-1: tLNWacec4kGbLg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589232cd-f5ed-4b65-8a31-08def8d60621
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 00:58:44.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhPYsjexDokq1qQDgCfgMTWHS3PRu2s3+1VJf++YNF1VZgF7LusX3pgcRxWcxXw0SQG58CaoEQXdM7Wl0j8GgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> Relative registers can be better served by projection to subregion instea=
d
> of ad-hoc handling in register macro. Projection composes better (e.g. it
> natively allows relative registers of relative registers without needing
> additional support).
>
> Remove relative register support, and update the documentation to
> demonstrate how projection and subregions can be used to achieve this
> instead.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io/register.rs | 474 +++++----------------------------------=
------
>  1 file changed, 52 insertions(+), 422 deletions(-)
>
> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index 49a61da106c7..295b06dd53a7 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -8,7 +8,7 @@
>  //!
>  //! Note: most of the items in this module are public so they can be ref=
erenced by the macro, but
>  //! most are not to be used directly by users. Outside of the `register!=
` macro itself, the only
> -//! items you might want to import from this module are [`WithBase`] and=
 [`Array`].
> +//! items you might want to import from this module is [`Array`].

nit: "items" should now be singular.
