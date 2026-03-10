Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CADD34A3C4;
	Tue, 10 Mar 2026 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178800; cv=fail; b=C15s0TpqtTu1oIFpAU2gEBQly+jHIxbcMKgaDtoX/mtgM07brnOvpANiYTGJ4P1N3V0PllkiG+tgjbTFjIFCk1zLPA9Zde+ILwwXbdDN+cxL1dsz9YmjpCEnmm1wJWk6+E7kfWFE/QvpuVKXqobHOb//GCERtq4+gmst7n/B+2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178800; c=relaxed/simple;
	bh=uoLvD/ILqzcHvRUjGwWZIplpjahH0b7fU3qWxToJB2A=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fumcToi7L7OzkkYc5dEKd5vvM09TMmHDYI8a45+0MUEqBKnzQVCBiMpzEXE0u1tNYNofRnOqvlZm0YXP8Y46j54u6YH8xC7lC6OwYxvliVePxtr8SpcZDLjK+hEBv6lZr218TWyRH1MAN6UxYOxr3SRexpyJW+yt0bzBIusyocA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAfpkrTc; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAfpkrTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773178798; x=1804714798;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=uoLvD/ILqzcHvRUjGwWZIplpjahH0b7fU3qWxToJB2A=;
  b=oAfpkrTceEAXHbn4QJblaWqsUne87yaDgsZNmfWYruVQBpO86Di5gmw1
   yWX0b2pNR+yfoA45Z8wOy/eAgFDQqGar9G9IMgqjPNysKCj/fFUWYKwMt
   dsgLG05JwlGbyWs3Oi+7Sbaq2HeLhw7Ovg9SR30ktO3mmXoYTxlCv+TVT
   3olrvxoYnGCtvERjl8/x3bN27oK/AKrznMAEs6EmHQ1shbzeS4hJ0hNc9
   weZgdwj/NFhxkB5zLKSz/p87TTPZoTSJ9cWCh3oyNXPgvQSMiL+SKqzT8
   Uu/apemyuHYXfw+FAFUSn/p8oyA0gfAYMSRgytY/zAlwvq6ugc+hSjjSR
   A==;
X-CSE-ConnectionGUID: tbyQR7MzTLOyK0VW/LSJnw==
X-CSE-MsgGUID: 12CLzmb6S3y+wzPQZBrIGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74281682"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74281682"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:39:31 -0700
X-CSE-ConnectionGUID: 9/n3flw2QhSvDuiY9n1y6Q==
X-CSE-MsgGUID: 1A4mNYIMRayvX7gdLr0jvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216575559"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:39:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:39:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 14:39:29 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:39:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYDEYvPvrgWw3fRZtYF/+xZjGSQWgfTmhe2BLdYCCCuloV/ItcHJkuUGA7F+EySvgdkphHyQ1nYGDlWf6qirV6zPDBCzHWWbUEG7Fx4JIdX2nT4O50FvzP3N9tDuj68fblv318eMvMQi7/uilaRxCyyutXFbQLVTKJBdt+V02mWqrDUEQu6r00YyB+e3p+BosV9rR902x3YQ3W3iJhhBKw55MQD89rpRyRjIRmGiwNIXdZJ038g4LFC6zUIgQSTtWHVgYWVlYS+QptohU/3ZcMT9VbYXra01HsB68JBVmQsTANCv7Y5JtgMYMujldmXJlNXGZc7+zDRZAojO0WSoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiGW42DMO/g60T08if5TQsPXoOdWWma5M9T2hMFX5Tg=;
 b=Ydzz+mJXWA8tSEH5NFDKT/8zy/vv6pmYk3tnQB6de+L0E7UvOmzmj9p+a2Y5tuy4KdfKHBmdjO2dYgwUyiDP85+Tc0+pn6sAE3SfkFL0/sBadyjxgRtLYLNmCLB6+HCIv2sic9chITWJM4zSLW3NQABmYkP9EVapZPH7QqFjs0WCLb0yPqN0DoWm6HwfzmGp+qnWz6MdingRSuxmGbG06YGoQLrb2s3JIDYUg3jQMFMkA52VP4dyZjvdU0cy5c+/972BMajdIyeZy3AaZFXd6KpxfIgV9+7ETbbvQKwe43XmGZldqXzX4gzWx5b6mcZy3LtG/yB9zKHnf9aUaW+Biw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8812.namprd11.prod.outlook.com (2603:10b6:806:469::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 21:39:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 21:39:26 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 14:39:25 -0700
To: <smadhavan@nvidia.com>, <bhelgaas@google.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Message-ID: <69b08f8d8eb97_490a10042@dwillia2-mobl4.notmuch>
In-Reply-To: <20260306080026.116789-1-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de03d3d-04dd-438a-9bcd-08de7eed80a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3maFMaJz2k5z/iE9XlsQEFQ+OxPMRI0KMzqbhUbAOiCX5/4EJ8uqCDsydnCCJIng6sTjgz51J/GZScOLz9cJgMFCrkwrHzwG9eMGk0GUUAEih4AF6xQGuuNIFDoQ4NqxKiDVVNoZ171WcSFqr873juzRvbQ0QF3Gahn5ihz+0PT02UqSHNab6lVTng4gVQW8r04vuz5ijmyreyXgZVtBuHJrofy4kyikNesaLivoL5yq9TwAm0yzKuCsOYAMAbSpW2ZfYr5ERc7jbpjgBaNaO7Omdjs37PY2n5vBANgvPSfu4sVO85u4/h0lsoYZlQuW1t7vFOnQBN1Ki5AiG4/K6N2WvC8fgft3krOFCUuG/VchhpjCkbMiS3qAVv41V+v+IRQkSYepYuYqByL3wsZMSVsxgIE+a9Zr4xhVhT1I7zCBbvljqYaBIzoTdO0VxJYlFvFg7LZEaYC8kXOjMP8caCZEzbDezvUCrEvxcbPbK8ohtbCVkTnMFbiPn7OcRaL1w7C8JQsy/GZASfRh5n2uuDiRN/+D0MhAlzYvQbQZe0Vho7FJLC5dtGKQlVssUe2YXc3hcdjBKaqhiKlHvgI5Ljz3x/kRZnnGDlmKdqXG4qgIMPeWgQB7TcdKomH3O8O3BGQ1zrTq/x5/s82ZDNje39b2IEwUMFGLACkMxGpdJhx/HaQOIe7tgpJ0wAAGWBA9ZSg7wd5HY5+oW0r4c4sN083DPUespck0i3PmLM9/Oeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC8xT1dVMEE3OVltR2YrTG1jOWoraTkxOTZnNGhXcThGQnJPMll6bUpzL1lk?=
 =?utf-8?B?dDd4ZGU1MGkzWVJZWlhLVUk1em5oQ1pnZzZwRVJGc3dOMnhOMmp5NklybC85?=
 =?utf-8?B?Ym1CV29WZ2doSlNlVUNkYk1EQ2M2ckNiSGxrYUpCN3VwNEJQSktnemp5a2Ni?=
 =?utf-8?B?b201bUYyTnRyQjZUOXR1eEFZbzFoUWUvbkZqSk9uVGdKN01MQTN0d2lEYUZo?=
 =?utf-8?B?akd2Z21MMlJIQ1hDMXdyajZWc1JWZjM0M20rMXBGRUljbGNGYlY5R1hqNXlV?=
 =?utf-8?B?d1BsZFk4c1lnNGlJRFF4c1Qrd21QUU5uQUZURkkvU3ltUy9DcDdaWk9sWTBK?=
 =?utf-8?B?L0VvVmVTUkVERmdiTU8xSkFCODc2SUk3V2hMVzNBUTFoZ09JbkZpaHZiKzVy?=
 =?utf-8?B?N0tmODBDV25nMUZKeUN0RDBrL1o2dDlZdlRoK29RUGpMdmdNZE9JV1UxNUVp?=
 =?utf-8?B?clVsN0lWUTI0RmFyU3lrMHV2dS9ObjZkRGtRWEQ3bEh4bGREalN5NEhxVE1r?=
 =?utf-8?B?OU5lK0hYZzhJOW1SWVNLSGxMb1F1UWhGbElTWVJQbEZ2ODJmSUhkK1pDUGli?=
 =?utf-8?B?WjAxcGlpeTZTNGR2eU95a0hLcEtXdTJlNnN0NlZnR0wwbVlZQ3lqRkg0OGZr?=
 =?utf-8?B?UnJybEJ1dTYvQ1Q5N1dmUGFQUlpxTDdpS003NjdGOG5wTUE0NlNrVER1WlFH?=
 =?utf-8?B?UG1qSUZsSG5DckM5cnFwRUloUGcrSDdsV0UyRytCMXBtVkZaQUN6TXR5WEh1?=
 =?utf-8?B?S3ptTk9lNFVsSEFzV0wzL3grQzNsekFlYnJUWllCRUR0WmtCSkJLVTlaUCtJ?=
 =?utf-8?B?ZWFHQTBZNDcvdnh2aWQ0UUY3dS9IU3Uxc21pNi9xWSswbXRBZjZnNW9LMDlz?=
 =?utf-8?B?TlRnWUZGT1RWc2pDVzFsSXdqUzlwc0JmMFFlbkNrTTRvTU15UUFPbVRSVFdI?=
 =?utf-8?B?TjhVbSs5SzdjMi9pT1dZUys5c09GdGFveW1iM2xwSnlUbTlGcXFBMW5Cc1hW?=
 =?utf-8?B?eG1aRzExYzBVdHRGU0hrWU4rbTlVcGd5WUlUOWIyd1VKampNODJtdTBFeUVJ?=
 =?utf-8?B?RFNEcitVWnRXMnRBcnhYWGxlM2NUd2MwczEzdUFrVmFJeFdmTnA0aytzZlBC?=
 =?utf-8?B?THBxSHpkMnFBaUhQWlhMcEhUc3pvT1B0SUlLTXkwdmx3bEdkdStyUzFRVC9n?=
 =?utf-8?B?YXVseGQzRG5ETnNLYldmMkVrNWNaN0dKS3VyeDNpWlFhNXZsM0Q1eVc2L2pQ?=
 =?utf-8?B?eGpuWGJxOER4RVV1a2dBMFNnVFh5TGkzQ2NFWjdCUitaby90UWVqcjJkOUpt?=
 =?utf-8?B?WWQ0bUtSSlFkZUpiWnR6aG91Y1RIV3RkOVNEVWN3QXNwMTdLdk5TTUhCMEZq?=
 =?utf-8?B?dDlHRXhtRWFLMTA2SXcxeGxhZjVmeFh5Q3hDREc3OExsMEJPSGZCeE9lQmxW?=
 =?utf-8?B?QTVMU3ExREhIMVlyOXV3NkY2cEZ5Y2Y3ZnhJYUQvUjJabGlEckwwVmxqVjNR?=
 =?utf-8?B?KzkxVlp5aVc2Q29Oa3Yxc3JyTU5jZWtPRCtuOVh6K1d2UXlRVVhEbkUwNVZy?=
 =?utf-8?B?RmVMUHIzODRaRVE3VG9DRGh6VnlHMG9jeXUraDdvMi9lTzl5cERpeVpxYjZv?=
 =?utf-8?B?a2dQb1ZpTGZEVDd0TVJENStGZ1JRK2szSWVQcDQ5TStiYmNVcENVc1lwcjFy?=
 =?utf-8?B?Q2FxZGVoanhTckdnblFKVUhjTks2S2tqclpsSXlVSk00dUJ1bGZzMmZ4bVBt?=
 =?utf-8?B?MXZmOTdXUkFmeWVhUUZvSFpLTXRhbHM2UTlVeU1Icm0vZkM4VkU5YityM2lJ?=
 =?utf-8?B?Rk5MKzZTUDRWYWVKTzFYaFZTdzFuUTJkT1Z6RW02Vzh5bEFzaFVuL2dnQ292?=
 =?utf-8?B?elQ3VGgvSzgzdDhuZ2ozTlBvQ0dnd3ZwNVEzci9DdjRUVVlpUkl4YVY1YzZr?=
 =?utf-8?B?VE5xQU5yazBpNEVLWW16NDFPSlQ0SW4rTHR0THlQQkg4VXJBTndSZlB4R3hq?=
 =?utf-8?B?ZFJYZUxpem9NZ2NrV240L0V0dHNyMlpjblBYUzVrRG1mS2o0UXNOdUxtREY5?=
 =?utf-8?B?cWowMm9BRlg1TENKcVI2VGY1ZW1SYytZL3FNdEtXL1NDSUJubk85NGZvdUtR?=
 =?utf-8?B?WnZ2Z3lVOXo0VjF1dWNzQXBjSDZDakYrdWs5UzBVdm50aXowbW5oVm5KVVhZ?=
 =?utf-8?B?cmNxd01SdWZyN3pjZi9icG1EQ0FpeVFqUiszUnFYT0Fad1VuR1VRQ0I3QlMz?=
 =?utf-8?B?YVYzd0ppd29HV2RZVjRNUlNVSEp2SXlqREpYYmtiTWpnMUhQUUpBVUZ0Vk1E?=
 =?utf-8?B?ZTVCOVlzd2dvd2FIVDVQWnRxcG1VVWoyeGJIVC80WUQ3aFJ2QjhrV1hqR2Rq?=
 =?utf-8?Q?22aCMZgFro7CBv/k=3D?=
X-Exchange-RoutingPolicyChecked: VHHRQ0NEzP8Zzc66/JvXqyTxHLiyBlOqMb4l/wZyU2b4cFZOaOE4LidozKz9+4IbSugdgywQ/34AVwHAoPv5IUG25MpYgrqjdE+mQ88K441yEyjCCJHcCigz4dVdJ+yKRNO/bRpkKJWk3uDuF9KzOX+Y89KocuL3dvketVujiXv1nHZG+lr/tj/xB6PxCvY3GzMTXfd0VnWA1Bzc7MKU7MmLZUT03SiPD6GFcDCwUIyl6KRg9vyPLP9prqfjE3/JR8a8oUQGoPQ/K6H20z52UyX/+gS4f2b0BJtExGvLPYVTWTCBqawKrTIhrtSsRwCkOHyuBy8RMn1p4qxdqWhcrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de03d3d-04dd-438a-9bcd-08de7eed80a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 21:39:26.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bJQdH14/Wt+fzJ8JavkB06zVwj6CLTNB0AykgmQ+E3br6nq0fZ5ylp1RVGkKPZ3oxE9satD6onLaT4u+Ctj/JuXBLpZRjsYWZZBS56R160=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8812
X-OriginatorOrg: intel.com

smadhavan@ wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
>=20
> CXL devices could lose their DVSEC configuration and HDM decoder programm=
ing
> after multiple reset methods (whenever link disable/enable). This means a
> device that was fully configured =E2=80=94 with DVSEC control/range regis=
ters set
> and HDM decoders committed =E2=80=94 loses that state after reset. In cas=
es where
> these are programmed by firmware, downstream drivers are unable to re-ini=
tialize
> the device because CXL memory ranges are no longer mapped.
>=20
> This series adds CXL state save/restore logic to the PCI core so
>
> that DVSEC and HDM decoder state is preserved across any PCI reset
> path that calls pci_save_state() / pci_restore_state(), for a CXL capable=
 device.

The PCI core has no business learning CXL core internals.

For example, I have been pushing the CXL port protocol error handling
series to minimally involve the PCI core. Just enough enabling to
forward AER events, but otherwise PCI core stays blissfully unaware of
CXL details. The alternative is maintenance burden to the
PCI core that I expect is best to avoid.

> HDM decoder defines and the cxl_register_map infrastructure are moved fro=
m
> internal CXL driver headers to a new public include/cxl/pci.h, allowing
> drivers/pci/cxl.c to use them.
> This layout aligns with Alejandro Lucero's CXL Type-2 device series [1] t=
o
> minimize conflicts when both land. When he rebases to 7.0-rc2, I can move=
 my
> changes on top of his.

I think we need to evaluate where things stand after both the CXL port
error handling series and the CXL accelerator base series have landed.
Not that they are functionally dependendent on each other, but there is
a review backlog that needs to clear, and those establish the precedent
about where CXL functionality lands between PCI core, CXL core, and CXL
enlightened drivers.

> These patches were previously part of the CXL reset series and have been
> split out [2] to allow independent review and merging. Review feedback on
> the save/restore portions from v4 has been addressed.
>=20
> Tested on a CXL Type-2 device. DVSEC and HDM state is correctly saved
> before reset and restored after, with decoder commit confirmed via the
> COMMITTED status bit. Type-3 device testing is in progress.

It is a memory hot plug event.An accelerator driver can coordinate
quiescing CXL.mem over events like reset, a memory expander driver can
not. The PCI core can not manage memory hot plug.  It is the wrong place
to enable this specific CXL reset because PCI core has no idea about the
suitability of reset at any given point of time.

Now, the secondary bus reset enabling for the CXL did end up with
changes to the PCI core:

53c49b6e6dd2 PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Port=
s

...but only to disambiguate that hardware may be blocking secondary bus
reset by default. However, as the cxl_reset_done() handler shows, there
is zero coordination. One might get lucky and be able to see those
dev_crit() messages before the kernel crashes in the memory expander
case.=
