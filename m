Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793071579;
	b=t1RmYCwrMnzMq25PBtCstWnTrfei0T1gK8FBgYzsH/fzZM2ae+/7lIVGjll0vHRaCJ5r
	 FWLyO2FWzwPWAkPl4qa/NA522hYEUPUmetJmWIF8bTALH10DEH+Oukrw6AgM2w1s0V33Y
	 lc3IQxQlkWb+uIXgBsEilHsX+J3vHH7XX7+sojeIwbvU6EtPs98IclvhdlA2wBbGanOu5
	 7KQN2+AxVTqbUMv39IVDU72Spo5+E0YjgdFYcATaJmoPhym7Q01B8ETl8BtIZr7o+pH74
	 89G294c5IQpnV6Z4dvvbLYt8bu/aSOP/bivVbJegxYOHfk8Nc8AFJmaVIN+zHS04Ipw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071579;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=xbV/bFCgv0v5LDAvlUI2Vron5yPEZtya6Merv9AgFmg=;
	b=AQCPtsV2M9ot6GVVy9atgX5aSNTBDWcZcXN3pxyifpzkin/JEqniSTlqdlHN0n86AlFq
	 G3ip9Qu9+ghrfknubJP+Gx8vbY1eno10VtUeAJyDm0cdhm5lvuO1Iv/ZIRvj6kFDbIcRd
	 a+BWd4QtK0MNfWDFqayxBH8TjTW4H3nNnASfsWECX5JbQCbnoEoJO3Xv/X/KWJMyF2Q2u
	 /XzCQ7VFFYbWmdv9qtv71xK8yK4vVwAA6ObDgFhwqULtxB8o57vUl9T3DmEPjXAtI+G11
	 TtiT8Wjlve85SyG6JrJWnecPalqZ/4Ga5WmkPaCLZ6gEndNBugXMwD6FQjCTcGAlh5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kYv8Qjt1;
	arc=fail smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621DB606A31A;
	Tue, 27 Oct 2026 03:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 621DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kYv8Qjt1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793071578; x=1824607578;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6W58db0ju+iCyU2sDwg1NZRQ5iwwgCFFX6FzoGQOyKQ=;
  b=kYv8Qjt1hk3/9i9/uFEWxCWfj/rn3tdiwUL5pXYdWXVtOFXLL4DBCDT6
   rjV6Fu+wR0aa0Ql+sQu+syv78Gf5OrlNZQEanx0DdSrPmDEzdu1t04GQS
   T8kNCMurC+Qfwb+t0HqAWsUkwSP+hiSLcXrmSgpx2TYrnV6TiPo8Iaxd7
   KH8FVQ6YEP+OjnasMRKioLQyJCqc4TA4GakiKmFxCujoqZQfQmtBz76rj
   7jaeR1WqKuUDD8iQMd3dwXdfOtbf2enClZAok1+3BBZoAc5YjR15MzTD8
   DlMXDPwDloVPyRg91J2iGClcFdqs/fj5Kla4EM1cMUcJLcsRWFp+X9+xS
   A==;
X-CSE-ConnectionGUID: XQSuics+Qk+BNp/o+bT3kg==
X-CSE-MsgGUID: CZgyZ6xOSI6Gv4/9nsHOTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1638171"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1638171"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 20:26:15 -0700
X-CSE-ConnectionGUID: 5LpQwJTxT1qQZJlpXbYKZg==
X-CSE-MsgGUID: 9xe78nVuRym9Ksb5wafLKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4583741"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 20:26:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 20:26:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 20:26:12 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 20:26:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgaQtpLWcsPARFD2GYVFStgQyRNZuN33rF3+70PwEitvwBFsPBzCGxmKh2HJ9vFMMBSb5Sa8RJrfBTBMIPQbH342F4DaNZCquLQOM7rDRlTIlxXL51gnjxYgooy4N68x/V1ZfD43LK7MbrdXbFFJX72xNPPGIx7hlZVZ34Xyp3ZeONJUwlzgyU0mXevQa5az5WJxfxaVQSbpgU1kCBr0Ehn3Sc237UV6uQ93kS6qlkhGSdt4mO8nKtn+lKbdgU+BNxpTH8YU4s7Ggf41CqtVSikK2NXGFtFlasVYqzlLPTxcprIgE98kz2ux5pBM0hAGWg7GWud6jNfLH5armA4G2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbV/bFCgv0v5LDAvlUI2Vron5yPEZtya6Merv9AgFmg=;
 b=VEpUvow+xImMY0lesvd1O+TBzKdASoCl/JUTj50OyXgQ+z3kljng7/fASDRLQwyiACWNSV8LgqY5FjhYpu0Xtk4d98DqEP/9fkgKHFKnEnNv/IBNw1fim0QOcaqWtGLVvEr2ERx/JtHqouVvLgdk9Nd/TsJJEd8/B7/dyWfkfF4yjvk5uUhvxmUmWoLb2ahHFcOUUKvGmcTTKnlpZ7jKKdXNFQ9qb9r/yUMAy0z7hCT4hnVp4smQXZG+fVlpgSuq/qs73lKTD4kmu4hGgG+opUz2JV+D0ZEgn2cPqqz2rKqsqdeZdh99Vy10cOPtiCXpgEvMLFzN2PP8gK9beQBwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB5994.namprd11.prod.outlook.com (2603:10b6:8:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 03:26:09 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 03:26:09 +0000
Date: Mon, 26 Oct 2026 20:25:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v15 11/16] cxl: Validate and synchronize HDM ranges
 around reset
Message-ID: <auAZxpEJ6ojhu5gW@aschofie-mobl2.lan>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261011021422.3428136-12-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f0d33d-2016-4cf0-1de2-08df33da0ad6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|6133799003|261026121527099003|18002099003|22082099003|11063799006|56012099006|4143699003|261021121427099003|10067099003|261022105027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 8IglgZM0icuA3paGKurAMa7EAnUJ+dk9QiYOSc0/6Llm95ZWtvAIFsc0JneDp4pAnQITQMK/gnL6FPu1KUD2hIOmHDo4L3zY1oMNKJPBzZP9FTpgHHcPfRuh6+O+jM/dyOjvzYCIvU2qDCzeQcKp6g2DtaQC+xGUyZDIgJZycF3VHXmchdMrDY7TFpIJqf3NCiNrTkIT66P6Yzi/2JGBicRj8nLH98NGWEMkZS1YxjHtgazSZWHEcDemOa6Lp0YEX4VxmouY/NRmp4h0L/tUDniWHmdqXLtBae1ONQFnIPpjFHtRocyOTUBLIaLFgQG5aHB5UGsahaaCm+MrRWuVpZaVvNh2I+0EYeO4qzzRL1omj1OoBjS2rw3yGu3+ebMjPgQsYNboF317UxNrxcwZF/NGlVccwynkDYLpMfzQnDbjhrDPjy1P1OwSspYRW1vnbNxSxvjGhFMScMa7eonFY2ppILHIVmTl9ysw6kOzd3TCmMC3TCs62Ku78iLWs0KA6njhRBEHqiWz3tw9NKqayGEeVzOiFeNwupOneNofpSjWW4S9Axy4vhe5eCQ6j77f6o0Bkv1IsdWEPbZY4f1CooWJbo1ApwcrZfl99o9xC5kMQbtnroRfP0PQhZ+FT/inLeXJc+OVGjDBuBoXqhnKINpzMjTaN4Gdd+IfWQumw+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(6133799003)(261026121527099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(10067099003)(261022105027099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItitbzCBrWg4Fa9PZgDPMioYWMxmonR4m2GnHAdDyFE6Xibd6Li7NRXYUPR3?=
 =?us-ascii?Q?YpFXf7Rrqsht1TWus/v5gIIryQwuuY68kDOK0MDn/sX+P0st9PCfdvsW7+Ua?=
 =?us-ascii?Q?lUPjY1AU8gu+Pk5TR6TiXSpkAxpYxBvR18UDBUQUcwK02jCtkCzlZ55/+dK0?=
 =?us-ascii?Q?+MRatVO0FQryiO2HWKjytNISnxZznRB11qXyAXFxu6yrFBJNyuW0n8K+r3JF?=
 =?us-ascii?Q?HUdANuug7Mj12qxC7YDP/P7D+BtNtBrHFEgUJWO0JL0qf7cqi1W6ofTEOWsw?=
 =?us-ascii?Q?lvyMKIkZLgIcjt8LBEcikHpK5wnZ3tazSI9Ydljil8m56EyBfCJp8TTcPUDf?=
 =?us-ascii?Q?3+zNPozhR1ZCQQEAnkGo5u6GABiP8epSD/ujHQHRioz4oYnqT9RC8kydsPCK?=
 =?us-ascii?Q?xTkNsv10M8/P4nQqFYHDSt+fPqYNTbXBVkc9V+av3wsAgBJD7RBgraANbr3J?=
 =?us-ascii?Q?dmQVKsCecKdmDOelkmI9v7gSPC7zIzPFmYLnlN0DAco98vbjUlQkUj82VZeg?=
 =?us-ascii?Q?qXLjIdKuyyyfDFCjsn5UwNIcl0kMvmYSOF1M/SJlf3wfogIc6YFrjyT0yvaA?=
 =?us-ascii?Q?carPMQGbenayJ2pAMBD7iMYtu/czo7FU87tNS7Ml61t1UoiZFlADtfCmok5+?=
 =?us-ascii?Q?9uh2WNYe0F3dAubyPc7Z0FsG34EEHAuoGvcUzx50pDr9sh1YFejxyLWxVI8e?=
 =?us-ascii?Q?AJRJTKIp3DfUooZ9jLIMVLyFJLsRNLgEyG9Lx7YhmaMx5AIgQ3jiwUYiJc0B?=
 =?us-ascii?Q?Gyy03v+cwPdzkmrNNcZ3T3/0SsGZCXLEe4cS09UzpfrHu9IfGwQCQs+0qDX5?=
 =?us-ascii?Q?NJg9ldOcT2lqaF6xbrBS8V1HjrqGZ9hvTls3MJq3v+YUrOfFGlASWK7HYeVk?=
 =?us-ascii?Q?c5sXRklUXIVCq0e5yVvkGbgiGWaSu6Vtc1kkCmBtJzgTF3GVJTweNwCTTxDM?=
 =?us-ascii?Q?clIsI/gWyXukGY3latp2lJKZ+q+1QuU/BLjw6f9e+84Ot4wIntJe+18U6NiM?=
 =?us-ascii?Q?TztijaEMoiI5dPppxrZ5zAWLellvmCWxZmUZz375SFKUwtwM/qyjG+XMqpgt?=
 =?us-ascii?Q?2if8Bvk60VCykdLVX7eZPrvHc60be00VFXN5RqdQG+u7exFLSZOlBcKdsAqQ?=
 =?us-ascii?Q?VkqSboN9/d1FolueDfz76jWExhbjO77yIiOEW9NPxi/gWT5BkYlCXbBhAyb9?=
 =?us-ascii?Q?yt9ElN4NC62N/XJ5o9fQyibPMzvZhLin5Z9DF7E3eolWDwx8/8TgdXYXM8cb?=
 =?us-ascii?Q?OmBoFZMRYHWgoaqY0virrpcTLbzKTFjgx+soYj6PmbYj4hY2//c0xDycwkSM?=
 =?us-ascii?Q?O9EVmQBJbV6kBsVBCgCmb6/TDk4zLo9MCqzM5M8RYb1JFddyHCqGGUvxWySH?=
 =?us-ascii?Q?R9JNUVTlLbTIDMVod/+Sf4kP/NQy9ENdlhR9KVFruwZCJaGnkNPPIzDSfuoj?=
 =?us-ascii?Q?ymi1j3Qv36LH/Sb+n6nmYUqdVTz3TRr1eotX49W5FiVJfyvaUDF24cy0m0kW?=
 =?us-ascii?Q?PrbMVxifZo2YQnTuqydhzI7PMoliTReoH7Aknu5/zMXgn6EEjDMgGtocfd46?=
 =?us-ascii?Q?6afW6hmPbyc4qKoua8VvXhS65nE7QR3T0lyu0uvWCddrWZDXUspPcHLWa8yb?=
 =?us-ascii?Q?/DFk0tUPen/mnHZZ2dosXD67n/tvwyEQ9fAHvMkHIoBxi5+quQOe1w15Nttd?=
 =?us-ascii?Q?qUf0r18a5TgmjwbXk7niDoaV1N4p+WNf7q24Y4a2m+tvbdpq14iDHPJ7Zbrs?=
 =?us-ascii?Q?unns2fbyMRwPnp2hdcLGIX7H2dqJA1E=3D?=
X-Exchange-RoutingPolicyChecked: f0F2l6JSyLbMBock/3M9mnj3WDqTCxn0WgRpaurmrhYaY61+jAMh2b4Nd0CWPJ7c6J5KMSKKxidwTaro7cI/awrODqAnoSsTZpfIDudNpcNmEWgIH/D4DZN7XNs/+r22LJw2XlON/zIwYwL8G8GySsZJMuj59X6IiibIDUFuuA0ZUfu6j12ZqF11SKQUvKXOHlxwCRmV8Ot+PoTBgNi2Hv5FNkf2s7XVX/GpIYXMSeqhF7+uKhWCqWK1tXOyM05mhiSPbq0UHHFQ9dYWVvvalv15vjTk3x/RwrQqTYLyeOEOzctieTsfH1o18O9gHSEmElo0YemVdfSJUXyCbnHhwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f0d33d-2016-4cf0-1de2-08df33da0ad6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 03:26:08.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUJOLShe/cO+ZD9fp1H6RUaUzBRVp69XuxkPXjLWauJmPfu7tVYl6TPf7lG4n8bjk2LbK8pCjuUGczj5bf09+nAEQDcIc7N++iKtQBgPmPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
X-OriginatorOrg: intel.com

On Sun, Oct 11, 2026 at 02:14:17AM +0000, Srirangan Madhavan wrote:
> Refuse reset unless enabled system-physical HDM ranges can be reserved
> exclusively and CPU-cache invalidation is available. Invalidate before
> reset and again before ending IOMMU exclusion, holding range reservations
> until the second invalidation completes. A later patch places state
> restoration before the second invalidation.
> 
> Reject normalized-addressing decoders because their cached ranges are not
> system physical addresses. Ignore zero-size decoders because they map no
> address range. Refuse reset when the device decodes memory through its
> DVSEC ranges instead of HDM decoders, since the cache holds no range to
> reserve for that memory.
> 
> Provide the range handling as a region quiesce in built-in CXL code. The
> quiesce lock blocks region commit and teardown for the whole reset, and
> the HDM state copy taken under it supplies both the reserved ranges and,
> later, the state to restore.

Hi Srirangan,

Is above statement underselling the potential impact? The quiesce is
cxl_rwsem.region held for write, so for the whole reset it also blocks
region and decoder sysfs, region probe, poison list/inject/clear, sanitize
and event record tracing, on every CXL device.

Can the changelog say what it blocks and for how long?

more below on the 'how long' ?

snip


> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc;
> +
> +	cxl_region_quiesce_lock();
> +	rc = cxl_reset_quiesced(pdev, dvsec, cap);
> +	cxl_region_quiesce_unlock();

IIUC, this cxl_rwsem.region for write for the whole reset, including the
Memory Clear wait, which can run to CXL_RESET_MAX_WAIT_MS (20 seconds) plus
the cache flushes. That blocks all region activity, on every CXL device in
the system, not just the one being reset. Does resetting one device need
to stop all of it?

snip


> +/**
> + * struct cxl_hdm_range - HPA range held exclusively across a reset
> + * @list: entry in &cxl_hdm_quiesce.ranges
> + * @dev: device for error messages
> + * @hpa_range: system physical address range decoded by the device
> + * @len: length of @hpa_range
> + * @res: reservation of @hpa_range, once requested
> + */
> +struct cxl_hdm_range {
> +	struct list_head list;
> +	struct device *dev;

Can these range helpers return the error and leave the reporting to
cxl_reset_quiesced()? That was the v14 ask. v15 swaps struct pci_dev for
struct device, but the device is still passed down through
cxl_hdm_quiesce_prepare() and stored here only for dev_err().

-- Alison

