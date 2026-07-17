Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0803DEADC;
	Fri, 17 Jul 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275442; cv=fail; b=cU7kLxhJY0RPlgY/0JAeFsP1menFgHcNZXJcW8ZlvCdJ19Zy3JzCh0jpEW2X5kOj9OusWmsaKIqPHS+0Oz3n/29Eo2/svtJA726B4NgW5qp4t+bJd/FHOBm7eXZJFCOOX5vw1w9+NfeyuZ+vaTdz8ke50tqKjSIgCPBgIAGBy3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275442; c=relaxed/simple;
	bh=ME0CAYOqvEXYHnM+0dgRSewJjDicpg9ED+Khfhmv9Ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rGnSdqnn8pfi47KgFvk97TQwQ5loksT73R8XDciQttBo/cnfGdLY2UtlTT6xut0uwsFxL//ZKGMJDV+WhkPfYNhXG8HSOzCuSf+HFIaOVbcHpUf4mT5rT+jo/rY6F5kaUMXKQCG3zrazFIB8PHTiykWOcVwsG+Dr2olS5/sIOso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAoBLfKC; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAoBLfKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275441; x=1815811441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ME0CAYOqvEXYHnM+0dgRSewJjDicpg9ED+Khfhmv9Ho=;
  b=EAoBLfKCDqOjlIX1TSrsRBjnv3/b2CDdnJ7ooALj/s6sjIEjkEVQInRM
   qg6QMwLxzc/GIAd8U0cUtdpu7U2Y8hL1mcDq3NLoRBQR5VZad7kAWNcju
   w+IVHKqd/39cFy4eftCIdjbn/AkbXy5ljHtYi7sIGqImA1eu5KBSOo7Xo
   TA322SXB8T0LfN7nfqQNhlO+urUt9cdsJzPUZjSiu94qWPibEiKOmIsWr
   q8akd5+Kyc25gLVUtvfk4h84glUfmtYOGlQGc+Oz9wQdslIuZcgZBk1e6
   mU3fUzFFNLTu7TS3zuzqDISY4/Qo2p9JBwJiFmAH7FBueTmY8raedL6jK
   A==;
X-CSE-ConnectionGUID: 0MFQ7WW4Tzy5LkDVa6vTBQ==
X-CSE-MsgGUID: AsML7ba6Tuu9KUTTqcMXpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="110494758"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="110494758"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:04:00 -0700
X-CSE-ConnectionGUID: KtjyyWz3TfGz79yuB4Fr4w==
X-CSE-MsgGUID: j6hldSiaSj6strRp+9rYbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="260543513"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:04:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:03:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:03:59 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwg34s25wURjb8NxTYv6P6twSy+Q+KLOrZtfa941W12tFc2uryvkwHemVtIOOs6ru586Aepq1EcT8V3kakKFnzsMv5iS5E8HW8ubvWZmhiOQGxCNQ+u1pwMPhAcbn229oCMqOWicTlIoaA+zE1CoB/zx/k3nUdsbvlPaE2lj7q0/wa/UNLfdAtHJOlOufs4pNiIHeIqGh53W/+S11dO1cxjfERDtWseaqmDS69KYANaTxxR3Hq14QhArHLai1dBYqiqaFGoajxCkVd11W8Fq7CCac29K5ax7H+7yun2JmySCPSbsQ2Hut/LljqeZg7PJ/7KTlkPK3iq6L/NAnd1ZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UZ96yd0fa52TfxwD8LEOcQZqlCZibA8a4PlFEAoXj4=;
 b=xbRSBqg/V9M1DpC1rNBQ4YUeMdYk/t0ozHkr5H14KTEPidv3TbgenhztDvfOajv82arRRj1vTjRjfv5iG0qXhfhTkJ80gRrwrMEd1kUbfz1cOF2yTCreJePnaNhWSPSDmtskKt+fEPRFDyqPi+l0IYQBd9n/OInS/Q90s49nJW+WtcrOiF+DUH6lqOM0bD2aVkgyzvV1sIyG+geDyhl2Y5I02Iv0yJPGkwLH5jOnWoU2qxoJtMxUs+76oCzIMorKRkWRwxSn2TEWCqD5x5z81QxfeQ2kckyo3fctjCwFO0VIi4AZZdjI3nDBdUfiY+rMqNtxdsWOMu8XBYccsasjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:03:57 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:03:56 +0000
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
Subject: RE: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on request
Thread-Topic: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on request
Thread-Index: AQHdFII1dp0ZUEYvfESPfxWrjTOS/LZxXI9w
Date: Fri, 17 Jul 2026 08:03:56 +0000
Message-ID: <SA2PR11MB484467256B90A1500F0FC1D18CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-10-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-10-matt@ozlabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|SJ1PR11MB6108:EE_
x-ms-office365-filtering-correlation-id: d05933b6-292d-473a-b326-08dee3d9f39c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: g5UrOiAu3pU8GssiHUl9cPIiiPbiAi5jho1iMe2oOKzh0VlkaNwTnqZtbtEQ17F0AsLdSqoZWFIoSH8KRl5UD2Cr3qX52a9hEEC4GBGz3V96Eu5pzm12tqpz9SuznAbUWJadl1Bw77qAlFW/ItRe/Oue//lHSLerKlIfnWuL1+CLgz8K2V40Xy/kHP7lJfX+bKn8KfmYp8sznxmx7KB72csIMGH5LcJzuRp55t9AtAeUe372Ge6h5yLum6oFQZbkHveHaJ6Nx/2UOnhMNOiFiA7MY2pcrUKuCtREyWYrbq1xLWbu2fjc/Gv1FSzyRR6neBBv5VNGEL6Z/YM479MWHrQjHh2Ai/KeJwY+syFoTWPceQVj6f+AFr1081/1gFYBI0aQvDAGvud3+0ngjPFnZoURGNVOIHfLM2hjP0X6UwAee+4t/iMcxv6SPyZWOTJPykgazLPDrrrurFDx/VVUC0KTFaXxH4Iybem0oIeMrV0BHXfLEDPraJKu6g6rt+jkoqq3mAZn6AW8yWxbhFHJu7iHhcEw0xoW7D323QDesRy1GaD5rQfyyLVc1HoXEMXFcBWcv/pOjLMfqwq2G1sJNaatUDK2xMHu6Hwl3GSvEXCK9Yg1kkf14KKc+/4xk1rN1S/o8EojC1KFRSszI4y8sgJZxeVAcGB0SLr5EwoaMSPzKQXikf4AMsnO8wkauSX1y0g5EdqNxX61urTHWvmSP0SRREeXdFmMnF1oZCSGrUDxRrinGyveT/l0fFtvZj1e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u+ARB4/bbYoO3Oey64Ev1S4m3nFbbu8orHcSQlIZ6rnfzX2i/wZitBIM4Z?=
 =?iso-8859-1?Q?r1Xe/+OqEu955Ds+VVy+wmqZoovhHbO87DzLA3p7uyYWmP+unKR1kXhD+Q?=
 =?iso-8859-1?Q?VyNCpbayI26Uyc4Pwty3fNlpPdwkDjJ9V6Ff63Hu+qGudafn8w5Wuzsx1a?=
 =?iso-8859-1?Q?UOtHmYgbXv9HpwHIz56tlzOBsrrEyrcPPtrwaAA6QlJBxZ09Pg9u2DN+Fc?=
 =?iso-8859-1?Q?S02cbPSdlk7e+xX9eQe+0b0wNPM90PXAGzjJ+0xAvhKrYr62hw9PR44LFs?=
 =?iso-8859-1?Q?+EjtnPx/A5HmWUQTqsVIlK0XbviujX8gQYdtMjM7WnSkSMCdaXW1c0Ox5A?=
 =?iso-8859-1?Q?2+QVrZL3p5I0sNdykuX0V0iDwoxc3OosdpckFrxsKstCiUR1aNaa1gmY4n?=
 =?iso-8859-1?Q?8NOOUXOWnFN9a01ZtUS9sXZqs43TGI50g8Z6pJED2kOyb0Wd7vaJXWN6S0?=
 =?iso-8859-1?Q?a4VhfFXXspsnchRdUglVHaseYWPA2zteJZidOpgitMvWzDNrBVA2K/kGgu?=
 =?iso-8859-1?Q?aMJf5F+/XEVKh9WQ0oghGqpBLSpDW2El1t87Z7kAXVLvUbCs71vVRA5ejP?=
 =?iso-8859-1?Q?NebJPnhenMyXle/G7izCDqOZUmw6DtJuWuZX/Z7NYdOXyJdl6VicZXAPUf?=
 =?iso-8859-1?Q?6X3YdkySamcH8JYC1DwVJ6rNLU+7TztXpiFwWihfJhF2uQRKb6ss4N5Lec?=
 =?iso-8859-1?Q?dFl5WkQI3KXyR2zGzHuoanHwM86DU32+st/QC+TXVkkRlQ4lLza8hiwOBM?=
 =?iso-8859-1?Q?fDWJHnumIzirxpsfK4/zhr8FwKpzGRIxLs7o0wA8dQufWOBghZZuzZ5KJG?=
 =?iso-8859-1?Q?+spC0h1aqsqNr1J9Jgcl2pOQMbek+1gyxG5Jw9zIIdGMNjhJ+YhPj+d/XI?=
 =?iso-8859-1?Q?H1Tqn7xGQMA4tu8SFolO97w2wufYmve0hNHMp62dW+ewTNRMNDE3CR0gDC?=
 =?iso-8859-1?Q?GBHgoGFRYxD3UFnijUSka9GOZL34o9+iNuD8uzKYRsVSyepY6vN9/aDdwM?=
 =?iso-8859-1?Q?BTT/5jpb2WqC/9bCaFf8rr/UKb5AAf0FRmSpDxhIs0RBiHS7HyT+EZ5YST?=
 =?iso-8859-1?Q?ODEoxjD0SRAMcGvC9DxD+k75+L6b1uvJuA5dWaNksA6yjVTurUjLf9gV9f?=
 =?iso-8859-1?Q?eyvEbxMdczEeORWNWwH1vf1hYf07eYwzE8Yh1PQQkE7tQLdPqahjQXaT5j?=
 =?iso-8859-1?Q?53oFUEUflYX54I9q+jdMQfJHfKEmZYEOGZM5UYDaqq4OYD+lwO6KqRtagU?=
 =?iso-8859-1?Q?UOlWOKZ265CxHcpL3K1tq2k5Xw5eZ627zodj5gndaAJdNx0U8M85jWPVOM?=
 =?iso-8859-1?Q?uauf/5QM7qkzMe/0B4s678P2ifgHy2PwCLfenC17pUuaz45QWzlE0dCFV1?=
 =?iso-8859-1?Q?mxS31LzMrI+8mMV/cQ4oUBuW+il3Nrhiq0eDA9NwF1UgaAfa6YR7BmgFa4?=
 =?iso-8859-1?Q?srIge613lmsPVbpAlPra2hw7p6Rf13KVFMssznfUTVV7mHBrTv2Dvf+/yF?=
 =?iso-8859-1?Q?kJvzAqyoCfHc/3W0keNaOwvDwWBbnLqi5+9ggmHqu6mu8RiJAikp/g0dwb?=
 =?iso-8859-1?Q?JLv6hY6MpxSLoYMioD+oQt75id1BS78aChAOzpYxVlO3GrVuB5ZgPXCCpq?=
 =?iso-8859-1?Q?e6GXdjpX80NQtxzJAS+31TGkv5F05/iw6YPTB8vpPFtL5347Y7GjaLjPKp?=
 =?iso-8859-1?Q?C5anpbJ/0bsng1hCqVH36MYfc4WmJLz0+l27pbitlbr9PKqQBuPnJaNR9B?=
 =?iso-8859-1?Q?kkkc4bydHqIIMnry3NHzJjtRiFVH8fzHsQnkgXRWntIUMg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ha02s+5XGkCavwLuyP47ZsndoLOVVXIAFrjI/uPtVx5sBh9pm7jhgfIEkwcsEZ9tJRd+x6NyGq2eZEMDuh3sjGYAtk0XPUpaNLI2RvJlXawkH4vh178w6BpezAwfkciJCtSpz9DXjL+geG0gCQl3Pvz6iqXwyf42UDEKncfpsRNRXkJVmKCBaNxmLcm2D49AXum2ww9jCHDfzetWRwf5XYP4ofFflRgOa7XXzvq7+s7aMuQIqWuX0kIMbHkzWw+BjxXbkE1c7qMhRIsVTNtbWReAN+1WUdQGuancUNCbHrP/m9ffl9lvUGo/Q9fCRa9Ip/H0fGb73opD3ITzKo0M4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05933b6-292d-473a-b326-08dee3d9f39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:03:56.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9yqODtgVGQyDmJeDhgcyAd5V7qRah84ErEl5iOALOV1okH0JHYw/QzlkmOFwkEbdS+NCEnfjCjGfxCLbR3VfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6108
X-OriginatorOrg: intel.com

> From: Matt Evans <matt@ozlabs.org>
> Sent: Thursday, July 16, 2026 1:48 AM
>=20
> Expand the VFIO DMABUF revocation state to three states:
> Not revoked, temporarily revoked, and permanently revoked.
>=20
> The first two are for existing transient revocation, e.g. across a
> function reset, and the DMABUF is put into the last in response to a
> new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE.
>=20
> VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE passes a DMABUF by fd and
> requests
> that the DMABUF is permanently revoked.  On success, it's guaranteed
> that the buffer can never be imported/attached/mmap()ed in future,
> that dynamic imports have been cleanly detached, and that all mappings
> have been made inaccessible/PTEs zapped.
>=20
> This is useful for lifecycle management, to reclaim VFIO PCI BAR
> ranges previously delegated to a subordinate client process: by
> revoking, the driver process can ensure that the loaned resources are
> made inaccessible when the client is deemed "done".  The original
> DMABUF is defunct, and BAR resources can then be safely re-exported
> for use by new clients.
>=20
> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
> function common to move and the new feature request path.  Note: this
> now only calls dma_buf_invalidate_mappings()/dma_resv_wait_timeout()
> on the revoke path, whereas vfio_pci_dma_buf_move() originally called
> them for both revoke and (unnecessarily) un-revoke.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
