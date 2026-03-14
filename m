Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92D4315F
	for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451975; cv=fail; b=O+FGktaqge/o1ny/21MWRC87u6UCrg0qPWJ2SJ6WRAvjrBZlyEPK4+dvzjKk4q957Q/59IGOmMu8gp1ZPK6KJ200XlppAEm/lg5CjJChsvqBUy8LnaqgMHj0ojwzBRAGDp5mjukZPtCe4vJgxGEZgH7rgh78h2hyzYetMLXNilM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451975; c=relaxed/simple;
	bh=cCTfUK7fl5skSCAiLHH0Qqnmd2hO28SWQb03gn864g8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=a4E8d/EcFHX8KkJuqGy3zUzCH38Nkm+uEWh68mZCDM8lBwRompHdCDZ+vOrC+u29OGQUzlJLGN14CYa5IQnqBhWMqkKb1kSld/7ews1yQ1dMcod+OA3XfaR3JHUs83zPJfULiLi+De4IA0zDDI3mbRZfHkq+NIqTTVrURSRmfMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUvyUwQf; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUvyUwQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773451973; x=1804987973;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=cCTfUK7fl5skSCAiLHH0Qqnmd2hO28SWQb03gn864g8=;
  b=CUvyUwQfVVUcErrDs9pwD4e1SWhO7+qew7JpakJP3+fpdVWs+D2Osw7e
   vKt1WU+/mc20edlSZmz3+6Oy4PWPEDNimj2iDClv5h8tQJdV4+9AbNmuJ
   dyjl7xQFQtHeyUkSKyiYa+1uxvkNjz4ekXQhTfpEkrtu41KfAsI1qczkg
   dPV8nhOYdWrqDeT43UvBWbwQ3AlfKOIx6xZU8DwS6IeQ23kWYWgbcts2s
   1y45qPLflhsoY7ykQ1TrNwT1gu2CA3EjAnztE4XOHJL5P632dOidBRchu
   rqB2W0715ad7JGXYqeobpeSxaHkcnY5rZDmI2VjUJMO4vAI/KaxLTEfJs
   Q==;
X-CSE-ConnectionGUID: Ipq1gMZOQSGSgySvZYBzyg==
X-CSE-MsgGUID: kjc3eB6xQXulEzvek4xSwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="91943541"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="91943541"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 18:32:53 -0700
X-CSE-ConnectionGUID: 72WnVRC4QkSHc5/eMM6Jwg==
X-CSE-MsgGUID: gEQ/XTeYROiOpYO/Of74Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="259224085"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 18:32:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 18:32:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 18:32:31 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 18:32:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhxT/3BdB92ZFOEOK9Vvg94WyZaXr799Vqbu9CxkAdFrB2jXZmTk6iIYoWvjlnTupPRKOcpOylT6IgPrH4lRNuLurD40lAL/hDK/+wPQHLP5JrxPzJP2uiwIY0q4zsYcZpFRrvtbTjE3yVWoHYyTBpfNs9HQSoJvTwXyh5v2EM+xDR6Z/Zj7S8gMq532IZ1oi89fCu7VGaaxGorwlNqAvmTWLFKLsq2M9QdPd2sRy8bFqU//6ZBwkCLKQkWQmJu+Q5fcSLsW8Z/cqHBclchrQCRw+WrCI6SURk6KQdKa3Bz337F/SXhR2Sxylb5RlOnA2K5Gkxv3nVwgsjqhlO/9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVPaA0YAnMI25e2sdsumzDY3RZlXPlMp1djnFUKwvk4=;
 b=Guhos3ynRhxDXijFwpRKxADISK1Dq6Qnln6lVuC3KmwK3TtTscQh+GAde2axB2rbHHh5G/mlJCFy+5D2ZJWWIgY8vczxlYgapUqkQjxNAzmDBlrOFhmL5Opwwih4rzOBSO9uXbijHWKYVxazvo13m8RB+MVokU2u2cdA5e8fy8llxdoF24JwGVY6iS6p1uu0ql4YXYvY3EWikS2wI2MK/2YmGZrTVYMZjCq0oPkN8N03j1xIjbxFymPhhj4WpICv4mHBwj2wxvdhAcZ5Ifsuaf2GeS4rIDqnTwo6WGxvkoKf8OHbul3cn/fM1HDGr6INdJ/D7xLT93lLuxQm2UY7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6380.namprd11.prod.outlook.com (2603:10b6:510:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Sat, 14 Mar
 2026 01:32:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.008; Sat, 14 Mar 2026
 01:32:29 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Mar 2026 18:32:27 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Greg KH <gregkh@linuxfoundation.org>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Message-ID: <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
In-Reply-To: <20260313202421.GG1586734@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e93ee1-9237-4d09-d35c-08de81698e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E/+wydPiK5f03HPT4r1AfLR7KY6VJUI83jtVR5qvhqAbPdK7l+Gy//PgzAmFSVFB6PlN+FT1kJmlxR3+UTCFuvut+c10RuG8UShtKitFcVt1KcZGb8ZCNVmx7lwfRkmMZ8FeZI7qOL/0PLH86CL7AaZpr6ek0u/w+dP1Yi96rC1/NW1UMwX+Me2o2TNl+jcCGodjDG584oOzRyKexhAaIELjjhzKs5lAhPjk8P6fufxSvgQNZT3HbHfYmlfPj32lwNRVxxKFJQNDKS9KxKKDXxt89vywm57RLjm5TVYu30mFFVKRwpJMBpzdtkNETBjgoqbpCAWzczdB7UQYsQSGDBujE/UFH1HPNUMAPFmKTEZTSt7zASO1trukjrt2E+ZhUYmUx1QQb6zQwjcN63PO8ADPamxPZeVgt6vOTkTMw9gjGbtAHYx1UT6wvxm+JyXIhBMQtu8sEqlnYi0JXulC/R5Mp7ALT4l0SwD1kLzXTK8ttoamcHqRSTaRP+VKkE7Z2rf6vAlS4lA++TOWOUPE48E5Gp/kRbO38+yOA/G7NJg3L418raZmiAZFGiqz0PGZKPAf9y5qHvL747ut16G6cyOKzdvdYeOw7iyKOQX27scxE26p1745LaDjPAcGuS9c5mPB09kAiVy7/kATZ22cuLacjWUsg2LZNAzmzoGHCgv3fB0/G9MUh8jNoTxvbyOn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGFOWWkzVHlkSTg2WkQ5ZlZIOUg0eHpIMnhnVFdWZUZsZ0dhbXZGbG9naGZI?=
 =?utf-8?B?SHkzYktKemVaa3J0ZXJyd3ZjRjkydUM4cmtJQU9YMDZud0JpVjdzOFdkQ1Bs?=
 =?utf-8?B?SFZtWjU1UkxBSlltZEJQa3QyTVhreEhUSlk5Vy9hdFV3dTUwbHB5bGsySkhB?=
 =?utf-8?B?QlFsdkwxUWplalJicTRBM29KRnJQamkwV3ltVUtwUURDWkc0dEJPN3J5RExM?=
 =?utf-8?B?VG5RaVlkZHZ2VlJJSExTQ0dOc0V3UFRzY0VhcHI4YlNHSjRBNGdPTStmM0FL?=
 =?utf-8?B?Znp0ajJIemZjQ1RvdXlOY2FzQVBqUTNVSTV6dnhhTktRdGh1dTNqUHFCMml3?=
 =?utf-8?B?akhwNTVUUTJpMVArTHVxUnA3Rnh3MmJNRlFSMUJ3dFd4N2JVU0x0OVNrUUpX?=
 =?utf-8?B?VFpBWDhBcXo3UVdiMUFhUGdsQ2JLUUpONUNBVHZvNGVmVnNjbUtzM0ZweHFQ?=
 =?utf-8?B?QUhJR1hOU0FQNnN6TVhkMnNGcVkyOTJJRmo3MHJjOEc1WU04cEtNSXIxWGZh?=
 =?utf-8?B?a2gwc2JOWGZuSHJsUWlDUjJnTGJTMVl4elR4TjdhOExCWHpPMWxZdjgwYUll?=
 =?utf-8?B?dGlNL1dvR0RVbmwxaWtES2hVYnIwRHBqUlU5SzEva2l1Z21DNXFiNURkb1Iv?=
 =?utf-8?B?MlJhclhhTW1vWWJKZHduYlgxaEp6VWxmQWxwQmZpeUd4UWZveHpJWHFOanJx?=
 =?utf-8?B?R3ZXWHFKQWV1bEZ3ZytHTWZML3lqaVV4TGYxQmRTNU0zdFZlR0tQdlEvU0s2?=
 =?utf-8?B?cVFkRFBvZ0cvU054dXA5bUxNUytqT01xcElHVk0yNHlhczJJcUlYUEdPRW11?=
 =?utf-8?B?em4xdlp5Vi9ESmFtbmZzRXRyNHI1MUxDdWhBUWNWQXAzTzlYZHg3SXMwb0NL?=
 =?utf-8?B?ajVVaEViVkpXdmR2bDNpMmtGRVFpWTRoZHYySEg0QVZudXJoRXA5L3BKMFZy?=
 =?utf-8?B?bHA2TDFNUXYyQUFWVEdPbDJPN3h2WUNydHJqenRrdnpDTW5HNjgwRFRpSXVw?=
 =?utf-8?B?OHlqZDN3aXVOYVNlbEN3cXkyWEZzazZESVhaWFlRbVJiemJ6blNnaWNURTV4?=
 =?utf-8?B?djN3R0F5RG9qdlpJd0kydS9CMXRqajg4Y0xXc0F2YmFPZTlJZnZFRE1tV0tr?=
 =?utf-8?B?dytXUWhkSE5Tb3pRV2grUFZSdWZ5NVQvUytoSEU0SzFGL1BsTXlIaDg4MUQ3?=
 =?utf-8?B?OG5QekFPTmkxYXplQ1R6T2g1aExmMWhOVjM4eDVGcFlnY3BWamM2NWJJUHpV?=
 =?utf-8?B?N1d2VFYxbmw1K083WGJ0WWtCdlBRaVV3ZVhVdXVwd3JZWTgzT3Fac3VqVGpC?=
 =?utf-8?B?V0ZqRGxyWURsaVhCY0lmdFhFdE95MzZNNEoxazFjWVdiR1Jnc1dhdEpFaUZN?=
 =?utf-8?B?TlYrWmcwL09DSDlQcUpVZzJVNjlLMGlFU3o0TFc5VHdabDliZndudjBWUnl4?=
 =?utf-8?B?WVlPa21IbFdETWl5WE9yMEw2bWswdHQ1SE9xVkpaSkgzZWpEWE9ibDZ1ci9P?=
 =?utf-8?B?VTBtSlRKaElrUDRncjBIZmo0aElraFI3V2ZHR3lEdVI0dk9CeWd1M0d4TWdv?=
 =?utf-8?B?Z2dxc1J5a3p3Zi9RTUtLR01Cc3h0bWphakVHbThOZXBzbTUzVVpwTnMyZEdE?=
 =?utf-8?B?ZDhhV0ZXeXVQQlpmSStDbWdvSUFBcmpRSWVsQmZ4ZTFEQWRDSThHanE0ZUZB?=
 =?utf-8?B?bDdKcXhHNlJwaGNRUnV1eEs1U3lZbmd3ZnRFbEhBblpxQ29IMHZ3RmNrNm5O?=
 =?utf-8?B?VDBvMTYrNVhGZHV5V0kxZWtZYXUyN2ZZL2lpMzhybzNlbnU2aWxjM1V0Y0I1?=
 =?utf-8?B?a0hqRmEwaUt1cEZ1M3duV2ovYmRnL252MkxVcEVaQlpBTHpyY0JrNnRaOGx6?=
 =?utf-8?B?SmYwY0N1dU5JNmVJM2RWL3k4S09wL0tvL1ZHazNjaFJWVThBa2Y2ZFNEMndk?=
 =?utf-8?B?KzJydGlsOVZMdXB2TWQxbkU2eFMrSWx6TnJWV3lSaUV1bW4rVC9vRGdickVE?=
 =?utf-8?B?WGswU1Y2WnVJT09LS3VxY2xXMkhjWXo5Z0xONUZETlZpbnpHZHR2blNnVXo0?=
 =?utf-8?B?dDZzQzVDMVY0bldJYzZ3RFZpVkp2L2g3UnFRaTRoZHF0YUllcG9KYjJveDJ1?=
 =?utf-8?B?bk94YzBkMXVXNTdrR1FPWmhWbFhmeFJyVVozSVVheEM5NGpKOG9Nalo4QjRw?=
 =?utf-8?B?SGM2SVRPZHdRQ0tCQmlXUFJWcmxocHJGWGVVc09Ib0YwOFpGc2pJMjRTQnRz?=
 =?utf-8?B?d1J2YWlKVlZBKzFwbEQwem91Szh0MGRZUUtMdUdzVCttMlAxTkhXd284QVpL?=
 =?utf-8?B?dklERUxYNjhETUludVYra21Pa1ZVaFNYU1FQRk9XaEFmbVhlMDNQcGNnSmU4?=
 =?utf-8?Q?MICErT4xnGujrpwE=3D?=
X-Exchange-RoutingPolicyChecked: BhqZMiNua0wmzda+pftFk3ZUARrhOfm9J5Jm64EjIOElqY6Xe53krVLwAwtZWTSIQptEcbX0Iu4iASoJQv8yZOI7cfm2qRA8iavibRJ6jKwC5BPrR+gXKg2VKcqnPdlb5THn3b+6EqTH3otf2VXBcGp18YAP/DJTcfHDWftVE8w3t+omagSN0XmE7/UymIUsEI7cFmDjjF3CZe/X8R3RMS9CQdhBlY3W4W1LpNjWWjhygQuOBMOffm+5ubqAvYt/fHIDh/QNcWcnhZb5HwxZgkQGlDSg+AjpxY2VAtKdRGnwK+NOmqctWX8BMF390wmKBrb3ZiHbVBIw+q8Enf5V+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e93ee1-9237-4d09-d35c-08de81698e05
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 01:32:29.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yIV/qDdYAceYG8aXYNuNW4nLFQVegvk1TBbwWlc/OlWkvEuwi8s2J5JdygM9cL6EoW74iwtiP/lHGZw1HnlM+m7GZzO7FqJhbpcdtI0/Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6380
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Fri, Mar 13, 2026 at 12:56:07PM -0700, Dan Williams wrote:
> > > 0 Blocked and disabled
> > >   The device cannot attack the system, enforced by the OS not loading a
> > >   driver or mapping the MMIO and IOMMU fully blocking everything from it.
> > 
> > In terms of details I am trying to think through whether the device
> > actually changes its ->trust level in reaction to a driver attaching, or
> > whether the block and disabled state is implicit in not being driver
> > bound.
> 
> I am thinking of it as an independent property. When the device is
> first discovered it gets a level by default, userspace can change the
> level but only when not bound. The level restricts what the kernel
> will do with the device, 0 would mean "do not allow a driver to bind"

The problem is that for all the buses that do not currently have a
"device authorization" concept only userspace can decide that a device
should skip bind by default. For that, I propose module autoprobe policy
[1]. Not yet convinced the kernel needs its own per-device "no bind"
policy.

However, I do think userspace would like to know if the IOMMU subsystem
has blocked device DMA while unbound.

[1]: http://lore.kernel.org/20260303000207.1836586-6-dan.j.williams@intel.com

> > > 1 In use, attacks from a hostile device are possible
> > >   A driver can operate the device and is expected to defend against
> > >   attacks from the device itself. The IOMMU restricts the device to only
> > >   access driver approved data (no ATS, DMA strict only, CC shared
> > >   only, interrupt remapping security, bounce partial DMA mappings, etc)
> > 
> > This is a better way to convey the current "force_swiotlb" settings that
> > TVMs deploy in their arch code.
> 
> SWIOTLB that is needed to make the DMA API work because the device
> cannot reach CC private memory is orthogonal - the TDISP state (or
> lack of) should directly drive that in the DMA API.
> 
> The DMA API just wants a flag in the struct device that says if the
> device can access encrypted memory or only decrypted.

You mean separate "trusted to access private" and "currently enabled to
access private" properties? I am trying to think of a situation where
"dev->trust >= 3" and a flag saying "disable bouncing for encrypted
memory" would ever disagree.

> > I am assuming that each bus implementation may have a different way to
> > get the device to the various trust levels.
> 
> I was actually thinking no, it is just a generic orthogonal driver
> core property.

Property? Agreed. uAPI? Not so sure...

> > For example, the uAPI for PCI TDISP requires associating a device with a
> > TSM and asking the TSM to push the device to trust level 3. 
> 
> The other way, you can't get to level 3 unless the TSM subsystem ACK's
> it. So TSM independently does its bit then userspace can set the level
> to 3.

That bit though has lock-to-run consistency expectations. So if the
kernel does not yet fully trust the device by time the relying party is
satisfied, and the uAPI to transition the device into the TCB (level 3)
is driver-core generic it raises TOCTOU issues in my mind. The
driver-core would need to ask the bus "user now trusts this device, do
you?".

Aneesh and I are currently debating on Discord whether the kernel needs
to protect against guest userspace confusing itself. Part of me says no,
especially with sysfs, if multiple threads are racing "unlock,
update/re-measure, lock, accept", then userspace gets to keep the
pieces.

However, to Aneesh's point we could protect against that with a
transactional uAPI like netlink that can express "trust if and only if
the device has not been relocked before final accept" by passing a
cookie obtained at lock to accept. That would be awkward to coordinate
with driver-core generic uAPI for trust.

> If it sets RUN and 2 that should work and have some kind of meaning,
> just not be super useful.
> 
> > Another bus like thunderbolt may want to imply that "authorized"
> > that uses challenge response (tb_domain_challenge_switch_key)
> > enables trust level 2, but otherwise only enables trust level 1.
> 
> For thunderbolt/hot plug I imagine the kernel would default all
> devices to level 0. Userspace would do its thing, using whatever other
> uAPIs, and then set the level to 1 or 2. Then the driver starts.
> 
> This way nothing is coupled and the kernel can offer all kinds of
> different uAPI for device verification. Userspaces picks the
> appropriate one and acks it with the level change.

Thunderbolt already has authorized uAPI. I expect adding dev->trust
support to thunderbolt is more related to ATS privilege and private
memory privilege.

> > Yes, no mitigations against spoofing the device interface without TDISP.
> > However, I would also assume that level 2 is the ATS-on trust level
> > outside of TDISP cases.
> 
> Yes, level 2 would be the break where the device is required to not do
> wild PCIe packets to maintain kernel integrity.
> 
> > > #2 can happen in bare metal where a OS may activate link encryption
> > > and attest the device, but doesn't have CC private/shared memory.
> > 
> > Bare metal would still need to figure out how to send T=1 MMIO cycles
> > and check with some boot attestation that it can trust its MMIO mappings
> > are indeed targeting the device. So let's say trust level 2 is
> > everything but private MMIO and private DMA.
> 
> bare metal has no T=1 and no "private" at all. It just sets up link
> encryption, excludes a MIM, attests the peer, then opens the iommu.

Ok, we are on the same page as to what a theoretical level 2 would mean.
