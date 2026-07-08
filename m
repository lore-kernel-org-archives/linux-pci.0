Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020096.outbound.protection.outlook.com [52.101.196.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9964314B9;
	Wed,  8 Jul 2026 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512344; cv=fail; b=SscTeRX9Ui5rXT1+xbkEgQvWq9RKZpibvHX4M6XHdD146osvyOL9fATMKrM9yixrCplLPtUh3squH3eVMsurIrKxQtyH0X3D0n+Uw1XZRpJAhnwio9dDwUAB4cnasBXt5O7ObYTerrc9g2vDz5e5sjehttbI/jaJqPatFlSVFrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512344; c=relaxed/simple;
	bh=KM+yhD/2lu4D9Cz/UCHDHuYp9+bo+O8+EVVil7Hhfi8=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=oDrbcWXLPZlY0azvVonNf9NrSo48L7NLMi+beCaDZMdmEVaeEW7yqu0AjfJvJUZQuLgoNUyA7yRK/1v3mDJJg7O4G4rEcjLdtTiiHaC3vOd5bJrjN34z/kriwpUtGfdtZNbxifeaaR6EQUdL81oHc/HlFDnCZVmVUdQ+SdEvlvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vMyNi9xf; arc=fail smtp.client-ip=52.101.196.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vMyNi9xf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8fc53ErGqjk9gssxdz2ynHqXQ995UviHMeXuODSStDVt2ssveV4BJu7ZNYCoyt6tzeuc1tAD1++ksROaQltiIFTtaDarBNdca3SnorkYQKskcF+vovQ1JADojR0q8oK1OK1XNdhe/pWNLd6cPPcoYI6Rz2d0No0W8pMqmGlWUaMRwbm/ORCgrPrXsQFwHkW9C7tzNMzdXP6y236LR9STphx8BmbwiZLZoVqxnPX4QwIX7spWCdUv1XXFjaQTf9jc1j+2zGwKCMjJxvbuSTpMP1b83EJ3vy5V/Dz8fDjBKYfZB2vBWHHsOwcRb1T2vKGOe7tmiHymt+vhOjdY+h/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs3A3jKx9mXo0cQLWuBUqz8btk337I0lh2f9SHMb8SM=;
 b=qit0MOTTHmPvY4LNpFYw1CvKErbeJ06dOtusJdc6gAUVKR40/yZ27RMrqLr8EHOzGGIxRzuQoMWEUlt7CIo1U2PqXvZSS6xqbUnJmezP9m8LXp/7TUM2eLWZVhFwFwKeHAmq0QVfaogXD3gmmQNotVEILslJqOqn9N7qgKsjXcOOfaZ1Am+G7QAlrjKz7HONkPDBBnpKYVk+6OxpY0aoh8QLrwa3XQwHAy6ypaiAE9AvHIhdlqSAWOA9ogogMEjSG8FkuMbNgZiFWUCViA266s9NUmUvvK1jUaGrPMAeKe4kNNDqShwSZCiUpPbo0mkMVIHRn88vQ2pWAlm+TYu+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs3A3jKx9mXo0cQLWuBUqz8btk337I0lh2f9SHMb8SM=;
 b=vMyNi9xfhsMFvuughn6H8A/EpMMt2v02io64iC3jmIF/cHmKlnDQM2qga80WMMpeEhP6K+fjkLuZ+orWTP2j+Hrv7wjTmphFAgXBERue9jfRuveSwfvgmv+KUsxTtT6uQ4fxsThR/Wlvpj7wRhpkfgePPl+nX9tg7C39uwN9DJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOVP265MB8837.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 12:05:39 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 12:05:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 13:05:38 +0100
Message-Id: <DJT6CXCU2PRC.1ZUZFVVEDR6L7@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v6 04/20] rust: io: implement `Io` on reference types
 instead
X-Mailer: aerc 0.21.0
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-4-72cd5d055d54@garyguo.net>
 <88183651-927C-4A64-A3C9-BC5C4FE6C831@collabora.com>
In-Reply-To: <88183651-927C-4A64-A3C9-BC5C4FE6C831@collabora.com>
X-ClientProxiedBy: LO4P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOVP265MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbf84a9-39ac-4bc6-85c7-08dedce93a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	NFNAiwh/euaVf2Fyx1OZo59F+UwZmZ6WOG72oOJRI9pMvPlcwB/azsduyJnXYwGgbGb7kf+6joYLJ0MdXR1nrCQ8WSQTunNfzO1yvLGhD5sebWBZ11suSV0AZFt9hAYG++6es8leFBUzs8qOazFIcEOjDAuCTakW0hPQWn3eB7SjkJOmP9+BnhctUQyyRekgs3fRIqZpSpoEhM3dycExsxFtfTI0CQgar3/MIoFD63FLI7JJtkTQT0a7IHr6V93lv8J3gKqTf6nacADR5atDQFubB1IoiNKcmcQNKfe6MohMgR6RWdyiW8KxCUKlV8kbpnNdd3hidjM219Cjiap3SpYM4OM3gQHJcnYJM3iUO3J3zL+ne+FAO0+BsMmoBJ7fY+Zs+UmIL3rALkNmBhGEPKp3ckulM79HjGr0bKv7IZy5LRwnwJVk3KMyG2YcNxTigMHyRndpG5sSrHT4flVPn53VFCesb6azFS6vi4Fabd4NOlVfnRE5vocaC6ahC9ndCsFtFNt1K0lFVLKNDZ8P9nJnr45FQEzw+Y60wuGaUwGEHWSVrYR9nShMV45rooUl0q2sZPK80+ggGEET7iLJdaxM5Rz1kEM7Wdq1Af/cFOrpj6XTq9m8xihmBxgkF3n4m8Kvr5561RcIIGexg0RJVJdztFLkRMfRtWsH7mPP7uo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlViUndUaytUMUtLSGJkc1N5NXg1MDYvYUkxYmZ3bUo5VmRBNjFVTll2UzY3?=
 =?utf-8?B?c2JVZm9SK0xnZlNQeHhuNXZ3NW02NTNEYXRIcTN6dlFKTXQ4QjFOWkhvREUy?=
 =?utf-8?B?VWI4UklxYnNkbHRxUHZkeEZoRC9GZUdIeWdCREhGOEhtNTA3ZlErdU5PejVu?=
 =?utf-8?B?M21IOXZHRXBlM2Y1bHNvV0ZmZit1MWIvcHdSU1hNT0dRZUMwenV0MEtMaDJB?=
 =?utf-8?B?a0h6S1RwdDVLeG8yTk85NGtCcXFQc0VNclpFSjMrbDlkM2xXaVAxemN0QTgx?=
 =?utf-8?B?TThGQlFEZzZwMS80aFRhemZuZFdvZ2RqcjdsSldEdUMreHR1Tk1Wa3lYN0Ry?=
 =?utf-8?B?dkZzVFpXc2xwRFAxUjBlOG5heTdWV0hwYXJsRnhRcjJXN3FTci8rMU1EZ3dQ?=
 =?utf-8?B?cFkwM0UrRG1SblIzTlNrUUxBbmRZam5DejJYWHB6QUh1S3doN1FYdEVtN09H?=
 =?utf-8?B?OVp1MEpBVW8wT05RaW9yb1NpTmZNU010dU9VT0tjU2c4ZE9YaUVqSHA0YXZT?=
 =?utf-8?B?RGpldThKVGZJWnJUWUVmVVEzYS8yZW5WdG9tNG9pNWxuVVd3ZXdvN0VIQVk1?=
 =?utf-8?B?ZFZZTjl4NEcyYUFmR1JTV1lZT1l6dmtvU3IyVHZBQVlPaXQvMlFXUHcwTmtP?=
 =?utf-8?B?RnJzcjZLeDY1S201K1R0Z3RUSlZTWWEzYnZMUldzVXhPQ2hOUlZrdlVLckFp?=
 =?utf-8?B?MGxpb3hCbHJrMHEyWTA3MjRzREVXbWc3QmV1Qkg3a21JK2JFQWpUemdyaEdY?=
 =?utf-8?B?RktESXFZN2hscmwyem1nMWZXaG5vRmNnSkY1WUp3R01mSkMvL0dIRXZLVTdM?=
 =?utf-8?B?dW1FRDBsS2lXeGs2V1FuTGltMWs2ajBoVm55RnVhQit0V3RLTWVTd2s5em0y?=
 =?utf-8?B?cUdtSytkUWFvUjFWRmFFMlg2d0hrQldRNG1FMzZ2akxJNHN0TE04UVhFc1Yz?=
 =?utf-8?B?NHZTME4ydVdkMkhlY2xTaUw5VEtwMThNN01PV0Njdjd3UVl0NjA4TG9IWnJl?=
 =?utf-8?B?ZkxVZlBnQnhBVHVtNUpjbXZic0VMbldRK2I0NUI4ai8wNG1LUmV1L3M0WUVz?=
 =?utf-8?B?a29BNnlkNnVob0NxZW1WWEN0V0RrVkszRHlYL25rQWNLbVp2bDV4SkJQNCtQ?=
 =?utf-8?B?MU8xNTBZYWlVLzJ4bkpFTGxwQi9sUVJhQkxnaFpUS29LcVdWZmx4dWkwYVcv?=
 =?utf-8?B?R010M2xNSXdUcjBHTmp3NlBsaEsvbzY3a01sVWFhN1lEWGRrZ2JOQlVDTWFr?=
 =?utf-8?B?ZnJNUWs4aVgrZm84dkZubzRhcFRhTis4cVZXWEhrVlJtSks5K2VXWUM5VTE1?=
 =?utf-8?B?ZEkyNkt5L1BDZ1JLYjlTOHNBTk1nWmxURXFmdVhsanJITkQ4dEkySzBjQkVI?=
 =?utf-8?B?bU1UUmkyVjAwZis3NWZJd3g2REE3WVkyRFIzWGxxZzNFei8rWGYrdnJxTlZY?=
 =?utf-8?B?ekRPanpJdGM0SVZ6T2xKeDAxcjlCT3lvbTRwL01GdlhaY3dvVEtrem1TTGZp?=
 =?utf-8?B?c1dkRXMrMzFRUERxRTJMcVFUT2Qvckd3MXhYdkNBeUUvdHpOMUl1UDVaNGhn?=
 =?utf-8?B?cldEbGcrNEgveGlhQUQ0cXkzU1dxcXR0Q2t5MW5MSzFZYlV6VkZqOXBaVW40?=
 =?utf-8?B?OVBZVVBBNy90ZG9NeVZQOUdhQnl5MDF3ZkFkMk50bm8yeUN6Ri96ZGtHckJx?=
 =?utf-8?B?eXVMeEFSeHZqMVdsZVMzaHBDOUh3SUpNaUFLQWdqclpOVE0wRkZiRWR1UFNC?=
 =?utf-8?B?elFOdlNFck1VZ1JCU3BUR2RGeEo0SG9DbmpnUkFIQUxmN294UlVDdDFLMDZP?=
 =?utf-8?B?c0VsK1E0K1JKTzlsQmJoRGdoczZrbGJDTk9Kc2p1a2o5NHk2N3hJQVZWNkFq?=
 =?utf-8?B?WGppK0tkYXdISGhtZXJVMjRET29ZTWtxWjFwNkl5a3UyL3l0QjVHKzlSaDV2?=
 =?utf-8?B?eGU2bFdKQWE5Vll2ZE5SemNDa2N6cjQ2K0dnM0c2cG5NbWVFelVia04yK0g5?=
 =?utf-8?B?T1dnMG9rKzdFeVZDZ1BQV3BaeTA2Qm1yVEkrN3liT0EyeFBscUFLL0VXZXF5?=
 =?utf-8?B?Z0ZYbTdNRE5DdG5CdWUwRE1PRVFLWmNDT3JWS0lxdUdIWUZ2elBUNkpSbHIw?=
 =?utf-8?B?ZDByeGpDT29sUlRWRUNCMDdJWlgrY0VMbWg0cktjSko3OGY4dDNidUVGZG9H?=
 =?utf-8?B?K1VDbDM1cC9yOHc5ZzNOSVhhTVBwYmhZM3Q4TEZTMGNzVnNvdUtXTDYwNW92?=
 =?utf-8?B?czVYWEZtb0hUZTRBSXZLdVFRMDV2eEpXb0dyalZCL0I5blN3MXlmQVpHWStu?=
 =?utf-8?B?Nmp0cWZnRklUS0xBZjFFU2gyT0ZkL0NLa1pWeUNjcVZUZllXZ2RBdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbf84a9-39ac-4bc6-85c7-08dedce93a03
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:05:39.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjMLkE42PrRgUFkLJz14Q2ZbaSr8psh2xA2/aWix4ibG62ssOJxmd/rWSm/jalsG+Nbxc/T+Q7deT66OWqeHxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP265MB8837

On Wed Jul 8, 2026 at 12:58 PM BST, Daniel Almeida wrote:
>
>> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>>=20
>> Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This i=
s
>> going to change with I/O projections, as then `Io` needs to work both fo=
r
>> owned objects and views of them. Views are themselves reference-like
>> (however they obviously cannot be references, because they belong to a
>> different address space).
>>=20
>> To facilitate the change, change `Io` to be implemented on reference typ=
es
>> for the owned I/O objects, and make methods take `self` instead of `&sel=
f`.
>> When I/O views are implemented, we can then naturally implement `Io` for
>> these objects.
>>=20
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>> rust/kernel/io.rs     | 82 ++++++++++++++++++++++++++-------------------=
------
>> rust/kernel/pci/io.rs | 12 ++++----
>> 2 files changed, 48 insertions(+), 46 deletions(-)
>>=20
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Hi Daniel,

Thanks for reviewing, however, it would be helpful if you can trim messages=
 in
replies.

Thanks,
Gary

