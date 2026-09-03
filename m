Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F047F2D9;
	Thu,  3 Sep 2026 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430221; cv=fail; b=d3QdBHhjMIl7xzGrmHVibX4P7bmgc0d7apzViqEWTPbo2QDAIbgsobYnwkDyxW+/mmTfCCt15SqD0FhsOr5wQlVrpRxfoeiFDFrU7QpDvWS57kiULuoQL3IPnpVKT6Vy+pSjPnyUK9EmN8LvSAn69hlNopkdLod0leM58mRl89E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430221; c=relaxed/simple;
	bh=yymDsLqJ2PuYs7Xcw8QYoNr4yPWMgm3nIF4MEpl6uys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H/ff4whlM9yiRXC6ZJyT6g8BoK4+iixN7O95CRSNRdC8pqqP6aNNVyJRJOVysgSdgBEdEzjYuI4N99tG6fDhEvtpbuTHT25pQIkS1t11fQYXzKX4GqzjmSM4dKG5XiLVXQIuWoV1pJlbD8DuZoEMIQgis9inrOC43uRTaxYuUWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VjstNgYc; arc=fail smtp.client-ip=40.107.208.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VjstNgYc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbY2wUqL7vyqKCZUqdfzB+uOzsz7bZM3AVOeJSGSzbwyC/cxjSXSxIuSeHXM33Pa34H4mcONcDS90WtuO97UQoZTSghhYMsomfNakglFebDedx/MIHcGS6vCwbIHNuNefy/vGkm9yHeHEBHltt2br4uw55mbjV1OAA0W2YW3BWoYUskB2vDR5AztkFZenDjkfW8/W18YwYiDxS3G5veMXqct3PoGouHtIQaoMBKXIs27836ZiedEDkqwwYA1U/cBE70IkaL4bNoSkcLjf1S/nCoQS4z/Vh7cvggVw3qo8Xu5pVud70MO6JSJ+QIab9Om7txU6Gv778T5qTGkQAQEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVk34mzZXw/qohce7TE15G9tKommzmJc82eUIeFWKaw=;
 b=N9670v8eXeeBDfuiXIPy0mTrHl2pojZuYPnydpVYd20WCp6LoF4hXSaTQ3iwlXqgAgRU1DT/qCR/Cp8GZ1MwfgzZyj35PvR2RfJHmzb6O1mbY+PyH2HqUBEQHX86zZM0R6qy7jeqoCB/gveIqpZq8suyv3IlA7knmmoCBfMcfTY/TXIoGI9QsxVrPMYDViBAaCnT/bplAa5WHz/Jt8dJFevsknIPshRZfG1I3lJOZOVzkORdQDC5koI4QdTkxOneQt2/0FjZXVh2t0s6wu5G7X44eaJnuCQ063g/XOSd3jDQI/sB//Qkf3WqOoboQ6QqOZZCbnSIH41fVgSIK+CwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVk34mzZXw/qohce7TE15G9tKommzmJc82eUIeFWKaw=;
 b=VjstNgYctd/9gdT0oNba6ldscIuH/zzjBmvKwOWpr+Fyp6hghNkN8g9Vaf6rCgrW7DF/R6YjHtPHKwlod2hODtURWHegYzxJIfhUReQgV31Hu037IjpTeyRupeEHaqNTQDU5QDxqLsXKYagU4A4jMiTWRuwS+RAdo6dSf3px9Siy8cXpYmtv/Ou3aVIv++YsgmnjxvPxUIuqhj1JsrvXYjFBoaq5xzP+4vRTEvtcOtXTGqm1s5Ej319JKhe6V6k1+oy7XFaaSMFFVNolulewPK4zQUZKG3hgt3rUbbuI6dF6VfSvWC1AigXz0z6gygQ3OA42pq+Y1Hs8KA872WJubw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:10:06 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:10:05 +0000
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
Subject: RE: [PATCH v4 06/27] vfio/pci: Add CXL ops registration interface
Thread-Topic: [PATCH v4 06/27] vfio/pci: Add CXL ops registration interface
Thread-Index: AQHdKweCUW4LA9fFkECbqRVABSP7lraw6PsAgAugiNA=
Date: Thu, 3 Sep 2026 10:10:05 +0000
Message-ID:
 <IA1PR12MB9030C72FB28A1D6D915A333ABDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-7-mhonap@nvidia.com>
 <20260826151154.19486297@shazbot.org>
In-Reply-To: <20260826151154.19486297@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: c2759028-bed4-4dff-6a7f-08df09a386ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 owKeKIygD6XFpenxNqsVQkf8XOSeg5NlkJCzvhqLnt2EF7pFNtS3evxq9Tw+VRk5dAFY57E7N7vcuvQ5lGJ6GZXnGNKgBmz4AG0pe4b3d/4r4o3e5cJ0gsQMcNT3LU2ST/0Cq3wbg/AjwdtMs8Z6FJVfT1icLts1oqE4JsxIb6s5Ok1DQpgx1lU72IlcQz/Zj90gvKxyUhoszOaHois6NytmTDknwTwkVQpFWbYy59alf07nJnrpnADqQDWOecgoAi+Fe4O14oaTlr8e+lJHAUv/CJzgM1AYvoNVjtHyXdydkK0ilf0kWhy8PVsTcctGzDmXWaRwqvurkwSFL5yhcznQcoRmwU43O6VVfVq1rEzqJtY3Njl37OklQPPDwDPKUKvr1SQsef/hxZkyEZMBUB2JW85qUeJflkFdD2q13fG3x2SXDmGkP1ictGOExxeb9t2jWTdAwm1MfQSrClYcAC+B2EVqL9tk42z7gCSXlfpVW2FJ4YwS7oHNaU2kqqNud3+vHkQ4/0cS1m2VdQzbB9nJroQ10g2TW+8Q8FWWny4VWCzg0BmsO+btYkeUBMfXhqk1BStswKqzmDT/6mSFLVIHfk5oYLwF4eBUGKkfeVk7xg5x9Xg6a+wyqhtIK6JJuCv4zjEsxCb23A1mbzGNEmPuCTq81BwDS3Lrz7o1PZ/wJekrnUwf+steyGCK2ELLchjXAUTsLYG1HAcKlekqqOxV62s2EqPEY+J/4M46xcI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Km64AbJ01e04R5viWz0/pBvDZG8lf7BrvrcObkHbSfzmhHdNO2fwU1ZXpZOh?=
 =?us-ascii?Q?n2BJkHpfJorx3phzyfr1wlClXOb1yFnlpLS286MEuCYXJBvVIQB9Y/vQlkgr?=
 =?us-ascii?Q?U9R81FByHNenHknyCS6H/mQ87TBt3FIPIshYp2eNFvRpyuK0PTxDUvtmcwoJ?=
 =?us-ascii?Q?0j3kM0QviobZA0n2+NOEkfRBCEtfOrZO7oWS/Jor4V3GWYyymvAEuUSDBKIl?=
 =?us-ascii?Q?qoOOaYvXd6Ld48PwLwVCY/dk8r1pQrpNO919QONPfWuMvJXBblnqpOTYLX85?=
 =?us-ascii?Q?2kqphmFNcsZi5oZCrDxVGnSOMYlwKXeOvVRYDfWHcxIDEuD9SOu3W8i+F2S9?=
 =?us-ascii?Q?OsB5slDQ2Vi7dQomGsWtTn+QBwfMLsu3C7yRrVgrNDSlTbnS4n9ibHwBPblT?=
 =?us-ascii?Q?3+WcZ5jVVOZVxye2TE6i6oYuzr38cL1kZDUHgz7uhd8t6kAfsxFNz4E/7+8S?=
 =?us-ascii?Q?YchKuJLdsCfeMzS482yX3fRQkfPI9HCYdIIbsphw5D6luJGPRxUsm0bpp1lt?=
 =?us-ascii?Q?rZr2pz9PrsCGyi07bMrLvSyZQ3C6h8PQIZKV9Vki8OuXzNpLvLGdNPJgCwQI?=
 =?us-ascii?Q?mPQ6Ik6nhJcyZO9Fs0QtQ08Op0MpVIYrbWKoKrcL/zG4cHxNd1vrDPPcdeFT?=
 =?us-ascii?Q?eDVFygTckbwVIagH4dhbVDN5GQykO9T0NrD5ytXLmuWx35tXnBFERuSlAlhy?=
 =?us-ascii?Q?Ecyo2ark9pY7u+CPJIY/ru0ysqY86nvi1R3qxbrrhrWISArSlNv1dQiNroFk?=
 =?us-ascii?Q?NAazKY/9BgIDzQRDBJKzmlmMRQEvHIItnucAnu1wh7BUZvVqK3+siYqaZN57?=
 =?us-ascii?Q?1Yb/f/lbjse/lSmnMn+PeDaLWdCaHuc+/GTkt6xi6dqzCe1OgUDeoPuCHfni?=
 =?us-ascii?Q?G4/eymbniPcLywGHvQAcMZ7UJlI2z+W0WSXkO6f8DHWy6BwKWzv3MvTxo4e3?=
 =?us-ascii?Q?b9Xfv3MOGSlzi+Hx29DZREckqnC/oLvmFYpSstsW0NFGEflXMGaq9k3ef/9z?=
 =?us-ascii?Q?EdCD/BlLOrd3WNRVmwFlFgnPOr2SPwdorxb+lnHkz4wgNg4R4P6qpBenxwBh?=
 =?us-ascii?Q?1tr2e+bmwV3HnX2Np0Yet6UFCvkpkxt7Hv+DWO+JbaxjyfWuwJqKRDuqyI5R?=
 =?us-ascii?Q?R1iMtXbSMw7+WjJAzuqvNQwRsrCo0nwYiO6RKQzk8HDqak8JqfsWe2tl+2m+?=
 =?us-ascii?Q?0Hpd8YIIahRspFPyVsTLHJ2W+2dXRNuYpjpLAcB+qiSMod9YtqVhyrbCE8bX?=
 =?us-ascii?Q?DHUPZpE4bCdETY4dK09XdCZNMGIB/B41TNKzsy8Lqs/9dxhadn0URP+IM7Gj?=
 =?us-ascii?Q?EDYCCyF9fUE5r6Uj/gPD+JMPWVXooTO+vsOIMnWO1Zz1EnpIv21eX6pYSrZ+?=
 =?us-ascii?Q?FrjLZYj6aZhBYeuZH8tSZui2+deXFygpikk3HUv+nuZ06ewPzMdXBt7f9Nug?=
 =?us-ascii?Q?KONG5ADUKzLqqpRZYh94Goruw/qFi7Y1P2y+BboCrJzNQDOJ6kshM6R04Mux?=
 =?us-ascii?Q?hTQLcPfBhQqcPMJ1A4lRrx8hul+oW++22tZTtD0v/PYInWmgKet8x16kgjfv?=
 =?us-ascii?Q?OjAW7I9LzzrZU83nqqTM0uzOri4uZkZ3HxFiNJxRLwR3ZUBk1xPMbjJH6vEO?=
 =?us-ascii?Q?C8/kV4IdAZfMHHcm0gE52hjKPPVKxYLYiycDaec0PPM1jLAPRG7g3JkS5FDs?=
 =?us-ascii?Q?DqiFUqGpETNuQrQxjLEyrVYdNbaPiMuIZ40X3BKKRvTNCcvD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2759028-bed4-4dff-6a7f-08df09a386ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:10:05.8913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJ9JaL8kS/dmHFryug8LbOQJEr2ecrkqmo6vZw2E61Z/n8Ve0SAvDKMCuoTpMp6EwUh7GfIEIJIJJrXgnorZ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Thursday, August 27, 2026 2:42 AM
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
> Subject: Re: [PATCH v4 06/27] vfio/pci: Add CXL ops registration interfac=
e
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:10 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > vfio-pci-core must stay free of any CXL header dependency, so CXL
> > Type-2 handling lives in a separate vfio-cxl module that plugs in a
> > set of callbacks. Add the registration interface: vfio-cxl registers a
> > single struct vfio_cxl_ops at module_init, and vfio-pci-core stores it
> > under a mutex.
> >
> > The owner field lets a later patch pin vfio-cxl for the lifetime of
> > each bound CXL device. No caller yet; the detection path is added next.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 27 +++++++++++++++++++++++++++
> >  include/linux/vfio_pci_core.h    | 10 ++++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 3f11a9624b9c..88e68d43af9a 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -2670,6 +2670,33 @@ static void vfio_pci_dev_set_try_reset(struct
> vfio_device_set *dev_set)
> >       }
> >  }
> >
> > +static const struct vfio_cxl_ops *vfio_pci_cxl_ops; static
> > +DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
> > +
> > +int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops) {
> > +     int ret =3D 0;
> > +
> > +     mutex_lock(&vfio_pci_cxl_ops_lock);
> > +     if (vfio_pci_cxl_ops)
> > +             ret =3D -EBUSY;
> > +     else
> > +             vfio_pci_cxl_ops =3D ops;
> > +     mutex_unlock(&vfio_pci_cxl_ops_lock);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_register_cxl_ops);
> > +
> > +void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
> > +{
> > +     mutex_lock(&vfio_pci_cxl_ops_lock);
> > +     if (vfio_pci_cxl_ops =3D=3D ops)
> > +             vfio_pci_cxl_ops =3D NULL;
> > +     mutex_unlock(&vfio_pci_cxl_ops_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
> > +
>=20
> Use guards to simplify these, especially the registration path where we c=
an then
> just return -EBUSY.
>=20
> I see the get function stores a per-vdev cxl_ops pointer with module refe=
rence
> held for the life of the device, so the serialization on the mutex is onl=
y per-
> device at probe time, but it might still be worthwhile to preempt that wi=
th a
> rwsem here where both these paths are writers and the get is a reader.
>=20

Okay, I will convert register/unregister/get to guards and the mutex to an =
rwsem.
(double-register returns -EBUSY)

> >  static void vfio_pci_core_cleanup(void)  {
> >       vfio_pci_uninit_perm_bits();
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 9a1674c152aa..14753972e714
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -66,6 +66,16 @@ struct vfio_pci_device_ops {
> >                              size_t nr_ranges);  };
> >
> > +struct vfio_cxl_ops {
> > +     int     (*init_device)(struct vfio_pci_core_device *vdev);
> > +     void    (*release_device)(struct vfio_pci_core_device *vdev);
> > +     /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> > +     struct module *owner;
> > +};
>=20
> To mirror vfio_device_ops, should these drop _device and just become .ini=
t
> and .release?  I think that better reflects their actual usage while the =
eventual
> .open_device and .close_device already reflect the mapping into
> vfio_device_ops sequencing.  Thanks,

Okay, I will rename the ops init_device -> .init and release_device -> .rel=
ease.

Manish

>=20
> Alex
>=20
> > +
> > +int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops);
> > +void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops
> > +*ops);
> > +
> >  #if IS_ENABLED(CONFIG_VFIO_PCI_DMABUF)
> >  int vfio_pci_core_fill_phys_vec(struct phys_vec *phys_vec,
> >                               struct vfio_region_dma_range
> > *dma_ranges,

