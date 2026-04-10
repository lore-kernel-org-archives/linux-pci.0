Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60CAA932;
	Fri, 10 Apr 2026 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790849; cv=fail; b=gQA29JKVH8gGokabKh+XttCQ1O5nqqDMdCO7FW9q46DAZ1XWagwq3zLxUvwyhgfzRG/5X8y64JJFWJh5vZgWzIhYIrXEzbLjjsswd3BPHmW88NuIWCr9Z5gofFHEpU7A8WFhvEuMrMd7kwY8H/g6RKvJQgE/UdQCCPYjDenjKcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790849; c=relaxed/simple;
	bh=fdZ1NEaNnH7k2jC/57Mwcy1CGoWGcwk3tBHAHuO+PIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iHuw3AU4wDU/R0eQ3tLe22EbjTHUW/hnE6q/QWm1tMOVcajqHdIMAaL23DT9jS7dXQYQclT6Sm1ZTmTJrbNRd6FGXrZ/34NW9s81weHL7oIfTKp3FhPVGr+h6LBq4LvW0V7aFIpa3H/2ZFyebDt/hnJFx/3Umxpt7Ig/2CK1kic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kG6Dqu3R; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kG6Dqu3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775790847; x=1807326847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fdZ1NEaNnH7k2jC/57Mwcy1CGoWGcwk3tBHAHuO+PIg=;
  b=kG6Dqu3RLjNAHRryArz5e/DIv/qjdAxn2LfytCWO+E5bnAeKpAjb53pA
   PGed7oeudPk4vmkQrTayHcBoO2HDMYWfLjcuyLY58x66GzO5gZQ8bD/z8
   aD5RVT1lwIUac1xS5OvQZVsMoU6tnFHcWDmF8TyIm4ebjhsfPVY73qsrg
   GGSEwFlTe8iUDatKKTLR05J9jubmz0jMZ+/aGs9cQnbzodqNsLxlVNXWN
   JYAY5XAvK7QmfkNnVyV3XmA7uesg4fonneljII1WElD0f4vqciB8moBE2
   e1THOwRo9KIVYO61AO+XnpOa4Qjcp8vWuYOyBPKTnHkswkCKeZKPUZZcb
   w==;
X-CSE-ConnectionGUID: qvKbMo3sQrmdqV8PR0yFnw==
X-CSE-MsgGUID: 02W1e/tnQCCfVvQZAnbYtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76927358"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76927358"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 20:14:06 -0700
X-CSE-ConnectionGUID: ZGqvicJySsWohh3xn3zNig==
X-CSE-MsgGUID: wnLFPHfMS16bCEtHIkggIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="226247261"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 20:14:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 20:14:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 20:14:04 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 20:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feYLUEiI5mebEJAe911r4IrEiSYj9aofEPk1+veZERn5iZDu8rTf1V8cDPp1YrdsgM3mN8XlHEFYqhPNR4DoxRZecOt5YTMhRnBNiIKP+MWwDiJ+iYqVmJfRVQrU4RZXuOT3qEIMIPlqAAk8lmlBcLebXd8G7ghC2M4angkoGyTmHnP42l8FAywDNZAmRfVi80Owe52ssjOWxv1zxYymvV/lO8BXjSOvWZzslpD9TnLnZfK0it4wBXN86vVlvgN7+BsiPtYvtRUrHZyf5r1Xki1yqjbX2uknpzNWhTicDendUq8c/lGUYRcueJ37bpkE0Fiqb348RF9FVTVY0CJM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdZ1NEaNnH7k2jC/57Mwcy1CGoWGcwk3tBHAHuO+PIg=;
 b=QUeCAQ9VbUmQeYZ3HeqzTwV1orE0UwzKfsqgqwmsbmpO1SB7VR5t3KW7MgD74QgA7KO0tlZC7r9+HXqWE/UUAN98Ym8ts9cF2hRBOAJkoRXbHhztv2dpmkzOkxIl8Dzx1eKRKVxZ/9qY7iK+F3DmhB3gbWUIO47j7jLGN+hxKFtLBf3BpShdjc1SQSDwG+UAMjf55cVgPdxq15B1J75JUzA7a7a9561NrNkUR6C0rXfDuh2IdI7IZBnjL6zn/dXd3sznwXyyqRkBGjs3wXEPSQIYj3XeVFjhLjFvSKhMWaiP+GnB9fY5P3xGSWie5Ix55JhFvPEwUygDo4vY7JTEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH8PR11MB7095.namprd11.prod.outlook.com (2603:10b6:510:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 10 Apr
 2026 03:13:59 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 03:13:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Vikram Sethi
	<vsethi@nvidia.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Topic: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Index: AQHcrcLZlsPpC1aSZEGOkgr6dEwpTbXIca9QgA8X6ACAAAIUAIAASGZA
Date: Fri, 10 Apr 2026 03:13:59 +0000
Message-ID: <BL1PR11MB527184E183703E14F6C861118C592@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A6B1B103C4B0201458348C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <adgsBgXYy68GmxAf@Asurada-Nvidia> <20260409225252.GU3357077@nvidia.com>
In-Reply-To: <20260409225252.GU3357077@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH8PR11MB7095:EE_
x-ms-office365-filtering-correlation-id: 7ca6dbaa-a545-48c6-c20a-08de96af355a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: g9yFAn3LOLTLy0KcXBaeDdXsHWqan+g2mxuE3BKZHCkg0pHiKkAq2XL7lckr3B14/6NBWzU/H7bNbO9OZi3I3JxN18VRNK3+yoe6mcrh3nOPDjtvKfzcWNZw/rHTYePV2C4hDS0gEcMqaHu8xtOSGqa8n3qp76ekekI7B+rqzy1qbsSSLkjMOpt6+pCJ7dMDRD1rucYi3E9VPDTb2CD1QJ8KhO/V4uX8lPmIYFn4zFzDPO/+nBbEHd2ct5/DRGuvW7k05d/hWzziUMNtyLbScDr7+l2X8TudMMkOguj17RyL43ilkE1e2GYoCN62KLcd+Ge96eQd7ffTS1g17p+YGBYF6TgfMNqeptStH3xz2IF5Z2ayDlPdunGHnV49PBvQ82uE/rl7FYnJGzEmtXN2Uq1utvVgV7H2SjxcPYwuMKIEixQmVSQN90VPbfwZwnahlghppCk0L941wpq5tDBS2xsuEOy8CUisHbJDox25Tabtb8NTFTeyjAtRliGZ8fAZmz0lbaxr+ZFnKLIByDzkDhOi9FVFb2Y3gYcectD06A82EIeyHAJ+EcC0L64SBGm9u0IB1jCPyU6TN0jbz62ghlPQS+MkAAX2/GMnN2fWw6g+x7u4Z7ibquxWQdryLUc8cqlOgLuwfgtVxaM/+aeL2ZE8kpZzQ6aETk4ikhj2uqd/Q92/dVvXRIAlbMino+jwJANoyv7/zSAOs6pIsSdSYFPD1MsuJPYwuXZTOloH9cLuFstpGwGng4P+Oim5bOvLN0vLE8czAr0XDOx3/NFfaS/xUuhmC/fsC99eTDAygeI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?97Ez+Z3ywuzVT0m2r7XB0uK64fD3qEg5yS4+kCsWhZwxRqlMp0c8uev29Uck?=
 =?us-ascii?Q?W8BipsADWwLxZUue2s767m1XCETMi43aKvG11mTbIiIscpdc/vggwme6J6x1?=
 =?us-ascii?Q?DphM+gxKBWKTxyrNJ3CGfmXQvU8xDjlJAf8bLyX1ICnyJH5EkNB/CMnmouFm?=
 =?us-ascii?Q?tLsrbDII6ZuD0Uic/nLN5Y+EzgSHrpxMvkuulvuU+b4pYQLRK6f1ANXKfpIg?=
 =?us-ascii?Q?mCND2NKifozocXpopx5UQNoQqVFIdGh9cyuQHLqACvAWImRgfkYBjfgZWOpW?=
 =?us-ascii?Q?K8vYSlwoxOt1wZL1v8oSvF2T5G+6mmaYDhcNRagtlINp+geIvP8zhwPw3KNf?=
 =?us-ascii?Q?NYQEllw2pS9v8tsCtuUpCfPySAUdBgWDIFrK7esGQtxsWR7dhfvMcRADUgZr?=
 =?us-ascii?Q?q6oWYkxgCrRbcez95DIIgtZRSkv6mSTk411HBzPW/9xJSfHL85vsZsD+bw+S?=
 =?us-ascii?Q?Ls9qesPHPr0YVJ3wH+WoweF2684hpESKA3P7VdJg4uc0NzMB1GqNMKSF6LMQ?=
 =?us-ascii?Q?iWEf5Z/GOpGmvC8LJavRNIbLeZkEDJ39WiDI8CqyqBV0BF9Eo0Wyz69glzVn?=
 =?us-ascii?Q?vnLuNmbgWy2Rf+xN3P7GwwJSj0pICh9YZUS2e5zyNNi410rE/dioaNeolEXr?=
 =?us-ascii?Q?dGogvosBWBimKhYdcH7+vjYrn6EQd0ly2gwwLuTy4tVZGrj5ugt03ifOa/aF?=
 =?us-ascii?Q?YRvqO2fooNs7ByKJtX3HllqpFF3I4DMcbCxVPb33EHatR9gnBHhd0N9+6PLu?=
 =?us-ascii?Q?vhLegVcNHjhgf16WuhztoiqbaeIM19hxxpRlJd+bS3kE3aeTn4Y6wnfT6mEr?=
 =?us-ascii?Q?8FEOzfs98+mzaDcujifKBgaG4pqhF3PXNNE+UPTCjQmCeXXyqfgbNgXr21AU?=
 =?us-ascii?Q?YEcnKOENe2WdTGhQucsfMLq8bMCZXDldvLaHsjSwdvuRXNYeVJP5xob3wxM7?=
 =?us-ascii?Q?iWEKDsXnRQw67CQQEsvmpNrBySEXbBSeLDwkTB90+p7O2RuOF5KFWllYhRu+?=
 =?us-ascii?Q?83Woj8B4zeqJDtUG6+dscuSaoPAPxNibhveoBDcjfic3CqB0lSOO0uMo6qGQ?=
 =?us-ascii?Q?ed3yVWHkUxAWV8XLOq3yEwLIoB8tR8Y3Kj8Yeo1U3UeZvGN67AbATIpHbFA9?=
 =?us-ascii?Q?k42XBzMF1XBZzg1u74FLfFtfsZBk2u5uy/UGOALfkfV59tAwEH2idfzRi6ea?=
 =?us-ascii?Q?bKKTN6sn0TzLdx9+6ENMtYvvo0/+Sr3bWFqaqfaQ50IXgv6MnFAvIxTqmuHI?=
 =?us-ascii?Q?hvimSCkDFTaXZupjjvnVJ1pa1EAl2YlVdLA2pww46TErenpDVnlwu24rDXJR?=
 =?us-ascii?Q?m3UAUYaLw1+YGqh0u8HNeH08+3CzGwRJiYfCY/tMAnlA1/Np0Q6bCEF9vKwF?=
 =?us-ascii?Q?92++GPtdTSgG3yzFTJ2CCGjkgP+deUJ5YHw2dUXhzPNX/znSUc7dRPa/h7lj?=
 =?us-ascii?Q?Zx7lrGMAeZgVnya4aknvnh/64hJO5H8+XcTf0mOyog/McXkIm6LcE+AyC5b/?=
 =?us-ascii?Q?f2AsddhOOFmbfYuKq29oRbt05M/9QZMbnWvmKzct2BoNNtN56hK1vkymulEK?=
 =?us-ascii?Q?/1LDGkpOzX3Bhnqf4e6Cg/DdBF0SZjPvUKVrYXboylRpczB5YHeQUYvVoaK3?=
 =?us-ascii?Q?Ve17RU5BJx7QWGINHMaHJrUBA8CraAzvMfdOPe2Gqj8OMZ3zQuPe7RULN6NO?=
 =?us-ascii?Q?B+DrGOaQmxvNw6Ju3LrdiEW6m28+e1TLsH31Jqvqy/rL1E5IRig/8lcPUGuv?=
 =?us-ascii?Q?ckK9VLfFtQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CRkJxFVAOxnSvNkDM/pAuK9J9TuSJ3IeXH70irppEJRFqh4V9yOXaQdDNuznydlMn0nqtrS8LTe8IdHwBv9dP/5vPXszFPDRRsutGD0B8zRIc0vJLHedFN7doxo7km2Akh/AkLOyDFnYRwE9IO9Cdab94f93WSm8rIGAm8RfXRmB0AY4B9oCr4FXK/ULJvpqS/FFBY6IvHzNO9aofcwaSKdb0BO+GYt6K+AM5SPI0QejH7UnqyhmTrXr7aoJqW9PvFFqrzG2qU7PhZF+rl7g0so+lBu0tEaorswDub1APVBTCuEgpB82aKkQ6i2csBCY1jCxHI3wYG0XSdm/4guKlQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca6dbaa-a545-48c6-c20a-08de96af355a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 03:13:59.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itgtF+VGzDFP4wN30g96LqtByG8SzlLsyonNfZ8kougZal9akVbKhz4bGlFz8MwK+c3s5c4/A4sHzJkE1r4T4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7095
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, April 10, 2026 6:53 AM
>=20
> On Thu, Apr 09, 2026 at 03:45:26PM -0700, Nicolin Chen wrote:
>=20
> > One question regarding VM case: if a device is ats_always_on, while
> > VM somehow doesn't set nested_domain->enable_ats. Should the kernel
> > at least spit a warning, given that it would surely fail the device?
>=20
> No, just let break, the resulting failure has to be contained to the
> VM or the platform is broken..
>=20
> The HV can't turn on ATS because we it can't know what invalidations
> to push so not much other choice.
>=20

Taking about in theory - host can append a devtlb invalidation cmd
after iotlb invalidation (if vcmdq is not used)?
