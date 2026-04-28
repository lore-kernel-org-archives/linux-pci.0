Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020143.outbound.protection.outlook.com [52.101.196.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA03F1672;
	Tue, 28 Apr 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374874; cv=fail; b=RJm4TIf/YeCYS+fb7nxtTmUKRcDl+nlVVZwaavJ+GdAWIZvspbS/3SAHz3SzLwtNHqnGyyCVRefpyOuDIF8ePHRw4TcBpJQ2Rdh6hSHK7WRfjx4P7IOLx+Y4h7XsUGBePjdK+jZ9czCq8toP1p33LX10Ai+dtqEwL7x/VX3prjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374874; c=relaxed/simple;
	bh=t3wo8y6nChjJIOc9nlIeH3Vdvlx843Ma38Bm3jHh9D0=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=V8pSsim+9RiWJwu2YGU0D8FXLsOpNAMkas+PptzAtvK3wPjwN4LPbpmeq+MnvCtKRsjjq/MiV2PjOs4soxfjb2YSXg9aWCDKAYdnyc4tD0M5d2Ck1JyPfPxnUTEItZTyEJxg/9ZWPFUQnHVv4G6cF11at+KCc5Lx+tKLY+FFmJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=qlSsznPs; arc=fail smtp.client-ip=52.101.196.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="qlSsznPs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVYXhr393hezTnpMYMVF37Y04STbwP8ioHOA2mqaXbgkGR+9ScrhwVCtCnHOmciy58S6wtG3lQASzbpORM0rgbBL1l8JfpVNPg9pRUYaKbQVQ9C2WN5ceMRzZCizcHyLY4/qh4c9Xjtz/scB/1Yl9URrulycNh2bjzwj1H0WJbT9hiW1TSUtFjJcuV8upC779NUWSv65PFt8M/upLF8gDL6axBP2RlTQVWXuREE3ncf4Y8x8QNe65wX0LoDXeVuKL9ZgjbuuPMiviY7P0t8YHTWBydHT/l1s3Vg1dJ8ih6WSm3YY3N4tPBxnp7Cw5TR6ju5tz/csx5whaDeELAnKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxgQYpOktKhL1mhQ9h76R6RFTggfLTvbCxIjDejxu+k=;
 b=q2iYt3AVm5Cbs22Hwo0xk1XsJX4VjHytilHh5eO5UglvdDv0gwCFBnHGqXNLtvgg+EbM/8lmxJXsVVUw2Q74sBxwpINqyKCEMQ2hnBE6oF0csVGjVXe2Y3flxWt3Mr0SFml7KUNQvHq7shinoNB3Eb5EalNFqP4wpnDf7m6Gu/HqaSy1N/c/IQ8ryu42j7yy9vf5N4dTZnw0VAoUJz6dfrz9HCB+mpB61HYf7O0k+/jfcu91txxAxmkJtCLn5It4Do8Vex/XSdQGx8Q1kNYwuHilXOPl4NQC8mNjX+tSQZ06ihb7Na1v1RvPND/PAqkt84hj3i1nOMNL4GE66eEcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxgQYpOktKhL1mhQ9h76R6RFTggfLTvbCxIjDejxu+k=;
 b=qlSsznPsv8fiEtuVPFojNDYf8wH4556OjNgWHPu1RZi28eSE38CcjgX8wNAFKtsZ7DWVWo8iHw2msIvsxAVMZlDyOk8w/53tTwjlHcP7BuXwhbfoj5DJHXUU45OTWFg2TRX1/s4eJ1Ni+bKIKrTg1nkEXERM7dmEVSTic9e7ChU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6976.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:14:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:14:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 12:14:29 +0100
Message-Id: <DI4QT2U1098S.3K9K7INQ86M0Q@garyguo.net>
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
Subject: Re: [PATCH v2 05/11] rust: io: restrict untyped IO access and
 `register!` to `Region`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
 <874ikvqwyd.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <874ikvqwyd.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: c930a1a1-bd0c-46a4-971f-08dea517513d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|366016|376014|921020|18002099003|18096099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aI/KFRnfbHWjAeIk6VX/VTXYcOUdB8gncCVOsSpDJyv9QQ2ZKRIK6wjCbxhMzWcLTJ63uu4e3LsIATS/h6kFWxOdkwxApLKwbCJoI3U6i1hQnO0hrv7noZxcRJ4DadKt36aqJnsdctD+EwbVuTZ0Of8xhTovpJxvdaFdqBehRRxPk6lyYxuv2VLi93xou93LlxUMVW+5r3GGmHVN9uGp0xhhPoNIjvd6s+R8bbWxD4tTkM1SdBurHQaf3v/27WS4bnwyujMwWUm3vYBDuX9CWnTmMkO63nUCpZcfA1TwvfzA9nUea3qcNwjAigI3kC3dD7ZFRwBsRvdl01vbm7nOt2RXxFGiPje7MU7JiN/f3DjTY93KV2c1t7OTWq7asRMjrVY09vNo472vz6TK26fU+VXyalqve0kL52NFMe7uwOUotKeVYZoU40SmD98tkdGQMMY2aMZzxDAY7aXU/zRFSfC3W/xNAyLnBvCN2dmJIX9mRi1kIt2jroxoGS/AvtK8gHwPX8SLIn85kmmDzSiPNfDu/WbEWZJDAqH9IagLUWLVDik0LouPBMMbg168e3KfSWawKicmn7rt/HLMO27r1ucr+YsYN6SgxDf7MLISUN34BPif8gHnNSHbQ6Xtyj4Ud8Fqjx7TRppXt+qyBZh+S0PvEdWNO0XrkgRB86rFPb63IVtyXYy1KDgybDJbkaBgCoi3lTa+KnJnTZL1UaqCeP42+CndBHUAtaYXGlhKBYXpWM0jQJXYJXHFutJ9FMB4e5/1+3bVhTsswSUdSwfE/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(366016)(376014)(921020)(18002099003)(18096099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGxiNzBoUmphWlpPaHBRYjZ0cEsyVTF0cEVYcW9rN2Zwdzd3Z3ZnM1RTbEpz?=
 =?utf-8?B?VkNoOHNNUFhCTEJpQzZlNFNjOUhEdTJTRVdHWFMwMnNDcHRkNTFMNWZ1ZWRp?=
 =?utf-8?B?UUcvN00rcGRZRkMxdDNaOENVYVpDZVptN3ZRU3pvbU5zRkZZT3A3emptRkJH?=
 =?utf-8?B?allROExINGhXTkg4SVAwREpIZ0E1MUVIdDhOaWRFb3hUbUkyUkdXVEd4bXNE?=
 =?utf-8?B?SnNNdC9SdjlyaXphNFk1VjlNOEFjRmlTTTc1RERiK3VwQzRhMTdpU2JYV05i?=
 =?utf-8?B?UHBUNnhkcWNQZEQ2S0U2UXgrS21XcTV3dVRlUVVScG4yb3VOeG5SZ0Qwd3g2?=
 =?utf-8?B?VEh5aFpXdEFzSTU2TTVKb2tGeEIxUVE3SFZrazdzRTNQYTVvTmRXb2lJMU55?=
 =?utf-8?B?YWIvZndveFV3U1lLdXBKdno3TU9ySXZVRFN0Y1IzQXJOM0hPMERkYTgwM0xI?=
 =?utf-8?B?c0xmRWN3WENVclJ6cWdRQXlCZ1hIM2JGaFltSVpVL1dYenlPM1g0Ukt3V2xV?=
 =?utf-8?B?ekFibGxGdWxWY1NOMjJway9qbUlReFV4RXlWUXVmOHNSVDd1RFdUa2dlM0xK?=
 =?utf-8?B?bzlKQys1UGk5Zkl0Qll3OVdyWlZkVXB3L1pQTi94dTJSeFpidTZtZmNhTk5P?=
 =?utf-8?B?OVUxb2l4cmtxK0hRU3IvMkJSQWhsS2RVa0U4ajB0SDNEOEgwY3R4OU1UYnR1?=
 =?utf-8?B?VUg0TUhFYzY5UDhPQ0ZoSjl6L1U5S1RDOWlSQ2JocUJva3FyZTh0cnVBeXRm?=
 =?utf-8?B?aDAybEJGcmJ0c3cvTWg5RXlSVlhhekJ2bi9jcFo0czU5TzhmSGNKek9oMHRv?=
 =?utf-8?B?UUhCYkZZQjdnOERIaWcrVVlTSG9zbEZXYnM5a2R4OFlCUDFsdE1hZmJMUGdt?=
 =?utf-8?B?OUpCSUZhNkdsSHlmb2VzYzBPTXVtWTRTSEVGUWNDT3NLYlUrdTZOLzFFT0FN?=
 =?utf-8?B?cmRUc1NULzl3RE1tV3czVmk2dFdXZXZTdE9FY3hFbkVid3lpNjc2TEw5MUcx?=
 =?utf-8?B?RXZjRWpTZHJ1emR1ek5zNnBUTnV6dU9PVUpablRsaG9SbmJqQ3dESkE4MlZl?=
 =?utf-8?B?bWlWU0Nhck8vVGN3M3FPWTU1bU81RTRIYnMxa1E3blpPcjlIalhUWHdPdXdj?=
 =?utf-8?B?aE04SXJ0Q1BGWnFrMnlJWjZ2SlhadXgzUktoUnluSmM1TE5FVFc2QUIyeFVO?=
 =?utf-8?B?MXMvNE1EN0pzcG92UWM0VWFzTFc0K29ZdmlraHFSMi9FTmc0dkNWOXZ5cE9m?=
 =?utf-8?B?Y0w1NmQybmdSUVJLVkVxWlRrSlZLc2hyWkh5dno2cGY0L09HUWxmZEg5VVU5?=
 =?utf-8?B?SjVPemtYaEZMSUF6WmRBOUlBMHllL3dhd0hsYm9uWGU4WHJJZTExMWxtWUxw?=
 =?utf-8?B?eW9lZHduR3Jla2dwdVFsU1l3S21BUzFqQ1RWZ3AyNFljc1hBYVc2VlZHZ1dk?=
 =?utf-8?B?cTNQcFFQUURFUUVkTFNJSkx6RlBKUitoQ2xtd2JpaFlMVjRpd0dNeFppdDBv?=
 =?utf-8?B?Mll4eXhmaXZVYzRwSHloVDVCMlBlVGFpZCtrZmM4eDNQTG05YnI3c2ltQXZY?=
 =?utf-8?B?UFRBR29MZlpNdURwNlljVWxQUGpwSk4zQmwzbW1MUmt1aUdjN1prR04vRGM0?=
 =?utf-8?B?RWg4TDUvdSt3N3ExWjkwUzQzOFppdXlRc0xoV0EwUlNRdExCOExSWkJzdENt?=
 =?utf-8?B?KzJOTkRjLzhvRW85ckRnNnhNMWFVVkVzdTlrQVpXT3J5cXduUldvQWxnTDhM?=
 =?utf-8?B?bStKWUUyeDFkQVBDYUNxd1diMTd0YUlkMVUwbXZWSW16NDNwdU9jK29RcVdQ?=
 =?utf-8?B?TS9rUlVoSlVaelp2YU4vMHdqWk5ha3Q4d2ZsNlk3U1UwdWNCWUd2ZW83bzFu?=
 =?utf-8?B?VnpEMG5IdFRJYnFHcFVZU3BScmRCVkZzdmJVT1NqNFBUUnBJcUZ2Y3ZoNDdY?=
 =?utf-8?B?V2w0b2pTQVF5aHRCU2pFYVZMNGtrRVpRcWpGcDY5VGN4ZnNzSk5uRVVNVEJp?=
 =?utf-8?B?VDllU3d5L3ZJR2RSdmtjWGdzaUJFNGdkbS9LRVpqOWN5aDlwUG9aSklyU3F4?=
 =?utf-8?B?ZnRlbzhwajlhb25MSUZLLy94dmg1M3Fma3pEMkNsSE9Ca2hHSVVxcmE0NXFY?=
 =?utf-8?B?SDVhb1ZxVC9YV1V6QTQxcTJIaFo5MlgxQjFBZFpWQmtwU2VsNXlvZ0x3TDNl?=
 =?utf-8?B?a1UwKysyS3BWMHA2QWYxWVg2VXRCK2x3dEg5UGlFZTNkR3l6VmQ4emswbzcz?=
 =?utf-8?B?RFhlcFlIbDJFNEkweUNoeTNNY2VUaDRrbEZ2aXY2S1Bwb3RxcGEyZzhwL0oy?=
 =?utf-8?B?Vkl2ME0yR1lDc2VJem82R3pQOWx3WmFNcS9sYXpwV2xmYnFBdzdtZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c930a1a1-bd0c-46a4-971f-08dea517513d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:14:29.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEOlvMW1A4L0Tdw8EN7AOXZ25PPlcwSXj0LqiWBR/Ojgokf6Kdx0c7udm6MwaqUuJ5n2PKCkRcIjT/LdQAwBbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6976

On Tue Apr 28, 2026 at 10:02 AM BST, Andreas Hindborg wrote:
> Gary Guo <gary@garyguo.net> writes:
>
>> Currently the `Io` trait exposes a bunch of untyped IO accesses, but if =
the
>> `Io` region itself is typed, then it might be weird to have
>>
>>     let io: Mmio<u32> =3D /* ... */;
>>     io.read8(1);
>>
>> while not unsound, it is surely strange. Thus, restrict the untyped meth=
ods
>> and also the register macro to `Region` type only.
>>
>> The way it is implemented is by adding a generic type to `IoLoc`. This a=
lso
>> paves the way to add typed register blocks in the future; for example, w=
e
>> could use this mechanism to block driver A's `register!()` generated mac=
ro
>> from being used on driver B's MMIO. The same mechanism could be used for
>> relative IO registers. These are future opoortunities, and for this patc=
h I
>> just restricted everything to require `IoLoc<Region<SIZE>, _>`.
>
> Does this not prevent `usize` from being used to index anything but
> `Mmio<Region<_>>`?
>
> It is my understanding that the following would work before this patch:
>
>    fn do_read(io: &Mmio<u32>) -> Result {
>        let v: u32 =3D io.try_read(8usize)?;
>        Ok(())
>    }
>
> But I think this will no longer work with this patch. Is that the intenti=
on?

Your example would always fail, as you're reading 4 bytes from offset 4 fro=
m a
region that is only 4 bytes in size. I suppose you're trying to say

    fn do_read(io: &Mmio<[u32]>) -> Result {
        let v: u32 =3D io.try_read(8usize)?;
        Ok(())
    }

? In any case, it's intended to be unsupported. For types regions you can u=
se
projection. So the same code can be written as=20

    fn do_read(io: &Mmio<[u32]>) -> Result {
        let v: u32 =3D io_read!(io, [try: 2]);
        Ok(())
    }

i.e. reading from index 2 instead of byte offset 8. If one cares about byte
offset they would probably want to use the register macro instead or having=
 the
MMIO region untyped.

Best,
Gary
