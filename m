Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BD4772A7;
	Thu,  3 Sep 2026 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430160; cv=fail; b=WIvzKTL0+bAvfITJebloUZ0TzgPWyFIuXkXD2ujHGdwiGFf3O5m+K2IopNgOj2qommatdYDKtniIGriG2mg+RUdiMBVxS73679r7I0iW2U11XUcF1qWdzBU7n7/TPjVuixNiU/jeGtVrzOysCct+CU8YaG1OzWA1AfRVAG8EaZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430160; c=relaxed/simple;
	bh=1BxGDXXdFWWTo5Hq+RTo6mP7LvOcBznLI2iBKiokm4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DL7FtDpldjBUppiYGpMYgYL5wHFAqYHP1YbNnyRiyV9Cutm2DG9lsuNlYdAUSxfSpr7uzgdGXw/qDVn+ZcygvIcsb/MK36o3s/T4TLD1a0+wgzn7XWmpMa5p4+gmM+SlhCGSQtwZjaq7rh0nM6dLIIAu1aOlHmB3ImnMbZUf1rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GSP6XMyo; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GSP6XMyo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCbVDP7ywdej1wL7XBpENE2SEy0bsjaIWHviYS0r1bYVU0tteCfItRN9SBKqna+PGIAfPsutWzd639hu5lJ50k52nZiEYgLdBgKiLFUm29EGDO/UXQWMM4F+2UP4yDMt6UvJCEu7iNVBYVzsIugF0EVVzR6ZoxP+/9qZJn6jEYsWp5kx6skG+JGwmmxR+REfhUL6j8TomkuFANKvxD9p3aoGdOgUlyGQ6mJJF/euDP9NCSUlKeNDqQODiUt1WQDmT7wokU3SBPts2LY3IvhDdGegTxurhdz0kJ9FB9Y8eUppJo2GDsptJkY7jvP4+T7IO9oBtSIYrxGBqu+2zvaXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BxGDXXdFWWTo5Hq+RTo6mP7LvOcBznLI2iBKiokm4s=;
 b=rkz5jld1a0vGR1211hAcjmxyRl7IWBiyK5tIrshMFt5IHEin5NhYA/lrqxPh6+DWXu3F/HHPPUXIgTJOamUMler6LXfl4egXuwgVMLc8aQCNnaHg98EnMhXIHLwKSeTZVdZejHF136Ap6JpzAipNXm3FNr2AXdaJYhQdNESEgV9aWSlimCIW2EVkOkdlqyawJPW7UjLOf4tdnnJjhYJKuWO8XTWj9+hJ0ntK8btIgfUGz2WlEqeaHLTzTYooOXKH9Z79sTw4xHFQQtggIzthjut1bi21HSG+2bKI2CbGjAInRO1OANJy152Xn3GjfkTkp+Dm2ADJCFCQdqWmOld3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BxGDXXdFWWTo5Hq+RTo6mP7LvOcBznLI2iBKiokm4s=;
 b=GSP6XMyo7yh1qbd6Ozew08AteGJdc8cPp6soNQ+mBfkxyNUtKFwCrMv6bNsflG6ZUpI5zIC+MJblpNYDxG46lEqBco2Iw/2gzNn+JNkx6tjgOFfzwXLrMBZDwCuJu5gWQ4sa3zfmRtzXGWJUarvj0aBjCR58XHR0McgGGOJ0M5oRq4i9I1lv/cdKNLooxr+s23ZRSBwLiW7YAmlnG+w4331uf5RmaVRfW7m5WZiW6/aWYPrp00/GFjvy4Rb9is4dkzeTF/rA/1SOOTqjp3ve45rmwAq5d1gG2nLCqL8xbmhqZL75ncsNVJWz4c9ErA1GA3N7/Re+//IY6H6IM+TNsQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:08:55 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:08:55 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, "alex@shazbot.org" <alex@shazbot.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>
CC: Neo Jia <cjia@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v4 04/27] cxl: Establish media readiness in
 cxl_mem_probe()
Thread-Topic: [PATCH v4 04/27] cxl: Establish media readiness in
 cxl_mem_probe()
Thread-Index: AQHdKwd5lNi9HBy68U+mCrHW9qkOJbaztnqAgAjQYNA=
Date: Thu, 3 Sep 2026 10:08:55 +0000
Message-ID:
 <IA1PR12MB903042E67B773EB3C2BC4CCABDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
 <20260813093631.2288172-5-mhonap@nvidia.com>
 <dbc6658c-9c3d-4590-b9c3-784dcc7846cc@intel.com>
In-Reply-To: <dbc6658c-9c3d-4590-b9c3-784dcc7846cc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: 912abad8-131d-4eda-7b68-08df09a35cf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 I8RDKzXTmHEjFxTJqsbWkv93K/UjhacVCTfh1cR/GRs2dfiGX4xCE7RQjVS9Bg6ypj/bpC4UT0C1UBrWwSKOT7vrVDKVtJxCVT03gETkjV2J2W8KDjm7yC2IpLsyzvlMwlYCXqJntKiSei/gjd2Hig5clUP8+rxnt19/avPzqfl9OgcgQXT24JOFPgYHx2VdyB28XBA/cI+2nqS/LTfYqTEBM4XDdFB/RC6T4m76eMAFS1pF4LoF6al0fPIyZUAi5kq3mXOxIRp5217W22q/a2nB3s9ico+c5gvj55aPHR1ddqBH8oF4wpk8FoSnPSOShXQCzIAb+8aLXsOyRHVkTgFRf8XbQIykki5K7eMIBA6KWulH0wozHZ1LT6l2a98qcUnIFvDU/hKvtPBl/+Cg8jHv4XtHvple+c16LuPbzEMDZzzy7WIqENWvJo1Yg3Kx0f+qcYbsOIDJqKR4sDjz7GOagU6yIKDryEm0xJunjXQi2lQ5WGEsi6/73mlBFEXb6boZqkeOwKe7/kRRmgS2UdE2pt65fkTsMVQTXp6fDsNeunDssBnK6/C8r1AFex1PdC41rJ2eIypDAPZX0WPIburJV0jtaIdXZm8kO+22QSpilsM4kVpbEovCgvbF7yvBM/JboxXXhYJbligMXFfbaEets0inG9Jpt0SyDvPl04x5dBgP2XTHDRyCX6OVvYlGfTCqHbqvCIjJnifX00gCXF3UiQ8ZCZ8fPuBVlhAFCdSCiJkfWkHfeGMw+0tdAyQW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dG1mM091eGJMaFdiNkRGcXpMVDhWL0w4Y1Y3c0VVSzUvenkxcDFOQlFvNkYx?=
 =?utf-8?B?OTU1dTl6WW1PekduaUF4VGtpdVVnMWFmVmhTam80cER1NDlLSGpEdzdVcWIy?=
 =?utf-8?B?a3YxYUphdTUyb0taUTJ2OG1jYWMvVDRicVNZSzUxTG5PT3hMWWtvci82dDJQ?=
 =?utf-8?B?dVd0bnpPTy8wUDVnVHY3UG9aZFJHK1dxaFlWWXJ5cGF0M0g0eGh2UERsdWRu?=
 =?utf-8?B?cGZIMyt2M3F0Y0F5bGYrVjNqcVZXdDhxM0JFT0Z6a1VpYWxzVnhIRXNTdEJ0?=
 =?utf-8?B?eTlUOHE3RFlZNTBLV2ZpOGNraW5IVEpNL05vUnM0WGttU1crUHdBMlJHUW9J?=
 =?utf-8?B?UWQzM2F2UlVKbXdBc05uNHFZUXpSb3FoNTJ5dXNCbVpCcHRaRDk5VnhKbHRL?=
 =?utf-8?B?UVRhZkloSWM4bHBYZWdoelJtLzlrdlhTTnlQSE1mYUZJbkkrdXFMb1JHdm85?=
 =?utf-8?B?MVV5dWtNWW03SElmWjBESUpDOWxlS3pzdUptMmJUNGQ1VVFXY2YrZmlGZFdM?=
 =?utf-8?B?QXhpVllJMjRoZ2hISE94UmEyNDAweU9xMVVDRkpOQmdJTnZMWEFDL3p0S0R4?=
 =?utf-8?B?OTNndTNGM2JVQkFqZHFjcTc2Q25LbU1kQTVBbFlndzhlQTlGRDJzVTdwQTk5?=
 =?utf-8?B?TWxtbFIvbUhZUnRhVUlLVTJIWDk5TEtzV2pHc293djl2NGxxR1hPU05ObVd6?=
 =?utf-8?B?S3JNd1B5cU1TQ255MklsWXZtRGVDVllteUxuRmZxTWltTU9EMGZWNi9kSnRw?=
 =?utf-8?B?dVI5amtMVWZoV0h0Mk1JV0ZCSjhYYjV0Z1FtSkIzbGl5b2wwQkg3V2FWZmEx?=
 =?utf-8?B?NDBDSGFGaDJ1UXRJc3RpZXVMWFpKUjRQTnk2UTkrbDQ1eko0QVNHRStKdXRQ?=
 =?utf-8?B?eUtRcmtidXZwa2ZQc1RSaUkyUklLMWhaK0VhcVJhM0NJNXppNE1ObnAwdnVz?=
 =?utf-8?B?NnJBTWxZcndDV29BT1VjRXRZQ2pXTHZXWll5Nk95TVg4UVJmeXhPWmhOTFFO?=
 =?utf-8?B?ajFJQkFCV2VhUEQ4T1R6UEkzNzFsMzZhTm4xMi81TWZKZDFRekxwdzNCNzRG?=
 =?utf-8?B?R3dmU2pkeVhOT3BNd1hXSkZGOVhrSm8zOS9VRFgrSHJSRU5NdVZEVm9BcEZO?=
 =?utf-8?B?aVhaOE5ac0Q3LzhKeGRmcjk3SDM2YytSalJZT3dMMHh1NVk5aklIMUViREp5?=
 =?utf-8?B?VnF0RUdEd0hkQzIwaXZZdVFvaWZxS2MwbWphdlBVbnZrem50U1RjTk1pSldB?=
 =?utf-8?B?UTNmTzdXR1YrUEcvR3IxRC9zWlAzNXJzSngvcytqZ3JzWHk1d0NuVk5EVk9n?=
 =?utf-8?B?NkJWRi9YWk9tdmRNZWJ4MFZ0VXc3alZsWlhGSnpDSEx1RXVOVTEyUVg2V2tK?=
 =?utf-8?B?UnlycDFqb3NobGhwdFZlRmQrWHBCejN1MXVDKzVmSHZTcjJvNm1XUlBmUlNr?=
 =?utf-8?B?UjFxNHFzY09JazRIY2xnWTUzellzbW1XZ0RZMERpeWFGVFVvcUZadlhYdjBT?=
 =?utf-8?B?NCtVL1hNSmNKYXpNNVFUMDlLWFpPY0E3V21pY1R1UWhscEZOSzhwMmxZYUtV?=
 =?utf-8?B?STMzaVczYmp2T3BpWmZsMnF1TVh1V2U4eC9QRTZMK0I4aUQ4L3k1dStsZmlL?=
 =?utf-8?B?UUZVa0hET2pyS3QvTXpuUWtCR2VWUUs1aVFNWDNBbHEyRzNsYUsxUDdXaFRK?=
 =?utf-8?B?b0cwbUsvMllmRmgvV0dyRjJlQzdXM2tSTWR6UzBmazJXMkxBY29nbUMxZjZ3?=
 =?utf-8?B?YXRCTjNtRWlDb3Yyem9VQzFKa1Q3SmVFWWR4eTVqVDVmK3kwTitYa2pjdzBi?=
 =?utf-8?B?TUlOL0M5SWJsWW5UUmZZVzQ4RFAzL1RWRzFKRVN4RFg5TkFDQU1UNEFHaVpw?=
 =?utf-8?B?NzJHODNCMnpsanJEYWZGZnh6ZmFVK1JPeFV6MFpwQVVxckMwKzZBUytYS3Rz?=
 =?utf-8?B?aWQ5S0tCK1NMNmF5SnZvY2hjTWlhWGlDNktVbFphSHVtU01pYUNmb3ZuZmU5?=
 =?utf-8?B?QmwvOHZzTHJPaXVGUkcxRkoyd3lYZHBjM1RKYVc3emlTTFQzY083L1EwWVNl?=
 =?utf-8?B?R1JCNnNpL2lRVkN1MUUyalFoT01BS2F0ZFBSc1pjNlJXb05OS1VMN0lZVmEy?=
 =?utf-8?B?UDNxNS9lSEhBSHl5MGdOL1pDWWJZWUNuRThaUlFEbTJIVFdMN0xvRWxmamZW?=
 =?utf-8?B?Q0VmUXRKeFBmQ0NUakdXUmFKQVgzbjQ1RDcyWDJTVUVWMUtmSE5TblluNFFL?=
 =?utf-8?B?YituaGVvNXl6R1ExM0NwSkpDdzNpTHppMnd4MGEzWjNncW5iV3FlajdxaEpU?=
 =?utf-8?Q?lFxCt+4NGErA/N9Z2r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912abad8-131d-4eda-7b68-08df09a35cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:08:55.3509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZgG5ppZtJ7sicSKH/3cdvzfghv78cfv1Bw/1raapkmE0xpWoapdvhTNBwF8vqTVmRqPwLWsECXuQfz/9Ghjaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBKaWFuZyA8ZGF2
ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDI4LCAyMDI2IDk6MzAg
UE0NCj4gVG86IE1hbmlzaCBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+OyBhbGV4QHNoYXpib3Qu
b3JnOyBqZ2dAemllcGUuY2E7DQo+IEFua2l0IEFncmF3YWwgPGFua2l0YUBudmlkaWEuY29tPjsg
amljMjNAa2VybmVsLm9yZzsgYWxlamFuZHJvLmx1Y2Vyby0NCj4gcGFsYXVAYW1kLmNvbTsgU3Jp
cmFuZ2FuIE1hZGhhdmFuIDxzbWFkaGF2YW5AbnZpZGlhLmNvbT47DQo+IGNvcmJldEBsd24ubmV0
OyBza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnOyBkYXZlQHN0Z29sYWJzLm5ldDsNCj4gYWxpc29u
LnNjaG9maWVsZEBpbnRlbC5jb207IHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbTsgaXdlaW55QGtl
cm5lbC5vcmc7DQo+IG1pbmcubGlAem9ob21haWwuY29tOyBZaXNoYWkgSGFkYXMgPHlpc2hhaWhA
bnZpZGlhLmNvbT47IFNoYW1lZXINCj4gS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0Budmlk
aWEuY29tPjsga2V2aW4udGlhbkBpbnRlbC5jb207DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGRt
YXRsYWNrQGdvb2dsZS5jb207IGtlZXNAa2VybmVsLm9yZzsNCj4gZ3VzdGF2b2Fyc0BrZXJuZWwu
b3JnDQo+IENjOiBOZW8gSmlhIDxjamlhQG52aWRpYS5jb20+OyBLcmlzaG5ha2FudCBKYWp1IDxr
amFqdUBudmlkaWEuY29tPjsgVmlrcmFtDQo+IFNldGhpIDx2c2V0aGlAbnZpZGlhLmNvbT47IFpo
aSBXYW5nIDx6aGl3QG52aWRpYS5jb20+OyBsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga3ZtQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgtY3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWhhcmRlbmluZ0B2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNC8yN10gY3hsOiBFc3RhYmxpc2ggbWVk
aWEgcmVhZGluZXNzIGluDQo+IGN4bF9tZW1fcHJvYmUoKQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6
IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiA4
LzEzLzI2IDI6MzYgQU0sIG1ob25hcEBudmlkaWEuY29tIHdyb3RlOg0KPiA+IEZyb206IE1hbmlz
aCBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+DQo+ID4NCj4gPiBtZWRpYV9yZWFkeSB3YXMgb25s
eSBldmVyIHNldCBieSBjeGxfcGNpLCBpbiBhZHZhbmNlIG9mIHJlZ2lzdGVyaW5nIGENCj4gPiBt
ZW1kZXYgYW5kIHdpdGggQ1hMIE1lbW9yeSBEZXZpY2UgcmVnaXN0ZXIgYXNzdW1wdGlvbnMuIEEg
Y29uc3VtZXINCj4gPiB0aGF0IGNyZWF0ZXMgYSBtZW1kZXYgd2l0aG91dCBjeGxfcGNpLCBzdWNo
IGFzIGEgbWFpbGJveC1sZXNzIFR5cGUtMg0KPiA+IGFjY2VsZXJhdG9yIGJyb3VnaHQgdXAgdGhy
b3VnaCBkZXZtX2N4bF9wcm9iZV9tZW0oKSwgdGhlcmVmb3JlIGhhbmRlZA0KPiA+IGN4bF9tZW0g
YSBkZXZpY2Ugd2l0aCBtZWRpYV9yZWFkeSBzdGlsbCBmYWxzZSwgYW5kIGN4bF9tZW1fcHJvYmUo
KQ0KPiA+IHJlamVjdGVkIGl0IHdpdGggLUVCVVNZLiBfX2Rldm1fY3hsX2FkZF9tZW1kZXYoKSB0
dXJucyB0aGF0IGludG8NCj4gPiAtRU5YSU8gYmFjayB0byB0aGUgY2FsbGVyIGFuZCB0aGUgYmlu
ZCBmYWlscy4NCj4gPg0KPiA+IE1vdmUgdGhlIHJlYWRpbmVzcyB3YWl0IGludG8gY3hsX21lbV9w
cm9iZSgpIHNvIGV2ZXJ5IG1lbWRldiBjb25zdW1lcg0KPiA+IGdldHMgYSByZWFkeSByZXNvdXJj
ZSByZWdhcmRsZXNzIG9mIGhvdyB0aGUgbWVtZGV2IHdhcyBjcmVhdGVkLiBXaGVuDQo+ID4gbWVk
aWFfcmVhZHkgaXMgbm90IGFscmVhZHkgc2V0LCB3YWl0IG9uIHRoZSBkZXZpY2UncyBEVlNFQw0K
PiA+IE1lbV9JbmZvX1ZhbGlkIGFuZCBNZW1fQWN0aXZlIGJpdHMgYW5kIG1hcmsgaXQgcmVhZHku
IGN4bF9wY2kga2VlcHMNCj4gPiBzZXR0aW5nIG1lZGlhX3JlYWR5IGJlZm9yZSBpdCByZWdpc3Rl
cnMgaXRzIG1lbWRldiwgc28gdGhhdCBwYXRoIHNraXBzDQo+ID4gdGhlIHdhaXQuDQo+ID4NCj4g
PiBUaGUgQ1hMIE1lbW9yeSBEZXZpY2UgcmVnaXN0ZXIgZ3JvdXAgaXMgb3B0aW9uYWwgYW5kIG1h
bnkgVHlwZS0yDQo+ID4gZGV2aWNlcyBkbyBub3QgaW1wbGVtZW50IGl0LCBzbyBjeGxfYXdhaXRf
bWVkaWFfcmVhZHkoKSBtdXN0IG5vdCByZWFkDQo+ID4gdGhlIE1lbWRldiBTdGF0dXMgcmVnaXN0
ZXIgdW5sZXNzIHRoZSBncm91cCBpcyBtYXBwZWQuIFJlYWRpbmcNCj4gPiByZWdzLm1lbWRldiBv
biBhIGRldmljZSB0aGF0IGxhY2tzIGl0IHdvdWxkIGZhdWx0LiBHYXRlIHRoYXQgcmVhZCBvbg0K
PiA+IHJlZ3MubWVtZGV2OyB0aGUgRFZTRUMgYml0cyBhbHJlYWR5IHByb3ZlIHJlYWRpbmVzcyBm
b3Igc3VjaCBkZXZpY2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFuaXNoIEhvbmFwIDxt
aG9uYXBAbnZpZGlhLmNvbT4NCj4gDQo+IEFncmVlIHdpdGggQWxleCdzIHJldmlldy4gRmlyc3Qg
cGFydCBuZWVkcyB0byBiZSBhIHNlcGFyYXRlIHBhdGNoLiBBbmQgc2Vjb25kDQo+IHBhcnQsIHBs
ZWFzZSBzZWUgZHJpdmVycy9uZXQvZXRoZXJuZXQvc2ZjL2VmeF9jeGwuYzplZnhfY3hsX2luaXQo
KSBvbiBtZWRpYQ0KPiByZWFkeSBmb3IgQ1hMIHR5cGUyLiBUaGF0IHNob3VsZCBiZSBoYW5kbGVk
IGJlZm9yZSBkZXZtX2N4bF9wcm9iZV9tZW0oKQ0KPiBnZXRzIGNhbGxlZC4gQW5kIHdpdGggdGhh
dCwgbWF5YmUgdGhlIGZpcnN0IGNodW5rIGlzIG5vdCBldmVuIG5lZWRlZD8NCj4gDQo+IERKDQoN
Cm9rYXksIEkgd2lsbCBmb2xsb3cgdGhpcyBhY2NvcmRpbmcgdG8gZWZ4X2N4bF9pbml0KCkuDQoN
Ck1lZGlhIHJlYWRpbmVzcyB3aWxsIGJlIGVzdGFibGlzaGVkIGluIHRoZSB2ZmlvLWN4bCBiaW5k
IHBhdGg6DQotIENyZWF0ZSB0aGUgbm8tbWFpbGJveCBjeGxfZGV2X3N0YXRlDQotIFZhbGlkYXRl
IHRoZSBjb21wb25lbnQvSERNIHJlZ2lzdGVycw0KLSBTZXQgbWVkaWFfcmVhZHkgZGlyZWN0bHks
IGJlZm9yZSBkZXZtX2N4bF9wcm9iZV9tZW0oKS4NCg0KTm8gY3hsX21lbV9wcm9iZSgpL2N4bF9h
d2FpdF9tZWRpYV9yZWFkeSgpIGNoYW5nZSwgc28gdGhlIHN1Z2dlc3RlZCBzcGxpdA0Kd2lsbCBu
b3QgYmUgbmVjZXNzYXJ5Lg0KDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY3hsL2NvcmUvcGNpLmMg
fCAxNSArKysrKysrKysrKy0tLS0NCj4gPiAgZHJpdmVycy9jeGwvbWVtLmMgICAgICB8ICA5ICsr
KysrKystLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9wY2kuYyBiL2Ry
aXZlcnMvY3hsL2NvcmUvcGNpLmMgaW5kZXgNCj4gPiAwOGQ0Yzk1NTEzN2QuLjliMzcyZDVhMWFh
NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jDQo+ID4gKysrIGIvZHJp
dmVycy9jeGwvY29yZS9wY2kuYw0KPiA+IEBAIC0xNTEsNyArMTUxLDYgQEAgaW50IGN4bF9hd2Fp
dF9tZWRpYV9yZWFkeShzdHJ1Y3QgY3hsX2Rldl9zdGF0ZQ0KPiAqY3hsZHMpDQo+ID4gICAgICAg
c3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGN4bGRzLT5kZXYpOw0KPiA+ICAgICAg
IGludCBkID0gY3hsZHMtPmN4bF9kdnNlYzsNCj4gPiAgICAgICBpbnQgcmMsIGksIGhkbV9jb3Vu
dDsNCj4gPiAtICAgICB1NjQgbWRfc3RhdHVzOw0KPiA+ICAgICAgIHUxNiBjYXA7DQo+ID4NCj4g
PiAgICAgICByYyA9IHBjaV9yZWFkX2NvbmZpZ193b3JkKHBkZXYsDQo+ID4gQEAgLTE3Miw5ICsx
NzEsMTcgQEAgaW50IGN4bF9hd2FpdF9tZWRpYV9yZWFkeShzdHJ1Y3QgY3hsX2Rldl9zdGF0ZQ0K
PiAqY3hsZHMpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByYzsNCj4gPiAgICAg
ICB9DQo+ID4NCj4gPiAtICAgICBtZF9zdGF0dXMgPSByZWFkcShjeGxkcy0+cmVncy5tZW1kZXYg
KyBDWExNREVWX1NUQVRVU19PRkZTRVQpOw0KPiA+IC0gICAgIGlmICghQ1hMTURFVl9SRUFEWSht
ZF9zdGF0dXMpKQ0KPiA+IC0gICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ID4gKyAgICAgLyoN
Cj4gPiArICAgICAgKiBJdCBpcyBwb3NzaWJsZSBzb21lIFR5cGUtMiBkZXZpY2VzIChDWExfREVW
VFlQRV9ERVZNRU0pIGRvIG5vdA0KPiA+ICsgICAgICAqIGltcGxlbWVudCByZWdzLm1lbWRldjsg
b25seSBjb25zdWx0IHRoZSBNZW1kZXYgU3RhdHVzIHJlZ2lzdGVyDQo+IHdoZW4NCj4gPiArICAg
ICAgKiB0aGUgZ3JvdXAgaXMgYWN0dWFsbHkgcHJlc2VudC4NCj4gPiArICAgICAgKi8NCj4gPiAr
ICAgICBpZiAoY3hsZHMtPnJlZ3MubWVtZGV2KSB7DQo+ID4gKyAgICAgICAgICAgICB1NjQgbWRf
c3RhdHVzID0gcmVhZHEoY3hsZHMtPnJlZ3MubWVtZGV2ICsNCj4gPiArIENYTE1ERVZfU1RBVFVT
X09GRlNFVCk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgaWYgKCFDWExNREVWX1JFQURZKG1k
X3N0YXR1cykpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KPiA+ICsg
ICAgIH0NCj4gDQo+IFlvdSBwcm9iYWJseSBnZXQgbGVzcyBjb2RlIGNodXJuIGlmIHlvdSBqdXN0
IHJldHVybmVkIGhlcmU6DQo+IA0KPiBpZiAoIWN4bGRzLT5yZWdzLm1lbWRldikNCj4gICAgICAg
ICByZXR1cm4gMDsNCj4gDQoNCk9rYXksIEkgd2lsbCByZXNvbHZlIHRoaXMuDQoNCk1hbmlzaA0K
DQo+IERKDQo+IA0KPiA+DQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jeGwvbWVtLmMgYi9kcml2ZXJzL2N4bC9tZW0uYyBpbmRleA0KPiA+IDc5
OGU1YzM2OWNmYy4uOWM2ZTk5YjkxMjRjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3hsL21l
bS5jDQo+ID4gKysrIGIvZHJpdmVycy9jeGwvbWVtLmMNCj4gPiBAQCAtMTA1LDggKzEwNSwxMyBA
QCBzdGF0aWMgaW50IGN4bF9tZW1fcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAgICAg
IHN0cnVjdCBkZW50cnkgKmRlbnRyeTsNCj4gPiAgICAgICBpbnQgcmM7DQo+ID4NCj4gPiAtICAg
ICBpZiAoIWN4bGRzLT5tZWRpYV9yZWFkeSkNCj4gPiAtICAgICAgICAgICAgIHJldHVybiAtRUJV
U1k7DQo+ID4gKyAgICAgaWYgKCFjeGxkcy0+bWVkaWFfcmVhZHkpIHsNCj4gPiArICAgICAgICAg
ICAgIHJjID0gY3hsX2F3YWl0X21lZGlhX3JlYWR5KGN4bGRzKTsNCj4gPiArICAgICAgICAgICAg
IGlmIChyYykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJjOw0KPiA+ICsgICAg
ICAgICAgICAgY3hsZHMtPm1lZGlhX3JlYWR5ID0gdHJ1ZTsNCj4gPiArICAgICAgICAgICAgIGRl
dl9kYmcoZGV2LCAiQ1hMIG1lZGlhIHJlYWR5XG4iKTsNCj4gPiArICAgICB9DQo+ID4NCj4gPiAg
ICAgICAvKg0KPiA+ICAgICAgICAqIFNvbWVvbmUgaXMgdHJ5aW5nIHRvIHJlYXR0YWNoIHRoaXMg
ZGV2aWNlIGFmdGVyIGl0IGxvc3QgaXRzDQo+ID4gcG9ydA0KDQo=
