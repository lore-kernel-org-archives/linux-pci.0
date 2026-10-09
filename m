Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595704534A5;
	Fri,  9 Oct 2026 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526492; cv=fail; b=CvRC8V53n06dq9/EUOSnI+hEO5nBDjCVvRa+qXlP7YYuqY88d4HoZvqGYPCGErPR7Gf1vWDuVX7HkkrowjQjsYt678GktWWflP94KqfzbsCxVmN2QD2osXdbwwIo9J6etxAXkSYl3PQ3YvkIlFTlVFjyFh8qqlhH/pTGlGIT24w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526492; c=relaxed/simple;
	bh=YiqthkFJefj6cFwihBatnEvjFdnnQ2yuJqYorJcmU9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nj0Byj0FZm+De4PbE/ryhMB7x8mR49eh8PiAQctw/YC9/KKxGN2YUposulmb54kkrZeR7vAmmsxaI0t1iWkZO8fEDaNfGEMxMJqhXfikstzM23Onc1C+XorFj7bQX0jZYXMiJVO1gqqy/w9Z1OoLzBo6MVpUox8caJPOhSuiew4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sBfTUe5o; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sBfTUe5o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvI3sLWCDfXVsoJFpjeKHEiCcjanw4ByriJYa93oLXa86NSpIo7GNhJ4gFsODl6e6n/3Q6Vr7Osdta/hMZRdK4C8G1D5Hkvo1lsVhb0kA+hG+QJ+m8HF8LYUkGc9wLtSdCptHPEqMLSlqJQa5cpRRqDDxsH3hgXfPuZwzb7vvC3rqMTcnRarATCMzHRGI3fVCYsf27rnXIFGMHtqfTKhQcvYveTVfPzq3ByTfZ7YxyllB3ZIyzJpwwzFOZOqL79K/00BIxVE5sfbMNYj5CgBYJwb1ONWgwJNm2OLll5WWMrCy70yY8VtkZbuJicCHX6XGrv1Ckyw5OKVlDVIvRUnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9oeoV7yey9aa2H96R7hBpeS1DnnxwL8Up+0eZHpsgE=;
 b=P05h8GiBhlMU71a7OMLAlAQ4klLbJqLFGAGMqxmjxboo55dPt2hf6VAbAuSdmeQ8aPljTNPi83uCrVamlQiG/7jZW5UpVitoM/hd8o5DFQ08uQ1DZkFKCX3+Q5CQhlU2kwAmAAtGvxP3qhCRXddLcK2f/cyK8a6DtqHQEHTOvPF65Qhtc0BotsHCxgoSdNKleucAXWOAqbsNuIHKysz7BD6ZaJm7X73qOSHIJlwQl6lJBh2jqOBZSY91ULp+m1qSCXFHUK3M3gyTFhfaO74EGfRSXw5sOEJ/ItDu5OCc/Li/Heg4qhj0h9rStCgG2+HAtZ1SUc9fBUT4HcZVOXaxnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9oeoV7yey9aa2H96R7hBpeS1DnnxwL8Up+0eZHpsgE=;
 b=sBfTUe5olfacY1C0pWJjJY3o2psqF7S2kSBOGVKeIjBwRk7svoOcBtoBA02lYg4ni6UsQyw/L/fRbBwynkziX3HuS8L+odBikRPBrGR0cOHAV7hw/yjRIUTDTpkoZG23UWem7Y+ubyBK/WOxVAsuFsgOmkw4/g5ltE9WEMdqdUUMfdx/FEqSpqtThkx9tVKLfhfmo2C+MuiGboXbRH0XisuMvGcR/1ZIn7CViWBnCEfKTW+rE0x8V+zxb6k/CO3Ri+/N6YZafLPjQsGdAzmPNO4HXO3rlDxJDiApbB28jFJxAocSq7P6mE7nk8uBYGjuJ51mh6DcMtTj+qnfV4anfA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:44 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:44 +0000
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
Subject: RE: [PATCH v5 18/27] vfio/cxl: Expose the HDM memory region to the
 guest
Thread-Topic: [PATCH v5 18/27] vfio/cxl: Expose the HDM memory region to the
 guest
Thread-Index: AQHdRgq2DVZ0kIocgkufipcduECkC7bZ5ACAgBruONA=
Date: Fri, 9 Oct 2026 06:14:44 +0000
Message-ID:
 <IA1PR12MB90307CEE420D039D0CC6DCE9BD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-19-mhonap@nvidia.com>
 <20260921201405.16db1b89@shazbot.org>
In-Reply-To: <20260921201405.16db1b89@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 11de74f4-612d-4b28-af09-08df25cc9ca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|18002099003|22082099003|10067099003|3023799007|38070700021|11063799006|4143699003|5023799004|56012099006;
x-microsoft-antispam-message-info:
 PQxcJa+ibA6PDYI7WgYVRc0wGn27cPlFLkEychkUs+4/nonPyUwEAXjNxrtdwIQ04i2L6d+izf7Vjzmp76wDLsSIbz77BVnVxBTN/ogWDYRUV4LYfeM0GrfQdszFgoIHQKSGkaqsAZYeJWC/4p/qlTHYitbQizxozr0OABYnBhf8I7pAacel9uyZX5ec+dfii7Hno18JqudDnHy0CDiI31k2LYEdVlt4VtU7t2kxKuznHQjJ3d38EEIwC2xvqVN6tTouMw/Rb1ASBs1EwlDV2FEDOX8qMm+YiQULPzDTY7hCZUWDqbI4v8D+G/HlRwQXC+Kn8y0wmsWYpQJtMiw2hRFLVS0ktKOexSu4ZjyHqyMB8j3sDx5CCtsV3OllMhSfHH/vls77E8mn/lGYAGRVmOVK3CA9CxGu650HBwkvq+yQhdbwAQyR1IxFsiUJk8XhbTZFpx0ATpGLXHBx36WH3Teadru5sNLoBMOd3PnwJ7GA72M/60ngYHX2HNs2XnUgigPY+DcJri5+aRxEfUd8hiNjRfZdxcHZkgTZgNtIc2vpwoc9scpa5b99O+1MrooSHhJsOBN3dUEa/d5JI6Z4JpUdwMcGbiuge1M7p3C8skolV2vE5WLccpB1pq8u9YLGvLOpvvQFguclztKE/CYNn9yjVk71kgAaVHZ1PzPzexJCgfDb8MmNuHugloRZVqH0nUQcBzSsSEnN/m4hqzOfQYpNICafXEdpYs/3n4Eniwc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(38070700021)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dvkrklHURM4YlXpg7nj6KFUctmauso5BnRtvWAAasbQ+3+7Cxb0Ew0gMY/O2?=
 =?us-ascii?Q?SXMDjy+26ZUaEVehNKqY/aKEHe9LBy2qUCyPG5LuRpSmUUMQ1rQioOFlN9yX?=
 =?us-ascii?Q?nECwsYiLjmxjmGSayZaBr4Nl1pa8OxDgPImJxKZdArc3smxLczqlj2ftszBf?=
 =?us-ascii?Q?YxzJOTxrFf5+RlKjrc87MsnGL6Oj0aU7Ve6/OjRzfv5Q/XT+f5xOMNyJE7tV?=
 =?us-ascii?Q?9gnRj6TChGEmYmrf/mJkqPdhMoVrIYGpgRslKcdvueeSItj8fcVyQxWUg5iX?=
 =?us-ascii?Q?ZqVHOtnxNku5NgNEy/pFkxniAx22wrglBP6VI+YaMaemoni/2znk6y9mJJ4F?=
 =?us-ascii?Q?958FTpjOQlDfwddIZ1WIBXEU1yFSdgXhcNIS29l4/gmy+b9VfQVKrIhr5IfJ?=
 =?us-ascii?Q?kZjoBlJlUMF3iIbXol0Gy4x8xTGpY9BiPzPz9gj+8RTHhC4JZbTVhbpUlYow?=
 =?us-ascii?Q?DKgFRCSzfotkYlBfjMt/oFNa7hTHlrUelyijOtHc200cRV2I5RbqVnq0SQbj?=
 =?us-ascii?Q?AywnZoUe96z3ILaTakQfP0qNi39RsSwlissSr+PCjmAXgsRpTZH4ToYq1Ajx?=
 =?us-ascii?Q?dOXe9/5ZezUqGuwMswaOdJSflgBRP29ZcLqfUDYgznUNPg9ImBUsln2Ugh+B?=
 =?us-ascii?Q?NgAORVkc49pJd3DGu/VljB5uLqWuQgiI0cPZlmszgUlDcpDPS0sYD8sbeK6c?=
 =?us-ascii?Q?PX5/HjRJDs03NVFgKlEVlq28D9EP7mPzG7LQ98g6O4Sd2TSqpredqRMhGyqD?=
 =?us-ascii?Q?ohvqGuqairCMf1zRQNYbfy8b4hRlXTnzZumtpbwX8+jSyi/tv1Wvj0FT807E?=
 =?us-ascii?Q?xbTQeCRMHKDkX7KOiPZQTY04Hrfq7J7J/kd4TF8DkaiseVY/Ef7UO3G/zv7d?=
 =?us-ascii?Q?xMU5cvBsKEs3PGQNIJH0vXJnJXwWlN7aTdQwanM1nCSTA4Xh+heSZzrIZi0V?=
 =?us-ascii?Q?gvJXVZ6KuqYqU+G9rjE/t76uZXFfvWF0nraokZHO+Cn5S1snhSUsHSoYPXNc?=
 =?us-ascii?Q?5Gdf7OhgZeo6NggygrSHAykUraGRkQ71y4AkFAweJWlalCd18cqFFrpVdDbH?=
 =?us-ascii?Q?PV+06jg6VYtVmoSNS6etrAPkDwfXQz/Uv9EJcJ9W5wbZzi6HjXD35M9JXfUm?=
 =?us-ascii?Q?0XI1XwNUojQ77aizfthJsR9/52b02/rDVJYi+NsvNq8tzmU0TOnzF6abKWCh?=
 =?us-ascii?Q?yzqqbnAwBrcMGiYHW31nTzbdh1FvTzeGkmDfwmPL4kUM2M0Vcc1Ce9+T2AAa?=
 =?us-ascii?Q?Ii0CJr3jUFfxm8NPab8iTfvI8D4yGf0zrUrI5ZqdLUgQ6IvwSGrYmBMvN6w4?=
 =?us-ascii?Q?a4OzxsRp0QvrKqfbLnw6II0IwmjAqG9hUMpRDd8kL8B4mH3iVP47vunKJ8xJ?=
 =?us-ascii?Q?LEKh2QeupxnV2okfKOlz4SrgdsUdfh8Ig0DSfmhNGZ/LwEiX7m6Rn6dIFGQ6?=
 =?us-ascii?Q?/aRAW7hJ4uh6hpyIoS0Lvm/dg/gWYfnmVID18C3QloLRsSxMJoqO8GsCMXk/?=
 =?us-ascii?Q?Bm3Neoxx/dm6OyXvj22x7xxNeM2SKsWjBWJzqtx1m/aKoWLLOawbledj89kY?=
 =?us-ascii?Q?O2UQJQcsQiAG9uuqy86P8/kODriTWuIhIYgwPvevXiYSOz0aJKlJNtdxvUkk?=
 =?us-ascii?Q?7g4hMuRWB0r7PwcgRwsonosBFVr43/zHYqi891xh4pthmUT1ICJVEm+RITpb?=
 =?us-ascii?Q?QAdAMk+re0mk1iQEGtmAEW5Q+qIFUh8w++UNaalQiPg3rbKh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11de74f4-612d-4b28-af09-08df25cc9ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:44.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bh2MnmA9epdN6M9bO18Yku5Vfk/XhM2Qf97ybv4AvUH29MXTVaWb9Ez7UMqH0U6h/Y4a5FYabgDOOUiag61y5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Tuesday, September 22, 2026 7:44 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
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
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v5 18/27] vfio/cxl: Expose the HDM memory region to t=
he
> guest
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:31 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 guest maps the device HDM memory to use its coherent
> > CXL.mem. The HDM memory is a host physical range with no struct page,
> > so the guest and KVM need a write-back mapping of it.
> >
> > Register the range as an mmap-able region under
> > VFIO_REGION_TYPE_PCI_VENDOR_TYPE with the CXL vendor id rather than
> a
> > bespoke region type, per open because vfio_pci_core_disable() tears
> > down all dynamic regions on close.
> >
> > Own the resolved host physical range exclusively
> > (IORESOURCE_EXCLUSIVE) so nothing, /dev/mem included, can map a
> > conflicting cacheable alias that would fault the host once the range
> > is mapped write-back.  There is no devm form of the exclusive request,
> > so pair it with a devm release action.
> >
> > vfio_pci_zap_bars() only unmaps the fixed PCI BAR range, so revoke
> > mmap-capable device-specific regions there too.  Otherwise a
> > Memory-Space disable, a D3 transition, or a reset would leave the
> > guest a live mapping into quiesced device memory; the fault handler
> > re-gates on device state before it inserts a pfn again.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 186
> +++++++++++++++++++++++++++
> >  drivers/vfio/pci/vfio_pci_core.c     |  37 ++++++
> >  include/linux/vfio_pci_core.h        |   1 +
> >  include/uapi/linux/vfio.h            |   4 +
> >  4 files changed, 228 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 5c8a63833a43..5b65cac30aba 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -5,9 +5,13 @@
> >   * Copyright (c) 2026 NVIDIA Corporation & Affiliates
> >   */
> >
> > +#include <linux/cleanup.h>
> > +#include <linux/io.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/range.h>
> > +#include <linux/uaccess.h>
> >  #include <linux/vfio_pci_core.h>
> >  #include <cxl/cxl.h>
> >  #include <cxl/pci.h>
> > @@ -17,13 +21,144 @@
> >   * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create(=
)
> >   * @cxlmd: memory device joined to the CXL topology at bind
> >   * @hpa_range: host physical range of the HDM region
> > + * @hdm_valid: true when host CPU access to the HDM range is safe;
> > + under memory_lock
> >   */
> >  struct vfio_cxl_state {
> >       struct cxl_dev_state cxlds;
> >       struct cxl_memdev *cxlmd;
> >       struct range hpa_range;
> > +     bool hdm_valid;
> >  };
> >
> > +static unsigned long vfio_cxl_mem_pgoff(struct vm_area_struct *vma,
> > +                                     unsigned long addr) {
> > +     unsigned long mask =3D (1U << (VFIO_PCI_OFFSET_SHIFT -
> > +PAGE_SHIFT)) - 1;
> > +
> > +     return (vma->vm_pgoff & mask) + ((addr - vma->vm_start) >>
> > +PAGE_SHIFT); }
> > +
> > +static vm_fault_t vfio_cxl_mem_huge_fault(struct vm_fault *vmf,
> > +                                       unsigned int order) {
> > +     struct vm_area_struct *vma =3D vmf->vma;
> > +     struct vfio_pci_core_device *vdev =3D vma->vm_private_data;
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     unsigned long addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orde=
r);
> > +     unsigned long pfn =3D PHYS_PFN(cxl->hpa_range.start) +
> > +                         vfio_cxl_mem_pgoff(vma, addr);
> > +     vm_fault_t ret =3D VM_FAULT_FALLBACK;
> > +
> > +     if (is_aligned_for_order(vma, addr, pfn, order)) {
> > +             scoped_guard(rwsem_read, &vdev->memory_lock) {
> > +                     /*
> > +                      * Insert a PFN only for a known-good decoder who=
se
> > +                      * media is ready and whose Memory-Space is enabl=
ed.
> > +                      */
> > +                     if (__vfio_pci_memory_enabled(vdev) &&
> > +                         cxl->hdm_valid && cxl->cxlds.media_ready)
> > +                             ret =3D vfio_pci_vmf_insert_pfn(vdev, vmf=
, pfn,
> > +                                                           order);
> > +                     else
> > +                             ret =3D VM_FAULT_SIGBUS;
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static vm_fault_t vfio_cxl_mem_fault(struct vm_fault *vmf) {
> > +     return vfio_cxl_mem_huge_fault(vmf, 0); }
> > +
> > +static const struct vm_operations_struct vfio_cxl_mem_vm_ops =3D {
> > +     .fault =3D vfio_cxl_mem_fault,
> > +#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> > +     .huge_fault =3D vfio_cxl_mem_huge_fault, #endif };
> > +
> > +static int vfio_cxl_mem_mmap(struct vfio_pci_core_device *vdev,
> > +                          struct vfio_pci_region *region,
> > +                          struct vm_area_struct *vma) {
> > +     unsigned long mask =3D (1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT=
)) -
> 1;
> > +     u64 req_start =3D (vma->vm_pgoff & mask) << PAGE_SHIFT;
> > +     u64 req_len =3D vma->vm_end - vma->vm_start;
> > +
> > +     if (req_start + req_len > region->size)
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * CXL.mem is coherent memory, so leave the mapping write-back
> cacheable.
> > +      */
> > +     vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND |
> VM_DONTDUMP);
> > +     vma->vm_ops =3D &vfio_cxl_mem_vm_ops;
> > +     vma->vm_private_data =3D vdev;
> > +
> > +     return 0;
> > +}
> > +
> > +static ssize_t vfio_cxl_mem_rw(struct vfio_pci_core_device *vdev,
> > +                            char __user *buf, size_t count, loff_t *pp=
os,
> > +                            bool iswrite) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     u64 pos =3D *ppos & VFIO_PCI_OFFSET_MASK;
> > +     void *mem;
> > +     ssize_t done;
> > +
> > +     if (pos >=3D range_len(&cxl->hpa_range))
> > +             return -EINVAL;
> > +     count =3D min_t(size_t, count, range_len(&cxl->hpa_range) - pos);
> > +
> > +     scoped_guard(rwsem_read, &vdev->memory_lock) {
> > +             /*
> > +              * Same gate as the fault path: only touch the HDM range =
with
> > +              * the decoder in a known-good state AND Memory-Space ena=
bled,
> > +              * or a host CPU access aborts as a fatal SError.
> > +              */
> > +             if (!cxl->hdm_valid || !__vfio_pci_memory_enabled(vdev))
> > +                     return -EIO;
> > +
> > +             mem =3D memremap(cxl->hpa_range.start + pos, count,
> MEMREMAP_WB);
> > +             if (!mem)
> > +                     return -ENOMEM;
> > +             if (iswrite)
> > +                     done =3D copy_from_user(mem, buf, count) ? -EFAUL=
T : count;
> > +             else
> > +                     done =3D copy_to_user(buf, mem, count) ? -EFAULT =
: count;
> > +             memunmap(mem);
> > +     }
> > +     if (done > 0)
> > +             *ppos +=3D done;
> > +
> > +     return done;
> > +}
> > +
> > +/*
> > + * The CXL regions carry no per-region state (region->data is the
> > +shared,
> > + * devm-managed vfio_cxl_state), so releasing a region is a no-op.
> > + */
> > +static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
> > +                                 struct vfio_pci_region *region) { }
> > +
> > +static const struct vfio_pci_regops vfio_cxl_mem_regops =3D {
> > +     .rw =3D vfio_cxl_mem_rw,
> > +     .mmap =3D vfio_cxl_mem_mmap,
> > +     .release =3D vfio_cxl_region_release, };
> > +
> > +static void vfio_cxl_release_hpa(void *data) {
> > +     struct vfio_cxl_state *cxl =3D data;
> > +
> > +     release_mem_region(cxl->hpa_range.start,
> > +range_len(&cxl->hpa_range)); }
> > +
> >  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)  {
> >       struct pci_dev *pdev =3D vdev->pdev; @@ -120,6 +255,21 @@ static
> > int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
> >               goto err;
> >       }
> >
> > +     /*
> > +      * Claim the range IORESOURCE_EXCLUSIVE so no conflicting cacheab=
le
> > +      * alias can fault the host once it is mapped write-back; there i=
s no
> > +      * devm form, so pair it with a devm release action.
> > +      */
> > +     if (!request_mem_region_exclusive(cxl->hpa_range.start,
> > +                                       range_len(&cxl->hpa_range),
> > +                                       "vfio-cxl-hdm")) {
> > +             ret =3D -EBUSY;
> > +             goto err;
> > +     }
> > +     ret =3D devm_add_action_or_reset(&pdev->dev, vfio_cxl_release_hpa=
, cxl);
> > +     if (ret)
> > +             goto err;
> > +
> >       cxl->cxlmd =3D cxlmd;
> >       devres_close_group(&pdev->dev, NULL);
> >
> > @@ -143,13 +293,49 @@ static void vfio_cxl_release_device(struct
> vfio_pci_core_device *vdev)
> >       vdev->cxl =3D NULL;
> >  }
> >
> > +static int vfio_cxl_add_region(struct vfio_pci_core_device *vdev, u32
> subtype,
> > +                            const struct vfio_pci_regops *ops, size_t =
size,
> > +                            u32 flags) {
> > +     u32 type =3D VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> PCI_VENDOR_ID_CXL;
> > +
> > +     return vfio_pci_core_register_dev_region(vdev, type, subtype, ops=
,
> > +                                              size, flags,
> > +vdev->cxl); }
> > +
> >  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)  {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     int ret;
> > +
> > +     /*
> > +      * vfio_pci_core_disable() frees all dynamic regions on close, so=
 register
> > +      * them here per open rather than at bind. A failed first open ne=
ver
> > +      * reaches close_device(), so unwind on error.
>=20
> There's no unwind here.

Yes, the comment is wrong. I will update it.

>=20
> > +      */
> > +     ret =3D vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_MEM,
> > +                               &vfio_cxl_mem_regops, range_len(&cxl->h=
pa_range),
> > +                               VFIO_REGION_INFO_FLAG_READ |
> > +                               VFIO_REGION_INFO_FLAG_WRITE |
> > +                               VFIO_REGION_INFO_FLAG_MMAP);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * The decoder is firmware-committed, so host access to the HDM r=
ange
> is
> > +      * safe. Open the access gate; reset and power transitions clear =
it until
> > +      * the decoder is restored.
> > +      */
> > +     cxl->hdm_valid =3D true;
> > +
> >       return 0;
> >  }
> >
> >  static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
> > {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +
> > +     cxl->hdm_valid =3D false;
> >  }
>=20
> If hdm_valid is set on open_device and cleared on close_device, how is th=
is not
> redundant to open_count?  It's totally superfluous everywhere it's tested=
 in
> this patch.
>=20

Yes, in this patch it is redundant.
hdm_valid is meant to say that the HDM decoder is known to be committed,
and that only changes across reset, bus reset and low power.

In v6 it will be set at bind once the committed decoder is verified, introd=
uced
in the first patch that changes it and not touched at open or close.

> >
> >  static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index ddd6807893fd..8913a9e24302 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1295,6 +1295,23 @@ int vfio_pci_core_register_dev_region(struct
> > vfio_pci_core_device *vdev,  }
> > EXPORT_SYMBOL_GPL(vfio_pci_core_register_dev_region);
> >
> > +/*
> > + * Unregister the most recently registered dynamic region. Used to
> > +unwind a
> > + * partially built region set on an open-time error; regions are
> > +otherwise
> > + * released together in vfio_pci_core_disable().
> > + */
> > +void vfio_pci_core_unregister_dev_region(struct vfio_pci_core_device
> > +*vdev) {
> > +     struct vfio_pci_region *region;
> > +
> > +     if (WARN_ON(!vdev->num_regions))
> > +             return;
> > +
> > +     region =3D &vdev->region[--vdev->num_regions];
> > +     region->ops->release(vdev, region); }
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_dev_region);
>=20
> This is not a good interface, implicitly popping the last dev region adde=
d.  The
> whole interface should change to push and pop semantics if we're doing th=
is,
> but we shouldn't do this.  It would be better to ask to remove a specific=
 region,
> identified by some compliment of the creation parameters, with a memmove
> + collapse on the array.  Or perhaps this justifies another data structur=
e.
>=20
> This is also unused in this patch.  Why's it added here?  This patch alre=
ady does
> too much.  We could have lead with read/write access and followed with
> mmap support in another patch.
>=20

Okay; in v6, I will drop vfio_pci_core_unregister_dev_region().
Its only use is to undo regions after a failed open, and vfio_pci_core_enab=
le()
can do that for every region: I will move the region release loop from
vfio_pci_core_disable() into a helper and call it from the enable error
path as well.

I will also split this patch into read/write access first and mmap second.

> > +
> >  static int vfio_pci_info_atomic_cap(struct vfio_pci_core_device *vdev,
> >                                   struct vfio_info_cap *caps)  { @@
> > -1972,8 +1989,28 @@ static void vfio_pci_zap_bars(struct
> vfio_pci_core_device *vdev)
> >       loff_t start =3D
> VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
> >       loff_t end =3D
> VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
> >       loff_t len =3D end - start;
> > +     unsigned int i;
> >
> >       unmap_mapping_range(core_vdev->inode->i_mapping, start, len,
> > true);
> > +
> > +     /*
> > +      * The unmap above covers the PCI BARs; mmap-capable device-speci=
fic
> > +      * regions (e.g. a vfio-cxl HDM window) sit above that range, so =
revoke
> > +      * them here too, or a Memory-Space disable, D3/PM transition, or=
 reset
> > +      * would leave the guest a live mapping into quiesced device memo=
ry.
> > +      * Callers hold memory_lock, so the region array is stable.
>=20
> memory_lock doesn't protect the region array, it's allocated at init/open=
 and
> considered stable.  Like v4, this is arguing where it's convenient that w=
e need
> to guard against PM transitions while also preventing PM transitions.  Wh=
y
> don't we just support PM?

Agreed on both. I will remove the comment and v6 will supports PM. (added m=
ore
details in patch 16 reply)

>=20
> > +      */
> > +     for (i =3D 0; i < vdev->num_regions; i++) {
> > +             struct vfio_pci_region *region =3D &vdev->region[i];
> > +             loff_t roff;
> > +
> > +             if (!(region->flags & VFIO_REGION_INFO_FLAG_MMAP))
> > +                     continue;
> > +
> > +             roff =3D VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_NUM_REGIONS + =
i);
> > +             unmap_mapping_range(core_vdev->inode->i_mapping, roff,
> > +                                 region->size, true);
> > +     }
>=20
> There's an assumption here that doesn't seem well founded that a device
> specific region that support mmap is necessarily dependent on the memory
> enable state of the device.  We could have chosen to report the coherent
> memory nvgrace uses as a device specific region, we know it's not tied to
> memory enable.  We could support mmap on something like the IGD
> OpRegion if we chose to map a whole page for it.  There's an implicit
> dependency here that I don't see baked in to simply supporting mmap.
> Thanks,
>=20

Okay. In v6 I will make vfio_pci_zap_bars() cover only the BARs. vfio-pci-c=
ore
will export a helper that revokes one device-specific region, its mmap
and its dma-bufs, and one helper to re-arm it.

vfio-cxl will calls these on the events that change the decoder state: rese=
t, bus reset
and low power.

> Alex
>=20
> >  }
> >
> >  void vfio_pci_zap_and_down_write_memory_lock(struct
> > vfio_pci_core_device *vdev) diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 475a0ecf9e4f..39a28cc6ae8c
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -198,6 +198,7 @@ int vfio_pci_core_register_dev_region(struct
> vfio_pci_core_device *vdev,
> >                                     unsigned int type, unsigned int sub=
type,
> >                                     const struct vfio_pci_regops *ops,
> >                                     size_t size, u32 flags, void
> > *data);
> > +void vfio_pci_core_unregister_dev_region(struct vfio_pci_core_device
> > +*vdev);
> >  void vfio_pci_core_close_device(struct vfio_device *core_vdev);  int
> > vfio_pci_core_init_dev(struct vfio_device *core_vdev);  void
> > vfio_pci_core_release_dev(struct vfio_device *core_vdev); diff --git
> > a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h index
> > e41437fa17ad..1bf86763c0f7 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -370,6 +370,10 @@ struct vfio_region_info_cap_type {
> >   */
> >  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD (1)
> >
> > +/* CXL Type-2 device (0x1e98) sub-types for
> > +VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
> > +/* CXL.mem HDM region of a Type-2 device, mmap-able */
> > +#define VFIO_REGION_SUBTYPE_CXL_MEM          (1)
> > +
> >  /* sub-types for VFIO_REGION_TYPE_GFX */
> >  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
> >

