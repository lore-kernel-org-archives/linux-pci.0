Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639A47126A;
	Thu,  3 Sep 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430059; cv=fail; b=uAJz+wgtEsi/9js2DSiULP83NDMDi+2yGnvuisGQoOXLyGFYLCUBH/0Wpt9R3M02tUoaLyB+RbNKeZFhYc/EzUv9Nw+JbcvsK9IULuOXulYJoNZ32IQaCxqfiJsy+WWVtewpKarRxq5CO4PhRgCseRNOFyWi9yJ0i1UQT7kyKzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430059; c=relaxed/simple;
	bh=DJQzuJB/TZu/pazQgBz4EMV5+bzEAKfeRYK+Ze4MDWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rg0vAnm+06yP0Cu2y2+oftVSQKyk9Gss1rqUOMS9JaXFpH/oHHlZkltzjEALzcYcKwShy2fpg6OxoCe1PJcq0hSMa6ZLKxcDEOKM9f9KsEwZK3BFsvv4cyZQGtsPJmvIAegL9eVWg6BG++hCNpF1o/E7Ey1kLq8js8Wjzha8J8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Df9VzQYT; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Df9VzQYT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHJjpBOwJ3GwxkZPeIvcZ6wP6fbn8nq2Af6oCXSgRZoVLUXfow9hFfRslIFL5NkJgtqblSxFw0B2YI7PS43IMkypZ7IKACOBP0+YtF1rBneT13KTT/N6vGx7kndWilDzpCgKvPPO9WNSF/NA3sNAzq+VvK8oTQOqSTN6i/R/seBxHN81QMDfD7J6k2kvkju/cOPAqRXTsvcWkCig15YGdI5IYGK+nUqq0Hl2HYy9AvtisEgci072xXbd8sA0ECzX2gYzdwFNsqkMX8i63uYGyzig6/XuQFQc46CIvdiI0Gzov6Bdewg5nAma9M6Sz3E9xqyesHXhtkEEBzYPBSK0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmT+vZjECHY0di8/36lzFbY8rEPIRqofC+O/x9H9wzI=;
 b=uPKsR/RGKgAsw5IUbEqeIqAiuM7Ryb19xzyLEL85s2uBysKKfnq0q7/+CjOvZbJ1W/gTzwS+n30sBKjvRCvRs5ZI/a/pNgZ0e9gj6JHxooNz4REoXj6Md0p5ZAHaEcq8oEowE+mjdeGFSlD5Mz0Ft5iRIpMCQ5OxLjEx4E+KqlHoZK066pVshwPuMuQWDDHDpehYEvT82RWyNGWe3cPRL9WeRMF2v0WdSF1I76Y/oUYEVCTed7xdTXOx/iXxwPNc2e2XM7n80nE94I9NjjwDa2LJdAke542Eg5RHIdz3i+rZU0oMCSXAkHKG1WH0pz0enKnaXnJ0jNBSBln0HvrFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmT+vZjECHY0di8/36lzFbY8rEPIRqofC+O/x9H9wzI=;
 b=Df9VzQYTwNoGBadjd3HPujI0JWYjmIbZ4VpxwA3BAE/4Mwaf+IRSEOwhQK+9oQqgrnAeGA4KXXSxGdkSxoy2qMWPn+bsSTxBXev8R5QF8H59er7yCMtTGI2yHNH8YU1YFazFetLcSKadr6tjfpgCThERfdBS76+lMLoFu/pmiOYzFtHaSVt/qprH6FXiNY+QJaQWGQGIiK0qNcrHXXg6chFu+LtiDPvrFMiCUZhdj6PayEogBv2LE7J23V4Zx+fTPDqm/m7UFXBC1trC4TzGHuELYeRI03fVjMoP5C/AlawzlqbBq2q1RIep94eIH7Xum2RlhCXHY4jsBvA7yECIYw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:07:23 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:07:23 +0000
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
Subject: RE: [PATCH v4 01/27] cxl: Fix resource.c include path and export
 cxl_restore_hdm_after_pci_reset
Thread-Topic: [PATCH v4 01/27] cxl: Fix resource.c include path and export
 cxl_restore_hdm_after_pci_reset
Thread-Index: AQHdKwdkZtSAYgnzrkys1MolqR67xrapKXoAgBNT2IA=
Date: Thu, 3 Sep 2026 10:07:23 +0000
Message-ID:
 <IA1PR12MB9030D9E7A6FF2279708F7B4DBDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-2-mhonap@nvidia.com>
 <20260821235240.7926351d@jic23-huawei>
In-Reply-To: <20260821235240.7926351d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: 48180932-c0bb-4b17-a25c-08df09a3264f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|4143699003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 SitQop/lZTDSO2TWE4arexFCAYisoDIm0IfAoxSo+oVrH+3I9J2+Ttkw1b1q2JcLZMDnjKegrmCcekdiCQBAxOsI9U6/fgT1qivafWe+yRmY+VkVDdv2r+iqoSzEWKjPcHtR9CA95RegSgbzjbhq1ZXHsD2DernhEi7fZv2sXsw8igdIwMSy0EpND52sUZMSmV2MxSGEqhzQOiGpuDQQJcpkxp0/lp6LbO4N6JSZc/haDVqQeE9Nh5ZYjcpvj4JVGOv/zLhxBbnCvuDxixlDQ7gmqEryLUhsrYwZhZnlqYJqA8l0ig2N3mIXa8/mobxVgLy+1PjSdI3M3HNGA0HE3Gxew3iLYHzUgD2VdqFptdO6kjbyjiR5gK7+8hHZgveN3GVl2Xwsgby2B5EhesvQd9B4txigRTmKJ9X3Qln4bQ3VE65Gxd9SOsEOWobVRAXJi/sLqFJpaIKmfqga7wI1Sr3Fc9QbOeeER4WZNn4Qywj0AnREEVhksguX1ogCejuigvXVWxoZDn55kIoFQgvUAL87UFAdmv7zhrgAWN17WgPs3BjO1Cb17iibRBUFRGCK5kCrKKF+b9FtGlz75T9sctZUL/8ANiKqz78koDq09msB3DsK24GuXSpeeeXjfgElfCmSBmwLSfmwcMaCu497J3bysY5ftaylZ4fbdoKF+9CEICT5XXqNUw2pl+3+mLTuy/FnG+zr85TVtlE1CIByxd0HBUYUlNG2cfuKEWpSn0k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IsECCzEwaT8HEhN1c442SRW9levEcOB30zDLVSSnun+6GNcKdt7z2LXj9GEk?=
 =?us-ascii?Q?maVN5axFLWtuIavUTvySafWDwexgxt1ZhEFAPoqshZku8HPTFN2CY3EjjzGs?=
 =?us-ascii?Q?sL8SIFvc9rV1BaagIw+6z8YN3h03CLFEl0KSs767ZxlBxoGIyERlT5YDSbEH?=
 =?us-ascii?Q?3F/+b+xECs50aVTvpCT77hWG3opA6MGdEKOWloA8dUlYOjnfLJoKX2UOHxid?=
 =?us-ascii?Q?c+iBnRbvr/PWMrqJK2t6siWOZ9Af7L9kwmc0R4SUDk0CJQUu0bDvy2cXufJt?=
 =?us-ascii?Q?Qc0mptkqFoueKb0chIafup3kiuCYn18t8zzxJXKkMao2gpzFRZCR5nJKmHQN?=
 =?us-ascii?Q?uSDNImW4QMGqF4bKS3uvF3xjhTF6YyW/WrkkvAG3laNyqtuEzukEGELC4/Km?=
 =?us-ascii?Q?uH1504LzweAGAIWtcKGMsQBx4d+B640AscnERex4zm9a46SBYzwIvr2voFsZ?=
 =?us-ascii?Q?d9q54qxRgezy1ohxmWOrgQcJc0zNrAPdSn4FC6iCRet9JbFDnJTKQg7DANXh?=
 =?us-ascii?Q?nVDGGUxzVx+S+RuwbczpixNsM4mqH+3C9NXRxWXd/dKl0zCmdt6gSQ8Ddbg6?=
 =?us-ascii?Q?VmaRsxBmfr2UhWJHvVjLWl3AklgOMmMN1YwLceHii0Z75u/kqZHZmgDvu9qH?=
 =?us-ascii?Q?vxD2wMT/+kcf6yxCl87yTH6NlEOd41fhn3Fh2aefIZj8OfSs10WU8SQBJUH2?=
 =?us-ascii?Q?l85T6SdaGRykoEIU/hvfx8JaN9UVASKXzaMeSknjUWfbMOws/7QYCQoKCqI7?=
 =?us-ascii?Q?67CNi3QhmzmZTyCz90GyhaOHguupYZXgWoUtEx8CT1eECPylFRbUJ29KrXFz?=
 =?us-ascii?Q?VB0qAdPBOn0/gmH4CPGPBrPfyb+kav6HSUOMlkNc5jWJrmiQNYT1uu9REn4j?=
 =?us-ascii?Q?X48Zm58n+tYsQwO6EN5MeU85dp+7L29OQPhDBmFymo6OC4fLJx2RtNjpZYgh?=
 =?us-ascii?Q?cZGatePCiBT2+z0i7okKA8a9uIV9ZWOjUL1AXwk0qh1oSZqHQ8soz4moGikY?=
 =?us-ascii?Q?dc7P/ObYDHTjWhUW1L6ImqdDkPHnErMOc2K2TZP5kC31yAV6YYBblTfClfbp?=
 =?us-ascii?Q?9Sd/cvIpSLTUdkGeUTBZOdWw9SqOPRzBrcdSpdf/L1qy+g8WfaRMCE+lUSpH?=
 =?us-ascii?Q?H0pWpPKiWP1mvDOJnZU/SH8Zd+Cs6QKjAAHvAf5QSOCjydmWQlumhKir90O4?=
 =?us-ascii?Q?/ywLNE5MLFVWgO7iJyfMIDqo5kB50HRx7YRstrx2+D+ql/zIShuGKteti//Z?=
 =?us-ascii?Q?ZmQvmxgoaA4VrXuasqvfZOtG39qLeXrXZU8Yp7bl986M8MsHVZ1YzCtt10pD?=
 =?us-ascii?Q?L0DMqnJbgbIsIW47TWlkpYHcOixSqJ45UyXYzvwaXJuf8wxgZaxilcsa1NL/?=
 =?us-ascii?Q?gu7ecGmS1VvphBKUKqMMu81r1uf/osSkvIlJGZdfsUmQam3p4QINuu12dNvm?=
 =?us-ascii?Q?Uc52/hZ/TIt4mENFxI+pOyh3mkm249OsB8bYUalrY/f0QU2/QThY2Av2DCaY?=
 =?us-ascii?Q?x7s0IAwtM9LGs5jb9OzPskPwRiZpam6dc2PsX9c30qcToXxXY+hjfdAnQlV0?=
 =?us-ascii?Q?P7H2g34vUMMhqkABgfSbi/SAPM96OIJQybhjvgON4gz+v7djTTSNI0dFMr35?=
 =?us-ascii?Q?C8xZcTWv3hVm4lRY2t2/1fWcnAZSqRmL7LJfbPqSAEqWs7WQFY9OvUEma8r1?=
 =?us-ascii?Q?FFlAauRbqtvhT3c67T16Q/ME+wIMNgmlvds7Rcw3+HOFFQ+/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48180932-c0bb-4b17-a25c-08df09a3264f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:07:23.6858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGK9A23L6TL2k89Zqo/Y8M6UmQwRKBreNEt6UZjbuTNL1Ap3yaqXKfetfcsCt68/HO5zK9e1YgxOHgVmjHMgGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, August 22, 2026 4:23 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
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
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: Re: [PATCH v4 01/27] cxl: Fix resource.c include path and export
> cxl_restore_hdm_after_pci_reset
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:05 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > The vfio-cxl Type-2 driver restores the endpoint HDM decoder after a
> > D3hot->D0 soft reset by calling cxl_restore_hdm_after_pci_reset(), so
> > export it to the CXL namespace. While here, correct the resource.c
> > include of the CXL PCI definitions from <cxlpci.h> to <cxl/pci.h>.
>=20
> Why?  + if this makes sense (I haven't checked) please make that a separa=
te
> patch (for now) + make sure to call it out in review of Srirangan Madhava=
n
> series where this file comes from and which hasn't merged yet. I think it=
 is in
> patch 5.
>=20
> Jonathan
>=20

Dropping this patch in v5 series. On v7.3-rc1 + Srirangan's v11 series, res=
ource.c
already includes <cxl/pci.h> and cxl_restore_hdm_after_pci_reset() is decla=
red in the
public include/cxl/cxl.h, so there is nothing left for us to add here.

Manish
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/cxl/core/resource.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> > index daa5e7fa2509..492ffe8e3576 100644
> > --- a/drivers/cxl/core/resource.c
> > +++ b/drivers/cxl/core/resource.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> >
> > -#include <cxlpci.h>
> > +#include <cxl/pci.h>
> >
> >  #include "cxl.h"
> >  #include "core.h"
> > @@ -850,6 +850,7 @@ int cxl_restore_hdm_after_pci_reset(struct pci_dev
> > *pdev)
> >
> >       return cxl_reset_save_restored_state(pdev, command);  }
> > +EXPORT_SYMBOL_NS_GPL(cxl_restore_hdm_after_pci_reset, "CXL");
> >
> >  static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *c=
tx)
> >  {
>=20

