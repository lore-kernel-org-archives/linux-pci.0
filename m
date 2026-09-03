Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BBB486E46;
	Thu,  3 Sep 2026 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430364; cv=fail; b=NX9IOyAKAU1bTPcHQEMNPHYkcADMugWQ1Uu84CsTEkkvhX+en6BwXvA/AmWfDBAsjkJM9NwvKg7btY0cOE5Bvx1w4E9GiIYf/5x6xbxD/RwMFYVIg8S6TD8AF8Qn1G7c2Jc0leKFKWyDZ9OJCq79V6taUlKn/ssQhFztlkR9k8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430364; c=relaxed/simple;
	bh=V7JbCdTym07Ptpoa8bXGRYiTGyA2BZt+8y5yZbJTbL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KFBRv/yTnv9sVPCgJCjf4/QaAE9Wlmh71X8uZ7s3BpWipGqaAB91/92lSDJj/gGuOs97KHouni73GLaPDpUD3R9+JLROFbTLDtxhRjq+iiapZ2CMMGdi9X9dR1ZnJc2oIBcKg+4u7QlnvYcDxdwg5Wjh0/z08pMe0oaKNb2TB94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XgiRG6j5; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XgiRG6j5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh2pxtB6hS0spxETl6tC8W2up+pxuehWp9ZBGSVNZu/KWutStF9vtk9YV6bLpknPldinAJX96aRx/mEd2vOF1TiCmJOtxFRiu8GGIIqD8SYF/kw4h1Z7N0TL18NzfUcG4Ibg+tLXxMd4QaxBM8k9RJeKhmtPazay/VfSdoa51iOqZvM3wR2xSYI9e4k4Odz+Vg/i9MrAxc2bK8+G+oLRkOQHhrbiSv4eILqB8qnuRv5i0/gqHrngzIPpkM4KMzuJgzP2H7MZwV6aVI20YK2iUpOKNP3jD5Yexfe9RRMu7JaT1ogEC0U06NV2E9HEzCEhPzAi+atKTW0J963HYq24Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIIs+1qiUuQ6Ts2kjv5CM0JrBcxDkMOJDFaTs3o2WNA=;
 b=qQmRltzyYluJKHrym4mLrLx/OSllOoIEZ7Ck3CdL4v33gUtVnIanfqriRbgmULt9blCk2iGmYFZpZpqJI+wW9uZCfENTgySKiEYRKsJ/c0HOnmGR119NeD2v+X7sbwecEmNRWvY16XNWvkT1O+zEbN16qDb9wYAz+JkPcwnJ5MVdDG3+qe/SbOH3ehavQ+bb9RDGf4KjirbOSdLwSO1NPdTjSU4Gb1XGc0drKIgu1QYG2DWS5KCZkFnxNfUybbFKCUiH8T7O34SaRdHWBUs6gDJClG24m5Z/FhlsJX5O56iuxal0bOGwt425WtfIACnTozbgCNXy8CLGMs5W0YJdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIIs+1qiUuQ6Ts2kjv5CM0JrBcxDkMOJDFaTs3o2WNA=;
 b=XgiRG6j59EVb3ikmOprqsXa/Eek+iHGiTObxVTgPW+UYLwfqSB7XSkSDAwXoLS4oJi2tT2YCUKzvCq1U8pJ6rptGNkyJ64333FKLHRZVNLvMF0X/MzRgmPsXm5dTTG6qAkX7zOyOPO8qjQ9FcIUqBnEOB9TRURSP6MprwF+olnDBnLGmorYwxFGSRTHMwQOMb/LxFPCcdOPSNpzm3CgPR58ftFJqJzsyWgUgyl6q2d4ngbs/kCF/JA78ahTcuW1Y6WsFq7ns7ygU6j7gYuDmtu02pjpRCqxxngBykiubXcZCrQ5lsXVu2VcQtg7QFZQh6mMK52Dkt90X0Sr2Z3rgMw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:12:28 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:12:28 +0000
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
Subject: RE: [PATCH v4 11/27] vfio/cxl: Own the whole component register BAR
Thread-Topic: [PATCH v4 11/27] vfio/cxl: Own the whole component register BAR
Thread-Index: AQHdKweclojedchMm0ueJWVbJjEXiLaye6KAgAoS7CA=
Date: Thu, 3 Sep 2026 10:12:28 +0000
Message-ID:
 <IA1PR12MB9030143727C7F41086623FA5BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-12-mhonap@nvidia.com>
 <20260827151303.5b34ef3b@shazbot.org>
In-Reply-To: <20260827151303.5b34ef3b@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: d02fd91d-8eb0-4232-29e5-08df09a3dc1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 NIUN6IYZQUSO93L2eoOrMuBR+m6S0Aq0D8HRHzPn/bJMTn0Mm2vgR/SgHFQQ+zKp+H2zYpP+NAO9as/USvUfNnpiS1/eeGB6jiyB9QIq1RmtpcvqK9ErCT+IrP11l9ir2scFw03lV50mlLCwGoZzTZ/bYHnUcxe8E9YYqembd24W/cxqhOQjicOQMv0YXe4Wc5YUm5sEDOvFMGt/bTc8zsgJlhA6/kKwft+MqOcGCC1RNiWIY1AzAkkderUcUjkt2FY7RwkQjqI+YGAdRHM7MCWyLyX0Nm5yS6GyrusY+6ZsnD4WOoDjHA49h41i0GdFFsUnuRwj2WqWpQChAED4aZCdjEqOvQWiA8XQgAW8C3Rxhx4oi6J5b7V+utDIBXvsL44xZwV6yqIdr0zAY+6iUMqjpW5Y7Ij8mdWx7Ix0aCrbd5FZDZW92y3BqRK0zr4NDFM6cUZvkvAXp0cxfR2IN9VLGET2858Qjn68a1rxLNxDeArTA/dOTaVGw3jZFaqoAm+2alOz5kmM6ndLEchWl1D0SrP/z7k5rYbMcrnNk92gZfMigAOgHtCRmcTMQMVY0lhhNf3YVl4V1Mm+Bf05vE9fBTwT3j3Td7DL+3B4HGg05z2Zmj/DpMwCp4uhk4O8BnnkCqjx2DF3xfmIGPIGkdllwQnDa5nliOW6FpMo9Ph7TORVZsKV8Ixao62cTP6ITBQIy8thPJ/MLZACWz3+z9nZNDGi++TZyzf057BFl3I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4P44sP5VZGLmxNu+FBpHiISue450szbzXTaLl/y5MVtSDdvtKuXtExNVutVt?=
 =?us-ascii?Q?67R4DJCOP9AumVB8DYxDxN5McCS+e8gybVgIpxMglMLoVsCiIRBXutSZEYYG?=
 =?us-ascii?Q?lbKnXZmQ9xuR/zia65+HKcyyded7q6lQX/cj5K6JGkHYXy7HgKPJTYl/k6JV?=
 =?us-ascii?Q?zN/HbM6pgfac5C87Q972r6t01bvApgmJyf1PmMHMyoWbE3amXITu9qNOmyM7?=
 =?us-ascii?Q?KwU2f6hIHilm1DVxfLc4v4vA0u5Yu6nHX5FcNKyBFlRjebt1a+vmD8mAEvUK?=
 =?us-ascii?Q?BZSOYCuBwGan1d/CVcHnZk8bTAQCriYVkiqu4/Ld7nlw3JKbMa8uQsfkC52P?=
 =?us-ascii?Q?uYcTxvIHBBlrDP/zDKDrHsa8Jn4SbgaDJEcXYhJ50PadMJctyszEtwjrmNqR?=
 =?us-ascii?Q?b7LAddqCWQHWQdDuPIa8a4WpQ7huHwsqM3Te35/ZgWVs6McF593MpktbqYeO?=
 =?us-ascii?Q?VvJlmXyZr5SZSBB+h/kyVIv+itUNnE1Gz31B3gPir7/uMJBL06E8NNCTf0e0?=
 =?us-ascii?Q?xu1hUdN60rINf609s6c1Wazhiwq3iz9JRk5F/TznO4Hi9+dP5GzU1G0q29kO?=
 =?us-ascii?Q?CPWjoaUBYSf2N9Sd6HjphntXk4LveuEsBwcWSqFGW2LGlie3WkT6iVq5aW5f?=
 =?us-ascii?Q?wPFDWh4oXapVMCQrnU46rzlV8e3eL3mSr/f8dRiy7OTHOa5Dkfng5Y3euvEq?=
 =?us-ascii?Q?F2JH94FHnxWhmtx+8R5ynh3fEVqnIeUgjQhNXvpeZv7mz5dytxde0l53fHJ4?=
 =?us-ascii?Q?LyTtCfBzBHG3jM+Nj5TlKbZyLcXYDefceMavhDNOwD8fDozs18ZXpkvB97yM?=
 =?us-ascii?Q?jil3eZkX97AHSFDZB8dbwiKAkOvMLZjv4e77NPVsqevxCLKAykora8MktYxL?=
 =?us-ascii?Q?BbFCukNImjSVhdHgJgLS5LpcqAJtFiBnhTseMgR7zzFGaPFDYciZbqBfQZBo?=
 =?us-ascii?Q?xZW1lg4UVKDd5VFW4sGV4bs886AbsqzZRGBK+BawwsmouM8QiExE8xJLb/pM?=
 =?us-ascii?Q?XUCSslvq27FPvKeMS/JFSn9I4uApxyeF8puVdv9iJYjzQ7upW2i0wMWApvSa?=
 =?us-ascii?Q?SQ5hbgxEPxj1/hvkxQfJS6WiDUMLMjaL+PEZNVThhL28n9s4D7w180RuQ8H/?=
 =?us-ascii?Q?IWjyM9Sb1JmZ0uNOb+JfSAWTQPpVjBK9wy0daiN+219oa4CedCk4Dyeii479?=
 =?us-ascii?Q?lvumtnuCjx+c0MXERy79Gnbxls0WnoQ3Hp8kvoRfQYper+ku8DZpYGX5dwI4?=
 =?us-ascii?Q?Of/foDZ7zEOY24K/pHO93AAMbWJb2/sgzXpgHqN4ti1/bWuxPlO8vaSXO9OW?=
 =?us-ascii?Q?fnD3Tmbx/trAXYpitaAhNcRzutmWaz+EBx4c4Vscrqa5/DtpscB5dfJH6Stm?=
 =?us-ascii?Q?JAHmKep4oJe0lgtCPfIRzU8MiSSsnoie99ZtP3YXPIzljck4nxKP85Lvi1BJ?=
 =?us-ascii?Q?S6Gt707aA7iTyh6vkymXU4rL1HdfE1uFNig61ZnMJ1yVT/g2JUBunhWD9MKp?=
 =?us-ascii?Q?CEgncbxRHbVgjtQWrq+c5n7SAKUOuxFiOIfMuTKtQU9GgKAbc5tlTnSg13G7?=
 =?us-ascii?Q?wbz+6aGGxVpwTyK+mj8Y6st4uvAKErLVZz4y8ef+D2AhC06UBXJviQSjk8Jt?=
 =?us-ascii?Q?3fCjOji3hghGEy07kU/IcG5IB+tg4eQbnPacE1J3o6J9fXmW/m/k7nBg6Deo?=
 =?us-ascii?Q?d90SuIeWqOYT93N2dvARg/+IMLv62gxKd1K70lbEz5cR2Nii?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d02fd91d-8eb0-4232-29e5-08df09a3dc1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:12:28.6911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xa7orYOdlFgesHI8kPSpwKZYmqSAY0DpM1z4oM/ac5UJwpubggN5vKwlDzlMTLZwekjXQkc0s5VWwbuOoVWQUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, August 28, 2026 2:43 AM
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
> Subject: Re: [PATCH v4 11/27] vfio/cxl: Own the whole component register =
BAR
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:15 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > devm_cxl_probe_mem() maps the component registers through the CXL
> core.
> > By default the core claims each HDM/RAS sub-block, which then collides
> > with the full-BAR request that vfio-pci makes when the guest opens the
> > device.
> >
> > Discover the component registers into the device reg_map and pass
> > bar_owned to cxl_pci_setup_regs(), so the core maps the sub-blocks
> > without claiming them and vfio-pci owns the whole BAR.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 7edc53b25576..966b7c22a6ac 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/range.h>
> >  #include <linux/vfio_pci_core.h>
> >  #include <cxl/cxl.h>
> > +#include <cxl/pci.h>
> >
> >  /**
> >   * struct vfio_cxl_state - per-device state for a vfio-cxl device @@
> > -70,6 +71,16 @@ static int vfio_cxl_init_device(struct vfio_pci_core_de=
vice
> *vdev)
> >       if (!cxl)
> >               return -ENOMEM;
> >
> > +     /*
> > +      * vfio-pci requests the whole component BAR when the guest opens=
 the
> > +      * device. Declare the BAR owned so the CXL core maps the HDM/RAS
> > +      * sub-blocks without claiming them and that request does not col=
lide.
> > +      */
> > +     ret =3D cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> > +                              &cxl->cxlds.reg_map, true);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret =3D cxl_set_capacity(&cxl->cxlds, hdm_size);
> >       if (ret)
> >               return ret;
>=20
> Previous comments on patch 2 suggest a different interface here, but do n=
ote
> that cxl_pci_set_regs() can return -EPROBE_DEFER and if we do actually wa=
nt
> to defer the probe (until when?) we'd need to split this errno out as a
> legitimate probe error case versus the fallback mechanism for other errno=
s.
> Thanks,
>=20
> Alex

Okay, I will make sure to split the -EPROBE_DEFER from cxl_pci_set_regs() f=
rom other-errno
fallback, so a genuine defer is honored while other errnos fall back to pla=
in vfio-pci (matching
patch 07).

Manish
