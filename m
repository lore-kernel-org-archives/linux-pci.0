Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AF30567F;
	Thu, 21 May 2026 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348227; cv=fail; b=aN657hPlFnSh6qvMtsSmzoOjnRi0rl+G/vRMJEI9nUWbZdYwEL1ohhdcsrVLEj0cHoiepPjuHP0OFi/BN0EzXLOytxLtr+/unZmkj6BMgpURIuUrlwJyWOhpERvPdv+eai4ATEMziBeE/kKk4wWmSUD7wUiXmuBEtXp8ODRGRe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348227; c=relaxed/simple;
	bh=NVyRYEobDtUgm/Z1PwnNbPvphc+seNV236DT96lCMqc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTfZ8vqr4VQekLHt6hj+yBLp5lQiAw8hFILZSMbOHl+FgKv2qU7iIH/zryMC/tmQ+yLwa4Bswad/F/d0n07zagVT3KDSc1vkgo/fBcEX1Q4853MNkV/rWLc5PBSLmn7ibz92vUkSsN10Fq8RP3d35dA4r1YCtVlLROwoPSiKwTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ga3o0r6C; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ga3o0r6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779348225; x=1810884225;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NVyRYEobDtUgm/Z1PwnNbPvphc+seNV236DT96lCMqc=;
  b=Ga3o0r6CJu9meQRE2gI2yZr+IqZ7ml7vSQ3+GFUVecLd2Wi5ORAbnOYG
   0BBba0oJg3m2tlRdQAxXTCwMfdHGu8+GnW7oJP6yWXvUemtHSEaWW5pZ/
   n1cuSIbT9WRLKMH7l1xXTIxej+bAJ4VjvcuyaT7QBmNF9xffB4NhxpmAr
   7CvuCgSzl97mdW5e/F+/i44N+8evWCxJpgV0Kr2d+DCwqdFinamj8n4Qr
   Irnvj7pPzG4M5gDHOipkuwVHVQbi5nwwNJEZZolkM1eTiXGcO0KHWyWZM
   0yU0AV87xs3d9rwR5DLI1/0SXsGXH9NaB8I8nc3UBFi5YQnBQc3J8T+Qx
   A==;
X-CSE-ConnectionGUID: N7jt78nPQR2O7T56l172hg==
X-CSE-MsgGUID: TGXuOzKSRwu5f5x5+BinzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80293924"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="80293924"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:23:43 -0700
X-CSE-ConnectionGUID: TERjVk1HQcO783AUYAYT4g==
X-CSE-MsgGUID: dh/An7CbT9utY3sjnFT1OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="245442607"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:23:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 00:23:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 00:23:42 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 00:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9Qe7r+tmljWbVDzJqzm0XqVKk3ZWbSyW5Q4EjNvRqu5+haEYsrVVpc9be+oGi7WyAiMvj5VSX0At+WvcFUv/o+CtRTKLBaKFuS7E+r6Y4pcBcQAG0GHMEyiprgfCkCI6NyB4CutJC6Cp8YPLFuIrpQoEFrLQo2Mt2SK54oA8rr+eEF3+qlDA/0SH0WzzYE3Ze0+5KFCRVsZZFSDLl89OlpbY2HiGrdiR3dKENBfhavvoUC8pZUPBZWl3+VBa89+KYJJgnKO5JCegicXd6MCiJ2LBTVr2/ysDvwGRRRUZRW3HtHuG4qR+hl3wf5Q0n5zbJI+TG7pgnybCg2G+nAvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvucpeuTgVoUbejuaut9Bag5MJvavuhhmQB8e4XOw+c=;
 b=JVYh0X/gAy6D5/AbYrbmv6DkytM+Z8IkW/wdr96yo4fGf1LGYdoDkf43TJKe8z9QU+u07YnIwIQGKA2ctsQXvN3j2spA+sVsMFH/DzAeaPXyH8F6OcVx21y3aL7DssvYceSeSB1J9g7EHD1TH5YUFOM/iaI5PxLV5KhmikpH3Nix5OEF8P8yhk00LuUrCIc8aMpkxjzZpdSWAX4AfnnUGfonxOILfvIGL96r301rptJwx+lUNW1Hlg85NmGFJbhmv0+9HY9lnHr40KgW93XwnnDEc3LcUNy5hrzvpgMDbpKTh0bq69AeW8uKgZr90R61QbEHQp9LEQ6rAgl+tkDWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.16; Thu, 21 May 2026 07:23:38 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 07:23:38 +0000
Message-ID: <80e7e1be-c384-470f-9949-8c0dbad165ac@intel.com>
Date: Thu, 21 May 2026 15:31:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>, <joro@8bytes.org>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
 <e8337102-aecd-48e8-9a2d-10f41ed43c5b@intel.com>
 <20260520143410.GV3602937@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260520143410.GV3602937@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::11) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM4PR11MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: a4874eab-c0d4-450a-6761-08deb709e054
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|42112799006|56012099003|11063799006|22082099003|18002099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: isM0PPpw413bim2Jv34QWCGalLatIKK1xH14nFULqORP6ixa+HatNQeHPVSDP6nOmOCXRj/usnzKkg8k/CTDgQRdoL3TO4xFcmpHQEqQ27C9z6tKd5Hx1tSv2Z9ddruc6K2Slds350AC9vQbNehvraigZ0NGXdH+C5gHXk2V38ek3n2ak21CrzSkDRxzgO7a1uc+uaG/C6rGNxLs4Zn/NYzBxQiKzUEDOG/tkR17DCCBNYpc3fs6MS8CocKQCTf2ieqZEmoPjYuZ+uHMXyGBnDhowokHpTjx6bTCjLCXw8+nbJyN+VXUxRWPpQxdH9F0Sy+1TwAP22tmcFQvZKfP87gH+WVyNuaFNFeW7nypPZgfDmkHXzj+DYR+QW/0BijNZcE1B2cpy4LHEwFXUF4whuzjoVdDhSscpu/81/+gRjP1GlHcAApLZJkLdGuA4SQLLaEt01ABr560uYIYocJDGzUK4sXs2gsm6n4lXun2xyG3gVR9EoanG8tjUiAgeMfKStXvEac0Kn4kfhyF8Nr40Kugt0D8hfv7LwTbosVc+hN7+1cnXxNJGn+BdQkobE6sVTc5jNqInG8k4UfaoG8qfO2NkVBuCZjkPcIY69xtkDpDzGrwHouW51j2u3jYqmfj3WbysWmjFNcoWUZ8pBiOoDyr9i5WyV3zQS+XxTjJ2kDnVR2DvvA4Fzzp/Dt/ooIe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8492.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(42112799006)(56012099003)(11063799006)(22082099003)(18002099003)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXNieTdDRElicEtLWGNLaGxNbTIxbWpMQ2VuaGtBRGsxeDNHTkprT2ZLNWRr?=
 =?utf-8?B?QVo4MWd1RCszZHk5SWVrUzhrY2kvMDdTSEplbE9EVjhEbGhWbVkzdi9YZjJF?=
 =?utf-8?B?UHRuYVBIQjIzU00yZ1NHdktTUm1TQXhZaXVQUXkvMnYwZHNVMWNPWitpakNW?=
 =?utf-8?B?akgydnJJVWVEekFIc3doZlJXaVRMWW9DQjR5SUFjaEdYN2M0d3RJaVZOTzk5?=
 =?utf-8?B?d24xaDR1aUFxYmNPeTlGMUFyOVVFNUZ3YzVnSjdsMFlhSVRKaWljeWoxbHli?=
 =?utf-8?B?NDNINWs4aHBXOWJ6Mlp3L0hlUGVuRFdnZ09MSVVnNlJVbk5leVNaZXZkRUJw?=
 =?utf-8?B?dHRjZEdJTFltbkJHVGhqWEN4TkVPdkZCKzA4U1lTWUp2TFdzeE5BcXR0Uk1v?=
 =?utf-8?B?OUFjOXlwZUNLT25XSk5NUkNZOHY2VXRzV04xekh0VmhQd2dwVWV1b2NoUm9B?=
 =?utf-8?B?VUNnM09zOFU4WXl0YllFV0F6NUY1c3l3L2QxMituSnA5b0s1ZC9ZWFE5RWJC?=
 =?utf-8?B?S0U4Y2FFcnNGUjRmZDR1elNUQUh0aTZyZlhhY0RoRDRWY3Y3YjFET2lLRlox?=
 =?utf-8?B?ZjlWY1R2bFJJYUFkU0txK1h5T0JMOUZkV2FGTGdZajdHT2dvQnpwZjlzV091?=
 =?utf-8?B?Nmp2Q1ZJQTdVTUhQVWFzTlZKOVgrNENNazVPL1RwcWJvS1ZaWEdtMEtBQ0pn?=
 =?utf-8?B?S256YlZrUm8yVXlFRzVCSEtJS2hIRGhUSzRJY25MRTJBUW45a3poM0NHL2RB?=
 =?utf-8?B?MDJFR3hHd2M3VjZBRkV1c3VzemdaQTZ1QmVIZURpWi9Kb3Ryc0tRYVI2cUQw?=
 =?utf-8?B?RWVDZ2JxZEsybUFWSjZMT1FlV1NIempSN1hYblY4aEhTekFURW9QN29JN0o4?=
 =?utf-8?B?MlMyR21ZTDZxSW9rRU9LMjRURkJjK25xRTNwNXdlcjNXYzUzS21vNHgrRm9W?=
 =?utf-8?B?dEsxam1BT3huREJ3eEVHWG9SYktRSDFvYmMwMkorNkdhSWtqMFNSVTRBaWN0?=
 =?utf-8?B?Q1pvbGhFMWpLaGkwVzV5Y2o4dXJFOFZ1VDdYRjlJSFcvVmVHanRlMittRGxj?=
 =?utf-8?B?NDkxQlBLSlMrS3RJNitFRGpWcTRraTh2VTlYL2dWZlMxUDlBUXhxQTRxWHcy?=
 =?utf-8?B?VlNLMy9OZUZITldWbDhyMnJiS3NLZ1pUYTd6OXc1Z0Y0RXVUd2xjNVRtb1VH?=
 =?utf-8?B?cGdCZDNZb2x2OTYwL0lNMUpWTkh1MGhlay95RFBNSUYza21tR2Ntd2s2UWxD?=
 =?utf-8?B?em5CVUIrTkV5Ky9MQUFUNTZKa0lNeGxZckw0a0ZDc3ZiVG9uajUzcWVWV0ll?=
 =?utf-8?B?OUh5V3pSVVhLaVpMeVNrZ0xOUVluZ0JKUEhkc2pKZktYc3FORTZkSVJxRHAw?=
 =?utf-8?B?dHcrTVZacHBXMk9HMjFFTkNrbjA5NHFFOFQvNjFpNklnanVUVnU3R3BJNnZi?=
 =?utf-8?B?Yk41bk1UWEFkU3g5UzV1Y2NiM1JUaHQ4L211VXVtOTlzSTh0YnZDOE9jZy82?=
 =?utf-8?B?eGU2TXp5TjVEWUtsVnFKRmRPcmJScFJlN2JKVkF3SDN6RnRML1Q0RStmVEdw?=
 =?utf-8?B?N3hlUFQ2MTB6TjdXQWxncGVrajVLWWdBZERoZEZHTFQzZUgvT2xKUTlEZElM?=
 =?utf-8?B?TWNCOWUvSVYwc09pRGpWZFJaZkF1eGJHeGRyMGgySGFrMDlyNUdJWE4xRTZV?=
 =?utf-8?B?TXNGc0NFeVpDcXZaNVJJbHZUQjVjcUFHV2RWNHpuUUNkSWkxbmRWV1VlaGxL?=
 =?utf-8?B?bW9hd3FTenI1RGxoaUxmY0NqOWY5aCsyY0g0amdzMk4zcUZnWXcyeXNmVnZz?=
 =?utf-8?B?SWxLaWNWUHdPQXJOakM4Tmp2blBKcHZlUFdOTFJ1SVFJQ0UxRElCRzFmN3Vy?=
 =?utf-8?B?QUV2TGxRSUJjOWlnZWxtOC9DM2trVkg2VUhFV2Y3ZlhlckpuaFNVM0wwbXE2?=
 =?utf-8?B?cmF0K2Fia0pKYTlKRzlCY2NadXpIRnkzeW1ZVHF0SENrRnZPUkRoU2xKeWEy?=
 =?utf-8?B?WHhRVldlbG5reHpHTGkxNnZhcUMvUXpJUC9SZ2VPT3JUSE5RMGErL3RCVmdI?=
 =?utf-8?B?dVF5V1ZjYlJ4NWFQclBvNzNCNWNMRkV6NEtCa0lrZHdST0RUY003S3dZeGtq?=
 =?utf-8?B?OWluQ1JiQ3dzUWdWOUhaQWs2N21zTVY5RHNBc0NXNWhSKzgvQmNzY0F2Szg1?=
 =?utf-8?B?SlFDVllXL05kdXcveUt4Q3E2d1FKdFBQL2lSVzNiVFU0T1dCWW1rVWNzd3F3?=
 =?utf-8?B?SGdhNmZRT0JRdmliTWZSdjlRN2grUWZXb3N1NjVHZnc1MDYra2xOKyt2VWxk?=
 =?utf-8?B?U2dGZWVwMVpqUE8raHVhVkpMZ3dVV2o5YklOa0NvSVAzN3AvS1ZZUT09?=
X-Exchange-RoutingPolicyChecked: RIOpFyUZAdvN+HBOkDQGmh7lujJjmVCml95OUuGIJRH6GeNCWdSJ1yUP/NYYqifT3v1V627yMsE5C0WLWbFsrL1YsEICW12tHZ5nDloEAAIRhXawuS+/1apKlkivHjfAXAEKPbTha2GS49A0GucEUCeyOVjJxvq1TvcSDhM9ZhNLDO4TVdojQEjKgS1aSDUM/OZFZlZm/44ExIUBv0VNDaEE6+Jy9BTk0tGn2YeN4exZl+MDebnEcri8OOlpXkm6IdYsD8yRtLSK6X7oBkuzjwykI415JQUxSJkSyhOADCPpKAQYW1WtbnMW46x5nvNPJ8PAi7FWFV0CUzm8hJooKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a4874eab-c0d4-450a-6761-08deb709e054
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:23:38.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2yQSpX8NeJ0XD6k4B5riKjJbVcn1/q4pPDukRfinP6IyhsgZtjOlSWt/Z5WGCTqnC7IU04qWzjLenvP2VHTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com

On 5/20/26 22:34, Jason Gunthorpe wrote:
> On Wed, May 20, 2026 at 09:12:31PM +0800, Yi Liu wrote:
>> On 4/27/26 13:54, Nicolin Chen wrote:
>>> Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
>>> given PASID on a device is attached to an I/O page table. This is working
>>> even when a device has no translation on its RID (i.e., the RID is IOMMU
>>> bypassed).
>>
>> nit: this description seems not accurate. Intel iommu driver enables ATS
>> in the probe_device() phase. mind tweak a bit to avoid misleading
>> message. :)
> 
> It probably shouldn't do this, it should follow ARM and have it
> dynamic during domain attach.

Agreed that making it dynamic during domain attach is a better
direction. However, even framing it that way, the description tying ATS
enablement to PASID attachment is still architecturally specific to ARM
SMMUv3, and doesn't hold as a general statement. :)

> For security we need ATS disabled for blocking domains at a minimum.

Agreed on the security model.

One more data point worth discussing: today Intel's IOMMU driver enables
ATS at probe time, which has two effects — enabling the PCI ATS
capability on the device, and setting the DTE bit in the scalable-mode
PASID-table entry. When a RID or PASID is subsequently attached to a
blocking domain, the corresponding PASID-table entry has its Present (P)
bit cleared.

Per the VT-d spec (condition SPT.2), with P=0:

- Translation Requests (with or without PASID) complete successfully,
   but return R=W=U=S=0 to the device — effectively a no-access result.
- Untranslated Requests receive UR.
- Translated Requests are N/A.

So while neither the PCI ATS capability nor the DTE bit is explicitly
cleared when a blocking domain is attached, ATS-related transactions
don't produce any usable result from the device's perspective.

Does this hardware behavior satisfy the security expectation you have in
mind? Or do you still require that both the DTE bit and the PCI ATS
capability be explicitly disabled when a blocking domain is in effect?

Regards,
Yi Liu
