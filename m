Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697802C15A0;
	Mon, 21 Sep 2026 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985141; cv=fail; b=NNmfHL9dSXniPdslyO6hBNXTmlDlz3fymPFxq8CQPm9pfiIHHmKBsQCgVLN4Wa7urcggOiw7M2ajkjkLg0vKsECm3krNyEdSYhZRjtsVzHbZf5UcEKq6q4gXV+ywLlCgNDHvQvOG8PNQ0dmrfQPFFFdu5BlVz5ck9kW/1tTRQis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985141; c=relaxed/simple;
	bh=Q9tWzS38fD/uR7ywjALnCkIquTLQ5tJpywlBiOuPePs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XS8azfw+7Z9tQpLsNTvN47cmEp+N5NB5uFXJTCRG4GYJZ1t/Y/99pDxFSJqvedmBYLDjsWicjpJxmVLeH/saGdJgKcG+xhywVqJtlyf90Saz7H2OcCb5jYfsNbM8dynumFSbZ9dd/VJb25ovMz7SpXWKTFMQCnI3Y5tgTDjq+w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWJ/bzO2; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWJ/bzO2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9Hl/CtGbmg8fjdZuvGY2ba9UehksQJ84lX+zTFPX+UACHICP/m4unEEVhuRGfckJh2OjUBHfRolSR3oh4oDWupFL8T3E3FrILkp5YUbCS/QD3Q/3cQAN/nNprOjjEA7k20IZ24OdrxrUFDx9wrpdtSC9joDWOoGiF2WNT66EVOsa6uT0P5q1RvDxrwDrU2TBGrAva1k9gMcjNUyQcjyPEQqnGHRSdhWJ1PSOrzG66QfihWyTvLaLSXtg+dEts+w/OvTfcbsSS4DO5pT/2o9KzgQSokcutiAKUIEuCRz5A8YrslFbyL7u2ie1VT2hVvUqfpa3GJVv0lVboAiosk8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCW0yeCmAK+bmUUx0AD10/BHvXx/CfSpw1xvTgeF1h4=;
 b=sYCqQ7Hd+HEEHBJIgpH7qNNjrTusxnt8Lc/HcdhlGRu89l56kOrzOtbFs6hos5CS2/zzNcNWRNjvV1W9YNYmMA+BYJD0sLuqBk5Ax3X8xI/VbeIso2nEadOxj65uW+oK9h6dUcpotDuoqlF592aDSANIPQvPDrOhNv6i05+7qHQijHjNTQwtNtKUNxnex+6qonCkYtO7RC8xboqZ9bq8vbZEeruR23KUiILrjOEsabgxdGzm0TByWoEeSn/+ux6y8qG4Wkq3XKIDPzZ9xREQ5hdFpql41we0zVGlIfE6fmE/N+UxRJvHbqtWX22oqz2do+xAqJ+bE58pPY+qyTHIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCW0yeCmAK+bmUUx0AD10/BHvXx/CfSpw1xvTgeF1h4=;
 b=CWJ/bzO2feXV5Xz2DPSHPV3KQmRZBWBOkYvFe9SJbVB+9u6LYBM9l/EjxkULgeYQdBhHb+L/1JzcB1y+pIYvRtrEtSAgoFSvKZ5aC3JqHAo2MRr/15GPwRtGEykWmeNlpeKzkV776ilRXwHcD8QWzUlWvYeKeHvnpoF6RLINrUI/SlJ+XUvcHA5hYu+kHo73KzGn+O+w1XXSmByB2z9IUFXrvKLeMq15a0f9sJH8NZACCiw9Peu6xrcM5aXww9c3dLfwuPy3kCMj07s02qnNpSegS1HL1WEzZRrWr2DRaBiAPGMisE2hNL1Af+4gAByYOnueWB/8dWHkkeyc91aZog==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 10:05:30 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 10:05:30 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Richard Cheng <icheng@nvidia.com>
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
Subject: RE: [PATCH v5 06/27] vfio/pci: Detect CXL devices and load the CXL
 provider on demand
Thread-Topic: [PATCH v5 06/27] vfio/pci: Detect CXL devices and load the CXL
 provider on demand
Thread-Index: AQHdRgp0IN2H5fI/1U+81S1A1Zc0qLbSdnEAgAZeFtA=
Date: Mon, 21 Sep 2026 10:05:30 +0000
Message-ID:
 <IA1PR12MB9030D0A74FE0BABC769DCCDBBD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-7-mhonap@nvidia.com> <aqun1vZcE3gQzXD9@MWDK4CY14F>
In-Reply-To: <aqun1vZcE3gQzXD9@MWDK4CY14F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|IA0PR12MB8974:EE_
x-ms-office365-filtering-correlation-id: a6c3da83-7f45-43af-017e-08df17c7de57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|4143699003|38070700021|56012099006|5023799004|11063799006|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 Uf85updehh3XL0I2JeIVVSa0Tfsj1LJb/r4ONHdLdciWp/vWqD9JsPNqUrVlSm0Wv2Z3zwurLPVA1hwzjDwTiUswUDMWFI6APqX13VMf07OUgk6iDq7xaSvpakWsc4OSpstBOo7qwg/bhuguqy0IOqI0lDOEb1oYSp5KUNWiuHrnJVYPApIwjSnmEKkrOOWVj565KO93I7n5fjAxwecp3buLHNrFhwqaexic2C57zWSo6dMEirMPQoE3iqLJszeYBVSSGagfWgqj/zF9d2alVitfOJk4OUSjG05AEDyIlwjdmQ6x3u1PbPvjCN6iCZnuMVzOavx19JZY6BWX9E7kBDEN80fuI0brFGpmI1EvsW+mz9S24T3KaJW7uga79e+3v27w7/jFZPaZO501oebslvIcmNo/f4EXsev4+QN9Fn59hfaZmDVHGNTANu8tfJY8kYOEp3Kem9JYnYEB82mOXlzH/4P5rLM5X/gOAjVpGPDFEK657Iszngi8D+o4LBuuv+Z+oLf6Qu8HevFn5S2w9OH5a0LWpZ+RHlWL5AkXFsLQYw0uFg8RfE1uV0rNdhJ9B1PKS95izSLqJaTZuqqGn5gSRgrSFo+nhCWXcsMSJu8VfPZK/Vkt4VTjDqwrdthBQ064GkOmb3fUY5RIfvMqLlbYMXkyVFaujafK6nioxAPR2QTBFTdy5nXUBso8VYIkDueCxPpzUjNbUKD1+RhWga4MYsJKicbuUhGnfboc5no=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(4143699003)(38070700021)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hyy8kErxscK8nM9svWXXf6o5ifFGKhv8D4Wm4AzVdENYczg5JEOkJvvgUkMS?=
 =?us-ascii?Q?WEXVD56wGJ9eSFOJT0aIZ+X2q4ON5m4jX5SpXYkW2Wcq7hYc7ixMKdvsE844?=
 =?us-ascii?Q?51smS3EmLatzyuut+SvOhzW6Y05magIEatiqOOvMr9j4aEGAdhzMwHvP24OL?=
 =?us-ascii?Q?4gF25xji45CGLxIvv2fVDdlNYnkQjzWIbRCisuD841TUtI4Hur7SfWdMfROM?=
 =?us-ascii?Q?MolMshZeQTko8vroYg+rHei5+K0V2uJHsu8rmrs2PtKcNwdOxp7Msi8W7b1C?=
 =?us-ascii?Q?5ImAnFVInknqrBglHC1AmV6uA41cAkVYAxldtIqE/5yxhfAdnDxFvj1eMKp1?=
 =?us-ascii?Q?mxYdqxSKqJLbvVRR/ueKzp2jcmN/P7k4ghvjVmXZTpI5gCfL9QfNqIAu709a?=
 =?us-ascii?Q?g757N8PDFnmh49NtN5nJh91eWIEGAxvlePt6EYFW/gZkwuMgnznBiZ4dIvS7?=
 =?us-ascii?Q?sbgd9lPKotuQdetyg247+3WfOlckYT4HdKf8HuALG31r1HDVPDrT6GS/zdlB?=
 =?us-ascii?Q?rsmMKUGeGpfYRXqOu7bfcIuXlt2nIwZoBlIPrI3RRvFl94WhF1v7O7pZ0Py0?=
 =?us-ascii?Q?uhPg5OtauBKlnO+u/rsyWvTf431XYinNsaMMYnkcI3MhSboby24IZ1Me6R6N?=
 =?us-ascii?Q?PimLfLcXNl8zV6iwtrHEd24gx1ursXq8eqg8oiC83rEjTiKxyZm5N3Xod0M7?=
 =?us-ascii?Q?f8d98CCX8eudixBi+8xF4+5qjbaUJI6/QvYiLRr2qdJoyKGQMAmKY/eUWFxv?=
 =?us-ascii?Q?z1T096ZDpmuKnzLKWzOBKGmVFAWbkc74i8WfCrQ9Ej8CWrhReJplkV8fM4zZ?=
 =?us-ascii?Q?Xaaq2ZX4KKz5Sg5QTmePfG2Z2zsKxcsCSbr8snUv0ifY0COXtsU6wWJJOQUx?=
 =?us-ascii?Q?4iZJe9tbnTwUMgub1dyPMLmCPjzfcyvJT5sG/8ALiQ4DM6N01bB2JuMhfKMA?=
 =?us-ascii?Q?0wbvoDt1ruDC8EhM9Is51EBbTBaviXriVrhet35Vt7Vgyor6fCxb0a3c+waA?=
 =?us-ascii?Q?hoDvDE3/08oZLxs0RPR1lGs/8vMX2Mu99haC5Gownt6KqwcNAEgmMxVvv22f?=
 =?us-ascii?Q?/h84tgif4toKC596CYSefGtR5Antdt42HBW5HdlPwoX9NcKKPDCrPeGoanUO?=
 =?us-ascii?Q?jUZMCqLI1OaDT8ciao2yBMIuDIU4Hh3CmI4G98qsgqw8a9C0Bl7y4BqC2Ve0?=
 =?us-ascii?Q?iPfaCCT8F1jquGonIsqc4+9YOQYPkQHbbjZOIiQwZkIcmQnFTZXLnmwFAYYD?=
 =?us-ascii?Q?lMCkrjA4ANG1GxtlubFf4mdrrMDxwgs/T59g5ReqKSDB353XfebIVqsEZo+4?=
 =?us-ascii?Q?DqSZg6X12ZE8evMHNzTBtLNsKDP0mH7IP+siyQtftam/shD963wvZj3y6L6h?=
 =?us-ascii?Q?MksRvyvYb1ZrOpCP/1xD59wyqqwYeO/Dfgv3I+i31TJ5e+M4Ccl8re/7x/Y+?=
 =?us-ascii?Q?9lKv6xsA7BhUMNphcluWamKf2h8QRLbvT9GRy7ha3IsGAbVlsa3MXAaHz6aL?=
 =?us-ascii?Q?5dRLTNB4zIqHuIKjo/a8tp4S4nEN+jhDnt+iClxImPffzi153FjiJr4kkf+W?=
 =?us-ascii?Q?Pvij+3cE+sb4Z5+khm0dWKK/86pUM1/sr6Hh94tSbz/QS8+RJWzx3SWPiN0i?=
 =?us-ascii?Q?2bLyH/ZdPk/t3j/2IAZQK6GkcxuT3FZZwmUPh6hxLar/aR0A7xupeyEjE5ho?=
 =?us-ascii?Q?V7CH9m5hECUC4hMTUt4pLLE9j18/fEyUEi6PoHA+8eRHRcEG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c3da83-7f45-43af-017e-08df17c7de57
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 10:05:30.5535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdxGbPy43sF4xZT7DaCXkqKPiXlG5NbRbmXVfqqVcuXX/EtUFT1PgCP7ZcmfuaRw4f4ufGLo7rlzNMLbRsAthw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974



> -----Original Message-----
> From: Richard Cheng <icheng@nvidia.com>
> Sent: Thursday, September 17, 2026 2:18 PM
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
> Subject: Re: [PATCH v5 06/27] vfio/pci: Detect CXL devices and load the C=
XL
> provider on demand
>=20
> On Thu, Sep 17, 2026 at 12:05:19AM +0800, mhonap@nvidia.com wrote:
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and
> > the CXL core in unconditionally would bloat every vfio-pci setup.
> > Detect a CXL Type-2 device at bind and request_module("vfio-cxl") only
> > then, then hand the device to the registered ops.
> >
> > Each bound CXL device pins the provider through
> > vfio_pci_get_cxl_ops() (try_module_get) and drops it with
> > vfio_pci_put_cxl_ops() at release, so vfio-cxl can unload once no CXL
> > device is bound.
> >
> > If the provider is absent the device is driven as plain vfio-pci. A
> > built-in provider whose initcall has not run yet is waited for with
> > -EPROBE_DEFER; the deferred-probe machinery will retry the bind once
> > the provider registers.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 84
> ++++++++++++++++++++++++++++++++
> >  include/linux/vfio_pci_core.h    |  3 ++
> >  2 files changed, 87 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 2cc5dd20396c..9eede1e56ab5 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -2202,6 +2202,84 @@ void vfio_pci_core_unregister_cxl_ops(const
> > struct vfio_cxl_ops *ops)  }
> > EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
> >
> > +static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void) {
> > +	guard(rwsem_read)(&vfio_pci_cxl_ops_rwsem);
> > +
> > +	if (vfio_pci_cxl_ops && try_module_get(vfio_pci_cxl_ops->owner))
> > +		return vfio_pci_cxl_ops;
> > +
> > +	return NULL;
> > +}
> > +
> > +static void vfio_pci_put_cxl_ops(const struct vfio_cxl_ops *ops) {
> > +	module_put(ops->owner);
> > +}
> > +
>=20
> Anything guarantees that we can finish devres cleanup before dropping
> module ref ?
>=20
> This function drops the module ref during vfio_pci_remove(), while devres
> might still pending.
>=20
> I see in patch 18 it register vfio_cxl_release_hpa() as a devres callback=
, and it
> lives in vfio-cxl.
> If this drops the last module ref, another process could unload vfio-cxl =
before
> devres invokes that callback.
>=20
> Best regards,
> Richard Cheng.
>=20

Yes, I think it is possible that a concurrent unload can free the module te=
xt
the callback points at.

For v6, I dropped the devm action entirely and released the exclusive HDM r=
ange
in the provider .release op instead.

vfio_pci_core_cxl_release() calls ->release() and then vfio_pci_put_cxl_ops=
(),
so the range is released synchronously before the module_put; this way no
vfio-cxl callback outlives the module reference.

Thanks,
Manish

>=20
>=20
>=20
> > +/*
> > + * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CX=
L
> DVSEC.
> > + * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem
> > +only)
> > + * devices, which the vfio-cxl provider does not handle, so confirm
> > +the Type-2
> > + * identity before engaging it.
> > + */
> > +static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev) {
> > +	u16 dvsec, cap;
> > +
> > +	if (!pcie_is_cxl(pdev))
> > +		return false;
> > +
> > +	dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +					  PCI_DVSEC_CXL_DEVICE);
> > +	if (!dvsec)
> > +		return false;
> > +
> > +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> > +		return false;
> > +
> > +	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> > +		(cap & PCI_DVSEC_CXL_MEM_CAPABLE);
> > +}
> > +
> > +/*
> > + * Load vfio-cxl on demand for a CXL Type-2 device and hand the
> > +device to its
> > + * ops. If the provider is absent the device is driven as plain
> > +vfio-pci; a
> > + * built-in provider whose initcall has not run yet is waited for
> > +with
> > + * -EPROBE_DEFER.
> > + */
> > +static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
> > +{
> > +	const struct vfio_cxl_ops *ops;
> > +	int ret;
> > +
> > +	if (!vfio_pci_is_cxl_type2(vdev->pdev))
> > +		return 0;
> > +
> > +	request_module("vfio-cxl");
> > +	ops =3D vfio_pci_get_cxl_ops();
> > +	if (!ops)
> > +		return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
> > +
> > +	ret =3D ops->init(vdev);
> > +	if (ret) {
> > +		vfio_pci_put_cxl_ops(ops);
> > +		return ret;
> > +	}
> > +
> > +	vdev->cxl_ops =3D ops;
> > +	return 0;
> > +}
> > +
> > +static void vfio_pci_core_cxl_release(struct vfio_pci_core_device
> > +*vdev) {
> > +	if (!vdev->cxl_ops)
> > +		return;
> > +
> > +	vdev->cxl_ops->release(vdev);
> > +	vfio_pci_put_cxl_ops(vdev->cxl_ops);
> > +}
> > +
> >  int vfio_pci_core_init_dev(struct vfio_device *core_vdev)  {
> >  	struct vfio_pci_core_device *vdev =3D
> > @@ -2223,6 +2301,10 @@ int vfio_pci_core_init_dev(struct vfio_device
> *core_vdev)
> >  	init_rwsem(&vdev->memory_lock);
> >  	xa_init(&vdev->ctx);
> >
> > +	ret =3D vfio_pci_core_cxl_init(vdev);
> > +	if (ret)
> > +		return ret;
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
> > @@ -2232,6 +2314,8 @@ void vfio_pci_core_release_dev(struct
> vfio_device *core_vdev)
> >  	struct vfio_pci_core_device *vdev =3D
> >  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> >
> > +	vfio_pci_core_cxl_release(vdev);
> > +
> >  	mutex_destroy(&vdev->igate);
> >  	mutex_destroy(&vdev->ioeventfds_lock);
> >  	kfree(vdev->region);
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 9fe0d1a3a370..7f3a2bcb5830
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -29,6 +29,7 @@ struct vfio_pci_core_device;  struct
> > vfio_pci_region;  struct p2pdma_provider;  struct dma_buf_attachment;
> > +struct vfio_cxl_state;
> >
> >  struct vfio_pci_eventfd {
> >  	struct eventfd_ctx	*ctx;
> > @@ -109,6 +110,8 @@ struct vfio_pci_core_device {
> >  	struct vfio_device	vdev;
> >  	struct pci_dev		*pdev;
> >  	const struct vfio_pci_device_ops *pci_ops;
> > +	const struct vfio_cxl_ops *cxl_ops;
> > +	struct vfio_cxl_state   *cxl;
> >  	void __iomem		*barmap[PCI_STD_NUM_BARS];
> >  	bool
> 	bar_mmap_supported[PCI_STD_NUM_BARS];
> >  	/* Flags modified at runtime - dedicated storage unit */
> > --
> > 2.25.1
> >
> >
