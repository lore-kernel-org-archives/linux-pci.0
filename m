Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024C3DCD80;
	Fri, 17 Jul 2026 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275398; cv=fail; b=XvfvwWwgmccyccRjqyNfpv5C2rZLj0m9BZcnmcHz61RFPkkC7QE+JVmfoZzlTI4GaT2vqfS9Z3eTRhqdjYnlFlXzQ/coCJZ2kGFAXNlUXukCcIwEYF0e+L/bv0cLn8RDV+Np+l1J9rTh9nBawsHq9NA8gezY61qrdmIcJPervTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275398; c=relaxed/simple;
	bh=2nQJBIdLuKhJCCPS2ctl69CbfPToLc2SgyD+b9x5wyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pcW5q5qRzaf3nZAbJ9zMX03Tu1cMSLu2GNMM6eCgyCpGxjLlU36IOv1dOnC9FEyGZ8nqg++f1dHzVxNIv30qGT7FjL0h3ke5DLYOWhx4lY2ZiB/5nk0uFpgO2LPDhznSSfRx1girxPLI2pfWlXZHLc8lIYJ+Ba+b3tXXdfDRqd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fluK6bXs; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fluK6bXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275397; x=1815811397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2nQJBIdLuKhJCCPS2ctl69CbfPToLc2SgyD+b9x5wyA=;
  b=fluK6bXs5zubGa8inXPnFlRICBnseryiQpV6j2zD5jmAdLu1aOs+6jqR
   su9dB0/leUsPUKWgp6ycQzLfrASuP8Em1IFbCzj9J+Cs5TEpEkf4fItDU
   0ptPBQNpRfxnGjK8VeRhruS4q5hRahLoxk6kZ/AzzsFRjwzfOMWH8se7Y
   12pQ9qgH2dgOFvDQ51HU2zYhl9cTGhlrQBYn6Ge/MTi3XuAQrJepJ9H2x
   yU+7SkfyunwwHDgKIplWce6T5Y+FuZ+HrfraaXmfhfjRtzMbLPCf3nmEv
   epqzp97r1AUj/LeciNNyCcugl+RGEGMWd04sLJXXxGCFHp8uW/1DKzxOb
   g==;
X-CSE-ConnectionGUID: cIpmjr4cQmyWBHtudwTGaw==
X-CSE-MsgGUID: 7U38jq9kQIGPx7ZUj7Q/hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85036310"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85036310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:03:16 -0700
X-CSE-ConnectionGUID: QodQjsMYTn6TarB/VRZPPg==
X-CSE-MsgGUID: TpfaJxEZQ6mXS+8jdwHU/A==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:03:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:03:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:03:14 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:03:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+ymlTx2BwXE4YdnQydNYRlH8y3vwBBKqysbFybgWEDaRDEzGwdDkZ/VQFhdzbT/NkDDbhIHj9o6pOxIxyozS74Z3Ya4fZBk0qk0+TWkJwg95S3frA11MHaDfOpfdPVb4Hd/lITjwHJBGGnAG3gnFAR4OQrdkHSkxaTYhzlv/ErcmW31g/vnQIl394hXyLjeEdmyIscGAP60UNtbaSIvKvWMmOFRDGGpxqHNnELPaW3OxLhNcrvA4dAsnc8hZahvixMxOtpwhJnO+W7aaGI1zoondCgKhWkB2ZDPEf6wwDDVNb+2nZFjYmzf3O8K/w9gi3wa7G9CKQ94jfs5O4Blww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2jGqlKh91Zgf02kDJIMN91wBPGQ+BwHHah+u1UJ3tY=;
 b=Q2l3Nmt1PHXfeIyLmg+ZnaP3vdKRzTQkxRN+2pdZfeTTFfwzCiBIWbkB46aeCUm/0SGLosbDZd05ZmGx55trjj+X0caPH3Yeifj0PuB3iYQx5c14+zUUDRe0fp6BM7IzrljEFI4ICrtw3pOVmwkJQlPBiJN5ukbYVLKBwjCulQJx3fiNaMDmjtBIPAvyndTs4uuHaQOfD6XatSolDuccAsFOdDi35cCXZ8yRDPXlt/PPRPwATgQ11mJ+F49S9QNdvWApUOnZq2pqI7C9+na28OR+UwF2/h6fG5dsN/qBt7MicySkZWR58z6XSBQwX2+ubJKdTfYA0QqJhyg/xF5Rbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:03:11 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:03:11 +0000
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
Subject: RE: [PATCH v5 6/9] vfio/pci: Provide a user-facing name for BAR
 mappings
Thread-Topic: [PATCH v5 6/9] vfio/pci: Provide a user-facing name for BAR
 mappings
Thread-Index: AQHdFII0acwcVEw5J0G2C4d89vkdVrZxXFig
Date: Fri, 17 Jul 2026 08:03:10 +0000
Message-ID: <SA2PR11MB48446374427C311B452A84B98CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-7-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-7-matt@ozlabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: 54e7cc04-36d6-4f4c-c3bd-08dee3d9d84b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006|4143699003|921020;
x-microsoft-antispam-message-info: gS8B2H9TWkG/QrZnpr4rmhzEDUyhklCP/hFv9ZBp4AFvMRS2gTpkSicjbVgj8Zc7JbOYKMpXwbdZ8qyjk0hBFfeYcJnscfF2ae9isVePGSjoatbvIjpAu9JgqlqtaDgAWY+znUrcEZdP/FH/XQI0MEJO2vgl1sko5xvDCXR6XSpOAsR3Obz4F8dNF7H8KSiViF44GqwahvfamkZd+Fqexid2WG+zN3Ot4gXGX4TDINr+jvBDIcW/1DcDo2pTluy0d2uPyzp97sX7mGuXyo0q0k2Rr4mSDppXBArcpIlVJjj2WrhqywfSYXQr8hyPA9dA6/fApMUGuwtwj7D+VbeZXIWLh3mM4t0y2ORybae+b+TrsioC4RjSb3ETzbm/1+LZcYGFPIcQD8mLHthA7oMjW0VqyL3C2qVJcu4j4ZJ6MJB6VfIipJNJhkjaVIJSIp/V6kHygmCSOc1hX/jgV9TK4ka41bT8yqr+LPWcPSs6ng/EuiB4/IYUxZC33SjEDTFmwK/9WtpDqOfA8LLKhEsvx635Gt7jv7ftG4/SI4KLAooAwvRluTFMtePqiqxiVnGIyWGVSD8ZTH9HVcA+QS1XbkqmU4lsuCqn5AarkWteH/ZMU/fDWpnUjWYI4OD8S7FJI6HVVLAMZ3n/tzN/MllG0YUaC+XxGW045m7F7OYnEo7vyLgtYqgMH5IbUeQqUqo1LB7+yE/zRVkUa0HdygfhkAtJZblILTLiM4AFRVonRS12GyAgBJac9XQbBr/rK8ep
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OblqCyLoL+mglfFTso2SjrNuxnqkBbx1aYmbNM8jJwgOQq8JeA78PXGhly?=
 =?iso-8859-1?Q?ZgewibSgUiEYv9LKPGIj1zK0aumjMYZ0kxvZiUe7ECo2Sh4tWvZY9YnBzd?=
 =?iso-8859-1?Q?9gAkizu0wQUUByCYQP2flI512n0dF6pMsJg3a7ciOEqohSCseTO67/+pOs?=
 =?iso-8859-1?Q?zn8o5dUJdDLqV+oEGnZPXAoZCDGqNgSfuUrn75weNt7KVfZA0F+p0n3JjK?=
 =?iso-8859-1?Q?65CLy5ADfj5bNSHFZonDm6X5qp4iccm8a13YC9et/q6D2QpGeJZGRmb37F?=
 =?iso-8859-1?Q?yvd4xc32c3lg8sYjZ9ig7vBl0Q9Qq1FGlOsMrrNo6ESLQvm9Z+jypINwbf?=
 =?iso-8859-1?Q?WkrUT5YnEvEgIQ22p//wjJRPEnl7eq3K0D308boaeR9LNYGFUyl5Wz/2Gk?=
 =?iso-8859-1?Q?9vUM0RwL8O1HlNmhvO67hWAfdVltTeLLDG7oHeQawrvndQYeF9+7MMAl+I?=
 =?iso-8859-1?Q?BepLlQL0JoIsnq6chppym8KJFlCChLDN0IGWs9lkrpDrQN9bgORtMLD4Ic?=
 =?iso-8859-1?Q?rxsbB/4t9p4riUVNnJBBtGgj8d5rgEFHSg6Hab+dqG5TyT4JhMPCbVz3VK?=
 =?iso-8859-1?Q?6V67P+wUTms7eCi/Sz38IjrQunBFBY0++iBR1lDGVhqPW5nfCMEhExDJmI?=
 =?iso-8859-1?Q?c/uwackyVFpcNH6bfr/UHaGSXl/CeCh3zeBQzbeWXLrb7m1DT7/25/6hQ2?=
 =?iso-8859-1?Q?J5rZMPrcwjh9M+f+uMasY7s8wYPb+P3hR/VntsXyLKGviQBv/X7Yiiz/Ph?=
 =?iso-8859-1?Q?nYUk3Pn7IQQ2iqI3G4FczxrwvNdcxgJDqiAdvQpLIADjQheAvNvjdAMUTp?=
 =?iso-8859-1?Q?03+Se8abmPGZFPfmC3D2XNRFrT1g5LRBeQDahbEaC2moi2Bo/fRylwwstB?=
 =?iso-8859-1?Q?7q4JcdEIHdmfHUyeveSVfxNJkZ5T/IEl3M+4msj5JC0vK/Y+SXsgKO7MpB?=
 =?iso-8859-1?Q?waOnvGkuTtY5DSXI60azMFqeJhpLuNV8+rHTDj0qySzVNEf/ZJ4AFB0ODN?=
 =?iso-8859-1?Q?SDQxr0+JmFDSZJfdbEySIVu+csR/71moyy9B34Jrd6oAt//Twh83B2Dx4z?=
 =?iso-8859-1?Q?hS03pJGT+4u1xd7iAnIw95xhX8xlK8Hs2kEAIrXGL9mRhOttMcd/9SVfA0?=
 =?iso-8859-1?Q?Xildds2xMXhOXOUgAkJ+sSJROlBIdwPhz8C0LpJMD5KSP9fKfImyY4ldQI?=
 =?iso-8859-1?Q?GT1coc8kdTJXZwgFnwRodpjJVucO8/gKRgvHG1R3VKDxLZ94m9oInQhOgq?=
 =?iso-8859-1?Q?2qf1kRqXVN1V5rtxq+CC4giMqrgg1XSd77wP8z2f0RgR7DY83bTvqAh9bL?=
 =?iso-8859-1?Q?Kfsx7nd5lr06kpj9mDsWaN14/Ha5KTihn5KZjEsQWFAwBwjUM5HnRc6B7p?=
 =?iso-8859-1?Q?yFm8mL93i7H25rv5+AB2/zAYlj8Lj5nxAXBAq2pxbHzwRGuRrgJpPe1sai?=
 =?iso-8859-1?Q?fF83ITksZUmiXQ94HWDA8xh6ndbbw8lBcdlaQro7TQ5avbF+YeUqBOGFTB?=
 =?iso-8859-1?Q?lFmpHpc2nnTmecGWnj3i3nNPRdV9F/DGbuC18Qrta/1cAG3ivFvvlSnb69?=
 =?iso-8859-1?Q?xBLsW9iobHcOaJZWcsZcaklRoz8iFKt4i/IBCo74BUTdQr4woqzAT7w5ft?=
 =?iso-8859-1?Q?TRj8ob/3f2P/EZL1ntLtBP1GKdskRaN4eF0mnBVZRqqcNPKK7F3aIxGoLc?=
 =?iso-8859-1?Q?6NM0B5vZVqavQ+q5TEe4Oz4qtf28jpSGmLV8C2wrfHaMLRSZUIBVqWPArg?=
 =?iso-8859-1?Q?+Di0cxKF12XdIfSM7gw5PZYaTnEOSArWwlHNqZfA0HGG/q?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XB1vXPht0iPwH+j/LvRr7f3M+RGtPZSRGQL8Dnh4x/K+IE6CBgVCy5qw6gVP7umqFtbBghkE45h3mOQlxhNkpZjrHE1CTnN+oU0s3k198qWVxnH/55MienCjWuVF5EwgoOg+dslXX672AfhyLLZW+O8VfqRyY7uwoJKBmg7UWMOcJfpGtkXygApcYFm+0v5YvwYrAgqIJaFzD/UMTVc4BpUTLdTMD52k9y1/3u9zaxEgCSPCwVC/3lbu4K5YLKm+3IHeH+zE720X9s54luhZmJNhUTH16vIU1qBZ22QQ7oAVwHD3Eka0S8mHl7wt9NnpiTzkIJb2ZEIc/clYXAGVmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e7cc04-36d6-4f4c-c3bd-08dee3d9d84b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:03:10.9093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4B/9EWtynrV/y1d3vMLrG1LEyFZC8t/ddt/yGxkvu3/Xmm5PznvVkpRYh4cpMPkSS9hV4meb9cLk9meDQEWQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com

> From: Matt Evans <matt@ozlabs.org>
> Sent: Thursday, July 16, 2026 1:47 AM
>=20
> Since converting BAR mmap()s to using DMABUFs, we lose the original
> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
>=20
> This applies only to BAR mappings via the VFIO device fd, as
> explicitly-exported DMABUFs are named by userspace via the
> DMA_BUF_SET_NAME ioctl.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
