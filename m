Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA584503FB;
	Fri,  9 Oct 2026 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526489; cv=fail; b=I+teH9Sd4czEo+wG8Z9INm1870u3XNa1Q/2HdOmEdYkEVXIfTRrsHl5syIwWOviEgNl5a8jDbRpDQ17ONz3h2VSFkG3HQNQaL8N+tknKiD/kcpQUmrj7CDkM7HlLeUsPLvG5IjEW6wQtNm8ebyYCg9wozT8jp7MBQPTUlgX/Sx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526489; c=relaxed/simple;
	bh=5tWNcEHvTurq1SivSZ9zp2tze3RifhwOr+AsWINTH/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kh19JFOG7+B/SncAI6f5HhjgZiuVm0yPRvFtGmOZbqF+S0dmBbQeEOZKq4l6hMhtAOEjVKCI9mKQsyEArWpD74Mg0/jNo144zXqWOBZpxhAqgffZ8uTaI+BuB/bhISeZIveTa5GLOOODxPH1o2Rs15Nv6ASJlH+P3bPReT3OLO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oBtqeOBw; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oBtqeOBw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hi4x7cuu8fpEJxAz2HB2M3EjoARg/JGZbt6qbveX36ZaD/J36p6iucpn6wgfurwTGsf5ob3zmaR/AV7fhvQ9QzZoELxnmvcvr4XsEhJc2MyZmZUzT+hdJJSSue0QMVlf3xdHWUeeWXp+PI3BTMSBpdPFDAhTC6wBGpZmw4MiCu/Bfw3GHHjzOatFdykIKDN1ccOj1Sl0ujs3abd2RkPtGowxCeHWy7Ud12yEi1qCZUVK3d7yEfLgaNhXDcmXGhM8TogoUm0tanesFtOtjDh6bpyvBF8eTjIxZDcJsHGYWBTJAhQESYtSPdoE3rYbZUa3LRrQfo3V37RHxj3uqDboOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HdhzixaLh4Ju0Ci5//VZqg4etUmWdsxC37K09XI15c=;
 b=qW0arPwsRtc9A9yphKyFYITTwInOg34eX5xVQrQeNr70PIJ4mOP4NVYwBXtPLrpxlwopzcdmjBDLWQcxQWeNX7tRa9WsLy3Mc7Nglju5V1QEAAeO05+FNXm97z7FaC6yHU7G30yjj+X+zrLmdnWSheNeiygA2qkLK+V9n4s0ovPO9AruOxc/EhiAbHQgwII9whqtIVpNmcCTDBGj7LXkevOP4UACFSyXfglerLZeNINv1Tf7Bgcop3U2m8fiSix5OmAka26z8aLthsIbocG6OIRcIw8cccEPSNy2xfo0zrUrEoTi3eJ+nJuhua0vXIbCO07MmUSDGcbuRc7ojdldlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HdhzixaLh4Ju0Ci5//VZqg4etUmWdsxC37K09XI15c=;
 b=oBtqeOBwWY63cCcSzWk9jayIntG1y+9OC/6XvOWhOrd5HGkk+dA9IlYtDM296tfdSryAZCi9hnyJdGomI+UhZrxFOyNNttqG0taRfU+LvMGj7XRw1MobmFJMXaCFva8eyxs/LxiKZ4x8gUGE0cdg8Lt2BYMgAAP3apvS9+cy4bvhHYw+qIfrgFVMX3qe7pGJo+Wew/PF8OzIFLletHBtJIBcIrYN5hn9wLIjAbu/ly0o27OVd+nxTlFd7pBD7XyTbfAa0pbXqcKPigM9pDGMdq2OWorHnJ9hCrvJPCqMMILmbL+gJ5qoLsMCQ6pohjDF+glOe0WUdCCHgAvTk9BTvw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:40 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:40 +0000
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
Subject: RE: [PATCH v5 17/27] vfio/cxl: Own the whole component register BAR
Thread-Topic: [PATCH v5 17/27] vfio/cxl: Own the whole component register BAR
Thread-Index: AQHdRgqthOA0w+O4KkmYpyJ1QTqig7bZ5AgAgBrt0YA=
Date: Fri, 9 Oct 2026 06:14:40 +0000
Message-ID:
 <IA1PR12MB90304B7758626191F042B6ECBD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-18-mhonap@nvidia.com>
 <20260921201412.78b7219a@shazbot.org>
In-Reply-To: <20260921201412.78b7219a@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 8e70672c-ef58-4fe2-8595-08df25cc9a89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 vNDOKqFkdNXpgimF6ZTxojKT1W9hisFHOO+xqoqxoOt8LQSFiIJxwLzTrSw5rkN4N1pTWgef+8uUBY392spZbF3Qe56RI35Xw1ibo3XaL6VzN9fannjzc1pAjfDjX/U9LOk/afUYAnR7jBVC6pfs2P+USTQEGqtQ8SQbwdE6PTBaYxBh07nvE/FJDxcnCoUPILqRSYY7DPua6wue4oB34iHClZKcr3VTRBxYpzO1SOenEHKgEMCfiJl/7ESYoVRqzWvc5v5uOLopXVlVAxZBSQL07aEFKQm6+M4ny98bt5vIMnZL171PZFPMrHe/yq1WjyUaCrrrc8bsYMHmIq358EFwtd8KQeAVVciJY/ln4C+mBggIyoN18pw9Rd4yDKE0ckOcMo+WwB9xYMzqXh37lWclElXMbNviefbCOMFmpMgfAAJbO4vvIw8iQBBXBZ2/+yXe32/fMHLAyU9ovaRqZzOEeskvrPEvy8VkDZZG7ItF3wHUmXujCohYsKJgfSd1A46hWFuU7o14z94OH+7QrxYH9bR3lWKaGoYl/y4R0M5nPW9Yr+uHNYziykFIcIMUn9swAuB4xIg5WZv0smTrSIwdswcY8V36E8NLEUwzkRfBMcJsrgvtpnKHopNCa7PNJyQc4cnqMuyNTeqKbD5YrZ0DQpeMk6WnRqt1VPysvrFD232Wb1xmxq0YLkm0mbcEe0cqfzAP9kuLZu839MSGlsHRvvRg9Ay67voWQpzJBE0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NPqWTyNLSGGw587swmzGk9g/XMElAcWiJL5nxwCjyMXX3sDu0ijVHzv0sDCx?=
 =?us-ascii?Q?QGhUQBcn8GIvCjqeiBnAKfs6x/FMMM8LJ6yQog00R9sDRbuWOTvrzaVKnSDf?=
 =?us-ascii?Q?TIB3MAhksuO6CDrynCVDs+venW2ZCftv+hGvXHOn2qdTRfyrzLZG4tryZea0?=
 =?us-ascii?Q?sBCVTvMSJoPFSPpMBc08MFAxgBlnhyyZ/5a05xdDqygvP6xxaDdE+8urz/WV?=
 =?us-ascii?Q?/j5ufFZfCQVnB7IGExZhNJKfVP0zriYiNyPN084Dr1MNXfOgxzCpLIkuzep3?=
 =?us-ascii?Q?qZ5rEGeD7jsHdLZ/0bNjw1+gS+Yr2jv/vau0qPAmc+nm41VFa/HL9/2/Rbb+?=
 =?us-ascii?Q?a8YpCaL/v5rWVYt4VlEuK0LLewWIyFhxiMeSjsS4XFqHLtA8zvFC/BJbNSoB?=
 =?us-ascii?Q?TfaOYQo3uLRwy6VugtdVs7jBzi7m9N22zEia0Ryyr/LsHDQt4FccEsVP6fMm?=
 =?us-ascii?Q?ATkorFovQOzvNP4WdqNPHQ2AMUQEsgCVt2C8vmAphLz0coV5eXffZDjv54XX?=
 =?us-ascii?Q?QLOu6IyJdO+gz46NSZpLCth9eeHLj5f+igHB4l1i/O39+yFoq+yKGA+Sbx84?=
 =?us-ascii?Q?Oy4IZJs7TZzYzP+ll/dLHN1RtuQMY1F2YHXrqmhw9Qt7s8Wrg0uaxO/9I+dX?=
 =?us-ascii?Q?JZ8g7zaRoYBG79NkFTokqDes1LQvm1+9XuJMzN/5aoh/6ndc1DjmE6HXD53h?=
 =?us-ascii?Q?v4O0dad7lnPBencYpMrAS4Lhbts3AOVFhAIo/ZVJ85J0lEBMmeA6vfPYLr41?=
 =?us-ascii?Q?Rt+MpHyk8i7fIlOQi34zGGuKyrU1YpK7vtMZRA57UqMG0uaCvhrsIvln+u0r?=
 =?us-ascii?Q?gWS9Qq8lti2baDV8fnJi1BW92VSTce8S//FPXT8WDROxutBhCqeJB9628C98?=
 =?us-ascii?Q?5WQ+4db+5ve7K1Yl6foSBA9Quq4D1EsmYoKujr1TjcBNHPVzS7oZoRg8SoQI?=
 =?us-ascii?Q?RnVneOtM5e43ut2bJlki9BTpB1l+Rr/AoN+h3CMlsIWJDDodya8GV7+wN3u0?=
 =?us-ascii?Q?x8z8TG4N7yPQMbFZUjpjYnY7sUp5dW6JWgYKZKuYUWyQcrp6zTzV6gf6jEpO?=
 =?us-ascii?Q?RmauxjPcXoLdH9CvhvFZBoes4Qd7hhHrTWb5Zp7wEzS5iKL36J3GK09homBC?=
 =?us-ascii?Q?B5pgKn2xoTZ1YR286ibWYenUt9aaONAa5vUtBXNQgYK0B3JVz/ALhWtlg8bD?=
 =?us-ascii?Q?B/4vm9WPrn8mhuhZ0oZ1eXAtAxlWIPjV5t/5KeO6KCf11HwoqI/sW0plMyVP?=
 =?us-ascii?Q?JRDiFMFwvz0tgZ7wiVx48WGlCFFN7Ib5bj2AMbWgBjBU2ioHUtVvhOmEJOig?=
 =?us-ascii?Q?COne2r2Zu2UXQvqQ+AD0QjT8rMvJlrTSe71El7fkfZKa6A70CTbivdVQg1+7?=
 =?us-ascii?Q?lH77Y6oTc4URK3kKPX0jRQ7whxUKVsWm2UHTl/gfMz4bXyCFx8mXez+TMfHM?=
 =?us-ascii?Q?uGA/L7lMd666Q0zOIlVFt+4PewkIUJAQ+V+xWyFz2uYnvl4hzCl3U3RNvv6S?=
 =?us-ascii?Q?KObFwrDHwL44HgNbOCUyXvZmMPbSw0eP13kVpCafyhJkWbo1DJ2QZ1VYe67G?=
 =?us-ascii?Q?7W+RA6sbph6rYuuLO6IIf4DzApIVvdRbv5FT9Yo/zjv37BFB62XPtJqJ7o7M?=
 =?us-ascii?Q?qEpGQNwHnxR8E7cNVwFlFyE+gey9cvRDXeexVo4dCEaeRL88U5YUDWQ3K7Rj?=
 =?us-ascii?Q?2HBm94XhJKnIRthDcn6kL6H1jF4rwvS2io6LVCCT3LyrkaRc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e70672c-ef58-4fe2-8595-08df25cc9a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:40.6080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iBDvc9b0A+1sRPFazOEIhrg59IvzknC9FChl4n0Tjo8DPKQz3d0bcU8oouKFxpO+1shupMAcpNyLTNs0B+wlw==
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
> Subject: Re: [PATCH v5 17/27] vfio/cxl: Own the whole component register
> BAR
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:30 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > devm_cxl_probe_mem() maps the component registers through the CXL
> > core, which by default claims each HDM and RAS sub-block. That
> > collides with the full-BAR request vfio-pci-core makes when the guest o=
pens
> the device.
> >
> > After the component registers are discovered, declare the containing
> > BAR owned with cxl_reg_map_add_owned_resource(). The core then
> > ioremaps the sub-blocks without requesting them, so vfio-pci-core owns
> > the whole BAR and the requests do not collide.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 0d92e6a409c1..5c8a63833a43 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -89,6 +89,15 @@ static int vfio_cxl_init_device(struct
> vfio_pci_core_device *vdev)
> >               goto err;
> >       }
> >
> > +     /*
> > +      * vfio-pci-core requests the whole component-register BAR when t=
he
> > +      * guest opens the device. Declare that BAR owned so the CXL core
> > +      * ioremaps the HDM and RAS sub-blocks without claiming them, and=
 the
> > +      * full-BAR request does not collide.
> > +      */
> > +     cxl_reg_map_add_owned_resource(&cxl->cxlds.reg_map,
> > +                                    pci_resource_n(pdev,
> > + pdev->hdm->hdm_bar));
> > +
>=20
> The result of this operation is setting a singleton "owned" pointer to th=
is
> resource, whereas the name suggests it's adding the resource to some set =
of
> owned resources.  Is "set" really the more idiomatic verb for this than "=
add"?
> Thanks,
>=20

Yes. I will rename it to cxl_reg_map_set_owned_resource() in v6.

> Alex
>=20
> >       if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
> >               pci_err(pdev, "vfio-cxl: HDM decoder registers not found\=
n");
> >               ret =3D -ENODEV;

