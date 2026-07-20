Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00C3AEF3F;
	Mon, 20 Jul 2026 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563165; cv=fail; b=Ks8TAEa3bfzwCbuMvvEnau04u8TW17v7H+OzQ+n9qgDFQsEDsodHzTyS2wPmCKiL90A6ZmUONItF+Dchl9Gz+tMplmSWHnbvZ3qhVXpg/IBkvkKv71QfejpvcW3tkzc/sQGKszeAXL6FcIetBceCkYQVLBhVxkIuyI3V+AWzv5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563165; c=relaxed/simple;
	bh=3lBShHa9Ahlt7uF5tngeQKWAsOx6R9Tg1+jBiMQITMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MM+dQb9JjAkEs1d97ccvPxZ6nGYKCdWkf33nnEQX1dexja/1bPIRExroDR4ULdcHAITrrYujZfRv4ooJR3T7NgHt6fXRNUVGiBwo/sEVtwJF8qkeZPT6tdhI+V7sfwhGjNH+prjIwgjchFd0DK/Fi47/rskrbmkqxTiaiGK5UJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPv94XOC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPv94XOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784563163; x=1816099163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3lBShHa9Ahlt7uF5tngeQKWAsOx6R9Tg1+jBiMQITMI=;
  b=SPv94XOCZnYBKokB+i5YAiqkoIVNRR7bMYl7WWl4lyTOqFR1401OMDx4
   4431yJzwmB+N0Ou54ZGwtlqTJak2yQUAN99FI0zI1VmwRao8VG79gcCcL
   Uvd8djL1JqAKDOltY5IyRpPqVJ0U1NRavquOkQOGBEfM/ndKEGh1jvnAR
   qaAwkaZ0oavIDVhi5a6TkjzmCDFLjvDtzRNaTVp2XMINxnJyymsBCXYEw
   XIBZ6aX0MMAj2x71Iaivi0muigAXfnSciIzt6Rv9j5eQwIXAAiv7WPMtK
   3tHaOaPdAgQd2wV/d5HwIMg9XU4Sv0EIuWBfmswWHSuAErIQVyJ+hjuYe
   g==;
X-CSE-ConnectionGUID: pRxp/HSnR9a12DT1PAJVcw==
X-CSE-MsgGUID: 0uj1r0b1QTW9XIlorU7v3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85348015"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85348015"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 08:59:23 -0700
X-CSE-ConnectionGUID: J+ejoi46TZOMAfksJuNLQQ==
X-CSE-MsgGUID: odH+faZhR7yvd2Vinpq3Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="261292181"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 08:59:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 08:59:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 08:59:22 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 08:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4FvM5uJ5W4hBAoNLgW0zN1l6Xhsi5DCVdvAwdD5CdGFYPoNIgYiwKAlFQvpwDcLOnetK5psvXV5pngTT/WNQGSq0T0Btfzwkx9k7upq4H71zFrUj5j5J6IAS36Yua4ZtTpoQGRdvS6lEhZQq5DCDgmEPx8oIRMxkVaqvI0F7wBnlAjO1xfdWLmGYH7bLeX8eF26XS3++yikGjqrcNI0/7ENocKZ6gsQr1xp5N+N1FoMb0nB1sM79k2jRuaftiHkPn6zFNUvMjaIhGZKTAd7wGw1jqyVBT1tGgEGBxbGnegXG7OrAAvmaX/I8APqRrZ/kFJCTKcx6eae38bKSy357g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lBShHa9Ahlt7uF5tngeQKWAsOx6R9Tg1+jBiMQITMI=;
 b=KgQmhVW0j3ENmaF2kfzcRaynlCW8poeTh3tNzGR2vXr7E42C+wrQEo3Y5zd9dNvX7hbzv0eV+dboej414I97pjlcXVo334i0JM22YbrWoajufLThzU67MOoO9Sr1prAQgNdbwadwQCTnDIhKEYnqVnjFQdFPaUgxBiWUJQEbBi/Dj4OLk0PvsDgW/bc6h0hbtrqVsC3nFBNGKIOpd7+w500cAWf0PwObTV38yWYCpqzE62ihPBR3WkpBfoso6ToIKR8ggEDz4y03HR8sHwLeLK0VhOnK16+vRdEaiJGAkfhjRVhfaAwoy4syp0XoMq9Lpd2InwBe8PX07j3p7a/Wlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:59:11 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:59:09 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Bhat, Jay" <jay.bhat@intel.com>, "Barrera,
 Ivan D" <ivan.d.barrera@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "decot@google.com" <decot@google.com>,
	"willemb@google.com" <willemb@google.com>, "sheenamo@google.com"
	<sheenamo@google.com>, "lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 1/2] idpf: remove
 conditional MBX deinit from idpf_vc_core_deinit()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 1/2] idpf: remove
 conditional MBX deinit from idpf_vc_core_deinit()
Thread-Index: AQHdCObbBw7yiHoajU2zUrnrjidperZ2r25A
Date: Mon, 20 Jul 2026 15:59:09 +0000
Message-ID: <SJ1PR11MB62973BB5960791B4F8E8AF319BC32@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260630231854.11536-1-emil.s.tantilov@intel.com>
 <20260630231854.11536-2-emil.s.tantilov@intel.com>
In-Reply-To: <20260630231854.11536-2-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DM4PR11MB8204:EE_
x-ms-office365-filtering-correlation-id: f6b11767-bb84-4510-ae39-08dee677d5a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|11063799006|10067099003|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: BgF/OWCEw0os2dYjxsYFfUWFphQaCpHwKtGfi0SVfl4REFZl3OHYJoE0gFeG2X5lu/B30eKrIBXsd39mMYsgPx9iEa8eYvJePTP/+BbhmzoGsJiGlO7KSfnKKoIZtem3Cjr4/fiKcltp9gm/VsU73ApSmn2oD+h3gSw6ssg4aA6oT61KqVbhmt7klNlKjE0Z1G6s3dPn8jcRb2tv2LScuC63PDqFyigVmFGW/3qLVuHzWjGTPMwgUvmhu6xwdWKjUmTcr/NYLjEr+aLB1dgCCRYB9OaxCxUf7/oE613fsMw7P7lW2SPqOnI85ZK9vjAzI7Zc98kWgi5g8zIVQY0urFy7IUreyL5gtX+J25FxM1IhSEy11TWbkqd0KaTGA4Z/5psM8sz7MlNbIASbvxGtSUkjFHqZOqUeQ9OA0fhUA2huUygU30TBzGs12/iCF3PDPQ3kCBrn4Mx1X7377LNikR0qcYkXd1pYecKyDixfaNGxcMXaBQdTonWO1x7yL+5b9AIOs88oUSmTCfpq/x175R56NOgEvb5Re2VNVBvZADoCvGTJeDVg4vZ8CCw0gZ6wlI5Y3fQuY2ctGxlgzejOMXnct2Pim0fiP6mf4O6qFZYZXUx/Fas52nUxQto+964HuFODJrM+kRJv7RyVuuXUufI05G/k5UaA7yEZWUB64iLw+SZziIiyiUS8VKASkwrGgUnt9Aa9hvgS1m//HyRy5UyuaC8aflkleW9tjjuPnAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WDzkfZtl5dIqUQgO5hvuFv0kpQIRuglYiiyCgRrXeXYXVSyubR2b0m+xZknu?=
 =?us-ascii?Q?jfow+KGkB3/CedqU9BHmKZmDjy6ZX22w/2AfumA3vFHjU4cgFqa6ugoKxE2w?=
 =?us-ascii?Q?AEYbgDfxfugy4/n1jAT/2JdlC2cedgBL3H1yJ50ZUhRitoDU0KGM6WT6tZUi?=
 =?us-ascii?Q?+Fu2+T9ph2K5cf9qog5gzkYydUf/+JAlJD4wr9S+a/FDR+lB7ZQgkQhHGKLz?=
 =?us-ascii?Q?e6KVsiq+k36KvtaLydU4lGMn8MCQSv4sFkkwvZ0Oih7vxEZkj4nzJTZotOqe?=
 =?us-ascii?Q?z7YnVhldDC8a2boJBPN9X+fOM1zd/KSC/shu1l2eZd9doIZ42P5M9PP2t4yU?=
 =?us-ascii?Q?Eze1Im+2fQr7mPVGHU4Cg2RgmDE7yKEkoWBPuoo1ZuAasvfKlwxnUsxemFYe?=
 =?us-ascii?Q?/kkfjNBG79xCAPHgVyt5UkQQOi0nwJ9HW8LMFNRmXaIqzlz+mou5GKXNMlno?=
 =?us-ascii?Q?pdgz8BE8lfBpjOf0QLrIl2DTym2iK5IcUp95nT+3jFrsdZJIGOn72q9MTfBz?=
 =?us-ascii?Q?HMTrjVF707+7VzCa4z1ViDeep8WBSqoxAXFHPRIseMrEyuA2+nws4OrQTUcc?=
 =?us-ascii?Q?fhfrFRqkMGp+VUzhTotH0fPqNYxJJZjqEPXG4fKPSd7YnzJ3Yi25g6+dY9mk?=
 =?us-ascii?Q?6Bus4JU+IEPuwZVoMYQpWtQxqiZavx1VwbCfbhPXfyhWKP5SWUjDuO2p/BK5?=
 =?us-ascii?Q?YdF3fM4ukIx6uPX4Gh2xUgoeWjfxIDzQOWKMxmv64mUx/eL/uzfgXO3Ba8Lr?=
 =?us-ascii?Q?A24gv1ALX7KjDIf48j0JuiHMRMaNFbxLYfbzmXTdTIWkcoQzXjbat0bdSlY9?=
 =?us-ascii?Q?mIt/l92SwsLDQ2EEg3/bTWJzjULnm1mi1y1eMSLehrRvZ7WDMQzeaLVuCNUr?=
 =?us-ascii?Q?KXXHAjae/aufgudGeatvPpjROfTZbJd0eqQTZvEjxgFcPMUiJLDynIFgrIBe?=
 =?us-ascii?Q?dluBUL2Rq8IuxFlcyvWYudqeB4EiCBNptsTEXxWeXx75Apk6Fb5Q0W4FQpai?=
 =?us-ascii?Q?UFE5uvSKjyRKNrh2DTXds6wweH5RwiFtf3hiBR9fsK70BdJzs96gPLgrBFGL?=
 =?us-ascii?Q?j3P4v/HUlpAjX2oOtE40DDvuONno8xxSowN4JY0Tzdx4hlNeatTXCO+mRGHZ?=
 =?us-ascii?Q?cEpPTt9skFIjm12fuWhSrI0mhClMD5dvEW5/kYYiXUxA3KmFAuqZ2Bk8VjRa?=
 =?us-ascii?Q?IBzpPFgY4cMka9zJtRn8UeUEIOG9c4Hm6V2UV2ILiciH51yI5h9Byb4bSykR?=
 =?us-ascii?Q?3aW7ST5OqDDVDY9uZWCT+SiWec9XGh3wu/DOF6rrCqofKptZOnUP/lK+GZ2p?=
 =?us-ascii?Q?tVr0PlRy55no8Yls3mRr11XysGz/cJoQ3u26DOkqO2mNq9xcj0can0MyTy2+?=
 =?us-ascii?Q?jamBwAIZhDIE1WRIVlMcX7xZmUKLIdZvVUPgqSKLxz0scMLWDTqfle3qZRj+?=
 =?us-ascii?Q?EA961Rf6gk4XcQdC7v9JaSr6e/Qh51WLWjx7xdxBei+gfTKDSbTMKIR8xfaa?=
 =?us-ascii?Q?maLXdqknq4GOFYj95V5Yl6hKbfwsj1WgcH3vbB4JxMgjEkBMS6zAZltPjP2J?=
 =?us-ascii?Q?6kYZJOAu+8P5DZzSmVxAIBKXUTCvkuhpfVTCKih7cILMTGHDHb/mV62wtK9Y?=
 =?us-ascii?Q?mtUcLd13Bd+JUUDBc8rKnFLfuXoyf0IHak6CdgPFyrRQyBu5RjUyYfBou6Cx?=
 =?us-ascii?Q?UjX0voQi91rdyZFAq4PdVoQuSPjGlxqllBPowBdgICgWvT6aB6ZruVMy0M7L?=
 =?us-ascii?Q?xRLGoDCkjg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cEWOgPusqeWteq0PatnXPjgmscqSuNpIQvXH2bGNMxeXX0oHIVCr2nI4h3qPa3Ctd8CiEIXIOQKy4QcEvCZohma6H4wn8gDEFDI1m64YIYVv1YocOQh6RwssQauL5kSSkEeSZuF3sHYEG4cobvx+1l3BQFt9Q8TmBFZUcQEFiBMAE73Qjmju9lXQ2av+XJNOaQ6HoQJxOzb0FFr5dTqk55lI7xOexsEKn2MJwuLAjMWsmF90JftydGLp7RphiUiH4NRR1g3Vl83mDdLxF0cqzHfkQmtc3S8WRHYSy/Lgz9b+syxx4IgKcxrwt6AHiyVGhyj9LH2Fio+iu1208ti5ZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b11767-bb84-4510-ae39-08dee677d5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 15:59:09.1965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXXyO/Hm2a76F0zoyD9XfBYbcci22ZqOm9S0aJep3L/XoxJuRJLDcFCtkliviwL6da6Cvf1ihTc6pkHeuYuP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Emil Tantilov
> Sent: Tuesday, June 30, 2026 4:19 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Bhat, Jay <jay.bhat@intel.com>; Barrera,
> Ivan D <ivan.d.barrera@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> linux-pci@vger.kernel.org; Chittim, Madhu <madhu.chittim@intel.com>;
> decot@google.com; willemb@google.com; sheenamo@google.com;
> lukas@wunner.de
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/2] idpf: remove condition=
al
> MBX deinit from idpf_vc_core_deinit()
>=20
> Previously it was assumed that idpf_vc_core_deinit() is always being call=
ed
> during reset handling, where the MBX is disabled by the reset, with remov=
e
> being the exception. Ideally the driver needs to communicate the changes =
to
> FW in all instances where the MBX is not already disabled.
> Remove the remove_in_prog check from idpf_vc_core_deinit() as the MBX
> was already disabled while handling the reset via libie_ctlq_xn_shutdown(=
) in
> the service task. This is also needed by the following patch, introducing=
 PCI
> callbacks support, specifically in the case where FLR is being triggered =
by a
> user, in which case, the driver still has the ability to notify FW before=
 the reset
> happens.
>=20
> Add call to libie_ctlq_xn_shutdown() in idpf_shutdown() to avoid a possib=
le
> regression where long timeouts can happen on shutdown when FW is down.
>=20
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Jay Bhat <jay.bhat@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> 2.37.3

Tested-by: Samuel Salin <Samuel.salin@intel.com>
