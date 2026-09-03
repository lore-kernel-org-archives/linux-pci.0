Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B047DD77;
	Thu,  3 Sep 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430482; cv=fail; b=PcyYLqSMyBz8E1KU5bggbKMd7BK6JTcD+Bf5fToWkbWxxrvkN0s52yOq3Mmi+toPtrD1IM6dGtdGD5oKLcp1ILK9QwxDqWUkuHHRjkGy7F2RL7ac3LYE6dkhM4BWCZiKuq5ydzWkaMrSXteSR8VS4otOi9EFaHwAMVZuMJwjNqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430482; c=relaxed/simple;
	bh=kzg2AmCzZMxeipeMWMdFgGRIgU3Z3LHTHqnK/KC97s8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=afKb+OEOO/wf4X0uvFnY+hI6TO553phGJj30Khx6oTygp5A+oOM+T/sbDqEiSUkiAfuFSZCakkufovLIA5UXjDspiB6P6tmyrXYBRGhKPg17KAJSodYtzKmuHWxdkP1OLOhmZx+nk8u9/kWYfwByZAOtYTSvXieeQUVhow8Wf+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M5ZA920A; arc=fail smtp.client-ip=40.107.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M5ZA920A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzg2oHYK3DavrbcYWCWcpXkqLWIFnOt2bDmQZ1esWS31aA4rhxuy3rLcmezwLlUKC8c20e67HUP6Ds1aKJjsvO/6lKWxG/oKrfx/Rj4L5EVdWZZV8M3LNMWla5gCF83GG7P6Fnh/26+RmaXlK9c7FRmpldwz4J4MhhOmCQV7Xqwj3PP77gVCLlFAtCCf3k4MYn1aXSzLTjPJDYNdhuJO12QvB1sGzhE1kJG7Ovbv+sNRhtghtQV2+SM/TujoCGDrzWqNTKzWWXfgl/JfErOTMEeuDV9rD3osIL+NpL7UDV8sOHq944tNc8Sk5Vrk23VuqyycU9TvSm0MSg8lWr+qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smaMVHPE9N+1NVWu9MshhnMKxoySnmm8jnIkITg0LHM=;
 b=xPgfNNrqOaLJpHXPtVlIhIPSqEoGHg39aykeP0bVYKlV2lOBSYWHRR/pVWPaQFli48s0EHvIQ0P07G3ko3yTq3ruuIDI3ffLFBCN3CUxzCu0r2aIbN98bnj0OsYRvO1zMqsKf/K552bpuzFDk2yKFrZV1UEr4qGNkpOBbvayG/4UUM7Peyh3DcY8F/ofSLNZmXn5qHHbUD6xTEUvzBgFNBiGZhSg/qLE3BLWsYaA1gZUKsTQDWoF10IdJGcn5qVd/yYLFY5i0GTQghodPAlPFyyViSTxusK2IIYdvwNU8xu/TPRysPkFluln4Lv6ojZ33wsRiXbUOaNh6nTFaWmu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smaMVHPE9N+1NVWu9MshhnMKxoySnmm8jnIkITg0LHM=;
 b=M5ZA920ALhETFPcMmgtCMZHDGLI4tD+i1FPXMHnplPzgjugeOk5LnjhZUfcCr/pHoJYmboEM7ILuISt5Y3wdsuKc4MfyUA4H/HWuEKgzAtF+LhswxJO154aBTfCfMHXKUJy1XGF9S3Yl0QfDSsD1Zefb/yQdGPvMqziLcrQTOwSJdIRsIQa7thFgOUymgGcPLHzbYjQrp1A6MbqUHluh6SRYxnlGMvcJPRW3q5fY+yjePAWx/wkWDvvyl+CvSsm/VQ8u75YiIBZxj45Oujdz1mP1M+LuYZdDtpq2wxIxNY4UwO/6Hrq1t4E771BjD48xGsLKmuguuOt2ZtnnCohEvg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:14:23 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:14:22 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v4 17/27] vfio/cxl: Virtualize the CXL DVSEC
Thread-Topic: [PATCH v4 17/27] vfio/cxl: Virtualize the CXL DVSEC
Thread-Index: AQHdKwe/9SUlJoz6ykm2K+5NGuMVGLazwZIAgAjreSA=
Date: Thu, 3 Sep 2026 10:14:22 +0000
Message-ID:
 <IA1PR12MB9030B89E5855C937C90EC40CBDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-18-mhonap@nvidia.com>
 <20260828103938.3f8fb983@shazbot.org>
In-Reply-To: <20260828103938.3f8fb983@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: 448bf0fe-3303-4980-c6be-08df09a42020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|3023799007|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 AAJ6lLrRLICIqNQsdlTf42VFGGfWpSTQbbnbZd/zrONUDGGQ4JHgLSNSv+SDG+x4fTX4AixyZeDctkKwJrZcNOh8Ag+BocV1T/y3VoAf3YIn8tH8h6iF77chCisXSP2UgDCcTdQDDGokTQMFaSdaSZe9xnHT0YtFD/xcbgmWV/Wiy6kmilFFvQI6lB7SALR40//VF75kw0011NytKUA7CkkHJ/HNzpCaD2LfzYVnjoiqAkU22E9Z4Qz6hwwJj0MNUy38pW4df8By4OQFrN0T+zLN6Ft7wTBaVLQ7uETL3IAr/GPXHeu/b0mc3b+fnd9E9GPJPP9tN94LlXgif2P5pHBnJwIcf7vgg/AFWYb4QNOvGOK8Ko8HmwRl9CneDcgEv1Til2hRLvwVO0M1ceZTqDhqyjsznNKKVTgeuStdXUJpgopg2x9UF3Qtre3vxv1bGQw82m9xB+wzHEtk+QHPfIn2tPTGAwmQSgTDr/lOZw2ERcS+QlMGGo3tpUY6J7deiZNSfLSGmvQh1zx3gq5KLjScdBRKTwY1O5104zDd/ApA4Q5+Ls0qinPVju9gZHtdELMBjPqBvgoypoO+Un92xskPU9gagcecw7U0HQ5aP+zqjpCte9eB/2X4GWI5BF+CXl0qZsDzFhFiyLgzxSb8gZFYLMRImDIWiydwx+QEGNqf0O1VH0/chGoMwNGZ/s0BgnqQFX7OrjogLc/pEIh9vRxNB0+HVfvCgxos0IyCXsA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(3023799007)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j64BI8jN1wFmJ3WDHpOprSiRGvoAix+KGW/alHD/hGmnFCCEDIqbN3T9HE/U?=
 =?us-ascii?Q?5RjC8+5MWd3kCEJgNhd/P6GwJ9wtjFvsc8CQAfLVgDaULe0NIdz6nUhRcOFf?=
 =?us-ascii?Q?yiklOfoTfqEWTH8gnMG+Fq5Z1sU1QWGodTpBDrVwxW7cNV7WU6elLK9NWetK?=
 =?us-ascii?Q?K8g9XjqHa+5zhTV8Vm4UiSy9kBzTrNzic1GsUnU+6vt1gASIetCFnK4colfL?=
 =?us-ascii?Q?ujNpf+uN4xJaxlwH0E5NQRJNUMNleczaoRfhgCoZEcX3/+SMLxDQ2oUfaf7F?=
 =?us-ascii?Q?xw/2hVuuN0hoQfUVqTFjvG7CwWy2VjzC0uhpEwDyDh4YpQiv9/wkjwZsJafD?=
 =?us-ascii?Q?foFK1O2vceEW3adfotSxVPAHtGXjrzP9BdTT6KOFW7475BI5Q6rH0euPyHDl?=
 =?us-ascii?Q?BOztrdX4MAKarvPWFBPAarESFXH6GsOtaUAT85kIkcOZzUyPuT++fHCZkaQ3?=
 =?us-ascii?Q?jb3K8sj3ZMWIDiT38slOvo8ZIPzCdJwZUiNNoJYpAR7+ryCZQiBq/OrWqRIn?=
 =?us-ascii?Q?BqxIJG5zrLajZ3jDrrXl2fWkBPaxuOlX+lTqOF3MC8VEvkaUFF0+RVBxm8eO?=
 =?us-ascii?Q?RHyEECe/ZAPYf9+yRjoXwfhXqoT73E1Hyd6mxO2ExH9O2DJAF5shqOe1x00n?=
 =?us-ascii?Q?1HZMmXmA9IFOE0One+4vv0F1fsA9gE9z+RhJyIgbte4zmtOmppu3Q8/P7iJC?=
 =?us-ascii?Q?jGDg5ZR1LRAZr+T+0Y9q1NnFVXK/H7rQRmnFOt2GDQu49DnXvq0dd8HC//IC?=
 =?us-ascii?Q?nlgh1xaZwlCYJQ6jElxm1pZjT9XKiwTV5GeoyFCdF7WVDJr6F4kP4Q79jSQs?=
 =?us-ascii?Q?NDQg3qEqvNZ0uNUBP1csREgsN2CPScUOJYpipbT9AW0wMwbdvr7DrCgPWhye?=
 =?us-ascii?Q?jWQDgEaXfAWX9C6em6U2raxb/EmSOTNwn6ox029WcoE60VSYAN649aLXtLqH?=
 =?us-ascii?Q?0zC9u7vNDjR8bsQr6U/Y2ys/gp/AUWgdIXkUm40EsK3wD4hvAXP2SWrSvYuS?=
 =?us-ascii?Q?AaAETMeB3PFxNLrMxmpAYQpXbne+qxDjRoJOLjjC2PnOD+PWu+f2G9keCY/h?=
 =?us-ascii?Q?ixgJzexxa9LnRC8dFF/NUmZjMB05Jh5NmHspIXWUp54kU+ruYWBezYcM9He/?=
 =?us-ascii?Q?sEWbSLF//+wTKknQFPZHvislfi0h1mOyoMF6F+gT+fwgCLxNNh/1i2uawybq?=
 =?us-ascii?Q?WEMMod582QmmYcSvlX/kf38uTe/mTDqjf5xY4q46s4meMxvCyPRQcRFHFIeH?=
 =?us-ascii?Q?0k0fV/OQUp2Dt05UOTymAjnhJcZe7DlRXozTo0VzBG4SJLymUIJV/G+Gee5D?=
 =?us-ascii?Q?OU8+7qzt3ceFGMMgnop0Ft7PLQ7HmezIrioBaxmNssTWUN9i+hqeuUnjQXit?=
 =?us-ascii?Q?KkNpQbKxAhPtGsTQFgd3aa1C0zYKCFABmONI9W9sxnRUcnlA9VlZ8LNiTBAV?=
 =?us-ascii?Q?TH7T64tJm0AYvNv1TYQY60UAynyADGmlqLRLMDSPvBr+0NWZH6yuYcPExmtg?=
 =?us-ascii?Q?zQy7bAwDxeRnzZOQJNJMej4E6xBxYJFwqNHRsgx3+f67OaGwCUxm5ll2Tf18?=
 =?us-ascii?Q?Rq8uUdDQBnCxKs2oG8ppYZlFToGxKjd5DW6BoTOtgW299zA7ooDwnYvjy69p?=
 =?us-ascii?Q?71JhYWd7pNEvLYVU5A/C3piXT3jgGJfZc95h3C/jeFu/h8pEpcl++jYvcuGa?=
 =?us-ascii?Q?hdxJ9BUbaz1rkTP7xnMyJqFCNdkgOq7ihY+nP/GTzGY5NyKu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448bf0fe-3303-4980-c6be-08df09a42020
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:14:22.7107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnxqacFx5oRauCUASZUdN3Xun4LZqtPsccEyjz7ZEac6FHjz+Aqgw7JzT1QKf8iUh41mbMObkppd/mBhDUT+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, August 28, 2026 10:10 PM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan Madhavan
> <smadhavan@nvidia.com>; corbet@lwn.net; skhan@linuxfoundation.org;
> dave@stgolabs.net; alison.schofield@intel.com; vishal.l.verma@intel.com;
> iweiny@kernel.org; ming.li@zohomail.com; Yishai Hadas
> <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v4 17/27] vfio/cxl: Virtualize the CXL DVSEC
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:21 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Serve reads of the CXL DVSEC body from the per-open shadow and keep
> > guest writes in the shadow rather than letting them reach the
> > hardware, so a guest cannot reprogram the device through the DVSEC.
> > Accesses outside the CXL DVSEC return -ENODEV and take the default
> > DVSEC handling, so a device that also exposes a vendor DVSEC is unaffec=
ted.
> >
> > Route each shadow write through the CXL r4.0 field class rather than
> > storing it verbatim: Control stays programmable, Status is
> > write-1-to-clear, and Capability, Lock and the Range registers keep
> > their firmware snapshot. The guest can no longer set Config Lock or
> > scribble the capability and range fields.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 88 ++++++++++++++++++++++++++++
> >  drivers/vfio/pci/vfio_pci_config.c   | 36 +++++++++++-
> >  include/linux/vfio_pci_core.h        |  5 ++
> >  include/uapi/linux/pci_regs.h        |  1 +
> >  4 files changed, 129 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 2e516a0929c6..9fed909cb9d3 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -148,11 +148,99 @@ static void vfio_cxl_close_device(struct
> vfio_pci_core_device *vdev)
> >       cxl->dvsec_shadow =3D NULL;
> >  }
> >
> > +/* Read a 16-bit DVSEC field from the shadow; @off is DVSEC-relative.
> > +*/ static u16 vfio_cxl_dvsec16(struct vfio_cxl_state *cxl, u32 off) {
> > +     u32 dw =3D cxl->dvsec_shadow[off / sizeof(u32)];
> > +
> > +     return (dw >> (8 * (off % sizeof(u32)))) & 0xffff; }
>=20
> I don't understand the contract this function is providing.  It claims to=
 read a
> 16-bit field, but an odd offset either crosses between 16-bit fields or d=
rops the
> upper byte.  The contract would be more clear as:
>=20
>         return (off & 2) ? (dw >> 16) : (dw & 0xffff);
>=20
> The comment could also specify _aligned_ 16-bit fields.
>=20
> > +
> > +/*
> > + * Apply the CXL r4.0 8.1.3 write class for the 16-bit DVSEC register =
at @off.
> > + * Control is programmable, Status is write-1-to-clear, and
> > +Capability, Lock and
> > + * the Range registers stay fixed at their firmware snapshot.
> > + */
> > +static u16 vfio_cxl_dvsec_field(u32 off, u16 old, u16 wval, u16
> > +wmask) {
> > +     switch (off) {
> > +     case PCI_DVSEC_CXL_CTRL:
> > +             /*
> > +              * CXL.mem stays enabled for as long as the guest owns th=
e device.
> > +              * The HDM decoder maps the guest window to device memory=
, so a
> > +              * store to it while CXL.mem is disabled completes on the=
 device as
> > +              * an error that the host fabric reports as an SError, wh=
ich is
> > +              * fatal. The spec does not pin down accesses to a decode=
r whose
> > +              * CXL.mem is off and many hosts SError, so ignore a gues=
t request
> > +              * to clear the enable and keep the bit set.
> > +              */
> > +             return ((old & ~wmask) | (wval & wmask)) |
> PCI_DVSEC_CXL_MEM_ENABLE;
> > +     case PCI_DVSEC_CXL_CTRL2:
> > +             return (old & ~wmask) | (wval & wmask);
> > +     case PCI_DVSEC_CXL_STATUS:
> > +     case PCI_DVSEC_CXL_STATUS2:
> > +             return old & ~(wval & wmask);
> > +     default:
> > +             return old;
> > +     }
> > +}
> > +
> > +/* Config accesses never cross a dword, so a single shadow entry
> > +covers them. */ static int vfio_cxl_config_read(struct vfio_pci_core_d=
evice
> *vdev, int pos,
> > +                             int count, __le32 *val) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     int boff =3D (pos - cxl->dvsec) % sizeof(u32);
> > +     __le32 dword;
> > +
> > +     if (pos < cxl->dvsec || pos >=3D cxl->dvsec + cxl->dvsec_len)
> > +             return -ENODEV;
> > +
> > +     dword =3D cpu_to_le32(cxl->dvsec_shadow[(pos - cxl->dvsec) /
> sizeof(u32)]);
> > +     memcpy(val, (u8 *)&dword + boff, count);
> > +
> > +     return count;
> > +}
> > +
> > +static int vfio_cxl_config_write(struct vfio_pci_core_device *vdev, in=
t pos,
> > +                              int count, __le32 val) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     int idx =3D (pos - cxl->dvsec) / sizeof(u32);
> > +     int boff =3D (pos - cxl->dvsec) % sizeof(u32);
> > +     u32 off =3D idx * sizeof(u32);
> > +     __le32 le_wval =3D 0, le_wmask =3D 0;
> > +     u32 old, wval, wmask;
> > +     u16 lo, hi;
> > +
> > +     if (pos < cxl->dvsec || pos >=3D cxl->dvsec + cxl->dvsec_len)
> > +             return -ENODEV;
> > +
> > +     /*
> > +      * Place the guest bytes and a matching byte mask at the write of=
fset,
> > +      * then let the per-field class decide what actually lands in the=
 shadow.
> > +      * The hardware is never touched.
> > +      */
> > +     memcpy((u8 *)&le_wval + boff, &val, count);
> > +     memset((u8 *)&le_wmask + boff, 0xff, count);
> > +     old =3D cxl->dvsec_shadow[idx];
> > +     wval =3D le32_to_cpu(le_wval);
> > +     wmask =3D le32_to_cpu(le_wmask);
> > +
> > +     lo =3D vfio_cxl_dvsec_field(off, old, wval, wmask);
> > +     hi =3D vfio_cxl_dvsec_field(off + 2, old >> 16, wval >> 16, wmask=
 >> 16);
> > +     cxl->dvsec_shadow[idx] =3D lo | ((u32)hi << 16);
> > +
> > +     return count;
> > +}
> > +
> >  static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> >       .init_device    =3D vfio_cxl_init_device,
> >       .release_device =3D vfio_cxl_release_device,
> >       .open_device    =3D vfio_cxl_open_device,
> >       .close_device   =3D vfio_cxl_close_device,
> > +     .config_read    =3D vfio_cxl_config_read,
> > +     .config_write   =3D vfio_cxl_config_write,
> >       .owner          =3D THIS_MODULE,
> >  };
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
> > index a10ed733f0e3..f088e4ce5e07 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -1102,6 +1102,39 @@ void vfio_pci_uninit_perm_bits(void)
> >       free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
> >  }
> >
> > +/*
> > + * DVSEC accesses are dispatched to vfio-cxl for a CXL device. It
> > +handles the
> > + * CXL DVSEC and returns -ENODEV for any other DVSEC, for which the
> > +default
> > + * handling then applies.
> > + */
> > +static int vfio_pci_dvsec_config_read(struct vfio_pci_core_device *vde=
v, int
> pos,
> > +                                   int count, struct perm_bits *perm,
> > +                                   int offset, __le32 *val) {
> > +     if (vdev->cxl_ops && vdev->cxl_ops->config_read) {
> > +             int ret =3D vdev->cxl_ops->config_read(vdev, pos, count,
> > +val);
> > +
> > +             if (ret !=3D -ENODEV)
> > +                     return ret;
> > +     }
> > +
> > +     return vfio_direct_config_read(vdev, pos, count, perm, offset,
> > +val); }
> > +
> > +static int vfio_pci_dvsec_config_write(struct vfio_pci_core_device *vd=
ev,
> > +                                    int pos, int count, struct perm_bi=
ts *perm,
> > +                                    int offset, __le32 val) {
> > +     if (vdev->cxl_ops && vdev->cxl_ops->config_write) {
> > +             int ret =3D vdev->cxl_ops->config_write(vdev, pos, count,
> > +val);
> > +
> > +             if (ret !=3D -ENODEV)
> > +                     return ret;
> > +     }
> > +
> > +     return vfio_raw_config_write(vdev, pos, count, perm, offset,
> > +val); }
> > +
> >  int __init vfio_pci_init_perm_bits(void)  {
> >       int ret;
> > @@ -1121,7 +1154,8 @@ int __init vfio_pci_init_perm_bits(void)
> >       ret |=3D init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR=
]);
> >       ret |=3D
> init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
> >       ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn =3D vfio_raw_config_write=
;
> > -     ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn =3D vfio_raw_config_writ=
e;
> > +     ecap_perms[PCI_EXT_CAP_ID_DVSEC].readfn =3D
> vfio_pci_dvsec_config_read;
> > +     ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn =3D
> > + vfio_pci_dvsec_config_write;
> >
> >       if (ret)
> >               vfio_pci_uninit_perm_bits(); diff --git
> > a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h index
> > 7354dae1dd85..b9202cb29d96 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -72,6 +72,11 @@ struct vfio_cxl_ops {
> >       void    (*release_device)(struct vfio_pci_core_device *vdev);
> >       int     (*open_device)(struct vfio_pci_core_device *vdev);
> >       void    (*close_device)(struct vfio_pci_core_device *vdev);
> > +     int     (*config_read)(struct vfio_pci_core_device *vdev, int pos=
,
> > +                            int count, __le32 *val);
> > +     int     (*config_write)(struct vfio_pci_core_device *vdev, int po=
s,
> > +                             int count, __le32 val);
> > +
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;
> >  };
> > diff --git a/include/uapi/linux/pci_regs.h
> > b/include/uapi/linux/pci_regs.h index 4f5942ebd29b..00ca1c777b44
> > 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -1359,6 +1359,7 @@
> >  #define  PCI_DVSEC_CXL_CTRL                          0xC
> >  #define   PCI_DVSEC_CXL_CACHE_ENABLE                 _BITUL(0)
> >  #define   PCI_DVSEC_CXL_MEM_ENABLE                   _BITUL(2)
> > +#define  PCI_DVSEC_CXL_STATUS                                0xE
> >  #define  PCI_DVSEC_CXL_CTRL2                         0x10
> >  #define   PCI_DVSEC_CXL_DISABLE_CACHING                      _BITUL(0)
> >  #define   PCI_DVSEC_CXL_INIT_CACHE_WBI                       _BITUL(1)
>=20
> This is still not the correct implementation.  We're only doing virtualiz=
ed and
> writable bit manipulation, with some RW1C manipulation that doesn't requi=
re
> CXL callouts or module dependencies.  This could all live in vfio_pci_con=
fig.c
> gated on fields in the core vdev, ex.
> vdev->cxl_dvsec, vdev->cxl_dvsec_len.  We can setup a vdev->cxl_perms
> field with similar use and initialization to msi_perms.  This would also =
avoid the
> CXL DVSEC shadow setup in the previous patch as vconfig already shadows t=
his
> range.
>=20
> The only CXL callouts I see later in the series are for reset, where we c=
an make
> much more discrete ops callouts for store flags to avoid direct CXL modul=
e
> dependencies.  Thanks,
>=20
> Alex

Agreed on the suggestion. I will update this patch to handle this in vfio_p=
ci_config.c

Manish
