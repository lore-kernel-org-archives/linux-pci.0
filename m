Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D33921C7
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052662; cv=fail; b=QeAOHGdImblGYQpk+0g82yLiYpke/ciCBTM6QqensyTgHvD6upZI+8gG/cdflLgQjsbkpsweFe1X7mzFGsiEC467B/eru7Xfhjs7tiOne0bNHN4eaKtG/BvF0g5FaGgooFA+aeD9h5cuIGmCjZhOow24LLemmeW3c7S6xGj9G0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052662; c=relaxed/simple;
	bh=wY62FrmHEqafSQV2EN7X6nHcFI74EYj4TWGYmgNdg/w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HPH7PHw1xnByxj4JIPrgFVYpcpZOq537vsHSqWpo321iwIvXqrV5zmzCZKUCYPw4TlHUkONz2574/P8bw+1pp6I8gXbOjkBTT0/iEIUqvdOBOlFx1VCTrCBqiYYs4i7RCXLyi1XdHK4DGKD/gdc94Dw++xWa2/gJjKlq7rczvrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grtndRCK; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grtndRCK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773052660; x=1804588660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wY62FrmHEqafSQV2EN7X6nHcFI74EYj4TWGYmgNdg/w=;
  b=grtndRCKLee/fyzNKCMcFS0oiv1gHlNKaolFEkiHQ12qqYjyz86Ov8NY
   cfuJ6QWQqfL8KaZd7V0CV18Xyxqa1NOCJLazRhDUU2olsDyQBl7SMAFrA
   vChsGe2I0FYkJzRPvAqV6nrj3sh9G1xEt384KoEVVr83oNSGtAOmfJPZx
   rmHZqkC23mO+q5MZATNeon+mi0WdXL8IvhCQ3ulLPC8QPnllY7uA4U1jG
   W4vFBeUcaATMHbzYLYr078zHMXRZucCpCAHAQVLlWzdCr2hJjpYuomF7U
   VJrbl7VhQvsfEkxFvphzSDq5s3vkGsI8C/cmY73WW84Zb6HchEXVWyhUq
   w==;
X-CSE-ConnectionGUID: dGi8pceqTnSRSVM4STYaEQ==
X-CSE-MsgGUID: nuwhMsEQRXafU4aFAeubXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="96690117"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="96690117"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 03:37:39 -0700
X-CSE-ConnectionGUID: 7TC3xsvwSu6bcU4TV4/rcg==
X-CSE-MsgGUID: FmxT+ZIwQrOfhKhU4WbxCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224641174"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 03:37:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:37:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 03:37:37 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e49I0eQuFUEJzkWkYDg84OI2T9/7aTudBzS+BMxzTEv7spsIUD7LAvRLER7foSelkuw2ytaQ9Y1bQx8W4p9DgI/dDOLPLFktfvDE7+YCJPKBWODRYOJUM+VsvHUwmWmhTUplzlKMkg7fC6A1hyzzERdglz1h4PFA6hK1e7AacpA/xMr0WshedFe8zJKUYXaR7Sw1dEXme49TgXct/lYnUIzR21gZeYlysdSeGDfXNYvbGUjslOV1DckRBmXMjVVwhdhjOj3JTipLbWL+0kvKdeFDZlP6Q8RqEwcqxnaW84imgLjJyRPOrJQPkpRhrYbebxqy/EM8jSOa9929gEeA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFvhpyPj+C8QJP5m+OpVaIDzRAWcmQm6CqTDmbQa5l0=;
 b=is1ck61wmLOenIALfWl+Maei9wI5Fuz7vH2w6p4Q6HnVToVX6DgAR/m/0CndUyR/LHr13vw7YShRxEUiIHjWKaFp1OVIcgZC1y6R58uMPd/ePoFVOxPKmCJekXjFrVD1Qa4E3WpPpJVlEOi7cmWq+QIEzIhGDIsG1C75Dy3/no5Ji4nsR0ypqPmncylAE+nWJOmYCIQNWhr4A3BWIIpe/1iwCaGC0dL6AirV7K8s8T16KosLmRlD/yxJ9sF5E2FUkY6WrRl1A8A7YJpKP++jY+Bkw4aDbnR0N3VjnQn68RAny2R0vOkTZbs5Jtqsfuobpjd+JhUkGfNeqskgoOfNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by SA1PR11MB7037.namprd11.prod.outlook.com (2603:10b6:806:2ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 10:37:34 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 10:37:34 +0000
Message-ID: <acea76fd-0ef5-4bf7-9b8f-3bea2096226b@intel.com>
Date: Mon, 9 Mar 2026 12:37:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 2/5] igc: Let the PCI core deal with the
 PM resume flow
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	<linux-pci@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Richard Cochran
	<richardcochran@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Dima Ruinskiy <dima.ruinskiy@intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|SA1PR11MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 25988786-357f-4102-7b7b-08de7dc7e005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: 5O0NPZxIbfV+Vxd3msvYRGu4Q+c24YE1AQA74lMKQ0c4NEzokypRqk61pLMn4k4a1ihW4iGJhA+gM6DIPBKbPvQygjEKgVZk4CctzLXgPrn+sKD6z+OB89Z4LkjD3Fg95r3suASYAQHWA03Yp887+iczvuLCkzFdS9V4ZEYHVyVCudhZtCHWisYzVgQd1K5AB3Oyh6e0JTRftQ0Mk/qDDEXtL7Ot/5ID2hFA8wK0F8ko63pBm+abEFs0An6AAkgmloEN3uFFune93l+Y+UuuRnc9B6eJLpye9f8csFM8uLkTVjBc3LT+842pdgzBms+dNrED2UNJKHCK7PTn6ioc+Ufl03yASFWrZksXwHKef9EG4yPQrJi7Mkt6VwZWY1Zc9XnMxatkv4a3mhU780pFP6jiYUOmu+dMUhIYR2SNFB/dK3jaFsNJGP68+hqO8fJdb6fOhTpH5lwIDNGXnMVeg2u+YzIPEwAF+O0ZoW4GfV4Ru22sTmTB5bxgdbjOZkF14aSG9ttwZAhtbR45DAhE6d0rA9xw49rrfV4TSuLd9JZZa7eezBOnhxgQ50exLN6Cb5luMOydMuBJXaMPVwAFMWBXTvkWTVe/Yd7pRfazMedejHOZhAz7bK1wnxsahTxlt8pJQweql9N6RP3BVLMoS0uV6/DPIWGp7yGyhgaXq4c6WRlNA0MaYncr91xEUI5GgcWwd/xJpcE6xuDKzq+2rX+skYN92NS6AQvI/q6SQTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emN6dDR4bDZqeGVQNEZNVW5NMmhIeHZPT0hxOUg1S0ZGdkpLb2JGVjFnYVox?=
 =?utf-8?B?QWVtcmJSRjFmeHV4a1lFcllpYlEyNCs4cndoelJxQWZEMC9ZcC9xbXg0dmVN?=
 =?utf-8?B?d1VXL0JKRDhYaER2d1pHVXZudk5IRFVjL0JmaVBibEpMUncxWE82MWJxVVdz?=
 =?utf-8?B?OG5RSVkxOXVDWXE1QUtoNUMwR3prSzlXUjhDZ2VhbVFUcGxjSytiZ0JwV21y?=
 =?utf-8?B?TlNzUTAyYkc1UWprTmJKMTd0Q2dWM0p0cms1WHN4dFpNQ21vb3VxKzZrbndG?=
 =?utf-8?B?WmE5R24zbTFtQU9zNXBxdkVzRXNzYmNERkZpZFNuajlOR0FUMDluaHJWWEpm?=
 =?utf-8?B?WUttNnFhSWVJc3dydHdGKzRTZ05nNGQxbjVDVG1kb1l0LzlxejNpVGFNWWZr?=
 =?utf-8?B?R3BvZ0JXUU9SQlFTSHVpUFpnTEpYOWRmYnZiUnE5TnNMT09qUW1VaUlXOVVh?=
 =?utf-8?B?TWo4eGFyM3RsZTFWbUxWa3BlNmhxWHVXWHJUYTJXZDcvMUxXaWFEV2dMVysv?=
 =?utf-8?B?b1E0OXdMSExLTTg5TWNXbXlUWHBhQmtWd3RENVFBdm54VkVPU0plNDZuNGRn?=
 =?utf-8?B?RWJ1VTh6bFRQdy9CL21SOVFPN2czRlhXakZFcm5wWFdnZTBpa1dLbEVYbTN4?=
 =?utf-8?B?L0RJQUg3MncvZHByRWpsQ3RseWw1UXVvRThCTkZ1ODg1eUIyY000MHJhaSs5?=
 =?utf-8?B?T2xMMFJjU2dhT2YvL29LRm9iM2lNV0czcXViSTB2MTlBS3NTamhOTWQrVnJF?=
 =?utf-8?B?YzRuM0s5eVg4bEpNNTFTZU9vQml2UjBMVlZkZ3VrKzlIbnNXK2I5dkNUUlRX?=
 =?utf-8?B?OC91TzRTMXlxM0pJbWpkKzN0YXhtWjJWc21sWFVPZmVvMzNJL1NHRVBYd1Ni?=
 =?utf-8?B?cUlDWVdCdXZ2Z3EvdW1qTk01L09kenU2UVJRWTFBdFBSdkxCamw1dzdnY0lz?=
 =?utf-8?B?TVd3di9yTkl2emh2aE5sWkd3ZWx0citzTkZCSDRjSDVUMGM5V2U3ekhGWXd0?=
 =?utf-8?B?Ynlndm9aaHdxb3J4U0pscEcvbDhIL2RiWWtyenRnS2hNM0ZXczlGUUlEQTNu?=
 =?utf-8?B?ek12eVhFME8vWWFJdnMyZ3dkamxOOStTaTVYUzV6K1lXb3daclRjNElDZnpY?=
 =?utf-8?B?MUJVUUF3Q1RJS1lGZGM0VkJQZklQVUNZQmZPemkxa3p3OUpCeXd3SG94R0RB?=
 =?utf-8?B?WFhSMXR1L1QzZ1B0TWoyQWZqUWZNZTlBVGFLT1BIVkZjMDMwODRFbDJBWVhq?=
 =?utf-8?B?N0oyV25ZTnpKRno5Y0RCMWFyc0tVOFFYK1JMd3Fhck9SZ2xLa29vUHdRRG1N?=
 =?utf-8?B?eElzUCtBcVBWREhqSFV6R0VudDdxTVF0cThiUEphRFN3U0hCSU4vOVhkQ25s?=
 =?utf-8?B?UHowRzRjSEFQMDdqcHFnREl1OHpMN3VQSzd3WnFnenBHZTREZnFqNXd1Yk1n?=
 =?utf-8?B?TzVyQ0c0UWFOcWlxeHg2TjNiQThCajMyRjN0SXlON3hHVXY5ZmpQSi9vaEZv?=
 =?utf-8?B?dmdJSTNCU2xXK0ZnNXBlb1VhWFdaUTVZODAwRlRlTG5yaGtBNElIYkVTT3NX?=
 =?utf-8?B?dmJBUE14dTRsNVVpOVdGeVpUTGVobnQrK1B2ckVCTmFGelVHUkRyUjd4NGFJ?=
 =?utf-8?B?RlBMOWEvbWt4cWpZUDRpcG1tQnFsb1RYdm5DS1VHZFFRVDM0M0ZDU2lhMXNT?=
 =?utf-8?B?SnVqRWp5NkdlL0RIbUNya0x2WkhlWWpYTTRQODJGMnhpY24zTkkxV3VLZFMx?=
 =?utf-8?B?SnU4NXJzbnpRUzZlbURKZ2VaTVFyaUZER0NBMjduZmx6V0c4N2hMeHE4enZ3?=
 =?utf-8?B?TXl5a1kveFcrdWNldGlYdVVnQVgwMUxpbkw1Y0Y2TCsrMkVGZkhyZk9VQk45?=
 =?utf-8?B?SWlhczlxWWF3SnN4V2R6WkFBUWVXUlBQNTNLQmxESmU5R1NJN1VmNEIvc1Jq?=
 =?utf-8?B?YVpGRHVYRnY0YnZmUDBFdzNHOS9JejFIcmhLaFQ1K05WWkxzQVBTODdmSU9V?=
 =?utf-8?B?dFJieUdmSnVXUUhvVnozd0M3SnphNmlRZW8zWkc5MThvZ29NY3M3SlloWXll?=
 =?utf-8?B?a0dla2xOS2tMNzUrRnRKVjJBd011ZnZTY0QrSTRQVjc1K3RkUGxRWkZpZ2Qz?=
 =?utf-8?B?c0dSVmh4QmQwVnF0TlBIR3VnaENvb1NUcGdjUnNqWlBtNG9acUxqdWVkNHZi?=
 =?utf-8?B?RXJqekc1b0NjMjVsbUlVSFN3bk9hZVIrenZ3SERyL3JhZDNDbm9jZC9hd1N4?=
 =?utf-8?B?RWNWOW12dWhrdHl0bGI1eFRMZUh3YnVob1VKZDVQbERnbEdJaDBzcXMyU0V5?=
 =?utf-8?B?YTBiWk5hcmVNamx6Nm9BUkM4SFlnRXhWTFRUZWc0NkFCbW5wcXFHQT09?=
X-Exchange-RoutingPolicyChecked: OfbMidJfKVckQcIXQ0lKYDJPLZHDA2xulwpcHNfWI2KK8LHXQ21RtPW+bpuBt+2EXCPqFCG/OK7fDRhKFVnF3rNg7F4pyjW6FaF1/hm3nZgVzA4hXWMPqcEJ+EZqM9DQNjKe3ueBVMdIsSE0Nlc3YARxmDCxP1kcuuCHAVYjc38OektrbNK8h+wB3Pq29IMyqL2c6OnlJzU8dsFLCjCeRa5rjN4UR8xkBw8GYQp6TdpJ0cfTfBXhNrwoYySSzRNrX7LN5/BIKCCBgdcCsX6qfHjyay9QDvzfnKM+klX2DxKBDRlymWbP6zi91AT3sCF1XgTQ1oZnydifJqgcACrz2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25988786-357f-4102-7b7b-08de7dc7e005
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 10:37:34.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSAWEx/80RILTifwjH09866ozxIaXZVm8FDFIIyCghEOjscmlAeQqrJN9FKucJHYx4/rPhZFb+elOuT8XB2p10FHrsAog99CiKMy7GxiwHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7037
X-OriginatorOrg: intel.com



On 24/02/2026 13:10, Mika Westerberg wrote:
> Currently igc driver calls pci_set_power_state() and pci_restore_state()
> and the like to bring the device back from low power states. However,
> PCI core handles all this on behalf of the driver. Furthermore with PTM
> enabled the PCI core re-enables it on resume but the driver calls
> pci_restore_state() which ends up disabling it again.
> 
> For this reason let the PCI core handle the common PM resume flow.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 6 ------
>   1 file changed, 6 deletions(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
