Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230631E853
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425232; cv=fail; b=Wm9CzeBXqZfRUxoNrnOrH5j4kyNu0k2YPXXLZiBYq7RAL4eaJW+WmjNb9ru8chGZMoc60Lc/A0W/TqHlEPVTVEST8DIKM5+QiTGK66mgVS9oXIqk3QzHi6yuakNo48ZkK8m/csoaP99W5RtdI3Fs4fDNfrFmHuL6rfsz3k2nKYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425232; c=relaxed/simple;
	bh=VZjrZQO0X7daJEhQCe7aT9zBWjffDJE8KBjKsnLSI50=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Iwl6k1P6EMiBbDBCWJdhoJefMNRhvTfzEEwZOhV0t6fUq47e2zBj0D7z50o5vN5fsR8eLXBvBrUb53F1n5Qft0OnkfX2aA2WY6uvv7I7zwg2AJ5Gje1zuoK9ZRCsigCxWM+D8aWbnE4oOI9yX/qHH2i7qeeUsCQjZ74CvGntuA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awjNbUem; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awjNbUem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773425230; x=1804961230;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=VZjrZQO0X7daJEhQCe7aT9zBWjffDJE8KBjKsnLSI50=;
  b=awjNbUem/WcYWfec2NFY/8qxFsdHo6THUgL2kXr2JeaKjV1A+Jc5G7HR
   ksko2dSe9FJac5xXzlSC8s8MMWPylugPvX16L9uj+0yUzw2CllDjiwmgP
   +kL0c+o0Pha3faHiItNpqMNaQRR1I+/a/RJ2BHzDl4GcN6xIVGOol8f41
   YCa/MPkmdNOll5D3Pc3AR0A8aMO3CUvNiOUTZg7XbHDbspjQuh+UR219c
   DllFpH6MAmXPYCpcUApUDlsAifbjUykvxNwYSptFGrazZhM5vLa8In2Gk
   ixDr+4nucIhfO0WR9raVWMJy9+Px9XOM1BpN8ChccIEJgncp8ROVo+icc
   g==;
X-CSE-ConnectionGUID: mJ045BWIRriXIO9eEVUVzA==
X-CSE-MsgGUID: W1pBw/FoS2GH6188vN2JNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="78429354"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="78429354"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:07:09 -0700
X-CSE-ConnectionGUID: 3FoYoSnRRa6rpgoaOyni8w==
X-CSE-MsgGUID: dLHKAg3yQT6wp5az5nqBeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225928274"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:07:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:07:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 11:07:08 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:07:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzDQHxzxjeNFBBP4VOOyLIaMNMXu8pxXCpMJ1YkT7H4qHp8o3qJ6I3iC/GbPw16HZQGxcdZ3kjW5D8MFOIW6nh4zT7jx3hnw0Bwva9s4UJl+6mRd3HMV1YqbHTWtZMWw/bLVj50RJbc/lcNAXZ+6ei/jMrytvZzH3doNYmrR3nTGp18za3o5vf8OVqRGTkod6Sa/mJvxvc0OeRQedUjo2EWwwVIk8NEYFpOD63kxcepo08xIsOFXS4rBxaxnurrJTgy/n9KD8O300mzu73VWW/JJcwE3B/D132HM1wEfrq9Od9wzmOTSCdudYtl+Cx1SEAfZWlSRHLv4e0ZKh9HApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBVDkANrzM5x3ht0i3sNfalmrJJac86W69JNuRdCuLs=;
 b=FUrLcSoF4oMlQC24xvNIR+lFfPI6/cJ9CKckQPYXXhFz49DEuMjj7LbNFRa97h+sO1diCHxqQb73UXKVKPu9AAaA8S7kL0D+Ou4JzZMA2BDgYiYpeT7ChFYTyL7vgH119Xdi0gOFz5r2NOKNdq/yNRx3LD2wkRzBc/R86lqJmLBybtQG0ygkoZS2c7YkWbkGoh3YErdK1GP28pUd6g9gTYkiifvcHUL/+YPv3t9BsHUadnMpyfmu1ZeCxhbBbCGmlQGMMqqmDrRF/BnKXaJBa5zB8krDre2ppyftPy17Pp4VTTUz+hbyYQMt0sBKCEtonTmg/+IUQXCxtrt8hifDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPFA424F92C2.namprd11.prod.outlook.com (2603:10b6:f:fc02::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 18:06:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 18:06:59 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Mar 2026 11:06:57 -0700
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<bhelgaas@google.com>, <alistair23@gmail.com>, <lukas@wunner.de>,
	<jgg@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
Message-ID: <69b45241e971a_b2b610050@dwillia2-mobl4.notmuch>
In-Reply-To: <abPh3d4+opAkot3p@yilunxu-OptiPlex-7050>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <abPh3d4+opAkot3p@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPFA424F92C2:EE_
X-MS-Office365-Filtering-Correlation-Id: 4066612c-c065-4665-351c-08de812b51f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZLZcjlAoSHCHdcgUQxE85seGZcszBionEv5K5Bg3bmY0LKa7c8ZVyaNndsSI9O5Q9FAogf1/nNz1KbUg3SXpNHuOr9Q3QN7bMkbKCn8vFNZbUr8MQaLgqtKn+sUXhVl/8e1WZGiU0kqSMmuxILYIGfhMbkLcafdmTxBaNWTKBdDADnrCq51VdbjJObPec8nbuRK1JXlsQySxz8MkTxyd7M/3c14cSYw+CtSbvIsgBpH0ruw8VvU8P51r2Yc/ppC7NO3j0p1rWb9DpLupyUa26lgC2D4T06meY8/1sbbuqpgj1kZvfBbMNmfP9WQpscwygPWWRCAT+7vgpguzWEYkUuc88iRj2r6HBsBJYjJOaQ3mJvbL41b7dE8RcuTjYhk8oDsoZ1rpHj/r+aAFzNjl7pSQAt2b5wvXxe6NhYngjsWn8kaDPtBQYduDu0OyXMnEDqNcHVpjdDyW0FWYMZzkCktOCCdYYFr5jOsQH1xaraHA+kRH61P+BOw6AXtQXPDbpJY1p2bQ6+9KaemIjJ3Y/nmuAN9ZGUED+rHgIQCYdaARKl/A4cG99h94d75fSy/Mx1uCFFqQjpm+2MFeHNSQUjtpFlVKf52euZr/a8UzPMgBUk9UbW+RuViW2cdZBe1PIYz/DS6Qsqumy31aGmlLCUDEXxUKRhqVnAEBObiZIGm83kmjWQozFiPjdtFSuvDbuQKmm44RaieVu1QmexPAYnkrRXhQyObFBjoFLqPRbVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnpuY1Y2dXkrdk83K1E3ZG43cENkelJueUtObFVQUmQ0SWlhdFJUSFJ1MzVv?=
 =?utf-8?B?cWVsN21qNG9GQUtzbzVSWHZXV2lPYWx2K0hXU29xZ2hJQlZNcE5MQjNodFp0?=
 =?utf-8?B?VFdKZHdUVW8xbm9LWEZsZi9QeGVaWnRiWmdOSkEvdGt5TXpYTVp2ZnJZSU5U?=
 =?utf-8?B?VHlDRklsbHBUQVlvamtiWkM1Myt4RlhDZHJ4aktRQkMrNzkzb1ZWWG0rSHJR?=
 =?utf-8?B?REpCcEd4WkNYcXRJTWo3SEdNenFTMnBHeWtGcVlEYzM5NmprWnRLbTNQVTFI?=
 =?utf-8?B?ZGdxMUpaVWw4R0VUSm4rYVdvMHBpM3FzcndKQXBUNkVSdUNQK1VMN2l1ZGVI?=
 =?utf-8?B?UmlrSVYvRkROdVZBdlNkMXFTMTZoMjcrS2FUYVZLbkwzeFFGZTJVVUIzZU1E?=
 =?utf-8?B?WlRVR1ZXN0kzcE1VeXVldmgrUzU5OXJkMGFLSFRBdDFTWHV5RXR1NFZ2WW5P?=
 =?utf-8?B?M2NsVk54R0Z2aVVjZEtQSm8yNDIrTWFiZFRxbHNMUUR4V2ozMnlNNUI4a1lh?=
 =?utf-8?B?aitmYmJOUnhKLzdmbGZLZXdieWtkdFl1VlFFQUcveDh2Uzk2WDlmdVhjVVJr?=
 =?utf-8?B?eUFIaXZ3OWkyZUZpS09WTmptR1hhSk9JbW96UUFJQzRyc21ZM0R2L3YrbzFx?=
 =?utf-8?B?MlNXaGpnZFZqSjc4UjVDc0dKUTl0eDBxcmo5THdwQ0JEZWNNaCs1TVYwN001?=
 =?utf-8?B?N2E4LzZWTTc4Qm1lWlIzWmRnYzhYM21oNnRUUmF3QzRuaVh0VlQxajFjcmRF?=
 =?utf-8?B?ZEZSRFRCZmUyVHRUaWlFZGZvQ1IycHBpZ2dCUzQ5NktsZmEvRWJ1Y3VjVmI4?=
 =?utf-8?B?MG93eWRPOGU5YjZWeFpkeWFDWTJjNG1KY2tVM1IrMTBBSEo1N0Y3d3NZSExY?=
 =?utf-8?B?RFh4RHc0RkkwNUY0ZmUwTEZxR1JmR3VBby9TRFBQYnd4YWFEVDJXb3NIQytN?=
 =?utf-8?B?bGlxK3piL1lHR3Y4ZVFjRjE5aTVQYjErTkVuRENla0pXMVVLUWVzcGpqdnRv?=
 =?utf-8?B?ZytDckdURWZpdnJBMTlCVUIxQ29KOFhMWDFWVTVRYzgzL0xDT21BRk1aY2dC?=
 =?utf-8?B?TmZ2eVk3UndZNzV4L0ZDbm9wQzlReFltQ1FLM0E3V2J2ZERsRW54UjJsczU5?=
 =?utf-8?B?L2ZRb2J6bWZwSW4rZlJ6b0RZTXhWK0p5bjJsdnkzQk5DZU9lVGlqM2VmQTV3?=
 =?utf-8?B?Z1lXbGJpTWIrWUUwSjVDclBBVnFYU1JLTUpseEhBRTE0MnAveGlMMzRXSzB2?=
 =?utf-8?B?Zy9xMEh1eTl2VFFYa0V4VG1BaFh6VVlRQ1NmQmp6c3k5VVZreDFNZU5NMVFs?=
 =?utf-8?B?alhOWUtsU21wbW1CWWYzQzBocnV6cGxGU1NZaVVObXY2OHNqVXZBV1JOVldp?=
 =?utf-8?B?YUNoUWhOaE9Eb29FRWFhdkRTdk9aM1ZkVTNUMG1nK1NTcGhPd1ZmSFVSZTJk?=
 =?utf-8?B?Mjl6Q3d2N0V3Q2o1WU5rTHlOdGFqRG5kUDB2WlBrempKOG9Ja2FBODJoYnF6?=
 =?utf-8?B?VXF5WVFWblNlU0pCM0dSSGpLajZuOU0vWEFqM1Y2RTFNUngwTFdVdGRQOTQ5?=
 =?utf-8?B?S3lCWFVvc2U2RlBHcWF0cml1TEFldUJ5S1lJVVBJRmN4d3FxcEtSM3FBUUNM?=
 =?utf-8?B?M3R4a2NXcVhsZkM3MjJZYnBwMHNBRHoxM1ZhZkZVcGlLS0k4Wk9Rb3ZDSXVw?=
 =?utf-8?B?bE1sTG1ueTFYOXRydU5nYThHSnVlS1dzUUFlRkJrSE1seU1WTkVJdUpKNjcx?=
 =?utf-8?B?YlJRaG1KZlcrOXQyUWF3OXdubjg1STIvWC91Mm4vQ3JTTGllMWN1TFJWdFQz?=
 =?utf-8?B?WVBraWdCdXdkbEZhQlBsSHFMV05zR0hMVEVmemNKYWRydFkyUS8wK1llTHNW?=
 =?utf-8?B?T3hwZk1wMTc2NUo3ZzJsVFV0UVBCNG9BcWxnZytMbmFXS0ppTGNFUG45dXd3?=
 =?utf-8?B?UzJKRWVwS00wVG5CbVh2akFzSzdQbklySEJZQkNEZVE0ZTBoK2dvblo4a3Nk?=
 =?utf-8?B?UTIwb3VLb0JPM2dUVXlTc0pGVUdVQk0yajY2ciszVXpIbUlWSkpzTkZmeHUw?=
 =?utf-8?B?MEprYTJZZFRYa2orblBSNmFIOTNZeStpZUJNSVdkNjhGVzdUOXA3VDlRdU0x?=
 =?utf-8?B?dGpSTzUwaWtRcGZ3S1BhakJZSFFMa1BOSUtOTTZWUkMvdHJTRlJzY2ZWZk44?=
 =?utf-8?B?dkQ1cXc3NUplWWs0SFVtaHZWeXgyZ2tXaDJVK2M2UytGSmdzeXhadWNObThy?=
 =?utf-8?B?dFFJUFZEdHoyOCtEd0ppNWNrRjZpdk5pVGFqekFwVHBCRzJ6eEJVSk1tbi9F?=
 =?utf-8?B?dmhUeUxkRklHQjd6T3c0NXJLTUM3dTA4UEdJQjNaRmRUUUZFeldGdDRkMU42?=
 =?utf-8?Q?/fBjaTuQj40KT32w=3D?=
X-Exchange-RoutingPolicyChecked: q/nc+ZqZd31fiyt4OBS+/SxNZ0BrEQ7loYRU2iQLJsIYgJYUDsFyz7n3N4HFI50EnfeRrbxdphlF2fv20FuE83O91b+Nk5vHjPKqywvcbdtPsUrcWy+nDctBPhW70zMq9DyFBPYTAUoETnhWcNrMsClc3aDrsT+9GoiBw6C/s9O7O9sWTvFza4jvfdXdaF9tsXOCUOo7XYpGPFfXR6hffCOYXwMrsBKYyrnxJbieb/Z50t12O8u/nOH6bVSMUtohVx9Q+FJBOReXJ4Kqq0/xKk6ACcA/XYrYSJYODK5lF12wxGcm/CugMWxBXLIL+j7ZRWITJ8LWskI/kduJAluxtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4066612c-c065-4665-351c-08de812b51f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:06:59.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIIXMAQ0UvB1Ro0LnQ+dHN2VJqmoNq2OePSlmwxdP+latQL8XA6fsUqpsYzX+ZKVLWAdsH/u4QakvOx5x+af9S1dLPRow/iK9hiz+fFYybs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA424F92C2
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> > +void pci_tsm_init_evidence(struct pci_tsm_evidence *evidence, int slot,
> > +			   enum hash_algo digest_algo)
> > +{
> > +	evidence->slot = slot;
> > +	evidence->generation = 1;
> > +	evidence->digest_algo = digest_algo;
> > +	init_rwsem(&evidence->lock);
> 
> IIUC, this function is for link tsm driver, is it?

It is meant to be generic for both, and an "optional" support
library for the low-level TSM drivers.

- Host PCI/TSM evidence interface collects the blobs
- Guest PCI/TSM evidence interface retrieves the digests via private TSM
  GHCI
- Some infrastructure (either arch specific GHCI or new common GHCI)
  pushes the blobs from Host to Guest so that guest PCI/TSM evidence
gathering can also get the blobs.

> But in the following patch, devsec tsm would consume
> pci_tsm_mmio_alloc() which uses evidence->lock. So my solution is to
> initialize the lock on tsm construction.

So I did flub the "->evidence == 0" check, and yes initializing the lock
by default looks like the right answer to that problem.
