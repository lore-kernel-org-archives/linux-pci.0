Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49638F928
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562373; cv=fail; b=g7ak3jpFff5VlCvlEeUbz4dA0EbvLbalKySmg6mWPV3xk7AbLfti6fkAgSFfoIbDtPDI2OWDgZlyVk0TNBzPifZYAD2QqCKGD08W6a5LO6hcII0ES+Zb6WhH26jwWhfyoLN/bhHOnpL7tyhcwk03XS/KBkNORv5pAoQ/ZO6crr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562373; c=relaxed/simple;
	bh=09RHYLt9dCHoThy5iKrKwUUbE9EXGdUiaRJ45nswdMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gv8H7inwYBo2EAw1RMZCyDrHENfMcDGI9AHAoPjyVLurb+6l55j2ffuZ1LzZ6pZ4xgyZNVSJG7rtTHFGu9ILAxWzkKmUUUBODBFp7UUGPf36wA+fUS9kZ1aMnHNM2VD1w4LWatXiTdCGJ6LwI00+Qqxky+1vdVTLxNYFwy9QYq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTqNfg+Q; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTqNfg+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791562372; x=1823098372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=09RHYLt9dCHoThy5iKrKwUUbE9EXGdUiaRJ45nswdMc=;
  b=dTqNfg+Qs5x0OpfS8pFNtHLJco6WKs6YQp7CMJF5MOVUb1s1YdCstUdF
   06xiky7Jlc3lbAAgfEz8Sg1Ie9fo0T7TTMul1/18xxtKqamf/WYCypm0t
   2I0ol7CiL89Nb7mAt6ieEtk0tk905RwwRtjSOY04IgGqCQdIiFqzI4OZm
   yfi5yjSsjMEDMrd5g5TDonh+1FZ2RbLNWHAiSOYgUHbnZc7HRKT6nj4BX
   D+ODJRpndfGwySxfWJ4puO+8XtprYlmJPDYdJKGmNGpx6McOsl+NiaIE/
   sw0qdZ6LSSeT1Y08ValMJ/ioqSUBDQEbAyV7s0LV0hBEMccnkTWJmrVd0
   Q==;
X-CSE-ConnectionGUID: Uj2z7jI/TTOOSl8cGNxj+Q==
X-CSE-MsgGUID: uS6YccOYTPqY8GGZ3FgqZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="265203"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="265203"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:12:51 -0700
X-CSE-ConnectionGUID: fs/rxZOTS+2Jx2xyku6y0A==
X-CSE-MsgGUID: cp89sC9tTtaxCywjcvPsgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="694761"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:12:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:12:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 09:12:51 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:12:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FE6VscBNLSbOZiDJ1rRik4h4P8WuQKThjQT+1MErHP0H9bqHrRa3GcJVD0g2DvSAHvnOigqYcOmONbmJYtyQQg8ErnNMYBqbhoG/379PwwYiA2bc+dBIY0wNQHw/Z780aDvYqI8JPq0Wm5e4D7kxXhRI26BprJHZSKuuTjC7nRvM+M8PUo0X50ClomtsbvwzF9BHtO8bDu2XvJ1XOO2pMZMxt3iLw2Gy4H9m02T0Lpd/7kS+HzlOdlm6X2v7gIFGWBOegPygnWkGy9tqWvZ6MB+2o79s127sgTCcfkRcS9cjImHIN58xh59HNT/yy6c0sF8JqhxrWR3BhwHw9DqNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09RHYLt9dCHoThy5iKrKwUUbE9EXGdUiaRJ45nswdMc=;
 b=mZtURzeZNxyHiDT/NU1hl5+x30rthXcqXtdEGNy0JMgOBETDcIn0IURr9XygqQNmTPcryaB5Nk8jP/QvguSOJD6fwAhFgEBKx1UOIFQeTED/NoBQRd9I40gxQBh2SCOVNi+YO9m9E8+Jy3+CbtlZFyRxKm2nw6fkOfXbXgQBImkj0p01qFTVmB85YBahYEIybxxot4qrXcYyXtG8uvew9POyIqvTant7GcNq9TClHl44u6mc4qOTiVnpyVrS/F/ZlaIv95V3jABR7mUjjklZXkYAnjHu/vzuNeN2ceypfzQpqgqnvOl6WHQlAE3S7ZJVIGvzSBrDmakwGyAKBh/yJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Fri, 9 Oct
 2026 16:12:46 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:12:46 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
Thread-Topic: [PATCH 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
Thread-Index: AQHdWASb0EIL+J0ZIUasS7OKh5t0E7b1WqyAgAAEMOA=
Date: Fri, 9 Oct 2026 16:12:45 +0000
Message-ID: <LV2PR11MB6070AA39168B7A2B943DAE87B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009154034.82321-2-pavel.e.popov@intel.com>
 <sashiko-outbox-165794@kernel.org>
In-Reply-To: <sashiko-outbox-165794@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|BY1PR11MB7984:EE_
x-ms-office365-filtering-correlation-id: 5b5886d5-798f-4cdc-e9fe-08df262027fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: ICqO2NIe/k9IM1i8GMJE4eb3405lI1H53AvBAUWGTKsBnwLTZlm0DTmLC5aC2HVLr6tSb1GXjjjDYMoabfdZn05qalPWV/nk6Z3+NaNajOqwYv5gGoPhZn17Cs+MqEWS9IcD5cPG6NcgqzTR9T7lcqNRitH/G2bTkv50ZDke0gFZjEBVtOd1HeXRLBWT/JTxzNyVs+MLYMxjEx9BhYXfOS7whx26lZBg4+Dg7jJB3y6mYNuDP5j4X4y0eskPsdOuqW3/LvPl1NtsZh6PqRAAal0iUrwArvwmBkji1zQbOmSTtwlKucHF9mjruVbwGXbMksFivj7kpML0OXsTOxNuckRs419n7N8fG0j6d8gpgZTyithj92i13oCVzNev3mjm3OFLAoS6hiTNdMrM85RQC+87AlPBQUokdcNsXAKeoWXQduPG9Dk966CUMFED296fsjy/xv440E90ARxlWup/yHK+t9t21aGI0101UjeSybZla1UPJDWhOrgr3KiDfYF1kUMnmWejQp4nn4WhURlbZROpQ64IFKsqnJqzyiA3f1OVCz+bVl//Va7Cuzmy/m6T9qzcZS4UASLpcPY2KZcwOiHxoKx/fNrfxRUG6HfNXtQeJm608fZjo1tpZLUd/CZPNBsXH5/LJVEsmnNfuvCF8x0bXj4gnA7gx5qeNCGOQ9sf/BLT8WvNdR8z3DokyJgjlkksGACUtb3rN/ugyi4xqR5HTdgQUrd7fhLewNKah/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3czZWIxVENDTllUK0RBKytkWmpLbkU0eGRIbUJFdlFwY0xDSFEwMDQxMkRw?=
 =?utf-8?B?ZHhoaGRaS0l6ZERwaUMwWTVzejVtUWZNcmM0bnRmd2RzbUp2Q25DRjJRV050?=
 =?utf-8?B?Y0lUT0F5cEJjSTBscXdKNGhYWHliU2VabmZmTmtiT1cxR05Mb05iN0kyVUR0?=
 =?utf-8?B?VklTZytHZGo4OHBoWjRmSU1iTGw3Wm55ajI0SWp1QW5zUzgrQWhzWE1vUGFM?=
 =?utf-8?B?TFZBTnBDb3QyMzluMDBaSEdtWlRQMGFGcWlqMjVYODdhNDUzS3hicXg1ZmdG?=
 =?utf-8?B?YXg2MXBXNzZGcGJmbGdLb2VsZFRlbmFYSWRzMjhCTnZCeWtHZmQzRjJQcEY0?=
 =?utf-8?B?VFMyMm4zOHQ2YkxRMHgzUWhjQkY0WGxqYUVjNjVGK3A1eWNKL3ROYU5qRWlL?=
 =?utf-8?B?dndvTG1Idit6OTc1dENzZ29sbmFvSXNtalBQZXFwWldmUHRrQ3Y0MGZaUGJ4?=
 =?utf-8?B?QVN0U0xielFvenZxZUQrdHh2dk9ZMHdUL3BwZ29YRVJiRk04ZWlGNEhjQnND?=
 =?utf-8?B?emhFeG1ncm1tOGZCUjlQZTcxSW5vWEdxWURyZmxaVDU3TnJESHBPZzZuU2Ju?=
 =?utf-8?B?S2F2SFdGL1BFcVdpTEg5aWxDWFVmSzloNE00eUlhUjJ6MzZwWkVYTUJIKzFR?=
 =?utf-8?B?ODJzaUwwaXRBeWRydEVGTFNUVkdMS3JhSjEwUE1idXhzajR0SnV4TklTS1NG?=
 =?utf-8?B?QWlmeXBPK3NyRHNlUzFseHVoUC92VkVGdDF0OUw0TmZCTVY0VnRNb09STGE1?=
 =?utf-8?B?Y2ZKMmYzTkw4UURZREsxanNPRmdSRXcyb1JWb1BxcE43NVJKVjl4QzFFSzQv?=
 =?utf-8?B?ajRYMGhHR0lTemVjTDUwVU0wdHZxQ1cwVDd2VUJoTFdDTFhlVzlYMmZ2OHpk?=
 =?utf-8?B?amt0V1NMWTR0L2ZUaERPdVJWZG9WZk14OEQxTlZiSDRobERseWQ3RFJNYkxT?=
 =?utf-8?B?YTdlZU0wNE0rdmZsSkd4QzR2K0VjVnZ3NkdLdjlFWms0d1RLTjdtdVlHOUF1?=
 =?utf-8?B?T2hseDdBK1JjcHlzbklxdWFvclRJd3FremxBNUczOW42ZkMrbGpTSkh1VjJY?=
 =?utf-8?B?eGR6VHU4STJWWUd2NVlySjJzcExuSjZDQkpKSHFHUmtnUktFNFViMTA3N0dG?=
 =?utf-8?B?MTVnaHJEVkRGaHUrMXBxbS9SeU84VDdzcEdoWGl3blhOYXd5YURZbUZpMEF1?=
 =?utf-8?B?Q2crSC9EOWRXR2Fla1BRTVY5Wmg3Y0p1TzRkTlJUbzVUdnN5bkhEUVNzUFlw?=
 =?utf-8?B?OTYzK05LNlJraFlVR243b08rZVU4eW0xM2ExL29TdW5PNTZ0N3VtbWwxR0p3?=
 =?utf-8?B?SDNEUW45UlV6alNEMlFBZ3hvVE5uOXRZSDZEaThYQTBSNVRqMStrWGxicG9F?=
 =?utf-8?B?VEUremREdS96bHZsMGpHTGZRbnlqWmNUR0ZMLy9qRFAxb090TXFHU3ZxczNC?=
 =?utf-8?B?S3hUSTJDRHJRRDVWR0FMQThoeUlUV0VuTEN1MVJ4QWpuY2lydFBLVUxIOFhh?=
 =?utf-8?B?WTA1TzhOM2hoOHUwbldrcGZIL3lvN2dPT0Z3UzVWT1pJSk5JMDdmYTM1U1lr?=
 =?utf-8?B?TUhxdFJDdWtUeWtBaU9oVk1ZSXFRY1Z4cUExaW1rajFDVFcyOHhKT1B1Qno5?=
 =?utf-8?B?TFhUOHVvTlJSVFFKMVJXL0hxemJRV09ac01yODk3UElJRzQxUHFJWTBhOWI2?=
 =?utf-8?B?b2dSZEYxQ0k3Y21kSy9yTE5PRkRNaEhHL1BUZ205SHlqcEpKTkQvbCtLQ01Q?=
 =?utf-8?B?anRtQmxPZXQ3WFQwek1PNXYyc3VZYWhKTEUvWnRoalpselJXTzNROTM2bm5k?=
 =?utf-8?B?eng0d0REUVp1czVBQTNuYkxJK3JFcC8rbmZHL01ocU90M2hqWHJzNlRpVkQy?=
 =?utf-8?B?NUZCMHBSYWhVQ0F1VGUrSVVtVllsbThYTW1NNVNnTy9hSDFwazZRUVVtS0R5?=
 =?utf-8?B?RkxVVTZCZ1NINFBUS3I2Q1QwdnFEMk1jK1lEcnQzaVliSlorUERjbysrWStk?=
 =?utf-8?B?QlRqbXp6aDl2cFlYeWJkbyttMXlxWlRGbC9NSkt5dklvWml5YWZPcW12VHBh?=
 =?utf-8?B?ay9TemR0RnpxckZDOVMzZlpnMVdTcVp2T3ZGKzJQeXhLaDlhc3FtRGV2Sk5r?=
 =?utf-8?B?c1EvWDVzbVFkcVZCVWtrTFkzUHA0b0xxQm9hVnFWVCtuSDdJaEsxbTU1TDFi?=
 =?utf-8?B?bjNkMktiTlgycitaK25Ja1ZweWo5V0cwSUZWb2F2aTluTXNUN0w4Tit4T1ZK?=
 =?utf-8?B?V2RIM2dSaVhVMTFqa3IrcmdUSU4xckllRlZZeS9iNFZjaS96L0VHZVhQVHBp?=
 =?utf-8?B?aVRkYXNRVnFpV0VkV3JjNlhGY2V3NFdKaFczZnJYR1pnZmVZb05zdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0u1mnFSWgMLa+vjrcjljZ9uCFVSGb6b/aBu2S7LESRlRFHkx7RgxgddPgrnwi2jd/XGQi0e9uR/DXOT0Fda/Dl4qkrUizfPt5hcutHL/2J3qpgcLmh5w/j/KWzKhq83xIHasnYywKqTXLWYZACBIsx5aHbSnloGV7cX7INzUMbgClvlxDmHEt85CL2/Cm5OvrhR0TM/Jr9H8qLCSXx50iNALzjwHYQBD563N+JcSnE9+tAfCn8vu127q+ZPyu/z+qHd1yaG5ga0X3Y//b5VvXmi6rUTupw+0CaHhqXkbDRYBqcaO/MzmrLh2Xk2jROIFMG9wcZgOA5C/IGs8Xrj/+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5886d5-798f-4cdc-e9fe-08df262027fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 16:12:46.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 345gRNcLM3DJtequo2VDJu77cbBtQ3IgybmBNxSxkk1lXya/vJUraWsEkNjbOyVakkK+EXt3EPzK2N4LNw5iRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgdGhpcyBsb2dpYyBjb3JyZWN0bHkgaWRlbnRpZnkg
U2t5bGFrZSBhbmQgbmV3ZXIgQ1BVcz8NCj4NCj4gSW50ZWwncyBGYW1pbHkgNiBtb2RlbCBudW1i
ZXJzIChWRk0pIGFyZSBub3QgbW9ub3RvbmljYWxseSBvciBjaHJvbm9sb2dpY2FsbHkNCj4gaW5j
cmVhc2luZy4gSU5URUxfU0tZTEFLRV9YIGlzIE1vZGVsIDB4NTUuIE9sZGVyLCB1bnN1cHBvcnRl
ZCBwcm9jZXNzb3JzIGxpa2UNCj4gQnJvYWR3ZWxsLUQgKDB4NTYpIGFuZCBBdG9tIEdvbGRtb250
ICgweDVDKSBoYXZlIG51bWVyaWNhbGx5IGhpZ2hlciBWRk0NCj4gdmFsdWVzIGFuZCB3aWxsIGVy
cm9uZW91c2x5IHBhc3MgdGhpcyBjaGVjay4NCg0KWWVzLCB0aGlzIGlzIGEgZGVsaWJlcmF0ZSBs
b3dlciBib3VuZCwgbm90IGEgc3RyaWN0IGdlbmVyYXRpb24gb3JkZXIuIFRoZQ0KZ29hbCBpcyB0
byBjb3ZlciBhbGwgWGVvbiBTY2FsYWJsZSBnZW5lcmF0aW9ucyB3aXRob3V0IGEgcGVyLWdlbmVy
YXRpb24NCmxpc3Q7IHRoZXkgYXJlIGFsbCBhYm92ZSBJTlRFTF9TS1lMQUtFX1gsIGluY2x1ZGlu
ZyBEaWFtb25kIFJhcGlkcw0KKGZhbWlseSAxOSksIGFuZCBldmVyeSBYZW9uIHVwIHRvIEJyb2Fk
d2VsbC1FUCAoMHg0RikgaXMgYmVsb3cgaXQuIFRoZQ0Kb25seSBvbGRlciBwYXJ0cyB0aGF0IHBh
c3MgYXJlIEJyb2Fkd2VsbC1EICgweDU2KSwgS25pZ2h0cyBMYW5kaW5nL01pbGwNCigweDU3LzB4
ODUpIGFuZCBhIGZldyBBdG9tIFNvQ3MgKDB4NUEtMHg1RikuIE5vbmUgb2YgdGhlbSBpcyBhIHJl
bGV2YW50DQpWTXdhcmUgb3IgSHlwZXItViBob3N0Lg0KDQo+IFdvdWxkIGl0IGJlIGJldHRlciB0
byB1c2UgeDg2X21hdGNoX2NwdSgpIHdpdGggYW4gZXhwbGljaXQgbGlzdCBvZiBzdXBwb3J0ZWQg
VkZNcw0KPiByYXRoZXIgdGhhbiBhIG51bWVyaWMgdGhyZXNob2xkIGNvbXBhcmlzb24/DQoNCkFu
IGV4cGxpY2l0IGxpc3QgbmVlZHMgYSBuZXcgZW50cnkgZm9yIGV2ZXJ5IFhlb24gZ2VuZXJhdGlv
biwgd2hpY2ggaXMNCnRoZSBtYWludGVuYW5jZSBidXJkZW4gcGNpX3AycGRtYV93aGl0ZWxpc3Rb
XSBhbHJlYWR5IGhhcyBhbmQgdGhpcyBwYXRjaA0KYXZvaWRzLiBJZiB0aGUgdGhyZXNob2xkIGlz
IG5vdCBhY2NlcHRhYmxlLCBJIHdvdWxkIHJhdGhlciBieXBhc3MgdGhlDQpjaGVjayBmb3IgYWxs
IEludGVsIENQVXMgdW5kZXIgVk13YXJlIHRoYW4gbWFpbnRhaW4gYSBtb2RlbCBsaXN0Lg0K
