Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45571481666
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863684; cv=fail; b=WkCSa2s0alQil7oEJc8Oa0WbR986j6giHru5CZleX1Fm65pS/VLoSRGR9Xo6cBnoEjqocGpY8lnxEpUR6R0tVeC9W4IXwCQZZs+Wz5hVBjjF9eTkjZqDl+JNZaRxDy97WY6PSeOAct/wQNvttXWG0EutiqvbOEwpESeRWqpsGAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863684; c=relaxed/simple;
	bh=dF6zq1ZySvuhPg/xKZaLCveiSUHxXoLB6333ofMABsY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mAAa5zo3CPS6ytvw0bx8ReUkKVSQSb2I9+M4ZdXUYQ9HoFxUZiUMbJLaePR0EzuoKtzfrkStstqJ6sjL9j2DByFsDJ4i8nL8+ApCAF8LYwuz3+19AxyVxuAVACE7BTXab7sHHRfQP5BMqVv7V9RvkKqY6XHwxqCdIRUHoK8yS04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTfqOrgE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTfqOrgE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785863673; x=1817399673;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dF6zq1ZySvuhPg/xKZaLCveiSUHxXoLB6333ofMABsY=;
  b=FTfqOrgENOptS5ipbYyIspedDYGEwgcquRSAl10Hb/xyQug1SAGx6xUA
   gsVbnN6rnWcwzsPG2m4w1b2YUoDd6zCTYNZ+2SU8kPVnZib8rxf+v621I
   mFundK9OZZNHithYEq61RhIRMl1WD8KWW0Kz7t6joB12pFflsXKgSO3JY
   raD9fMyfrgwbQSyT/Z1LpPFR0jRD+60Yfw1B6pArSoTak+8BJx+abHojk
   QQ35lagzB/+EUToyEgVOxHao5JI600WFvnu++os38TKwq3lK80d09BZN+
   rwGOc4eYMA2jD8OuX9A1X98O+rp2T52+4NawK94Pi3i+PN4KvC/d3ffi/
   g==;
X-CSE-ConnectionGUID: 6mc8VNCKRiq1gHfMlXeXqg==
X-CSE-MsgGUID: EoTGfDGIQreq6zsGuiTXCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86622733"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86622733"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 10:14:27 -0700
X-CSE-ConnectionGUID: XyaJh+yWSwqKnGbnlhCTQw==
X-CSE-MsgGUID: nyquq/PpT6WdhsuLbFV1PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="263559540"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 10:14:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 10:14:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 10:14:26 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 10:14:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdYtaw7nxqVosH+d88kJIm7Q9Fi0q4FvDutNb+bRpT31bqKAnXDXnu2sPCeUQzAeBc+chvUHRKeofsRaeXX4vPpQWoj4cEfF4pyaIjDNxD7zb1VaulE3fMR2TQZ/mWP111Ob9aMgQ3SmdwtD3Nq/vTjSGNy2jua0lgCBlwPuC3sL1GGFyz+5EdH95Db/Ubp2dOF4XfUF6UQ/SNSgwgFC4C9LA7DUlaNF9KpxmCsEIJE0kzicrl0I6PjqS4V5lScRxqk5t55EXW+v3pRQ9Wku7BKobnz1Yq8A04Rnvb2zPXfy4xvfmBuTbtuSaKJ+mkC/vhW5TKhOYf2RbO+sc05Vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2scaFaPNpB4X8QyCnOQwZ8i/ETcXuH8h3sPvxVITukI=;
 b=kEVSdtSM+i7NuBIKFdVf2mt4HJhE0yGtt6iG8AyAKdXR90ek85Sl31WDv8rWSDE/Mc7af0jYbFC0vHuCWwNAjlDx3kucj97iIC4r9bPituKoihpd+2ZNubgtGA5izQ8A8jemXaQt6OVpEvCnhFRPnsdSPf7MOHNc0doBArULuIXnOXIBATQOGW0Nx5NnAPA0HOa0eefTUYJEUEFAotrvUyT8SKrZ4q3Sl/9Dyiqr7d5MhhPbh2QZyXA2Zlge/FNJvZcEfhRKT6hPfiy7b4a38WxjoATJ8sPazp/WkjHoge1cJWL1VgvCTWqqcBqYgY3xwVR3bqFmImWeaN/4QEdHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 17:14:22 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 17:14:22 +0000
Message-ID: <603aff8f-b7dc-4853-8fe6-8cecdb83e9f0@intel.com>
Date: Tue, 4 Aug 2026 20:14:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 07/14] i3c: master: Fix potential UAF in
 i3c_device_match()
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, <Frank.Li@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-8-adrian.hunter@intel.com>
 <20260804151107.333DF1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260804151107.333DF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e00c731-deee-4941-f2f7-08def24bd3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|5023799004|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: N00q4oOK6xBu5Ma9NhZrrOHWIXdt48UBjrdJfiJKG1RG5uMqCfaPMkliZ4lWWS3uezNV3jIxR4H4Fxrbxx2zq6ffIXcjrjyM4bYh9/Cre/tXXcNxRidDGMqlYScUNVcyBo4+rEfukGPJFUWdJXOCFb0AclYKUiGBmCdmqeg8cJ/CO5LWNk4/ugODO0fW63LiEiLTFc90phzTg0N+Ss/F9TgMITCmA+6G1g442oUGv5BFBih9sG+KEH+gYgtHntJwkR484QDROhvMQzpK0VgKjSL6AfXmoh+fXuL9xzLdZRljfAZu7zYGkXrlzFfiRFoFl+1b4CfHbl/W2KN3Z3rfuZTWokGDSTkKtzT8Jszem/CludA/grZk4xOzULXLVFT9CtEg4ngzE7asrAkSN+9fj7Pl5XbOXemTUGljBCv+OgnZid75z3r49o7e59lIWTEaf3vkmSUzJ1ynZV+GtFqRGIxbJlMwvX/dQZK+diyN+eR2sU/fcTljWhZuBkDzv/mETFOtTHhexEcwQL+y19kDt2Cz09E4qJBZuKBhI3UEgr+AqgP/+w4uAJPEJiXY3GFRTsz1N0hT3h1q8x3hm6xzw2dKE1DifO3OzMlNgy7b0wzgQz86jDLHPV5fNvnqjRWie2U89c5hdriIFD8FJxRmLiWAuXZa4qmMfuZIhWma0OE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0Y2Z1ZFeTdSaGtpWXpUVjZNZHlWTkkrWWFJSmxJOFZYaVQxamhDYzhrNDB5?=
 =?utf-8?B?aHhJbmhHUDIxQzhML1hkUytGVVBtUXA2aXFBdk56TExzRWI5V3Yrc1JIM2Jh?=
 =?utf-8?B?MTlPN3E4N25WTSt2akYxem1tTmE0dXRPcThVc2VLV2ZYR0VrM3ZJK1Jwbkx3?=
 =?utf-8?B?QTZDdjZhVlVpd2oveVQyTlliWktFT1ZhTWVtcmNXMFkxRUxLcWZtZXdHTE5S?=
 =?utf-8?B?NVlmQlA2U0pwVE5hWTBUZzlWYzMrQzFLb0NXbDlFeEhiOVpxSEVpZFBySDlC?=
 =?utf-8?B?Um1zVTVFSzJXcDRVN2MyRjRYU1VNUlNkNWJQNWpuWC9PR3dVQmRvbjM2d2s1?=
 =?utf-8?B?M1FzWUVndTg5dDRSUXMzSzRFMTUza2tuY1FSaS9qN0RNYzR2ZzZrT25KbEV2?=
 =?utf-8?B?ZEpSYW1PeEI3RkphQ0Q2VTlMdW5uRFRMRC83T0MyTW1QOVhPN284b1ZCTlJW?=
 =?utf-8?B?YzRFb2Q1dStpdXVVZHpKaDM0WnZuMU5iTDNxZ2QzbnExcjJ6aU5kaTFsdWd0?=
 =?utf-8?B?YjZsZXd4L1p4OFVMZDZPSGZnazV5VEZUVWRqdFNneEt4Sy9tZHJhcDgxRExt?=
 =?utf-8?B?enExcHc4YW14N1RXS0hRNFlQNHpoWU4xbWQzaEFjY2dBN253T1hMc2JoQnB0?=
 =?utf-8?B?Zi84Q0J5bS95Y1ZOazI5eFpHeEdCa2JPakg1Y1JYL3NuVjU3TnV4TGoyQURN?=
 =?utf-8?B?OXpUL2NDaDlVN3k5RlBmT1BEem1sU1owbzVqQ1hBcmw4QUFYMnZEeEFzYjBy?=
 =?utf-8?B?WXVCY0tqakVHKytRMVpHYS9oalowb0hvREVaa2xVQUF0aDZGUFZhOXNXMUYr?=
 =?utf-8?B?bm5sN3FMOFJZOUU3Z2NBUm1HSTNXWWgxZE9UNDdsU09KUVd5LzJGOEVhMFQv?=
 =?utf-8?B?M1kwSlJVWkxYL3kvL0FkRWs0RXl0WWtZdFAwc3RxbVZiNXdIaDExVy9QYWpC?=
 =?utf-8?B?VUs4ZkczWWZiaTRac0x3S3lQUWpOdHIrcG9KTm4xSEptRXBqSTBYSXNYMVF6?=
 =?utf-8?B?cjlUckY4OFMwaERKTWF5cmMvYlJhUjdrYzFCNDFmYS9BcXBDY0FjYnMrNmlJ?=
 =?utf-8?B?cGFDVnJIc0Q1TjVobUlrNTFRV0lvajdxalF2ZURXVnVSd2hDUlZxcU5XaDNs?=
 =?utf-8?B?eCttM2QrSFJEVUdHWUpQUTg1dVhRTXNOOEpUVUpJN0V1QXZsUEFFWmJoWmNm?=
 =?utf-8?B?bGNSV2t5N2VLelhoRUh6dDVva3VLSkRtR3cvZmVOQmgrL1RTSFpPc0pDeXk4?=
 =?utf-8?B?SEtET1dBL2kvR3E2ZXhjWDdmRjJ0R3FkbkhKZS9KNTl5Yjk0YXFuQnJTUnhB?=
 =?utf-8?B?OXhQNG83VFlFTVkwanNNMnUxT3Jyak1VRmtYU1FTN2pvV3ErVDV0UEhHMTlJ?=
 =?utf-8?B?Wk5nUnltQzJUR01sY1JtamhWUWh1czFtQk4xUlpaN0dHOUNTSlNITjJ4dEw5?=
 =?utf-8?B?ZlZnNGVHdWhjWGNGZ0FIdU1wVzBPQXNBZEN5VEF6b2d1NjQvU2Jkc1BEemVN?=
 =?utf-8?B?a1VsckwvbVZKeXdxRVlrV1ZkTnc0eHNIQ2RkSmdkM3dibHQrMVBWUkZ3dzRB?=
 =?utf-8?B?NnpxbXFSekxNTCsyQjVWak94d0Y5Ykh1U2hGV2ZlVG5HbHlwdGp5dTlOVlow?=
 =?utf-8?B?UkhMcm81cHJOMitDVWZqaFA3RWxlUEpraXhFeWwxdXNrcnUxZTZOYUs3V3M2?=
 =?utf-8?B?cHBnbE56NHFkNWptZFdoeFQvMmlmcy9va1FVUjR3UzllamthWlZyK25sb1Fz?=
 =?utf-8?B?bkJobjdTMW9lZmdWRFVVYVM5c1pBNytML2tyT2lYNXVWaEtNQVhQSWVwL1Bl?=
 =?utf-8?B?TW0zc1hsT3VoK0pHZERBN2ZhU0VEbVI3N2I0V3JuNUtMSWViRGlDQkZXdGM5?=
 =?utf-8?B?aWRvYzlPQkFWcmR5L3kySmRjWmRFSjlKTm13UmhqNHJIbCs2YjZ3VmJmemdQ?=
 =?utf-8?B?Vm12cDJMalpYSms4a3FOMk1ybmM1a0t6R3N0aW5Ldk1LRmg2RXpuNXF1QVNw?=
 =?utf-8?B?d2VieTZNRzlSNHUyQVZpMUx1Mlp1MGVXNG1yNHc0MnFYdWhlOXp2OTdTRW8r?=
 =?utf-8?B?NWlwMVM4V2JoNHZLbnZibnBZR0lQNEdoZ3p6cnBzNDNGVlMzUU9udUNBaWRz?=
 =?utf-8?B?L1lwQno3ZmxvcHQzbWhTNkxUOHFrOXZwN3pZeGFta3BIMkJqNlVBWmR4M1JV?=
 =?utf-8?B?S0hxdzFZZ3dNNkFVUE5kdHhEenRqQWs5d0NIUk5JQ1hXeHVuUDNmQnd0V1p4?=
 =?utf-8?B?VGVLTW16TEplc2VuOWtscWZqRVdnRW03MkdOb2pjYWNCYjBhQ2pGRlhiNjA4?=
 =?utf-8?B?ZW8vQzlyUkpVNDRCN005MStUQVA3aDNPcWJyaXZ1S2NOdzZnQkE3ZzV0TFlO?=
 =?utf-8?Q?4gNwf/5LH7SJ314E=3D?=
X-Exchange-RoutingPolicyChecked: hTNUqGjUg9qYsptWAEWykgOVW2I2AsCZIjNloUUy58IEH6A6Xu+NGSgS4oBoE/bc604mI+vfrJ/Vk03DF2MyGwF8CvCpXlJ7qHeCZVUl/mHO+Appx+1SzPezaRkJIV0jXg0v81Bd1mNY/7QkI0zuVvKJA6lvCOZkuk0aWMSw445E4VIutsXCH9z+4MtNZracXrPfaDnyqzvekUnuvt5QepOC3CZTlbwx/E5+cOxY7ySfTtfp4AvrgeNFAU/BsAu2X2eMRZZRKilx+HB/9V2uZfzB++ZOWNRU+1r9FlJwHjOatJGlLZjQRb1a0eK+iXw7Gw0utAH7eXjFIcMR31T4UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e00c731-deee-4941-f2f7-08def24bd3e2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 17:14:22.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcdJTYd8GFQF9UFaphuVgspehjjcQT79zTCTDtuLV5iWpGP5ukJcWpkL5zj+SUQjGNKz2BkVadiYcTC5Pc6PoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-OriginatorOrg: intel.com

On 04/08/2026 18:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Removal of the NULL check for `i3cdev->desc` introduces a guaranteed NULL pointer dereference in concurrent unregistration paths.

Not valid

> - [High] Unconditional access to `i3cdev->bus` in `i3c_device_match()` causes a Use-After-Free if the parent master controller has been freed.

Makes no sense.

> 
> Pre-existing issues:
> - [High] Preexisting use-after-free race condition in AMD SBRMI (`sbrmi_i3c_probe`) accessing `i3cdev->desc` without holding the bus lock.
> --
> 
> --- Patch [7]: [PATCH V3 07/14] i3c: master: Fix potential UAF in i3c_device_match() ---
> commit d088359c0cccb56067d426e92d0a49f24376de53
> Author: Adrian Hunter <adrian.hunter@intel.com>
> 
> i3c: master: Fix potential UAF in i3c_device_match()
> 
> This commit protects access to i3cdev->desc with the bus normal-use lock
> in i3c_device_match() to prevent a use-after-free during concurrent
> descriptor replacement. It also removes the NULL check for i3cdev->desc,
> assuming the lock guarantees validity.
> 
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index 947ab3c681d5e..e7ea410078891 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -347,8 +347,10 @@ static int i3c_device_match(struct device *dev, const struct device_driver *drv)
>>  	i3cdev = dev_to_i3cdev(dev);
>>  	i3cdrv = drv_to_i3cdrv(drv);
>>  
>> -	if (i3cdev->desc && i3cdev->desc->boardinfo)
>> +	i3c_bus_normaluse_lock(i3cdev->bus);
> 
> [Severity: High]
> Does accessing i3cdev->bus here risk a use-after-free if the parent master
> controller has been freed?
> 
> During unregistration, i3c_master_unregister() unregisters child devices,
> and device_del() drops the child's reference to the parent by calling
> put_device(parent). Once unregistration finishes, the parent platform device
> unbinds and its devres frees the I3C master struct. 
> 
> If a concurrent bus_for_each_dev() iterator (such as from driver registration)

That makes no sense.

> holds a reference to the child device, the child outlives the parent. The
> child's i3cdev->bus pointer would then remain pointing to the freed master
> memory, leading to a use-after-free when acquiring the lock.
> 
>> +	if (i3cdev->desc->boardinfo)
> 
> [Severity: High]
> Could removing the NULL check for i3cdev->desc lead to a NULL pointer
> dereference during concurrent unregistration?
> 
> In i3c_master_unregister_i3c_devs(), i3cdev->dev->desc = NULL; is set without
> holding any bus locks. 

The DAA and registration paths are already blocked by
master->shutting_down flag - refer i3c_master_shutdown()

> 
> If a concurrent driver matching thread invokes i3c_device_match(), it can
> proceed in parallel because driver_match_device() operates outside
> device_lock(). The thread acquires the bus lock, but since unregistration
> doesn't hold it, it could read desc as NULL and crash when accessing
> i3cdev->desc->boardinfo.
> 
>>  		static_addr_method = i3cdev->desc->boardinfo->static_addr_method;
>> +	i3c_bus_normaluse_unlock(i3cdev->bus);
>>  
>>  	/*
>>  	 * SETAASA-based devices need not always have a matching ID since
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a similar locking problem in
> the AMD SBRMI driver.
> 
> In drivers/misc/amd-sbi/rmi-i2c.c:sbrmi_i3c_probe():
> 
>     if (I3C_PID_INSTANCE_ID(i3cdev->desc->info.pid) != 1)
> 
> This dereferences i3cdev->desc without acquiring i3c_bus_normaluse_lock()
> or using the safe i3c_device_get_info() API.
> 
> Since probe runs holding device_lock(), it is not mutually exclusive with
> the bus maintenance write-lock used for descriptor replacement in
> __i3c_master_add_i3c_dev_locked(). If a device's address is concurrently
> re-assigned during DAA hot-join, could probe dereference a freed descriptor
> when it resumes?
> 

