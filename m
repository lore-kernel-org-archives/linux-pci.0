Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E11E5018
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765634; cv=fail; b=S2kZu/zF/DHq2TsjPFyndvro4S38ZY7G6X5qzboJ3Ww0LSqe3TcLCUtsdy9ag2ANK0+fpTiPcq9KePUNytDzOnTBgwgWL2r/DAjDqELcnKHqvQekusRiXvxCmP+LN8TjWYu+HmUShJW9HRlwof/X9dpN35fXVg5HdwK5l4ugffo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765634; c=relaxed/simple;
	bh=qquLAvqjmjOATdNybcjYC4TTYPXJsF10GcHKlFD5TOw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=REMt85s0UISieaTOBoU/lTl17fR90hZG2ePNOyUvBK0xPizZ97Ixeuwpl1gWudrdQJaAJiqOHDXLA2eoUE/30QDXSlrKkH1LOkGWRNr5pPoHHp/VCccniq4UGfaYvQrLZz4z4dsTzlEmwl2HptVU5GjMGtTegFWsf/hivL0Tp5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8HavwFT; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8HavwFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785765631; x=1817301631;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qquLAvqjmjOATdNybcjYC4TTYPXJsF10GcHKlFD5TOw=;
  b=j8HavwFTvoF7JkGnStt8NOAtZLWahhoaQVDuuR4C+XwcuT2YeedlAvy8
   5sGdHsENF8srdrdUbdjXi6kRNxo846PPazcx67paiMxcESCZ7nEjwu5O/
   Q9eTgGn+EPYta5d6RZ97UtcwsU6ZL0nyof0DpmGl3M2zkW3PB7+Njnm18
   e7IUeKABFUvSekOm0Cd++2HbYxls+01N+hgEvPdAbhedLZ+k3LmYZ2Zrp
   ogSoxKkLfosWOTUyVAnqSG6IC2qTpRyCTEkaGuu/XrKVfbSx5qQ0zJtSi
   cvBvREtzIIPPP10RHIEKdhwhWcMnvTCD5/t0IAl9NeOzK9AroK3sLsYaO
   w==;
X-CSE-ConnectionGUID: 7x/dMrXzSja74dlVNMhoPA==
X-CSE-MsgGUID: A4CO4AxOS8KVT4gCqeyutg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86421786"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="86421786"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 07:00:31 -0700
X-CSE-ConnectionGUID: agqmUFLVSG+44S5ewaVVBg==
X-CSE-MsgGUID: e0waNpEdTpWs4NzpfB4kfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="264700312"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 07:00:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 07:00:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 07:00:29 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 07:00:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEZOBbjtNM2x+BjnVEo0SY5E29dZLyJUQyDRsE7E0uREMD2rRzg+FZvC+nDa8cyg/GRqxvi3ixTqHLubpWui1p+n4gUt70fvS/YJ8dZykxllrSvTuOTKlHvQI/Fe1/Qai6F5oI4QqnHRE3Gjlz0r3eO1fIb32QKJiIfbIgZNSLAfdIQtQozhwghCLd2bulm85T7aGpP2SqOryMNYYyvbwzA1Q4NwwqFGA+spv2vnJvdOi5kNDKRkj2qgOL0E7+bpojXRhRlN4dWl0Lvg0ylyTzPfAmB9vz4ke5rcPG2TGx0RHvRxkQj8mUTbe985KEw6I+0XElOv6pPjyNSVJNU5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWAGflaRJnH1ULoNysMImLPl5odmDhUtgJENoY9dnBw=;
 b=k71YVcY4oBzI2FLGwa7EBXC+EST3/t7+TIiJBOIKlsv8JJebdchwCCXXLelUiplBd+XgM+w2Smsiq1j91j7JhTdG9Hv67shta2rhM9VIFQX0+a74GDF0iEw/X1hgr9o2xYfsAyS6SsVusgAxsOYWZBbA/Gce3Oj8zzUIKEKKoOgDUcDjYnTvynPfLzmFT/tkU9dB17Az+QcRFyYFmYUhj59hc30VQCya/YHpTvYnVzwyrlDhMqKMvFXClqza2jv5Ro9vLlLaqZ8K5V8PXe2+DMk7ks5nvC/64LDPi+T6IMQkSoMH8jyeeh/+wWOOHxjRbUDaGA3bG1IgctBbGgpe6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:00:26 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 14:00:26 +0000
Message-ID: <cd96321c-3ca2-4b11-95e1-17d0a411ce8f@intel.com>
Date: Mon, 3 Aug 2026 17:00:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/8] i3c: master: Fix recursive locking during device
 registration
To: Frank Li <Frank.li@oss.nxp.com>, <sashiko-reviews@lists.linux.dev>
CC: <Frank.Li@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-i3c@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-2-adrian.hunter@intel.com>
 <20260728161935.C236F1F00A3A@smtp.kernel.org>
 <amkJi8010zem-2O9@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <amkJi8010zem-2O9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0290.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::28) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: c584f9d3-a8eb-49a5-c906-08def16791bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|56012099006|5023799004|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wybxTUxZWnp/YZA+3KNWBY3pft3Yol3DjHieFQUAUVYgNVqqnH2oNhwIa38ojkPgKUD6SF39aWi6kHVqOlRNzGQv3a8atdZy/abP5As3HAMTC+pGB80YghT2kwea/KFp4v7y/FHx8HDnIs1nAz1f9mtl+kK09tIrFeLG7S4khK1eY6V+U943YuD18+dY6BZx6zHgqpcES4es7jT3XQjmrrUyVUV2LZac/ds3Ew3HKIGQxXnjjwvcIUGhk4OwrUlD4MVHSbBFp3khfNBDOJiejwlqJtZXdshInfb0NoNr5cy82VP7yS/stwcxHqCY/dic1+aQMx6UJnwKJjmdodd6Gfm4diEm1BE30Jueggq/1H+Sc2M1T5lyaveqPj+x06lVfE6yxD0hzaqne8wg6ImXIh/LBZXE2Vxe71/tKXNqJsHhpnYh1oY4bZzwFAorLXLPayxkosKYJ9aKQgLvy2mYqu8etUyeEeXv5JAe9SiaNpNb4XRsBdHzYyRFIrrLoM8fU0xxcdF3LJhknH/kdFIUEBBeSfM7JXXvk2ruFqdA97WjjYBdJgGDgA+K34lU0p4PMDafS/nq83Ey6rV4HOhdDO5iFNMpTsMorgVnlECR9YY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC81MWpZUDBsdkE2M0pCNi9wenlNQytRNWVyNlc1d0ZaWTlidkV3ODVOVG54?=
 =?utf-8?B?U0FLeGovVGhwNW01K1VzdWprUGs0b3J4alVEOTE0VnhJMG55bnZMWDM4UU5h?=
 =?utf-8?B?TUxrUi8rKytCMm5kQkNwNFo4UWtpVmZLUk12NEJvZ2dOaEtkNE14bWhLTTRJ?=
 =?utf-8?B?U2QxRFMraGV4R2FqU2dHY0tuNmNiZEYzdHhJaG5tMDBQUFpVVnpqcDV3Qnp0?=
 =?utf-8?B?alp3SG4xR3NqRUhaK1FvNWZTL1lDSVIxZndBTDhjSHhqdW9Dc1ZjN2crUFhP?=
 =?utf-8?B?L2NsNUJ0Um1MUC96eVdKaDlUQWNGd3RBN2lxZk9Qc0FJdnFQMnZKeldnNmFL?=
 =?utf-8?B?S0dCd2ViZUU0ODFNa3hpWmsyVTNGeDRCMlpKejIxeWFFOER0REtuN0E3Nndz?=
 =?utf-8?B?UDVRRXhpWlE5MGtuckl6YXM2SDBTeTJWSnZxNmRVVW03UEp1MjdORlh5NzZy?=
 =?utf-8?B?NmNReTJJcEJPc2FRL2s5QmxCUHlRNExTYXk4RDFkQnlyREd5OVZrSXJWN095?=
 =?utf-8?B?LzZjRitIU1U5YW03ZThKS0VUTi80L2ErWW9jc1JhdTRFTk5hSy9vTE1KSENx?=
 =?utf-8?B?OVBmcHVtMzRXL1RmMlRIMlJvNkg1b2U1ZjJVL1Rrc0xtZkJTMEZMMEtuNDVK?=
 =?utf-8?B?NklmSUpFQVZjNmJ4ODJuMXhzUGhDWk5rS2dVbmVpM0JCV3NWOHpONW9lcklD?=
 =?utf-8?B?eTVUYVUybW4va1VCbWVRZUJoSExYQWk2ZDV2amNLa3pnOFMrMGFxYThKWXVM?=
 =?utf-8?B?Y1VUMUlmN204SHN5L1VCa2h4STJ1NXRGVmU3Njh4TDdJMTVDTndmRHB3TnpR?=
 =?utf-8?B?R0htNnRMQk9IeWhhT1k3TkRZUWt1ZGppclM1WGZhMHNhejlGL0VPbUQvQ1B2?=
 =?utf-8?B?VjBweUpYY2VVTGpaTEVGcmdJd3J2MUh0SFFGVXQ3TXloaHhQam9ORkhxSEJp?=
 =?utf-8?B?d3oySElMMUthT1YrWWp3UmpZWWNRZHBKMGdJc3ljaGVEa3lGaVhMSWZNeHZn?=
 =?utf-8?B?WFJCSE1UVkdqak12U2lNRVVLWHJiaVB4d1VwRXVmMjArVnliK0ZRRzl1RG1a?=
 =?utf-8?B?WDRRTXlhNVZCM21WZlJKMUJCV1hkd3pMNSs0WE5hZXhaY3ZpN2laWlFWbW1r?=
 =?utf-8?B?NDVvZkpNanlpOTIvei9DbmlFMUVPUkovVElmUk5qdGhlejQ2R2tha2gwWFll?=
 =?utf-8?B?MitIck9KY0dvTFRLSDdFbnVkU09PemdSQXFZdktDTCtUZWlmZnRzZ0w5SCtV?=
 =?utf-8?B?OUdXTWJDR25Sb2t1QytyWHROdHZYQW5wWEM4M2VPQW9qVExZVVhWdGI1aXVN?=
 =?utf-8?B?SmJnM2U2b1VJR0tPZzhneTViRmdHWThlMUM3R1o5b2phWU5XQ1A0NE81aEJh?=
 =?utf-8?B?Q0FNbFp1SVhHT1gxL3dvVEJLRFpKOHhwRTZJZkVkbmNzWU9LTU5LQ2hsVVNu?=
 =?utf-8?B?Z1RTVkY1M0htangyTGxNdjAxMUJLRFgxa2NpZEtFcTJod2hUZE9tVllJOWhU?=
 =?utf-8?B?V2l4VzNXeTZoWDVKeTNKYnc5UHRSSjkvVzBjRnVOd3FxTldmZEIrWEh0NFBB?=
 =?utf-8?B?T0puemVhRmwxT0RVa1crTVA3UUtYRktPYzA3WDR4VEFRWmMxUlNiZFlmamEy?=
 =?utf-8?B?cHpmQTl6bnpqOXhqNmJsblZLTG5mQmhmQnd6T01hd0E3enVPdUZCOHhBTEh4?=
 =?utf-8?B?QjRRSHh3WGZNV1k0ZDJVZmlrL09xK3gyanNveUpVZ01NQ1BBbXhnbHVDeWEx?=
 =?utf-8?B?R2QrZXVsT1JTQjJ5bkQ4SEpXazQ0ejVwZmxDYmh4NlZMalZlWDhBc3lXc1Jz?=
 =?utf-8?B?SjBGMFp0b3NOeWdweGZJK2JwbnlvV3dTMWhKc2xSNVdoVUc2OUNSdjlzS1oy?=
 =?utf-8?B?dW9EMXpUMkZwUzdOWkR5a0xCQm1uRDJiOUdkSTJ0alFBRkdzbmlVWmJWT216?=
 =?utf-8?B?SWtkM1kweEYzOUJzQTlzRnZxbGVHTWRVYmNQWkROdFFGajJJWllCK2pTMi9C?=
 =?utf-8?B?bmEvbG54a2JqcHlUSzZyd3orVEVhYVZka2VSV3BGcjlTR25HY0crUllOc0lI?=
 =?utf-8?B?V3crR1JoMkRKeVFseVpZNEk4R0ovM2c3VnZwNmRzeE1wWENZdlM2RXB0OVA4?=
 =?utf-8?B?bUJ1V1R3Smh5K0pBemJGajQvaUt6dVhkaGFpVGJmaVlkbCtwRFE1MGFteEhN?=
 =?utf-8?B?TDdTMEhHVit4NHFwMmFFMXArbGlSTXMzRU9lVkNURHNtdGN1QnIvZXFaZ3hO?=
 =?utf-8?B?TExDUUFiU3EvL2pHR1dHMWppUkdxSEhUS05oYmNpOWpRRS8wcUEzOWNMbHRy?=
 =?utf-8?B?UUluRUpDa0dJY3NsVEJqVmc4Z3Z6STl0QmJvNVVEcFBHZjN4MkQwRm1QNFht?=
 =?utf-8?Q?9gTYAtCmYgkvQBO4=3D?=
X-Exchange-RoutingPolicyChecked: VFvGu+2cFZjmPbQGi89uF3ZabURnsp8ugrytcF8zlpesoBBdpexyyf+M6yDeiG9dFSg4kNRoFXY3L3l7WhCFbfjKR6PsKRCsgR6bhSucyaAnk2DX9EA7WmYI/4WU5W5J0sIK/0TXLE2TN6g5ScMysid3mHuEq72RpTtV5XHo9ndZtXN/RjJLBMzFk3PmENODNgCbShIIt2tAqYMOk+Nuw8fEfW4wUaVxkapeqcaVbg4vXf6mMLpt+SLW0svLNNVE/QStnTG55FMTx1uRTwPm3A2PJKrRr5ABh6ADZoLFiwlBA1/oAZVy/dDcESA3/KL+lDfPrIy4Few2TtcMSnKYHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c584f9d3-a8eb-49a5-c906-08def16791bb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:00:26.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPv3ZxAT3h6bJbhT9JCW2sMM4WZoIywzHbYQ8rnLkiejCjBD7I/kjtQ/N3vZT2Ybz46qanZHsyrMbUymfqEE2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com

On 28/07/2026 22:56, Frank Li wrote:
> On Tue, Jul 28, 2026 at 04:19:35PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> New issues:
>> - [High] Dropping the bus maintenance lock around device_register() exposes i3c_device_uevent() and driver probe functions to a Use-After-Free if a concurrent DAA replaces the device.
>>
>> Pre-existing issues:
>> - [High] i3c_device_uevent() leaks uninitialized stack memory to userspace when i3cdev->desc is NULL.
>> --
>>
>> --- Patch [1]: [PATCH V2 1/8] i3c: master: Fix recursive locking during device registration ---
>> commit 33a4dcd6c5626faef95bc7cd02ec4c56c6710c78
>> Author: Adrian Hunter <adrian.hunter@intel.com>
>>
>> i3c: master: Fix recursive locking during device registration
>>
>> This commit separates device creation from registration to fix a recursive
>> locking issue. It drops the bus maintenance lock around device_register()
>> to prevent deadlocks when probe callbacks invoke I3C helpers.
>>
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index fd3e79d10c840..874f6e11b296d 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> [ ... ]
>>> @@ -1999,25 +2008,37 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
>>>  		if (desc->boardinfo)
>>>  			desc->dev->dev.of_node = desc->boardinfo->of_node;
>>>
>>> -		ret = device_register(&desc->dev->dev);
>>> -		if (ret) {
>>> -			dev_err(&master->dev,
>>> -				"Failed to add I3C device (err = %d)\n", ret);
>>> -			desc->dev->desc = NULL;
>>> -			put_device(&desc->dev->dev);
>>> -			desc->dev = NULL;
>>> -		}
>>> +		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
>>> +	}
>>> +
>>> +	i3c_bus_maintenance_unlock(&master->bus);
>>> +
>>> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
>>> +		ret = device_register(&i3cdev->dev);
>>
>> [Severity: High]
>> Does dropping the maintenance lock around device_register() expose
>> i3c_device_uevent() and driver probes to a use-after-free?
> 
> look like make sense.

Yes, but it is not new.  A plain sysfs read like:

	cat /sys/bus/i3c/devices/<bus.id>-<pid>/uevent

will invoke i3c_device_uevent() without any lock.  It has been that
way since commit 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead
of calling i3c_device_get_info() to avoid deadlock")

After this patch it should now be possible to take a lock in
i3c_device_uevent(), or alternatively, put a copy of pid and dcr on
struct i3c_device for use by i3c_device_uevent() so no lock is needed.

In any case, it is a separate fix.

> 
> Frank
> 
>>
>> If a concurrent I3C hot-join event or a sysfs write to do_daa occurs while
>> device_register() is running without the lock,
>> __i3c_master_add_i3c_dev_locked() could find a duplicate PID:
>>
>> __i3c_master_add_i3c_dev_locked() {
>>         olddev = i3c_master_search_i3c_dev_duplicate(newdev);
>>         if (olddev) {
>>                 newdev->dev = olddev->dev;
>>                 if (newdev->dev)
>>                         newdev->dev->desc = newdev;
>>                 ...
>>                 i3c_master_detach_i3c_dev(olddev);
>>                 i3c_master_free_i3c_dev(olddev);
>>         }
>> }
>>
>> Meanwhile, device_register() triggers a KOBJ_ADD uevent. i3c_device_uevent()
>> reads i3cdev->desc locklessly:
>>
>> i3c_device_uevent() {
>>         if (i3cdev->desc)
>>                 devinfo = i3cdev->desc->info;
>> }
>>
>> Could this lead to i3c_device_uevent() or driver probe functions dereferencing
>> the old descriptor while it is being freed?
>>
>>> +		if (ret)
>>> +			dev_err(&master->dev, "Failed to add I3C device (err = %d)\n", ret);
>>> +		else
>>> +			list_del_init(&i3cdev->node);
>>> +	}
>>> +
>>> +	i3c_bus_maintenance_lock(&master->bus);
>>> +
>>> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
>>> +		list_del(&i3cdev->node);
>>> +		desc = i3cdev->desc;
>>> +		i3cdev->desc = NULL;
>>
>> [Severity: High]
>> This is a pre-existing issue, but does setting i3cdev->desc to NULL before
>> unregistration or cleanup lead to leaking uninitialized stack memory in
>> i3c_device_uevent()?
>>
>> When a device is unregistered (or if registration fails and triggers a uevent),
>> i3cdev->desc is set to NULL. This bypasses the initialization of devinfo
>> in i3c_device_uevent():
>>
>> i3c_device_uevent() {
>>         struct i3c_device_info devinfo;
>>         u16 manuf, part, ext;
>>
>>         if (i3cdev->desc)
>>                 devinfo = i3cdev->desc->info;
>>
>>         manuf = I3C_PID_MANUF_ID(devinfo.pid);
>>         ...
>>         return add_uevent_var(env, "MODALIAS=i3c:dcr%02Xmanuf%04X",
>>                               devinfo.dcr, manuf);
>> }
>>
>> Since devinfo is uninitialized on the stack when desc is NULL, could this
>> broadcast uninitialized kernel stack data to userspace processes listening
>> to netlink uevents?
>>
>>> +		put_device(&i3cdev->dev);
>>> +		desc->dev = NULL;
>>>  	}
>>> +
>>> +	i3c_bus_maintenance_unlock(&master->bus);
>>>  }
>>
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260728155308.142713-1-adrian.hunter@intel.com?part=1

