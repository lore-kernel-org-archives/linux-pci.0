Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1443BD659;
	Mon, 21 Sep 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983821; cv=fail; b=VZV6++5i3gdmPW5g8ok95EVC7Ck+/RpqKjQaOEt7aZoVVKLkoqG9Q8XTEil+G7/eFrY0JHygkTy8u8VksJGF5vsvv/PlwpHewktYguAbH1m30t1+9mdQXJDfpQTrz/7S4vwbNhP+Mghvi5yjVBIdN2wVXH9NOJG7GVUdmooa2QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983821; c=relaxed/simple;
	bh=nHFKXSbY/rp8R8cKSK/DeOCPH7lTutnf/PFbty94Il8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7J/k7eMZJu19phHmF5sR/snsNG3duOnHW18iNBt7od9a0dZKKukgZMoBQgTjIWcIrmTOYJURqGjXrn0cm/VJE4qmBATXnBENwfkeGBGTDAfoPzUYvQD+hb96lwUqW56n3QaKX1BWS2+TfQWaICRg1yDSpHi1N9VtARiwearhDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r++IFoVW; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r++IFoVW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7AXR9xlTTVPqmdjY6TZvxqfCUZYa7v2jok+mxQMkYAzuaQeWSLKJwKbmB08fRu1Bai0NP+mT9/wMv7rrWwavjoSB9XP/rEfjvuD7qPYNhbFT055mC6mjGXQX+oiH7ZmPyKI6jClPurGum7PufQHBxdNfskXtF3LRqRQ2/6foqJpq4spSPLHZ1yaAOVtcoTpw9LUWP+hZyXHUMDqts/z0Oe9bszeGpwJE7imevEhmXoJwKKDiKiFH3/WrPZ/H1mkcLFtuaU0cTHscYf2UF0GpDbf185Dcwct+0w7jqOVuoq5wMoE3DitvJzISq4GX4Yfo+xYNg5cs8AESTzey/V8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Q4KpLrodrgI+UlzzkmpO9LKAZJoUvfPkjG6igBe92U=;
 b=ctPqH86KmVgJKIgBCkV0ikA3+tqQYwELm5XGnFPwDUIxCVPwr2kV4gqEItPRK5A9Y1hI0S2bK57iyCs03c/HnjA9k3UT+tLCQAlpmsAxCkho3ampyso/AbPcsk4S9i7zggArBT+h0NlUViqv/gU0kEGZnflg7Xxd6qDgZ8z4P6kVr15cuypF8cYlGkDqnGVoRbocQskl2NchCvFm9a3tyo9B4UOcK4qpJt8AyDI7adglaFcrq3VTD1kC0Rr5RheLO8ukCqy1tGXxc6XVnlj1myiXCwgH02xCLOUKt/ggPZ/QEBDr25jqqhRlzOQOAvwuFlkylBdFHFNt8K5zejw6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q4KpLrodrgI+UlzzkmpO9LKAZJoUvfPkjG6igBe92U=;
 b=r++IFoVWMQAXUa0QNNySJ6v5rt1v4aTTFd+55Wf+ZoINiahBGPzcmGNKWFBpql9LH12L+9koKJmPUi+YWiRQTM9OiHehzaMbvZKpv23eoUimRJQLqKchon7881VvA5zsPF7/pDk0DlE+cUUUzx5OxZZRj2a32GTF3/EfIQEwY8sK0Z/kCr1fndki1C6gsvKim+9Sp3QzjCh4z/YmO8nDZ47Ugh4TOXXqtjoMOCAaJL+01ArKAk/u+h93L1QWw9aePrt970uCJdBEMBi+MBrnKlMQNvuVO/ru//U0m6jwi2bV3ASpWoZgDUK+dGBzeiDjezbAMHBdfsCfPfg5sMhU9w==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:43:34 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:43:34 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Gregory Price <gourry@gourry.net>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
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
Subject: RE: [PATCH v5 26/27] Documentation: vfio-pci: Document CXL Type-2
 device passthrough
Thread-Topic: [PATCH v5 26/27] Documentation: vfio-pci: Document CXL Type-2
 device passthrough
Thread-Index: AQHdRgrlNhqk9xrYw0eW1HwG3HKyqrbRmGkAgAcugbA=
Date: Mon, 21 Sep 2026 09:43:34 +0000
Message-ID:
 <IA1PR12MB9030771093FA13DCB01C481EBD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-27-mhonap@nvidia.com>
 <aqrl_FyWEBOZundU@gourry-fedora-PF4VCD3F>
In-Reply-To: <aqrl_FyWEBOZundU@gourry-fedora-PF4VCD3F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV5PR12MB9777:EE_
x-ms-office365-filtering-correlation-id: a5ee8aa0-839e-459b-c16c-08df17c4cdd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|11063799006|56012099006|4143699003|38070700021|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 aa22u9xks9Y8R05YQqyYMNVIh+UCg4A+DCaMjX16G2JHIa9eBYFvuAIuSHgTiwFyFCTARTcfMSRi/tvvadTuQFZdrK0bwE28s9gWSbtT+UN7r21gXRW3GsdtyOqnA7tjjCIXIZPFC5GNjAmIvMScWu3sBm5yRd7RaVS2sv0cQ1A8olaI9YjfQfl+v2TOHZ6K3quENSR+QMk3hdEZf+cnX0BGdK9jO+KgGAL+c3BdjSOLNGuIxe+mOPix9s0zxKfK84Uo+S/mYlhIktlXY6OHw0qLnO5H8H+EDm/JXIkTPm6VmZClL0Bjx037/L4ItcpzWdkI80SPdNA35b44f55M3gMTSLZQg6obl+vMuf+FfJZrAeUVFAvWxECLVXeEYPNYqSiTL8V71R7mrWFXIDM11JOkFt+q1F3/B1MhpcO5kgUI2ahd8rVfkd8m6JPiVwa1kEaw8dFMLOmY3Cl3vC7QiuIO2URX/PC0gfFa29v22HMHPYWsr2nqttEV0e/X3WKwEd5qMmoVq+nCO2mJm8ZppAvND+MiDagCYhQJeaLI4VspEpfxY4vQpc/10phUzp+hD2CpfV9yhjL+Ru8HLN5MF7wVu1xXryW6fjsNi61aEl4/OV6riXyG4RWuVt6F+g7eI7QnVGuAGFCvmbk9mSkdmB/el/7v/WoECs15WEkI5DlxsnWBwjokG+JmOol2pK7Nw2QIvog9sQKn7g8mkSW7HdQAiSxZ/ZlzTDOldu+dUGQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZT/+qYRvRxcSiYmXg5C+tZmNHZ5Dvx0JVKO6tf6ARkKdNq161jJoXvs2yNen?=
 =?us-ascii?Q?WDbADOUVyacBP6kGN4UlRnK03J3Uzo0U5genj9SmxbHuV/NDRmVAdMDrqeW9?=
 =?us-ascii?Q?yJlSImq78NtUMnQnm2UkXU+HQ4M3Kipb4iWKqa6iXlv5K0hRwcOqumlF5pYa?=
 =?us-ascii?Q?gz0n//O484xZxUXqTp5wnEWo1jYf9z67KdBEvEkq3u8wVzqwqwiM3Ecr3IZS?=
 =?us-ascii?Q?k4o2XuFGkOQLpaWajdY7iBWSQYSfthg64O5v3+v9tKWiwvlnl17WD4ih2jfE?=
 =?us-ascii?Q?w6ls4YZrXIDODlxHtZ4c4qghyRTy9tnSrqd56OdvJOM5b9KLyVWT8ivMkM+3?=
 =?us-ascii?Q?0ad9D7/AqyiZ6wA2LUQdFqYIPQ10rUG2R18pOu1CTncI9Dbq+NE5h5Nd6a09?=
 =?us-ascii?Q?F0SGaMMze/FgiA3FHcgZglhy+r3As+98TG3+fcPJ8Ky/CgcGLHMRMlmMouEx?=
 =?us-ascii?Q?YFbE1aJYipaqmUsbaktYYEMjSyBz114ekB27rvTBa4x44BjeWgrlAiPe0UN9?=
 =?us-ascii?Q?k/DL4eILVQCVvX2CTkPRsWfrdMXYz85J40LxqCs5aqHtzP0jMpA5SNNwnmF6?=
 =?us-ascii?Q?cpq/Mzl/QhcgExNrHnskBid2Zi33M0ipTzYQXh9Vm36fyXZz8IJaLGzdRGZz?=
 =?us-ascii?Q?Ow5wBcEubWsnw6MzXMtca9aA/TpITuaUV9/ENxfy+OUoTdGR6y79WInLay5v?=
 =?us-ascii?Q?8HIk5omzDF+T2EPe2fATKEv2bYaOU3G67nlBRez1JeZ/SnOU0OTXm4zmZfa3?=
 =?us-ascii?Q?Dtu3IA4EipEYiDc/L2SM0wXGUmwBhweL2idU7CLEFyNtcLZL9uPMtGoz/qPJ?=
 =?us-ascii?Q?pMqnK2WOh6yPI0vh2hVZ4Aw5hlA9w5nwkYdHsm/QSZ7ENQCQGHWRf1oMqk98?=
 =?us-ascii?Q?bLlF5cD5UvzQxaFgm3MN/3GALPArjgBladdZbTbMOpdy5GVlQa7la+FgPMRz?=
 =?us-ascii?Q?hhh1RtispHK5hkdns+vdJl6OUgVwuMhfCPxjHIF54u+B7Mvf7s632pQlfuAJ?=
 =?us-ascii?Q?+ngaNYHKD/E7c67clojsUq6dFkHyEjz+uqTX26rmv5enRRjAjRNvDraC7q45?=
 =?us-ascii?Q?d87c7BM94CiVAC7PGJfWyT9fRuQiyhCerdDvZ6JTvXnBVN3D+EDGFApiaCLU?=
 =?us-ascii?Q?+aKVGvg3rI7Y4agG4UaLrVwXbey+1rZIbR6mGSfFVQeQf6xX7TmXklB1FWFj?=
 =?us-ascii?Q?OiJfC9nHSwOW4FbYF631PgqR9tNp3+t7mzU7Oeg0OfQzhVp7yZwyd0vXG5lh?=
 =?us-ascii?Q?k+yYEFYb/eqwPe8QxHG1GdmlM1PrR3uVm2UKXJAU90Notm6WZPg4Aj3g/QG9?=
 =?us-ascii?Q?xzb5xSOuZI1cTEZjhnnSUpY7wWgZO2lwsZ1M8WgVkSuegyZsEF0v9d9uRnI6?=
 =?us-ascii?Q?lJPmdabkCPjrg4dd3KXJIChtwjbXGTUBsdjHIIWaHdU87FsrGBTQZnFGeN5J?=
 =?us-ascii?Q?+hYfHKJMDAKw2+zbZtcICmc4s7WxZflkn2I0FowtZ7/N6Ljg0HfY0bqtzX/v?=
 =?us-ascii?Q?GpVeHfTBfDYFvLayZC4iiHTwT97h9OTjJnHz42quDy4ZBJF1girasS87AoBW?=
 =?us-ascii?Q?DeYJzV38X0Uoxu7/8SpcCFel6Ayk9e0lj97UHfNZ3PHDqzKDT93Iv+QwFeWE?=
 =?us-ascii?Q?ksODUG0ErfBCNRc0aCnISN8Ul9vCs/y4WBdWRyXYUGossFkfbgijvrRkOhE7?=
 =?us-ascii?Q?v84YZNH7nuTMZj21u6BrpeyLEZQiGKlf/FEJBDcfG3tr2O8Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ee8aa0-839e-459b-c16c-08df17c4cdd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 09:43:34.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwR6oYsdetAaXFKOS4iyKQXGz5j6zIu+tXGtVvMYGdOLCyiDeebadXWgn+vjuB4eioVCGgTKmnA7wMMxTDE/rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777

Hello Gregory,

Thank you for the careful read of the documentation. I will rework the
sections you flagged as below:

- Address model

  I will update the wording to mention that VMM does know the GPA: it build=
s
  the guest's CFMWS window and so chooses the guest-physical range the devi=
ce
  can inhabit. What the host owns is the HPA and the placement within it, n=
ot
  knowledge of the GPA.
  I will add the two models you described, fixed placement for an accelerat=
or
  that needs exact physical placement versus no fixed placement for pooled =
or
  compressed memory, with a small HPA/GPA example, and note that the curren=
t
  series under discussion implements the fixed-offset case.

- Virtual decoders

  I will rename the The "Guest decoder and commit" section to "Virtual
  decoders" and add a short flow showing a guest vdecoder write being absor=
bed
  and a live read returning COMMITTED from the host-locked physical decoder=
.

- "The kernel virtualizes ..."

  I will update it to say vfio-pci-core (its config-space permission hooks)=
.

- guest IOAS, stage-2 mapping, and struct-page-less coherent memory

  I will define these terms where first used and include that the range is
  handed to the device whole and never onlined as system RAM. I will also a=
dd
  details why a stale stage-2 mapping must not outlive the HDM window, and =
how
  the VMM rebuilds it.

- Reset

  I will reword this section. FLRs are virtualized so a guest reset can't
  inflict physical CXL.mem/decoder effects on the host rather than loose
  wording "must not take an FLR"

I can share the revised text ahead of the v6 posting if that is easier to
review.

Thanks,
Manish

> -----Original Message-----
> From: Gregory Price <gourry@gourry.net>
> Sent: Thursday, September 17, 2026 1:03 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
> jic23@kernel.org; dave.jiang@intel.com; alejandro.lucero-palau@amd.com;
> Srirangan Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
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
> Subject: Re: [PATCH v5 26/27] Documentation: vfio-pci: Document CXL Type-
> 2 device passthrough
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, Sep 17, 2026 at 12:05:39AM +0530, mhonap@nvidia.com wrote:
> > From: Manish Honap <mhonap@nvidia.com>
> >
>=20
> 1) Thank you so much for writing documentation, i truly appreciate this.
>=20
> 2) I apologize in advance for my terseness, I know writing is hard,
>    please do not interpret this as disliking your writing or series.
>=20
> > +Address model
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The HDM memory is a coherent host physical range (HPA). The host
> > +kernel resolves that range before the guest sees the device, and owns
> > +it for the bind lifetime. The guest only chooses where the memory
> > +appears in its own physical address space (GPA), by programming a
> > +virtual endpoint HDM decoder. The guest never reprograms the physical
> decoder.
> > +
> > +The kernel holds the HPA and does not see the GPA. The guest programs
> > +a GPA and does not see the HPA. The VMM holds the device fd, reads
> > +the committed base from the decoder-register region described below,
> > +and maps the HPA-backed HDM region at the GPA the guest committed.
> > +The base the guest reads back is the GPA, not the HPA.
> > +
>=20
> I think this must be slightly inaccurate / imprecise wording.
>=20
> The host *must* provide some form of physical memory window to the guest
> at initialization time, otherwise the guest has no way to know - at boot =
time -
> that there's even a window of memory it can use.
>=20
> That's what the CFMWS is.  This is initialized by the hypervisor - which =
is
> controlled by the host.
>=20
> So the host (at least the VMM) must know, for the region the entire devic=
e
> *could* inhabit, what that GPA is - because it's the one that makes the C=
FMWS
> for the guest.
>=20
> If this is not the case, then something is missing from this documentatio=
n to
> explain why.
>=20
>=20
> If you're actually trying to say is that the GPA's programmed into the vi=
rtual
> decoders are largely symbolic - this at best feels a bit inaccurate and s=
imply an
> implementation detail.
>=20
> The host's virtio device could enforce ....:
>=20
> Host Range:
>    CFMWS HPA - [0x10000, 0x20000]
>                    |         |
> Guest Range:       |         |
>    CFMWS GPA - [0x50000, 0x60000]
>=20
> In that case, you'd get the following translation...
>    vdecoder0.0 - [0x58000, 0x60000]
>    CFMWS GPA   - [0x58000, 0x60000]
>    CFMWS HPA   - [0x18000, 0x20000]
>=20
> Or the virtio device could not enforce that and let the host page-fault j=
ust hand
> it a random page from the actual CXL device.
>=20
>    vdecoder0.0 - [0x58000, 0x60000]
>    CFMWS GPA   - [0x58000, 0x60000]
>                          |
>               No discrete host mapping
>=20
>=20
> The former makes sense if the device (accelerator) requires exact physica=
l
> placement to do its accelerator nonsense.
>=20
> The latter makes sense if the device (accelerator) doesn't care about pla=
cement
> (compressed memory).
>=20
> This is not saying we need support both out of the box, but we shouldn't =
lock
> ourselves into the former unless there's some reason why the latter is no=
t
> reasonable.
>=20
> Can you please help document what the actual expected behavior is with
> examples in the Address model section so it's easier to understand the in=
tent?
> That will help quite a bit.
>=20
> > +Guest decoder and commit
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +The guest programs its virtual endpoint decoder through the trapped
> > +region: it writes a base (a GPA), a size, and then the COMMIT bit.
> > +The host already resolved and committed the physical placement before
> > +the guest ran,
>=20
> So the host does know GPA, just not exact placement.
>=20
> > so a live read of the decoder always shows COMMITTED and the
> > +guest's commit poll completes. The physical decoder is never
> > +rewritten; the guest's writes are absorbed.
> > +
>=20
> Rather clunky, round-about way to say "The guest decoders are
> virtualized".   If possible, it would be nice to formalize this concept
> into "Virtual Decoders" - since that's what this is.
>=20
> With that concept i think you can probably generate some nice diagrams th=
at
> show how the guest vdecoder's interact with the host drivers.
>=20
> > +The VMM observes the commit, reads the committed base, and maps the
> > +HDM region at that GPA.
> > +
>=20
> So the host does know the GPA.
>=20
> > +CXL Device DVSEC
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The kernel virtualizes the CXL Device DVSEC body through the
> > +config-space permission hooks. Reads and writes inside the DVSEC body
> > +use a per-open shadow; a guest write stays in the shadow and does not
> reach hardware.
> > +Accesses outside the DVSEC body go to the device as usual.
> > +
>=20
> "The kernel" - what part? vfio-pci ? the vmm ?
>=20
>=20
> > +DMA and iommufd
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +A Type-2 accelerator issues ATS-translated DMA to addresses inside
> > +its own HDM window, so that range must be present in the guest IOAS
> > +that backs the nested stage-2 translation.
>=20
> Type-2, ATS, DMA, HDM window, guest IOAS, stage-2 translation
>=20
> I think the only thing i don't know in this sentence is "guest IOAS" and =
it's still
> hurting my brain to read.
>=20
> Are all accelerators expect to have this particular interaction, or just =
yours?
>=20
> > The HDM range is struct-page-less coherent
> > +memory, which a userspace-VA ``IOMMU_IOAS_MAP`` cannot pin.
> > +
>=20
> The hardest part about writing about virtualization is keeping a consiste=
nt
> mental model from section to section.
>=20
> which userspace? guest? host?  (i presume guest here)
>=20
> `struct-page-less coherent memory`
>    e.g. the host never hotplugs this, it hands the entire region
>    directly to the VFIO device, right?
>=20
>    I think this would be nice to spell out somewhere.
>=20
> > +The HDM memory region is therefore exportable as a dma-buf:
> > +``VFIO_DEVICE_FEATURE_DMA_BUF`` on that region returns an fd that
> > +iommufd maps with ``IOMMU_IOAS_MAP_FILE``, mapping the physical
> range
> > +without a VA or a page pin. The dma-buf is revoked whenever the
> > +mapping is torn down (reset, power transition, teardown), so a stale
> > +stage-2 mapping cannot outlive the HDM window.
> > +
>=20
> For the sake of readers, I think either a little bit more information on =
this
> "stage-2 mapping" concept is needed to make sense of what's going on here
> and why it mustn't outlive the HDM window.
>=20
> > +Reset
> > +=3D=3D=3D=3D=3D
> > +
> > +A CXL Type-2 function must not take a Function Level Reset: an FLR
> > +resets the coherent CXL.mem state and the HDM decoder. The PCI core
> > +reflects this by preferring the CXL reset over FLR, so a function
> > +reset of a CXL device runs the CXL DVSEC reset sequence, which resets
> > +the function and then restores the HDM decoder and the PCI config stat=
e.
> > +
>=20
> I think what you're trying to say is that FLRs are never passed to the de=
vice
> because it can cause physical device effects that defeat the purpose of t=
he
> virtualization, yes?
>=20
> So we virtualize FLRs...
>=20
> > +A guest requests a reset by writing Initiate CXL Reset in the DVSEC.
> > +That write only stamps completion in the shadow. The real reset runs
> > +at the vfio reset points (the reset ioctl and a virtualized FLR throug=
h config
> space):
>=20
> As you describe here.
>=20
> So it's not that an accelerator "must not take an FLR" - it's that FLRs a=
re
> virtualized to prevent deleterious effects on the host / hardware.
>=20
> Am I misunderstanding this?
>=20
> > +the kernel zaps the HDM mapping and revokes the dma-buf, then runs
> > +the CXL reset, which always clears the device memory, and restores
> > +and re-samples the decoder afterwards. A CXL port masks Secondary Bus
> > +Reset by default, so a ``VFIO_DEVICE_PCI_HOT_RESET`` does not reach
> > +the endpoint and the HDM state is untouched. If the port has SBR
> > +unmasked the reset can decommit the decoder without restoring it, so
> > +the reset_done handler gates HDM access; a ``VFIO_DEVICE_RESET`` then
> > +runs the CXL reset sequence and restores it.
> > +
> > +The decoder register region is served by live reads of the hardware
> > +decoder with guest writes absorbed: the decoder is committed and
> > +locked by the host, so a guest can neither decommit nor reprogram it,
> > +and the kernel keeps no shadow of the decoder state.
>=20
> This is basically what I said at the beginning - it must either be that t=
he host
> provides locked auto-decoders at boot, or it must provide proper virtuali=
zation
> so that the decoders settings are fully virtualized.
>=20
> Seems it's the former, and that makes sense.  Please correct me if i'm
> misunderstanding.
>=20
> > After a reset the kernel restores and
> > +re-samples the firmware-committed decoder, so the geometry the guest
> > +reads back is unchanged. A VMM that dropped its HDM mapping, for
> > +example across a reset or a D3hot->D0 transition, must rescan the
> > +decoder and rebuild its
> > +stage-2 mapping before it resumes HDM access.
> > +
>=20
> Yeah i think we need a bit more information about this stage-2 mapping
> rebuild to make sense of this.  Maybe I'm just not read-up enough on this
> particular setup - is there another part of the docs you can link to that=
 talk
> about this, or are you able to share some details as to what this rebuild
> process looks like?
>=20
> ~Gregory
