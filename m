Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793346121;
	b=wYugfiJHzW/J9gaqwIwcxpSwJZM/74E7fx7Aec31mAUmLK8qBaL7bus6SnmVI5Yvz0Zf
	 c7OVmyYoJjuQZ5+tDh/w/9hv/2pm2vCBrFUw/psQZPwx7X4m5MXGKfjsdyyBaiPgTFWek
	 tFgQr5T7Pp1FRNqYC+ebQrf5eAeFudyF+XGq5GyLYSfceGi0ViTdtMwO8YkEqkrcM7h3S
	 SI7GzJMxRfAZOE0T/K3BHXjT6RpobsxZv7zCV2uELoCD/TcJmluJsopl5HBAqUVMiC5B8
	 DjV/QjPpaeQR1bD89nneQ3X9h3MODtO9wIe8DqK/cvIpLQQareOGPHbG0VlA4soCjRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346121;
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
	bh=fIe2fVLq47lhu7tJbuwi/qLYYo/NCjmCC2mb46YXLSk=;
	b=Ba+a/YCDcflVbqp/TuE8XQXBlpB6y4cWhh2fDI6tMX7MjQqFNz4FShfbdfYoxFeBYMHb
	 lXV0bxJLRwWRrA0a6luzFWwTcqH1j+B0Nux93dDQheGjTYpmv371rWoE4fBh+Yp9H+ml4
	 7DFsrF6Q8YgFiVk0gKmxAOkiAuXmg/kUM6ZjXsKE4UOcByUNo0heglT9ro7H8d8f7FQPj
	 LE1gII611RDgCuCl2e+U5uuF8+I0XanT4i3w/rhS70BeSdvGzkO1XPMkpXEFkv5oFz4/M
	 yfFsYvrVUbiVRr4HfGQHbBbl6F9L1OOTsMOq3LVQduA5spIiYDlkFcM49ZjTwFUYVsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eBEKwnrH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F1606A31C;
	Fri, 30 Oct 2026 07:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eBEKwnrH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793346114; x=1824882114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JKuq+enupRH8FUVKxT7u/K6ba3meoMAfmz2a+OPEpEc=;
  b=eBEKwnrHd2ggrAuGZl193k6CKv6MhnPl14+deIyZx9nlM1zmBMmBp/o2
   lCpSkE/6Bp9Eh87WU5mpjY+SsLUHQHSmCRf4hQObdYMgbxnG9fVxWg7K6
   Kk+trCghWiUWNzWKt6ZQHmp6hw37EF9F7qvDeUAw/IMq2+XW/wLd+lQK5
   Qc+uWygBhNz6FZ/WB99CpqejogsXOpAAIwW4euRfgDQJH3FwKL9EG17bP
   AeXr96t/CglvQoSO15ykXZB/DgxtsPwgnu8hmiy1cX2pfouY0FxFzhG7m
   Cf9PzCzS5Oyg4psl2N4Q0Lk70hNmn3PQjY+fczbtM4IbaP1iRAr82tfh7
   Q==;
X-CSE-ConnectionGUID: AdEcf4AIQ5Os79k8nlLVWw==
X-CSE-MsgGUID: 7ZH4BG13TCutV+5MxyVBYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1989550"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1989550"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 00:41:53 -0700
X-CSE-ConnectionGUID: 2PLduTI8QomvMyhx61Gx/A==
X-CSE-MsgGUID: gzGB7z25RKec2sknnjShxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="7152501"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 00:41:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 00:41:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 00:41:51 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 00:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhgt1yE+bTw2ktzMCE6BK9O/EC1QJ8XX3EVxGb0C/90b76qBZj9imaIhU+TcNYGcsKvbK3JCk28iyEziCxnD7AJvFB236nRgDVfFlmeKzCL3Vq2LnflUDIEvhw/q5oNdjUERKxzmZ6/CHyHdxWPRqxGVfuzvwxmv8GubufeqgaVsqgjWqwo9JJD4aqc8rx5B2xIpzeCZ2Z7A2o2ZDcWNm1jVRaEijbzCKEfNYaZrJFFLBSmkKg5ctwUbVQQPgDoQ/SUGIBf5ydavEX1UUO18lPysHPEWmgt0ONK/78cbxKklA7e/EVj7YYkFRcg9WL4bNTIQJOFTS0Fbm+zkYmL4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIe2fVLq47lhu7tJbuwi/qLYYo/NCjmCC2mb46YXLSk=;
 b=NakxpWkvT6FnLJpP9hTVPgJCMjf7GG3tDPcL30Oah2rx8qE9LN+kmWuNAwM7YyuUCEiF3UPuatRpsVgS5D0qfcJBSt4rYGmcs3mWBwPmBf25N0D0n6dxO8Gku6oD5gH6XDsCx4wQnB2tOman4+Lh4R8gT+d/QeP7dXMpB9hb3pmKhed3v7cdttbEAlRnhCJaHGphMUVcYgE3bRkxK0CD8dtunxW9IYF20UEiAPFLZFVQhuEm8IeIwFRZpft58P5tmY1bZVKpBu4tzfohbdei3uK6cPnj497tHGaQXfuZyMH8TnKnno/jiQmbbSM8xqLt0EQ+mpYVDxTwWOOEWZp1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MW4PR11MB5910.namprd11.prod.outlook.com (2603:10b6:303:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 07:41:37 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 07:41:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
	<alex@shazbot.org>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Jacob Pan
	<jacob.pan@linux.microsoft.com>, Joerg Roedel <joro@8bytes.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, "Krishna
 Reddy" <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Nicolin Chen
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
Subject: RE: [PATCH v7 10/16] iommufd: Add the vdevice TSM request ioctl
Thread-Topic: [PATCH v7 10/16] iommufd: Add the vdevice TSM request ioctl
Thread-Index: AQHdVuqLnkDudTU10ECPGJY5vEDWKLcTcUiAgADzIwCAADjrgIABMt5Q
Date: Fri, 30 Oct 2026 07:41:36 +0000
Message-ID: <CO1PR11MB48352ED3E4DEB3A8B4F089AB8C6D2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-11-aneesh.kumar@kernel.org>
 <179321444123.2412245.6955528563980811144.b4-review@b4>
 <yq5a1p98c0f5.fsf@kernel.org> <20261029130117.GH3040767@nvidia.com>
In-Reply-To: <20261029130117.GH3040767@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|MW4PR11MB5910:EE_
x-ms-office365-filtering-correlation-id: 12747bfd-aa90-4270-cbbe-08df36593a07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|23010399003|366016|376014|261026140227099003|4143699003|38070700021|261026130827099003|11063799006|261028144727099003|56012099006|3023799007|261021135927099003|261021121427099003|261021123027099003|261022115727099003|261022105027099003|261022113327099003|261009223027099003|261021130227099003|261026121527099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: ogTmrhSNkPSlZjFB35IcW14qQniKrbW7EJGtNOF7Jqhkx20umU7txUBiHe+iKwrqJ+wRreEqkGlB1/omCPdTSEILKy1YY6dRaIBaqxAx08QX7bTpztKEZCBM11XjA1pq2CTgEfidtdZA8GNx+jWWO61BhLxHmeDL1lvUTXuMQnlSUFRdDuWonj/WXGr/Y19c3KMh7Y5xY1uWGmIT6Cj4jzglu0D1dUqIQfO3iMS7WSsuFyomLr0McLYiVxVHzw2S4Yw2XkLFUoifLDtUnZoQN5/bHib+vRcQsDltBdXstz9AsiOvjb6QZhW6iXCp+G0hbzYqEv/ihRtgHS8PeDeUtrY/VPWbBlxkotgprnlXWYTDXF7WdW2P9opqnRWcvzAc1ufI1/AWtFNs+YpLmmcLwY+bhdMJBxd8NmjgMEKZb2kyHW9NejRBP24tHmEDve4XS9vEunRRxaFwXIM5cHqFQy9sGW201oj3S2dT6Eh+Ys+RDFd4IddsI2L+MFc7zC2hFq3Ny+FYGGNGktoWDFpiVJFDs+nR+JzeXxEjjA3rHg5JQx5qSYVJ6+ilJrbOgo+Uct7RdA40hfqaJMbk2Lf8rz4MNoUSOLdySn+I3LEYbEP0GLh7TdhdMy6mGYKDLtNf+GgpDZuXCokkr+qxdBYTi4BLsdMWCM3q+QbTwpIPIyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(376014)(261026140227099003)(4143699003)(38070700021)(261026130827099003)(11063799006)(261028144727099003)(56012099006)(3023799007)(261021135927099003)(261021121427099003)(261021123027099003)(261022115727099003)(261022105027099003)(261022113327099003)(261009223027099003)(261021130227099003)(261026121527099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KUO6kthG4mYxd3JTUJauyRaPjbaggDfcN8K9mBQhr6apIdvKYo72RyuJuMb/?=
 =?us-ascii?Q?GqoIA5kigtJi84vm7KocC/7oKWRQEOffI5Zc0Hv4gPKSJorBTOELREcjBwYi?=
 =?us-ascii?Q?a1gOZGNBUfUWonnlga5q5rWr80YYQKpsoiN7ooIJTg0gcQNcVfN7l+ujZiZh?=
 =?us-ascii?Q?ELeomI2db7/LINblPZd88kJYDVylI/Wt1s9dVLGUv06AVgQY739uHPjn6TXB?=
 =?us-ascii?Q?dI0qfIu8iB4/NnCRF3rXQhrc03t1zF8mdtlDZMKdWVqAEgabd4l5JbrWXAPO?=
 =?us-ascii?Q?QRi+HB5A6GAOvaAKS1nv8Nn0aTrXjkMkKq2J3ILmi3HQFBZ2+Yq+NCoE8Usj?=
 =?us-ascii?Q?nXKFtVlH5DYfVWutI75om2eJ89AeUttNLzYha7MEUFs5M2bXKHP444w3UTC/?=
 =?us-ascii?Q?f/cNjgi4B4ijDylwL5IEDw+1OLjV33VpmPfdmhhohWa/BxvKxX62fLNUQOpB?=
 =?us-ascii?Q?/an8Qd92KANIZHyrHTy/A/SbmoGnl+t4WCDusnCU6aYw0IvgrSPXlz1M2cK1?=
 =?us-ascii?Q?fqlBdokxl4SlxchEqFJVV4jxdEbbCpHON8pkYJysznW99GmT8c4ANsma38Sz?=
 =?us-ascii?Q?8hs1gJeoiVVZu+t8oHEQhuy8jaAvln20qElIWYdU7CxMuxBuNhurDWMK0tt0?=
 =?us-ascii?Q?IvurPldC4E+aTsumY0qKPbKDMFIfO3z4ouw9k1CIULNQj/oxn2tNm3B8ZLXV?=
 =?us-ascii?Q?3WhduALfTY7pGM4D22/lRoOeiJP7NZBij9p+ATLkS4+AxTjbHdWs6SjfsFBx?=
 =?us-ascii?Q?Ot7VJ79npC750ISMXa7Oswnz/OHVo/zlEFGeJPA3z80K9SI2kJWcvctRzo+i?=
 =?us-ascii?Q?Bhf6Un+OaRXEU41PSPbzRg7dwByZ8ygqCweNuyYvJyZM0FtSNc5rcSkjhdfW?=
 =?us-ascii?Q?RXawaw1/v7SjTMfKVNin3xH5uctVtHeWd6/jiMMIC4+M2DyXmqa5z/KWKlJ5?=
 =?us-ascii?Q?wT+WeVrQ6JOjtCyF0nQJWoBtbGN0NVBD4jC84sLOXhFT5jqar8Aot5c06ZeZ?=
 =?us-ascii?Q?5OMHGqE/mh10ZdDy2WuxRKycemt6SFcMpFXg6EHQIzEUR6XeGcM9qdLEMxpS?=
 =?us-ascii?Q?7Kzc99jGqJSbU8X1YW5H+n+vwrtBNelnpieFMZ8MtsNkr9qD88gLVHi1erK+?=
 =?us-ascii?Q?8KFsHZjAAsc80jqq/1y8PDpHIJWHJtd5FFEEZ1C19UNOJMBIY8MlEbkES2xq?=
 =?us-ascii?Q?ZuJnO4ugUnerpKEbVe+pUumJ/HLreyNntMTo4IluAxoiAN6tnWopYS0TonHd?=
 =?us-ascii?Q?OSQYxiPSHHTLW0DywLmzogczBSG1+dGq0tHSvLSxhLs/MY73ICoeYCWPgxLw?=
 =?us-ascii?Q?sv8sTg5EIPCgU/oKJauaULAitEWNxRAE1zzRHkrC/nvzNrGv4lBoEUK/02s0?=
 =?us-ascii?Q?oewdSJCoGQiQ7NBGcMeJ2XiKzY2CZDNY5aWjAe7aAjavZyUrwvYYFXtpoj/i?=
 =?us-ascii?Q?C4QwgdmsDGnEQz0tzDeXl3brdg2f2QTRoEMdmzzpHFplzs0lwVvRIGssv1GZ?=
 =?us-ascii?Q?Y9SblOF6Ge+4FhQt3ihMS0AReby49cqGiDNmgGlCd5nh9RDwiVASsa7yEF1d?=
 =?us-ascii?Q?uEjjV1V9BtIwnF/AboOL/1mOk7jyTj0wgcE0CDzOtOHm0i81+5okKtFY/E/R?=
 =?us-ascii?Q?UXz57ACm7bxxk1tcHWRJiXCsOa6cVnfbZLNM8kNttb0bxW2sflAK7fOhn6DA?=
 =?us-ascii?Q?5DRUw9NDoAEYkOhuM7C1VSN/rY3KBg0dwXhhB6cHlnDsgyAqZxz0v+c7Iogp?=
 =?us-ascii?Q?ycW89BPi+A=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: 0wzsDmfhTX7cShrk6qolmuPvgOd4L7vN4IBLhSD7/REJaxBie5Z6CTsX+HS0DtDLk+J49M0FLXo00Q+W9Snmv5ctZg8fDyj4WFmEL1DmxSsHRIqYK5Yw0zFCiv0mcaAu5Use7oguEhf0xqwJh0UVqPgszWBOHjwbH3gb27u4eTTIBd9g+JuOrATgV0P+CAjw8jYz7NmM/yGKVWCxxvuuSFHE+4Yc/vcWfWTd9ch6Xrz6HiXbTVe2mj6EdrhzoErDtUuyS7Ew5Ax0u/KHdDMFBabe1shxEXqNSxl+dLf3ZOjCUwomOL3HWxsVB1FEQo6IlB8U2pVbn2bz/wGuJ4H5kw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12747bfd-aa90-4270-cbbe-08df36593a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 07:41:36.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8vpM9GeVXOfZKkUsJdJ89rycxnu7e96gT1q1sZrZIGSLBLviIlTmIn0SiL4lBuckcOpvT7d5IF/pUYTPec/xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5910
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, October 29, 2026 9:01 PM
>=20
> On Thu, Oct 29, 2026 at 03:07:34PM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@nvidia.com> writes:
> >
> > >> [ ... 300 lines skipped ... ]
> > >> +/**
> > >> + * enum iommu_vdevice_tsm_guest_req_op - Guest TSM request
> operations
> > >> + * @TSM_REQ_VALIDATE_MMIO: Validate and map a guest MMIO range
> for the trusted
> > >> + *                         device.
> > >> + * @TSM_REQ_SET_TDI_STATE: Transition the trusted device to the
> unlocked,
> > >> + *                         locked, or running state.
> > >> + * @TSM_REQ_SEV_ENABLE_DMA: Enable DMA for an SEV device.
> > >> + * @TSM_REQ_SEV_DISABLE_DMA: Disable DMA for an SEV device.
> > >> + * @TSM_REQ_READ_OBJECT: Read bytes from a device object, such as a
> certificate,
> > >> + *                       measurement, or interface report.
> > >> + * @TSM_REQ_REGEN_OBJECT: Regenerate a device object, such as a
> measurement or
> > >> + *                        interface report.
> > >> + * @TSM_REQ_OBJECT_INFO: Query the size of a device object.
> > >> + * @TSM_REQ_MAX: One past the last request operation; not a
> command.
> > >> + *
> > >> + * The request payload and response format depend on the TVM
> architecture.
> > >> + */
> > >> +enum iommu_vdevice_tsm_guest_req_op {
> > >> +	TSM_REQ_VALIDATE_MMIO =3D 1,
> > >> +	TSM_REQ_SET_TDI_STATE,
> > >> +	TSM_REQ_SEV_ENABLE_DMA,
> > >> +	TSM_REQ_SEV_DISABLE_DMA,
> > >> +	TSM_REQ_READ_OBJECT,
> > >> +	TSM_REQ_REGEN_OBJECT,
> > >> +	TSM_REQ_OBJECT_INFO,
> > >> +	TSM_REQ_MAX,
> > >> +};
> > >
> > > This is still no where close to being well defined enough.
> > >
> > > Everything here must tie back to defined spec references, listed in
> > > the comments.
> > >
> > > I cannot guess what data is passed over any of these APIs, how things
> > > like "REGEN_OBJECT" select which object to regen, or what the format
> > > of those objects even is. The formats of req/resp are never specified=
.
> > >
> >
> > The request and response payload formats are specific to each CoCo
> > backend. Since iommufd treats the payloads as opaque and does not
> > validate their contents, what would documenting those formats here
> > achieve?
>=20
> Well if thats the case then no, this is entirely inappropriate.
>=20
> iommufd requires every single struct to be documented and
> described. We do not do undocumented opaque structs into drivers.
>=20
> So figure out exactly what needs to flow here, give it driver specific
> names for driver specific content and document everything.
>=20
> This should be done patch by patch as the drivers implement their
> stuff.

some could still be generalized, e.g. setting the TDI state. There
doesn't sound a good reason to have vendor specific format for
that.

Then if your suggestion of using the attestation subsystem here
can work, those OBJECT related operations are generalized too.

In the end the set of vendor specific definition here might be small.

> > > My guesses with no information
> > > 1) VALIDATE_MMIO why would the hypervisor ever need this? Guest
> > >    validates MMIO through secure communication to the secure world.
> > >
> >
> > With VFIO PCI BARs backed by guest_memfd, the VMM can validate that the
> > IPA and PA values provided by the guest belong to the VFIO device.
>=20
> Why? Who cares? It isn't a trusted validation, and there is a RSI that
> duplicates this?

TDX doesn't require this. It's a guest call directly to the secure world.

>=20
> > We previously also used this operation to ask the CoCo TSM backend
> > to map the device memory (the BAR regions). I have removed this
> > operation from the latest series because that responsibility is now
> > split between the VMM and guest_memfd. TDX and SNP still need to be
> > updated accordingly.
>=20
> Right, it should happen automatically as part of lock.
>=20
> > > 2) TDI_STATE I thought at least RMM did this with an RSI?
> >
> > CCA uses RHI. The RHI reaches the VMM, which issues the ioctl to
> > complete the request.

same for TDX, using GHCI to reach the VMM.

>=20
> And then the seq numbers check that this went through OK?

which seq numbers in your mind?

>=20
> > > 3) ENABLE/DISABLE DMA, see #1, must not be done by hypervisor
> > >    See my reply to Alexey:
> > >    https://lore.kernel.org/linux-
> iommu/20261022123058.GC3008132@nvidia.com/

Not required by TDX.=20

> > >
> > > 4) READ/REGEN/INFO, what are the objects? What format are they in? Ho=
w
> > >    do you select them?
> >
> > These objects are cached by the hypervisor. For CCA, they include the
> > certificate, measurement, interface report, and VCA. They are read in
> > response to guest requests. The requests reach the VMM through an
> > RHI, and the VMM issues the ioctl to read the requested object. REGEN
> > refreshes the objects/evidence at the guest's request.
>=20
> > >    Does this overlap with attestation subsystem? Should attestation
> > >    subsystem be used to access the SPDM related data?
> > >
> >
> >
> > I had hoped we could use it, but I could not find an easy way to
> > integrate the two. We need a simple way to read these evidence objects
> > into userspace. I am not yet sure whether evidence-get can be used for
> > that, since it does more than simply read the objects; it also updates
> > evidence.generation, among other things.
>=20
> It should not do that, the generation has to follow the locked state,
> not the evidence collection.. See my remark to Dave
>=20
> I think the bigger issue was it had to use the VDEV flavour not the
> PDEV flavor of RMM commands, and it isn't obvious how we switch from
> PDEV to VDEV mode on the hypervisor..

Can you elaborate this part in a general way? Want to better understand it
in the TDX context...
