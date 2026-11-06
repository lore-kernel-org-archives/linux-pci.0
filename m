Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793949376;
	b=DYSRtcOyYcs4TzqCmWZ4JZP9JkTYS3ooJetw1lR/jaXzi88GmaWMwhjn4eDdlJHCvRjO
	 mYU8VCAvfrBLMlWd/xOp3PERFMbz/Fx8moPf3u4rYBz8r29m2ZrRP1RRVA3TNL/6Bguqp
	 x5BFkTO8TnojX0EXc2eQFegO8ssoe8zsKKNRBJHFYL+nkuiUyt1YmC9OieYqUWse13UTR
	 MzDWCOnIKNfLKwNQTT1WOSS4b06KkdFhibd8Vu8HHpjHLt5+CMAS0yweFeorctoL4o8QM
	 d4BjuiQA8XeqBi5cANlwwdSBqCVWzdcxpmAawN+bRt/rIa3aQZOCdclyR3I7mwyis+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949376;
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
	bh=NZ5w5GHbCYylP32rqPTQYa49pHnY57UQY5QDmKMmWvI=;
	b=xMM6ng+HsGmxBNIs6djUUdjFDh4fleuVNfZNVQcKTVqmq+2zwlIQh3QNxdUhWukGvGfn
	 N75SzdTQdtB8Wvez13Wkq2/jsVnf9h/JbqQ0PcAhpG1bPKAJrdcd/J9kE3nRzNZACFNa3
	 5YCAnVt4VcOe6NMrMtXzH/ycWegtF5D2QvtsKqO2LG1r7RrfSC+r0FVsZH1sKrL5F9ilF
	 t9BWL7ZKPDVCgE2B6doaXoFp+cYlQHoSLnSNBzFlHCKvU6TZ0sHBMmHLx5jUKVzwhSMwg
	 2MypPAXT2MvJ2O+hjbd7ya23BTCcxbUuZzCO/peZnc5MiFj7kyfHBNeqQ3+cu1PDgxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NjVXMNHL;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE92606A329;
	Fri,  6 Nov 2026 07:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE92606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NjVXMNHL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793949375; x=1825485375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ObAjJLuFZJunSI5T0JTjOtnbu2T2CO6arhBLtgyrbMU=;
  b=NjVXMNHLYPQHMhel7mR2+t+kkOXVqV91NwLZW9oNipz1BbdBtQdjeQVh
   G+FTl8rQWKlA0/8CdiDd89Puo7OfOMetnYont+SFR4KPve9lKFMzwROe+
   Wik2XveGMchQiLLTPBPGAAVGJmFFeRSkzQkOBKJp0eLNNVARedltf5kea
   D7N+YNcxUVcKoIough0ECfHwRQwM3F0JR82RumYu4tj10rX5Fj51bPBZo
   HsQlti/BLzHwTTh4XgbNnrJHxtA2zGXRAPKGjQS08a6k1DHx8bNAdzfA5
   N/f4C471EEGlqbH8DP44wd4I4xYYp28s0uUmboMNI4UKQb6trvelY17lJ
   Q==;
X-CSE-ConnectionGUID: h1gwRn4ESzGyGJfAanZk/Q==
X-CSE-MsgGUID: xgK0HZfsRwu7iWKQi59x4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2788464"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2788464"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:16:14 -0800
X-CSE-ConnectionGUID: vviSLBp0QA291jEyIAWc4w==
X-CSE-MsgGUID: +a7T3bQrSOOBvlJSdh7w9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7376504"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:16:13 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:16:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 23:16:13 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:16:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2BFFkeV2Z61/pr2T9vyqSyn8wSM/ayYqGps2HoZpsO9C2+HQZbyHJzEtxrBe14s6YuK6JnYsPKVziDkApkkN4nuTYWP1ffL12QCdTHtwKdKCkqYFjOLcJwhAxn+uM39PfUUYc5NvPZ/oCZ7Eaun/nBaUc36zSog/3Z4prlrQ9cV3GQS5RfaUXop6ah7GaF6uk/S+YblQMXfwYVfbJsi8PENFQU4bfpYtMmKip2vuvFc9sUG3V84l877p8Eq5zBoA6Y0zlSE/lc9X6xy2qbt8DkO+XV9MEoeiCHsXv3n+RqWek6SEmViufNTI+uFXmLiuv9Z2TTnbA+it3eR6ygVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ5w5GHbCYylP32rqPTQYa49pHnY57UQY5QDmKMmWvI=;
 b=D20bFZ0Q7bhMArh2J2n7yAqssakbNudLH5RrlDSmpQu/aVLAfEhkvC+HB5TjGpOW53cUCksLbbyQXZEM05xCGytPMa/3IReRwdcLbOS0o6EyM2iaEjn6PO4iHoxr29VBvP+rhhfvtNFRdSH0dseKlzkQCdDzYg5ae4a91snS9yusjANwu55YFtOaQBuFNocINWfxZIaIpNoqaK4hf6JefJTBvsj8wGcVeFgjgGg+qyPQvaUDqpiLGEj9fV6XdG75aCsqyJ54Fo4/h9qJjTOiJ9hZ6l7m8KC8oKsCOBF0CUnMxJ474soNU4/hJdsDKc+6men8JWIL/yNR5kRm6kAOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 07:16:10 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 07:16:09 +0000
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
Subject: RE: [PATCH v8 06/15] iommufd/device: Hold a KVM file reference for
 the device lifetime
Thread-Topic: [PATCH v8 06/15] iommufd/device: Hold a KVM file reference for
 the device lifetime
Thread-Index: AQHdbHgT3OmO4yusNEikpUmv6S0QJLcgoz1A
Date: Fri, 6 Nov 2026 07:16:09 +0000
Message-ID: <CO1PR11MB4835982DE81AFE060EEE01B88C762@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-7-aneesh.kumar@kernel.org>
In-Reply-To: <20261104161632.3547423-7-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA0PR11MB4669:EE_
x-ms-office365-filtering-correlation-id: 43620393-4d0a-41d5-d922-08df3bd5d4c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 5bEwltfrDD/IQv99IoJZJvW/wyQUSBKSKcg2Tg7reSZeOoVkk2A7qt+O5xmUz0APfe2qpWN8Sve99rerJciEppAje64ncfxOo4avyS6hnFZ56Hx5k+2zSr1xFdrgNOFfU94jPcuZOKFFLAMALo7Lg8R34Xno8SuHmwz8uATq/1F56W++AqT+K6+KTkwsJ9yDFSwejSeRjuW+65ceo5ErcpY7iUlYVw+52JF6E7iPf+7hlgtM6SV9FBjyzL3mvtOdWV99Uav6HPJ0PA+0iFOvKsadsh54TZPkyU+iGUsRWNFonWi7kJda0zAI+Y/o2Fzku+KIG3iODIj5bqDd3AoJ0+3KTAUq4D+NBbxuovPY3gEtWZnLBLgBhzl7ugSfooji+kRJ/GsWIPEvEFFarl+eF33PkrbvHpwULVrFSW6YMMwj+i9DIDdn2OTB2JDjJftTNwYFU4hfraXHp0YoBeut/YYGJOoElUeKnwCt/pWFtYttJIlkUDWvN7cQh7hBSLZiEwwgZGxxocToawUe1vzjzGEG2cJpJsu5XIA4RUujsv9GxfdORlcM1ZCdMwnhUptFbp2LvSeeiWXDYvCIF3CSlnkaStuEw5UKJl01yW4HN6Htdkb4DOcvDuBu2QE8wFWr/E8Cn6uANaTQuPgwtcQ7xOdzABL4haVyxRP2kO/7qLAoL9cW1ASfM6hoDoyPDcjlSALiLGIerjL/thWFEnurhVC5LzYzEBlrVBKit6VHGUE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j2fI8ZDSH5eJ16rvBSPAHje8w9Ua4tIj7NdP5aGfWlzhmkKSi+hFcveoSSei?=
 =?us-ascii?Q?FZLTNsjPkP43hTe1ETHl10i/eJ9xaBVuM6G/xFTJB4dJ9U4/ByRWC1jKkAMD?=
 =?us-ascii?Q?yjObDVKJEeWBAU0eKZsXOjJsCgdj9C7n5/rHDmdFvGBgzDJyyyg3XFIJBMHI?=
 =?us-ascii?Q?H0cFM5E/5Du0Ssl379WTcJWL9duFQmEYQQwj3xAc//7ijWSQwNPSEUNj3qIX?=
 =?us-ascii?Q?LeH39pLWFhiTmzDvcFGCk5tTxoJ2DHgtL683xnQeqav0nQzolhFzdcg9Pg36?=
 =?us-ascii?Q?FIi/pq2XKwcbOReo7BFUUWETqzHvAIApflrkZjPN9WFSKHJMDqsVUr3m60RI?=
 =?us-ascii?Q?OWWbsQ5BsLCBU24M7s45/Fk4Yd7O/8VkmDUpusnphaWHLg5Aw13CGfaLFPag?=
 =?us-ascii?Q?8IWAllRkVhCLzRecsoURHsXXbgcgXcOcJFOEW7cx/C5mDoqdDo96Z7Oj9S7l?=
 =?us-ascii?Q?HHOBL4TFIe+rYRWLnqbUrSTgll60SA3cMt9kXv9ukMGdRYi81L2ToV1OZuDc?=
 =?us-ascii?Q?ZetczoeniWwHSab8wBFA1rvL3bWd3o5V5xTTahVAtc+1TdTXdvJ4+K9GdCxu?=
 =?us-ascii?Q?LYBW9+zwzYerxejCbo4z3JORgNq7Sv0RywaksVROPk5hdNopwiOmGnKu5yj7?=
 =?us-ascii?Q?TB1GqlFCJNc/nNz74qZFXuJFi6MKNm/baNux6RI2SkM++5C4sHTMWo1lw1fn?=
 =?us-ascii?Q?9AK8Q31ewtIR8jzpABwOBtg5olrzX5r7/fmTMSxqrCa4N4JoJksv3fAtvjGv?=
 =?us-ascii?Q?3eI4OfqCcYWcTxIZ0r34Wwj3iMDmnSBqtA8stVFooNYrZKbNmE7KxYjmRtB/?=
 =?us-ascii?Q?R2/88ZU5oWxHhP/p6XG/dTMRkmpF0pFX/OG1dsXQZYUFY4TbhRcE4RVa7rSy?=
 =?us-ascii?Q?a7QyB5zc7NrUV+oJKANqqFTHWiaS5U0Y7gqlFhcrMVcX7dFz7GFz2z3M5E3d?=
 =?us-ascii?Q?nRYC+30kt0kkZituNIV/xXJZ3w0C9hrNh6zVAS2BnPU0tk8TcyyeteeiS8/P?=
 =?us-ascii?Q?gyckLX8kNs4zbRbjPQYGY3dqDjvaQ6Tg8g7M1oKxYfcVPcZ6J2yETHMFjoJz?=
 =?us-ascii?Q?Q9bgTX1mQigMEpvadqRbA4nf3sQBGOY2twyLB3vC8zRuhRHL7kcZZhLULXGB?=
 =?us-ascii?Q?w4bKWjFSFGGDx5F5yrANZ9h4FC9Z4M4CJMA3QPbQw6h+sXHxakvM8rHOD4Qp?=
 =?us-ascii?Q?sm4W9kIGZQQz+bxr9yoMUqmVroK12zkwRRyb+fZHnN7YmosktTnU3sajCI2A?=
 =?us-ascii?Q?DjAoeVOS5/EwipycN3NJ+wgz5Zy2B0/qzqVMBQc1vP8vQdBqfFTuIF/jkx/I?=
 =?us-ascii?Q?U+HLDYQy1Deu8bwrkKs1/yRLpRILq7SvIjG+G0ZpVmDn4MqVHQfEmqw4LZD/?=
 =?us-ascii?Q?piJOYzBKFjQ/rEC8Yts8+B/4L3MJWRfJ0YmPu6u0qoY0d80lN5tzxNYHXRg7?=
 =?us-ascii?Q?nTNVausEWAOjAmCWyJb1KSCGQitbOkoyy1zqRf+jjpT3b0ijNWpDmSlSXTvR?=
 =?us-ascii?Q?2WVeCqGxqzuN2LqEGNEBiK+ikxFoC+SgF9WBnxQ4kCSyMhln1vSB6hrpoFQc?=
 =?us-ascii?Q?4agOGw4/Or87oFtb5bhVzclo3WnvHzI28aCqJR29NsLkSaSly62tlwoqq9Vw?=
 =?us-ascii?Q?AqtSC4vNgPAPY7jJRWCnPxKTdxxdNaJqBAyvevXM5uwwv/DuG7HvURY9G84f?=
 =?us-ascii?Q?3GbmDP7O5IY3Fm4kMfAT77UzOBP5bt6hqpMT7I+pHAPpU3fz?=
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
X-Exchange-RoutingPolicyChecked: bVeJ3srWmR119MLP7rbX3A2coQox++7DxyaE4MJ5pJFA6btxfMQ4baH6sebUrEsowPde5s/w3Q/LQ4abtmbGL9RK6lhWHPRQgyKF6D6hm0FKzvrhInrf4L6d97gudXL+7F+tsqCCZGy5KsmTpjxCU0pjL9ZAFEy/lbWTIVKSJ7o126axL8I+XMd4ahXgIE4lNgD6STL6vvFcj4wPsQzX13WNxVoDk4M1qjwSef2xawiSYWMnQTDImReurgQepR7aYdqdVY3IGDqSM3GLRb76ls+UVTvyOpT0aJEF0+lHXukhIc5+fL3PSymhtStcymtC0D2vYjmxSzrjHIctRygw+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43620393-4d0a-41d5-d922-08df3bd5d4c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:16:09.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuYzEA6Sn89Ev6sqUvLYqqqNJAyBcDXO4o/8ZxhHalYrrSBxuPAk/fEiiN8/bynxG1COC2plqTGW24iq+KRx/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Thursday, November 5, 2026 12:16 AM
>=20
> The KVM file stored in an iommufd_device currently relies on the
> reference held by VFIO while the device is open. Normally, unbind waits
> for outstanding device references before VFIO drops its KVM reference.
> However, REMOVE_WAIT only waits for 60 seconds. If that timeout expires,
> the device object remains in the iommufd xarray.
>=20
> For example, an IOMMU_GET_HW_INFO ioctl can hold a device reference
> while
> blocked on a userspace buffer fault:
>=20
>   iommufd_fops_ioctl()
>     iommufd_get_hw_info()
>       iommufd_get_device()
>         iommufd_get_object()
>           iommufd_lock_obj()       /* takes users and wait_cnt refs */
>       copy_to_user() / clear_user() /* may block before putting refs */
>=20
> A concurrent final release of the VFIO device file takes this path:
>=20
>   vfio_device_fops_release()
>     vfio_df_unbind_iommufd()
>       vfio_df_close()
>         vfio_df_device_last_close()
>           vfio_df_iommufd_unbind()
>             vfio_iommufd_physical_unbind()
>               iommufd_device_unbind()
>                 iommufd_object_destroy_user()
>                   iommufd_object_remove(..., REMOVE_WAIT)
>                     iommufd_object_dec_wait() /* timeout: -EBUSY */
>                   WARN_ON(ret)
>       vfio_device_put_kvm()
>         fput(device->kvm)
>=20
> iommufd_object_destroy_user() warns on -EBUSY but does not propagate it:
> iommufd_device_unbind() returns void. Thus VFIO close effectively ignores
> the unbind failure and proceeds to drop its KVM file reference even
> though the iommufd_device is still alive and its ID remains usable.
>=20
> Once the remaining KVM file references are released, a later ioctl on
> the still-open iommufd can access the stale pointer:
>=20
>   iommufd_fops_ioctl()
>     iommufd_viommu_alloc_ioctl()
>       iommufd_get_device()         /* finds the surviving device ID */
>       get_file(idev->kvm_file)     /* accesses the freed KVM file */
>=20
> Take a KVM file reference when binding the device and release it when
> the iommufd_device is actually destroyed. Release it before the igroup
> check in the destructor so that bind failure cleanup is covered too.
> Document the ownership in the bind API and device structure.

I don't think this needs to be fixed. There is already a WARN_ON()
in iommufd_object_destroy_user() and many bad things could
happen afterwards...

If we really think an ioctl could take more than 60s in sane scenarios,
it's a more complex issue to be handled in iommufd core.

>=20
> Fixes: d8bb80c8f0e5 ("iommufd/device: Associate KVM file pointer with
> iommufd_device")

btw no fix tag for an issue introduced by an earlier patch in the
same series.
