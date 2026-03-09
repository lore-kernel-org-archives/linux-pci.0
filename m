Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F802C237C;
	Mon,  9 Mar 2026 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097879; cv=fail; b=rhiKtuTlqhfGi5Bv07bxUnRBOEKcBKNTkNUt5Bjh28sQLgElFtPOCsLVMqzlwqTt53T4BGpdxxRtR8iIw137zxy/LxWFE3pnN2PYVmn/KZc70oh0XAf8K/OKTWCzpZYKyzI6AhyvnDr3PMX3+AIUCNqTeTK1FnbJNyp8H6NbSzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097879; c=relaxed/simple;
	bh=ZSMrWr/qp0wIWPYwUyAcoQ/jOVOISKCtj0Ktvoo6jfc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ehVrhUUyYkyGJirdhHcftnImAQouWTnkW8ex7ZtE8zhrXqEoZBOCR+mW9PN970mJxZO4gnV/Rpi1QhlkfLvpihx0S80mQlIh3M47wKQI8NvGZS8BtK7bgrrebxQYP0zPCJJ4LIt0bPeMgPzYMwH8vKDMq8bH/uKZEQ8U6uDjVag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePrDSqOW; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePrDSqOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773097877; x=1804633877;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ZSMrWr/qp0wIWPYwUyAcoQ/jOVOISKCtj0Ktvoo6jfc=;
  b=ePrDSqOW10/XX2jC7dZ+G+QcBaJESEv77yxAVyt65rSyCCMYDgk3wXFT
   aXcsiQc1iH8BBwqLlOiuEQQ3hII+8N3hfOBIctf+GDpZ1vH8NnELyFAC3
   3cgNYjxKXddyWW6UghyWBtQi/ej2b59zCIH/p3jvQD4ad9zbH4ckO9IPJ
   si48sxlzkMEGuHuMXTqDpfA2eHMCXzWw9CwldloMIMRoM6Fdev3+JX40e
   SRMwnRoG2O4B/zarM8905Q61mdbtrRPG0KtJw0Sv8eR9Vpc/+evYpPXQe
   OL/Quql4JH+wdHQd2OE+8UnlPh2KPS23CG5woZimYgRsm9ktbYl7YpQPP
   A==;
X-CSE-ConnectionGUID: LL28BECxQ9++G/zR2zdbvA==
X-CSE-MsgGUID: TQpJCz2uScWJW6a1vnmTCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="84844557"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="84844557"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 16:11:16 -0700
X-CSE-ConnectionGUID: 4Pogy5AxTWCzbv7upXooHg==
X-CSE-MsgGUID: sDIdV7glRgKgXvcoN674IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="250375263"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 16:11:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 16:11:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 16:11:14 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 16:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJ9tusJGT/FkJJKmBLfhklxKPCCqOMExAJz0FIjeYMHSkdPWTJfL3aTBbJxmQcE6VaaXCgk0xbXBEjBMvIBIIZdz+HVRGyxrv85VZYH3bYiB1UbQeywbvXS7kDdH8/9nnCiFtEfa9/RlLAqqa0VLc+P3WKVpKtvTf7yoXgPfzMObMPsWpclN8PSQ1UqUvjuMVpSWaUPmo9LSyL+kny5PZy+LhS9PzTgJVnsi7+5UFi+NWr2uZhTLrtvJnMHYbQ5QrIrCZ5qgMrfek5PY63Z1RWOz2PLphGsRdKE5NH63LokEYBVhVnPqyvTLP2Qze1YRNjH/d448jRwcC8C9bKcxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd2QZ59dRKbqJ+HiFg5qs8iilwZyWVXivLZv0zHUqlg=;
 b=XOH6Cm5IkiZzWYrkpiL1EV5JdE8twZq+8z58xy9aXetQP+c0mzAuP9G4oo5RGe6c+Go1DALB9d7KPi/Z+clX1syNA+aMeiQPgRi9yS8g4eKVv3w4YFJdD1e++ph2M32cYA0lc47HcawAIbgBUR/p91m/jPKvMvJRtt1YdwYsKi874KgISO6+4t08lQ18XAjCiM25r14F9w3/7GSSuMtf9Rxc657Q/EMKRLSYxmjMutYA+cb2H6u3MigaxxLe1o0oIpiHpQKiLfgkaYzkr0yjjWDNCUADs0n4vWSnS4+aWvupj4MtHLNOGvs6UceO9hmtVYEM5hDyEzCwk4jYgvd59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7265.namprd11.prod.outlook.com (2603:10b6:930:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 23:11:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 23:11:06 +0000
From: DanX Williams <dan.j.williams@intel.com>
Date: Mon, 9 Mar 2026 16:11:04 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>, "Alistair
 Francis" <alistair23@gmail.com>, <bhelgaas@google.com>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Thomas Fossati <thomas.fossati@linaro.org>
Message-ID: <69af53884fe94_2132100f4@dwillia2-mobl4.notmuch>
In-Reply-To: <20260309204026.GA4132316@nvidia.com>
References: <20260223171527.000016ef@huawei.com>
 <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
 <69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
 <20260305124837.GS972761@nvidia.com>
 <69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch>
 <20260309113941.00007258@huawei.com>
 <20260309123148.GC3717316@nvidia.com>
 <20260309153339.00007b29@huawei.com>
 <20260309155909.GG3717316@nvidia.com>
 <20260309180054.00000933@huawei.com>
 <20260309204026.GA4132316@nvidia.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0047.namprd17.prod.outlook.com
 (2603:10b6:a03:167::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: e18afe57-dd47-4495-3304-08de7e31240e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: tS6MAkjrH+z1jQjKMY1tx/+2U7Sl64AHfiggtv2PiJqeb2XZuUJZ1w8/+yggutW+CGWyuaNSt0Ek3553DzeCBgviWVKq78ASE63Ow6Wu8qMMIyrOAhoIA6tRQyCMQuW2732uaAcpC1KNKijNUuWaynsgBZ+vqULfjf7t73RZsJ652jaKMEUjaN3SGIlXR2VWI6qYvKEs4hudjhpinZaFcbEMzXUdxgXpPpPUUzKanVNMJToqjcU5iDJPhPuNLWO4KGWkaX4N7Mpl5fZEtqaRmhwmagOM2AbVjiRFE2WBG1xpx06oweoB3wJJvqsZCsecUeVYRlTsnBIInN0SrauVfiSeOFpGbXFG/u//9mntgZQCGLIHlvHGVHFaegRxFLvuP+R1kdOpFNGVGGjXFTh2XfYnrm0pw0ElwAIzyF7RQkoogacIOZQsetJye6sXXLXz6MdYomrBKIDIKCTbeZ0GvScTo5NOsbgY0WSEl3h3qaokwcClrcEqn6jFKJ+dVCPiHmREV9c4tv+7U9aVODeQgbB/CAvtQUTry28Wd830Yi6PB82XhqHcnRVyIa+sObjlM04eAErNKTKqNYDq4nEfQi+81J/+eSs0kiwThK5zb1qTxUjAEu51/Vomj/Tj6GKR2Z6MlD2lU7Ji9Y61v1L5o7RXGf3uxWNq7XlP4MjMMeEMLJK3uiAFYWMWakcaLKXS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajNWR1BRMEptTzJNbkpRbG5CVnJZc1JHeGEwVFNlSW5UVklzUHhRRnFEWFZU?=
 =?utf-8?B?eW9nRHdTUUhjQ0N3ak5Kc0ZDbk4vYkVZWTFCajhuTGRHUy9hTVIvT3VsbUVw?=
 =?utf-8?B?THU5S1ozN0haL2dScTZFS1E3SkhJVnlCSzVVdEoxRlZwdlB5MTNoSUZIS0pr?=
 =?utf-8?B?eHNIR21sN0I5aVBWTnFtTFV5SE1CVFFHZ0JneTlBdjcvZmplQVFROUdLclk5?=
 =?utf-8?B?TWYzM2d4V0JZVHRGYzVQK3l0ck50Qi93azVpY0w2WitTVUxnNkllRjhEQWxo?=
 =?utf-8?B?dnpCZXFxeEE4MktqR3VlYzZDcFFjWmdYSjNzSlRQR1dpSXhlM0x4NnVCS2ZM?=
 =?utf-8?B?SzRFRFlCQUpyVlEwYVd3L1VxNnY3eENoWWM0WFo3NFVlR3IzY3R6UGRZUEw5?=
 =?utf-8?B?Smx6SUxFTHZ2eHAwYXlXeUs4SE45Z3NHRmcwWVJqSi9xbkVGbDZtYWh0TTlH?=
 =?utf-8?B?amprSnVYVjl1TnBmdHFaSU9GanQ1S1luKzE5WnB2eDlpeCsxc2ttNWRueWVY?=
 =?utf-8?B?VUI3NGVTYjNyUXEwWDQySkdFN2hpbks3dDVTYTAvcHpHbEh3WWpCZjJFcUZn?=
 =?utf-8?B?TXc1V1UvdU4wOWl5NjBTWjY3NzgrSkR6V0xYYVU3RW8xdUpyeGQ4VFMyMFQ1?=
 =?utf-8?B?QlBGZXpYb2ZFUE9jUzBpZkVlckRqaDlXT1lrT3Y4YTJDQUVPcnRFNlNZQzBj?=
 =?utf-8?B?Z1RKUHJocGt5UUNiaW5PU3ZhbXpvMVpnL3hjSzVSaGpSbExxemhHV09SakZY?=
 =?utf-8?B?UEpjSEYrdlg2ZmJIREFpSHYraW5JbXpBTnpZelVTZWVialMzbGVRNDdJQjlV?=
 =?utf-8?B?OURtTzEzRFROV0QzWE1zSWNwdkhiTzRORkZFL3gwRGtXRnlVbHcrRTZEQXVD?=
 =?utf-8?B?SlhaNXFOaDBOcXRlK1hGdTVXMDJLRkRGQkZ5Y2pncDYyOVYvQk43eEt0RWRG?=
 =?utf-8?B?MG15M0hNV20rbkRxc0ZTblhqOXVTODI1KzUzbHAxMDhqelIya3YzeTlMdGZ4?=
 =?utf-8?B?YU55TE9xQk5NQ1JrdTRrTWFPMEVsU3JMMHdMZmFzTVRnVTRnNVpPaVhwb2wx?=
 =?utf-8?B?aWJ3eXROV1NQYUxkNld2cmh1YnpGNVlPRXVvTzBwL3R3K1dFZndWdzN3Q0F3?=
 =?utf-8?B?T1BWNE5oZkVWaUhyVGxQd2Q1cTFjNWtzZU1oRk9nR0UyOGhNa1RlRUlsckdX?=
 =?utf-8?B?bzU5MTBDUUhxNFhxaUVvWXRUZ3IxMTJoVTBWOVMrb0h6dklhSzVpM1ZTdkxB?=
 =?utf-8?B?OWw3cVFtVkdxTnJaQjZsbnM1NXZzMlFYcEErUTMzNFMyNVlQUFNtb1FjSlpU?=
 =?utf-8?B?emZNYkcxYzBIcndpSkNoS2xlZEFxRHBLaHU4ZVJ1NXhHcHhnam5UTWZROEdj?=
 =?utf-8?B?R0tqclJnWnNETkNzb0hWSnlBWk9sWE5WaVZsaGRYVmlObUwzYnhKS0V4MU5K?=
 =?utf-8?B?T1lubEloQ2NpcEh0V0psUE5JYUhGNVFjZkRsdXpOcU9IUUFkdmltd0p6dXM5?=
 =?utf-8?B?V2RVbWlnWG4vdjUxaW13R1pQcmtCbnVlNkVhS0dhN3FnU0VTd3haYXVqQXJx?=
 =?utf-8?B?bEtjdldjK3VhcEpKRml0YVdQQ0VmVGxlOGVMTUVmam1EZjV0elNFQW1TUVl5?=
 =?utf-8?B?L3d2blhmRXgvc0NjTVNzQTNxUmhaTEZlUjg5dWVIWjIyNHUwQUsySDd2RCs1?=
 =?utf-8?B?NlluazYxa0ZWTWtZTXJ0d3ZmelVXbHhSZ1BRdVFoWnkwRkRKbGtsQ1NzVDBO?=
 =?utf-8?B?T3NqNjk5VWxWNWdLbndMVWg2Z0xwUnBXMS9ibFNBYUNPcG1GWEQvUTg3cW1N?=
 =?utf-8?B?S2tMWVVFY1QwRUo0QjBWcG5wdlg3V0pmQ3NWUERuN05raGNJUXJ4M1d5M1l4?=
 =?utf-8?B?RDJRWFIvVmpiTHFuV1pqb21QdFVsaVBVVzlmR0VacXJTSHBlcVhldkhiWjRt?=
 =?utf-8?B?MG1YT3pDTm5PbnFPaUVXYXBRdk9iTUhRTGVkVU9TOEY2YjQwTGIyS2NwSFo2?=
 =?utf-8?B?YkFVNmV2dHp3TGFjV2dZOVdDQ3lnSklQdVU5M2FtVHRwRHJDd1BOZklHak8y?=
 =?utf-8?B?TXJxY1NIK1gycS8wbGh3eFdtR0w2WWFieDh4UzZITmhsSEQzTFdJOFdvRXp6?=
 =?utf-8?B?OVlJelhhclJZNlhBSlRxZzNCVWpUWDJER2xvRHRGRkI4RTU1anZXdHp1Rk1C?=
 =?utf-8?B?S2x2cnFxaC9RTGJPVVJ0a0JjQUVIQjhKVmxjVlpnR0tIakFadVNMWHRyL21U?=
 =?utf-8?B?VVNlcFp1ZnROVHoyWkREZjR4cFF0UWhQQkRaSE1NenRHYTQvcFFmR1lPcjIy?=
 =?utf-8?B?ZG1vaGl6TGZDWnRDZ3ZXQytzbWg5WWVuY3ExbGpSemp1SW1XbU9YVHdTZFFn?=
 =?utf-8?Q?ycjK1GEvzhCmTB9I=3D?=
X-Exchange-RoutingPolicyChecked: pR6YECwmMriOOKSOPp16ZV+zBwLiwcgCRCShzbIBtS84laRFwVot1pIZLuZn+sqmLsfuaf53IqV9HmPjstf5m9S1GJvDQTWQz+bFke8F+cR3XcULwH4SYojPrkeiIUhzv10zj6I2I88XdFNyCDeCddyPBG5xXlMPOfAhkRfM8zpJG8pphzU+J3fjsyowAzpjrw8yX1av/ZBoa5RaODKGNXVgMArLQ3iYpF1zm+c9EbZitnRoV+/KXXr/xqBV8a7yXt73wPD1dvhI97Ws8HsKfMF5/Q7PCNkEKrgWLrNRnsnKDPDldH5VJfAofhkeYOOIU+j03ZGLlwNfEPGK9ZWCFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e18afe57-dd47-4495-3304-08de7e31240e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 23:11:05.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7ArrrOPx6VyZ9+kJZ5XlQyxzDB8Uv1VVnK8tLGwYb45Ymo0zBTqhTbOj9opRgXpoazEhHL/WFQXWFCskGNI0L62cdfnZVBxz+qJH6CV5fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7265
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
[..]
> > Whether anyone actually implements root ports via standard DOE flows or
> > everyone does this a custom way at the host is an open question.
> 
> I'm expecting Linux will be able to setup Link IDE, either through a
> platform TSM as you say, or through someone plugging in the IDE
> registers into some Linux drivers.. I certainly don't want to close
> that door by bad uAPI design.

Right now there is no extra uAPI for IDE. It is an implicit detail of
the given TSM whether the "connect" operation additionally establishes
IDE. The result of whether or not "connect" established
selective-stream-IDE with the device is conveyed in the arrival of
"stream" links in sysfs, see:

Documentation/ABI/testing/sysfs-devices-pci-host-bridge

You also asked:

> Yeah, and I don't really know the details, just have some general idea
> how attestation and PCI link encryption should work in broad strokes.
> 
> But I know people who do, so if we can get a series that clearly lays
> out the proposed kernel flow I can possibly get someone to compare
> it..

tl;dr: can you point them at http://lore.kernel.org/20260303000207.1836586-1-dan.j.williams@intel.com

A couple notes that the host kernel is unable to establish IDE without a
platform TSM on all but Intel platforms (that I know of). At a minimum,
this is why I think native SPDM should behave as a TSM driver. Platform
TSM involvement for IDE is the predominant architecture in the
ecosystem.

As for link encryption and attestation it is all rooted in the launch
attestation of the VM. Once you trust that the TSM that claims to be
present is valid then you trust all of that TSMs ABIs to enforce
confidentiality and integrity.

Now, a TSM is free to decide, "I do not need PCI link encryption because
I have apriori knowledge that $device has a connection to the system
that meets confidentiality + integrity expectations". So link encryption
is present for discrete devices, but maybe not integrated devices.

Assuming VM launch attesation gets you trust in the guest TSM driver
responses, then the attestation flow to the kernel is mostly just
marshaling blobs and digests:

1/ Host collects a fresh copy of device measurements with a guest
provided nonce (response emitted by PCI/TSM netlink, nonce received
via guest-to-host communication, see AF_VSOCK comment in 2/).

2/ Host marshals cert chain, measurements (signed transcript with nonce
from 1/), and interface report blob to guest via an untrusted channel. I
am currently thinking just use a common transport like AF_VSOCK to get
those blobs into the guest and not have each implementation reinvent
that blob transfer wheel.

3/ Guest needs to validate that blobs are indeed the ones the TSM
expects. Each TSM has a private message protocol to request digests of
the blob contents for this purpose.

At no point is the guest offered explicit PCI link encryption details,
nor the host for that matter. I think some TSMs might include the key
exchange steps in the SPDM transcript. However, that happens within an
SPDM secure session, so host can not otherwise observe it.  SPDM does
support mutual authentication so the device could in theory challenge
whether it is talking to a device-approved TSM.

The open question I generated typing this up, is that if a common
transport is used to get the blobs into guest userspace, that userspace
still needs to push the "interface report" blob into the guest kernel.
Kernel needs that to determine how to map private vs shared MMIO. I
still think I prefer that to each implementation having a set of
implementation specific message passing ioctls() to do the same.
