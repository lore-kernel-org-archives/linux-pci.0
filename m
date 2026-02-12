Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE6229B1F;
	Thu, 12 Feb 2026 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770875784; cv=fail; b=bTLKakBIeV9wldJm5wM/qhSt+lcaHqrF4KS6V07MT3ttiBpILq5NctBAmcSlzjzkfjpYrt+TzS/g5AWIm6DO4W++YxOuobHEsOl3zlJCpQ5mVChacXdy0eFNilk893G06FEAeH2iI6e0SKXPfXTiAYO3v0XfafyfPxuYii4yBg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770875784; c=relaxed/simple;
	bh=CtqSLO/ryIpCKoqXuIeKjEScj85biHq6mFN7PUez39o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GT3ud2QaLi/yP4kKHa27h/QsBNgXRdUvpAmbpbB8YB1hjgzebLLAvzOIApBfvg1K/hhcf//lhQBwds6ONoH73g4Ye1OpeK7OIQcZA+533eQd4V8Hx++H6u4OBhFYcbb4GP9Oxw5qOiQsDqf7K2/PNUpps8p+C/kvUChbtzOX1TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfMkUaOr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfMkUaOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770875782; x=1802411782;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=CtqSLO/ryIpCKoqXuIeKjEScj85biHq6mFN7PUez39o=;
  b=bfMkUaOrKCMfX0ElsoBr1dYc8frRtW83ZHZB/1fiz8VrPCqfElpvSeFj
   MnOnYKquGj5WZatgspa1XjRj/tOZcxo/ZNpdWNn1cE34mlcb19P637UXu
   qDmNwFZFwqUrgEc2QTOUsSjQomcHTZbY6oBSvWbHwFbJ3xKk/lX9P6ic8
   aLARNzAUy/oYVUmJY+D3zUkmJ1dh1IOh5vSDsZyi8j5eeRBD55FrPN/Xx
   JjyXKUxBSHaPmOXVta85Kqkx1bVifmOwoieS17SV8vTXccQwhbRkBd8Yw
   yIX1dNNYj/7WNmhsEhm2TiRbJFEcFEp0iIlrbWaJuPfTVAjA7Tbjm/zO0
   g==;
X-CSE-ConnectionGUID: cFEepZD2RsGVurynoaB/wQ==
X-CSE-MsgGUID: nXd/awF3QBe5dA9+8u7iUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71935419"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71935419"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 21:56:21 -0800
X-CSE-ConnectionGUID: ghN6D3AQRyy5fogFIEyryw==
X-CSE-MsgGUID: i8DLrO4RQC+1GvUQqDVohQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="216968710"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 21:56:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 21:56:19 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 21:56:19 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 21:56:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqcIDIXTQMErqvIJzz9mgHhvw1HSJXyTnkgpzkTVa3bGLtnD7dGByRiTuQbS8rE3LmnIYVuFhdERk7UKshfkgdS2/8ZkESXt0eJhZVim4iZcAcdsEyz2oUqjfNaoHKFg0xutRysaPhf/4SKnPjr9zcN8n6YouNaEeoFgJKzRIkTpdSaY+2Sdvcme5Dih5wNUfjJFfcrMhhbRJwZsINbcSzu5/uFWsmItp3yBhToCTCMmSzBzFQNKp0jstjOXBqEVglH1DPQkH5x2cUfsVkmJJ/uilc6iDOGSku7cyxTTCJ/KSJQQ7vSzZ8J6vPkymHRn6mTiEIayw9u03GiNy/x28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GEdd93gry82KdQCdTjekREx5ANcNWwGWZpxUkfjWEk=;
 b=ysZobePQPue6FRPKVacrvENwOI6tGcbj4ZW3CVWc0CoeJWn5U9mvgT93amE5KvJGyX5XO4dM0Srmgm1QMm0STJGB53CWjqFG0aoYC4fVLmyxAeyio2T0d23Ox1hhIfCD4YZT8PFAxA71qLKw7gcEI0NgT7exs2p0OZHwKVSiFafvJTfocGFI8/8BnAZHG7Ke5cXdTyEwXy+1Uq8c4koFkLFUVNwYK+t84EEKHKigM/HmZhhlj+KL4ZnnOGZddzXlmYnPccEs/31nZe8dG/iyvbxMd2A6CvVRtZx5lJAC21+IGiDHlqUhTAW9We2WTLPIKTyN63E921CQaNVYrMh+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6381.namprd11.prod.outlook.com (2603:10b6:8:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 05:56:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 05:56:16 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 11 Feb 2026 21:56:15 -0800
To: <alistair23@gmail.com>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <alex.gaynor@gmail.com>, <benno.lossin@proton.me>, <boqun.feng@gmail.com>,
	<a.hindborg@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<tmgross@umich.edu>, <alistair23@gmail.com>, <ojeda@kernel.org>,
	<wilfred.mallawa@wdc.com>, <aliceryhl@google.com>, Alistair Francis
	<alistair.francis@wdc.com>
Message-ID: <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:a03:60::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 561f7ef6-2d13-4ed4-ad20-08de69fb6fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWg0ZTBJcEcwK1N5TjJYWW54MXM3bUpZcnRlNGpHaVR3WGF5RkZ2QlVOYXRU?=
 =?utf-8?B?d0ZhMVdycnNnSzdzVGdzR0E3U3NYT05kLzdFQ3BxVWJLd2luRHNuN0phOFM1?=
 =?utf-8?B?MjFtaHpldUNFU2NEWkUrZzNiWGk0ek1hSUcwYjYzckdObnlKdVdtY2I4YXFG?=
 =?utf-8?B?Y0cwZk1kWk5Cckc5enRPQXNMTS9CRkpTSkZUdERnMEZRR3ZJdGxsd3dGOU5a?=
 =?utf-8?B?bWNMVXdLQ3BQK05UdjMyM3lWaE5QdnYzc2ZleVRid3BMbnJuRGhqU2hqSS92?=
 =?utf-8?B?NWVQSGZ5RjBIQk45VngvanE5YjVFZzVCTUdZYzYyYzZUWXU3eEJWUHJDQ1hh?=
 =?utf-8?B?bWpXN3B6cW9FYWhGS3FqOEZNM0NjbzRoYUdXVTFNUkFyaVlLVnNidUhQajlm?=
 =?utf-8?B?bXRQWEUyL2pucGNpM2l5OVBoQS8yYjBOUWgyb0lMRVU5SVJMWjdVbkFpcGJU?=
 =?utf-8?B?TytJRFIrNlprN0ZJcnlYNkRFZmVhT1BqSDBWdnZpRmFmdzBrWGNMNWJ0UUor?=
 =?utf-8?B?SlpDbTE0SWEvU3Fjd0RiT243TDNNV0hVcCtWU0RudVdKVDRMQWpwSUwwSHJ4?=
 =?utf-8?B?VlJsakdMQnFmOERtbHV2WVFMVEc0MmlDb1pibWJPdmxCRTlLU1pwby9iTlZD?=
 =?utf-8?B?QXlrdEJXK1ZxM3h3WWxrVTVOTCtja1lFY3VodmpXeDFJa1BsRG84UU05YS9v?=
 =?utf-8?B?QmJwbU12L2tTZjh5d2lWRTFVeHFabDZaTzF5MFRoL25Td0NGL3BidzQxNHdV?=
 =?utf-8?B?bTBzZ1ordkkrQkNhZldSSG1jbjUrWEJ4OW80U1oxREZIN1FsMVNTb2lORC9R?=
 =?utf-8?B?UU1OUXdzdHpseVNVQzZQb2xxalNXdWpSK3MzcUZ2UG1lZUsybURkcnhPNnpr?=
 =?utf-8?B?L2hhSE5vVldBb2JGcXIzZzdkQjJyd1dSNWpoWkpCSFFzVW0vK09lb1ppWWUv?=
 =?utf-8?B?QUxoQzFKdzBkZlRKdlI5UWEvMG9mRkxWV2pQNmR2c3Y2UU9NRSttWXd0V3NQ?=
 =?utf-8?B?NVlSSmJzSmpwRWxqNlZ5bkVoOTBOYVdRS0hXQTRucmxhbmhqVENvS2hrLy85?=
 =?utf-8?B?U3ZsV0w2cHFYdW0vOXRqS0g3c1E0MEVZZ1BYaW5KdjRQV3UrUDhTNllReTdD?=
 =?utf-8?B?cEtVK2NES0hMMGtjSC9SZXlyUjN2TWp4N3lzUElMM1ExbkVWS1lBZXhUV0N6?=
 =?utf-8?B?UjdLVVArNVVhQzVVK1BrNTdnd2t4bU5LNlJFTEtvNm54Y2MwSytSdnpNN1Nw?=
 =?utf-8?B?bnJ3WUY2d0dNMFpFbmF2Uk41NE1jeGRZdzFXYjdBem9DdXZNaU5IemREYTQz?=
 =?utf-8?B?SVhmMTlLdFFHNnZlYTZKNlRSU1hJdUtqdy9EYXdVSkw0YU1FTVArbHpHeWQ1?=
 =?utf-8?B?bTBFY0xEMHVhNnZpTmF6Y2wrZDZrRkNPa0dmNXdwa0VsT2E2TDYvWXZCdGRr?=
 =?utf-8?B?TEQ0YXR6bnBqeVZkdUhGd0R6WXhtV1RJcU5JUTFTYWgxVTltRWo2VXBYWHZV?=
 =?utf-8?B?VVRIM3kreC9MWlJyR1Q2NG5LMVdGanZnOFdDaDFaYmlrazQ1RjlJdW9NZy8w?=
 =?utf-8?B?ZmhRekNNU201MDlSYS9WTVpxMHkrWmhIZUR3ZWQ3dHlTdkpUYkYrdmdjNGkz?=
 =?utf-8?B?aTVnYmdlVjNZcS8wSDU4c0wrcWlIUzJWQWlMUXJBc3EzV2pFNVRTMTZGN21Y?=
 =?utf-8?B?Vi9xakFWcUFkdHdqTjZDcUpkQ3pFOFdBYnl2RG5xdHJQSWFjQ21xQjU5R04v?=
 =?utf-8?B?eGpXTit6ck5NTnBCcTFLY1hkZTJUYzh4eis0Vi9oQ3hxLzViM1dBbFhHYU5n?=
 =?utf-8?B?TEpWQytrQW16RWk3RnRoUDVmUDV0b2J5YUxLc3J4bnU4dDYwd1I4U1pkR2Nz?=
 =?utf-8?B?b0gxQW5ubksyUFVNeHVRMUhnQlZPODRzZHBjQTJaaGJBTWcydVl3Yk1xUnVB?=
 =?utf-8?B?M2x1NmZ0S1Jzb2xxUXFwaGZ0MzhJZUtzSzc2Y212TGJpQVBLcENyazQ3bHE5?=
 =?utf-8?B?WStEVWZGRndERElQbjEzeG9JMWpweUJ1enZKWm5Ld1R6Qzdad0xERGpBeHo4?=
 =?utf-8?Q?8lDKC/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c29MbjJlY0lmejNtZ09qalJBQ2lBTkVlcGx5Q0p3OFBSemtTYjNwR0wrVWVS?=
 =?utf-8?B?by9ET3NUSE9rTjU2UWhEdVFQejQ0QTJVOGdpODR2aXNHQU9HSlNjQVlEUStz?=
 =?utf-8?B?ZC9IYjViK2JISGxhQ09OTUVWTXBpTVhSV3Q3Ym1lNVRMa1ljTGhoWVBxQzMr?=
 =?utf-8?B?OEZoR1dsRk1KSjFZUHBtY1ZNZGZVSjVoQXByWTUrZ0tlUzFLdUhJVVRoQXZ5?=
 =?utf-8?B?cHJRdlRXSnVmNjdRSUtsRCtveU93cVJnaUJFNHFlWHQ1VExSZ0g4Q2xzbnk4?=
 =?utf-8?B?eEVIODBidU9ma1E0U0NRQVhVdDJod1JVaGlPVG1jRDBHSnk5VlBjNXNIc0NT?=
 =?utf-8?B?MTFBYzNIL1padEN0S3QrT3M0alZySEdUVGV3a3ByeGVIRjJIekdsTEFzZjJu?=
 =?utf-8?B?T0R2ZmNaZFN6OW5oUEtFS1lhWit4SE9VcURTMlFvWHpxdk1mcDRVSEFYYmtY?=
 =?utf-8?B?ejRvVlVZampRQWlzdjdTSWIzQUxFYi9SSDlUOTFOZkd5TlRsSTRTdlZyQnRK?=
 =?utf-8?B?NWsybS91WDVyWFFkRThSamo0UVExTWZNUzAvbkY4YWFEdHlZajFySXllT09N?=
 =?utf-8?B?cE1WSVZRc3AvNDgvWEpKRjE2eVhjb2IzK1lEYWs2WUowUExPU3NqcnZYWkpF?=
 =?utf-8?B?V3EzVUtJS3BTb09xamthTm1ZNk8vZWxNUzh3aTZXcW1FcjFPZ1FQVktPd2g0?=
 =?utf-8?B?dUJTYmV5Q250eFFBRjRrbUhQK1dla3pncHd6WWZBeVJtd3hPd2NQOTd6MHM3?=
 =?utf-8?B?eTdONGEzT0doaVlPVmZoaS9seFZUam5HWi8rVnpZclpCK09BMStlZFllQjBZ?=
 =?utf-8?B?emNCa0M0cTVlYmkwdHVyc0RIeDIwRFMwbUllczhJSGpZVDhMYnVLTGZwOGVM?=
 =?utf-8?B?NnFKR3Bya0pBSWlPeWtNVHZHRDFNam9BYlRUYUVzc0t0TFptVUI3QzNaenUy?=
 =?utf-8?B?S09FTlNDd1V4Y2d6RkZFby85VVRLQWNXbHJKQkkxMlJzckExNDBuOEZGSGFS?=
 =?utf-8?B?UXZCRmtuRitoNUgrckZndlA2TlRpMlA0VnFicXREeGdRNjNkSTFheUYrekpm?=
 =?utf-8?B?K2pCUEZEZVNxMW1KR0ZUZytFR3hkaFU1dTBlTk9RVmVibTg1Ulc1am1WYU5M?=
 =?utf-8?B?YXdySE9BUkxZN29CL3Urb213dkNZMWd2cksrNTBsRGJjR05PVDZ6NDRGK2Ft?=
 =?utf-8?B?cnlaa21oZFNCVk9ZMCtsbndOY2tWY3RVL0o2Q1Jib0JSQXZVSnZZMkQ5R280?=
 =?utf-8?B?bmRxbTRvODBybUtyYm85eGJHa0xKRXNYb1BUWU83eERuQS9HWGdUNWZXVlFy?=
 =?utf-8?B?YWQ3QUdsb2tob0UraDRyZzBLTy9xUkQ1L2s4WjB1QjBJck1NdnpLRmQ0K0Nj?=
 =?utf-8?B?L2wzTzlyZWxOdHpycUlCcENTaDZLRDBocDJReGhrOHRicDRCZk5yT3psMkMr?=
 =?utf-8?B?eVFlbWg4ZTNZTCt4Nzl3U3EwOG9ncldHelk4R1ZscEJibGVHanZlS0xVNzRo?=
 =?utf-8?B?UzNxN1dqeUxXQnQ2MmFMWmU5OWNweHE0N01tV080TzZIbTh0eGh0Nmc1ZWVs?=
 =?utf-8?B?QXI1a1RGTnNXNkZWSDRiQVJscDBTWXZXNi92RHlQc0NJNC9tY0ZkOWRKY1ZG?=
 =?utf-8?B?cFBjSU91c0tnbWV3MjUwd2QxcnQ1bENwV25tY0hqdDNaTnVkZndnZ3RWdHJL?=
 =?utf-8?B?c3pRSlZDbkdLMVViSnBrT2VtQ0xpcGFQYkNtTTlWVTFWR3UraUhEZFo4WVJF?=
 =?utf-8?B?Ym9IWk4rL0thRDNDRjVyZ3BlbVNOaXVRSUY1ZTVVNjNTaHhsR0p0d3M4ZFY3?=
 =?utf-8?B?Q2NPWS9keXlkN1JmdDZmVFpJNnlDUzA1dGcxY21rTUJZdkw3bkNYS0RCUi9D?=
 =?utf-8?B?a01WUVAvMzlGWERmc3V3SnBFdDVxRUQzMmwzQzNudHZONG5wMHRoVXdCQzRM?=
 =?utf-8?B?bFFSTGdzd2V0dlZYMFQyU0I5SDRXakNTdDBPSjlId3lkRWFiTFhQWGhmNkEr?=
 =?utf-8?B?OW5HUmM5aHI4OWZhRDFnUDJrRXJWQ2pnNVNTQ2tJd2ZTeUVmbzUxUW52OTAz?=
 =?utf-8?B?N3RsTWNIS0dOemdBLzZjZWFaMGl5N25NaTBKTUx6QXF3WnlNb1FlV3RMWE4x?=
 =?utf-8?B?bWZudWRMdGhycnNGRTFqcVZmOHlxdW1WOTdwbzUzbkt3WWhyaXpUZ3NMRFg2?=
 =?utf-8?B?Sm93UDVTKzRDenUwdVlRZk43UnJXOXd3SFF3QnJxdEVEWmJKY0wvUDQzTnZL?=
 =?utf-8?B?aVdnQTJmSHF6TGo2RnBhVXdFMU9odThKY0xHRHhTMlc2TmdWOHBvbmdHZEpm?=
 =?utf-8?B?YUxGeTBMRWVCckppNDhZSDA3Vit4Ny9MNEk2WkJ5czNtY1FKNXU3a1RRZHlV?=
 =?utf-8?Q?F+571ei5KOulfveg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 561f7ef6-2d13-4ed4-ad20-08de69fb6fe0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 05:56:16.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuZNp0DlbSwcpoYHMzyIw1ZF3eQU+KJatqQRTvlfjbaYuAkAxmmImRhSysT/LHOxPEhWCT8/OfGiaGGBuuFy4/0HuCU0fQr9ZJEHc3Ei/wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6381
X-OriginatorOrg: intel.com

alistair23@ wrote:
> From: Alistair Francis <alistair.francis@wdc.com>

Hi Alistair, quite a bit to digest here and details to dig into. Before
getting into that, I will say that at a broad strokes level, no immune
response to the core proposal of depending on a Rust SPDM library and
forgoing a C SPDM library.

Most of that allergy relief comes from how this organizes the C to
Rust interactions. The core SPDM implementation calls out to C for the
presentation layer (Netlink) or is invoked by sysfs. That makes it
amenable for sharing those presentation mechanics.

Specifically, my primary concern is integration and refactoring
opportunities with the PCI TSM implementation [1]. The PCI TSM case
should use the same uABI transport for requesting + conveying device
certificate chain, SPDM transcript, and device measurements as PCI CMA.
Note that in the TSM case the SPDM implementation is in platform
firmware and will bypass this library. The TSM SPDM session is mutually
exclusive with the CMA SPDM session.

[1]: http://lore.kernel.org/69339e215b09f_1e0210057@dwillia2-mobl4.notmuch

> Security Protocols and Data Models (SPDM) [1] is used for authentication,
> attestation and key exchange. SPDM is generally used over a range of
> transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> 
> From the kernels perspective SPDM is used to authenticate and attest devices.
> In this threat model a device is considered untrusted until it can be verified
> by the kernel and userspace using SPDM. As such SPDM data is untrusted data
> that can be mallicious.
> 
> The SPDM specification is also complex, with the 1.2.1 spec being almost 200
> pages and the 1.3.0 spec being almost 250 pages long.
> 
> As such we have the kernel parsing untrusted responses from a complex
> specification, which sounds like a possible exploit vector. This is the type
> of place where Rust excels!
> 
> This series implements a SPDM requester in Rust.
> 
> This is very similar to Lukas' implementation [2]. This series includes patches
> and files from Lukas' C SPDM implementation, which isn't in mainline.
> 
> This is a standalone series and doesn't depend on Lukas' implementation.

So, I *am* allergic to how this series references Lukas' work by
pointing to random points in his personal git tree. I trust that was
done for RFC purposes, but it would have helped to call that out in the
changelog and set expectations about the ideal path to coordinate with
that work.

> To help with maintaining compatibility it's designed in a way to match Lukas'
> design and the state struct stores the same information, although in a Rust
> struct instead of the original C one.
> 
> This series exposes the data to userspace via netlink, with a single sysfs
> atrribute to allow reauthentication.
> 
> All of the patches are included in the RFC, as it depends on some patches
> that aren't upstream yet.
> 
> Now that Rust is no longer experimental I have picked this back up. If the
> community is generally on board with a Rust implementation I can work on
> sending a non-RFC version and push towards getting that merged.

As long as this stays explicitly designed to minimize exposure to
"refactor across language boundary" events (as initially seems to be the
case), then it seems workable.

> The entire tree can be seen here: https://github.com/alistair23/linux/tree/alistair/spdm-rust
> 
> I'm testing the netlink data by running the following
> 
> ```shell
> cargo run -- --qemu-server response
> 
> qemu-system-x86_64 \
>   -nic none \
>   -object rng-random,filename=/dev/urandom,id=rng0 \
>   -device virtio-rng-pci,rng=rng0 \
>   -drive file=deploy/images/qemux86-64/core-image-pcie-qemux86-64.rootfs.ext4,if=virtio,format=raw \
>   -usb -device usb-tablet -usb -device usb-kbd \
>   -cpu Skylake-Client \
>   -machine q35,i8042=off \
>   -smp 4 -m 2G \
>   -drive file=blknvme,if=none,id=mynvme,format=raw \
>   -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe \
>   -snapshot \
>   -serial mon:stdio -serial null -nographic \
>   -kernel deploy/images/qemux86-64/bzImage \
>   -append 'root=/dev/vda rw  console=ttyS0 console=ttyS1 oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1 swiotlb=0 '
> 
> spdm_utils identify &
> sleep 1
> echo re > /sys/devices/pci0000:00/0000:00:03.0/authenticated

So this is where it will collide with TSM that also emits an
authenticated attribute. See Documentation/ABI/testing/sysfs-bus-pci.

The rough plan Lukas and I worked out is that switching between TSM and
CMA based authentication would use sysfs visibility to coordinate. I.e.
TSM to CMA conversion hides the TSM "authenticated" attribute and
unhides the CMA attribute of the same name.

The most significant unsolved point of contention between TSM and CMA is
the policy on when authentication is mandated and the driver probe
policy. The proposed model for enforcing device security for
Confidential Computing is make it completely amenable to userspace
policy. Draft details here [2] to be refreshed "soon" when I send out
the next version of that.

[2]: http://lore.kernel.org/20250827035259.1356758-6-dan.j.williams@intel.com

To be clear I am ok if there is an incremental option to have auto_cma
and/or auto_tsm that arranges for authentication or link encryption to
happen without asking. I take issue with auto_cma being the only hard
coded option.
