Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7930B50C;
	Thu,  9 Apr 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721371; cv=fail; b=j0d1sUCYr2GSRC5AHmbiDwuQadS3muUkjxBmOngROJD9fN8AHgQgtb2GS1jzr0QYVP8p6TSD9SRYxnXU8c5LX/25ubliCYhzW71tCY03Ir5/n5Ohaz0TEqFSkOBVWzyM4HG59M7t/DTMlGjrHe5sSSf95Y1KmdEsTyf8by79Deg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721371; c=relaxed/simple;
	bh=0c/vMphjrYYpu80IFtkRLIefKaLZrCaOoxHCJqDQ/ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I6yqlyIkGIrvuppXa+VhLylSTP50uCAO7iGCs16cFk35VW0jLpxTFMwP+K0atrrZhavf7X+PYx1aNG42nkzeeY8HEqJPvRan05U8V1UGWirFfxncUm2AhmaY+OYbHZiGPPgH0aoQue27KqbvxGDvPSPpi6LNBICijyJPQbnWL5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECH6O45s; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECH6O45s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775721371; x=1807257371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0c/vMphjrYYpu80IFtkRLIefKaLZrCaOoxHCJqDQ/ek=;
  b=ECH6O45sYMxA68sRjL2g+BxWx4jgvDkmrQdNQDiE7EkKbEScCcGph/8q
   td74njxJj55fCekYx8oj2wZ/YgPhf+mwVVcuJPsN4HSYbuIXhoZYMjIOk
   xXMMHMabkCxfma4jqrR9y04T9BzCNyuA8SOzcMHl3gXVCc9Fkn+AXD+/E
   PoAg2rpo57bTNnMaL9OhYa3q98vn5oR7IvY9QT3FyXz/4Wq7DUvldd571
   zghgyq9N7WgSgcUY/9HC/Qo6qGdLkcdkrh6jwpXRTTXM2Q7kSO33NYKo4
   Squ5B5mj/LgPZXOEUBZf3MyKKEGzONcF9WJ/tDuHffBuThch2Q5gA2HRH
   w==;
X-CSE-ConnectionGUID: DTPaFZ3TR+2WxaJ97ieafw==
X-CSE-MsgGUID: xXcdTsBxS0OAy0GBby6IfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99346425"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="99346425"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:56:10 -0700
X-CSE-ConnectionGUID: g/Z7r6JNSsKZgYtKHCt1AQ==
X-CSE-MsgGUID: V+0MR2SiR5OQywN8MzzjaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="233074579"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:56:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:56:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:56:08 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:56:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krZDXJY5nlTbp+LLmN2AN87dDh8PkQEb/P7XoKD1/SleVbl2wLz1IztxZIpsF8Gtm7OgrRuyGN+3J580AcECnnCSCnohY4sDtkZD7uGpnX+b9uI2iJX2DOIFd4J5Y/qYxtTqyefqtB9HmmRkvJBz+hc/A+02fqGbeLnyAhMSI6MNE78nnUAuQz6AXpneAz9AMXo3F53goIXT6l+UH/kTmEHByNUNJnfIFINfENzYln7lxdjoy5yKek640jOasZ/jSHVqmdSFWzJBFft9vYke6Jy9FlKkoiIUmYwmVgOeOz4bwUF1BiUXwRzdd7TY/kucAQHBcD/1kIFCs58VzZB2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl2SnELBk6MH7pAlqpZVuFBNAj4VRxqYyZUZdYnTxq8=;
 b=m07n8AY+G14jbd+oW5il03UEvwRISS1Dkqrx2B9GJO73d2v+CKFvZmy9XrlTSbfI1rSz4V61RvB0DwkuaV7Xg9C62as5iy/Jm3sX45inmKPFsmW19YnfSJ/bcGT64mOm3kCgm5Ts1xDDxii1ZmmN8pk14aAHoG5mlep29gHsqtlY55Cq1d24K3/WI4TpI2Bv4JpP5KWzq86uvw59/h4fY4N6KREH5Y+3GefXZEChgO4mBtV/h3QX+boYtfq4ejD9pwi4kk3qsJPYQDSNnIKTChop3rJ7CYnzgpdk07NM19IkbAgHjegoMfUTFYJCMJz9HhJGjL8vBwdvRTvCApDHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 07:56:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 07:56:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 24/31] coco/tdx-host: Add a helper to exchange SPDM
 messages through DOE
Thread-Topic: [PATCH v2 24/31] coco/tdx-host: Add a helper to exchange SPDM
 messages through DOE
Thread-Index: AQHcvgg6M3chqW9amE6XRdboCxGklLXWb/VQ
Date: Thu, 9 Apr 2026 07:56:06 +0000
Message-ID: <BN9PR11MB5276E1C73BFF4EF6A806F69D8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-25-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-25-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6541:EE_
x-ms-office365-filtering-correlation-id: 8c1bad39-becf-440a-4155-08de960d7473
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: +X58x5EpBD8aas0PXMVflzbuN0TiZVHnVFWf1iX8UuPN+b8WJIECeoaWiqmH0XvfPtvoRQYzlij0lZtn4voljrT6wzD04ArWQh80xo5YJc/7zuQRkOBUk4Umj5io/O7uKrQnPD6GoyL83iIGw0Ya4DwvA706ZLKqcsDLqNIOMiGXJ2lgywKTWFjhFvjFk4TMoE0WHPKQzCLyNv0fafrXUbPO4SI7GyYHuqzkqZ54xoJrlexnnF8oxilNew8COzfijIz7jaBgwxf+Pr9sEfyfTbi/BeWOsj5Vmg4LhtXkEPDR+cOQc6u+gteisRAs4M7VaVlO2E+/vjyr3ZNu6xrhWXDYzjY7Rb6hamDq4LWxqNQi67zTJLxvaCrsc1GFTA/+3VtUzmof5owbfBqRyzy7WDjYYS5+cv63F3iqJcyS25XlpeV8Oe0yWj4L8kO8fGmBO8V9WAu9Zo9EbkMdG/CN2nIf8cXu9AB1ox88gpZYe56/8Xv+VTuDph73/pj8IFIqPy8Fbt9XkfeTx2oz6WKMmIgSR9Gh1kG4b6bu24zsD0yExpw9GJwpvfbEt3fY4Y0wjHVGNMfpFGjq7RabVFO5jEdDPss1baLJ4Z3SRZCRzd98otTIIXVtvxbW63ebAZtk6qzvwNhN6rgfn5i5w5z3OewfrDL9HTN6nO8YShKiDHNRtjXZvFJf2mYzZV4DefxMmTx6xTiiZ2ntu6Fw7D5Uio+SsVGax4K6SsGPszs8eeAK49P2tHr5XWdxdO0kwymLcUGRMoju/ZfYH/4w+gwwDCD3LyY21CM3FfoWx8qSZ0E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/x1h9jiu46nCijB8hBXKCQRNfruWjsf/fdNLXsMRHck/rjNz7IyQjDvtd2HL?=
 =?us-ascii?Q?yUl4mQr6EJCLQwANtH0mO7e5GBecG96Q7U8MGJPPXRnINv3flAC1yqMTPysM?=
 =?us-ascii?Q?eEpC9ncKJfpktEvBzM1i3FXxIYrpwx3W5KUfrEeRKXkfM+bzZEzJiyC/nuLK?=
 =?us-ascii?Q?lpWAltLNmqhv6U1QiMJwSy0UoM89tOAxCgtkzWb9lYIhRGoCz+Q3zyrqYOvk?=
 =?us-ascii?Q?beeCiIKQcanN/8CePUeU6aaD9p6cvBeTSRXx49oPOt8vkAaepnsQm/iv58RB?=
 =?us-ascii?Q?uQMoVMK+uG5Cw5pB9K4rVQwQAlI9d26W0o4l76rHHTfZ4bkqonndULbKC+r+?=
 =?us-ascii?Q?mzMMqd/2oabahzL6fPCXcDjDBj8Cb9Oq1g7XHnMjXjft4smqe3CK7a+/rFFy?=
 =?us-ascii?Q?SJ0trhn9uf4VPVn6IUUxCQI+aDKAI4oWgVINNctgR72zoSO2vcxDfel4p1s4?=
 =?us-ascii?Q?O6r50iDgh1QCMy4zZHwt1XevG7It46J4vYYlmmn1nmZ/gEnnMDP3GBq/MsFv?=
 =?us-ascii?Q?PMHkTCVv3frlfdhtjN76zucTv3N0eYHkgLuxG+ROce7TTP+LdaB+7poF17AA?=
 =?us-ascii?Q?LfKNsx0rhtEm0gunwdjoikdhva8OKQ0gSfa0neYSvVJya6HLs91YHgwp8FtR?=
 =?us-ascii?Q?WV+awHA+JS0ZxwGQb3BeOIb07G0zgv8+aSgK1BCm2Jx5pOW5rJo4hk2VNWpn?=
 =?us-ascii?Q?av9qxK+KtwIHqf0EQy8vDSlMyqWIQW6IT3c45wq1R7qMmqGyQ6JcYS67xLXQ?=
 =?us-ascii?Q?1MO+mxqH441WD6JJleLkft1csJlpXe5p5xljV8ViQiKTB3XuCneNy2GwY8Kw?=
 =?us-ascii?Q?8O8v7GeNeGY1ihgwHJysG/G7ogsPuyk922hZreavTCiqaSvdlDPWtPkp9l7C?=
 =?us-ascii?Q?rVmYtvOAikHuj29u74fjtlK5IRzDj0rUCpSySPEXqbWJxsUyIU5ORKhBBOu8?=
 =?us-ascii?Q?WrN6MW5LzfPs/JODoYnkxcj45ghxoyitsM15IyHur2aIUPIwcTuXVRdnWb+5?=
 =?us-ascii?Q?Z+Lu4/brSZOzeUnPrerPIvAD6OFvW3A17REj8GWtYi4cqytgkoL17H9Nzf9t?=
 =?us-ascii?Q?Y9nheRNEJ/QFOxPfcSw5QZ6y8abCSv3WlhUqx3iJwcB5fMPUngJiOYl5E1fA?=
 =?us-ascii?Q?u9WCmxoU6LJ0kKQqHq9Lue2NoqMIfkNSj0bfC4d/jzm7dEKGuRURCdGF0dJK?=
 =?us-ascii?Q?rQkLwQycu4LtvoBN3+p8zl1aioaEgJXqKVIEhV2Rf81/jwneow8XlSCj5JoM?=
 =?us-ascii?Q?669/2zLDMpV112O4J4PGf93HcjAENdEwjjLHEw89ACOD3OfANmuEgFwR7kin?=
 =?us-ascii?Q?H1iPdrNQ2BBWd99OK5CRfqkmOjClLpxJeDsOjrIn6Lo/RA8mlX0wWvoBhh7U?=
 =?us-ascii?Q?4pDi7ooq7i+eyh3t+WAgBfb/1PkR9xXCDoDbnu27RSJgWJWKQcm/TJmOh0F1?=
 =?us-ascii?Q?SoWO6Gt0y9D3c78lvjZDvlQnOHZ1q42ZpVqkb/qCtHsfHvhBuwCBgxJk9LIP?=
 =?us-ascii?Q?urk011YOKrUHdCXb22tNEeFNnY1qUHx9hMKc9fSk2BuDX3/3nGZE1cEloO5b?=
 =?us-ascii?Q?HTsUen6QwT1IgXQncE+bH8ij2EwDMuK2Q5vWLQB6ySTzFKMllwAyx7kXB+8i?=
 =?us-ascii?Q?X+uUciyK4o7LjIjFXP/NQZF5ImCEvKkXbzgGmUGCrGm+88GxrTCLcguvVmsj?=
 =?us-ascii?Q?+NIEJPdeH8GIa5fd0MCZNiBtvBN2+CpfUgfHst8gxsu8Nu6162rK/mq0Q8l5?=
 =?us-ascii?Q?mkSsM+JlWg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: geNh03BxOuHxAdbNIs4aQHRli7SEQ5bJpFWiEwM7mrgPbjGmhDqkzo6grHpvaPU4qgqsEtZIr0v2jZmJzRB413KrTMdaGso/KwQAZeLo55sz/gUVHBF6BQ2QVvs1CzKwDDJaUjlbsDNH7NupmYiKZ2d0xMnpN3ut/76rZI9W9VEaDZCnBD81r2GUlRsu07NYCoSQSpkYVqsV3NbkO4i9ia10dby/fr2TsW1JqQpld7JDkSJnPIT4uRskV8pI0HLlM7jy2tUhUM5g/zlmWq2g1IoL8SCFPq3KNLZx+AG2jTL096VK7S+Slk1GjZFA8YH47fXm2XFIJ7nRmILHK39cBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1bad39-becf-440a-4155-08de960d7473
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 07:56:06.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULOGPeZMlI3AeOYDYWx+fXPLz/qGLnpQKAYFk82tVajHo4My2r55hUWn7XUEtORCLawbwbnRQUBMHObIe+WFmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Saturday, March 28, 2026 12:01 AM
> +
> +static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_tsm_link
> *tlink,
> +						void *request, size_t
> request_sz,
> +						void *response, size_t
> response_sz)
> +{
> +	struct pci_dev *pdev =3D tlink->pci.base_tsm.pdev;

call it pci_spdm_msg_exchange() and pass in struct pci_dev directly.

there is no other use of tlink in this function. could add a note that
this should be moved to pci core when a 2nd user of raw frame comes.
