Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A771DE2AD;
	Sun, 12 Apr 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776004725; cv=fail; b=OLS1kV/18NL1yllNLMNtxdDJJ1rlxyLrKR5Exa1uQpyFOjiC2Gtthut8WWXqUOP9TfqeD4ThevIFi2DBLmj0QCKy+kkGgkacmNFw9lqBoYXcl+IeCDg5Q7E6paI4tvLvt9hTFUlQpgmiUop+xqsrOhhBMOpPjdba3d9R2/rnXXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776004725; c=relaxed/simple;
	bh=aecgk5veG46ZmS2lSoGe7xWzRUsNjhn75TvW3FtvNxE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gwc/YhRhRZP2dd3bp9KNxfENLTgbEPpigQFeKYe7/iL8gfFkJtZBWSgrZZz/OTqWXIuM/xaIsNtioncoWfcycPXQ1IxrTHNxjSOTjr/wlHxH6bnu0mPYdaIcj1naj+tLaEPGEftwTNNWpdX2LTpbM7wKPQRMjIF+JrV2iY2vpq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1wNkT8A; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1wNkT8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776004724; x=1807540724;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aecgk5veG46ZmS2lSoGe7xWzRUsNjhn75TvW3FtvNxE=;
  b=O1wNkT8Ahz6p9shVTOb35lhK666POcTzGUZp1RclMQkGixdrrs2LJBv0
   lNdgztwGXTuomOcptPn69mM/eSqhoxjik/XvAx1SHjPIHvk1FPMsMOJ9y
   TRLlnOKpvdjO4wyqBUPhD11zUVkpQ7vP08vubWTxJXxfpCxvMO/vFjDib
   4wgSjzJ+GYSNG89YFdGhRgu7m8mURxu77yCTM7raDe4VvKwt/Y/kaaI94
   mLkRZcTgtjdF19REdokWrzVUkRDKw3eFNKrHHBukQFnXI7r5wwKw1Yjah
   LEm6E1ZCX0IwXIPdvV8TP01hV1aMn+SW7qyirM5Wqt8X4+O0f2Qbqw6L+
   g==;
X-CSE-ConnectionGUID: c7410QumSwuxHsvVxCgWqQ==
X-CSE-MsgGUID: +HRDHKGBRI+sePHtImakcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80842968"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="80842968"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 07:38:43 -0700
X-CSE-ConnectionGUID: V6jYS1eUSCaLBrhDeEXppg==
X-CSE-MsgGUID: sPY2mHdbSwi7FUZoQME00w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="228691419"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 07:38:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 07:38:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 12 Apr 2026 07:38:41 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 07:38:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfsgNtNThFJfcXMbTQ31f7dYRjVtNPqvd7uQsaNasx0a/hn12k2oerrdwdnmhVEKfbsyTUYl8sVBX63rlQN3hHo8+sfvdq6BPOKRZmNh8p153s9YkhEmbhjcEqs8pIZRQF1hcz+PXq+/9qu5dkRaEc8Es6wOHoSlMozRUUM8URIU7LUnD8u8bDRN3BK1LlnQtvWHx7M7HJ+yv9J8+JT2pYILvvG+AMhmWYDRYcmxNE/5fVkOF6U1srShpqW5O3AAXmlX94NYt1Dj7wyuDxB8YMQCpvKyV+I1sgkE6IhitJ4ocEV6e1WdmWUssJcsW5Cv7qSgzm/TevlRK8o+qXVIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUfc32/4bwsQ25V2kUG66JXoHK6OkXTGLdVmmbBGKe0=;
 b=ZZjQWoPjikWsWPhj1C2VVG6/6jmotr0rRyJD0mNUsurkWbZMGyAW2IQu6FeVByUjj8Mpg9Fs05G+H2lWsPO5LqEQw+cxy4xkMJr3YtEB3QepAeToXHvn2/KtilI6wolUVEzld3+7/2I30q6A9N7YGDzlMQ5/FToa+eLGf+72wgjyKEc8DLkuJAnHc6T+Zz/Xgnr9gX40ELeP9pUka21BzzIN3z6FELBKTxpryRS9dKqBxWz1ti0H900wS5OdDutGdbUp2xvXxyDgB4IxLuqfn6SWWbnh50rAHEjYOkmvRY7slumZJsgKLw8uK+A1A8kY47xlVkMX2lZvW1NyJR0DBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8160.namprd11.prod.outlook.com (2603:10b6:8:189::5) by
 SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Sun, 12 Apr
 2026 14:38:36 +0000
Received: from DM4PR11MB8160.namprd11.prod.outlook.com
 ([fe80::d873:61ca:d2b1:53f1]) by DM4PR11MB8160.namprd11.prod.outlook.com
 ([fe80::d873:61ca:d2b1:53f1%6]) with mapi id 15.20.9769.044; Sun, 12 Apr 2026
 14:38:36 +0000
Message-ID: <92eb35ca-af8d-4f54-99ea-c0532cace217@intel.com>
Date: Sun, 12 Apr 2026 07:38:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/2] idpf: implement pci error handlers
To: Lukas Wunner <lukas@wunner.de>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <jay.bhat@intel.com>,
	<ivan.d.barrera@intel.com>, <aleksandr.loktionov@intel.com>,
	<larysa.zaremba@intel.com>, <anthony.l.nguyen@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <aleksander.lobakin@intel.com>,
	<linux-pci@vger.kernel.org>, <madhu.chittim@intel.com>, <decot@google.com>,
	<willemb@google.com>, <sheenamo@google.com>
References: <20260411003959.30959-1-emil.s.tantilov@intel.com>
 <20260411003959.30959-3-emil.s.tantilov@intel.com>
 <adnfeAJHoFoaGYH7@wunner.de>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <adnfeAJHoFoaGYH7@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:303:b4::29) To DM4PR11MB8160.namprd11.prod.outlook.com
 (2603:10b6:8:189::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8160:EE_|SA1PR11MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd32382-6f97-4200-f419-08de98a12e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: BE6XjNrvNCC0wmLfUOR+UR+Vu1ek+uE18OLQtGi5RfcJ/nneAomqiJbKDTQpuPiivd4d3GUepQkQngZk1TiPqbeXNZxzMeJKDJjkCiqGpYS8jkXZSg3g1jDAEd6jVPYJxWv85hF7Ml4QNIf+MSvOOsR3Ps0rMxHTno5AEhys73/ud9Lq50Eh06JYrS33Z/dnwn1+AFd/GMJmtqwZdTshniq37QzY/xuLHKVgxDzO57+XwDR7gf+KU1SSMw+seXFkGmQINv/9bcDx8VrmmmEq7eaTV8vOfSmxEmqaJSm53uYfi11b/YjXKo9WGeWmazjTclguPCCBLLDcTGZBDIKVdRZRoZdLYgHaL369OCwhRy6Lnp0e2CJRT6JiqsOenoyUZQy+MR7YY+Y9AwZUjHrBMF7wB3IkbbHPkdGcaRBoTFkORvXtUasVbjCKQhLum2pXKsFLmcblvMO50HtNni75oGR4NInRqiABcoqgYsINjjcWrWDV8lgkHtSlRLP2o+Na5FZk+VlBWpvDxijpyjnOM3ny5iTrc3LjSZf3L7fOvKNfzt1QqXBegPdGSnorQyukxHPXRFy5JUkCWrBSlSVSkjKwlZjRtu5mrIujeh/20Spmc+AbeRFf/16iqaB9WjvJ3vs1crf8sHAiY+eWr2IVmOkj38VU8ACnact5qcr/bkynUCQjIE3qTCj3soGdWcpIOftwMRx2gHrYyV6hXzOJZ/CHflqI69+RyQ1mdZLuLls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dvUm1DQ2F0TW1JYnIxZmlYUmwvK3ZvSE5VL0ZIVEE3Q3l4bk9jcEZlT0p0?=
 =?utf-8?B?dmpESVY2Y3lqZHpTSTA1T3RNTGVCTXhFR0tYSG52YUkxaUI5bnd1ZkhmcFd5?=
 =?utf-8?B?MnFEYW9teWJIc2ltTDBxeDI0ZDFqRDgyVjNkWkFzRW5makt5V3BVbzhrcmRu?=
 =?utf-8?B?V2FTKzF4anFBeDc5OGlrZHVEOWM3bEhNUXZwdlhzLzdMQmZXa0EzeG5Ld0VI?=
 =?utf-8?B?dm9iR1Jnd2hrUnNNazcwVHlOMWFObVVsWmZMRTFSeUw4UUR3Rytyb0QraFNh?=
 =?utf-8?B?MjNtNjMxbDd3N2RTNS9jckxlSE9sbThQdmUvTVprSmpFNjA4K2laam9XRWx3?=
 =?utf-8?B?MFNycU5Eay9VUEV6WFFkSkVzY09OcVFNeFdSckp1TkJXTXl6cmZMbW1UY1NN?=
 =?utf-8?B?ejFPbXVYSW5USUVTYTdFUnJRbmJELy92aVRsdElCOFhhNENxcmtMQ3pkU0pu?=
 =?utf-8?B?VDBUMnM5NkxoeXZaVE1UWnRmT3AxQWJscVhoQzBNL2J5L0RBS0lGckYvc0RY?=
 =?utf-8?B?Nm4wSDJKUldDZkdMOWJ5ZERPUkpCWVA2UWRCcFVmdUR2MW5HdUR6TEd1eGEw?=
 =?utf-8?B?OHUzU1g2c2JOVCtEOWd5bDltdTNBWlNGQUp4WkliOUZwRSt5ZmdjNXhnU0xW?=
 =?utf-8?B?M2gvUnRPalZmaDRMdHpBa1ZtQ3lpZTZwTG85NmJpU0x2SzJsWEJxemtRYnQ2?=
 =?utf-8?B?bWhpbzNkd2tVOGxhdG8xVkxsUWFsMU5PODFyTEtXNDFaSGxvTCt0RXBlcHlO?=
 =?utf-8?B?SUdMUi9MWTNYZDkrbnM2WTFka3YyWmZqZUVaaC8wS2F6NGF6M2EwVTVzZWhx?=
 =?utf-8?B?amJOSzE3NHlHZFMvRllqOENkTHF0NkFGcWlYVkp4cUgvTGlrTmVCZFVnei9C?=
 =?utf-8?B?Z0U0c0liWHNReGludHpQd0ZlcHVObnFWUXZuaXJsVnlsOFlZOWRlT0F5OVJ4?=
 =?utf-8?B?b3NuaTBHa0hqVWFCSElmUjJmM3ZVczJBZzNzeHhtV3Q2bTNjZ2dBakJhdmxn?=
 =?utf-8?B?U2RZMjJ1YjJReGl6ZS9LcHByRTZXT3VyQ2l1c3N1dURKRGJhOE14TGhCSElk?=
 =?utf-8?B?SGZoS05UbW83bkRVbnF5V05KcGxxSkszYjJzZmx1OE9uM1p2UVFYZlVaSmxG?=
 =?utf-8?B?TmVmVmdCTlluMkx2WlFrVGpwMTNZVjUybHYvUkxWQmc1MEFlc1FITnZVKzZh?=
 =?utf-8?B?bTFDakt4S0ZHaUVOUXJ0b2xLaUNPYVM2TzFSaGNnOENrZ2hQMmlKWlFFaXZ5?=
 =?utf-8?B?V1FGMGlmYTMvL1lMZWZyaEhqWmdyQjBURHdpdkZFMVJ1dVF2VW5jWkhjM3l2?=
 =?utf-8?B?U0pjbUZEbTZXaGYvMlRpTkk1RTNtc011U0ZwdTEzeWpRZWU5Yk91ZXg1QnVM?=
 =?utf-8?B?Z3grZmhoa3F2TXBvZ21vVmVDb21KaCt1N1RXelUzVjhMb0JsTkZhMHBGYkQ1?=
 =?utf-8?B?azZoSmtRSllNS0tTdkJPa3J6VXVxd2FKRE42YUtVSkFTZy95UTIwSkpJSmI2?=
 =?utf-8?B?NnNNQkVoMjZwK1BaZkpXSHFqVFFCTHdRUWNDSUMrUFdpVkdOZEc2Tnh2aTlX?=
 =?utf-8?B?MDNhd3hPOFd1aDZwM3NXQmRBN2NEQUJ6VDhnQlNFcDc1MEtlQVZVR3drMHNT?=
 =?utf-8?B?d0RpT0R0SUlQTFpNeGMyeTgzMzFkdFF3RHM3Y3B2TzNpVk5yWHhsWXNiR2R2?=
 =?utf-8?B?SFh6eGdVSm8xdkdCeW9iZGdRaVFzQnJBdnBFLzQxTFE3QnFzdzJJellKRWFN?=
 =?utf-8?B?ekorU0ZNS0N5OTh6bFFOcGUydk5kU01VMk1uV0dsUkI1RmFmdkpaUVlGZ0ZR?=
 =?utf-8?B?MVJwUHlZNUVkaFZJYnVxNWkyb3QzdDMrYzIrSHd6VmVRRVRpL1ZudTVIN2JD?=
 =?utf-8?B?TUpJcHFQOTNacEtvWExyOU53cFRrL3h2MWYzcFRnUTlBV1BWRXlWUlZvSm9Q?=
 =?utf-8?B?NzMwSEtiYTVuRy84c3QzbkNQcS9aOHl4bW9Vd2REa2lETFJyZGlySTZEZzhp?=
 =?utf-8?B?ZW5OSzhkMDRsVHltR1pXREdRODI4WU5hSVhCZ3lFTGh6dGQrZzZWQVFHeHF1?=
 =?utf-8?B?SWdRejhCRWNMUkQ0WEpHVjF1aWdtTW1Zd25XNGNqV3RLeGVJSk5yR1FQaVdw?=
 =?utf-8?B?U2ZZVUhkN3pybS85eTR4T0NuU2NXdGRRYjBrbVZPYldHd2tON2ZHREpKdEs3?=
 =?utf-8?B?YWpSaGhxM2NvSURWUjFDT3JweDV4dU14Tks3OUZNRCtUMDZRWnhON2U3Mmhn?=
 =?utf-8?B?SWhZRFR1R0x2eHBiUUZ1NStIaEpsUkJ6eEtOV2xOQUtEdDd5R3ZWR3BsL3pS?=
 =?utf-8?B?WHNxODBPZ1F0NmNYblZDamF1WHdaUjRQMVNBd3hqd3FESWZRTjdNZz09?=
X-Exchange-RoutingPolicyChecked: jX/F8l6tNV20VvcKJy6OInwM9GFfaroKwp6FBKjd2d40truWDWongXEuXtNbg1yQZZ0tRDhmV2S8WbDtWpQvcTAhA9qOTQYpqhCHsv56QB6cATv6Yjjor+rk3sNxlNWJpJsmLvMVaeXfdSHqTdwYhiEJlyBzqrdoMVGT2HFtw6xN5EzISWgO/cTAL2n3/W6iQcg/QWFIW+rFSIMGWfeIFH8mvykBmzg1y9GQSs6WABBykhZBbU/S5EpFkdWh5tRAD+0Gr11mvvrKbS74cgMeQWFvNMDACUoM7V29thjzUCrr2g9V7w9Jcv+Kue8mXZc+gKFSQtrghaVN+nZ3WvaESg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd32382-6f97-4200-f419-08de98a12e36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 14:38:36.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T2CTyLqNKyAyC31LqoCBiWhQ85sBkAUjsWUSnPfwGpYb0Os9u5TMtCd04PyG6CBaOs91TMY/PUTD0uwyKeouIEVg42h2wbJIkqKomUux2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
X-OriginatorOrg: intel.com



On 4/10/2026 10:43 PM, Lukas Wunner wrote:
> On Fri, Apr 10, 2026 at 05:39:59PM -0700, Emil Tantilov wrote:
>> +static pci_ers_result_t
>> +idpf_pci_err_slot_reset(struct pci_dev *pdev)
>> +{
>> +	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
>> +
>> +	pci_restore_state(pdev);
>> +	pci_set_master(pdev);
>> +	pci_wake_from_d3(pdev, false);
>> +	if (readl(adapter->reset_reg.rstat) != 0xFFFFFFFF) {
>> +		pci_save_state(pdev);
>> +		return PCI_ERS_RESULT_RECOVERED;
>> +	}
> 
> The pci_save_state() is no longer necessary here, please drop it.
> See commits a2f1e22390ac and 383d89699c50 for details.

Ah, the state_saved check was still there when I last checked and I
missed this change ... I will remove it in v2.

Thanks!
Emil

> 
> Thanks,
> 
> Lukas

