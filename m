Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424848B383;
	Thu,  3 Sep 2026 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430387; cv=fail; b=GFq7Wc4lyixGNMb6Xv4N91WQz/5UmnoYXDSUwGx4kqAc9qMj4ogGg/FoSjXkxExG7EK/hAjrP/k3XRB0XNlYqcBe414bW5Keis9ARkeMnPkFmoUre4bHzcEai+9EyjBmK8tvZ1IT5siVfXN0Pe5riWIfKVNumUZv+uHWHpqO7Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430387; c=relaxed/simple;
	bh=eWa2BI/HlFFtTG683gIZE8r7NOAI2PCuLGnimAVq0Fw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=beIo3+jHX7jcxLpZz6UAe+34XRVCTiI881+CzIq7+Yka8igptOCOenJwGN+ImjENbH/0ApK2DFhM7KWR9B1qht29drxx/9bjlV6f7yhX+SaAEIIWihtZHkxKBCudSe/cKseOEPHMamaplx01ObXDkbEcvZ+Z3yKj51GoMvBHyTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z5cMSns1; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z5cMSns1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCk8jN8D/PUe+okhlPlyYiKzeOrdycQVeU2uhWDyHkbXFAJyA8BosUnYw75oaGwiroZJeQ8ATrbozEcj1rjuAMhYFgEYMmwaae2srOUtacq0Uh0RwSi48htbJ3/3KiwFaU2wVEfF9GDx4O+FT5toOkOhrKIm6gOdvjJmqHVolIr78X8MdZme4W4TYpn4nOvb5SzUgeMDvirtcQlSoRQLFp2dyx+ITm+Ol/G+fmNuqn0pEybJi9xZ1JtNEmcv9z2plxli3B5EMavbkAwV1CjIa/DRwJOqkBtGUhB8mYlYdVNkziqevbKunHbtkTPZobLd88CoTlOCh67TRorLm2DgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUZIfaeXgebDzVJxPpWFOwfZR5McZ0rvGCrMgIPCxNI=;
 b=ParErvKvHlXVFmX8YllIBnOLAbA7LJTHtd5MBc5/SpnYLz9TwcICsRgN97+RF2bWuLyYq1vlVpJDwh8T49Kbpm3ZpC/tWQ8UqOTVhsJXpFvcVl+iJ7S18L9aCc8TPxaQTjPxfKSSTDzuOifeUeKBFdLd9/YO/M8C0zJmAD5mEgrGlFoFaiJzev+lXbehFU4MHNIfSn6uY4K/G/1oJUxlRZehaGJXX38ZuNmMsiOX+/W9KCSn/UwbM4kkZMHs7OGBGY/JkZY+qDX0IB73IpGzWgTygwHs0m3xoIHZrBBSy6RJzn4JshLKFqTo4Z3b4Lays393TBRlULI5wa8QMhOiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUZIfaeXgebDzVJxPpWFOwfZR5McZ0rvGCrMgIPCxNI=;
 b=Z5cMSns1Q2qvAQpVMSbR4NcUamRE0e+1d4hEBfyysSCbV4PkWQApFSIXuiNRhWk/MVxYJ1yqxu+Zd5c25cPgmIVAiaVCZqqdxo6ZuhE9bWTXXMSdE8fo858bDBtSc0GULtRbUHo3uFpmRXso4DWMv9hth5dL9hT8NYaED/7Yd2rA/pS3m6fcWn0ZQLEQWVP09iGwKKA36KN0ri3CpGyXaOKTpNDwYlEUQot2z3eGnvuEFskxNUl2XZu6PnnpvilV/kC3SrXWj8P1ieFocbDeVh1J0EMCx31h1XHIia1CLMCLs5sn/MYDcLK3ATxENQDa+ike8yWbEV1cMgknxDaRqA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:12:49 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:12:49 +0000
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
Subject: RE: [PATCH v4 12/27] vfio/pci: Let a provider exclude a BAR sub-range
 from mmap
Thread-Topic: [PATCH v4 12/27] vfio/pci: Let a provider exclude a BAR
 sub-range from mmap
Thread-Index: AQHdKwegHqgrZ/VYx0+2ppMOqEdRy7aykyqAgAn732A=
Date: Thu, 3 Sep 2026 10:12:49 +0000
Message-ID:
 <IA1PR12MB903084BE76BF2539A35DFAA3BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-13-mhonap@nvidia.com>
 <20260827163717.6b9c1752@shazbot.org>
In-Reply-To: <20260827163717.6b9c1752@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: b168e185-e60d-42c3-bf36-08df09a3e894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|3023799007|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 d8li72/S/SN93tOtqJfgB6q3/0LYemQxFO7BjYGYmZUm/KM4CZDSrwaA9Sn1PD/GVf/C1UkMtgQTv2rz56WuMtb1ndCLbXZKmMSt8W/njMvKfbFpiOA52uDiJltdjTkKeRpBNiyzT3jwhvLzrv37J+d9nAMPap7AK/21JNdnjZVIAbrbYOHGWGbEoqNHHF7bDscVF2bbfzSaLGGvi7NIwXNKGcYG2JvMfnkP8j6ZR/i3AHos5t0K1ObV10yuk6qT94CslGuLh2AuZ4BN9i1usU3K18WXZBMu17+crOy7DN1cQ7bGNrEIRwIaaDIjfKC8V0oxDweEz9SweGL18r3SRTuK6hoIqUaf8XXTRcl8C8VfO9RlVPj2816EQ7y8CFWAiXd7zp7njZKbLt9mpu73zI70FBATkMn04wn6Zjjg2OacNhclmYGAcg0W00F0b6CvipkViqSTalmxOa9pxFL9vPln6I9l8FK5k8b4YZWfudPqb8XZ508Fg1G7E5TcrjJ3tCbtTYn7SwfqbhtmgguLnWDcAH7WikU6LtEvkkmACVI/jooF3pGzT/yWXwqhpc12x+5Go9Ko+pwdHjUZGrU3QOtS9Ur7l3bTyH8HLE9f0BRe7zbxMBPbFCB3R54w/a3K5KB+37ToLIJnd5TdCz09xayo/9zLk5IbXo4xYNlkwMJXE6g19YJs3bVunlUMXhQO2ZJDNr8GdL0cxhudggeyLi3RlgTkIQM1wdLvE2oLlIw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(3023799007)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QNJeZFuqpM3WgNGQfv19R5rNe1zSMpx+HV5c7PIoLNmAOiORs6xQtyY0w+cn?=
 =?us-ascii?Q?hVZs/cw6eZVIaFL/tNT15L7ihIyak+XsEznCBeFIqjhBJRr52QUbcrj043C/?=
 =?us-ascii?Q?hJVw0vUGEqWrYygCy6VoKUDz9S+G7MNGTrALaOTTF6Kuin3dVSjYVn9JJ9X5?=
 =?us-ascii?Q?aJsN7WQ4vfPkk/n75lXVHTNQ2EyuSjbHgUWI3whmIHYXVxFpY/EGYiUxnsUm?=
 =?us-ascii?Q?kPzTtTHxJVmvtq/bUApaVopJNvzpku/SEw99n7N4jQI+23CMoynClQk/nrAH?=
 =?us-ascii?Q?ZzDheMceN5hhosYg2tY9Wuy1Xe9TT2QeAgZYNIvLZbpYOmy6bhEkclqtduU5?=
 =?us-ascii?Q?+Td355gIkPLvcLunRglTDO/0u44f1wxruSMe2cJ5B9Is6/RXxYWqtLLlUlft?=
 =?us-ascii?Q?GMBp3x8dovwTpJMHD2MF2PSJcx+fECSSZYJ2n23zQx/zSvzhoO5FvHWF4z2t?=
 =?us-ascii?Q?ETHIoEBrncm7oYQO6jWYetNmbI/Nuz4fd155PqI8mmXIQSoDIX9gwxYIrqzO?=
 =?us-ascii?Q?8AfwCT5skm8OXXB2QaJj8Nbvrq0L00wzxI/J4fHE0PXvj2862dAZe0+4Vhif?=
 =?us-ascii?Q?ejwBntsbURmR6i+5CTX/2itIXAggXyhY8h5whDawJwcqB1h6RwAUY3XEJiS1?=
 =?us-ascii?Q?m/fyGxTKPiNQQXJwVxCS0SrQkO+Zj9GxXD2Ddw9b0nzX0p9gb3kD5HW6CS+t?=
 =?us-ascii?Q?oBROJAy+F7b3eAGxXAjreMjKQlcck4J2ywTJc8pd30qacjUzOY31uaP4LG8V?=
 =?us-ascii?Q?3VrTUnkd4GyOxahYtSQDGZ9t0akn/oW2TWPHgkzA/I8XSTeDunpwcY6qay/+?=
 =?us-ascii?Q?lCaolfe1vPW2cAWLuo5a8/qpYVsTDuoLa6c4896o1lObY5Rj/rv5bJACmphd?=
 =?us-ascii?Q?V4F7WRKUJDtTWF4/DLvAFEE77dF6C6rqm5CWjt5m+vEf0dsVgKLXHEEB4g9L?=
 =?us-ascii?Q?DZXsHW5N7Bey1aBFWJTvAzXC9etWUnp1f945RGhHM+GDbtQ/NGpN9kziG2No?=
 =?us-ascii?Q?CEtAPdWifXuZiRq69ZI7hlLGbA1G8Ulh+RBRnq7odVPOVqpIQI9yLYBBqyDq?=
 =?us-ascii?Q?UXnRKG2t7LC/bQllRMXLQqRBwvsVmZoELZcL5giuSqLuZmxlwFCGyQksJ+lU?=
 =?us-ascii?Q?+mpxEmhjdf73WKHD45fcjD+Qh1qq6Huc4cVSwySknlXi63NXhUgRDxeIhO5k?=
 =?us-ascii?Q?jnHtoahttDAV24MdJ1JRKkgwcN3yZwSC/gt9VAYYZ/E/YJXCltXfZbNaMEps?=
 =?us-ascii?Q?ShAsAT9A6Gu8b/Z9EGRaFzmyL8C66tZApcpaHKap0IpoguyDzcjSMMz39DU7?=
 =?us-ascii?Q?pbOkKxa9sZb9Q1wH0vtUJQQH6xvsxCUjeRqRQVsjorELalqA2aPS3pn/jCsu?=
 =?us-ascii?Q?z6SYuS0FSfmOJphUSNK3okXLSgdfAz3TvjjRoF95qTRP/WTv3h/cbvyKDloA?=
 =?us-ascii?Q?lWHYVGe6eu/fsKIarUnhSqJ20tmsaTU+Xc6iSxjyEegygNRIe1jtrc0r5gqL?=
 =?us-ascii?Q?goX8n2hmSoAoFyp13VSFYPcYJTntwmfuw+5M7lGI5V2c9qZqgQ0+JncanjKk?=
 =?us-ascii?Q?P4BFRrEAW5XLQza2g4jrc9VYsRNo3NSfQgdiaiAIH9LXt6DKDe9LKgPoxmuo?=
 =?us-ascii?Q?Kd3Ddos6SLk8BRDHMv0fdSaq3FPnjJ0NZVdlHwJ4m8K20ZF7mIVA6pHH6JJG?=
 =?us-ascii?Q?s9QRspzMzL0785b+bpPm5S8BtEvG3xFOqZmYqdCP+TBRwK3h?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b168e185-e60d-42c3-bf36-08df09a3e894
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:12:49.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGFetCp6JtUAr4qdRmz6KHvhMUYanJSp/Uqq6jDwgr0DoZKGE1MAFMcQDmZEtupmoYthrjdyU4rWdbnxJnFZ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, August 28, 2026 4:07 AM
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
> Subject: Re: [PATCH v4 12/27] vfio/pci: Let a provider exclude a BAR sub-=
range
> from mmap
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:16 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Some devices expose registers in a BAR that must be reached only
> > through a trap, not a direct guest mapping. A CXL Type-2 device's HDM
> > decoder block is one: mapping it would let userspace reprogram the
> > physical decoder that governs host memory decode. Give a provider a
> > way to mark a BAR sub-range off-limits to mmap; it is advertised as a
> > sparse-mmap region and refused in the mmap path, while the provider's
> > own region still serves it.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   | 72 ++++++++++++++++++++++++++++++
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 13 ++++++
> >  drivers/vfio/pci/vfio_pci_priv.h   | 13 ++++++
> >  include/linux/vfio_pci_core.h      |  6 +++
> >  4 files changed, 104 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 0f9b5dfeea66..49dfbdaf3f05 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1009,6 +1009,67 @@ static int msix_mmappable_cap(struct
> vfio_pci_core_device *vdev,
> >       return vfio_info_add_capability(caps, &header, sizeof(header));
> > }
> >
> > +/*
> > + * A provider can keep a BAR sub-range off mmap (for example a CXL
> > +device's
> > + * trapped HDM decoder block). Callers hold the resource so /dev/mem
> > +is already
> > + * blocked; this only governs the vfio mmap path.
> > + */
> > +void vfio_pci_core_set_mmap_exclude(struct vfio_pci_core_device *vdev,
> int bar,
> > +                                 u64 start, u64 len) {
> > +     vdev->mmap_exclude_bar =3D bar;
> > +     vdev->mmap_exclude_start =3D start;
> > +     vdev->mmap_exclude_len =3D len;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_set_mmap_exclude);
>=20
> If we're going to go to the trouble of creating vfio-pci-core infrastruct=
ure for
> handling excluded ranges, I'd rather see it handled more generically.  On=
e
> excluded "mmap" range per device is limited, leaves MSI-X vector table ex=
isting
> as a separate implementation, doesn't accurately describe what it does si=
nce
> it's excluded for both mmap, read/write, and ioeventfds, and doesn't make=
 use
> of the existing x_start/x_end infrastructure we already have in read/writ=
e
> paths.
>=20
> I think we should probably create a list of excluded ranges, each contain=
ing a
> BAR index, start, size, and flags.  The flags are necessary to manage mma=
p vs
> read vs write exclusions, where MSI-X only excludes read/write, but this =
feature
> wants to exclude them all.
>=20
> All existing use cases of msix_start/size would be migrated to this new
> interface.  Handling in vfio_pci_bar_rw() would also need to account for
> multiple excluded ranges per BAR (HDM exclusion adds that as a possibilit=
y),
> iterating for any access extending beyond the intersecting exclusion. mma=
p
> would generically fail any intersecting range with the mmap exclusion fla=
g set
> and region info would iterate the same set of exclusions in generating th=
e
> sparse mmap capability.
>=20
> This would also correct the behavior of the next patch that intersecting
> read/write accesses generate errors rather than fill reads with -1 and dr=
op
> writes.  Thanks,
>=20

Okay, I will handle this as suggested with a generic excluded-range list in
vfio-pci-core.

Manish

> Alex
>=20
> > +
> > +/* Advertise the BAR as mmappable minus the excluded sub-range. */
> > +static int vfio_pci_mmap_exclude_cap(struct vfio_pci_core_device *vdev=
,
> > +                                  int index, struct vfio_info_cap
> > +*caps) {
> > +     u64 bar_len =3D pci_resource_len(vdev->pdev, index);
> > +     u64 excl_start =3D ALIGN_DOWN(vdev->mmap_exclude_start, PAGE_SIZE=
);
> > +     u64 excl_end =3D ALIGN(vdev->mmap_exclude_start + vdev-
> >mmap_exclude_len,
> > +                          PAGE_SIZE);
> > +     struct vfio_region_info_cap_sparse_mmap *sparse;
> > +     int nr_areas =3D 0, i =3D 0, ret;
> > +     size_t size;
> > +
> > +     /*
> > +      * mmap is page granular, so the mmappable areas must stop at the=
 page
> > +      * boundaries enclosing the excluded sub-range. The byte-granular
> > +      * exclusion still governs the fault and read/write paths; only t=
he
> > +      * advertised mmap areas round out to whole pages.
> > +      */
> > +     if (excl_start > 0)
> > +             nr_areas++;
> > +     if (excl_end < bar_len)
> > +             nr_areas++;
> > +
> > +     size =3D struct_size(sparse, areas, nr_areas);
> > +     sparse =3D kzalloc(size, GFP_KERNEL);
> > +     if (!sparse)
> > +             return -ENOMEM;
> > +
> > +     sparse->header.id =3D VFIO_REGION_INFO_CAP_SPARSE_MMAP;
> > +     sparse->header.version =3D 1;
> > +     sparse->nr_areas =3D nr_areas;
> > +
> > +     if (excl_start > 0) {
> > +             sparse->areas[i].offset =3D 0;
> > +             sparse->areas[i].size =3D excl_start;
> > +             i++;
> > +     }
> > +     if (excl_end < bar_len) {
> > +             sparse->areas[i].offset =3D excl_end;
> > +             sparse->areas[i].size =3D bar_len - excl_end;
> > +     }
> > +
> > +     ret =3D vfio_info_add_capability(caps, &sparse->header, size);
> > +     kfree(sparse);
> > +     return ret;
> > +}
> > +
> >  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vde=
v,
> >                                     unsigned int type, unsigned int sub=
type,
> >                                     const struct vfio_pci_regops *ops,
> > @@ -1157,6 +1218,13 @@ int vfio_pci_ioctl_get_region_info(struct
> vfio_device *core_vdev,
> >                               if (ret)
> >                                       return ret;
> >                       }
> > +                     if (vdev->mmap_exclude_len &&
> > +                         info->index =3D=3D vdev->mmap_exclude_bar) {
> > +                             ret =3D vfio_pci_mmap_exclude_cap(vdev, i=
nfo->index,
> > +                                                             caps);
> > +                             if (ret)
> > +                                     return ret;
> > +                     }
> >               }
> >
> >               break;
> > @@ -1851,6 +1919,10 @@ int vfio_pci_core_mmap(struct vfio_device
> *core_vdev, struct vm_area_struct *vma
> >       if (req_start + req_len > phys_len)
> >               return -EINVAL;
> >
> > +     /* An excluded sub-range is reachable only through its trap, not =
mmap. */
> > +     if (vfio_pci_bar_is_excluded(vdev, index, req_start, req_len))
> > +             return -EINVAL;
> > +
> >       /*
> >        * Ensure the BAR resource region is reserved for use.
> >        */
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index c16f460c01d6..51983105d38b 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -177,11 +177,24 @@ int vfio_pci_core_get_dmabuf_phys(struct
> vfio_pci_core_device *vdev,
> >                                 size_t nr_ranges)  {
> >       struct pci_dev *pdev =3D vdev->pdev;
> > +     unsigned int i;
> >
> >       *provider =3D pcim_p2pdma_provider(pdev, region_index);
> >       if (!*provider)
> >               return -EINVAL;
> >
> > +     /*
> > +      * A provider (e.g. vfio-cxl) can exclude a BAR sub-range that mu=
st be
> > +      * reached only through its trap. The mmap and read/write paths a=
lready
> > +      * refuse it; reject a DMA-BUF export overlapping it too, so a de=
vice fd
> > +      * holder cannot map the excluded registers to a peer and bypass =
the
> trap.
> > +      */
> > +     for (i =3D 0; i < nr_ranges; i++)
> > +             if (vfio_pci_bar_is_excluded(vdev, region_index,
> > +                                          dma_ranges[i].offset,
> > +                                          dma_ranges[i].length))
> > +                     return -EINVAL;
> > +
> >       return vfio_pci_core_fill_phys_vec(
> >               phys_vec, dma_ranges, nr_ranges,
> >               pci_resource_start(pdev, region_index),
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_p=
ci_priv.h
> > index fca9d0dfac90..902d17815ab6 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -44,6 +44,19 @@ ssize_t vfio_pci_config_rw_single(struct
> vfio_pci_core_device *vdev,
> >  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user=
 *buf,
> >                       size_t count, loff_t *ppos, bool iswrite);
> >
> > +/*
> > + * A provider (e.g. vfio-cxl) can carve a sub-range out of a BAR that =
must be
> > + * reached only through its trap, never the direct BAR.  Returns true =
when
> > + * [start, start + len) on this BAR overlaps that excluded range.
> > + */
> > +static inline bool vfio_pci_bar_is_excluded(struct vfio_pci_core_devic=
e
> *vdev,
> > +                                         int bar, u64 start, u64 len)
> > +{
> > +     return vdev->mmap_exclude_len && bar =3D=3D vdev->mmap_exclude_ba=
r
> &&
> > +            start < vdev->mmap_exclude_start + vdev->mmap_exclude_len =
&&
> > +            start + len > vdev->mmap_exclude_start;
> > +}
> > +
> >  #ifdef CONFIG_VFIO_PCI_VGA
> >  ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user=
 *buf,
> >                       size_t count, loff_t *ppos, bool iswrite);
> > diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_cor=
e.h
> > index 117cd67995d8..43755b91880f 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -162,6 +162,10 @@ struct vfio_pci_core_device {
> >       struct notifier_block   nb;
> >       struct rw_semaphore     memory_lock;
> >       struct list_head        dmabufs;
> > +     /* BAR sub-range a provider keeps off mmap, reached only through =
a
> trap */
> > +     int                     mmap_exclude_bar;
> > +     u64                     mmap_exclude_start;
> > +     u64                     mmap_exclude_len;
> >  };
> >
> >  enum vfio_pci_io_width {
> > @@ -176,6 +180,8 @@ int vfio_pci_core_register_dev_region(struct
> vfio_pci_core_device *vdev,
> >                                     unsigned int type, unsigned int sub=
type,
> >                                     const struct vfio_pci_regops *ops,
> >                                     size_t size, u32 flags, void *data)=
;
> > +void vfio_pci_core_set_mmap_exclude(struct vfio_pci_core_device *vdev,
> int bar,
> > +                                 u64 start, u64 len);
> >  void vfio_pci_core_close_device(struct vfio_device *core_vdev);
> >  int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
> >  void vfio_pci_core_release_dev(struct vfio_device *core_vdev);

