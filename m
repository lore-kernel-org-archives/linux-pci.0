Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066A33507C;
	Wed, 18 Feb 2026 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458119; cv=fail; b=UVyAhA5psqIkIzjV4jD9ocm2CXplYNbnhD8ba9agJfLQ7CPy9hSr85p/Gkxp2yDIC2HjvpfSa11RQ0RERaxVKbBeuR5DeP7jV5vpsOMJrwdzNPHgKZq1/9ZPL76Z7qNIKZ9Xi0M869qYgXj+nuQlZiNM+MNrwW2+GtkXUehT1Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458119; c=relaxed/simple;
	bh=KzyxFsYyKr3G8mxm0e8Nvu7OpZ5pyaYmUtjUzX4xOxY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=mwlGDqHycSER7jMYtAhH0jr7ibJKBNVCJ7NNixkjHeb2uC0MKaOvqY63w9qkvo9Zx74gBttm14yTWHkBHjQqgL98NjJuYrE87AB6YJZkvu7Uh0oz5AOl3UNOACwSChhYRKw/SJ11vsdQ29FvB0AS29WIOE8aECYWwurluFQLQoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+f8MND8; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+f8MND8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771458118; x=1802994118;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=KzyxFsYyKr3G8mxm0e8Nvu7OpZ5pyaYmUtjUzX4xOxY=;
  b=e+f8MND8pKCXXdFeDXXePH4VC84EQfk10h3acPavXRIWF0OPVvgsaDIc
   4S6xslfzyVGto3NWt/k1d7Do0r0YVp2XLoDVBboL0ytIncqZIYFFM2GBm
   lavRTyDJfDVo0Cy/0UgAhq3BGdeLGQsx9bQyM5AxlDIlsaRuyxocUX+Be
   qe4PSEaepEJ5lgnd60T9Ckq3bzQpaFM13YPcVzmS5bkYdEaLGd4pirQaK
   XkphS1a4MipiIPTxeuUdEIgmYw2EeqeyXm8LvoAGwK/ldX7UNzzGTVvRB
   kCTWhT/IYDLwd2IXGMfze9qjProWG+OQQx64Gzh680G+8BxtQg1YelOK/
   w==;
X-CSE-ConnectionGUID: FsTP/9SZTwyvvnL/6hSGQA==
X-CSE-MsgGUID: Q/Sdx71sTBiVHGAPy8nxZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="98005314"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="98005314"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:41:57 -0800
X-CSE-ConnectionGUID: 9Jtr4U5oTpCRY+q6xWWOpA==
X-CSE-MsgGUID: UP1DzuKYQNud91x481Js1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214354292"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:41:56 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 15:41:56 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 15:41:56 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 15:41:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGgZAxOZ+TlO1Rpubkz0cT5pcX9TMe9iT5IZMGw6Metaeu2iMAX6JwOtlLxHFXa5WeaV93kE4EdHf6Y0mmEma+EsTuYNdTfNyoqNn4Z7O42UhdRqyg2ZrWHpFrJFQhftaz1Eqyi0HU7LkXhr8XxSy5TK7foBFbd8DqtWyOJlpEdpA3S19U+Qk88tmIqkisiypCznKaHhz1dyqL2nvp3PLpx/PcEkIlNkJhgsRAu27ut8WY6RFc58Jovipk6fphgzq2QVekw5rFVk5YED/2VI1RY1mi1UyNGktNObbpvOPAXV+EKBXUbkSJAwOlp6AR3D9X5tn+ro3dJr3MEOS+hYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9dQ9cfUEJlups4Q1YGUaCQOgajD3olNUUxp03ZOS+Q=;
 b=E4KG7jsS49tD0mDktv9v0q2Ee3qUYRdhlNOM0OHwFbrDAqSY/VZoQFYskK2a8gHakvRTJbxVdEIsTO2yCSaOmxSXs00Qv8dBCvQDGm5XEQyYxhmwm3OrQSS8mgSZeY7oRWAwr6Y0CIAEo/c1Bp2AL7U2v4mxe4Z4oqEYJZ5DdyNYidcWWW4qKZFL/3OdGV9jjIRylitvJ82K+Gglml//CUQ0DeDEb5/t4EG7EzK6oYbdceoiUxF1uohoghfXk/JYi5OF9qZncH0CVeWkyZvuVhgmqsrPNANAerUY24ADjeCq4ekWtXZyX6bnQt63mNpSOOlvQtMgLpx94UWepRt7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 23:41:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 23:41:47 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 18 Feb 2026 15:40:10 -0800
To: Alistair Francis <alistair23@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: <bhelgaas@google.com>, <lukas@wunner.de>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alex.gaynor@gmail.com>, <benno.lossin@proton.me>, <boqun.feng@gmail.com>,
	<a.hindborg@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<tmgross@umich.edu>, <ojeda@kernel.org>, <wilfred.mallawa@wdc.com>,
	<aliceryhl@google.com>, Alistair Francis <alistair.francis@wdc.com>,
	<aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
In-Reply-To: <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260217235604.GA1595019@nvidia.com>
 <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: d79e1dd2-bcb3-4e3b-7d98-08de6f4747cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWQwS1pDNnljRWlpMEFpak5VL1U2VDdqRGJ3YW1OZmVlMWRtQ0NyTnUvYUI5?=
 =?utf-8?B?OC90ZnRIY3BEbzFiYTNVSW9zY2NTSmt4YnM1T0prdjNjY0tML1N3WS9ZbGNr?=
 =?utf-8?B?dU5yRWh2M0grcTV0OVlJekZRbWVjaEtEZ0RDRTk5OFY3MVZJRnJXbzZGWXBB?=
 =?utf-8?B?Z2dOMUlQaTc3V1FSUkpEVmx6Qy9xUlBsUHhyMTRWLzRjU0E1amNSSmoreHhX?=
 =?utf-8?B?bDQ2b1NsR0ovWHpEQXZaOHl3U1lSbDllNTdYMHJRSERpZHYwMG90M1BKaEFK?=
 =?utf-8?B?UzhrRWtBeXNkR0xxMDJyVVFVRU9DeDRRV3p3aHo2bHZUc3hhdVp0bnA5VHl0?=
 =?utf-8?B?VTMyN3AwSWIwUVE3Rk1rM1BCTnU5b29tc1JXWVNIM1laRUFOb3lRM2VNTW1T?=
 =?utf-8?B?WWEwUGdWb0I4TzZiSnNUYWFRdGgreTlTT3J4SWgxOFlhZjJkSXZ4Z3U1SDNu?=
 =?utf-8?B?RklsQytVTUwxa1JrcmdESjlhVGw0UDJHN1N3TWFteU11VjF2YjJxSG1ra2lB?=
 =?utf-8?B?VWIvcWxWbTh4Smx4bFltYkNuSnlnTis5emJyRDJhazJuVXUxZld0UXBQSWor?=
 =?utf-8?B?SGNOU2hJSG5SYUFHSzVab0xob1R5K0xvVXBqalM2dnZyU0VEMWpUY25FMzJQ?=
 =?utf-8?B?WjFFSDhabCsyd3hPNDFWYnpsejVVbTFkbE05ZWpNOXRGcHpldktrbENSRXN3?=
 =?utf-8?B?bnl1QzhPSnRnYWRFMGRtZ3ZlRGpxbzg3MzBRY2JxQnBSTDcxcjRza1pKb3Z6?=
 =?utf-8?B?aHJ6WFlvU0J5VUUvUUdRMGJiNStvVnJtbFljVUQrY3BvSWx2eUUycUlianJC?=
 =?utf-8?B?NHUwWjFSMDUycG9heFFtQ291NDlSUW1IV1I0SkFDbUZCVzdCellsemMzMmpP?=
 =?utf-8?B?LzUxUzVhOURmbGVzZ3ZHVHp3c3YyRlFuaEdwMDREUjNGSWU0T2h1Zld5Q2xK?=
 =?utf-8?B?a0ZRTGZJZFcwWnhRTDNuRUMzSmVheU9vQkVTNmJMTWdKSXlYMERndldXOUw2?=
 =?utf-8?B?TVIvRFREOTh4VUZrbitIaDFXSnJGK0p4Qk8rcGNISisrNXVBRFp5MG5sQ0ZC?=
 =?utf-8?B?ZEdQdXJmN3UxZk41SHh0eUM0Z0VrMjltUDRLUkRmNElYY1J2STR5U3ZHOTA5?=
 =?utf-8?B?blBUQUY1Z2VuaHRBL2RXbVBJTWdHV0lHUVhLZEpMc1M2cC9iSHZsVHNvWk9F?=
 =?utf-8?B?eEw4SWZ2RmxYMU9tZ0xVNmYzV1g0OUZ6b0ozYUlZYzlYV3o4RE5CcnYwcjhN?=
 =?utf-8?B?YXd1c2UvWjc1RWFZT0JTbGVsNFlVWkpuWUQ0Qm5JSDlOQlZDeUdOMUpkZjQy?=
 =?utf-8?B?UjdtanRFeWl0T2greTdSWTZqS1VUYmVkejhJUGU1SGxmYjlLRll0Z1hnYUFH?=
 =?utf-8?B?QU1vT25Ia09Jekk3dlY5SHNYc0JldDVtTDRVQ0RMZ3dBZTRxSVovZmo1dmor?=
 =?utf-8?B?K0dqdTZHNzR6b2htbVpHaWhLTjFpMVVOdFNMc0J3Q0xIblFSTFN2TmNTcmk1?=
 =?utf-8?B?NHR1eGJJWGlYNlpKS2FEbFFRUTVRSUVHTU1TOFU1Rm9XaVVEMVNnMWV5dmZE?=
 =?utf-8?B?TjRRR0VIMnl0U3dlUitVVnBBSGpkRnM2U1ZZUTh3dkRwN1ZRL1FLcHVyTW1M?=
 =?utf-8?B?aGd5STh4MjI3RzUrYy9KeDM5eU9zeHkzUU9haEhyZ093TytTbFkzSEtpZ3JI?=
 =?utf-8?B?VWRaYU1pZk9IcmhicFNvVEkvaDBoalI4Y1ZpMGw3QWVVbFpFeWhHdXJVZHBt?=
 =?utf-8?B?OEJWd3Y2ZzFkVnZLWXhSRzh5SXNBVW1tYk40aUJ0WXJBTUZ4OVRWMHA1Tm5K?=
 =?utf-8?B?RGp5cDNCSHdDbTBDa3N3NzlxZm5OTjFjb2FIVDUrNmErK1RSRFRwS2luQldp?=
 =?utf-8?B?Njh6R1VlRXNXTlpuMWw1UTVscGxjWHBpMFB4OU84NlNaN3F3YXpubGNaWndZ?=
 =?utf-8?B?S1d0WHVQVHdkZjlPc041MWVEeS81Sm4yZUUzalRXWVFKN3RRekR2QW8zb2hD?=
 =?utf-8?B?aFltc0xGOXJXd2VWdTVyNUhJa3JjNWJYSVpIcndIR0w2K1didXFIZmFmZzFC?=
 =?utf-8?B?cy9BK0UvbEdlbWFxU1c3dzJrbUQybDJXN0N3aWtGOXlZdzBnT25zM1JLN1ZB?=
 =?utf-8?Q?qu8pQcMNkVPwUyC/Al2h/vSAt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STFlMDduQlFVWVdla3ZKUWQ1MkU5Y29HMXFuQkdPUXc2NU1UOFFadHpwWXhJ?=
 =?utf-8?B?aDNZZEZ1a3RzblhjRExDcHkrcGt6MitIQnN5MEViMzQwbTRBVUhybDR5VWE2?=
 =?utf-8?B?RE41NWh5bkNJZ2RTOTVyaGZ4OGQ3eXYzZGpVNmJaTmZKd0lMa3BpWFBSQTJC?=
 =?utf-8?B?Rlo0VTFkLzFOS2RKYk9uSEIvK2RaMldlZ0xkSWs2U2R6a3BSUWJ0dWFaWGU3?=
 =?utf-8?B?blYyMVQ0TzNaemxYdHNlcGo2YWZzWng2NncyLzMzRHR3bG92Y3hMWUdOb1Nt?=
 =?utf-8?B?WitNK29MVU5EM1V5VjJRcGxBSzV4bE9vMzlyL2FTUTdQS0xoNmcyWksyQURP?=
 =?utf-8?B?Wm5MNFMvUUFxc09VdXJjL1BpanpHU1RLZ1R3aWZQbXpKbmhtMEY2QjBPTWRM?=
 =?utf-8?B?N0N0L2ZsTG84L1orb0JoM1p6SkljNGRyUWZxbnFDRVc3Q3ozdktDUkw5NnhS?=
 =?utf-8?B?WWxkVlk0QXpPdE1vTTJvcTFjVFB1R2RmQU9vM285dWV3TC9WNnpJaGxUTERz?=
 =?utf-8?B?aHVkYWVuUi9PbC9DVTFBem9VR25weFZ4WnlFWW1xTFRuS2VsbXd3OFhFZnIy?=
 =?utf-8?B?bk84b2RSdG1FbzVJaExkV0dQSE5lMnZVUzhkY0IzRVkzYVNKaUhRSTB6bWJi?=
 =?utf-8?B?dW5zRnJ3aGU0RXN3Vmx0U2VCWExGOUZaODdiRkRKQVdkdUhQNDIwUlp1WHZK?=
 =?utf-8?B?M3JpVmFVb3orWUJwaGtqMzgrOCt5MzNxNmpCd3I5ekg5VEtrV2MwQitITEtt?=
 =?utf-8?B?Kzd6dll0anAxOVRUamVBeFluZCsxaG15K2h2Y1hMMjQvTUR6TjRMUkNiV1Ft?=
 =?utf-8?B?d1p4S0dFTmN4azFOdGtNSHc5YTVJTkZoMWFGOUNRZ09oVnZtbkFLTkhYcEpr?=
 =?utf-8?B?NitxbHpKOFFySVUyS2Flc011ZFlRbFQzKzF1d3UrRXVjZWI1TjYyaHdlNnVS?=
 =?utf-8?B?YWROTW5ETkR3a2xlK3E4b215SS9sdTVhNmpmRkNUcGJkMUFRU1MxZ0pDVHF4?=
 =?utf-8?B?V3Jwcy8vTUJxZWw3VXhJWW4yaUptRWdYWURyOWdoa1M2eU8wV05oWGlON2ZC?=
 =?utf-8?B?TGFkU0puSVNCanF2WDhGMUNreDRmUDJJZkRFVGp1SnRIVzNsSjJDTGJ4Yk4v?=
 =?utf-8?B?U0RYTDlod1BYM1RrSXY1ZGNTYm9JMnE5YUNNNkU5Uzd1dmk2VVk0NWhCNmUy?=
 =?utf-8?B?WU9qTUZIUWFkSm1TWklJN0RLLzd6UVVKSU5WZndwa2E4d2JUYy9TSG0vakdO?=
 =?utf-8?B?MkM1ZjVkM3hJS3hmNkkyZ3Z6Z3V4NURoN0FuaVRIRXhyUTRGOE9vRVJaTFBx?=
 =?utf-8?B?c0dXQU5jQW5xa0R2bk9IMU43azlhcFNweFVBYzJGMTIrQk0yVDVabEFXcHN0?=
 =?utf-8?B?MjFobU9qcjd4bmZMb3VycCtnYXJhcTFaYys4TkFwNVptdFgvTHI2RmZXZGov?=
 =?utf-8?B?WFVHVUUvcU5RczByRXVLUDRaa1NrZHRnaEk3dDFnOTltbmNkUUlXbUIwbTJu?=
 =?utf-8?B?NFZyNjQ2Q2V6MEVRNnQrN2tMQndJSTFFOStTY2JQbFE3TysrUTUyUjBoUG9h?=
 =?utf-8?B?NGtUZHZ6Qkh4K0c3VnhxYTN1VDk1V1ZBQ0tFU0xmcTBVdzBMcTRRanphMTlt?=
 =?utf-8?B?QUVhOFF0Q2ZNTnoyNnRuNDBrbElHdGZSd3czRFdXd1htYmNPYm16Mk44NW1N?=
 =?utf-8?B?R1oxR3kxVUtQdUlNQnZHQnRsbnlPK0lvT2JVTEc2R2JwL3lIbnU2WmRBQnJV?=
 =?utf-8?B?OVZudFhvMTlQa0gwR29GUGE3bVdUbGlhazAxSE45dW4wMDFKQnQvVUd6RWxU?=
 =?utf-8?B?amp0VDRPTXFTd3JJb0FRVE5ocU9vOXhsN3hzZHBac0xUaThLcmkrOWVuVjNq?=
 =?utf-8?B?d2ptNFFIYU0wN21UWG9WK2lyRnFpSlk2SzR4Zk9qNUFKWFArMTFSc3d5VzNk?=
 =?utf-8?B?K1FLTXc1VER0QWI1bUpjSXlTdi8wWEhOVXVESHN1QTlmdUI5T2J5NE9tRU5E?=
 =?utf-8?B?TWNOSWNCLzlIZThDSk83YmM5eDlvaHZFNURmL25tVWR5WTdCc1Y3azk4ZHdV?=
 =?utf-8?B?cmlNSEJieitGZm5OcEt0OHRkNDhpNTdiSlRxWkZIU2YvWFczS0Y4U0VzR3Bi?=
 =?utf-8?B?Z0hNVkFvKzVsYU50Nk0wRjJXcC8yckVhNk91Sno2NDJxaTluRTVDTmxVZ1Zp?=
 =?utf-8?B?VnMwL3lCWjR5djFzZSswbVNmeTZTOHB5Zy9FaVNtcU5GSkNLdUVhTVFiVDF0?=
 =?utf-8?B?Yk8rS1RMWjh2ZUZOT2dQdlMyV2t4YXRSRjR4ZW5PTVhkbSt6SkwyNXhpMnZk?=
 =?utf-8?B?QlRTaHZ1ZytlWS91TzcyT1NQN1JWNHE2WFhYU2RTV2NweVQxTzJ4MXVHRkF4?=
 =?utf-8?Q?cij16EfI0d7y9uQg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d79e1dd2-bcb3-4e3b-7d98-08de6f4747cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 23:41:47.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DsLlnmjAmzHV2xZgeNQnomFPUprXov84c19nV7ioVMtayfX9b9yDGYQ225qU6noAa2oaR8rFkxBeVk6HQfhj7nynTZzysk5TIDs5om+EeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com

[ add Aneesh, Alexey, and Yilun ]

Alistair Francis wrote:
[..]
> I'm currently thinking of splitting this in 3 parts. One for the
> ground work patches (crypto), one for SPDM (without netlink) and then
> a final one for netlink support.
> 
> I feel that this RFC proves netlink can work, which is important. For
> SPDM the authenticated syfs attribute is enough to provide usefulness
> to userspace to merge that while sending the netlink later.
> 
> That way hopefully everything is a little more self contained, but
> still has users and value to justify being merged.

The split sounds good. I chatted with Lukas a bit this morning he
rightly pointed out that the crypto pre-work does not really stand on
its own without a user.

However, I notice that Aneesh needs x509 certificate parsing for his TSM
driver [1], I think TDX would benefit from the same to offload needing
to specify the wall-clock time to the module [2] for cert verification,
and SEV-TIO (already upstream) is currently missing any facility for the
host to attest the device.

[1]: http://lore.kernel.org/20250728135216.48084-17-aneesh.kumar@kernel.org
[2]: http://lore.kernel.org/20251117022311.2443900-9-yilun.xu@linux.intel.com

So one proposal to get the x509 pre-work upstream is to extend the TSM
core (drivers/pci/tsm.c) to export the certificates in sysfs, and update
the existing "authenticated" attribute to reflect the result of cert
chain validation.

This provides immediate value to the TSM "connect" flow and is smaller
than depending on the SPDM library as the first consumer. It also feels
like useful refactoring to split 'struct spdm_state' into context for a
session initiator (SPDM library) and context for the artifacts (certs +
measurements produced by either SPDM library or a TSM).
