Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FE480325;
	Thu,  3 Sep 2026 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430588; cv=fail; b=mYFHjdqJkC5ECKtGcG76/2gDrpeQUzCSgxW/2SkZy2eQ4y94fGDn2m9dsqINfdPfxeItshC1ZYlmavqfYpbhFQBsNihYNrOJWBTmhCNLKZn7WSvn1JV8Co6Y6mC+BkNwDOGWZQL5q6V0toqx9EJO2AsQNUWDn8uNmyomk1fYGTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430588; c=relaxed/simple;
	bh=3VRcHa59YiZtW37OJr0UJJ4L2TDpFK6BZBGcVL/PA0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYbxOvXJFTNnuTkGe5zjxnczT3kZgmwmBZK3NTROA3TbuMcH4//Cy3RWsmZ1EHgOskgjx9n9TmPGC8j9fz+dEX5YY0FTkAvpKtJoaFuUUUT3Orut1JaEXE38IqQiyX/BHuIGYA9TjnssgeBobXAUdqzcFlmENi762PHOd/ztpeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KR/lx/H6; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KR/lx/H6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uC6yAw4tnMiROxXe3ZcaL2Ma6Ndwd3HO2SbB83cDi2IWwL+yAvHqQjwZo+TLuTZAkeJA55u7HstwTV+Nh89RcUoMirn3FQnZg+XndgO/xuxE7Z8vQMFZkveIughzFGbubVPUs9cGeNCJJaIiBaexSKCbTHoL7jIqONgUqbXP2jo+Y/5hcDQ0pWmbAvmu6oB4j40PGHU/IAhaobE6ccMRIQdXXCzPd+8BNakGyWhkLdCrxDQuL82m3ALh2VvI+YQZSBt5jnlVOf5ZGZ9AukenGoTZsj3ea1xm7ygai/5wWpLmfjKPU4cuBOBEfvqA2ooT/ETMXE1jox9uRqZBvGpCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLaWX9Y9RHB6DTyXBcyzLVCWnWCuY+HOhMB9bJc3dd0=;
 b=P5yTKCYqJ+yD3exOxXf+DeTxo1f/IRFMKzYwI+hurdBOJ/MoD9ZNpdICgTvfmAdb5/yTX+EZWLy1CO5812nd+y/Jvum6Z8205fLM26YDiMvg4Ptx4QQFrqZCUVDsY1r+o7myEC9FrwLEZ3bikVwNdfszszHqn06frpH6r1K9Kkbil7RR0EngcoYrEntc3+eGOFfnAKaErfDPyK/CEh5ysNvbrlaOG5WQPEcXlTNizpA4APkIhkVqpo9x7NiLNe7bOhHLvULlmZqRIh6Q2PUfCSQIhnStb/732TyhowcLkXRcHJEnPQw/tuDvkRsiM6+ZFO1HKhcB8s6aDCV3pAcXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLaWX9Y9RHB6DTyXBcyzLVCWnWCuY+HOhMB9bJc3dd0=;
 b=KR/lx/H6R/Pc0dNc9M0V17Vlf8HcoWG+gwOjPlfWAOjbNSSiIdTLy4efuYP9wxTLmnSZrck1Chd5pZQLox2FIgZCFSeS6mKPK+iSPy2Uy0g9FPILJsvI7pmyZwv1lRSynmVy7FfkKAmma6bTIpzMjA1PRgG2ANfN13Nr/fDAlB/p2U6fV8d2M2/3QV7JtCDFqBfu4/vWwvO59ZoXXeHvqxlPwrUBwfSyM8GhESTDIz707NgCc4GZePDWXduYqG52laYVOiQUhEYWQhWN5oRi0DgcW5WJqSsbv57v8M+tFk0YMPcbBnvwDS9FJ6B8Sxo1BL5taX6i1qCfXHxfYlCvRw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:16:05 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:16:05 +0000
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
Subject: RE: [PATCH v4 25/27] vfio/pci: Provide an opt-out for the CXL Type-2
 extensions
Thread-Topic: [PATCH v4 25/27] vfio/pci: Provide an opt-out for the CXL Type-2
 extensions
Thread-Index: AQHdKwfr4GISZAMcQ0OcN0BwTtF47La0Ku+AgAiWMxA=
Date: Thu, 3 Sep 2026 10:16:05 +0000
Message-ID:
 <IA1PR12MB9030ABB798B34C694C626418BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-26-mhonap@nvidia.com>
 <20260828165645.03aed778@shazbot.org>
In-Reply-To: <20260828165645.03aed778@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CY1PR12MB9582:EE_
x-ms-office365-filtering-correlation-id: f2eece16-46a2-46d5-39c0-08df09a45d15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|10067099003|11063799006|4143699003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 BIViEieAUdV4HETSkU0bb1A/gL5R421yClgn1Y22kKrqoMSL7mUscQfXZh85w6P+BGN33mIcDuaxiGKX3X/Ps4vIzXiLJ0HAKcT8DeKFWumijiO70geoUp1capB66RTcUlV/i15idt/JoQzLprT0n26Obvz+tBeZ3CqxKDKNQ4Ku6eHqW9TZJ3EO5NX8PqbBfS0opBj9GtHY2/AtIJBtbO/wN9sQNURh5wrAVG5DMtowYRLCIttLf6mfzrVZdCR91Udf/CBfzKrxGPbBsiUjs0tp9oTy+vwcb1z9eNxy5e8ZU8JpjbYRf+0GnScy2BvTpJXCqXn3oux2C5yFMjIgyu4DAq14tzYc7ibJHnuxFKzLRT8GHP/+4ULeBv+phminCh93/svGVhV2ces0UwE/yntoWf2wzPC3CRnX9RjGYl54nwy14eBlsLaJE0vN132fUe/R/j/yUrGXekNBQjQ2q0UOVVwqdpMg6StxZx/XB5ypYT/czW4poTJiedcOzE/dOjSmOLEyFstF+Nk9TDPOr4PFg3aisUtkDfSNrW3oUA9Jy6pFLDCrb/1HJytw1az8GzfuAY8IhxngwKtmkjBap/bfpmRAqCPvzHzBifXISDQ/49Py/kgUgu90A/512iRmjsrSfVQm2FbF/U5nk3tEkW6Gjcn5tjrmWkZYN7fU6O7o74BNF7nEysHk0pb509bpJRNeIFT3KYVab0DaDszZZLVPHv6vXHwdsdKjhD0eOeo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aMxbz1Oyy/ng1t0t82JqO95y/oVCEYuAW1fuepu/PasZM+IWJJGO02wc0LhH?=
 =?us-ascii?Q?tBGsxCaIn0spTf3pf0jVJc00RcHtOMdfuzHraRbO4z1BlADZKv59U9FBFwKz?=
 =?us-ascii?Q?EprMf5i8+FLnNlKl5hrPBxyTkGxBfLEZG0PaKsnrV3YjM8tXaiZXQ5SMBaZa?=
 =?us-ascii?Q?kPRk+XdnZgsoP0+nZlUy0CsvRBMyB3sTF6r0QyzrHQQ9qG0JHeZOfLy524ay?=
 =?us-ascii?Q?9CRrkdIyTcui76YXHBnuKryYbaDUO4QqsNx9Z+8gWVaQQuZueF/Lgknc9gJ8?=
 =?us-ascii?Q?KrO+NuocjPzn9GPMhrELcLdTRlrCM0yS53B1gS/75IYg7iVvfotESYXZA4Ya?=
 =?us-ascii?Q?c9XTL9HJX81iKXw9YcJ+aRvqi6xFRshTPNZAktyhwi6ik3GQtSTnWW9OurCi?=
 =?us-ascii?Q?+zPVcKe2df3Js/CGPTenK0HYMYHEO5EX7XN7zdUeUpvnpe7kosft9CQNvmnI?=
 =?us-ascii?Q?srzB/1pxcFEtaEh4zv0nD2Hj21Dq2ULuiC+pf/KIm3mfqO2UJA7bUXKv+VFP?=
 =?us-ascii?Q?Rqqd8nSfnqGAJR9NgUq9czCJGF7nrSEVjwhFCFMHANhBaqWC31v9KOSWVsLR?=
 =?us-ascii?Q?wbEoprZqPV5GnydtSQkzPFkg//+PCV/lHXdDpBFclzMK0kO5BJhkf+9n8Jks?=
 =?us-ascii?Q?ENievOk8RxPaBgimn/jakia5X6Gtc7eAwAQGE/8jOZ5tHm120Ynm8XIyzyER?=
 =?us-ascii?Q?TpftfYfLouUrNp4iPxpbFdFlJr1gYAg7H0wN7JHK7xctkDmUTAfarp/vvi1m?=
 =?us-ascii?Q?xNjNHHVBHkK7iiz9UdUcZ47vMoIEC2rExsO9WJKRVLQcu+8vojV2Gpv/6/hK?=
 =?us-ascii?Q?fcZfOWuWfLiAqTo1e2yngQOVfqaLkwOpy2JS1VSO8aP2KacJGeQmKIw4AqsZ?=
 =?us-ascii?Q?vtd2O8PZnnoVMR+2vJxa2FoP/bGGXvlwOsx4iGoqlcxbCd/kFSYAKZR53G3r?=
 =?us-ascii?Q?mqEwaOXhZjLHrtGNOREuUgCScoF/BSxRnWzZCzvuXkzH2BGFdHhmJSK+D9P7?=
 =?us-ascii?Q?Lt5Vaz7+DXfN73phYYuS0UGkXtD4cTtHpWmIQBW7mMPNcL+3HKH3KuAo0PZe?=
 =?us-ascii?Q?yo1v2pkkBWsEe01SreH8mn76WiD/egA0tti1/rAzDErTBAl0ArvCyj4KiTiv?=
 =?us-ascii?Q?z9Ji4s4FZwBnGEsJu2YQ58azqBRIn6eMmAt+ExR5Z+R4J6o8xEm2nBVebKvR?=
 =?us-ascii?Q?hz0GsYAvamtqRjQ65Fy+2G6MiemQolu8maTQZZrWRSOHnxL/YZ6lqq+STucq?=
 =?us-ascii?Q?+BJ2PMb+ACpq7e62IyOppuqxXNqMcWnTzVjYkZUH8ehGJ0i+gtKZJXOX9lEU?=
 =?us-ascii?Q?Y8nHOpGzYHrMY5un0oH2tDkkHLpMcDykCyZHME35ibH/gqJ9PHnppuoc5YTU?=
 =?us-ascii?Q?3drp0uJgLunI8UW6RvX0bxUEeCjIN95aI41yLsRdVJqqEygfFclXuKpzduRo?=
 =?us-ascii?Q?t2rh6NIypLPeX6zq9x8vdh8gIR0fP5YujRsZ+7rDd4pHg6iwlz0HwqbacLXk?=
 =?us-ascii?Q?Rv5h1TBHxMJM8JXVxEIdL5VSp7fe38n+82J/GjqSY5Vc1cEZEXaO2MoC2lCt?=
 =?us-ascii?Q?z9RRmg3DCesY2dBSZgWRFcNvLHZM4flIbPMA/QfeG64Q2BWwlXf0WJDPja4p?=
 =?us-ascii?Q?hFhlgC52GOhNzHW6DT0YD3BEdU9bm2BPFZEAqFK3AhTP7b0TY3mF8vzn9/HE?=
 =?us-ascii?Q?JwnIw1Q34if8CkbR/JA7eBrMowXYw6FrnjV2axFG468077fC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2eece16-46a2-46d5-39c0-08df09a45d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:16:05.0455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaRNKdya+N5TMoIib8QYEH5iN9McHzUwzI1ZINewEdUszXfHppE3i9qBrEVp44O7quZdi5felqu1d07X8sn+BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, August 29, 2026 4:27 AM
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
> Subject: Re: [PATCH v4 25/27] vfio/pci: Provide an opt-out for the CXL Ty=
pe-2
> extensions
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:29 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Add an opt-out so users can keep vfio-pci's CXL extensions out of the
> > path for individual devices or for an entire vfio-pci instance. The
> > runtime gates are:
> >
> >   - Module parameter vfio_pci.disable_cxl (bool, 0444). Setting
> >     disable_cxl=3D1 at modprobe time makes vfio_pci_probe() set
> >     vdev->disable_cxl on every device it binds.
> >
> >   - Variant drivers (nvgrace, mlx5, and others) may set vdev->disable_c=
xl
> >     in their own probe for per-device control without the module
> >     parameter. The bit lives on struct vfio_pci_core_device so it is
> >     reachable from any variant.
> >
> > vfio_pci_core_init_dev() consults vdev->disable_cxl before it probes
> > for a CXL device, so a device that opts out is driven as plain vfio-pci=
:
> > vfio-cxl is not loaded, init_device() never runs, and the device gets
> > no VFIO_DEVICE_FLAGS_CXL, no HDM or component-register regions, and
> no
> > DVSEC virtualization.
> >
> > The module parameter is built only when CONFIG_VFIO_CXL is enabled;
> > the disable_cxl bit itself is unconditional so a variant driver can
> > set it regardless. This mirrors the long-standing disable_denylist opt-=
out.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci.c      | 9 +++++++++
> >  drivers/vfio/pci/vfio_pci_core.c | 8 +++++---
> >  include/linux/vfio_pci_core.h    | 1 +
> >  3 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index 830369ff878d..0ad041fffe48 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -60,6 +60,12 @@ static bool disable_denylist;
> > module_param(disable_denylist, bool, 0444);
> > MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist.
> > Disabling the denylist allows binding to devices with known errata
> > that may lead to exploitable stability or security issues when
> > accessed by untrusted users.");
> >
> > +#if IS_ENABLED(CONFIG_VFIO_CXL)
> > +static bool disable_cxl;
> > +module_param(disable_cxl, bool, 0444); MODULE_PARM_DESC(disable_cxl,
> > +"Disable CXL Type-2 extensions for all devices bound to vfio-pci. A
> > +variant driver may instead set vdev->disable_cxl in its own .init
> > +callback.");
>=20
> The latter sentence isn't module parameter description material, it's aim=
ed at
> users.  Why does this need to be read-only since it's following the latch=
-at-init
> flow?  Thanks,
>=20
> Alex

Okay, I will move the user-facing sentence out of the module-parameter desc=
ription
and use the normal parameter mode rather than read-only.

Thanks,
Manish

>=20
> > +#endif
> > +
> >  static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)  {
> >       switch (pdev->vendor) {
> > @@ -142,6 +148,9 @@ static int vfio_pci_init_dev(struct vfio_device
> > *core_vdev)  #ifdef CONFIG_VFIO_PCI_VGA
> >       vdev->disable_vga =3D disable_vga;  #endif
> > +#if IS_ENABLED(CONFIG_VFIO_CXL)
> > +     vdev->disable_cxl =3D disable_cxl; #endif
> >
> >       return vfio_pci_core_init_dev(core_vdev);
> >  }
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 0fed8e00bc1d..4b51a0f1e847 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -2423,10 +2423,12 @@ int vfio_pci_core_init_dev(struct vfio_device
> *core_vdev)
> >       xa_init(&vdev->ctx);
> >
> >       /*
> > -      * Load vfio-cxl on demand for a CXL device. If it is absent, dri=
ve the
> > -      * device as plain vfio-pci rather than failing the bind.
> > +      * Load vfio-cxl on demand for a CXL device unless the user opted=
 out.
> > +      * If it is opted out or absent, drive the device as plain vfio-p=
ci
> > +      * rather than failing the bind.
> >        */
> > -     if (pcie_is_cxl(vdev->pdev) && vfio_pci_is_cxl_type2(vdev->pdev))=
 {
> > +     if (!vdev->disable_cxl && pcie_is_cxl(vdev->pdev) &&
> > +         vfio_pci_is_cxl_type2(vdev->pdev)) {
> >               const struct vfio_cxl_ops *ops;
> >
> >               request_module("vfio-cxl"); diff --git
> > a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h index
> > 18e206a35d8c..8e3723a55c17 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -158,6 +158,7 @@ struct vfio_pci_core_device {
> >       bool                    disable_idle_d3:1;
> >       bool                    nointxmask:1;
> >       bool                    disable_vga:1;
> > +     bool                    disable_cxl:1;
> >       /* Flags modified at runtime - dedicated storage unit */
> >       bool                    needs_reset;
> >       bool                    pm_intx_masked;

