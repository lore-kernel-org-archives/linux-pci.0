Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE9483BFE;
	Thu,  3 Sep 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430445; cv=fail; b=sz+3Xn177MjQyZibZQ8HQoTTP815WlmYnKyPUABmNjPfNV9n2nZwf+/64aUh/4HpElu58rUIUtgL47PZxeDwbr6VlS0dtkZ22/yqhoVXwpY0iDh4mlWjaz/ABBNQzhOiHVuwESCF5sJt154xU6nbTrR9K5DJFgs12WKeKKnl4II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430445; c=relaxed/simple;
	bh=c8TwS0HKo+owraXppKFkV9XzQhe0+Bx8ecuhzsAC0OY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hYsa0oY9+AUqGlnfae+AlF/gesblL1hsS6rdKy1t/QWofFc2TAuVR1pC+e9Msf1Bw2Jd1PS20xCPO+gYVtTes1T8YDWB6mIhkzGTUN1mlMas0BW6BMDMyP2LDkma/cVK4/BR/R1OeOzFvbfjfMqjguPGnOaHrBUgm/h83DGV3Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M/qtuOSN; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/qtuOSN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjDZXPzLg1FMQvprkUlZ98IkMBoz5azXjQhX35gJe0rgmzRmvfLiy3+crOZFgBgaYyfrM8nzz3wfiER1+XMpskACP79ILEp/eIvqun2crj5PN7gSrHu7MFJzaZnactouff/9w+UHzmixISIKdctuxfy0CGwp9B6t9Gqy1QK4TusjCCle7WjycctLTJmq4N9sxr06E5gQQ5YiyAAvQzmQS24i4rzGzB7BirzRDfO7300ZyGKkDV28xhf1Nt5qXpz8xX54I+E8I0a8dljUTnFDgkoOBUoo+pU4sdtz3cEaEyN+E60BnzBdqVSedywlLJO1jtfhfN21R9Rct+sTajEolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miHmFooAs5jBMxijorWxVcRcOpzCWrKfVDEUOk0Hn8g=;
 b=rSWAK1GVtyEWOiNVu/rmI6YKi3xYKpJmr/mMCCdVGcyZsKdmT4NETGzm1SBGnN9GDyfBNLNfOBpM2gqNlMrJl+g/SMVPbK2HQS8z2/pkrk4J+KX4a0wNdGB95v0IXJkAyM8zoa5ljhPWemlZTlvTylLEaK7p7LLiDrSjmS22DhuYzzFXGX4ibH/tbVSnqImfNw9e3ct+ueL4yCL3x3rln/C331NOK0XdOgVfS0xxipmMr7GSqXWB+2T857PGPWOnhxO8gBXCGGDbR5Hy5kQNDmcqz6DLHxUsEiXq7oDyM6GXE9PCC0R5vXphXODOqyAVq8Xs6hIK2IVxrP2PkICQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miHmFooAs5jBMxijorWxVcRcOpzCWrKfVDEUOk0Hn8g=;
 b=M/qtuOSN7RxzYnLAVnJX0PZheFqPw7a4/8rYoA556iMm59c4IY2IGrBz6TwwCh8cKOFCt/gb4ON3H2uDeBEu3kIID8jwZF+RVEi8FeMuSNT3FmIfNXT3bwYLYYADQ7lXXio+CQDu1bXV6dRKATNyLRXCzH+S8iFjwcvYgJ8wDv+X27ANQ03OA60mycC7LD9Vo4mcny4oI+CqpAetibluSyGp4lP8nA/FSvTMvP+yWCEKUc+kOyeAjvgvTLq74Z1xkw3r2xpTNtvtBtOZ3KOjGdfo85DzQfb2iSZmM/bWuC7EtcZ9T1DidkKGZkqQvYi6GfqsECjEMbvk3YoIQenS+A==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:13:40 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:13:40 +0000
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
Subject: RE: [PATCH v4 15/27] vfio/pci: Call CXL open and close hooks around
 device use
Thread-Topic: [PATCH v4 15/27] vfio/pci: Call CXL open and close hooks around
 device use
Thread-Index: AQHdKwez+v4GSo28QUal0ZTEUTynf7aymmYAgAoRzGA=
Date: Thu, 3 Sep 2026 10:13:40 +0000
Message-ID:
 <IA1PR12MB90306FB7D62E104105B3E1CEBDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-16-mhonap@nvidia.com>
 <20260827170310.5f49eeda@shazbot.org>
In-Reply-To: <20260827170310.5f49eeda@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: 09b15d14-41d2-412e-4176-08df09a406d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|4143699003|5023799004|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 S3+rQqOC5Kko43GHsXOBuuqtBLD7MCRZmMTdZmilEedG8vd+zYOCbvX/4E0s39F1Z7m8H1hUWfq9SijQ8ZxUkf5dbyXKTHlL5spwkut+V2pX3MQgXACNkGF7di22BR0blOg8yiN5hZGBch/WdkmOkuXEqVxkEiRFDMR3Y72CXdRexM586fWE0ShT7uwiQNHeC1+E8ogBc10+XhCzk1xwnDQuumkmnVrmoSf+jf4HVjn7D0VzsToxMtpsYV9/1t/Hzq0U6MBLTtaXt45xmVj+H1ZNPnkYZSudT5c/wVojSx79SZ0CH4Hf1lp1i0PnC37byyevVwr0aRx0aCAByHEPgFaj2KFpJt9k2KF7cBD7V4fCS1+luQq7NiYCEM2Syf3V6P1j9h5B1CpIuATZ0zF7AvmLikeABALMXtWR/cn2Py80JVBYfTFYgjho6TQtZ5Rabba34E60umx5V21m2dC9TyPfVXlVsNOdUXh4jvfpRtwaz2YFp9B9iVEbyUEnmzvtgNPTTDprfadHfztbspcL7KMh0taqc6L30/Ynxi68stt7VGbIMD0irQ029OnWisOdmesmiGaV7jI/pdmQoj+glgGkfbgKhEECe1QBC2qwu7IO3VkTaknLhPcpkpeVg+zPx+nWBtv1q+RAQA3kJ2o9xi5xdG0qDFNjDjTsXIkI3ApEv4uQ+WAnvUfw71QAly7xdb5WTwwHpriV5M/vu3Qfjq2Uz9Eze7BLgqclC5kKk4A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/K26fDK30TM+EkwdVIjwRtRIsnsGIa5G1OthAzypGnkhiAXFAZlG2Vjo+cQx?=
 =?us-ascii?Q?ZQzBsJ3obY4YtgX55HiOKaeC/cRq4+oHM4T1bCZz4HJGFVxlIs3eeEkIM5pc?=
 =?us-ascii?Q?yTvywb9fE0LXh7I2HY2JHVh5ChqYHTdsAcng/Ympeov1yo1ccxPFk7UqgKHt?=
 =?us-ascii?Q?nPslh8rxj4M8lU2w/OI0l+buH3kGbvDlv7+AHQOhpaNHgxrGGKxKWODzQSSU?=
 =?us-ascii?Q?P/ohuxfSON2QguI7XyhCGohIVHofvs/1ZNLwC3x4RwGDpzBn7nUCAqrLtJC+?=
 =?us-ascii?Q?fnlO7Ce+MMluiOqJAKJaQ10WeffmXJ/za7kkb4AbBTl41wKqfCiYTWhQPqRo?=
 =?us-ascii?Q?3ORFsy+tvAYQi3ka67VMlYb+2tvx+aCfIjdLPKUG1jYeTSaqheVm+zxNexoG?=
 =?us-ascii?Q?1RaeZ418bhs93X5ig3JoLRGqc8VCI6Z7PXTy/As6VHgqwnlvAfWK8BkS2aAa?=
 =?us-ascii?Q?qgi7AJs8HnfZl6NYkS3i63AQqd3wP2JNBihSQiAdOQD3ESAdJuzghIWJbTzW?=
 =?us-ascii?Q?q0vjVxYENry60yzed5j1ALo81GO9lZhq6YdLHiaA1/D5WOum6VGz/mK1/RSs?=
 =?us-ascii?Q?EZwbRyP+YcCkqt42avgrYw0/D3ZbGJrTKIc9/rEoJc6+3RRK9Zo33Si+X1Vk?=
 =?us-ascii?Q?aSQOhh3qL6QgNzYsafulKN3viT4/7mhsIZVJc3ZrN0EW69NGTDfRBgu+0mX7?=
 =?us-ascii?Q?zXMKHT8bQCDt5Anvi1jNVCNUfKNOiRLTHKKAIwt392u432ZsRISSTOQTq7CQ?=
 =?us-ascii?Q?ADirbpl+4WUCXgnj8dKjsNBwGk/NtO3ughVVStafNY7sPS9N6P99Tnm8O0Yx?=
 =?us-ascii?Q?DkxPCTlpczPwibRI+5Gz8+MIxeY8KSzDkD2iXBA8BsMipjkhGYszpHOpQC2U?=
 =?us-ascii?Q?6l4MKFoF1ewgat4mGXh8ThHDPF8G2apMTf3hVkTsKWK5eLub2VikTK8ly+ap?=
 =?us-ascii?Q?dkV6SmDfZzLw0bPiMnTUund+0uLik3cFea3Lsz3v1TxsGaxunUnxgmBBLQ7i?=
 =?us-ascii?Q?6hTHnJqaI26b5XxMQ3lmzRwRlOhAItSWbPiXBUBbNpEcBdS1dC5MlW2h1Iwv?=
 =?us-ascii?Q?AUCkS7r46NZHC+xfM0i+apSAdOZXePTp6ChQK494BH9We2rafGQFc9+hAxwo?=
 =?us-ascii?Q?LPcB+zq4vICNzYZwYr+j4Vo9GxA+W6CumEg6deV9acR87jr+aFWuIZ4EMP2s?=
 =?us-ascii?Q?srQ970RIWrdMvRS6r4nK67Zvxt0eYXD0s4fN0GvxfmdIgfTrEieZ9eYlpTA4?=
 =?us-ascii?Q?w0TSHrXHw9MGlU4pfR+fNWnULzWuDpescL5m0zvcb2byvci4tVrn8K3UdTrH?=
 =?us-ascii?Q?UKXuc1VfbLB+8RWNqRjyVSUsrt/0/yOWppLc6hnmGpb1gRXebIgmRsTT32dF?=
 =?us-ascii?Q?RN8IzBSeAYOyucpje4hBFu2Ox1jKR9ctrzO213kHRDDFdD8VCtLjhTTX9t9v?=
 =?us-ascii?Q?7MBOV8cL/I5XUTHADGTGaKvLSWaG+c02uM+2v1G0JIDGGsF9RlzuBOU6B3/i?=
 =?us-ascii?Q?zz32llQPCt6F7cnugnr6WdWWfLmpfgQrhG91z+W/6Viw9YT444gvKCrPI8Uw?=
 =?us-ascii?Q?DYngsed7Yr689t/Hq94HHy1iLM+w+V7WuznFvf2yL+t1lTGWLE3ufpLbD396?=
 =?us-ascii?Q?iYdiKkCj7tniFDOfP2lycMSm7iaPd+23fiq9fqQDKR3FsBv9/TENaBqRo45K?=
 =?us-ascii?Q?Jv+J9fQ0BCm8yTz6LdVfVDoC3NpshB75+aDpvp6/wYMiARM6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b15d14-41d2-412e-4176-08df09a406d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:13:40.3877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXkvOZ5vWIznmIT4wIvzCI7Ad7X8gIxTC7T7l6Q6rwHpBllrmDA788blFzPho+cz+xrv6rEQ/1ePgDTZyQ4zsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, August 28, 2026 4:33 AM
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
> Subject: Re: [PATCH v4 15/27] vfio/pci: Call CXL open and close hooks aro=
und
> device use
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:19 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Volatile CXL register state must be sampled from live hardware when
> > the guest opens the device, not at bind, because a low-power
> > transition between bind and open can leave bind-time values stale.
>=20
> But patch 7 prevented such transitions, without really an explanation why=
.
> Accounting for being in full power state at open here further diminishes =
the
> requirement to restrict idle lower power states in that patch.
>=20
> > Add open_device and close_device to the CXL ops and call them from the
> > common enable and close paths. A failed open unwinds the enable like
> > any other error. The callbacks are stubs here and are filled in next.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 11 +++++++
> >  drivers/vfio/pci/vfio_pci_core.c     | 44 ++++++++++++++++++++++------
> >  include/linux/vfio_pci_core.h        |  2 ++
> >  3 files changed, 48 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 966b7c22a6ac..d19fd638f538 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -100,9 +100,20 @@ static void vfio_cxl_release_device(struct
> vfio_pci_core_device *vdev)
> >       vdev->cxl =3D NULL;
> >  }
> >
> > +static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev) {
> > +     return 0;
> > +}
> > +
> > +static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
> > +{ }
> > +
> >  static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> >       .init_device    =3D vfio_cxl_init_device,
> >       .release_device =3D vfio_cxl_release_device,
> > +     .open_device    =3D vfio_cxl_open_device,
> > +     .close_device   =3D vfio_cxl_close_device,
> >       .owner          =3D THIS_MODULE,
> >  };
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 49dfbdaf3f05..470730cdc88b 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -584,6 +584,21 @@ static const struct dev_pm_ops
> vfio_pci_core_pm_ops =3D {
> >                          NULL)
> >  };
> >
> > +static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device
> > +*vdev) {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     int i, bar;
> > +
> > +     for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > +             bar =3D i + PCI_STD_RESOURCES;
> > +             if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> > +                     continue;
> > +             pci_iounmap(pdev, vdev->barmap[bar]);
> > +             pci_release_selected_regions(pdev, 1 << bar);
> > +             vdev->barmap[bar] =3D NULL;
> > +     }
> > +}
> > +
> >  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)  {
> >       struct pci_dev *pdev =3D vdev->pdev; @@ -660,8 +675,23 @@ int
> > vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
> >
> >       vfio_pci_core_map_bars(vdev);
> >
> > +     if (vdev->cxl_ops) {
> > +             ret =3D vdev->cxl_ops->open_device(vdev);
> > +             if (ret)
> > +                     goto out_free_config;
> > +     }
> > +
> >       return 0;
> >
> > +out_free_config:
> > +     /*
> > +      * open_device() runs after vfio_config_init() and map_bars() hav=
e
> > +      * succeeded, but a failed first open never reaches
> vfio_pci_core_disable().
> > +      * Unwind the common vconfig and BAR state here so the allocation=
s and
> BAR
> > +      * requests are not leaked for a later open to overwrite.
> > +      */
> > +     vfio_config_free(vdev);
> > +     vfio_pci_core_unmap_bars(vdev);
>=20
> Unwind in the reverse order, this should start with unmap bars.  The abov=
e
> comment is rather gratuitous and looks a bit like AI slop.
> Thanks,
>=20
> Alex

Okay, I will resolve this as suggested.

Manish

>=20
> >  out_free_zdev:
> >       vfio_pci_zdev_close_device(vdev);
> >  out_free_state:
> > @@ -682,7 +712,7 @@ void vfio_pci_core_disable(struct
> vfio_pci_core_device *vdev)
> >       struct pci_dev *pdev =3D vdev->pdev;
> >       struct vfio_pci_dummy_resource *dummy_res, *tmp;
> >       struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
> > -     int i, bar;
> > +     int i;
> >
> >       /* For needs_reset */
> >       lockdep_assert_held(&vdev->vdev.dev_set->lock);
> > @@ -737,14 +767,7 @@ void vfio_pci_core_disable(struct
> > vfio_pci_core_device *vdev)
> >
> >       vfio_config_free(vdev);
> >
> > -     for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -             bar =3D i + PCI_STD_RESOURCES;
> > -             if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> > -                     continue;
> > -             pci_iounmap(pdev, vdev->barmap[bar]);
> > -             pci_release_selected_regions(pdev, 1 << bar);
> > -             vdev->barmap[bar] =3D NULL;
> > -     }
> > +     vfio_pci_core_unmap_bars(vdev);
> >
> >       list_for_each_entry_safe(dummy_res, tmp,
> >                                &vdev->dummy_resources_list, res_next)
> > { @@ -827,6 +850,9 @@ void vfio_pci_core_close_device(struct
> > vfio_device *core_vdev)  #endif
> >       vfio_pci_dma_buf_cleanup(vdev);
> >
> > +     if (vdev->cxl_ops)
> > +             vdev->cxl_ops->close_device(vdev);
> > +
> >       vfio_pci_core_disable(vdev);
> >
> >       mutex_lock(&vdev->igate);
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 43755b91880f..7354dae1dd85
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -70,6 +70,8 @@ struct vfio_pci_device_ops {  struct vfio_cxl_ops {
> >       int     (*init_device)(struct vfio_pci_core_device *vdev);
> >       void    (*release_device)(struct vfio_pci_core_device *vdev);
> > +     int     (*open_device)(struct vfio_pci_core_device *vdev);
> > +     void    (*close_device)(struct vfio_pci_core_device *vdev);
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;
> >  };

