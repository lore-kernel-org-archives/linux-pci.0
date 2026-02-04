Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF133985;
	Wed,  4 Feb 2026 04:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770180393; cv=fail; b=n1a2Fm/ljCDbAZcDYvZe/1dn5uyVC44iPVsTMcK5utu42eVaugip7mq/GbshZzRS9APMhmeEIuhRFe0qMu+mOyt8UKS8w/LYfYeSY0HD2z0zNzOtGK2IvZ3v6K6y6nhdGzbBuElF2JXURJW60Sx0f3y57qITQtWvUM87WxNMhPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770180393; c=relaxed/simple;
	bh=wMMJd2Z2BnpTTbj+U8pIfPnoIq8L38O1lrjggeUM3Oc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ZzO6DMce7+iun1xRXXA3cnEe33fShoOFjoGqZkCbcMARHj7PzebnHCosB7nDLLmBlMsFPzlpgAfjqhV+jXN0sdII2yPh3D8TZMMBlWCLwXaKYlmk7szUY9wI/+O6Upfc1HNS8lQtOx/Bm9QhCZUPoHeT1OAKhjVzmM4VtBdUCkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYMKi+cv; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYMKi+cv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770180393; x=1801716393;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=wMMJd2Z2BnpTTbj+U8pIfPnoIq8L38O1lrjggeUM3Oc=;
  b=SYMKi+cv3eu+Xj5c9Cih1fWci5CBg1KtC68J/7VSDaj5WHLS4kPL4yId
   fS/kmMcqmFzJZBS56189Zj5sYerqMxJMItYy7xYPivKahIKTr3mTmUfI5
   2tVK8wdLNtoQuyLNwzp3D1Pm7to/lyRm6kUpjvTmOO6AEkATZkdfkTgMK
   59AyLsc+tf+o3+8yHxXi/linA19xmePUlh14LS26PUiznLwO3FK8svuwY
   BVuLlYbqIlAlhTeGn170MFqllV9LFCKlQqjZIjam7Q0+YGcxKa4h12sOp
   PZUBeEozJ++mg1YIiFJuTvG7GqOvzeJbzkL19SBNlr+Jj5LAHfDK8Ld3b
   A==;
X-CSE-ConnectionGUID: PeGMS/u9SCuLvB+6yVO4DA==
X-CSE-MsgGUID: YWVcGW0QTDGUbpcPGn5nTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96816694"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="96816694"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 20:46:32 -0800
X-CSE-ConnectionGUID: lM12sJRVSY62GK3xtHV8Sw==
X-CSE-MsgGUID: o9xAhdFTSbK2jXc2OJzxwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209348949"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 20:46:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 20:46:31 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 20:46:31 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 20:46:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpL/tlsH86z9MXjMFDMEOViUN+CdtMi2LlRhppSGRvAB58dSDH27GbxFaKh3O+hovJWHQq1on47YqJ6Ydu3xtERUpHBlvdmJgGvo0wIvhRjEj5R6y1ZesGDg0IhR7beTkB83sJN8BaU0wUOE5rogovGM1Ffenz0K+mW1QD5KKJMWxygKoEv/KtYTgZ7f+g1yT95YL8IRapEm+h12ryt917AMHB5jK/CxNaD9QpaOgZCXJsMjVvrVWAnOyPdJocD+uOV+moNYktcVTOZ6exsXqNQzf6vwVprt8osAo0CXFa6wwEqusj30ADEUde76lXRywp+hkbfnwg9qzpr68I2M7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5h2Ww5wsMS2r3+OosbnIZNySaiQBm1CtVy8M73Cgr4=;
 b=T19dqdjs8bR/W+fJOih2GFL9LtiTGjKr1+pymOH9R1apDiH8bRa/HdCbweUzc2sGsYSFvSE4yy4UIjxCysH3QBMBr2ymhItk68eU8PX7RmC6YqtfOvWAmqcXS2Fqx/N+i+FtKrPodeQGaUb2J96SfO2Ps4EVm1tXHPrdAQ34pQ0+cAlmDGGUeS2t7vhsBTP1ytZB4wYtRfJBh6tfvPdizYQPkqDloHdY1LzRueaUYTQxcm1foW+l53Lnf8fORq5x1xyK6ZWorL1Msqk2Si8Ot9il+RoTA30FiFazx9stdTNxlbmUcPMxFsN4dMYzVhE8hiN5oi+ZQIF7NmXsaL+lEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7851.namprd11.prod.outlook.com (2603:10b6:8:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 04:46:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 4 Feb 2026
 04:46:27 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 3 Feb 2026 20:46:26 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <6982cf2221668_55fa100ce@dwillia2-mobl4.notmuch>
In-Reply-To: <20260203025244.3093805-5-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-5-terry.bowman@amd.com>
Subject: Re: [PATCH v15 4/9] PCI/AER: Dequeue forwarded CXL error
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 4949f110-00fd-45ad-1468-08de63a85b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmIvbmlkVDJ4YnBXcFRRQjVOcjF5SE12akQzVHB4d1FNNWtJQnIvTUhxcTRL?=
 =?utf-8?B?Wlc5MUU1WlhRSDF2dEFMeStLZTg1bXA1QWtOdVFldUlyWWtRM2ZDRkRQNGs3?=
 =?utf-8?B?ZTRQaldFMTJQa1VoYlBlNEFiemMxYzRRaVc4ckZJY1dBRlExa05RbDdqcmNL?=
 =?utf-8?B?ek11V3ZiTVpwMXl5SXF4eHJnWFFhTnNCZWxaVm8veEl5czhrV3hRbGRiNi9D?=
 =?utf-8?B?dDVvZEhuOGV0TzZRVUd6Y0JaS0ZsczVjRldMdWxNZXQ0RFdJNlVXWDQxcTBK?=
 =?utf-8?B?aWM3Nk1jZ1luRDdINU5DWUdIeUVNd0NYWkRLeWpZVnd2UEIzOG5WWDJiSzIw?=
 =?utf-8?B?eGVWOWliVWQrdFBHTlIvTEpDZmVwRkZKemt2VTZxazZmb0hINTlWM09hOXdQ?=
 =?utf-8?B?TDRxdWFZT2RZNmd0UXIzVGJwdE52Vm1jTEVNL3JpVE5NMnpUaDdzN2JYS2VJ?=
 =?utf-8?B?WGtSSkpCQUhHUDhPNWF2K2NzK3p2d1dUS2RObnhpSVVWUGhoNlpDU21JQ1pt?=
 =?utf-8?B?ODRxRFRnZGQ0SlAvVTF6czhzM3lYY3pOMzFOcU1CcHhNTWhreUZEUGU2L2xv?=
 =?utf-8?B?ejlhaURRNnRaWjBaT2EyRHVKUStOK09FQUFKbTk2cGx6S2k1YnBHUFl1eC83?=
 =?utf-8?B?cHYzUE5oMEJYMUswYkUreTNqS0NxRDhKSHFDVjVjdldLWXRlNW42TU92VEpl?=
 =?utf-8?B?LzNhZDN2cE55YVEydW9DV0pRSFZ5cHpnbUdKQ2w3b3RWZEJkWi9QaVUyZC82?=
 =?utf-8?B?cjArelBhcFU2ZEduY0JTRitFSHpodEllUE1VVWVKRUdTQ0JQcXgwSFF2U3Ry?=
 =?utf-8?B?WENMQmZqQmVBQVJidWxWckVzL0cxUUhmRllYT3hqNTEyRyt2NWovUURWd0Rw?=
 =?utf-8?B?dlYxN0djSWtFUkJ0N2FYUUNnWEsvSVlxWVNCRzdaZnV4SUc1aTBybyt3bDdQ?=
 =?utf-8?B?K1VkT1FueWdUNDNRRE05Wjgyejl1WU02Vlc4L1dKdDgxcWdod2lWUXE1M29u?=
 =?utf-8?B?WkV0blVMbzV3THRkVTNkOTZPbmpoY2VkYTV5dVlhdCtBVGwvb2N2RFA2UEhG?=
 =?utf-8?B?K01wRG95VUdlSit1WGpLUVBYVVlVZDl6M2FxbXEzaGdqVlNjOXhBY3F1Ykkz?=
 =?utf-8?B?dVE4R3FkOGU0dVE1K3RwRkhodzdoUUpUdVRCa2l6elgvc255Ri9nMXhyZWFi?=
 =?utf-8?B?emxpWHc2NndKTDJNaVVKZmhQbHBOM1YxL2g3VnVEZ1liQy9rSXQzNnVkT3BG?=
 =?utf-8?B?N24ydC9YMS9zN2FOUm02ZkpLODR0c2V2MlV6Zk1wcHMxOXdTS1lla3JoaTVj?=
 =?utf-8?B?UGlYVE51Yi9WUkRya3dVT3A3WHNvRnE0bHNETWw3b3d4NnZWYnN0NnhrQ1ZS?=
 =?utf-8?B?L2p0Y2NISktYZmhIalJiZnA3UU50SVRLT0hFazVhUWo1UmRKY05ZQ0VyQVlC?=
 =?utf-8?B?WHRrSjRGeVhDOU9tM3pOY3lqN016Q1NSZ3RrKzRZTXRnbVFoR3NHWjRGdFho?=
 =?utf-8?B?M1JSdlZQVzhBak11Ym55bjBBV3p3YWo0cy9vNG5NdUgxMmNWM1ErWm1IQW9v?=
 =?utf-8?B?RDFscitKR2U4Q0xKYm9jQ0lyNTFkN3BnUHVGKzlWYUYvNEFUT0RhaUxhZ3V5?=
 =?utf-8?B?dVZJM3U2d2FPWXZaa1BtZGs3K0hiZGpEZFVLL2FnVlhHb0lNZXIrVHNHNlJh?=
 =?utf-8?B?NklJNFBWeU9jZEpCUXdoT0E1NEhsNXZobWJMTm5zL0VlV3picnhsV0pGTW0w?=
 =?utf-8?B?b1RMcndQcTNHZjVsZzc0SVlpK3dCTm1veVJTY1Z6eHA2aXc4Wk5JZ2R0T3oz?=
 =?utf-8?B?emVML1pQcXBFa3NPeEY2K2NiZWowV1dNUWdqK20wOGlXY21rWGhTRGQrTWp0?=
 =?utf-8?B?R1QzMkhXWjZVUk9tbVh0aFZMT3A1SVQwWjY5Z28vR0hNdWltb1RyWTNob1Rq?=
 =?utf-8?B?a0R5VWp0THpzVnBZSi93L1NCek4zMkRVc3A2UThvamkxb3RvNmhxVDZubld5?=
 =?utf-8?B?a24yQm9sbUNpWVB2ZWZrZjFpUTZua2JzK1VBUksrUCtocVBCNFNpb2RlSzN1?=
 =?utf-8?B?Um9vU1M1SXBSaCtjVXV6dEc4WFl2emVzVGZlb2wxVG1BUHpJSGQ4d1lsTnNl?=
 =?utf-8?B?eks5cmtyeFYwcUpOSjVKcEdrWmpuVVFnTitPSWxnZ0x6a2NYZWM3YUgxRVd0?=
 =?utf-8?B?aHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVB6M1dpOW9kOHdlVzgvcE1JUG5yZDBrbGJNNFJCM0w0QVd0QytCVUQ0SDFq?=
 =?utf-8?B?R1RkS2R5ZFJ4VlI4U3dWcG1qWThaSWhhMWlpSUQ0SzVMRVlCbnByamVJN1hh?=
 =?utf-8?B?d25zYjJYV1RmRVZUNWhLSzRUWTBzSmgzRExHd1lGOVZ5TXVrMUhBUlEzVENy?=
 =?utf-8?B?RDRrc01HYVNCMVc5RG8wa2RhUkJBQngvM0k1TkpzUFMxOGpaLzVvK1RBTDdi?=
 =?utf-8?B?ODBGMkcvSDByZ0lpbWVXSElaZGQvTU1nbUZLNXRibkZFYTA4TGN2QWtTaDFD?=
 =?utf-8?B?UzNpb05zTzg0RGh1V3RSMFhmbFZVNjR0a0F4RTRkQmh4RW5oU0wwRlYzRlQz?=
 =?utf-8?B?aU4rNTVlYmpZMFZZUFZCK1lNVnRsK0tLSWhSQUx6ckZ0VUtSYVh2M3lWa1Vp?=
 =?utf-8?B?b2g5ZWxSL2xjLzVjc25aZ3diRTVzM29OQ080QnBMWGdhUURHa0ZvWnRkdEdT?=
 =?utf-8?B?YlMyd3hGd1AvV1dRaHlKYXYvSkR2a25FUytpVWdGbFV6R2d2dHc2TFViU1p4?=
 =?utf-8?B?b1B3RFVRRHF1aVd2NDBxMDU2dEpHUUZ6Rk1sUlVCVEd5SWhqRjN3MXpzZU9I?=
 =?utf-8?B?LzAzTVhIdlpMOEYrNjNya3dNcHpuVGV3VDJQSmZpT2puaDl1ZHpEODcyWFEw?=
 =?utf-8?B?TTlkVzdhMUJVbHJJTW5EYzdmZGcrZnNhb2lvWklta0NycDdpS1QycDJGUm44?=
 =?utf-8?B?dks3d0FQd0FHTS95WkJkMGhuZS9ZczkxRVdSOE9jSHd2NXdHRWdvUm1YYmg3?=
 =?utf-8?B?L2FQVmJtZU1EZWVDMk4zVjNhd2tNbXpnVFVCVmc5bmJiNnIyMXo3ajlrcm9x?=
 =?utf-8?B?bVFYRGt5SDRSazdVU2NZT0V6OEc5azZHcjk1MVVEN3VCNnRtNFgzaGpqcFdm?=
 =?utf-8?B?TC9jZHdhZ0xrcVpHOTh3YnhLV3VyMkZPbElwNm5IdGUwVklFOTd0RzcvS0Fq?=
 =?utf-8?B?SHpHczdaM01JR1ZQVWVXcjQ3VTZHZVdhTnRlVDdDWGlYSTBXNXNzTW00aEY4?=
 =?utf-8?B?Nm0yMmRXbDJIL2pyQ2NaWGQvT2lKVjdma043U0VyeEJUa1R5VVdvdExqZ0dr?=
 =?utf-8?B?cDUxVWx0UlRDTzArMWFrd0pZeEtXa2FhWDAyZnNPT0wwZnhCS2RUd05HMnkr?=
 =?utf-8?B?SHJyQ2dFVnpZNlByL1hIZXk0SG5zN3VucWFzUE5oWFVpSmxUTXZZTzZVckdX?=
 =?utf-8?B?bFBrTlBQMXFzV1pmb0xhSGFVMjJoNGdtTlRpMzJzN0hBVnVlaW05bW9HUTQ0?=
 =?utf-8?B?QjFLaTV4WjhWbXoyK0p2NWpENkJ5a0ROb2FycFlkK3B1VlpTd1o0MHA1RUxJ?=
 =?utf-8?B?VUIrQU10ZDB6Zi93eHBtZWNmQ2xndUwyQlNNM0pzcHJKZTZUaDB0Q3VNaEpD?=
 =?utf-8?B?WUhxeVRGN0hFNzhGSlpOWHBPMU5tZFRxdWZyYlJVdWZZeHlaU1ZyVmlCY1Q5?=
 =?utf-8?B?VmhhbGhremJFK1lYSGF2OTduRHBpb250NGx5ekp6b2pSL0J0Q1VZVWpsNDhX?=
 =?utf-8?B?M0k5aW5vSWxVOFg4ODBwNmtnRG8wQ3J1MFdLdU9yY2xZV3BWaHh0cFlaSjIv?=
 =?utf-8?B?WXp5QVdmaGRWV1FmSDVaNXdUYnM5SE1UdHdSK1lZZ1JPUnNPKy9HQVNYSFh1?=
 =?utf-8?B?Zi9aRFJGOStpbGRhd1RUalVLOW00YlBmTThmT0NnREJnTGcwR05mOW1YRHNm?=
 =?utf-8?B?eC9yR1FZMXFzV0dZd0s2THlrS2dGWEpzangvcFIzcFZIeXlxcDEvSjV4dHZ1?=
 =?utf-8?B?S0xaaGxSUDQzRWE0RzkxZ20yR2V3TlY0MlNmT2J0QkI4UEU0cS8zaTg3SlEv?=
 =?utf-8?B?K3VrTTh5TFk5Ky9jeVBBOHZDb2lRaVFvL2RZTS9ydEdHZGNROUdWV3d0eExu?=
 =?utf-8?B?ajlTbHB0MGNDOVBzMWJreEhDU3BsNHVGYlc5bC9sNGE4SXo0TTZNQTVyUXJr?=
 =?utf-8?B?VFIvZmRWWnQxN1RUQVBwY3JWbXFGbnRMUkdxdkl0aHE4YWRSclg1MktMV3ps?=
 =?utf-8?B?Z2hyTkl1b2NMdEg1dTl5Kzlvb0hlb0x0UitkUDFpOTNDcG9iQTJPbVFyalZx?=
 =?utf-8?B?RG9idkc1cEV0WC96cUdSMkVCWWlTbUtOaXkvQTliL3hrbS9zSHRDVll2bzF6?=
 =?utf-8?B?R0dHcTRDRkhGTkN6VVloQTUxRHVOM1JGUUd5N1A0b3FaRWplR0ZXM3Z2cnNi?=
 =?utf-8?B?VTR2dTN5VEJRS092M0lsVVZhbEtrSTFGQ2k1eXByUjlQMjFWa1hJZm4wd2FX?=
 =?utf-8?B?aTV3S3ZRNmcyV25oSHh5alAybmNoMG5vWFppQnE5czgrRmlZUXFDaFp2eTd6?=
 =?utf-8?B?RW02dGJJTXpXNFVnZUVmcC9MNStNWEVaOTNBbkJmYXVJQ25vM2N4cVdzandD?=
 =?utf-8?Q?2tCcC4xAGBQYhrAg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4949f110-00fd-45ad-1468-08de63a85b9c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:46:27.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bytBxo4ivwcOcd/ytS6q9OF7hEO9Yjjn4E8+ATsEFGbRxRy5b9yhQNce28QntnFOLWJ5hAAaHtiwJiue1Gr+zRt+wHmwEeyP1HiyA3qBqZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7851
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER driver now forwards CXL protocol errors to the CXL driver via a
> kfifo. The CXL driver must consume these work items and initiate protocol
> error handling while ensuring the device's RAS mappings remain valid
> throughout processing.
> 
> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
> AER service driver. Lock the parent CXL Port device to ensure the CXL
> device's RAS registers are accessible during handling. Add pdev reference-put
> to match reference-get in AER driver. This will ensure pdev access after
> kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.
> 
> Update is_cxl_error() to recognize CXL Port devices with errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> 
> Changes in v14->v15:
> - Move pci_dev_get() to first patch (Dave)
> - Move in is_cxl_error() change from later patch (Terry)
> - Use pr_err_ratelimited() with PCI device name (Terry)
> 
> Changes in v13->v14:
> - Update commit title's prefix (Bjorn)
> - Add pdev ref get in AER driver before enqueue and add pdev ref put in
>   CXL driver after dequeue and handling (Dan)
> - Removed handling to simplify patch context (Terry)
> 
> Changes in v12->v13:
> - Add cxlmd lock using guard() (Terry)
> - Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
> - Change pr_err() calls to ratelimited. (Terry)
> - Update commit message. (Terry)
> - Remove namespace qualifier from pcie_clear_device_status()
>   export (Dave Jiang)
> - Move locks into cxl_proto_err_work_fn() (Dave)
> - Update log messages in cxl_forward_error() (Ben)
> 
> Changes in v11->v12:
> - Add guard for CE case in cxl_handle_proto_error() (Dave)
> 
> Changes in v10->v11:
> - Reword patch commit message to remove RCiEP details (Jonathan)
> - Add #include <linux/bitfield.h> (Terry)
> - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
> - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
> - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
> - Use FIELD_GET() in discovering class code (Jonathan)
> - Remove BDF from cxl_proto_err_work_data. Use 'struct
> pci_dev *' (Dan)
> ---
>  drivers/cxl/core/core.h       |   3 +
>  drivers/cxl/core/port.c       |   6 +-
>  drivers/cxl/core/ras.c        | 106 ++++++++++++++++++++++++++++++----
>  drivers/pci/pcie/aer_cxl_vh.c |   5 +-
>  4 files changed, 105 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index c6cfaf2720e1..92aea110817d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -182,6 +182,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  #endif /* CONFIG_CXL_RAS */
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>  
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index ee7d14528867..8e30a3e7f610 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1402,8 +1402,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> @@ -1607,7 +1607,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>   * Function takes a device reference on the port device. Caller should do a
>   * put_device() when done.
>   */
> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>  {
>  	struct device *dev;
>  
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 74df561ed32e..a6c0bc6d7203 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -118,17 +118,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> -int cxl_ras_init(void)
> -{
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> -}
> -
> -void cxl_ras_exit(void)
> -{
> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);
> -}
> -
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map = &dport->reg_map;
> @@ -185,6 +174,50 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> +/*
> + * get_cxl_port - Return the parent CXL Port of a PCI device
> + * @pdev: PCI device whose parent CXL Port is being queried
> + *
> + * Looks up and returns the parent CXL Port associated with @pdev. On
> + * success, the returned port has its reference count incremented and must
> + * be released by the caller. Returns NULL if no associated CXL port is
> + * found.
> + *
> + * Return: Pointer to the parent &struct cxl_port or NULL on failure
> + */
> +static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
> +{
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	}
> +
> +	pr_err_ratelimited("%s: Error - Unsupported device type (%#x)",
> +			   pci_name(pdev), pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -327,3 +360,54 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +
> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
> +{
> +}
> +
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	while (cxl_proto_err_kfifo_get(&wd)) {
> +		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;

This is a bit clever, might want a comment that it pairs with the
pci_dev_get() in cxl_forward_error().

> +
> +		if (!pdev) {

There is no way for pdev to be NULL in this path.
cxl_cper_handle_prot_err() is different because the CPER record is not
100% reliable and pci_get_domain_bus_and_slot() can fail. No worries
about that here.

> +			pr_err_ratelimited("%s: NULL PCI device passed in AER-CXL KFifo\n",
> +					   pci_name(pdev));
> +			continue;
> +		}
> +
> +		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +		if (!port) {
> +			pr_err_ratelimited("%s: Failed to find parent port device in CXL topology\n",
> +					   pci_name(pdev));
> +			continue;
> +		}
> +		guard(device)(&port->dev);

I expect this also wants to check port->dev.driver?

> +		cxl_handle_proto_error(&wd);

It feels odd to keep passing @wd when the pdev and port have already been
extracted. ...but that is minor.

> +	}
> +}
> +
> +static struct work_struct cxl_proto_err_work;
> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
> +
> +int cxl_ras_init(void)
> +{
> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
> +		pr_err("Failed to initialize CXL RAS CPER\n");

cxl_cper_register_prot_err_work() should return void like
cxl_register_proto_err_work(). If someone registers a NULL work that is
the same as not registering anything, caller gets to keep the pieces.

No real bugs that need addressing, so:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
