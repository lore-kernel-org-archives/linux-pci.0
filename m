Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D097221F24;
	Mon, 13 Apr 2026 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062445; cv=fail; b=cXhDv9uGX8cVnNIbViMyFUicSb53Clg31WAk+YxJOo6CL/Ue1QkG080lv7y2afEv4/VLg8An8W6JvLn1P8+BmcPkBM+7XQmgwjicU+vuUSvVaP9EWCLdvFksbsXsEMc4VmoQV2IOCrHw6q7cUxLnsb2A6shARToYachr9fI6WRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062445; c=relaxed/simple;
	bh=uMf7sghh0q5q9zuCzPMO6ZngbelEBlAvwQKt+jjT7f0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZhxXdd3HUjUiZ5tUg9Qayy5fjP2WbqUI2Ni1CfJPGGAvOmKn1tlw/5EywBFxbvCqGXtZaPvIggmxTDon7A+uNZWtLFOUeSTdMKSDY95M+qCpTWwBL/wwwo2TxMJ9B0L9mFdtygXyZEa3Ms2VwXXuiL2LlSNdVr1tiSrGNUdndNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EE7yvNlq; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EE7yvNlq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776062444; x=1807598444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uMf7sghh0q5q9zuCzPMO6ZngbelEBlAvwQKt+jjT7f0=;
  b=EE7yvNlqA7CwiFwtQgDVZYSoMtql14k4eDO0OUgI8PfQfiZRuF3rM5lV
   vOLJWBQxDUFS99NI39qvWnjwNaEjNVZ4bNiXP175ZuRSWksjhmYzKuINX
   z41HUYhmK+ozWGUFmibjxvznM7XsMxVdtKUOs2y0VtX+2eUScMfxzjldc
   PDRebJuZ7kfrnEMJ7RZFwjZ0eng6zXY4LPRmlOmrA6jSnYMB7R5LhQaUA
   LgsuYI7RlHc+J1LoB9X4l5grAKE+Wq4vKp8O1gZstJH8Rs3zMBCfVoPHL
   5flcgLcofWLTgm61LIJlK9b4LMhS0/frIIhBxrbo9OjK5nnQabRj8JHsz
   g==;
X-CSE-ConnectionGUID: BDH+OotqQDWrawGPlUnEKw==
X-CSE-MsgGUID: +jMlHcDfT4CzQsayKw8kIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="87692536"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="87692536"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 23:40:44 -0700
X-CSE-ConnectionGUID: HYULBIEaRkCGdg93l7yYuQ==
X-CSE-MsgGUID: Mp39aBe2QOC66Odgo2mFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="253087052"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 23:40:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 23:40:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 12 Apr 2026 23:40:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 23:40:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmBdbCVN7l9LqS0DomaWJPGd3H64JkFAAQAEJzmNbLxUmjC8AVzpv32REVNg54TJOibljDWzbhTQEIhZy/XvHa+gN9gERt/0PcXdfZvgrfgjQFHCRCQc8EzZWSeLnNGY273YE2nbc6Xsd3VrWpjUkNuleJ+dPZFhzOrclJ7P8PhBpESHDH2HV67Fais3PzsH4mNMD8lZE0aXL4jCAMd553Ac31xr8E+/Ri5LMSXZmyE7QYUh1q8WS3JVfNXTW4G/AL8a6Ty75Iyn0rYIpqwG+M4AHHpV+a6aEr0Nc/cj/ahNO4QyTUihv6sdTfeNgLy5tiQYMJaHp/o1HNsy6wM7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMf7sghh0q5q9zuCzPMO6ZngbelEBlAvwQKt+jjT7f0=;
 b=L+5UMFI0kkUWKiLyOBgeVEKuGgHLbVWMYHyUOp1mr9nUZccGAzi+qA/jxK0QARYH4WxNG2eOliyktwJtysPzDh2Y9KgK59C6HjjS/qNeFOguk1Ut70U/LLCio7o4f+ePYsdyjSvsLaHTn+i/b3ZdXGVdXvQcOVU/CnrEsiEsDIxahkp3xFZ1FaPfymUlzgIStO3y0JOy+CktdBi5d3mQRsrvUofrHHrXbhaG+tKK6h6/F9+eX9Ncdp3a7uuyOc6h+ZOhfNTQJtbg7IMB17uUtbg0X7D/1TnPP0S2ZuDEIaqanuYP3ILBTbEIZj/22XoSBK7WaCg91vvHYL6h2G77Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA4PR11MB8889.namprd11.prod.outlook.com (2603:10b6:208:565::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 13 Apr
 2026 06:40:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 06:40:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "miko.lenczewski@arm.com"
	<miko.lenczewski@arm.com>, "linux-arm-kernel@lists.infradead.org"
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
Thread-Index: AQHcrcLZlsPpC1aSZEGOkgr6dEwpTbXIca9QgA8X6ACAAAIUAIAASGZAgACU9QCABFtj0A==
Date: Mon, 13 Apr 2026 06:40:38 +0000
Message-ID: <BN9PR11MB5276A0E069B21137833ABAED8C242@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A6B1B103C4B0201458348C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <adgsBgXYy68GmxAf@Asurada-Nvidia> <20260409225252.GU3357077@nvidia.com>
 <BL1PR11MB527184E183703E14F6C861118C592@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260410120508.GA2588311@nvidia.com>
In-Reply-To: <20260410120508.GA2588311@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA4PR11MB8889:EE_
x-ms-office365-filtering-correlation-id: 48556ff0-19fa-429c-f8d5-08de99279369
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: xFXs5ot6q9TMsnSdKaZHzrSVBnCXBNvMYUpEnBKVXbOwDITOkCwB80/RYr8WzRm8xR9j9Kw8S8z13ZBDIsxfGnXi009aWRNJuFAWO5SAulvRDfuNqyzxGYoGCCRFFmgy8C4FjS8pyRMvmkUfhEM9yFRUqtD4KD827EMrVqhCIKOYoVtIJM92/S4XA589FcAtFhbfyj393LX0xLm5pX2a9AeS+rQxloqNjP2b2GfDJQkYV/XmUOHvSFl9DozjAgBSPaQ0Ep6U/FvjG/FU3246VxeRR7LT0hP2NejFWXWN23dbV0sQzCQZI8NprtrH+2qIpcXUAG9ENKqcwtbHo271BlSuwi5GVkmpTahNizJ0WzsS0EE3Mgmi5IbT2w7p7gi+X5x3M0qo2tr5/SNuABfkrfNrFYUpQOicz67eScj3qTr2SYy47G3rRqbM4lCnJoqCfwroZZ9eSe/K/g4hbly2wLdzkzPt+rG4aDEU/c6iszyhncEpEHizb8775gm/1gZ9u5vm/rFu+oGEty4Y2fFja0tILkcCpdzEoy4keNKmexG2wuFhY/gY52BXMLniSIJFxODCHxeoaxFxNOZY276fI4kv51g3RK0bfsDmrFbLprhcqpawUXsnAvP42LgWFsnOE8tjaKBsUXtqeRAnRbiwt0tXOTA7c9aK4T3Bc/sWkepW/U0x9Hk0/wJsC5KruwCwFMds3LE7DI/1tlEjSs6q5WD9u4HD4Pe5AyESRubqwQXj63fvvzQuvoA1fdTxS7C6WVnwr9z95dVPW5bDjUI83OqTD//jVhHw/MC4ZuXSsoE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GSZrAuNhv72YYNYPQhFeC929EPkqGi0B8tgZGm3hpc/ZPiIrTvRM2BPM0KMs?=
 =?us-ascii?Q?ebChzh9a42x/xCmJa5sB3/gihchWo56rjXJ5Bw9q1+zWTcC/IFDj9Om+t4sz?=
 =?us-ascii?Q?Z7IGhgEcRNyMHPPdjIdMKKBmKdEYNS6oPIrupWeKGhRrcgcIsioqX2fAi3Pv?=
 =?us-ascii?Q?PAM9MdH01ctS8d/6HWsNXBSrWOnYS7nzESQMwyB9+YznFBetle7mtrGm+PI0?=
 =?us-ascii?Q?jKnfgrMcEg8j5oCKNwc8dKeie9dexbqoj/nM4g63/4ZR+t0YIu3NpqTfFxDn?=
 =?us-ascii?Q?P4CyqVAPJo02bFLIhy/yXfod15zK6ce8L5a46oJ7PDY1a8nEU7K1Egp3rYwI?=
 =?us-ascii?Q?c8mUdBEeC1z4UPbgaXr71rEbJ3Gv5vLPKTgEvpE27vU7E8o5pep+6D0VT8IF?=
 =?us-ascii?Q?oyjqRHPr2fFENfbSvpl8o5C/QjjJDOV2/YOOI15lBC8ZeqK96iDdCqxaCgC8?=
 =?us-ascii?Q?P8gMJHrcYk6l+cf2U/QAQF6YeY562R6WgO7ersSGIJC3oPvPnY65P57NGqHN?=
 =?us-ascii?Q?+f9LTBVx9ssDftxje8pgNngMlF/ecrLqhurWrAg0ARCGXOBLxZzvOqgrEcxZ?=
 =?us-ascii?Q?qay9b/LIa7ki/KbdavTFczEeNSFIWlZvCmE/xHI6fA0emi6HFXQPn9jnC4xs?=
 =?us-ascii?Q?Vo8gTv32ryx4jJFKopmimugAON47zVGLJ2CHuk8+Zmne3tiC2z2Mz+WNjjBp?=
 =?us-ascii?Q?FB3TID+OfGMYBkQLjs+J83UorLc5E+uLSWOtUdxuTctgFs4jbcLeaNPZygfB?=
 =?us-ascii?Q?DgyDTOu9wrMcykEs/X7G1fIRFZBtMlEWjkosCTEhR5iTT1yPgJeYEoiqzSDb?=
 =?us-ascii?Q?90IVBmULjQ2nSO95NWKdHamdp/hKTsHHNnS8U1Nv+q7SvrJwuJvdWCR+jITX?=
 =?us-ascii?Q?2om0RW5/LhRnYZ3ygi6DPCddYlTROsEjz3cSkuqP16lnOd0jOlTTd5jItMhC?=
 =?us-ascii?Q?1f2TsulmVXe3tv+AuU8qnLGJI1jEE4dTrxaK0uqh9XuGKVebXUCRBKmJmHOK?=
 =?us-ascii?Q?XchukgrXcu4uOR529A/zRqZYh8uZ0dF7IG4MmfQTk8IhzFtueTtTwvpnEyNU?=
 =?us-ascii?Q?8yaEUr460gj4+FuYa6Rc706tz0UszPdpChDM8GvDSbTaH4T+kpJy8KX8kdoJ?=
 =?us-ascii?Q?DS+QRuWQdChMJDIog7EXdSbNuZudI2YcyRTOqjAyVwzQN8HG+vSC7RbpIuLN?=
 =?us-ascii?Q?tZoLZL1AF6K0A8vA6IqFLOcV76lqn8C9UcRJDQqjiRFokCL3p4yuSJCQPREs?=
 =?us-ascii?Q?NrWd+yD4nRN4I89eQT0eE5Q8wXbeFhhCxuBY08sqS6mxoV3TKKzeTG2Aonsz?=
 =?us-ascii?Q?hSwFUFi0DGt7FCJQ+0WYwsELSlTZwaSjRKsOcV1v8ZN/m2jw78dYXytQPXgh?=
 =?us-ascii?Q?b4HFlWPHlS3OFvwOmJ8TjyeTK65m498HkZTSTfx7JW3KSdO/PhpitwQWNwhl?=
 =?us-ascii?Q?M5o5AzSfHDG5hlE+7PVsPygqgvjv8PqcMVqZAPF4Jw0Piy1J1XaavPmFdzFo?=
 =?us-ascii?Q?JF/n/itBeDmz7ZQS2mAJ8q24PVYfzMwPKKP5ZA6KGi8Vfuw8iwHkRJfxX5+1?=
 =?us-ascii?Q?xfzYHGTK12/w6EkMQ/iKI80tyfoeZg1YSlrYhln2LGyWsO+PVH4lCdNtvbAP?=
 =?us-ascii?Q?fpnVhw+b23Ke9NUpBa+eYRPlj6T5sGsiXvCoeCJJs1ndyC/Fb+PZdL0cUD0e?=
 =?us-ascii?Q?IK/bK9peqYn+vehGYkIiY2kItRZxr1+JRBr76cbC3MRcmZZS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rR4mvLF4uKEgxRh0yRVrqvtaKWUI+I1Nm+WgbzMn7PJj4Ca5Mq89mJXYkvUEYsQ9MLODX3banXPszsWJszHG40bLPWRJKBEPJbnxDlU5RROzQDXPkqWBk/dG6u6DcYwq4oYWL88nIRkwMIWnw6mjpwFTMRy1pX360MP0fUBT8bC1OvMlLcu24UNHsDnv2smUQuxlWQA5l0ypq9+wtu1sV/pdVnTBXf2xEKd9Is+fSdMq30vPL90avRXZFrSlRyG37G3svCW+r9FvMEyX9QZsPdDbn7KxwXFxJaVDiqwU5uVWetah427IoJwhmmM9MpqOAR//6I6XFdFLXWyyWr7UkA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48556ff0-19fa-429c-f8d5-08de99279369
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 06:40:38.8916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gz5QG0uQ4jhhQ/NDsoYfBTa+MlbnLyQ8/pM/8eC35bwb+DnP1/bifJ6sGsbuLA/xZNyJGhPqdQDKBUztFgwbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8889
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, April 10, 2026 8:05 PM
>=20
> On Fri, Apr 10, 2026 at 03:13:59AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, April 10, 2026 6:53 AM
> > >
> > > On Thu, Apr 09, 2026 at 03:45:26PM -0700, Nicolin Chen wrote:
> > >
> > > > One question regarding VM case: if a device is ats_always_on, while
> > > > VM somehow doesn't set nested_domain->enable_ats. Should the
> kernel
> > > > at least spit a warning, given that it would surely fail the device=
?
> > >
> > > No, just let break, the resulting failure has to be contained to the
> > > VM or the platform is broken..
> > >
> > > The HV can't turn on ATS because we it can't know what invalidations
> > > to push so not much other choice.
> > >
> >
> > Taking about in theory - host can append a devtlb invalidation cmd
> > after iotlb invalidation (if vcmdq is not used)?
>=20
> It can't map an ASID to a BDF without shadowing all the STE and CD
> tables which we don't do for nesting.
>=20

I see - on VT-d the PASID table is managed by host which requires=20
explicit pasid attach then that knowledge is a side effect, but it's
certainly not the case on ARM side...
