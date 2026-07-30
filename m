Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27D35E1B1
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442605; cv=fail; b=Hh5qZj9WBDaZkEUE+DApkaQyQvVzhszo4PCXYl1DBTXaazXf96NjKKMqdZ1WDgqg8GG8RXyvgKGAQoLyDsOnKjwlzqXXQq/L8ArspmWHRaPTMEFcoHqbBDCM3htwudDvt4sxds7aUIDuqcfFuFZXEbf4AYMRXxnlAtE9Wabvggc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442605; c=relaxed/simple;
	bh=OaMvaRrS/lTZlpFHrpMynt1pyxYZ90E7x6xzltzE7i8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RceK6PF7zsDnHDbiF29nXb5eroVGBn1E0uLdxmKu0SA7s5zTvXJe9sQOc2tZZyR5b6NIsG+vFyYhw7c3v3pMXINGE8DPyyi7Ca1oGYXhQCd++jIPaHxQLwBz9mpcmtcgjSkNQ1rjCp70es2bBcULQ8W1kqMUBlQBLyiEeRH8FO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nL9HHarr; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nL9HHarr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785442600; x=1816978600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OaMvaRrS/lTZlpFHrpMynt1pyxYZ90E7x6xzltzE7i8=;
  b=nL9HHarrcuYiAlr/i6aosWK2Zc/UsXEDUP49ugc6tfXmvdFo0Qp6pP+q
   k0bsMNY3Xy3huP/8czDtKZ0dh73DqHeoZRbz/7smGggx2wRcIBlPVJhDx
   vQHsVE6zk87GLAAgn1GNmlQVVo21Fxc6bMEK82dTXhlsMg+AAwxUQ860p
   iRycCM7ny/nS9G0qQascrhb1YIh8p1hB3+icLT/gRdrbanul7L2eLNC4k
   sI6xcq8ic9JbgMzYgbsblzo/1UWc20VN4YPPtPv8a/I9Nfk14wF7LHElS
   pOmWvX9ZLNHUBhM+66Ykljjm7TG+Mb/K21PsprFYsf1EPcHLi3gtuD6Ec
   A==;
X-CSE-ConnectionGUID: tiZUqcJvRsCS2hRm+j1otw==
X-CSE-MsgGUID: b42e5LiXQlyljYRhOq7nNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96431030"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96431030"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 13:16:36 -0700
X-CSE-ConnectionGUID: Zrjy73dxSNi0cJLMBdt8EQ==
X-CSE-MsgGUID: mpZg0N/KT2Snh8A8ZIA73g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="256474536"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 13:16:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 13:16:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 13:16:35 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 13:16:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sqt6ZhKkNUMd5FNsHmSYz0cZRGvrd3tdwLbxLjZ94dVrsT3HjdMvJ9Wpk2Key7T908grMI8ZQJ+ZIwaS5Whf6m/uruUJ0l6jKKHGt9FCFQyuVayGjJciO5Z5vZ7fPDtI9Bx9MTeQMjK/bevUd4Kns7djIwUcH/0Kcq4znojLGxlElliczqGU0f8UU0y92WeKYlOq2YTpyj4/PyfzPJ+1lRSMdFy+8vFJqh3d/TvLcbxiOSJiNuvBnjMZCimWdcb2Hu6+qx7kR4x/vYw+UVYbYlZ1pBDaoNhK8jazgOKC/O/MEIEw++OkA3o/YZ9ETo32/OjU4hfmfAjxZdnt5hx0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaMvaRrS/lTZlpFHrpMynt1pyxYZ90E7x6xzltzE7i8=;
 b=YA3qD/PLTCF/t7SHUN59o7fKxBDf8pwqaLxBw82iCwPu+k4/8/1v9np8JieYDoxVnlxCZRiAkThNUhuJFbfoG0gFoKHstDrZ9ihSMCkKac9EZxk64AyKy7QwNpl6eQCgv9vrTb4CacRKJiIyDi+8u7Ticx7rUX5LLim5rdC0ENgwXD+jLvSnWQjudR94UaTa72Rh4O0h/VmsvUAsh+riJCvb/miLaj1mt24rheuFV0bwT1XuGcsDqeY+djBaJHWjwMoIx81AaAQHszDOlBfkKol9vLZYTPG6CPcXZZuqhSCdd5rB2niBnX5G+2gVc/J8DdF2n1l4ERExR2jd9+jS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by DS0PR11MB9478.namprd11.prod.outlook.com (2603:10b6:8:28f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 20:16:33 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 20:16:33 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>, "lukas@wunner.de"
	<lukas@wunner.de>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "treding@nvidia.com"
	<treding@nvidia.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Topic: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZImB0AgAAE6oCAMTTxAIAABOIAgAAe6wCAARjQAIAAHZOAgAhH+4CAAAUPAIAAEYwAgAAGZYCAAAi/gIAAsEyAgAFxSwCAANOCgIAAFZ0AgAAXJoCAAAJLAA==
Date: Thu, 30 Jul 2026 20:16:33 +0000
Message-ID: <b314134d7e39eb497a17283ce15467914aa054ae.camel@intel.com>
References: <20260730200819.GA1520846@bhelgaas>
In-Reply-To: <20260730200819.GA1520846@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|DS0PR11MB9478:EE_
x-ms-office365-filtering-correlation-id: 1a6e0b8e-6c74-476f-8944-08deee77732d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|10067099003|18002099003|22082099003|6133799003|11063799006|3023799007;
x-microsoft-antispam-message-info: e+Fhm0sB9Mbze3NUrpV5iG/X6rSwh2160GDNv8Zbwr1wHcp1NPkOiMv7RGxJQ1LwDkUKSirrRtD1EDLeZz+C4qGkWiJTs5IsLokcJNoB1paTV5k9ImkVj5y8k1PxcWLOBkBXfTwLUhATcEhC2gQBCV6gkZLFbqGn9uoKHvrsktXi2Podl2Kmg/CpudKvwTLBoJMw0zm9w8kM5T2V/hOM70zrBK+ZgkC/KwmJrclfO+UtvE8+pLw7oeUsyO1CjkzWQEkcL/JZfQO2tKQDSk9SofdOOjKrWq1MMeGcIsEe1FWASzbo7po0gz0KWdFydihW1+GROfbnqK8FPr/RtLgW8LdgWPnRaApY7oBQri0WDF2NFRIRJoqOaHUU99KI7pV9gqt3Uc5k944HyMT7WDAzm75eFOYt28fYQfi5eW39O0kY1BMtwc8091jQJ8SDWqSPUG79uakoz7FosByEY8l0Pc8GOQ5qT7Jg1av0TacHAit6UvBOcBxnfxFIJwxBA+FvbLw+Rgf2KR3jsDoQo9G3jO2MPxHhl7OmEQ+Sh9FlOvYvfo4X5DIsCr35gZ0wfflqZGMvg5hw59R52AnMyZkfTBlWbij+2Qe5TFQNLkBZJd7BiylTxCMOjl8AOZlyOl9qOH7FtaFL1jpT8Pftwb62+wQoVNz7uJHTmm8cJEL3hPId+U1yjMEbIlBlraQR8NbLyKSEovy5GFx4yxM3IzpjQ6L8y6VvqttcT0z5xN5TMe0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0VsQWlsNHdtalh6ckkySzdmbGw1OGxZRHR5OE8weGJ3WHNkRUJMenR0eUJC?=
 =?utf-8?B?d2YrRVI4NmExVFJaSTdEcTZnZ3JCU0FQVXF2L1FsUmhLSURoWWtTNVpoaCs4?=
 =?utf-8?B?ZWJUcGRDMy83Z0hFNnloOFhENm9MN1hBbTkwR1NWSXNueUxXTjd4N2tCbDlo?=
 =?utf-8?B?RlZuejZqOTJMYzlsY3h0emM5VTF6bTRGWWNsMlhxZFFwbHhvNmMvams3ekxv?=
 =?utf-8?B?UTU3WEw2UzB6VklONDcwNUlpYXBBWU4vRnlRS1krUTdJeExyZVViMm1RdDBs?=
 =?utf-8?B?RUJaZ0ZKY2hTZ3QzMnladDJnL3VlSWk5WmF4TFBTWTV0eCs1LzNETVJYcUVM?=
 =?utf-8?B?RjFqT20yUGRzWDVzakRmcnY2REUxV1U4SlZocExucURIaGtqLzAxRGpxV3g1?=
 =?utf-8?B?TkNDZ0x5Ui8wZ3BkeGRqWmlXTEQ1K05BQ2pSMkNUeHpLMEtSdkZLSzhpc3k1?=
 =?utf-8?B?cXI5YTQ4U0pxMGFKTE5rTXpTbDZ6bVRtOXUvWmNUU0ZOTXY1NTM0MnlXWSsz?=
 =?utf-8?B?WkF6Y1dzZEErcUFaYm85amNXd2x3eEJuMnFpczdQOU9qL1lIUnRZTEF4VjBv?=
 =?utf-8?B?b1l2bTNZQ3ByVk1IM05Ea253cEdMczZwUzBoczlhKzQ2elBoRVpVNklyVzdu?=
 =?utf-8?B?OG13MDlDRGpZZTlKSWVCZjVyTUhKVlU2NUFkdlVEVG9wNXlEN0RQeElvOHAv?=
 =?utf-8?B?K0JOY2FWSEtpTXFVRmF0K2xZVSs1cU9qa1R2R3JxS1hRUHdpYm82dHYyMzBu?=
 =?utf-8?B?WEEvOS9ydUZUTE1FWk41SmpXc3V5VDZ2RVhVREp0OFJNYWg0ZE9RdTFBZjBN?=
 =?utf-8?B?ZjVYdGVIZE5DaXJobDJvU29WVHNocEZGbTRvK0d2WUJTY29NSkUwM0pkSEVH?=
 =?utf-8?B?cW9zWExZakdFY3ROZ3NUOGhlbFpHRjJNSG0ycjdHZkRucXl4azZZdC9aQkM3?=
 =?utf-8?B?em5KaFI1LzRZL3Y2UW1uUW9OQk1PbDBETElsdzRBeWI5Nkk1YjVKOEhLQmpz?=
 =?utf-8?B?WGFQRzRObjZMOGprc005bC9jcFlMdnVJNUN1R2ExZ0Y1eTg1MllUZTRhWmti?=
 =?utf-8?B?SDUrRnZRWEF0MjNNdFo0OENtMGg4UUNsS3owSmV6VTYwR2FIcDNaOUNtTE9W?=
 =?utf-8?B?QXYvSmVMSVV1VkZiTDlrLzdtc0xMVm9YcDUxTjc4U1hEOWU0RzNsL1BIMFhY?=
 =?utf-8?B?YmNzeGhaYlVNNWxpUXRVOUFHUEZlM3d3VTVUb2JlRGRnU2dWWWc4NGpxblpH?=
 =?utf-8?B?UmJQK1F0cUhFbiszb2VlMG44dXpSNW1nRXVEeU1PQlNkSTZMS0JMbjFFNGwv?=
 =?utf-8?B?Q3I3d05paU1aeWIrK0VaM1ZodXRhaE9IZTUxMENWOGpTOUhWd2VNcFpiNkI4?=
 =?utf-8?B?aG9GazVIUVFkaVp5L0dHMStZR3p3Y1AyMU5kaEZIeDNlNGttTjBHa25tR2cx?=
 =?utf-8?B?Q1BpbGVWYjExMWt5aHl6NGxqWDFIandNeDVWanplcjJobjZZR2JYR0dWOFdj?=
 =?utf-8?B?TVNBanNXOHZhNmhFT21xMHF3VTF2QXZTTW5zYlRVUEJFV3dmSFRaYlJiMUNE?=
 =?utf-8?B?MTl6YWlsYnBuclIxQ0JmWm1ROFdHTkV1YXhaMjJxYW1lb3c0SmNhSkYxU0l6?=
 =?utf-8?B?ZjlpU1ZSQUhEQmpwVmlzK0EvNUlOR0ZoL0ZPQTB1b1puNUg1RHZDMXdkaGFo?=
 =?utf-8?B?STJlQlA3U2s0eWkxSzl3S0ZZUFZJbHppdGVrMTE5MWN4T0I1TlFzK2xKSFNw?=
 =?utf-8?B?U2ZlckdFa1lBMHY2V2d0TlFwL2Fpcnd6VUxtMzdnRUE4MnByUUR4ZW5hUHJp?=
 =?utf-8?B?NkFCQUluRVhLb1ZhRVRzY0RSZ0FGOXRCVUVqUFpzcDNyT0QvaFdDRS9tSXdn?=
 =?utf-8?B?NmZIR0NLZHFIZjBtZlJacHo0R2wvRVY4REFNa2FHbE5uZ2p5MGZmdm1EYmo5?=
 =?utf-8?B?eHk1NGY5S2JVRzBOdTJzQlQ0MkZUOGdBWXlHWXZkeU8yZDBHV1M4NnZjSFZC?=
 =?utf-8?B?NG5xOVZoVnQyNzNBOHJUVFBUaGFLTEw3T0d1S21BdUxoT2hET2VLWDJldE1Z?=
 =?utf-8?B?M1FLMXNTZWJZSnZDK0pQYUhvNDBQSVhqbm91SHVuVkhsREQyM2NSRllYM2RV?=
 =?utf-8?B?WUFFVDlGQnZYWEZndTJHRzdiRzhEdkV3NkdsMnJKbmYxRXY3dElXb0Npa0Zr?=
 =?utf-8?B?OW9xRUp0ZTN2bFdqMnZIUUtDcklEdzE5Sy8yZ3FVY1NIU0JvWUFsOTRqNDlH?=
 =?utf-8?B?N0ptLzMxSThyQVQrQzdGdVFkdzdxRWo2STYyTDRmNjBLaWRwTmVCcndkajhP?=
 =?utf-8?B?TGhWcXkxVmcyMUI5SExkK3FidGluQVA2VE9Xck5mZTU5eG9VZkkzbnlHRTlH?=
 =?utf-8?Q?zBGxuScQsI3h1KZQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3CAA1EF41CFC14382786680E72FDD11@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s8tJD0FOHRjr5HHmvaDwOLcuCKW9lHUDd/ukPtZ9667KZXHRovBKoLSK5bkYot9NobuWs5mTTguWVWyAEuGLQujIzemi+bczLRO4omOnQ090YNRXSQmPCwfLNPuMKOmQzU6jSG9bArwIK/ztASbZ8o+WK2XkFYesvMrPpb65HN4M1ZHA3GamfkQtoTUGBLC5Kjkc+Hw30yCAqxPNegPyUwjzhPuTfEe4PKsCBKGC+ZZGrWkfTfHvIcnRCFJWkzIdHephDalMAAe0WESTYTFtUSw02QVccLhEPN5+z4To1Ugf8gaUj6lc5Cm95bUnORKS3shRwBezvDNgsSilhU8VUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6e0b8e-6c74-476f-8944-08deee77732d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 20:16:33.3827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JC8Lcq03M2KTy0ZJZGzKEbv7+HAmB1dWpxiWEOOfo3RBYPeApNdNIRtflPLKx+gD8xBY/X8hytss2eH+CiSOl+g+XH9S15HwoI+buHtylO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9478
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTMwIGF0IDE1OjA4IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUaHUsIEp1bCAzMCwgMjAyNiBhdCAwNjo0NToyOVBNICswMDAwLCBHcnVtYmFjaCwgRW1t
YW51ZWwgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI2LTA3LTMwIGF0IDEyOjI4IC0wNTAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdWwgMzAsIDIwMjYgYXQgMTA6MjE6MDZB
TSArMDUzMCwgTWFuaWthbnRhIE1hZGRpcmVkZHkNCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBPbiAy
OS8wNy8yNiAxMjoxOSBwbSwgR3J1bWJhY2gsIEVtbWFudWVsIHdyb3RlOg0KPiA+ID4gPiA+IE9u
IFR1ZSwgMjAyNi0wNy0yOCBhdCAxNToxOCAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4g
PiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDI4LCAyMDI2IGF0IDA3OjQ3OjA0UE0gKzAwMDAsIEdydW1i
YWNoLA0KPiA+ID4gPiA+ID4gRW1tYW51ZWwNCj4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+
ID4gPiBPbiBUdWUsIDIwMjYtMDctMjggYXQgMTQ6MjQgLTA1MDAsIEJqb3JuIEhlbGdhYXMgd3Jv
dGU6DQo+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjgsIDIwMjYgYXQgMDY6MjE6MjNQTSAr
MDAwMCwgR3J1bWJhY2gsDQo+ID4gPiA+ID4gPiA+ID4gRW1tYW51ZWwNCj4gPiA+ID4gPiA+ID4g
PiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAyNi0wNy0yOCBhdCAxMzowMyAt
MDUwMCwgQmpvcm4gSGVsZ2Fhcw0KPiA+ID4gPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
PiA+ID4gPiAuLi4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gQUZBSUNT
IHdlIHN0aWxsIGRvbid0IGtub3cgd2h5IFRlZ3JhMjY0IHdvdWxkIHNldA0KPiA+ID4gPiA+ID4g
PiA+ID4gPiBOb1Nub29wIGFuZC9vciBSbHhkT3JkIGluIHRoZSBNTUlPIHJlYWQuDQo+ID4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IE1lIG5laXRoZXIgYnV0Li4uIEkgY2FuJ3Qg
Y29tbWVudCBvbiB0aGF0LiBBbmQgZGUtDQo+ID4gPiA+ID4gPiA+ID4gPiBmYWN0bywNCj4gPiA+
ID4gPiA+ID4gPiA+IG9uY2UgaXQgZG9lcyB0aGF0LCB0aGUgQkUyMDAgcmVwbGllcyB3aXRoIHRo
ZSBOb1Nub29wDQo+ID4gPiA+ID4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiA+ID4gPiA+IFJseE9y
ZCBjbGVhciBpbiB0aGUgVExQIHdoaWNoIGlzIHRoZW4gY29uc2lkZXJlZCBhcyBhDQo+ID4gPiA+
ID4gPiA+ID4gPiBtYWxmb3JtZWQgVExQLg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiA+ID4gPiA+IFVubGVzcyBpd2x3aWZpIGFza2VkIGZvciBOb1Nub29wIGFuZC9vciBSbHhkT3Jk
IHRvDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHNldCwgSSB0
aGluayBpdCdzIGEgcG90ZW50aWFsIHByb2JsZW0gZm9yIGRyaXZlcnMNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gaWYNCj4gPiA+ID4gPiA+ID4gPiA+ID4gVGVncmEyNjQgc2V0cyB0aGVtLg0KPiA+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBJIC4uLiBkb24ndCB0aGluayB3ZSB3b3Vs
ZCBkbyB0aGF0LiBUaGUgZHJpdmVyIHdvdWxkDQo+ID4gPiA+ID4gPiA+ID4gPiBjZXJ0YWlubHkg
bm90IGRvIHRoYXQuLi4gUmVnYXJkaW5nIHRoZSBoYXJkd2FyZQ0KPiA+ID4gPiA+ID4gPiA+ID4g
aXRzZWxmLCBJDQo+ID4gPiA+ID4gPiA+ID4gPiBjYW4ndCBjb21tZW50LCBidXQgSSBjYW4gY2hl
Y2sgaW50ZXJuYWxseS4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBGb3Jnb3Qg
dG8gYXNrLCBjYW4geW91IGNvbGxlY3QgdGhlIG91dHB1dCBvZiAic3Vkbw0KPiA+ID4gPiA+ID4g
PiA+IGxzcGNpDQo+ID4gPiA+ID4gPiA+ID4gLXZ2IiwgYXQgbGVhc3QgZm9yIHRoZSBSUCBhbmQg
dGhlIEJFMjAwPw0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEFuZCBtYXliZSB0
aGUgZG1lc2cgbG9nIHdoZW4gYm9vdGVkIHdpdGgNCj4gPiA+ID4gPiA+ID4gPiAibG9nX2J1Zl9s
ZW49MTZNDQo+ID4gPiA+ID4gPiA+ID4gcGNpPWVhcmx5ZHVtcCIgYXMgd2VsbCwgc28gd2UgY2Fu
IHNlZSBpZiBhdHRyaWJ1dGVzDQo+ID4gPiA+ID4gPiA+ID4gd2VyZQ0KPiA+ID4gPiA+ID4gPiA+
IGVuYWJsZWQgYnkgYSBib290bG9hZGVyPw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
SSBhc3N1bWUgeW91IHdhbnQgYWxsIHRoaXMgd2l0aG91dCB0aGUgcXVpcmssIHJpZ2h0Pw0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBSaWdodC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBdHRh
Y2hlZC4NCj4gPiA+ID4gPiBOb3RlIHRoYXQgd2UgdXNlZCBhbiBvdXQtb2YtdHJlZSBkcml2ZXIg
aW4gdGhvc2UgYXR0ZW1wdHMgc28NCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBrZXJuZWwgaXMg
dGFpbnRlZCwgYnV0IHRoaXMgZG9lcyBub3QgaW1wYWN0IHRoZSBpc3N1ZSB3ZSdyZQ0KPiA+ID4g
PiA+IGRpc2N1c3NpbmcgaGVyZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFBDSV9FWFBfREVWQ1RMX1JF
TEFYX0VOIGFuZCBQQ0lfRVhQX0RFVkNUTF9OT1NOT09QX0VOIGFyZSBzZXQNCj4gPiA+ID4gYnkg
SFcNCj4gPiA+ID4gZGVmYXVsdCB2YWx1ZSwgdGhpcyBpcyBpbmxpbmUgd2l0aCBQQ0llIHNwZWMu
IEl0IHNheXMgInRoZQ0KPiA+ID4gPiBkZWZhdWx0DQo+ID4gPiA+IHZhbHVlIG9mIHRoaXMgYml0
IGlzIDFiIiBpbiBib3RoIGNhc2VzLg0KPiA+ID4gDQo+ID4gPiBIdWgsIHlvdSdyZSByaWdodC7C
oCBJIHdhcyBhc3N1bWluZyAwYiB3YXMgdGhlIGRlZmF1bHQsIGJ1dCBpbmRlZWQNCj4gPiA+IDFi
DQo+ID4gPiBpcyB0aGUgZGVmYXVsdCB1bmxlc3MgdGhleSdyZSBoYXJkd2lyZWQgdG8gMC7CoCBB
bmQgdGhleSdyZSBib3RoDQo+ID4gPiBzZXQNCj4gPiA+IHRvDQo+ID4gPiAxYiBvbiBteSB4ODYg
KEFNRCkgUm9vdCBQb3J0cyBhcyB3ZWxsLsKgIA0KPiA+IA0KPiA+IE5vdCBvbiBteSBJbnRlbCBS
b290IHBvcnQ6DQo+ID4gDQo+ID4gMDA6MWQuMCBQQ0kgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlv
biBBbGRlciBMYWtlIFBDSSBFeHByZXNzIFJvb3QNCj4gPiBQb3J0IA0KPiA+IA0KPiA+IDxTbmlw
Pg0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIENhcGFiaWxpdGllczogWzQwXSBFeHByZXNzICh2
MikgUm9vdCBQb3J0IChTbG90KyksDQo+ID4gSW50TXNnTnVtIDANCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgRGV2Q2FwOiBNYXhQYXlsb2FkIDI1NiBieXRlcywgUGhhbnRGdW5j
IDANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEV4
dFRhZy0gUkJFKyBURUUtSU8tDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERl
dkN0bDogQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0NCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJseGRPcmQtIEV4dFRh
Zy0gUGhhbnRGdW5jLSBBdXhQd3ItDQo+ID4gTm9Tbm9vcC0NCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhS
ZWFkUmVxIDEyOCBieXRlcw0KPiANCj4gU3VwZXIgaW50ZXJlc3RpbmcuDQoNCkV2ZXJ5IG9uZSBh
bmQgaGlzIG93biBhcmVhcyBvZiBpbnRlcmVzdCA7KQ0KDQo+IA0KPiBJIGd1ZXNzIEFsZGVyIExh
a2UgaXNuJ3Qgb25lIG9mIHRoZSBSUHMgYWZmZWN0ZWQgYnkNCj4gcXVpcmtfcmVsYXhlZG9yZGVy
aW5nX2Rpc2FibGUoKT/CoCBJIHRoaW5rIDg3ZTA5Y2RlYzRkYSAoIlBDSTogRGlzYWJsZQ0KPiBS
ZWxheGVkIE9yZGVyaW5nIGZvciBzb21lIEludGVsIHByb2Nlc3NvcnMiKSBhZGRlZCBhbGwgdGhl
IGV4aXN0aW5nDQo+IHVzZXMgb2YgdGhhdCBxdWlyayBmb3IgSW50ZWwgUlBzLCBhbmQgdGhlIGNv
bW1pdCBsb2cgb25seSBtZW50aW9ucw0KPiBCcm9hZHdlbGwgYW5kIEhhc3dlbGwuDQoNCldlbGwu
Li4gdGhhdCBjb21taXQgaXMgZnJvbSAyMDE3LiBBbGRlciBsYWtlIHdhcyBzaGlwcGVkIGluIDIw
MjEuDQoNCj4gDQo+IEkgd29uZGVyIGlmIHRoZSBQQ0kgY29yZSBzaG91bGQgZGlzYWJsZSBSTyBh
bmQgTm9Tbm9vcCBvbiBSb290IFBvcnRzDQo+IGFjcm9zcyB0aGUgYm9hcmQ/DQo+IA0KPiBJIHRo
aW5rIHRoaXMgd291bGQgbWFpbmx5IGFmZmVjdCBNTUlPIGFjY2Vzc2VzIHBlcmZvcm1lZCBieSBk
cml2ZXJzLA0KPiBhbmQgSSBzdXNwZWN0IGRyaXZlcnMgZXhwZWN0IHRob3NlIHdyaXRlcyB0byBi
ZSBwZXJmb3JtZWQgaW4gb3JkZXIsDQo+IGUuZy4sIGlmIHRoZSBkcml2ZXIgd3JpdGVzIERNQSBk
ZXNjcmlwdG9ycyB0byB0aGUgZGV2aWNlIGZvbGxvd2VkIGJ5DQo+IGENCj4gd3JpdGUgdG8gYSBk
b29yYmVsbCwgdGhvc2Ugc2hvdWxkIHN0YXkgaW4gb3JkZXIuwqAgSWYgdGhlIFJQIGhhcyBSTw0K
PiBlbmFibGVkLCB0aG9zZSB3cml0ZXMgbWF5IGJlIHJlb3JkZXJlZC4NCg0KQXMgYSBkZXZpY2Ug
d3JpdGVyIEknZCBzYXkgd2UnZCBiZSByZXF1aXJlZCB0byBhZGQgYSBtZW1vcnkgYmFycmllciBp
bg0KdGhhdCBjYXNlLCBidXQgd2UgdXNlIHdyaXRlbCB1c3VhbGx5Lg0KRG9lcyB0aGF0IGluY2x1
ZGUgYSB3cml0ZSB2cyB3cml0ZSBvcmRlcmluZz8gSG0uLi4NCg0KPiANCj4gPiA+IFNvIEkgd291
bGQgdGhpbmsgd2UnZCBzZWUgdGhpcyBNYWxmb3JtZWQgVExQIGVycm9yIG9uIHByZXR0eSBtdWNo
DQo+ID4gPiBldmVyeSBzeXN0ZW0gd2l0aCBCRTIwMCBpbiBpdC4NCj4gPiANCj4gPiBJIGd1ZXNz
IHRoYXQgQkUyMDAgaXMgYWxtb3N0IG9ubHkgcGx1Z2dlZCBpbnRvIEludGVsIHN5c3RlbXMgd2hp
Y2gNCj4gPiBpcw0KPiA+IHdoeSB0aGlzIGJ1ZyB3ZW50IHVubm90aWNlZCB1bnRpbCBub3cuLg0K
