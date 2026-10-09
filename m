Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B74418E4;
	Fri,  9 Oct 2026 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526511; cv=fail; b=ooom9RH72/EVvTQE1h7CulCf1BsiTneisK9+MRNEPxpqjJplmU5rh+01nMCwOWqr93G6VyHC/vdu7lvhZFnC/j0qwoZrTlYRpT1d9vFRpbtYT0iHD7W1B17i8E6AyqXOOK+9nMbZdA62WYDBiOEzzK5Wy9Vct6PRCLo0XfzTSGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526511; c=relaxed/simple;
	bh=lkM4mJJp00HByGGf3DRAflHueCE5Ickaq/i+IML812k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hso3FjqH+N4B0CIzoBz+qw5a7hWY9/h+aJrCI6GwqLvvEUIbLMlQWqaqs8gx2M0WUlaOYGGb9XFOYIt8MRNkZ1RXrUZTlKUlc0PYQmvx8rXcYJifvTykt0C1EVWZIpflh952lIuuxb7athXp8E/YBWESj/DlAvjNZZNfda7FVk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A+Eebezc; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A+Eebezc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogOeUnxWAgTY+gG3ascsTSdyMK0YMOUJ5r/tl4lbj2omf6t8qiKkuV6Q4zWyXYvbGlaMLzSqwg14beTwUIxNPoLht394fD0OE891MDsR1InRjxRitj7l67vECKuCXgoshr/OkFFLWVB9vVMzgcnREKJ5dafOAjV1F5YZaAKioDg6ka6VwuP+qcggjhXK2svn2ImxsC/OZ5bcq3RQlbzUQN26/VLTzTgeMzA6s2UbZKBhmT4ly+UC5YnBeGa5WDTG3riXay8Kubks1NVMoWSRAvuKY3E8h73TDREfvGfbr7AEXTpTDOZIagwVMWLu14Q1gSqaCevvZfaFESC7AYeBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+hsszxJZQomDDYqeSzdcpxWWQPTRfnBXcNevvm9u98=;
 b=d4UvChORQMh2sA0tCVVfK9xv1gk8Xp9U4Vm8cE5LMI3yiZpHKUf9PKSHh3Qn+rZ9J2o4D/2GYbjJ9eHABkyZ7j4FuiKDHH5fRV53AOqQMnm5KvhSXwQmcTSppPh/mhs/69sDS0wliUd/KI8W4i/lwnz8q7nGH4hevIehP87OybCBSgZB9kbhT/6x4DaqYnLbHbRQCfVViZvQU73e/cTa9gcQQuvP/OVoT4MLMF7jEEDQ652AkkYQ5IbDVgQGoiEH6yDMmUPu3Ud7sYAi0VPmfXTTIIExc8CNpuwzSWTpQ6BydBuAnpcg6RirbHPDwb0QEsczqz4r/hibRam2BiS15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+hsszxJZQomDDYqeSzdcpxWWQPTRfnBXcNevvm9u98=;
 b=A+EebezcMbQ3lA+4nnLwud+vYIM6b1Q+Jx+a8ipdixM30NwW1hQZ4fJyHwYSVB7Kdndlvla2E/qxhQi1jG3W0YhOAQHkgzUNt44HQ1Yuz+GrLsMNLjiDvhpBi770AumAI4z0LuFAI0/ru6rVVhJgTjcTM82FN2EJc6T3WHpbcv8FCJ6gnw3bn0Pmu2NNoL+OEpKeEYpBDqG1NGr6GuTvGJM28X5it5n0RHwMIwjCF4iepJS4YQX6bi8ouL+B96lxNqB1r2riZAQs0Jg9RxhisUyr36Kx1N0Jr2lhSZneS1EG18kA7LKGNodW/OU/zRCnxtorKHJvp8kIhrlp/JQELQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:15:02 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:15:01 +0000
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
Subject: RE: [PATCH v5 11/27] vfio/pci: Virtualize the CXL DVSEC in
 vfio_pci_config.c
Thread-Topic: [PATCH v5 11/27] vfio/pci: Virtualize the CXL DVSEC in
 vfio_pci_config.c
Thread-Index: AQHdRgqNmrGQcovvtU6hjipjYSD3Fbbf6riAgBTx9QA=
Date: Fri, 9 Oct 2026 06:15:01 +0000
Message-ID:
 <IA1PR12MB90309DB5F8BEF05759BF606CBD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-12-mhonap@nvidia.com>
 <20260925231541.492d5407@jic23-hlaptop>
In-Reply-To: <20260925231541.492d5407@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 22469a7b-ddd1-4a38-0a2c-08df25cca738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 sXJLWtK9PuZdvD8gsQUB8Jzrb/3TjtYSaXm1vwtv+JVT4UHB/U6oT5XGicMz6uLJcOD5IDbfsi491sN24wWyFRal0qfAKIINX+4mUM3mFbDr/07P17BZ8DsuKjuGpVoBhGIFi5CyQGVOQVFVf0vKJqZ3ZHAMn/uOKmbfc81mdHuftc8PGB1gyxINL2JB63EvFN0jBg4ZtSFNcI1SeFA1f55FEiSbSe+HjCTQEBEZ7qycWAHPwagX1D4UqB0LKrZRdF4SWJJJraQSDoydUXitPqPVqLTuBEUhb1tEkJZgXfVkIJ9y5OT3Crpe1OenvgiH99xutF9OmI74u8tV4z682y4Rguo9j+Z5T4Yz1p9DCSpQwV1pfnYhwO7+nZOWBAesHwALDFz0K/Rk2AhTt4YEsNTsZoTBasQu7dLmw4XNp2PxlQKbvFRLOVTG2c962MUA96ij3iDO11CKg+mwECsheCoi5Tm92orU5y+ciUl7lA3pbCQaKpGHMK2vZvhZpSOrglS2sSihozTUbRBc2C4VNDiG4l8cLxM4UwmCkCGBhzFFcDmOuTLgaziCIMfHFEN9RTEBoAnqBd9DpsnUV2VwTZqxh6r4Rh0NkvtTWmHUGe/c/u09wbi7dkaOZawUaBLuzZ0bM2/K4r9h0Ozysr2tN/9aXIgoQSRfCSMMTxQ81NUS83ZmDh969Jt5GwpNJlFo8b/DfdeyMkwSAT+Jyzh+Jfcf79sgrIb0MfvcT0erw0w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Kw+9TQoxrmq/lvmwrrAjz8ZNkPw6HQ1Ve55uoyhdnqV8USD4qqzRVLnMCkIF?=
 =?us-ascii?Q?JHeYOvd6eGnZ7sBi9eywKiM05lwlP/6jFgRmcMjR8/+JdDVcJviplYB85plJ?=
 =?us-ascii?Q?TmM3qI+ZQH2z6Hkj0SmJ7nA/opWKDdjFy0gLHEA1Tx/1K5Tu0ccMQNx/rnlG?=
 =?us-ascii?Q?vDt3RaBgAO59e64oNM2A0zfrgq97Ld/Qrb0PsSkFhmEgPIPqR1mPrplh0Vv/?=
 =?us-ascii?Q?X8ivBVC33Z+5bQuwUrw1SSDqvH9oq+wui73HyueDG8mULsmD9I56spkn6vZv?=
 =?us-ascii?Q?0J78voNGautykQQvahgfzKnEMGrpwLbuj/8ur7kfn8pxZOUEZOSfOpzDFuef?=
 =?us-ascii?Q?ecJ+RdggLr2ZO0omu5zlmOw6vDe++EvDG7zNpPrWTrI5CtHQxbSJFhxpTksv?=
 =?us-ascii?Q?FBxQkY2rvL1A26jypDLqP4znfPtnlAR3BWQBZ9zUX/HKs/Ae7OiwjbP1kd2S?=
 =?us-ascii?Q?2d1Hpm9p7731+PfcyBEjTqOMDCxhlUO1he9I8E+Pccr/xpdiztpK+/wXXd+X?=
 =?us-ascii?Q?rLufFgg7RjOmaQpcCoVCsqPqIxJ/V20J//qrT+FZ8mFRRc1H5QjSeER12lQU?=
 =?us-ascii?Q?mfxwSW3qUmiIcJhAPtxIytRfWLxWhpX+Ree3jGig1c40QPVbJtKOZEjy6LQe?=
 =?us-ascii?Q?2hekdd0GYJw8i61vDeN78dQsiauXYyFMdnz6FHdL2blQZppj5/rysiCJ7FcS?=
 =?us-ascii?Q?n2pPpN7ToWa/IAOYnrLtUsyI+p5cCTup3K0CR/QuCq8hwqLuXLX5dMigHPA5?=
 =?us-ascii?Q?0Q7YvKA37Cbqsjm3/r4we9h/ml7/AS+xGvI8Kh3ZNlnwt2870GIFIfInwNC0?=
 =?us-ascii?Q?sWqOI+ZnAK1SE9HIxkDyf81Zhmv+hXvqNYb+EF0k4toz4GLx59lVP9ocW8nN?=
 =?us-ascii?Q?bAJGAovWByjMqEws/0Wu6yDzLtwGVzsOcBx50V2LdFkaEsE22GVKxJ7RidSk?=
 =?us-ascii?Q?MpSxeOUI0jBnyl3Z5oYmVu6zHifKjqtp/RV5Oh2W2cX0QAUG9fWOyVD34dVq?=
 =?us-ascii?Q?5zq9Ub/QK0z2UIjYzPL4o+Tv5gNN1VpJqKLX4KTrhF/mKpmCAz19Tmhs9rPU?=
 =?us-ascii?Q?u7NvUnQEvdF0ExVfyudQySz32+PpvtSQoD5pkAEDtdSAjXU6PwUd0V3cS7RI?=
 =?us-ascii?Q?Mh7PKa492A31doutDVjyN7ZgqJb/C0Lfy9xOEo2sceUFcne+e5kMCt07yQ41?=
 =?us-ascii?Q?m6v02JBx4E1kKTBWbNmEkIvF95P0zdZuC59CFGMQiyWfyRerYvQ6doVBIP1U?=
 =?us-ascii?Q?RzJSYL1PoQcUL0M3+78JPk0oGy3k8dYXiNpYEgqi3/PSJbvM0kVyrJVODmyy?=
 =?us-ascii?Q?nRpsXoVVtrj6SoTWI2mLPBD4aDsALnurNvVNnWPT9fmC/dgSWd5WoGMIQGaz?=
 =?us-ascii?Q?do0PhdSZ+w9NbdKGXZWAm+0BIsnq35zlHePJyzEFtHFbx3tFBzztsmU6nlwK?=
 =?us-ascii?Q?lUdQ1oHgHSqrD490RjF7d0NbOsOOPPhK6CPldH+aKPTuPkjB7cNfrUybf1iS?=
 =?us-ascii?Q?hkidwG+/7PNUIWgv9N4tkoIQn68T9Dyu8ou/7YL1nAItBiH73jbgFfuzkvT5?=
 =?us-ascii?Q?ZU3VVk2+U8KGwif0zBzdiq9rXBMbd1Fnnhxwq2GD7k3/5RWJGIwQKf6WeCqg?=
 =?us-ascii?Q?AM2fm/4eTIDv2tSykpjIp9Q+4ij7AsMdAh30D29pgugSG5ieyJBb69f4AMeQ?=
 =?us-ascii?Q?7HkiRGghpz6JZhc05W1KlUS3LwUOLCoH7T2FdfMv1iRIGeY/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22469a7b-ddd1-4a38-0a2c-08df25cca738
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:15:01.8680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQ+5+rEUOGUmp1mYvlL2ut6QrKo5HK60kUnxtfZt3XXz4Fh/D8idIWfsRlkgRz/kUEpRTA2sCXEjGaODrbnXpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, September 26, 2026 3:46 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
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
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: Re: [PATCH v5 11/27] vfio/pci: Virtualize the CXL DVSEC in
> vfio_pci_config.c
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:24 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 device is reprogrammable through its CXL DVSEC: a guest
> > could set Config Lock, toggle CXL.cache and CXL.mem enable, or rewrite
> > the HDM range registers that govern host memory decode. Virtualize the
> > DVSEC so the guest sees a shadow it cannot use to reprogram the hardwar=
e.
> >
> > Build a per-device cxl_perm permission map, modeled on msi_perm, when
> > the device is bound through the CXL provider (e.g. vfio-cxl). The
> > whole CXL DVSEC is served from the vconfig shadow; only Control and
> > Control2 are guest programmable, while Capability, Status, Lock and
> > the Range registers keep their firmware snapshot. A vendor DVSEC on
> > the same device is
> > unaffected: the map is selected only for the CXL DVSEC offset.
> >
> > Control2 carries the CXL reset and cache write-back-invalidate
> > initiate bits as self-clearing doorbells. vfio never forwards them to
> > hardware, so a custom writefn synthesizes their completion in the
> > shadow: the initiate bit self-clears and the matching Status2 bit
> > (Cache Invalid or Reset Done) is set, so a guest following the spec
> > reset sequence (INIT_CACHE_WBI, poll Cache Invalid, INIT_CXL_RST, poll
> > Reset Done) progresses instead of timing out. The host performs the
> > real cache write-back and reset at the vfio reset points.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> A few minor comments inline.
>=20
> J
> > ---
> >  drivers/vfio/pci/vfio_pci_config.c | 132
> ++++++++++++++++++++++++++++-
> >  include/linux/vfio_pci_core.h      |   3 +
> >  2 files changed, 133 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
> > index 9914f3ac69ae..9a020a768055 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
>=20
> > +
> > +static int init_cxl_dvsec_perm(struct perm_bits *perm, int len) {
> > +     int i;
> > +
> > +     if (alloc_perm_bits(perm, len))
> > +             return -ENOMEM;
> > +
> > +     perm->writefn =3D vfio_cxl_dvsec_write;
> > +
> > +     /* Serve the whole CXL DVSEC from the shadow. */
> > +     for (i =3D 0; i < len; i++)
>         for (int i =3D 0;
>=20
> Is mostly acceptable in the kernel these days and keeps the scope tightly
> defined.

Okay, I will add this.

>=20
> > +             p_setb(perm, i, (u8)ALL_VIRT, NO_WRITE);
> > +
> > +     /*
> > +      * Control and Control2 are guest programmable; Capability, Statu=
s,
> > +      * Lock and the Range registers keep their firmware snapshot, so =
the
> > +      * guest cannot set Config Lock or rewrite the capability and ran=
ges.
> > +      */
> > +     p_setw(perm, PCI_DVSEC_CXL_CTRL, (u16)ALL_VIRT, (u16)ALL_WRITE);
> > +     p_setw(perm, PCI_DVSEC_CXL_CTRL2, (u16)ALL_VIRT,
> > + (u16)ALL_WRITE);
> > +
> > +     return 0;
> > +}
> > +
> > +/* Virtualize the CXL DVSEC so a guest cannot reprogram the device
> > +through it. */ static int vfio_cxl_dvsec_init(struct
> > +vfio_pci_core_device *vdev) {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     u32 dword;
> > +     u16 dvsec;
> > +     int len, ret;
> > +
> > +     dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +                                       PCI_DVSEC_CXL_DEVICE);
> > +     if (!dvsec)
> > +             return 0;
> > +
> > +     ret =3D pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1,
> &dword);
> > +     if (ret)
> > +             return pcibios_err_to_errno(ret);
> > +     len =3D PCI_DVSEC_HEADER1_LEN(dword);
> > +
> > +     /*
> > +      * The virtualization writes fixed DVSEC offsets up to Status2 (t=
he reset
> > +      * doorbell stamps it). A device that reports a shorter DVSEC is =
not a
> > +      * usable Type-2 function; leave it as plain vfio-pci rather than=
 index the
> > +      * device-length-sized perm allocation past its end.
> > +      */
> > +     if (len < PCI_DVSEC_CXL_STATUS2 + 2)
> > +             return 0;
> > +
> > +     vdev->cxl_perm =3D kmalloc_obj(struct perm_bits,
> > + GFP_KERNEL_ACCOUNT);
>=20
> I'd use *vdev->cxl_perm instead of struct perm_bits just because that sav=
es
> anyone checking types.

Okay, I will update this in v6.

>=20
> > +     if (!vdev->cxl_perm)
> > +             return -ENOMEM;
> > +
> > +     ret =3D init_cxl_dvsec_perm(vdev->cxl_perm, len);
> > +     if (ret) {
> > +             kfree(vdev->cxl_perm);
> > +             vdev->cxl_perm =3D NULL;
> > +             return ret;
> > +     }
> > +
> > +     vdev->cxl_dvsec =3D dvsec;
> > +     vdev->cxl_dvsec_len =3D len;
> > +
> > +     return 0;
> > +}
> > +
> >  int vfio_config_init(struct vfio_pci_core_device *vdev)  {
> >       struct pci_dev *pdev =3D vdev->pdev; @@ -1842,6 +1955,12 @@ int
> > vfio_config_init(struct vfio_pci_core_device *vdev)
> >       if (ret)
> >               goto out;
> >
> > +     if (vdev->cxl_ops) {
> > +             ret =3D vfio_cxl_dvsec_init(vdev);
> > +             if (ret)
> > +                     goto out;
> > +     }
> > +
> >       return 0;
> >
> >  out:
> > @@ -1863,6 +1982,12 @@ void vfio_config_free(struct
> vfio_pci_core_device *vdev)
> >               kfree(vdev->msi_perm);
> >               vdev->msi_perm =3D NULL;
> >       }
> > +     if (vdev->cxl_perm) {
> > +             free_perm_bits(vdev->cxl_perm);
> > +             kfree(vdev->cxl_perm);
> > +             vdev->cxl_perm =3D NULL;
> > +             vdev->cxl_dvsec =3D 0;
>=20
> I'd define a vfio_cxl_dvsec_exit() or _unint() for this so it is clear it=
 pairs with
> vfio_cxl_dvsec_init() above.

Ack. Alex pointed out that cxl_dvsec_len is unused, so the exit helper clea=
rs only
cxl_perm and cxl_dvsec.

>=20
>=20
> > +     }
> >  }
> >
> >  /*
> > @@ -1926,12 +2051,15 @@ ssize_t vfio_pci_config_rw_single(struct
> vfio_pci_core_device *vdev,
> >                        * of the extended capability list.  Use default,=
 ro
> >                        * access, which will virtualize the id and next =
values.
> >                        */
> > +                     cap_start =3D vfio_find_cap_start(vdev, *ppos);
> > +
> >                       if (cap_id > PCI_EXT_CAP_ID_MAX)
> >                               perm =3D &direct_ro_perms;
> > +                     else if (cap_id =3D=3D PCI_EXT_CAP_ID_DVSEC && vd=
ev->cxl_perm
> &&
> > +                              cap_start =3D=3D vdev->cxl_dvsec)
>=20
> If it is only used here (I haven't read on in series)
>                                  vfio_find_cap_start(vdev, *ppos) =3D=3D =
vdev->cxl_dvsec) seems
> fine to me.  It's only just over 80 chars and hopeful this bit of the ker=
nel is
> flexible on that!

cap_start is also used after the branch for the offset into the capability.
I will keep the variable in v6.

>=20
> > +                             perm =3D vdev->cxl_perm;
> >                       else
> >                               perm =3D &ecap_perms[cap_id];
> > -
> > -                     cap_start =3D vfio_find_cap_start(vdev, *ppos);
> >               } else {
> >                       WARN_ON(cap_id > PCI_CAP_ID_MAX);
> >

