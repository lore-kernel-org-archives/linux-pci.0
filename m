Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26F39E6EB;
	Thu,  3 Sep 2026 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430278; cv=fail; b=DQTtrAeiWxc6ehzCdtEEIoE8KJH8xMuWutK0t02UUDoqAbMPBMbQnFmEeweXILJB04owrJyM7tQmgVIO2wMW+HH+P8v4Ko2VmAFPBcw2knGS5dP5d6g54fiv3fao2wLEyqbcjmS3uWbjLPUtH2GmBMt1Qfcfbzc55TDjltLsHeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430278; c=relaxed/simple;
	bh=nWoBiNjfbEaapn3YTvIV4Fv8ffmbrccBQbFRVs/lidI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QwSs1823kYafR31nNIWgtoFpesRTMaup+Mw3PXZ6C8HhZnhDG/LE+EhC9kIb9dtAYHu4lR9C97WsVQVFARYOfD+7M6AfC+ucvx3h/sjHHCcaeOoqCOhdZnVxuf4WnXBS2LD6kg6IpZa7P5tveyiXoxJTl0IXYuwTXPolnHQ0V/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jcXHLCCe; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jcXHLCCe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRVnP7P9pAaZZWaEv1+O3CtNumsuWm30FEyDCHKHuF+Z+H4O+GuubJFdu0LXERCAsCqZgzSUBt0eTN1/lgNgIUtB7KXehQR+zdzUdWe9M9LQ0CxpsSePQD0fVKYbtCQnU5Ctc/YlNDks8YbzFj0cJzWthgX2lkZl77gCRroRscwaRDmzlWwt8Im3IOYbztcdL5ZMe2e7/N71NMkeTKQosennsRyHMgIpSNQxg9VElTdg/xpbqiq0vfRnxNzGSo87XJhfeNOVllevsEopClrT+6DiQH6HppfXSV0NDbXpaLHI3zTJ6+hoHZYK3/GuSwACeZxNSj2LwwqBpYbA4kVuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7u9ZDl5CGQQS/tr76Gl3+8+PslvqjwQRp2rqvf9554=;
 b=GuFoaYWI4J64SfqSyXFafcwn6dscOI7sDWXd4A27+7bVdjhmG9YNLYU/2wghzK4DH95ab7yZQLc/j2RtnLt8IkebCz9XmvLnxO8OLwaIH7sEqlc77UpUKuUKYaW6vt2at+V76go4t5QRj7wdup7fJMrx1MNJ2VKSeiifZ1DpTkBfqf31B4Iz+D7xlmjyZfSqt9CWgXN3M1rpintsjQi15bnzoQAxa2Yis2ieJlgAF4VzFjYRAR28dAJZkEJa3D9tkt0Vh3j+m+HTT2M8vI4RVi4gaCl+PQETL3aswCtGPyiNBvzFlOcTUOGxYw6qUajLqC6BvkdWzlyzyRwTWJvi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7u9ZDl5CGQQS/tr76Gl3+8+PslvqjwQRp2rqvf9554=;
 b=jcXHLCCe7tHi/7HCohSCbb44czxmGtTmjqzxfX+WXYYrH5jE/VpwbufXaYVel8p0e39gIDNPBEhYYW6n7IwYdEssVQ9ItHWCmAG1m83epuwKDswYiHI8hHtu8tOGtQteYqpvcpJI+N7zCM162atNtto/wFKBpV6/8vt33Oz4rfrTTQxc56VA3dYAolJIXuVm83DEmAEz/NVSbtZC8yHWETDGo4v5qVYuLbBO+/IhNdfEdz7PhfsrmHtXx9TkjezigIezvXgHh2qIIdy0GElV4YxEI2b4j3G35H3e3l/BO7guPHGO503HaiopYN+ayDAgdJgZ6OxqiMtri+FlPVnKrA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:11:05 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:11:05 +0000
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
Subject: RE: [PATCH v4 08/27] vfio/cxl: Add the vfio-cxl module skeleton
Thread-Topic: [PATCH v4 08/27] vfio/cxl: Add the vfio-cxl module skeleton
Thread-Index: AQHdKweLPmMaBQj+80C+38PqKdi5FLaxBIuAgAuIhcA=
Date: Thu, 3 Sep 2026 10:11:05 +0000
Message-ID:
 <IA1PR12MB90304BAC83A1310AA8348E22BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-9-mhonap@nvidia.com>
 <20260826165033.582735f4@shazbot.org>
In-Reply-To: <20260826165033.582735f4@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: 002af77d-d251-4736-fdd5-08df09a3aa4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 zW5l49Qq3qR/8acbPQs4QXj7LopiQ7wrouuK3fx2fXi/PKbz4RYq55BSgxj84x/kbLg41tGn2IXLxFDHxBJ14TJRlJINM5qal5qhZLiOdwzySvkVXV+bDSk81Exkq6GaQNqOVWWB1AW3pleBTFyEiy0uuHI1cRhaeDE0Ep9yhKScNQJ6ser6Pw8a4UAwHK9GrYpa2mQ8aV+cUWy20Xei7NxH7zFtNGfr/det7U1C0s9xHp2nGc6ZILGKma+Rd5cQJunJ5NACON9xBPbe7RS7c5UClfoqnqax6M4HIpmfjRsF0CyWfhUBO7/hOAdVGAhfZUqJgWOVgGvcTOWg4z4nMoVsLBOmMfr0OMGbAC6j6EQFQI43XJ/Z/gjvnrrdoUirfwPo2oaHrdWpgBKUp/urg8+Mqvvr8j9x/4bK0tRZTilONGTgwqQXnAcdb/67LmqTZVBOjq3rYNvg+HQbuTCVim9zShG3YSafQhHstb9jxUtXg+p1FE4jrVXP+3hjSrtAOnX/ZUP3NTqjdP1pWR8Hdxt2xBXMKYtGXaZ0PKTeEj/0SnKDJwxmtYlpNzwCKD+bK71VZ8R71gJlPIQbV8au1ibyRgpOx7Qhy0WMVdoyg3aM7FNkvc+PfW0lKqPmPPZc3kohjCZpfXryKAsvX6vKUQKwhGrxOEcdALEnOOIkhEEyex589r5+as2XC5svbw19Sp1fzbjIqfgNal28VgDEhVFHjRSZ0ZYIXnM9ExWacLM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3Lr8kR9eTv6m5VxoI8pEcPusqp/7brMdhak09rqRoA3Ts98RQnXmogr5KfO0?=
 =?us-ascii?Q?WWynrvV6j+d/DXKFYPNgH1llNotlbnjBUQi2BQ60ExLslhwXvQOti1RCJHge?=
 =?us-ascii?Q?KS+MQN04mLdS8od8TBhO+kQ7jFeq7QNmeHUDZn2lQv4Ux93DCZGgRNsptUuM?=
 =?us-ascii?Q?sfdXkKLppb+xBVxrDxf7fJJfLDxzh/7MZxsjKeZmWINkGbtJ/GoDMBA71Z/q?=
 =?us-ascii?Q?tvxYeZ78lb7FUJoVRseyEur+9PMq7MWRNPNrakE0YrtOw8rZUD/OJU/JbMnD?=
 =?us-ascii?Q?2EBiQv2Cware6Gbtq/H3V6SCyaBdbi8/lyf5XOQ2V/dj5xA96j9sQiT+e2fV?=
 =?us-ascii?Q?2AYdRpZuJW58enb5Ryy7qJM1DJRz+YIOIjBncRQRXRfLpy1iFp1GUvV+gf8C?=
 =?us-ascii?Q?tG8U4HZRFSbT6ZYTpW43XwddkIV0tDH6rJ06vwPQeuldbSYkp8Ud8sebtFN5?=
 =?us-ascii?Q?GM8NUSR7BUoRuwI9nAUWfv4EHKjtQ1IiLq9ZZxCl6/g3e7MenHhQpQjD4qgK?=
 =?us-ascii?Q?wkAb2oPTyzqixOQHFwTblsWOnZcXkm6q3ZcFkCZUbxjGQwkckIMGgBZT04/+?=
 =?us-ascii?Q?2SIbFDEK2RzG0ubRehaipO73TRYzJL/PfVwtDvCso2xMzIVcOUPQikSQ0Q3m?=
 =?us-ascii?Q?FuzAF+T/3rtj9VIWedB/bXi4WaKCMiCdeH/DABZ20Zgry843xNANRxrLtpFX?=
 =?us-ascii?Q?jZWw0X9h61gbyczHroYne0N1ZEgNmr3KtaOmrbtJJ38THZXc67nLl3zCnBtn?=
 =?us-ascii?Q?VIKHQeld3ElIGHpvM42YcqesgETQp9npVhKhhRc18ZJej0e2YSZ49V0sZDtS?=
 =?us-ascii?Q?kw6EpwR77n7V1LmlrqFjs+L5GE42zDUZdCXGPerwTpREasQNZ6ny32zrxOrQ?=
 =?us-ascii?Q?Ai/HVt75WTsvStPaygSDwQ2z8VF2+7cA4YVyjHN4QuHKBtzQ83Gj3e1MAlHI?=
 =?us-ascii?Q?stzJhVl6hu7aI3vNOiILautbK2nXME3PzwJdpU2F8xkbfJSX+ub4Uq0tUa3h?=
 =?us-ascii?Q?rThlweuG6pHGinkc0xjusv6c7FUN9Uu2rMea8Ar/hcHFjsSBXxZV1PuUxzM/?=
 =?us-ascii?Q?HrYCeruiU13Cw6NFYoJADJ1bcl9QVo2PuTNdZQYsDsuSrXzcFw0xMDUf5YEt?=
 =?us-ascii?Q?I2qXmgA8FnKeso9r1ptBSFP/9NN5S1gtBXD083niFm7xPIdp6ReAG5mcrhaI?=
 =?us-ascii?Q?+uXB7yC9hqU63D+Lgp5DOWc0L1DsMz/Af6EPzlFoPzRqoUsehH2K7K9D1ceG?=
 =?us-ascii?Q?1CuQi0wMN2idtqkqSd+WKWRtJurpa2ujIjPPBHnACQmRKWn+zdefuypFOOB7?=
 =?us-ascii?Q?IVjI3LO14U2GlXffOaXTNjTAY1IqI09Y2j7k5EvQoBvy62/rtduGcZZ/oGig?=
 =?us-ascii?Q?Lu5ya2J0KzvPUuV++AsoM/IRFpOsiNxAXYG4eEPC6yahzDEVZiR2jLurnXjs?=
 =?us-ascii?Q?1kIpBFHsLxqZS2VRNyjLH1L9i/+yo6S1mN3xvWkQ68ObTBj/sXDri8V6qLZM?=
 =?us-ascii?Q?DwIw83+dNrO5kJ0WZu/2yzVFX0a3Zf6Sgns0qRQpr/m5M54Di3cdKhi6tVOh?=
 =?us-ascii?Q?Qko4g87gkHl2qLidL6JVi+eourzSPEAwia3/AABp0j699bVb10URrY2Ok+Db?=
 =?us-ascii?Q?HgqyVLcmnG8Elz3zdcya8ByLDfXwE7E8CErrHfmBDR39h5a8dZU7DpywX6qQ?=
 =?us-ascii?Q?N3nzDfhw63r9OBwyTg2UaBvdLxsHw5flErCYEs/p+yxtd/Bw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 002af77d-d251-4736-fdd5-08df09a3aa4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:11:05.1240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTeagR9BdYwQpC5IpfpRgInAODMs4ZYAYoTE43nqvQiKWvHGlnL5+YQHSuqc9nCO0VneZDXf5yYBhrk4ljAuPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Thursday, August 27, 2026 4:21 AM
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
> Subject: Re: [PATCH v4 08/27] vfio/cxl: Add the vfio-cxl module skeleton
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:12 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Add the vfio-cxl module that vfio-pci loads on demand for CXL Type-2
> > devices. It registers a set of callbacks with vfio-pci-core at
> > module_init and drops them at exit; the callbacks are stubs here and
> > are filled in by later patches.
> >
> > VFIO_CXL depends on CXL_BUS and builds as vfio-cxl.ko, which
> > request_module("vfio-cxl") resolves through MODULE_ALIAS.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  MAINTAINERS                          |  7 +++++
> >  drivers/vfio/pci/Kconfig             |  2 ++
> >  drivers/vfio/pci/Makefile            |  2 ++
> >  drivers/vfio/pci/cxl/Kconfig         | 11 ++++++++
> >  drivers/vfio/pci/cxl/Makefile        |  3 ++
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 41
> > ++++++++++++++++++++++++++++
> >  6 files changed, 66 insertions(+)
> >  create mode 100644 drivers/vfio/pci/cxl/Kconfig  create mode 100644
> > drivers/vfio/pci/cxl/Makefile  create mode 100644
> > drivers/vfio/pci/cxl/vfio_cxl_core.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > c665bf8f1a28..aa8cecbc4cf2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -28312,6 +28312,13 @@ L:   kvm@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/vfio/cdx/*
> >
> > +VFIO CXL DRIVER
> > +M:   Manish Honap <mhonap@nvidia.com>
> > +L:   kvm@vger.kernel.org
> > +L:   linux-cxl@vger.kernel.org
> > +S:   Supported
> > +F:   drivers/vfio/pci/cxl/
> > +
> >  VFIO DRIVER
> >  M:   Alex Williamson <alex@shazbot.org>
> >  L:   kvm@vger.kernel.org
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig index
> > 296bf01e185e..c3f54fc8ccc0 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -70,6 +70,8 @@ source "drivers/vfio/pci/virtio/Kconfig"
> >
> >  source "drivers/vfio/pci/nvgrace-gpu/Kconfig"
> >
> > +source "drivers/vfio/pci/cxl/Kconfig"
> > +
> >  source "drivers/vfio/pci/qat/Kconfig"
> >
> >  source "drivers/vfio/pci/xe/Kconfig"
>=20
> It seems fair to put this above the variant driver Kconfigs rather than b=
ury it
> among them.
>=20
> > diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> > index 6138f1bf241d..c3031070a1f3 100644
> > --- a/drivers/vfio/pci/Makefile
> > +++ b/drivers/vfio/pci/Makefile
> > @@ -21,6 +21,8 @@ obj-$(CONFIG_VIRTIO_VFIO_PCI) +=3D virtio/
> >
> >  obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) +=3D nvgrace-gpu/
> >
> > +obj-$(CONFIG_VFIO_CXL) +=3D cxl/
> > +
> >  obj-$(CONFIG_QAT_VFIO_PCI) +=3D qat/
> >
> >  obj-$(CONFIG_XE_VFIO_PCI) +=3D xe/
>=20
> Here again, cxl is a feature of vfio-pci-core.  I'd promote it to between=
 vfio-pci-
> core and vfio-pci.  The earlier linking also has the benefit that in the =
typical case
> it will be available before the builtin drivers (but keep the deferred lo=
ading
> behavior).  Thanks,

I will move the Kconfig above the variant drivers and the Makefile entry be=
tween
vfio-pci-core and vfio-pci, so it links earlier while keeping the deferred-=
load behavior.

Manish

>=20
> Alex
>=20
> > diff --git a/drivers/vfio/pci/cxl/Kconfig
> > b/drivers/vfio/pci/cxl/Kconfig new file mode 100644 index
> > 000000000000..1392fa4ed15d
> > --- /dev/null
> > +++ b/drivers/vfio/pci/cxl/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0-only config VFIO_CXL
> > +     tristate "VFIO support for CXL Type-2 devices"
> > +     depends on CXL_BUS && CXL_MEM
> > +     select VFIO_PCI_CORE
> > +     help
> > +       Add CXL HDM handling to vfio-pci so a CXL Type-2 device, such a=
s a
> > +       CXL-attached accelerator, can be assigned to a virtual machine.
> > +       vfio-pci loads this module on demand when it binds a CXL device=
.
> > +
> > +       If you don't know what to do here, say N.
> > diff --git a/drivers/vfio/pci/cxl/Makefile
> > b/drivers/vfio/pci/cxl/Makefile new file mode 100644 index
> > 000000000000..8501bf626108
> > --- /dev/null
> > +++ b/drivers/vfio/pci/cxl/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_VFIO_CXL) +=3D vfio-cxl.o
> > +vfio-cxl-y :=3D vfio_cxl_core.o
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > new file mode 100644
> > index 000000000000..cbec7319452c
> > --- /dev/null
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * VFIO support for CXL Type-2 devices.
> > + *
> > + * Copyright (c) 2026 NVIDIA Corporation & Affiliates  */
> > +
> > +#include <linux/module.h>
> > +#include <linux/vfio_pci_core.h>
> > +
> > +static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev) {
> > +     return 0;
> > +}
> > +
> > +static void vfio_cxl_release_device(struct vfio_pci_core_device
> > +*vdev) { }
> > +
> > +static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> > +     .init_device    =3D vfio_cxl_init_device,
> > +     .release_device =3D vfio_cxl_release_device,
> > +     .owner          =3D THIS_MODULE,
> > +};
> > +
> > +static int __init vfio_cxl_init(void) {
> > +     return vfio_pci_core_register_cxl_ops(&vfio_cxl_ops);
> > +}
> > +
> > +static void __exit vfio_cxl_exit(void) {
> > +     vfio_pci_core_unregister_cxl_ops(&vfio_cxl_ops);
> > +}
> > +
> > +module_init(vfio_cxl_init);
> > +module_exit(vfio_cxl_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
> > +MODULE_ALIAS("vfio-cxl");

