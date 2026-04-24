Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98723624BB;
	Fri, 24 Apr 2026 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013700; cv=fail; b=AZpHHDoS+GwEc05JFS2y6ULMLZxKqhsp0sLMHgJUSBhsl4+siXsIxrZiaMhaLLUsGUIHzXWcO/U7jf4bjIwYD9u8NSLNA1JCq0ulZovnhMX2rRyXCahOrzlcZ1lNtmgSpRauFYbR6P70sF5Xo++810nBgVujZDENpcqGkRizfs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013700; c=relaxed/simple;
	bh=gPjSkPV558/PSOdusTLbuPSYqBU5TBF0Lp17Y/kqB4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uu6G6Q/KkEgax9nAOGaxAJNc8V5ALJX8dXpiu3LE+5KE4Hm8kNI86zDesfrDa/DpwrdlyVqRR8BubQbUwVriRVy7XiW86splBhNHiql5H7MRH/paGCTQdhioeoxZPBYA9hZ0UZT4HDfsbgaFCuSAT9OpDn933FzghmRAGSxvdL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwsPf23/; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwsPf23/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777013699; x=1808549699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gPjSkPV558/PSOdusTLbuPSYqBU5TBF0Lp17Y/kqB4Y=;
  b=MwsPf23/PXRWbPE1ohdVJKirlQBaZh4zUQenokpfb0BbdHt/TCsa0bJe
   nmCV56p/5L20uTMfCMjP5cR47zxA6zSInMNlHyf6V+i8I6e8IR9REw6k5
   pfCemNk/7o+mihgShvJJA0vEVTW0Ew1nIxT/Mm56jiFIJgkk+DOwEfl67
   HnnnYThYPLPKsZZ8O3JiuAWdSgk1QvxHcNrTtYuujTerUdIu6xNlbiKnt
   XWq27mnr5Gj3ZGeuLmcLaBONLYhx5tPUL/rFm69fxe9BwXdRDnbMshC+I
   yNy2J57Qd3M47/ha6i5mc1QSGwvK3r5F8JDrH/gNsFyuN4iXB3dSVs09A
   g==;
X-CSE-ConnectionGUID: d9+7qTEiRFOzqEdJTItlPA==
X-CSE-MsgGUID: jHvs1S5iQpmflZT5fafT/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89372334"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89372334"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:54:58 -0700
X-CSE-ConnectionGUID: rGqYMQscQMWrZHqVAKEDrw==
X-CSE-MsgGUID: yoXF9zvtSk63pSivlwZ6ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="229681676"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:54:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:54:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 23:54:57 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVrcLMMJnD6BZ4oFsVXqpIN9Wb65EwKmkAJTZ2aSnxNedonMca+7srGwjWErj192d3jAIMK1u7eFkIgntwCTq1zeQq877Qo10GNwWHx9nUpo3fqzV+rzcTyz0t/z21B9iQqNaLxOfLr7yvCdgG7zaX88QtcwIdFg3mUg/qJ4j59oFS4jIVLnMoltbeADqlZSuBTZesrU1do7IUc4T3fGejFmGWJKvyJB1i6VAQ6CWoNhq1zoHD+XPZv5Xqhii+G/LzjfzvVMxpQpKQMHRDFB1Jd3650qckZkCB1ABCVUNXLDNF/KYgD/s4mltG0++vXWdCCri8u4g9yjyCW+T4CPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5ElWv7YQTqerLo8guNHIb3o55s6b2RdHR9P6gWQGgo=;
 b=AC4MiWBEWJ+/5oegFzSn+hDddSshwwlXzryPvUEopdRZq0s884PlaN+H43mvwjGRyaOgYfAxiz4dUXFktZYfbtbz60aHg63nowMrSCZ58dfXmk0MMyl3C/DGlvHdHBy3O6/CYUg6uOTW72ybVLVkNRxC8XSO0BtoUsXbGhnwpznH+Mp/46V5mPEgQU4zwvSH+Qe7mO6dkrAoHF4/r0BSw9JMSc0d5GocBCeUU5bHGMBm0arTB3UMiIoJpMwNXZV60Q7Ibh0Cxmw5SHDZexY4Cp8MAcx/5TfMM5JDcUezVlr5KOx6kib9gUjFj6PT7j+W5q0hcDexyC/HEyB40NkH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 06:54:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 06:54:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 23/31] coco/tdx-host: Setup all trusted IOMMUs on TDX
 Connect init
Thread-Topic: [PATCH v2 23/31] coco/tdx-host: Setup all trusted IOMMUs on TDX
 Connect init
Thread-Index: AQHcvgi+gONkkSAccEKfTKJuTlAsIrXWbxDAgBSJPQCAAvkZUA==
Date: Fri, 24 Apr 2026 06:54:54 +0000
Message-ID: <BN9PR11MB5276916B241153121738EB208C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-24-yilun.xu@linux.intel.com>
 <BN9PR11MB527640A3D76B66DCE5FFA58C8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeiUartvxzsvq2Ye@yilunxu-OptiPlex-7050>
In-Reply-To: <aeiUartvxzsvq2Ye@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8594:EE_
x-ms-office365-filtering-correlation-id: 94df2f27-7540-42b2-4445-08dea1ce6433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: TwRz+XVDO3BVszky/7UFFFsVnzSjqTVMjufbA4s6FDoJGJbUBCMIr4+mOCVvrMCaQJYU5WqjQlWKreE1rcg7cJTRMNw4qgqj/Jvu7mcFwk2OmeaYcND3B6PISWNYL0Yzz/3lG8vW7748kky/G94UD8yJdauopY4JmslM9sppwNlg7Ndh6GB2XbfvKG4ImEAoh7hMqmnSph9aboYnmywlDIoTGVAGUMB4/wB2Qb8dX2Q5Hr8DSBM6EHrkuAXf3b3jJJYgwR/RdHF1nBrxrWqyicx0rs095EDSqlM0F3P1DLZGF1egg1pWfAw5GigMT87og8QpoHpCULLYQnjOoWCpkspmC96naZND0RmECYEesJvvC8db/4Anw5HYjqAjc8MNKDRNbKc/wa2AouVjdO6YRavURqFSlHZuqDHrTnUViQhuy+J60dhfTEZ4GGwn8OCcmx7gtFmW5wcJNjW/qLd8FBYsl+ElCk6WchasejaGwFcinRIf4LjMsZ0JnhuK9GbmqMArWL2LWF4Ve5syroOdFIBxdrnbVz9oj3x+eP8uANmSgm4eh74uMvM/7O90VKDRmOx1E0M5CR9B3vRfiPp3+x0OBJsQaOX0Ox9cwSWiFo4OBGwHO6zxTH3DBtSJrub7WUyNtuBNT6X1Pjb776cuhpUR342fMp750Ku/MxckbMwr/eoAEJ/BRNfHcSPxL7OaH50f4MXmgC4/0EPCgYUb4rAdE2qmYjDPRE5a0qqiiVbDECJnkKfr/Dh2wQ/FdDCvNQnDx6zxb4CNyu7xaxf1a3XtcIZPk3Ff/39nw4FnGEc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+UvM2rva5/jHXtgd3RzY4H9haWkILSkDMqKi0kYTNQCytEZyxwuc9vNOcIYP?=
 =?us-ascii?Q?hJlwDTTAvzzxSGOhPKg+KKk78VMxBx+JU1HzOpSBphrEoetnFQvpasd8djB3?=
 =?us-ascii?Q?KtEWjYz5qFnRZv1FtivHNBZM4z2GB5GknWoFO3emhqlJAj/IZXsfyUgiMsdn?=
 =?us-ascii?Q?Rg2WtpCehCrABuDicrhLY/V0xGfodywyGhS4nUuI/z4sgqtuX5iWXKpEGsr6?=
 =?us-ascii?Q?dTd/YmhM1bttTGi7jDLoHkeLnyBWLRYODyUFnoJOZQUqatvPkAvrpCpb8Nkg?=
 =?us-ascii?Q?UlCZWMpdyhKNyBkOI0Z7M18W31pquL1yJDqbJhUQ+8lyXZ/eEo8i1rDZEait?=
 =?us-ascii?Q?rAfIs5fOgS6Li7U2dUxgNMDWUHieln20b/J8PvVf1HrVc0//FOcypQM9IdcY?=
 =?us-ascii?Q?zMqtS0raaoM80lDjAr6pIJRe9IG1KZOHtuwz7FV+srHyxYDLu3xTTSTOdzlP?=
 =?us-ascii?Q?Lozgysyak4iLfB1ZFkZ4klG25OWz3lkm/smIBmsNmaAAkXXKQ9E49oxDt6yT?=
 =?us-ascii?Q?h/eJlijhThP+ObTxeVNtvJwnxGr9Hy5AuL5EBjY+zRDeRPgD6UcdzYjj/El6?=
 =?us-ascii?Q?cr76Qd0pYxrWnBC3S0jAs7By6TuLdO6vgNCEy0mYfDnI53nQ70cXeIu7sfZu?=
 =?us-ascii?Q?L9edeB/uLjCuDrwotoFDKeO7JhfkNg2HEbVbMn++slU7OkuNHByHdl7bHC9z?=
 =?us-ascii?Q?66vQg3yFQirlsXqQlUhMbuwX3cgbvRl16P6CXB1SAdgwNRlHJ1ST0ofixx+E?=
 =?us-ascii?Q?ZZkxJq+WKu/yt4zd19KmqldSNeO1fTG5nwuhhn8Tjizo/a1j4o12rCkVKCpy?=
 =?us-ascii?Q?W1SpWoKQfo45LWsEltQOLAljCYZp6xBklqa1UtUwC9fAIn2QL9yDDGGslIHo?=
 =?us-ascii?Q?NLI5aq+1rNh6PMYZ0QT9+hseFpXVoTDHc9hfyF9Akln7E9S92fT5tto2o6aR?=
 =?us-ascii?Q?j8LRA2sgBAayA9amTt7TcRRbgV3D/QKDNxFfSidtRcIL6bzh/aWd/kks9Pm7?=
 =?us-ascii?Q?0zDK6dITFpvmf+br7xL4J5FhcfVCn434d0xQNbBa2YDOSAMIJB0kCO2KLYmE?=
 =?us-ascii?Q?rYfmI/MGN4P5nf083v1el8iSlQLbsF7H7ckvsUtefx28EaDDph0ERenAyvyE?=
 =?us-ascii?Q?qBkoxQXlfR5PzMteWh3QCjQb+ym7ZZOKlZOJUs9shP9yyvlN4NQBPs+eP7GM?=
 =?us-ascii?Q?qv7r55tD4Jl1kxnPbCnJU+B5V97p3Zs+bRF6/yn36JDged/RKMO2gI9K+X0w?=
 =?us-ascii?Q?9SukrLhOHiaOhCvsdv1siEO5J4NYzJngE399VnAFPcWJlA3ZzeYMQsPlm8xH?=
 =?us-ascii?Q?gjAVyLqGYfhvCb0PMmBt9H0mKVhb90ruxgVBI9Cr9jd2S6D82cV3kbBAiZ7t?=
 =?us-ascii?Q?EVCaFv5lWPrMCtRTW3AAkhttmezC/lIaC7ydgUtTV029N7AZQ47/HXhCCMf5?=
 =?us-ascii?Q?ap2vS4v1U4yV7KCLWQXJQWlsubz2DP50FtBpOWc+GsjfuCh33R3I6ttWVz1V?=
 =?us-ascii?Q?PuBbp0kPC5U2/W+VRcywZSZx8pNHBxGlj31bZlcEynkqgON/SZo6kVY7joI+?=
 =?us-ascii?Q?fo8PPWZBIrAVV5dczy2tHt1jJ4EIByjWfmNKjL32qA6O17HD9e+/ZguKLIhq?=
 =?us-ascii?Q?YX0TZpKdmnqzvZJf/HJ/0esOMxv4/C6o4FO1ylDO2gGddHjaPHvItiAntsNB?=
 =?us-ascii?Q?tj1sA/UsafY9gTFLXDj7qKVows7csnR9Kktk31VMTLE9MhIy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ciE+MQRttOKWNqwjPKIF9J09nssgh6UyU7mCmWNSvkcl5fSoeeG7tdnfZFpbr0/iLZPAQbn0tHZzJV1iy+pka/AddsgaTWRpVOm/kF5NdXdmkpZ4b3UC+Cyt7zYCHDeFOP1TF/ypfdb2XrdOZXnyJQkWS9Ceg5wwX35WYDgo/+Q3VZRmJIksk970IwhKFoxZhLWo2jvC/bux6Fb1uZcajS44eU2QwNeaVGIqGdwVkA1nbpqE5kVAjflVpCn8QR2YCW5em/3QK8g4yc/bU9T5u8A5es5UVHR96BBJs2tAUw+uHfY+21YzbVYFxvzQNzzH1o5N8YN/NmSfFAFY2fDW0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94df2f27-7540-42b2-4445-08dea1ce6433
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 06:54:54.9427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXcYemiHEV65Pp4WR5NYLEfJcwO+/usUePluY3ld/38q4hNOfPmURfLuIBhQ+epHmFS6k/uwtHuwurailiP6Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, April 22, 2026 5:27 PM
>=20
> On Thu, Apr 09, 2026 at 07:51:56AM +0000, Tian, Kevin wrote:
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Saturday, March 28, 2026 12:01 AM
> > >
> > > Setup all trusted IOMMUs on TDX Connect initialization and clear all =
on
> > > TDX Connect removal.
> > >
> > > Trusted IOMMU setup is the pre-condition for all following TDX Connec=
t
> > > operations such as SPDM/IDE setup. It is more of a platform
> > > configuration than a standalone IOMMU configuration, so put the
> > > implementation in tdx-host driver.
> > >
> >
> > not sure what above tries to tell. why is it a platform configuration
> > when you have seamcalls on each IOMMU?
>=20
> This is to say the TDH.IOMMU.SETUP relates to PCIe SPDM/IDE, it is not
> just about IOMMU. By identifying the
>=20
>   for_each_iommu(iommu)
> 	tdh.iommu.setup(iommu)
>=20
> as a platform configuration, it justifies why we trigger this
> configuration at tdx-host driver probe, rather than in some
> IOMMU/IOMMUFD API.

iommu drivers also involve PCI, e.g. call pci_enable_ats(), etc.

so having relation to PCIe SPDM/IDE is not an argument of
platform vs. IOMMU.

Actually I'm OK to put that logic in tdx-host. Just the explanation
here doesn't make much sense...

