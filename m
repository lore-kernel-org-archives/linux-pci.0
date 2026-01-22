Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565136923E;
	Thu, 22 Jan 2026 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769060687; cv=fail; b=Sq16+LLcdC9oj3xZm511USxwkg+o40Q7Mvf0pOXQE7DA6vWKIHXybdUGlCvuXE9r9MwBeIfNRd7JZIz589g2fZyQ10F+AGoEMgyZTHycLEXRJmqf5Piyj0eikV/vsjGKaFE7bl8Cag9HF0YHiRRq2Ca4iBH2/mGn+WsYH6zEw2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769060687; c=relaxed/simple;
	bh=catkDyq1P+7h6Z639gAHWbspz8yD2jQXcmD0sqCRcnA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fP9KD0Jbq3uxjQXEvpV/t8LKoOIp5o9Uq/lHwCV40k5AA79Bvy54cQ7rAyDSH1OX0bw1SxF6JZmtGaEL8veOxUXb/O0yyoJP9pg2eq9Yw2YdST/021rNNoRkyLB7DiuKj0Ef91V2ABquNEdSxCH/j0/mJLV4J+XpVIxsY39woYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaLrPkWt; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaLrPkWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769060687; x=1800596687;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=catkDyq1P+7h6Z639gAHWbspz8yD2jQXcmD0sqCRcnA=;
  b=YaLrPkWtis5Z4O/zlzwrhAauuXAPMncY6nlt/4PJrYThiY34tGg/TZ7p
   epyBobA+wqcny8Zt0wRM3Ys0QLSwKnEjBOPGcdA9N+vBuoddkSmAL9Aua
   lFpYF1JdhNY6mp0nPPgxeeVrltNJ4S46gKKrRUw0FN3n1GCny7noSv+j4
   JIkY1zFjEsYEl1NPo2R0b52jA524QKcUBc+dTxfn6mM32Ei/9/nyuZZRK
   GahpKuVtF0xo9dmnaAqPEfsy72TDmARUbCgrmmhbbD8HCVNP6SGZwkPza
   ZW4TY7rSH6SlLbIbDVfjkVns4jdfq63OWvZtg4S1I0lUzTFLRwc5pv+cO
   A==;
X-CSE-ConnectionGUID: yynSV0OGRCirfyG83I0BpA==
X-CSE-MsgGUID: i71CocKhSfygX/f/VTUrOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70463154"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="70463154"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 21:44:46 -0800
X-CSE-ConnectionGUID: IEF37eFvSHqo0ZbIHY03UA==
X-CSE-MsgGUID: 3kLj/xmuSXGIASscWLqmjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="205892487"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 21:44:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 21:44:44 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 21:44:44 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 21:44:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsffV9XahTL6HgJlQYQbZuaogO5MIvYDlLcsbnjTBF9YOd6M3AajnPbiwx1oMTdlCk2EVnXnnf6IhuyUNET0VBeO++iqYDLIX90EetaLNzlaqAv+fA5EH9iqwDQoZF3FPepyemeYRO9aQwRiihi9CNVUFDJRZfqAiDc3dDfFEDaLvHxfQl58d6ZoUGGiVVidLmwsF4Wbh4E5AbxcWWQRrd6/gqVVThPGrq4IbcJ6dNkbc5jHZr8ofNhg5jp8jyiDPiCwJ1HpOCTBD11+2X6oMhmY0gOGPBEx+7fqwfForXh1B08DfA+VqAH9H1qR7WE6Pj/nN/9QxoDMq17K033Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuSOpoMAkU9mC5oipfdG69OLcJIA2THsljN6gfWq4To=;
 b=if8zitF3C1DMfm6/7iXZlaNKvHG1xzWBJ6BlCbJQCvmc8i68QS3XNKhEsB0RuoGSHxgF6dAMKDrMkIVyO5BpN1V11hM5RT5Stwan4Utxtz0OTU45wJepVFvaSWoXaaJRoqeVBd5lCt9+vUaLvqKUzuSZEhe9dDFimPIG87pgxXeYJUsVfVWj2wQPgbhv4PGNjUorvPK3RAzBNKRgKyP6i6c5hNZIBsE7yEvxMgrPUrFBQTkdoIT8k9vE7vI1LgVWuG9bw0qnmffiUffJHUyhcxXZRiZ6ETn5XgMl2XnH8CHw9JcLC7qWvDEqps/xaggbcFVX1wkXiP98WfmBfivSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF801A91A7D.namprd11.prod.outlook.com (2603:10b6:518:1::d34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 22 Jan
 2026 05:44:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 05:44:34 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 21 Jan 2026 21:44:32 -0800
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Message-ID: <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
In-Reply-To: <20260121130315.GE1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF801A91A7D:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ae99d7-a475-4e36-7bcd-08de59795243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWNvQnUvOGVOVmpuZGxNd3hCR21BYjdOWDdEVE5icHhuY3NjTkIvbnpMRHNZ?=
 =?utf-8?B?NDdwR21pVXZCeDAyQURYWHVYR0lTbXM3SG5Yd0pteGI4K3E1bk5iUFFRV0F1?=
 =?utf-8?B?aFJ6RlJxM2QycFhUZ0VjblB2T2c1ZWUzUHRLV1k4cFRFcHlEbDZvS1ZQc0xp?=
 =?utf-8?B?VDdLUkk3Lzc1RE1pbFVUcHNFbHVvSGpnSjhCNld2Z2VIZXRQeTVPVDlkdGt0?=
 =?utf-8?B?eHVvQ3Vnc1QrV3U5K0VYbk9vMkhFdzJHbWh4bUJBVFhrY0ttVUhlV3dmVklB?=
 =?utf-8?B?MGtoYXE4Nm1vUzVtWXJwTXJpdU1HY0pKcThGVGNTWnJxMUsxMTB4UEgxRVdn?=
 =?utf-8?B?RHpTdkN0OHRwWjlreThIYlRpV3pxUlFZUG1KY1VuYkNWaHpybktIcmhWbnJ0?=
 =?utf-8?B?SS9RTEh4SGdmNm5MRjZxT2hTT2ZrMkFLL0JJSXplWUNua1lWL21iRjdxU1hQ?=
 =?utf-8?B?WmJ3RmZESnQxOTk3ZW1hQnl2SU91ZGIyN3ZHYlRyRHBWQVNrenNVMXBCYlZV?=
 =?utf-8?B?QmZncVh0anl3Nm9lN1JKc29mOG1acXlpUE9wdjN0b1BDMmVadkRzMi95QzFn?=
 =?utf-8?B?SWRDMVB4QmtlY3dCU1FNNitoN05vZFhydmpWRkc0bVJPMCtDU3BzaHpUZVlX?=
 =?utf-8?B?QTJ4aW9ERmU4RmVGRXJpN1hpcTd0Z3c5dEhQdUNrdCs3WkZwZU9tRytpNEE3?=
 =?utf-8?B?ajVnbnNYK1g1SzZ0NURRYmsrRjB2ZGVnaS9wWnR3YUZuc3VnZTJMT0ZjQi9S?=
 =?utf-8?B?NHN1QXhVSEZhTEFlOHhMc0c5OUlPWUtUWnZtZjBST01kTGNFOVZtUUZTbFJL?=
 =?utf-8?B?OG5odU00T0gwVG5YRklrci8vZ1I1L1pQblFJbzFoR0R2RGE2TXljTk9HaWpl?=
 =?utf-8?B?Z08yRGlMNk8ySW53VHpMYkwwRTd1K3dsL0o4NlF5YTMrNnNBL0dEcE9IMndD?=
 =?utf-8?B?Qjd6dVNQMko5N0FISDd3MmprWjRSK0M4Tkg4M1NoTzNpUjZyZnZJR3gwcFpJ?=
 =?utf-8?B?cXMxVzl4QzVJRUpWdWFkSCtmSW0xL3owUE1kODBKYTFMcTF4cHpqeGxKcCt3?=
 =?utf-8?B?NlhuZS9FbWt2dWZQRjlKWXY1OUx3eWJyNWduNkJGOERGVGhBYUZvM0lPS1pG?=
 =?utf-8?B?OW14M0Fzd1hOcnd6aTAvY1pXeXVCMjZSUHp1bHhUSDlzTjlYRHVTd2tWUk5V?=
 =?utf-8?B?L29aUVNaWkJrR1ZPb3JRVmJ5OEdLcVJwWUphdG1mUFZ1MENxQkg0OUtYeWhW?=
 =?utf-8?B?V3ZIVUk1NU5KTXIzaXZVOEg0TE1FeittZVB2bU1sUDJ6YXYrWktPdllGSU5w?=
 =?utf-8?B?MkdQL1l0V1FFL2tXQ1VpdXNwNE8vbFpVWXBmUW5JU0tpdDBZYmlQZ3FiUXJx?=
 =?utf-8?B?Q3dic0lnWnZ1SmEwbEJPNTI2Mjg1RVhUY2p6eVhNZHZGNUdOU1VFTE5HaEh4?=
 =?utf-8?B?alFLTzU2Q1FVeEhDNDZxZi9tMEVySVB5NDRkZjlPM0NlY2F1cTVyUWlIQ1hD?=
 =?utf-8?B?RFdsZk9vd0k0Sk9NaENlSWJoTG9nN3NITzY0Rm9MdDRhY1RtVG0rOTNwOW1Z?=
 =?utf-8?B?Yk8wTm5JQ2RldHp2a0x0RFl1WXNXdFI3SHp0eUVoei9GSFRMYkhsVWlTVHph?=
 =?utf-8?B?bTl6UUVDUENCOGs3MzNEWE9iVGVVM0ZJN1VhVmRHbXBPMVA2OXd0YXJiRVBK?=
 =?utf-8?B?RStmaFZhNWo3VlQyUkhrbkU0d2x6cVlVRzlmeXlFdTVQRzI2KzN5ZElldk1Z?=
 =?utf-8?B?SDJ0VnVpUHFxdGViV1ppNHpBT2pVaFdxa3RodEhVSTVPSyt6V09VWVVteGtN?=
 =?utf-8?B?M3N4LzJXckRoRG9jTXc2a3BWUmwvem4xdFdDemUvUEl3S1FqTzdrVTRVOXli?=
 =?utf-8?B?aXVRWThObEN2Z0JibGd5TXUzTkpGaHdhL29YOWdlckNkTDloS1gzY2V2SW1o?=
 =?utf-8?B?VFJvdGh4ZTcxc2l6dTUrbERvdWVDejNVYlpXQXVxU1M2czZnTm5YRTRuWWJy?=
 =?utf-8?B?UGxVcUFPaXhPYWljbUxubzdZeVNkckRCNEpybkpZSVRIY2xpMU5vS2dEZXpF?=
 =?utf-8?B?bFJlUmJxWDdDaGkrdDlSazhZM0YrS2N0V3JIVHQrVFRTdVc2ekFTZ242Tng0?=
 =?utf-8?Q?o0Mw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDltbW5rQ3lCUWNOZGNiVC96TUdQM0lUdXQ3Q2c4VS82ZW4zckVnUXNIdVlF?=
 =?utf-8?B?V0pzdTRXWVFRTUlpRHlpVERBeFFsV0FVczhyWHh2alg4ZDNodzVkUThEUjhK?=
 =?utf-8?B?T0ZMUlR4RWE3OXdoL3V5ejN4VFBaL3NHcFlpTE90RGdtRzloTGw5KzRLajJI?=
 =?utf-8?B?Nk94bWlHRDlCdFYrRmtyeHVrOGQrSm9oU3d2VGRqemhuQVh6OWhzTUZjOWFx?=
 =?utf-8?B?RUdJdnRvclpjcU9Hd29PVEcxcXZ6NUlieHZCL2tiOGdoakR5QU1GVW94dFZM?=
 =?utf-8?B?UURxV2JHekNiNzd6REQ0dUxvR1NvelBKREMvVndmWEduajBxY25RY2dENHBK?=
 =?utf-8?B?RDc1dlZxWXlKUk9yaEx0amhoazVsVTV0WjZ6dTkwMzFUM3h6eFNvbmVyWEZv?=
 =?utf-8?B?Vk52NnB6b3ZReUErZkN0V0ZZYXVlUW4zVEUvTUloTGhSVTBkekJHNDViM0pS?=
 =?utf-8?B?bllVU3g2dmdFN0lhUVB6QTRURjZpaDFZMUVyS3d5OFZ3QWZQUUVzQk12bXlR?=
 =?utf-8?B?RlQ4Wm1qSUlreGVCTHo2Q0hoU212UzVFWkVFbWN3NU4yR2NoZzhsNW5PYzJw?=
 =?utf-8?B?V29XZE5Nb0Q1S1JCeWdaNUtGSzNNWlFpZWEremxnSTVBSHJvTUxCa2ZhcEt6?=
 =?utf-8?B?NGxvRi9DUzVYa2VjOWFLQS9sT0NWajBobXU0QXA4eHJrKzc1Rm1ZWHVIK05L?=
 =?utf-8?B?bFRTOERaYUFHeTNoYzBCL1VHcHo0TnUzdHRXbElnTWhGTmJMTklBa1huVllu?=
 =?utf-8?B?Q09Ec1NWK3hqOCtTSmRkOHU1YmtTMUNuT1FvNHhWL2w5NktXMnFSNWQ1dEls?=
 =?utf-8?B?VEhHNFZDUWpOa000NGw5MnVKVDB1WVpJTVh6U3pHRUJyM2U1VkZ0MXAxUFFj?=
 =?utf-8?B?VWFTVmFVWUVZL0wvcTByekdrZlZsU0VEZUJra0NQaS9VcGhTWGpodVZub1pa?=
 =?utf-8?B?SWxnSGFyWFpONGwzdEUvM1FEUUFQSFJLSk43YUhZbHo1bk9QTE92VkF6YVZp?=
 =?utf-8?B?dnBSeHlsV0FyZklVZmRyalh1a3l0N0tPejlHa21laVYzUm4zMm9CazcxeUVo?=
 =?utf-8?B?UlFEMW9RMllBMzB6UjRoNGZ5REp2a3pGZk1aTVdQUTFiakFNb003MzJIV3I5?=
 =?utf-8?B?d3cxN0pHaGV6Y2MwUFZacHVwampzWFlVWjVGR1lVVTllTFNvczJleXpaUERI?=
 =?utf-8?B?cDAwSDQvVHc1MnZHUVRkOHZzcFhtdjlVZDdheFhBNnppS2pIOUt2WlUyZEpF?=
 =?utf-8?B?TUszb0trRUhYZnY4aUxicWZTSjdBTE9qTHpjWWhwY2FPbzRJRkNkVTRyb2pC?=
 =?utf-8?B?VlNSRmJWK1NUWXFFZ2V2V013WUhFNm9QbkhNM2EyL2c1TFRIS1FvRjN1VXR6?=
 =?utf-8?B?OU1HcUdTT1lzTU1XMzBvOXQwVU9IYmFPTnpnZlZmenBtb3QrWmQ5MmpVN1Ax?=
 =?utf-8?B?L0FjTmxoOExUdEEzeU1wbWlUZDNpNFl4ektubWVWTm1ldWxJRTRHd2N4L0FC?=
 =?utf-8?B?dzh5dFNrNVBLYkNyYWFMUFRQZ2RIZVorb29RRGJuNy9wMURkQlNHVVNmNzd5?=
 =?utf-8?B?cEw3S09SazNET01mdFdsSktQWmRYNW90YnowbytxSmRCNmpuQWgybFgxdWtQ?=
 =?utf-8?B?K1JuN2dpRFU0QmFhV0cyMVc1NWRQeFl5a2ZIcURUbzU2aG1INzdobUxEN1NT?=
 =?utf-8?B?OERDMkNBMDBpc0g5bk11R2lweFo5eUhkSEcwbXFrV3RUQ013THNkM3VXTFpY?=
 =?utf-8?B?bjdHR2RXMDhldUhxZVJUdkl5QzJtYnVPdEFXZWNaUnZnT0NIWWtJNGpuZFpq?=
 =?utf-8?B?TkNqajg3OFM3Ni9EM2VsZVo5Q2VTdFBIYjFhU0h0M2wwcmhEWEYyYklJckZY?=
 =?utf-8?B?NHM1TVN1M3JKUG1SQXd0RkkrcWlyMWJlTTZQSDZSSU9KbllUbmE3NUVsY2FJ?=
 =?utf-8?B?QjA3RkdJb2pRV2RmdlRFT0VUVDVVS1VER0FqR0xCSnRHTHZKSnhqY2IrTWR4?=
 =?utf-8?B?YU5ueEIydWE1VVBZYTNtdWlFekthVmp6R1pTMDZPWmVjTmJuVnk4dUpkTHFy?=
 =?utf-8?B?ZmVreVlJL04vUWJNaHdwcFJjOTFjUjBBV1BJcVR1YlhTaXdnSGpiOWg4UW85?=
 =?utf-8?B?bGFaNkY2blphSlhlUUpZYXBRQ1cvK0poT3pxSUNBNnQzdGkyaE9uZDdSeUxY?=
 =?utf-8?B?UEJacmJ3ajU5REdXUEpzbEt4cHFEUjFQTUpuL1hUa1NneVBiSnp4bXNGbkNZ?=
 =?utf-8?B?bnd3blM3blkxN1EvU0VlM29rV2hFNXVoZkVvaC9ta2pEeFI3NjlnREdwVC9L?=
 =?utf-8?B?bWs4V1NTMU5SMnB5bkRaM05QUW9qU1pPSjcwM1lpeTNiZUNDdHBzY2ZQS0Rt?=
 =?utf-8?Q?hTanyVFDfWAZwakI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ae99d7-a475-4e36-7bcd-08de59795243
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 05:44:34.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwDzULuFnN1Enm9l5iANmuulD6zbvJolTxu3pF/8A50i+uWQpngPhhQgwGZ5wxcDkrSymj+ZF0QH4Q8X6sdY2P+CbFV7L5od7lfCU/Lslis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF801A91A7D
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 10:03:07AM +0000, Jonathan Cameron wrote:
> > On Wed, 21 Jan 2026 08:01:36 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > 
> > > +Dan. I recalled an offline discussion in which he raised concern on
> > > having the kernel blindly enable ATS for cxl.cache device instead of
> > > creating a knob for admin to configure from userspace (in case
> > > security is viewed more important than functionality, upon allowing
> > > DMA to read data out of CPU caches)...
> > > 
> > 
> > +CC Linux-cxl
> 
> A cxl.cache device supporting ATS will automatically enable ATS today
> if the kernel option to enable translation is set.
> 
> Even if the device is marked untrusted by the PCI layer (eg an
> external port).
> 
> Yes this is effectively a security issue, but it is not really a CXL
> specific problem.

My contention is that it is a worse or at least different problem in the
CXL case because now you have a new toolkit in an attack that wants to
exfiltrate data from CPU caches.

> We might perfer to not enable ATS for untrusted devices and then fail to
> load drivers for "ats always on" cases.

The current PCI untrusted flag is not fit for purpose in this new age of
PCI device authentication and CXL.cache capable devices.

> Or maybe we can enable one of the ATS security features someday,
> though I wonder if those work for CXL..

It should work, but before that I do not see the justification to say
effectively:

"We have a less than perfect legacy way (PCI untrusted flag) to nod at
 ATS security problems. Let us ignore even that for a new class of
 devices that advertise they can trigger all the old security problems
 plus new ones."

I do not immediately see what is wrong with requiring userspace policy
opt-in. That naturally gets replaced by installing the device's
certificate (for native PCI CMA), authenticating the device with the
TSM (for PCI IDE), or obviated by secure-ATS if that arrives.
