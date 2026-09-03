Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EC3B6362;
	Thu,  3 Sep 2026 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430201; cv=fail; b=dp/2If6XEPbNFuczICGRnOW8/Vh5Wmmx/x1ORPkFDlsW/xuBYzTlP9b7ageFaRbUx0yGZO+DiaMj/EEHAkOnsYlD7Q2SzGx5jFZw8SFsyH/7Di5wodMOAsY4cVO6jmO1tXVwfFYXZWiyMOsFR8FwgwSQIuayH281AyVKFsH8Efw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430201; c=relaxed/simple;
	bh=2rrFCHtHop1XyGPrNsp5yvqnIWj2+0N7AwdEZCMW+FA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8MKl3oh3nBhWQZq8KxD0lC23u7hQfjSLO04Qto4/ZCrYuHkmK07QnWdF+JdoIqK/SeebpDU1GIeF5Cby5NjglbYgRstUfDm+i79oZDdcRDDo1+iwnvBxG3K+igQqIRiQGpxWYAoYKKcgXoXhSqtKNUdAZ+jXz+5c0Mw6ZPInLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b5hom0BY; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b5hom0BY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCjscao67cKNHyhkDb64yAENtrS2ZuJQA7GQacl0KctYP9DOJuET4aYQ3l4XQvL4lbiO/mEbFXRARlW8Eyu9sb59mQZka4t6U/f7aHYG4YJ97BE597u9QhLmosdpWjfnCSQ/IKa82KcVTgYSK2KzQr9Gft91bYjpq7nfM0DnR/IDpdwXsVfIriRjURjbWZTRpBTemOzsnUaitYgJJJJuzwzlPjID1u9Vc8p9OYaHErGhIBCGA1CbqbI4CeqPJybSe/2EjSOJEbf0lgI0OVBw3/Y65+RQZ4+hajh6vaf/H1ON7Owpa5kQpr0eThHJwMA8U/zknZNKIHTJuLK3EvgXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNtnZtpP31LFvMmpos3cjd3zWbwjJcy4MvoVlt7BnAo=;
 b=wdqMn0uMEa+0ryaUk9kqc9hYLOOhtDNEKycezamb2Gh9WwY9ZV/IBqkjBlG92UZ7YCdGjA0ANyFGow93RO8zqHlE6bos1XakWaGdFGb/bFT0Dq0fHTYIKBqNxgdO1iUIzJN/KWKXjLb40LXyQDhG0X2CnZv58641YeCNPnnPp4my78fvRE+FIk+dQEzLj56fgPh6B0SiXbjE0iQTQJr8i2xO7GvXdC0Acaw+OU2h2YdgQ0uB6maErjB8Hyo4U+tNLWNfLcy2W2mTwG4IxsJmtvwYu7GJN5tXxPig9L56zC9bpxOJKKmC2m9VJKknoLvNtxlcZebOHxAxcjzbsDdTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNtnZtpP31LFvMmpos3cjd3zWbwjJcy4MvoVlt7BnAo=;
 b=b5hom0BYYRqCnozKrkVflguaThFGMy142d586na1AWGH09HjWqotesWSD6dSoPH2YR4G8JcCTDupKON7LcugHjR0s9igJHPoM6sykX46pehsg2yV8wDmI6tmzJmcFXdJek9xMdSie6olpb8QV6knRv4alWnq2Dyozgu2Zh04TOSPGHPbNUImOJu33jsFNd4pCcwj5+w4dTG7qaLHsU6cdaYcPqmGcwumDVn2yDObE2bZ04P4UOMizcUGrDVN9gqSY5KMcotCtwucSHlqOvytBJ7wKGD0NEuep7U17YrnM4Yv8oZGFBXgZaSbbJ0JZtAReKUG0x7+9991rr6O8Sh8PQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:09:42 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:09:42 +0000
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
Subject: RE: [PATCH v4 05/27] cxl: Add a function-scoped reset entry for
 vfio-pci
Thread-Topic: [PATCH v4 05/27] cxl: Add a function-scoped reset entry for
 vfio-pci
Thread-Index: AQHdKwd6DG0I/KMD20KM968RzqP92baveCmAgAz7qvA=
Date: Thu, 3 Sep 2026 10:09:42 +0000
Message-ID:
 <IA1PR12MB90306969DB506409F55B227BBDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-6-mhonap@nvidia.com>
 <20260825171151.2f707b93@shazbot.org>
In-Reply-To: <20260825171151.2f707b93@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: c39680bf-84dc-4ddf-1ce7-08df09a378ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|4143699003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003|38070700021|6133799003;
x-microsoft-antispam-message-info:
 x3qQbftALMlNjXuKRFkoaoTJ+gnKCW/iLSt7Qt+CsHZbD1dAP4I6oU80dmMx0Q8ydFmcyUF1bwEaI7YVastVIzsZnKZFtBx1JbBlB4sCbms4FyJZaHfoORpTHxq1ILiEz2gisYJk9Oxh4z8H5+Ern3cC4/hS2yQJMJqPPHGvqA2N/S6kXyARr68IWFyRaM3JARXhhkevMDAbGnuYT0JUR57mBQ0/WNzbCp4n4eIz7JtehyG6CiZn9uppBb4sdmxRH7dbQysRYRpbkcsKfJk4U5QFN9JbKNkzSVeLTCSjeeiMLyK7+iXSydfhcepTYmByVmvb1Nr/eee+Qz37Wc38Bu4NC+wz8IkplGtxgMYeWAJpyaxmJaflfS1vNQ1sugbUFIa1/1y/yon3B/76R01TTn9s/mdlRS5ulW2DrgygocRojzbRPKf9DpA4yvVHSbpT6MWcgVnQ3k/Die/52m1IvkvHBWN8iSoXy57tTCPsS6HFaYtJBNrRAzI3QcjOyWDFJwrNeeaOdDPCacJHx/cg+g02/p+CZC1MVqWBoFaJwob1mkZwyrfXB/SmHL8InKyt6fQMDamRSSbWiDt4i36UUS0d/mZ1McsRI36xdCeyC2Z+b1Xw5/W2QOx5wgHSPdzvJircHLwtBnb/DeWn0/tINIkSDpDSu+aWvMoQdRHjITTRkt6UoLOCp+H5oQcE+E+Ym8miZn33E5S2zGCzQ1K2P5IKF1qovzdaxjdP/pOTA4A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cAaBjJh8dlIyF6Arz7imZ9Q9nizpls0ImmWm2pYnR9laqMlBtyoHPxDt6fyN?=
 =?us-ascii?Q?N4SEtYs9gcz0aZKsqy2292CEmF+j2cxzL8yTiICeTHV5V1gYy+apJJUgXeq2?=
 =?us-ascii?Q?W2MVIAky2SGaD55IDLtn8wPYXEFXD6HVPhrJ98Zqj1+V3G2R9O1POEn+cqK5?=
 =?us-ascii?Q?m+z2B3OwPSwVX5CU9Jws3mMEr0hTolF9EXTOl69ZZ9G+ypvRuNOhNEhAlaKW?=
 =?us-ascii?Q?e8BmjIjUoY4HnFCqNZbvMjmoC9Gl1ZALUJQ/FMoQEMo1DwHbkg01SIVFRhwq?=
 =?us-ascii?Q?cS9yuK8e1dKMS3toqCnnmqdmCKyBXQskP3nDfDlbz97Y96sVdMnU7HQLzAAJ?=
 =?us-ascii?Q?6gSZvp2GjwkltGTQCHslORKqAlEUSsNauVpvXdTnyMHNrBdOqFR7hGmsqlYg?=
 =?us-ascii?Q?h5AxLlOjEcOLHuM2GQFBhbHUWXg1vZ3QAEEXRXtrsBlZcQ5haTV8ldvagfJY?=
 =?us-ascii?Q?Ix63DfoZ0pmLGSs3wUHs7QdTuZirm6Ej0s7mBzraViULSV89phHCW0/8tcUu?=
 =?us-ascii?Q?qTvZlfWdB2Vt718IMcMOVMHAVXPtK0D/hT7Tn5AyXOonyyWJCbtSOV6d5Kqd?=
 =?us-ascii?Q?8Ehw4B3EvvUbpe8gQdckB3g1pWHKd8Nhl1yIe8HPX69Kln2MRKR3YAzJQdZT?=
 =?us-ascii?Q?64cgdMQ+20h5SYeXxZXhI9ORjZu2hPyFFLYCXVOFsoA5ek+JSuyxzYW44U19?=
 =?us-ascii?Q?RyCGoLlTdp11j0pDifhnwnCFk0bM05daRIr4pPYO4g/rCHr7Ml4nBKqQPE47?=
 =?us-ascii?Q?zgpu5CK8zhAPn7xB5o7cfsWyHFH/SlM136M4sAVC4QE6rpzuxK1Fj9/qipGt?=
 =?us-ascii?Q?8UCws5akjFYu1wRmlPkyKCso6ZZ5V9hZN1y1QyKiH4hfiZBPft8NJNN8cUYU?=
 =?us-ascii?Q?55uvnzxpY+Yg9SE/k9FVrL90Xa0+gRUQ+Z76l8lqQrC6jI6J9vwiTOMSmiIw?=
 =?us-ascii?Q?nxa4XvS53hvm61z8aYzFvO6JZ/NkUcDQZbM9LfAX/A16D7sLcmK3J5OU3W5Z?=
 =?us-ascii?Q?NRSPZH8WG0epv4c5+ba74YXzCGDfdMwmCKXwm91wDm7WqPtU1RjmimK3kbnx?=
 =?us-ascii?Q?5cZa6jrTpB/SbBdPS7HevalEJdP0D5u3aLSiZn+p1XgXIBqn5kGSNfMQ3wam?=
 =?us-ascii?Q?NO/Kzg01oyyU17/ulDqK170V8kjWu7zoAbbEcGXhoDxGWdl3Y1Bk2LvxURKK?=
 =?us-ascii?Q?eWcpSYFQMWS7oWUvB9vsJcslds6ex9kfdGsJ/PESTauiBIJOiKZggEAHEwyy?=
 =?us-ascii?Q?iChRgSIBiCpHUSXrfasfIx+SYcT/P0eEcr0vQmcMGGS/hPb/KQo8PNpMzCbd?=
 =?us-ascii?Q?Zum/objD1z2fb2F7OUL6RxN6s7JAes03qID+/0+KfN2VyyOZNN9mSwrvhtTe?=
 =?us-ascii?Q?TZ69L4G1Gs89ungNtCBSM2yZMZyUOW7mtdkQhJkv1AgQcAwI92gwKtmNLGU+?=
 =?us-ascii?Q?yCrB1eihulNctQLGnKwVhZkM3/b7KfoN5Msw6K5uAGZ20zM5hh//LgQ0ISjE?=
 =?us-ascii?Q?LTH+1ZiGu12sMA7Ad7WbMQTj9eYKNMsn432rTH0pXPiJzyj0mdIBMb1FRdx9?=
 =?us-ascii?Q?dck/9NdAT3Naac97V7L0ut728QKTo4nrpK76hyZcJyRn7Y+RkpylDbdaaQwK?=
 =?us-ascii?Q?qSrP2GmX39OoSoWmlZRwMTMaQA2uEfMP6rf+rEuVcncWM5jYBX+Ybxo6K6Jk?=
 =?us-ascii?Q?SVhqLOKikAX63KheZkExIC88HRaG5zxIdMtV6ND9H71d6Z1Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c39680bf-84dc-4ddf-1ce7-08df09a378ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:09:42.2207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dW3hUcRPa1/ItMPv2iRTOphfDzWwnmvZ7ccozLiQShpY9mpi9QY8DEH2GIsjGV7iWFim8OFZh3E8JafAM/cqHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Wednesday, August 26, 2026 4:42 AM
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
> Subject: Re: [PATCH v4 05/27] cxl: Add a function-scoped reset entry for =
vfio-
> pci
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:09 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > vfio-pci needs to run a CXL reset on a passthroughed Type-2 device
> > without the host-memory handling in cxl_reset_function(): the memory
> > behind the decoder belongs to the guest.
> >
> > Add cxl_reset_dvsec_sequence(), which runs the DVSEC reset and HDM
> > decoder restore under pci_dev_lock and cxl_rwsem, and
> > cxl_reset_capable() to gate it on a function-scoped reset.
> >
> > Parameterize Memory Clear in cxl_reset_execute() so the guest owns the
> > choice; the host path keeps it disabled.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/cxl/core/resource.c | 69 ++++++++++++++++++++++++++++++++++-
> --
> >  include/cxl/cxl.h           | 12 +++++++
> >  2 files changed, 76 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> > index 492ffe8e3576..cd15bd9171e6 100644
> > --- a/drivers/cxl/core/resource.c
> > +++ b/drivers/cxl/core/resource.c
> > @@ -1164,7 +1164,7 @@ static int cxl_reset_enable_cache(struct pci_dev
> *pdev, int dvsec)
> >                                    PCI_DVSEC_CXL_DISABLE_CACHING);  }
> >
> > -static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
> > +static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec, bool
> > +mem_clr_en)
> >  {
> >       u16 ctrl2;
> >       int rc;
> > @@ -1173,7 +1173,10 @@ static int cxl_reset_initiate(struct pci_dev *pd=
ev,
> int dvsec)
> >       if (rc)
> >               return rc;
> >
> > -     ctrl2 &=3D ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> > +     if (mem_clr_en)
> > +             ctrl2 |=3D PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> > +     else
> > +             ctrl2 &=3D ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> >       ctrl2 |=3D PCI_DVSEC_CXL_INIT_CXL_RST;
> >       return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);  }
>=20
> I'd again avoid a bool arg here, an enum type might be a better option.
>=20
> I see in the spec though that CXL Reset Mem Clr Enable is only supported =
when
> the DVSEC CXL Capability register reports CXL Reset Mem Clr Capable thoug=
h.
> Should this return -ENOTTY if memory clearing is requested when the devic=
e is
> not capable?

okay, agreed; I will return -ENOTTY when a clear is requested but
PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE is unset

>=20
> > @@ -1273,7 +1276,7 @@ static int cxl_reset_wait_done(struct pci_dev
> > *pdev, int dvsec, u16 cap)  }
> >
> >  static int cxl_reset_execute(struct pci_dev *pdev, bool *target_prepar=
ed,
> > -                          int dvsec, u16 cap)
> > +                          int dvsec, u16 cap, bool mem_clr_en)
> >  {
> >       int rc, rc2;
> >
> > @@ -1283,7 +1286,7 @@ static int cxl_reset_execute(struct pci_dev
> > *pdev, bool *target_prepared,
> >
> >       rc =3D cxl_pci_target_reset_prepare(pdev, target_prepared);
> >       if (!rc)
> > -             rc =3D cxl_reset_initiate(pdev, dvsec);
> > +             rc =3D cxl_reset_initiate(pdev, dvsec, mem_clr_en);
> >       if (!rc)
> >               rc =3D cxl_reset_wait_done(pdev, dvsec, cap);
> >
> > @@ -1322,7 +1325,8 @@ int cxl_reset_function(struct pci_dev *pdev, bool
> probe)
> >       scoped_guard(rwsem_write, &cxl_rwsem.region) {
> >               rc =3D cxl_hdm_ranges_prepare(&range_ctx, pdev);
> >               if (!rc)
> > -                     rc =3D cxl_reset_execute(pdev, &target_prepared, =
dvsec, cap);
> > +                     rc =3D cxl_reset_execute(pdev, &target_prepared, =
dvsec,
> > +                                            cap, false);
> >               if (!rc) {
> >                       u16 command;
> >
> > @@ -1340,3 +1344,58 @@ int cxl_reset_function(struct pci_dev *pdev, boo=
l
> probe)
> >       cxl_pci_target_reset_done(pdev, &target_prepared);
> >       return rc;
> >  }
> > +
> > +/* True when a function-scoped CXL reset is available for @pdev. */
> > +bool cxl_reset_capable(struct pci_dev *pdev) {
> > +     u16 cap;
> > +
> > +     if (cxl_reset_dvsec(pdev, &cap) < 0)
> > +             return false;
> > +
> > +     if (pdev->multifunction)
> > +             return false;
> > +
> > +     return cxl_reset_hdm_available(pdev); }
> > +EXPORT_SYMBOL_NS_GPL(cxl_reset_capable, "CXL");
> > +
> > +/*
> > + * Run the DVSEC reset sequence and restore HDM state for a caller
> > +that owns
> > + * device quiesce and PCI config save/restore, such as vfio-pci. The
> > +HDM range
> > + * collection and CPU cache flush that cxl_reset_function() does for
> > +host-owned
> > + * memory are skipped; that memory belongs to the guest here.
>=20
> It's worth noting in the comment that a device memory clear without a
> preceding cache invalidation risks that the cache writes back some of the
> memory we just cleared.  The use case later in the series does that cache
> invalidation, but the requirement is a bit subtle here.  Thanks,
>=20

I will rebase this onto cxl_reset v11 (cxl_reset_get_dvsec / cxl_reset_exec=
ute) and add
the cache-invalidation-before-clear details in the comment.

Manish

> Alex
>=20
>=20
> > + */
> > +int cxl_reset_dvsec_sequence(struct pci_dev *pdev, bool mem_clr_en) {
> > +     bool target_prepared =3D false;
> > +     int dvsec;
> > +     int rc;
> > +     u16 cap;
> > +
> > +     dvsec =3D cxl_reset_dvsec(pdev, &cap);
> > +     if (dvsec < 0)
> > +             return dvsec;
> > +
> > +     if (pdev->multifunction)
> > +             return -ENOTTY;
> > +
> > +     /*
> > +      * Trylock rather than block: This follows the trylock convention=
 of
> > +      * pci_reset_bus().
> > +      */
> > +     if (!pci_dev_trylock(pdev))
> > +             return -EBUSY;
> > +
> > +     scoped_guard(rwsem_write, &cxl_rwsem.region) {
> > +             rc =3D cxl_reset_execute(pdev, &target_prepared, dvsec, c=
ap,
> > +                                    mem_clr_en);
> > +             if (!rc)
> > +                     rc =3D cxl_restore_hdm_after_pci_reset(pdev);
> > +     }
> > +
> > +     cxl_pci_target_reset_done(pdev, &target_prepared);
> > +     pci_dev_unlock(pdev);
> > +     return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_reset_dvsec_sequence, "CXL");
> > diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h index
> > f8e8fddba152..541ed6de75a6 100644
> > --- a/include/cxl/cxl.h
> > +++ b/include/cxl/cxl.h
> > @@ -164,6 +164,8 @@ void pci_cxl_hdm_init(struct pci_dev *pdev);  void
> > pci_cxl_hdm_release(struct pci_dev *pdev);  int
> > cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev);  int
> > cxl_reset_function(struct pci_dev *pdev, bool probe);
> > +bool cxl_reset_capable(struct pci_dev *pdev); int
> > +cxl_reset_dvsec_sequence(struct pci_dev *pdev, bool mem_clr_en);
> >  #else
> >  static inline void pci_cxl_hdm_init(struct pci_dev *pdev)  { @@
> > -182,6 +184,16 @@ static inline int cxl_reset_function(struct pci_dev
> > *pdev, bool probe)  {
> >       return -ENOTTY;
> >  }
> > +
> > +static inline bool cxl_reset_capable(struct pci_dev *pdev) {
> > +     return false;
> > +}
> > +
> > +static inline int cxl_reset_dvsec_sequence(struct pci_dev *pdev, bool
> > +mem_clr_en) {
> > +     return -ENOTTY;
> > +}
> >  #endif
> >
> >  struct cxl_reg_map {

