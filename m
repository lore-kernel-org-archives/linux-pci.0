Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4B2741C9;
	Thu, 19 Mar 2026 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889269; cv=fail; b=DK9wBbYRtLVRQzvH9fMcFzqjuCyOMfDjgT8RBgYgpl0k0p6sbWCUfAwo+Cy/0mxAxobL/wyNCrjvF1TwBZ/lXaUl8r4GUdZQWyk3LQc1dzNOFaL4R6xXQ0/13NkriXkL1QcCvUmczhX+Yg5IChUAJFaeZejjU/sUjbOTnfuj7BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889269; c=relaxed/simple;
	bh=uA1MkwLw/ZvpBtGVluQovkyuMbojJ+68wsHyuALzqRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mrT6dOgeJMi3QMjIjaPdpeYxq0j3+2ljSjTlEM3qWm3LiVrMv87Z1PzGj5n2B+KGgNZHca0+0qmlA0LCb8DEIwTUYyraUh2cIEbTppzIEoViHg+CFZ6mx2L8Qe6hubb9S1V3Q7zlvmx8td4gNrCYrRDUikO55XqL2KTleWgNdc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix8/tEe3; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix8/tEe3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773889266; x=1805425266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uA1MkwLw/ZvpBtGVluQovkyuMbojJ+68wsHyuALzqRU=;
  b=Ix8/tEe3yqldxOk5P+WpfqYx9He+tsxI3ffXQjICXPS6LqBnSMdWVJb+
   Vtmivcd0oGE7LFq3Zt7EZqKrMxzjxlVGhyc77F5osCQ/HEJ+XnfBV6B/7
   eW1mXCZcECpDoK2mZWGiCj2Bfa6Xr3ONhI5xBfo+Io1voeadA7yK4YOpX
   Sapt4vXdMY9LwDKwzZIoV4iCWKfbpcKdCG+9ku9qKeAymnD0NBA+QZ8J0
   Qd0xQHhPrGDuQ600+p0y/gDfFcMrv3QShqdX4SgsTOmGRLXpfLHLUmBqz
   btFEsRDJXjU78M20rfNA8OsnZJhRhI9cvRG2I1QEnv9FfwgB9ZKlPAtSQ
   w==;
X-CSE-ConnectionGUID: 91PukWusTwy8Bri9lQx3QQ==
X-CSE-MsgGUID: YXH8ljD/Tm2y3a6IBA/knw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85275625"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="85275625"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 20:01:05 -0700
X-CSE-ConnectionGUID: 6bfDACHgQFuxeTMqDM0mHg==
X-CSE-MsgGUID: FZTAYe1fSZqfHbTJuNJ8qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222872224"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 20:01:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 20:01:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 20:01:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 20:01:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og+rpftkzz5yMhLXa9XC6XMBjXxZsNeI4OVBNuKp7yEii3dNNSJ0kmtZ/1RCgEpJOEqWFDZEscQlJPtFdMD6ZXGW0c6qEkMZYPtU9/iHfvACfFKji2zGqf50kW4m57HY6PqdlL5Wl+CUbRUKBvKi5pEuB/Xg6Ilt++laRmyhiCAHY+75NcN+DW2M7tFgKJ2SnNirBi3Xy3tTCCo3PC/Q94OWpaa5t1rKRgKsuXJq1j6JVFOIuSPlG8ngpkoONEf70KQAp44Zqdi3Lq2SQisfvTOyzh+HSthEFhF06rKtKfKVZGqD9d52Ei9kmBktf23AGkfrecJmCWW2gyTTcR+nbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keiFFnV++fbqQnBwQmVSMiP2yFWsTltn4cY20bi9DmE=;
 b=l4exesOsM8OXuTqyfEnzmcdJ4D9yHrn9yJuyMluMGAw+18Ffv/iJWIwb91xKqtel59Z59d8qSuzse4puN8i2qulA+7r2tdpmAxSJH+iDkod/50+GAlO6RPcB1pujB//RMWlLkP0bcH9oIsHdCyM1wvR0SruMaRY5/W9DYOfyanBqIIKbyfbwQoL1La7nIN0ZnSnI7UXMaEoBYJXLxiuC3pQf2sXM9/giMMoOAyo/lHguejl6GOeJgTN07c7BPt00PQs4BlrPlL1IvJvgU4J1n/Tlkz3wv5VBsCoTX/I5TVqL4pHayzsdYd2LrIwwuL7xBh5zQBoMMqtCP9nOeAAiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 03:00:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 03:00:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "joerg.roedel@amd.com"
	<joerg.roedel@amd.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc] PCI: Fix nested pci_dev_reset_iommu_prepare/done()
Thread-Topic: [PATCH rc] PCI: Fix nested pci_dev_reset_iommu_prepare/done()
Thread-Index: AQHctyLLyEh9aH29q0aVa9nUVwPgKrW1G2tQgAAKbwCAAASzIA==
Date: Thu, 19 Mar 2026 03:00:58 +0000
Message-ID: <BN9PR11MB527654AC35FD1EE8CDF7E1828C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260318220028.1146905-1-nicolinc@nvidia.com>
 <BN9PR11MB527657D79BF5B16943BCEC258C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abtipPYeAEpg+vbI@Asurada-Nvidia>
In-Reply-To: <abtipPYeAEpg+vbI@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6909:EE_
x-ms-office365-filtering-correlation-id: e44c9ac9-b58a-40df-6aad-08de8563bf0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|83080400003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: gCSsZeg8zJh2+XzJ0wk9SZTBgSC8TF1Q6atFUiqhvd1Newt2lhTu5xtrtYEjjgizbqAzDkS2XpB/6gkVFMwFCgVpySpo4fBeoSZoEFBqLN2W2uQYASfrhtmuWZ1fepxSos5oQjFTYV+er3/qH8plW2Q4JkATrbMtv6aVJHt0oU+D+ebdk9bs8+6LTtTfWZVJvdH7tcZ2yBD1cTb9rFpwObDaFWHskHwbMqPvC7F1ufdRSu8xIydDnChjTAuv8tFUWLdFhAxK4Y2C32D6suM4hAgcjWyxB+wWIthQ2+tPKQfmZEc9xpy1WE6sk/xeLMtYDuCDGPCNxVlbKUBQmSCKmxpqUWgaeXnZ3YaAxnz6GwdYJbbkkBiTTlX9GX07FhvS8ynZk6/y4MRojGuVrQQAKHkdyU3zrXjH1TblArbVW8xN68UnoCIcMRhDvWO6knj8/PE8L42chuQhUYZo55HdFIPJYQZZgPr4G1el22GWy+HOo+sKuNaLFS0+4YmN6sX2X3xX7PA4uXpBdi7HPu9Xu/j2bx8vLSRFuYAl/sYEkbPutPMs+JPHpg1zCUTlvnZ0kZr2Vin2E+/TTZ54pvuipTSYL/6Z6SVIA04Hgn4ZxCRfVRymClz5ip/EqGbCoRMwQSCatznKa35jVwwH/s+LkmQ9OOYAdflWFQxPKxAWPw8zHyQ6ZSdy5H40PTc+ZuoY1rBO79ZDDWgYb/5b6NO8GuzFfldawqSqcGUwVo7CcqNUtcmHqn3mxXdNINlB3sDOJp6iX2hWe9ymETXuW5gUfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(83080400003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?96OY9IEF9EyEitQ92FpWBZAbQZLbW2DVpcsCrLtRVF0hkst+Hs5Vqlzm7j2n?=
 =?us-ascii?Q?KZ/5dz6tgFJgUWVui/qr0bgdEaVZruvEz35ngTxFgd9GpeD4FCV25adkcyQV?=
 =?us-ascii?Q?rAra3IkkwJt57DGpx3e6qvC+FplJyuENdLGosxesiWkbMWvjtRgC45FgG3TM?=
 =?us-ascii?Q?+QBdrlVHIPKchETo/69PpyW4lZohJQsDsEJuLZo3ljAlsMFbamHjrEx4J5u/?=
 =?us-ascii?Q?SR3QtVptrnqaU7fBxF1o6WWBVO+MKt9Y61bOUYsriH9pGk1xCY6FBE51aTwZ?=
 =?us-ascii?Q?aHgYOyIYc9foTtGR7PYiz+ITK37QwIUbWwm2k2HNNOqGDY9uR7MxAYFtpF5t?=
 =?us-ascii?Q?5rPnIV/UuYYIeYQS5YZieBV3pVDFRsBjID6yucyYgsqe3TWewwiaq9MPzAT9?=
 =?us-ascii?Q?Iss6wZ1U0HhERUQHAobLCxNeR+AroAz5mbBepfaZAAwBTilWN3SbskcVha/B?=
 =?us-ascii?Q?f9ZcmkUSQqmD99urhDQ7J4yIWFnvzR98CLD+d+A20GUP+ZjhqNVGp+Bqwttf?=
 =?us-ascii?Q?WFl8pnjgcBIEzIc/IQXX5l3AoWhSqQdfJG5gJZAOP3ngXs3NZgWY/BFx6iDd?=
 =?us-ascii?Q?pZmar/BxzWX3Q6mokSwPyFIFxOxZAdotJKFn8+G4h/iG8zL9zyih9U2HmMLc?=
 =?us-ascii?Q?Mxq5AhkYlia/T1i/IG9JOFjWd1lG7Q0KeiqADjnWKoHxDa7Quh6lcXeQ/dd5?=
 =?us-ascii?Q?h7U16xc5EOqqXBCn+dmdtVPq+benitaveV6TMgdIbdbPdAnsuAxohZuFBB2H?=
 =?us-ascii?Q?+1ehGABQxHlfqyB8+TUJ4aMTFSIo0hUVgt83kGMLcXZLTW/rHG73irY8vLoW?=
 =?us-ascii?Q?TACBA0xup7FpS0O8/ju5IaXdA/dmDABFnajn6pdbVSQiaZ0tGbgkSwkiKUjJ?=
 =?us-ascii?Q?eS/WP9lcWQmrfq+qjaGZAuRlUXkQxaR9K3sbH5lAwtnJb1VhyeASSm9BGYvh?=
 =?us-ascii?Q?RAeDXl02NNWz6hSHaMOTW1XL7odQI1EmfuPjBIRcOrnaU2nVWDS++jSgv0Vd?=
 =?us-ascii?Q?2qY3MxQN/uxDDZLaqFdT3UeLFBpJhaLKt+a7fAZGjz9GFZ+pMygHApz2lG19?=
 =?us-ascii?Q?rQu7vSnDU0FoazVhD7KZ1msRkRo7+Nx8htmKrUAN/6IWxXgklLE4NlQslUA2?=
 =?us-ascii?Q?EoeLcF6UXdPCn8BICMAagvYJOsBLRla4M+DOynkdsDtEgTNQBQhPF1Voa3Nr?=
 =?us-ascii?Q?JqkehCdAan+DVSCNtTRHdNsWHbRTA45F7TAwK9KQWcS1z+SIAxBzWrcOf3ym?=
 =?us-ascii?Q?V3mCDy0vwAWYjXMLTWuQXWagTow2BAHOIj90bn1xcB1wIMGpT2Fii0deq+BX?=
 =?us-ascii?Q?r0v8pgWRm62HsiNMri2M434NkskQI/RjFkhE0pIclE3rroM9LCzuJN8TzisH?=
 =?us-ascii?Q?EujJ8S43V/DJUWWlI8NBXS++zePsGRrzxClAxNRuNhj0WH+HLEAj/Rpqh+jF?=
 =?us-ascii?Q?vbD8Odccu5d07mc4ei1QpHjRMS9onME1Iy9Fd5z/mSHfRL+/yCBycexTwr1o?=
 =?us-ascii?Q?D2wO9weWHvhZPEhPi2sFHzD+RNDrksmChtqFUt7MKRSObAsJZ5gh7UNo+dyX?=
 =?us-ascii?Q?I8D/qw02Lm3n29CaAAHKwGrXH0slMxc2Lxm0hZZG50lYm0y915wSNRrK8ja2?=
 =?us-ascii?Q?mtmKHOqqVHeap+DRgwVxGiWf1f+TZx1EymdE+eZgQgNVrAUrw+IOg8H/8Wk1?=
 =?us-ascii?Q?CSwUPpPaL+Xt5GFwh9/VvkqCZmpxI5AWSPwerWo9jPyB1IDn1+8pu7QrxLdB?=
 =?us-ascii?Q?TwE7phHRBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O6llc2wT7tvacvcwXTMQKYiw8MRA2fjY0EF5ewuhw5lS8l42C02dbtmYu2TLoQcXn/kdGF6XPJJrqQN4BQelfhToJ+a/S4yAQ0YXUp19R6hgVihVsD/9MJjBUbPnikaKpPXaOZovcsyYtYFT1hKryKwzPSAab9n9DrEvl/CahqgzQ3cMU/eLuZ86038QnucyyBt+ua0+XQvymeHAIYazVXiqclJ4XSazlY2Y84jcyYVN1I9tbE6aPuDbI4plGk2OpOppGMhwh3kGJgnfq3yrFhycB9u+b0IhZClIXSGK5DssKeveDZRgXPbphUtFL/UJeNPImhKdTD2pNk7f1NI1eQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44c9ac9-b58a-40df-6aad-08de8563bf0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 03:00:58.6804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LqhP1PGZXTL7k9A5XzEiNpMWGa8el0rG4Hheq8Y8ggRUHUSIzsXRj5oaVPNzt0RlAC03SrPwt/Mi7o4fHP7UAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6909
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, March 19, 2026 10:43 AM
>=20
> On Thu, Mar 19, 2026 at 02:22:39AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Thursday, March 19, 2026 6:00 AM
> > >
> > > Shuai found that cxl_reset_bus_function() calls pci_reset_bus_functio=
n()
> > > internally while both are calling pci_dev_reset_iommu_prepare/done().
> > >
> > > This results in a nested pci_dev_reset_iommu_prepare/done() call:
> > >     cxl_reset_bus_function():
> > >         pci_dev_reset_iommu_prepare(); // outer
> > >         pci_reset_bus_function():
> > >             pci_dev_reset_iommu_prepare(); // inner (re-entry)
> > >             ...
> > >             pci_dev_reset_iommu_done(); // inner
> > >         pci_dev_reset_iommu_done(); // outer
> > >
> > > However, pci_dev_reset_iommu_prepare() doesn't allow a re-entry for
> now.
> > >
> > > Digging further, I found that most functions in pci_dev_specific_rese=
t()
> > > except reset_ivb_igd() are calling pcie_flr() that has nested those t=
wo
> > > functions as well.
> > >
> > > Drop the outer callbacks in:
> > >  - cxl_reset_bus_function()
> > >  - pci_dev_specific_reset()
> > >
> > > Replace with adding the callbacks in:
> > >  + reset_ivb_igd()
> > >
> >
> > I wonder whether it's cleaner to just make pci_dev_reset_iommu_prepare(=
)
> > reentrant here.
> >
> > what this patch does requires additional attention on specific reset
> functions.
> >
> > e.g. reset_hinic_vf_dev() has a special logic waiting for firmware rese=
t
> > done after calling pcie_flr(). With this patch the _done() notification=
 will
> > be triggered earlier than expectation.
>=20
> !
>=20
> > the original way is more maintainable with prepare/done equipped in
> > the highest level reset helpers in pci_reset_fn_methods[].
>=20
> Yes. I agree. I will add a reset_cnt and allow re-entry.
>=20
> > btw the AI review tool gave a comment:
> >
> > https://sashiko.dev/#/patchset/20260318220028.1146905-1-
> nicolinc%40nvidia.com
>=20
> My browsers on both Linux and Windows blocked this site :-/
>=20
> > it won't hold if my proposal is agreed. But it still applies to your qu=
arantine
> > series which relies on accurate report of success reset.
>=20
> Would you mind posting it here, if it's not too long?
>=20

Here it is:
--
By removing __pci_dev_specific_reset(), the IOMMU preparation error checkin=
g
is now delegated to the individual device-specific reset handlers. Will thi=
s
cause IOMMU preparation failures to be silently ignored?
Looking at handlers like reset_intel_82599_sfp_virtfn(), the return value o=
f
pcie_flr() is not checked:
static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, bool probe)
{
	if (!probe)
		pcie_flr(dev);
	return 0;
}
Similarly, delay_250ms_after_flr() ignores the return value when actually
performing the reset:
static int delay_250ms_after_flr(struct pci_dev *dev, bool probe)
{
	if (probe)
		return pcie_reset_flr(dev, PCI_RESET_PROBE);
	pcie_reset_flr(dev, PCI_RESET_DO_RESET);
	msleep(250);
	return 0;
}
If pci_dev_reset_iommu_prepare() fails inside pcie_flr(), the function abor=
ts
the FLR and returns an error. However, since the quirk handlers swallow thi=
s
error, the PCI subsystem is falsely told that the device reset succeeded.=20
Could this falsely reported success leave sensitive device state uncleared
between host and guest environments? Can we ensure the return value from th=
e
inner reset functions is properly propagated to prevent this?
