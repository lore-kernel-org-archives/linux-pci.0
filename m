Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4347FB19;
	Thu,  3 Sep 2026 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430356; cv=fail; b=ae14vlMGCMeWq8ftShe/fKSL5FGe8hbBRl6U/9VmhGQIQ7zLNB1LV7xA4gtzBh63h7d9MEfdNnY7fIGlBETct3fxZRuVcM4fJ6r6iLstq2m5oiv5/hRk/1kS6PkrFzo5FJ2Zx84tnN/g0L8mLBiYSLT2qb+YdoAGHLCJ5DIeo54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430356; c=relaxed/simple;
	bh=kLm4emGN3943fvUS5oR1SLGBa5Xsi+dDzNIgZven5MQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u1ucFMkbc5FYdcmsp9Cickp7rfKgecIgrwK2Bhsg2Re9TeEVRLQsZVpLVlpJPsun2lPVhYLuPO2rJuqNAe96BpyuuC79gt0QME8eBOXtHSJJZFQG8fLXRkjNS0uBeRnayiv9AUo5fPzC36zAdLwioiPINthzSzOelbLjfEVtF/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mw9JUN7N; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mw9JUN7N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMKtRKiBK8lLts7ZYwWBNnAUK5/2zQZAG8jtVMkKBsWoHiFZz6oDzlDntNfoHGoZcsO7DUx0T04xEp+tO7CsU3y1v0peXhKZgtZ7SL7rGsykCMTAxiNJKP3Ip3MzVRAmUgIGK8G8GjiuR8FAne1HioXAdWuCuIiQe76TG8QiYEPdVkSWCS58Skyp1QUoS40oW1KqFkn19fUESU7B4RvMOPiYeLhvO8IrYelqDtprWIze08HXMDF9Iu1ZOFJNp9OKPIkZmRMrVxO4wHJnGAnQ04jzo/Eh/5yiQJEKh9/I8hWbLNAlV3qd2uV6n13a/Krn7G/3ubor11gHySleSoEPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMmoyO0ZoeqK8M6UrTMdIROiqkfMlZiYqwJPUGPBBu4=;
 b=GydnAUFwzJCJsNEHLt1jzewcZTj6QywhH5g3FC08ju+1RPZl38C8P3e3nz591MmiFQfRjeY9I+bc01LKrvcbj2Nm5xvbWSJY+cvAJepORvqZpeTtEN7DiJSGwL/r2Tuk6ik3crqR3ncmCCR/ulSdrPoRomxjRwPQxy4GhMLxBwEimpsZVfeCtFUinze2MUsD+knFFd7ZfHdrGH31MWcoUw02N6qZKU2QCdMCX3mOHAi2hokYt4ZRCufnNO1mMsSxXth3oFd/BON7CyJhoo4Nfg0ZHlhquIkf7HOXzU0h6q6rzYtJnnUd9nnxBzUTxKco+VTX2cA4zxbNTmS4MSu4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMmoyO0ZoeqK8M6UrTMdIROiqkfMlZiYqwJPUGPBBu4=;
 b=Mw9JUN7NpxRdPY5lZnJsz1vxtIEXhKCvirf1VqqTgwZSlJP2F2u3AYDGXBD0HuG3M8ellZPNgAGKJ3wH4WoJLrIt+Am+Sb9ctigVGZ0l9Vhz0DDe+icoQvgk5dywKurUyNGeJ8s+vQ/7NHs9Cyxne8iq2bpaw1bN8PZC/6FWwEulj7EW2oo0+fg40zlj53nHfWoVHkF4edgH4eoDKYJoqIfpnWFsDt9gaHzCBWJTtRPVOr7EB01VKyPNy74QA9tWswR9MR73rfkuRCnys/H8XEONK9CClhlXG1N4vxmwV3JGwDHDDpMuQM1Nvygqxe9j7zN7ksnUFFS9nbEINtF1IA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:12:19 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:12:19 +0000
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
Subject: RE: [PATCH v4 10/27] vfio/cxl: Reject unsupported decoder topologies
 at bind
Thread-Topic: [PATCH v4 10/27] vfio/cxl: Reject unsupported decoder topologies
 at bind
Thread-Index: AQHdKweYdJ80dW0s+EiRjNacZZiOu7ayd3iAgAoWkmA=
Date: Thu, 3 Sep 2026 10:12:19 +0000
Message-ID:
 <IA1PR12MB90309CBDD23EFE493BB27D25BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-11-mhonap@nvidia.com>
 <20260827145809.71bcca71@shazbot.org>
In-Reply-To: <20260827145809.71bcca71@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: dde2909f-1bee-4bf1-407d-08df09a3d69b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|4143699003|5023799004|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 qLB/gydlNJmhYrmStWRdrXZ/J1kQQUy2Se3exA8mix4U1eJ+aMcN6PoTqFhMNRni2oeV2H3AFTDoR9a7dxoDEUiD4PgjV+p3j8j7H26JE3FOlU3xDtlJTFxL0P/DTMdcGjIVZyEBh2YZheOWNConakeeYkXHDlmRdn22dH6ipD5PVxgGj8whF6eNnMEqqWDXXXGw0IE++0po/1gUD1K/z+GGXuB20ea30U5k9kfm8PXXSfpfvcrKa9TdMQfTJEChfqmLNoP4rbGSscL59+9qOSolXSa4ImDZnOkPZbo1qMlkCJjNv8yJkR+46luUoWVym7sLlVUuw/QlrI6nx4PyCifIAL4OY7PRhHNNSfvh48cMfbSptW18dTj4U8I3PUi8VoZeR/OZzMGmt3JtG+egcXPEbSS5zDAxNrV1RkcvxCB8brMi9GHIyNeqhZU5Xoz7HiiRDs2LW2k52ywSVab0l6uvRm7nOfodN47Q4TjmBvxkk1UG3fnb8Uw/NyZ/N+bGHNK7u+uXAJZUWrTulkYwlgnaQd2eMmqY5/20D1cGf42iyNi45s5bB5RBNfyGg6NFUXXY1i6uqCpYNkRBGsYyTLRkl1JtUN757ANzg4w1nFVjmPJxhTgfCj3Xq7b8vWjvTcBxnk6Chp5lBGk3NO9Iysp/r8+NNa7rl5w/TKRMK0ZO1WEJ8tUwVlb8LrpnEKMUq/D/RdA9ExKwXp38hIJSEfL8GZye99UNEjWfkqoVHQw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?04Nmm/amD6plBtDjSe26TmFw9GA7M3/65p3gcgJ91Yx3uQ3CN+ezT0Wk25Yn?=
 =?us-ascii?Q?XkVwo1w85eBDdT3cqEAuui171Z6kPvTUY1yIXql6EJfnYfW6orj92cmbHjWz?=
 =?us-ascii?Q?Z0CpHPCtPmn4ausKURekhvjqWzxY4QYz+10f0F5gSx7E9H90+qm+Z9FrkpZi?=
 =?us-ascii?Q?O6LR4YFipsMtxZnHtlTj5pECLMg2d6M1UBnO9X6rE5LB0nQBG3RHOyOUqefn?=
 =?us-ascii?Q?MWp1KsU+DNFV+P4WJsdtcxeaSNCEyPFihEeWRPpz/UzNbWftEBSsifeVP9Mq?=
 =?us-ascii?Q?9WdJmF6xjUOzU9gN7FnF7SybBm8+xc8M32BK8jYXM7kyljFaV/2tusflf9pL?=
 =?us-ascii?Q?Yb8l/REc9vrRLYdykSf9fV3KGabXC3hIgsIHYrb7SW1PXiFSkblvmvvzP+bY?=
 =?us-ascii?Q?lbad7EWjCcbG9P7fRuyfaIyuBWD0s5T58FJ34s/pZBJVErXbAjEXSHQabsaR?=
 =?us-ascii?Q?oEq6rNNCHcz0YRkXNHhPS2m8zNwKzF8W4bdtuBQfLMDZ2vWwXHCbj3+v8T3u?=
 =?us-ascii?Q?QlZ2JcaGXin8m4YAUJORhykIIPBJgr9Worvh3q+ylhgNUJJyMalA4+D9YUtn?=
 =?us-ascii?Q?1UYS19n6SiD0HImFuXUQcq2rD8EzGlJUF+833VwxBFFXBj3LD0VbDq0hveho?=
 =?us-ascii?Q?z1b63P13ofqCSFLrCvmdljiViWX180J2kcKds40GUa0xmHQwyhZ4zlb4j2MD?=
 =?us-ascii?Q?B6+zHFdYC0KLmloWCQzkhN0xy4jMyh9wUUeby/RUSukgd5yL2Q2E4xcgz2og?=
 =?us-ascii?Q?3vTqp9Uzcv4Ut2hhcErtCepGOf4gPLBg5F6wZ1/AwhqIDfiIIUDJicpBJHkt?=
 =?us-ascii?Q?VipI+Mq+W11eDNMmOoQD3psuV82cFC/BBpELiiAjX5quNXO1od4YcnetlZv1?=
 =?us-ascii?Q?2TVGoqIrJkXFiF/qXjcTy95NbA6DEF8dvb568ooqbNEb6lEUPDF6fKl7VBdj?=
 =?us-ascii?Q?HtArJKeOAhwCXLZs8PRsFhXw4FEvD54NOr4BImJgUxq0HjV1ajZlARIA5+2a?=
 =?us-ascii?Q?Z6YoEZ8dI3qWFOSHRIhwKmJZZrnnMo0ROUbYhsvTDdA8bwfGdVcixhw2EZFi?=
 =?us-ascii?Q?NtO4txg3ZuHtrjuDCMkwqlypIDbUxLnRGStJ3nfCTB4iwi9Z0kIMpD0ryvrL?=
 =?us-ascii?Q?GDs8h0zxPJj2ejDxfQRyEVuSp7GGw5OzhcUCXUuSJet3nZNamBfvwWQ1uN80?=
 =?us-ascii?Q?EY+fqvUo6OOSMVX38WZnB8N7Cf8cHyXY8tF/s5ZnX/F4rnhUiqhBVH/+6kMs?=
 =?us-ascii?Q?drLaxqF4Gf735bPvw8vHiI/qgR1oGHRJz9BrE8fBWNHQYx+KvY04l/BIInlp?=
 =?us-ascii?Q?fFjGwoJTyqg7J/FeF1v9t0jRAtkEgNn+2dWUucIOemw7Gz4zRdCCb9eswihP?=
 =?us-ascii?Q?n0U+Rwe79AFG8kfclQXZw47qE27Mp7Pv88HmdbV2cBUWrTDJBBL2ijua2069?=
 =?us-ascii?Q?+SwL39tNoPvBJQU68Wb6OtVTehG7ENXDDJGyPNYzEFk/29wPC/tYHuts3VqO?=
 =?us-ascii?Q?TS+lDlv2Y9q+iH+m9zGESQ/Ak0RQEqGngbAUQ8lbNRFhU+R61TE5y8/vX2ee?=
 =?us-ascii?Q?cZn6s0PlV6r6fRrZUKbXTu7QN1SDyDGRebvH0/jFAOvz0sQaOAs7IbHvnt+f?=
 =?us-ascii?Q?ceAFZd6zZ/TUpyz0ubE7VKapSA/coILX0lS9YmDECciyxWwOaUb2hAXqeb0p?=
 =?us-ascii?Q?Gbxf+zobG/Oaa+wtMygfF0qDrsqlEmpXhjp4KyT4oOzEUXr8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dde2909f-1bee-4bf1-407d-08df09a3d69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:12:19.4183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUGLJ4CZyfguUs3+9fQFaqD/2jaVYBoq5uhzX6ULi6oxPY0v/1IlrUWJVvWwFWP020oSZhx/a2lm2BlhGBJHbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, August 28, 2026 2:28 AM
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
> Subject: Re: [PATCH v4 10/27] vfio/cxl: Reject unsupported decoder topolo=
gies
> at bind
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:14 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > The guest drives a single virtual decoder whose memory maps 1:1, so a
> > device with more than one HDM decoder, or an interleaved one, cannot
> > be represented. Turn that assumption into an explicit refusal at bind
> > rather than a silent misprogramming later.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 125e11354a46..7edc53b25576 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -36,10 +36,30 @@ static int vfio_cxl_init_device(struct
> vfio_pci_core_device *vdev)
> >       if (!pdev->hdm)
> >               return -EPROBE_DEFER;
> >
> > +     /* The guest drives one virtual decoder; multiple are unsupported=
. */
> > +     if (pdev->hdm->decoder_count !=3D 1)
> > +             return -EOPNOTSUPP;
> > +
> >       hdm_size =3D range_len(&pdev->hdm->settings[0].hpa_range);
> >       if (!hdm_size)
> >               return -ENXIO;
> >
> > +     /* Interleaved decoders are unsupported. */
> > +     if (pdev->hdm->settings[0].interleave_ways !=3D 1)
> > +             return -EOPNOTSUPP;
> > +
> > +     /*
> > +      * The guest drives resets through the CXL Device DVSEC and polls=
 the
> > +      * shadow for completion. If the host cannot service a function-s=
coped
> > +      * CXL reset (no reset DVSEC, a multifunction device, or no HDM r=
eset
> > +      * support), that guest request could never complete, so refuse t=
he
> > +      * device rather than advertise a reset the guest would poll on f=
orever.
> > +      */
> > +     if (!cxl_reset_capable(pdev)) {
> > +             pci_err(pdev, "vfio-cxl: Unsupported device: host cannot =
service a
> CXL reset request\n");
> > +             return -EOPNOTSUPP;
> > +     }
>=20
> Why does this particular error deserve such a high priority log while we =
silently
> fail the other two cases added here?
>=20
> These don't seem particularly noteworthy to split into a separate patch v=
ersus
> rolling them into the previous.  I'd probably also group the easily testa=
ble
> EOPNOTSUPP errors before we actually start evaluating things like the
> hdm_size.  Thanks,
>=20

Okay, I will fold this into the previous patch and make the log levels cons=
istent.

I will also re-order the EOPNOTSUPP checks before evaluating hdm_size as su=
ggested.

Manish

> Alex
>=20
> > +
> >       dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> >                                         PCI_DVSEC_CXL_DEVICE);
> >       serial =3D pci_get_dsn(pdev);

