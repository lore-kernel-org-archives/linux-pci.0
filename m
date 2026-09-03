Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304247D924;
	Thu,  3 Sep 2026 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430460; cv=fail; b=iRi+UvDthBayFfiW3EFhsOwUgQm6DgoH2mmngzJbFLnGKjegDWG0JEu/iqxrShSd8oyz1TRPI6iF4whwMz88LbT/yCkofGzCmp2nKtn84LrNgvrZGXvKfGJyllMrj/42/e9S2TbY6y4HnE542EVlUVbaLD8MWDAEKpCrHSPGjkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430460; c=relaxed/simple;
	bh=K5HZFSSNMDPZ8ZaHEVRvJ98qv5lZhvH2dY4QadjQkhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ma6z1KnwDo2zBYtzB3RDvGKR3sjeExcZeuQOs0o0813SQ2GgJIrJNm3axxck1tVAfhjqkHioqN6eyrBonU5neWxpo91w12XbBpBTDSdNArvJNTnmDSWdKVNJhphe4kgto8VAfAcy2TuqMQPmCVhrHRKZQN6ZgzySHBUP8ufbQ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hstAZnLh; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hstAZnLh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsU3/sy4yDkZ6jM7BBjR8TLo7cJWcOBWGrQNr+mUN18f8ersZAvWEyFCWfpQ3rVzXsNU55N/Kx/Pt/lPwxbNwETL7NarO5yi3JcqbFS6xSTF5BkEnztfHmfTT1KMhqTXWL65Wpm0asUbDjXB8KRiAMqDNHOTfVsHB/4DbDHI0qgeRPOYF3V6ekYFRtqtUZ/4pO3eLDL8TcKtlgbptTkS/QNd0eYZSgrch5BPz4l9yzlsxdGiX6xIzutv9ZWPEiFGOOURIrShTKVa8Ka6kLQ9fpcuSn2DhwFDBRYMEp622jvM0Kf7caKk7KaggWs2Gn97ZIW0nQfNO3JQh7ERUiqncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79h1yDZdPzkwGE+WC0x2NctC+IMVDF5OGEUSYapK53Q=;
 b=tLyrWJDSUVhnsMi40ZeZJ6DOIike/S+ECTmefnM6vg6KradzMwnP+9FiHnZ1HaBrGHchdDpqLrCZShrtPfEBYlQ23npCxiMZHmuE/IiiP5hFKsZyte+aUnbXHukYjZ8ERUk47JwH4T+JKgXicD/IDI+qxt9TnCeIFmlgiccSdXjjGBFqzOszT4PxZLS7GnH2NEYXfAbMluWCQg0oXTb8nQoPlTN/UEPXUbEu1c1kGq3eJuligTWO2efEqACX1aOzM6qxXQ8EvEpxcVahDoZ6kGz+A16pkcMTEL2DgK1FFGoNoZpc7v6o7BRBFtAegDElhJEITRm50T0fpkNGQEFeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79h1yDZdPzkwGE+WC0x2NctC+IMVDF5OGEUSYapK53Q=;
 b=hstAZnLhcahVVrZF5dnUo5+txRPXmyP+CShl9RHaVYeGT2fwyfuG212WuFyuXTKllXZ+stpv7T46eT4qmle3IiyaEUk1XHzlg6haVI39yI3W4i0wiYgq8NTil01CuEqq3OAsD+7xDcBprYpZ8/Asylu3nP3ss8LHY4pUjKrUXkhI663hlzNoStMbg2oGJLrvSKIbtptXM0ASYAp27kT94SVKJvRE54Pc+K8w9jBw4v7suGrim76YhIdGriz9uMrnRGTX4qirzN1KI67DgJcNEiaDoDPk1W3TwufRCE67YwUBiIF5lY3J2QVGooQbh06XP5GkXv0pWATwHEe3qCQjMw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:14:05 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:14:05 +0000
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
Subject: RE: [PATCH v4 16/27] vfio/cxl: Shadow the CXL DVSEC body at open
Thread-Topic: [PATCH v4 16/27] vfio/cxl: Shadow the CXL DVSEC body at open
Thread-Index: AQHdKwe5eSNhlPdrf0+qc+ndTFJGYrazqGmAgAkEDLA=
Date: Thu, 3 Sep 2026 10:14:05 +0000
Message-ID:
 <IA1PR12MB90307EE95CE063A75CAEF801BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-17-mhonap@nvidia.com>
 <20260828090935.719115e9@shazbot.org>
In-Reply-To: <20260828090935.719115e9@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: 6f84723e-91da-42bb-e031-08df09a415e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 e0cyHlWX3Bilw0n6Mr7v6aSR68WwMeWW9zjlGawx/Dvm9hfznV1oahTVdIBdOmZAWLdU6GClln7hRqU7BJz0M3anTybdpsjzE8LqnhvvG61OJpuLQwl+RxGURvpfsEmeZKo65BIVVAt9IZcpTRiHLmjf+7d/InQZNEJ7uon2y9mHzXds+GxfMOK/mg2LVU3nttkoSjlIVVtSGv8S002RfBPDRUJtsYFSeLg9ag/4XEjuaoQVonDz3XmXNxwP4OSivXCXQT9oIIMixTD00TTJW2L2/ZmQ1UYSLhHzY0vR2RMSb1l/xd6dRFR2Nq9L5jPDPcmdJWory9buJixOmS4umxFHVVxcFDp2+fVcUDkuM4XT8pdjXN3c2eBtuGa9ZcbGZX/H6GwhhK4MAkX0kVxWzhsmjohv0dSi4iCtPqKj2T70VkFHblDZmI/0IMEDqh5zf9lkgZAjJi0lCV4D3fp32MVI/NgxbUzg6zMS0EUj0xHb/G2PV9psF114hkqGJp9A6GtndbjDLUQbPXdlWSwUnea15MU+rvHYZwWNWlayYMP6gqT40M1o54emTcQz6JEG4Jl9RFdlAqqRAttvYGMk9eAYCQYlfwx7IOXJa3NUh7uWR/h9VQdehn3QoKryfGvhgZq0DaIHLR00ynkXKO/mwhepzXGmcs1jkWgr0xPE05sacQ22qtaZ1AKFBwRFo1mEPH/xzk01oBySDfWsEXyqFwjX/tJ1lPKwkcaOsuvlZqA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wMY535NjO02pJlc9WiAmRMABB1qAqOMSUDkW/k4FuANrrRImkNyvBUQdce83?=
 =?us-ascii?Q?L1zpsRyfzTxiFTIfiY8XYgUSF8E4VaaTEEG3xchjZdVianIbG9KyOfWpf2Nw?=
 =?us-ascii?Q?0zvDkEb3bNPWMeGoyv5MFeq+tgWznfSh9ZMsWc0nZ/Qn2XCpD37QI2IgmZc+?=
 =?us-ascii?Q?9GpiGmvhEEDVss+lhcfWCx4gBNqgBoanXj1EN710QiZqr+JNDyglch4emSF9?=
 =?us-ascii?Q?3cEUoLR3kdmYz9LClLGUox4w26Rvu6xBbdMKp3U3o1ysManw+yxn+xIkrkJX?=
 =?us-ascii?Q?qzLyMMr5wPrsKtoUejFW3f/Oam2CnLl/nE46vYla0qfY7leUJvGXHGPv9UFx?=
 =?us-ascii?Q?dm8UA80Ad8nYrD/55ivsosmlW+u78eHTGgYUkcf3ZEVewrrcfcxGb7sSyBLd?=
 =?us-ascii?Q?cRJnMT/9W3hxGuLUBkTdGL0QT/FOVykxpCIFRsx4CANbYPRZdEWQB6a/iyXq?=
 =?us-ascii?Q?v+2biVp6PNLfeJVW80l0rWhKodmLNoTe1/bIy0SQJWa5LQp5BIgdQscnEoYU?=
 =?us-ascii?Q?QGEt4w0k3pLqen5gCJ/tg4VUJlIGRulUJ53IPv0tyCm1P22DQk0ldrkKq6v5?=
 =?us-ascii?Q?IzT5C9qmwFCXPlfq6B5zXnUGG8sLGXoh6kCTSqOh4LyI/+C9/ZNK2S0AeoZd?=
 =?us-ascii?Q?h6gRprZGkRGe7v5fzs+L0fuDbIOVsKl8UM2XhR7F1Fx4HK3HFuALFLYqiS0Y?=
 =?us-ascii?Q?vgyeVUuMu8XPslV+XZON4k4ohFrQafKD6kLLgt2+g8tElNIBCekbUjc5kzAA?=
 =?us-ascii?Q?KacXNVmQMPb5i4ZkvCIGc4bmczqoLNH/26sGYM8mnvxdiu1mwJXy50f5Yv2v?=
 =?us-ascii?Q?u30KExzNaqljuibtJLbuPhtsH08JJgpArunoTU9cQZYuNrYOG/quPwheidwK?=
 =?us-ascii?Q?jNXGivFl1tsGoTFC2BEaizmOIwgXbVp4ZDU/ZeL2ZbGpxw33ZBlgdg8efzO0?=
 =?us-ascii?Q?PorWqM4ZzFEg2B4ynNIi1Sfn7SA0fWkP+UbQLOoyE3JN9DhcVkOd4xcoybCf?=
 =?us-ascii?Q?PGKZrT4+4dX9iKozKmvtVCHiJCgGduNmcwe5D670/LPGlzphqTKGGm16nWJv?=
 =?us-ascii?Q?OfV4GdT8pvAriN58OR3O34g6frym4rmHyGu8nI3QoALIPOU6G4KYJ984NNoX?=
 =?us-ascii?Q?+xthfokQgIVIL0vKm0Y6PP5vbyQcZaHITrV3UUAsDBVaHlEtGdcvy5sX2KVQ?=
 =?us-ascii?Q?TzlDJ1IS+XH5glc4Ch/K6OBhMpr92Iy9i1LrZp3a/Y/9hLVaA++VlcwCf5rw?=
 =?us-ascii?Q?ELPXp7XdsgM1jhFKFs3BvDyJ5hVPnmDznaH60FwNCSaP8xSB0dsrElzrmogt?=
 =?us-ascii?Q?G91eerTlNRwGrqVXN1qj37BNoLJcLb0PmSM3JmBt8HtJNqyUfH/sShEhjvDl?=
 =?us-ascii?Q?XyP0gm4Ey/H35L+HlqJGZWGLIGLXhsqxnhUtplKTULOIvBCkypo+SgQDlrhC?=
 =?us-ascii?Q?h8YIS8TjhF8VaEXUY44JGXnpGU0GGf2m+YUq1W8zF4sqnQdfr4+4b+KAljhc?=
 =?us-ascii?Q?aO64y45Ao0Y5QHx2gzqIK1KcZ+yi+BFdkqGdMEKRhuMLQ15xWjrfaP5uuOeh?=
 =?us-ascii?Q?Pg8cpiEG2V0RkM9NORU+r4pdJDCSh+a2ahZ5Jx11sfCM0hspMmXCdAB7aZL/?=
 =?us-ascii?Q?pTI4TK2SzyBhhJ0zHhHWt+w8yrB6hxj5kA/kmuiBczYaifImErBXvaAxsWQu?=
 =?us-ascii?Q?ep89xZYPD3DACxWxNjr3W8id60UwAFzUiRlB7d6mZ0xEAgFR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f84723e-91da-42bb-e031-08df09a415e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:14:05.6151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okKxlorSq71iybUXhiHH4CW3jYf0wMmPlUYchB7vw5tsd531xESb4/FBnDzoO9M48beckuV8AhbCr9/MzIUE5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, August 28, 2026 8:40 PM
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
> Subject: Re: [PATCH v4 16/27] vfio/cxl: Shadow the CXL DVSEC body at open
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:20 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Sample the CXL DVSEC body into a per-open shadow when the guest opens
> > the device, and free it at close. Reading it here rather than at bind
> > picks up any change from a low-power transition, and gives the DVSEC
> > access handler added next a per-tenant copy to serve from.
> >
> > Annotate the shadow with __counted_by_ptr(dvsec_dwords) so its
> > accesses are bounds-checked against the recorded dword count.
>=20
> It would be useful to describe why we want to shadow the DVSEC capability
> here.  Also, it's the whole DVSEC capability, not just the body.  We're a=
gain
> mentioning that low power transition that the earlier path prevented (but
> shouldn't have).
>=20
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 39
> > ++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index d19fd638f538..2e516a0929c6 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/range.h>
> > +#include <linux/slab.h>
> >  #include <linux/vfio_pci_core.h>
> >  #include <cxl/cxl.h>
> >  #include <cxl/pci.h>
> > @@ -17,11 +18,19 @@
> >   * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create(=
)
> >   * @cxlmd: memory device joined to the CXL topology at bind
> >   * @hpa_range: host physical range of the HDM region
> > + * @dvsec: CXL device DVSEC config-space offset
> > + * @dvsec_len: length of the DVSEC body
>=20
> Nit, not just the DVSEC body.
>=20
> > + * @dvsec_dwords: dword count of @dvsec_shadow
> > + * @dvsec_shadow: guest view of the CXL DVSEC body, sampled at open
> >   */
> >  struct vfio_cxl_state {
> >       struct cxl_dev_state cxlds;
> >       struct cxl_memdev *cxlmd;
> >       struct range hpa_range;
> > +     u16 dvsec;
> > +     u32 dvsec_len;
> > +     u32 dvsec_dwords;
> > +     u32 *dvsec_shadow __counted_by_ptr(dvsec_dwords);
>=20
> dvsec_len is bound by PCI_DVSEC_HEADER1_LEN, which is 12-bits, so it fits
> comfortably in a u16.  dvsec_dwords is therefore bound at 10-bits.
> Both of these fit comfortably in u16.  I'd argue that length is easily de=
rived from
> dwords, but we end up with a hole in the data structure regardless, so it=
's
> arguably useful to keep both.  We can drop 4-bytes from the structure tho=
ugh,
> which actually turns into an 8-byte savings with the two holes above (2 +=
 4) vs
> one hole below (2):
>=20
>         u16 dvsec;
>         u16 dvsec_len;
>         u16 dvsec_dwords;
>         u32 *dvsec_shadow __counted_by_ptr(dvsec_dwords);
>=20
> >  };
> >
> >  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev) @@
> > -71,6 +80,8 @@ static int vfio_cxl_init_device(struct vfio_pci_core_dev=
ice
> *vdev)
> >       if (!cxl)
> >               return -ENOMEM;
> >
> > +     cxl->dvsec =3D dvsec;
> > +
> >       /*
> >        * vfio-pci requests the whole component BAR when the guest opens=
 the
> >        * device. Declare the BAR owned so the CXL core maps the
> > HDM/RAS @@ -102,11 +113,39 @@ static void
> > vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
> >
> >  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)  {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     u32 hdr, *shadow;
> > +     int i, dwords;
> > +
> > +     /*
> > +      * Sample the DVSEC body now rather than at bind: a low-power
> > +      * transition could have changed it since the device was bound.
> > +      */
> > +     pci_read_config_dword(pdev, cxl->dvsec + PCI_DVSEC_HEADER1, &hdr)=
;
> > +     cxl->dvsec_len =3D PCI_DVSEC_HEADER1_LEN(hdr);
> > +     dwords =3D cxl->dvsec_len / sizeof(u32);
> > +
> > +     shadow =3D kcalloc(dwords, sizeof(u32), GFP_KERNEL);
> > +     if (!shadow)
> > +             return -ENOMEM;
>=20
> dvsec_len becomes inconsistent with the other fields if we take this retu=
rn.
>=20
> > +
> > +     for (i =3D 0; i < dwords; i++)
> > +             pci_read_config_dword(pdev, cxl->dvsec + i * sizeof(u32),
> > +                                   &shadow[i]);
> > +
> > +     cxl->dvsec_dwords =3D dwords;
> > +     cxl->dvsec_shadow =3D shadow;
> > +
> >       return 0;
> >  }
> >
> >  static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
> > {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +
> > +     kfree(cxl->dvsec_shadow);
> > +     cxl->dvsec_shadow =3D NULL;
>=20
> This makes the counted-by field inconsistent.  All fields should be clear=
ed.
> Thanks,
>=20
> Alex

With the DVSEC handled in vfio_pci_config.c on top of vconfig (patch 17), t=
here is no
separate shadow to set up. I will assess whether I can drop this patch enti=
rely.

Manish
>=20
> >  }
> >
> >  static const struct vfio_cxl_ops vfio_cxl_ops =3D {

