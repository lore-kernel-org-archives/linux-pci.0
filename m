Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C21B30DD1A;
	Fri, 23 Jan 2026 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130432; cv=fail; b=myTOQm4DW3Fb9+A1FMoLrBnWh+npMBInIqeyZ1UNAZtmGIo/g8n8oAq8qT67kMtVfWHlAQYYcW8a5HypGvTxaNJrHunx3AvHJOaGsAezU1FRyy2WpIDZvbq/DqtsK1cUIpTrGjI1XeindSqAh/uwfrt04Z/pCv+dzYJvUJC2eV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130432; c=relaxed/simple;
	bh=+/Ws7XV9UnCUGvO7r0hfrS5md9SeN0fXt5RuGeK+bYM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=lSFRnQcvfKSDw9XHjnM4jDmFmpRAEqcXII/bJnT/m+hfK6r+efbU7oiuoi9k6bOpzdg6Mm52GT16PUXaCMdR1I0Ue8ibZ/ydaM2cDE7m5/Q4isei/f67Wvwn/CyVp0+nrs588R3k2tp4R/0qUqSx8r89mCTR6CEva11++qXeHqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKGdIGhf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKGdIGhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769130429; x=1800666429;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=+/Ws7XV9UnCUGvO7r0hfrS5md9SeN0fXt5RuGeK+bYM=;
  b=JKGdIGhfrjM2TddMFOZOksUPidH8l8i+L2MMb/1JiH/VihRAdyTZtoi+
   KX0X5xG3jZAsatBdFZl9zKCnYjwcrFAR4bAfPNqGXuuyWVGyn5tawOoAm
   yIh6XwSdHlA7atcbJ40JwGIMIfeRCi4HP0IXPnCdxyCQIG0epoJ8MqysP
   MsxEp4iczU3bUwNgdpOpTLgEc9VgOjWMi+HJilQVgiVXN9rbHYuV7hAVi
   MfPVVe+A53Q4jSNwR6UCmx6+8v7BsTqAA+EaISXBsYSCLxPo7cJ2H7Bop
   aBVVGQRK1hnMeOOoH4SD9cLXezxKryt52U1navjqs7INk11Rn5BJ4YWSm
   A==;
X-CSE-ConnectionGUID: GI6J3UpGRK+kZ5KADwsfmQ==
X-CSE-MsgGUID: 5gFvRjINTmOKQUJMTL+doQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81823624"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="81823624"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:07:08 -0800
X-CSE-ConnectionGUID: f9eJxsVTTR++dwbMxI0SvQ==
X-CSE-MsgGUID: G9+REIHvTb2En1HdY+xK6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="206787809"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:07:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:07:06 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 17:07:06 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:07:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGLj1+mHGKkY2DPabJFJtpeVsSZi/2E8eENseJAdlqaYOx9j+Q/YIPiF6MlGMQ7hsLOEF0/MdxQ69Oa3wP9Jf/EbvgF15PB17yQ+xDTiDNw9GlSpisCS9pdgB8F1kK8SJEXXO7r+FCEys5YleVRuo8QaLFjQ0eHitQccDPsRe2tU29LGwkM504hD0+5uuoIkMMYDBC5bMwGeRxHyIuBV3DkO8EiilZvc8QeYMI/p9eZSIbdlrlG6XuOkfKC/d78Ovxxon+eyhobDF8HbaB0RhZGsez4TumrAc7DTrzQ+sssRfsk7h1FqOJlndZt5FBusyP7SvtPSnW2KJBcAU/p1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRExm0mzFgulvvBnp3G+QXlqwoGP1hRH4oPSOwFfGlM=;
 b=wt4puan0STZkoR+VcJwP4ilFy23FbAX7Z+yFJ4Md587lQO+sRZbVWatX+AoRf49BdeK+2+ZZdP43Ye3gSrjiH8YUUulW4q5pCPvFS//qDBZd7WIirKSCz2Mz0QGD016MfWUKuhXofscvyJxVKFv8qE1BeXnzkYCV3k6Y/BYfCYtHGnKlAJOOgzdp0VnHkOHsrK5VJYnPnDQIQ1rmJTZX4Jj7AE3Ylc3SzPvloZOiSCyFUB8J023dbbE2nr67kfwrE7oVRSo0j5Y9us4bN/BnfPzjEQ+oOZlr1ZbkBxiAXIMNh/ST56BOv5MqPRl1Qi9OKtHaMobLwCo/KVdgo2Zihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 01:07:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 01:07:02 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 17:07:01 -0800
To: <dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>
CC: <yilun.xu@intel.com>, <yilun.xu@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<linux-kernel@vger.kernel.org>, <yi1.lai@intel.com>, <helgaas@kernel.org>
Message-ID: <6972c9b522ef_1d3310053@dwillia2-mobl4.notmuch>
In-Reply-To: <6972c872acbb9_1d3310035@dwillia2-mobl4.notmuch>
References: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
 <6972c872acbb9_1d3310035@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH v2] PCI/IDE: Fix duplicate stream symlink names for TSM
 class devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c93aaaf-171f-4275-c874-08de5a1bb796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ditVYzNHb1RWeVJNL2M5UXJaZWx3dkFDNkpFMUlwZGQzaW9UTlhkNWUvSThU?=
 =?utf-8?B?dkVvbFBkNXZUZnJSMy9EOWFrUDVoY1RjVHFBM1VJQmwrNGI4VEZIT0JqVXhZ?=
 =?utf-8?B?cXpvYTZMaDUzd0paV3gzdUtkZzZwZkswSC9VUVZiSEJTUStkQU9MWW43aThT?=
 =?utf-8?B?WWQ2dlFpQ01mMnlxNW5VTjFkeGtlcm9xREdBb0I3dzFwTU1MdWNzendGLzJD?=
 =?utf-8?B?aGxYQWJoQVZmdUZhYkxHSmtLd2ZlSG9QbU43anIrYWthVXFENUkrSFpTVmh6?=
 =?utf-8?B?UENBYjNBbjd4dERoM0U3cXB6NWlFOEFsVVdmdEhpbGhXOGdVM1BqTXFhc3E4?=
 =?utf-8?B?QlFqWmNQVXoxd3JIOUo2eElOUXVNZzZYc014SGhaMjNLQkcvQW5Xb3dQeUI3?=
 =?utf-8?B?dVdjU0ptdmVaU3dubktraTZERVZtZWY3YllFZW9VZTRYU1hUMDRxK3JKL3hW?=
 =?utf-8?B?OEtpUS9LazQ1cXdiWS9Ebnd0UnAwZVc3UzNrQS9vc0Y0NE1ZYmRKWG4zZUVX?=
 =?utf-8?B?QWkvL0ZPN0VkYzNlRFlPRGEwZ0FJN1JRT2JSWWNaNVJWUlFMY3ZOZnU4VHo2?=
 =?utf-8?B?dlNtdmFSaTN3RXZZT0IxZXVtSGtlcEZKZ0hpdWcvVllicFdpcDgzM1RGNzVG?=
 =?utf-8?B?SExXSnhBZk9uc2dLR1JqZS91NnJBVnJyblczOGRpZk5uVEV1WEpqc2pIV3A1?=
 =?utf-8?B?VGk0ZjRkeEYwWVhWRVprL2ppN0I1alU3cWIxdDZiNm1weVRDVkZFd2F5ODFL?=
 =?utf-8?B?YUs1QUZtbGIyWi9SUFpDMHV5RmxGNVhuWSt6QnIwdHNwTEZQT3pUVFhqblNq?=
 =?utf-8?B?UFJqVmFTajZhZThjTzRGdngwTGhlL2lLK1ZnY0hsRnFSdG8rYWd6L3ppSTYw?=
 =?utf-8?B?SUFJb3JlL3gvSkI4VHBuUVNrYys0S2ExVjhQMVlhcEtPQXBPUSs1MXJmVGpq?=
 =?utf-8?B?cmV4WXhVYUVBNDV4SGY4U1owOG8wR3ZqRjVISmR2bGxJbXVaYzJWaXRHcHFm?=
 =?utf-8?B?MVE2bnFhaFRva0F3U29TbVBIRE1HcEJhYkFadFA1ZHgzZVdpVG5TZjgyaXJl?=
 =?utf-8?B?emRuWWhrU3FlYU1qMzNvTmFoQjNlNlZOUW1JOTFpQ3BHdjFubkRGVE9SWXJ4?=
 =?utf-8?B?cFp2RTVBZ1JpYVltOEx6b3F0d0Jub3l4bks3WFFxVjVnREJNNWxUaER4b29a?=
 =?utf-8?B?bW5IZFJSNFhVNjJWRmFXOWFJaFhzMXdoeEdBUUVmMGYwVnRYVVdGd1pvdUp0?=
 =?utf-8?B?U3JBQ3ZGOW5OK0FaZHQyZkhsMHBxQjJHMEZsd29aTElCWXQ2akJGYTY2TWN3?=
 =?utf-8?B?YzdBeUM3Ym55WEczSERJWUE5T0xKRWhwYithWVg4a2FPUjk2WWFKTVJYcWI1?=
 =?utf-8?B?ZkV1WGJrZ3FYZnZ1alRaYmpQYUczWEUxbGV0UHhTMkV3aGJzSGU1Y0FjQklM?=
 =?utf-8?B?bzUyQWNTUFZ2Z0h4RkE4VXZoMzlMSEdoazRhR2p5dWhidXNVZEVISTM4Ukoy?=
 =?utf-8?B?WmZmd2ZZYmcyeG1RcEg1R01VTlU2RzQ3K2pua0tvWVlYWFcvd0s2ek1RUWZi?=
 =?utf-8?B?bzE2a21zaU1CTW5waC9mM1JyK0pWc0FybVFrSHpmWEx1eUh6a3FTUHoxRVR2?=
 =?utf-8?B?aEdXdkJoTktvV3FzLzF4OGI2dEwyNWtBRzNIalJEZ3g0cTJHb3ByM2VxSEp2?=
 =?utf-8?B?bE9wMitidWIvaDJrNEFvYkVGbXFqVVJBNTUxOTlqeXp3VUQ5Y1JpeGI3SkJq?=
 =?utf-8?B?R3RkSjRxNDlQbWl3b1VOSHNEVE9PY3MyNkUxMlJibmpYb3gvcThRdkp1b3R3?=
 =?utf-8?B?T3hBMjNCNHVseW9ibm5QOCtmVjJLSlBjdmJQdzJBdG0yVWhVUTNkWFg0RDBO?=
 =?utf-8?B?dmJsOUt2ZGN2Tzk5dXJyNng1NGxXR2h2dTBBTUdDZVJaa3FhS3VzdlZpSUhD?=
 =?utf-8?B?dmIxelVMNWp6VXVEYWliSTdENWlPbDdScFM2bldQZVlKS0liMEJqVnppSmpI?=
 =?utf-8?B?OTZIeVlpUEVyeE13bGVLTmdtYVpQZWhhaVNHUHpic3dsVEY0T2ZieHc0OEpp?=
 =?utf-8?B?a2pITlV3UVovcmM1a2RoK254S0IwN3Q2aC9qZWNtNm5DdmVJU1FWZm9vT0dt?=
 =?utf-8?Q?f/H8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2k4dnN6UFBTNGVidmNncjNlNmlRM21JWE1tQmdyVFltS3hmdjV0RDcyelB1?=
 =?utf-8?B?ZHdjNXJvelBhcFNxTGZqY0xrSS9CSXY1dHhaZVFTTkcvRkJlTHFrMzk3TTl3?=
 =?utf-8?B?YSt4RkhrK3Q4Tms0YU5JV01zSmlhYkMzQmdKYWo2eDFrT3g1Z2RpZUVUbDNW?=
 =?utf-8?B?M1hRdER3ZUl5SW4rNWpnZUx2VXpObW5KM3NraFZrcEg1Mk1RTGtXMmpSVk5O?=
 =?utf-8?B?K2UwUzVNbUhSNU9JUDZWVHRKYnUwVloyc3NLaktHaUJCcTNQbkRQME1jRjF2?=
 =?utf-8?B?SUt0QVRJNWM1QndpQ2FZcG1JUUhQRXBqQjMwcStrb2lRd1lXOHRIdnlGYWhu?=
 =?utf-8?B?ODdlMWQwaWVQRzhQYjBMMFprRTFHU1FockhFek5aL2lZVmhHTjF3a1h6OTV3?=
 =?utf-8?B?K1luL1ZVR1M4a2luRytxRzM4MWlzUmN6NUtLeCtjQ2lUVDgzTG9HY2MvRngy?=
 =?utf-8?B?WE5la3gxa2VyRnc3OTJ1TzMzdHp4eTNGa2hMUmNZSzVZM3BwMmJCMCtacURV?=
 =?utf-8?B?OUNwWkZqczEwc2UyQnI4d1MwZnBXMjFLckZWanhTRzFhSkFSWG14elpWVHVj?=
 =?utf-8?B?cS9ZNzZ0UGYyN09zTUVGaHRsMHd4K05CTFpVZ1JIZFBPUG54VjByTWFxWFJK?=
 =?utf-8?B?RW5wUjd1WHVTZGRJUXdINTZEbWpzbGNnN2Q4WXVrNlhBRTVLNWp1YVp1YVdJ?=
 =?utf-8?B?SkZZOXQ0S2VCV0o0ZXM1UkErSkU1WHFXejF0Y2dFeWJZbmlsMEtPSDMyMkk4?=
 =?utf-8?B?Y2Z6R0xpSVhFMDlXWExTempvY0QzZldJOFJES3NZRFNNOHRnSmFTSnFYMGVJ?=
 =?utf-8?B?ekEybHVUbmFjRVJpTVR3eHpuVnoyamtScjRqaEM5Zy9KMC9kRHVDVDlEV0th?=
 =?utf-8?B?Zk53MU43YlllcWM0T293S01DQkhadk4zWnRCK00vUjZaTDBEWjhrYUhZUzY1?=
 =?utf-8?B?QnFzVTNaYmlUbEVicU9YV1l0TEw0SmIxSUY4NEIrTzI2b00zNTh4d09VeHVV?=
 =?utf-8?B?TmhYbzFaZTlPUWx3V3RmWHErTHd4YXo0UThQU2xGWEpvR05iZE1XNFdaekl1?=
 =?utf-8?B?NnIzeS91dGltMjdkdkdrdFBJTFFmNWRmdTdCSFo4ay9QdjZKN0NNMWhGSUpT?=
 =?utf-8?B?Q01JaEhhbGhDZ2o3UEZOYWFmekI1b2FYVFRWb0h4N0lrbmVWYUNnYmludlB3?=
 =?utf-8?B?TkdwWWZOZjRXMEZqL1pOVndrQnhmZzhYRDFaK3BUK0tsbGJETkFNeWk0ajd0?=
 =?utf-8?B?VWljT29rTUV2dnpPYWZpb0JBL3l6MXplVXFFRC8zS29pcWI1czlyVmNORGJQ?=
 =?utf-8?B?U2dOb1VGQzJJMFE0Y3g2R1g4QnNhaWc1S3J3VTBtUGtrNmRkUWN5RHZFLytS?=
 =?utf-8?B?Z2k4MFNHdXNkNEJRUTIwYlJMQiszQWNxRlFzVWU3Z1lIbnkyajZvOW92bFNo?=
 =?utf-8?B?dWtxaldOMFBlVkxrR0I5UG4zcUJMSUJXNGc1UVdIQmV6YzRNNm9hT3NkbWRW?=
 =?utf-8?B?d0ZkdjV6djQzaHhRckdMbWZnTkJ6UW90ZjlhdFhaTmF3MUlPVE0weHR1THYz?=
 =?utf-8?B?MkpCa2lSZVhZempXMlJiQWZPYVMySUh2VTl4WitnN2E1ais1Qkw4bFpKajJR?=
 =?utf-8?B?K1J6cFkyOHZKQnFrUjQzMHV3L0h5eHUzOUJ6Qmt2c1VRVHdpdjh3MkxienhX?=
 =?utf-8?B?blJDd1FOQVRKTytTczJJazl2VFZOQnVnTlVmVnJNZ0RMMUFvaHcxb05zbFBm?=
 =?utf-8?B?NXNlT0cwellidE9Bdk1NemlsYkFvMHNCTkVzcDNySTFiL0RoOWYyZlRUdU5O?=
 =?utf-8?B?UlBxR2dwOUZPczFpQ3ovbEMwTlFtazl3YWlJRHJJL0wyQlRzL1NCK3JtV1FT?=
 =?utf-8?B?RWFEUUx6dVVmZzZ1bzROc0V4bEFscytDbTBQc2xBaW5iMVBLWmwxNDZ3cnJF?=
 =?utf-8?B?cmZ6OXFEUG5SY2ZnT1pnK1NFVWlHc01PS0Q1clF6b0NlQmR0THhJN1d2L2dl?=
 =?utf-8?B?Z1dCNkk5SG9yaEQ4Vi9kWjBxUXd0RkpEdi93OWZ0ZmtId2Q2UVA5ZmRzdWRS?=
 =?utf-8?B?UnhLYi9TcndJUHprMU5GeHBpUEhaWDEwelp4cTY4enZiWnhwQkFFK0l5Vmsw?=
 =?utf-8?B?NnpQNTNUdzJqbm9mSnVGOElkMmNBaXdmdzRHNXpUUTdaSmJ3alNXcmd5d2s0?=
 =?utf-8?B?UndUK2ZjN3ZYRnlKeSs1a1J0V1VTS05nQ2hDNTJDVno3R1NVTnhDVXFSaDh0?=
 =?utf-8?B?cU5Dc3lXSkFSb0F2NTg3Q2ozeUFROFI4b09EVW8xZzVSY1JIWjZ1Tm1XNGhL?=
 =?utf-8?B?R1hoNGlhb1FWTTVvUmpucjBIS0QxZnZWYk1ZT0pLUVFieTlERlJEUlhHT3Jy?=
 =?utf-8?Q?NqYiVKxixYdOiBMU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c93aaaf-171f-4275-c874-08de5a1bb796
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:07:02.4617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+cDjltPz3moyuKD4jAjXR9KQm9mpUVylwrG7szFz+N0iq8InIWwThn0vZT8u5LV+DBT+hRPVbYKfYqxWde2/F9UIU+E9DSmDgY0EmnEor8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6006
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
[..]
> However, after seeing Jonathan's feedback and noticing that he missed
> that 'H' 'R' and 'E' are documented in the host bridge ABI I think it
> would be better to simplify this to just a link back to the host bridge.
> 
>     /sys/class/tsm/tsmN/pciDDDD:BB => /sys/devices/pciDDDD:BB
> 
> That achieves the same result and is easier to document as "When a TSM
> has a established any IDE stream it links to the host bridge. When the
> last stream is removed the link is removed." It achieves the goal of
> letting an admin do "ls /sys/class/tsm/tsmN/*/stream*" to get a survey
> of all consumed stream resources in the system.

In fact it does not even need to be dynamic. At tsm_register() time when
@pci_ops is provided, link all host bridges. Unlink them at unregister
time. The only driving need for it to be dynamic is if there is ever a
platform that supports multiple TSMs each supporting a different set of
host bridges. Can cross that bridge later.
