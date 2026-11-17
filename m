Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794946602;
	b=fyU8lW/4sz016xPXn11elUvLrKh5xnfLa+UL9GupAhZnG5wPyez2jEozE4T6n/eYVtm7
	 uLtNjfqFp0CH71Rtgc2bEUhG8xJ5LB61kr/OamQAJC5LM1cNe0IFNkkx0Cd9AegD86zZz
	 bWJi0Ri6vpN2eaQcGHVcDPdKHMH66T3N7wi/K4I9PRHvr5GB5ndDdHv5ct6xFn+dhByc/
	 iOkv9+SE2Tk5GDrvHNdbQLgAt/bytecaeWHNe4B4rq3Xsy00w9aeBKuCQK2iROOYH5YI7
	 R3QOlDBCii5ZRMqSLvzVFQzJ/vHJtxL1VSoPFGts+Oo9nCjyg3rjq0NgRKUI3WhRJFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946602;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=XC/RG37JEgvhCADMur/DNxnc9fBCU37/ehDfLgVMu5U=;
	b=HPL8xvkwTQKpdcO9WBG+Me52iIbLkKZe9KSCIQD6T6dChqtYc/dsa2QSJNq64+jZMHxV
	 //8CLQ3ytj3FzeqazYJVjHdHALkuG73jDeR7CT52FC6BPu6p0ytDj1lf7sA5zJGRUUK69
	 OLR1gaQvjHhUZTvizaI75SDj0h1OAcUpZG7cuM2kmnJA0kNzXYVOoXZiN3yzSzlUjIzbn
	 LuuKF+LGfOtAJe5PSOAoxuYHfbiCtfYWpqNTOHXOgQnhODDS/14eYALV7TFoQSnE73CqV
	 0Vd8rNTYhtNl2y3OHiKakdiD4F1Mov6diXtDnqto7fIVWniKIRj6RWv+MIIs+hQjamA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EVnEBmcv;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VLItk12t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0CB606A31C;
	Tue, 17 Nov 2026 20:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA0CB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EVnEBmcv;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VLItk12t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794946600; x=1826482600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XC/RG37JEgvhCADMur/DNxnc9fBCU37/ehDfLgVMu5U=;
  b=EVnEBmcvzIBhEaw1GyZB9JqVJilcN3+aoZGsWj0AUDAJz8gHgmxfjkEO
   xBHCaGzEOTQeFUKDUihwDialkXBSCw3cy7KTinR7xf791aIZW1lqfSIEV
   QkLvoeLIyu7HRNKWRyBk3vA+TU7uMI9uX0V+eUY5Dg+f0eVi4YuxiCgPp
   LqWtp0fY0CN/vc6tjQJ+X6K3of3cm4u4aT62BPcwiBc+X5p5UfBISpJbx
   VWGUrgshxSrR2h4qgVz3bTvGlmNbVU3lk/tmgttDf2sIuNcdg1J8yy0CY
   Kw/9sqfILBljHY5GtCUFQIlSeUNHrJ6RMtQnMUfjQApP9YK2um05d7sJo
   A==;
X-CSE-ConnectionGUID: dj8sMlA3SjeAE9Wyl6+Elw==
X-CSE-MsgGUID: cE5V6mISRNyEMAPTIb8Vyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3746288"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3746288"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 12:16:39 -0800
X-CSE-ConnectionGUID: UGJBknSKSSmIDnV3BL6+Bw==
X-CSE-MsgGUID: qgvdqDUDQfSG8S3cZ91dZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9708854"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 12:16:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 12:16:38 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 12:16:38 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 12:16:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVKNLARl6/aeA0kBgGbM9yn87LG1DRnPHb1SVSoMJSL+SI+oJqqbXLpEPaD9AVVo6ojD55l4Rcxd7YuawjFwmKayRJ8jNJtJ5fB40aTU2L09O2QJJPTZcXg3Nb2Zw1rvF75MlDTFqqZamCpr0fBQ+/YiSpZfAcAJeYiyDVPzgchQdwuyUNOi4dQlgG1FAXIU4peanzVT1V1mrBTixJwQEGU8aZy5tqwzC3+QCGaQt10RRjToKJ+vEnHtyksfW/g//Mb0hL54LYeQMililNF16zrlBm6V5JfwFW8JOAQL1CoinJF3wLkq4KPHGxR1/cQJmxYiZ48HWTF7LeihCXMdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XC/RG37JEgvhCADMur/DNxnc9fBCU37/ehDfLgVMu5U=;
 b=htMlsVhsAGDwx8OJ1A3ZpSdTqEssggYDoG9Py00yq6zw0TDuQHpE3cT1pU+ggXdthdgepNF7t7vNfXXmpQT8r872y4y4orrGtSQeVIAprmDGVeWkRbymWRP7aWxr9RFMqAm53tAiNsbASWugvYlYQ+MqoIlnmYOL4FawX7WJdEIhttoLRDXIBTaJF2IX7boKYfQYK4FcMGixiP5D3yAmNQCVGFOAajgsoI/k7QmfLlInhI07YvgCie6dQDSjugf57QFajXXaA79ITLHe4kr4A1e8ZHdRpSpVD53Yai2YKENl8e5lvRX+kqzJQ03hJEYYhm8RoSj3UfL7uzPlDocMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC/RG37JEgvhCADMur/DNxnc9fBCU37/ehDfLgVMu5U=;
 b=VLItk12t5kLdl3sVFvfw9CdRZYdY1Enxo3OnsKOWkhjnSfLQC4UnF6iGWZ2iN6q6POLtda5L7j/J3rdivcvU4vlRW5ScLZw7jpdfT2/Ir5rhZsRh2xf1sfGlGzcZwHE8GpietGQs7CQ1u2rpNN/Xoum37wUAoBiDp+sTnDmmuko=
Received: from CH8PR11MB403433.namprd11.prod.outlook.com
 (2603:10b6:610:32f::10) by SN7PR11MB8264.namprd11.prod.outlook.com
 (2603:10b6:806:26c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.12; Tue, 17 Nov
 2026 20:14:34 +0000
Received: from CH8PR11MB403433.namprd11.prod.outlook.com
 ([fe80::b087:96e4:50ea:b5de]) by CH8PR11MB403433.namprd11.prod.outlook.com
 ([fe80::b087:96e4:50ea:b5de%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 20:14:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rob
 Herring" <robh@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kw@linux.com>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/13] i82875p_edac: Convert to
 pci_assign_unassigned_bus_resources()
Thread-Topic: [PATCH 06/13] i82875p_edac: Convert to
 pci_assign_unassigned_bus_resources()
Thread-Index: AQHddd61ATuwfIOwQEq5go6vW/VTGbcw1cOAgAAYbsCAAcEagIAABRlA
Date: Tue, 17 Nov 2026 20:14:33 +0000
Message-ID: <CH8PR11MB403433E7312691DB4FBC415F2FFC7B2@CH8PR11MB403433.namprd11.prod.outlook.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
 <20261116154005.GAavsj1a11BRgBVtSd@fat_crate.local>
 <CH8PR11MB403433B2B6C13E8AA2A31130FAFC7C2@CH8PR11MB403433.namprd11.prod.outlook.com>
 <20261117195455.GEavyxDycsQbYSctQr@fat_crate.local>
In-Reply-To: <20261117195455.GEavyxDycsQbYSctQr@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR11MB403433:EE_|SN7PR11MB8264:EE_
x-ms-office365-filtering-correlation-id: 8f0e6e71-0cb6-4ba4-1f02-08df44e76572
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|18002099003|22082099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|10067099003|56012099006|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: cx75NKLMqqdbhDYr1L6byoZEZ1GVzmMReYYiGk9DnYLThaogF1is0mrkj1UrLq8ctqbp4+hghqzAZyk91+jZyvZV8a34HPAdHNw1HPE8M0Dvm2Ks+zPQOnJ4sWX4b1XUHRqBiAB4jiTvpI9IYYi0wBxoV6O5fMP+N6n5aJ4z/VF4s3OgHKd70mtm/CZnmflgEmWncMFFFqAmndMsnvBnqqKffN1kym26vE59nknd36QB/5TqiUMIRYC7tzvyO8zMzBV6+JkLiH8UdllqpbVRiVm5CozsnqcU7ZVfrHadcUMyXkVFsUcC7LP7QZtt/1mYzVSoTOJfreQEMBmzTf7D38ETLrZNxtPsSLJ3peADajwCgXye4pGYn/ry83QqVZxngThnqY1XE9D59QQWaYPCDWbh/0mHhl2FKl74XiQcpOjj+yHuN8P9SvPkGbdZm+a74tUf3OUPYG7OIrxcrfhalUfCg0YfoeyCrppRVeWb9A1mspAiMXv2KX8J0ArkNo2tt9JiVWQT5yo8pARv7yejufD8Vg574xgBCjcpUj2DMmGSkOrnFxra3fbCJQj700D+HfNn2NMTSmkX10D4A8u5X9YV7GUuNQiIshtjK4YzCnxJ6XcWduruIBSzLwdltKjj6HqEIskBHymww8bOdTU3sLB2if+T0yZHGyE+O+j1oXEtcE3N/cvwLc4fbt+Qi9med5aC1CJKPC/qeIiy6eCdnHD8lC8jfUltz2o96lButKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR11MB403433.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXVRY21HMUJ2Qm1MMjBqcVk2dlp3QXJIaFJBQWtUc2JlcEdaa1d0eThxME1O?=
 =?utf-8?B?bGxEdEdLckx6Unl1UDhZbFlhRTR5bk8yNFdOeUNCYkxkWjlEemljKzVWYW95?=
 =?utf-8?B?cDNzODN1VXI1TmRtOVR0QUJ2YlRzNHlDYit0WjA0UFliRXlaY0l6MzRmSnl6?=
 =?utf-8?B?eHAyWHd0KzNNeXJlZDdCYStNa0x2NjYrZWJ1MHNiZ3ZPR1Rad3RKU3dlbm9j?=
 =?utf-8?B?YklPM3lRY2NIQ2hpYmRxSFh1U2hYTlpUQTNFdVVSYlo0TVJjODVOeFByMXI0?=
 =?utf-8?B?VEhTTVRRd0d4VTNWTE1GQzVObm9pUkc3N1RnTml0emMwZlpWVnpWbmFqZ0V1?=
 =?utf-8?B?WUlYNTNOeDNsYjFsV0Z4SCt4eWpsNUozVmFwempLQUYyYmtKb0dpNWE4Z3ZJ?=
 =?utf-8?B?WDFoK3hpZWtmTWxBaFhoYmo0bTRqVW5qRHRUeXQwVEV5Y0hFdjMrOW1ETGFI?=
 =?utf-8?B?alZiSi9UdVcwemRRRWdGS2d4bUNrUEZybWtvajZCeUNod25BVTQ0MVY4V0cx?=
 =?utf-8?B?MkFtem5TSG5EclZsVjFOWHVweUVIYit4WEoxNnh5VVVnemZzT2VmNlB1dDNi?=
 =?utf-8?B?VGNaZFBGWWNweUdCV3hjcGxnNjZTUHFJSm1vbXNSYUhraVdjbFNscDhUajdX?=
 =?utf-8?B?S0lqY0RSZXJkTDBBZ0hGbUlvUkMwRXN5SnV2VGt6aVpwblFnUmtiQmZIM21i?=
 =?utf-8?B?NWVGMytOcHl2MTRmMWN4Tmt2elEvdGNIc1ErRUU3ekxKaE5UTUJIRE9FNUdv?=
 =?utf-8?B?Q2FiOWI0NWhXWHQ4d0h6U2NvZVAyM1dNNDMwT0JLM3V6ckF1Vjd1Ty9sS1VG?=
 =?utf-8?B?MTNQemRoaGtMM0ZKa2NjOWd2NmVrZXVHb0RwRDFYV1V2T1hlZ0pEQktiVEli?=
 =?utf-8?B?TmdCUGdqT3FpZ2kzRFBPYmxyYUtlNm84Y0pGUEh4eGpPWlNFekFKelNnMkor?=
 =?utf-8?B?eHRnVG9ScVJRQlFPQTNzVzllVEs0OWZMWnBXSUJpK0JBc0VIelJxZFVHTjF0?=
 =?utf-8?B?UUdjanI3NXBSQk1rVk9UR2VIV1h1TTZZQng1VUJSWUpwVWtaK0cvZVZvd3lw?=
 =?utf-8?B?L3FRTTlBNVQ2MHUxTEtTU0xnbXgvMlZSS0E0V0lqVTJhMTdnc3JFVVlwNzY1?=
 =?utf-8?B?YjZLcy9yU3ZsdU5oNDJTWGR5YU9GbFdDUStadDlFb0hoM3ZxVmQyQ1BTbzIz?=
 =?utf-8?B?bG5KT080MXM2ZHB5cDlWT0JRTHlvL016ekpRTWNIbDV1QkVIbld1QW9MeTFO?=
 =?utf-8?B?RUFIK3poOU1Uc1dWVjRCR1JGSkdsOElBVklsOVBTd3dKcTZram1GUytPcGtj?=
 =?utf-8?B?Q211S0lTZlBqTEpoa2x3OWM2azNYNkxZbkgyVk8wK29rYURNODczOEp1allT?=
 =?utf-8?B?R2NxckxGWWlpUFNUY2Jyb2EwUWlzcUh2dUZKMFloWVJIdUNhak5oSWppN1E2?=
 =?utf-8?B?cHpjL2g5WUV5Y1lTc3BGeHhpSnV3QzFYN1BYM0tvbE5PeFZ4UEs2NTloNjho?=
 =?utf-8?B?bTZZUUlaVDlMeWtjNHh3NEs5SGYvWjMrUmU3aERCV2crSTlFejlsZmh4TmRJ?=
 =?utf-8?B?NVlBMkxkdjl4L0c3VVpFY1pCRVRseUVjdHhOS2hIaC80NGFvMUx5dWFwbG8w?=
 =?utf-8?B?akZzallyS0tBZnlpMFVnT25xaGZJbUJMSGVwUW1zMTF6bzNjdENZUG5vVFl3?=
 =?utf-8?B?U3FRM0NEeGJvMlA1RE5IT0FjaTVrSnN0SDJxMzZabldlNjZLUHQ2a3hCUnRl?=
 =?utf-8?B?MmNDU3VvRkZMZFRsVTdZYXo3QmpTVUtLamVNQ3ZkU0owR3UwV1FYTmlyUmQw?=
 =?utf-8?B?VUJhWEprRWFmWkR5Mk5xaXRBUjNiSmMvM05haEhqdlliNWk5OEs1OWhKTVY3?=
 =?utf-8?B?Sk9MOVJ1SVRLL0JvT1dQdUlYbmJ4M3dScHFQOWpQQXM1TFNzc2tpRi80eEt1?=
 =?utf-8?B?ZXBFblRXVHZGUTlnMVpIZ3NSaUdoKzhTRGxiVU5weFJRM1lEMEVUSjZQZUpJ?=
 =?utf-8?B?ZysveXNDeDcrOU5DWXVQYzM3a1J4SVFFN3dvV09TYjB3c0ZNWXlFNHg4MFZK?=
 =?utf-8?B?R2RhZWZYMXBDRVg5OFZiaWVCTkRGNDNxRUl1dGtHOGFObUVWelFZNVU2aWhz?=
 =?utf-8?B?OFZsS240azFpaFI3S1VUZE04OFkwTjROWjNMTGNGRFdlY1VlSGJScGJ1Nm4v?=
 =?utf-8?B?bzlwSDdRbFZDVjgxRE5DeWxSNFpacDh0UTZiUW5EaG1scmwzVzIxdzl5K3li?=
 =?utf-8?B?WUVwRmZ4R3NBYyt1RUI4eHdlQUZ4UEdsNXFyT0hSM2N0NGhJVklEWEd6bXBt?=
 =?utf-8?Q?X/zg69fKkRn3S7xesB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ql1GiLftidPhc7H80nILRjvW9TcrTK31XVKTO0PvLiwpMBP4yF2DSTcGKFuGSGB3LSzDGAKruzbyxjgPi6Ueg7Hf4cYxHdVZNasKv4a/CRylWPWcnEqZnwL9gxNoH7o4yfMxkO71Rb5YsGyyOJR3nNrGzaSWWonwWrFQVduE64o/2n72upewmP7qXZzE999QZiqc5fKE3P69ss/roxUfUyTTbdpRyIIJISk7sBWVkiPz4jBxqzrgKmXVDhJuSCUKc4tR9/dZ3hWOQYyrzU2OCqg7EZulMSXwaXrpxvThoJT/Sr/qkND+dpyXd/3oh8VSZwqwFis8fkSlKVZSSyEE2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH8PR11MB403433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0e6e71-0cb6-4ba4-1f02-08df44e76572
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 20:14:33.9592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8g302qe48wKlofflgmu3Xq00cGvYJedXj4OjyTmqcICxi0MpDQaB3j8bTp26vbIO5Qd7oCP4oL8WNik3SYbPPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8264
X-OriginatorOrg: intel.com

PiBUaGlzIHJlbW92ZXMgYSBidW5jaCBvZiBsaW5lcyBpbiB0aGUgTUFJTlRBSU5FUlMgZmlsZSB3
aGlsZSBoYXZpbmcgdGhlDQo+IHNhbWUgcmVzdWx0OiB1bmlmeSBvcnBoYW5lZCBFREFDIGRyaXZl
cnMgd2hpY2ggYXJlIG5vdCBnb2luZyB0byByZWNlaXZlDQo+IGFueSBtb3JlIGZpeGVzIGR1ZSB0
byBsYWNrIG9mIGhhcmR3YXJlLCBhZ2Ugb2YgdGhlIGhhcmR3YXJlIHN1cHBvcnRlZA0KPiBhbmQg
Z2VuZXJhbCBsYWNrIG9mIHVzZS4NCj4NCj4gVGhpcyBpcyBhbHNvIGFkZGluZyBkcml2ZXJzL2Vk
YWMvaTgyODc1cF9lZGFjLmMgdG8gdGhlIGxpbmV1cCB3aGljaCBpcw0KPiBhIDMyLWJpdCBvbmx5
IGNoaXBzZXQgZm9yIFBlbnRpdW0gNCBmcm9tIDIwMDMgb3Igc28uDQo+DQo+IFRoZSBjb2RlIGlz
IG5vdCBnb2luZyBhd2F5IC0gaWYgdGhlcmUgYXJlIHVzZXJzIHdobyBhcmUgd2lsbGluZyB0byB0
ZXN0LA0KPiB3ZSBjYW4gZWFzaWx5IHJlc3VycmVjdCB0aGVtLg0KDQpJIGxpa2UgdGhlIGJ1bmRs
aW5nIG9mIGFsbCB0aGUgb3JwaGFucyB0b2dldGhlci4NCg0KQWNrZWQtYnk6IFRvbnkgTHVjayA8
dG9ueS5sdWNrQGludGVsLmNvbT4NCg0KLVRvbnkNCg==
