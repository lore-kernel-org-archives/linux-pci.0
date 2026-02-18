Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21A1A9FA7;
	Wed, 18 Feb 2026 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771390481; cv=fail; b=YdETTNwewpEVpBeu9/4aIg2vZTTEaeDwqho7BBJLTsdmprUTwl73U+Vr2s4fb3ZWDlYLPV56PRtaK7htA3GjfpHLbbKWM8q8HpH5bHgEZ8dequcm45uK4tRa2wlVE4LEOGtSKrEiytoaJfACiQFLYNQpBEbFHy7zqvK/f9CQpug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771390481; c=relaxed/simple;
	bh=mxm3ND0lOn5ma4l9n1BWjvy0XTCQ5OyuKLhAxp8GbBc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u1JVg8De0L2vodpojpRpJiK8QcOBH2Z9E4a8K6vbMnm1N4wvRvt5rrN3CtQPlb7Qc+1jNUF44+fbDpyAbOe9csLdXkFs3W045IM+dzynl5Hl6Kp1GL5vl+OL3PWWcqm0VFD6P5V+6daTKKxYykoRbyPmC/Soxqb6/D9h0lcszZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyfcptiD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyfcptiD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771390480; x=1802926480;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mxm3ND0lOn5ma4l9n1BWjvy0XTCQ5OyuKLhAxp8GbBc=;
  b=gyfcptiDt/ad5mulIslPWxRG1m1CsHivSBWx02j2icc9WajuFyvVfgtP
   0gto7yv4Oo9RwrJSkT8GOA8gH92nMW6rdvvKClyQjMfsxx8iKMKRcXBe1
   i82pSa1XPJ6NHjSJfq2LZ4hVL0i9jPTYaWKj4E6fwFTRISbU+YRAstr4I
   hPZQK1z18/JOoUq8u3M9EhHQhq2AQJZ/ghsFHkbxSAS6EwFK59y8Kh0EN
   O9wAeT+sJ4SmlvAYUGv2u98ZLd3V3Qd59gIfxc1zDZzN8JwqToz9qiZB2
   HMqaxBZnuUUBrkjxGX9RBrEK2borI2Yd9FTM6j1mz/ji42yQ6Ybl2/MIx
   w==;
X-CSE-ConnectionGUID: T1qfqn39QLyF5hr070SYug==
X-CSE-MsgGUID: 6KFi7QpiSNmMfqBFvjdU/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72368718"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72368718"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 20:54:39 -0800
X-CSE-ConnectionGUID: 4l2Di5LFRYG/oy5d5vRr/Q==
X-CSE-MsgGUID: QIcK3nBnQESkYFyrkmdgLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="218618060"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 20:54:39 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 20:54:38 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 20:54:38 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 20:54:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYtlWsQvx6G8p/wRia/Pgdkryc46ZwBuenpYZibdFRICZG6sV9NwasZKN+QwtLud1/VDPHi4+4G+se7V50TA4jyL6hQYKwjgl0N5FchCa4PuMPdThC5qDUaXHU/GDDPPUnErY/KUgXpoMPD8WdF5rR4ChQyMLTdm4EJkS46qRSLHa8GRNp0SQmEMjNxGiy3VGGufEQ6TiE7ypmQp6dgHNEx4pvYKCuJP4NFj3L1wOErYRkFnRWA67CQVZ/15DC1xcRSCw+ACaQVRfeXwRqHtC0zcx4TWZIcdNU4FWwJnUJElSVHv86ArwQmVSNE7FZLU4LdkCrz5X4tLlO9SlLqERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dqMgM/R1zHv55O/f0AC2uwr7HwZqfX6lKWRzCEc3q0=;
 b=bIDN0lRGuHwmDxlrH+TLZJM201avp5W6Sx6pC6XMlI0NKSdF3BU+OuBCwiSroG1DdD+IJUomQUexH60Zs2B+lDHg24Rsermy54SGXR0B4XRDHGtOpPo+fLQnajuLlnT2BpW40n7HiGXZ9qMYEp8eX1ntA5QN4vmGWiJIKrY0aBfRwV/st95E9BXvlL8/hTTvMo13SB73JzyKYDmTlhaR56y87hGbnrHFw0NU5ALlVJYne6PCiXNaJFcIpF3ZUW5741c14eJdWxLq9uuwNCgeTOfqNcw/4g0XZwtIzk6FWJvCyK8I3mDHxtMIVJFM56laZJnfKyQusEvrgiXEf8Uopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8)
 by PH7PR11MB7514.namprd11.prod.outlook.com (2603:10b6:510:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 04:54:36 +0000
Received: from BN9PR11MB5273.namprd11.prod.outlook.com
 ([fe80::cd29:11b3:288a:2794]) by BN9PR11MB5273.namprd11.prod.outlook.com
 ([fe80::cd29:11b3:288a:2794%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 04:54:35 +0000
Message-ID: <564e872c-ecc0-479c-86c3-68b5d3fda512@intel.com>
Date: Wed, 18 Feb 2026 10:24:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND] PCI/TPH: Skip Root Port completer check for
 RC_END devices
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<giovanni.cabiddu@intel.com>, Wei Huang <wei.huang2@amd.com>, Jing Liu
	<jing2.liu@intel.com>, Paul Luse <paul.e.luse@linux.intel.com>, "Eric Van
 Tassell" <Eric.VanTassell@amd.com>, Yishai Hadas <yishaih@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>
References: <20260109052923.1170070-1-george.abraham.p@intel.com>
Content-Language: en-US
From: George Abraham P <george.abraham.p@intel.com>
In-Reply-To: <20260109052923.1170070-1-george.abraham.p@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0168.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::10) To BN9PR11MB5273.namprd11.prod.outlook.com
 (2603:10b6:408:132::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5273:EE_|PH7PR11MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adfb030-f79f-4861-9512-08de6ea9d047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFgwZkpZQk1uUGp0MGpGQWtVK0NXQTl6ekdFeldhWE1VVWJDOFFZL09Sd1dX?=
 =?utf-8?B?eE1hblVMb2U0enl4WVFNcU5xS2E1RDNYMXFXNmt3bTVFQXN4bEQyZWtUQkJC?=
 =?utf-8?B?ME1yejhzeWhERmQxSTRTTktub2NBeE1XWnFxV0s1RFRsZ01jcFBkQ2lKRlB2?=
 =?utf-8?B?UzJJRklPNzh2Zk9NTmpJWkMrUHBTNFpNckkvNXNYTUZRQ2hEdHEwRlArbGht?=
 =?utf-8?B?QUtCRjlROEMrazduK0poNUErdFdteE16Ny9mVm1OeG1Iajg4MVhhWmt3bDA4?=
 =?utf-8?B?SGE4cWpmSDk3QlZyUkNZVWlKNisrb1lNbUFkQVJYNElKRm1DWmNEUW5PaHpY?=
 =?utf-8?B?ZnM4S1JKVXN6VWMzMEFua1pFUTYzdzBpK1hFN1ZMUU5NM1FaN1FBQWVRMWVF?=
 =?utf-8?B?aWQrVGNtSzY1bUdiZ3k0RllQVGRlSW9Kbnk5Mm9rdzUxN3NicEFwc0dML3Fk?=
 =?utf-8?B?ZDdqWXVlY2hMSE1kV251cUcxTFpQYWo3d2NXMHU0czVNWkk4TFNvU2N2bktw?=
 =?utf-8?B?UlBDdXZ5a09jS0Z0ejhKd1RBaW1icGYxOUk3M0pqWlFZQ2l0anB3YjdrcTdw?=
 =?utf-8?B?U3c3QkgxcnNSYkR5T0xVRnFySkNETElQT1QwMXlFL1BWRW5kQndOaTQyaGk1?=
 =?utf-8?B?Njhhc0N0UVdzR290ZkIvRERDZjdYamJMc1BXOFdwejYvUCtvVW1BZGtXNVRL?=
 =?utf-8?B?RHNXQ0QvRnU4SnorZ3Y2THgwUkN5NFZCZFlmUkdraVFtNGh3QU45U3pTeEti?=
 =?utf-8?B?dnUrZ3ZOeC9YM1Rid0xCVVk1dkw5bWdTZmFVRzhGWnY1cVFQMTJ2ZG85c1RN?=
 =?utf-8?B?NlUyTE9ZMmRvekZyYksrZllhUmo4T2hDZjFZY2dZa3JNVnFkRDlQRTZTQ1R3?=
 =?utf-8?B?djZaM2FYTmRWenhlVytvMG1SK0FhWStmbGlmcjl2Uy8wVU1zU2kzOTUzR3dN?=
 =?utf-8?B?ZHlJV0JWT3VQU2FtUzdWcS9lQjY0V1o5NE9yV2VjM01mMnBFMUt4OEcwVEhC?=
 =?utf-8?B?MUh3ZEdhQzR3WFlSVWxZOTdwTTJhT04rMUlaOWd1RTZWTXJjL0o2ZnNEUjNF?=
 =?utf-8?B?em5TR2dpMW5Kb08vUnhwd3Q5Z25FeUs1cjdYcm1mOFp3V2h6SFBmL0RBeHZ6?=
 =?utf-8?B?enJhaHFydVNWMFpERDJwOUpPczhpTlJWVDdhNFpNNUJnNjJRZGdJUnhXWW52?=
 =?utf-8?B?bndUckM5VXU5Ky95V3EwYTF4YTZsVUFhT2Y5SW5SbEZ6eGhleC9oRWl2VzJ1?=
 =?utf-8?B?T2RxV1g2bm81Tms4U1owQzVNWWg4VHZnb0FnWk9NOGJwQmdkTEZVdlVGK0lx?=
 =?utf-8?B?VXZwdUxwMDc2ZzFmNjRzb251VVA0M084eUtFSFByM2h1Z0VzbE84ZW5NSkgz?=
 =?utf-8?B?TGk5cWo0cVhDajNhUWhmMVJ1TEViS1Y3TFFlTUlHT1RZaXZhNVBqdHJtWG9L?=
 =?utf-8?B?K1prVnlRdXQ3U1ltUFBIQmJJY2FVenJGb3B0VWY5cDAxT0pWcUE2NjU4YkpH?=
 =?utf-8?B?a3ZlNVRjZGFJTXZ1UlpNd3BPd2RkQy95TC9tbG9tQ213UjJQamk2WjBLQmxW?=
 =?utf-8?B?dmRkREc2MTB2K3BpdVJGcVRocFRYUHR3cmNQaXZOTnJwb1ZTUlJ0L2JlMTFj?=
 =?utf-8?B?c0FtdmNHWDJPR3ByK1VWRThWR3dZYmVhZTBKWDBFQWZFVE43SWFyNjlUNWR1?=
 =?utf-8?B?ZEQ1R296bzFJSG1qZDNkUG1mSUswNmJjbmltZ24xRFNYc21mOGxCQzRNbFZG?=
 =?utf-8?B?L3FqanVGUEt3SGd1NFBrZHJrakZYamU5d1dsN2gwME5jL3lSSGRBcFNjbC82?=
 =?utf-8?B?WVh3RSs3NmVWdUVzMEF6eU5RRkZFdktpbTllTGFlaVlPaDlwZmdwRnpaSC9R?=
 =?utf-8?B?bkcvYUNBMHF2QURMc3hyNjVidFNjNldWU2taR296Y3dQdjJkZUcyUFBqZFBI?=
 =?utf-8?B?NEVvV2c3dEMrRFcyL0xlYitvVEt5RU1ydUkwMlJzaTZ5UHJPSEw5aXhrNlNM?=
 =?utf-8?B?cTlSa250dlVtRWwrS3lsVHBOYjJ5WER5YjltRVpZMHhPN0VEa20vNHhVRGdO?=
 =?utf-8?B?bFQ0ZVB2ckpqOUpKbkR2enpFSXJkbFVkeDZkYkRjVmlDdE5NUHBpMjI2cC9L?=
 =?utf-8?Q?iyUI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01MK2lVRTREa3BtcHYvalpmMm85L1YwdkdZakhIbkVYN0p6TkVleURVSHdO?=
 =?utf-8?B?QTlPL2pkelM2YUVjRktNV1Z6Y1IzcGp0OXR2UThSTk5TbzhlSU9BVDk4bVRx?=
 =?utf-8?B?MjBGSTk1ZDVJWisvYUxoWlVHa3NGeGZtbWRwbVZYaUErdTlxSEJpUWVpcmJP?=
 =?utf-8?B?OUZ4LzRXSnJhS3RocjFxUG15T255R2pxRkllclM0cVNDSGIxM0ZtWFllMHIx?=
 =?utf-8?B?WWZkQWF1QlNWMVlBQTd0dWtQSDZxNS9MQnRBRUhKSmMzV2lLckU2Mmd1OUZ3?=
 =?utf-8?B?RUNCSzJkVkZXditNK0ZVN0djN1RHWXVqOUtZb1pwb3JHOFB2RHhjNlJncEZp?=
 =?utf-8?B?QzVtZDZBaXMyR1crNEpNV3llUXllWmlUWTkwS0E2SUZtckl6LzlvalhOc2Uv?=
 =?utf-8?B?dytVZ2pzWGErbEswaFV6eGdoVjRZWXAyNm43VlUwZE9iWllBNEVObUwzb1RM?=
 =?utf-8?B?T3JCbkdqNzVTdlhTM0dFV0xEU3puMHVyYjVCYXc2bmZOeExyVWU5ejlmcVVE?=
 =?utf-8?B?ZmhFS3FOQ3NJSmc2Nll4MWdiUXZNVzczalo1NGw5K3dHcjhyZ3k3bE52YkN5?=
 =?utf-8?B?WjBTRjV0YUhCUHJPSFZ2UlcxUTNNM3A5YjRFQ3ljUmdiNEZUaE5FWXFCMWxz?=
 =?utf-8?B?dVgvaTJHVlEzaEdKQzNKemZJc2ErWEx3QTB5RW9OWnFPQ2V5ejJOZnVpWFVX?=
 =?utf-8?B?VE84SUFOMjdUMVFUU2lDUHJFZ21WWG9wL2FrTEd4b0pZelJmMnV3cUNOYmJP?=
 =?utf-8?B?aWRCQjJZV2QzNjB0V2x0ZlVNYkttaUhkMkpuaWMxUzVzNUNqcjVJZ1ZRWFVi?=
 =?utf-8?B?SC9HWHV0V052SS9pYXRrNk9OdmVJeDY2c1BjVDErZmloUnBmbnBVU2R3OUNJ?=
 =?utf-8?B?OUJkc3VCc2J0MFVCNTJoblFaQXVPSCszL2QxeVRsdWJ0cGRxcWlnYzA1VEF1?=
 =?utf-8?B?cG4xeHhHek9oR3lwRW50TmRid0p0Q3hVNHVoLzV2YXJIRnM3ek1CNUhBcmlV?=
 =?utf-8?B?MFJIY0JWZ0l2d3IrLzdCZ2gzVXVuMXRQVm4rdzNvWXRseFBBSFlPSExVeklh?=
 =?utf-8?B?S3RmSU8rNzVOYytjZlprRERCK0lMQXNLU3ZuZEdSQjBaalVsdFZRZWRNdFBv?=
 =?utf-8?B?VkYyby9VNDFqa3lQSVJCZDBiMlcxOUIyNEFjOEQvcGJuaTNpNjZTK0tMcmJi?=
 =?utf-8?B?N3NwWFpjdklPYi9zMDYvVkh1SlJoYmw3SEt4OVBMaXExU2oyTHhsVFJoWStV?=
 =?utf-8?B?azdaaDBZdmE1c0NmamJoM05rSHRPblZBSlBuTUFnT2s0cStwNUo4c1hpdTZn?=
 =?utf-8?B?UnVPaDhsVFhHZitOQ3FVNkRMbk9NQnFyTXN1UHJDTlg1QnhqaDZqNnE4Qkpj?=
 =?utf-8?B?MUkxTjRVeUtHZjBNRDh2ZzhhKzZrUTB3QVE2RC84NTVlY0lOUFVHNVJ6Q3Ax?=
 =?utf-8?B?eU5qWk5wZzJwc1hDUkhDV2xEV2h0ZmhJcmJtK1ZIdnRKUXdEbDJPZm9Tak9h?=
 =?utf-8?B?SUVSZnV0R1lKWEFCamgyazUwUGxtWEthN29USnFZeGp4UmFpY05kYzBYT1ZN?=
 =?utf-8?B?c1laV0xZbHFMSDBVaTN4cnVsbkUrejI0MjFMWFhIcE9ZTGNrZjZKaU5iSFNp?=
 =?utf-8?B?NjArL3NCMW9ldFpDSEdrV054ZGp0U1c5UU9iQ3lWUHdWeTlyM3NXMUcva2Jv?=
 =?utf-8?B?dlEzS2xoa21oMnNiZ3M1c0JVelNXMi9JNmF6OXg3Y1hmR0J4L2VkK1RpbFpr?=
 =?utf-8?B?K0hCWGRVNGQwbFV5NHhFVnhUeUl0emJoZmU3azk3V211VkEwcGxxa0xhSkM4?=
 =?utf-8?B?dHVhVjUrQWo4TjhQb2ZrL0twNDlDdGI2cVBXV04rT1hJWDJaYmh4QWlGa0Zt?=
 =?utf-8?B?RVlhdmt1VUh0aWFMMFg5eXlteCsybDl5N0p0TFlHaXhUdW9sMGdHZ2g2ZFBa?=
 =?utf-8?B?T1RaM1dNNDBMV0xXVXNmaG9VSldTbzd2Uk13c1IrS296bStRM3hTU3NrZ3Y5?=
 =?utf-8?B?eXVSdkFkYkE3d1YrVlNXcHIvUk5GQ1J1TjJjWVM5VmFXNXBZWHRsa0k4V2Yr?=
 =?utf-8?B?M3RmQzhLMWxod3BEYnFzeGxIbDZRUTliTTVTQ09Ram5HYk4vckp6eENrbFdz?=
 =?utf-8?B?aEFyZml3ZXhlWFVtbzVNZ2grdUhkVHNJZjZpZWJZTXVHKzZpQTJXQ1VwUHRD?=
 =?utf-8?B?MDNpQ25ESjBqamloWHNzSXc5Q2JHcWc0Wk9mZ2MzSDZiOU80bzJEVFl1ZUJ4?=
 =?utf-8?B?ZnZwZXFsNm9jT0lUYmhRMUJPc09uaTcxOVBrSGYvOXQ0MDV2NWQ2aTZSa3hs?=
 =?utf-8?B?Z05pbnp1NXR5QTBjRC9vYTFvcVVTTCthMStQd1diSW1OR0xHZ1ZaYVF6MGEx?=
 =?utf-8?Q?Dqc4kVIhEcshAo+g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adfb030-f79f-4861-9512-08de6ea9d047
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 04:54:35.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HxwfMKjis2dTKPwbasdgzf7T1BkhMz4QJGJlDmwLWNtkPqEFEjZqMBICIyIIzwKc7+5lZOu8hlca8ngoazdid4QPCGrjE5X4gGl9LbVVmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7514
X-OriginatorOrg: intel.com

[+cc TPH authors that were missed in the previous mail]

On 09-Jan-26 10:59 AM, George Abraham P wrote:
> Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
> directly integrated into the root complex and do not have an
> associated Root Port in the traditional PCIe hierarchy. The current
> TPH implementation incorrectly attempts to find and check a Root Port's
> TPH completer capability for these devices.
> 
> Add a check to skip Root Port completer type verification for RC_END
> devices, allowing them to use their full TPH requester capability
> without being limited by a non-existent Root Port's completer support.
> 
> For RC_END devices, the root complex itself acts as the TPH completer,
> and this relationship is handled differently than the standard
> endpoint-to-Root-Port model.
> 
> Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
> Signed-off-by: George Abraham P <george.abraham.p@intel.com>
> ---
> v1->v2:
>   - Added "Fixes:" tag to link the commit hash that introduced the code
> ---
>  drivers/pci/tph.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index ca4f97be7538..e896b3958281 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -407,10 +407,13 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  	else
>  		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
>  
> -	rp_req_type = get_rp_completer_type(pdev);
> +	/* Check if the device is behind a Root Port */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
> +		rp_req_type = get_rp_completer_type(pdev);
>  
> -	/* Final req_type is the smallest value of two */
> -	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +		/* Final req_type is the smallest value of two */
> +		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +	}
>  
>  	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
>  		return -EINVAL;

