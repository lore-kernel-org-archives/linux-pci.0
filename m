Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793907118;
	b=kEnGUTz5QLzUafd40H2WdJrlyQAoAQdcFvVfT/vBGwRlepsEpV4//tYoFcixMfpsR5es
	 4S9o4DzzJkCo6xrXJ+gIn5MpNCZT1KPKv6hPRLeUgUUWFgRwe5J+0H9uj89moT8dVIHWV
	 7SO/wE+fYspckUbbz7NZvxaQuS4t9vEWs9hYwEYyVbx/9sb9HrKyMzit68+vbGqBhGCO1
	 WLC39Nx5jtghfqzF1wHcOSGX2BpdddO5lQTYwM2QQaENSd3SfVfj2bENgGVX1W6ewO8+i
	 dsBX1FgbuFUobFtt7JhjXKz2KpAbhGUOz8ON/rBJCi4s2PPo0ySLdMbPUERkwYsi+hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907118;
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
	bh=HyA6OZZ6N7dgKGpUAVpgEVuegbPPq/wy6smKJZEn+FQ=;
	b=3TrJKf6DyQtg8eI9Rlse5xnFwwXOGbhlBTdHvMmfpf9eb4JgogkjvywqSOvxx1tCqgSw
	 mjN0IcO36/rQKYzSRkivE/BvVcJfegzz7oyoCVc1geedInE4v50LQAnWsrlhF3/dlLgRn
	 uLM+HOIeRtjYcNgNrpOsPgb0zv6mNuYrSeGUUvv8ogJxoBnma7BIx2qNitK7akUSWoZs6
	 1Nj3cOEOfOY6RZUsHaRGRrXLbYWTr3An92L6jMStXNrvjmoIdSEWarDNWTomwauO3tY+q
	 rivdhBol84gJ8RQzU4rjRJS4nEHqgxgvAZa4y6pjqNptxNh/+JM/Dz+YkQoEyg9MKXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g5lCKslG;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211E606D834;
	Thu,  5 Nov 2026 19:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0211E606D834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g5lCKslG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793907116; x=1825443116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PBlrdU4vOtqhIHolc4etLupQ/LxCekWuYhxPkSgClEg=;
  b=g5lCKslGL7GufUdWd+LZnrptmTjFv68tLFZ8XKKbgiNctUkGRQN9atb4
   +e3rL1pA0zMv5k7vM4uqDO0/REovrR4Viuocsi3Ksv8Ero4eJ+F1gnaEh
   Yooo/IlvQtP4yV2tGuMSabszzXj1pVHAGMtQiQ0kZIZzt1GaPqev4ZzDc
   g02aIIPX4630RPbVxy9qQ/0rPpAyTsFWeUcgpkazDW8PqeR0fwUm/QHhq
   /ZBI2mjquvzm+b9SRxrQZNA+gui+dwHp3qldFcaWgEvpFrImIjNteB3UC
   n8fJy36O0/Hjt0WDBS0fQNUKhBHEu9HeYwu0Rt7bzRw3xt+dbT6a1OFT0
   g==;
X-CSE-ConnectionGUID: RPv55hywTCWeRNAo15HxRg==
X-CSE-MsgGUID: RFs2gsG9SmKt2Ym6E8F0Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2803293"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2803293"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 11:31:49 -0800
X-CSE-ConnectionGUID: kMm66g8NRF6+ahdlf3eIOQ==
X-CSE-MsgGUID: kcjQwU37RMSjGXE9WWfeAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7411661"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 11:31:48 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 11:31:47 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 11:31:47 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 11:31:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFcLbJtwdaWeJod3/L2ZYfXdDbiQA11WBom0NdyvwkOzTKq8QDlisRy7IXjYM5Zq8THLkJeB+QBeQBnFSrjuvNVneLiQ1+sG3QDkU4W39zSlu+FUyk4iXZqtWyGaAaig2uJGBuX8mRPIjTXxWq+hFDdAU6OlX5CPCm+epjVYnnL9bozbNOuyOz2OHD8Wmo+sdt2XJLv3Y1SeVHF05zEUoT5vfdwVEr1DTCRJBg17Y/MZR11wOXVGw9py0syxBpD6cxIBzKsOcq2KNy/TJ6w3oxydb+fV62oUk4V92y5IHlV4J4c40zldz5J/8LWDxo+AJrIkn4GAFaKScBeyDSMw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyA6OZZ6N7dgKGpUAVpgEVuegbPPq/wy6smKJZEn+FQ=;
 b=Lu/RmLbN0nS105/gsUHti1YjUVwtwFHNnfePRIIWnc3sM/5mOVIlfG76ARDEp8OmSUEoJd9EZo5ALcEDT5NaRzL8VmsCZIwrCRZNYmMbWFEGumJZFudMFXHvtBx4+UoP4sbUAt8bEi+TtjDy0RMtJNq4Qn6UoBCl+VSc+W815FuXpDsTwpfhu2n+GBHdYaNfb1Bvft7aCdIDMsy990UiKJiHpKubK76MyQudjhpeVjO7MIvygcgG6nbEhwKCuBD3rH9LT/ZWfCmhtyGMxyLbd7cItmiKbUlbK8AupDE6ijBVofhzJB574LeO9qONt7PND1ND3pkQsy+KmhRfMUzF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SAWPR11MB9922.namprd11.prod.outlook.com (2603:10b6:806:54c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:31:45 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:31:45 +0000
Date: Thu, 5 Nov 2026 11:31:40 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Li Ming <ming.li@zohomail.com>, "Joshua
 Machauer" <machaujo@amazon.de>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v17 00/19] PCI/CXL: Add CXL reset support for Type 2
 devices
Message-ID: <auzZnE9zYEpjutiX@aschofie-mobl2.lan>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
X-ClientProxiedBy: MW3PR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:303:2a::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SAWPR11MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: e73b7912-abdf-4ed3-7e84-08df3b736d60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|11063799006|10067099003|261028144727099003|261026140227099003|56012099006|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: CsEJFiYWjL6wRciZMemaQRJOSQMyPLk78RDyWa6/Rbr2cy7MrIy+Mm6lIUNy52VPUXY7enzh+wgr/XcNgCZi1ndYqbtFhjqHQo7Qc7OyU6BKTIHmmeoMgEMIQ05/H0HHh1p5sq+Xzl/go4OKFuGxzb5Ww103hGJh4LoyL+y1LsyZfLtC/svWREONv/taGPgANisqUZr5UlhC6zYcyeGfjEACYT5WUoahERe8906StlL3Trb8nKPsE8YTHp1oI3XJyOqTwej5NCu4wkc0hHTCq+51CWriQMTPIZZQCBkZh85XuA+K7vhkx2bM/YeQtbR63bC+NepRCeyqsnnMZbhEv2Atmugz+WU0HeW24HaW51YXxCsNwBV+TTRT4IjwUPnqYSlBEpAO57KzhVGmjF7XVB4h8+RWpNpFw0u1uXterSs9Vt2Y+2rzyNEsfiO6DYNAvjBbbJS6jDAaNIlGYQMJQhLV0fJIBcK4FiQ+lDaKxMw/JODBKcTT6lgooBvsMzLtKi57mb6XHRge8zRkgk4d2+/R/OVuHlBCfDlxJx6VnncFKtE1mS1alzu1/LGi9cUTd76ltvHXEAjZ8yfgpWUV5o5Ox1QSLMsxJWBJ9eIDVefIm11KhB5eVhtXXJRmBAwd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(10067099003)(261028144727099003)(261026140227099003)(56012099006)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?26bXPkPEg/KYUSwQffdSOMflumoTbIIYpe8iEi9iejfdB8QaqpN1s2c/yaTy?=
 =?us-ascii?Q?TyqlCu+2zYSeA9l9VYmCvozpJFeTNtwPMoVMT3xmHeTeYtmEIInHWuJI2oBW?=
 =?us-ascii?Q?w0FGLjKcGDn31U31pmJqrlW6DbaIClXOGtu5vvtecbq272f7r9y+NsCruFXs?=
 =?us-ascii?Q?v6XArahWaLDgqprQl0TMbcpSv7vukBbNH4s2kVH47l/sHs0/FVrENz2jLzuM?=
 =?us-ascii?Q?Zct5uTFBwpeGsrpn1O/kHP0w7qzuMb19P2WJUArriQKwq/TgLZ3NHFHl0tQE?=
 =?us-ascii?Q?EAs7FQlrqFQapIjc0opmt/1cuFWs0EuLqLb8sG8LnGIxDoFrWJwvBOOMuyfG?=
 =?us-ascii?Q?FWLKhuomoMyTx4oHHS+vBThhg2ItKIS/mRxYmY2BkFAyUm09qswp9FVFn+Oa?=
 =?us-ascii?Q?ZpXYFTSjg5CJ9CBGuTn0ut43oGFnovieD/XdT9cIj4HX7fM62iZY92VzsHv8?=
 =?us-ascii?Q?5KUcb/gHPF/58f7LxBOa3uM08Wcs7JxcfUom0DhJ05rJ8yE3BzorV3EKu26p?=
 =?us-ascii?Q?KC8OVAcBuf0peehhC4vDOFeYXx0M7Pzw2+ANUWMq+kKCkiMhEC1Jin/PNeoY?=
 =?us-ascii?Q?RXsR2h4Vy1TDjy/mz5YTCCXTkF5oGRdVGZr7kB78K/kEmDZtwxAXWgw5j7IB?=
 =?us-ascii?Q?5Wbda7opwi1ZjlYcgnCw65deyEHfcMMNZPiDJkJ8w4iW6P6VHt3YsJ/1nXqz?=
 =?us-ascii?Q?zp8ZF+ixyZePEKXdiAmr61yVQJMncEgZ8TbS+nNEQlyua5fL2LFQrIcv0oKp?=
 =?us-ascii?Q?BG6U5UHcCydm+ijhSOL8Xc7UA1qpYRNwP0khWTBWSer9GzqQPHV1iBlNNX99?=
 =?us-ascii?Q?roN0e31NJ3A1F7X6a8sNfTeWu5vMax1uk8jGY8FWRtWlVnkz4EByp/fW9wth?=
 =?us-ascii?Q?UzCam33q4gJHNw3PuuXweTkpewAkwEB7HZW3aoynth6nI9UPz/gNpwGrayEx?=
 =?us-ascii?Q?Di9UEitRRn3M4GPEoIoay6lf3w5xvi0qhtPWIHFH3eb3dlyZouvrms1FJHn1?=
 =?us-ascii?Q?nZe2NrMEaQs+ADMrlBCpznuSZZVckYpLMNFyH1w5hrVzD3CXvayj9z1k18W7?=
 =?us-ascii?Q?z4rU7552hnv+0y/CogePqYXZrJotCoYnMFmthm9Z6rPfBvxhIx6/j0s9IMfa?=
 =?us-ascii?Q?JSpWbol4Po8oNzjar62k43pFBtg4XPPpFhXaPO/ytkX96+QjMMgMTjQCk5pP?=
 =?us-ascii?Q?pirzEB3Mi50qh5Ty+cUEhObdNwBwjUIq3omL1XARPl29/kbWgVml4HEW6pRx?=
 =?us-ascii?Q?ulak+cQTKh6IS0WnpftLyhpp5fNbp/fiK+YGkBfalm16JrlfNSF98jMlHEDo?=
 =?us-ascii?Q?XC8PkS9HZS++49PD+hubkq6isLBSj34pDPZSnpwh+VnYSZi0JbqUBjf0WpAx?=
 =?us-ascii?Q?54lgxZw/BsJWPYt2wLIOi38uPVPIxqZLglySjpR1eDj4Wr5nnn87V9KA2Bwo?=
 =?us-ascii?Q?k+5JzXPcEE6ZXhUl+bHwTutMu/EBYfuwhHd30CfJ39R8Rh2OFzj7938Qwzg1?=
 =?us-ascii?Q?YDvOMZumH1shsCelbkc4mY610Gxo5nQQEABT7dnV1UMcvV/+O5UYl1Xg2Xoo?=
 =?us-ascii?Q?bdJsg6F8eGQl05dDqeb6lkYcT1cOTVP+6lsGdOa7QKUD5t9qlnqsDRexTpj6?=
 =?us-ascii?Q?tdAuBeNuiBwI/hYGkA+E1ZWNvd3IqOok/ELKhMJWUB0Wje6WkHJ/LsdK80b/?=
 =?us-ascii?Q?JrDomxATQDNZVfZOO1KHF/NdM5lROQ+TjNEO14tTF/igt5+Jx0pZF858DwJG?=
 =?us-ascii?Q?EnLMFuWEsJGmGZeWN8o8aaRnS3xziUs=3D?=
X-Exchange-RoutingPolicyChecked: LyFgTr6he4vB+noRTychFFkLnkZQZT27p4wW0rLza2PVUNcITgu3vynx/1GQYRjqa72bLaAjgLSqImV2aPIBxBBbq3WSHC8Z7Rjg848dIbe8UvzHRWBrgk/Jj4FmJ2n62gMCSRpSjbzbziYmxyPSuaRX4Lf42hnKNtuJqiq2mrJzIA9X0lEp5Y2MiD7wgpNd5bKzHSPep9jECNPg9FIRFfjGvbECVNYVLBYHVk6tb2dgesqGC7jZNqnpZn9MwmC774wy0FxdZsjB3NobKfes+1gdIiNLWab4sO69rutBoZ4yAq/lhblkesRreYczy5kNw1hnXkblOGaW6RjMNn/TRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e73b7912-abdf-4ed3-7e84-08df3b736d60
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:31:45.4100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inJrzzr48NEK90xBReepGlS6PFKnzONkHJzZrObKQr04RxfLdK5QQ7TwoXZg9ptdq7j5HWWCtE8xMiMekk89wATZ5k/xiiTrBbyaMzQ+No4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9922
X-OriginatorOrg: intel.com

On Thu, Nov 05, 2026 at 06:58:58PM +0000, Srirangan Madhavan wrote:
> Hi folks,

snip

> 
> The KUnit suite checks HDM range boundaries, zero-size and uncommitted
> state, lock and target-type decoding, and 12-way interleave.

There is a KUnit branch available now to base on: for-7.5/cxl-kunit
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/

-- Alison

