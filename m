Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793300331;
	b=ljtbp3Xo2H2YMYui0nxxbQySfDGaYmlEw34pgkp2qhYmxt1Fhywiu6rwB+cGuB6u9lnV
	 Tyjx2h4/EcucfOhC+wkXkPjWN0GyJgx/OIsehnHvT6URRtgcAORRCCNGj7ivWc/rNgTz5
	 Fic6JJQNqB7ocpxZw+zoGD4cXchuLn7ZlbbbLdIsnZEF2t8JrJ0wOREMdUuoUmRClrn56
	 EA+N+9kHWCPOD7imqWImybEutMh25CpFlacTLmU7ThuHpsNYt3lBuTpxQYlaQLK+4B7Hz
	 U+NoYTct7XlROGj/vcoN2KrLPWduZlJMWfkawCEnQWIleUNgtRVk3Yu/IPC/ctz3Npw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300331;
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
	bh=NPiZ+08ulLx/vkZSEtkpezRbSQS6bYsKl0lEbL5mVQs=;
	b=Idi6t0XZDDuEHNvWMX2TYysqXP3q5u/sq2Ahek0j20TWoJlsOcAMofctEpWjaEvQljJI
	 g0kIASBp3/de0aPoQ9QRYEsOmiHO/2dhGgs3ecBuC5+sx/hSd0ZoxFs3UNw3OxPF+EYVw
	 lejL+nfzTmgOF97LqVTOhV7OlK8bOO1UGgehM1KanfYtXw2HKfUSjPmrwm+5hzzGRjhAg
	 C8NEvejQsaoacHkGHpLFhJDANEWN8/X9tWMnjryLWO5HZ3IBY5/kl520c9gsFbHWH208K
	 6jeg5BQyBIc3Otw4ashSvM7kZqEIEoi0QaKWRz3PXfip3J8myqRZ0XVuK1WQDz4OCWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XrYDXGS7;
	arc=fail smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA79606A32A;
	Thu, 29 Oct 2026 18:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA79606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XrYDXGS7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793300329; x=1824836329;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=11GrxuV4NlNs8iN8pO4wuSpb7LaXbS6hhqvNqPiqnPU=;
  b=XrYDXGS7X6PckvNDQvsr0QHBk0fhKvkOzSEh8Yjmm/32QRrEahmIE9nY
   jOiGnZoEGOiXIZ9334jDQt6O2+Kgjq6VFoTJ5LofXsO64fP0h5cN78Z4s
   /uRVGLugdo3a778k0LlyT5PhOlTOrDnq4sEWCTJ3xG1FNnYoDun7tT0ZO
   mNVQerxvb6JqI6nlkOqdaAYoXGI/rnVvYqBWtrhBdiaEI13ENaPae0WyC
   ZgsOPkzN02HKM6PHg1sreMr+iekAbBhHKIJ1C60OqV+igY84fSS85EURp
   7LGDfwPhuxoZbpb4f5NjHSpvfU/9Xh8LE0kCsoJpNRP6GUj7r5fgsVxuA
   w==;
X-CSE-ConnectionGUID: 0mXPZD/0SrSIvUj1d5G6xA==
X-CSE-MsgGUID: oAw9ojP4TqGxnAVUDD8AuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1933143"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1933143"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 11:58:48 -0700
X-CSE-ConnectionGUID: LJ81F3wuQ8GFhW+KU8Cbjg==
X-CSE-MsgGUID: L0VOrmtQRMesX84PNqkGvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="7055602"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 11:58:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 11:58:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 11:58:47 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 11:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/GustOpjR0ZRmCDIdiiNMJVTMRZ5udTPVhicBVrmRwktqPuIoInTg031Pz2cLHYolY50npZSpPHlbPC+CLNV/1GwFDWHF7fZf9l3nqvIkLyLFY19dZW7uWBjtRIsLzjHN/IDrMXheefLyooPaoV4IG/sfaOWthR0tAtBfMrOZBfplvKPSFJ6Q3Ga10BcJ6NtIyo2Ha6WDSx5jvMtQHbqoaDjx5/xybXSsS0sEVCF1cMeWy+5Dt7k/aVzfotDZTAust2rrwpsuCwiocZZNWPWjsByuqPoSMmK/oCPVMlNqnaz325Il3LrBYuB7zdKXK3yaWZolpVbmrumQTuuzXP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPiZ+08ulLx/vkZSEtkpezRbSQS6bYsKl0lEbL5mVQs=;
 b=FQF/1Ft8M7cAxvhz4FySUcDNoEUNhFvkVFmGuXfE/rl4qh8+I1wIhQpNQ4iim/F+tGaaL2gZ9xbGq7WDfYw7nBUPfxPrOttoR73AzsLwyotOeTI5TriQCM9aD6JLrMnsFBncIqUDxpuOfkJxzwOuortR76X5wwCqBWF5rfcQP+lKMVjTKmBPIdSSDDfWulRyIcQFud3tkAdZRN8/utP5Q72ZhftfH3BuqBSSV+5xfPed1XqrpxpiH5kT/vL3Yl7vVz83m+cZvrQXYJ9NFb+uHR1kaaUbWdvSCN4ug0RntA6M/3RmwFJL57YFx5Lbnz82LPE49HBfKv5Hbj8MdRVDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA4PR11MB9180.namprd11.prod.outlook.com (2603:10b6:208:56e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 18:58:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 18:58:40 +0000
Date: Thu, 29 Oct 2026 11:58:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Li Ming <ming.li@zohomail.com>, "Alex
 Williamson" <alex.williamson@redhat.com>, <vsethi@nvidia.com>,
	<alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v16 00/18] PCI/CXL: Add CXL reset support for Type 2
 devices
Message-ID: <auOXW3BTb8CYIh4m@aschofie-mobl2.lan>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA4PR11MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: ca00f338-33fe-431f-c9cc-08df35eea4d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|260925021311599003|260925022911599003|260925021911599003|11063799006|5023799004|56012099006|261009223027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|10067099003|261022113327099003|261022105027099003|261021121427099003|261021123027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: gu8uJKYY0j1Mru9EUj5c0Fz4ARcMuF5tQ23tYTovcpyFuN8yu+aJHlVzCqltxXWEOuSoJm8pGGUsKQoBAMpSqDvHct90jpQjA+FA7w3RXb0i7wk3evqjf9Q8K99EXIDa98nCjQsKu3GCWdIdJ2CT05LLr/oU2xqA8VE3OJm0qrwreCo3pKhFNQysnEd2NFWqo/bz95P2usTqzLXNPNLHJ19vZSD3STrdDtestWCxxZ3ce6Wd8dFZYTpGYMgyrZ20D/m9iWs3g37ehg4m7XFlv/QCtG7scUOTaEzJYtkUqEP8YB3rrun1G3NHTRKX7haIIf42Ure+YOK9VK7vKXK+cySAE7I4F/XgxCI5SBRjsa4PWwwj5bWVsAug5aMTGvdZG75/WcU+LFw1HjUH7DqeVIEoTAJaSbJ+Kdz3ubuddu32B3FzUMUAP6slFkENaDMyRsE/6A/1NDUaWCqMoNBpHqtQQA7/YY5oFZt+cs3bnoDQV2qMwT1/4jOM7JCX0J7PPnYW19j9k6urCTqDWYUDi2HNy+ydBpbs4UogJD4A3XJksbBU5PLkNs6gwdOixkxpXsHBPlA5eJyV7FBj1j2XUhxsZ1GigeNBqDcpgqhtX7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(10067099003)(261022113327099003)(261022105027099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKuwl4TPJa2VlS9chhLt2oSGaDFwrFKp3vGpP09OGs/DIrNi/4PjnwGYywYa?=
 =?us-ascii?Q?t7/JXogksfU79Z2Ro9F/2SXDxbTSlXR3yx2y48XTJ54GmC1fL1CP8vYOzmvV?=
 =?us-ascii?Q?rIp0jWzMfn+10Pi1mdrwf55P02nN3nZAAYerDhcrr+NCp9p9g/q3DPXZTmyA?=
 =?us-ascii?Q?nQEIBflxH2Pjn7bV3j4PIVOOegY3QbzPumlY5XSa3ZDAacKzJzVEMnvkETjp?=
 =?us-ascii?Q?3ahPPTjkYnP/IPmvp3bsoN0Ih6EKwJMzxi+vaVMxHLvh5kDhxyshbGdXn5w1?=
 =?us-ascii?Q?fiKNAbsazXsnTapUHu9SwFTQtac3VokHSp1HslG2S9jPBn7yP1RMvZCsxE1q?=
 =?us-ascii?Q?vNNN6R+bJrXck1BJfGQbJnjeuD5k67ZZp55sqYdKCxGw8jW/n6PFeXDz0oMO?=
 =?us-ascii?Q?o9j8raQitrXNyHJvXyofAHSrSLdYv9XKJ2zOEc2O7Gd2jXtPr8q1QeQu+4uC?=
 =?us-ascii?Q?MEmhvfRzXDW7boOPVFwdhutAdngvWlYLfDvJMDeRKxrAbSRZa+1UDSuFR/ZM?=
 =?us-ascii?Q?NLd5eQ/5lYLLUsrJIyl1VsdBPjcckcNK3eTYN+kYs1lWQc6dm9ed8+qfnyBT?=
 =?us-ascii?Q?q/picIi8tq8uM0essrVOeAkqVDVg9r7EyMuplk2VwyMkcbZPUdWlCiLkIZNC?=
 =?us-ascii?Q?k2sIouu1OAKRAcugslM+XqJ7E18Xf1qcwBe+54nJlfDMPoWy8AylqcIV3GFM?=
 =?us-ascii?Q?C8FTFT2Dm9XYj32ee3tbI2FA/IJ2k1InKilqfPY5YM3WIoMs4PqyIg2h+USY?=
 =?us-ascii?Q?iMIoLg2x7wnDeal8pTCFfBbTZIIoU6dGTAwxvZ7eefJIwa1y9nruGRo220Zp?=
 =?us-ascii?Q?bc7x1tEuYU336Jimx60gEg0AGuwHwveFAJxdFj2Rpbiw3tyTPKlC8Y21mKYK?=
 =?us-ascii?Q?RLaoREQtWKjfySDelg5vBB5X+vsqPEPsQV6sQ4t3yIA7TnfpGIMWVyf3/Nyk?=
 =?us-ascii?Q?cOrOA9UqWVnKfcowTOBYftS41kmif0hLaifjzTEzB5mmIzppMhAIjm8vL+uZ?=
 =?us-ascii?Q?pAqdgFbbq4U/0iEf9CY6s87dwoZb1pvQsUaxZe5t9KIm85JIbJi7WBXYmqUf?=
 =?us-ascii?Q?1C48lS728y/08hYVpH9xuRKwi4xbc0PMB16rNc+aXrKkfIkwH2jeBCmKIHQq?=
 =?us-ascii?Q?pQvgrcvtX1/yGelCNmpy3uS5gzISRuCbgPPQYnC1JROocgquisft6eTqkDN8?=
 =?us-ascii?Q?QtQb426u1yvzUzgZJ6bvboSidL3vX4JdKr/jiK5wAEGJ6PK5QsLLvcIyudX8?=
 =?us-ascii?Q?vfR+WhhV1ElNVLFxLondIevQWQ51fCt+F6Iphf7yZBleumNYWyrPYNmLKy2x?=
 =?us-ascii?Q?H7gpGwSnmypoHraSHdnu45G6lTWE0Vb5Cd9pNIco3aOS+HyvQXxYAJQdCrQt?=
 =?us-ascii?Q?TbyaHWcmJ9WTGKTcewVBnfsOXTaCH7FtVQQJT0nK+2yJ9KeJshbN2qMFy29l?=
 =?us-ascii?Q?53C2sxiiQ10V6GsMwU7SnyR7DphJ8Vr/4cmJSu5Gtsp97PabP2BElVRSeoBy?=
 =?us-ascii?Q?1AORcxoelfIKiBGEX6WOfNG9V6sgBiSfa6TSjnjOFZHCWBQSgWs5KndEkdQr?=
 =?us-ascii?Q?tyLbHr2AG5fly+GNTYQkJRff579+KWiefR499K1NsM+ao5zKs+ZJaVoe4xD2?=
 =?us-ascii?Q?Iif1g+C1AJn+P772QRSVg2mMN09+WUxwyOk0KYZQC/2oBW8CpDHdy38lVnid?=
 =?us-ascii?Q?vIrlaA+xDAclxwjLYzmSxjNK5bRWvdm3hLrptXB+uoN691jT2SNMaHllyBT5?=
 =?us-ascii?Q?UfgICrHxjH0POpd6C6xLiVBgiHuLMxU=3D?=
X-Exchange-RoutingPolicyChecked: yOsjYEcvtyt54n3AgrYFxUNYLVQBLn4V/kOcpchCqJlQbfkzuljTdnPRP7eCPy5edC/UXzdKwUvPhcDYU6HSqZSaqS0GLaGtcdlVIYakujXkm0FopzJ5Nb23ENPzVVoHC03zzqtFCj/STF0b1E0d5gHqdLC4taUl4vdxIX0rOs7QYYJycPnYzOfpS3jz1EWYnJnuFGi20bJyB3tP9YtMZbeFQj6olp2ej/7UqiALzEYF1ug/MmH3E7WfrJY5hq9AFLg3kNQ8oT/lTN63JhYyKeQHwRTaReI/iVhgQighR43jyJmwwdTwpiekWVBMi5physpdz3wxQ2MlfkXOdha1kw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca00f338-33fe-431f-c9cc-08df35eea4d8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 18:58:39.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7dVx4Pqjqctz/gtMex6XVXLD8CbgJ+aJ32rTl9PLLmDHMXn44Xx3zsEI6Zbe6Q/8zzCh5rbrI/R44WiowXpDpnLyrZhTWoPA0k9eyL1Yo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9180
X-OriginatorOrg: intel.com

On Thu, Oct 29, 2026 at 02:56:45PM +0000, Srirangan Madhavan wrote:
> Hi folks,
> 
> This series adds CXL Reset for Type 2 devices through the existing PCI
> reset_method and reset sysfs attributes. It disables CXL.cache, performs
> supported cache writeback, initiates CXL Reset with Memory Clear, and
> restores cached HDM decoder and CXL Device DVSEC state before PCI use
> resumes. Active HDM ranges are reserved and CPU caches invalidated before
> and after reset. The method remains limited to eligible single-function
> devices with both CXL.cache and CXL.mem enabled.
> 
> The reset sequence follows the CXL 4.0 specification [3], including
> CXL.cache disable, optional cache writeback, CXL Reset Memory Clear,
> ResetComplete polling, and ResetError reporting. Sections 9.7.2 and 9.7.3
> define the completion timeout encodings and reset access restrictions.
> 
> The userspace ABI is the existing PCI reset interface:
> 
>     /sys/bus/pci/devices/.../reset_method
>     /sys/bus/pci/devices/.../reset
> 
> Userspace selects "cxl_reset" in reset_method and triggers the reset
> through reset. Following Dan's v6 feedback, this uses the PCI interface
> instead of adding a memdev-specific sysfs ABI.
> 
> For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
> callback when provided and disables PCI I/O, memory decoding, and bus
> mastering. The CXL path reserves affected HDM ranges exclusively and
> blocks IOMMU translations where applicable. It does not offline memory
> or revoke mappings; it relies on CXL.mem users retaining conflicting
> iomem resources while access remains active.
> 
> Changes from v15 [1]:


Srirangan,

I notice you posted this v16 without responding to review feedback on v15.

I've already compared v15 and v16 to see which review comments were addressed.
However, that exercise is no substitute for responding to reviewers and
resolving the discussions they initiate. Rather than me repeating the
outstanding comments from v15, in v16, can you go back and respond to the v15
reviews before we proceed?

Reference is the guidance in Documentation/process/submitting-patches.rst,
under "Respond to review comments". CXL subsystem contributors also often
append the reviewer's name to the end of each changelog item to identify
whose feedback prompted the change.

Thanks,
Alison



> - Split register discovery and cxl_rwsem preparation out of the HDM cache
>   patch. Share decoder register reads, read register pairs low then high,
>   and keep cache access and locking in HDM state helpers.
> - Dropped Dave Jiang's and Li Ming's Reviewed-by tags from the decoder
>   unpacking and cache refresh patches (v15 patches 7 and 8; v16 patches 7
>   and 9) because those changes need another review.
> - Clarify the 16-way decoder interleave limit and incorporate the review
>   comments on decoder helpers and cache refresh.
> - Keep a successfully read HDM snapshot if restoring PCI_COMMAND fails,
>   while reporting the failure.
> - Clarify cache writeback timeout handling and report the effective reset
>   timeout. Keep all-ones config-read checks.
> - Split cache preparation and state restoration into reusable helpers,
>   and simplify range error reporting.
> - Allow the test-only region invalidation bypass for CXL reset.
> - Explain the scope and duration of the global region lock.
> - Reject virtual functions for CXL reset and CXL bus reset.
> - Consolidate decoder commit polling, set Lock On Commit before commit,
>   and report HDM restore failures at the PCI restore path.
> - Move the saved-PCI-state check into the CXL reset preparation helper.
> - Move the standalone HDM decoder checks from cxl_test to KUnit. The test
>   layout follows Alison's proposed CXL KUnit series [4]; if it lands first,
>   these tests can be rebased onto that infrastructure.
> 
> HDM caching now requires CXL.cache, CXL.mem, CXL Reset and Reset Memory
> Clear capabilities. CXL bus reset state restoration uses that cache.
> 
> CXL Reset requires a registered CPU cache clean/invalidate provider
> and matching firmware, such as the separate SMCCC provider series [2].
> Without that provider, cxl_reset can be advertised while execution returns
> -ENOTTY, unless the test-only CXL_REGION_INVALIDATION_TEST bypass is enabled.
> 
> The KUnit suite checks HDM range boundaries, zero-size and uncommitted
> state, lock and target-type decoding, and 12-way interleave. The unit test
> suite passed on an earlier ARM64 test kernel.
> Type 2 device reset cycles are also successful with this. The reset test
> kernel also included the separate CXL bus cache maintenance patch.
> 
> [1] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/
> [2] https://lore.kernel.org/all/20260910082142.1522865-1-smadhavan@nvidia.com/T/
> [3] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
> [4] https://lore.kernel.org/all/cover.1791949910.git.alison.schofield@intel.com/
> 
> Srirangan Madhavan (18):
>   cxl: Clarify decoder interleave limit
>   cxl: Share CXL port upstream PCI device lookup
>   cxl: Move decoder declarations to shared header
>   cxl: Embed decoder configuration in a standalone structure
>   cxl: Introduce endpoint HDM decoder settings
>   cxl: Move HDM decoder helpers to built-in code
>   cxl: Share HDM decoder register unpacking
>   cxl: Move cxl_rwsem into built-in code
>   cxl: Refresh cached PCI HDM decoder settings
>   cxl: Build register block helpers into the kernel
>   PCI/CXL: Cache endpoint HDM state during PCI enumeration
>   PCI/CXL: Add CXL Device Reset sequencing
>   cxl: Validate and synchronize HDM ranges around reset
>   PCI/CXL: Reject reset with unsafe function scope
>   PCI/CXL: Restore CXL state after PCI reset
>   PCI/CXL: Expose CXL Reset as a PCI reset method
>   PCI/CXL: Restore CXL state after CXL bus reset
>   cxl: Add KUnit checks for HDM decoder unpacking
> 
>  MAINTAINERS                          |   1 +
>  drivers/cxl/.kunitconfig             |   4 +
>  drivers/cxl/Kconfig                  |  18 +-
>  drivers/cxl/Makefile                 |   1 +
>  drivers/cxl/acpi.c                   |  26 +-
>  drivers/cxl/core/Makefile            |   2 +-
>  drivers/cxl/core/atl.c               |   4 +-
>  drivers/cxl/core/core.h              |  15 +
>  drivers/cxl/core/hdm.c               | 273 ++++------
>  drivers/cxl/core/hdm_regs.c          | 419 ++++++++++++++
>  drivers/cxl/core/hdm_state.c         | 408 ++++++++++++++
>  drivers/cxl/core/pci.c               |  70 ++-
>  drivers/cxl/core/port.c              |  68 ++-
>  drivers/cxl/core/region.c            | 102 ++--
>  drivers/cxl/core/regs.c              |   9 +
>  drivers/cxl/cxl.h                    |  46 +-
>  drivers/cxl/pci.c                    |   2 +-
>  drivers/cxl/port.c                   |   4 +-
>  drivers/cxl/tests/Makefile           |   5 +
>  drivers/cxl/tests/hdm_unpack_kunit.c |  90 +++
>  drivers/pci/Makefile                 |   1 +
>  drivers/pci/bus.c                    |   1 +
>  drivers/pci/cxl.c                    | 784 +++++++++++++++++++++++++++
>  drivers/pci/pci.c                    |  12 +
>  drivers/pci/pci.h                    |  29 +
>  drivers/pci/probe.c                  |   1 +
>  include/cxl/cxl.h                    |  60 +-
>  include/cxl/hdm.h                    | 109 ++++
>  include/cxl/pci.h                    |  13 +
>  include/linux/pci.h                  |   8 +-
>  include/uapi/linux/pci_regs.h        |  14 +
>  tools/testing/cxl/Kbuild             |   1 -
>  tools/testing/cxl/test/cxl.c         | 158 +++---
>  33 files changed, 2337 insertions(+), 421 deletions(-)
>  create mode 100644 drivers/cxl/.kunitconfig
>  create mode 100644 drivers/cxl/core/hdm_regs.c
>  create mode 100644 drivers/cxl/core/hdm_state.c
>  create mode 100644 drivers/cxl/tests/Makefile
>  create mode 100644 drivers/cxl/tests/hdm_unpack_kunit.c
>  create mode 100644 drivers/pci/cxl.c
>  create mode 100644 include/cxl/hdm.h
> 
> 
> base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
> -- 
> 2.43.0
> 
