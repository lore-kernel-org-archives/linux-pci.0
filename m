Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794224704;
	b=jIXzt1/eSqDOpxtZe5yngCVw4OzYRccd3Tbkd5kZFVUf2kVbiM7QwGhL/KRwNDZN4SZP
	 54L+AjeMu7C4rfNx+UeOrKOiqQEux68s60I0mCtUOIMus02+nb/ScRSEb/xUPiVwaCS3Z
	 WppsceEBCTo/AkBGKFqJZEWTeQnSXxNThbg4FnaUinZO9hNjvhBqmSNjlOmNXduopEPSu
	 Okk+R6KyqT3It96Ctkh1fpWBU3vHlbQWpHSYpoD3TDvp0amuVcpN3wi6kR8ql4UZEvHT4
	 buI1z/X4rzfx6tcbxjXg8h21RQqZCzHTThEJNNFP9Vfmq5e475G0igZl9ziwyB/uewQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224704;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=jD3z+kf+p7o3UoabVYPoGxaaVHCfZCCVEt1sMeZ6TKg=;
	b=en1E/OMh14XaAEAorM4NJgKRE117gdGTR72NE9WoE4gyY1EGI+s0BMiwLjv93AdD9qLO
	 MSmzp9IznpwgulOhYMMtagN5Bz8rag2RyfUaU+9fzuG4T0sXwjU//suQiL/yGixtdfqJ2
	 5lf9znTZDbFXWoU+fdUXDba/lBgNuhL031/qt155cm2go936pbHOn01OoI1GYXsnff/o1
	 NKu4mimY88IOcra5msS91gcMGHEhl/jaLPGBODa8bNo483Un8ki3R1b1Mp6KXczrUvzFF
	 k7bHuqTx5FOdKGONKfGKfcFXb+eGCIWlfJ32VNstD/h0jbZMWlITLM+gJwrcQYLA1rA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AUna2nQ+;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DF606A322;
	Mon,  9 Nov 2026 11:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C54DF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AUna2nQ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794224702; x=1825760702;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dq5vVML3wPlbTuFgGX6ADaQWTyeLQQoNVMEu3ET1UMQ=;
  b=AUna2nQ+qU8G+7hCBocjENwbapcNgmJuXaEUuUE0RSpDDuD667g9h88Y
   mK6rfugJve66yaAePsNE44gI+MI0TCzmtmv9/kG+knaeXoJSpVsS2mcRV
   AtmLnmVa2by53QiQ6SHDADs10n0nqXYCooqxhAhPfMd7LL85nnKMOHcFm
   VjjZrJDhV3EJ3sAmlGouFY6K5PgfF+pY5AmIR3QwbyUW1CTRjIhKE1LMZ
   /CZx5Xp1q8VVHZRafi8IWUwcXFTdM5jJ+iLfbdQIHe738c8D8UQNIjRgQ
   kF2BaI3jS5C1PSzsxzK0X0Pjub3Vjx0xqXUdwVuUWeBOCdUNbuKPH4kHz
   w==;
X-CSE-ConnectionGUID: YjNVAxT8TrShl7WJKz201g==
X-CSE-MsgGUID: HPFA5LA3TnmYk0BjqkMdlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2983381"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2983381"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 03:45:02 -0800
X-CSE-ConnectionGUID: ZD2R8tOET3iccdLn0CPX9w==
X-CSE-MsgGUID: oSpeyBAvRxSN63otZFWiag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8182670"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 03:45:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:45:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 03:45:01 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:45:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJnRVdH+AT/AR7Hr2V+SCjzv2BO0mEOXdfXFvByw9N/hQYrMCOKuWVNjCE/Luj1PRDEgsEMo0Nvsh9yoNqlZ0M4gxBk8k7l/MTo87yoRlJG4QB2nXOUHrZBmpipGLw27CNHNSyfu0eBdW6ihFwNO8FraPgFx0J07VJRGIsXWV+VfWr7Yf6+umjTbMRy/ZZ15qGDCd9hecJqV2exjRN7h11hmbQTamkFtEMQxYsNhqWez1HhDm60XGGSQGSBFdrLU3WQfIK4BJS+fs2l1yIgCfIj+CWkGaDg2Cpf/+QAwM/5knvLBhL9R083RcrZddSSvzIwci3X3NnTVInq8Is+seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD3z+kf+p7o3UoabVYPoGxaaVHCfZCCVEt1sMeZ6TKg=;
 b=UD277Cvgt0KknVj8o91bAxIzknNcUqd1sJ8VjqKJ+a3y9FXiBCf5zBBPLsEly+u+pzZKdmBggbHzYmccyq56lvpsch3smw9QsLnapSDlY244DrL0Wsrws/KMICB045WQA3oqPIGmFucOopc4ZTU/C49bvqGZMBmpSOXLARHgVbSSSgOk1NxOEin+6uu4d2f1XIylcc2B6YAcd2ZiUG77NQ5IT40fQCaVTAU+Do/3CAOsUGLVf1C0BBVMSIdGHedSgwQ8zwQJS4ECqoF3VEQtuyOfCRghkL8ufT0byg3wDB97NjfF3m/k4AaInJr9mn6f1mDtMyVgSs+qjyBNlkuMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:43:57 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:43:57 +0000
Message-ID: <02c36d47-ad50-4f2c-88cc-6c91f62bba00@intel.com>
Date: Mon, 9 Nov 2026 13:43:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
To: <netdev-bot+sashiko@kernel.org>, <danividanivi@gmail.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kuba@kernel.org>
References: <20260925112850.189302-1-danividanivi@gmail.com>
 <179068206160.434549.1717741783856466607@kernel.org>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <179068206160.434549.1717741783856466607@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 3342f2b7-eba3-4352-72bf-08df3e56bd22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|56012099006|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: vNveLvh1KNbrXCKwpjgSvKNg1zXscaVRA/qnfIpKKacJQn68Hh4jO4nI2WlaBvHYhAkPTyi/VRf+DM84gCR3DqkKOTbGf7/26x+8miFKIEVmBjK2HcYgEhvtjb07es7W00HxsEsho6hsAwogxrqMPLAlvK6fl/F/FIarLXB4ZIXAgAsKctIWcgzVAYmf7/vgHcrYBTVYzwipx3yYIomFYFf4393aQuS5MTrTfDxxs9PuZbyzU1QO4KV0V4vEdHQR1Irm4MNPu4kYCS0YtNGfxF0t9FRuQJPfDEc4WpflZVSCqKfvLcUx9x8At8clI68k4KZMZJcLCysDeIWDbJHMsrVEVvYNHtz53+ybl3hK1VyPztvxfw9f3KZek9q83VwrVZKoY+4U5vj6vk+5N9eMND97tjl2g32mE/usJcFsUvdvjgWoH2pjCZrXIvO3VnW6g/eqVmI84vz7CQhq0AEIff1lnzd1V5pG7KiA/XZTUrDN/t6Y9Sw7k+whmkMC38qNWJWjcEPOi2WAy8ZGx9ZldDDsPzXWJ7n0gy8pRg3EhqfiyunCU5zGxynY+EiZnrDmGYO624Q2t1Ujl08qaBPzTGZXwX802MTxxgnQl9qryAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5630.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGdVRDNvaDRmOFhpSnJpOFJvelU0djVCS0xGMnBQRytEaGVxenh0bUgyS3Q5?=
 =?utf-8?B?R0cvY2RJL3Z4eEZSaDJvaGxMSmpnQjZ3NGhHZ0lma3I2SHJ2Zm1jeFU3TEVT?=
 =?utf-8?B?YkFOeGwyWHlEeEYzZDZQOElMaENNQjZDak1CdTBTUHJwZ0svZDZaK1gwODZD?=
 =?utf-8?B?RWtUb3hXTWNuaU9GN01aUlNHdFAvZXBzcEczY2VuMC8zZzE3eHdOQjh3V3g5?=
 =?utf-8?B?WExlMVkrbkRQNnlzVVZTWFdNdXpvT3RmZnBzUUNSLzJGaWs3RjdEVlU4Z2FY?=
 =?utf-8?B?VkxxRVhLU0NYZUEyUEZYRUF6ejJvYTZSREk2YjhrTXA3UGZFbUFGZDlaK1ls?=
 =?utf-8?B?bVc5Wmg1c3RMUkRmNFdpMVNUQndmcnhMTW13YmVKcjBEZjZZd0I0c1JSUFdX?=
 =?utf-8?B?TUZ4bjVTd3NxRkFLYTNpOW81VnJacFZHRm1sWHU4bXJqYnFZQkhldUVGS3g2?=
 =?utf-8?B?WVlVZWVIY3RRNE45K3FybjFBeDE5eEJUb1ZYOFVONWR0eG9jRjFQSWhYYkFY?=
 =?utf-8?B?UDhkMms0bE9oZlhueTBrRHRBZFlsWWFjOXpNb3lCMHZSdGIyZ3Z6Uk1zNWtm?=
 =?utf-8?B?L2pKMDZmUGsyNmNsMS85TGF0bGw2WVFRSlY1V0Q3Rjg2OThIU3JUTXM3ZEg4?=
 =?utf-8?B?ejliczk5OUVtejNDMWdaSW9mSlU1WWc3eEVKSDZPb1dWbEE3MGVNSWNPSTI2?=
 =?utf-8?B?QTRiWXJmdERCRTVKYlZVbUpLMFZnSzB0SVVnUThFeTE1VGw5S2hkT29EdDEz?=
 =?utf-8?B?d2lvK2ZXTDduaEVuTXlSWGdFWTU1MnNXYzk5SVhqTmVLNWlVMGxPd0xza1pU?=
 =?utf-8?B?Rzh6NXMrbVJXOExoTEhNV1FvdUN5aTBXSXhWQjE5N2k1WXJpaHpESU1YUEMr?=
 =?utf-8?B?aXh1VWUwYlB5UUw1Y2U4ZlZnaThKNmowOXgwMWFFc21kOGVkWU9iMXBhZ2sz?=
 =?utf-8?B?cnlpTnFyOGtMR0hxNXFUVWUvVnhkUFNHekxBd2lNVUQvZTVPNHg0UHV3UWhy?=
 =?utf-8?B?N3pEQmRadjdZYVdodTk0bjYwVjVoaUNKZXFnV2V3SW9ReVVLaStmankwcXFE?=
 =?utf-8?B?cUxieVhUMXZmbVlkMGdZUnZsNGZNeGJyN0pMSUxwN0RGWDlRWmNBT1VPY1ZD?=
 =?utf-8?B?ekdXVFJEbS92MUdyY2NyTWhCN3dqb29xdEF1UlVreDFkOUR4c1NUdkR5NU9q?=
 =?utf-8?B?eGtZSjFTeDhKdDVIZzMwMkw0L0ZMY3luV0N3N3d0YkpMU2dHVkNPSjhaUFpz?=
 =?utf-8?B?bnNLQktuY3c5S3RjOUlnV0F3TThBOHRlcG81dHF1Ri9MdytDOEkyU2FhMlpN?=
 =?utf-8?B?MGgzSlUrbU0xOXdqZUJwdkVIUnNMMzlsNGxSb1lDbUlIcFZpbnpyM08xMWJ1?=
 =?utf-8?B?YTl1RS9taVF4UDhwaEY0ZGNqMU9OdmFGdHhJbjA4QjUvTVFTcDMrVjZCcDZj?=
 =?utf-8?B?SUs3TGZTSjhZQ25RVExzM2VUbzRyUG9WMjk0Z3p4WDVYZHdNbjVoMFR3bnFv?=
 =?utf-8?B?YWcyV0pGOHR0d2Z6NmsvLzRTNnFWeHlEZVpCSmtXaDFqWk5zbEwwakZqelhO?=
 =?utf-8?B?c0R0ZC9ycU1vUDdFdkhzRzNTblZRT3ZLZkpwYUZjY2pRRWxpZGx6S3Jqdzlh?=
 =?utf-8?B?Y1I0UDNFa2U1YlhaMG5uM3ExZ0NreXVXNE5HL3RuVlYyY0pDazB2RksrWXNN?=
 =?utf-8?B?VFo5czIrTU5DcDdaV3pvN045dWd6bFQ5N1htN1dpODZMSEgwaWthS3Y0OWtF?=
 =?utf-8?B?ZXpZeXVUdllLYmVBN2JOcU9LRTd1ZGZlZjVhbEYwYWxEclRqNmhNL3hvVUdB?=
 =?utf-8?B?UEtVRXI0anlBaS91bXRVaFM2dTlEaHlrL1JVTHE4NkQ5TEVOSmNZZVNLQVBD?=
 =?utf-8?B?WkZMZUlrUGd2bTVwWDFkZjd2RXV6M051a1pzNDIvMHhreHY1NDlRU09sM1dV?=
 =?utf-8?B?TWc1cldqdHV2Q1NMRU5YQWxNSHpWWVFNQ1lQcUVpTTdUVW5tNkpwa0tWZVNh?=
 =?utf-8?B?ODR3OHhFaU1SK09vZ245RXdwcXBLcnNtYlFVd0ppTEttZWZxMGNwWEl1SFNx?=
 =?utf-8?B?WFVSQnNuS0NiR0NxYi9sN3FoNkUwK2xpTzAwdmZlZitYdk9rTkpPeGFUM1Y5?=
 =?utf-8?B?d0lBRytHaVk1N0kxNC9ld0J0VFRGaUxweUViZVc1QWpHenRqZllpc3pBakdI?=
 =?utf-8?B?czgwWUFKbUpFcUdUQjArVjFVcEsrNG1KZVdZeDlWeG5UbE1TWjhNQXZOQ0pQ?=
 =?utf-8?B?K3Q3QkF0bHJ1OXNxTHpSVUxZWWZ3eWJld0Rmb2xtcmFzMmFpeHV6cTRPSnNo?=
 =?utf-8?B?aklzNWc3R0hEZDljcjVaSXZqVjJYZmp4eWhFMzdWVmkvREVWKzlzUT09?=
X-Exchange-RoutingPolicyChecked: Mfie3Cqphw4U9Z8kvVP6L0x3/7QHoRhGJH+aVxa/f5lhWYi4pCnPEsaxXzSOQYPZI4kx28sPl7dzncEyc/vlJdgkui+vW2QxWeKW6nai+yn8sMtLJUX2ikmAHvJfS5on7SweUAr4eEf2JBnx9uJvuRki9gC1YnWfvhLvYj/2RIgYicakBjjMXGKF4aJs9OFDOEIukB3+rd/abCo+dTIf7lPqGwRdBai/HAl5zxH2vqJnnZZVJGv+WorFaBsd0eV6a8wEbRiUoZc6OXe+mLaJ/8eJKUHlWaaRPnTJjWDSyqkMw7lCVG4Oq76e/lDEdh0U4Vw/Z20jBFru4sT/R7inbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3342f2b7-eba3-4352-72bf-08df3e56bd22
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:43:57.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wohVK3ElYAgT81eg6XIeX7xRh5+EFZTFZZmT9/g0GZZBjX5SiT3KJyPuI8fBxNxibij3N4K2ElZPrVa8FJEwBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com

On 29/09/2026 14:41, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The widened condition in `__igc_resume()` (igc_main.c:7562-7563)
>    makes I225-LMvP and I226-LMvP call the non-locked…
> - [Medium] Adding `IGC_DEV_ID_I226_LMVP` to `igc_is_device_id_i226()`
>    (drivers/net/ethernet/intel/igc/igc_base.c:450) changes more than the…
> - [Low] In `igc_probe()`, `__igc_resume()` and `igc_io_slot_reset()`, the
>    return value of…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch now
>    exposes I226-LMvP to it.
> 
> --
> 
> igc: Disable PCIe L1.2 substate on I225-LMvP and I226-LMvP devices
> 
> This commit adds IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226(). It also
> extends the ASPM L1.2 disable in probe, resume and PCI error recovery to
> IGC_DEV_ID_I225_LMVP. The motivation is BadDLLP errors, link timeouts and
> shutdown hangs seen when I225-LMvP negotiates L1.2 behind Thunderbolt/USB4
> docks.
> 
> Link: https://lore.kernel.org/lkml/eb5a9805-3e53-ec22-696e-21c6b8cf0bfc@molgen.mpg.de/T/

I think this patch might better be split into several patches.

1. Adding the missing IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226(). 
This was probably an accidental omission.

2. Addressing the locked vs. non-locked call to pci_disable_link_state 
(the possible deadlock noted by Sashiko) - this should be looked into a 
bit more, I don't know off the top of my head what race is / isn't possible.

3. The actual problem with L1.2 substate this patch aims to solve. I 
checked with the HW team and there are two conclusions - (a) it is 
strange that L1.2 is enabled somehow for I225_LMVP - this is not 
expected. (b) generally it is probably best and simplest to remove any 
device ID checks and simply disable L1.2 across the board in this 
driver. Unless there are downsides to calling the API when it is already 
disabled (I don't expect there are).

--Dima

