Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1D3DC852;
	Fri, 17 Jul 2026 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275335; cv=fail; b=omqNOzruAm9CUL6x/FlPQLS9OtWdNJdqDU5UBO91IuZJ07IsQvW6U7QlYGkaE98nSPp5LZjCKK429NhjSihodXVL8cAcEp/aJHH+HZcz0SipiY4BE6wYp+1PLkFDIjVNsKXsie2YAJCjfCw5ZMP0jXmVE1GQbxYYTv4RqA8CMU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275335; c=relaxed/simple;
	bh=jJL/HLu4mMj9/upMyN1WbN/Wr81t7SMgGrnz7X8Dx5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JdCmSoS1Gwqj+fw+crmc6pprRQdbV+k+e29iyJ8Y/8KUdbras33h9WAG9zoF9wnR3QbQ6a0guJamYmwgtuEa392hRSSOAb+DLVAeXbqgusW64bjZH/snf7dQfKgpcdH4qwaUdVu3e+p5xXEdRhxHiT3bfKg+vefAHKxC6HX/IaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDQ/j0Oh; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDQ/j0Oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275334; x=1815811334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jJL/HLu4mMj9/upMyN1WbN/Wr81t7SMgGrnz7X8Dx5Y=;
  b=gDQ/j0Oh17/2t+ggFE4i4bE/pjXwBCUfF3t/8MrvBuxjzYaCLmAa0YOV
   mCQSswhwK67DVOzMadxnrgZEDr9xPsbQgUZNNkOSWeoehn61IGxNlzocP
   4bOCLZUQUcKQEifymApkI/FweUP4hBI8ODDIT953q/+ghInWriHRrwi6b
   25aXjcAvKDGvCCv2PhPNQdpfpT36xDl9zB98Fes6wPEoFmxDM9XYORID4
   aS2CP1UPmjTT11zluN9aXI5NnoGcbwmNt/2UPWrnPIPDsdw2btYxpptb2
   qwipPeh5vM3x4tzASJiD58g6HonCuiIRip0WrJljSslZ0hL0EKrBbcZYM
   A==;
X-CSE-ConnectionGUID: 9lKBbGghSsiYtptSB9RgPA==
X-CSE-MsgGUID: 88++2MTxSvOwKr+9PKsn/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85036127"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85036127"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:02:12 -0700
X-CSE-ConnectionGUID: KCN+ZmJ6TNCf7xtl1knCbA==
X-CSE-MsgGUID: ftQ2rsXhSg6yyTeas81uJA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:02:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:02:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:02:10 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.15)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:02:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsTWg+V0EKcn3IGAnkahUC40I+nMLVbbHGKZgTdXu9bu4faHf+zh+GSCFL4PyHO6Zd8q6ayujr34d+oEKbjp5PM84wzTls5F+a813qFaM67HOF/XsTczcuWI/JPozTGZ5pRk1uZPUlR5slly6eWpQkL8BhiFfYNQgxvYytNrgwCD0dZcYugem8T/udoHY3kOyWu+x3XXbvaOoVRHBlOUJF5kgPxLTPwlQfAYrIiTP/2US8USi0uob+ke5L8K8RAWys/HmPbntjjKHLuwxNnPVQ1N06R9RE+mwro6T9iCv3bmfuhIJqMcssSTQUpWTeM52mX9/g2EbVvZo/ZS7LQwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJL/HLu4mMj9/upMyN1WbN/Wr81t7SMgGrnz7X8Dx5Y=;
 b=JSdPWSnFYyJ/5hcT2kKkQ+UQhnchsDLGWx+mg2+wGQe7b6hqKIFhcBlHbMTjrKArfYrtk5HRGYEdGpDNNg/0TuLn0uKBODcOq68HtQ6zxrHuuV07LZbTfAdxUKzv1H7BcffFqahd/c0k9wnCh6lyX+dEzduO2kthhS7+O847+KpHAjWH6gBpkywlQHbEJt7Uz3Xxfo/Y+v3QpVqLocsi4TZtqA6kujAp+jEQQNhYVxj8j+GkQ+e4cNznEFQEgKxYQg5n6KtmGpLc8rxqUno6YrOG8/Gbn0YyaWUN9FRKz098PMnIQQhOMLB5hzJUrBosqtCZ9Zxsa8GZjMb3ucIVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:02:04 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:02:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>, "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro
	<amastro@fb.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
	<christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>
CC: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair Popple
	<apopple@nvidia.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Thread-Topic: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Thread-Index: AQHdFIIdvrzyk9/J/0mOPkEUyzecNrZxW7NA
Date: Fri, 17 Jul 2026 08:02:04 +0000
Message-ID: <SA2PR11MB4844CD49C4833D80C27C2CA58CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-2-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-2-matt@ozlabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: f23fbeed-4ad9-402f-836b-08dee3d9b0a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006|4143699003|921020;
x-microsoft-antispam-message-info: iG9JkxZ5arSp8ZZybzHa0miweIO9K2LELncSjuzTrlsCQuFLC7+ET91OPKx2o38kAXjYSSWSH2BdD3/208KFUw5eXb1d0dVZDPIvZ0ohqel9rVint4VKudrFSYvKVIpizMlLgW9PPgeJ5A95b+JR7pZPQAI8aHjFm5QXWREXGHQWBNbsQJRnamY9mSyn4PcYeI0Btjxo6glcn6Ga+zd1bpVsOKzaPvaQ0e8a1OwfYeqs04Dh7vm6pxGSpFEKlkzuQZ5LGFpzbg+9567HSx/GNZQ2hEfnK1ql/wnM2QsnWGgM3He0pyT37H4bewC6R20F1rIxV8Lae6N0R08qkE4nwSMEn3IrBReMXtLImy8DDZNsNRLLGKHUapX8dZXFGr3GlAPlV3fkoow+J5VaK+JP93S2vG8X5RMkdAcn4/u1TB0gIJL/MvGsFbMwSwsDV88y6qq5YZ8tRaEspbWHPTK1NJzF++C0obXB9rUYyGOQy4K67+1uB7xNljlbzi1apfkXN6EqMrWCypmmDbqbJQAynsr9miNBQwP659k4Jbr2vP4UImMPXVlX7DbokTs7DrDu159bAc6dhTu8JYm+9Y+FQ7RS+p4y1pLN572e3vt2GCubsD2H9nfE6prAMuHIRY7bhoCBUvVMexWCNkUH1mLXU5EadVUCw33wcUXuOrsNhCitC+aFcpkEkVXz7+g06AFSzG/zBcJlxmeXLVqNEE+5NXW7fQrOytdkd/Yxczl128zB0mOTTVylp1rt+FQCZG19
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tFEWJyMbCmGOK8EjkFJ/WrwIBsgV0lqYWUbrlK/1X+RNN7IDvfk+dtWOta?=
 =?iso-8859-1?Q?QGWcXh5IH/V2bX3Ph8gd1ccKpvpWzUmgvV8aamgSXpqPeKD10UauSFOX9C?=
 =?iso-8859-1?Q?VO0mtLfaW/pYy6uHKa1ziMQu14GmAD4sOuCSVUoq/e1+SltXJE2LJn6+0/?=
 =?iso-8859-1?Q?rHIs4UKLPybj7VceS06GUStfAhCPkYKVs8CrlD1IlkVM9D1QzfZRr4zr09?=
 =?iso-8859-1?Q?bvqA5eL55XkgxaYwkD0YEwpayyXYKpnGOgPXactCb8hHc2Y4P+FaSjDYEN?=
 =?iso-8859-1?Q?8peRPrJ2AjpSIZZGUcsdvxFwSaoAGxEJKHy6p3zum+tX5T1evm9rp02y1H?=
 =?iso-8859-1?Q?9ZQZ39whY+rLCxgnmSe4kjQxm8mk+IUt9/9xuhYHy2IP3ijBCY4jZD4aXY?=
 =?iso-8859-1?Q?k1jCkR/t7XPKqljjmtLAHVJIummsW+9m9RZHOYJXgWGzPj/wnaviuB0cjJ?=
 =?iso-8859-1?Q?fqzgcMCkacRa5XnTHmF524EMKGSmMuGXy6jgmgaBKg4yFtsGeZgx+yPYJY?=
 =?iso-8859-1?Q?eIa1oa22p/s9KOvXFGf3051DtY1UuW+EOc5RkK/K/LEUlcISMPhOTH9FOE?=
 =?iso-8859-1?Q?9t3uLYuWhbXtJ0Dln5FPPBqZ/hQXsooAzk1J94kdW6zQRpchV9UQCp7SMf?=
 =?iso-8859-1?Q?+ByGYgAvKBqo/K57y5SgYFn62uBC394yCKl9Z8GRY8wLVx0+Pw2Fe9vnWh?=
 =?iso-8859-1?Q?xnPlj3INXsS4r9ngdHtP3Hq+49IChlaqAGUc9/kdRULYrR+iWz+IwejX7B?=
 =?iso-8859-1?Q?9GlmEgf+3C0NQ5VzWKcJtdxivf0LHCn/bFfVK6EqDJIpqN9vPIHmueGyTc?=
 =?iso-8859-1?Q?MkR28H6dijGKezFRKPDBwXZciLYKWuxqKJOwpQWYJFSRO6lwAzUcNkB9Nb?=
 =?iso-8859-1?Q?q64AFtt+NzDFQyciAyYWVAvHsfgZjfGNAwsYIlVAfIraJhdkjOQT4zbnr+?=
 =?iso-8859-1?Q?uRqC9BjJYfUifIyV699KxzY/VOHuMhoVyqc6pSNNmTHQfQPNJ0Je2c/LTa?=
 =?iso-8859-1?Q?mrVHQgR/Cgxc3F73pLd/cuC1NuGemH5rZV8IX/g6+nPmfvdEEdmcnDcksK?=
 =?iso-8859-1?Q?PMh+hN9kG7Rk6Jz9DGFFcFeg6vkfkN9zTDyQ0RvpjcFyvHPcwx61kpN+FD?=
 =?iso-8859-1?Q?k7xEBVtZfHzdaaCph15wZP/vSKoB7zMwc2gGGa/kPqaz81Fwzxu+QOU7mO?=
 =?iso-8859-1?Q?Rn68hZ7ZUNRqKpu/XQVpxO3ApnOSpyAKwcdfcrIgFXe/PjVAAre9pGW+ID?=
 =?iso-8859-1?Q?wLFiSXKOxqSanpi/OJfTcN46Xz5PbkAHVyJ7oyjzO78K9LOR34Ba1C5i/R?=
 =?iso-8859-1?Q?E6sx/W+BVzAnHHnvvzMayk7b7eefkPBDfhhZLqq8wvprxNu8oKsnEZpSP8?=
 =?iso-8859-1?Q?E7sSEQzZQ3ecB17jKgutdk9/v4AhczS0Afxya4l5nCY8SRE/NEkitBOeaI?=
 =?iso-8859-1?Q?M/K6fgsES3JtBnS7zsX8fwVv9PKwh8Iqhqei6Zk50AALfN71HhP5zSF01P?=
 =?iso-8859-1?Q?ZSN2tnvWdwt2I7Gs9VVtHmIgXElKCnHJ0Fl7QbrkqYHSXCovsOvzU3YXIO?=
 =?iso-8859-1?Q?1ZQ5FfB22xznAqMLsaRTvV/LB7oCIXn2jc8Mos7xNWvyGPcgrl2pbqMVmr?=
 =?iso-8859-1?Q?HrZ+IB9EAn2hdGbKdLI9s0tqTp6aOdi8UqzU4CSs+zGcDPokC2sUn7gtRH?=
 =?iso-8859-1?Q?UqkvgbB6ISEnuwDiR5eP/09qSv5TGpcHeuAPgS2DygqXhtTz98vue3PsG7?=
 =?iso-8859-1?Q?QzpTiuotPP/WbYSmWlih2iEnAL92oqNqChPWp2qF6boj7s?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qk02GjSPIdh3RDkWQtRWTYCXoeZyW3dL5JSOBmrA+YZQTKmmuHe4bWTXTDFwVGjLoC7gzXltGnSoWwNvCVlUMfqrBBcU3osiIanMV81U0vNt26am8L5sQaODD2+4LH/clOX7gLFNCQKwVN2KBL9M0ARWq5IGbdERLdonzUktNaizJugjiYDCcovsrMOH7eraRqUSYpFFixyGw/oivN3z5JkwyAcGvCYuZul7/ad67AvkW6iD5YmXJ49Da6cjcFk6Q51k7Z2yFeoxA9RPfaH1zQ2rV4XEwTvtoPxVbtoY9MDlheL0XL1NwCs8XFCn5vihkhrA2LiZ99VeQU3521+E2A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23fbeed-4ad9-402f-836b-08dee3d9b0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:02:04.4132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8D2sF3LhHmw5gVSXqoP506AGO6ueAXT6c6Nul21sJ+h3XijB0DcgFE2+c9MP9ZqYc+0hv8U/pG3Mpl64LwmnbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com

> From: Matt Evans <matt@ozlabs.org>
> Sent: Thursday, July 16, 2026 1:47 AM
>=20
> Preparing for a refactor in a subsequent patch, split the pool-related
> release code into a new pci_p2pdma_release_pool() function.
>=20
> This allows future compile-time selection of a null implementation for
> pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
> P2P-related files.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
