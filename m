Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020101.outbound.protection.outlook.com [52.101.195.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F343436348;
	Tue, 28 Apr 2026 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385331; cv=fail; b=A5WffT2OMQjguMQ0wkKEzGgbksnnW/0UVYFVHzrE3U2BDiNkxknzXZaGdxOzNLhX6S0b0q1ctUTps1g4OW2v8EC7KLtos8v/jBC5AmQLSbYqdnvJ/XAhqv3KL4yDcQaqD5O2PU+rhJjfv4Tc+cefkHFF8x5qop0FFTXBgacXmmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385331; c=relaxed/simple;
	bh=ndyC7XN9CVxHrFfZ6D62IrhXJSAHYfSGyDHejd8dokI=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=NrPJfTdzY2ckhI+FSY5h7HrXXzCGx9ISktWq5R3He/a07ZU3YZqidA6uMPdZPsi5KnkLyWjiuilVeY/GVUiszped9hP3pB+b/j3LSDK8eS0EjJ8D0hxkISIvXYvQfw1TvifrAl/lEm2xYEIcTIAiYsWOgb4zBnmPCpIgmBNPdrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OsbShZSZ; arc=fail smtp.client-ip=52.101.195.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="OsbShZSZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmaymhB07wqvKIsDPoeVVPvU6JBZgpuoHjj+J1RnI0btZ+F1FIFj41YDQpL67/uBonAN4fOQUE7MA60KvvP0hVrLTuWLY/Uq+risesrH/Vw+LOgnc2NMQx9p21E8bladnx/PM32CraZZo2KK9lhI3ihptaGsFw/TPx4c6v9hqf081OTr5Oh8SY/ghTaFm3ChWGL+BpuQoeJHRj14R9STvTfIsTX5Ps8/K7jV9Zi07QylyZp6ijq0+cON01dsC7FLUYVmUGTqnU44vTxc5g+rctrLImorVt3KqUyeO5u2/iGqgP73taaJ4nC/8dGbvv6YIDZaxeEfVbOF+8/piXo8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwDuMHE/4HHSYPolYYpXbnNdbqbbZXyxT87H71H9lls=;
 b=hFCIkVBMyOVmw1DaOlbIKbyuo5ZYCl/pFeSFtNl5bHECWJvzpPNmwWgKNbzgdp1fieEAYhk/BoR/fPOv4woEcbQ5Zg4nfngH15cBdT+spq9YX+qXWNzsQWQaq3KlXKWwqALPiLwpYBYZBDZ/4elSpM2pYz5kahDUgteYg/esn6GrknCO6UhHtpUGMUx4YJMg31ALeKjlmbmtKgM3Docr1cbPGQ2WkB3Zi8lNHYEOFG8mgt6JaS7C0XLLaymr89BWlCmgdl2VGFZU+X5uW5gdHHF6ub7fslgrdgzykEczPHCf3rTjg0utx2LnzR4skIbdWwcd4MPtQUdE/ohpfqYz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwDuMHE/4HHSYPolYYpXbnNdbqbbZXyxT87H71H9lls=;
 b=OsbShZSZS/dZTKY9ybBmRokrDrMHpa8aIskI8zBu/LLYL/YLFA5gagmb3caNGlpzM8aOf3J8hSB35+Msskki+SlUAyxVaZLRpprm6KvFMnlKJQiGXmN+xUa/q85Nq3y1NKzoSxxpewC+t98/jx8mtQLJfXHrtoG5unZ0rThVevk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6708.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 14:08:42 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 14:08:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 15:08:41 +0100
Message-Id: <DI4UIGMGKN6H.375657ZERNYB5@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 11/11] rust: io: add copying methods
X-Mailer: aerc 0.21.0
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-11-4c251c692ef4@garyguo.net>
 <87lde7p6d9.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87lde7p6d9.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P123CA0034.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a95ef55-85bf-4dd1-8ee7-08dea52fa761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TD9YVgmnLkSI+sVs/iOrwrJo8qMB/FdRmkturYpXDuinsM37YRudyiAwN/Fph3dzxG/eREOOCgqqt1kQi1wWYXMbeoOb62nfS62yl5XcjkgwNZXi7Loy/ohUNlFxXo9GhIY/5ekXNcAP9WChNy9y03rBb0QEKRNpufSOweorm11N92rT6IPuWJNEwSn8nlrm6ariEJBzGi+bZCgGhdfcHw9/GSEbE61i77VCjx7CvnXvEp8oukc6CrjLR6hqlBN4tLiSHsDKDnoceU3kmZZWKm9xyhh42JhSYNd1Qz853JcwyUQLGskDY0K72WVhhSPZhMk6PuTbjEEolFPmQ0MdnR4g3csnJRjqtBTZywhnP0bHsT6gVT6+8qAN8wZTjImRL7Dsm2vxMzUSpuHE/43BOG/vzqQHp0TLeQ2XM9f52J/rhrq5RUUyHdUK8dCKJWwZISwRxKR2fzYE9vFUBXCINc19CJtq3Q0Fp8TAWzsw1AaZD3SyqV5TzF0LZp7hK5gRXa7Juh5TojZ0nQ4g8Q7e+U9rsRs7DFg1phAehWL2fU1dU2RhvaJotrgf4tEqme7siANd++T84XxmQJqW6Hpeag44AZXshZOc9i+3PDtlK8gI08dK9o6gdlwRi3i3BceqNRwQVRExZsf/LL8C5Ac1BVWZDamtDdNI/r9sTa8krdrngkAfwDfdK13D/qozxR1EVKIOQkzlwyi/YRmzlXi6AWNYbrxGRuNWDkwe7OjXsZ6J6lUA67G5hTHyyamelAbPYrTZrOssF/ej2zsMN3ppQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzdTWnBSdlNZdWY5eUJ4ekJ1NjlJU1V6V1BNVnJrelpyWjFDMVl1d1FtUW9J?=
 =?utf-8?B?YXRtRzFJcmNwcUMzTy93Y0hOT0gyVjVpTm5zeWFNOXYrRllvcmQ0aDFrVFlk?=
 =?utf-8?B?cWJaK2NCdkRaNS9nbkQwV3NVODJ0YXpBL0hrWWsyaEJlcS8rN2JTeWREcmxW?=
 =?utf-8?B?OW5zSnBZSW1ESyt0d3pPTTZwM3hXL3V2TjErRHVQUUNNcXoyaUhteFFvSmtk?=
 =?utf-8?B?Zzh4aE1CV01idTJyd2R2NTFobFNTaFYxUmlIRU82cEJPZzRPbGEwRzE5MGhC?=
 =?utf-8?B?akRpMGp1QWlKSTgycFRDMWx6Q2REU1hKeHFDcUxQUmljVjczR1J3K2RpMWNi?=
 =?utf-8?B?S21vZzgyU01aVnFMdDUzNmh3ODQrdURieGpGSkpvWHh5eE44WEx5REdWRDIv?=
 =?utf-8?B?WXJFa3J2NldWWjhUS3JFL0Y1cFJZeGNqOTM1SlZvUE15aldYamw4amlBNDU3?=
 =?utf-8?B?anh5dVNTalhuNWh4UHdTSTNTQzk4MFo0WTVHb3hBdmtud2NzaUwyYUo3MEh1?=
 =?utf-8?B?c2VyaU1GRG5zYmhmRy9oaWxEYVhEWVNzL1k4TmJkbndtMmJrUSs3SzhSS2F6?=
 =?utf-8?B?VjdpUFRid2FORCs0ZU9SbTI0eFAwMGc0R3c2UmRzOUNLMU9DdFNZYVpyU3dI?=
 =?utf-8?B?aUpOZTV4RGxaZk9paUhxZkMvNEQ4Yyt3bW4xWVhDWnNOaW9CcnhRZjNocVUw?=
 =?utf-8?B?ektkUGdPS20xZ1hGVm1iVjhiTlF3VXZ6YW5INGttL1JuMzRKSG1ZYVlUdllB?=
 =?utf-8?B?emhOa29MYVRyZ0FINURycGltWFR6MC9rN0Y2SFphTC8vRmI0UkVuRGJmaWpF?=
 =?utf-8?B?dFRmR3FhQUI3Q2J1U0I0c2tZdFBFTDVIL1B4VUgxZnJRMDErZGUvWlIxLzdQ?=
 =?utf-8?B?QXgxaEI3dGovNEJqQnRRbnZzRHNnVUk0T2pxZnUvcFpRdEtKWnNNOWZsSG1G?=
 =?utf-8?B?RFVLUndDaGpPVlpoMXZyMWNNTThveE1SYmZ0Qm16WEE4MUdZeXVuSjliMWJp?=
 =?utf-8?B?UzJEWW5lSkhSODloZFlxUHdVM0pPT2l0bFprT00zZkVHZVZqMGNXUEtpSFVr?=
 =?utf-8?B?WmR1QVdNOEtlUnVCUXpkZXl5bk9RN1R0cFYxQjNyYi84TjdVUy8zWEtLeUdk?=
 =?utf-8?B?bjlCVlUwbGwrR0RPOWpRbGY1L01rbXhPUjZVQnRCTGdYakNsTEdnNEtKRHJi?=
 =?utf-8?B?bG53eVVZdVZSWElWOUVaSDBUczQwTWdsZTFSMWtoTUhBcmxlRFFsMlV4Z0tV?=
 =?utf-8?B?bnFHOFB4N1A2a0NnTmJGVGVQTS9wUWRRMkhIVjEvYWJ2NElrNGtwYSs3Snpz?=
 =?utf-8?B?QWpFOVl4bml1Zy9qMEVhVm8wSWJBcU5CZUZvNjFIMGFFd2Z1ZEc1aVEzcnJh?=
 =?utf-8?B?cFZ3WTN5cnRiaU4wVDU2MEUrSUtUQ3ZZQ2U0ZllaV1hvLzJwT1Irazl1THVl?=
 =?utf-8?B?aE9OUEhzdzc5b1ZmVXN6c3NScUJ3aWhxSHZKM3hwTnhEU1B4amw4Vlg2eSt6?=
 =?utf-8?B?OUFHcmZIYm5UOGlVT2J3TTNrbzV4S1hZc0srWUxmdDJPMFFJL291QUNBNkFB?=
 =?utf-8?B?V3A2djNNUkF0M1VxK1RuQUlVV04zZ2xScVhIWFFuZ1N0cXhPTC9XRFRwMXRR?=
 =?utf-8?B?WG1IOU9Qc0Fzc0pQejg2cGJ3dE02ak8yWjJ2RTBWdDB3dFduVEhreDZOcFFj?=
 =?utf-8?B?dlJySFpreWE4MFRNZEE0djFmVllZS2lLaWVjUVBUZGJCUFh1Wnd6RThqQmZX?=
 =?utf-8?B?bzZNTFNWaEtOWWcwZlV6OG5KT1JpWlN5TkZ3aHB1bWdsTHF6aVNvQmNGSFlG?=
 =?utf-8?B?cldRaERBaGFLd0Z3K3JzaUJid0ZFalBnU3dmeWlEcFZxM1ZaczgzM2ZZdzFR?=
 =?utf-8?B?dTdqZHZreUNmaTRkL3QyTVR1ZjBzOHlKb2ZTZWFGaDg2b3pPbS80aVJmSXkw?=
 =?utf-8?B?Y1JLVWNOaUdaYW85d1hpaU1Gc3FudkJnR0J3dG5BS0gvb254NG1FR0dxOUlK?=
 =?utf-8?B?dVFaRWxCMlRvWXMwUUErdy8xNGYrejNlNFNrVExiM05Pb3JzT2pCNnZWTnYx?=
 =?utf-8?B?WjZDSGs0bGQwWTRrZy84OGtqOU5FaDdMUHNJTmpaZm9RSjVDSm8yNHBZN0lE?=
 =?utf-8?B?OTREYWZQei9HQ3ltMTE3L3hNRVFJeEd5N3dKbFczUkVUa2lLRGEwY1RwUllm?=
 =?utf-8?B?aVN3MHBRSkRVZkRKdGdwazhmNUlDMU1vQzVEVzBIeXNzbGxPQzFmWTQ5MUo3?=
 =?utf-8?B?eG9XTGp5bDlLaCtwMUFJMlNQZ3FrTlQyTUFQOEpHRFVGSC92RkxBODdsUVpj?=
 =?utf-8?B?MnpGQ1IzN2tEcm1kb0dyZkxWdW8yT0wxNWI5REx2OUI5YUZOVVR4dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a95ef55-85bf-4dd1-8ee7-08dea52fa761
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:08:42.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4oIuLD3vk+g8t4clW/+aUU4SX+QsJ+7tLSKfbSrvrUv1iGu9wQ1OZH0X8cmO3hMUQ8VIMGjXeiP0m4nUh2l1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6708

On Tue Apr 28, 2026 at 2:22 PM BST, Andreas Hindborg wrote:
> Gary Guo <gary@garyguo.net> writes:
>
>> One feature that was lost from the old `dma_read!()` and `dma_write!()`
>> when moving to `io_read!()` and `io_write!()` was the ability to read/wr=
ite
>> a large structs. However, the semantics was unclear to begin with, as th=
ere
>> was no guarantee about their atomicity even for structs that were small
>> enough to fit in u32. Re-introduces the capability in the form of copyin=
g
>> methods.
>>
>>     dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
>>     dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)
>>
>> The semantics for these are modelled after memcpy so user has clear
>> expectation of lack of atomicity. As an additional benefit of this chang=
e,
>> this now works for MMIO as well, which maps to `memcpy_{from,to}io`.
>>
>> For slices, which is unsized so the API above can't work, `copy_from_sli=
ce`
>> and `copy_to_slice` were added to copy from/to normal memory, and
>> `copy_from_io_slice` and `copy_to_io_slice` were added to copy from/to
>> other `Io` regions. They're optimized if at least one end is mapped to
>> system memory; if none are, the copy occurs with an intermediate stack
>> buffer.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/dma.rs |   8 +-
>>  rust/kernel/io.rs  | 231 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 238 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> index bbdeb117c145..307f5769ca0a 100644
>> --- a/rust/kernel/dma.rs
>> +++ b/rust/kernel/dma.rs
>> @@ -16,7 +16,8 @@
>>      fs::file,
>>      io::{
>>          Io,
>> -        IoCapable, //
>> +        IoCapable,
>> +        IoCopyable, //
>>      },
>>      prelude::*,
>>      ptr::KnownSize,
>> @@ -997,6 +998,11 @@ unsafe fn io_write(&self, value: $ty, address: *mut=
 $ty) {
>>      u64
>>  );
>> =20
>> +// SAFETY: `Coherent` is mapped to CPU address space.
>> +unsafe impl<T: ?Sized + KnownSize> IoCopyable for Coherent<T> {
>> +    const IS_MAPPED: bool =3D true;
>> +}
>> +
>>  impl<'a, B: ?Sized + KnownSize, T: ?Sized> crate::io::View<'a, Coherent=
<B>, T> {
>>      /// Returns a DMA handle which may be given to the device as the DM=
A address base of
>>      /// the region.
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index efcd7e6741d7..0b1ed68c0f9b 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -4,6 +4,8 @@
>>  //!
>>  //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/=
io.h)
>> =20
>> +use core::mem::MaybeUninit;
>> +
>>  use crate::{
>>      bindings,
>>      prelude::*,
>> @@ -233,6 +235,55 @@ pub trait IoCapable<T> {
>>      unsafe fn io_write(&self, value: T, address: *mut T);
>>  }
>> =20
>> +/// Trait indicating that an I/O backend supports memory copy operation=
s.
>> +///
>> +/// # Safety
>> +///
>> +/// If [`IS_MAPPED`] is overridden to true, it must be correct per docu=
mentation.
>> +pub unsafe trait IoCopyable {
>> +    /// Whether the pointers for this I/O backend are in the CPU addres=
s space, and are coherently
>> +    /// mapped.
>> +    ///
>> +    /// When this is true, it means that memory can be accessed with by=
te-wise atomic memory copy.
>> +    const IS_MAPPED: bool =3D false;
>> +
>> +    /// Copy `size` bytes from `address` to `buffer`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// - The range `[address..address + size]` must be within the boun=
ds of `Self`.
>
> We should probably specify what "bounds of `Self`" means here. It's not
> the bounds of `Self`, it is the bounds of the memory region `Self`
> represents.

I just copied the wording for `IoCapable` methods. That said, I think it's =
worth
improving.

>
>> +    /// - `buffer` is valid for write for `size` bytes.
>> +    #[inline]
>> +    unsafe fn copy_from_io(&self, address: *mut u8, buffer: *mut u8, si=
ze: usize) {
>> +        const_assert!(Self::IS_MAPPED);
>> +
>> +        // Use `bindings::memcpy` instead of copy_nonoverlapping for vo=
latile.
>> +        // SAFETY:
>> +        // - `buffer` is valid for write for `size` bytes.
>> +        // - `IS_MAPPED` guarantees `address` is in CPU address space, =
with safety requirements
>> +        //   `address` is valid for read for `size` bytes.
>> +        unsafe { bindings::memcpy(buffer.cast(), address.cast(), size) =
};
>> +    }
>
> You could just leave out the default impl and implement each case for
> `Coherent<_>` and `Mmio<_>`. Do you expect more implementers that can
> share the default impl?

`copy_from_io_slice` and `copy_to_io_slice` needs `IS_MAPPED`, and also the
optimization of `copy_read` / `copy_write` too.

Given that the semantics of `IS_MAPPED` ensures memcpy is always okay, so I
think it's better to just define it.

The implementation of sys mem would also just use memcpy.

>
>> +
>> +    /// Copy `size` bytes from `buffer` to `address`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// - The range `[address..address + size]` must be within the boun=
ds of `Self`.
>> +    /// - `buffer` is valid for read for `size` bytes.
>> +    #[inline]
>> +    unsafe fn copy_to_io(&self, address: *mut u8, buffer: *const u8, si=
ze: usize) {
>> +        const_assert!(Self::IS_MAPPED);
>> +
>> +        // Use `bindings::memcpy` instead of copy_nonoverlapping for vo=
latile.
>> +        // SAFETY:
>> +        // - `IS_MAPPED` guarantees `address` is in CPU address space, =
with safety requirements
>> +        //   `address` is valid for write for `size` bytes.
>> +        // - `buffer` is valid for read for `size` bytes.
>> +        unsafe { bindings::memcpy(address.cast(), buffer.cast(), size) =
};
>> +    }
>> +}
>> +
> [snip]
>> +
>> +impl<IO: ?Sized + Io + IoCopyable> View<'_, IO, [u8]> {
>> +    /// Copy bytes from slice to I/O memory.
>> +    #[inline]
>> +    pub fn copy_from_slice(self, data: &[u8]) {
>> +        assert_eq!(self.len(), data.len());
>
> Do you really want a panic here?

It's the same for core's slice::copy_from_slice.

Best,
Gary
