Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC38353EF6;
	Wed,  4 Feb 2026 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181749; cv=fail; b=drCIkDs2V0/N2ByzVmL6J64cZbXjTl3vigDNkf+p4pO83xRAa+Yfy3p8x9pHUFiSy2cFVEkyAQFx/c0V/RIuzvwmuctrvcWTMFJF0JxA6byimjTX58rQbZ76m3txmhVVdMQ8O9ghIr9K4xhtvDZ7rJc2AtyXyias1mqFDS1e3aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181749; c=relaxed/simple;
	bh=LdKJ0lFe8DTyRDiekBzVzaq/NH9UQEQGUX/Jrx/QU0o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=SwQUGkNFZ85pmMgsNdIf6yRhiIfUs0QGyKhNj5KRvCuAhQbV/Mhdd7hdN+2LkuF+a3vYGHSSn7rvaMdM87kkrOUyZ3I0U8F1U9IWcT1FbOdwiXGjdykXGPcK9MAzMSYgC5Krqn1F3FsrEGsRfWIGlSd/V9lfc0/Ik76FEO+W2tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIJVPH2F; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIJVPH2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770181748; x=1801717748;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=LdKJ0lFe8DTyRDiekBzVzaq/NH9UQEQGUX/Jrx/QU0o=;
  b=MIJVPH2FP2cmiaXvuCnFMugI7cfZeexvgDh3h6A3BYjZXcSeOb38novM
   zIR8G1Q5sWYjQE1R++8xMCEl5u7NeKwP+xeAzBMdmBlbdZaUwiltVVKy0
   /g8rCDxWc+Ri1ZRF94k2z7AqeY1ivL9S9Kw+/2Uhppx4SciB2gIp9yjl1
   cs8gytIeveiCiRNY0tBYIjut7o9Q3ryu5TuxtYuF/GGQ2/evzGff1Qysm
   Ejy2Nff0IwKukzPBpy8aliYnopdvyC96v9VLXkhbApEYYAx6bOX415Q/q
   xpMw/5dC+G29fEOyoXICxNpKnmsRtN2jymHa7vQ5OnLpStxTaAWpjPbrH
   Q==;
X-CSE-ConnectionGUID: PR3qBtIkR/i+hU+ddyxYMQ==
X-CSE-MsgGUID: Fq26vypjTkOwg/O+n5rtxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="73964779"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="73964779"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:09:07 -0800
X-CSE-ConnectionGUID: 3+ao/gSJR7e7mSPax2ssKA==
X-CSE-MsgGUID: azINCx0YT6uK0zs0rH6o8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="232981607"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:09:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:09:06 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 21:09:06 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:09:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DU0trZRnyHynHS/lHIE0wzxoQlfLVUkngaq9jybLlCk36h7e4zr0r61lDlSojrQeijVGTc6v8MN6JDmq0nIEDnOGDzn6Kjp0vst5Favr3+KEKBSDsdaNpsbyTTZbSphJdj9ixCOH1aOJi2jzR4DycV/MFxQz+D2+m2219B83SqnCrqWbfqzWvG5154Ea+Pta8qzliQOsq0DJu7HwjzoX5fT7510b5OlJ084JlaUw3W1bEE9pPJxUedYtGrlIRghgrJThRa9tegcEmg/JUysupToyDgfoH0ATjTshQOSMDZqoFgopT+62YjI5AJt58poD5VZ9cvDnL2knJHUf7xgNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epdxG5Kt8KaKw7/x5BZWi2CuGhXcl0NnW3LmzY08/cA=;
 b=ZFL6ajleQ//qfO5y+vpQOyR56HRnvjgcBG3pYpLXIgoAiGmWnsqrsc55985mwt4uQi6L2TxW5SvITjS8afZmzmcuyshcl9Kr0HZCRWXSofafgh22xbyGcIvr8qlQcKVGP/UNPDPWf5S3O6sCj4R42/c8pb3UBTdZhDUjRnOCtGaDbWcaZPHuAFNs+DPZo4o0+YpFKLARd6T/6Kd/yoLfnjV/U3fcfk872D8aLEXNzCRgruf4QIjyZKoz+4njodrY0KgIsVKS2L3ml44Hn0yxpURaT1BnzJJS1TNFbruYykBBqej/s0cEmkCOQFiTdS3Rtm2c233MP39R2iB5JVfScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8269.namprd11.prod.outlook.com (2603:10b6:a03:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 05:08:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 4 Feb 2026
 05:08:58 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 3 Feb 2026 21:08:56 -0800
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
Message-ID: <6982d468e42eb_55fa1002b@dwillia2-mobl4.notmuch>
In-Reply-To: <20260203025244.3093805-6-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-6-terry.bowman@amd.com>
Subject: Re: [PATCH v15 5/9] PCI: Establish common CXL Port protocol error
 flow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a22ff4a-c510-457c-9a21-08de63ab8086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUxabU1IZkorVExRU3dQVytBbzM0aTFhQk5EMjczQ2FZLzVTcXQxSFRTWnpv?=
 =?utf-8?B?WGxVeWNySFVBcnJLOXlpNkVqUlpncS92Y1FhazVZZWNueGFDak9Ha0J2UDRi?=
 =?utf-8?B?cmdZV3VOS2llNHR0SmtUVHZzbXZ4LzlWaXFVcFhwQ0tOTDlBdUFZeHVudElD?=
 =?utf-8?B?emhQY2ZGTFlRUjQ5QUJtSVI5emVHY3Zrd0YvMHRaN1R3b1ZITnQyaVdmZkRP?=
 =?utf-8?B?ZExnNzNsc0tLdjVuTnQ1OFIxU2dDODFWaVVwQVJkNExDTGJRU1gyTDJTdlpz?=
 =?utf-8?B?RUltZm5zeVhtQmlIeENIaWQwU2l2VHBpcmJBRWJTVzVtamRrS0E1U3Z3YkN4?=
 =?utf-8?B?aER5QUdmWVc2dkhBQUhMcEpDVWo3R1RUdWMvWStNUzltZWc4RjdjbzFuMGVY?=
 =?utf-8?B?eWVOaE1qbmlGbEpnSkZmRzd5ODFmdzlPRXhFV2tRcmZ4NFNsK1BRQ28zSytI?=
 =?utf-8?B?clYvamw4OFNwRFdyeGJicHFvTEprb0ZNMVVhUzFKZmRmdzkyRXFCMTM0Sk5T?=
 =?utf-8?B?ZmhXSUIyWFFGUWNDOXM2dkZVSjY3dytwR1BWRjBpcVhCNWhvU0JzZk1xSEJG?=
 =?utf-8?B?d3FBcHlxbDJ3R0FQWWVXVStGM0h5V00xMUxFMDNWKzhEN1lqcUl6Z04yd0N0?=
 =?utf-8?B?S0wvdS9kNCtJSTlkdzFhODBEQ3hmM3UyZ2w2eDd5Q2pBeStuTm9uay9RY2g3?=
 =?utf-8?B?cXFwcW1KRjJlUUJGYmNHc1pFZTlpYURhdjgwQ1pKN0RxREVBam9saWZHUUFW?=
 =?utf-8?B?ZDZIU1JuNXBNN1RhQWY4bWRUdVdlQnRVWFQyQkRxNlpVZ2dlR2Y0LzcyNlJT?=
 =?utf-8?B?V3R3UnJpM3FKOWgwVE9vNXl6UXcxcmJyaHEzTUlGVWh1V3lVT1BXbkQyTURm?=
 =?utf-8?B?Yzc5YjN2OTd0TGVqYjlkelhTUVdsUW45NjllQVo5WDZ4bU5ZZFhZZFd0UHVq?=
 =?utf-8?B?RDMrNk01TUhGcHdWZHc0QlJmZWIxTmM2b1BQYUIwQ0tudnptbWhmcUh1TFpN?=
 =?utf-8?B?SHhIem02OWszOHRYV3I1ekFEODlsSnBVd1ZSc3ZnNlpncU9tek4vbVJQWXdx?=
 =?utf-8?B?MG9YdGdmVGk5Yk1WeUxRSllxekNtREZXb0RsSUJJQ0xpL2ZPMEtRVENRYlNv?=
 =?utf-8?B?bFMzemJibG5MdDFKc2RzZTEwUnloVUttYWdGR3BDVzhnOWM2aVRVZDRSNEk5?=
 =?utf-8?B?Y1Mrd0duNHVpdGxNejR2RnhhbERtOWJOaHBlYmVCVFBvNjFnK3NDUlhHRGIw?=
 =?utf-8?B?ZmJtR0pIbk8zWVV2Qy9Zc3J0czllWXgrdWRMK0FOZ1QxenJKeDFuRXR3enkw?=
 =?utf-8?B?VUhEKytlc0VzT0swUGlBamViN08xMXNjMERjdWZ0N2pnK1RGSXRwYmRrcnNm?=
 =?utf-8?B?dFVFZmlxN3FhR0hST1l6T0pwWjRCOU9lSUFGMHdqSjllTTBjS29ZK0VlVjdR?=
 =?utf-8?B?dE96RjFmK3ZwcHZiVnRVSUowbjRuUEp0cVduWFBVeUx2SjB1bjhQSFpTU1dB?=
 =?utf-8?B?enZMN0lyU3htYS9ZeUJBYXdoMC9aSTBVNTZsVnVYbnlNOEdCTU5mS0dLTWlU?=
 =?utf-8?B?clZZS1VjRXZOclRESnNBUTVBYit0UDRUNGFCK2cxSXJHVG92TlB3WGVML0lZ?=
 =?utf-8?B?alhlbkNkME5IUVBDWnVVaFUzOE9jenNTV3JEK043TXg4ajNjdFdMalgxNjA1?=
 =?utf-8?B?T2JTM2ljbmlhOC83dVFiaURKczdheUYzR3RlN3F6K3NsNjc2bFh1eVZETklx?=
 =?utf-8?B?dUxaUzBEbkFlM2pkbU43eTNCVzhSN0s1bDBkenBtS0ZYVzdReUo1dXFhNWx0?=
 =?utf-8?B?QnhjTzhxcU1JTDJWR1pKSDlJc2VGQ0pKYS92eU15dVVqQWoyOGxDUjAzYk1z?=
 =?utf-8?B?WmU1RDZuSkVVWTVZbkNsZkh6WG1uc3JPQitpcmpvczcxdXVMRzhkZUdXQWxT?=
 =?utf-8?B?K2pod2krODU3dExudmpscE9jVTU4R3BOeW1SR09oclNVQWUrZHhSNTM1cnNK?=
 =?utf-8?B?Qis1QjJxWlNad0RuYkowRVNUQmtLd1RKTVBBM3lpd0dpZmRyZStUYlJzU3Ev?=
 =?utf-8?B?OFcxRGpSTXI1djY3YXdTdmk4dlVHTXFmOFlGQ2JkRWxtcTljMGRQenRiWFB3?=
 =?utf-8?B?ZFJwNnlpamozUTFiM2FuTFVOTEdCUTkrVENzU1NCM0wreGY5Y0FWb1BFS1NL?=
 =?utf-8?B?SXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUYvRWRHeHF0OEEzRHUxelhGTmEyU0hXRUJSdmZUb1N1S2VlbERyY3lSMVc5?=
 =?utf-8?B?eWhzSmNQSUNnS3JQRzNmcXlqS3VoWlhYeTFIOWVMRU9jY1NhbTNoMEhaZWRB?=
 =?utf-8?B?UVhHeUNvdGZEYjdUejRSU3lTQUp0R2FXWUp5eXJaY0VwK0czSml3U1hoVVdy?=
 =?utf-8?B?bnQ1MmYvck5xVVNBaVVLVDJYQng2bHZMYTJhcnpzSkp5em5ZbWpwUFVGTysx?=
 =?utf-8?B?Q1JUZGFMOUpSYkQ4RXliOGd4WU5Hd0VybWdhY0hlSHlSWDRMSW8xSnljT0VZ?=
 =?utf-8?B?NEZ4WGVrYmJQZEsvdmhzWTF0RjF0T3dYV1RCSkp1MjVPSkdlVnZlcnY0VWcz?=
 =?utf-8?B?K2kwMVY5Sm5uT1ZnaVIwK2oySy94eTN1Y0lYRllnZlR2dVY4N25VMkRtZjY0?=
 =?utf-8?B?YWdvUEF6bHNkSkxsSnhheXpaQkJ2Y2g3c1dlZGsvZkZrWU9iaXZUdXBqTnlN?=
 =?utf-8?B?U3h2a0NYeTJYS2k1SWs0WnZnWFltZnVIYVdxZDFHL0ZxZUR4Tk5BRTdEOUNM?=
 =?utf-8?B?SjhSMmR0V2p1aDNwYmRmL3paTFFRVk9tbEtIa2FRbjg3NFlEMEhlQ25hVmRC?=
 =?utf-8?B?Um5zN0FHZ2tPMjdIWjZtR1lHclNIS0xaYlZtTUpnTThOd041ZERydGVGQjJS?=
 =?utf-8?B?c3dLaUFtMlBJV2FCUXFaQkJla2pPUkxpbTVWZ2Q1M2orbW9ZQm5vN2ZCaTVx?=
 =?utf-8?B?aEpMRk1hb1h6cEFPam93cS9rcWd6ZmpUUVRwaEZZQUFFbVpPaFQ0dTc2VUV4?=
 =?utf-8?B?TU5ZQWhFbkpyYmhOV0QvOGZzSVJ6S1VLQlNQK3ZzY2oxdzRxUko1L2ZrdVVU?=
 =?utf-8?B?SEFOVjIwRFRLc3ZUZDc3VEFoaDVodDFmbGpRNUk1R1d0WVlLV3ZGdHJEWXQy?=
 =?utf-8?B?MVVsdWwrZk9NRVZZOURDV0tQczlaOGsycjhLUXkrSStRa3phdVo1eEtlUEhM?=
 =?utf-8?B?b0JjNVprZ2dTdncyajlFVk44dVR6Y2hNUWx5aUlqRGQ3ZTl6TFY4TUVDaU55?=
 =?utf-8?B?bExZczcrZW5nTGhCRVRSWVB1WUJueVZFQldvMEg5dDV1R2J2dm4vb2Z2akk1?=
 =?utf-8?B?dXpadVp3bC9zZHAxWUtGYTh0OUplQWVWdUZsb3QrK1Z3MXFTRG52LzJlZmlv?=
 =?utf-8?B?cDBZOG5tUHV2YlhZNk9xZ3FmbWRwU1lyZ1dGMkVHZmtyZWM5MEZoODBGRE1W?=
 =?utf-8?B?Vkx5NGpBdmV1bU1xSHFYUGZ5VHBHYVZWYzVRZ3B3Mzc0ZDRFUWtOcmU0TTFl?=
 =?utf-8?B?RkpHSkJIUHJvaElsMGtmMHdleDhWYVNNTTFubWJVNnlSL1ZmQVh0Vyt5aFdO?=
 =?utf-8?B?R2lzU0JYSjJsNzVnTjc0aVNHM0RVeDJVS0hzc1R4eTdJcEpzbkZ3WFcxbktX?=
 =?utf-8?B?aVhkN1NadmhudERvSWdzUmEwWE5LSTJxQm96OE9kczlJRVBzQy9yK3NCNFlU?=
 =?utf-8?B?aW5RVkNhVjVSUjkzSWpNamRYNnZDTjJkYWlCSUkyZDNoNGVoQStXakVTZUw1?=
 =?utf-8?B?QzExTmpvMHdmWFV0NzZLVWdFVVlWbm5KdHFZeEZEem4xbW5lQUlKQjBEQW5I?=
 =?utf-8?B?Mks3dzN5bW9WNGhSN1VOeEl0ZzJEN05RSDlIZVJHVDVCU2xScUxBdytudTNU?=
 =?utf-8?B?ODdIcUtTbjdROTFQUWF3ejFobHRmNkVGN3NqK0Z3ZWViMWExTGpoUHQ2aWZP?=
 =?utf-8?B?YS9hN1MzbThsY1U1WW04U0FUZFBiL0xxOCtmd0N6NHZKMEt1NGhadGZpZUFl?=
 =?utf-8?B?NDFleis4T0Z0YXJXK2Y5UkxZMEErU2J1RkZtL2c3ZjkwL2Q5QU8ycmZjMmh6?=
 =?utf-8?B?cldlOE9RTzFoZ1ZKYlRuVjNxaWp2NmJGd3k3b0o2QXp0eU95eWQ3d25wRWo3?=
 =?utf-8?B?MWdSN25hVXVFMkQ2RGxOR3diR2VtdWRQc3pnZldOZTBkRkRNWTdhODdFQmp3?=
 =?utf-8?B?cGNTNUs2MkVLSlR6UFdwaDNXRkZGTy9vRHN1RmtUTjFtSyt1NlJqN25aSG14?=
 =?utf-8?B?alBFeitJaDBJRDQrRm53RFhteG5EZCtqVk44bmk4UUxSc09xVWhWZjhSQzFi?=
 =?utf-8?B?cDBKaGV3QWs0SG5GVEwrSTR0WkdjNHp5a3ZCWHdDc2d4K09vL1BOV1dlYW9z?=
 =?utf-8?B?OG1IU3Y4NnpPaWRpTHJjNjZWYVBZZGU1c3lLS21kdjFBbzhVSmMzZUM2QmxU?=
 =?utf-8?B?OHB2Q1Mrc29oTG9IeVJTWm9tRFNIcmtmWVg4REFHVXVQU1JKemg3YXpKYkU5?=
 =?utf-8?B?eXdQb2lwaCsybUx3TnBkNkJGbDl1L1h5WmdTeHplNEc3Q1Y4clB0TGpmNkFE?=
 =?utf-8?B?QWhTOVZkTWpPbVVCbXpQbTFZdlFWekJDTmdWdmE5enhyN0pVYUJCZ2M1UVhj?=
 =?utf-8?Q?g2U2JgwaVBx5dBBY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a22ff4a-c510-457c-9a21-08de63ab8086
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 05:08:58.1902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iU1YYoeJ3UsoxYaGsDIi/7hk0ISgl5FmITKn94kN1yAhIRdNWRdmoISGwoD0cicj7YRM3SgGaffMNMXgZm9kdI51Kcqm+/ghFkRrCsxrZn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8269
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Introduce CXL Port protocol error handling callbacks to unify detection,
> logging, and recovery across CXL Ports and Endpoints, including RCH
> downstream ports. Establish a consistent flow for correctable and
> uncorrectable CXL protocol errors.
> 
> Provide the solution by adding cxl_port_cor_error_detected() and
> cxl_port_error_detected() to handle correctable and uncorrectable handling
> through CXL RAS helpers, coordinating uncorrectable recovery in
> cxl_do_recovery(), and panicking when the handler returns PCI_ERS_RESULT_PANIC
> to preserve fatal cachemem behavior. Gate endpoint handling on the endpoint
> driver being bound to avoid processing errors on disabled devices.
> 
> Centralize the RAS base lookup in cxl_get_ras_base(), selecting the
> downstream-port dport->regs.ras for Root/Downstream Ports and port->regs.ras
> for Upstream Ports/Endpoints.
> 
> Export pcie_clear_device_status() and pci_aer_clear_fatal_status() to enable
> cxl_core to clear PCIe/AER state in these flows.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Dave Jiang dave.jiang@intel.com
> 
> ---
> 
> Changes in v14->v15:
> - Update commit message and title. Added Bjorn's ack.
> - Move CE and UCE handling logic here
> 
> Changes in v13->v14:
> - Add Dave Jiang's review-by
> - Update commit message & headline (Bjorn)
> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>   one line (Jonathan)
> - Remove cxl_walk_port() (Dan)
> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>   sufficient (Dan)
> - Remove device_lock_if()
> - Combined CE and UCE here (Terry)
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/ras.c | 134 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c      |   1 +
>  drivers/pci/pci.h      |   2 -
>  drivers/pci/pcie/aer.c |   1 +
>  include/linux/aer.h    |   2 +
>  include/linux/pci.h    |   2 +
>  6 files changed, 140 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index a6c0bc6d7203..0216dafa6118 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -218,6 +218,68 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
>  	return NULL;
>  }
>  
> +static void __iomem *cxl_get_ras_base(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{

Nit, clang-format puts that { on the same line because coding style says
only functions get newlines for open brackets.

> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return dport->regs.ras;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port->regs.ras;
> +	}
> +	}
> +	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
> +static pci_ers_result_t cxl_port_error_detected(struct device *dev);
> +
> +static void cxl_do_recovery(struct pci_dev *pdev)
> +{
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +	pci_ers_result_t status;
> +
> +	if (!port) {
> +		pci_err(pdev, "Failed to find the CXL device\n");
> +		return;
> +	}
> +
> +	status = cxl_port_error_detected(&pdev->dev);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */

This comment feels more appropriate as documentation for
pcie_aer_is_native(). CXL is just using for the same purpose as all the
other callers. You can maybe reference "See pcie_aer_is_native() for
expecations on clearing errors", but I otherwise would not expect CXL to
carry its own paragraph.

> +	if (pcie_aer_is_native(pdev)) {
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
> +}
> +
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -288,6 +350,60 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	return true;
>  }
>  
> +static void cxl_port_cor_error_detected(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +		guard(device)(&cxlmd->dev);
> +
> +		if (!dev->driver) {
> +			dev_warn(&pdev->dev,
> +				 "%s: memdev disabled, abort error handling\n",
> +				 dev_name(dev));
> +			return;
> +		}
> +
> +		if (cxlds->rcd)
> +			cxl_handle_rdport_errors(cxlds);

Isn't this dead code? Only VH topologies will ever get a forwarded CXL
error, right? I realize it gets deleted in a future patch, but then why
leave dead code in the git history?

> +
> +		cxl_handle_cor_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
> +	} else {
> +		cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));
> +	}
> +}
> +
> +static pci_ers_result_t cxl_port_error_detected(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +		guard(device)(&cxlmd->dev);
> +
> +		if (!dev->driver) {
> +			dev_warn(&pdev->dev,
> +				 "%s: memdev disabled, abort error handling\n",
> +				 dev_name(dev));
> +			return PCI_ERS_RESULT_NONE;
> +		}
> +
> +		if (cxlds->rcd)
> +			cxl_handle_rdport_errors(cxlds);
> +
> +		return cxl_handle_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
> +	} else {
> +		return cxl_handle_ras(dev, 0, cxl_get_ras_base(dev));
> +	}
> +}
> +
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> @@ -363,6 +479,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>  
>  static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>  {
> +	struct pci_dev *pdev = err_info->pdev;
> +
> +	if (err_info->severity == AER_CORRECTABLE) {
> +
> +		if (!pcie_aer_is_native(pdev))
> +			return;
> +
> +		if (pdev->aer_cap)
> +			pci_clear_and_set_config_dword(pdev,
> +						       pdev->aer_cap + PCI_ERR_COR_STATUS,
> +						       0, PCI_ERR_COR_INTERNAL);
> +
> +		cxl_port_cor_error_detected(&pdev->dev);
> +
> +		pcie_clear_device_status(pdev);
> +	} else {
> +		cxl_do_recovery(pdev);
> +	}
>  }
>  
>  static void cxl_proto_err_work_fn(struct work_struct *work)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..b7bfefdaf990 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2248,6 +2248,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> +EXPORT_SYMBOL_GPL(pcie_clear_device_status);

No reason to open up this symbol to the world. Only cxl_core.ko needs
this exported, and hopefully we never see another bus that abuses PCI
like CXL does ever again.

[..]
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 7af10a74da34..4fc9de4c78f8 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -298,6 +298,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);

ditto, too wide of an export.
