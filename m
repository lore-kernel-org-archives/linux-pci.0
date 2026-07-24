Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AD188CC9;
	Fri, 24 Jul 2026 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875115; cv=fail; b=m9Kgykg9nqUR718UrWEWplUMCSxILvpQl5avWAx+SR5wy/ZxGo644B5Acvl4n0xrdXogji1xl7wF2v5hik7xDzj//kUveSUn0Ja80M8IzF5ypUhwSMapr+hvo4BtRV2qPoIJg+6jM53OMIRbo92xMFw+x+ZrRJMBUQfu6tQJG/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875115; c=relaxed/simple;
	bh=6V73mWVMLmPdvwCJPHxLv9RqqB2bXi3N8lKKJRTC4SU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=h+joYAzqJGCTZeTaZrwEPQYH8SW7u/8dhcGbdTSRxk2RJAcnHiWWYHDnQqOoHnzzi1EFkBDH8n4jkATm/9ja2WJ03/A5FRZW4pkeFRKDnlVgoEUtwV2vFeTwip88J75vgpoh4tLIgXNzrreC1JSG+RzBtwE7JpxFd58kx3VerdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qekh7ZEy; arc=fail smtp.client-ip=40.93.195.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qekh7ZEy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fso5LVFF8f0CwIJr9bZBt7LOkoqpjoyMVyU4TVhsZoARfqr74qHLK2b+KHBX1mfOx5rWWWAD/w81KUUvg2nAnOWPk1s3hvNHEe1u7ki+ZJqlk5TY2p/idE8HTt0r73KjpqccXc6ua875zXJt2ZXVjrTBtp5DED/xQy0vQNUSnvaIeBQJca5Pzs+m6K8K7Y0xUN0fWxN/DHTQuFv6R1K1seZaIyZQZc8a7OToDyFHwx22GT2z1fS7lTZsHj/4QnUKPNpK2mn4QC4V3TwrRZB4doiqt+jTvvclpUOyboOQzoCiax0Mf1MtB9ytKVos3//EjwdjMr8zpM/xFganxxq5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qObFCXGrraHYCvKwH86TF61Yd3cVXF8j1v941DPoDJs=;
 b=V+5xlrX7XFGkEQP54T18VZRhy6V8qFZRy5oPWxbd1Xd5+aeuCZJkj0xVe/ljdg7knK5pCxLy+OlrEO5Pij1Logqlwlh/qtE/aDixrw6f/Qe/24XPoMLUvKI3P59iwL+hmTmvwmw3tGcIzCjIaff5BKTOSWgU6RFd3JtkCRJ7islzJpCRsD9A6VmyovtfepNcGXEsnMykK8WGSJzEmuKYzKjEoXEWmhY9bqQLugGPq8OM+hZjBHHhNe7xsgBEQmYSxS4xR7rWxlYgb+NV74D5oTqCpuAjh+Nqip+DGKiImLrLwcfe2JDsbGanMLdCI+kaP769XDVvszndNbPnBur7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qObFCXGrraHYCvKwH86TF61Yd3cVXF8j1v941DPoDJs=;
 b=qekh7ZEy0+ZMSJ5VKHLHmWQk5TC+kRf58uG71FUTJdEmNbN0Ib2tE9FFx9EDVnCl1pccQu4U8FBDzTXsN7YXrGk7/YCoBl+Me3JbqTbZjsKIITaoGVxwUjfNME2cYOcqT16B7y1sdcIQ6OksSikZLcTvihmpPMme3rm15YxBfuTUO32oqyTT8OyhAfZ3c+RCpbiTOviiP357qMW1CYQJEi0CTeGByYmUnmKnbg1N9hsAUD36MQkNBETEriKfq9DgBid63pe3g1rpMGzGepIEPXJ3lo2gTPPF3Djvu8nC9CFVnRbppX0UsBurfqgdMOUcjlih08c3HIcQ43Q2qcQYBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 06:38:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:38:24 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 15:38:20 +0900
Message-Id: <DK6LF1ODPWC3.3QQV3SXQ55SXP@nvidia.com>
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
Subject: Re: [PATCH 01/10] rust: io: register: allow explicit base type
 specification
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
In-Reply-To: <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
X-ClientProxiedBy: TY4P301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd1d5e1-9c65-4575-ccf1-08dee94e28ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|23010399003|11063799006|56012099006|5023799004|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uO1pEldULUCDh34Og0Bk+/AsU4bC5Z+QqgNhIw6rT9I7wxRPhWlILP1fiXk74XrQuTjQT9nlMfuG3GXdQHeuFwzPDHjs4RgFSIMTSYTDNkhkqH2ebIIDXa9iSli+sbP1kmzgAEkMZToNIHWlebZaCgHJofV52gRB8AZxpRixcLUjXFQF/uysUQRmxBrKzRJZZ4MdB69GDH06lvGyUgAZw9qwLdUfHDtoDsOfu3iGPIqY+DNHmiU1SppApb8XsdEeVKNJlD2yNpxFKHyHhl49Fd6rOBeXPkLY+yPi7stiM6IfukfQuLCDFVm5q50Lxu77pTDAGeWkIyteGUiaM7u696An4Q9NXASIDW9Hzh+ZroSG2LOH3zqygF4OiFy4FPeQckhKDI387mH0UergETD5A5NvnJBTDqfpIl12lSuJqnX0EuhpjaTFVEbQyL54V5Z0rIwdUDtInRJu4nTE9fRz3jNsuZMoNA85h7ZF0oupvIrEEPq1K01mOqjtz242pWoT0lCVkT2XjyN+ds1ohKWtYlbruOpC3McleNF9G9RxfkUBasRNgobDW5N7bN1qzv/XS0pyVHeOQGrqPLIkmtTeQRivw84PItVZb8mm5TZykKZ4rrw1F4FW+0/Q14vCTe4QnnsTknWoQVaXD1P95f7TN3CnMKF/tOLMv+ZGN3KSDbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(23010399003)(11063799006)(56012099006)(5023799004)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2JRNzRxUGIzRUpLODJrQk1pU0xBOGtxYndMbnp2Rmd6U3hTa0pTbzdJdEQr?=
 =?utf-8?B?d3pNcGZ4ZlZaTUdEcjdLRFFod0VGWDBOOHhZejh5THdqUnh0aThnSjJXUHBC?=
 =?utf-8?B?U2VVcms2M2hFTlYzcThsL0x0UDdYa085VXNpRzMyRTRTUlFnNDZqNGpRUENo?=
 =?utf-8?B?VkU1N3B0Y29YbGVOREpSVDMxd2orRkphUnNvUFN3QmUvWkpyaERpTTg5Vzhh?=
 =?utf-8?B?QTVFWHBGRXExcGpLR3pNMGhPczVJZWVhbTgybmpiSks2bDUzaVFNb2hUa1lM?=
 =?utf-8?B?cnhzb0Z3eHByL2JhN1IzOCt5OVNtZWcrdVlHYThST0tITHF1RHhJRFJRL3dw?=
 =?utf-8?B?aUZZeXRqTE5XaXdWSEc5bThweUxFVDI0VFRsa0xRaEJqOVBkWnVMbitncjF4?=
 =?utf-8?B?bHFkdDRXcUVVWFNndFd3YXNQdmphT05va0FqZkZBbDhyU01naEUyMlJmM1dO?=
 =?utf-8?B?L1M1d280czdWOStmS3Z3ZllMQmxaRXMvekx1YTVZQ3JQSE16aXBKNE1ERkpr?=
 =?utf-8?B?U2htdDM2dE1BTVZYNlVMYnl5anoySHpRWEJMRkc4Z1lPMEIwcXg0S3Z4SHlS?=
 =?utf-8?B?cHNVd2svTFVXRUNxWGNTdnNoUTRsWXRrTDZrUHJaSFdZM0pHQTY4WjhaQnFF?=
 =?utf-8?B?QU1sdVB0VTh6US94NnZnVGNmWWN2MWliNm1PNGdwS0MxbVRFRjNrYkFkTzRQ?=
 =?utf-8?B?WXVETTJ0bXdRSVZTcW9jcU1XbXVRaHV4RFpKanBhOHVxWUhDcUdkR2lpSTZD?=
 =?utf-8?B?MFBGcUFMTVkwS2ZWN3NxcHZIRytLN2NLa1hnTVBNZjZhV1JxeitrZENXUVh5?=
 =?utf-8?B?SkFGZXFOcjFmUUIvWlcvSyt1NjFCekg1c21FQWdDQi9ZWTNJMkg1Y1A5N0Zu?=
 =?utf-8?B?bUViUUNQN1ZkSjRKSnl4ck52TEk0bGJXbUk3NThmbmZFQlZYZXpoZUV2WU96?=
 =?utf-8?B?RGJyODFzQXEvbDA2bkc2b3hsc0JjNHgzcXVCVkFvV2FWSDdOTzN0em9MVzAy?=
 =?utf-8?B?V2FFL3dxZGVrOFZZUFVLcTM3OXV2SDAxV3U1RkM0Q0kzVmxSZkJCdy9iZFZV?=
 =?utf-8?B?MGp2WFNFdFY1aDBqK1laMnlLK0RUaUhUa3dpSDl5ZHYwVVRTNXAyZHRzT0pv?=
 =?utf-8?B?eXkxWWkxREJwa1o3YlJoRFpkano0cTZkSTRpU2dQRXF6S2VFM2swRWxpR3Zy?=
 =?utf-8?B?R2Q0cm9sUEQzcmQ4RWtUdysxOHNuR1lSR1J5Wi8vNWFDL0VKYmZLandJTFlO?=
 =?utf-8?B?eHNuQmVzTk93NDF3UWN2TmxGT05qb2ZKcktTV3hTbUFqOFJGbHp0MWZpOE5C?=
 =?utf-8?B?QUpYVWhXdnFMM2hoZHdBVGVXa0phNTZiRDc4OTR2dTVobVpickJ5cGxjZUYr?=
 =?utf-8?B?UGNZUi95TTdlQnc0NTJqMlVoa0R0YVhKK3cyL0lmYnBuR3h1S01aM2YrNXh4?=
 =?utf-8?B?SDVCTWJZV1B2YXo2aXBQY2xFejF4a3lLL2V1SHVsekhvUjVObis0SjM4Ris3?=
 =?utf-8?B?NENLaTRIc2dQMWxDVlRxMFlnbWJuMU5kMUN4eGJvUXkrZDR6R1gzOWY2NnhC?=
 =?utf-8?B?VWx4RkIxSVlYS3pxZFpSK1Npcms1bEVXWDViTG5kTlBHOElYVUZtYXFBUyth?=
 =?utf-8?B?SlB6N2V6Q05yNGJzK240K3BvdkNmYnNmTU5tZGFMUkpVb2YzU05nRlVabjMw?=
 =?utf-8?B?RGhXNnJrQk5XNFFtQWh0dWJLNHJMT3k2NXhaNnMzYzNYTVdlWktIaTl1UmRm?=
 =?utf-8?B?YjY1WGxhVTRsd01XdmEyQ0R6eEcralB4S0tDYnZWZjZGUkNON2dod1VFU1lE?=
 =?utf-8?B?QUd2b1BISnYrUmg4TjliTHBSTXFGMTdVMXhqeHdram5kWjZwclZmNmtPVzhs?=
 =?utf-8?B?N2M5bkJHU09nUVNyYXo5WEhFTDhlT2xJck1PMWd6aUJ6aU9hbGZYUml5VUox?=
 =?utf-8?B?ZjFQT0RHOUVDRi94WjJ3UlB1QVphZnV5RlZtakJoeXR4dW91U25ybS92R2Iy?=
 =?utf-8?B?aXFPVXNzOWk2Q293ZG1sa1g1d3h1Wm01TEZOUDZpRzRxdGVsbWg0Z25SZ1FL?=
 =?utf-8?B?eklkSUdqLzJMYnJyZmtDT1BHTHVwZjUvWWJjZ2pYOXNFaWlxVzdpZHNmeGU1?=
 =?utf-8?B?Q2J3c1FPNTF3OG1mU1ErKytPQk5QdGI0MnJRQm1NTTUyZ2tjWkxqRUhxTCtW?=
 =?utf-8?B?T3RhbVY3YXhxYlg1SC9hTUFNaEd1SE1tZTdxV2JtdXNMOUNyM3ExTW1zL2NO?=
 =?utf-8?B?K09XaDBNRXd0b09aZ2Rmc25NUVUrQXF6NFZxaG9lTHpzVzZOYnBJSmYyNDlJ?=
 =?utf-8?B?UFRxV1cvVEU1ZFNJdHpkb1h6S0c3RXJQaklzSGFUM1pSbkN0Q0dIbXhhV2E1?=
 =?utf-8?Q?Xer7xwT6y7W9+mVxavGgxze8IGdp71qsO7X5cJxhW2k4F?=
X-MS-Exchange-AntiSpam-MessageData-1: 3F1CuVEbT/MoAA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd1d5e1-9c65-4575-ccf1-08dee94e28ea
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:38:23.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrS9mOKpN5a5yNbU3T+q+scqwedc1ju1FxzCTzoxGjQWKg4AfgUtFBTjB3LEJsow+Fb7TRrfQqSD+MOt2qKPGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

nit: the base-commit trailer points to a commit that only exists in
linux-next (next-20260720) and is not easily discoverable - it would
help if you could mention the base in human-resolvable form in the cover
letter.

On Wed Jul 22, 2026 at 1:54 AM JST, Gary Guo wrote:
> Currently registers work for all untyped I/O regions, which is not ideal.
> It allows registers defined for device A to work for another device B and
> there is no safeguarding at all.

This doesn't sound like a real concern. Registers are typically local to
a driver, so one cannot use registers for device A on device B even now.
And within the same crate registers can be isolated by module if needed.

Even if we restrict the base type, the examples given in this patch only
partially address the issue: registers from different drivers using
regions of identical sizes could be used interchangeably without
complaint.

So I don't think this patchset addresses this particular problem, for
which namespace isolation is the correct solution anyway.

>
> All users of the `register!` macro know what type it will be operating on=
,
> and that type is consistent across the driver. Therefore, add a `base`
> parameter to `register!`.
>
> Currently this parameter is unused in the generated code; it will be used
> when all users of `register!` is converted to gain the parameter.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs          |  4 +++
>  rust/kernel/io/register.rs | 79 ++++++++++++++++++++++++++++++++++++++++=
++----
>  2 files changed, 76 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 95f46bb75f9e..c5f07c38e59e 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -883,6 +883,8 @@ fn try_write<T, L>(self, location: L, value: T) -> Re=
sult
>      /// };
>      ///
>      /// register! {
> +    ///     base: Region;
> +    ///
>      ///     VERSION(u32) @ 0x100 {
>      ///         15:8 major;
>      ///         7:0  minor;
> @@ -1028,6 +1030,8 @@ fn write<T, L>(self, location: L, value: T)
>      /// };
>      ///
>      /// register! {
> +    ///     base: Region<0x1000>;

I'd prefer if we could limit the `base:` parameter to registers defined
against a specific block (like the current relative registers). Having
it on all register definitions adds an artificial limitation (that e.g.
regions must be of a given size, which may not suit drivers that support
several generations of hardware with varying BAR sizes).

Top-level registers are currently working fine without this, so it
doesn't seem justified except by the safeguarding argument, which I
don't think is relevant here.

The syntax (specifying `base:` only once at the top of a register block)
is a great improvement over the current one; if I were to pursue my own
fixup series I would definitely have adopted it.

Still going through the series in detail but wanted to raise this point
first. Overall I think I like the direction, it makes the falcon
register accesses read much more naturally.
