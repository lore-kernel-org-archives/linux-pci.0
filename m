Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EE1480320;
	Thu,  3 Sep 2026 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430409; cv=fail; b=s47JWVLx8h8V2GG7dQqw/FHA7/5BYUymTLSfNDazUFYH56X0rIyhTcyp4scCOVw6CWr0rCNGQl2/vOXoB/co2YvVMH0J9dFQruhf/DjyFjnfnVyh7YtLYHGKP8EqJaM2ARtHfSQUgWKl4/QWR7VdXzp4jOPIScjSRdjzOyeotqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430409; c=relaxed/simple;
	bh=AVkS4vP3R/G0WUJZnCZbA7ni7ZLKyTtmbK8seJQpes8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OO7dUc+JXOgfYKwmE71+Jk3MsgmdTlSfRnLGyxJAxiKKGa7F/eb4wujbWnV24ipVBS9EFZ5Y+EMZeXBtamBh/Z+eL/+Dyp1flTKxa8WN4+xigK231CUOpFeEU/QwI2pqvvYHryLutip87KYWz6ZHLhowPbY3bx1BGbAo6wArXzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QaZlwnyD; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QaZlwnyD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiefQRdhtV5X+5d/aajRjpz+Vg5ecnCsn9HiNQ8/rFDGlSgImdEIniM7ZL4AwC6gDmKGNcM7ch1pc8pj40xj87svHY5mO7oPUdgHb9nxhI9VrRq0dqbK5vlqls/+hlVpVuiSF/vQXPDbN2LwrAWBvXZxR+SflMnYizsgpH2yqf7V91YPqq3O54T841l04kNHTZHrIO96p/lkmBO4luarM/dxDdyspevHbM1VcCf2ckl4Qqfn2WC0OUA95foWe8McmucGx9Cc1OuaoPhJYUEhQX3I0OuX3pzB3bqncZBwYeNoMpsj6TQAZbMrjf10dY8z6A2U+ObgjXN/DIz+m+sxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYAbzJc+4WCZPWjN8HiXG4+xQlcuOENjVdtz2hX9XzA=;
 b=AyVIdjZzXji9Xfd7q93tIlSYIQfunzywnq2iUbgsW+BPAw5QZlkKCpiyUDIQkG8gTS+soUf658yALeyHuz4/8735vlspXKDzxhIU8iWmGHii1FBb9udc832WC6PWTo2z2yz3bxZZ3KJKiA67qhz0BYyG56lxJleRnrtpo/PoPT6XVpPMJD14ouGxfs4vST45/PwePAL+CIhAVtgyWFLw/Ld7w9U4C0T52iyfHSWLw6JFGozuEJBWg17hrsDiZNg94uZvoqWeU3HppEKVEWLpKLksXGuU0C5aPrBBNBdqNKLXrzzT5TlVA9N1WM1H21HvrYbXDOB5/lM2PgKwTri95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYAbzJc+4WCZPWjN8HiXG4+xQlcuOENjVdtz2hX9XzA=;
 b=QaZlwnyDKG8vZZLSVRIrkes0qiEwZVhu+C+NOW2RAzrun2p2yCEUVuroBPxWIo/tKMi5S0l1yozWWOIgeyXbY8GAdQIkP5mR++F7GpcCAmD5aY0HAcm/ZMyRo9vBsJjEKXW3DaVqFg94+/RGPH9qRngQW3ZMqxGsLI2BbKdl7i3EkKY/zrdp6M5B+6ZQl2hEd/4TRsgGSwky9DALqESMa61Z18zx1pfN4hS8PAZ8GdIvQb+OwObKb8wp3EbKCrHDy702zOsw5JuOdYgx7nUG8+J3moLfzXANXy6cstdf77tHZJpebqHHKF7prmx90wCTjD0p7fDWSTfF/GYQXDG4ww==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:13:16 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:13:16 +0000
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
Subject: RE: [PATCH v4 14/27] vfio: Add CXL region type for the HDM region
Thread-Topic: [PATCH v4 14/27] vfio: Add CXL region type for the HDM region
Thread-Index: AQHdKwerSEQoCyvIgECrlP8bDkJUHLaylPuAgAoW8SA=
Date: Thu, 3 Sep 2026 10:13:16 +0000
Message-ID:
 <IA1PR12MB9030C6A64900A300598964EBBDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-15-mhonap@nvidia.com>
 <20260827164347.02d7e871@shazbot.org>
In-Reply-To: <20260827164347.02d7e871@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: a94360e5-4a38-474f-71ca-08df09a3f880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 IFs1VgbkFL5l/8KixbqUjN3LVcAdM3iqo4Gij4E9ERciqYtIYzGjF7CxueBNN0crGjkuUZaSWd4to/QkWfHId1VgsFMvKgqagSElDTz0BVB0WGu/SqAI+HsLuJ7QN3veeH44u5YFmmJyDtw4j/PdMDzwvRUGhGzsrsh0eTMmIgBsXqzKGQZvEuFmL/rRcEmJ0iCIu8UImxIclEgVR7SKp1gw13Hq0Be5O477JPFU1kU1qgFD/4SWjPwB1/zU15HFFHEUz8HfN9+GvHtceHBOiJ64GyfUwyzFcy7/cQ6/Cn2Grwym5pfWfpzyn0wxhlkdcGoJELqH3jL6U74vY9DPFBJ8X0AFGdnVYtVBaHr4pqb0AiK06CO5DzaN409SNbvngMVetfZZcEIl6ZKaBC4gLyX5w9mTkTwceEtYlXexjl5oWUIknd6o9WPWXOcjVOX6gFYsCbxd5TVjoHZdpRM5qrIE17Gd9NeRYeBvneJRpySgTmuBvsz4MiTBxROo2HIkLnN0vYXfqb9tNCXJc6HXsCaCGT0PAyjzwAXbn1OmxAViFBBWFZlYj3PWyGL8TkdpRgC0u2gRGaO9So8bidp6RRsjtQPskWLecUXy/yXVT1Fgnmj3pd9r54MM1rp2KX1tDT0jJrReAp2hIM3XEZGWZYDoy++6k1BeYVI5gN37QihXipWe7cj+OOW/iCE6gpjVt0bc/AnKhP0utxt1wjrig/pSGSZl3zvIRUQIP30xSno=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0FiFypo52+JAkQgEHPMxMXbsIacunP+rtVXZeDjNDjIOh5yU8SbEQqfOYqny?=
 =?us-ascii?Q?m2GiF3PLnfyWMvIVtpVPy9HokD8kpXnSs3Tjd/7HeBa+7ESEmXyQtHS6Id5s?=
 =?us-ascii?Q?myu5UqOYzCc5Z7RTB6+QmdjATFiBVX8zp9M9wuVZKvmjPZemopxwXoUDXVly?=
 =?us-ascii?Q?WimzCoBGJkpFky5UNoInXgDu6KzpjLEy666b5yTDNfwdMfc0ksmC8iI3BE+c?=
 =?us-ascii?Q?mHuyVlUUYw07MdR/EYQZur6JeE2cMt8zW1u4TIELM5SX0fgBPbDLaIfWlaYA?=
 =?us-ascii?Q?bUmH0+0P0B/px8H6EYlq7PcJ2JODbaR2NhyDBdvgdYYny0n0IuIhPZlI3B0A?=
 =?us-ascii?Q?UP5/HLeURaYLk9yrF9ien0xL46jRinMhsRpotBLp5dTB9O+09u+0noD8tNOA?=
 =?us-ascii?Q?6gis/MDMzqio4ykE8zWHeMqZ2qpTS2euHFqCqWxGAC7b2jzO/IUPCAzA4Zp+?=
 =?us-ascii?Q?3iCEGP6jyWqrCWtwY5OM6lB6+s53TbfM52kr4sH/1GRzFYOU3HZHmXm89cJa?=
 =?us-ascii?Q?LlM1Egowjt0sKmutc+6tXVlY9DsJOy2/RAhsugFiNNlfrbRB3+x4ZYQWyT8m?=
 =?us-ascii?Q?swEygjSheru3kBPmNzshxOi9xgMdlAw8or8eKnXUo/aBvF91LFyW58IfiV9O?=
 =?us-ascii?Q?+Q7nba9pTJclJmFRBQHXwFYVtrNGOreXW6v4A9ae/x6hOUgZ/FLDHC3qD4eY?=
 =?us-ascii?Q?EeUt2t+fSLmwZetgBbmkEsUvWzL7EiBWaTGKb7+aX1gU++OWcxtuUPQa7Orz?=
 =?us-ascii?Q?mkcEet1AA9O7hrtiSUZO+83N6UNKaqcG8u6Ajz5gzWXoHbKfFPXLpWWi1u5E?=
 =?us-ascii?Q?6BoTTu5G9Zeq6E50qYi/ytA6nakDlaAaJA9w5+GW+URp0287cb/CaodCT36y?=
 =?us-ascii?Q?rxFikGbcMYculGSK0IgxD1PuA4l8ZYCNUdwso9AvH6Lg/0ixICeyoAwqH/AG?=
 =?us-ascii?Q?SsWy056Khy49+4wvFJtZk7bgJce8fFwB+wbhOLNR1rBahzpQ+H9/QtzYrVyT?=
 =?us-ascii?Q?orOi/xE+cvwkrl8KvBxzwwLvLS/5P/Vdm6h6P7PA4ywdnW+CoLL5gcMBkqEE?=
 =?us-ascii?Q?QYIOLOV155KMpgige6PrbA7h3DVpYBQaRbXxij+X/0WV9adWz09/IeaQ8uOb?=
 =?us-ascii?Q?a+ENJ4Tw9EWWpgF4Gm5Ih7KM1GPVvKCQNeH9wYD1lAqkWj+eSfgrkPvpr6o5?=
 =?us-ascii?Q?kU4XWaDlhzWoTX9YzuRVTDR0dUZTEXwFBSgRSkWla9xzg3MuX6yo0zjE3v1d?=
 =?us-ascii?Q?bipqTP+ICbNrWfCYU+8lVC1PnDFjnOW9oStj423LOwZdGG20BZ6AL/t0t3oW?=
 =?us-ascii?Q?hNjEZWj5ARI9KWgL/35jurbvp2PIfgOvZY9gdlXG5X+23sIHGmYf6qMoiAED?=
 =?us-ascii?Q?NDLeDCssD3e8JGMnx2Gl2i0N4XhqGA5P0SURdBhtzt1a9kgCin0Cebyy0hT+?=
 =?us-ascii?Q?oRS9orA4ay12GHbGpydNGzeGKRzaxdpc8Sjgn1/I2+0c+ygG9D0t3NIGUlsG?=
 =?us-ascii?Q?OWCYotKQhVI0qkPFGyMQBDfjieW79+G1N9B9D6xU204GqF20NYt1QtJroeJN?=
 =?us-ascii?Q?Pdo0soMAfx6mPgWfKdj8xLHRBr5pmPZp0tds7QR1MDrrOxm+Qcp6vhuTL79c?=
 =?us-ascii?Q?exDshVdCNXK7Q62iOmsI6N0koc2M06VnnPHpiOJkicOtyYkneFRbJ38LJaE+?=
 =?us-ascii?Q?rb16ICfRMPs+DRXCCqivdXJ3z3djRBsi6rkYQS3IutGRpEBk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a94360e5-4a38-474f-71ca-08df09a3f880
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:13:16.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwtozHhRkVEbsgwe9VjEuFGI4fFGK6n84TCB/C8KhKght32QDgRrVKCpVu6B0FidaIweN6NLVJvVRMTl1rKVrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, August 28, 2026 4:14 AM
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
> Subject: Re: [PATCH v4 14/27] vfio: Add CXL region type for the HDM regio=
n
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:18 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 device exposes its HDM memory to the guest as a dedicated
> > VFIO region rather than a PCI BAR. Add a CXL region type and a memory
> > sub-type for it; vfio-cxl registers the window under these so
> > userspace can discover and map it.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  include/uapi/linux/vfio.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..540e62312671 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -345,6 +345,7 @@ struct vfio_region_info_cap_type {
> >  #define VFIO_REGION_TYPE_GFX                    (1)
> >  #define VFIO_REGION_TYPE_CCW                 (2)
> >  #define VFIO_REGION_TYPE_MIGRATION_DEPRECATED   (3)
> > +#define VFIO_REGION_TYPE_CXL                 (4)
> >
> >  /* sub-types for VFIO_REGION_TYPE_PCI_* */
> >
> > @@ -373,6 +374,10 @@ struct vfio_region_info_cap_type {
> >  /* sub-types for VFIO_REGION_TYPE_GFX */
> >  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
> >
> > +/* sub-types for VFIO_REGION_TYPE_CXL */
> > +/* CXL.mem HDM region of a Type-2 device, mmap-able */
> > +#define VFIO_REGION_SUBTYPE_CXL_MEM          (1)
> > +
> >  /**
> >   * struct vfio_region_gfx_edid - EDID region layout.
> >   *
>=20
> CXL has a PCI vendor ID, it's even used in the dvsec capability.  Why not=
 use a
> PCI vendor type region?  Thanks,
>=20
> Alex

Yes, I will switch to a PCI vendor-type region with the CXL vendor ID inste=
ad of CXL
region type.

Manish
