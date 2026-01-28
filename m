Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD525376BF6
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634470; cv=fail; b=m4Q2CI12yRBBV2QhJ4KE3svnrIdWfKYCuxnW3uo/8rppcokA9S/A+WGpfM3McBl0oHvPlF8wh9ir+dr8cxzN5cBGlGb6nDiS9lzdPxoCA22HjrB/eusP7LVTSd5XY13Z3+O2sOgqWNGyZwm2iOcHLFn1eM+g3vRBiTr6+gPBP9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634470; c=relaxed/simple;
	bh=2SaQki4o9EihtCW6Zv/iCkDKyZ3Gs5MaE1jTlVM5sgw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=dgzS6wiPKvZTxuOAxlcgDfYw2BnfXsXyWS5zJfsZMv+lwsAtgruPLCY2E5Zpp9gmj+ZVZ0KmWne1K/8tPbF7BTiIS4XPX6uyLNsCpSdvg+pnz8SthfQVzQtzuJvZncJ6yXLDauJWqPdFHnGsec1WAWKE9Q7/IAAmbphVCD6koGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgeUzkad; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgeUzkad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769634468; x=1801170468;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=2SaQki4o9EihtCW6Zv/iCkDKyZ3Gs5MaE1jTlVM5sgw=;
  b=jgeUzkade2chN8nmCzFxO9A/usvOd4KtzDVlH4xo0LIucTui1if9IcQi
   2zKqPsppcd4bHS4kw5qV2Awt90wb2EQKEsDGDqHUQ9P3vEAs3ZIgx3pwF
   W0UHSfYdBEQ3P8c5Ee6CTXDsq1N/jbzZBY7gdy9XC+MJT9PKO/xJJVD9n
   BIKUuYs9s2ylI30cHhsgfFM+mvMl7LoDCfnngjrCramHqhc4qUZg2iSZk
   yTqvO+mHRVVaSKbtTEgatM13y1MasUl3DNlqnhTtTi8WXU3pm2/uD1uu8
   z+04k/G/FHwO+YSrYvObnwtebX1ISL0Y5457bvtYYsXXTsOMnt14Bqqvj
   Q==;
X-CSE-ConnectionGUID: wFvdVUDmQyqUtb0+kXgs3w==
X-CSE-MsgGUID: hlcSnSTuQ8iPoFQ3CmC6TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81589090"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81589090"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:07:47 -0800
X-CSE-ConnectionGUID: zf8RdnaUSs6Elf2MMbtxMA==
X-CSE-MsgGUID: edZmGsRESB+h4wdh3IJeeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="239627216"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:07:47 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:07:46 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 13:07:46 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.35)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:07:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4FywI28pPDZ4YdFQ5KU0jWlqzfrgpuEDiKQ2VAQNnfz+FpSilo1LAYsSbaJeCaMOAEUw+3TXn9f+QxOk8JnuczCO3FcgVrTtl/ujXq6e09QAlu6SK0ts3Boe9bN5aAtAKKHfzruiELrKH3tzang6XTZ75oU77paloavW+yq04CF7ONUXFy+4vatbpPJyWAJ7G9M9VavcJkgJHstmeFFgEyXZu6v+VHbX82cuPrOBpu+sMZKeCp1ZTrXQRTwBPIHBwyb6joiTLl71HE/7+HJq8oqvRLkP7bep2XWnDJyi8g5IjSsUCZgJqHLzcCp2L6dxn+QL4c0HdwfveXaBziWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCkkvYEiYeFH/7dgkOSTfL4yd8YcVLCgpwX1kiAbBoI=;
 b=QNE0onjdp/z2AkyOzuPd3fOf5n4t7iua0rksYJlcQ525MIFqUctrVTKVKL8Rk+mVlc1U/Amb+MfGgr2aWoRSWzxhayNQHxpU9ud+iX80906RCgAvWAHTt/dBenVtRmUj/G02kDg/bFw/sKM783xqaVRbwfSne6x6DIMq7ztGhssdFwy62HhuNb4XNbH/MSGXcJZHq+/wh6kf5Yn9Cw2QbcEnI1ukoLX0deA5vd0xfs1WzT1JhsjRilCAiKeXWAY5+rDJAQIiroxEurSv57GuR2lB1D5IN65GJkepqyBZlv34NLsn/LLgPo74YhB8D/DQ4pa0nuPLcPmAT7F6jvSH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPFFF98E87FA.namprd11.prod.outlook.com (2603:10b6:f:fc02::63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 21:07:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 21:07:38 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 13:07:37 -0800
To: =?UTF-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>
CC: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<bhelgaas@google.com>, <alex@shazbot.org>, Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Jinhui Guo <guojinhui.liam@bytedance.com>
Message-ID: <697a7a9913e11_309510010@dwillia2-mobl4.notmuch>
In-Reply-To: <aa3866ec-79d6-8eea-ca2c-8890a4c2b3bd@linux.intel.com>
References: <20260128180338.GA423654@bhelgaas>
 <aa3866ec-79d6-8eea-ca2c-8890a4c2b3bd@linux.intel.com>
Subject: Re: [PATCH 2/2] pci: fix slot reset device locking
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPFFF98E87FA:EE_
X-MS-Office365-Filtering-Correlation-Id: c93802ff-95bc-470b-3e8a-08de5eb14466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1ZmK2VpYXAvUEVuTHkxMStsZGdLeDAyTGxoWE9PRkpHeGRvSXBrU2tLOFRD?=
 =?utf-8?B?K3M3aUFCdlg3WGpmczFsak1nbElVZVdtNDd4VGt4dkpoV2dmSDBDOElETEd5?=
 =?utf-8?B?VHFrZm1QcFFkSW9nUlpqU2hDQ1h5UE05cDE4NjhJaEludlpTTlJMNG5keW5G?=
 =?utf-8?B?RnBCNXE0b01qM1RrSGh3a2xVWWsvRUdXa3BYUmVCSThDM08wMVpnTEkzcFJ1?=
 =?utf-8?B?aEcwOFJMY0FDR3ZLa2xPcmxiNzlIMHlHbVBOM0VmQ3dhWExNcHYrak53NjI0?=
 =?utf-8?B?d1ZyRmlaQUJIMUU4cEd2OFN4ajluNkN1R1B3WXQvbjZ0K2JkZnZkSXVOWmQ0?=
 =?utf-8?B?aTJ0U2ViSmZsQ2daTThMdk9YR0ZNeGczMkhsRzFEZU9kVnpIS0d0cnlOS3I2?=
 =?utf-8?B?U2tFMmdVNlpxL2xxcWFHVmdma0N0THJtdm5wT3JpajRSTnh1ZlVoakdPdEVR?=
 =?utf-8?B?QWFSdGEyKzVoNWVnVjN1bXlhZUp1bTdWN3I5TW5IWmN1cXVHT3hCL3BZV3V2?=
 =?utf-8?B?UWxSNkRVUGc0ZFhJZzJqakZ3UkFmNkxPMm1QaTNzUUVUZUUvVFlqeFpKRVVJ?=
 =?utf-8?B?Si82cmR4ZEVKdk1SWUE2Q2FiUm94YVczeUVlR2VrOHg3dDNUNW9uYmN5cEVs?=
 =?utf-8?B?NUV0V1R6ZmdQanNwbHB2UDV0Q0pnM0k2T2k4aTlDamptRVcvdFYvZnQvQWJ3?=
 =?utf-8?B?SmNNWGd4bWlsdEdpSUZiQitvN0ZsODY0K05nWVBFTVE0L0syMVpCSTZjSkQr?=
 =?utf-8?B?TzJJWUowa2FLMW0ydFpRQUEvTVlYUGRXK3NIS1poSTF5U1JQeEt2OS9nUlkx?=
 =?utf-8?B?RFpQSDZWQzAzRXdxeE9xOFgxZVcxa0tmVHVKTWtEbGxqdzNNNUJFbE1oR0pt?=
 =?utf-8?B?a2E5NzBwd2JvcmRYcHJDS0FDUWI4M2FQbElEOWhFMk5jVlNPRytnVzRaYmdT?=
 =?utf-8?B?OXBwR2VxTjFNd1lkTHljbXZNQWhUaXhGaXBROFA0Z2M3cVVCZWptYjNqMUsv?=
 =?utf-8?B?TTQwZFJOOUFrMDdMOGxCeC9wK0F1RFdFWjNyZzdkSWFPUmpHNkUxeHJLRnlL?=
 =?utf-8?B?ZnVoUE9SMGF3T2h0d3djQ25paHFXMmJPMUY3NU15ZjdpTTFMc3dzQ3piYVlo?=
 =?utf-8?B?c3FLalJsRjhzanlPNFBvZXJBQTNXNHY1SVc2M3B1R2Y0ZUwrb3hLa0l2NGg1?=
 =?utf-8?B?L291cVdWYURsZ1poc2hUc0xtSXVNQ2x3Y01hOVJVNVdUOEJIU2pETFhSSm5y?=
 =?utf-8?B?WlhtejR1bXFLaWRlcG9jOUN0UktnV201Y0NBZmFLUGlvUFhRTk4vdlBNa1U5?=
 =?utf-8?B?V2ZZdzgyVjRCYnpJY2cxaVFGZVg1Q3Q5ZDAyYkxwWU9rTC9OOHJiamQ3MXpm?=
 =?utf-8?B?d3hXYnZDejlzL0FGazJFelZpdXdsRVpYU09kdDd3Zi9JaHZNTy9pMWtmOHpJ?=
 =?utf-8?B?MW00S3BrZEFFN3FDSy9xR1BrQk55LzRIdllmZHM5QkRIdlNBUExyQlF0RVo2?=
 =?utf-8?B?a045bkRRZXVGQzFaRUJ5OFg5L0VabEVwZFVoQytDN2prVTdaSWhvK3J6Lys3?=
 =?utf-8?B?M3MvRjhWUjU5cWcyRmVYZ3NTWXN0cWgzV1VMQzh2WW9icEtFVjBwNFZTUkd2?=
 =?utf-8?B?UVNTUXBKYm9lNHNIUGZaT0RiNjhZSWlhMGs5VUxPekxEYU9Ldis4d1NTRm02?=
 =?utf-8?B?aGN2Y28rVndBbnVEV0NaTU5FY0R6ZjBZUWRrTy81M1RNQXQ5SHduZURYUXBG?=
 =?utf-8?B?dFNIeDdVZW04V3ZxVktlc3JMeTA3dngzbERJUDVoWTRzVUZHc0NjUkQvMFZE?=
 =?utf-8?B?T2xRNXI0cjlIWTdLbUpGS2dOL0F6VExVSHo1bWFRUnBsRERNaG03T3REQ1dR?=
 =?utf-8?B?VkJJUkVuQm1ud1NRZzNiVFFrTllQbVdRdlJDREJra0ZPODlZUXBFNnhab1Z2?=
 =?utf-8?B?aHFJbmxpSzhNcWpyNEoxYklNNjI5Y3E2eXVvakVicFZQSzlPM3I2dG9Fdjlj?=
 =?utf-8?B?MFdMZ3BlekZKU1BxQkJnaGNkSzA5Vnd5WVNsa29paFZsbU5Fdko5a2RHT2tq?=
 =?utf-8?B?YkJiRStUMUtLRHFCNWxtMGJRTUdQcHc2QlJSazBoNXAydUZiSlJacG1ac0tU?=
 =?utf-8?Q?U9Ig=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUl1ZWJlTWRNcnlzNU9sUk1XOEZOTmFOTHRYR2NFeEg3THFuN2tMeEhVcVdq?=
 =?utf-8?B?SFFwS0YyaU1TNDU3ZVNJK3NBOVhuLytHSW0zbUlKb3EzcnZTb0xZUUdVSGM0?=
 =?utf-8?B?YkhudFhRYUtsV1l2VktCSkkvN2NLY0NYcmpWdTVDdEQvUkI2WFhIVG42cmxO?=
 =?utf-8?B?S3hpNmdkamR4dFdVY2FJWTNzNzhJRXNGSmVBRUVaaDNNUkpJQ3JMbWg2ZWRy?=
 =?utf-8?B?UDNEeGE5bW9MeGcwNDh2dE1ZVGV1bVBYcFo0d1RMSzdVWFVXVnZZN2l3dzQ3?=
 =?utf-8?B?S3FwVjhjL3E3VG91SFNpMU4vSTZrMlZGNmxoSkQ4VDFOVkZaRWJLVmowazd5?=
 =?utf-8?B?VFNpM0J5UHUxOEFWZDU3NDRvc293UVU1cGFqeEhjMDQ5UFFKZVQwRGl6WStS?=
 =?utf-8?B?OTVsMHE5RXNzaGROWDFGVUwzOWZoTmtNVU1pV2twZW9SUFVJS3FOL1JlQjhV?=
 =?utf-8?B?QUp0K2ZFTDl6WUxPMzhYMGE3QlMweHVkanljVU9yTzhuUUdreGFlVFFhQXg3?=
 =?utf-8?B?QzVOL0p5a09ONkJVYm1pajZqUjg4YkJER0JYdlNYQ01ZMlhJR2c4ZHRNSUs0?=
 =?utf-8?B?Vk9Ra21nakQ4cXJORWFaMmlPd2xVeUk1RlhVZjVGTm1TanQyUUE3TkUzRDhV?=
 =?utf-8?B?Y2NxSndHZVhGYlNvckJZdTZMeDVlZEEyMzN4bFNUbVJVK093QmpCMWdnamVL?=
 =?utf-8?B?SUVaYW80ek9DOXZIODZlTTg1azAvRFpkdHJFSkN2YUhITVowMTNaN1VyR1dU?=
 =?utf-8?B?QUN6WmxVaXVkdHpsVHhjRXAzNlBFQVg1MFA2aFBQd3FmYVNHa1BENkVlRHpm?=
 =?utf-8?B?M3BOVWpheDhacm1HSS9hN3V6anIvVGU1YVFvbSttQjRWL1Roa0hnUnI1ZkFz?=
 =?utf-8?B?SGpTVUFGVzc5djZuSUN5NUtRWGRXSU8xM09qSDJ2THRpMWhaTDlENGhSbDBi?=
 =?utf-8?B?Y3d3UzF5cjc5bW93djg0YWhQUmVJblRLTTdWcUVhVTYrQVIzZ1ZsekoyeHZY?=
 =?utf-8?B?VEZGQ2ZUVldwc2xMS1RzdmxnYWVycnovRC9YRGhHeE8rTkpuRDBDNTB1SStK?=
 =?utf-8?B?VlNPUGlnTUFHWUdvM29hU090Qk5GTE1Ba3NiRG5XYk9NMytrVUxPOUd1UklZ?=
 =?utf-8?B?SHgreklwQXNQRitzTHBwdHMwTUp4bzMyMDRRbmUzVlFXaHFSeWVnZEFsdVpk?=
 =?utf-8?B?MFA4UnYzNGwyT3VISGJMbW9UckFsZGtuajNvdU1jWU1vaUdBMDdhczV0d2JL?=
 =?utf-8?B?c0RtWGh6U3M4NytGb0xleGhEd2JLQnJ0TnVhSFY1bWJQakpqSU1uc0JzZUJW?=
 =?utf-8?B?MWpZdmNQUlVWK1dqbWd6azFreGVWMTJiMnRaNnNYdHJycFhWTGpKZnBic253?=
 =?utf-8?B?dkhoRTZpWDZxRG1rVjE4bXpDZFJvczN6V0JlVkwyUTVmRFdWNVBWTHN3cHhu?=
 =?utf-8?B?Tnd2QnpqTVc1ZERxcGZ5bXV6S3JvOW9LY3plTFRjcTRjVkN4RFpjVHpwVVhX?=
 =?utf-8?B?OGw0RkIzSmR5Y0dkTzhtRmd1YWhtdUk2UFlURnZiYWZmeFQrUmUvNTNjUEdk?=
 =?utf-8?B?M2FLaVhuZlQ5cjVUaHcxcld5akozeTV0QnpsT2lwSDlyanZZKzhOT2tBZHA4?=
 =?utf-8?B?NmVMVm10MEIrVEpaMVRZZ3h6Q3BzZGJiMERFY05VTy91VFZ1clMvUFFyL0xt?=
 =?utf-8?B?c20xNkJEeElYZjhSRFdXcmx5QVhkSHltck9nWDQxSTllTkdYRE1iN2ZKUHJG?=
 =?utf-8?B?YXhhb2RnT3hTQjIrck1lc1owaEI3TWZNWmZKS1BoTHhjQXlLZm95SENWWGU5?=
 =?utf-8?B?TUxhR3BMdk5QUVF0MXBTTmpqVVdqeWxKclpTNjlQaFVUV0M4TFUvWVFxdVVO?=
 =?utf-8?B?cDBJNGtNVGhRWkpab0d4N05RMlpDZ3Fyb0JLcndvYkNmSTQvaE1zcjBDakJa?=
 =?utf-8?B?VDdRN3U4VCtNc3FuY1pBTnI5ZURmYmxuenVKbWcwTEpoT252UkNpZUtOMStQ?=
 =?utf-8?B?WDMycHhTUHE4S0xqQjNJYUtuYWZVaWNCeUEvRllQbEJXYWVqOWdEeTlkZWZF?=
 =?utf-8?B?N21lWUxWV2MyL2lMZVZvMGZJQytyc1hmdVRDV3pqcUxkL00vQXJHUXF0MXRL?=
 =?utf-8?B?MkE4ZGUzTkNNNGN0YlAwc0c5eTVBRmJJZG9ibmRpa2lDZ1NzbmJzdzdZekVq?=
 =?utf-8?B?UHY1a3dRUUdUUW56OE5mVVE2aW03NWlPUjg1cFBOUEt1MEllemJhSXNNOE5j?=
 =?utf-8?B?ZTRVWTl3Z0dqcUhWZ1I5Ky9SU2dhdGRPUEdWcWozOGQvdFVpZFNnb3p3Ymd1?=
 =?utf-8?B?eTFZZ2Nub0JUdGd1Wi82OUUzVDhRbjlNR3djMU8zMVNnWEp2ZVlsZWt4U2U2?=
 =?utf-8?Q?1i47Gu+tx1B/VRC0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c93802ff-95bc-470b-3e8a-08de5eb14466
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:07:38.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqqOA+tFFMtbfvXf0OnGBTWHPDHrjAA5Ds5c/H81MPRL6DoS7rNrADAnYFMc8BnumGbWn3PSaTUWFQAmedsk/jcB/+nk4dOrwQCt5kuv1Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFF98E87FA
X-OriginatorOrg: intel.com

Ilpo J=C3=A4rvinen wrote:
> On Wed, 28 Jan 2026, Bjorn Helgaas wrote:
>=20
> > [+cc Dan, Jinhui]
> >=20
> > On Fri, Jan 16, 2026 at 10:41:50AM -0800, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > >=20
> > > Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
> > > prevent the warning:
> >=20
> > I *think* this actually refers to pci_bus_trylock() and
> > pci_slot_trylock() (not pci_bus_lock() and pci_slot_lock()), since
> > that's what this patch changes?
> >=20
> > It's unfortunate that pci_bus_trylock() and pci_slot_trylock() are so
> > similar but separate.  If there were combined, this kind of issue
> > where one is fixed but the other isn't wouldn't happen.
> >=20
> > But what about pci_bus_lock() and pci_slot_lock()?  They are also
> > almost identical, but pci_bus_lock() locks bus->self while
> > pci_slot_lock() does not.  Should it?
> >
> > All these almost-but-not-quite identical paths make my head hurt ;)
>=20
> My series does attempt to consolidation them (check the pending patches=20
> from me).
>=20
> (It doesn't consider this fix patch though but the other one is taken=20
> into account, the series was build on top of it).

Lore link?=
