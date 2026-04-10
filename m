Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95BC37A4BC;
	Fri, 10 Apr 2026 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806772; cv=fail; b=twNlKi1hITmSq9aN4MdyyzUkmqwTUESX2/Nrh9/nbyAj6hIFAzV+1uiH5VnwfjSnFU7y/YZT3IpWFd/aMyCY01peClM6i6kO5V+FlFtfG9UhmQprd1E6ohWSP00hUeSDvgnr+eT/umm96CpkwPawCBlUJIolhKWhBK2Hnm8i3+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806772; c=relaxed/simple;
	bh=i0IIMDn4lDQWfV2K84P9DhJKDnLJizTSGujsSI/eru8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kb8AbGCCpAS/3lbs92LXmWgh4N7LC5Muxk6/ZBJW317j3WSFkrKQZ94Cfm72TjW81u0z5m0C5a88dkSFRzMzMqn+tOj9aGhTTYTQC6/jm34XEIdl8H6Ajf/+m4R5VpIIAGq5thCI0Ycf7fFB7qJb2Kgg0pDTxDMUAig/DK45M+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewOw3bGF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewOw3bGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775806771; x=1807342771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i0IIMDn4lDQWfV2K84P9DhJKDnLJizTSGujsSI/eru8=;
  b=ewOw3bGFIIo1c0eTH6HJegt8LSesQLsMe7FbJbATQDhm3nwYpdWCzZfk
   dcmLxSD0SVmYqmgW++m7cvs/C2yxlhEdx0VYIxL1KhRSRQ2k/qWDqtgC2
   KfL+2YLjnT6pmyaJ5BV9lARC04xUWkox+1hKTZ8Y99rZeyDRBDNfl3WqR
   /oGOjca7WjQBoFAolGhbzILvjggHbhL0P/uqccbvjo+W+OeR2/RQPvQdu
   0k3thHBf6GsEoAstleAmylJuL80NIaJprSFRbk3xM6YVZbNi/n6KR5Fzt
   KlAOiSF/gFbL8gwhIkNfq6St32U0Hv7gdaH+I+/G1ULG+hPn3jfNExip5
   A==;
X-CSE-ConnectionGUID: 0+XAm0XvRoOx4MlfGJP5rQ==
X-CSE-MsgGUID: u42DvEGTQn+sdTq+gfcpCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76943810"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76943810"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:39:30 -0700
X-CSE-ConnectionGUID: k6zXFFqKR0uXSE/lfN5XWw==
X-CSE-MsgGUID: YA6FqYd5RM+kGLUz89ZA9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="222518399"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:39:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 00:39:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 00:39:29 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 00:39:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L23V13OXdbQflEwWrTZH5lOBdR4XHb0sRWeVeouVH5IfaWyjGQiThVuAl/MtW3hj5Hmd6eioYB8c1eb2OTpYsY8y9j1ISdBYw6k/fZtBhy5UO45JtUu71hsN8rdPJyjhCarKj3tenLpSXscppaqjAazCPYqw3XZMUqT9+5fEwOX0zpy5DIw80QNixCKdIuBXpCof/D2GDKjIXDQc4G0lWDyXppvOX3xb/2W6noL+VR0YRa0LXQA0KROCrj7aiCKLkLNBkoy1msIbTia+MBBqYtpWeD5EcuU9PPzJ8r6DhOsfbMt1qYbEc26eixF9sUlTb0TZ/xIs7eARX8EfjlY4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0IIMDn4lDQWfV2K84P9DhJKDnLJizTSGujsSI/eru8=;
 b=OrYbAgUL70bUOtncXslKwy0axsB5TmS3lg7sDf6TK/rQo1xYG5glK+I418159iii48Q4a6/Wsqi4RyEzZv3Jz04dcI9ReJu+ZPhMgKMPQnNG8jEdfvBvepR12JEL004O0epoIq7Tm5yzMW0T594bapmqf4xjrTXiD2L31HftCIN0n0tsuRvJtkTrwZ2DAX3flhgnIVgbg1G2WbzJj6jI1P62JKRzdYdFn8GG68dHpcSIFOW2+6blRyn08zYXqejG/Osjwe5iUfXwlN8EruWygvm2gdF8x8q+HXEDMCK4TgapSl+1+SAqMQs14P5goe9/w6qt3XUSA1GDcUlYhZNzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7871.namprd11.prod.outlook.com (2603:10b6:208:3f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 07:39:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 07:39:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Samiullah Khawaja <skhawaja@google.com>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: RE: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Thread-Topic: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Thread-Index: AQHctkK1dv4ps/vKUE+CojHzX1Q1QrWz5inQgADHk4CAACzGAIAAUyTQgAACJgCAB6OBgIAbOWMw
Date: Fri, 10 Apr 2026 07:39:26 +0000
Message-ID: <BN9PR11MB5276908B840B7ED348863A868C592@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52763AB181F5213FAAB4F4F08C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abr8aS/MDU9aeKu9@Asurada-Nvidia> <absaKimeI_TXXxuu@google.com>
 <BN9PR11MB5276467C1933E19E98277D378C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abtphBuLiXxSxmAy@Asurada-Nvidia> <20260323235105.GV7340@nvidia.com>
In-Reply-To: <20260323235105.GV7340@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7871:EE_
x-ms-office365-filtering-correlation-id: 9d2fa823-6e22-4e97-5107-08de96d44ab7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 60ma6XZRnymsz5fK4vQbJRY80sPLutMq42Zwb6byloWknhEg8YhhFD5BYC+JEDtQtj0GbZpPWpU/+xrMmKyueKgErMbq0s1sP+HZh49CwLp9SjbrycVAD0XkKDjTABEzin0kqKbBG9MMYgYqpNNmq6cW5vgqMmIuYEDg9/mgPjhw1zlYfxdP3sjLETLUZl7qTICvU2aTc3PQIshPkO8z3P5tX5+FFp1YLyShu9Fr4gryyloCaIKuuca9fiAa2er2uHfevrcLkGDB2q+cLNdjU9Tkex882b+oXHmOHHgOApgvLGclCOVliDL4sgzAmMcfAI82/K3gJfOVfpZhHWYmPAmujtQRghT1HWaVUVG03MqtGH4HMDkCwJY9nNhyYsoW4m3S/YK3Su4hThzLAcrDWUH24pcQuwgXna7q9+7zZJstQzDhLz7PlACKGKzPetRrC7+X2xJNW5QC8HRcyFn+lf6gSoMDpWEpR5TQ11DkxcCmV8j/hKwzegSWFz3JkZk+OVQ7olMPMvTSeaRtGYXDshyU7+WkG9vgdiKTwJ0iLjba6bo4V7/SLDCfhxtdQXtlUociOglVzAZqjCKfdgY5bUs3XzTa8sOuHyuVV43P75Mv0fc5geeS5cvLd16KTPdmM2KJo0/Zuc3UEaVPXOK/FlFJnuAt4SznbunzoG74QU+9hMXDwCNasheLR7t/P49/I+jYwB2AmgVT5uP3zGkDnX2mlJ6pfwsIimPXxcbLjqxau/G73k1Z+Rey3D5QY35b5Vtfq5+QDMC5aqhSYK4Kl7c8jpVnrbnl9EzXTLvRzZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9XyLN0ywZsakbY/TZlHsoTn9m17O13EvRZFpLPn2xkQd0c0pyYWFOHUjof0k?=
 =?us-ascii?Q?wzKAIZWHWtb6t53u8iILtFCUZWiihYgF7rMZ7aLxR38I/hbxILl7LyWE1sL3?=
 =?us-ascii?Q?SSO7ew3aFawUIJj7lUKnx1QCH4kso40CoeJzzKysZub3kMrKXAf80V+1ymRx?=
 =?us-ascii?Q?ssoL0RRRmqPC+/ahq6nawlKY28zPC8gE6SNt9oTTmNqp3XFNQBi3CLHDUsW4?=
 =?us-ascii?Q?rFejpuxbeu1n3Pn/Fb/mPHLjE/qzCdi3F+7ThOz+qLbWnJQZNq9kI45b7ZnL?=
 =?us-ascii?Q?I0FYf2w9CEXHtvwjNp7OduUx6m9p8wJTxXQW/irpXuLTsHn/fRJQXrZwQkM9?=
 =?us-ascii?Q?Da3t+YMJfl9wtQ1q6lxANWU28UdAjFOt3vJm4ia/8ltP4NsbX8P1sgI2dE+i?=
 =?us-ascii?Q?HONOUieD5k5b1mtZmDFIBEVtBhw1qWk4UMF3fP5mQgcQ+ZlyufU8YQVFo1lk?=
 =?us-ascii?Q?KVIsPICNlrQNcVwcOQ4Cf/mEnYyXRuBKXZhioZPcXkSYmb0VtXBIwLhgNYyx?=
 =?us-ascii?Q?5UbHwEyQkgY1GWk07QopvGt6zWp/M+7/Y/TLPiAPRe8ceeHdNrjNNlSHmNC6?=
 =?us-ascii?Q?DoRYD/IYeu86Q59lR3RWgRBAHkJ2Hyhzrze+wJK4VgWVNmrSqaZARiC/Ewbv?=
 =?us-ascii?Q?sM5hOCfwGwtrp1kFgsARRE/k0q9IP3GxncJdmwz1uk/5tbJ6AI4Zfq4HQl3U?=
 =?us-ascii?Q?UPZNfBSZHI22JSjEkzJ7oPnwfS/hRVFEmRvbHLPIlvLGWTevohXZbGgVvb83?=
 =?us-ascii?Q?0r/qKKejmxpY0mtyfOD0irA8wQr3nS2Hf4le+feXX5Vus2rXI28lBZfdO0ZC?=
 =?us-ascii?Q?LJNzt4YbX8+rc00fbqX6FoM26vdr/mpIJbb0RaznfN170hzdgjYV1kAmG3f9?=
 =?us-ascii?Q?sq//nIF71+kAbeRawIbZHwKu1onMtLuHSp7t8J/fJXABe2afHf9IOms5jHMm?=
 =?us-ascii?Q?R0a4dZcgbktJr+NkRMnvA7oKUiDLVZehuBUOyX0vIIbBceEKq7p4j4GYy6/d?=
 =?us-ascii?Q?Jhg9/171qfC/PdGkaK86VULzpVAjc/oDXxrlGZk17yiw9eqihDQl3x0k/xM6?=
 =?us-ascii?Q?hZ/Byb38/MjP0oB7Pjt2o5AP75qbc92stc2kCd6eWNwtUEgEMpdpm7abOdxV?=
 =?us-ascii?Q?24YprGLgE68vr0AuZ87EddzwW+zwRuyZ/Yy8f/28q4XyJw17ILt76PiBh6NZ?=
 =?us-ascii?Q?0k8oopanYOozhn2VLf66dsPy5hN/ejSy7ca0EmVdIWvHIby6Pr6yi/WQOpP1?=
 =?us-ascii?Q?v+8Zds2lqNOnMNFWKik1E6MLGMy5654+UIR6C36kw8bdNK29+lttLBDemKTL?=
 =?us-ascii?Q?HNEwjvdVVIBjeIOnqFNFW5LyS2gEPnUYYimU1Mulxc5dMlHohPEaUr/C5TIU?=
 =?us-ascii?Q?h4s1Vacj4yg2HYJp1boNPQ/QoUT3QubO9zGo2O1C0nSVKKNof7kdP4VEUn2S?=
 =?us-ascii?Q?zWBAnoXangDz9W9QGQHMvGCRNGCs0jMXPp6bwHk4k0CfThZgOuxC0F4BZHyQ?=
 =?us-ascii?Q?T+VDvXQKAvixDjB80kxYH8AIKWDee/zZoXuGWYZ2TLN3n4UoeqhPUcvPOYCQ?=
 =?us-ascii?Q?IRQqL57D2/muaoIvtah1YYimv6kjXFuoly/5yOoOU5ny09grnFtf8caiqZyT?=
 =?us-ascii?Q?zayn38lfMdPaGmrHCNk7UjDAKlXQol9pHRJiz/C+5NO7oTWpL0cxekgHhe5m?=
 =?us-ascii?Q?PBMpPpsdoohBtuvKvza4ha+fSoc0g6VAS7QaTZyvmD34ptQb+ekICVZfRB0E?=
 =?us-ascii?Q?0KCp4HwmEg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FFfJdhhHoMZWe97b6o71ZYGN8FJgwzoV2wH7lTYLy0RYSlNDqvfEp8NSmbV0yzrLtgGmhQmafPvUG1q0eT5pG4G+xdOYlaBqV33KOK52ycBiZDZKSBUNNBhhVuYGWAp8TrdJSirE9DtSpXASBKiK5RhT90p6HcgVhjHoYzs86etqxHZloeRL0JdUFh3esUthzYoPUczmpbIXigqF+vt+E7KFG6SopU21EHmYoEkmL14W2XZ+XUTlS/aEdmguYJBampiJY+o36vFpJ18kNccS3whXXQDgtRtHRmXbmaUPfCV04LSyAOMJW0+pa4vFMpzzkMHb0mRjmfufV6KQqcwHYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2fa823-6e22-4e97-5107-08de96d44ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 07:39:26.3919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbCxCoD8JDS3PGwyFkoFXOfKCtWyC0qddwp2hSBKmsMB+vsOJ9GA5NHOWKzR1MqZKcQwVtbDxw7YXS4+Hksz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7871
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 24, 2026 7:51 AM
>=20
> On Wed, Mar 18, 2026 at 08:12:04PM -0700, Nicolin Chen wrote:
> > > > VT-d is able to find out the SID of the device for which the device=
 TLB
> > > > invalidation timed-out occured by using the SID reported in the
> > > > "Invalidation Queue Error Record Register" (VT-d Specs 11.4.9.9).
> > >
> > > yes. but when there are multiple submissions (each with a wait descri=
ptor)
> > > fetched/handled by the hw and then an invalidation timeout comes, all
> > > pending wait descriptors will be aborted (not just the one correspond=
ing
> > > to the timeout). In this case all affected submitters need to re-try.
> >
> > This sounds similar to SMMU then.
>=20
> Not entirely.. smmu HW stops processing at a SYNC and waits for
> everything pending to complete, then goes on forward. If there is a HW
> reported ATC timeout then it is contained to the SYNC that followed
> the ATC invalidation. The errored sync is skipped and whatever follows
> continues forward, so it doesn't contaminate future work.
>=20
> VT-d's wait descriptor with fence FN=3D1 sounds identical???

yes

>=20
> I guess if FN=3D0 then things start to become indeterminate what the
> wait actually waits for..
>=20

Currently we use FN=3D0, so all pending works before head pointer will be
re-submitted. It has a larger impact compared to FN=3D1 when a timeout
happens, but allows more parallel work in hardware at other times.
