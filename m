Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CA2EDD78;
	Fri, 17 Jul 2026 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275436; cv=fail; b=kbEVenepvgAYRTU5TmOGXWCJGVw8fOWhFcAnKXgEUHMvbyS34/PpkbcPOkIyjWTjCBxUJKGbGs2NOgMXrtom+iUuiGx12DKrUg7VLLV+GRun6AR7zBd1ihkKCf6OiPWldt6rK97tcuTTVUGsfUD4fjZixcxracNvND3A9F0VwBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275436; c=relaxed/simple;
	bh=+1EsGkPbcfir/NDZEy71JwJFBhIczRezp5Tf4/0YMqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PyT0SYQMD6hdCPUAm2yz8HOu+u+xHFk8W+U1sqZ4RtbH5Ci6tsjFG+aPN8+rpxZadnM2zNc95+miHhMAfTeJ0lJ/pW3lLRgfMPovwsZwvY31pXOLpgAJBHKk3guxm3eBfVtpsoYT3Yja5ilsO6oh/59/6VpTsuukNLue2qQQ+zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0wm1gop; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0wm1gop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275434; x=1815811434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+1EsGkPbcfir/NDZEy71JwJFBhIczRezp5Tf4/0YMqE=;
  b=b0wm1gopzZG1AzgJpeIoUzDLs9k78BoBOUx5nx20yoTbeDb5iU5X2Ld1
   SparTeG/vXpajfd+499KIvrUuVhJsRp4S0BVe795ryXaAm1buGgZIDI7l
   UPS8eW2hBM3S3/wnoB1hweIppjaX62Ta05/FYzyTWy00GW3M7OlfUzLgQ
   Q7CwXNVV2X+bwFWR2v67nAmrEABD1Db5AxRcllG7x6B49Tj3HXkUfLVgB
   TUO5YcBSfG90J+7hwLOukLBM5ax9VDKQOdFSonJAD0acjObROtvEKtjwX
   InIFIVH5ky1jTICNjuV6WLTTHll8VSrjhTURAHz2vv7g982BEEoGXw5Kc
   A==;
X-CSE-ConnectionGUID: mk0akhOlRSqpsh/p9JlntQ==
X-CSE-MsgGUID: HVcbD+aSTQSRMujpU0vqLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="110494699"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="110494699"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:03:46 -0700
X-CSE-ConnectionGUID: WQjv2ToMRc+1uRQdzMKqVw==
X-CSE-MsgGUID: SpkgJeoETnq9N+IfN2X2Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="260543495"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:03:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:03:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:03:45 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:03:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEwgIWGUxQtQZgEu2UvX8RthLdLoSJkEWOuSz2rZrZzVeIVNmgNApkJs53Gn5grn7s8H5UD3pyBfZhXsuGTvaeEjgUaO7Zu1H2ji8uNEarCgwC31/LbX4n7KLd1BYw1wmWqw8bGEl8JqKdV9pFlatqGCEKcY8rQ4ZQPqKnLnzl/pixQnzeK47hesUjP9uRHSbTa0y5Ilg0g4oz+aQkuwg3qe8CpywRWGGCMrzR1lyW/GTWTjPR/z0L5A7xkVpQl1TwqCvlq61vqQi/gPujTd9rxxZgoZ5sH3fEWknGqC7blUBahhr2yNtwSx4twMUZpI/5wo852WPzIP+ouxyblSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yap2UztW3CAJGJxWnB7PfArm0/xWpH4ZyaCxgnnj7/U=;
 b=KBAF439WYF2GFtbDHILfGepys0AlfBVpDyX8mitt5onoU5DInr4iZUjzxCK+ZWxA4Sq8No8OlqDt0ir9S/hBm7UmV3mJc9jJfaGucNZPoxMV8toDpoeRERXOoaWH0mpM4qfFTPoSiBQSjmDbScRacCxCJvzIG/GvKDi/B4ght+N4+GNw12myyTu0DD93Mu8W6a3BuzrJr95hd1SBnOED1h9B1ZHTCsFqMIOTW8pFLOFYxmkQbdj7ze4pcnyLJo3o9HttpBFf0TgvQh0YUiJndpOQwvYMgXTnxBeMMEbYDnr9m9Okig/wPaxGoldSTaidXg/058ojBAkruRAeDuiidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:03:42 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:03:42 +0000
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
Subject: RE: [PATCH v5 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Thread-Topic: [PATCH v5 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Thread-Index: AQHdFIIweQfcr4WbE064C8XF2FOS1LZxXHwg
Date: Fri, 17 Jul 2026 08:03:42 +0000
Message-ID: <SA2PR11MB48441D5B72929088C66762058CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-9-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-9-matt@ozlabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: baffb45b-e607-485f-9d9e-08dee3d9eb50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006|4143699003|921020;
x-microsoft-antispam-message-info: m7VX0xdmywghIL2chgFvpDTgIPbQeACofmbvZhOQsBANe+ZLUw5/PtPiNpw6R58XXoEPPZbTPhqCR+gDKmibLU0Uf7vzaJQka9LwZKcBcknBbEMwqEaic/RmgqB5vhuygS+m9qqsVLxcBZ6tzDttoIjO3m8P6PFfVjBCzFxHBaBxIa3knbBeMK5ERB/azpZvOttS6XLyLmHbMmAOw4aGG0vK+zbRPa7P9Kl7TE1W9s3wcmP1RMTkdzkgxttd8KPGPVNVLtRicA/6/hvertHjGq6mF3PBnrDRUwz8++OcRDdonhggpVQ3jG1SOGv5QLlDVAPTomTg55/gUQL8GaKYy+LWd+eoA8G69yIb9WZKBB3zn/zfd8yIK6T8naGfyMAPd2jk7SxFvZchxzPAdGgkCgPe5bRjmnLYkwqVCeRtskC793ZhTjd9bBKM+zb9OLf9PyXFzWMTuGap8rpZPq46hNOOQ9zFi2l0N1gjtCPu2Ne4kGf22CQZjtaN6snC/dqzWlQHL6Y/bkgnY5MKTkY8eEJ4pkX1Pdadjq/gTQQzBKP+4JASjsx9qlFbrRVZ9PWdiHMaQQpfo1wS1aMuHQUhNLrnf1fDLKReLUeZQ7LqWd5lMsOHjZzo7WhdmGEMPW47MnK0zALbM3qgXHfr0wNg+xEnkV31BSYzOMWlKzxkkvZzFXibO5yo7GWz7L96SFr6k5iVE7lqeSxVd9UeUKDgXUbPoOQ+NLi321k3jbCS9wfEO/WPL8oPSblwF3FaAho6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oxGmG2PpvQPXwuSQgMQ4is3UtUQaUh6/7XHIMsoF4UXOP0IN2daFwFj7+p?=
 =?iso-8859-1?Q?JIAUu/ztagq/6AES0sN6RtYNoAAkZj3xGBtiajBgH2q7mzr5mrp9Ju2eQU?=
 =?iso-8859-1?Q?t+vlsE269PRHbIxiy2XJ+zOf/2m6erKvLwicez3tH1t4BC5CZlemXjZWat?=
 =?iso-8859-1?Q?dsX7MWkXayuZ0DS5gyU3QoEppj+WoAGt8V40ip5RmLNOF/fqe9LyXqQqbF?=
 =?iso-8859-1?Q?b+WELIk2WgkAx49yc4Td1NtOXuElITchFfXYRKA57YL4A1z3zKIfgNj8YU?=
 =?iso-8859-1?Q?tQ5OZIICRDeXRTKSXTI9U476rmjMzJh298psQh22QYr72XAH90RBoZ+a3y?=
 =?iso-8859-1?Q?hSrp8ibHsch+tUN+rx0gjR5uYhDIZ2ZFCO72AKN7nv3NooxgQbKcDC6inW?=
 =?iso-8859-1?Q?gptdH9kMWAJqEwcMhERgIi3K12a8+bB8qhPrx27upQmRKhRwQkDjKXQ290?=
 =?iso-8859-1?Q?Wmd2AWcZWlmrcGDYnwo7teaE9boMysHnitzDOnk27vjG8gwAxRqi28RGKj?=
 =?iso-8859-1?Q?roS7xxpPl25N62uiDdiA4IlGfVHaNd6PgkMRqyc5XrHObWkd0pilC5KGJE?=
 =?iso-8859-1?Q?fPkjZRVoKpnGArnhJgagnhfy83AV8rHxG/4zNFSG9bHy0ATmnzvNt4VOGW?=
 =?iso-8859-1?Q?thfLVYRXP0EUhGe3xOQenV282+W8zHDjbauHAzeLkOXG//ORkT/67kMJ7h?=
 =?iso-8859-1?Q?NB40JjQh199AjiXfcDzzGlkl0yoxYHWt4JJg4a8f0PiEljHzZPZ9dZZyJk?=
 =?iso-8859-1?Q?o1kSHepPlDF+lisSLd5Vlehj01Mg+hjHPcnehbsTVsueoxqXwLScpdCq1Y?=
 =?iso-8859-1?Q?RHVvIXnJJKRElilvhr0fX4iVc0GIBU00+eevz1risGPDAKRw3gmag9Rf6X?=
 =?iso-8859-1?Q?twT7Mxc+BmAGDUGylPpwvAx09HtcQuqqSSuF8mz552iQKlB9dgYQbQ4VKr?=
 =?iso-8859-1?Q?Q8cjVizXoz+8gUqQVy93TMj8g56LwkyUu+I9BuIhZp1R0aFYxM/YJ/QfjW?=
 =?iso-8859-1?Q?Wob5ogWDXFyefMKd7xdKYrE1BL6l+srptrlPUjDr6qFqaFTraCB0/kRaeb?=
 =?iso-8859-1?Q?vVb1kuWE9kW6qEMMV35PNiBHSswFEFJC+9ZoPgf7eEv6Rp231LoTewopmO?=
 =?iso-8859-1?Q?x6kvgLjKffVXOatkwGlnLNEm/KxUNhp6WkgGiLDYbscDLcKXBdLDA0ujF8?=
 =?iso-8859-1?Q?c0ks9sDvuEHs89BngvXVjAmhDNK15twM3dcmW6iM9iO2o0oE6/HSnd/uSF?=
 =?iso-8859-1?Q?aIdwss4BAOQt2t0ljjddvAqgl7HUrJ/tTD6j8huoAljIz7Ro2HeZzgZwvf?=
 =?iso-8859-1?Q?zLItRdunzyT4/n2QxehMrv5+H2gJFXW7vTOX4Ulf/C+L8hkE9dnSdDk8VQ?=
 =?iso-8859-1?Q?lB5FUZSD4dDakP4ebl5EKr1+wKJ1YFGXiwlsTEea2hMj1pyhHnjLN4QeU2?=
 =?iso-8859-1?Q?vXwZSOerlJ5eaAu0MDGvgGt1LOe0zqdQRbqz8f7TWZ4E7xzzB/BL5fSvzQ?=
 =?iso-8859-1?Q?C6S5dAswPwShQeJS0mz+zaq6p76AMplTqoh8WwN+GFre9s3/61ob7PbjI+?=
 =?iso-8859-1?Q?ZWccbqVo/iIWNybnr788UJTbmvGwaPKErTLrZZiCCSOXuNg3atLD9KIZnj?=
 =?iso-8859-1?Q?SUEjY70KuLoFYJL9SnWiUIXhjbT+N7LjY9gfaaX7cfkXL1nk+zGxqyPZV/?=
 =?iso-8859-1?Q?VxSPcvfpcxoTmFkbdjn2Y7wO7O3M9g6pdrLkVpat5zbwUbbaNXzdJCZ4xX?=
 =?iso-8859-1?Q?FHEgC+wTqCG3+S9pTOFj7EAjiLaUbZWEJn/8rJhdwHAz+U?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GvOScqitQ32cqosuYBZmu1m5q2ws32sSLAAH7dHAHIO2wKK9XonzID2XuZ1YI+9R7Ocee1vRny+hkDvSD/TqfCngnVaRCsc2qvbLPItI3OTha+s9d2EdmvJQId+U4Hsh2C3jWX43fGhMJogQDXcqTaxTryUPwXHNyuKcLdzxDKv99I2OyZxPbeRK0GMSuf6A2rt0418jZW/zBRtf+9v2Aw/XFFlZE5w0Zeu57J4hGjF6Zw/7Hb56UrOeUqUjBKhjBF0yIssO67cNZl3Nij0QDXByHYpGM0sqXgpx66wpbgH4qUz0khXAfRBmV2pW/JkrqyYDO/mleoHaE2MGtetIEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baffb45b-e607-485f-9d9e-08dee3d9eb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:03:42.8226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79QiOULBdZy71WH2gS8KaOLWcr9udLQ5KYBl0FqyCKNnUNcRs4NzyjIzHXdFHdaB5YAzGR39kRK9FtRCTv1/yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com

> From: Matt Evans <matt@ozlabs.org>
> Sent: Thursday, July 16, 2026 1:48 AM
>=20
> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
> support for mmap() of this fd.  This provides another route for a
> process to map BARs, in which the process can only map a specific
> subset of a BAR represented by the exported DMABUF.
>=20
> mmap() support enables userspace driver designs that safely delegate
> access to BAR sub-ranges to other client processes by sharing a DMABUF
> fd, without having to share the (omnipotent) VFIO device fd with them.
>=20
> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap()
> reuses
> the existing vm_ops.
>=20
> The lifecycle of an exported DMABUF remains decoupled from that of the
> device fd it came from, i.e. the device fd could be closed with DMABUF
> VMAs present, meaning a fault on a VMA could happen concurrently with
> vfio_pci_dma_buf_cleanup().
>=20
> To deal with this scenario, the fault handler now temporarily takes a
> VFIO device registration to ensure the vdev remains valid, and then
> vdev->memory_lock can be taken on it.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
