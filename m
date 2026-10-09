Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581743C7A4;
	Fri,  9 Oct 2026 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526486; cv=fail; b=oQD/Vo9UlCOz+isYLGHHmOPjFa/a7/9eptXLhlQFBRwN6VZNbHNt2J9U3r3TXxoiBbGB3LLVYpGzqHHYVNQKiV60hir+pMRQJBRjndj8LobaRqnRX+JyBG3E9KczZoka96HwD6lLCS6/TglnR/SiAsTKxmvL885vXh+be+2xugY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526486; c=relaxed/simple;
	bh=mAxbnwPjoQhWneOinj3hAy55UtSr1GcBIznvjrfsb1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HvpXnk2+VTjDfC08MAOkQtOoMRtRz02Qby+4EicG0Fhfs1KMyyVTtXqwzOxJgVbR2F3yA7/WeeIUAB7pTJFwOa+iDqxJ8kU3i9rDIWeQcGsdghTEP1xuXsxnVY0FCIndWc7ATaqlflFTEEJt9QACvSk35lpVjbWS+iPdxNdDd9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H5UT39aX; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H5UT39aX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w++DG4ITPQ29LMalVa/qWekTzeLhoF8ZSPHta7ZF5lvTAlGOumQwLXoM7MQpVJmF0zmxrCUzLnhimC7mqb0QEVtkLnB1ULNdoFOzZ7rYQ9XrXRuYVMHnIymS2aMTcQQLQftIGqvuHy1vhfh86fD7Kq0TfrsLxVox5NXbonbJD2gxVegMqhOWaNSJVr3pn2bmKLl1holzFALFnT5pEmWJLMU/UYmyRTY6ExQIp9j5ClzaQ0N5XnuF6G3m4MNIrnppvyRywsnYzOT91m19qqxPz9okpInPUBD9WeWfr8mQNd4nGfY4T/y8NtY9NF47TuTfO3bg7JMO+Qmv8N8KDdWmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4oAb88pgBULZyxbPBfJPcosB2glgvAHkicmoIxaUc0=;
 b=YxNolkdpHG7SAoBLarZ6i6nY8c0PK/NlLzGBeLVYqCr6OP7ciG5dWjn4mrqvAsKINDa6LYht4iL2CuWJ8IIXf4DS4fHZXN30d0reag9bkZfR/ydY+q5TGeixYljyqFVo2TPQtEIIEdltpTHYd/rq+GTBj2IMFyZIbigdg22jGiRTSXmy2wMsoA0Qds/4msz/8P+6hoIslkb5kV6BLj7B7/JfJ1I5Q1EYB8VXRWKcAl2eo1328nozWC1Qk4jO/tZrXqFP0XxtVMnlmPqAG8a9jwGPJ45nEVNzMKi3rCx3aiGdnIryo1FXUWjkaciLbRjMl/9fcsGK4ssK0z6siQRTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4oAb88pgBULZyxbPBfJPcosB2glgvAHkicmoIxaUc0=;
 b=H5UT39aXfUuCJRg1ejYDvB2q91A9LYi+vf/pvayjsYU+vg0nMWh+MaxwavvAhzKDUKbjAzVnct6leXETnhKC+AUHU8UOnxNjBgH1g9aJuar5ZGizDj5M7GdcZPVL071hpFvUvzurpEbriR3+ZC1wpRpZ52vhkv5xF+CHRmcLUzkVBX4opoR8Vi8ldwzB/yQiKrBh/IK4V0e6IwAjdrEPJE9IZH0gcxlmpfC9ywh9Ll44DE4MvNPgImkroUBLCiQ5Q2EkRCdH6LgQh3bYgKSrPTd6GOGG5oZ3R2ZcbwYusBIMnSC1ECsoA4Wpgx6x30dYzv6ewVnXKb8F0jQxKkEg9Q==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:38 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:38 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>, "dave.jiang@intel.com"
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
Subject: RE: [PATCH v5 16/27] vfio/cxl: Create the CXL memdev and set media
 ready at bind
Thread-Topic: [PATCH v5 16/27] vfio/cxl: Create the CXL memdev and set media
 ready at bind
Thread-Index: AQHdRgqreMlvx76ncEy3JzzSnFJZCLbf7LcAgBTkmUA=
Date: Fri, 9 Oct 2026 06:14:37 +0000
Message-ID:
 <IA1PR12MB9030107911FF2FF2839DDCB6BD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-17-mhonap@nvidia.com>
 <20260925232250.7d408311@jic23-hlaptop>
In-Reply-To: <20260925232250.7d408311@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 1e35b384-f86a-4bab-ccb4-08df25cc98fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|5023799004|56012099006;
x-microsoft-antispam-message-info:
 w72gaOp/vCYLlfCz15+nUakJ9FXPkJpG3JSz+mApmIBZgAEJPW+Ab5+Eb+xPNamu1N6oUBeub9SvsLPJK7fQ5QUat1G9R2lKVGLr2n35I6PyufAXxe4EInD6EEmMoOfcE/q1t+sbUdbsQOONpV+uNBE6f5/Ws4JGGcKUmx2ZoHEMjdAhyiQNFk6h2jjNH3HWFSI/Q+lctgxLrbEkRS/BRjVS9r2MC9HvuPXZNGbrJgiu3zOxGwvV6BeJXyj6yIaVNUCI7emhbLH34uhdteyeVG3LOnGmUwnLX74rzKFEqobwfbJ+yY4skbd/1/fXm/bfCIxWgyXho0cdwHrWk6Xo0SrtYApH2gETvbMMlWCYJZYbHSEhF521QtSYreWW08NvLjvamAfJcC4otVmazDijc3P/HANhvREeYYDr8qKxauKf4zW6KMpjsLjEIfoCrMgRSGkO1/w6sK5t23kZ+W5lPC0bvpa5OjhjeqHzSVPgm5M3JGqXo5BA18ofAxCj54pBjoKUsWcbOtDNBLBJ+iS9hYKoZH6GFlzPZrIhqqiNw091GL1CBxm8ZVMiVA+vcsY7nJp4UBo2idVOyuDJ5WWE88rbEhQrtvh9U3PxRG93aJkIK4kLe7LEAvZzByqdPHYJ3Mese2wFvWpTl3NN/TLJ70Z4TYuA2Jhc0cGHztY5IDiVJF0O4UlNNSEiWnPEh3d5b5pFVX/rtHD/WBVWBCvpdu1oaSEV0ghVmse7CJZsnT4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OGWGWAYU5y1f/votv+vldfi0DPXPeVpNIUMNzBmxVzEgfouSSdqsYcMGNjNr?=
 =?us-ascii?Q?Ne537Fw2h+mP5PWNtv3HDjjnD/P6IE8tKGIZDsClZ577ic5MGJmOCR5NVbex?=
 =?us-ascii?Q?r6LzBxBvQ0yobhPim2Fkhz2/iFoLZbYDdVPaZFzP4I6iWaAR5vtmKAxBVbd+?=
 =?us-ascii?Q?3XY5jB1KLiGb3svpYTEOEWk4+cshYYBrYE6QlQhlAwjkkmPD7chM7wg4pfQB?=
 =?us-ascii?Q?lmdRjqODdTNE1JXiRqLqpsGkRVqrcMX11KmsA6W4rdxJm/6oBhSEj+XfJ67K?=
 =?us-ascii?Q?QxPV+HVzvdUsQTcJat13yXcSJy4xy9GuJ1OygJb33kwJ7Vu0oM4ytrAjHjAQ?=
 =?us-ascii?Q?Z1a42rBM40/If5rx7d6lRiEN4aIPw/OiGXqiD5LSJTRQVvc70ql5CEYy/atc?=
 =?us-ascii?Q?qa9KjNBke2gukkZDi7tyMI30i1EkWT1Y+TBCU4wc2vQAvKp9yjzGjC1tbtPt?=
 =?us-ascii?Q?oIHUEh5mVrXGZ2Io89v4HBBv1srVpz/YKpeUnrHOqpX1ICNs+MgC01d6Pcgu?=
 =?us-ascii?Q?cyJRGvt6cAV2jN7NxNwU07cfmy4n1B3uheB+QmFilbj2SpxjhnLZ3hwI6sUx?=
 =?us-ascii?Q?c0MCr3TgragsZeMXkWgwtwlyN/UrFmo+XtICNTuyu67r4784mAwzUz7IDSmM?=
 =?us-ascii?Q?4lQqvA81dQ/BCz0t/CwZkzgZh5qhxt+2evRn99jMxPRYI1+3QXzSWCzjcb+J?=
 =?us-ascii?Q?/w4ZVHjvEGds/+raGKXmeHjJeeeqIkvGxzAlzKcUBzsIT4TpqhRuEaaZAsUP?=
 =?us-ascii?Q?jGFYHmkoLDbfTYWikXM+o0CUojTODv2wzaWPtr87XAurTT4/v2GIQ+PgtETm?=
 =?us-ascii?Q?C1nM1w8wsRT5lcGL+9MNbXbPhSMqI/kATOHNDsuzlAfkx6wlHhNhHLIILlGf?=
 =?us-ascii?Q?VPksTEzXucUaQn0ewj47RCmaZf65XX92grMo0aO7E4efAv7/CUYd/VoDLLDq?=
 =?us-ascii?Q?WzZHK1Yc2RtaYNDv4py/e7OJ4xQhBI4jbYRm4tqhDGg6ehBLH2id+19jt7pR?=
 =?us-ascii?Q?ipD82T+P4h3KbMle43sa78epnHO+U2npAF6A8KGjORkqGhrL8289F2B44XsQ?=
 =?us-ascii?Q?dTjYHYCObFe44+6pBPh3AEdaSYIB30Xyvwl2ZTgC3U69+Mv0/tiQTCagvsL5?=
 =?us-ascii?Q?5GXniGVrJ7QfO1ostCyutuz5ouDC68JBclGxqYKpCQXXPZhRD9SdQ51jzTkR?=
 =?us-ascii?Q?9Vl4vcE1ra61y4Y/UroIRR9OTYrzhI6t3LK3bazZF1TH1k7/DyK2TgAQ3X/9?=
 =?us-ascii?Q?AXHFNvXqovvOL1uaOTC6mcFsaZM2XJ5bvQZtngzgBKBHP19x7nrjD2q+w7hT?=
 =?us-ascii?Q?wiURHRcXv6hasACqyPx3fH+bWlNFWh+McGw1bATntqOjC5BAwdymmxztFu6d?=
 =?us-ascii?Q?jJuxVbXzbE8onMHMnBdtd8Wj+Cekhr5dXt4RUvwmivLyZZgnHsi5O4CebMmK?=
 =?us-ascii?Q?pP5iJsAKpKAxPm3XM1s2JPvf13EoB2oGF607W9kOV/QcP83I73+iuHl5PeMf?=
 =?us-ascii?Q?wey8PHojMpMJCF276/1ke64V9nKJMXJGjI5OdGfqOcc9X4F4EzN8SYhUgJv5?=
 =?us-ascii?Q?jt+SKnfsdwYJ1nzJkEH99HTxrlJw/UHIVh+MD7aiFc93kPjekQyJyigg68HB?=
 =?us-ascii?Q?+/e1iCsmFokRoNkCVSXNc2WLY4VxkyIV1iHADCWui70PbSCsb0n4NUobV7hV?=
 =?us-ascii?Q?lqzi53aYgPXbD+YUS0P2X9nzKnK5VuSAQW4w1EgkhBElyiAq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e35b384-f86a-4bab-ccb4-08df25cc98fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:37.9633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bh7YsQaM9iI7UUVOqdTncoXHliY7coI9hfVMHBZXtvvPpUJ4OFQPE6iv1tgdWTHQXit0hgJuXW/YbVUqb4S84g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, September 26, 2026 3:53 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> skhan@linuxfoundation.org; dave@stgolabs.net; alison.schofield@intel.com;
> vishal.l.verma@intel.com; iweiny@kernel.org; ming.li@zohomail.com; Yishai
> Hadas <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: Re: [PATCH v5 16/27] vfio/cxl: Create the CXL memdev and set med=
ia
> ready at bind
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:29 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > At bind, build the CXL memory device for the passed-through Type-2
> > accelerator so it joins the CXL topology and its HDM region resolves
> > to a host physical range. A Type-2 device has no mailbox, so there is
> > no media-ready register to poll: set media ready directly once the
> > component registers validate (mirroring
> > drivers/net/ethernet/sfc/efx_cxl.c)
> >
> > As per current vfio-cxl support, reject a device with:
> > - more than one HDM decoder
> > - interleaving enabled
> > - whose reset the host cannot service
> >
> > The CXL-core allocations are grouped with devres so a failed bind
> > unwinds
> > them: init failure falls back to plain vfio-pci with the device still
> > bound, so devm would otherwise hold them until unbind.
> >
> > A low-power transition would reset the CXL Type-2 function and lose
> > its CXL.mem contents, so keep it in D0 while it is assigned.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> A small thing inline.
>=20
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 118
> +++++++++++++++++++++++++++
> >  drivers/vfio/pci/vfio_pci_core.c     |  16 ++++
> >  2 files changed, 134 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index cd5d41856404..0d92e6a409c1 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -6,15 +6,132 @@
> >   */
> >
> >  #include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/range.h>
> >  #include <linux/vfio_pci_core.h>
> > +#include <cxl/cxl.h>
> > +#include <cxl/pci.h>
> > +
> > +/**
> > + * struct vfio_cxl_state - per-device state for a vfio-cxl device
> > + * @cxlds: CXL device state; kept first for
> > +devm_cxl_dev_state_create()
> > + * @cxlmd: memory device joined to the CXL topology at bind
> > + * @hpa_range: host physical range of the HDM region  */ struct
> > +vfio_cxl_state {
> > +     struct cxl_dev_state cxlds;
> > +     struct cxl_memdev *cxlmd;
> > +     struct range hpa_range;
> > +};
> >
> >  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)  {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     struct vfio_cxl_state *cxl;
> > +     struct cxl_memdev *cxlmd;
> > +     u64 hdm_size, serial;
> > +     u16 dvsec;
> > +     int ret;
> > +
> > +     /*
> > +      * pdev->hdm is cached at PCI enumeration, before any driver bind=
s, so a
> > +      * device without it has no usable HDM decoder. Fall back to plai=
n
> > +      * vfio-pci rather than deferring the bind forever.
> > +      */
> > +     if (!pdev->hdm)
> > +             return -ENODEV;
> > +
> > +     /* The guest drives one virtual decoder; multiple are unsupported=
. */
> > +     if (pdev->hdm->decoder_count !=3D 1)
> > +             return -EOPNOTSUPP;
> > +
> > +     /* An interleaved decoder cannot be mapped 1:1 to the guest. */
> > +     if (pdev->hdm->settings[0].interleave_ways !=3D 1)
> > +             return -EOPNOTSUPP;
> > +
> > +     /*
> > +      * The guest drives resets through the CXL Device DVSEC and polls=
 the
> > +      * shadow for completion. If the host cannot service a function-s=
coped
> > +      * CXL reset, that request could never complete, so refuse the de=
vice
> > +      * rather than advertise a reset the guest would poll on forever.
> > +      */
> > +     if (!cxl_reset_capable(pdev))
> > +             return -EOPNOTSUPP;
> > +
> > +     hdm_size =3D range_len(&pdev->hdm->settings[0].hpa_range);
> > +     if (!hdm_size)
> > +             return -ENXIO;
> > +
> > +     dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +                                       PCI_DVSEC_CXL_DEVICE);
> > +     serial =3D pci_get_dsn(pdev);
> > +
> > +     /*
> > +      * Group the CXL-core allocations so a later failure unwinds them=
 here.
> > +      * A failed init falls back to plain vfio-pci with the device sti=
ll
> > +      * bound, so devm would otherwise hold them until unbind.
> > +      */
> > +     if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
> > +             return -ENOMEM;
> > +
>=20
> I'd be tempted to factor out the stuff that is unwound via the group. If =
this
> were simple a call to a helper function, that helper could return directl=
y on
> error giving us simpler code flow.  Then you'd just check the helper retu=
rn to
> find out if you should close or release the group.

Okay, agreed.

I will move the memdev setup into a helper that returns on the first error,=
 and the
caller closes the group on success or releases it on failure.

>=20
> > +     cxl =3D devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
> serial,
> > +                                     dvsec, struct vfio_cxl_state, cxl=
ds,
> > +                                     false);
> > +     if (!cxl) {
> > +             ret =3D -ENOMEM;
> > +             goto err;
> > +     }
> > +
> > +     ret =3D cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> > +                              &cxl->cxlds.reg_map);
> > +     if (ret) {
> > +             pci_err(pdev, "vfio-cxl: no component registers\n");
> > +             goto err;
> > +     }
> > +
> > +     if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
> > +             pci_err(pdev, "vfio-cxl: HDM decoder registers not found\=
n");
> > +             ret =3D -ENODEV;
> > +             goto err;
> > +     }
> > +
> > +     /*
> > +      * A Type-2 accelerator has no mailbox and no media-ready registe=
r, so
> > +      * set media ready directly.
> > +      */
> > +     cxl->cxlds.media_ready =3D true;
> > +
> > +     ret =3D cxl_set_capacity(&cxl->cxlds, hdm_size);
> > +     if (ret)
> > +             goto err;
> > +
> > +     cxlmd =3D devm_cxl_probe_mem(&cxl->cxlds, &cxl->hpa_range);
> > +     if (IS_ERR(cxlmd)) {
> > +             ret =3D PTR_ERR(cxlmd);
> > +             goto err;
> > +     }
> > +
> > +     cxl->cxlmd =3D cxlmd;
> > +     devres_close_group(&pdev->dev, NULL);
> > +
> > +     /*
> > +      * Powering a CXL Type-2 function down and back up reinitializes =
its
> > +      * device state and discards the contents of its coherent memory.=
 Pin
> > +      * it in D0 for as long as it is assigned so CXL.mem stays intact=
.
> > +      */
> > +     vdev->disable_idle_d3 =3D true;
> > +     vdev->cxl =3D cxl;
> > +
> >       return 0;
> > +
> > +err:
> > +     devres_release_group(&pdev->dev, NULL);
> > +     return ret;
> >  }
> >
> >  static void vfio_cxl_release_device(struct vfio_pci_core_device
> > *vdev)  {
> > +     vdev->cxl =3D NULL;
> >  }
> >
> >  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev) @@
> > -59,3 +176,4 @@ module_exit(vfio_cxl_exit);
> >
> >  MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
> > +MODULE_IMPORT_NS("CXL");
