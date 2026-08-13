Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020074.outbound.protection.outlook.com [52.101.196.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F344963A6;
	Thu, 13 Aug 2026 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640544; cv=fail; b=jmd2KMv6bDlk2UcX7bIPRgoEjbNc/LTtjKYHMGrodsqEFEtCWu4xp+Zjp6PaPFEYiCAO6deNX7JQMltecxdeLuqPqTUrSPMCA6nWnqy1J9F/zgGbAu/eZFQm9yRS1ymiXKIzlK585LaA83gpry8XCtsjOfhtRyVz63n0ZAPkviQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640544; c=relaxed/simple;
	bh=mQEMWnfeH2iqGx45HQKjLLCP9BEAEOn4HK3mU42CYLc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=EdtSK3zywJViOhsKkpWXKNNrGgH9hNoM35jsuoPcjPOT6luXJ4LGUiwkKYPyhI7Cci+CJQc++kBoSKFJNHTOlU8R3aN90raTtuVAjQLVsmYFk7RdRkgGJ1tDIckZUPszLr+PRz3Vu/BiVVZ5Yf56tmo3CIQ4q0HzHYs+N1+1/sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HeE8Cg9K; arc=fail smtp.client-ip=52.101.196.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HeE8Cg9K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWmpvs630P5j6jRgvBL7Ehpo30l75kLVGw/x3F/7x6ITFOD8tB2kX05EElUcNuQ8aih8lmckCTt0b9OH/tN5epHvu4e2Dkw7zCV50Xnqi7iGwwVdSxzQsRLnp+AJoK7Z3bjoMM2JE2mJZ6Ir27czWXnQLvCoe/wKe9j6WSLL+kCeIeie4aj58cB2JyZKUaZgGE28XL/nQSzpagPCr5vMHZEtxRdfahMxCato2WNdwHQEb9AAq6GmXSIQUSTesErY8Vnl0od6zCcCiBnCC8bAyRQxn9QCmcV7hTti2VQdHRXsFyWGL16W+UnCv+2goWhYz+UylKxHJA04z913TPaioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yUJ1arexY0RwuZVWHT4lAyT74lw2YC+2QZmg7sadIE=;
 b=KJisSz7AV67cB5O78ANNqIaDRDQwYeZV9SWlG6eHGQi599o/rxMbVTic3xfGJj9PVKqek0mCJN6wScGKspeXxeRWlemuA3BhWdIazb1wkSLSD2tfbFhmwVegFrjYnGyHDO2OD4o/MxVCrxELAzSA+xBwPAGMxOy+Yth9m8o4lekAQ7r85waHcSAzc29XR/dWN1bmMOiZwczdAmZgC4M85XbjVgI/c0BRfpL0BTA3oWt0ckmUmw/eDKXArm+7Wwh29lf4+pCJf9uUaHsQZkyCafKCMq6ad90CJ/Z3hMS/VcCqebrdU1vUj5wjiQ/q7IfmwipPEaLeUbLcwcjwAuGPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yUJ1arexY0RwuZVWHT4lAyT74lw2YC+2QZmg7sadIE=;
 b=HeE8Cg9KMXZwLoW9njUgwhx/MAM3MPiNWY9/7PmPqmigT5VlCMsmQwoDMfgF4SaEDG9YMtZACABt5pbO8ZcIG5H6WQkUxAc0K7DuxovDvHejOLMd1fMKWhyOLTswztgkiFoxH0cdAvr0JDmvFHp0nsSbjYQkM/8TynSpJ78cgDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB1845.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 17:02:19 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 17:02:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 18:02:19 +0100
Message-Id: <DKNZ7ORRTRA2.2WA4NB3PRLAOR@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Rework PCI IRQ vector code
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <jhubbard@nvidia.com>,
 <ttabi@nvidia.com>, <apopple@nvidia.com>, <ecourtney@nvidia.com>,
 <shashanks@nvidia.com>, <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260813165234.620555-1-dakr@kernel.org>
In-Reply-To: <20260813165234.620555-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0161.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::22) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB1845:EE_
X-MS-Office365-Filtering-Correlation-Id: fc620733-5819-4564-934f-08def95ca2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	YiyXRMR6aIsh3ZwuEkaChj5L6RtMjKKjkZMS0+enf/vKZTDoUqHzZq2ckD0/P4cAfmgG16PJfiYIje8RO3oXyL7+IWCZka7PYof0E+d8UacK1fM8sHgyHzE3FTQyawssQmK4/JW4kP6sCIZUq9LZE5Lcs2W5kEQ+FiDdSLZvg1n5gY2hJlCULARx98AxQrBp9AyFxokRTkU5p77C1ucBX2zYtbBet746iQnVrIZgzO0ger5DXK6vQu+LtEQm29hyvCo7b+0j1JI4PNj4NbVHscHP3uJazPkBCO8iC7kETby0e78klnYDCv5C3Ay5WoefeUNX8Osjo9bKj0RrsSJc52PkAiI49TQF1PJxxoub4bR8oqNuNPomMB+DHu14W8h0rFQjhYHPMTC1jOEZDRcDBhg4lNxuBNGfxluJLt9Aiw5HOh1v6C4cWVTqrCLKdedGC4u4c7TBHC1yBiIntAvMv1iIegmq/0j64lIhQMXJJ67QFrLEnIQrA9DwY30u78ZzAP/7qpYeYnFNX22w3X6hYJoP3faB4hxfSYczNe8qdUciEjgkdPyTpprdj07qmQCRWWy4zsR7EqNxdRCS256R03KELzwXJKd26LP7/GSwsR9Cj6BWIC4f1IHKf+W+FugUqrd55nhsPLz1bTd/5BWE3EYju3NdMfiLkrQxhylkJ+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVNXRERRMk9Vai9BUVZldHpLVzhCbGp6TGNVRk9JNFRlS0hMNzJUNFJCSGNz?=
 =?utf-8?B?cE5KWGp5YTFVYzZzVlQ4a2pFSVd2RStnMXN3NU0xNmYvVGc1blZVbk94Yldz?=
 =?utf-8?B?NWp5ejFIV1VtaGk5OWtSOE9Yc2RYQVZpNitNSTI1YkoxL0w5Vlg2eGtsTkdC?=
 =?utf-8?B?MWk5V1FTNDBpRXJmZEFUT2ZIaXA3Rkd0amNlMFNsdkVEQVFCUkt3NGs4R2RX?=
 =?utf-8?B?blJwWEw2bU5Ib1FSOUQrUGNaVnE0T3MwRlFjSStuUUJGNmxlTnJJLzk4MWdj?=
 =?utf-8?B?ZTB3N21PeG56S3JoeGJoVk41eTlDY1BQS3hkU3FNUW93SGRUcFpXM2t1ZXBF?=
 =?utf-8?B?d0FOaUZVaDIydlYxeDFub1VFL3IxWjNSdzAzVGh5TytjZ1RsaWZnZ09pVjZV?=
 =?utf-8?B?SkVTUTRTdXJwOUZxbkh6UUthWjVPOXVTcVFHdjgvbVJ5cWFmeTI3RVdRVmhR?=
 =?utf-8?B?dFhka21YamtSOHdXSStSZDRKa3ZkeHZaSkJyRlhYTm1RV2Q2MEpGaXFNMWI0?=
 =?utf-8?B?NUIxLzFjc1V2L1ovSWhxUGo5SU44bjF5T3RTaDY2NHYvTW1jWVdCMVJSTUs2?=
 =?utf-8?B?c015Z0ZmY1Bzb0FKS0dITER4Si9UKy9icjN5T0hza3cyRFhYUUh2Mnh0UXZi?=
 =?utf-8?B?K2JBd2RFTUpOQjJKa0ZrOFV2emtBRS9Wd3BhMnpFOVA5T3liK1J5SlNRcUZF?=
 =?utf-8?B?MEZVOFRaU0VxMVB5M0E0VVpVRjN5eWNWTmhEdkM1b2ZMeC92bkNZV0RJRW8x?=
 =?utf-8?B?Vm91THdFYS8vRko2WU9oU1ZiaEdPWkxZZm0zQTJYenJjSklCMWttTWk1Misz?=
 =?utf-8?B?R0FpZmtYN25UUmpCZGtHTGpvcnZXbStsWE50Qlpaa01pMGhUVXRpMXgyK2do?=
 =?utf-8?B?OEtSaUV0ZGl0dFJxRzM1N0Qya3ZaUjk5Y2FmemFRTmdtV3pEMGZRVlNQMmhk?=
 =?utf-8?B?aW1FWkZyTUxXVnFvTHIyelFqTUhjamJFemJzd0pabkhJYjU2RjJVWVIrQjd5?=
 =?utf-8?B?RGF3N1M1Mk9WYmpRMVJQbS94MGxyTGJsVHlYYkZoNFNjZ01mZm4xcXl1bUdY?=
 =?utf-8?B?Rk53SXMvUGF5T2hNbk91c3R1SFlrY2J4ZkJyTDZqaG85eHhkWG1FVGN1K1lU?=
 =?utf-8?B?TWpiRnluc2ViZXc0dXAxWng3d01ueTkyc1ZaYVo0bFhDaXZJTjErcEwwTSt4?=
 =?utf-8?B?Q2IrdTlOTXlKLzBJUEorWnY5NzdCNzFsRXZSMWk4T0pINUkvMEFtQ2JoRGFC?=
 =?utf-8?B?RDNyYkhlOUZPcWlFYmhKUVNlbnFhdmo0b3JEckNRR1JydXpCRXFOVkJ5c1Bi?=
 =?utf-8?B?clZwS001emNDMGlSOEI5Sy8vbzViTjlLU2JSSnJqb1gvd2I3eGd2QytuZitQ?=
 =?utf-8?B?cDJjL0F0QjhTTERKcmFNRnlleGxtZFFTcm1wOVpnUjVsaHBPQXRsUys4cWNx?=
 =?utf-8?B?RVYyemlmT3ViVUgvUW9iSGlLdTVmUHRtYVZtcVZ3YTVOR0xyRklTTDF0a2M5?=
 =?utf-8?B?M0NUUThvejlRNms3ZEV2YUxndjVCQTd5dGZ3WjZwYmJ5T3YybUxhRCs3bXFP?=
 =?utf-8?B?aGFwQ2dLNG1GRGRUKytMNXA5NGZ3ZnBkMzIxM2NVQllZbUFUdUh6Zm8rZkZH?=
 =?utf-8?B?L24wQkxsNVdJaTl4NXBleUUwNXJCcy9yYnhMUXJ3S2l4bXFrekdXNjNrby85?=
 =?utf-8?B?SEo2SGFOaDMwUGtVbG5DdG9wTEs1Z1BsYVUxZHl1NEQ2UGxlQzk1VE4yRHR1?=
 =?utf-8?B?b0RDYi9jZ3FjbW1tK0dMejBISzdoZzBRcFIyL0ExUTExTG1JQUp1Ny8xY2Js?=
 =?utf-8?B?cngrODAvK1RTeFd3M3ZpMlBvcFNEWm1ydGNTRXFTdUNHTElSSHJ3RXhWWDdv?=
 =?utf-8?B?cGNrY1Zsd3loUlVwbkpoU0pBVGpwaUNnVXVsbSt6RDlleS9mSy84TVluemVZ?=
 =?utf-8?B?RUtHaUNEejdnSVNRcFdlWTNXS3FRY0dxYnBTYTZoeGtWRG04M28xSEJJaHlG?=
 =?utf-8?B?cm52V0MzckcxTjZmNHU2WEcvOXZzSGRHYWJTWWNiTjBGemxDcGUwc09hTGRl?=
 =?utf-8?B?Y0d0T1hKU2p2cjg5QzZESkhhL0tqNGgwU0l6ZEZBQWJvaUVWeExPWklDcW1z?=
 =?utf-8?B?cmJoQVp4WnQ5ZFp3ZzRubHNqRU1xQWkvNnF0VG1ZakxtdlFsN0NKYkRWd3Mr?=
 =?utf-8?B?K1VlVmsvRCt3aXpxcDVOcEt1aUdTZlM4RDk1cjZacEhxWEpQa1pmbU9DaUl0?=
 =?utf-8?B?SDNpWDNXQjQyL29RdWtLdzhPNkwzM0hqanVoeURsUFE3M014dlJPQlpNbWNX?=
 =?utf-8?B?WnJSNnlPT1V5c3FkVzI5UzNQVUpOeWpoWEIxOXZKc3lFell2Sk85QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fc620733-5819-4564-934f-08def95ca2d1
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:02:19.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcduBg/gITWz6BokQapKMHBjEguoXn6WVGG6gcG+cIqXdz62okKSmEr/KA2wCWLZT0iCuKelyE9A9ay+bV2i0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1845

On Thu Aug 13, 2026 at 5:52 PM BST, Danilo Krummrich wrote:
> This series reworks the Rust PCI interrupt vector abstractions, motivated=
 by
> review feedback on the nova-core interrupt support series [1].
>
> Convert IrqVectorRegistration to a lifetime-managed owning type, replacin=
g the
> devres-based approach. Since index() borrows the registration, the return=
ed
> IrqVector inherits that lifetime, preventing the allocation from being dr=
opped
> while any handler is live.
>
> IrqVector embeds a resolved IrqRequest, making the conversion infallible.=
 The
> request_irq()/request_threaded_irq() wrappers on Device are removed since=
 their
> &self receiver could refer to an unrelated device.
>
> Add pci_irq_type() as a C function in include/linux/pci.h, replacing open=
-coded
> checks across drivers [2], and wrap it for Rust.
>
> [1] https://lore.kernel.org/all/20260808031120.363869-1-jhubbard@nvidia.c=
om/
> [2] https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/aqu=
antia/atlantic/aq_pci_func.c#L196
>
> Changes in v3:
>   - Rename s/count/len/, s/vector()/index()/, s/vector_count()/len()/.
>   - Remove redundant range check in index().
>   - Add missing #[inline].
>
> Changes in v2:
>   - Drop the IrqRequestAnchor approach and keep IrqVector as a new type o=
ver
>     IrqRequest.
>
> Danilo Krummrich (5):
>   rust: pci: convert IrqVectorRegistration to a lifetime-managed owning
>     type
>   rust: pci: resolve IRQ in index() and embed IrqRequest in IrqVector
>   rust: pci: remove request_irq() and request_threaded_irq() from Device
>   PCI: Add pci_irq_type() to query the allocated interrupt type

For the series:

Reviewed-by: Gary Guo <gary@garyguo.net>

I think the duplicate irq alloc issue is still worth solving, but I agree t=
hat
it should be a separate series.

>   rust: pci: expose the allocated interrupt type
>
>  include/linux/pci.h    |  25 +++++
>  rust/helpers/pci.c     |   5 +
>  rust/kernel/pci.rs     |   3 +-
>  rust/kernel/pci/irq.rs | 220 ++++++++++++++++++-----------------------
>  4 files changed, 128 insertions(+), 125 deletions(-)
>
>
> base-commit: dbaafe9cc56a996931eedfe043eb34418cc9cd9b


