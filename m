Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793346857;
	b=XY+0OiRCy41OCfd1zkAZN5H8c+rSTwQTQ5pgmz2I/1ozIONJy+EHNPYKBABzd7bjgQfe
	 VILbRL/usKgV9Ad7NMwIxuI7xuixdvjSCjQRt322UuXyG7fk0f3av6r2daiO9XYLwDtU/
	 JSD2q+R/u3luG5E72TsiwmGRPOTtx/E5afXfirANmSd+l+Qxli/eH7G+LEUuRiiU08lmY
	 GeZZ/PZHaIW0RRu2FR0JJfdPru3pxHhxUVfg8QAar8QYaJeN7e2+BEFkKSXlftnoSsEcq
	 PFa1mT8V6BwMD5Q7Y/Amra1+K9A1h3K/NDf4dtOQdAFO/0tLJj8QEcr7cxIpC9NazJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346857;
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
	bh=6EoGtyip+WWxwLd3kKwHF+R8DhnOJym7GVJI9941rRI=;
	b=YNo1L/0exYE6VLyHOHdU/MWpf4Pzt4PRMlTPl9v2U2FXD2OnCv47SZiSR107odE5sj1M
	 9uPhB6PGYY/ZY9mI7yiCNHBEU9jiag8Sl833kzMhWELGrI+hNvjHNDBOjf7Qtw+729Xtw
	 2bRsSpRVkBSYJcQcCMPxl2FKTMurOnybeLp39xFcnTFVmerLMAp5eeOhE67VwrGIDXh+V
	 iP2qeoXvW0BrvEg7O63vXTxuSAoTWugpQfa3ZYGMbhO61Y4eDwW/JnhZhx4pwZ671QdLe
	 Im1Ls1flnwuBjwspklHnSDrQ+mdPU264j1rx8GKvxkOXJXjMMi98pobmotX9J2lWsWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HxDp9LzV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB1606A31D;
	Fri, 30 Oct 2026 07:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CB1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HxDp9LzV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793346856; x=1824882856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wplhCE3NDwkIJNFzHHGEwwiIj+j8UcAzUiZ7coTIxPM=;
  b=HxDp9LzVblA4v7+X6lZjebMi4jTPOhT99w3ymmqkIiEGSKAr/eOCBmcv
   kpdoaPtAb3abYiBcbI2Z8xe/csLINasvO4yGAP+Nvc2WxJjpbGSnsMF65
   jPMddergNgXR1jK3Z+DX4jKMoQGw+Pm2MjfRR2zOTCC2sa3XUDPgEG6Cd
   iDaD6e67F34h1ZssUH6ktTDVGNpNWJ8cNC0aWOFbmhu2rH2YMliTsgXe3
   YfcDzlLHyVVy9Kij0PXHXDMmTerDs3OxqC4kCdKECPlXA5OEd9HvFvuMY
   knStb3jNq7rpzaduZXg7kT/F4DtnvxGegej1s5LeBAAHTt7JInDPhb3Hx
   g==;
X-CSE-ConnectionGUID: byD85M9hQtaIuVVsShbw6g==
X-CSE-MsgGUID: +k1WN56SRsORVL5xNMV0gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2011422"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2011422"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 00:54:15 -0700
X-CSE-ConnectionGUID: Ee4qYhYESOm9Fsa7BN+eOQ==
X-CSE-MsgGUID: BBqLoFsKQJKqFd7hYAoa8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5390513"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 00:54:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 00:54:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 00:54:13 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 00:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTEyDxMR1CSgP24WZOIEyQ/r6kzaAxOhxDPi1eTzCbjGCrl7Hmdf0ZxHZt9qBQUP9lo3zZaakgBgd3FdUZT4907TW3tNF7pf82ZKJ8RuoxMrq0WB6G5zzRd7+5k9HNkLxHuvo9J+IaDDfhbV4dKu/MKdBiaWDf6nIr712/a4OAJkBsqayeZdbC4RjfMsbn4vVya0AybxjsG9tKGuWRZHKWX8k0Kii6SHXfPCEf3CnZXWNFKjK573YUaZG/Leol9t1i5FSviP43e8UrgUeKGJoHEcR2UpeVdXgss9i+ql6jIVcJDwJSd5GFVVEFoGrSe7C7GU2pGOShb6ttno17L1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EoGtyip+WWxwLd3kKwHF+R8DhnOJym7GVJI9941rRI=;
 b=Qukf0kpIodXcbBPMMR0UlfBve3usKS0ZEljy20/H1tYtNvOrvOkrcLDlPpPtQvT/iX0XNnDcG/a36buDaNhEepglqKAi81j9iIsXxXWw7Ws36r/CBeKGTHaPSdjTmC/u3qY0VY9WelIAAaPhS8Cj1lBKgL1wzZeT3s/jRZlKAhljjZWsfeJ0FK26PUyuo8POAnkMXJSX7kfjIWOE9iI5OZFchYjhPD8t7aal0oyE+X4It1engzpJSVsMd1eiPUirgt2f530t+VUnOwxyn32VSlfRYzsJs4a4Up0BCO6vPKHBvS2KWfEWsOZBoQ+L5/JP1x9II3nig4ym0GzBkVmi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA3PR11MB9206.namprd11.prod.outlook.com (2603:10b6:208:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 07:54:05 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 07:54:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Jacob Pan
	<jacob.pan@linux.microsoft.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
	<alex@shazbot.org>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, "Jason
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
	<linux-tegra@vger.kernel.org>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM file
Thread-Topic: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM
 file
Thread-Index: AQHdVup+WCo7z5uBzkSccRTJUCcMvbb9XZuAgBbRTACAAag7kA==
Date: Fri, 30 Oct 2026 07:54:04 +0000
Message-ID: <CO1PR11MB48351C4BD0BAD3BF6AFB2E0C8C6D2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-9-aneesh.kumar@kernel.org>
 <20261014105913.00001217@linux.microsoft.com> <yq5aecd9aupx.fsf@kernel.org>
In-Reply-To: <yq5aecd9aupx.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA3PR11MB9206:EE_
x-ms-office365-filtering-correlation-id: 3c7d81f9-8102-4e77-bd78-08df365af82d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|4143699003|261026140227099003|38070700021|11063799006|56012099006|261022075727099003|261022105027099003|261028144727099003|261009223027099003|261026121527099003|22082099003|10063799003|18002099003|10067099003;
x-microsoft-antispam-message-info: 7/hYxt0cWQCMCtNCGttCEE1u4PdRs7S/2MB/phIuZ8kIc372RRScikMP+S1t3N49yrNqvtuBEw5DLiTRLmq7HkaisKkkamGda8lb7dO3P7e1O7ykO35XE0zRiQbDF+RN9otQH9qWMWyobdaGjcYzFaUn0lcuwAaF34Qugwp+3nWRz2l85rqqkocxvIaSvaKkIpKYn58hlbBJQ2KO5blogZ0ZJz4Go07jd91aRRXxXKN/FyS1g4/nQtbdk2wIg5PIamxF8og+Kv0MkmUQ5zRvnSNsN5p0HKTeX7TJzY98eUrMrQhO+s4tJThKTUL3FgvyuI4LhbbGHbIQvvSky1yc3jn52svi4ZiPgQ1F4dt49R+DsXYuFvtNvSpBDmYuPv3X8k/6Xnxb/JmMIfnWz2Tb312OYob/KpU/1YlbpHTfP8wBoz88aXdlVB8cVGL/U9MQ2+HZv559U9JqcrQbYNmqGtEvQl6EBuG+8oCbslAL6162in6y+OPYtL+coxyxkr/oiMHiawGY4O3pMPYJivuD7Wh+FWUuSEqNu/OV023Wfhlor4TMk2bkf4JVuTnXLbf++p+Ua1KYmbHxIPjlyvrdYlnU46f6NrpCGpaTa6UUNd5mDCAJjdmCYAS8i/7EvsJ0o0ujq+HoSWsJJOrMvVB40yPELS4va8Vd5K+2vjxFKz3OUY8rHpoH9aDXT1XTjWN+EqvBbdKpAr/yr8SPJTY9qzzKrajzqWHg271a3zoclOg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(4143699003)(261026140227099003)(38070700021)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261028144727099003)(261009223027099003)(261026121527099003)(22082099003)(10063799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8waQI0Td0a5J/qTHE25GLpnHSvqf6WEotZf3lnMFQPKouodqWZmcNajIXrZj?=
 =?us-ascii?Q?g8uKpc0SCvTA4yRqu6DhmFjswmitcKcSmwUDMxpk03YokxGn49v5JPhKbl55?=
 =?us-ascii?Q?a+/7JjAwRJ6rlMYaMXIZG1zTuJvXMsfI8xFqKb+f16Geu0NdoGbLy/eCGShR?=
 =?us-ascii?Q?iignmj96/mLZR7cu3/uxEhbAhK2E+TseheAgTEOgVDxex1+oZ0hj4OJyltfG?=
 =?us-ascii?Q?UI0FxAeKNqO3CnMKIG9ZjUj9bRxuaGG/lR2kQ2q/E0wdk9hUNwcQjNAbpWl6?=
 =?us-ascii?Q?jR7rhYgzE5jWszVJKTCSl+Js4n+z/j2xdMo91Ow+47TnkSye2nWoiHBzQrw+?=
 =?us-ascii?Q?joGwiVE7Xm4rkQV5E8tFUTWvvsH5I75/QBwQ3Wb5Q1w03tIHlwSuR4wPwK5y?=
 =?us-ascii?Q?bkKnyuxuM0H1JlAYknMp/aEULgyVSOHf+zVu+rDNsop5HKB2+sSH7/8mgQV3?=
 =?us-ascii?Q?3nIpWCJ0qoBBf9vmAhLZpupKfS7S16r6Cq5tmCLXM1/uoOPTonovgksT7hMX?=
 =?us-ascii?Q?U+3BDRrwoawYlk8uk4eMk+CWmf0ZZ01CB3W5Cg48DnBnm+M/fsPnYxY17vRl?=
 =?us-ascii?Q?b0GtmYexxcW2SidzPfm2fgnLDMPg5Zq9ao2m1KTe/OK4CQISOverE8D7Kk4L?=
 =?us-ascii?Q?TzpW8+4fXYBHB9D2+ktIQEfRaQYKYArhMhJkHok1Cd4cgA6I6uRhWZKt6rR8?=
 =?us-ascii?Q?NVLYaEQMrT7xnFxVPt9TjWjEanWqZeFps61xNmlRQR9PEYKf2Q1QrKbLszT+?=
 =?us-ascii?Q?3zc2Nco8tXImLWqFOHfz3kx/2EOaMEkMdBXGT5UfLDwMxmjevBv9SDNPqSBN?=
 =?us-ascii?Q?J/3W19SaCGTHMeqGqZ/QORgiZKR7tb/LabtSKzasIE/V/0L45oO2LULNslFo?=
 =?us-ascii?Q?Cc+JbbcAJRbdjZ7QHCnAICMm1DPXUcQWmfrQt6BAOtMrsEZ2GW6gaOTkj6rV?=
 =?us-ascii?Q?n44k4uwMN7NaED2M0h0DvOHyytBLqJeKTd83+cvES4GzyQxI83EU6jqQ7kbs?=
 =?us-ascii?Q?+iYgDXaM5il6pAsBhf3CsUO2W3OM9imo5BML5/hlEzRR4bh7IZ5GTdv1SJLs?=
 =?us-ascii?Q?Zjd4XgvJrhQSglEP/o/GkPR0Mg1WEg6H5gUjyTCLobuslt89mw5KqdYKld18?=
 =?us-ascii?Q?n1VEtANo0fRNlMGynU6n/RDt9TGMvGshQP4MQxfhGGtML2KCCwqA3RMDXhrX?=
 =?us-ascii?Q?n1H5zH5ofpAW5Sc2r96bH7JkxMXgQRxghw1ULidSJfXf03fJPFsBldseHyZF?=
 =?us-ascii?Q?+poa+d195c4hbJGAGmb3s+TP3IdSL70SpulCqcsqQXoTXI6eujmrOhYmMTIy?=
 =?us-ascii?Q?xAIkWAK5H3pWp1hJ9J6JMlogTzzvw3V/ZK3uzGQb33U1jUiFSHz8eLOOiP4I?=
 =?us-ascii?Q?+Q9tuLLi/Is71zmQbYL1aO+SzMSgOjGBISNzRtx9hdWSbitV6Nj+bhdYsnIL?=
 =?us-ascii?Q?5nmNaBiYC7xs0wNUwB8RB0+6IX4UJ78cpNYohkIkkPfYrtfyUALcWRW/2q+/?=
 =?us-ascii?Q?n3tPZI1k3pB6BFI1I63cGamO6mimIepDDU8fedLse7p6YwzoeCojH2i21K5p?=
 =?us-ascii?Q?z4JQPNIkHO8VG+2y9i/iahNhq9ChsZrY6i8OJ63gHJaXRdHxD6wX0NcaygoV?=
 =?us-ascii?Q?Xh1sC7IsHuXfEgRz0UiMpPFTLCfC3FjSVF5V3UjnpXWXEb/XcUv0Vn+9x5ii?=
 =?us-ascii?Q?yiIJaOYXIQRId5RoLHiihFx6WlrS3EUAns+txJyKrxqLi5Gh?=
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
X-Exchange-RoutingPolicyChecked: jrX4JgWJNtTw7hcNg+0vBO2USLTbTUiycwk9Wo4llFP4S9Ht4Nnycy/v1t40DxLcwwLYu0TG4We5rr6/PwbRzaMIRrgEGRwEgAoE6BSrZChKkS0MQrnxtPDyFB52XQ2H8cH1l4ojf0OVHnABLpyOXg9tk6gXLpb+PmG4MZIPxQcGsMLOBem/v4c17vKjYUiVE+qLF/aXHORwSBYQO1mYRCuxhYmBn9um/Pk55A0p/enclYbjhSnOLStbfBZtS8OrpiLYf4rqC4KIzMDjitPhpE1/45FsK7O0awXrxX+zRTGd5t3Mi3ZWTb8/PLYpiHP1qYOodUJiPN89Xy1mDyyAOQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7d81f9-8102-4e77-bd78-08df365af82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 07:54:04.8451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAqMO6KxE1OX2qbpJvjnGVtrx/duyh5qEBQqlWFG2BSPNlOeR9qwJ4MuCH18HnvVKtHexKz9o+gukoZCY2/5nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9206
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Sent: Thursday, October 29, 2026 2:26 PM
>=20
> Jacob Pan <jacob.pan@linux.microsoft.com> writes:
>=20
> > Hi Aneesh,
> >
> > On Thu,  8 Oct 2026 11:29:47 +0530
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
> >
> >> @@ -82,6 +85,8 @@ int iommufd_viommu_alloc_ioctl(struct
> iommufd_ucmd
> >> *ucmd) }
> >>
> >>  	xa_init(&viommu->vdevs);
> >> +	if (idev->kvm_file)
> >> +		viommu->kvm_file =3D get_file(idev->kvm_file);
> > So kvm_file will persist inside viommu even when no more vdevice exists
> > under the viommu. In that case, don't we need to check idev->kvm_file
> > matches viommu->kvm_file during vdevice allocation?
> >
> > Otherwise, it appears possible to associate a device belonging to a
> > different KVM VM with the existing vIOMMU, no?
> >
>=20
> Agreed. I will add the below.
>=20
> modified    drivers/iommu/iommufd/viommu.c
> @@ -212,6 +212,11 @@ int iommufd_vdevice_alloc_ioctl(struct
> iommufd_ucmd *ucmd)
>  		goto out_put_viommu;
>  	}
>=20
> +	if (idev->kvm_file !=3D viommu->kvm_file) {
> +		rc =3D -EINVAL;
> +		goto out_put_idev;
> +	}
> +

IMHO this is required beyond the tsm usage.

Currently IOMMUFD doesn't prevent bound devices tied to different VMs, but
in concept a vIOMMU should not be shared by two VMs.

The uAPI header already says:

"
* Allocate a virtual IOMMU object, representing the underlying physical IOM=
MU's
 * virtualization support that is a security-isolated slice of the real IOM=
MU HW
 * that is unique to a specific VM.
"

But that uniqueness is not enforced so far, and your proposed change
can fix it.

Besides, it might be a good idea to return an error if idev->kvm_file is
NULL in iommufd_viommu_alloc_ioctl(). I don't think the viommu logic
is designed for native application...
