Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020105.outbound.protection.outlook.com [52.101.195.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C8488DAD;
	Tue,  1 Sep 2026 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281452; cv=fail; b=dCN2IGt7bUOMWv/Leqe8ejJLF16ZLn02o5gh9XHZzG9aTjHCRuOoiKrwsmlhZV4M/Ke+bvaCZzew+53MbDvaRaJ8uMAo+05qJAt+2OMKPgReDDx32Xq6LtBQR14+U7oR4bHN3Sipch7ppJI4IcRk6it0QkZhQRJbCXz16PPGwwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281452; c=relaxed/simple;
	bh=LRCzTRbElfNXpnbN07JbS4qKUWYbLxu7w8UpJPZal0Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jhDdc7yP+wtsBPIX/Q5tmII2p17owkeroGWwxxgL07wkM5enXbI1cCyhepsHlvqZY3K5bFx5hPCbC3e1z7XORXFJy/5OgIFqHertvTpkXafrCihO5r9GqgZP0+RtG8taHS5arpNoFu5QgHpUu8LTVYfFahAnknLUQ/Pn4/sdRBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CaoG77Z1; arc=fail smtp.client-ip=52.101.195.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CaoG77Z1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOcu4EsESSMwRqqlrl5VvIDCKhWnhPrMKacCA4ScrgzVWiBLqI7gIhtGX6nghQxxQ+OK2QL/e/T6bNM0o3G8rBeUtJISOP3xUJNmldbLQOidEkRk7YetGrB8Euse7m3ebU4k3JUe//CNvnbuLxCpVDVQ7KcUdfEOUqjCB4II+i133mvUi63Xj4d79rUhgyU+KbYTZNGjgenbSD62W8wM6flyGQcI9zCmxdCnHrD7VwTM2iGnpvdWeKk/CA5kxnTg36QTj6ie8BZ/ZAKfWMJVoKvihry1o/aC6E5x2Xzqpn64JD+1kRERlXAiU4cE8oliw53mfcyT4MOz1X8Ff01nUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Otepd9WSVL3uV6K+l1r6wDSj3LCIZLja4n6PbCqf+f4=;
 b=ToLMSgEPU45odr7si0zpW5V+1v8sKxJLj4ESbYwUtp9P+4UzOYj8M224mLkLHKd9SagZahBI+p7W+/5xyvkcDXrDNSHPEZXAOFIKSoFEUNjlzbFBWN/kE//7sRnL0Y70KNP2ak0NdnRhqO/gHe3N5oyuc0yQqbKVlM6S4pMj7qhdwVQCqge9E50ryVBHNlEuUZeWtU40CRCiAEBxGp2Cf+5ljLMzwR5ZtGeVCRzi7aYk30633rkf05X2bNU4Rdc4lgsoddR2PqtJblpfdcR/sKo48TcxrQ962sy5K/BK5OXO31J58HnKdWkScpU09RzzF1HzsG81jOXL1LBGiN22Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Otepd9WSVL3uV6K+l1r6wDSj3LCIZLja4n6PbCqf+f4=;
 b=CaoG77Z1kJsTRuakOZrjK9yVsjCePgSe/DzzGdPUg68qQxSjo002G8bDIyfn4OpBOh2XIJxE4JxPGZmWGlspgaZiPpxLo8HfS6ZZI4TuGeQ39wsPKogvNZkJFj4Sr5OTDaFM3zVcpGwmCmqghc6j4Y5IgEMS7WwS+w6R66wyUfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:41 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:41 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:34 +0100
Subject: [PATCH v4 10/16] rust: io: register: make register have a typed
 base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-10-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=9843;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=LRCzTRbElfNXpnbN07JbS4qKUWYbLxu7w8UpJPZal0Q=;
 b=xJyvWtgl0OkNJs1eY0dYkJVr690tyL9fuZI5Gug5T+oBAFqHKj8gYSB0l9kEq6oHXr1r69LTN
 /xhWEdsgz15Aoh7dClWo/TuPMzrEKqZiHUSJVFxKjIK56BneZ0aGzxl
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: PAZP264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c34f4a6-f2dc-41a9-bcb1-08df0849285d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4Vs4oaYBWCmXcOZn012tq7eVQOUvG8VbkGTV/IB0yRBKJ1+LheJS+MEoBqJTjAQiQ0cGRR3ds9n56bgp25O98XjLoIji7z1pqf4txeiPZ1c06SHz34IXDPAmvc45+YtDrxHbk6LhIPOClA15pzXnXGUw3Zy8tMjf6vW3MbtloYRlsp8f3ddBG6t6ezWU+T68ZjtkLQHESt1AIVaRVJXOI7iLbDo88a6jOeRi6Qir5lJ8FMSQPgOfB1/mycT1dcvhJ6zOD5zokGCY/J07mI7g/RjZKUARCdNKnlGMpEr1WILX0koabkaWqgXHbzP6dHaX08Mo1Eqdv8aF8cP5kkZW7Jl59y4GjeBJDeMzRa1ctfrbnZxhxcDwEWrgyfiOohjxvuI9k/H9rNNpBUbu99oWASQwAwsnA24LgnvykD+1qJX+0WdyZVzkD/K3InqUfd0zBWu5qYItVxWVp1pl458ZjtmMndrBoiZpEWv1uEbws7EOX9toLJQnUtK/hZu/VVb2SQisCcp6lQoN5bA+nI95qQW6Oy+1wHZWFylkaFqpWSkNXXW57mO2/vSfFmnJJOExZIWFCALVVUZjQflrCKu7Oq2BMhKo3taK8bi4BheakdEvO/TYBMvGBFtErW1K2WrdpHO0jpD2YE5Kf8ZQwwrH++iYtjzxJ64wvZfzyukd6u2ILenmXckEiI9TZiapueDD49VOLdobs3gdDvxqq+UxcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm0ybHA0WXNkeEFnSHZuNkxtVGdzalROaGxpSlhQQXJ1V0RWTVVaT0xURnBp?=
 =?utf-8?B?SFpyK3l0amtyaHRoYU9WbzNFYWdZckgyN1l4elJlNU1hZlFMNUJUS200aUdM?=
 =?utf-8?B?ZFFFUGg2UmZoY3YzNm5UaC9zU3VqUVF1YStmaHV2T2hGa0p6R0FVQUU0LzlZ?=
 =?utf-8?B?cTFlQlBhazNUUldkeHR0U1dheFhUME83dG94UTltZFpST1ljYjdnZ3UydHRS?=
 =?utf-8?B?WXNNTDRuTU1YYjd5SlZQaG9KS0xQQnlRU2V4Y2lHQVBzREN6eUQ0bytsdzZQ?=
 =?utf-8?B?SGdwT1haWVBTK2VJVUxVT0pVQjhCMlVNdmNWRis4c0Z6ZytYbkVWOXM2NmUx?=
 =?utf-8?B?T252WloxZUgyUGM0UnlpSEFucU8rRENsRVJHaVNwdFlsWDl1a0JqSkFWdFAr?=
 =?utf-8?B?U1RBOE1MTC95TFFad0JHaVM5NEdFY0ZmUWQwNWM4VVNROGtUajlhWVc4VEZE?=
 =?utf-8?B?ZUIvek9rYVNXTUdRUkh1aU9nNGNRRHJVY1NjUUpQeEQ3MG9HbUxhSGNZQmZH?=
 =?utf-8?B?M1hybVJ6YUtPTXJKaFJaZCtUL2xTMnpoQVBRaTR3dzI5WEg0Y3JNM0x3REtv?=
 =?utf-8?B?S2ZGcVJ5MzAzZW5ucmNPc3VvMTZEcUNpb0FHWFVZVVViZWtTcFl2NXJ3eWlD?=
 =?utf-8?B?dlVSY2RnZlVhVkRlQmdyZUQ5dUUzRDFIdGdwc0xlZ0NOZ29STWMxbG5WYVRK?=
 =?utf-8?B?THZHM0JKRTFJd3E5SG0yQXFsRC84ZVMyMXdNUWkybHdocUd6OWV6cndRNkNu?=
 =?utf-8?B?cVJJRzNTU2hPZUh0VTBRb3ZUcHQ4cDZNLzFYV3NyOTVvNWFhM0FoYmQwSnN1?=
 =?utf-8?B?L2ZyZDBaTFhLNTczblpXLy9nMG5XM3JyQzJ5R1pNRitzU0pRYXBHSFd5NXQw?=
 =?utf-8?B?SkZob3QwdVBWdXh4MVdydFdPR0xhV2NENytrcUtiTjdjeUIySUttb0RjNUR0?=
 =?utf-8?B?ajN2UlRMSkdrYXpsTnc4UEdxS08raVpHVkpyaFA2ZXRtNGUyT0tjdkxqVHov?=
 =?utf-8?B?N0VvSFA0cEgyZXN5S3JjTHFOYzNKNUtkL2VCTHd6bno5S2psREZYaDlhcE1S?=
 =?utf-8?B?T01GRFJmbENuN1c2WnpxS0plUE1VOTRDbkRlMkx0NWg0c2pZcEZTQ2tYUnhM?=
 =?utf-8?B?eUxpbnY2WDdiTms5TUFkUzdVcnI0Y2dCR2JSQ2hFWGtzKzZ6amorQU5aKzJV?=
 =?utf-8?B?NE1UeStwNzA1V1N3N1VFcHVnRDlFVnVuV2RNZGhmVTEzSjJFWkc4eVFWS1Nx?=
 =?utf-8?B?clpXOURkSG83bmRJbGpiQmtDRXVXcGN0WmF1QUlKcFl5b0ZQazRVcnRJYTdK?=
 =?utf-8?B?bERlcWFwQ3A1NXNnUnZhU3RSMHV0NzdIdmhzaEdiVmZOc050K1FMa0FGZ0ZW?=
 =?utf-8?B?UDlTOGZhaEh6Z3BPSUczUWNpUzNaT0VhVnhYbjBSMDZZU0RxN1lMMW1WOUZJ?=
 =?utf-8?B?T3QxSTl4eDdNTXQvZmtpVkdscHIrb3hNTXk5UUw0TEtva3lXTnZqZlhQcUVE?=
 =?utf-8?B?OENrMzJnVkh4LzNFeUcxMU5yNTRYUFRzWFpDT0NNdWx4cFBNZ2kxTHBBeVlE?=
 =?utf-8?B?ZmpTVGVZRFdrcHJkU01WUk4ySGdCa0VkeDJrWHB4a05HVCs2RGpQeU5PKzBI?=
 =?utf-8?B?ZTN6cVlWRkZYVjY5cFhBSXYzcTEzaVgwc0ZyMW9INkMybElLL08vQVNOUmJS?=
 =?utf-8?B?QzExZnFMMFFYQ0VSdXczT2kwbDFWelNFMzZibkJWVGhxcjZ5NzdiZkFKb3BL?=
 =?utf-8?B?K0FjUGN0SVdaZWdJZy9md0VvbklLS1drd0lmcGhhRUwwbmFFS1owbTNNL25I?=
 =?utf-8?B?cDhaNTJYQ3hZQkpKYnVWd1YzUUxiZGlUTGZoNU1IbDdUR2xtMS9WNmRpYWI2?=
 =?utf-8?B?WWZkWng2TTdWMnBKVm9EcXJ6cEFxV1EzWENIRjE0QmRoT0hzcnBab1dGbkFT?=
 =?utf-8?B?Z0NkVlBmZUNoRzVtSk9iM0xtNC9seWJRakRqR25zYXRmbjN6NFl5c0UxZEJW?=
 =?utf-8?B?QTFmKzIzS1VOc3JyYmhpa3AxQ0s0SUZkRzYvR3hsSU5TYUdEdXdoY1IrSm41?=
 =?utf-8?B?ampJMzF3Y05uMzZKc0RwM216OHNPQXM5c0Q0THRMbmtuTmxBWklKUHAydy9t?=
 =?utf-8?B?S2padENFL1paalF2Y21wWm5LN0gyaXlPcnFzRitHaWpxbzdaMUtDMU5vOXlP?=
 =?utf-8?B?Y09pSXhqTmZKTGVKWDJsdDAvQk5KcmdQN0NJNFJBd2JJU1hZajFxNlpjVlhX?=
 =?utf-8?B?cXp4TEt0SVp1RUM3VkNQMHVtNFEvQzVLcW9mcm9DZERwWFdSYmtCMCtjSElE?=
 =?utf-8?B?RlZab0hyeFBjYzhYbUJzU2lhNFlpNDUzVXhQMFphUHdHZHM3TmpCdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c34f4a6-f2dc-41a9-bcb1-08df0849285d
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:41.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSxIoHEEoG/seG4APmdoMyw71A2W7fMNy8I97pxHajSGBJgfVSofH9Pnd9hcVhjSK37QtFgewGnOs06Wh8MEeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

Previously `register!` defined registers can be used on any untyped I/O
regions. With all users specifying their desired register type now,
propagate the specified type and restrict I/O access only when type
matches.

Also, add an `io_project!` example which is enabled by this change.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes since v3:
- Adopted Alex's map_err suggestion
- Moved the "const eval only" comment slightly down and updated the
  build_assert to just a plain assert.
---
 rust/kernel/io.rs          | 13 +++++++++++
 rust/kernel/io/register.rs | 54 ++++++++++++++++++++++++++++++++--------------
 rust/macros/io/register.rs | 45 +++++++++++++++-----------------------
 3 files changed, 68 insertions(+), 44 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 05c7fa12fdbe..7a0e0ebc6c85 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1685,21 +1685,34 @@ pub fn project_loc<U, L>(self, location: L) -> <T::Backend as IoBackend>::View<'
 /// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that
 /// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
 ///
+/// `io_project!` can also project to a subview of registers defined with [`register!`] macro.
+/// Register projection has syntax `io_project!(io, try: REGISTER)` for fallible projection and
+/// `io_project!(io, build: REGISTER)` for infallible projection.
+///
 /// # Examples
 ///
 /// ```
 /// use kernel::io::{
 ///     io_project,
+///     register,
 ///     Mmio,
 /// };
 /// #[repr(C)]
 /// struct MyStruct { field: u32, }
 ///
+/// register! {
+///     base: MyStruct;
+///     FIELD(u32) @ 0 {
+///         31:0 val;
+///     }
+/// }
+///
 /// # fn test(mmio: Mmio<'_, [MyStruct]>) -> Result {
 /// // let mmio: Mmio<[MyStruct]>;
 /// let field: Mmio<'_, u32> = io_project!(mmio, [try: 1].field);
 /// let whole: Mmio<'_, MyStruct> = io_project!(mmio, [try: 2]);
 /// let nested: Mmio<'_, u32> = io_project!(whole, .field);
+/// let reg: Mmio<'_, FIELD> = io_project!(whole, build: FIELD);
 /// # Ok::<(), Error>(()) }
 /// ```
 #[macro_export]
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 49a5fe069e47..58dcf651dfd0 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -121,10 +121,11 @@
     io::IoLoc, //
 };
 
-use super::Region;
-
 /// Trait implemented by all registers.
 pub trait Register: Sized {
+    /// Base type for this register.
+    type Base: ?Sized;
+
     /// Start offset of the register.
     ///
     /// The interpretation of this offset depends on the type of the register.
@@ -136,9 +137,9 @@ pub trait FixedRegister: Register {}
 
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
 /// passing a [`FixedRegister`] value.
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
+impl<Base: ?Sized, T> IoLoc<Base, T> for ()
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -148,9 +149,9 @@ fn offset(self) -> usize {
 
 /// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
 /// as an [`IoLoc`].
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
+impl<Base: ?Sized, T> IoLoc<Base, T> for T
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -171,9 +172,9 @@ pub const fn new() -> Self {
     }
 }
 
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T>
+impl<Base: ?Sized, T> IoLoc<Base, T> for FixedRegisterLoc<T>
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -240,9 +241,9 @@ const fn offset(self) -> usize {
     }
 }
 
-impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterLoc<T, B>
+impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterLoc<T, B>
 where
-    T: RelativeRegister,
+    T: RelativeRegister<Base = SuperBase>,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
     #[inline(always)]
@@ -282,9 +283,9 @@ pub fn try_new(idx: usize) -> Option<Self> {
     }
 }
 
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for RegisterArrayLoc<T>
+impl<Base: ?Sized, T> IoLoc<Base, T> for RegisterArrayLoc<T>
 where
-    T: RegisterArray,
+    T: RegisterArray<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -367,9 +368,9 @@ pub fn try_at(self, idx: usize) -> Option<RelativeRegisterArrayLoc<T, B>> {
     }
 }
 
-impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterArrayLoc<T, B>
+impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterArrayLoc<T, B>
 where
-    T: RelativeRegisterArray,
+    T: RelativeRegisterArray<Base = SuperBase>,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
     #[inline(always)]
@@ -393,9 +394,9 @@ pub trait LocatedRegister<Base: ?Sized> {
     fn into_io_op(self) -> (Self::Location, Self::Value);
 }
 
-impl<const SIZE: usize, T> LocatedRegister<Region<SIZE>> for T
+impl<Base: ?Sized, T> LocatedRegister<Base> for T
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     type Location = FixedRegisterLoc<Self::Value>;
     type Value = T;
@@ -406,6 +407,27 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
     }
 }
 
+/// Helper function for register alias implementation.
+///
+/// This is used to enforce base matching.
+#[doc(hidden)]
+#[inline(always)] // for const eval only
+pub const fn alias_offset<Base: ?Sized, Alias: Register<Base = Base>>() -> usize {
+    Alias::OFFSET
+}
+
+/// Helper function for register element alias implementation.
+///
+/// This is used to enforce base matching and provide bounds checking.
+#[doc(hidden)]
+#[inline(always)] // for const eval only
+pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base>>(
+    idx: usize,
+) -> usize {
+    assert!(idx < Alias::SIZE);
+    Alias::OFFSET + idx * Alias::STRIDE
+}
+
 /// Defines a dedicated type for a register, including getter and setter methods for its fields and
 /// methods to read and write it from an [`Io`](kernel::io::Io) region.
 ///
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 851335792a46..f603f4e45565 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -19,6 +19,7 @@
     spanned::Spanned,
     token,
     Attribute,
+    Error,
     Expr,
     Ident,
     Path,
@@ -153,22 +154,23 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
 }
 
 pub(crate) struct RegDef {
-    #[allow(unused)]
-    base: Option<Type>,
+    base: Type,
     regs: Vec<Reg>,
 }
 
 impl Parse for RegDef {
     fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
-        let base = if input.peek(kw::base) {
-            let _: kw::base = input.parse()?;
-            let _: Token![:] = input.parse()?;
-            let base = input.parse()?;
-            let _: Token![;] = input.parse()?;
-            Some(base)
-        } else {
-            None
-        };
+        let _: kw::base = input.parse().map_err(|e| {
+            Error::new(
+                e.span(),
+                "a base type needs to be specified for `register!` invocation with `base: ty;`",
+            )
+        })?;
+
+        let _: Token![:] = input.parse()?;
+        let base = input.parse()?;
+        let _: Token![;] = input.parse()?;
+
         let mut regs = Vec::new();
         while !input.is_empty() {
             regs.push(input.parse()?);
@@ -180,15 +182,7 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
 pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
     let mut outputs = TokenStream::new();
 
-    if let Some(base) = &def.base {
-        outputs.extend(quote_spanned!(base.span() =>
-            const _: () = {
-                #[allow(unused)]
-                type Base = #base;
-            };
-        ));
-    }
-
+    let base = &def.base;
     for reg in def.regs {
         let Reg {
             attrs,
@@ -209,18 +203,12 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             RegOffset::Fixed { offset } => quote!(#offset),
             RegOffset::Alias { alias } => {
                 quote_spanned!(alias.span().resolved_at(span) =>
-                    <#alias as ::kernel::io::register::Register>::OFFSET
+                    ::kernel::io::register::alias_offset::<#base, #alias>()
                 )
             }
             RegOffset::ElementAlias { alias, idx } => {
-                outputs.extend(quote_spanned!(idx.span().resolved_at(span) =>
-                    ::kernel::build_assert::static_assert!(
-                        (#idx) < <#alias as ::kernel::io::register::RegisterArray>::SIZE
-                    );
-                ));
                 quote_spanned!(alias.span().resolved_at(span) =>
-                    <#alias as ::kernel::io::register::Register>::OFFSET
-                        + (#idx) * <#alias as ::kernel::io::register::RegisterArray>::STRIDE
+                    ::kernel::io::register::element_alias_offset::<#base, #alias>(#idx)
                 )
             }
         };
@@ -234,6 +222,7 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             );
 
             impl ::kernel::io::register::Register for #name {
+                type Base = #base;
                 const OFFSET: usize = #offset;
             }
         ));

-- 
2.54.0

