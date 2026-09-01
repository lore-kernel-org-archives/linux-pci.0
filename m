Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020141.outbound.protection.outlook.com [52.101.196.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A536B91D;
	Tue,  1 Sep 2026 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264424; cv=fail; b=XFNjsyjaMZwi407VjgkIClzXVIUtrsSoZxq68lnF3Ju+aDLJSQ8ChJ4+72PgDzqizQxZMT3Jy6CRpp9jq45M3cAiOsqQWBIGIqdn3r2DrFhGH7bV0t0aVEdDFj1jWniEsjXkI4mwoejCpNLs1yyAdb/Ja7a6eYYN5QosdypyvXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264424; c=relaxed/simple;
	bh=sQOyoXtL9UOXyb9JYJQEIBOLAXvk+HA9gBTul0QXczE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=biYMPfVBczusxquoKBV6Tmki5HnPizNV3yie2NpFXPt1vRDhAmYMkjRLA8K5bQKV9FLB4TwmZhyvhjgKP8eCVsudGdZWYgKpFPAdELO3zB9GRmQfrojCGvgifqAvo7QB/PxNElGWKW+VQvVoz1RG54tqXHm3D2cKRkn4tR4Pe68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mhYVdWHU; arc=fail smtp.client-ip=52.101.196.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mhYVdWHU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzN9GUsDcsESbVj9iEOQ+EPs6txXoQZE4L849HL/uiX3dxm/LmPpnte+Bvd3AD2tKE171DwbOwyODM+GtRdhzMtr3iXCdUVUrEe1oA/I4xHNTAqTHLTFh4P4kYjiiv6h8S8gS1p+i1uNve/qoxGs5R8UMKoMourbZXaGdPXn6XOpjN235/II4dbSW5FLmMWUfCGZIvtqSXCtXNxFD+RZF2TiuS5jwmWPL2oHmVjLmEuWKiFDnSbtbImuoHrDshoXiVx2m8mxV9GqwPYz/6QG4bXnoVsI3++ycT7WTbkGSnDp+zevIgUdcg0rO8PrYcgSyZjxwky/HN0mh41c3OKJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQOyoXtL9UOXyb9JYJQEIBOLAXvk+HA9gBTul0QXczE=;
 b=J0V4EOym2De7UjyYOt0kPJErlsm7icqxSKcrx9K1egi+2Rw+AerW+lgl7s2qVY9RF5jxk0artOKsOcWAQV8fBZ7YjxWml89wsfOTTLzJGeurzU8CUgG6BtDMgrOET8J3DRKe9xT2g6XL803diu+W0Bqy9XTJn17zZb9nn/5uZCwsaUpHctm29mCroql3ImpbP/42MR0qtVMNIj6eU+zk7Z8W6BIvQdZh37cO/+qVcqShJBm6yBlWQucemEJxvAordXcaaaW4Bd+JYUzuzxNCv44M/kdMrvuppnVnpOSDJcKNPdxRTo5/bgIc0fo9yT1hnfBXNehcuPvfZDYlI//LhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQOyoXtL9UOXyb9JYJQEIBOLAXvk+HA9gBTul0QXczE=;
 b=mhYVdWHUmTixHuVtVUWxgcozz9eMGBnSLDHj4mF2PSWZkK04gvIeA0XvxV3I9nbRmwIKdmQjhq/8KAZ6/m+dLBha+d75H/AfiPD1G19L1yjY0MDclhnQ6gStv1hpDuHSGydo3A3nV0g/RCiA7nBkWk2tuKIF15IvfyK6l1T+scw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB5086.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 12:06:56 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 12:06:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 13:06:54 +0100
Message-Id: <DL3YTUU7W86I.29BD41EC3XI9V@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?q?Re:_=E5=9B=9E=E5=A4=8D:_[PATCH_v4]_rust:_pci:_reject_IRQ_vector?= =?utf-8?q?_indices_that_do_not_fit_in_u32?=
From: "Gary Guo" <gary@garyguo.net>
To: "ai qubits" <aiqubits@hotmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Sophon Zhang via B4 Relay"
 <devnull+aiqubits.hotmail.com@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com> <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com> <SN7PR07MB9708B6C36F40362265511D2ECFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
In-Reply-To: <SN7PR07MB9708B6C36F40362265511D2ECFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
X-ClientProxiedBy: OL1P279CA0045.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:14::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c10270-cd32-41a9-320f-08df082184e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|23010399003|366016|56012099006|10067099003|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2DXNjnrCfrhieqzRd4w9BOLAJBbKLX0q+P06UNeET3U2IMQRXZkNGRTf8F+HRCsKxC2/+cwPkoXFnbQk+cvtFSD8fg7D0U39nD3O8s/qKIjsSMLyvfN2Lpw9AXmZsB9dtre1tjBeVD0xkg+IYT5Qg9YY/JGajQwDE429Wcr1ceNRylgNnG563xggcHYypPHwo3W9vlBAsqGkJBImn3UCz43GYDB2g2yWt+VszR9FL1LNZ8wIVr2iefjMOweOiGPRnEpEeIdLwB7csIkYUQCmhK3U+OL8fYnlODKxHX+91EVxMGzdWj67L5aSn33SzED2jvLeVfDfz05bQeSEjywre+yBoyfna6WsXhkoaWR39VxutK7O2pNtHLGvIKv/a1Q9vdeqQzDhHOCz7c4KciR+c2zb7Ry8hTYa3iu7tJUxF4B8wfEBpUDClzubIGPZn++lV6hBeG6+WrRMAnJOrpk+tpzKonl1/T3ft8aGrrKQ2npSMHyYZbapbBBBssf+txuj79I49XRnfTTFlfiHiQ+JeXL8BCR7gyp5WzkT4Wcn/+v+lDLZwjQU+uSHWKzo1u48cKGymci+oScYwWXEBfU9f9NKwNiBqp2guWkfH84ZOG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nmd2Z05KMmdlRkMwcWI0QVo2M0xZTjNvaEJCdlg3R1RPYllFMXE2VWFtRHFw?=
 =?utf-8?B?RlYwSEVLdllXWE9IQTNValZWaXZNR0x6OEFXOHJLcFVXTDBhZVQ4VnNpVHdD?=
 =?utf-8?B?aU1rSXhueVA5VC9IdHZwR3paaFdOb3UyMk5zS1lGN0YxWEgzM1B1bHJReEhL?=
 =?utf-8?B?OTJjQk9PK2xxNm1pVnBzK3BmY1NuMkpOZFlqYXY4WHVUOVROdllwK0FOMjJv?=
 =?utf-8?B?cW5uc05MM0VxZ3hRa0RjQUh6WDRHaTJqc1BRdFphOUxlUDUzd2t2RWVJc2cr?=
 =?utf-8?B?NWJDemprZGxJNGtFNGJZbExUUDk4d0o0MkNVWERXTkVoamhVY0ZXcEhLK1V4?=
 =?utf-8?B?VXVnQTFsR3A1bW9taHF1TW50d2dVT2V4TmUwOENST3BjZlpSRUFTMG11T0RU?=
 =?utf-8?B?WThrUytRb2dDcHNIWmZhanl3NDhVbjUreEg3QjkvZzNGQlJ1bmlUNm1sZ2JX?=
 =?utf-8?B?c21LeGYzVGI5ZVY1SkV2eVdWOGJQQ1lLdE4rTWJlNTFHSlZWbGlYMWJSMGxr?=
 =?utf-8?B?K1JocjRyZTc2dUZQS1dXZGZFL1NDSzRuQWdxakxXQ202TDgwSWRvWjZocEJm?=
 =?utf-8?B?aUZNQVFnemE1bjg3Z1NEemE1NHlSYnJUQlY1K1dzelh6WGRHc1NOOExITkZ2?=
 =?utf-8?B?UXJZY1cveVpxMjhUdGdMdjZQTzcvWHdCVzd6Q2NUOGRHNlBrVFMxWXlySzRu?=
 =?utf-8?B?YlRHaUVaYmhZdUtCSmJmeVZoM2hwS1dkeUpDTDdxVnk0Um5FTUxEMjVqS0Zn?=
 =?utf-8?B?YmJ5STRycXRQVzhHNk9tTU00ZDhGRHc3TWRwUVJ6dXVxTzBKekxZc3ZZZ29u?=
 =?utf-8?B?YjNsOE9LcVZZOFhSeVZUYWJpcXA3QWZ1NmlvTDlkNHJPN0Q0YU9uTzNMa0JO?=
 =?utf-8?B?c2tUczF4bDNHMWt4ZUIrTTdCSXdvcmNYWkoyUjRNZE9hYkN0dUhBVGRHMVhK?=
 =?utf-8?B?Nk1Kd3BPYmI4YWpiK2dldUx5RUZFY0g1QktPS25TbzZDdmN3czlXY05FZU90?=
 =?utf-8?B?LzU4UjF0ZEloTjBkcm5zTUQ5eGZsNXZINStsSXhwV0NMUURXV3hhcjZzY0Er?=
 =?utf-8?B?dURsUmowcEpxY05yTmlLdHYybE9TK0hpd3hlZkNkZHJTUEFlVHJEaURXWDg2?=
 =?utf-8?B?T1BKTmlRYlo3MWpkcHpCUTM1ekZzY1BDM1haVVhnRndQY1IwQjFxbW5IUTVr?=
 =?utf-8?B?Q1ZhOWU4Ry9qMjN1Yk13S3NTakRJUklGUWpHWGdvSWEzN3h0eFd1M0JQbGpi?=
 =?utf-8?B?bkl0T1FlNHZFbFhLRlcvL0d4WGdVQ3dTeWEwT045TjJxYThTNkRiUTIrWHdW?=
 =?utf-8?B?WU81R2tRVFVUS2h6b0twdkNndEluUVZDT1dlK0dNbFhXcTRkUFBpYWFqQldR?=
 =?utf-8?B?dzZBMm4zNG1rSUwxOE91bGs0dFl1ZkNTdU44NXlUMG02Y0hHc3MvQzJZR2NF?=
 =?utf-8?B?SnZsZ1Q1eU1kcWJjclAyNk1EOE9abXpZdGM0cCtxZGpjQVdTZFFPTnMrdUsz?=
 =?utf-8?B?YXpxZTZEUjZ1MFdqWmY0cWEwdjBneGcwQVdrWDZ3SXFTc0hGMllHTTdmNGxM?=
 =?utf-8?B?eGRnbUZ1UGdNV0k0V1NFT2Q0TWx0TVhXcFlPcUovM3BQK1RhZDJTQWs4OFlv?=
 =?utf-8?B?ODdBckpXc1NsaWZhVHg3WVFxbk9WZm1iZVNLZjl6cG9Hb1VCRG9ZOUF3cG5o?=
 =?utf-8?B?L2Jhekx3R0xZYUhnaWpJaVplRG9qaThiSjRCdXN4SWJYV2xuNzllMzFpb1Fh?=
 =?utf-8?B?aDBoeEphQVE1WlFYbWNaZzc2cXV3OWJ2cVdBeTk2eXA0c2FxU0VpenVieHc0?=
 =?utf-8?B?VkorZEsvaCt3aUVLWWozQ29uNGNhT0hwU2FlWGd6cUR6M2xIaGx4NnAzSnlh?=
 =?utf-8?B?QWVKUXZLRTQwL2c4L0cwaGJpSXRIRXZtdjlYNnZGYnZoMnlRbW9NNGl1VEZC?=
 =?utf-8?B?SUs5ajlNTnE4Z3dxWVJHV1Vqbm9mekhINENsTlQ2NkZDWG15dUM2cnlyT1A2?=
 =?utf-8?B?MElpRko2Ym96eXpjeHpmZE81dWhQZk9oL3RJUGNjWXdlSzU4RFRsMTM1VFpk?=
 =?utf-8?B?Tkk0ZzgyS3JWMW1ZUHhKYlNSSmtXWDFjRmJ0cVRPNkEwNnVMSVVmZmtkSmVm?=
 =?utf-8?B?NXkzL2pqRko3cUhLZG9jUGJ2Tm5La29kaUE2amJlZzlnK2hxb3lVVjlVdVI1?=
 =?utf-8?B?ZnluQkRNVENLK1VLenEwWjBjZGVqdEFGZmw5YUJXeFVRdzZxSm0vOHVGT2pD?=
 =?utf-8?B?MXhjd2p3bHRjbDc3SWlxcXdqeVhJcHovdDdSdVZnODNmUVNoV0c5RkRHaXdu?=
 =?utf-8?B?bU16WS96KzFHclpIRTlTb2Q1UDVKa1hrYmgxNjUvMGhxTCtPYkl1dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c10270-cd32-41a9-320f-08df082184e7
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:06:56.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUcFwl6ghLfd1fok9It2unzrjJoVnIRo2aRmXivJX474Fifqw3XWucSEEFXSV2S9YHZnt7oci8GCiLVzvCrOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5086

On Tue Sep 1, 2026 at 12:47 PM BST, ai qubits wrote:
> Thanks for the question, Alexandre, and for the clarification, Danilo.
> =EF=BB=BF
> I agree that usize is the more appropriate type for an index-oriented
> Rust API. Callers are likely to obtain indices from ranges, iterators, or
> other Rust indexing operations, which naturally use usize.
> =EF=BB=BF
> The unsigned int expected by pci_irq_vector() is an implementation detail
> of the C interface, so the necessary validation and conversion should
> remain inside the Rust abstraction rather than being exposed to callers.
> =EF=BB=BF
> I will therefore keep IrqVectorRegistration::index() accepting usize and
> handle the C API boundary internally.
> =EF=BB=BF
> Best regards,
> Sophon

Hi Sophon,

Please avoid top-posting. See
https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying (a=
nd
rest of that page, too).

Also, your email contains byte order marks (FEFF). Not sure what clients ar=
e you
using, but please pick a proper one for plain text mails.

Thanks,
Gary

