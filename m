Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57034B434
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692026; cv=fail; b=cMqo9IUZv6NgvyMOCelfhkwtCLM1I5iP1Q6q7aDvMqn4SDzZwbcQeniERtDa16qIdsLLl10JDCZV64paQPTOB+3NV1x3zNdID3BiMGI7QGMsfex+aawnJg6RAeuZu7ah+kTDgK9YPAe2xMR3KSs22ggttYG5iKokfh6bq5mkq0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692026; c=relaxed/simple;
	bh=PhR6gevNRTQpevpp1ADkSoyWBhN1jSNgYnL+mIq7v7o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=LIWhkUWODC7gqzUvkzWU2byVclYN2vswGcAZW1dw1wiV3c8s9Vd4mJBC0Vj4uSIwwCm0MP+zMa+cLp4H/a+SbjUhBDTnjaRu/ePqWiEjhSFofuOyT88fdMvwmz/afCgT4KivFglGF6l4ZlC9Jit3yqyC268BHZWtgcVeW/TwNwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBM9obro; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBM9obro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773692025; x=1805228025;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=PhR6gevNRTQpevpp1ADkSoyWBhN1jSNgYnL+mIq7v7o=;
  b=aBM9obroCwuY6Lot2ixyU7jPFPZRzMAt957B2rfspykN/DWRDDbc6Ans
   HyplEi14jG0w3/C9E8/cuubXWhSTncOGoFP1BTpOXEK7vIf0BF6vlNoXF
   GGKfpSnG1bRqpF/csktaOBOwrbEWeh8vaKyy6uJkbym08a3nS6ASURmO7
   H7QUVKXxqKPJlLa6YIVrrhg6Y0OrqTlC0urO5QtYMqj0CPhpn6M9PXF0T
   n1FQ+h7WaxKbYAkzY0milk054v2Tnf2Qlq2XLry4O90lqgTyR9WBGfAs4
   CQ9G2Rm5ZsDPweg18f2IxB5nUZYHAefWw3Ig24uAfKAWBA8S0/iNDxmVf
   w==;
X-CSE-ConnectionGUID: xymHPJoyQvGFkwO0JDK0IA==
X-CSE-MsgGUID: pWYkvTrTRnyxjKqHp/2PFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85415259"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85415259"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:13:44 -0700
X-CSE-ConnectionGUID: WBy7A4yuTxWrPe+cIfduoQ==
X-CSE-MsgGUID: boB5aReVS+6aDDM+RCTDCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259922050"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:13:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 13:13:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 13:13:42 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 13:13:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBpPm6ZcZdmYxrYy3e7rBElB/9F3vGqculehniCKAKRRGnE8V2M2jxSn30fOKeJYmZTGeP55wEIM6IFFlTRsefWjxIeWJGyjVJ4Pg7cYlMkjDOlq1f9oJbJKE0mvdOjTjLufsczc9/yVnJJ6g2BuQ86oHfRVf8zWoejt546UEKKnemFa5NxTwbq1aqEiKc6bQnzuxHIjdolppBDJ79hTQREutpVLZ1PrNj3ibVmMW1lK2d5HNCrRs3zASkfnsFsEjQ0a5V5x0B43FYMVylyubbxY0w56eJPEiZ62R+8wxY7tMI0NuvZ3+OGUTHRwgQs649QmHTGrh9+q8YQ3YUOdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbK13vWH7pFSlkcRGXVbJ6SDkJE9P1/YnRui/pHbrGM=;
 b=k6IrsEUptk/Mh4TQjJjm21kqaV62eVxGJO33JvGRKUMQPz74MxHgmfsm7d4Wyvo/oENY9wWgqWGPhu29Y6TDt48jxuXZD8aU8aDCDbIeQ3Ssj0W7Lb0q5TlW+duAdWTsz1Y6yvWS14VVZezh3V5qJI3FuiX7G1HHQXcOTgWPDTJFtPyHyWEZnRgk+YjsIdM1W14pqaU3TC96obDpc/5UNVtDp+Po0Yd2DFZSwIajxStus+TVsPQYWDazXBuNVGvqGieCHQBLAhfolxUfNEFGecANFDmFPqEFdm+RAx71CFXUWt+cBKaXAaXHF8DRUHpVaVw59HIitgMg0fPpLBREcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8526.namprd11.prod.outlook.com (2603:10b6:510:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 20:13:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 20:13:34 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Mar 2026 13:13:32 -0700
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<jgg@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
Message-ID: <69b8646c8aeb1_452b100aa@dwillia2-mobl4.notmuch>
In-Reply-To: <abWq1oiE-YkksxNu@wunner.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <abWq1oiE-YkksxNu@wunner.de>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 353bd596-f43e-4fec-241f-08de83988024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: dXdTIXjb+Q1pY8Wdk48ZhOO1RwBxQDnIMMxFRR8ofRxkiL98oQDGbIqvTP/rIzIh/dsAEyXn01g+IigBXBYjMuXyHvmakCx3aHhsh9VbpTI7muTwPovD2KDkRm+jzqByFt2yj0K+NIsa/oZ5RlmQJCr9xYEJWN3L5y7jyfEBbIRrQ+t/VGbYFeFTacCaqh7r5EhJ33kGndzCSkIL/w1gaZF1m6C42vBaLZ2MjzbpOGoK6C6WzKjQa+qfxRwIoHi1+s3cioZ+sO3exs+ik7T0zA1sZ8Qw52VANDZjrxEXnHYMEcpsQZANpTEmowSN0aFPtUyEhgxD7pAHh2TI+ucCSnG4XoYb1dTUc0UlS+Te8f3/GshRYqkR3GNOIkABSub1KTvVLErWv1HLa1pTS89HeM6ga3pykbGB40AnTKsWQmbBEDMKvXTHxqmHeZFNLBE+CPTWtDMCXdr0khY/iyP+rCJ59ZvIifP4iR7AvYvmSa2nqCDlKceQYFxYdUMJRVhs/Ex4eV31FZ5XeYidWqbEK4/YFwR/xeNv9IHFfabEF4wGZHFsnxRnwfVyiapDJxgoMJ7HTLNJP8GDcR3FLthkEhD/lv/+9bpMSvipofpMe8B1tTuaBqp1u8gQGMix4kwkuOD/DQ++lnCZqSlYFIQ+EyxwjcH0m4JT6idWbSb64DEP9OoHluQozEE49dMGf2v/Js9ETM6drQS7L/AzqSmjTL3HBx2GK7hGnTX2/0YjOvMObD/yjjdH1EtHs+5OrGLi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NVbVJIZy9mRWY2S0V3cUpWanYySEhLcU9lVlJzempmYXRvM2pLMVZSd3Fm?=
 =?utf-8?B?a3E0STMxS2MvM09rT3daMytXRTB0SkR6M3BJc09VZW1rVHZWOEc0dlk5Ukow?=
 =?utf-8?B?MEJTRkF5MFlUQnVXMHFGbFNkRGxKSHhOUjZHSUNOa3lFRzFIK2hnUUQ5ZE9k?=
 =?utf-8?B?Ry9UdGVpdTRjZlBNNEMzY1oyQ0wzWnpac0cxQnZNRHVINVBmRjdrQVduL2NI?=
 =?utf-8?B?akdrQm1PQ29USUxuT1V1SXBldk14UHRIOWpEYkp3QXoxOGp0ZGNjbmNkZUps?=
 =?utf-8?B?VVdBaFplMkdvbHN6ZEQwVDlVV1J1alJkdlhyVER4ZGxJQTdkb0ZUaFBkME1G?=
 =?utf-8?B?dnhLM2t6Q3NjVzNWK0RGNlluUkM3MDNnbUQ0TVEvYXlyZUpZSmxCWUlwdXMy?=
 =?utf-8?B?UFZiZUI3SE1xQi9WVlg1dDN3Undoa3FHUG41cTBsaDZ5WDBIVkQ3L3N6ckVN?=
 =?utf-8?B?SjBIK01jVGpDQ1RwQjZOdjJUd1RxbTFVWmc2bFN5Wm1VS08zSWM5QWErK2pR?=
 =?utf-8?B?UEZDb253T0xkc0crNGJVY3RsV1lCeU83Um54bEwyZXJRVnVGNVo1dFdLUmti?=
 =?utf-8?B?S1NNWjg5Tno0VmNpVVdPMEhMNW9KY0lqMUN5NnQzSjJOb1h2clliT2toKys3?=
 =?utf-8?B?ZjNZdUMzTC90dFVyaWFsbXMxL0k5WlRIb0RqUE9NazNqa3ZyRTU2bTQvUzEw?=
 =?utf-8?B?ejJEV3Q4eW56MGdlcDlKbllGcnJaOUdKZFRqU3h4aG81ZnN2UTJ5ZGNTQzdW?=
 =?utf-8?B?eGV6aUFKT3lzRVlhL24yVU5aUG9OUmE1RnZmVXROTjczdStySnJ1VldHdUpV?=
 =?utf-8?B?QkQ3V0RJLy9yUHh0ME9iWWZJb2VlNzYwdGd1SEg1SXQvVWpDUWw1RFVBWDht?=
 =?utf-8?B?ZFpCN3BBMmhpaS9JcWRJL0VKbzlZMDhZRk8wUHV6dk9QTWxkdUpPSmRlQVlU?=
 =?utf-8?B?cmZhSTRwTkV2d3NxZTlkd1ZLWStRcHlISmNoejNtKzVmdXlRUitpWUhORlhn?=
 =?utf-8?B?QURWbFJPUytXK2xkUjROLzJRRE1iRFdRSHpLMllpMkFEVFN0M1ZpTU1OZ25N?=
 =?utf-8?B?WU1JVTlyRTNMSDZyU0tEbTlkVXUwSVUrUFpXVW1sUmtEZjUvUVlqa0VPaUxx?=
 =?utf-8?B?MktLZVFIZk5BWHNrTzI5N01vemRteDRqU1czTEhsdWhlSFQyWC9CSEZjU0t3?=
 =?utf-8?B?bXpMWVZEVjdlbjVWL1ZVS1Era1RCK2VMNlpSeDBVZWF6bmhmcjBXZEtldTdC?=
 =?utf-8?B?bzdCQmVJWnBSUzZFWGJ2QUEyeGdWNUZYSDhIWm1aUXI3Q0k4UVQ5SmRqWVhE?=
 =?utf-8?B?bXozMmRieVc2cytiK3Uya1c4ajhvaTlMRS8wQXBiRmNwWmJyNXlqczZNMXd3?=
 =?utf-8?B?YjkvUzA5SnFlajFVNUF6UHRTcTZKcjgxNk5JcWU5R1RaNmhwS0JMbWpMSVJJ?=
 =?utf-8?B?M1hjSGUyUWJIeHhRVjJOMGJDcitTcnVFeEdzdGV0b05mRjhLbnNIcFVZdStt?=
 =?utf-8?B?K3A2UFE1Q3MxY0Y3bW9NWXdnUktnL1U3Z08xaGpJelZSa2Q4NW12WncrNGht?=
 =?utf-8?B?cHhQNGhjT3g4N0J0S1NCWkd6cnVTOGFISkc0dUJPekhkMUpjRWRjRElDWWN3?=
 =?utf-8?B?TU1EaERCVk9UZUFiTXFYcXlyb2Q3anF4M0lCRkhrYXZkTEh4L3hVRHhBcW9u?=
 =?utf-8?B?ZWh5dzV1ZVo2UGoxS1VEUEtsNFViUzRqbW5TcHQ4L2ZFSHNTajh1dVFFN05o?=
 =?utf-8?B?c2YzTGZrSklscEJXZGQxeEdHSzBDYzZzaTd3RmlqdVFCdnBrU1lwWDYvK1Nn?=
 =?utf-8?B?TnJSVk1DR295b0s5MkRyOURrR3FoV01WTHJ2TGtUTW1EdzFOZUp4ZjlMTEFz?=
 =?utf-8?B?c3VBTHBjRy9KUHBiM3BMQ0h5M3E1R2M5dm94QS9BNmZodm96UTludkVremdn?=
 =?utf-8?B?Ukp2MzNEaTVCdFNsNTVEZloxK2pPTFNDNjFldW84djY4ckJTUkRPUGEyTk5L?=
 =?utf-8?B?OExleDR1OHYwOFk3OFRrcU9wTmtqclROZkUyNWgwYm9mVnU3d24xRWUzOVpC?=
 =?utf-8?B?ZEFPRE9hV2lUR1R6Z1NzQ2UzVlp0TkRTakxYUWhsMCtLdXZFdHBQcFA5WDZy?=
 =?utf-8?B?SHE1R2N0Nis1MEFsdXF2VnZ1TzhMWHhrb0tueDdhTGdMeng1ZEdlYWJKSklU?=
 =?utf-8?B?MjQ1aHdRMGdWSFZoL1MyT2lVMENLTWZVOVJ5NVUySWw1VHlZbEhaTjVmQ1Ny?=
 =?utf-8?B?V3hkVWw3RXBGRUlPN1Vwd3p4aTlBVWM4ZUh3RDByTFFFUFdTbjRNM1BDZGp5?=
 =?utf-8?B?ZXdzRG5tVnFmbHQ5dlBCbHFjMjJMQ2RKbHdwa0E5Ky8zdGZ0STZXSDd3QVNn?=
 =?utf-8?Q?z1gRcBgB1810/Uto=3D?=
X-Exchange-RoutingPolicyChecked: P7WCIF1OLF+XvnSBjaT7PxvQzmrdTR8U1g0YhXVjuPIk2nCo/Wm91lQfFzBUdJPpdsRK9cuBTk7ks0nNtEr6M9pf/scQfLweyxqoe3dybaEF01uXrdPzt0+eAhfdgslcYAWg/CX+INJ1OxeBfK9EjES9ekw5IQ1FwDOMi15o07+vmPrzw3wziHRnGwMEfCq9D8z5/PFeqVqUmLy7q19GXm4ioNQ2/W9BpZlGZXlvQmZ47r1BKaqJrJUJbHzJLwcyr19XfdFM5Y7pvRQsWr7K4IAaQYKLqUF3lSFp05Y4/a8i2E5mPKvbYlfPQb67FbNlbzYei3jRQ1q6+DBJ79rtuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 353bd596-f43e-4fec-241f-08de83988024
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:13:34.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+h1EEhZorCgcoTGB3OXwQqtAesu3bNUg3jm0I0RHXdrNqBKEBaix3LIDxGnqBAZ3PnanXJ3a/6bUdbYcJpBAhjE2yCIhgidHZ4IwXBMPsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8526
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Mon, Mar 02, 2026 at 04:01:56PM -0800, Dan Williams wrote:
> > +definitions:
> > +  -
> > +    type: const
> > +    name: max-object-size
> > +    value: 0x01000000
> [...]
> > +      -
> > +        name: val
> > +        type: binary
> > +        checks:
> > +          max-len: max-obj-size
> 
> The length of a netlink attribute is a 16-bit value, so a 16 MByte value
> (0x01000000) won't fit.
> 
> Moreover you're referencing max-obj-size but are defining max-object-size.

Good catch, not sure why the tooling did not complain.

> This doesn't look like it's ever been tested, so at the very least
> it should be marked RFC in the subject to convey that it's not yet
> in a cut-and-dried state.

The 16MB limit has indeed not been tested, the test script in this set
was using smaller than 64K payloads to check out the interface.

The RFC comment for this piece is fair. The whole became a v2 based on
the maturity of other proposals that were in v1. This "evidence"
proposal deserves its own conversation.

> The two top-most commits on my development branch have solved the
> size problem and may serve as a template:
> 
> https://github.com/l1k/linux/commits/doe

I was concerned that gets the same "too inventive" feedback from netdev
folks, but I ended up triggering the same with a broken alternate
proposal.
