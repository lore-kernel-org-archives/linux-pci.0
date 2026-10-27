Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793075568;
	b=NqVFMD/qB9d884vU0mhJzE99AfyRY1KdbW/3hedGVI/d178XU6BkU2ipyQ618OEI85Xw
	 P2SLfNoelAcULEJtvvZIqUObb9S1HQ9YLFg7rNnyWQN0C5Nwd5IWE11HHIEhpileD2H9t
	 cpF3AOnDzZfkE5zY9gSqU2CbdNSKcks5NpXhpukCFulG04+uoRjlN9pR8yMEmYKK8cBoS
	 7DuwrVN/BJy0NO629UqYJ5GPuwXGMPzKpTkiGfh8JDq3QP0utxmAsk9C0ZSSNACUlJ16K
	 7prOpDNOB6OqVYnW7KUKFwrd8Lsmy7BbdRe+EW9w8yrPJq891WYC6W1Bo0kfnTQ4JUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793075568;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=jXluiIzM4k4Nj2YwtjTgOAZphX8AbP/UDhK43dRujc0=;
	b=OSjMeTIhB47NXxaFAK8G17oWGgKm+p6Znm6wxJ1aA9kLW1Cq1/cQICE4EPVrFCgGs6Xu
	 PaHREWnjlPJ7cS6reUpPr9Rnr3vhXAnL3wEHgEGbbYxXJypn5tQsxd/pNbK1X76PVDG9K
	 J+ou0HYLIJ9FwqF9oo6JX/j2qF6AB5RSKHkisLNzv8z7IWJ1vxJyB9u0yRmEqQ330Uy/S
	 /y1S22Kh7y/yR8/YKuJBxhNRulHll8E1+ayB5Xdn1bWiuUEeoA7Tvr3HzDLcbO2fLgI7p
	 Ff5plxTThvztSkTZ7aXs9uEOXXznN5PbEA9axl5+GALIIKrTLzQtItqkVC3eceHhg3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BLMfyNQi;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6E606A31A;
	Tue, 27 Oct 2026 04:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0C6E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BLMfyNQi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793075568; x=1824611568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wz3TIyf4xdFiKcb9Q3t95e2QHcxsddNG5MHq3Y+0j18=;
  b=BLMfyNQiIz3oE4i4aoGcIj0CiyWX3X72XZpT00lapm4ZQxNgrB3GU5Oa
   3wT4xP6Xh711tUfsYQ8Mfm5vpkeoPuzL9PS+jx4wYaaqekIQC5qaikks0
   U5bfSIF8+kSOU1oLzVg1RZb+svPMNRq5jeOmEcvCWcdSjfy1vKtyNXEpf
   9fxV5QK0wK726IJd5b1uK+QOz6gW8Yr0hLg+SGlYi0OR7xBI3ERKlNba2
   U6fgDjcJowMubmve76QMqkosnkrvxxyLvjq60QFsS6xWKIy4kNgJavRAJ
   4ZAOicAeyaMmlvmeceRIfETUNtx/OaaNrS7IjyleFB8y0ehJOjnXoF/KR
   w==;
X-CSE-ConnectionGUID: yhf7VpMWTXGKyGt0Zd9kWg==
X-CSE-MsgGUID: 2oOlsOrNS+S1nxCYZ4MXZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1657929"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1657929"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 21:32:48 -0700
X-CSE-ConnectionGUID: AuMGGERiQlGFN3RYqbGa3w==
X-CSE-MsgGUID: w2JQBxYPT/6QE+SlJta28w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4530160"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 21:32:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 21:32:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 21:32:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 21:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj/7s9FVMYHeuHL9kxEiTibnA3oWy77pXApFQXvIiPpA2iVgOI2579VTIPmGb6yWk3XET7wX81HAU76BSwFtqXtzt0UgEPsr/SdPYkkLAelXKYCwh6cpCSBLhQw27ieNJQ3A3wRO5DsbIh21hBcElwE2bQtHYcRK2qb2Fp6edtQva+OROP3nIcM/XZIyFBcEiJngcHCAwwae126YwWOA6jfSPlc3rym+eb7yzY8Iwr4NR8Q4GaOrMW/Y8QrZjncU6AF/O1AX5M1jLchkYRde6d2tFwWPfj46h7DWjlxUcrBpz4L55YOZmcUqi8HREPP6FGcS9ea0dGOtNa3FUE6PNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXluiIzM4k4Nj2YwtjTgOAZphX8AbP/UDhK43dRujc0=;
 b=JTLJm+lWK3F0SqnPe48V9GvvrSyivcfdkMsxk/4HE7zRvUzil2YguyFvOmhd71UckQwoPMwIVGSkfDKfAI761zh9F+kc1JkIAiRk9P/sZ5Mjs4+ERSpWZPViONT2krbRBFFkL238zrJ9zGA8cgb80BWxLlApoO25lM2pAOHeoELsMdrFIRc13CSi9GHNsk84UjLo21ti/o3j3e0MM3B3PyqLV+HJXJB+ErcPKdlvZ/07+ONTD39wwM5VUmpF9k38Y/hHx01UK9AHqBw4trGAzGc9N016PIChZqk446dsIejeOZfh2jPjZ10mj+FRwZPwDGS2k0NENvIBtIVihOHqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:32:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:32:43 +0000
Date: Mon, 26 Oct 2026 21:32:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v15 11/16] cxl: Validate and synchronize HDM ranges
 around reset
Message-ID: <auApYR-A3qihqLbP@aschofie-mobl2.lan>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261011021422.3428136-12-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV2PR11MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 017b36b9-2901-4473-06c5-08df33e35776
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|6133799003|22082099003|18002099003|261026121527099003|5023799004|56012099006|11063799006|4143699003|261009223027099003|10067099003|261022105027099003|261022113327099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: jpnrGt9mYjNhCG2mzmY156dGwdim9qzMH2gAecHTUvNxXnbW9mKV6mu6AjqAJVq+4N7E6s8MwRQ1vFOTlGvk930W2cthpBssAL86qpkqq7LIJRrnk8zpuLZArGo3WGwbKTIzth6IDnGwHv45syGlrs/QdDfq+CL+f/tn/79Jd2NQdWZvhTi+9uKv6ObpCubAVUZ5A4wXjpzArkkQoPUr/C90o1IhS6/hekZoF0THWaJzh0xOVW0403LB6SDdvdDZlKAe4iT49aBm8fdC+9Ak7JSI8afAgpnioP+GX0fK6ZJe0R7XksDSWnXOvExWQ6E5qqPZkcrVlqU3tO//UZb0tEkjSIq1DBZed0sB7LKH5nZCitL8WcgRSgcnOvQ5AuQo3y5wfJGof6nAPc414oxLfr3E7zgATdObKfEPULYYVrxelkP3v5kKwEO+PL52VS+D/gi9QOth/SL+F8C9xOlS9OOGCOQulpY83buQNfF0PrVL2XN3W8VNjiiqd97yqebAqSF9k5BBdMoFQ8GOHAKBFkq61IG5Io9WElBbcL33vZJYAjipeN3Dsz73Nn9bE7c3BvSNJGm3FFecN+Q2EKDH4Kv49rKCjAQWzB2Qf6nbCT2Zcn4T/0lwoCkbCc4Ivmb1/Qr0jmAvh8w1KSYlOnmvof3AGFJr9VlSoQzOLnKObHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(6133799003)(22082099003)(18002099003)(261026121527099003)(5023799004)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?07ZuuPn6xFIgPG6MQ/JTH/i5nDeBe14YB4KPRN4m+ndS5QsiOcj0yra49icQ?=
 =?us-ascii?Q?aCj9tjZs7EWQ1z459NpqWWhREJuBIkxhafFx+AaYDQkZUOtNJ72PZtX21pSJ?=
 =?us-ascii?Q?9gTzolOdQtz7CKayzbnZ4Khcsj/rVtAyvkyqtKsnPFPL/7oEOj8uS8D5QE2l?=
 =?us-ascii?Q?wLiZZr/9g4ujWaXtVh1TKwOelyR4bkolTRmc8ANemcXktJ8NuhewC+zOZipb?=
 =?us-ascii?Q?2kUC4KLp+sTyfH6z3uXSKGOl/iMsVFdEKEA8dSkhYpjWLucNWwaV/YW9CRfS?=
 =?us-ascii?Q?rUn+MXsyIdIT/C/lkrK9u1B3QM4wFfCBKdeLRAzAArJCeNKlm42iqDSBlA1G?=
 =?us-ascii?Q?Ua7XtCCEWbtTo2In4rkKlfowQbGAWJ7iILpK/FfvddRm3V6pFcSSTG3Ks4BU?=
 =?us-ascii?Q?xLAj6EgUlQc/YtCJ3VojZF4n/NPPoG4O9aBy3uRvBQVJyHGLMbcsZcnoVieA?=
 =?us-ascii?Q?WyXlz5wbo+fp0pyg6dEhgJsmXib8wRHqcBBIsnXTrqWLObgZfNownnfR50gH?=
 =?us-ascii?Q?peH1W30+jGJ978SEKp6d8VKD15VzqXo23X8do2W6sR0r5wGZb21Ig+TWyiMn?=
 =?us-ascii?Q?eoxOt0k/SLDHKFH7qTDyR8xwh4vnVpLlNUxY0z4HMb1Fm3DjaF065Tgdch4p?=
 =?us-ascii?Q?PoRMkM8hDHAEIoauD/13Z7bSXYf2Hw+n9K0grUVj7Um7iLuXFPEGTd4M9dcw?=
 =?us-ascii?Q?30QlXFFbWfkJOnIDyzdOjj8bOkOIt1l5QUlg+KTqP+dQmTKIjX6GeXMooDlv?=
 =?us-ascii?Q?v1Ee0AiPYnY8Ye88MpEmYY7I4/niebERPUuocU06EyefWqyOTk31BhI8Y5S5?=
 =?us-ascii?Q?lAzYr4K/WDpA8zsviqL13xVGurlJcvZF3VxwB2F7YgdI7+EZpS6CGComOEQN?=
 =?us-ascii?Q?1dBvJ6bP4DbjXMsdFQIKRp/4jhTFvMtJWgejxwWz6g6HBEk65uaXJ9Cha5vi?=
 =?us-ascii?Q?Fubafg8USyGueDx3owZ/HNPRWUwT1QwlQsdwh+nEe1dYkNoxxqowbIIhEqGT?=
 =?us-ascii?Q?IFfPAs3btPGgCyafbNMn6OUtdLnCyTS54Yp2W0F1UfTRW1jt4V56+mqw0MZ/?=
 =?us-ascii?Q?INjdpABK59z9ClaVWOlrNAYLAkLN7Dewd0tChmQaXs10SbYvLPyakpuLmgKM?=
 =?us-ascii?Q?ZqDJQVf9ao3GsCVjFEfQzF3VdESbDYfyYMvLW9QkzIc59e+RSTuc4Y77N019?=
 =?us-ascii?Q?F0fISkY/19d+XUzlDmdWnsaFr03UC62pYuOEu64ibV4sl/sPUacWQsn9YUp3?=
 =?us-ascii?Q?vlYTOvYkxf/jpSWuMPjF58B5vVd65vJn5bAzhthMUc/U84HKPMwSPgPQfODB?=
 =?us-ascii?Q?Wr88XjTa2w9gHJ0SapxOd5lE3ebk7BhtncgA75blLhCinZQcCIye6w/k8ZIg?=
 =?us-ascii?Q?R809+NQenQCoyAPlplNduy1yQdiZl3e0fU6u2TG/ZxNpDGmfJIFNMf+x+Edr?=
 =?us-ascii?Q?hwmo5OubDtwxZBOKgWe2UaP/T6bgr/crRLjmaKBQ/3VCTM+cn2kWvDtdTzh0?=
 =?us-ascii?Q?KY7zQQHV5B/zZaNRYverDBwCgujCTwYEFSFONLo2lciZTVa3EtdbijuwmLOv?=
 =?us-ascii?Q?B5p62i+gJTVOF+2IlrSeDISSMuiVckckeGt8l3yXBrVqAX4x4vHPL3AVNXfg?=
 =?us-ascii?Q?X9IhFAhlBzej3Iw1BxESNuLBcwlK13zlFiljTb9FbFTjVlqZv7sTbsaoePqr?=
 =?us-ascii?Q?w4VG4gllvkad9qcvM2g8EuKbcSPUdRI37+Oum+Lett9AzvZNlCiWio65KAsv?=
 =?us-ascii?Q?LRbsZgiD1jc8WiVtpRtw14aJKjFpF/0=3D?=
X-Exchange-RoutingPolicyChecked: 4CAux1bT1ZmtRT1lMu78a8UZss7dc8G0pUWvD55j4X4RYr0BpUuc9mrT4OajjTjz0kjM0erLla3IfsJlZCdk5QdQckMD4X5f7O2FbCUemQJryTga4HFYEvqukbbHloR+Rg9UfArq5i6/SkWXnkLjCq/vvAO6iuy0q5wB/vYa1QwifLkz5HSxlsenkfKfL7wb/NkKAjAgrvSmHnG8F4VFpC9wKwVm+BMuW569f1G2ajy47JX4Z90DNbDl2KxgsYpVBbMWdBpcIhYcscZ+gPqRCWJCJJUCIa2howTcSxn1mG+lA5jJdMZ2yupqA20OxGQkL0Jq9vMhvL99HhmfRZ7zzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 017b36b9-2901-4473-06c5-08df33e35776
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:32:43.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mes4JTY7tZs+Y6XASxLmKSNtf3WWgLkVf2rsCGI+om9OJK7XEqSpAsJq33fk+N4YJe2pULTUR5aQ5ljdDGxZJ/gXSiIF/TfDAcmINxq7xNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
X-OriginatorOrg: intel.com

On Sun, Oct 11, 2026 at 02:14:17AM +0000, Srirangan Madhavan wrote:
> Refuse reset unless enabled system-physical HDM ranges can be reserved
> exclusively and CPU-cache invalidation is available. Invalidate before
> reset and again before ending IOMMU exclusion, holding range reservations
> until the second invalidation completes. A later patch places state
> restoration before the second invalidation.
> 
> Reject normalized-addressing decoders because their cached ranges are not
> system physical addresses. Ignore zero-size decoders because they map no
> address range. Refuse reset when the device decodes memory through its
> DVSEC ranges instead of HDM decoders, since the cache holds no range to
> reserve for that memory.
> 
> Provide the range handling as a region quiesce in built-in CXL code. The
> quiesce lock blocks region commit and teardown for the whole reset, and
> the HDM state copy taken under it supplies both the reserved ranges and,
> later, the state to restore.
> 
> The range handling and region-quiesce structure follow Dave Jiang's
> reference implementation on his cxl-type2-reset branch.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=5944c6e61f14c0dd28d54537be15edb2cadb0e8b
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Hi Srirangan,

Please revisit the tags and the inclusion of a link to DaveJ's
private branch.

If DaveJ contributed code that you used, then the tags would be
Co-developed-by: DaveJ followed by Signed-off-by: DaveJ.
(Assuming it was non trivial which seems true based on branch)

If DaveJ only suggested you create the patch, ie, you need this
functionality, then it's Suggested-by.

I'm not sure you should include the links in the commit log since
they are to a private git tree. Maybe just include below the line.
Those links are on more patches than just the ones you added
DaveJ as Suggested-by, so very that is odd too.

Anyway, that's for you and DaveJ to sort out :)

-- Alison



> Assisted-by: LLM
> ---
>  drivers/cxl/core/hdm_state.c | 274 ++++++++++++++++++++++++++++++++++-
>  drivers/pci/cxl.c            |  50 ++++++-
>  include/cxl/hdm.h            |  47 +++++-
>  3 files changed, 366 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index 9a31f5996c74..cef604013350 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -1,7 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/ioport.h>
> +#include <linux/list.h>
> +#include <linux/memregion.h>
> +#include <linux/overflow.h>
> +#include <linux/pci.h>
> +#include <linux/rwsem.h>
>  #include <linux/slab.h>
>  
>  #include <cxl/hdm.h>
> @@ -10,7 +18,8 @@
>  
>  /*
>   * CXL state that must stay available while no CXL driver is bound: the CXL
> - * locks and the per-device HDM cache filled during PCI enumeration.
> + * locks, the per-device HDM cache filled during PCI enumeration, and the
> + * region quiesce used around a reset.
>   */
>  struct cxl_rwsem cxl_rwsem = {
>  	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> @@ -62,3 +71,266 @@ void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
>  	}
>  	kfree(info);
>  }
> +
> +/**
> + * cxl_hdm_cache_dvsec_decode() - check for memory decoded by DVSEC ranges
> + * @slot: cache pointer owned by the device
> + *
> + * Return: true if the published state shows CXL.mem enabled while HDM
> + * decoders are globally disabled, so that the device decodes memory through
> + * its DVSEC ranges, which the cache does not describe.
> + */
> +bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = *slot;
> +	return info && (info->dvsec_ctrl & PCI_DVSEC_CXL_MEM_ENABLE) &&
> +	       !(info->global_ctrl & CXL_HDM_DECODER_ENABLE);
> +}
> +
> +/**
> + * cxl_hdm_cache_snapshot() - copy the published HDM state
> + * @slot: cache pointer owned by the device
> + *
> + * Return: a copy the caller frees with kfree(), ERR_PTR(-ENXIO) when nothing
> + * is published, or another ERR_PTR() on failure.
> + */
> +struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
> +{
> +	struct cxl_hdm_info *info, *copy;
> +	size_t size;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = *slot;
> +	if (!info)
> +		return ERR_PTR(-ENXIO);
> +	if (info->decoder_count <= 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	size = struct_size(info, settings, info->decoder_count);
> +	if (size == SIZE_MAX)
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	copy = kmemdup(info, size, GFP_KERNEL);
> +	if (!copy)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return copy;
> +}
> +
> +void cxl_region_quiesce_lock(void)
> +	__acquires(cxl_region_quiesce)
> +	__context_unsafe(token maps to cxl_rwsem.region)
> +{
> +	down_write(&cxl_rwsem.region);
> +	__acquire(cxl_region_quiesce);
> +}
> +
> +void cxl_region_quiesce_unlock(void)
> +	__releases(cxl_region_quiesce)
> +	__context_unsafe(token maps to cxl_rwsem.region)
> +{
> +	__release(cxl_region_quiesce);
> +	up_write(&cxl_rwsem.region);
> +}
> +
> +/*
> + * Bound the range twice: request_mem_region() takes resource_size_t while
> + * cpu_cache_invalidate_memregion() takes size_t, and the two differ on
> + * 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT. range_len() can also reach
> + * RESOURCE_SIZE_MAX + 1 for a full-width range, and wraps to zero when
> + * resource_size_t is 64-bit, which the !len test catches.
> + */
> +static int cxl_hdm_range_validate(struct device *dev,
> +				  const struct range *hpa_range)
> +{
> +	u64 len = range_len(hpa_range);
> +
> +	if (!len)
> +		return -EINVAL;
> +
> +	if (hpa_range->end > RESOURCE_SIZE_MAX) {
> +		dev_err(dev,
> +			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	if (len > RESOURCE_SIZE_MAX) {
> +		dev_err(dev,
> +			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	if (len > SIZE_MAX) {
> +		dev_err(dev,
> +			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
> +			hpa_range->start, hpa_range->end);
> +		return -EOVERFLOW;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_range_add(struct cxl_hdm_quiesce *q, struct device *dev,
> +			     const struct range *hpa_range)
> +{
> +	struct cxl_hdm_range *range, *next, *new_range;
> +	int rc;
> +
> +	rc = cxl_hdm_range_validate(dev, hpa_range);
> +	if (rc)
> +		return rc;
> +
> +	list_for_each_entry(range, &q->ranges, list)
> +		if (range_contains(&range->hpa_range, hpa_range))
> +			return 0;
> +
> +	new_range = kzalloc_obj(*new_range);
> +	if (!new_range)
> +		return -ENOMEM;
> +
> +	new_range->dev = dev;
> +	new_range->hpa_range = *hpa_range;
> +	new_range->len = range_len(hpa_range);
> +
> +	list_for_each_entry_safe(range, next, &q->ranges, list) {
> +		if (range_contains(hpa_range, &range->hpa_range)) {
> +			list_del(&range->list);
> +			kfree(range);
> +		}
> +	}
> +	list_add_tail(&new_range->list, &q->ranges);
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_collect(struct cxl_hdm_quiesce *q, struct device *dev,
> +				  const struct cxl_hdm_info *snapshot)
> +{
> +	int rc;
> +
> +	for (int i = 0; i < snapshot->decoder_count; i++) {
> +		const struct cxl_decoder_config *config =
> +			&snapshot->settings[i].config;
> +
> +		/* A committed zero-size decoder maps no HPA. */
> +		if (!(config->flags & CXL_DECODER_F_ENABLE) ||
> +		    !range_len(&config->hpa_range))
> +			continue;
> +
> +		if (config->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
> +			dev_err(dev,
> +				"CXL reset does not support normalized address decoders\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		rc = cxl_hdm_range_add(q, dev, &config->hpa_range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
> +{
> +	struct cxl_hdm_range *range;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	list_for_each_entry(range, &q->ranges, list) {
> +		const struct range *hpa_range = &range->hpa_range;
> +
> +		range->res = request_mem_region(hpa_range->start, range->len,
> +						"cxl_reset");
> +		if (!range->res) {
> +			dev_err(range->dev,
> +				"cannot reset while CXL memory range is busy [%#llx-%#llx]\n",
> +				hpa_range->start, hpa_range->end);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_invalidate(struct cxl_hdm_quiesce *q)
> +{
> +	struct cxl_hdm_range *range;
> +	int rc = 0;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	list_for_each_entry(range, &q->ranges, list) {
> +		const struct range *hpa_range = &range->hpa_range;
> +		int rc2;
> +
> +		rc2 = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
> +		if (rc2)
> +			dev_err(range->dev,
> +				"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
> +				hpa_range->start, hpa_range->end, rc2);
> +		rc = rc ?: rc2;
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * cxl_hdm_quiesce_prepare() - take the HPA ranges of a device out of use
> + * @dev: device for error messages
> + * @q: quiesce state to initialize
> + * @snapshot: HDM state from cxl_hdm_cache_snapshot()
> + *
> + * Reserve every enabled system-physical range in @snapshot exclusively, then
> + * write back and invalidate CPU caches for them. Call
> + * cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
> + *
> + * Return: 0 on success, or a negative errno.
> + */
> +int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce *q,
> +			    const struct cxl_hdm_info *snapshot)
> +{
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +	INIT_LIST_HEAD(&q->ranges);
> +
> +	if (!cpu_cache_has_invalidate_memregion()) {
> +		dev_err(dev, "CPU cache invalidation unavailable\n");
> +		return -ENXIO;
> +	}
> +
> +	rc = cxl_hdm_ranges_collect(q, dev, snapshot);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_hdm_ranges_request(q);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_hdm_ranges_invalidate(q);
> +}
> +
> +/* Evict lines fetched during reset before DMA exclusion ends. */
> +int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
> +{
> +	return cxl_hdm_ranges_invalidate(q);
> +}
> +
> +void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q)
> +{
> +	struct cxl_hdm_range *range, *next;
> +
> +	list_for_each_entry_safe(range, next, &q->ranges, list) {
> +		list_del(&range->list);
> +		if (range->res)
> +			release_mem_region(range->hpa_range.start,
> +					   resource_size(range->res));
> +		kfree(range);
> +	}
> +}
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 9eb13adf0daa..3da8b316857f 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -15,6 +15,7 @@
>  #include <linux/iommu.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> @@ -392,7 +393,8 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
>  					      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
>  }
>  
> -static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> +			      struct cxl_hdm_quiesce *q)
>  {
>  	int rc, rc2;
>  
> @@ -417,12 +419,18 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
>  	rc = rc ?: rc2;
>  
> +	rc2 = cxl_hdm_quiesce_flush(q);
> +	rc = rc ?: rc2;
> +
>  	pci_dev_reset_iommu_done(pdev);
>  	return rc;
>  }
>  
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
> +	__must_hold(cxl_region_quiesce)
>  {
> +	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
> +	struct cxl_hdm_quiesce q;
>  	u16 saved_ctrl2;
>  	int rc, rc2;
>  
> @@ -432,14 +440,39 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
>  		return -ENODEV;
>  
> +	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
> +	if (IS_ERR(snapshot)) {
> +		pci_err(pdev, "CXL HDM decoder state unavailable: %ld\n",
> +			PTR_ERR(snapshot));
> +		return PTR_ERR(snapshot);
> +	}
> +
> +	rc = cxl_hdm_quiesce_prepare(&pdev->dev, &q, snapshot);
> +	if (rc) {
> +		cxl_hdm_quiesce_destroy(&q);
> +		return rc;
> +	}
> +
>  	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>  	if (!rc)
> -		rc = __cxl_reset_execute(pdev, dvsec, cap);
> +		rc = __cxl_reset_execute(pdev, dvsec, cap, &q);
>  	/* Restore cache policy after any attempt to disable caching. */
>  	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
> +	cxl_hdm_quiesce_destroy(&q);
>  	return rc ?: rc2;
>  }
>  
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc;
> +
> +	cxl_region_quiesce_lock();
> +	rc = cxl_reset_quiesced(pdev, dvsec, cap);
> +	cxl_region_quiesce_unlock();
> +
> +	return rc;
> +}
> +
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	u16 dvsec, cap, ctrl;
> @@ -466,5 +499,16 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (probe)
>  		return 0;
>  
> +	/* The cache is owned by @pdev and does not require a bound CXL driver. */
> +	if (!cxl_hdm_cache_present(&pdev->hdm))
> +		return -ENOTTY;
> +
> +	/* Memory decoded through DVSEC ranges has no HPA ranges to quiesce. */
> +	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm))
> +		return -ENOTTY;
> +
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return -ENOTTY;
> +
>  	return cxl_reset_execute(pdev, dvsec, cap);
>  }
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index af7cef649446..f6446a2a7fcd 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -3,9 +3,14 @@
>  #ifndef __CXL_HDM_H__
>  #define __CXL_HDM_H__
>  
> +#include <linux/list.h>
>  #include <linux/types.h>
> +
>  #include <cxl/cxl.h>
>  
> +struct device;
> +struct resource;
> +
>  /**
>   * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
>   * @config: common decoder configuration
> @@ -42,7 +47,6 @@ struct cxl_hdm_info {
>  	bool dvsec_ctrl_valid;
>  	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
>  };
> -struct device;
>  
>  int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
>  				 resource_size_t size);
> @@ -52,5 +56,46 @@ bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot);
>  void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
>  			   struct cxl_hdm_info *info);
>  void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
> +bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
> +struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
> +
> +/*
> + * Region quiesce blocks CXL region commit and teardown, and with them decoder
> + * reprogramming, while reset handling captures or restores HDM decoder state.
> + */
> +token_context_lock(cxl_region_quiesce);
> +
> +/**
> + * struct cxl_hdm_range - HPA range held exclusively across a reset
> + * @list: entry in &cxl_hdm_quiesce.ranges
> + * @dev: device for error messages
> + * @hpa_range: system physical address range decoded by the device
> + * @len: length of @hpa_range
> + * @res: reservation of @hpa_range, once requested
> + */
> +struct cxl_hdm_range {
> +	struct list_head list;
> +	struct device *dev;
> +	struct range hpa_range;
> +	u64 len;
> +	struct resource *res;
> +};
> +
> +/**
> + * struct cxl_hdm_quiesce - HPA ranges held exclusively across a reset
> + * @ranges: list of &struct cxl_hdm_range, see cxl_hdm_quiesce_prepare()
> + */
> +struct cxl_hdm_quiesce {
> +	struct list_head ranges;
> +};
> +
> +void cxl_region_quiesce_lock(void);
> +void cxl_region_quiesce_unlock(void);
> +int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce *q,
> +			    const struct cxl_hdm_info *snapshot)
> +	__must_hold(cxl_region_quiesce);
> +int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
> +	__must_hold(cxl_region_quiesce);
> +void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q);
>  
>  #endif /* __CXL_HDM_H__ */
> -- 
> 2.43.0
> 
