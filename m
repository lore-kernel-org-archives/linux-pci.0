Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68838B7DC;
	Thu, 23 Apr 2026 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963916; cv=fail; b=nFdYP87ixP6MQUlKsVZyfbANZriJg4Sl13glq9CEMRv+cz4ByIerg+vaJyGTD68faLmZXZDIpWAk/AqvRend+HdRs1oHnDIkeyILBIiJzAGPCSGo8/X/YC7BqJBX0OfiuCo9NAUkfVO56zT22NVI8dCl32pNEzHOLosQ152JOLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963916; c=relaxed/simple;
	bh=3n7Mz+9/GF5Dd1oEDGSSkDw8y1pnGd4KmmpoIvQO/FI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l/5nmOowUOlBn6xACYBbpBO4vXDGzYbTfMRcRuYGmzQ72LDZkgrXoZi4VE39AXQ4VY90Nke62BDQ9PTxLsH/2EBamnYb6FhsJf6j2wLXerEU5tbGG65X6Z9AE3xpEcycjKbAQVpV2yPgI8aT6QiwERMRHC7jj7gQ6ba2zKq34AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia16dzpN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia16dzpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776963916; x=1808499916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3n7Mz+9/GF5Dd1oEDGSSkDw8y1pnGd4KmmpoIvQO/FI=;
  b=Ia16dzpNtX7gSPLJoBpojw6M4A83jv9pvLFVznzSXthudBvGANarLtF1
   Mio30XE8TDJo41BV18/9er91EEun/BSRCbcE7UcyYuWrPw/DQzKt8jAY1
   iE579dDupyRu479cSwe4uxNchUZBOJ4TS8cC/MQ1U324Z85g4P8zohPkK
   MjtVOIypczLHRR6V2G12c112tGL2DQsq5dAvmkKG/+qS7Ms1xY0P0FMjO
   ltQVuliyAOGW/K/aW7tQzbhsomk+5mnUealK2gIgKWWoj6qxQHGsCyQbk
   +J0L8QKRaiMtSAPjAPQkZBgUQeCRfBKxuNteBT86ObrBJqEB+Em6fk1kZ
   A==;
X-CSE-ConnectionGUID: HBbVmcA8T9mdmkPmmKrEOQ==
X-CSE-MsgGUID: VEtlBY/GR+6Ycx0CrqnOCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78132141"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="78132141"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:05:16 -0700
X-CSE-ConnectionGUID: 9zLgl7flSYCB8iHkyX6NDw==
X-CSE-MsgGUID: EITrIxMbRHm1oew+mUN7sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="228143233"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:05:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 10:05:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 10:05:14 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 10:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpUreZE0thZD0LOyfEcFszfdv6PIFV4iN22TiYVR/L4pdVO5a0hYz7R/NFXthjv8lZis9hUZ1UX1dbNX+19vtUl2NV2s7qT3i4NbzSWRSsGVfW1OZARgcLWm5KPozygh11M8fQI4WNElUiCO/vn/kToPGv6Tvf4QJu0suV9YfUGyJmXcymWekMCt0GFrEMW+2eqy38bcBilpup379tWw6kDs4z/VeuBYAVvrEA6ZXb61TkC3dDAsY/5xPzKN3pI+suEa6CbmaBFpUOj34Dw/teRuG+5abL+jm+ovDjzV1CrNxYvt1qBgWugxSIpSdMu9hLNqnACBIw7r8SUU4Lzh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3n7Mz+9/GF5Dd1oEDGSSkDw8y1pnGd4KmmpoIvQO/FI=;
 b=OOS8AQ/zzlLBM6betNcB9mlgyKY7koK60s7Aubv/wyPmbk4aCkjwspKPZKCHsWlWDiMq5V3aIehec0uA9ytMgP30uunsbrBQsCmiWWuXloOT70GGsdWM4MV7mppDpp4ekyLJU3zry5JFuYIcjjWLjm40XNtfV9LhD+KtX2slW1rRPUhzhJf1+YxQMNZinU+YFUMEA59kRzQSpg5W1jUxh4k71aVqbIVDFfzGc2N/vQCroPwUw/6Q+sbJ2g4QXx6zU6Eb4DlawVcrkFkceKqSg6iTHl4ENSxeufW03d2oSsEg/fvxksdH7xJNDh7iJiwRqvsssVltbCyN0wMfjBulsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 17:05:11 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 17:05:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Thread-Topic: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Thread-Index: AQHcvgYHJkre5vG7jEePV/TlncNhDrXr/POAgAENmgA=
Date: Thu, 23 Apr 2026 17:05:11 +0000
Message-ID: <3b0bc0dea544b10bd2fb0304a96d2671f263829b.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
	 <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
In-Reply-To: <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB4989:EE_
x-ms-office365-filtering-correlation-id: 8e83af20-660a-456b-5e72-08dea15a7ab4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: hq5mcISQlu3nIsY/3hhbV+vDbtQSR9eBb4jvCYxWArb+1Wu93+TV9jQf/6lwqdazDCsqW0A9vnLEL6j7qaW4epI97D1yE4m8+EgliPkw4IL9j5qagiguBxM38p/y/CaLTlJdcuqKjKb5NT/gHMveEMTyuiBLWYCC2W1NMnI4ncXXyEg/ev6jOkY/+pHGy2PK1/LmJyRIGT6iNGZ85YoLvrNQgvorL2Uz6NJdtgwwIZr8plVBMCEh74fj28Q2BLRf7Xs8kGzgm/gWRRUfeYA9FffdRg/1UNbQG2EVi4f8x2DmHrVTcB1k6f6TE1ZAz/wlm+QfPhEvWyNghRDorffU71QY84Lm0qxQVG8AjLjePLKBjvS91/PgxG3RhGQbnfe7LkOu3cDEIEc6FIRqwxhbN1SElIjqPdPurY2M6YYmKYvo3Eb7r9V6OTZX4pKYskfk/QTh5udskMtcJ0OstIDIpLMOITLRsSHtFCaioqsebMBGNy8I9yftT6M/e/+BhYDnqtyKFp6pTnhKjIJB4fq8pfqtw9v7E35m/fSguRZXwgDyMuJdy8f79HE9QafQDjiK3IN03MHZaW0xyUzDzgPvOywsu3KUT3hAcaVAtyuSA85b5Gld7BeT9a/1qVES8U9CrptLh9nbSQfdqPeO6JtZ0hd+NU3VlWUuewALhZ/b7ekTk4sC8yiduLaY3H/wCSfesvpyE1tc8SShxRHYqG2tv9Y0M/m20/73FVkmg0GRIV4z17sl5IwV0jK4ncbt+TQSRzbOKy4g58+ZvlW0cDBMWs55oTA9UqI4Hyek9kuIzcc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVFMTnZhVGx4OXcxSUpqYlNjdmlFSHNEeDA5WnBmQ0tycUliTWc1bmViZnQ1?=
 =?utf-8?B?QmQ1VUdvQzdkc1M1bzhaREF5ZGxyczNqekxpTllwK2dNS0hkTFpqRm00eHI0?=
 =?utf-8?B?eC9JcXB4VEI0UVdycExBZnhNMDNLS21kR0JYeXZMU0t6SlV3UnlSVzZQaHdO?=
 =?utf-8?B?SXVLZlBCZ252cDNSQTZzMzVCd1ZsT1M3RERrbWhSUE9RS2E5WU5YbGoyS0d2?=
 =?utf-8?B?NE15d2RQMU1zN2hIb0JZNy9nVDRzQWVpSHk3d0g2UWI0RlZtK21CaHJ0ZU5s?=
 =?utf-8?B?NmRrdTJMYlNkQm5jQkdwSmxZSDZmNEx4THIyLzVJMmRCZStyZ3lzMTczbkFu?=
 =?utf-8?B?RnlQWjYzOWRhb3h4NDJ6U2lIQ21ISkh0VGk5cWplQXljblNJd2RVTldqYjlv?=
 =?utf-8?B?eks2Z0hUNVlOdlpqVU9vUDFqelJnazBWaHFSS2VtWUNPRnR5WnRmODBRZzMw?=
 =?utf-8?B?Y01obDN6QU9vd25PZE1oMDAwWDdlN0JBN3RVNi9xNC8vaXhhMkREZk0xUzk0?=
 =?utf-8?B?bHZRUjVoSXEvRG9Dd05zR3Y3K25FQzVyMnV3K3U2UjR5c2FOUytRdFdLalo5?=
 =?utf-8?B?cjZpUm5ZWFl0TWpralZlMXNQcFhlcEJIZ2I2MGgyRG9lc2g3TWNuN2JEWVJa?=
 =?utf-8?B?aVQxVHhSYlU0dTljV3A3N2lkNDNGd2JGS2Vmb05uQnRydVRhd1RqQm1TQzY5?=
 =?utf-8?B?bldZREdydDVCbXdnQlFOVXNaR1I3TVFiN0pkaXU2SjdPM1ArZWZoZlBzNnBT?=
 =?utf-8?B?Z1RscWgvemtOcmo3VndjM2ZVbTZsNkd5NTc1a21IekhDTWcvSTFKZVA5RUFx?=
 =?utf-8?B?c1VsdEZpd0RSSWdjMUNQUzZURXE1SHMzRENSVncxaTZES3BvOHM5V2w3bzA5?=
 =?utf-8?B?Wlgzc3BWY0pvTEFjNmVacjBjZyt3UzRhVWlKWkphZjlzUnJEN0lOeXFQbmIw?=
 =?utf-8?B?SFBFMWVIQUhtYWRVRU02emg0Y1B1c0RsRTUyZzVYY2xxaFRsMm1QdDRINkhD?=
 =?utf-8?B?bkt6QVBOVnN5b3ZzNTZVT0Y1SVkvVTRKOTRTOXpXZU1xeTBXRFRUTFdOd0JK?=
 =?utf-8?B?NXN6Y2YraktvYXh6L1NnTjBENDdlTjVGNGhlYnh6RWIwVlRLRTJJS2dGdGlW?=
 =?utf-8?B?SEN1aVBWRkRDWDRwaFEvdEQrYkRUajYwNnlWbFBMT3B1bHF3d05na01lVUlz?=
 =?utf-8?B?VTdFMC93cHZyOFlXS1hlWlBGWnpRQ3VncHVYMDZHTm85blRTM2JUOU5UTUFV?=
 =?utf-8?B?QjFCU2IxNzdIWG1CV095ME4rN3JMNFE2LzdQeW8wNmFYS2Q0TzlTNW1uZXdN?=
 =?utf-8?B?bFY4L0xsSGloa0piQmovYktCZ2FJOFNsVWw5MFVWT1o5cWFLdWh3WmU4SUtl?=
 =?utf-8?B?aGc4UGt2L0VSdDFzZ29sbS9lWWtpbklXMjlYL1JBcGJhR3YrQ253aFgzUzV5?=
 =?utf-8?B?MlQwYW5JRG5yTFNXOEtMOTI1M1owdmJyNkh6Rm1OOHdsV1BZVmV4S2tBS2Rj?=
 =?utf-8?B?SGtXSjFkWGZ6bEJhYTFpcC9SWHZiNHJieFpsOXptTzVHMFhMcnFwSEtwZ29x?=
 =?utf-8?B?eWw1WVByaC8yTytYQmlmcnZyMUM0ZVd4WGpZNytIMXo2a21SQk5HalpGZEEr?=
 =?utf-8?B?UC9iSCt5ODQ0TnpCc2IxLy9sVUFYZXU4cGJnUnFZVlFWR3dIQmRPLzNDUUZW?=
 =?utf-8?B?UW9VSmluSFZoampUQmFIem5kQ0dDOGtFVTJkRFpRMFl1QXh4MDhhdk9VSnJh?=
 =?utf-8?B?V2NxbDVwNm96SnJkSTl6U0gwekJJRjg4MHN5Qk9vMVhkc3p3RXUvSFB0S2Ni?=
 =?utf-8?B?ZG9xT0hqRWNYaDQzMWx5OHlPTC8zSkFvKzE4TmhVQ2orbFN3VHpRTWRsbGt5?=
 =?utf-8?B?cnNPc3psZDFqVlEzSjVYYkpzYnd0dU5nVVI2SEg0VERvU2plTy81R0NYVjda?=
 =?utf-8?B?QkplTXBlUE9vTUlxSmVyL05nZ2gxSXF0ZjZEVXRNTnpEZ3gyS2cxNXU3OEs1?=
 =?utf-8?B?S1ZWQkdyQmxLWjhCUmhqR09nc2kya2dxZEcrT25LRVdHR1NrMmlaTmRlUUhH?=
 =?utf-8?B?dzZGajhUdHozYVkzTS8vWTdsM1ZKTENIRzBZQUxOU1N1RDF5TnV1VHJjZWFV?=
 =?utf-8?B?MkRhOXVGVkk0RTNNa3BsdzBlVW5Qam9QL3lVMXVGNWUyWTk2V21LUnFHejN6?=
 =?utf-8?B?ZUhYVXNOL3BVeDQzTU5hSEUxeUlrRWU3WWpIcW1rZDhTaVc5RE1BZXhieWhw?=
 =?utf-8?B?elpTU0VCOVdTMjMrRmszMmk5b0ZEN2JiYlVoTGluYXRvV2kvYVErdUJ6UjJK?=
 =?utf-8?B?WWI2czdDMTVYMmh1NkU1SWpGeTZ5MVp3WGQyajNGOVJwakJ2RXdtWmRGUllP?=
 =?utf-8?Q?LkHxxvnHppyziFgg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ABC2F01DE233943A1D689CA53B113DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n+iFEnqDJKoYUAdry94MKsAZ0uwFDP0uQmzdg7cDbMMf77RcR1wj/PtdLArWiupnHVcL60t4KoLHJNNTfdSIRFwJHIylH9AmcIPxjLOy6ODiRZcoL7vf8FHwdsA64xvEuhLb4dEWsDC8vqgm9+PSkjE4JRqc5t34rzjm9TR3eKSXaleyFgI5w/k3YjxGwpjx/Ly42B8c6llxHFfHnY3VvPPeK4ZO0A+m74+DgNueDAEVfdzvKD8KTGBOZLR/dIB4ta8FPc7ELJ0fHL5sRctPaP4uZQ099uxYxoqJbL23Yp8q8wXDacvH08VELl1XGon1GOfMs075aYBwSpkn+dCCyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e83af20-660a-456b-5e72-08dea15a7ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 17:05:11.0423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmV5XmsmtWSmncktmWR4mtjxkd4YjfnuO805j/5mDm+shkBNU5j3auXJT9L0oWskFOqGOLG1t5n6nnEYpN/XopO03n+bQvGEUw1Xh5eniwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4989
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTIzIGF0IDAwOjU5ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBE
aXR0byBoZXJlLsKgIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGludHJvZHVjZSBhbnkgbW9yZSBj
b25kX3Jlc2NoZWQoKS4NCj4gDQo+IEJ0dywgSSB0aGluayB0ZWNobmljYWxseSB3ZSBjYW4gcmV1
c2UgdGhlIHNlYW1jYWxsX2lyX3Jlc2NoZWQoKSB5b3UgaW50cm9kdWNlZA0KPiBsYXRlciwgYWxi
ZWl0IGluIHdoaWNoIGEgbG9jYWwgJ19hcmdzJyBpcyB1c2VkIGFzIGEgY29weSBvZiB0aGUgb3Jp
Z2luYWwgJ2FyZ3MnLA0KPiBidXQgdGhhdCBoYXMgbm8gaGFybSBmb3IgdGhlIGNhc2Ugd2hlcmUg
d2UgY2FuIGp1c3QgdXNlIHRoZSAnYXJncycgdG8gbG9vcC4NCj4gDQo+IEkgYW0gd29uZGVyaW5n
IHdoZXRoZXIgd2UgY2FuIGp1c3QgdXNlIHRoYXQgaGVyZSwgb3Igd2UganVzdCBnZXQgcmlkIG9m
IHRoYXQNCj4gaGVscGVyICh0aGVuIG9wZW4gcmV0cnkgYnkgdGhlIGNhbGxlcnMgb2YgdGhlc2Ug
U0VBTUNBTEwgd3JhcHBlcnMpLCBzaW5jZSB0aGVyZQ0KPiB3aWxsIGJlIG1vcmUgY2FzZXMgd2hl
cmUgd2UgbmVlZCB0byBtYW51YWxseSBzZXQgJ3Jlc3VtZT0xJyBpbiB0aGUgU0VBTUNBTEwNCj4g
aW5wdXQgJ2FyZ3MnIHdoZW4gcmV0cnlpbmcgVERYX0lOVEVSUlVQVEVEX1JFU1VNQUJMRS4NCg0K
SSBraW5kIG9mIGxpa2UgdGhlIGxhdHRlciBvcHRpb24gdG8gb3BlbiBjb2RlIG1vcmUgb2YgdGhp
cyBzdHVmZi4gVGhlIHN0YWNrcyBvZg0Kc2VhbWNhbGwgd3JhcHBlciBtYWNyb3MgaXMgYWxyZWFk
eSB0b28gbXVjaC4gDQo=
