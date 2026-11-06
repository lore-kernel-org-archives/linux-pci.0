Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793949005;
	b=TLV3H4xIlouNtTT79R4LiPo0j/K8H9w0h7Tsfmm37Mj78YERwJqNRqqJpQLecFJ9vq0j
	 gy1nZPJvdno76nxRnLe5midIYvn3aV5PlMAS8CqQfhPk8R4C1rinxHbGxrDqjGigJPdHE
	 La8iV+eIgJyxbPBtCbjAmNMzzZEOr8XlkTau9swgtnI/trXAM3/ESM+jMBlZT3oUuw6CY
	 kPuCaiChOjZWJ4sottjM2GJr6wVTXBAM2SRHRRTcsVhxdsvCo5ZBoaow8Fwh/BgPAo/Ky
	 ecOp7TYRMrFwZJySP5O7/r8VLo6+Qhg66fM7rz+hx/OjDtj3ugpp9c26C+/3arhbs7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949005;
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
	bh=GDs5twU/6liqGaJafhQ0aAT35w5KLtCNx5q5vk7CkKk=;
	b=U/lo7+mAjLQ4v8FJgoZ2Ze3xuUHnBkOt5b2phywt2EoAoFQ7xTFb0KLXlueYpFRbxTg1
	 YuyJooyQJ7JyJKl43301xKi+qh3XlvMDUz4LUWnObpQY9okQknVa7GVVwKX/Zli7HBlGq
	 kzSSI6f+RyBzqcsovxapsDk48HBiRfURmRzerEqnJYHL/ulnooboyLrc54wpqQ7mf0XKB
	 ZMNzIjDqT3qyuVYvtMGhore6gwss97/HpDxj1Ln80Zozm/7ZMjiyLIXODYy4yStCpQeJh
	 4ZzsSzikjSwkHV2Mzabx6HKOU40aCGK21451+ZujxZOYGJ2Wr9y2N8A/FOfUnU7jCMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nTC4LPng;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4333606A326;
	Fri,  6 Nov 2026 07:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4333606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nTC4LPng
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793949004; x=1825485004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eYcZxUsXIz7+yLRvN1uzAMDrP6mmdLk+T3LPpQ0esic=;
  b=nTC4LPngc82jHA/EABKd3AIO/kJIZyGZvkJ4gwlXfnAFNjjA/BRb1uZ7
   Iy7HUWoKCXoSaG6WopeXyI8I1btcW6AB4ZXsngYPL3NWg3ZPX1rgILAaF
   gfEmBYCzpp1K53ZOh5tMAgmoIPkXtBY/chcgtBInr2MCmHfqjIZ77CRca
   4Z+XZjS+5AyLUz9b9+cWFfiJe+nDrjsiDVyWsNh520tjxRi6GDu27D2j8
   8LtrcdT6Z5aSCCMRfwmhjbi6Qa0YsSBNwS+oYgLbhXWEBAuer2GANln+1
   agG7bSoeqwL8UcsrW47uR+GETlXHCNaSrZSTfy9243KJBHr3vg5sXDXpG
   g==;
X-CSE-ConnectionGUID: 8e9TMUaxRtWodXvuBFFRUg==
X-CSE-MsgGUID: +IH1DFOvSD2TrmTRBb0vUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2659585"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2659585"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:10:03 -0800
X-CSE-ConnectionGUID: A9Sm4fWJQx6QNeJkP26WBg==
X-CSE-MsgGUID: mHSi7eQ4RcmyEm5Py3KR7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7636910"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:10:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:10:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 23:10:02 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:10:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQawlbIBR6lxUu0z736yfvYo4vKJ8iw5QJEBPcYbobgh5hxG1/xlHYk3CVHSbKbwaFO5KSk1aexhvXC6a4aZcXqBUije9UBmG/mPdqlUIQZ9FhihI2xQGUgGqqZEHz37AEeD9um9T9uqDu4ij+MqUE/jtZVUu6nLzNeFjLtCcM5yXzlAUx+yy8K7ph9mUWRWW3IZEC11P7beXRiALBHfOzzSUjkGIz17tXkYjyScmMl19DNe6lJVgO3W18gfjEJiafLsv5/BaCmR12flYcucU7aTQonK5/Amq96gMJATlw271O6sOZHkKnJcPf1fmwvTycHwK9jEn+bNE2blbe2QdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDs5twU/6liqGaJafhQ0aAT35w5KLtCNx5q5vk7CkKk=;
 b=XnYSML1jUgMYX++1QZsG1aa0uM1Rkuvtkf4rEvvVCGlqh8pWLoSxJn16aTi1tQuQqEmV2FqE8pmjST0llGwMu9OIW9nM/JxUSN4YUyOGlxFhI13Cr3dgeFyUDSKFySzIwKDcQN+pzfnnWa47Yf9ZOHIN2jpFI0dF+X6eS7dQeE/dV3d0CbtNvMT6kV9JOc3hTqShPbmFAUp6aqsW9YtcMBjOjDJWzPcAtuo/x9kMT90SkbQMm52inAlBgm/94/LQuXEH31SsYz9IA9SZywuXSa1RyTKe8TsUdT5YA7nP8q9uhe8DzjMKxVTxyK2j5wgUdgRiGwE0qQ3NQDnjP5XJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA2PR11MB4779.namprd11.prod.outlook.com (2603:10b6:806:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 07:09:55 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 07:09:54 +0000
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
	<linux-tegra@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v8 05/15] iommufd/device: Associate KVM file pointer with
 iommufd_device
Thread-Topic: [PATCH v8 05/15] iommufd/device: Associate KVM file pointer with
 iommufd_device
Thread-Index: AQHdbHgR8ry1/eWAXUyIQq3mZYwA3bcgoj8Q
Date: Fri, 6 Nov 2026 07:09:54 +0000
Message-ID: <CO1PR11MB48356BC903D4B5700FADF31D8C762@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-6-aneesh.kumar@kernel.org>
In-Reply-To: <20261104161632.3547423-6-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA2PR11MB4779:EE_
x-ms-office365-filtering-correlation-id: c3a1f909-835e-4132-ce01-08df3bd4f548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006|4143699003|261026121527099003|261028144727099003|261021123027099003|261022075727099003|261009223027099003|261021135927099003|261022105027099003|261026140227099003;
x-microsoft-antispam-message-info: sl+C2vfzUvMqNXM6tf4vd7BCfaPm3MP6UEzAOoJ8ZfsNW79vDACNY3JKI1/2XR6PcE+W1mK6MEl0RU9bgsnvbrmsivFlGE9VJDpSuIo2YazsMGRL8FSwH8ld2CyirKuUugYiwaxmyFIIeY6qWXKFsv2lEodAqBB7ieqBPaEFpK4Exmk8LObsoFmUoozJA8eraHoYZ5Rfrm7qA1sxmfaprRhn30pFi5k5kwI21nCPeYP78qUSValVMpPRxZ+1kC5nsA/QlD2f9rGIaQWNydvLpYusDplJQjzYiCQRFWdP17AHrbj8wLwME3cRQXAC1l10TcgSA6hbS7XTFnf+s/ab52YMUUbtlhKIXVaXyaSEGs1RBXKSGuD7TEMJ0D65MW9yAe0qCGnw58lfF7+GQP1YLaxo39/P4q4Akbd8Y4B4kdpRDlGybWW8oORDD/LcT7zgvG2kxAIEMJ6B9l6IIO1RZpd3E2QTb2PfyWmo4ekzwziecBir7JMa7WukkQgB6JvpioQ72HOKh/pJmc7BtLrgI+ksEdQ4Ll39F/p1LYFjrDQSqvmdgrayGHcj3CqP9bNd4rgUrniVgkl9dlxdQu8mU9MPxCZFPkF9OCBJutqhSrUHqjHXWIGmVCpYR/tlM3XU8Plewo/buTUlLAHLfaKgAiShQ7xJWqtDLWbiK7pJ+IJ7D00DNfTeSZAxbrA9UU56RW/nX3cg57XE2yS6QbJ9h3NjypBDphuINBTA+c+WBGA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261009223027099003)(261021135927099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QRdGkzQHdzKp5MMsqdYgr7deWAPEPgqUKDIEkRym1TAWNHyJdBcuN7aaPYsw?=
 =?us-ascii?Q?0dTawPHwUZ1BGNdBgKtdNBbslALzcqNJKOUEoczwqwXl7iDDQsgN6T9/4JID?=
 =?us-ascii?Q?RBQhUN7JvDvvYDlzdudvPET43hQBLe+GRXrYFODs48aI7c0w9srrfYkZLYH0?=
 =?us-ascii?Q?ZunctODePJYsfjtmhtN8K+pvDK+B9jUB6E4q2HSNqrvUz92TVTYYK17iruyS?=
 =?us-ascii?Q?PUWS1Zymp3U3xzGJc1sPEwpTiG+vUKyhmoAbNc3sn4ZI0VxbTEGqCLZoP17b?=
 =?us-ascii?Q?Tx/gjEIXGH+knqt0SFL2MhgBZxr9ZwIYSrFRIgcw1XvKariIqSsXDp7ihZTX?=
 =?us-ascii?Q?jlGfxFLHs3CHNJ01vZlL2efvB/jNyo39OVVsH0RxWro0UpXui8v0ivCcAzIn?=
 =?us-ascii?Q?H/OfYK/fDFKvp5LJsHbELQ0pT69n7m6IJskEoQq1xvpkg5QyLG/ZVlq3+v89?=
 =?us-ascii?Q?iD4+PV2V2S4T0Jxf6bQlzddNsau+Z2RNqfkpdZQFIkB7uMq4kaljF+rq6t23?=
 =?us-ascii?Q?roaDjOkJWO0UVmMXJQtSE7Ghi+e/Oy9ZL3ROvm28w1muO2jZljFXdd1Tlroe?=
 =?us-ascii?Q?a32lA1LpprEqnfxdLMZxbiYwbxWprQiyYWKihUXDN2i126k4yloSFTg9uFkW?=
 =?us-ascii?Q?sz7uoAB78tDIULkr6X53AVMTjPTwLfdypgI2qHYVh9lCVQXgbb18hf7f2Bjp?=
 =?us-ascii?Q?MByWztbUbkMuk27IWLHUyQTPDjS1rNpBR19DHj4a4dekKAMEmBdJRapPDvxc?=
 =?us-ascii?Q?Z2rBAuErcEz2nd9j69vHXG/+sbEXw38zJ1EqjoRGnnGPY4HtNo7bP44br1ta?=
 =?us-ascii?Q?b5x/cyW2qlsYgPX9TrBNqt4qc7L/EelCMxAQ5JD3eM6mDXhur4+V8qu9v1HF?=
 =?us-ascii?Q?Z/y+tq9KIFrWzacVi1kYZCZRNQ2Z2a+JmKQdmMAEYeUZv+tvB/GYAnHPtGe7?=
 =?us-ascii?Q?N9YPfka4ND/pT23EeTt3svB2SlJRIoEilDTXp7y383TqhgSODCVeIVjCkP6g?=
 =?us-ascii?Q?lUtgr3YUKxyS3lR4esgYAWagBMLijiItGJ1BJNOqRULFlk+X/58FoXfNkQDV?=
 =?us-ascii?Q?0D42g5MaM4boz5Ew1FFJYHq6S6puAdMNws/3dtfAQxEW+RlrdS9NY11nWzAT?=
 =?us-ascii?Q?apcBoChsGDoUdnFZjsJL46mpMkcD2VnO0ryYsqL91nbJeRzIGDlzfi57Txpd?=
 =?us-ascii?Q?pKOaINXBBbJ9DoJ4i+EII/jId7PSKmM756s1pLkYqWsSfHcuddVXcusgW3uk?=
 =?us-ascii?Q?Qj1fG6FaQNyNn6cKfmyVZQoCqqpJuQKIjYVq3bNVKm85+K/R9Rhougn6+rfL?=
 =?us-ascii?Q?J7KjF2r7wgAuePlXit4KNgmXjQfChu/Pa5sBF/A1EfDDAQ75HoNU5IMtYspi?=
 =?us-ascii?Q?pRMNM80WvgD855phn5M6aGYgIRyHi0zi/uB5fjQjwZxoZ/KdOQh/UKDsOcpD?=
 =?us-ascii?Q?GLjolyPpHi32aYIT7DifkgoDAHoB8yLzwAaAkddp6gMWoV1cdSjHr3BBdKy7?=
 =?us-ascii?Q?S/HzB41CQmUjN4Ys/dByHCNgffb983IHNHbrCJLBimrV+YpFI4mWWWkM4eXY?=
 =?us-ascii?Q?sJ136XpPZd7N23NEZ0lxHq7lEhh7A598yEfWmPG75+CKyXSg14M1edC8t+BJ?=
 =?us-ascii?Q?RQhWF953KVSrBaezIVNGAOyZOlH7vISLRewl3taPCvApfjAKGuxdnudg9/Th?=
 =?us-ascii?Q?dY8GIUJfdjxO+f+/jSfuqF/J4BWxyHkEWrrLallpJb8jOGN1?=
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
X-Exchange-RoutingPolicyChecked: mCaa3WBDDbovV9rzBNVSiO6DBfwipSvNmZ04xA2XYOb/1KnFM6Uiew2/PWe8xioismaCfd3QtYSofU77+Nl+LYyT5bpoijlx1vfyPi71qcf3zjcBYd1Zaq3lzYsxF5MhtH8/lkFzVUkGse4d1eBMXv/6qhaNq7B3lTBbMEm/1LtPbn2fjKZ/n7e6S67mr4dEN9CoK3DHY9bfQ0+BRsWnodkU9PRjRsWqroZ3492kmIMu59CP+Z3L4MLyE9CDEScDxVSnbobLswzcPZYnVMwGToJMhpm5t5qAPdMGQgqGqTQxv8k1vxV6NtQRdtf1Wc9Te2n8W/g71yf8zuFtwUjAlg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a1f909-835e-4132-ce01-08df3bd4f548
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:09:54.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GyA743JRhj5A5qArkrRimPGo/8cQrqpjoxRi3m6GQ/71XqWhTMXKPb5P1DrRu7kE2tnCVYQ24vxQoRXGsTwtPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4779
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Thursday, November 5, 2026 12:16 AM
>=20
> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>=20
> TSM vDevice support needs access to the KVM associated with a VFIO device
> after the device has been bound to iommufd.
>=20
> Extend iommufd_device_bind() to accept the device's KVM file and store it
> in the iommufd_device. The KVM file reference is owned by VFIO and is
> already held for the duration of the device open path.
>=20
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> [nicolinc: fix build error in iommufd_test_mock_domain()]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

a nit:

> @@ -509,6 +509,8 @@ struct iommufd_device {
>  	struct list_head group_item;
>  	/* always the physical device */
>  	struct device *dev;
> +	/* ..and the VM file if available */
> +	struct file *kvm_file;

though the comment will be immediately replaced in next patch, let's
remove the pointless "..and" here.
