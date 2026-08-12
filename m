Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020090.outbound.protection.outlook.com [52.101.195.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388A478E36;
	Wed, 12 Aug 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558191; cv=fail; b=AeA8NdgpGIYoUQNRVDcjqsgwaYeIBs7SVz1AKNuI+iJvQYuJ39FzzG8mhkmMQfOxpN8i6kVWiDx7F1XURYGmphDmVVZ9f16a1an+tDMtaSWYIWp6rHFtCGh9kr4ppX7QX9cWeW1yGYvMauuw4DySZpBMDrl8h1q4hGrO9f6sico=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558191; c=relaxed/simple;
	bh=rBoyzPJyEYXYa6LW7E1BUj+ZZsBfzAcmpqhAdFW8BGs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fMvHXTyLX+B74wg3TAuT1ItjRFiGCcOHsqK9aDPh4q96P6qgpvusRkWTW3PNKxL2X8tnNUysDhy8R/pUihZ1OSeKRgbkG62fKxvt22u2WHKllP6pky13uvGRHHFM5Z8fHm+aniczClvt3LsW4JGr6a0IVI6Dx7iS6n3/1a8mXNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HydjyRPU; arc=fail smtp.client-ip=52.101.195.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HydjyRPU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8dG9gXY9lrUBTcSpzF1BIdU6XsXmTjkzGBmZthX6GDmBIe7LJm6Ir4e+t0KY3vdlVhJmWAhRVhhz7njTo81t2mYejo1QN6/+ntVGk8YYY+/gh+vG8YDDXUgrF6XYVokwgfOWYIPaL1BkzbM/KWVkSPDXWJaBMmfAkrBsOo7AvH9A2TxbQnkRyASgz9LdWUu4kOSE+Ul9E92dERomV6C4Y3O0Flkb9A6jQ5tcSZQZF3uWPlgqE6gwSPdUSFlVYSKRg4OenemD6oFTSwSvcph9h+VMwzeS+ocHaCgACgHAcE9JhRxVX3PtL3jI/PIKj4XtmwM5QU25cItbKBP0rapIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGIjtIBlB46JMVdIL1Mf/MDp0RAUsT6obKzJJB8z1XA=;
 b=QkJsRAdWQ0swoMNzSmpt8QchmjBpYXMyCgzRD7ASM7x1Jmxz2TT6QYSq988V47jkHybLOFQ0j4UStdgggC1yl+ldLoZQPUnIn29lwY4j7hsikDTrUGUx5aXimYNb6b3AFcaGST6rDOnt7PhQZ7/RrgedGraOAXcKl7GgeO3x1k9NzjAVQeEwIna8auZquWkTYyaqK84hRpRtKPlsCzWJWSyiEG9EmLrvj955KxCd4LKmcaxbuPkLnzI51JUJ5BwpUUmm++XheSzkThlbGNB+CheYKbiXsejhS+gyIuXp+OWW3gAxslaaqDEgoGnP0AgKP8iT128nTOWEvA5zkPn+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGIjtIBlB46JMVdIL1Mf/MDp0RAUsT6obKzJJB8z1XA=;
 b=HydjyRPUZG8HMr5V5nJghbeU0KzCBGWwygfs6wTnyXgOg7HNlWkjIsb3YNVsHUL8r4RLctvudjqNcOGmW2MsbZE2QxLH5cUKfDiJfDKaVXc3yEDAFhC7bR4qvXCll6VjMijWkksi6hn4KbcEItkk5C9t04Sc3K3pr7hJ2I2Zzws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB5570.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:287::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 18:09:42 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 18:09:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 19:09:41 +0100
Message-Id: <DKN60QB0522T.1IRNS63F2RMXG@garyguo.net>
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <jhubbard@nvidia.com>, <ttabi@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <shashanks@nvidia.com>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] rust: pci: resolve IRQ in vector() and embed
 IrqRequest in IrqVector
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-3-dakr@kernel.org>
 <DKN432T77NWT.1HRUZU9DJ9ABH@garyguo.net>
 <DKN5HGXO6M7E.1SL8IATHZFUK1@kernel.org>
In-Reply-To: <DKN5HGXO6M7E.1SL8IATHZFUK1@kernel.org>
X-ClientProxiedBy: LO4P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: f438fd4a-8ce6-475e-fbeb-08def89ce1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|376014|7416014|366016|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8uUm6B60twtgeoTQ6etQLtUI6MNYmQo2J1y9/loP3B41lGi7S/WJbZ0I4OhZV2rZK95fULIy0Vt2gOQhQEkIUMic+c1Z2qc5glGdQZQ6khvN8Hs127hilYvhwCCZehoySFmuRE77LoMBhK2EtnkV44+ALu1IEExpaQEpnTvCG9z4bVig0DMaSzEgvS1mic9xeuYsx3Te1Ix+n5LDhBIs8nouARgjwPLrfjlz5MJqhwgUPGb42FbRgBceeut+nTtLE/oOnbfH0ujFpmgDU8N5VeJCfcJOYsTPAX4o4XqPS2LjnlvG3/NLuBLF8+MVK6zsRC4WA6zmorgIZ9yh9egke1ME/uikuTeIdnJ+1LLweH5S+L9u1lUAy6BEH/4cAi1ua1IQD7SS6t1EhO3PoFBJGYe6vvysCP4vS/p1WQHV8jA7i1aicCQGriaF5hy0I0AoG679uldV2SA0lCQ1QWbQ3ZvundpYNnq2pi5YxatYlBZuVCv1tM5xpQ/MVhr93gvQR1jqXIxe672vFi5mSaoYQ29Hg+hpy5Oi83n97pl7AZqbdgyA4trE3TX57C4xFyph2ZTkjQtFiHRJxOwrmv0CnXgygeOJWn1YthV9h9Z38gjmA4L+urYQY1RX5qdiYwoGOZUoVHotl8KEIn50c+uqleUDMl5ZeQEbfTUj4NPHsCs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(7416014)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVJmaGZSWDVFY001SzZaMWU3U09BWmtjYWRpOEhuTUxxOXI4OU04a3B3TFpz?=
 =?utf-8?B?dDRSOTFicVhaMndmNXc2RWZzZ08ybEhRQzZXU1hicDJabFpEa2pQNUYrSTNW?=
 =?utf-8?B?WDh2UXhFcVB5V28zQXpqT1RNRklabmhzb1E3YVhJcndyTU8veDJoRTJQSHJY?=
 =?utf-8?B?bW5sa0hHMGw4bHFUcmNkTkFFV2JBZkZZWk9BQVQ0S3JpMlZ0cEJ5Y25NajA1?=
 =?utf-8?B?ZzZURnFKbGxITW4ySDNkajJVWDJFRlFocGdxQ3NyemtYUGowTEFkQUdIVGND?=
 =?utf-8?B?ZlBUTERRY2xTanFSeE9XeXlnZ0Y5djBkRHFXN2l0TDhsWjFGRFNqM3NVVEVv?=
 =?utf-8?B?eXBlM2ZWdFIrOHVDaEdaU3dPRDJta1Y1cTdLdHlmcy9jYlFrNUEyUEw1THVD?=
 =?utf-8?B?VHNjb2x6YWJIQjNLTkF1bENjdFhpekxPeDNaOXpjZWdQZzdaRkVKaEh1ZmxD?=
 =?utf-8?B?RFNoRllNdWhId0hsK1paYVhBZEdtNDJQRHB1eGp0WnN6bkxqMnR5R3pBOXNJ?=
 =?utf-8?B?QzgvL0dtdVpEdmlJMThaWmRjWlVKSjd1Rml2RlpYaUdtdEdobUVobmdqd3dv?=
 =?utf-8?B?QVlIelhyRE1WWFF2M3MrMVNQeHFtdmJVQ1dycDZpVGk5ZFlveXVMbFk5YlZC?=
 =?utf-8?B?MkZEck4wVE4yMnpyRWprc3A0TjZYUWgrZm1aUlNPd1k2VlJZU0F0NS80MHZu?=
 =?utf-8?B?WGFaUUN3S2NlL1M4Y1ZIYjdyTkZLbUNDSk56QlEzWkRNOG1QQk5IRndmQnpO?=
 =?utf-8?B?K2d6QmZSQ1BoRzBiUUxXQU5oRmNZdWlNVk5jdkEra3dpaXNOQkdiTHM1MGJY?=
 =?utf-8?B?dDVucVVpT2xsVHRNKytNZklrdE5uS3I1OW1TYldNYU1rME5wQ1RxWlFzNkFB?=
 =?utf-8?B?b084ZGJJR2h4eVBmeFJweXRaeXJuR0dCQzl3YnZKYTZKVmhwdHFaTGd2T3ZR?=
 =?utf-8?B?dmFXN0swZE9JT1pScGI4dmVQaFBBaUZEQlZwVkt4ZWVjbXlaQW1tZjQvekxJ?=
 =?utf-8?B?aWp6RDBKVzNFZW00UEtzVTZZcjV3Z2V0YXBRMXVpeHdZaUJ0d25WTTBQanNU?=
 =?utf-8?B?Uit1VmFyQjNzajJBSDQ2M2t5NHJ3dDRndUpBQS9zTWdSTmVpMzlhcmtZZldt?=
 =?utf-8?B?cjErbWVEMFQ4N2ljbXdBUWR2enNDZWRBdzF0UXc3am5haWZ5WStZODR0Wi91?=
 =?utf-8?B?VXlNTXRYMTN3NTJUK3Y2bDkvRmxONzR0Z2k4cHpGVjllcmRpd0JQV3R0ZER4?=
 =?utf-8?B?T2Zpd2xYak5MWlFWSjZqMkJhZ0kySUVkNUdKKzFwY3pPdXFPQm1VYXBhek9D?=
 =?utf-8?B?SFVvdFBPN0JrTWVnU1I3cisrdmpUemNIMUh0SDQrcjZBYkxzUEFUbzlPNzYx?=
 =?utf-8?B?WkNYYjA2cnBCcjh0MTN1cTFxQUdrcGxaK0t6S24wQ3VVRS8weVpxQ0RiSnkx?=
 =?utf-8?B?Z3pCY1VUOHllT1FwMkJIMzdBcEdGVTg5bHVyOWtjYWc3NmRwS2IzdVpjMjAv?=
 =?utf-8?B?bmdyeFcvNGRVUmNjdDhEZ3g1aG1lQnI2VmNpWHVDdW9seXlEazRjaTV1QXVy?=
 =?utf-8?B?QURyc3QvOThFT0JVYjEyN09VUmlVaXNtQ0NybDhYZjBsbmw1MGxZZnJKRWpj?=
 =?utf-8?B?Sk9SSnova040cjRmQTM4STJHVlF4RExhaDdGWWxERDIyK0ZuWDBOT3RUNU1u?=
 =?utf-8?B?SnVJdndjeXlNTjhZVk9FTk1qQUtoTFV6cmRXZW0wUzE4R1R3eG5HSXFTdjIx?=
 =?utf-8?B?a0JSVzlzMUVpTkg4S2tFTUJsSDhqdFM4Um1LOGZlKzRJbEhlTmFtY09EM1Fi?=
 =?utf-8?B?Mll2dHd3VEJyTmg0cWI1NEpLM1hSWnFRRE13THQrWjlDcTJDTHdUTzdSRzdn?=
 =?utf-8?B?dnpmTDgxRUd6TitPR29WOGFPYzZ1MkFEU0xkZGNqQWJIVnpHWmNwSVl3b2lL?=
 =?utf-8?B?dkZ1RXJ1V3A1NjJ4dXVLMnJsdHVBRHJhTGI3QnZHZklXZUFFVGJRSmM5cjdo?=
 =?utf-8?B?WWxZaUYrYWFibGhHb3hSbURpa3hqSE90aUlKS2s3VjV3Rm1BK3pVQlBnOGhX?=
 =?utf-8?B?MzBySGNOWSt3WHlqS1UwN1ZoU1V4WDdsM0hKSkxuRUFDVElEY1daZmw1TE9W?=
 =?utf-8?B?WHNrNkpCNXY5bno0eEN6MGJ2V0pRcnZQeXB4Q0R0NEFVemxXNW5QVDlMQ0dW?=
 =?utf-8?B?UFVFWng5Y0d5eVJCQUQwcGV6Qzg3bE83U0w1Y1ZNSE9ZUzBmald3ZTRqZEk2?=
 =?utf-8?B?L1BrcUNmd3JoKzNaLzVOUHVJNXhoay9sRklieDk1VUNRQlkxQ1FGaElIaStF?=
 =?utf-8?B?aEVOZXh2dHBXaW9icm92VnROWk5USytVUGQ1aXQ2ZmFUNGxQcGtZdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f438fd4a-8ce6-475e-fbeb-08def89ce1ff
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 18:09:42.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGuFtfHeiX4KxCwgQ+EMOpqCK3BSDDO7CeL2FG+8tLF0mKScA42ArSBo6LgesfA2R4v0yHDKR6l5bzFoiTuTNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5570

On Wed Aug 12, 2026 at 6:44 PM BST, Danilo Krummrich wrote:
> On Wed Aug 12, 2026 at 6:38 PM CEST, Gary Guo wrote:
>> On Wed Aug 12, 2026 at 12:39 AM BST, Danilo Krummrich wrote:
>>>      pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
>>>          if index >=3D self.count.get() {
>>>              return Err(EINVAL);
>>>          }
>>> =20
>>> -        // SAFETY: `index` is within bounds of this registration's all=
ocation, and `self.dev` is
>>> -        // the device it was allocated from.
>>> -        Ok(unsafe { IrqVector::new(self.dev, self, index as u32) })
>>> +        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct=
 pci_dev`.
>>> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(=
), index as u32) };
>>> +        if irq < 0 {
>>> +            return Err(Error::from_errno(irq));
>>> +        }
>>
>> Correct me if I'm wrong, but I believe that it's impossible for `pci_irq=
_vector`
>> once we have allocated vector and the index is in bounds. (If that's not=
 the
>> case, we should ideally fix that instead.)
>
> You are correct, as of now it is unreachable with the index check above.
>
>> So I think we should just `.expect()` on the error in `Into`.
>
> I don't agree with the conclusion; I don't want this code to rely on an
> implementation detail of pci_irq_vector(), which (even though unlikely) c=
ould
> theoretically change.

I think this is expected use pattern of `pci_irq_vector`. Many C code don't
check the return code at all. If we want to mirror what C code do, we can a=
lso
just drop this error code check and rely on `irq as u32` below doing the co=
rrect
thing.

For both this and the EINVAL case for patch 1, my reasoning is that if the =
error
is never going to happen, then the code shouldn't be written as if it does,=
 as
it will only add confusion to people reading the code.

I view these essentially as invariants, just not spelled out because it's
written in another language. In this case, basically you can say that
`pci_irq_vector(dev, index)` being successful is an invariant of
`IrqVectorRegistration` type.

>
> If we want to remove the redundancy, then we could maybe drop the index c=
heck
> above.

I think the index check should stay.

Best,
Gary

>
> (I also prefer IrqVector to be a new type over IrqRequest, as it also gua=
rantees
> type wise that a valid IrqVector will always transform into a valid IrqRe=
quest.)


