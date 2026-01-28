Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC177A13A;
	Wed, 28 Jan 2026 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769561358; cv=fail; b=pRAOwT2YJhF7I0bZCcMrdjFagyAIuAyIsgPkgoYAhljOVQRSgeFdzuC4WfqSRHlhacFJR+nCn5+W+fIs14xtFjQ3eTK8m+S1420Ur84khcQy8mMWj1joiQ1A9Ox7RJa2r/SJzeu55r90r8xVbNFHvPcOEo5o22CxtUJf7uwyRPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769561358; c=relaxed/simple;
	bh=GyDJzQjUUZNdjhJuE5UfK3Dw8OYKJ1xYcTZuiNmGqiE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nXNkTpffaam43x3bXnF55XBgPaKZ3hAjhLU9fxdexQJA7W6eYcmu+i0vZTGKljShaZNRNMSwFwn40qyvN317oQ11Fx2g3/Lmp1Xp/bIUto880eNTH1QbU8FH87jNRGWuG3k1FFi/k3SQBSNbP9QrxcLNgyPZn+oF6uKyk7sncqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0HngXfR; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0HngXfR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769561358; x=1801097358;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=GyDJzQjUUZNdjhJuE5UfK3Dw8OYKJ1xYcTZuiNmGqiE=;
  b=S0HngXfRhevuKRf56cj+KH/UPin77PNMsEixLlHXj2JLePnL10wXM2Q7
   pibVdYaaZPbg5usAwUP6s6l8ELKGjECFptJHw4VACangU2Uo1wenwUYzO
   nQesBdwtWEOSya82vg0rKSYOWSQ7ikKCgvVf38Bv5CXlCR/BKSXh7rals
   aYOH1wpsk0ofi/uBHbyYDNhkjku1xCFsETOwXSjZPs/CjrvNgEf0IPFNy
   AFjc+Nv4D1+gTVvtI/HX0ab7CY+7+0K0Orm23JvRVQcFh/Z0rWdRitFC3
   Q2xdYyDAtgBg/RNBhJ+5wtQz8KD5q6tCHRXcoPw90xK5B9DQVC1hFrl0+
   A==;
X-CSE-ConnectionGUID: NowWoeg7S5SuEdVA8bbUnw==
X-CSE-MsgGUID: KvdnGuZESyqhB1V+N/tJIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81876056"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81876056"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 16:49:17 -0800
X-CSE-ConnectionGUID: YpFCJPBdSK+EvZ151ujvmQ==
X-CSE-MsgGUID: 8oMZwh4DQSWVt6kEo8VJww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="239380434"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 16:49:16 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 16:49:15 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 16:49:15 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 16:49:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQJU9ibQYpefi0vHcs7i7OS/hHr5PDikjdynWD7mTav0KSyv/JwKVJCVlx2QmhGH9qGuUQJl4mHnLfk3TnbyFhG+AmOTuPdH6cnP5SF5ZP1r0nt017ekhwUIGS+sF7JGGjv2P2AbEcdnaaBrfLpBdxtEpOGMN3iYj3qoc/D/4if4IAHfmVTchoe+7K/0pgei2pTMTtF0kgkEBJVfvp1x5gw71RDM6LL1Fkldn/e3VVd9JzDLPZyWhwhHFyqOf8plSP3toswB8KzOLP9yJe+DsG4ZzOSF0eEboUd9hQwuCMRsa/vN86oijAfz3JM5R8O79Sxco+QFyeQu15WIKJmFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moHUq7uezv9QJoi+A9FdjfmV/BAmUdTBgcXU7oRl3CY=;
 b=sZ/itEJkyZbiSpWARg2w8MJeGCz8YmAj7QzdFT1+8RB4wvfWqwfTomRihkjJH9J86WGR9s2bJXkD4jtw5oW0Xr+ue9jozQmMfYYBxlQH+afPwFvpbFCFcSsbYoHTdn/gyVWlXsEMuHt7SZPfacErayP71rEEHsQW00AJSnFwFzSuFgZgrjvQfOg9h8OHqcwLR4AMDwJkwQxOGIAxzUAOaakdsBYLY/GUbWPJkYRsLJg/xYC376S5W/NcIhF7HKLFikb0m52yDbdXJh9Pl33QL9Lv7gwCb6JfhTJYyD8wTtqhl3nsOLnlsXYqQ4N9pBR3wfkDmwxiEkWtMaY0ca/DkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7352.namprd11.prod.outlook.com (2603:10b6:8:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 00:49:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 00:49:08 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 27 Jan 2026 16:49:07 -0800
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Message-ID: <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
In-Reply-To: <20260127150440.GF1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:a03:331::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 746f23c0-cde9-4396-670f-08de5e070b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXJRRHlVVW5ia3VlNG8rak1yV2dRNHI5bmxkelUzVjU2ejFUdFRZcThKR1dQ?=
 =?utf-8?B?a1Fod2JCdHdMVjl4d3ZBWHFHYWl2TkJSdEVUcVAvTmp3UlFpWVYxYjBYZytQ?=
 =?utf-8?B?N1pBclNLZDVVRUk5RkFBT0xJekVHSWp5dm9YU0tHVXhsK2hhbXMwdzFpeDJ4?=
 =?utf-8?B?KzJTWHZVMGVldS9MMU1JaGtoVnBsNXRscDhWL09HS2V1SGFmd25Hb0Y2S3hI?=
 =?utf-8?B?c293MHFOYW1hQXUraGxLeFFqcjg1RDhkMXdjb2twZ1hZeXA1UnJKSTBnNUNW?=
 =?utf-8?B?RjRDcjhjUFgxQVkzNDNhbGxWeEoweldIVml6R2hoQ29YL1Q4Q0xta0pqOTVI?=
 =?utf-8?B?T0RMOERUdzNpb0g0UTNxRkUwczlWR2lNRE9LWVhtODlqTmdzVnFHS0tQVnRh?=
 =?utf-8?B?Qmhmd2FseTQ2NE1nRm11elNoZDZFbFNnSWJ6aDN0WjVQVEpxTENoZjlaUzVa?=
 =?utf-8?B?QU1jRDlWSHE5SXFwYzIvWkM0MllSYUUzRVdhNEVHL1pxYTVmZXl1S3NkSWFa?=
 =?utf-8?B?RXo2bkY2S2k5SW1uSGVNRk91S2FJb2JRWmJtdDZxZ2w1ZE4za1o5NE5hSThT?=
 =?utf-8?B?TFJUK2hPSm93UEtCUkZhcDJoQ3p2RG83K1EzdCtiRmxuelF4S1NSTjl0QXNF?=
 =?utf-8?B?WXhScXJkd0RtZTVvTURWUVo0R2t2TjZaSWFxcFQxU2FmUGpOQ05lRVFmK3U4?=
 =?utf-8?B?V3ZOT3J5OG0yd012aldyS0l4NGp5dVIzVTZ3WU9ib0RFanZpS2RyMGdMV0tX?=
 =?utf-8?B?cTRUNXl6M2twOXVOSlkrU2hld1VFOFJoVGNnbDhPL1pwSEIrWU5Rdk5zL25W?=
 =?utf-8?B?SjUrVThZc1NWTjQ3N1lGUE92OTZlQnJlRnZ2VEsvcWc2L0x4d1F1M2FVMmNz?=
 =?utf-8?B?YU9meHdjdVk2by9qYXpqQ0s2N283RlNtQjFvNE9tVzhreGQxbnBTb0VEWkZY?=
 =?utf-8?B?dzBFZWFHdmR1R0NKNDVWK3JzWFpZQ3V4NFUzaUhPMW1COWd6a255QThEZnhO?=
 =?utf-8?B?TENMc2xRU3hXZUIwakxJMTNwYnBlWmxsdEpqRzRCRzNEQjBIQ2NpcEFZME1m?=
 =?utf-8?B?VFUrZlVPbkJpMkZWcWVKd3l4Q1ZneXp4Z1RFTytMVm8wREJRdG9sTXFHa1Ri?=
 =?utf-8?B?ZVJIUDBBZzA3aWpCdnpYc0FJWWIyS3o5blNmYmdMQ0Rmb0J1eFNaZk10S0VM?=
 =?utf-8?B?T1lOaHFUYVJVZmx5NHBJTWJvTHNLdzFrN0hTbGtvRkZwS3NuY3EvaHJRZFVM?=
 =?utf-8?B?SFl0elZNRU9yS0laczB3bG1USEY5SFplK2NwQVFRZFJSU0Z6VGxGelpxY0hX?=
 =?utf-8?B?MEV5UlZqSGFRbllYUEpMUGsvcU9VMEpxWkY2cTMxWkpZdGE3R1g4eEcwN1N0?=
 =?utf-8?B?TFMwVUk0MXBXNkpJSlpQRDl4cUJLcFRHNkppZ2lhN1RGS0tyTnlIVUNVTUdz?=
 =?utf-8?B?ZEdLbXF1ZDJkUGc0clN6c1NBWmxQMmxQekhHdVpyR3gvMDBUY0gySGxXem1q?=
 =?utf-8?B?bDRWSkJYbFVXTW9wRVRENEtjMm9ueE81NFpQTk16R3B0d0lPenkxamd5eTR1?=
 =?utf-8?B?V2RaMWNMYnY0TzQyekxZL0piRnlDRTJUYVVCdG9LZXl1T2J5QWFCYTRzU2p5?=
 =?utf-8?B?VVlhTEI4d2FLWWNVRDdYcjE0YkNIa0k0VFF6QWZCQStRU2c2TjU3Rnh4a1V0?=
 =?utf-8?B?MmRlVmx3UHJLTWZ4dG83VEVoWmViMzIyNGQ1ZklRZFhuaXBOQjk3cjh2ZlEy?=
 =?utf-8?B?MEoyY3FvSldVbEdzOGZCbUlyWnZPQ1R6RGl0eHNha1NxUlNuaGtUMGNWcStz?=
 =?utf-8?B?UUl3dE5veDZWYXFKSkhBUnltL29wejVFUC9wbTY5Q2tQZnJ6azVWTjFseWRv?=
 =?utf-8?B?ZkdsK05EcytKVSt1ZFByeTZUWmNvaThqS1VjR2RYNFZjVTBhUjY1NnhzT1hG?=
 =?utf-8?B?bFczWnBzYUlBUTVCNnRsK3ltT0lDY01DSmI1b3hKQ3A5VjMvSmI0ZlJKQ2RJ?=
 =?utf-8?B?QmZGUnJFY29DMFlZUVpBZk9JL0k0Nk5saWk5eGd3R0pBNUVOZzlpbVI3OHE1?=
 =?utf-8?B?TFRKbDlrZjdCU1d3aGF3eWVqWWttUXlFSzF2RS9zYzhxbC80Q0xlTmI0RE9K?=
 =?utf-8?Q?T/E8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0hmbC9zWStYTGd3M1VLb1NybGNsNnBIZ2lkVW5CYThybU9URWRFdzA5L2pC?=
 =?utf-8?B?OTJIRFZTSDVHa1FGVlBUd3F6b0hqL3RBUGl3Zm9GMjBONmRRVitJOHBYZjlY?=
 =?utf-8?B?cUdhT3ZzT0s5aHVyQjR3R0tnWjdiam4xQmFyMW9rU3NsNTVpL1k0T0lyRld1?=
 =?utf-8?B?OHI0eG1QMkZWWTRIQVp6NzMzeUZsUnB4UTJkZEJxM3BkSGFZbWlzcFVubno1?=
 =?utf-8?B?SjlNWko5M1lHVm43a2ExaHZxeFZ3RTkxOUp1eVllMkRBTUFWanM0TmtQZGhB?=
 =?utf-8?B?WjdCUGVnQ21vTVZWbU43UGFCejBpOHV2dUJqT21KSU51YVhXQlJIWnB3c3p6?=
 =?utf-8?B?MXZvZVkySEMwR2dzbWtTSk9yMldacU9oK01VNnpmdzNBeU5PK1dNemNVYkRC?=
 =?utf-8?B?aTFmK3dqamFBZXpibzRSd1ZxTlJOaGVIa25CNm5iMVlpNW5rOGhFUVVyRUMx?=
 =?utf-8?B?NUFzSXNYckdXSWVMWVU1bllDVHFYYml6WGVOdyszem1ES21XRlB0K0U1UTRS?=
 =?utf-8?B?UEg3RHRDN2tZdlhIUTR3ZmhxL2FHOFkxVktuVWZLR2tuQ0dPN2xVSWJJMFVx?=
 =?utf-8?B?aEhFeTBxeTBQdUNFdFNCNElYUkJ1Y1ZJdVNxZ1c1REVpRWtYUFVSR0NQME4x?=
 =?utf-8?B?MzJCMVdYL1JnbnI2ai9XSGRNczFvQ2V5V012QWovbC9hUGNUTCtibldTME5D?=
 =?utf-8?B?RTV3bHNrTkN4WFNTWm9lMUphbDJoNVJyWkZvNkNoVlFBcDBpRk1jSzdNN2ZC?=
 =?utf-8?B?d3VBaTgvT2VJWG5VUzlkTkhoanJ4OCtYRTJmaU1lU2EyaUNqOTA5dWwzQ2sx?=
 =?utf-8?B?eE9hVVNNRCt6cG1Cb1BDWGJpSUlkbXNhcGZtekoyYlA3YWFsTzNPc2MyRVZ1?=
 =?utf-8?B?NVJyMXlwdUpEdHlvV05CV1dOcG9YdmlrZWZxMHZtbEdURHBmcUllUHNLTm1Y?=
 =?utf-8?B?NTNwcnNEbStKY0tINHRuaENFVGpxVzZDZUNMdlRBKzh2MEpCTTljRDdXWktO?=
 =?utf-8?B?MkY4ZmxlYVJWTUZESTdnWkZDQXdZaUY0YjdSQWU3cnB0MHExdnEzNnZaZ1Za?=
 =?utf-8?B?eTN0Y0xabjdsRDV3ekx3bks3cVprWlNZTXRYUVF0UVlNdSs4YWE5MUJ1eTh0?=
 =?utf-8?B?Vmxtb1lFWTkyYkNzdXJBeUkycmNDZSs1WlMvRnU0UE90R3dISm5yRmZDQ2hT?=
 =?utf-8?B?WVp5SDA1WWJHNW9lMUo0Rk5YRHVYVVJRTSt0NmdJU1M0cUtlZXY2czBYMU9J?=
 =?utf-8?B?aVVGbENDbDRwbDg4S09JUkdjRzk0VFE5eDA1aTdpRVFEckxWL05xZzFLUkZ5?=
 =?utf-8?B?WVFCTXcrMHpWdkNoQnNRanc0cUJ0NnZoT2oyN3l2dGhrY2RDeDhTblZkVGlr?=
 =?utf-8?B?a2cxZ1plcG5iVTFGVlJ3ZUlHZFNDT1QzNWYwTUtzRG5OOFl3bkJmaTRoSHBr?=
 =?utf-8?B?bXhaUEh0aFpyVFVYZlZxUkgxOGg5TVNwUGxoamxaRGJSSlJuZ1NrNk4rbnBD?=
 =?utf-8?B?UFQ2YTdFMit0Rk9mNGlTc2lhUjdhdjRxL1ZiNnJTR0g0TkQ0YTRqY3FmREJB?=
 =?utf-8?B?SDFsWUhBdVdOTlVMemZmZ001R1dQQkszZ3JyQnBtNUhSQmRWVld2MVVhVHJV?=
 =?utf-8?B?ZUVmSW5za3g1QWU4UjlGZm9RZ28vVFlhZnlSN3M1V0U4TTVhY0ZsdUIvdnY4?=
 =?utf-8?B?bXRSd2lnSzAwUk14cmZlNjhQZWY5a3lZeVJJYVBoRWxudk8zSTRNbHBBaFBo?=
 =?utf-8?B?NUVTeVRWOTZrSWNKeE1WNFN1MTVYaGVacmR4cEJzaG5hR3p2YWxadUdxMnBO?=
 =?utf-8?B?dG1ybDY3OG1HVVNRaU1JOTBEZkVYNmdRRG5YZjZBazF5TVc0RUd4cjFObElF?=
 =?utf-8?B?aE44bWE3OUhaTXJQQWhFVHRsWUJ1dU94Uk9tM2ppSnJtWWdGNXRhK1lCSzBq?=
 =?utf-8?B?NGdKa3V3NGJhWVA4NThIaENXaUpFTlVpVWNLNU9FcG1CYlRjWURFMGFpWE05?=
 =?utf-8?B?TlhtTzhhY0pFcGVQbUZDSjNyMVlqdWQrNWxiSXFubXZwelo1UkExeWFjbUk0?=
 =?utf-8?B?MG1Jdmp5Z2NUeWFqcitkdEt5eVAyeTJadDhpcFlzQ2tiVHBkTkMwYXVyMXZN?=
 =?utf-8?B?Q3ZjU1RENERLNWdZcENzcGYwNElraHVsa2FNMmpoQnNsRHNPK0VBNGRYREth?=
 =?utf-8?B?dU5YZCtwUk9TejE5NC9uNnlJbGRXZzdDZEVyQlRqMEg2Qnk4dTBsOU8rR2tJ?=
 =?utf-8?B?LzBBL3YvYjlJNXRrbHUrZGQ5WW5EdHVxSmMvR2lIN3RSU1ZoOUxrYmorOUhF?=
 =?utf-8?B?MFhFZjZ3ZnovNVd4Y0JLK3BWVWlPVXJwbkFHUVk4c3N3R3ptNExsK1pOMTZU?=
 =?utf-8?Q?jlU/L2NrO1g6tTTU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 746f23c0-cde9-4396-670f-08de5e070b7a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 00:49:08.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAsAgnygJnTA2YLqK988sOSqB56DnfUVGGzZtVOulMeoba6b68plHBNd2k3ol9asGWzRxiKuR7rnGrW3o9sCyDtitIylY1oSa8+XUSYxs+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7352
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
[..]
> > Jason described the flow as "for these secure situations", i.e. not a general
> > requirement for cxl.cache, but iiuc Dan may instead want userspace policy
> > opt-in to be default (and with CMA/TSM etc. it gets easier)?
> 
> I think the general strategy has been to push userspace to do security
> decisions before binding drivers. So we have a plan for confidential
> compute VMs, and if there is interest then we can probably re-use that
> plan in all other cases.

Right, if you want to configure a kernel to automatically enable ATS
that is choice. But, as distros get more security concious about devices
for confidential compute, it would be nice to be able to rely on the
same opt-in model for other security concerns like ATS security.

> > At a glance cxl.cache devices have gained ATS enabled automatically in
> > most cases (same as for all other ats-capable PCI devices):
> 
> Yes.
>  
> > - ARM: ATS is enabled automatically when attaching the default domain
> >   to the device in certain configurations, and this series tries to auto
> >   enable it in a missing configuration
> 
> Yes, ARM took the position that ATS should be left disabled for
> IDENTITY both because of SMMU constraints and also because it made
> some sense that you wouldn't want ATS overhead just to get a 1:1
> translation.

Does this mean that ARM already today does not enable ATS until driver
attach, or is incremental work needed for that capability?

> > - AMD: ATS is enabled at domain attach time
> 
> I'd argue this is an error and it should work like ARM
> 
> > - Intel: ATS is enabled when a device is probed by intel-iommu driver
> >   (incompatible with the suggested flow)
> 
> This is definately not a good choice :)
> 
> IMHO it is security required that the IOMMU driver block Translated
> requests while a BLOCKED domain is attached, and while the IOMMU is
> refusing ATS then device's ATS enable should be disabled.
> 
> > Given above already shipped in distributions, probably we have to keep
> > them for compatibility (implying this series makes sense to fix a gap
> > in existing policy), then treat the suggested flow as an enhancement
> > for future?
> 
> I don't think we have a compatability issue here, just a security
> one.
> 
> Drivers need to ensure that ATS is disabled at PCI and Translated
> requestes blocked in IOMMU HW while a BLOCKED domain is attached.

"Drivers" here meaning IOMMU drivers, right?

> Drivers can choose if they want to enable ATS for IDENTITY or not,
> (recommend not for performance and consistency).
> 
> Jason


