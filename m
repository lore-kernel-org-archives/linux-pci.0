Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793951800;
	b=eyhN3NqXrqb/zG2ZfwxoNQHRpHksp3Xh9pF6UCmTY03wdjdcRSmio03TlV8aMpyOaKt7
	 DhEZqh+w2dAZEkLVOzMk6KofwpTv130uNM8Dgf9K+nAqjZtd39YgnAuRmlVbAf3+ncNq9
	 +nqJpC6AQRtsum39bzj5sDqznysGqtDGBpGbnq8K6fBfKZCDYYyqPCIoD4krDAg5fWtPv
	 VP7aCgo71zt52AatlqoPuJiPuGMdDWcsd3q9EBe97/Q0Q1O9wNRLNW1MmsPMdP5ofr7XE
	 JFaz4BGPE40AMEH3T4b8oEGuJa/ZToTePiLp8IrL6JlfxlTAcZ+WGLqh3MDXqmV4fjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951800;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=6T6z5x4IhOyYRLKWgrffiM7yFqTafPSADxmDhh/kQJA=;
	b=GI6eOTtYtdih7J40WTSCEFliicGimazIGV/dCweNtbt8kjtdMtM7eCqzouQUZXDCI+K/
	 e7i68WE6u8N/Fq2+lhCiEJU6HbYEF1QNUVcu241DoFODR+MDFPMgRpVx6yzKOvQeO9xbH
	 ELIHPOzTRKYgM0nClMRMXj0sGuCd1UvgJm8e3d/lx/BcJgpVVzDnBeS1tVfpEchNKib5N
	 o/1QL9PNQnQ5hILnL0CxkcDpttjAS7oJCaL+AJn06b+i1jtMJDRjvv6LkWQoZhe7rqBXY
	 O+ub5DAiUHjs2IR/yydgOhRBDTpMMyqYldM5ryWWQTmUNtgOe5eDje1ALJHpxHBXGGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RD0QWBCI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E4606A328;
	Fri,  6 Nov 2026 07:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0E4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RD0QWBCI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793951794; x=1825487794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gp1BlZqai+CwzNX/3689L96laLlHXDWtj+I/oOhdbMU=;
  b=RD0QWBCIUfjgWzMTHNzohzao6/oLR89HgiN3Y4ogjv6eKVKJe6MYwBxU
   UJp3pgid2xjiNgIxMgLuQMvMHfBQOT43Jv4Mk+Ysbc67vzy/K6qhDLfo0
   QZfAUKdLv3UVxvbUkQ7hh2bfvk3fxEJKfoDYWW8I3VM58Ms9WPso2XKRx
   9ZRoWYc2bTHudksqsEEGJRnk1CPhNAY9woX2S3p14GoOnHHYs90Lxzxnv
   8TQKvZb1n9T5qlf9TF7hkvAiC86RPOfAe2r19x2V8lEzjOWWBbDx91aVf
   T2ffmVhov6TnUjVZaiTOWqCVi+3EX1PF7s7XqBFggMd5cKH1R0HoerlQ4
   w==;
X-CSE-ConnectionGUID: /1oY61bBTKa7HgDNRcWYeA==
X-CSE-MsgGUID: KAyrHn7ISw+Fa+q2bkmJVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2751717"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2751717"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:56:33 -0800
X-CSE-ConnectionGUID: UcHisO39Q2Krw1xcYAl1eA==
X-CSE-MsgGUID: qhwsg5taQUejm+QJQEJ8Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7541049"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:56:32 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:56:29 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 23:56:29 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:56:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7gpy0vsr/kXMCzCZTsQbcNd0cxhj1RoGU5YddAN21EFnS6K5cfB/CWzZRXopbtVuUk0AjxVZAVf2vFma7ZnjHCzc+Xq5ybDp+KHrxiP/QOoj1PjMBQlACbbq98vlZ02DcQmD1ixGzRo9MuMGJ+XnDN4ovEEMVSj50J+TQtc3a0n6/rpJXJRc3myh7I4cbATwPHneJ1ODgOhu9qk1PsVYMulUeB6y2E/icZfBjGgPdIH+c5YQCFtxTgfw/+QtIuxw3ls28GvJ+ewmD+JnPbg31yTOBARuRWVOdXpOmgZUcwXXb/FBTJQtmCPLzRhN9rS6HEZGba8XVZhgnlEBHvxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T6z5x4IhOyYRLKWgrffiM7yFqTafPSADxmDhh/kQJA=;
 b=DBqwBU/xcyZ65qL0uP58dLxMYapue6wRCWN/7jzFrJJa0P0wzhI2mJCN/hMIql9kU7bMVS7mYmMn16QCZvXZ5ybL6opUCmp7sxoev7lOMTVBrfArBOxwguA7GNLMf5SRgUykfVMmzX1Hvyi4pYvAQxQGhRelZRWMEAM7vjDjgqToxeLMkbLTGuWEcNZOjrLPgWYin3VSWKOerCOxKcxX9MWuuCz89MkQ3r0bYmXLswKVnLUjozE0sXbe25gYbj23UXTBqykZKpU50IZZ4mxLgYz9jqDkOcz/A3E2peKD2pur6UppngbWIy3D1XPtbcAc3/udaec8WoXGI32rm6u+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA3PR11MB866706.namprd11.prod.outlook.com (2603:10b6:806:532::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 07:56:27 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 07:56:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: Alex Williamson <alex@shazbot.org>, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Jonathan Cameron
	<jic23@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy
	<vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Nicolin Chen
	<nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Thierry Reding <thierry.reding@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: RE: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Thread-Topic: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Thread-Index: AQHdbHg6xXjL5aZ9d0memJQCvEO+p7cgrT2g
Date: Fri, 6 Nov 2026 07:56:25 +0000
Message-ID: <CO1PR11MB483536F447DF311831A64D4D8C762@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-13-aneesh.kumar@kernel.org>
In-Reply-To: <20261104161632.3547423-13-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA3PR11MB866706:EE_
x-ms-office365-filtering-correlation-id: 99f23a6e-660a-486d-c27c-08df3bdb7528
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|10067099003|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006|261022105027099003|261026121527099003|261028144727099003|261102123227099003|261026140227099003|261021121427099003|261009223027099003|38070700021|261022075727099003;
x-microsoft-antispam-message-info: 9scOgteyWxEmbk+N7/FP7LsjkAH/D2Yl+lOOgPDcKaEtqKS1Pjv1rOaXhImYUOC1GH9ZTMzz+2Gl9fmQZ2zAOZRthyn8byapJ07iS//9tvbBt4qLWG56aEoWWdNZbV0Dz665iO9hOsiQ/aRI0DFfoefuFvab8Ecw60aoWEeQtOHP0BiztTHyS2gx+kFufkvQh9CmpotZHJ9uGl0/3YN3o+y0dkGUpcMHfG1wxljq5uoevS2BJtjPeTMwQ6xzhVLDASFT7muPkbvC8Q4A8rq/JhLVuhPnJ1GsnmeqQLc8AkhZMRTePOmfI2qXi7DdoACdgsFl7BrWlooXzfTCoHCr2zBhYYvoaFznGSQWMYWxi2DWEIv0R01OEnWSgay1anmIXTMIIeaThyc+cP+wtgzb4ApPHnhc+Ktpe10DDm0LPLytGxBN6W5rtFIAk9m0W+LWGoafZw4nWxdsyI9ZaLnp1XeZjUarQcGXtK+UsaUMCjzPA/TQBO6dZTJucIdqwTli0i6P4mciY8+LIzIBDgbbf8EGOreGm0cpnNpwneyO1qB6GFGntje4Z217XjtLZgA96ZTlyN3lCuscU+ntGq2P5ksaRGnVzXpMDfecHFySLrMqKQMGnUIZNfeFS2NBKYfxlrngs3QjkTr21oLgx/4+aLSY1flbFBbNbAUtUD/rEfa/moRHHmQt96XDtuc1dkuqAlPjLlA3KQCds7KU/5Qctk7gM+QIWuJjuId6qJUo9XU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261026140227099003)(261021121427099003)(261009223027099003)(38070700021)(261022075727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cbGKY/3NQzJCKU8FNMRkVbBxOAlpme/q4Vud8ehi6+z3L4NwquRLORarANIm?=
 =?us-ascii?Q?9RP514328FawUZFhOMHB7Qk6DMGl6BKbkMjPdQcePOIh0mrVj4rsSzfGcdNV?=
 =?us-ascii?Q?YUqqbTLRHXHA0IpZkAnCYzuUe1RK11XVZU91IlEdBLWtOD/f5wpmq53DRQSC?=
 =?us-ascii?Q?dgoGrgSzFYb36ZAi6wkI8BRAqDFpFmyMnyTtdlPOY4VQht8gz7MzdfmW/831?=
 =?us-ascii?Q?xCGvkXYDAaBJDeIQw23vbnH0SQyz7bNHdJT99tJMECzPhoHoCMiu86M0Hd26?=
 =?us-ascii?Q?cFpBt6Mbj50gXiDoJLN7RLLgvW1COEFJiKErarvHb7hmX4LUc3ejIgvAoOD3?=
 =?us-ascii?Q?8h1DFOpkYKO+XRIMTSv/2s+QFX4A0cJfDgaBu7D7DGZz//9MAIJ7hnApKzHz?=
 =?us-ascii?Q?XkQ+SzbtKYt3URNoTefH7b9Ur9d55RiTlEjkUyh/a909PeHWXwN2SwPTdqIp?=
 =?us-ascii?Q?9mLmsflMpbmhUId2Q74dRIri5FwSaD4Q4AXcuorC9joxsnklQMhHnUJJhd80?=
 =?us-ascii?Q?Md38djMhDb5D8fm2xXSLwRr2JPO3nj0+ECquNJKmBworV4nfZXyPLM3sgXB9?=
 =?us-ascii?Q?2Z9XGJkbrgANk2tpdvr8MLCmQRKTZFoNx1YsnB5EsOI2XzS5C7ZvLQKncafc?=
 =?us-ascii?Q?kBQ2TVpxZCDEe7ClFIkPEkel/UrKOf/KSejDb5DIviAkRfuoOHKRA+YX5u5F?=
 =?us-ascii?Q?oSbtSI5yKkKgVZQoVttid4qi/t6m/DVdB5A6+Nll7F8j6bR8/bVgK7LLDcJp?=
 =?us-ascii?Q?F+NUy7V8iG7NCvlCyJHSIHQ+LZsxNuE/eoDO8firReBaSGvdFUZFfa5EAmIc?=
 =?us-ascii?Q?Yhgkj2D6f4hg2+X3WWU1eCxEw44Z188BIPY3JS4n0ru64ZWnbmh3L6axs94d?=
 =?us-ascii?Q?jYZh2E2rppFPj3HrPnkghZiEZKQ/iN2ZiMxjosotX9+Hj/tEuzOKy1wR64+5?=
 =?us-ascii?Q?oDVbkPXg8QAYVOcA0/Ll2QUJHGcuREd1Bb4mnQkPof1srSPdkrwdYclTWGRS?=
 =?us-ascii?Q?Gdz8og2FlJc3/eHrrvfH02qWV+315khv64MgyAXnp3M5g3MMlqAt36D3ArWa?=
 =?us-ascii?Q?GhxCF0idgy2sw7+Eh6b2s9ZkK9rUlZXcJ9vR0wOvisAOspmc1AUyqZZq/yxy?=
 =?us-ascii?Q?VI6GN3Hgnoyk1KQEGp2vInz7ck5GDT8Q/BcJA07iI/vvZb9UTsvJF0jbsMHG?=
 =?us-ascii?Q?xFfnPahvKpDEeq5HtKVyi1cIfE4pbp6NZoqLZ9k9N/2xw4cBOyfTTq35TXfp?=
 =?us-ascii?Q?m8YoeaQqKVTJvvQ3NY7hBW6yElhbqbQkRqyJU90FeJ2eWxO0k4ZoEF0uzJdq?=
 =?us-ascii?Q?NBSrD2enx1p+PZVOPSP21w3wMKf1WHlpb6L0F5cNxfReyKI6VA7c9+02N8r/?=
 =?us-ascii?Q?YXpAOXjLAz9v5pN3ViG2JLcU8Qx7ceqkachdnhbgtMx9+ig9FyEM9JWqMD8z?=
 =?us-ascii?Q?1+kOPJrECmBYkBRMcnuE+5zeVM7RMSx4uKRIbaqKmaaYlO8YuDuLw+BV896k?=
 =?us-ascii?Q?JOLlKsaFVEU3H9rexJDiufDHSi2ptddMS9cwZFyrw2i0HypNre5FbqqcDBTS?=
 =?us-ascii?Q?KEQBJUfhe4FGjt0mmZpZKCR8htvtG2eUmhpqHHWiyJuVMGMCGa2ArvYfxc98?=
 =?us-ascii?Q?NJTZPG8Ob0cMGWrbPVpkvgutS9Mti8xmNCXxofo4aWuAvypKmSNe+/qRODyy?=
 =?us-ascii?Q?klDQJTjH56gUWiBkXgRZ8vKfmsw2OKdFk6Hjo4Vgbb5ttdBd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jrflsySgexLR2tOcXPfDLRG7ddk5lRGO0kPKESOgeLdwEX7MVWmKVE6kcgMolSO+xg5WAkffGf+oTkAKvQc6qnPwHhLYOLeADtTuxKyMEBqQvS4kS3wwETGUW2o8SChoFo0w+UsC6vT3Jw07LMkr04RAop9mmWZlZ9i/fhdJMhr2hg8wX/tx78Bitu2nmDRSd+l/QdD5ewW6rwK0ZmeJ4F5RXsOxcUWhUZutZS5b0BBy7e98Oicgs+oCqwMYbKITFFagNrB6w7wTyYtkWsY+OuyXmfaxuLpY+ofU3Pt15ipDH5FQ4lyT5N65CMIYon6vrectpehdrmIQtzDQhKVtTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f23a6e-660a-486d-c27c-08df3bdb7528
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:56:25.8886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWTw81DfvW++yndaRH1j1o2VRg8moeisUFMQIn0BcpQc332NMT18udfrX2n06Gwwchz3NYR6AUIxz9sUy0uwgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB866706
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Thursday, November 5, 2026 12:16 AM
>=20
> In confidential-computing configurations, a vIOMMU may be implemented by
> a TEE Security Manager rather than by the physical IOMMU driver. Such an

TSM is the firmware. Here it is the TSM driver.

> implementation also needs the TSM identity when creating and validating
> vdevices.
>=20
> Allow VIOMMU_ALLOC to first query the TSM associated with the target PCI
> device for vIOMMU operations. Fall back to the physical IOMMU driver
> when the TSM does not provide operations for the requested vIOMMU type.
>=20
> Resolve the PCI TSM association under pci_tsm_rwsem, pin the module
> providing the operations, and take a TSM device reference. Store the TSM
> device in the vIOMMU and release both references on allocation failure,

what does "both references" mean?

> fallback to the physical IOMMU driver, or vIOMMU destruction. Keep the
> module pinned until after dropping the device reference, since the final
> put may release the TSM device.
>=20
> The device reference preserves the TSM allocation. Backends providing
> vIOMMU operations must not unregister their TSM while the module is pinne=
d,
> since the reference does not prevent backend resource teardown.
>=20
> This enables the Realm vIOMMU implementation to provide its operations
> through the PCI TSM backend and retain the TSM identity needed by its
> vdevices.

It's not specific to Realm vIOMMU, and Realm is never explained in
prior patches.

> @@ -49,15 +52,33 @@ int iommufd_viommu_alloc_ioctl(struct
> iommufd_ucmd *ucmd)
>  		rc =3D -EOPNOTSUPP;
>  		goto out_put_idev;
>  	}
> -	if (!iommu_dev->ops->get_viommu_ops) {
> -		rc =3D -EOPNOTSUPP;
> +	tsm_dev =3D tsm_get_device(idev->dev);
> +	if (IS_ERR(tsm_dev)) {
> +		rc =3D PTR_ERR(tsm_dev);
> +		tsm_dev =3D NULL;
>  		goto out_put_idev;
>  	}

Is it legal to have a device connected in tsm (i.e. with a valid
pdev->tsm) but one wants to assign it to a non-confidential
guest using a non-cc vIOMMU type?

If yes we want to fallback to the physical IOMMU driver even
when tsm_get_device() returns an error.
