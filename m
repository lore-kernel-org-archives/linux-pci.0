Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4256935DA67;
	Thu, 19 Mar 2026 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887394; cv=fail; b=Eg/abCuMaLegCTgj8KHEGBm+xixLOpUwcCbHA6+MMmpLQM6zcAImTh43ouNKjdrb9J0QUI6NFHEQpf6/0zBdHF+TiT8PV3JQV8nHSSUzNF8k4oTLYw9weaueL9moylfT0DBvKrO5Gygl0sWyEzNajqhiISv+xnbBgyNA6Dpx3tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887394; c=relaxed/simple;
	bh=ZD6pmJLOtYFzYv68l6gdyABV0jSGcYMXdva92qbptMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPAegWUqYypT9S3YJnL78xUKz8x1LKGpjWiXqiRmS99FcrqJVQ0EKZ2POi5iDp1YQMgRX5tNB6KU0Y3f0yQtI00xuLTEDhgmBQfKbZDmTwpFPIWaPy2Sep8jbLD+bA6Nh+zPUJ9slGL44MKUxE0tp/qOeonqEy7ptFoO9NCd41o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOlddWcr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOlddWcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773887392; x=1805423392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZD6pmJLOtYFzYv68l6gdyABV0jSGcYMXdva92qbptMo=;
  b=fOlddWcrItF8iZOHmsHOLiMQ8ybHe9hO8afnU35HhPcqm19oFR4TDs9f
   4KdhLuuB9tDIL6i4svzFqn7LmfK2Fo2sCc281MOijW2ScEBuEMlzSAsb0
   g2FY8Dg3lPQA9IwZQ2qncleyNlwe8PzyZjl3CyWzFz2XYF6pzlPhCjRI5
   Va/dY2rch/RbUr/d1dZ/QvaM1tew0T3DggZhLWhC4FdUwpJHonlnPRGT5
   WN9reO19hZn0mnY/HA1PbHLA2Am0wag/powRhAcUv45GIECP2kj1bStzh
   q6BW+SkTF5eHKz03ku7mw/QuwjP7Vg1rF7xDe71MrbpUYrXyrszUEl2Ob
   g==;
X-CSE-ConnectionGUID: CCKO2LHTRD6vHs62wIgtAw==
X-CSE-MsgGUID: mcZwD8QLSnq2atZO1B6mTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85657769"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="85657769"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 19:29:43 -0700
X-CSE-ConnectionGUID: SUQdO5wnTTC69G6s7pf0zQ==
X-CSE-MsgGUID: TMG/v0HKSqGRBdiYK/JHMA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 19:29:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 19:29:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 19:29:42 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.13)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 19:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncJw4eaA1JyPIEJ7CMAANkq1ckn7oMYZY75UQxdhInpOyZXVaPkxFVdGN4FxMoI78ZP1kmXrH4nYoVkUjnWdx8z2REzhgR98n/McagcmwxPlIew67sFc4OPT2POSp6PzokMC3vffH1lowVmsiOpBSvUQ+zE4kZh/ICR+9V2AXYfaB7rCRG3/Z0h5/AEj3lJWy1CF342C66Rqo2QLWTHz+YKWZdpOXQa46fUObeJ+qzPKEuaJYpEicPRnP7QhFOnRIzplAucmXtBi+HGPKxl9HPZIvmaHQuaRG/psFHRz7UAav6u9/uTBSGWb+yZrXVomMFjLyPSCUQ2/x/vhgJWb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD6pmJLOtYFzYv68l6gdyABV0jSGcYMXdva92qbptMo=;
 b=Ijl+Y3vNKSm0ArUwSriQivsFtGLA/KzT+aDAtGsYl3qcpF+7eULzOdNHEuOURyqHBy2cqTa8qwcRwDnb3QEjOOecK3VQEua1faypOWmRjJuG5piEqMSJ7RXLkNgSTvV/7dx4dwXMqH7QYjCRlWK0jA8HNkn5uUq/vDj4r4H08cvzpNb8e7PWNfEXHS/ZH006oNuChxRWILuA43NHMnYQqhWeezjMbPxQE6lJv0so+tIClosOWbWBebMNIkQAB7s5k8LI5MW4mHWYqyiN8dAm2oeNQP8p4BNIaLrYUQQ/gZ5Ovn6DBXnVZ2b5805kelaYGE0az0SDKWSu+lTQsQ7mGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7597.namprd11.prod.outlook.com (2603:10b6:a03:4c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:29:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 02:29:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
Thread-Index: AQHctkKXc5nudtokhUmd4/hiAhcpbbWz6cEAgADOqQCAAGpAcA==
Date: Thu, 19 Mar 2026 02:29:38 +0000
Message-ID: <BN9PR11MB52764771C48B39C09F129F218C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52762F94146776026CA203248C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <absFXmFcpG8O7uNB@Asurada-Nvidia>
In-Reply-To: <absFXmFcpG8O7uNB@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7597:EE_
x-ms-office365-filtering-correlation-id: 3c77e3db-df4d-4f64-47bf-08de855f5e49
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: EltUyDCPpKW22gwip++xHWR5lTz7feFBST3ka5znKOJDAYaaMIi+XVJnEV2eCz44J18eZw7gZx2zOJ+BnqwnwCV3k+BxKjg0t6oELv5oH5bfeQMXdM070/113kBHtit7OXm2GnfVAnoECBNQzQA0nHVNB4ccG50ely7C5YHfK8wR1PdDoSRzxzA8EZ6YGMnoQOKNxM/kh3IOa4+QSrSIcTDWlKWwff9ySguqB2ahI4VQCUXriyUkLdJdLlTUSYyVq7BA1PNFyOBOfPdXkSvVSlq1XqNzGGtNgABkqnhepKNXr5970eW1Ee0Nw1cjn1Ko6lRRTbotZOBVz6Jm3/nwwAdYWOGdsHkj89jPwIwIxVtSsWtvrrqpUrZSnWzgdZ7N2XywTHcVK1kGtG4mbr3j+L7hCoL3eZoAzvq4Nv0QN+NZJhoHuhR/wcPYnNLQQpsdpeyNOyDFOhcscOPzQz+SfB2Y/8ZwGIHMWtfmiXgfAGNt00oIa7zS7q4uTdhSRmLxsWzFL/r/Ow7JWZqQRKowXO4IoRZGais2ti3jP8laGw/H5ZhafDqHoMAj2JKqgBFi3C/Jd/ijDj63wh3UM/vfxZRdHlgXfRn+hjviWam82qMwHO11wXYLVIoCEx0RkCgga13P0quPjDKr9YLzGOV/0YzutKAE8S8FsdGZDVtllpT9tNbl+TqbtJmQYOtlOh54tzjQismItpBrDFR6lmEYoA2w1EV3/biqatV/toapcwZsZRRqb9Fm5bb8+J8y0CzK83tfozaaodYLVBcksETQgocaYGNy6ooiVuHN8exFJsE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Nv5k5wdM5WXyFxsvSSEX9DpADeM9JEfhvnAkomVMihOjQ/jbAds3bTvwblo?=
 =?us-ascii?Q?7Y3v8NQZL2oR1xlct26e11Dk55E+fwlmrnYYQE2cwwJbPAFYjY8lfrOZhSSU?=
 =?us-ascii?Q?ODRNxQgSbLWuUBa66OPNt8pk0/nsSEtRD3VDTufS58jIpD8e/3MQYzztZGaC?=
 =?us-ascii?Q?O8ZtjcYMln7OgivaI2pJ5H5qtYovDVijJAcIr/Fnb74rvQE2HbbOZT//C77m?=
 =?us-ascii?Q?3TQtAIYw3LI2IOcRoO4Gt2nLPjvy8T5hbfctAyx3tKOyAPL3cft+yLKs0A2K?=
 =?us-ascii?Q?mqa2n72yr6hpcMJg84TXjHW1o7XbC2pWyKIHhTZsGjfx1cIY47TTTEkLHZX0?=
 =?us-ascii?Q?CmXdnD9p7Kg+CKxFTLjLN81Z4g9J4nxa7pKofblMH5lg49Hkt514ZOQvkkAV?=
 =?us-ascii?Q?rhd3DZS0QvEgTUuOVbRP8m9zdmYu2SR4GqwSctL0Py4BY3Lg6fm3uXLyy2Ne?=
 =?us-ascii?Q?vJTxvzjKMp2YkfZXETxgDJXaFc/pywbGVSEaeHATrPVBe0KcrOq+fgsu1ndl?=
 =?us-ascii?Q?xIn+OXKliuV5tZ2SRkKOWYoCN42powTagHwXDKO5zIxHRPbLVle2OUnXBGm1?=
 =?us-ascii?Q?FqmTZBgVOUlFAMGA19wr1e3mCspuBB0gRTElylz6mFAEr5qmq8IMV2BHOKFZ?=
 =?us-ascii?Q?voUAtY46uakI0x26myU72hLElKdXAyV9LERkNAPWuUXmyGG6nUkWLNOtae06?=
 =?us-ascii?Q?dObqpXVQKS/8O3WYOelhmphFU+XENmITPyjUfim1cqC4UStSYBBW6ii7Usfh?=
 =?us-ascii?Q?4bCRE7it7mMuLHcXCEhMdfUayS7ob3Qr6ve3Mcp4hCfyynn1an4RzBCETQOo?=
 =?us-ascii?Q?TZjM+aoH/45U0O4NtkGeHb6F7JLqHqOxpB9sgF17jd+kRmBaIGYiRezdG7/+?=
 =?us-ascii?Q?+j98Vlq0cWWTUSBigDQ8pTwKcCeQCWAmu0ilYpb4nMcME3i7WLUskeO6qGj2?=
 =?us-ascii?Q?AaU37fpjeMze0tv+ruS5vWWaw4QfO/rZ0+ORYPyS/VDaVxGBE/ZfTB2X+YEg?=
 =?us-ascii?Q?cu52ueGmQEhubSpT9qAKZMDrprIhjpx3EqmjK58zZ1jbjb9oJRZ73Qos6mDO?=
 =?us-ascii?Q?L+ZL0qq55CwqanePvCUynMsMuswtAG+T1QdVipExHatCZxIomom7vpxihjW2?=
 =?us-ascii?Q?e0dhi+ZZiIQEV3Q9nbRPn17mOCxvUtnw+ykEyCDkvhWKT7fQ/IZ0QSK1DDZl?=
 =?us-ascii?Q?CtOkNR64KHvfu4rE/Dys6EK1/V+6nW75+Zsxhu8bRVXohJiGrT5BL7UONCn3?=
 =?us-ascii?Q?9upMl8OzM7kF/1JzKPyQzVz4MyEUVNjUDUPMDpnoA7JSFS2Hc369ObotLZ3+?=
 =?us-ascii?Q?CiyMU7PYseKuD6olkRYIAWasqZon1MoKwiMZxV56hzP8EMjqOyFiVICnR1SM?=
 =?us-ascii?Q?IWIpGibodZqpDBiKIEvD0XP5Tc9jk1oVOD8abX4IasHRjq/hSIRNCxpltiyI?=
 =?us-ascii?Q?RJoK0F9Hs2s+A+b7p1xFTrjh6Pw2IKxrhL9cwPSZCCWrmsVWbUrQUN88iThs?=
 =?us-ascii?Q?jG3HgZTHhJR6g0OKV/VCCcDJqxXNitTH7mUjNUSF3zPcDVt8Pz+evQxfkrNu?=
 =?us-ascii?Q?pKmtSlx7kSSSN8P2837K9+fuYtz3kEzUXQLN24A4GgDHSn81+AjJ1JdyDqvu?=
 =?us-ascii?Q?22Dl+46S3LtXrBjtDGh1penYmaGo89oMeHPhQ0NBQpRqEsmv9t3IPvhRCQB+?=
 =?us-ascii?Q?FEsqk/cj2rdxjvV9l/5r8KlqtPAvaQCpcidK5KPaK6j56j4fT8GlVU4dNr+A?=
 =?us-ascii?Q?/VJcuL4Syg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U2Dyt5EylkKD7KrYF14ypna9UQOen+2HC7QHBOTwufvCJWx9Au6UM/DOCCyNLj/SkH/yRe1THyqbl5pq+XDywLniHaZ2KmkRM+Mkr/s1AWDgI2pGFg8PTZA3SYuC5xm0FttbwgtrAfHl9wClYf4Ug65qc7fjKiO2dzQiWKzYbFV1gG/frjBKNp5EFtYqWphPaBAukgAGZUeolNMtHfZD5/Czslp+2K5LM3aTFf1oPIj+WW9rGm45+xE+7CfOV7lThYv8DovQ4IDu3MjF8RwlgkULxyHYxP36/NT2Y6tyAvx4aXSBvkvKNW2gm9DQ9dG3O4NoaELZQLE8nc7aYoy40w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c77e3db-df4d-4f64-47bf-08de855f5e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 02:29:38.3321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xo+dhtGu2tUiCugxpP8WjpjdXvmXRyOVdpFTWmA+oxM/6hhQvhsWmaUAHxw6QjIbZ0paV50s09642h8emio9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7597
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, March 19, 2026 4:05 AM
>=20
> On Wed, Mar 18, 2026 at 07:47:18AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, March 18, 2026 3:16 AM
> > >
> > > Hi all,
> > >
> > > This series addresses a critical vulnerability and stability issue wh=
ere an
> > > unresponsive PCIe device failing to process ATC (Address Translation
> Cache)
> > > invalidation requests leads to silent data corruption and continuous
> SMMU
> > > CMDQ error spam.
> > >
> >
> > None of the patches in this series contains a Fixed tag and cc stable.
>=20
> Hmm, I guess AI overly polished the cover letter so it sounds too
> strong?
>=20
> This is essentially a vulnerability (potential memory corruption).
> And none of these patches actually fixes any regression. The PATCH
> 7 even requires the arm_smmu_invs series which has not been merged
> yet :-/
>=20

Fixes tag and backporting are not just for regression. People certainly
want to see reported vulnerabilities fixed in stable kernels...

