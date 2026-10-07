Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412593DB655;
	Wed,  7 Oct 2026 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401876; cv=fail; b=UG8SiXwemUvSSJArYfl4EyOtxPmlAXSgVeyzgFupTgqGbRdp+gLeOMndB2SGhtiz8782mobKwQf0kD+CaKqHOHafadjOO61Gfgl2IxcLg34ZF5jvNsUhN6JC0vxWTRPJFzv+mGgoS4MBiUyJCwK1crV0ZtJzHJNCL1+g1o9C2X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401876; c=relaxed/simple;
	bh=Z4hBM24BR9AmBpHoGMo6wP04Ahtx1sVEx2BYPR+zV58=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jKLd32p8Z6CyZ0J1dmBPLWGJFnuU+yuvPvSKwOZNHL5tzzrD9avihVBPxWuvsU4qZteGr34tZ/9YvTtvmbLhkFSKK2dDMML3btMjaiJMg6kzTnCClIq9Z1I6FYP2l6c4R72jnGgpXQNv50vCGG2Xv9A3TYqInZ0vGjPJdSUtdNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAxUbzPa; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAxUbzPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791401874; x=1822937874;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Z4hBM24BR9AmBpHoGMo6wP04Ahtx1sVEx2BYPR+zV58=;
  b=VAxUbzPamCyHJ5HG8UuanNcjHuAdRlUvcWldIrwhZWmY7Nv1C81vmm9b
   NkYxUl0qZPOShDsevWLwVrVWuCOWe9xquu6Y9ma3i5lj1ZfH1Af/VOovE
   xVSIw/cvZq8qEqQxuOmAileIdJoj6aOPaBGXEMypCgKF5o3a2gO/vopEw
   FeMYFUE8RMXWwj5iIB0fyMC+tMlLf0Xsq8EchaTynKxTQ0rhnbcF0qtse
   QmdGS3s0gbX5OaPCytMLg/mv2lKEJioAm7jpaUQDYG7LDXDdrEjiAYZSo
   T0ELkkMh2YsFOlxK2QppGzToPUnAGF4F33huJfsykBx2EilXLB0W42FtR
   Q==;
X-CSE-ConnectionGUID: 1lcB1vwiSQm529kuyEIgwQ==
X-CSE-MsgGUID: XAM22U0DTtm4SnW0N8ShkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="70261"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="70261"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 12:37:53 -0700
X-CSE-ConnectionGUID: s28EF69BTbOmL55lilWI7w==
X-CSE-MsgGUID: 6Tj68IaTQbC2Xb8IZx7bQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1611175"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 12:37:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 12:37:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 12:37:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 12:37:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaGr8ILYOnmBZLKIhvx3rA8KEV1Ov7sMJ0Kd9nxd9m68/Ni+Tz2Cz9NVpz3fiGFy/WXXYWoIWBWWRzYPkA7edpFV2h+29rFc64k6AjJSWMh8UWJM7LVOT8UIk9bDKosprTa9kNwi2b5S2px/kWo9zoD0EErDhGBStNECdFP4v7u6lZmAZ1TV1dDxhKwgKulMyoZX0bibo1kcsefsd2XUbGesURbdDTvBPe2caXKypd9t4B17famDzKy2+fBzTJtXCalibKRuIzAbmqwXJGYoEgNerWZtTfLwBWNAAL8eQjpHtrlVDdxu+ofTHK/v5NpAgVgS0ot46bOhvdCXmxoaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtAeE8u8T+knuOagOSa64W9nQKli0NnWPKFaXEQn1G0=;
 b=cN0acBq2jvI0R3S0T03oGhR7x6VgeVCv3ZKNMKR9ROD1pJwWk0ygU5nRLbyR6UAEaf9wE3gZp4+i5tHYl3A+GTdwD/LIE2qC1bi2DyoEj7N33YtK7CacGkQsYvqOOfwm8BmoLhGsWv75X3uU2wN+Zrld6soemO2OmIqQIJf8FXGO3UpA9Ls9x322iTSJ6Bn01ENUxTmS5tu1Co0wtF0IHpiFMC4bHdTy2TG/P0CVvTX7GRdi00bslnC95bkwjOUr9zfvO0U4+vEJq+4LIm8TZPunAeVVnR8Kom7oaWsnm/y5xZ6KcViEDBQhiFVxFGlQtgvWhxX3hSl5vEqvOKwWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9086.namprd11.prod.outlook.com (2603:10b6:208:57b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 19:37:48 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:37:48 +0000
Date: Wed, 7 Oct 2026 12:37:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Dave Jiang <dave.jiang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v14 10/16] cxl: Cache endpoint HDM state during PCI
 enumeration
Message-ID: <asafh2lu2PJ465gF@aschofie-mobl2.lan>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-11-smadhavan@nvidia.com>
 <bcc1d04c-fd5f-4c65-bafd-c17b8bfe5011@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcc1d04c-fd5f-4c65-bafd-c17b8bfe5011@intel.com>
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b6a5f1-a34c-491a-2d15-08df24aa77a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|18002099003|22082099003|10067099003|56012099006|6133799003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: EuG3Ahpy4Dvpyl/B1JhVWWBIVplucMnPc5QnasQGQWiYxk/UlTUfxQaq8n0h1Q1AKH9E3pplMCuVynleLiCf1l2rMmfk/YJZ9aUeaJHnRX5aUbceVvZCw5SQjAYZA9SsH7MteCk2pvdxunj3jF6j2alYgQXzO1cPGRWsNlnd8+vBYEDbXg/ulSWnH0GJeQ52VD1OfiP7eDea8NULBbsBnwB4h17Lfs4DSvOfdsrf4wEgNC2So3A4U2OPz43+qbdS0USLM3/K2ljFcCO0L0flLS3Nuo42qMdg6ye8NSPctO1fo1KvuA/EI4D8P/1sl0GJyKDlVQm9gmGgJ4sDWdGP6odkUVURqgvLMgWdjPpJtXKGqx4BK2KHKrXtUw3a6nfLvNMHs0U/11iBGEAmZAT4m0A2z9tQV3XdMhG5NpR2A6JVXhTiiehqwMUzaeSy+zqKvIdpm0KGvzaBKROmjujW3Ry/k3cLif97LAYlasmuOdWjKUHPEX9FwCYhErylD05CWB3p1LXtRmwBbPEbTwjV0l8yWepWlHOE2RV5vCiXCNf+IwahaWrN7kgwfIw3YBNVpGDo6U7UBAMu2N0V/5Nfq6H2OkYWICXeklIyMjEIbcYxriP1BQnKtHWnL1VoqqMVtRStPGA66RhVdh+CQk0zo3r+mMwSHKtbsPHvU7ZgOrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(6133799003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRRdXJ1R2VqcnNTVllGMFoxVVdsdkxzdHI0RkZNRVJLNUNzc2xaTWZHajg3?=
 =?utf-8?B?K3c1RHFpd1BqNW1nL3Y2L3VMeG9IazFjZ0J4Zm9hOXJ3SlU1aW9WYlk3UW1N?=
 =?utf-8?B?ZG1KUGRxN1kvYlRyQXhBdFJ0R05OcVVZdnNUNWJFK1IwN3dDMnZRTVV5WUg4?=
 =?utf-8?B?bkZHRmRhNnExSmZLeUh1R0FEcTZDanBqVXdiTXlxUjZWUE0rOFlOSUhmV2hE?=
 =?utf-8?B?cDJvWlNwNFViNVB2TXQ1bnFSOXA0ZGpKS0NRdUo3aG1RSlo0cXBUeUdMb2gr?=
 =?utf-8?B?QXg2eU5XYWdxQzdtc1hRTWFId1RjR3dIYmJCY20vOHNrTE5aelgvNlpzVXBr?=
 =?utf-8?B?WXJ6VTRyMUF2U3ZXRUU3U2VNOVhMbk9HNFJuckVJZWU0ZnFiVHFJNXUydlEx?=
 =?utf-8?B?UVNCeWRaem5QWTVtQnlWckUxOTkxWmg5VFhTOFFCS3lQWUJqNEhVQUdpR3FF?=
 =?utf-8?B?TGRTWm1xaDd4eHVuUFpPREVsTXM4aDYxUmVHUHRXcmxKZHNPRWZwWEcyOGwy?=
 =?utf-8?B?R2NVaWFHZlhMcHlxRk00bkxhalJZZGRXMjZJYlhLSVY5dWFVZGhlVnhXRmV2?=
 =?utf-8?B?alExSFZLK2VYeU5nWGJGZ3Azc0NVa094amI4Zkg5TzA2SWlmY0xKVW94cDNL?=
 =?utf-8?B?aVRjRnlaeDRmZkZWSlkrMWgrbVVTUjNYdXVpTXBMbG1jbGJSU3piZlBYeFVz?=
 =?utf-8?B?ZkhFUXc4UmtJTmtQT2JDUnpxcVJ5bTRkNVN2dHFjYmtScDNZRmNQWERWQnJv?=
 =?utf-8?B?TkxmbjJyUW9tZGRCai9ZYjJrTm1SbGRrNVdvTlQvMGdhREhRV3dHUU4rTEE4?=
 =?utf-8?B?RC81SzQxMWdSRVBoYkNsdGNOTlJzUTlJQXB5bjhjVTFmNDIrb2hPRkJwWDdS?=
 =?utf-8?B?YUY0Q25McFIzaUVrdFV2QlBwOG94clg5eWJqU1BXR1AvUDFKOGhCbDUrWTRu?=
 =?utf-8?B?TFcvTUFDZGt6T0ZxSlhCdlR2UG0zV1hMOHBhbnBIT2ZOWTBPNHlJTllBd2Jv?=
 =?utf-8?B?YWdqZHg0YkxHb2hkZU5UN1VPNGJUMlhHYSt2VFQ2RXRPVlEybkZ5d1U4aC8z?=
 =?utf-8?B?RDJUVmlsSmEzUUhwL2hRSDBldmZVUEdEMjdnK2VLVjNENWJ6dUZXd0xNNlZN?=
 =?utf-8?B?Skd1SUFQN0lPdU4remtxZ1Eva0RoejIrcmExNVFHWkhDd21kdHFzTEw4RVBC?=
 =?utf-8?B?M3BOOFNzMStTVWp4b3NueWVna3hlZUtveDlUajk3WGhHdmt3QjNiNndNOWNC?=
 =?utf-8?B?VURqblM2YmFHRGs4Witxak1vUHNHRzBzVmhjY1RGaGRCWGVMOEs1UEJiNDJV?=
 =?utf-8?B?dStta3Y0S0hmVGZuOThobWtQdXQwYUFvMk03UXdTNHBNQWgvS0ttWFpESUN0?=
 =?utf-8?B?WmwvbDg3UlRUZVBmdjFtVjNxSDFObXY0T0o5VnZVdURwRGpKelNFM2NHbjJN?=
 =?utf-8?B?cnBMbFlGb2pmWS83b2tDdG5ZekdrWjVRL1IvUWtsZXJnekZYK3dtbDloWEVK?=
 =?utf-8?B?aTdBYlBGMVEyRVpMNlNtYXdOQ0tQaGkrWEhZblJSTG52SlVEd1k4TUw0b21T?=
 =?utf-8?B?aklsOHU1QmFla3pwL29XbE80TllSOVRwVnk5b1RPZ3IyejJ1S21vakRBZnBm?=
 =?utf-8?B?b2hHU3k5SkZuVDErb3RSb2w1eXYyWUdHb3ZmWnJEaWdPelhadndTRFNMRStW?=
 =?utf-8?B?WTB5RDhoS3RrT0xVRitWQklXNEt1RzVQaVBTV1dNK0NQelZqVlpUTi9BRW45?=
 =?utf-8?B?YTFrZWJDd201akIyZUt1VHRJTFQyMU9ZT01GSXpFamZ0K3Y4bzV3NHhyc3U3?=
 =?utf-8?B?WEVKdTE2NHNQUnFoU0poS2xzRFZFRWFPc2x1LzJPRjZVaERpdmxaa0VWbnA4?=
 =?utf-8?B?SjhyYkpCSHFWYTRnWUxKL0E2TXpIRVhTb3I0QVpobWQzbjl6RUFYUnV1aU1q?=
 =?utf-8?B?WFBmMHV2MEg2ODJhdEpsL3FuQ1FhM0dlbnlFQ2tvbytBUHR6eHY1czlQUGFr?=
 =?utf-8?B?UlRXZ2U1eC9nYWJRVmN5TThtYVlOS0Z2WEZoNmpnLzZyLzRlRmZrOHhYUlRL?=
 =?utf-8?B?Mi9ETjN4RWtJVTVjMkJ5K0VXMVhkb2k5SHc1NlE3enMxTzhqNW5JOEZUUHhL?=
 =?utf-8?B?K1JNb3NRblROMlNORjduMkR2QnZNVGY2NForUytBaVBtR3U1U3pzL1Zubjdq?=
 =?utf-8?B?RjEvWGZabUhMMkxMV3l0WXpMTVI4RytrY1VHSHAxaW5lQVFlSndvcWF6djM3?=
 =?utf-8?B?RzZBdHoxYk9uZTNFaDh4cFVoWVNNMkdSa0pDYlA5R09pR283ZjRVaENLbHM5?=
 =?utf-8?B?WmFkQjdzMVlPU244c2I5QkpVdUtPSHdWVU16amwrc2d6eFRhWGFTNWVSQ05E?=
 =?utf-8?Q?mbIujAf21MDvU8tU=3D?=
X-Exchange-RoutingPolicyChecked: Kax4/6PQ+Xl4UvBf0G6J4VIaNGWiAIku+SetlgghKQOfdEgC3b4Z/DzqChlbXoPfhlQXRaNYj4cmn/D9N4sL5bFtnITSMd1sLI46FAhskeYBsLZ7NZEV38lvblp6Xe1V9eGmf4x8BNlw+mXsX8+PAgK5vvJoq104jJ2OaE5ajb0gEv1Xu6VZPOJadbYZJHkfzfXbXMZkG8r/ZqQkpfq54XHHEo/aw8NrYyZJ9e9lbi+HuAKz/nFj+GyzFOJ1S2uRObNNHtFX9NgFxZ9x52gHL4A7gPeOMpElar2xZB31aQWJ22NifIp/MA1mFeyMBlAFKgdHQJWlBl2WRdR5Tu/fJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b6a5f1-a34c-491a-2d15-08df24aa77a0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 19:37:48.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVJMcQJAHDszj/ovOnjFtqJo+xTvZPNq9LHk1jOi05hpvcJ2zYHRluxNMBzRnBj6ZKX8lgKrLzMcpIvMpK6PrrO447y0iDB0qq7Z1gz+jh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9086
X-OriginatorOrg: intel.com

On Tue, Oct 06, 2026 at 08:39:37AM -0700, Dave Jiang wrote:
> 
> 
> On 10/1/26 2:22 AM, Srirangan Madhavan wrote:
> > PCI capability initialization runs before BAR resources are finalized,
> > while driver binding is too late for driver-independent reset support.
> > Create pci_dev->hdm during pci_bus_add_device(), after PCI resource setup
> > and before driver binding.
> > 
> > Cache BAR-relative HDM location, global control, decoder settings, and CXL
> > Device DVSEC Control, then publish the completed cache under cxl_rwsem.dpa.
> > Restore PCI_COMMAND after temporary MMIO access and reject decoder-count
> > changes.
> > 
> > Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> > ---
> >  drivers/cxl/core/Makefile   |   3 +-
> >  drivers/cxl/core/pci.c      |  15 +-
> >  drivers/cxl/core/regs.c     |   9 ++
> >  drivers/cxl/core/resource.c | 277 ++++++++++++++++++++++++++++++++++++
> >  drivers/pci/bus.c           |   2 +
> >  drivers/pci/probe.c         |   2 +
> >  include/cxl/cxl.h           |  21 +++
> >  tools/testing/cxl/Kbuild    |   1 -
> >  8 files changed, 326 insertions(+), 4 deletions(-)
> > 

snip

> > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > index 2be1df80fcc9..e80500f457a9 100644
> > --- a/tools/testing/cxl/Kbuild
> > +++ b/tools/testing/cxl/Kbuild
> > @@ -55,7 +55,6 @@ obj-m += cxl_core.o
> >  
> >  cxl_core-y := $(CXL_CORE_SRC)/port.o
> >  cxl_core-y += $(CXL_CORE_SRC)/pmem.o
> > -cxl_core-y += $(CXL_CORE_SRC)/regs.o
> >  cxl_core-y += $(CXL_CORE_SRC)/memdev.o
> >  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
> >  cxl_core-y += $(CXL_CORE_SRC)/pci.o
> 
> 
> In general I'm noticing a few functions that takes a 'struct pci_dev' that does not need that in resource.c. In the future, I would like to extend cxl_test to this core code in order to cover most of the functions in resource.c and the reset mechanism. Do you mind taking a look at if things can be reorganized? I did a quick refactor of your series using LLM [1]. See if the shaping of that is acceptable for you. Essentially I had it organize into 3 parts. drivers/cxl/core/hdm_regs.c, drivers/cxl/core/hdm_state.c, and drivers/pci/cxl.c. Feel free to use any or none of the changes.


Srirangan,

Agree with Dave on this point. We should avoid carrying struct  pci_dev down
into helpers that don't otherwise need to know about PCI.

There are a few more examples later in the series where this starts to spread
through the HDM/range handling. I'll call those out on patch 12/16.

-- Alison


> 
> ┌─────┬──────────────────┬───────────────────────────────────────────────┐
> │  #  │      Patch       │                    Change                     │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │ 1-4 │ unchanged        │ Same commit objects, all Reviewed-by tags     │
> │     │                  │ kept                                          │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │     │ Introduce        │ target_or_skip_reg_val replaced by an         │
> │ 5   │ reusable HDM     │ endpoint-only settings struct with skip;      │
> │     │ decoder settings │ switch commit takes the target list directly; │
> │     │                  │  endpoints write the DPA Skip registers again │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │     │ Move HDM decoder │ New built-in hdm_regs.c, built with           │
> │ 6   │  helpers to      │ obj-$(subst m,y,$(CONFIG_CXL_BUS)), so        │
> │     │ built-in code    │ linking cxl_core no longer depends on         │
> │     │                  │ CONFIG_CXL_RESET                              │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │     │ Share HDM        │ Unpacks the common config only; Target List   │
> │ 7   │ decoder register │ and DPA Skip are read where they're used      │
> │     │  unpacking       │ again                                         │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │     │ Reject           │                                               │
> │ 8   │ overflowing HDM  │ Rebased only                                  │
> │     │ decoder ranges   │                                               │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │     │ Refresh cached   │ Endpoint decoders only; CONFIG_CXL_RESET      │
> │ 9   │ PCI HDM decoder  │ introduced here; two bug fixes (below)        │
> │     │ settings         │                                               │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │     │ Cache endpoint   │ PCI-side code moved to the new                │
> │ 10  │ HDM state during │ drivers/pci/cxl.c; cache and cxl_rwsem in the │
> │     │  enumeration     │  new built-in hdm_state.c                     │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │ 11  │ Add CXL Device   │ Moved to drivers/pci/cxl.c, otherwise         │
> │     │ Reset sequencing │ identical                                     │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │     │ Validate and     │                                               │
> │ 12  │ synchronize HDM  │ Region-quiesce API in hdm_state.c, so the PCI │
> │     │ ranges around    │  core never takes cxl_rwsem directly          │
> │     │ reset            │                                               │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │ 13, │ Reject unsafe    │                                               │
> │  15 │ scope / Expose   │ Rebased only                                  │
> │     │ CXL Reset        │                                               │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │     │ Restore CXL      │ Decoder restore split into hdm_regs.c, which  │
> │ 14  │ state after PCI  │ needs no pci_dev                              │
> │     │ reset            │                                               │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> │     │ Restore CXL      │                                               │
> │ 16  │ state after CXL  │ Race fix. Found through testing.              │
> │     │ bus reset        │                                               │
> ├─────┼──────────────────┼───────────────────────────────────────────────┤
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-type2-reset
