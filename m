Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432BB3DD847;
	Fri, 17 Jul 2026 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275416; cv=fail; b=QrzAzGAsLNtxtA6h+FaV/HindP3G1po+khNUlxornBcoDN1fpv0iQdUmsfrNZdDPaUgZBkKLaOFh7//rKGbaVB5bSZ56LcTYUVYeYIicOf0z+UUfr1mjgWuZnPsCSLTaynvRSKWwjdbQGwBnsXiqflCQAuE/TrqSiEkebmz+zIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275416; c=relaxed/simple;
	bh=4lG+5zxXgurJBjtrJtUVYijv463pP34165cuD0jUi8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VUe8UZIXRAAzB3SwTgAkAyHC6w2oVONUJtNAesgiAMyFtohtU24Ie1t02SGiSIcDvEoz/U2nTKShH7hcNhl79U/JZ1+gaaDVQScfsTeAOEKO7sLjq0d18TzQHhCiiFZenfcVOdC5/tRRBIYqn13i1rxmi3G8tEOGXz+PWlTwNzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdAtxjT6; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdAtxjT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275415; x=1815811415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4lG+5zxXgurJBjtrJtUVYijv463pP34165cuD0jUi8A=;
  b=CdAtxjT6mhUlgGbgbRUu20gsAYaKtcO6B60bVVx+CyhhKTEfcqK/e1KS
   Drb93Zbdw4I3/EYij5lHQdqHBjosjjRxNDuPrCIfKmwCqHSeQQt0nJlhZ
   8QQMnPJaM7MOk3xWqSueUDvgNTNWjmHGWv9lfygyFTwnLkn+YpsvEu6YU
   uoJjGAvQ+tw4c91tIutKJkJPcKIkWjG3mVkl812eEr7S+Otk6H4JWaPxD
   /gcf3yklh8Xj5agt9/OqFVM7qELgYZLCjDCjR/fXHPu+PLhp0atPiqYM8
   ktognlUUUWafiddr5/urANpJ9TsbM5cLiDhz1V0sfCKRu5h2DVHmGXOVo
   A==;
X-CSE-ConnectionGUID: TNyyv60dQWW1KG0kzk48mQ==
X-CSE-MsgGUID: Y44bTe0GS6CCxKUTLJCK3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="110494656"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="110494656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:03:34 -0700
X-CSE-ConnectionGUID: 0Jb7jkUASdmsmXhpmlj3mA==
X-CSE-MsgGUID: RFtONpeYRSOABHK6IbQKkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="260543467"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:03:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:03:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:03:34 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHYwwUKL9+e9EB0iJP7Nw/OZ9ROfPXlRo+KoKLj6zVCEHFRY2owgGCovVXC/j/cChxPNvzaSgkFMPBmgWFWPqBurh8c6L4KuuQqnjyIjWVQXCppberX3B+vqRUBfghbyyHweFyJR0WzbLy56cY9VoGCTLvobZjWlAvtrPxnT8bwnDyryKG37zNdaM42+scm0/EMSfWuDZFztZIkR6s2b0Lj1v5clzQM9xiubbkdMrePokFL40E9l/4iIv87g+iu59KlIFrg7YY3Y9I5kL6dlIDngGgVr6uJZAu0UHWLDqXv+SpwNNpuSMFJVmlNe6QPNzfYwEaw9MndVc1Dw46q+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHQK2ASJsd+DXLoOhr9bE/+P78Yw9xysYer9vIWLYh4=;
 b=L5KPS1bsyy/1U8SJs6coIlgQxp5YOZXzq5coE2JgOIz6oweBIxCr0bL9LbrELqGiC7Pm9psPL2ylVYsCnmaCzo+XAnnyIP+9mE+X5DBezlsrHPh0eF8pul5uxVtKMJIfV6KEI4tlzod/uLx/dyceGSwOJyayxGGUjGYG+D77yAKYQTt09dx62Bs5/jTBK6n0AEDfuVV9XoTaMBnXrsvRLVhLBFx7DngNKX6Ts1PHjDKLapHVk5KlO3dVcME7swJXh8BSQsgyfrGJyyYYCyBODWPnzC+sCTG7i1tbTAmboAMMwR/xOMz1IMFZf1JR9MNv4gkcIAAfAiSD2Uma17msXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:03:26 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:03:26 +0000
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
Subject: RE: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Thread-Topic: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Thread-Index: AQHdFIIwQs94T3Cf6keeoGn0EBzDpLZxXGvQ
Date: Fri, 17 Jul 2026 08:03:26 +0000
Message-ID: <SA2PR11MB48447C05D8C59FB4FF1C1ACA8CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-8-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-8-matt@ozlabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: b97cbee8-fa3d-41b6-63c0-08dee3d9e1a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|3023799007|38070700021|10067099003|56012099006|11063799006|4143699003|921020;
x-microsoft-antispam-message-info: sU40YZk+ojbw9wzXNJM6PAHxXf7B77SZV079oinHmoGI6CxWUK9QG8k3KcHfKzMjveOpC/MiUlOgTMC/y9DJq60qIwrUalPGMIGX5ykZZk8tiekotPr3dtwLCxQRasquXhpAg2Vc+RAgOPbRy1hAT/Ih5veRtb3PHzYfhAA43iRdCp3ix/0G/ZYcIAH940fH40rMsmqysnfqK/kCMs0t7FRlNGZlIDLvNpjW/YZXF4BwZeGJl8ysNE1rzubCs0VLTW+ZAVU4XpLiZp2ILQTmkIIZWlbAGrOQifTDN08BfEXpKv2B3XvrAIOunW68ngysvTzmBZcozjuHcwoIHBnCdz7Aoe5Cbvxmsav9ZjI0r0ej0BxUB571Vu5ToblM3yC+PJNi5F2kL0ElKX9rdKPXaEUaZtvdrRk6v4GY/LXPUTxQW+PGZ1CGWz8ORZL7k3GyYB2QhQu08UM18BksUrCyOqGTEy0D7/SQy5S8tUYL4rJg8Rt1QSK58/nX2KSqfcWdx7sl1tXa0p8AMpeBDNyH1HcN/KP3iT0H1G0nI1d8bW/qUGh6HUlOGnI1wCC22onqGPkCigpiSz5oGP2KeoZRW1w0nOPLGo5cgS/bICNHthHfWAJX+nhXjemUMDBzYaALztbmM2FQJ9D6zo5fVc34rE6mag7hHNx5gIxlAsO7EX5KtYBFy0NdimIIrUK7lVX3RZCoGdS517JHTYP4M3gSSisTbeMe8BGfhwZq6Vl2m+VlpTAU/HonPLMSnbl9Ikfq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(3023799007)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fcaDuMO3k0wQQTzzwMsp1TAvpMxdLOw7lyrvLPJ3gJndirJPCDSPASyznx?=
 =?iso-8859-1?Q?rk7tV9Xfw8fLrdNxtNz1mM0iuettcfoqfRRIRs6ZIQ1E2O0WOOuj5tbvE3?=
 =?iso-8859-1?Q?KgSe3VzZk7UApBOFDRklAdDudTIcJdiNzuVo+JfOB5cQkELqUuySDDpqsv?=
 =?iso-8859-1?Q?lyN0QtomvcNT1S+2pMUy00DdL4oloX8rN/xzn74gYiN0FwW4q3re8wge0/?=
 =?iso-8859-1?Q?hwk8qsGyElzKMu2kCzJQXJ5EKZotUHJxs2KolI3gJaqJqMPxMonYta+6w4?=
 =?iso-8859-1?Q?HjfcMKlXx7GAn8Sc/8kSA1OzVLgSL+hEYkc8TYU5TcJDyPsJT6shHTueQB?=
 =?iso-8859-1?Q?I4Oydy0xY7452fYXYEYcKKplYnsMhIhF1/6L4O2uDN16Bba/1/+39ZtW+b?=
 =?iso-8859-1?Q?TfrkRHkrlv8ah8hXXdmI0cohreYoEz4Xv/36ie1g3LXxpv+nGanBVX8L8J?=
 =?iso-8859-1?Q?F4/YySWX1EJ2U8mxa5UbuZDr3rswrpBUTXISJuIOeqO5iQ9EuUyhf6mw3u?=
 =?iso-8859-1?Q?YEMgj0ACtgyAoC5a2sa/Xcy5sQ/MYqvZVZ/qH6KGKpH9Sx4MOq5QIDkNhm?=
 =?iso-8859-1?Q?a7oTvm+pYBFP0A3lpWJhfcakGF8NGK5DPT4//ij0lRmGANjdQxdag2PsnW?=
 =?iso-8859-1?Q?W55ZGitpGBs8AajtGNdpRgI3IIulhOVIOn6f6oDswNOp8TwPsm4yLDgpWx?=
 =?iso-8859-1?Q?s/ZE7qkX/+TAT+1uslFikyjEbe+2/TrrOAsJEHIzTkMUqQXD1w2qlDxxAL?=
 =?iso-8859-1?Q?nIVy6ey1GPSxo9uIdde9EP4OCtWT//bXzw7CufDfPyGkFYlMKgNTWQx+oD?=
 =?iso-8859-1?Q?cdMCS6+71YSaqhckoAyqKh/KkefNYz9ayvk1z4RSAtrxE6SqGf+XdqsvqV?=
 =?iso-8859-1?Q?h7jT34m3ZnsbE04ihnmatCvOyAE4sq4KKRUL468V8qCCX1rfBPvDkHzENJ?=
 =?iso-8859-1?Q?rzwqaJq3wJdz3sNFe/gPLfLVVwGACH3wjjpGK7n9qJi9k3DmIjcjCcg9qt?=
 =?iso-8859-1?Q?RX2sRd61x1vwD4arZVCxJTBANvxpmBDndHKi0tfuesq+W2NU+Nb8qVEwxy?=
 =?iso-8859-1?Q?RFlIf5Mh0OHdu6baMZv49Mu+Wzf7dy5iHaU5MrKgMp/CbT/d03UseJ4z/k?=
 =?iso-8859-1?Q?dTGmDGjrbn0t8yKz6HhCYDkjfJkbQnuccy5PD7uQlv6fL7io9RefVtalot?=
 =?iso-8859-1?Q?oG6L6kLGjqPnO0NT1NP6lBPs0zcq09Fzxk9x/lUo7MuF2KRxU8PtZfuAV4?=
 =?iso-8859-1?Q?Q7HcaBKue9unWlcEfYdzWnJWFrlwpG4WdtE5BI/omMeJgJ4xoRzIUkgnTA?=
 =?iso-8859-1?Q?mlvi2+7Wm4ajF8ZnX2U648eJkw7Jht+RHo4YVWqco4w7ujRIVjbmwdu/A5?=
 =?iso-8859-1?Q?pQL5OafVe4yvknr64zZc/9bkj66Al/Zi0qBETxFNuSU+tDnFS5CNX7N212?=
 =?iso-8859-1?Q?KkWXxLu3rPppreYHJedIX9BmjgiS0OnfIdgs0xsO1K+oH1msNpLsmtFnC4?=
 =?iso-8859-1?Q?yTW/4Au1tXk19T8ifSCA8erExMlBi78A+LaciDA37hLZ6AGk4vXIEV55pr?=
 =?iso-8859-1?Q?HTqwlDVMAlWcPxBz8GszG/FQR4lgOOiIn/YQgN8HWb8Ea4EAHKKM/SOoWD?=
 =?iso-8859-1?Q?e6owxVnHRCRtmTeMkMNJra3Ir8KX3bYb3dPAVLl9O4jdoQc++rhkRPgvcP?=
 =?iso-8859-1?Q?Rfx0fTaZR1hR/pGJwOCL5uqn9qsMPVh37Da1MdKUdqPjS/H2fnX1Qh7XAb?=
 =?iso-8859-1?Q?E9q8EMCWKm/ctN4SmSy+nAUU4EtqRUZKHSHopVmDVm3qaf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iPL44KO+Z/VfK25N0Zs7xQ7FKYtgB1MuFrOLwvnQHjkCtkv35qhJF6XCR8mG/mH4KHL/i10lg8eIvlsWbjuMqjICN/8lPVsaqylfernHJ9xyBfM8fiwoD7xE0WOLUu2xapUG02Dn3ELRBHe0EUUje7/9XARhU7UKwI8Z+/NXZ+agSvoyOlyUuVW0i3eFkOtkr4qplI3JazTYQdUlRkSMc37BFJGxUAtLd4ajT7Fn7pbeh6lW9E7UIn0U1xrfZ0pqbZ73avegB3PI4XVE5coS6lBJryrzBGPtyIvWoIOA5FuLYHV1QTU91eZ4u2JobOlAFSYNsMJ6InoZFbGVoOnEpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97cbee8-fa3d-41b6-63c0-08dee3d9e1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:03:26.5796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLlc6LSFmWPkTySBkJjckIEuwhqPImSqzb9TYwYyM8Nop5IMIdLXMiGMBh9PtMJbBdXS0clZl733NCMmemG8gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com

> From: Matt Evans <matt@ozlabs.org>
> Sent: Thursday, July 16, 2026 1:48 AM
>=20
> Previously, vfio_pci_zap_bars() (and the wrapper
> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
> calls to vfio_pci_dma_buf_move().
>=20
> This commit replaces them with a unified new function,
> vfio_pci_revoke_bars() containing both the vfio_pci_dma_buf_move() and
> the unmap_mapping_range(), making it harder for callers to omit one.
> It adds a wrapper, vfio_pci_lock_revoke_bars(), which takes the write
> memory_lock before zapping, and adds a new vfio_pci_unrevoke_bars()
> for the re-enable path.
>=20
> As of "vfio/pci: Convert BAR mmap() to use a DMABUF", the zap via
> unmap_mapping_range() is no longer performed for vfio-pci since the
> DMABUFs used for BAR mappings already zap PTEs when the
> vfio_pci_dma_buf_move() occurs.
>=20
> However, it must be assumed that VFIO drivers which override the .mmap
> op could create mappings _not_ backed by DMABUFs.  So, the zap is
> still performed on revoke if .mmap is overridden, using a new
> zap_bars_on_revoke flag.  A driver can explicitly opt out; the flag is
> cleared by the hisi_acc_vfio_pci driver, since its .mmap just wraps
> vfio_pci_core_mmap() and so still uses DMABUFs.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
