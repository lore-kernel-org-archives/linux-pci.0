Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020116.outbound.protection.outlook.com [52.101.196.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12687411FAA;
	Mon, 24 Aug 2026 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572768; cv=fail; b=idM3wO52HQbW57qOCsyeOiCt6fL79SEJNc72v6n4BFY5j4A0q9l1a+Az+Q8emiwCBVazC4xGHJ4oZ1vph0/gn7auRlQUHXRGbdxEZaggpUI411PkoiAwEOQntajvWj5F5j7RVddGfNcRqm27R8K4pLp6LhtemPQ0tqK6qtByGt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572768; c=relaxed/simple;
	bh=pLpDjbJMDYyjpm5rSt9JVuhV7agbKY1AZS0CZdQv+HE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ekbFEDEmXZPx6l4SeKc3FO5EtlLUUpqIID29A2bC8hfcPYOVzjhjM0O4L5D/qn6TTzZOkkfY6mvjjBJG5DCXimlwZO38aIJ9q4OSH2uWnxCyK6o8qI+GW7CSoMCy4VC2Bz0sAAz/M1fX9MiYkTV4plAQ40lAwXaIohVi0A2wMHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kDT0bYOY; arc=fail smtp.client-ip=52.101.196.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kDT0bYOY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTg26jg2KYJYLDzbEnta1iQuz4m87kvlmp9d+7xyHP+SKStP+XNzSQgPXl/8P05hVKZJgR9i71lbwdSs9crHW9SXpMwNLNDv0zxms762eodGQoF/BtAoxYzNc+ESHVrjZgK11B9BBSjwAC7dJsDsgwZIK3XjovdVXSQ4sRktuHUlooDTGR4orEtdQQeWJ/TPeVPVI71O8QKuHQAigW5ZOjz6r5Lb3TKXBHONqEK7oKILtvyE9on2M55vLPv+y2+S4oMkP6cW7s7IRQJH9aQKtMDDVnfYYZ3efOnjN4avPdTDuvWr6gDLurj95O+puK718/XVa0Z1y0rJbqDc288+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqnzUgmDQkXbjLcd6NXE3FcHU38TFLHulsrqsGuRJcw=;
 b=c+rWqpAoOt88K3sZA7fH1w5r/PzScEYzV5DRo/4xwmMKFD2UasGkKgoXK1Sv/fa1MRQBRS55S6ARsZzW3ydTdpiZCU4CM4g2IoFAGFDe4ZBgZq/knSjojvUh7H9rPhsJ+6kUF+tqKyzoslXjW14vEfFzJRLhkouke2SgvNwxpxKOQ3zCN+b5UWt2tX6GsTfESOniagMe4ibP2qcsIvXVIlVbim9aT/Qz94sCtdJZr+Cob5pXkGt9LAfq6Jqdivhwl94NbzrV6Q3S3vEYHJjwnHXZBLyDW2INvUH8tDoZxCmU/uVcIOxfJ1vEA866PzXXgxFNROP59RBCarDoH9JrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqnzUgmDQkXbjLcd6NXE3FcHU38TFLHulsrqsGuRJcw=;
 b=kDT0bYOYt2RjERhNoIAqdVigDURhM7WDaS7MoDSDSgRzTU+ElwQ8Rdy765PYltLmioqgIQiTytngsy5zHKqVxNUsABMiXTC2lFLtKrQpv/oSeFhir4sSc+PglL9Wqh7nuLeTzv1Xb+KSrQPp4FQ8eXVTGwXyCQO3hbUS2FJ+Mhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB1943.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:59:21 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:59:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 12:59:20 +0100
Message-Id: <DKX5NPH3DNJR.2MADBU37NMZB4@garyguo.net>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
 <DKX45Q1J5M9O.27TM3TUTQH761@garyguo.net>
 <DKX4P05VHT0E.2O8M39SOVBVP2@nvidia.com>
In-Reply-To: <DKX4P05VHT0E.2O8M39SOVBVP2@nvidia.com>
X-ClientProxiedBy: LO4P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::6) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB1943:EE_
X-MS-Office365-Filtering-Correlation-Id: 3373d6e0-bee4-4cad-83a0-08df01d7224b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|7416014|376014|56012099006|10067099003|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	34wpy6I4TUTg4PJOn6/J0uEc34z02buenRu79XQYTQ7k0fYTkMzVPdfWI7esqG0/xHuh3Q+hHKT4i/i3of1/qXUK6Czu7YTo8JHjLhXZyNFKuSyaD7LmXxZvZ6UWg3giaVblhw/0qoiNiWh/XYJiCnbgBakl7nz4K41n0itZsAZRRdq9YcsWylVppPwoXxe2ocypltWybaiZP7X6vYSaTN7PE3ms+geR62UXNaTVjbRtHEc8BDinYSpBtDY8VsAerHAahjCIzn+0RnMbdUTCVXU2mZ/PH0tFvLCjvCpkyiilu2Q/yZ77BqoRC6yZ75b8kLbLLQO947sJQQfAQ3L59DGf2CBlhBLyFsgscrZ0bK4A10tef1MK1sQaZFKdsYrbzQpv509r03ZxTHH81XV8oW3KcI1RhlqT0DOmK+kkgGCTu9Bu9N/b4jJMSGkflGb2kjQU+5FGREk3HIvBCwIfao4tjCsASMMgjRTR0qbn7LUZxHQ3VTqvVA/+CsdQvnhOfFzd7anU7CZ/Sc7F2idyJFy0SkBR9AAubZsuy21kLqhcZBlnUK+W3byvUGJ9StY1+0fD1Ququ0cCgDKjJNWxT0KeabxMzxIbYdFJ+c9Yn8y76cAFd5N7R7fDhFlcdSdAqaWcpkA3au23nUfSizvEE1+fZpc1f7GK+WIvAwY6K+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(7416014)(376014)(56012099006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTAyVzdnNVRkMHlNUVdKRCtlRlFDYTF4MlF3bG5nZXBpejgyRXRvanJPeU1Q?=
 =?utf-8?B?MHZSU2NoTld4ZC9YT0xkK2xUcTRJWVFsUFdXR3pkV3l4cFNRRENMYXRHdXo2?=
 =?utf-8?B?RW9wWGtLemtXZU1oWDdramxTU1BGbGNOblNFSGxvbTRzUFpBTWcvWitvM2ZP?=
 =?utf-8?B?U09GKzhpZksvSXpYYUc1VDdXVzhRdUtnM2hRYmcxbGtCNG5wSDVWQTVQMXdr?=
 =?utf-8?B?anRUbmZnTWxCSW1QbUF3RlFIY3hValJobFRmNnVqQVJmbUJCSmxCQjltcmty?=
 =?utf-8?B?SThXaXJ2VzJVajFERzhLWCtXOFVPY2NrOEl2RmYyV0h3elVkUng2OU1nTXNW?=
 =?utf-8?B?K1pmQ2lJTXY3MDRxSUcrN0JzMm5wNGxQc2pUTHUvTmhtVDdWUEowOG1NS2RX?=
 =?utf-8?B?cGRuNCtaTVFSTVNva1hHWEp4RTlJZ0ZZc0I4T015T3JFcFYrc0d0SWowSk0r?=
 =?utf-8?B?OGhaQVVwQnpCemZyUzJIaURvYmRDZ212ai9TT0Z6L0dBc3IwVDBmMzE4K3lK?=
 =?utf-8?B?aGtTYUJubGxCNmtQUjMvYk1wNnFKcEgvQTI1TXF3Qmx0NzdrcWlzNzJJdmRH?=
 =?utf-8?B?K0pueU1Rc0drSmQzZEQrSThyWGRtY240UlNvN08vZjBZelRqdWlsTEhXRERL?=
 =?utf-8?B?YjB3Z1dhb3E3MDV2SjViL0lXVEFiQmpIOVVFZXNMNk9zRFdoa1NDaEJRWkxi?=
 =?utf-8?B?WlJnR1VqTHRDd01RcTRSNEF4RmNNYzBvb1hFRDlkclNXa0cwVEVrYVJJN2Nv?=
 =?utf-8?B?Y3B5aUFhQWJNZHdrYitpekZvRHpXalg3RkZaZEp6bEJzN0taQzM4NjdSTjhU?=
 =?utf-8?B?Z1QxREFFRzFLc1VJb05FM2YzRnp5N3BKUnkrczZRU2ZpemNQdktNajVkeS84?=
 =?utf-8?B?S3hWTWhmNkQxQWNHeDBDaGpYU0M5VHo0MEFrdVZDVWZ0TCtGWnlINnYyWDUv?=
 =?utf-8?B?RFZrN2FyVGRwV1kxNzFZeEtxcXEzeUlQS0dNMkcya1BpVUFsa1NJYWpaeWZ5?=
 =?utf-8?B?ZUdUdDJWYmorSEFYNkRwSVl1eHh1MXJZZThvbTkyVHdYYVNjcDN1Y3IwSDhh?=
 =?utf-8?B?OGlrclZvWWp5RDNteTJLS0h4TTAxeFFraGhzU1hRd1lvVVJybEdPOE9FdTJr?=
 =?utf-8?B?Q2RvNklrclVtSEFDYXJTNVZMdXpvRG52QlM3TmV3SDNMZ1RkNU01M1VDWndq?=
 =?utf-8?B?cml4dFFrUkg0dTI1VU4ybHZyZWlFaldrNG85dFdPaE1TblRVS0k4dDJKckZX?=
 =?utf-8?B?UEkwelZqbnFKWDFiTDllbDhLOVdoMDhlN2tXWXhsK3ZROUR1dzVxSGp2M0Z0?=
 =?utf-8?B?TFBXNWoyZisvUVJ6K2RwTFFiU3VNN3JOY2RJMlA1dmFvR0piSENoU1VNNzB0?=
 =?utf-8?B?a1VXdzVUVHNaNXhBTHc3MktIQmdKMHNYUzVlWkRLN0t6UWk2Ui91Sy9EZUJ1?=
 =?utf-8?B?RHNJTXhBTUp4RS96ODY1eGFXSmRISkFWWEpaNlFaWVhHN0hmMm5USmVkTFhV?=
 =?utf-8?B?WE1kTXYzTCtnei8zRWFSd0twZkxNUkZibkdhL3hQbTNYdHF5TDI5REl0MVRN?=
 =?utf-8?B?S3JVU3hlOS9QN0lwajYrZllRWWhEMFpza3FnWGEzNlJDZnF4NTFzM1h0NVBt?=
 =?utf-8?B?UzlFRHREblJ3SW1BNXdPOWIyVW1oV0dpbHI0VUtPbnNYKzFCWXd6R3lnbGRN?=
 =?utf-8?B?ekUvaXFacVJ6aXVjZkdHYWdiS0FpMDJYRmdON0ZhdVVsM0tjV0pucTk3M1Nr?=
 =?utf-8?B?Z2tYVmZneVEvMWpmMEpCWklpbm1zWDh0Ujd4cE50TE1WeG45eGNzeXFUTjgw?=
 =?utf-8?B?eDYrL2FnZDRKb09xNmFyQnI1V2hxUXNuWGRtUjU5c2p5aHFOaFZzZ2M5N1F6?=
 =?utf-8?B?emhBeHcwRVIrWnpma3N2V0xvMVp5VlRPdm9TcW1OSHluZDBneXV3SnZlMEs2?=
 =?utf-8?B?akZQOWtiY1QzdEJWZnVnZlU4TU41eFgwdUwvUXU3WEZtU25ESmpnS1VvVTRi?=
 =?utf-8?B?YStUS0ZKY3lZQ3FuVGlIMVpEYU00cHY1ajVxR0lhTjk0b2VtMCtybmlQb0sx?=
 =?utf-8?B?SjUzM1pPN0d1Nm8zaG1EeFRKZFRSbjFlT1JCejZHdU1QalYvYWpuZ2gxdHNu?=
 =?utf-8?B?NjJJbk8xSXRmdVVTMmRLZElQRy9jY3g5N2RacHpDV3VoUjUzME54S0ExZEsv?=
 =?utf-8?B?N3poV1M2R1psREhOdWloQ0tCNTRPcDBkUVhodjlza2U0WUJUOTNMVi9TK1N2?=
 =?utf-8?B?VEpCcmxRZjdxSDEvTnFnYmxncXQwdUo5eS9PUGdCcTZuZXVxRGo1RGtGbFVW?=
 =?utf-8?B?b3FibWRZUVN3L2hEQUJwczl4eGY4ZUFZRlhqL1pjZjd5TXRsY3h4Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3373d6e0-bee4-4cad-83a0-08df01d7224b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:59:21.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/O4BexLbFC+xrQZZtL8KEZ63ho3WPmRpHPfW5KBE7a5y7bNbgankLAmSWPEFv7EOdQs/YaEbeo4DOrrkwCHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1943

On Mon Aug 24, 2026 at 12:14 PM BST, Alexandre Courbot wrote:
> On Mon Aug 24, 2026 at 7:48 PM JST, Gary Guo wrote:
>> On Mon Aug 24, 2026 at 9:12 AM BST, Alexandre Courbot wrote:
>>> On Tue Aug 18, 2026 at 5:46 PM JST, Zhi Wang wrote:
>>>> Rust PCI drivers have no typed interface for locating and accessing PC=
Ie
>>>> extended capabilities.
>>>>
>>>> The SR-IOV extended capability describes VF topology and VF BARs. Expo=
se
>>>> this information through the Rust PCI abstraction so drivers can use t=
he
>>>> existing typed configuration-space accessors instead of raw bindings.
>>>>
>>>> Define ExtCapability to associate a capability ID with a register layo=
ut,
>>>> and add ConfigSpace::find_ext_capability() to locate and project that
>>>> layout. Bound the view at the next capability or the end of extended
>>>> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator th=
at
>>>> reads and validates all six VF BAR register slots up front, yields dec=
oded
>>>> BAR addresses and widths in logical order, and keeps the raw
>>>> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT(=
) is
>>>> a function-like macro, expose it through a Rust helper.
>>>>
>>>> Link: https://lore.kernel.org/rust-for-linux/20260804161612.776752-1-z=
hiw@nvidia.com/
>>>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>>>> Cc: Gary Guo <gary@garyguo.net>
>>>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>>> ---
>>>>  rust/helpers/pci.c     |   5 +
>>>>  rust/kernel/pci.rs     |   8 +
>>>>  rust/kernel/pci/cap.rs | 329 ++++++++++++++++++++++++++++++++++++++++=
+
>>>>  3 files changed, 342 insertions(+)
>>>>  create mode 100644 rust/kernel/pci/cap.rs
>>>>
>>>> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
>>>> index 4ebf256dff23..b946b14d79e4 100644
>>>> --- a/rust/helpers/pci.c
>>>> +++ b/rust/helpers/pci.c
>>>> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const str=
uct device *dev)
>>>>  	return dev_is_pci(dev);
>>>>  }
>>>> =20
>>>> +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
>>>> +{
>>>> +	return PCI_EXT_CAP_NEXT(header);
>>>> +}
>>>> +
>>>>  #ifndef CONFIG_PCI_IOV
>>>>  __rust_helper unsigned int
>>>>  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
>>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>>>> index 9f19ccd5905c..008c2770a3f3 100644
>>>> --- a/rust/kernel/pci.rs
>>>> +++ b/rust/kernel/pci.rs
>>>> @@ -32,10 +32,18 @@
>>>>      },
>>>>  };
>>>> =20
>>>> +mod cap;
>>>>  mod id;
>>>>  mod io;
>>>>  mod irq;
>>>> =20
>>>> +pub use self::cap::{
>>>> +    ExtCapId,
>>>> +    ExtCapability,
>>>> +    ExtSriovCapability,
>>>> +    ExtSriovRegs,
>>>> +    ExtSriovVfBar, //
>>>> +};
>>>>  pub use self::id::{
>>>>      Class,
>>>>      ClassMask,
>>>> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
>>>> new file mode 100644
>>>> index 000000000000..ddb3fd73e195
>>>> --- /dev/null
>>>> +++ b/rust/kernel/pci/cap.rs
>>>> @@ -0,0 +1,329 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +//! PCI extended capability support.
>>>> +
>>>> +use super::{
>>>> +    io::ConfigSpaceBackend,
>>>> +    ConfigSpace,
>>>> +    Extended, //
>>>> +};
>>>
>>> Let's merge this block with the one below, i.e. using `crate::pci`?
>>>
>>>> +use crate::{
>>>> +    bindings,
>>>> +    io::{
>>>> +        Io,
>>>> +        IoBackend,
>>>> +        Region, //
>>>> +    },
>>>> +    num::Bounded,
>>>> +    prelude::*,
>>>> +};
>>>> +
>>>> +/// Number of VF BAR register slots in an SR-IOV capability.
>>>> +// CAST: `PCI_SRIOV_NUM_BARS` is the PCIe-specified number of VF BAR =
register slots and fits in
>>>> +// `usize`.
>>>> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
>>>
>>> The infallible casts module is now available in `master`. If you import
>>> `crate::num::casts` you can now turn this into
>>>
>>>     const NUM_VF_BARS: usize =3D casts::u32_as_usize(bindings::PCI_SRIO=
V_NUM_BARS);
>>>
>>> and remove the `CAST` comment.
>>>
>>>> +
>>>> +/// PCI extended capability IDs.
>>>> +#[repr(transparent)]
>>>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>>>> +pub struct ExtCapId(u16);
>>>> +
>>>> +impl ExtCapId {
>>>> +    /// Single Root I/O Virtualization.
>>>> +    // CAST: PCI extended capability IDs are 16-bit values defined by=
 the PCIe specification.
>>>> +    pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV as =
u16);
>>>
>>> Same here, the `CAST` comment can be removed if you turn this line into
>>>
>>>     pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::PC=
I_EXT_CAP_ID_SRIOV }>());
>>
>> This looks horrible. I'd prefer `as`.
>
> Looks are subjective (or so I like to tell myself), so let's focus on
> what isn't.
>
> What is not subjective is that you don't lose a single bit as long as
> you use these functions, and can do your conversions without a `CAST`
> comment.

Aesthetic and ergnomics is a big part of code, and is what make people like
Rust. In a world where less code is produced by human, I think it's especia=
lly
important that code remains easily human readable.

You can probably already tell that I have very strong opinion about this.

>
> These helpers were merged precisely for this use-case; if you want to
> remove them and use `as` instead, that's of course open but also a
> larger discussion than this patch.

I was under impression that the series just provides safe cast from lower w=
idth
integer to higher width ones (mostly for u32 -> usize and usize -> u64). If=
 I
see the above snippet, I'd nacked it.

This is not what const generics is designed for and I rather view this as a=
buse
of language feature.

Best,
Gary
