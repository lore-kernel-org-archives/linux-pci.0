Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021123.outbound.protection.outlook.com [52.101.95.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6753CAE9B;
	Tue,  1 Sep 2026 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270506; cv=fail; b=irjgLB7Yhny97luAFN0w3pqeda9nCwauGU0ZgDpqM84YXAmubwH3+P3+2g9VNuhyWg7FLMMbc1ri39bNor8me547dVSa89U3Xtikz4+gs0nf+Mp1HOZ1185oVqIVg4CR+GeV80cvrEyNDVvHxE8f7L7ivEJM8qwcCb9Q9fANDQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270506; c=relaxed/simple;
	bh=AnthmuCRFdilorIJ/ArZsuwXm0tJhTfUN/3oF3mHyYM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=JfZpNo4yS4q+c4+jnXQ9JG64GpdyjwBxQz4r9TRjrumtDJVyn+RQQXDKh12jTKI/LZ18fub2OxmhClsryBnt9eBZaLp2+h1Z1QA6E1wyfmk+k5uEJ0sX18cIKZSRdfm/DojsTrQSmFlhrnA0GPyyMX4t4qeMJ4PvnEHgNKn6NXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fssYn4Y3; arc=fail smtp.client-ip=52.101.95.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fssYn4Y3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt6w708ShERPiQfl33biurBIly8csDAgKXZ1tfCyKKw+DjAHlZqD3VBFsW+PDjM6KlHeHoAYW5YuygZPJ1MTkz66RVU+O8htMTdWzung01SOcdJhhj5GPWjrAw9onrJiWe0VcDEaGbVTo241sjbxmlN4Fr5HvqYRDCcMQkQsZtTUJRHlyWzTzihIVgClsTjHy/41jNf+5uvw32l0FROgQZ9zZ4ybFof9MryiVaRf8pQxBH8IiXkT0fHfH1FIt50KIY9rONfMgnk3ZwwdgmAWY4uGeQpNLHbiNbvIF6lJV/Ue88bESBAOnMoviXN7qkTu5OnoL7+lzVQPPcnfN+ECZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXwnSZCDftVj+J/FqsEuKl7uUwzShrJNj/s+ok0nNs4=;
 b=B7lONdT2YjshDTDH9wrThDrPCH6sUOohJTqCcOjJrQCs7JQHnF5Trp9v67r7iHuxnG8Y/QHju3MQF474WMCz+rMVq/BO5s2JIB/W25omfOnXjqv7fJLKlFrAqht3IIgxTaCfMd2SIXF93U5LdCEYI+4w3QFCWp9PI0ni54o79NROfLSmHEro+aUo5zhq7v4nC8HUoQ2PS7zFFuCofPiLQ7ZtGjLVYUWHXPoArqXMsXYDHDUSFBr98Su8MF5jh98IC660m4U8MnlVeNulO1Omx0XzkqiOaBhY+CV54pcNUwwviwDiysY30pwlODBAUiJ0jC6VNfoWa8jgxI5sR6eorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXwnSZCDftVj+J/FqsEuKl7uUwzShrJNj/s+ok0nNs4=;
 b=fssYn4Y3B4LQ/k8R1Yh65F834tjIpg5oazmq1Ek0A7lWaLgihAiFZ0darxA7MOlif3HYZLt4K3Jww0BHi26DLmL6cyYF9tgaJnpfyV97JuYzQKtSRtGPLGimR5taU8gCklwbiviS+7/qnIMLt8h8jA6z7ds/Rmq9AKuUiQGzJXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB3263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 13:48:19 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 13:48:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 14:48:17 +0100
Message-Id: <DL40ZHH4H6B8.284J2WKIMKRDM@garyguo.net>
Cc: "Sophon Zhang via B4 Relay" <devnull+aiqubits.hotmail.com@kernel.org>,
 <aiqubits@hotmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com> <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com> <DL3XLHXS647M.1LMHQUVX5RTI@kernel.org> <DL40NH1AX8WN.2ZPY7GDL0FSEW@nvidia.com>
In-Reply-To: <DL40NH1AX8WN.2ZPY7GDL0FSEW@nvidia.com>
X-ClientProxiedBy: FR4P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB3263:EE_
X-MS-Office365-Filtering-Correlation-Id: 47260239-7d96-44fa-3acd-08df082fae78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|10067099003|6133799003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Op+d1+JvwcW18ZfvTqWIXVcNP188F0NmXFrjAudSVbRGVJlVVMyJ4/3+/wB8zno6sjeOaYNnrx/lzTeSI3DE/2LNOpU879MqyAuY3aa+08o5Hw7tB8wRQE8nXXpK5MIiVYQzkrn52L7JErDEweVGU2ORAKE+Jr2uJjxMAXb32T5AMaSUmzksa9UiW74ZRzHasDl63lKVZRW/By2NuhmNxHWZ0+1b2/NDNeU6YLMRXMxTn7zBqzlvhXE6gWVfRzYwSdq+SReVdxSUFT0BIjVmR5MBVeGEt4Emk81gmGGWby5cmfPAgPwLi9swQy4PlO+BnG3S3epRAjzcqLDGoKmZ6h/5IYTpmupoXO3xcGOvDl1UCdEckvkRfZdflpMiBwv2zlojuMJHlZlA8qrEXKHkharR6+hhQo2vo6U0tz4OG6fZhVDQvnSab0QVquLJYbP3xm4yyF33RcX8BoUdCQH3lAVXrgHxqmftIQJpL5qTyNXaZjwLujoyMiMtrC3EhAgV2c6crVdbgtl0N1+Xh0ZbGtza4IOtxbO+uWFamwO6xdEXtUu6jZByS50bRP5WF7BgBn4b6hcmqkiDJtKP8vgsmLV4VTRMhAPIqpEQOW7RE+/CISKfiuc23uht5qZeODOSHgPScOjYq11503ivbV1lk3A1Tjdwqi6CSuykMjE4kJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(6133799003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVVzc3JrN3dWbzU0cjVMUGJKblFORUFOSXhMVEJBd25VdHF4MzRUb1hGOGdv?=
 =?utf-8?B?M1pnUVEveTJFV0FNV2lEQVZ4djFkdG94emE5Z1RaZ1R5TWdIWWpnbmlmWklU?=
 =?utf-8?B?dUZIT1lwNXUxQU1wVTF0TFBUbmlDcDNWNC9aTjRjNU4wWDhoVDV3TGJVMWZO?=
 =?utf-8?B?SEVVei92MS9rNGhzdlNKemc1NUVybnMxTThXV28zakNVb2dFR1RUK3RoNlI5?=
 =?utf-8?B?MUo1NE9vVXhjRDNxc21GU0RMYkpDVGdPUHdnaUloQ2dnak1iVkhYaEN4cjhy?=
 =?utf-8?B?UXZDSThqWXpTY3QzY1RSUGc3RElPdFh0MTRFWnduOUc5NzlQb1g5TXJrWnZw?=
 =?utf-8?B?SXo1K3hZenZLenY2bHY3WXdCUzlEb1RoYkgvN1JDRWVNR0F4b3FvaHp4alJK?=
 =?utf-8?B?M0YyeWFjT2ZOd0hxaDdYdjVmMkc4OE1FcjZuK2tFbW9nSy9OdjNTdlpGZmtq?=
 =?utf-8?B?bklzRExWaHFSMnE4bkdxQTJrRSt3TDVaK1JnVU5ZM3VZS1F4c2ZUemFmSjUx?=
 =?utf-8?B?aGd5WkN1dlg0a0VIcnlkc2FLcE5PQzdYV0c1cVA4eHdrbnc3N0lDQmpkRTRS?=
 =?utf-8?B?bWQxYTYzSC96UW1kUmJ3VnF3RWgrR0VveHRGYk90cFozZjZhUVdEUjRSTkpX?=
 =?utf-8?B?VUZwdUR6SVh6UUJuYzZ0V0FQU0wzbnNGNVpSdnRIY3RBY1FBdzd0aWxMYUlF?=
 =?utf-8?B?bjdWVzI4ZjZEek5kbEVKMUNsU0NHQ3pSZjhoRVE0TExvTVA2UUFwdkhqZlN0?=
 =?utf-8?B?OTByZFFPZzMySWRScEZsTVZKRHplYUVMNjU5THZnODR5NnY1T3dUdWdZaUhj?=
 =?utf-8?B?Ym5qOVE4dm5ZVmJ2Q2hvazBjK2NpN1hDaGxuQjZuUnVHd3dGSzNtclI1Qlc4?=
 =?utf-8?B?a1JvNHZadkt6aFVLWG5UOUdWUXlONzhkaDRXRURDcnhmOG1GSTl0aDVObjhz?=
 =?utf-8?B?M0hRSG9CWE1sL252RGlDMXhFYzBrVXQ1STgvRjlMZ20rODl1SDlQcVNvQSs2?=
 =?utf-8?B?V0wzdCtIbUhuOXRiQWo0UHQyOGxDMndhV1lyMEpDbmY5NkpTYUhxa0NLeXZs?=
 =?utf-8?B?aWJRckVPUncyNWNkdlZ0LzFyMTRyU25mN3FxQW1YRjJZTU5HUDA0SktHd3hj?=
 =?utf-8?B?SE5mSU9OMUJHRmpVVGh4byttTml6UUlYWkNzcjNsQXY3K2J3blJQcUN1YWV5?=
 =?utf-8?B?SmppRDhhU25vQ0V5ZGxIQVZDVUpOQWtSc3B3UUhDcnJING0rWWI4NnU1MFd3?=
 =?utf-8?B?U2MrcWNlZlBQUjQzSTNYWmY4S3NpTmhHNE51VXBEajV3NEUrRUFYL0pGeEwy?=
 =?utf-8?B?YjdmQmVEcnY4ZVRHbnVqa3lVeTI0ZlFKZ2JldkM4OUlOUFJrblRGUWc5WThV?=
 =?utf-8?B?WWhTSlVCS29pemVtRCtjU08xTGJYUDZYb3ZUOEtHZldxSlFGTTRKSkJQWW16?=
 =?utf-8?B?Y1phdVh1aHVVT2ZWeXloanpucnZlc283RFR4UVNFazV1Qm80NUw4MEY0ZWh0?=
 =?utf-8?B?THhDTEJwblF4b1pjVUpKb3h0OFlOOEltejNHc0xPTGhOeENic0Nzdm9YNUt1?=
 =?utf-8?B?R2Y0RDFNNHpzSXRlanQ0UHRKUkIxYUVZcEY2WnBidHB3bVMvamZaVThqNWFk?=
 =?utf-8?B?NzRUSnIvc3dsWWxzVGI2TDBpNUlzUjZsd2ZsUkhRSWN3RGo1c3JrWWRBb2tj?=
 =?utf-8?B?WXNnTkVJWG1XMlRXakU0N040YXhzQ2lxd3c0ejFsUnM2MXJGMTFxTmNUVlY3?=
 =?utf-8?B?NGtRb1NnWVZ3TkpQVndLUGg4UEJPbno2aU53TE96ZHdlMlFtVUdta0g2Ni8x?=
 =?utf-8?B?eXg0QjlrcUlBZ3hTSkthOTlRRnVFT05iMDBZL3hYS0NvNi9GRkx6bldUK3hh?=
 =?utf-8?B?NHdYa1V2QzVzaU1iVDNjemJQRytpcmhsS0tZZUd1dEhpM3YwOFNuZ2YreHgw?=
 =?utf-8?B?SkRqRVR5RTF3Ui9rK0tLOE1pbWJVU3d6RUZWSFY0L09GM2Rzbmw1ZlNmT3Bq?=
 =?utf-8?B?dmV6Z0k2Z2YzeHVsYitabDE1Umdpd1JBT2tZS1VNTlZPSjY5ak1ONmlHZXRJ?=
 =?utf-8?B?VldTOHdPZTB0OWtEeG1QM0N4T0FvcHJRRFdmTWRrKzRBM2NsR1IrWXdWbEpw?=
 =?utf-8?B?VGF4UUVhN0JXL21lTUJZdlNvNmhIVFd4eDk5TGYrMm5HQVhLMU5FTEoxdTNS?=
 =?utf-8?B?aWNBYmFnQWpvRzdYVWJyVjM3Q2IwU3ZFbTE1a1h1a0xlZURVbDJYVHhvemIw?=
 =?utf-8?B?VGkyZ0djUmlLdytNSXZsOS9QYnJXc2U3REdrWnA0bjQxTnRYckNuU0F0R3Ba?=
 =?utf-8?B?NUlnSGdLM3RSRklRaXhVejY2cFZ4QXNaRWdVUXoybWx0QTBHZTlPQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 47260239-7d96-44fa-3acd-08df082fae78
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:48:19.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmCe3IRfyqmHlN+1Up67iblEGbzH5q5Do0SmJOLxue/6MQavIPXMRVW0CCI2HmO2BGvZf77ujfDC9L962R1sPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3263

On Tue Sep 1, 2026 at 2:32 PM BST, Alexandre Courbot wrote:
> On Tue Sep 1, 2026 at 8:08 PM JST, Danilo Krummrich wrote:
>> On Tue Sep 1, 2026 at 12:58 PM CEST, Alexandre Courbot wrote:
>>> That makes me wonder, shouldn't we make `index` take a `u32` directly?
>>> If that's what the C API expects, it does make sense to align to it
>>> instead of forcing users to make a potential unneeded conversion if the=
y
>>> already have a u32.
>>
>> I intentionally did not do this, as the common type for an index is usiz=
e. Thus,
>> I do not expect anyone to already have a u32, but to already have a usiz=
e, e.g.
>> from some iterator.
>>
>> The fact that the C API did pick unsigned int as index type is an implem=
entation
>> detail the abstraction should bother with.
>
> Thanks for the clarification (and Miguel for elaborating - I wasn't
> completely aware of it!). In that case this patch looks correct to me.
>
> Note that there is another `as` right after, in the same method:
>
>   if irq < 0 {
>       return Err(Error::from_errno(irq));
>   }
>
>   // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved from th=
is registration.
>   Ok(unsafe { IrqVector::new(IrqRequest::new(self.dev.as_ref(), irq as u3=
2), self) })
>
>
> We could get rid of it by replacing the `if irq < 0` test with:
>
>   let irq =3D u32::try_from(irq).map_err(|_| Error::from_errno(irq))?;

I wonder if we can just change kernel::error::to_result to return `Result<u=
32>`
instead and have the cast there?

Best,
Gary
