Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6053CAE83;
	Tue, 31 Mar 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946429; cv=fail; b=kXD0bAW/qs9Z7pMYC6OQjt3go0dZuoQ2m+g1p080aRcKlVAeuXVrnCEkeeEgq/sQ3MWYUxdBkiDI9LyINbQyuOLf2BhYc28hkt1APlYaKPflNATtTxONJ6nZhgaBaatQe6SJCKyHm18fsZM03ZawZcrRYMI6hnsXI1m5OfilJYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946429; c=relaxed/simple;
	bh=1yTaD357ZfPgpmlLX99YnTZCUORqf2vkYfKaaaTAwzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vtys1Pl0BbjpjTvHHVBohDQo3k62DDG32ApJ7fpo+03rpv57QpAqFijXrY//lZLEbPeV0kShontrp/9fYlvXLrwM24wYv+WVtY8NAZxJTTqBdpAkWIdhWb0CptzDIrImi5DrfGMiBBDWDn8UuyzAdo8lGa2EO4aYJJF/rjT/V1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8PNofaq; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8PNofaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774946427; x=1806482427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1yTaD357ZfPgpmlLX99YnTZCUORqf2vkYfKaaaTAwzA=;
  b=e8PNofaqJr4Artmb8pA8pRLq2EhPJloDOA/v8suC+X/B5+hzZLEW4pcc
   MLDBWGo2RxJUxKrnvds2tn8kZBwO7ujoF+0HJR+MEZ2P5J6LBrxvLX6Q2
   D+l67cxu1c7zuFWeLygDNZt0nRb1Lo93ZEk/WOfTLkjc4T7ni5C5kaSGc
   ADHmWv0KGXfzIUFiOeILPIWZrCW1u9p3x2xIOvFXP8bd56WcqODivtUJX
   mgl4cDs0tvHqU72amoz3MT38dqYSSlPLLKGYrAwL7nlqvbwYG262ZW4xc
   0Zw6Wln7cgj9bp2TikzU/0yKllw5Fwg7lS0B3ArztjgQza9/lr9TxejZW
   w==;
X-CSE-ConnectionGUID: Z+D4DHPxRl210NxUAjaaUQ==
X-CSE-MsgGUID: Ab4WhS1yQomUsutYRSqlxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76012395"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76012395"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:40:26 -0700
X-CSE-ConnectionGUID: vvDBJ73iRKiJhCzF14/nBg==
X-CSE-MsgGUID: nJDK1wgvRX+SKzXQhQD5lA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:40:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:40:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 01:40:25 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKkne7t9Swjhw0UmvYpwiHUkl4E+QdqyS04yqUT+pJzYTEbeHiH5LHoNNWhgptgDV1f6yVSmb1axSld97ymz3nNCvlJQpxmwF/f8zniO+jCACedN9DDE2QGXieOCOvfTQ1D5REehrymvRNKZeHlDz+6fmC5ugA+4+C6hpnC/D15qecnDzDo+8/jCZ9ch5bkQpJxpEvb8PXZI5GerWwrc45ppSezCvWIr+lUb4BpVBQoxl+mlzfk2ejKbIP+2ZRtTBEWNUXLYk5z7GMibI1A9fMEi25e7wbt5+NcoUIUORsrC8d7N+c6cr2sZGo+nah45PadEAaKMCdO2BRHuixwcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irJ+q6XubI2xsvkn5/WWgxsNoHiTSFW/w8XrX8NPEPI=;
 b=bS/tyRwmp8DYCboAyH6ySmKugCK39Eil9Dz7RW8hb5FaJFEoHJPVyE7zne0eq45iTWT1YCz59appyMg5uIXDZJxEpBUi1s9tOq7eKoPwSE1INrkFNbGLC/DsepydYVF022EthdNqYK1G4d680PL8CENQDsayQ2SattfFYWR2YBHAguU9MeytL55YXlTaXhWqPIbL48K0xmwcCGanj7t/5cJllgx+YlxyvV9DiwZGLNlw5PWwu3J0ctd+p0uaY5Xy4P2/mYN5+FAA3hK7NtGvtx/nhPwa+JbzaG3dEXn3KCMgbb+aXhRR2pcOwQ70qy9VEzDzr/qunRA6kk+tRg6esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA4PR11MB9060.namprd11.prod.outlook.com (2603:10b6:208:56d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Tue, 31 Mar
 2026 08:40:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:40:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com"
	<praan@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Vikram Sethi
	<vsethi@nvidia.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Thread-Topic: [PATCH v3 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Thread-Index: AQHcrcLd1vjxmcKV5EWISjNWHzO55bXIeBZQ
Date: Tue, 31 Mar 2026 08:40:17 +0000
Message-ID: <BN9PR11MB52760A7F20A1CC2BC0DB018A8C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <0e8d1ee1557c54943dd15ff836576de4c3aa58b6.1772833963.git.nicolinc@nvidia.com>
In-Reply-To: <0e8d1ee1557c54943dd15ff836576de4c3aa58b6.1772833963.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA4PR11MB9060:EE_
x-ms-office365-filtering-correlation-id: 9afd2387-ea83-4960-ef25-08de8f01232d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: TN2TIc3lzY61dnHCu9UElYOKgwy44RG4PN9ZdoP2dM3opT4bcu5gAMk45Y9yZD9oH5hQn5k6CmGcSPT22qWTQuaAdLR1DZXse11kYf8Vd55xElIYsl9pv7c4J3SXAGTG1FvlRmZYeWUkr/7PMO54KcPdAn2Rx+tCz9kNZsT79LwEIy8BhqjS7xgigrWT9p0Hx9AwAcRYB/c/sjAoeh1o1nqp5eTvu7JRetdzBX5JscTboK8n/xVuSJZ/oEKNEq9zVGuEFruWbMlURD4jWX+AFYQaqYEv//sT4pzqg/EB3kwmY8XRO/MoVq7njM0bhAipOqqGaUy1s9eSmdyDvyzdr2O6WifXa+ZyHXD2J4YrXU+36camqWebPyVIB+LY/EG3HAK7fESoyqebIoOc5WWY81beR0ppDNeygDcmpTMVHyc/sPzSDoslApgZWXL8VJh/PKTj0Hucu6SkNIrohewbtMQPNLVn6j7IbTKOeoMjsS9o5bUk80fM3YjCq/mRPCKvjfP0XD7TlMYWMtNyyTTFdAG0+AVgfisMXxlbCmAHqw4W/0BJVbJkQRrRAWohHPMxAkF9CmlpYOtqXdgnYzvMQN9rrUGm7WdXxsnK0vkzHE0DDiQBBZ81ik8vbEjF0DcsBZu8PcFp7Mop4/lELXwUfVrz6hr7vONlErSYtJwTWUlxgdxEFCmUTHtdxOrrRss3TbZELoKir8QlrG60fND776zeQ5IxEzjx/1rMdemAzy56GCVhgjNHrEsY2OUIzVgqgqUbOwxxvInlrJnbgf7WHRM8CHvXFnghSKhVcwXpvYo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?18wiUk8nT1ujxY8jwCYHLKCZvBVkD2+p/uw70cTkDWDaOBuRMurtlVvvaHkk?=
 =?us-ascii?Q?SQa7zipp8ciWZ05yacFCpkRXwbILct2LbmMKfN2jAua32FfAdbd4PEUWTTMP?=
 =?us-ascii?Q?rsuodtuuxB83foLLcOc9bxg8o85lO/ufs8rY3eopP41QDft/jrKRg+VkSMhO?=
 =?us-ascii?Q?wVx/Wq1T3dmlnE+sZZoQ1u66M/5i24YJoCfLSOIcVvxnZ3V6yoP8L6C6eLbN?=
 =?us-ascii?Q?t0NEE8sguaoJ24FiGKInrGr9BZSOSl1FaL8F6u8KeqMvO8TnF3Eq00ojFzLL?=
 =?us-ascii?Q?08p1H4kPAnP/4BkL5UnMkCv9CMncje7XBHWQj4ckZvGoOT2H3dcZaMtSL4g6?=
 =?us-ascii?Q?KWTY1n14Rrnp0Usi56z507psEX/7HboZRVoqrIFCipOfajooxWU+5Z0D2p/U?=
 =?us-ascii?Q?01wxeBQOZvXrwTv4eRnFqhju5iIxsTd9yf60DNKPOEQazNRwSC0UvOXPZejO?=
 =?us-ascii?Q?P2PdSX86SgCqhYtEi5pzQGLsXo8Ch3vJ8oKqkHv03kbF/rHFBXFhmV4dAaOw?=
 =?us-ascii?Q?9q3q453WsRhJz4SQ3iiSGWjX1YuXtT4HoT5MsGhox6b2lojLGeJJN8BRZHj1?=
 =?us-ascii?Q?31ykO/VJvUWGbOa6Ipig2dL222G0IyfDerCCDqTDsJR+x5bxU+pW5LeZDFdj?=
 =?us-ascii?Q?C7EomlvOgrykuwB5B/9VMgg1zIX7peVCBakbIdvRSRIVmKGT1auftAaz1YIG?=
 =?us-ascii?Q?a6Vzr8Za8vCwJy6CWlSbUgb8j/fpL/uwsz+TsmAhSg2pf51L2IDcw/XgIYQB?=
 =?us-ascii?Q?CPdQOdsgjr8ML6U/aDro35tfnDRuD7n2z0GBg1qIKkD0nI/EP/oh9KEgc1rw?=
 =?us-ascii?Q?6pKya18/vHQMGDe+hbsvUEbslvzh9NG5rG5Rr7K8+GMAAs+j1Jc1QTgSJhwn?=
 =?us-ascii?Q?Bgaz6bGOJLDymIzWMMpFQUTdU9jgVLfHOo8atI74cq+u5kwcNhZ4qYRaeiss?=
 =?us-ascii?Q?S4mdhQsb1upZ/W2wI13D4Q9K0I3klz85oUu3Q9QaDj0EQkJFdu1i5CsWc/B2?=
 =?us-ascii?Q?3jWh3f1+19F5jU3sf1R11kU9FzDlbsnw65xa0/JCPgiZui++ErWK6eWMj+Oj?=
 =?us-ascii?Q?9XQ1AC92ELeqxN3J4vMHy3aKgDYGrJmzKlVMCs99X/b8dMT60nbF1vbXOizH?=
 =?us-ascii?Q?+kd2k8xeBgqQneycuAC1B327pK9wngiAjkocajfvNrFEjnXKDYDipbnmSgTC?=
 =?us-ascii?Q?XAkKRt2rwRnWfVlXXl6MaO/P2zkOiOgKRPdXbHnk+AQPu3RE7e/+rEOcYSEp?=
 =?us-ascii?Q?fxrVw3xpK+bSDs/OeEe1/HazfV1rur8cgmVx4Ws3WE3Pzd7s1cuGXX1JA/U2?=
 =?us-ascii?Q?OEhXFxbGRUZYeLmHe65Eh75uIeImlROP87+7/OoNxNmjDxa78WqMCDy2WEdZ?=
 =?us-ascii?Q?KJ4t/D+kyIoPvvMtRsO/TY3ws7uDngIAcV22Jg425aB5pwo9hsf8naBjzXpU?=
 =?us-ascii?Q?AWuhJ9Ar96l2kUMLGqcdtrrPWksA7cQI07sBSSuWU2eEEFOS1s+cfUN1bLMv?=
 =?us-ascii?Q?r8RLH9erAlyDuKu0pdXsVLbcr4Hltl+DMFo3teXoNVwIG33VHuOgC60S6WqP?=
 =?us-ascii?Q?chZMF/TlWyL9q0XO8j9Bsz3HXwq4YKDQDs2TzL/AplCWHhhUmXwZ75xk6aqE?=
 =?us-ascii?Q?x+5b0AWZd2OagQ54k8Aoxe4FXhuLEVoAWc34x+aenqqUbPfXrUXlh4Y3lUuM?=
 =?us-ascii?Q?KSa4wU/V/uUUzyK9K47B3VGyg7jdGo97CWuYMEiSppF3OHXpNmAoVRNrM7C3?=
 =?us-ascii?Q?/KearHHIGg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rex9we7zOxZY4/vUhpD/I3P8rKyj8blKt2z4e3FoNUhg1vqGVtx7Bx0f7EvNl5JORWsTrPSSq2b96exUWmh+6+AinBtdQtGggrN7D4rHYFS/EoKJmYAD+N+Fm9hlb4XBRRLFRWZz8Ic3uyaXavO3tSV0j8eBZIEVinDIvg/NJkuUJ8MvjvNpHYr8Sy8tP2bJr4l9cUa6YBajhLso0TLBUlHeNkk1SozaO9iVep3DSeMmE50F5Q3x4ahTIUiARSWPVVUqhylPWwBH8TNDXXwz84/KYME5B1cwBPn/sBWCEVthQCDBUmishZfpHGb2kwlZVaoEAnzx2RuqDc+3nA/F8A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afd2387-ea83-4960-ef25-08de8f01232d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 08:40:18.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zqpHjRPqXKCtcSo8Zg3N0Tx78Sjc7jDk9qi6L8QPazcmoI7u20ELI1lUByvwmDF4QLv00gcCsFp72nk3RB4Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9060
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, March 7, 2026 7:41 AM
>=20
> +
> +	master->ats_always_on =3D true;
> +
> +	ret =3D arm_smmu_alloc_cd_tables(master);
> +	if (ret)
> +		return ret;
> +
> +out_prepare:
> +	pci_prepare_ats(pdev, stu);
> +	return 0;

is there a problem leaving ats_always_on being true while
allocating cd tables fails?
