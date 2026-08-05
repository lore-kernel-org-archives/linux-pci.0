Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022140.outbound.protection.outlook.com [52.101.96.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD5363094
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949541; cv=fail; b=fh4dstAfoVasEK4edV4ERS53dAQgeodzTRl4Uc1OW8lTJ2zNzqyBpUpWuFjdpjxJCEPXkEhd/pphjvVs850rTdXWGwcjXIoOHMEUMXgEWYlDiJ3gFawd2glRAcC/JuI9YZPJITgV0x87PcWaKhWsDI+D4RNAm/IPySi6Y2iC7Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949541; c=relaxed/simple;
	bh=VMRFHYLIjphyOc7mwGIFmL7HUiw5O9CU0U9fp/DWSWQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VDmdhy0G02Y9YUuW59dmdAP75rPDjER+otFZypYfY1IzJWEgXzMRCYlbAdF2RmKPkIPbWfEMSTkUYCDenkTZ05t/Z3nKyc11DCVuSy/D7TAvwOkr9gBfVCTlOa7OeaRJRUV1tB32zsgBLnC8M/PmIOoFIkzxl4xXOp22aPYNj2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FItXcexz; arc=fail smtp.client-ip=52.101.96.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FItXcexz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM1onhiK3fL5QfHRzISnoLLfjfakailvJt7XBBhNMWTvC/JzdLz6FOUm+jWU2VXL6ANjXjRgJMzkysAXm1f36d9qxMAec6uzfbjbYv2TRDhTKE8v8MX+ONsnkwKpw9/wYJffmoai/wlGkFXBiD97xhDo1516fpU+hkPT4GnTyfV4r/6wERCCo6LOb67dgsWE9w4XQoCikAgRBuuLJ0VV/qjoX/GWiyvtRS/TDdEwftdsIqQt+yxTu5ewrC+i1YxhDoxFPvxZbYS6bBSnfhxu7cMHYKebyrR5EocdepOKBeLrlETimDgUUTSxDil7or99WPlvHvAZQaTwygUiCnmN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zecMo195vCvXeznk3I1l7++ccgV7UJyYgTMbS5esC/I=;
 b=wwXfcJfqs6PD18dY4O2F3YW1bRCjKD4aMADGJEH8Y/jdeWo7j21u6gTvLahqlRgN6XY7ftPYv+uI8WgXT15+cryYlWyWoj8dUPp1erWZFRVzifg9VvBVwiP3wD2nO9JEPKQTYbHAhGhiAqF8mim9LOE60B63iJ4x0egkkZFcShvIhlIVKfD7mG/7q3TajY48VYSLBR0K+VeBGCC7ExeA5TmG6vKumFBtm812EmvHAIEMQOUC/l4RiucrqLvEeytKYKIOLB1G6MAHUwzsoV+n22Gf8fhDtSb2jD2vBRFftO0zuaK1RiWq7rhk62cxmPz4JBmYOOzVGe2Bf7fIjVhffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zecMo195vCvXeznk3I1l7++ccgV7UJyYgTMbS5esC/I=;
 b=FItXcexz3orq57oWADBDk3t9FlB8GM/YL8Z/GNzupCMH1etj0KVtZa+2mvT++cyNLNcIaBmqYPmwvtTzMDIg1S8OOj1xdsns+8anJbu1Pftc5R+GAHViwqK1cVMQoViV1bIbP7OS/ItbY0YGzMBCMwrNjGI7iqYyjky12KvRhwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CWXP265MB2133.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 17:05:35 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 17:05:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 18:05:35 +0100
Message-Id: <DKH69TWL1U4Q.2LS506JVSYR8K@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <ojeda@kernel.org>, <dri-devel@lists.freedesktop.org>, "Danilo Krummrich"
 <dakr@kernel.org>
Subject: Re: [PATCH v2 11/16] rust: io: register: support fixed offset
 register without bitfield
From: "Gary Guo" <gary@garyguo.net>
To: <sashiko-reviews@lists.linux.dev>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-11-c3ca142220a0@garyguo.net>
 <20260805165043.0F7161F000E9@smtp.kernel.org>
In-Reply-To: <20260805165043.0F7161F000E9@smtp.kernel.org>
X-ClientProxiedBy: LO4P123CA0092.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::7) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CWXP265MB2133:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a89d9ed-4f96-40ca-0875-08def313c42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|366016|1800799024|6133799003|10067099003|5023799004|56012099006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	XE/fWCmgXlD/hkQz7R/Dq+ZzrQsRU5d/W6TMt7+8F6GDXvdOMIkNMO6eAi96MaMyTSc68ATEvOpBsQTw5pZ6l4oGypDyHJy03bfW815ddQAS0stPnVr0uXMjl4M4R07+FzhPKHgZ9ScyhMHj1aN7IoKncPU5goYjiKSzk7pg7Sr6f4k4AmgBAfbSEsrKSoWppcK3AI2mB+SCjwy/oFatIDj9nKKe9DVlDPen8Lm5rDKl8dTn+UCoXAN4XPBsdc70f4O9wgaw89cUgmlZaGK8xWmjVKOORKxMroUJ9HdqnCASKlOSZ/EKXyoBY8yhS95A1dz8sSkdfnFRwYp9GY3W5hBXkS1YReZrZQB2jB7Ee6SMz3+55t7AX6BekR/zBrvwBnW3IJ+ao8hdvzhrd+5yBfozDIG8tejETa4Y8o6p5aDE+3oC5dXMlRmJSgLPy3OPZ75afkXOkExEyP+7fYwye1DbKjZgjG9Cfw57Wa7Y0qvJ+XAOXmgBL8MpnWBxaIwjuc2MqQAHuo6H2ifFFloG3ZU+lzMxSayLMLxCqU1fW1TXWrbeUe4Oyzem4a2oFCGEqXzkdIT7BQaP+gMuuf8koTnQjT5PMCWAnZVTCbP1Erb3wSMHaaVOVi/dX7RJEpPIldP1QxS6Q0zlyZoT2zJAZk79AeREhb8xqiO9Kqr5GqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(1800799024)(6133799003)(10067099003)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0Y3NkdMK0Rub09OWElvc0lDU2h0L1RnOThmS3kzdlg4UUQwcHdCT1ZabGVB?=
 =?utf-8?B?ZExTNnlkWG8wZ21LOXVDa2lKUDFBQ3FuSXU4aXVOSHNjeXFuYU5iN2xGNzRW?=
 =?utf-8?B?Mnl2dGNOR0I1cnEvaE5ZS3E2Q0EzQWhXa3FTeVFOM1JWZUI0akxyaVUwdjFH?=
 =?utf-8?B?aVpZZkR6aGRlZ0gyTUhLbFlrU3RZeFllL29sR3YyRm05RGtNWjljQ0NYWlNr?=
 =?utf-8?B?VnMwRXVMUytpUFA2S1ZoN0xhdWp1WU9rOHNQVWQxVUpPRXRDMjZFa0VXMnc4?=
 =?utf-8?B?RjU1aTZPdVlDOVFNazZWQituNnF3QXJSNnNUU29SZEhwckk2QlpyWnR4eVov?=
 =?utf-8?B?M1dPaWNHTkdNdW1LeEY4aEtnM0Y5STl2cE1rVlZoZU5zd1RJMFZFdkJ2OVpX?=
 =?utf-8?B?QzUyOEhZd09Zalc4NTd1TU1BYlgvbDN4ZlUyeGYzTmFWb2tmRnlzTFhDZEVy?=
 =?utf-8?B?dUQ2cEk4VjFJRGFabnVOck9aUHE4N3VQdTRkK0laL0FXMzZSRm5qKzNsdmRM?=
 =?utf-8?B?MmZGM0V5Mjh0WVVBQTdhcXdHTHZMTGtoMTVVYmRKL3JYSk5KWGFKcm5HOVBR?=
 =?utf-8?B?TkZTUUowNm1uSkI4aEdIa3NHbHJTREM3WjNmTnI1cERqN1NGdjRyZHVOZGlI?=
 =?utf-8?B?MjdqaXBBbXJDU3FHVHovK0tHWXRrOVZQNEtCa3NHOFI4OXN3UkZGZ3ZsQkgv?=
 =?utf-8?B?Njh4eW1CeDVZZVd4aDlpUnlWSy9JMmdoSXh2M3E1d3NsbVk4QnhvSGplTTRR?=
 =?utf-8?B?eWMraG9MS3VYdEJkTktiY0VpV1BLNlV3Zm5vTFJvUEhxRWtWKytDOW5UNWsr?=
 =?utf-8?B?MHE0c281bWlGdFhoTERuOFlsRnhTdW9wdndhWnFyejRxR1ZhQlgrZzhyL0VJ?=
 =?utf-8?B?Wko0MFNMSmF0WjNnZ3RRbDZaZUxEeXdrU09TcndNKzN2eDZlL0hNS0Vndy9o?=
 =?utf-8?B?NDRyS1B0Mk1LVjlCV0FrTUMzRU1GUFJVQmFoYUF6UzlUMjAvK3E1d3graVNy?=
 =?utf-8?B?WUtDZVA1czFlaTRxdll3MWxhcDJ4ZVBWdURJUThCVXBzMGNOSnNIbEJieUxw?=
 =?utf-8?B?a1VqUDlmR3llMmlEK25TV0t3dTI3SGo0d2pSR0E2NWxVbXhtSGtUYlRGQlBr?=
 =?utf-8?B?eDYrVE5WMTlLS3IxRnJHWEM4QUlwZkxKWTJaelU0Q29ZU3ZjUkVmMXRoZ1JD?=
 =?utf-8?B?MmozQ1RpOEd2RUx6Mm1YdmNlOVI1TWYyOVdjcERxRW1tYlZlUklHWjJLL1pE?=
 =?utf-8?B?WXgreDVUamNjZlVoOGpnV296ZzlXa1N2LzVpaE5sWmtRK0ZySTZ6ckFXclVY?=
 =?utf-8?B?U0c4QitIWi92RnZoRktLbzFrd0Q3SS83UHgxV1czVEowcHJEL2w4cHpldkpX?=
 =?utf-8?B?VVhFVkt1MjZURmhaWGh6bkNGbUMwWW1kOTJGcEtBSEg0ekJLVy8zK0czWmds?=
 =?utf-8?B?MTloOWY4V1ZUQWdiYlArWEtLaVZadFNzVEZLWWxDMmZqNW84Zkl1M2puWXFF?=
 =?utf-8?B?STdiZFhLMVQyMVQzODA3eFNBWjVVejlHUkNjTFdaVkZKTTN2K2s3b1hBTVlh?=
 =?utf-8?B?NndTdmFGQjE0T1NRdUN4UXg4UW5ySjlkVjV6d0dIN21iaHV5MUwyd2hKMVBS?=
 =?utf-8?B?NS9wcmdGeDFaVVdrVjg5WDh4TXNGMkkrKythWVNsajdxVWh6WmNHYUliNTVk?=
 =?utf-8?B?d3hGM3ZESVFId0JhclZwcm9VMHNDaWFTV3kreWpPbWNXcm04aVM0aHdmb2lE?=
 =?utf-8?B?dUVqMTFUdURmaDdJODhLOHV6Qmo5bXVVSWZldWFBa3RKc2p6TVNNK1R1MXo5?=
 =?utf-8?B?MktYNndhODRWbGV3NHVkcHZuamZvWkVnU0hWUXZ1UWhVN1pBYzg0VW5qVW1H?=
 =?utf-8?B?OGpFdWtaR2ZmSVBQM210R0dyY3ZrSjcybWVlUlg5bWIvNWdjVmNQcHRGcDBm?=
 =?utf-8?B?WXpjdm5ZekEzVFpySjJyVTA3a212UHQ5cXAwMUE2OEZTWmR6WmxmbUlKM3Nx?=
 =?utf-8?B?WndRbEQ0ZlVRTFlCRjd2dG1VU1crRDhjbUN2RUg4R3gzb2Z6WVYxMzJuYlJ2?=
 =?utf-8?B?alJYSlMrT1Zucm1NcHFzUVp1UlBCU1lKb3JyTmhMNDZBb3IzbkFqTk11cWY1?=
 =?utf-8?B?VWk0eTVyZGUxR2NITXAySlF2TVl5bWxXN0lPZ3Q0L2lmd3pBRG15SGNjUDFC?=
 =?utf-8?B?MUc1NElEMGF2aVphNUhFcE5yb2ZiZDJ2K0lITmg4bFdNaE11RmpRR0RDNEQ0?=
 =?utf-8?B?dThvUHBDQTFRV250NlVPSXpQS1NqcDQveVEyQ2tJb0RHeU0yTFBIZmFVZ0JM?=
 =?utf-8?B?QkRQd3FJd044R1ovOGJ5aDVhdVR6Q3poM0dlbWpoYjF5c01PLzhEdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a89d9ed-4f96-40ca-0875-08def313c42d
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 17:05:35.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grrxf6/Nxf5HrkD0S00Z71yGR8y/wNzdAK8MfBNKB3CghpKs3OybK0exBJtF472ktqou5TdIyLfMtjRc3PX4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2133

On Wed Aug 5, 2026 at 5:50 PM BST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The `register!` macro documentation provides an example defining =
a FIFO register (`TX_FIFO`) with a `u32` type. This violates the subsystem =
guidelines which mandate that FIFOs must use stream accessors (no byteswapp=
ing). Using a `u32` register type implies standard register access (e.g., `=
writel`), which will byteswap on big-endian architectures and corrupt strea=
m data. Additionally, the macro's syntax rule `$ty: ident $(:: $path_frag:i=
dent)*` restricts the type to paths, preventing developers from directly sp=
ecifying a byte array (e.g., `[u8; 4]`) as the type to properly model a byt=
eswap-free stream.
> --
>
> --- Patch [11]: [PATCH v2 11/16] rust: io: register: support fixed offset=
 register without bitfield ---
> commit a13a899311e93c249f5925eff4ce304f82a4cb69
> Author: Gary Guo <gary@garyguo.net>
>
> rust: io: register: support fixed offset register without bitfield
>
> Add a rule to allow creating `IoLoc` in `regiser!()` using an existing ty=
pe
> and not create a bitfield. Add an example to demonstrate this for FIFO
> registers.
>
>> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
>> index dc800fc711722..49a61da106c7d 100644
>> --- a/rust/kernel/io/register.rs
>> +++ b/rust/kernel/io/register.rs
>
> [ ... ]
>
>> @@ -499,6 +516,19 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
>>  /// In this example, `SCRATCH_BOOT_STATUS` uses the same I/O address as=
 `SCRATCH`, while providing
>>  /// its own `completed` field.
>>  ///
>> +/// If you do not wish to have a bitfield defined, you can also create =
a register using an existing
>> +/// type.
>> +///
>> +/// ```no_run
>> +/// # use kernel::io::*;
>> +/// register! {
>> +///     base: Region<0x1000>;
>> +///
>> +///     /// TX FIFO register.
>> +///     pub TX_FIFO: u32 @ 0x00001000;
>
> [Severity: Low]
> Does this example promote an anti-pattern for FIFO access?
>
> Using u32 for a FIFO implies standard register I/O accessors (like writel=
 or
> readl), which will perform byte-swapping on big-endian architectures.
> According to the I/O accessor subsystem guidelines, FIFOs should use stre=
am
> accessors without byteswapping to prevent data corruption.

Sashiko is misunderstanding the use case here, this is for intent here is f=
or
PIO FIFO where you read one word as a time for a fixed location, not stream=
ing
(otherwise the signature here would be `pub TX_FIFO: [u32; FIFO_SIZE] @ ...=
`).

I'll see if I can have a better example in the next version. Perhaps

    pub UART_RX: u8 @ ...;

?

Best,
Gary

>
> Would it be better to avoid using a FIFO as the example here, or use a ty=
pe
> that enforces stream semantics?
>
>> +/// }
>> +/// ```
>> +///
>>  /// ## Relative registers
>
> [ ... ]
>
>> @@ -826,6 +856,23 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
>>  macro_rules! register {
>>      (base: $reg_base:ty;) =3D> {};
>> =20
>> +    // Creates a register at a fixed offset of the MMIO space with prov=
ided type.
>> +    (
>> +        base: $reg_base:ty;
>> +        // `$ty` cannot be `:ty` due to follow-set restrictions.
>> +        $(#[$attr:meta])* $vis:vis $name:ident: $ty: ident $(:: $path_f=
rag:ident)*
>
> [Severity: Low]
> Does this macro rule prevent developers from specifying inline byte array=
s
> (like [u8; 4]) as the register type?
>
> Since the type matcher is restricted to identifiers and paths, it seems
> developers wouldn't be able to directly define a byte array to properly m=
odel
> a byteswap-free stream without defining a separate type alias first.
>
> Could this be adjusted to support array syntax, or is the limitation stri=
ct
> enough to require type aliases for stream buffers?
>
>> +            $(@ $offset:literal)?
>> +            $(=3D> $alias:path $([$alias_idx:expr])? )?;
>> +        $($rest:tt)*
>> +    ) =3D> {


