Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B136165B;
	Wed, 25 Mar 2026 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421749; cv=fail; b=q9fDkGiEwJqgcHSFjVmuEjVn7vO23MQcwyBTSR/zpi8TwOkog+f10GRhpE5WFPZPYJIR6uKCwVPRiKq4gs1jiB7WXi54be/DeROLdGcZaJbvnMCpCX4GAZFEJxQeL4iYnjSCvyfnzl/mUckB/nGVGsE3ampD9XF+Q4RiM9yddxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421749; c=relaxed/simple;
	bh=Q3eTjhpi8wOr+BL1e320Qon/Vvo6RwTQvOKBoiwSMo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mYEFjHv6/A4Tg8EJCZUOTdnGRCG9StSZVJaW9xXP7bFutu6eMTEp1blr5BbUK8l+dvYBuslw3so4IvZrSXzdgR6a1wLZ6FcBVPllnsNr+QTGy6FwGpTUk51E8BflIMBw/CWajs6J2atls2KBd5C5UJpBKocN5z6ZV6xXJJK6Y8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fp9rO7Mv; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fp9rO7Mv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774421746; x=1805957746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q3eTjhpi8wOr+BL1e320Qon/Vvo6RwTQvOKBoiwSMo4=;
  b=Fp9rO7Mv0/mG8MmHw61Z3qEYhfXyigjLzQ1eltn8LxpcbPMLPwcfueJb
   +hNHPqJMY2R9yb2znvXJYlYFNajXekleAj75VeejcMr55m2OAiM1LKXpj
   KXtesfN995K/qy8Zgq/tfN8ciJtNvNY6Hq2iiFsD/AKUFgTiQeF1mhoPU
   NkAy9v1wdin/BCzqtKgHiWNQ/+5MH4DueGXrUXIlZfuIjAGyj7CMkvKVp
   nWW2nZKHbn6lx7QPeq6xko62SUtc+VVYBEq2R/pY5bW/up9RLzFqBGTJ8
   CRgOJaqVh7l5JgK0gh3N0LlWspDFlQCgS/zDL2EHqBqHTDsYPQoBQg8Ln
   A==;
X-CSE-ConnectionGUID: U5W8ON6qRJqlG+X8xYud3w==
X-CSE-MsgGUID: 5jyymwcFQi2HhIUKcm3rcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86066971"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="86066971"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 23:55:45 -0700
X-CSE-ConnectionGUID: QbexQ/2ZTJWeHDk6rPHutQ==
X-CSE-MsgGUID: MJ2+ohtRQau34Rs28i2Fww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="219729073"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 23:55:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 23:55:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 23:55:43 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 23:55:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXKC95U5/WVIswoBfPXn7diqTxDVCTOEaYYPF4gU6546cc/j6W9I7awZeddL3uc/E7D7OeOCw36LOlLIjdpeWEXEQHwJRTJT/acajk2B/7Kp18Axi0PnSoU1OYS7ag/JoFOPBCkDwKQLJhjL376m7JkY6QEmXsuIYa07N+yGwlUdzO773yJU1wy+3ggM8Oug0LrsE/AebYzKTnMNcMNolEuniInpHtMLchVijvPxKoQMbohOg5vWTiG43P5fcgx2uvwt61WR+NJlaEkn/IY4eW/Xor2d4pjomPTxAsGbrss7YKCLKwLTCfLORcmGcchpAEuVDWL1P8iBDMMYvsv5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3eTjhpi8wOr+BL1e320Qon/Vvo6RwTQvOKBoiwSMo4=;
 b=X/4De7+1pgP2cgtzgee7/fZBtt0uSeXzfaB5xSHzsLJXy15fM+pY1m4W6jT2MB8BiXDjWCOb69gBHhnv+VCgYLEfRVjksyfQ1d6OVUtOmcNXHjzNpcNGoFKHA6JLTpJ2t9mmGf9sAoXht7Bc5M9IFqCujiWgcg7chErwJU0l9mMINRbfpRhWKCSjrR2hFzrn+Ee6AF/uaP/s4yijG10QDD4rjdUcODpTb47i6qYSizsrpeZYE/eBoSDFb86ZtEED//OGLZGox37V4llhLQ+dRoZpTXt8GJt2w64RjXTlBkkAPBr727aI6W6cyzjutV6NRzG7YOtxPwiAsJwoj2rUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB8026.namprd11.prod.outlook.com (2603:10b6:806:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 06:55:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 06:55:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "praan@google.com"
	<praan@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: RE: [PATCH v2 0/7] iommu/arm-smmu-v3: Quarantine device upon ATC
 invalidation timeout
Thread-Topic: [PATCH v2 0/7] iommu/arm-smmu-v3: Quarantine device upon ATC
 invalidation timeout
Thread-Index: AQHctkKXc5nudtokhUmd4/hiAhcpbbWz6cEAgADOqQCAAGpAcIAADJCAgAengYCAAgSuUA==
Date: Wed, 25 Mar 2026 06:55:40 +0000
Message-ID: <BN9PR11MB5276DBF0624E0EAEDC54874A8C49A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52762F94146776026CA203248C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <absFXmFcpG8O7uNB@Asurada-Nvidia>
 <BN9PR11MB52764771C48B39C09F129F218C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abtpCXAnqLRnbG1z@Asurada-Nvidia> <20260324000321.GX7340@nvidia.com>
In-Reply-To: <20260324000321.GX7340@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB8026:EE_
x-ms-office365-filtering-correlation-id: bc771543-2108-4f91-6f43-08de8a3b86fe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: mAWybBrauC/l6cVmRb0tgAF7zz+GWtLaYZbQ0Jf4kdT5Ru4Jx61qwIPeiRka/nkf5lDl1RWbrHXDXrTjF0Ime0mQCjKMVcJf+ArPRWNVA4eo3qvnwzx4tL8XcmcmX2VWV1F5uKtVOwRvrfsQ6WUHZLq+jkmwbCJ7CqtGqF4s81meJcMopL7YifVMGe/7+0Y/H1fZxGr3PoEqS7DQY2Sbf9KH6Vysd6koTL9JoPZ6BzY8g1t9lOdpsOyFZeEUyVbeUbk+gOwub1VtXkSHS/6jrOjnJT4CYd+KSB4+g3sziqBU3UjgMXYZ8HpVx2SsVmCrG221GNM5+3ZUaITEtYm1aEhZAH/82O34ckpx7rxQoFDrVi5xJwW1zydQXgDtqmbs5cVxTMH3w1XNkKdAZOk+Wr+4lwABG9A6bsL8EDZZdF5vVdx2iLsvcPk6iAyJhC1Mkt0uSw6tD/0Q7wuhDWF7JW4KuLNkDedq5BbIuYErc8vxy+SMq76zBtV03UcW40kwieVYICxDgSxrWjWzAP89yb+NOMiMye2uSqtlYgD5Ere/SMixA4A38prJlNAL9xM0iH2IHjPRffFAMqkH8O6JvWnaouIoHaKCm4nKROhf8+Z7C/cbL6rinNwNNfDqtQUhnaTkd1lHqxl2VQuLacWykR6/kdeX5RdDrNjmlsfVpeKEoOHRycAl3mpLUdo13WYRf8LZH6PWvZiDj9EVF2Q7G+mxtbEsuoB0FHpsHtQBZh79VhwUYYdToqo9AWYzY4OsJt6xILFjjXqrH0rriVfxT/GhAjrcFPTGpEaJRavL1Tk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zvxh2XctNiKpuOccxBM+SdON2/8CPZgYvaL1vWs5VOBAlv0eB92ommuOL91n?=
 =?us-ascii?Q?qTOBU3/54k4IfKwNAbuWwWjLmutxfoVYaaMzOO92cJ2YPq2bTXTLeLwBkfDG?=
 =?us-ascii?Q?1YL+1yjrjiNSX+UI9rLfuj+joVkSArXOVUWE8DtLB3obrBYGrMz0uuGiHm6a?=
 =?us-ascii?Q?lblVaPcSfATZJVN7eCnTkETZ8olnIKzHQXsv2DqSknvO4t//406smGltprwL?=
 =?us-ascii?Q?2MkqHSTJvCF20I/4YfrvSQXAWKm/Cu3YPR0NIayjh9yaEkxP2tzc3p525agu?=
 =?us-ascii?Q?8Fjj0xkO6Y+fv6v3yJshI03TP4UOexFa8Knjczmcgcz+tuZo4XrLhCCsil6b?=
 =?us-ascii?Q?BVHUKRlZQ9Sj6AZ7asUiKPuxUhitPaRfIpPfXAOZqInS0NnQgzQ2016ADPt4?=
 =?us-ascii?Q?GoPj45UeylEALBPZUY4tXO+Q5BkFlI5PnT79y4Tsr2nbtwsfjhX9Y4563wpv?=
 =?us-ascii?Q?S7ubMPicYatDjRZpvukbOlMK534thcPtqBxLjLJdselTTdCHxdYMF67ic7lQ?=
 =?us-ascii?Q?Mz2TYQsYNnYqVRGs9CtcDTWo8La2s55Gegi1ilXMpNLRlO2Xjm+OllLTl6yZ?=
 =?us-ascii?Q?l2MlrXMshOGluPSL5iZRnCOLMAlZTAwYiXD7EoaqfhdL7KI0JXSnug5ogwaV?=
 =?us-ascii?Q?qdAwHpXIekI50xb+f4KGaqudZPmVs586Po4qIEZuqVLf1HKF5Y7HGU1GhDxU?=
 =?us-ascii?Q?w2oQWllvqholBrTwXsrkMx81c8VMn8LTZHot2PeSQzVCP7tm8NUhU2QQgP0F?=
 =?us-ascii?Q?44VArJRZs6nWYkLauC2QMoNQ4ApaggEOeGm6Rze+7B1iPja6emA+5HguKa3U?=
 =?us-ascii?Q?LH3TSxpukngaOaGTvBTsualdSgvGaM1DDsJUgwuccvq03vytmwyzu5Ea4ENQ?=
 =?us-ascii?Q?b9DNwGQyHae5njbWEBmjpNhCE3G58YB0CAuKK6NMNHP+xL8COQ+Vz7PWwfQz?=
 =?us-ascii?Q?hzp5dA1p1c/P4yt782dd5tad0f7/kMBdz3Q7rSCkwst/ukWWE7QeqQRSG0od?=
 =?us-ascii?Q?dy/3JJGVesmhm19TvLKWiDLFVfuB/K/pM9GCEarS+FyEZogSuDn2gzH81f3d?=
 =?us-ascii?Q?qI71SlhKZNhpr3H4XagbA3oquIAuMSlPhPbd9BsiAA+ZwUUhJiwMa3XsY485?=
 =?us-ascii?Q?E0gvvZenlBAtzsMfbnWKXEodSN4J2ZZdf3GOcW0VmbaHIIz60wE2l+s1oBvF?=
 =?us-ascii?Q?vcJJz7yXQc7k2S/hSBBRsZB9pABk8N+cX94iEMavuMSAiqCqhCWCsKtN4g4j?=
 =?us-ascii?Q?5RtAKfllsHDMdq3yOH4I80a1rpsxLfXqtZsah/uInjWNafaKOKCE1y2kHbva?=
 =?us-ascii?Q?ptcOTRaLpTweL8G5IavldvnjiuSzuMDZHT7Qs/l+gdbxiOIGIj7uHY23COUY?=
 =?us-ascii?Q?RfM6sQ+2Wi2Ml3pxsYvrqBE1R31m5tl5GjpBNo0T2+ypM1BZDJ7zo977iSZV?=
 =?us-ascii?Q?Dswb+KCVDnbTz1n3XditkCA8+5DkCECm+4+e+bNiC18Xafc/b0uI2H3OLgDV?=
 =?us-ascii?Q?RdmLsvVmxTvesL9vNRTQCl4GC29wmgOY70OwMwZZFnR0iiQIY+9eDN8/zqdA?=
 =?us-ascii?Q?apfEZQDvVH13wMtiaZSgPCr/X9bB4BsUjfB0WyWQBVqgdvWdjFmGhg+O+HKL?=
 =?us-ascii?Q?IgNE9yfXOG5/pLhZJl+Jz3CpwdT7j5ybZ1MRwx6lYEmEk/cMkLcP6VE6SBkq?=
 =?us-ascii?Q?OOADo5xMkDqh19Eqb5nQDSg3gua/EcoPzLG/KIhSc8Lu+Ynt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fkW9QxNsQ7dmXXXHowu5I66sYOMGPH4mz+XoZK3RdF7Z1EcI06uq68h8zDyFxOekxF67QpYrigJZ15pmiIzcvPW6J5/7W2VekFwzI+kGJ/iS1pBaT45yaPpnutlyGR8csNjaRgTRowsP+5HWVm0wMqjN20A+0OrUr+N2AOeGvyvUSqGUGok+SYetfw5WVvCCb9tjYePzzxMPObcGBptIk+cUfFtpGTlm5Pt8nXHVDdBXy+C97rcaNe+ri/HrtsDR96EVNgLMhkgIq8qfLIwjXRTvYLehXOZHW+3xElsym6owe0BWX4V8XkXK3O/O/OD89D2cE2YcJPmZ2YHRE+d3ZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc771543-2108-4f91-6f43-08de8a3b86fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 06:55:40.5132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKQj2qJvZMBmCTMpGJBIfw/x6pYpskmjZZL+HkzkfP2wlxJt/nIGy7oR8rfx1yGY9spUPNm0SJrGvuwMmrguZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8026
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 24, 2026 8:03 AM
>=20
> On Wed, Mar 18, 2026 at 08:10:01PM -0700, Nicolin Chen wrote:
> > On Thu, Mar 19, 2026 at 02:29:38AM +0000, Tian, Kevin wrote:
> > > > > > This series addresses a critical vulnerability and stability is=
sue where
> an
> > > > > > unresponsive PCIe device failing to process ATC (Address Transl=
ation
> > > > Cache)
> > > > > > invalidation requests leads to silent data corruption and conti=
nuous
> > > > SMMU
> > > > > > CMDQ error spam.
> > > > > >
> > > > >
> > > > > None of the patches in this series contains a Fixed tag and cc st=
able.
> > > >
> > > > Hmm, I guess AI overly polished the cover letter so it sounds too
> > > > strong?
> > > >
> > > > This is essentially a vulnerability (potential memory corruption).
> > > > And none of these patches actually fixes any regression. The PATCH
> > > > 7 even requires the arm_smmu_invs series which has not been merged
> > > > yet :-/
> > > >
> > >
> > > Fixes tag and backporting are not just for regression. People certain=
ly
> > > want to see reported vulnerabilities fixed in stable kernels...
> >
> > Well, maybe I'll just leave additional line telling people that this
> > can't be a bug "fix" because it's written on another unmerged series?
>=20
> I think this is more of a feature (RAS support for SMMUv3) than a
> specific fix.
>=20

Not a RAS guy, but below is what I got from AI:

"
RAS improvements typically involve better error reporting, graceful
degradation, or improved recovery - but they usually don't involve
scenarios where the system continues operating with compromised
security assumptions."
