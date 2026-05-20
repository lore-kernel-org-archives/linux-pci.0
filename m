Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F52D7DCF;
	Wed, 20 May 2026 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282279; cv=fail; b=kxr5UTWCDmW3nVQ2DTgXEcGZqg1bnO955I7Aqn5ZVcruH75YH+AGPvO1MstQERCWswLpB0qkXMfRmP5Bf+PoTKQbhdNxtgwEOdo0gBvl8kyWWk8C/ijyVWBL9xFXRrzWhFFxlYppyZGF+ASbKFzqWx3E5q9zI8+tFuQvjqSMNuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282279; c=relaxed/simple;
	bh=egk/WDyxe2/X5HdnnMAr6fZh4abDtTk07ibq0SiUmi0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSw3ZluiyKV+YCSDO7dFPfIZYa9AhPBc/gYBEXa7njT1/QlyAH5WJLJJPkKLd4fDWn/fujFW2jj7BEjEA/7rX5p7o9IIIFVoqNc6ABF6al6mSedcFKrzi9oTlun2EsWaQSvUVDeqQDZJyi/s2JcOGtN7OdVxYqncW9BKfSzFLaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtwjMre6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtwjMre6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779282278; x=1810818278;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=egk/WDyxe2/X5HdnnMAr6fZh4abDtTk07ibq0SiUmi0=;
  b=RtwjMre6/4s1R0rodltMLDLx7gw6sEopEXwhG/8QjjSXP+qjf/t6k4uy
   kQvl7AXzpbpJ6YXwmZZPAj5C9DHv8xi++WoD4krm0OwyVt+3OWF/vVQWR
   ljXGvpiyMF3ckKppuF2pJnUzJ9SMgoVAztriYzHpk22vl+1BjRj2gYKOX
   kD7EP1mM6GsS9rUpSRDtAxtcGb6idr50PCU/0y/SwfjYWDZtEIk7ky3Fv
   Sh8MgOUq8sXQaZTscb+ZzpKWNfDcTpzl8TPdmpUlfSoI1eSnF4gQZylYB
   4nFh64oB+YHPPp3Bd5E+YT0t3T+PlSw7exgbhQRZo/yW19C8oYdLOCkwc
   g==;
X-CSE-ConnectionGUID: 5hDFJVsRRPuUw/ejVFk7cg==
X-CSE-MsgGUID: oespS4itSoOBrBIXhmzafg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="91571171"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="91571171"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:04:37 -0700
X-CSE-ConnectionGUID: o/0PFuOiQpmoKiBHHaqR0Q==
X-CSE-MsgGUID: vK9jevOmRxGHB5bOlGym2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235910659"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:04:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 06:04:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 06:04:35 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 06:04:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnoZFJW35O0pdvVixvJZ86+goFDrIrV9rnYJF2hv2aB8/6Hie75J9O+sORnO0Bjm7XRum2LKu2D2G6xkIzKJZglb6AJNS7sq9VLgCYg/iQoTnaGRi9HLHIkQQzyIy3ozRgMnZWZg3Lywy47ylcsJa1QFHc/aSLwOpVIwpZcsuJnwBXr4MC2x3zFYnDnCp902leQZZcMm/QzaPRtGMtLEy7d5gT40W04Zi8nxMTiObC0xMPNLuTmLZLTcUJ3v/ysdUj6pAXE7nFez29IqOy2pep9hMO2RDlUG3j46f7a95URlGjM6WM3Jau5bTcgXlaLLQni325hOuJ62HETyDdL+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9stA/ITgyis5XPKe7CPSEsHrkGE5ax5pyjoaUOZPOA=;
 b=AMsySWtW24tWAMw83AB6RbQKf8bxRPfF2hhBmYkLeB3eCzYfoNSKLK+2jXknz6WGFmFSNczI8z0beh9FVDW8AYWs0GmVkEVcBv3rAOKosf9dPhKMoCSDpjH9GI1CjacwLXk/SMG1iGAp9+yA67R7X+xYxagViOJzm7fVoepaR0RC3rqE/1sO5mHOh2TKrrRghxf1odpMyMPenhUUsFz3VACTLswHOJqy8WN1hy3gLw/pzoKZ6P0akwD/RianOcELHuzg5pMq5AB5eJU8+W8tcFX1ikNICj1YkgJG6SQ9IaMdCimugm6Ts3uY5ohXL5BrRKFzPA4WjzHPCxxUjEvQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 13:04:30 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 13:04:30 +0000
Message-ID: <a0bf2324-c198-4fce-97fc-db884f6e0f58@intel.com>
Date: Wed, 20 May 2026 21:12:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI: Allow ATS to be always on for pre-CXL devices
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <1a8cf5e88051ab5c10417edb94df598ecbc810cf.1777269009.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <1a8cf5e88051ab5c10417edb94df598ecbc810cf.1777269009.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|MN0PR11MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: f8283658-34f3-4903-2635-08deb670542a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|376014|366016|7416014|11063799006|22082099003|4143699003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rhm46yPSc/I0x76Pz79FQIs0BnmJDgmaOG8kS2p3hym7qTBZtNAY6F5Rgm2Q70QphA0+qkshzFLL6K/CEtWRBAL8g1woBuJBBCbsQCHNfkICuDwFEupyoqZcicsinQq6lTRaVQz5CMhmjUtiOYClqLdjtVX/oFHEPgrLxMmU4KXRN8VSO/iMpUsOeBr90AXIufyJtPfvTbBRbSEeer03NPoaI+XmJ7KBImRuDnO8DeCl19PxrLACrC0lCgbTaZZm7p4BWSU4/hxnWd7Lua+jl+Qdszp4TiOeMOhBfcYgD3BzWel3mcywHdAr9OV1GGsHRV4dJjg7YSmog7nViaeKTesGZDZmvVFi1DKKoNQaZVWq0n+Syp1JdsYgcy+w5ewlCCqHQ8zK/4W3RheeWG5YL3mvtjaz2u6fYbqMcWBaX2P72XtJSi74/gmi4t2jJZOEauvCT+fulo0cPgGF7VYKLmyXWZXx9ezLh58WWFxEhGIbeTM/+gyt88ECH5JVT9PeTh+TZmr+Ow3iHRaY9+MxfoZ3ctlgFz+5p4qzwdoW0ruuaWsCIFk4VOS8uYw14etLztR0GoCJZBsoUFs68mQ/jDr6AinwH4J896RTJqyHqV0XOmF0KQK5TKg+hiPUeB+cnIcLYnb/AkW8ebjAQRwKSQJO+HQfTjrG3RraDvF2GjcuzpfZQcQPc3XmmuVtwkN8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(376014)(366016)(7416014)(11063799006)(22082099003)(4143699003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUM4bUZvK0RDZmtyTlNBRDNhZWNJcjZ0ejBudE4wU0ZvRnV5S3Y0SEZYTFpy?=
 =?utf-8?B?ZFh2dVZxNnl1bStvY0VlUmg2WXJUVVJjZDU3TkFleUJsNHpuWElyYm5JWkZw?=
 =?utf-8?B?SWJCQy9ubFZtNXJGQi9abWg1K2ZzS3RYQVQybHpBS1d6KzRreW1yUzJnM1NZ?=
 =?utf-8?B?Z0ZkNVZpOS9VSW8wRFl4ZTZLOWhVbDRJVVY4RmlMd2VzMy92T0FhZThnblZp?=
 =?utf-8?B?Z21CNkJoMi9HZlNxQXU1Vkp2MmZ6MkZsYTAwSGhqS1YrcERDeEh3TlhTRVhl?=
 =?utf-8?B?OHNrMUcyU0VTeHUxVlRYNDd0Y2lMTEZZRll1OXowR0pwZVg5Nkpnb1ZDcDNr?=
 =?utf-8?B?aEs3eWZqcVFpaTN3Q2xjTFRJNXJSUFJ1MTBrRVJZKy9SSjhiNEw5eTlRc1cx?=
 =?utf-8?B?bnBMZmJBdjJGUW0wQ2hyZUxRL3NXaXpsYUJhMjRWVFduTi9tQjRuMjJrcElW?=
 =?utf-8?B?WjFJeTNuVFFOWTdmREMreVptbUJYTllBN21GVzN3cjZHZjNyL2hSQlNkaVpR?=
 =?utf-8?B?QmhuT3FMZjVOSVduV2hINHdBUzV1V3daY3g5L1FMRXpYTGNlcFZ2QW1VSnJy?=
 =?utf-8?B?L1Zqb3VYanhVL2hiZkVaYjkwaGxwMzZDaTJOTjRJVmJiN2YxUXBxcXRuMlJr?=
 =?utf-8?B?SFNnYmMxd1JsZWZTa2Z3dUMyZkxDNXFXTXVFWWlmTkR3RnR3WEQzS0FvM2I3?=
 =?utf-8?B?QVFjc2xxdUQ4dENkeXR3U0ZIS3dCbi82OS9KOWhnSVdET2w0YW5NZFdCTlp0?=
 =?utf-8?B?REMvZDVVS21zOHYwZnVRNzlZbXRBTHk3Z2pIWG5oTlJPaHJZN2FPQmJNYWVR?=
 =?utf-8?B?a3ZwcE9KV2VnUWNhVldhek1iRGYvaDYzVjJrRk5zZ1BDYzJsSnFYQklmL0F3?=
 =?utf-8?B?MjZzUE9YeGZaRS85Y3JldjBHM2o3QkFGb24yRjh2TERLcStDdFA5MGxVWmZh?=
 =?utf-8?B?Y2NmUFVKTDdjNmpEc2NqNFAzK25tRjYyVkNYelRQYlpBNno0SG4waTJ6YVNp?=
 =?utf-8?B?dWQxYi9welBpU2NEYmZUVGpSNWgrS0RYdmtyNDdBeWlzY09rSi9sZ003UkpZ?=
 =?utf-8?B?ZkJ0N0xBeW5ZdHgwM0ZiNUluM00yZEplTHVRV05pZkZ2SFNwTllPcjR6dFZD?=
 =?utf-8?B?NGErbDQyU3Z2UlNpekNGckdORmdkVUwwamZudjhHREVwa3E5NjhGVnN5SFhh?=
 =?utf-8?B?R09jOWwzelBNb21yU1ZPUThxV2Z4cjR4cCtnMXVmbWtsUEJHVXMwOE5WZzBO?=
 =?utf-8?B?d1dWLzF1MVlJQjFCU1lYUWFYYVFpbzZoWVBTYSt0QmxtcXZJVVJqRUVjT1NL?=
 =?utf-8?B?QWpRaVJMcFFYOElNZVAzKzhvYm45UTNGcE04SG9jbGo4ZzRqakwrajFVd3dN?=
 =?utf-8?B?eE9oZHZzRExTTzN2NmVGZHRYOFUzNFl2MDlZTUx3WkdRY3loc2l1WGRnalJi?=
 =?utf-8?B?UTdHOEVGa1d1OEVVdzlCRE56WURjMnl0eVk3a0VtZ09IRHVUT1dXMzdSWGdu?=
 =?utf-8?B?TUpRQnhjMjh5Q1VLb1p0SEhwTEcvRmRxZ0xZeERsZXpicldYU1ZtUXBSTmlV?=
 =?utf-8?B?N1hsODFXNmYrb0ZoaEhOWmxKTG9IcEY2UzRKTnVUT0psU1NKVmRseTNDSkJN?=
 =?utf-8?B?Q2treUp5V0VhVktRRlE2S1RjQmlmaGpxRnA4d3VmOTBnY0FqY0g3cmFhT2xk?=
 =?utf-8?B?eWZUb25tNCtVaDJZQ0F2WlZjSmRjbzF4dXV4UEVlQlhFMFAzeU53MExWVWRO?=
 =?utf-8?B?Z0U4SUNqV01OUWZwL3c0RkJ0SzloY0hCZlRmSEJraDd5VDdrYm90c1Y2a3Bu?=
 =?utf-8?B?SUsyU0RUZlVJdjRDR0dxMFFvcUFzYkZ3T0ZRTVZia2dNV0hyQURNLzVVOWtK?=
 =?utf-8?B?UlVBdXR6NXZnTzR6cXRaL3pxbUREUkNJNXN1YXZwaHZ0djVGUzJHMHdlUHdI?=
 =?utf-8?B?bmRkVjY0U0ZwQjQ0MjNFNEJRQTJxQVFmUFVYNFQ1K0M3UG9LRExvOU5OdVFv?=
 =?utf-8?B?WlVyL2tPZm10WHRyazFxTGV5ZjJXdmZzNTZaQVlQclh2ZUFYN2huN1laTSs3?=
 =?utf-8?B?NE1UTnFrNmpiL1ExZ3pJK0dMM3JEYTNlQ0R4by9nQk1BVDlDR1BZcE9FNlB2?=
 =?utf-8?B?ZUNBUzlweW4zeVNlbU5IUHVrZk1BYSt5bTFyUHdQQWFudFI3TVNBY01jZ1do?=
 =?utf-8?B?QUVRU0oxVTZWRVNiblhnTy9ySmNSdGZ2amIvZDNoL1VLYlF2RDMxUTUzblR0?=
 =?utf-8?B?QUg2R2grVzRGc1FaSFJLM3E2dzF4RFo2Q1VwaDJkVnZ4M29RL1dBeFpiSHZv?=
 =?utf-8?B?SzN6V2l5ZWNrdEdHZHNYa3hzWDFNbnhoYWhaVEdkcXVkaWhtc2VLUT09?=
X-Exchange-RoutingPolicyChecked: JVV9ARNRb3Q7Zr9qY8cPtQUpeSMxF/Wjp943m0dSn97rAfQpdIbOfvwvWjDpW2fw9647HbXvWOqLkWmtWrayUqvSANiLXHN+CTYqk+t2NvUzGpTryCFcu9y1Ae4RHGWBr6Fygl6ScPHonBeOX089fewQKutYcFt34IY9FHfT8IfWxQASAJu0kwO087q2t4ajXKRRVcE1NUETdbHjmjL7mgI8OS8xZPsJe5b+0qHksUe1Np8+9U2ewSIuVLArpoqhUKNgBlqEOWBP0l8MNpa9FBlocK7YORnnUHPsZR4OR6QHloFb9EA8FJsThCp8/LGTZ5UvOhk/LPiZ2BpZQ+Y2zQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8283658-34f3-4903-2635-08deb670542a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 13:04:30.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk6erEXiw3SaZuV+CylacJv34cQ/Fu4QXHaFuGHWWT2N4gHriW97y9MzjPu6vZeFJOP+KXotfXSDRqgDfOxvrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com

On 4/27/26 13:54, Nicolin Chen wrote:
> Some NVIDIA GPU/NIC devices, though they don't implement CXL config space,
> have many CXL-like properties. Call this kind "pre-CXL".
> 
> Similar to CXL.cache capability, these pre-CXL devices also require the ATS
> function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
> v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.
> 
> Introduce pci_dev_specific_ats_always_on() quirk function to scan a list of
> IDs for these devices. Then, include it in pci_ats_always_on().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nirmoy Das <nirmoyd@nvidia.com>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/pci/pci.h    |  9 +++++++++
>   drivers/pci/ats.c    |  3 ++-
>   drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 49 insertions(+), 1 deletion(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4a14f88e543a2..4e0077478cd7a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1155,6 +1155,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>   }
>   #endif
>   
> +#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_PCI_ATS)
> +bool pci_dev_specific_ats_always_on(struct pci_dev *dev);
> +#else
> +static inline bool pci_dev_specific_ats_always_on(struct pci_dev *dev)
> +{
> +	return false;
> +}
> +#endif
> +
>   #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>   int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>   			  struct resource *res);
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index fc871858b65bc..3846447ea322f 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -244,7 +244,8 @@ bool pci_ats_always_on(struct pci_dev *pdev)
>   	if (pdev->is_virtfn)
>   		pdev = pci_physfn(pdev);
>   
> -	return pci_cxl_ats_always_on(pdev);
> +	return pci_cxl_ats_always_on(pdev) ||
> +	       pci_dev_specific_ats_always_on(pdev);
>   }
>   EXPORT_SYMBOL_GPL(pci_ats_always_on);
>   
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..887babba97cc7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5715,6 +5715,44 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
> +
> +static bool quirk_nvidia_gpu_ats_always_on(struct pci_dev *pdev)
> +{
> +	switch (pdev->device) {
> +	case 0x2e00 ... 0x2e3f: /* GB20B */
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static const struct pci_dev_ats_always_on {
> +	u16 vendor;
> +	u16 device;
> +	bool (*ats_always_on)(struct pci_dev *dev);
> +} pci_dev_ats_always_on[] = {
> +	/* NVIDIA GPUs */
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, quirk_nvidia_gpu_ats_always_on },
> +	/* NVIDIA CX10 Family NVlink-C2C */
> +	{ PCI_VENDOR_ID_MELLANOX, 0x2101, NULL },
> +	{ 0 }
> +};
> +
> +/* Some pre-CXL devices require ATS when it is IOMMU-bypassed */
> +bool pci_dev_specific_ats_always_on(struct pci_dev *pdev)
> +{
> +	const struct pci_dev_ats_always_on *i;
> +
> +	for (i = pci_dev_ats_always_on; i->vendor; i++) {
> +		if (i->vendor != pdev->vendor)
> +			continue;
> +		if (i->ats_always_on && i->ats_always_on(pdev))
> +			return true;
> +		if (!i->ats_always_on && i->device == pdev->device)
> +			return true;
> +	}
> +
> +	return false;
> +}
>   #endif /* CONFIG_PCI_ATS */
>   
>   /* Freescale PCIe doesn't support MSI in RC mode */

