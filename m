Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC13AB29B;
	Mon, 25 May 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692334; cv=fail; b=mopQe17jAd21zxJ+p7E93imzzdgD/JCd5BTbEZ+ArAqmJXdSnTo7usrS5QW8n9tynJnoqwg2SKhhu4ko9Uxf2eqPZTsfovdvSk97zIWs8NGYEh+GprdSMIk3Ouyg0Zdwm3yiR+eATyyjS64cF5puLpc5EUCwll91KGdPg4LX34M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692334; c=relaxed/simple;
	bh=AH/B48z5Hn8bry6vzk8Z0lVNLGQ5GEpkKUx4Hy5DIfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nLmf1AisQbWZBEJ1LMU77a/znB+0fFIBOq12m4xJbV7Bis5CdlR6NebtZ62bm3/IUlprO09+Qd/Sfbqe1NyMeD5MbOPvoM7NELrjp4zZdejoxEuWE7zHyyz+1vZmvH7ume4/dak83/q/PgkUmxd/J0OzoIRcUUFJWD+fJZ1CnYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwoyMorb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwoyMorb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779692331; x=1811228331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AH/B48z5Hn8bry6vzk8Z0lVNLGQ5GEpkKUx4Hy5DIfI=;
  b=SwoyMorbnIQ/F2N1jsgEMTCbY7SkckvTR2SiJM2uommTpJ96uhb+ySAb
   Oe6Ts0uIbfQAhFSHzI9ffvoB8/HlZ2jzP0GXQ3rqanZ/Y2SILK0KPwDHO
   SZHQW7PUzj5CFK+CquEi1IQtwCAjxMGX8XjLOBwKNJw3h/0sZCdlFXo1G
   6DgXelOy19rh1lkoco4P5ynGHTBp5krPft5bCuP5Gnljn/oIzjIEUF3ew
   dI6M3qFdH/yN09jsVD9V7bqSjheAbt9cgkQm5w+NFLJ+khnmAWJma0kLU
   GaIBONnO/38wI39T7zLwKPEXe5F9byrElRaOSb5VFZGcLB0voCDHMJVSG
   A==;
X-CSE-ConnectionGUID: Mpe2ExJASkKNuT33L95uFQ==
X-CSE-MsgGUID: dKarJq/qQdanCb5cQpZ7MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="84132668"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="84132668"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:58:50 -0700
X-CSE-ConnectionGUID: RS11pADtQjO/CH3cgN02aw==
X-CSE-MsgGUID: j9rrAT7uRbCBL4hsLvpW0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="279633910"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:58:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:58:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 24 May 2026 23:58:48 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izcWQ8MVImydRPdvGf4ruxNnEAIuB8prPCS/qONqIVnnMSm8+RxI6K2YEww45PUmlsihEevyZSrBVdrLNEWpURAUsIr7oKPY/PYQ7mGwBzcWYjpWebWwsNW5Sghl556aZE/glNcIp7uFjjxxebDVAtKKrqZdSlltj2LT4xX69WjbabQboqTIM8MIUrj7Fi6gp9g49S+3OxYwVABTRY8PyevCwvA5BgQtSTtHk13AJcyjVfT4f4V5JL3xydop5tnT5mcD09Rr7+5Ir487nCjOyu2mA49xBJbmCQYsvxNNEzPM3c+oxth2zQwgJh5nnIxG/BOopv7ALzQtGESF7BV/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH/B48z5Hn8bry6vzk8Z0lVNLGQ5GEpkKUx4Hy5DIfI=;
 b=PVXxH3ZOXpeRyBURqR7Eu2fxWYk9dawFHQ55qsfnfsGyxEhDa5dOaG8/1L8H+zOXuS745fcLFz+ET31EPS/vgLy381fnX4IA743RMgcrI+BOcsprFRH2bN8QPU6/thk5+hCRWLJqBAZigCYzdtXd7kaSx9JYbmcnTOm6j9z/pbLM14uShsiG0IOVwcxHgZU5GZedzz2eHc8D8E49b3oVDSNTsgAaA75W5/TNoh+thSlxjs0XYiaHKvtcAyFb3f7mng4jPl0Nx5OtHk96tNVhZUoW8QDYeJ7EH0dD+8QRJvV3eA65F+F6DSzkiebag2DMcwHvKtJ9TJSpp5NmCC0sZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:58:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:58:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "miko.lenczewski@arm.com"
	<miko.lenczewski@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, Vikram Sethi <vsethi@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "nirmoyd@nvidia.com"
	<nirmoyd@nvidia.com>
Subject: RE: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Topic: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Index: AQHc1gpb1K2PMqLtpESSV+2LT0fAfbYXCIyAgAAW0ACAARxQAIAAXU8AgAXimdA=
Date: Mon, 25 May 2026 06:58:39 +0000
Message-ID: <BN9PR11MB5276D64268AFF7390D942E5C8C0A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
 <e8337102-aecd-48e8-9a2d-10f41ed43c5b@intel.com>
 <20260520143410.GV3602937@nvidia.com>
 <80e7e1be-c384-470f-9949-8c0dbad165ac@intel.com>
 <20260521130544.GE3602937@nvidia.com>
In-Reply-To: <20260521130544.GE3602937@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4825:EE_
x-ms-office365-filtering-correlation-id: 584b1aa5-8bb0-4c8b-0f88-08deba2b0cbc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|11063799006|4143699003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: oXSrExwg2izUuc7c7O/lLttTDje1S+Cu7QaprdYaRSBGAaRzsi3rZF7xmUVV9F45snoh2dxfIwZXQv4ZP7tTvsu5ks6L7cJtWnczmYpw6qMcyNHI91Jz2CZSEr5zjmWUHlELVpRTQWP34uHCEmQRPPO+x4Sno0yVZyZj+L8B9HYZwE5ogDMeguXvY+et14NcNfAYngB0Sy97/UNdfFzbJZ+oMyckMJeytxeQtG6xGxrJgE0JJY0btYdB5HfnBln83XxPuL9M7yeh3F+ax81PxA9aXhbARDhheKXZK5cVpLXRt5yPpds60SjhSvelw8CriMamZFBEGG3ngn45pkBXUThaiqd0vvRyYUL5Sf2lB3nzfM17GNZGQEdxP0OOqdYlG8Yi+InYj/r+SPEl6F7SQbHZKtlDIOqGheQtZMhWL3uzFZ1gBYUiK9N8vyXOnf4R2JpzVcAIHG2PubZ8aImvzEZAMWolC7cblQNfC/xOQeAwghI72KvCyoleow9UHqS92c3xy8Ykv7f8l6pr/k8CVlKgB0osD2sCau6V6jCxjbwPp1J0LL5Iihx6790+hNqpIaPVNk54p8KFffqF74qC1TXNMz+EgG97+B2GT9MWkj8qz0v1QbEhX5NTYhIyH+5VOhyhTBE6MJgVX7YxQ4fP0/ult2++cBUI1nK71LZmumtncM/7gfDv9koTavBt36nejGgO4dnpO17jWSWTxGoRpDUurWTblXvprUqgpR+YNdFLxOKkcxPyu0NxzMSSvZPn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UDSb/ycZRnDsaiqXTVf1MhKYdOvEFbPZeA/SP/oycvjilaQ7ehKfVlYugQNp?=
 =?us-ascii?Q?FPF4XnvjwfpOTB4OWzn+QFrQi3fLQf5aLWtfP08EgwHAdxmLYVR5v7k7DRq/?=
 =?us-ascii?Q?mf2r40bcx83vlokSvNliQlndQHWgzjSQalmcK455umTZGgvGzIwqBdB+ALBW?=
 =?us-ascii?Q?fjcUN/7vwrXW34e65PlnU2kYIAXkK5OJkc7OoMKWFvP1j4yLVdi16cqy0HWl?=
 =?us-ascii?Q?ph+VL4CtjtZdIykUp50yaZw1uE63JHsmrnZPdoODRjS/4iW3INIJQ8pRYjeF?=
 =?us-ascii?Q?F66b77isO3Ly3qYWR6K9Mp5L73LRCyIpt83bkjQgX68ICpZER63R1815uvAP?=
 =?us-ascii?Q?wYsfIaqQrbTZX/2BKZr0XgyCThGN4OpxSXMbBd4QvgGVdi+UxXtvXuK7Kzz7?=
 =?us-ascii?Q?9JJ6TLdo3ZVUGN8SC8hzLZapqmSzkXvk7KdOhSmP49r3TrkMjOTI+yqEdEaz?=
 =?us-ascii?Q?L1mbUNiEWwdp6nm6iBYFZGkX7MUL/8AMEO+NXJzNXIED5w4YwHTWP0juzVQy?=
 =?us-ascii?Q?WbUCn4Q23SDg941KReQ8WXjm2JF0IJD5fjb9ojXHNrNGojWBEZLvqRbiNYpk?=
 =?us-ascii?Q?7rJXUBfEB4YkylbaQalmjk+GW5hrxGUZwMrF8ChxbL8uL1z9pEVuLiu/FMQe?=
 =?us-ascii?Q?2z5pPJK6wgHkzWzBPq89lOGdhtZDMHNX8p4okdMYCxrCvcRYlEA5zL1UUqNg?=
 =?us-ascii?Q?mg/Crn6aAe1TvD43JUumuiSA6uE0sjJBaz/+foVuccbBYhnkpQbqmjgWM6He?=
 =?us-ascii?Q?lXNBXLGEUKwxfTVTLTMmN5ytXn2ydck91sdb8ZEyE9Z5+tzdhoQFa5vGC36F?=
 =?us-ascii?Q?3fe2VfLJ0mbhlohKbOGU64PuKkTfJMyeGoNUNxMRcUwl2y5TWyuxjZTMhI+6?=
 =?us-ascii?Q?18sr+0wAqJYVDXRR6HSHfMra9A9pcGBd2WqoQIDu4utMfbJ3olTk+AtOIL2X?=
 =?us-ascii?Q?cFllzwe4c/Hu+tio/EdMFibOjuKsHweP99Gb7mWoRG0iWcIEy1F5eXVwArII?=
 =?us-ascii?Q?KJmMuS3idD+ZEy0xOMmeR+58Q1o5B+uErDC5wkIUQozLth+5ggWeyOTcNG8/?=
 =?us-ascii?Q?JyB1p9SZhq6VBeNR8lCykFOc8ajh37zgQn2YXjVCNczPSodqnkrIlLIUGAcO?=
 =?us-ascii?Q?C4rgo1wvH4KyitqdKVdIqk/mI634OC/NEHEXH8Zsej7abLPmSMhIoPbkMdTU?=
 =?us-ascii?Q?jA0/3CQyAAciK2WN1pN+8PLvVREVOUuZUbofVvcJ3O2y/AWhKa6+2wY2SK1Y?=
 =?us-ascii?Q?LvC4OIiCBoWR8wgL61hUUzhTX+BSBj4yMyCHw8vX6AqiHkPokO+vGXj1DpPs?=
 =?us-ascii?Q?2GLXKxC/Vj8XZbAskLfkk1oyuD9yz+ansewIVUEN6isUnE8am32Qqb/jLx5M?=
 =?us-ascii?Q?ahJ9tBq6P99S2OpQMhKx7JTwTHG+XfiWigvwyqtZ+kA6FYIx7xp8VaSGRk/m?=
 =?us-ascii?Q?c2wlZegy5ZH1qplcTQfzV0EE+/CdQJPAM+qyAP77Lf8gcyrCD5CFR0Un1pE1?=
 =?us-ascii?Q?KQKNokhb1ApWlV5BrDji3hIB+N2JfcHPpnnYYijbL6T+J6JKCxC4+9zmmYXp?=
 =?us-ascii?Q?8/LMjLsZGdht8vRyO/61FmdcusRgjUVtxNcAOg3z+9X+q5dk+u9rVQeactIg?=
 =?us-ascii?Q?FpGSHXDKO7auitjTafEx2FpjIbn1EbD8MPYo+0WVA/F0Umr+XsaZVa/mpGal?=
 =?us-ascii?Q?8sUfng6H8XhhkwMmT+WxcnUXup3Fp6bcYQQtDrMfyb6XRxDBUAl7+5EU2kdF?=
 =?us-ascii?Q?P6A6ENqV4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J7FVoX+iAK3JLd1UEDu8c3ST8LM9xdr4Ez7lX3Qhw0Uv4Q27uuAoWkIXn+/aXlvCWimghnvyjXFlR+2Qd8xrP/OwodNopBEpIcrUqaoOj2AckG3OhOZsIWYDY++A+J7qxQZChDQGoSCZRoLbeeFFufVzpN4H0qur6pc2Kly2iu4F1uuiJVR/fHA6XKKRF/2lEA0Bw2FMLNXhHS89XgFHBUzZxWhJ5qAyTXcL38KnxKoVt9W0DuhrL1KfrCPAI8FYPpzf1baDH3KMw2fkhLg+gatU2nSjYTTiR3u6aY8Qvjowyu6QGlZgjROuAdYMQ3+RsPuLsqz56q7+6vXMASC8VA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584b1aa5-8bb0-4c8b-0f88-08deba2b0cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 06:58:39.3035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5F1ZpaMZTCsnIQD27Zv1/Q/Avy2E6ORIge2jt2xCz03OrwIvzn2c464huae3fIoQtoM27Rv9FDdOgfpoze+QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, May 21, 2026 9:06 PM
>=20
> On Thu, May 21, 2026 at 03:31:46PM +0800, Yi Liu wrote:
>=20
> > Does this hardware behavior satisfy the security expectation you have i=
n
> > mind? Or do you still require that both the DTE bit and the PCI ATS
> > capability be explicitly disabled when a blocking domain is in effect?
>=20
> If the HW rejects translated TLPs then you should be clearing the ATS
> enable bit in the device config space prior to rejecting them
>=20
> But it does seem secure enough as-is.
>=20

yeah we need disable ATS explicitly instead of relying on some implicit
behavior...
