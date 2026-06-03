Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C839B4BB;
	Wed,  3 Jun 2026 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472088; cv=fail; b=Lu1GBMI4yIJJ41DnetUQJSBLDsxbgOCofaA7TqdYe7CdimKnxnPK7hUgmf49gxXsjRI5qWPgM82RifhO65HKFSD9rpJns0AMpAnmSdYT7bw8Oj/1epifjMXfJ+GCwpD34UweB2zZiEgrM+c4RBxPr9tacZT5ERsN4AH3rQbxox8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472088; c=relaxed/simple;
	bh=9yHF6H5iQ9KYdoo8WyGtCWMMjuIXRw3bW7l7b+n43zE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VF7y/0ADptKquMBTiFFsUPnlQtlkIzNoMLx6bOKu76Bjh80aCiXqaQWr+4NYBYoB5F6c5Qxlr6q/DNaAAc2eBiNEpqB3eQh+ITGlj/Z38Jf5NJgTMXmzi5R5TJHvsLAbn5121ZQOjGSUJ6WUHNARFqfC7efPu990qmepGWcyCso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ct9nrrb4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ct9nrrb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780472086; x=1812008086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9yHF6H5iQ9KYdoo8WyGtCWMMjuIXRw3bW7l7b+n43zE=;
  b=Ct9nrrb4kTcUoq1nVDomYdTYBBowdZCcTRudt46YpaHfBIlwtlsFRwQl
   BUGx06Nehdjyk5wSPAmv7DS54MhQPN/fGTfTGPvv87ipsJ5OqewTyJJi0
   YT/U/rjW7W0xGNlZfKxLiIMPNvanXl29XsOD6KyIRTFviSSj5NTFCPbuZ
   sNfG27SFq/loKhP4VoSZ1/61yiN58RgMJe6belKF39vNQtRRiSOp3f40j
   0t4aDK7v8SCeEZzhDK5TVCQ0b/E1KIC2t/CZH3C9PeAK4uolXH9EDy8MK
   jfRWHmS0nVxu917oh571e+PG46dKvwhQyPh1h9LEfKQC8O+mwqdJ3pUDX
   A==;
X-CSE-ConnectionGUID: 8qcrCu1yQ3OEx1VQAelD9A==
X-CSE-MsgGUID: BefJ6wC4RI60wITuP/Jldw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81267024"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81267024"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:34:46 -0700
X-CSE-ConnectionGUID: NmDehRW1TKq0wRBbrxPaQA==
X-CSE-MsgGUID: rxGL7aAxQmqYUwTUNPqxoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237787668"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:34:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:34:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 00:34:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 00:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtQ9Ax+LQUpr44qlzAlbQVmyarsf3OBhCdZHDS3s89PZnbefrkCHom+w9s51ZV0UaT2IN6UG2Sc0oALaBJY5dU89uREc3GSY2dJevqEK3Ly1ieC8hJ+B80gJ/4h2OLHq43ivPnaH3eGovTXvd1ximFyhblbbrw1+ZspU2P+u+fEc6v5dOY9PS9njgiJJkg640BFWnPvu/HUhplZceeDPvYJseHBLY2QAcFr7ldRnyFgv3PCB+PGGTIWJFi84U8uPkhsKc92QL87ahoGyQgRVuLtaSjbWOpIHIISpXN6GETMrNT19/8z6SUEkv7z2mnoyucKDnTMYXD6V1balDsVbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yHF6H5iQ9KYdoo8WyGtCWMMjuIXRw3bW7l7b+n43zE=;
 b=PPjtGoZpdRLmhbtkbWCa1MYXJWgLRKVbMdStJ/Sr2upFFmU2pbmMdSBPO20i9jtO1WqrrWMwsDNhbCSCI9eOH0zFYyQmnj7xTF2tp7PJ7LtifjeiMsFhCj0LGJwykawapDEZKiJre4140HgzXiDIkv8PtAQ9o4V05nxmXMfTQVo5Z94h0zsdFluZF6nAJDoAR081BMqO2ii4Mz+zh+If77iHkO2DoSy06k6sQ+vPK5naW7MlgZGwavlchVHmRAPvvkcDHYbfQ35m4G0DK6wM/ibXeTtBCpvIb36XajbxWyLnrXW1ilkKcvH/cVjI8mlzwRywOHPT+xlE35NdvZ0Uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 07:34:40 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:34:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Pranjal Shrivastava <praan@google.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>
Subject: RE: [PATCH v7 5/5] iommu/vt-d: Fail probe on ATS configuration
 failure
Thread-Topic: [PATCH v7 5/5] iommu/vt-d: Fail probe on ATS configuration
 failure
Thread-Index: AQHc8dQj2WgCKDZFukCAK1icpUMm87Yscypg
Date: Wed, 3 Jun 2026 07:34:40 +0000
Message-ID: <DM6PR11MB369008FAFC19CA76EF723E808C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-6-praan@google.com>
In-Reply-To: <20260601143644.2358771-6-praan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|SA1PR11MB8328:EE_
x-ms-office365-filtering-correlation-id: b97b0b79-bbde-4562-42ba-08dec1429260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|5023799004|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: uI+bqigTEdYHsesuDyDGw8+nmEfJ18MBBExMpZApFui1Rf0/lm2i0TIC5SGZKHU4qoLzLzJHmWv+1r8R4mUaNy4CSrBl29rBIed+8hOyOFxuycIPd0O8aLLuC3ua6dapGfZptq2OehqV5y36pkUM+xGxbC8KP141dx9hJZYNXJnM/FWY9jhiSIPsUOZhx+uadFi4TYttO4WWDl/N96K6wp7luADgxg4R2PwI86vdwKXIJhnUz5dwMcSyoSMoCOJdiA3jMPSuICUq/wTVlFswn5Gp44eZmk1G4/UT7+kBkMMv1SlTm+zKFb/jw4UOAfVaS0jh4IQjHA2u+D/cZz4giPW+XKJ+LODTex6kpI2DDXNO8z16Y+rf61GEsKanYeg1/X7m3MRCZ95PaYT//u9Qs5CEfPL9XQKYauwQhSiWnnOzT6Thf3hFGcRLgpB6c1VQ2ur/9jiFX3bIkQCwjBoX7KsQqzBHbBKTezjlAYRStXNlDDIV5nFwdwvH7KvqdRhsE9JqNT37Gj/jl5d2JO2LV+9tJezydhwfsPe2r6wOiLsJMoAe2pPS7ue0qGvhxSz66o6Nkb9oHUV5gDteZr5Y0LwTsdFm4jdvdJ2J7HiAuuB2kx7lDuJNwbo/sg1iueipVsteDQKIRZjoU0Lr/NMG+uQJdNr7qLXOjOeTP1hfRSSeMIVJF8jSgOYWqoazLewVxt1O3IvaHiNXSZusku+cLJ4fqRak+0Z3Z299S7b7Iva3sXJOruwco2e8OOKE1pl0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(5023799004)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NCtMeStua0xXRmtxZFp2VGYxdDJDeWFvWnBqQ3lRZFc2RVNSY214R3ZPUjVn?=
 =?utf-8?B?eFF3ekZMSHplem9vNzFWaWdpSU5JOWJvR0luSytjdmxZUGViZ2k3WG95NThG?=
 =?utf-8?B?N2lrRjNxV0JiUHBMRUJDTnR2ZmRBZExGZmhzOFdkRHZhaU5qY216Q21WUElr?=
 =?utf-8?B?T0NwWmxYRXVRVGdjV3hLNFFkdWxqaC9zV2dXV0RjYi9ETmRlK0QrekFmZldR?=
 =?utf-8?B?VTl4VjdWY1BpVEc1TmNUMXZhOWxiWkdaUUtnSGwvZ0IzS05XRWw3bllPbzU5?=
 =?utf-8?B?bEFqd1duR2NGZDQ2cXNxVWFuS1U1TjBDVUphK3l3ak5yQjhQdmowdFE5SUUx?=
 =?utf-8?B?UU5iUDQwQzB1bktyWU5HQ0tDeHo4c1BRbG0vbUdiOHM2K0VBNDlDTWdsM0Zy?=
 =?utf-8?B?bnlqd0JtY1RnWUlQQTB5Sjc4dWV4UlJTSWExeWJ5Sko1UTVsOUlDZjQzQ1Bz?=
 =?utf-8?B?bFF1Z2lCZGtveklyaFJvMGNDK1E0bk5MbW1jQUdxVWV1Z2hTM0F4T3R6dHNC?=
 =?utf-8?B?TTgwSzk2YjJHL1VKZ0VkbU5YSVlzZ1BzUUpGWlYvK0FmTU1zQ2UybEJadGQ1?=
 =?utf-8?B?alZaRzRyNnFzNDh0cGxTdFA1T0ZmbHdQUHI5Qnl4WFJydjJJaUJLWk5wbzZq?=
 =?utf-8?B?NmthVUZxVDhwVVlzdkJScTZvVnVPTGZ3ejZtQmYya1ZpejB0ZFViemdwaEl4?=
 =?utf-8?B?Ym11OUJJdXNWWmZlcFh4VGxOSXg1NkdTSzhyaTBmQkRzTVp2T1U1VGU3OTBS?=
 =?utf-8?B?c2Z1TjYyUWtjTC9RT2ZzQ3o4WG1zeXBnYmVGbnRmVGp2cTNaRzFRRnpGSjY3?=
 =?utf-8?B?NzRGV2s2d1p1bDNiTHF6LzhhTFZGSGFPc2lTRUpKU0xzaXliWGdyQU1XQ3dk?=
 =?utf-8?B?UFhHV3ZjQXA5dFhpUzNpVHo1aU8vcmIvTTFiUEx4UWI2N0MvVGxYc2w2eHZY?=
 =?utf-8?B?UGoyOGNGS0NmdWgycUthV2ZhSGswQ2JUQk43eEt1R2grUXVXbk9aMkZpU0pZ?=
 =?utf-8?B?K25BbjYvLy9uVnJHVm9jMGZFQzBrZWlXU2FlTktWVWd1dDRhYklvVy81Mmxp?=
 =?utf-8?B?NFlSVUVJTWJTd0NuUWcwaHV0Tm1ucCtwZmdmMWtaQnkxU0dQTEtLRlNZamVs?=
 =?utf-8?B?cnVqRDJDbFM4dEgwd2ZzU1dMTVh5OXZwc1VVdWErOEpwSFRzYkhsT1ZCcENw?=
 =?utf-8?B?dFJVb1RZT3NLQ3dPVEZrRkY4VE0yTjhRQkVRRHNUYkJJL1VkMnh2b0FOQWNL?=
 =?utf-8?B?djM2NjFyeERUZ3pUQTc0YW40c21VZDBoR2xDUXZPOTdrd0NYTHZJQXZEVEgz?=
 =?utf-8?B?SFpiam1SRlpGcjZ4cTZvZjF5elFlZWloRHNqWXVHSG1yV083R1UvU2FCeHA3?=
 =?utf-8?B?S2czUW41THlUVmpSNnFkNlQ2NGsxYzA1SjNsc1dFSGdweDQ5UFF3VXdMVTlm?=
 =?utf-8?B?cmJZOE9BNVJrclJUWmhpbHZTdkN5TEdCVi9rUlJydHlJSkZTSXFXMy9UTUtW?=
 =?utf-8?B?TWM4SWwrUlpadldwOE56SndaSkd0SW16TlA0SG5VRnNoUjFzaTlvKzVhWDVV?=
 =?utf-8?B?NlZRTC9saWxsZE5mdW13RjRmNWRZb0R2SEh1NWs1NHRhTjUyd1BNQkhjODBO?=
 =?utf-8?B?V2VISUtnVUorUVVxV05sRERwdUxLb3Znb3JlaWZGak9NOENaM01pNE1zNFRX?=
 =?utf-8?B?cUtsbjVCZDRpd3lBYndmS2R2NXJ5MFFkR0Z6M0kxemFaNC94eTdDMTV0WDFa?=
 =?utf-8?B?U3QzNm9MRWp2aGYxTDFzOWdtckphTkxkZU1UcUZ3dGl5Z3J6MUpRN3N4UHNB?=
 =?utf-8?B?K3o0NHFHVi9KT3JSL1hZQ3BxN003K3hFeVdlclBPcUR2dGRxSFpxc0NOTlRE?=
 =?utf-8?B?cVk3UFMvS1ZSeU45bVZMeElFZ1ZqSmFadVkxS2tXVVpFUnhvYXZxZThDQUZP?=
 =?utf-8?B?M2J0Qmp0WDdPWmZoSEZpd2NhSDNzdU5tOFFGV3N0N0lFNW9oWGY4SXgxKytn?=
 =?utf-8?B?ZFNTVFB1YUhKNUdKOGN5cGxlajlkam1FS3dJVERsaG9SRksvT3RweEEvcXJm?=
 =?utf-8?B?M2ZKK2luU2djSCs3bTVlUENoMERhdjExMlBScTRxYlZndDNlL1lOaVprVlpD?=
 =?utf-8?B?RE9qRktLZVBpeHFJOXh2bzBOMldmUE9YNmVEMktWVUlLeUgyVHZ5KzZhUERH?=
 =?utf-8?B?QlhkRlpMQ2JCVVJFOWVUVTJUOW1NVlNVTFNvYW52YnJSeUg3ZGNlTnJQT3Jk?=
 =?utf-8?B?b0c1TWJjeDhaMjdkbnVQZjBYd09zWFRFc0ZjdHN3SnZJTVhCdE1ZVklRVTEy?=
 =?utf-8?B?YnUzN3plTlFLTm1rWFBKb1RlUy81V3RWTTNJNlBrNDBXTXNIaUU5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ef8O0qL+3+zHVpWWRbIJHZl3SJsEY7hQK9YZTUk2WbNhHFBl5LOCNN2HlZSigPSZYXIQwexf6qCbXCUpB0IdYc3PxRY4CtOHlTGg7QXB2/HzB7VcBfiyBD7YJS3pDflbK0QNKA4W7TUkYAu89vjKZUUcBfV0gMTlmk6uR2EjESN1Dl4r5XjHK5c89W02nI2veLPPFq0VtSqdTF1t3FqH9F/XNytYZy7nLhyWuhDX2VujviebUgBr9pxfdroCvQ1wjPtpZJM0862F/EuuCINyTfciEtUJtc32XIY6ge8k15WHmGoW6t4n7MaHtMHMNYwgF05BbthDuU2EvTiqCeow3w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97b0b79-bbde-4562-42ba-08dec1429260
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:34:40.0635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdXi4fuFJt5OTEYfMA2nvt5xiBKHEDs29Of0eURbbrh2lUG0w+5xfiuhHir3tYrs/h+IPDOWiBozo2QQ6VR3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

PiBGcm9tOiBQcmFuamFsIFNocml2YXN0YXZhIDxwcmFhbkBnb29nbGUuY29tPg0KPiBTZW50OiBN
b25kYXksIEp1bmUgMSwgMjAyNiAxMDozNyBQTQ0KPiANCj4gVXBkYXRlIHRoZSBJbnRlbCBWVC1k
IGRyaXZlciB0byBoYW5kbGUgQVRTIGNvbmZpZ3VyYXRpb24gYW5kIGVuYWJsZW1lbnQNCj4gbW9y
ZSBzdHJpY3RseS4gU3BlY2lmaWNhbGx5LCB1cGRhdGUgdGhlIGRldmljZSBwcm9iZSB0byBmYWls
IGlmDQo+IHBjaV9wcmVwYXJlX2F0cygpIHJldHVybnMgYW4gZXJyb3IuIFRoaXMgZW5zdXJlcyB0
aGF0IGFueSBBVFMtY2FwYWJsZQ0KPiBtYXN0ZXIgcmVhY2hpbmcgdGhlIGF0dGFjaCBwaGFzZSBp
cyBndWFyYW50ZWVkIHRvIGhhdmUgYSB2YWxpZCBjb25maWcuDQo+IA0KPiBBZGRpdGlvbmFsbHks
IHVwZGF0ZSBpb21tdV9lbmFibGVfcGNpX2F0cygpIHRvIFdBUk4oKSBpZiBwY2lfZW5hYmxlX2F0
cw0KPiBmYWlscy4gU2luY2UgZWFybGllciBjaGVja3MgaW4gdGhlIHByb2JlIHBoYXNlIHByZWNs
dWRlIGNvbmZpZy1yZWxhdGVkDQo+IGZhaWx1cmVzLCBhbnkgZmFpbHVyZSBkdXJpbmcgaGFyZHdh
cmUgZW5hYmxlbWVudCBpcyBjb25zaWRlcmVkIGEga2VybmVsDQo+IGJ1Zy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFByYW5qYWwgU2hyaXZhc3RhdmEgPHByYWFuQGdvb2dsZS5jb20+DQoNClJldmll
d2VkLWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==
