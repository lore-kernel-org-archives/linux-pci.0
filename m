Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0E3793A9;
	Wed,  3 Jun 2026 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481558; cv=fail; b=YHmxgJmflYSC70ilAflYBImbvdafIzOobdVxvpvkqj6ViMNbXbAadwVouhKso1Y+W/HzDMGyRHts7q3Ud4/wQm7lOJyCGL/COkFsqP4r9XEaHha29HIzO9TQ9A4C5BvfGKjMEvR5CMytaX3jroLBIu6Wo/UMtmBaQ9psmtDvbZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481558; c=relaxed/simple;
	bh=jxfkeB4BgBpAtczgPMLO08pelVhdm0I8/M3pVxvu4Go=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z42oZ3tKpNXq6IELHpMiyzBInTaVemTxXaO2yjqza+0szIwt2ETMWX1op/KgPECjun8oDEguuY+xkTFqwof9tPE/UhZdIFOQQzYcp4tr4kM8hh6f6C4lDdBw6N61WOkGfQ1QGdWY2uYDXtXJtZTKAC7ud2WydMEL79/btCebwlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZz6ln6L; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZz6ln6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780481556; x=1812017556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jxfkeB4BgBpAtczgPMLO08pelVhdm0I8/M3pVxvu4Go=;
  b=XZz6ln6LevEVIsCSLfJf2N70pN4fjaDG7JqrOfTy6plIljz+4RDc95I0
   gnu7ymnWoGiJ7bq4zrvnFbhVmBUWaJRgjrgCK2ctO0Tt6JUtA+opi6ONZ
   qPqylmHbKU8OC0eGBK+EpMLKqViCo8YkSTEchM7jzRWWo8jl3PjcmNItX
   rzq5WaCH94GrCcMufQRjFgHmolEJjxEpcUJYwfqaRdbO+1tmJXRvGlBCr
   SFq9qQ47UV8Wmcuik68pmJtzWH4NSfE7txgka0CrfLPVLhYh4u1agMrYi
   mExC5R4XDQtqaedBKZr3bSia71pqCoJJ5/59cgShzkQz8dOPtCXHRT/bw
   A==;
X-CSE-ConnectionGUID: xHxIJVX+S6aTVpHK5yuaLw==
X-CSE-MsgGUID: X6V4jd1sTsqcPBUZ+Rymog==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="83862657"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="83862657"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:12:36 -0700
X-CSE-ConnectionGUID: wEOCSZ/5Sdqsj/1Ep260rg==
X-CSE-MsgGUID: pW7q4YmJT2aSUqSdAYKqTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="237826478"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 03:12:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 03:12:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 03:12:35 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 03:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=su8YsMIDhQgbCa9Wk2oMG3xCOQ8UitsmfEWut/7hxpLh9Y396J9oHhrr80SORfc0HStQ1/QrA3UAps89uRqMUPB1tDi3+PUJ4tsaW5Us6lPkdOAK215gDdz9JqzZTIOMjz+w+xn4nZwMu8YRHSJy2ZGNKub+2JNJn43KAa8p3ysjnaGn2q4QtDUCUWREopCjuxJ73YSfxtsXOwRcF8im+ov7Ha84Efp6QSeX285zbWs6Emoon+hcXGeqYivxFsjS+D299Ad52YhQCuMIGRzin9RJGFFeS8WDF6ex4mUNyjYMhcse4hxKkx925zrJ2+W5a9a2ajDyo0+M9nL/9SVoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6Jv2hzQQxpsP7t6YsBgD/x16hnAOdROfHd0nj31is0=;
 b=SC55EdcB64Sgr4XUwhgjJL0J+tN954tpLPglbXH+24xgvs9Yw7CZz0jDZ8IKtK9lXaYIt9ovyn4L8kgJWyj+1X4mpGw+Znu8jcHT/EQuo09cuIf8UXsq9iDgOfYslMd0g3jQa8ApgreQObz/hQqIlq8Qwc0lkTM89++glXOglGr73F9zFXoaZw9nZ3/RM3Q+QuFMv8xAaKVvyzbEfeJPhueD0tML7DlJTMukCy/Ob0pyQMCEzc3o/z+6YGej3q9t9zyAIhvfM7pR41mlTowM6MN6HtyVL2q3us+4rNCuWjRwgKN22TJOVkCuC+EcMWdgRQ+RfZWFM9/X/FpExIEjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by BY1PR11MB8030.namprd11.prod.outlook.com (2603:10b6:a03:522::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:12:25 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:12:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Pranjal Shrivastava <praan@google.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja
	<skhawaja@google.com>
Subject: RE: [PATCH v7 4/5] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Thread-Topic: [PATCH v7 4/5] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Thread-Index: AQHc8dQlM9qB1q/QaEGi+kJgUM64DLYscmSAgAAcCICAABC4sA==
Date: Wed, 3 Jun 2026 10:12:24 +0000
Message-ID: <DM6PR11MB3690962BEF75B3CE8AF6F5938C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-5-praan@google.com>
 <DM6PR11MB3690D6851AE3354AC55CA2368C132@DM6PR11MB3690.namprd11.prod.outlook.com>
 <ah_v48zPNHoZb8D9@google.com>
In-Reply-To: <ah_v48zPNHoZb8D9@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|BY1PR11MB8030:EE_
x-ms-office365-filtering-correlation-id: 2109be1b-748d-4958-001c-08dec1589bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: p6zwRBzbH/3raM+p/M151lXpBh2C2FlJvnlw1SsYytzHWBaVV2h2IkG6h9L5Yuc0OtCdkNN2qoZiOaDkF9JaJNuH8VWRhrqHZx4nVdN2tdwSOaePGVG6UllG7BouDPiQ1I9kJEhNb/xOU+23uSdjpGbg3bfedPwCa1lweIP45PZpPsq6enJFwqDXIUHKuHtRYDj6yxHouXJLqnjJ4UgHyoMbIuUzAhYf8IC3EHF9VkQXRMqj29QAGVK1l+GczEeDL2TsRCVz2+szOiVsOrbAssyYHBFvNb5KQjIUEoT0kaWvbBXiX6Cld14qpTBfd2i5M6TjZEBVB8CRUObWoqE9xJ3Gcl+ccQ2JDRCejo5WJNu+1E+Yj1gvRAW2wz+Q22/5GfdMRvWVwc+d/0uUvWZ7C2xwHX1V+NykjdUuI48Cl+brSEMbDhS/XVzKr12kT4OOdhCLEvv4AJGiQM8jNZHLLfXW5n5cz0EHrDlICcN04/LXNgfk0/qcRv5v5pfp0Rc+aI2gHA8RPGHxbnTsdldZ5SQaOX2LMmfrXrCv8tFplJgOV4Y11pLEZSpY+D4eeUFy9uRa6EiXyRIbqUOf4jiPjQC3KBUlE6rnAo2XJbYVT5EHKA8JiqmBAx6sPNWOKi7ObWgEeXpTewGVgxLz/StDBm0icwpWX8SRuZ2tm8cgwZmxK+oS8AX4/mqBBZpf0zZF/YUq/7pDMFF/TenZhQGZ8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kObeVYsk/RFfPGRSq/WNXg46Sm2eBtdySGClvvXZdIx9dZ9XaZEstDhYvxwE?=
 =?us-ascii?Q?eqP4VSI3yj0NceB8uJIlH6RenJnLf/RN9L7n/DUbtffPYRnUksRdQ63XwsUn?=
 =?us-ascii?Q?1v7prkuJA1om6pNNVCtPBp7hYqgVgIuGJIw4OCW7rAZ3JSfGy0305wKNToAo?=
 =?us-ascii?Q?KMWsGbFHLv2zWLbChpaNpj8ch3nXFEP6jFPBzG7YDs1iWh+8o+WPr/K5c3VT?=
 =?us-ascii?Q?vCy1jfnpoBn+No1itUlFn+uPxPDZCRHi+XCy+CUIqBNnhduLKgDJvxGNcbCq?=
 =?us-ascii?Q?qx1EI4f7GmmrzRXmAFhk7C5wn1h9bKvcYyB1sUxZJ5Bcn2EvgEU7fgqaIFOi?=
 =?us-ascii?Q?wFKva06Po9S/ORdUjnUe5HhI7y4dDHj2WYcoXzAWfTjanlruUHn5L7UjrtAT?=
 =?us-ascii?Q?dbly8/teH7UsyECSKsVIopf0htqJ11X7JD1nsiUANABEKcVtshtn5Mn7UCBL?=
 =?us-ascii?Q?E++NumHdCqLdCTRh6XAa2G6/5FJ2FWou/CPpHLZ3mhfm02KX9u/hqvbXcHf4?=
 =?us-ascii?Q?9Tc6fzEGz9vLAl1ubGs+P7SbXHN1QcnCKksDBu34cNEKNBEy5rFdB1AXxoxZ?=
 =?us-ascii?Q?v35PsQSvGiHVNQoPo07suwhqNSkAMk9WlklluiXt9HReVKH1GUNfTuODtn3E?=
 =?us-ascii?Q?rH4LJtyIVrCCHYnDJsS19fA2qWz+wp/z/YgHWAZ7GVvt8OVaJ/cNVacF4OSD?=
 =?us-ascii?Q?o83jOgRJbnJIwHFDkFceJ1v3qJVHe0BgBXlMxfaNiH0Wz9jPMMJGqwjozqkf?=
 =?us-ascii?Q?GlGnZiESLWUMqKyDkjIz8lTa8zJgcmu9ykMFJXglbRv+8B523pAYKrjFEHH1?=
 =?us-ascii?Q?8VfK5ba4AdhLICFLyNJUvWb9VdK2hrt4QYKxc0XWmmgM4HNkvsyWmxO5M5Do?=
 =?us-ascii?Q?ITx965UAfKj2oRQipG1ohbs0AGYi+lA2qiULr+eSTSn6NE5ik9AKvNPYh2ya?=
 =?us-ascii?Q?aiQdDNB7gvOdbUHFoLMbAIVapeyQY3mQpxEwoT3u/Cm+v3PueSu2EcYvKowg?=
 =?us-ascii?Q?D5pLNFTRJX73yycNdRZWbG0K/sni8vUwwMW0iTGlwsG3pKXj/wO0rDGDb40H?=
 =?us-ascii?Q?p8a1vqBa1wg+Kb+mkJpiIPmM0LEkwLHOYxWSuTZam4H7wXEYd8Ho5aC91Lz6?=
 =?us-ascii?Q?Yz0EYCOk+t0nIhSw0/RyiLWOSbrs8XDT+yzfjHgC2jXdWP/9qYV7wWF6SGsa?=
 =?us-ascii?Q?sabxWkLEtKbDXRR+/daCkvjv8GoXrOI3qpoT/wIQIeGh47QxR22IE5tKr6As?=
 =?us-ascii?Q?DK5rl//dQ9MyQqLajk79+RkqpVWFqmpOp5p/T6CRD7CmEVOqBFdwL3WhRMsF?=
 =?us-ascii?Q?xocRqpkabc698g2H7wBzO6tBcvi/3zG/6RMDxQxwSij1NwAA7xXM6ZdZRRIV?=
 =?us-ascii?Q?U4qHHnKaPsErIV2sgwSw2iusloc+lMHeGQG824vikIkN552VVkNPQ/B7Yrce?=
 =?us-ascii?Q?sJAEiPytbRrh4DyCKgy4G1f6+/eBowXi8Tu1cI+lF1PY5uGJeYaxDksT5azi?=
 =?us-ascii?Q?G6KwHCzmBhh8h0j+K+SfsC8qw7m8oA4YKSaJzjX+t5g5EL+x/uDvMdQp5WRu?=
 =?us-ascii?Q?X/pU9N4cUjG76aYq9l27v/MWL/Up3uWIKrtxt9fYOZh2Zd3zAGuEd6q5u11z?=
 =?us-ascii?Q?R0gfocCoXC5ZCBhZkXeVm+Qd85RUyDsby3JBt0vQ5KkSZD+UvQ3o/Hn1e2uj?=
 =?us-ascii?Q?tiYf8ms+UmaU2U+gFufCu5nMoCte6NxBbpkRFAxmN5VnYnIHpYBZ5Qor5X3p?=
 =?us-ascii?Q?z5GtYdolqw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: j/pk67yNVv5MO80vTBziKsAxPtuJTvb6T7dUbfvXl4FAIw+aFJhKSfzsdmhiKCg5CwOY+1HPYKhcqfhnmB/eO8wSKzNlzJ6hCc5rybpaJF1JmCz/hgeN8UDfPYaF65I1QUQH9Sxmk0EX0tQylNxpga8+o79jqDMijNIOXIYri8ve4IFdxO4Mz20+jnz451oxtSNMFonuEfcG4HtPC02ORsYKfyMeQEH0kZsBDiFKvyRmjYHGE3CA8EtfC8sVpuzFybAYHiXK3ZLIOV2Fd+dgGQGA9H1OHkgdeyNmZAVAKonhDDIJ8X0YLWosTUUPhvEshvgdu2OTVr+5IuhIwudirA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2109be1b-748d-4958-001c-08dec1589bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 10:12:24.7541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3YqOyFRJtED3Xj8iUm8BdZ1u98w7MLanvNrj3qC2YH7OBSsiri1bnHu8s/TO/ubdncoD8pLjHPu1s7n73thBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
X-OriginatorOrg: intel.com

> From: Pranjal Shrivastava <praan@google.com>
> Sent: Wednesday, June 3, 2026 5:12 PM
>=20
> On Wed, Jun 03, 2026 at 07:34:14AM +0000, Tian, Kevin wrote:
> > > From: Pranjal Shrivastava <praan@google.com>
> > > Sent: Monday, June 1, 2026 10:37 PM
> > >
> > > Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
> > > WARN_ON(). Since probe-time checks now preclude configuration errors
> > > any failure during hardware enablement is considered a kernel bug.
> > >
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 54c7f1ae3a84..dfb2b0d2d2a5 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2956,7 +2956,12 @@ static void arm_smmu_enable_ats(struct
> > > arm_smmu_master *master)
> > >  	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
> > >  	 */
> > >  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> > > -	if (pci_enable_ats(pdev, stu))
> > > +
> > > +	 /*
> > > +	  * Since pci_prepare_ats() has already verified the HW capability
> > > +	  * and programmed the STE, pci_enable_ats() should not fail here.
> > > +	  */
> > > +	if (WARN_ON(pci_enable_ats(pdev, stu)))
> > >  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n",
> > > stu);
> > >  }
> > >
> >
> > looks smmu driver doesn't check return value of pci_prepare_ats() too.
>=20
> It does check the reval of pci_prepare_ats() now with the a recent
> patch [1] (merged in Joerg's tree) that adds a new
> "arm_smmu_master_prepare_ats" helper function.
>=20
> Thanks,
> Praan
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?h
> =3Dcore&id=3D5ff98a0da6b48d8722eac0080e4185c417925d05

Okay. Then:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
