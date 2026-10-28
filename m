Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793171090;
	b=nl0CE3TXgVmYQy7C1fQsy3wDMnf5x6CtdZsvxRAIivMu05HzVbBUIlAy/vQ9ZRNl6lHq
	 UAgPU21DOs5ZBKkNNnH4UYV2rjhxJUr55SlC1qQwZBj8lNh4RFz2yVh1VOEkvysy4qyX1
	 vFLfhY10y44lyma4TBH3idFDxLEmBjuwM7YIU0CGt9kLgmOx4iixuEfu5lKFtLTeSCEOq
	 nESI/4p1kN9QdC9gEBNlgjPxkKA+Ly2U08OvvReRRlp5FPYWSF24dTX5bdDWZaxNgMws8
	 BjOoLd04MpdsjQRpOlQUdkdT+fr1UEHt6/l53XUjvmWZ1w+9kyWFsWdFmsY08ZYHdvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171090;
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
	bh=CZJto9nr8Pj6ht4Xp1YwogfYVCbqcskNUicbmAHrUpQ=;
	b=zCFXxgte1c0uWjGBVAFJDUtaXhJjubhlHt6On3HiTqj/MDjOebS+rByUHPz7PbJ6Lcyr
	 0HeWkNHQPZmPnwx7VaWGcNpSWa/T9DV9BhSNB1elFIMlfc/zeipHaktGTs0uvIYT1BbJA
	 o2tmx8ep45rmajQS6DN4QhMeDU+Ta5MaRywrtbOZwFHEKsNaG6Sj1HqLxi+kSgagJLFh2
	 68JsePhxYmjzpNE789gHVOySpWfeAVJZ82DQrDpBY19/3Boc79+8LAhUQR6p0+HIz/CF5
	 YnKDZW7g5cDw+6eTefbEHRg6uY5jzOU/o5Xx4XMWSP9AVuNzN2Ue3ugICEYipHWgjVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W4Bhjkeb;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2A606A31D
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 07:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E2A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W4Bhjkeb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793171090; x=1824707090;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QWpwrcEWidmkW+adwRXRJDtvbcmC9v8WYfO4oAfHAyU=;
  b=W4BhjkebXdsI7mX9HF4nSY1+mr/gzoRwKjU+BsE01Gz/GcBP78Bg4aB+
   E+GC68bEs513groq9xVPsuONT4e0DKxRb3QeummlzyDgEcDOde7RB0lfQ
   ujqIdVGl+iGNbLXK34ISHxxoEnZx2VQUNKUhNddeyuDcQUicWBufCLyZ2
   BJoWPmTgs4oMFbcvlO0BsK3t0qqdy9zLeriZeEL7ZsArvCsnfz4kPVhX9
   oDovko225rET7ZCv293CCkFIQ+akKSUT5UaBmI1ghub4LRbTLgMKy+xL4
   6ItjrJY227N/uHJks922KtCn+unr/EQwn5Xd2UAApOlH5lRBuG0zjkOtj
   A==;
X-CSE-ConnectionGUID: 2AIomtwcQquvrPCMPLMPNg==
X-CSE-MsgGUID: EHg7TIALT1CXnQTJVklsMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1911061"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1911061"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:04:48 -0700
X-CSE-ConnectionGUID: BfofzuIUTJeSlzwcOEP9UQ==
X-CSE-MsgGUID: KAWdIUHqQvK+QempL54bXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4732316"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:04:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 00:04:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 28 Oct 2026 00:04:46 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 00:04:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9XpeYjA0eb9TiC7FRB20fG91xTZsa7XyQ/ZB6Ao1bcHTflFGxEiPc1m77PP0VVwBvwypHLMa9ncD+0S5nx4KFtjMsTlcXhUvlewUOUjeRuy0MVGhPZoT1IK2nc9PCyFOFuSTVnX66VafGzsMmSUEwDJwFY8OxUUY8JtHOP4MQX6fPRfNYE2PHsT7gzDPYnoUnIdG7RYv1FmsN0wL3Z38eO6yLW+RMOi57bQ0536AfrSBi09oUVAo9XYJG00x7Wkjw+8A3B1vnNT39GWHqoQ+//2VTuiO/zjLW8JyI9QVTi9Oz6DZjeupEMmL/+lEDEfKe5UBJGY9tF83lrNepQp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZJto9nr8Pj6ht4Xp1YwogfYVCbqcskNUicbmAHrUpQ=;
 b=C3rL4YjnxEc16W//8mtxU35HLvicWMPTdsYurKZWnpT2Ne9j4yHM2fvoqMz9s67ri3VApoYjc3P0011UqfSpvbSUM8snwno1U6Vk8rwy2NlX7B7xwYUmLJCxHS8p85P8Lw8SfHnQgI6D6pcTZrZDIwTueuY/ZcBX7dZk3iDtzmHUcZDpNvZP8LJev/Sd+lraJyQjFOvfTxxpGk0/lBbejnPYQbbzRGcUAl8hApzLoISrcfzJQM/eRr87oNAGxeh/VAhCQXU0vQVjkCbQXlW+OEFuwSrUd0BPHa0y1kSw/3bCxs6JwGLjWiqPHunIAGRCyuEyPSknelxdsGwCh81+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8)
 by CH3PR11MB497958.namprd11.prod.outlook.com (2603:10b6:610:348::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 07:03:48 +0000
Received: from IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391]) by IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 07:03:47 +0000
Message-ID: <b45d86e8-5912-4cc6-b6d0-d842bb1eb791@intel.com>
Date: Wed, 28 Oct 2026 08:03:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] PCI/IOV: Improve reset handling with VFs enabled
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<michal.winiarski@intel.com>, <djbw@kernel.org>, <brett.creeley@amd.com>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Vipin
 Sharma" <vipinsh@google.com>, David Matlack <dmatlack@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>
References: <20261027194905.GA462134@bhelgaas>
Content-Language: en-US
From: "Laguna, Lukasz" <lukasz.laguna@intel.com>
In-Reply-To: <20261027194905.GA462134@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0056.eurprd09.prod.outlook.com
 (2603:10a6:802:1::45) To IA1PR11MB6195.namprd11.prod.outlook.com
 (2603:10b6:208:3e9::8)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB6195:EE_|CH3PR11MB497958:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d46ce6-b065-40cc-99ae-08df34c19cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|261021135927099003|261009223027099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003|56012099006|261026140227099003|18002099003|22082099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: BLmRrrWbjpKWPbJ9jyUBEZobnCVx9NdzzzcjfqjW21J6xErYOmOj9AeOwbKpB2oKDc//Dw53MjGD1R8NvClqnoMaE92YjQ0lDsdmtwnd21H96kpg/iLabmF82cldhZysp5ffArgrz9KCc1fAN0efM5rvg+ZGuNsNyDK0rGgECca+RSnhcypCv+YXLHnsyHm8Z1+sgThwYH+bMM/SfVgeMkS0JQ8+mzyzEX3cTFE3JTLQoKe6MrNHOycb2AC0tyPZMbVxaTxthGvP3LbYq2c0E9mW0SEnJhX5909oBO3+StnvyZs48ennGTisFCzTyfx4166PwniPviLfSRTYBUS42Z0ByAdu78arBsYzb8fuONNe0iIuCiCSptbwy3bXgO/IIccuyo4aia+G118kIVByE01X/vTprIQdioDtygYAhjoOaQuyOXdYJzo9U0FOTRNvrkPz2CpPJpKWeKHv/tP0c7V/svCd2OmCcc8pb6R4QlVC2lflvVgLF8rboxyBYp0Clk0gp/Uzjbkv7I2wywz8fZ9iZkm3YbsLRo0tvQl0U71FG4f83qS6wBOZSPWCqM0aAMoBEpcdDUI5Rs2Pq9DXXizYPtSoOAw5sNgdEhZvhTeNsSwPEW4wL2fojmXnrVSV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6195.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(261021135927099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(18002099003)(22082099003)(261026121527099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emNaQWxwbGlYbEtRaG45QVorTXB3d2p1VWNjR2lnK1lqd3RJaHJrTUVIUTJD?=
 =?utf-8?B?NHovV0dmZndMR0pDZDBabzdwOWRteWhEUVRxSzhMOW5KODBmUGljTWJqeW1O?=
 =?utf-8?B?aER0UDFtVjhnS0VPeUkxdXZscStyWmozRDZKSDRnUGRub2k1M3hGWHJYeitQ?=
 =?utf-8?B?V2VRbGcyZENvWUxBbkVlVXIvWldURHUxYk55T0hwUmQra0JacCs4OWVXZ1Vv?=
 =?utf-8?B?bVM3LzRGYzBMdDhlL3BvRWJDTzU3Y2JLWEZaZURaNkhKWGxtQzhEalF2b3Vv?=
 =?utf-8?B?dEhGNnZFVDBZanJYSDk0TjhmSkVFdzhvN3VhME96M2t0TnIvemg4cHpKYVVP?=
 =?utf-8?B?TU9EMDJ2aWVGNVZodlkrN3llMzZENHdZRjA4UWsyRWdCRW9GMVJyUWt0ditB?=
 =?utf-8?B?V0Npd2UzcytxbkdwRHhXR01tQWp2NldpT1pTREZPQ21JRndUc3hhUTYrKzFP?=
 =?utf-8?B?TXM0clZnczJYVFZiU0QySXlONVVmL3M4SEFsWjlFVUlKUUdHT1l5aVdFN0pl?=
 =?utf-8?B?dUxUZ0pOek5NOEp3Zk45UTMvak5BUEJ0SUFPZnA1TVBiNDVHc2lhcE1YYS9H?=
 =?utf-8?B?UGxRUGRnZmhPYlZZNFRJMS9QK2w0UGtMbCtVaXNBR3JnZHRSSHpXSTZubmxH?=
 =?utf-8?B?ZXRMVTMvbnlCYTVsZ1lQSS9Jc1Flc05QbkdjNzVvdFc0NTFWNEE5YzhxcmIv?=
 =?utf-8?B?R2VnN3VTN2VJbTljblNMOVg0ZHE4VEcrSGF4UEZ2R1hLRkFjMlRmZWxoRm9L?=
 =?utf-8?B?Y2xTelFlMjNkSCt0Z01abDUzRFA1K3hnaGkwcEpydzkvZExWL3o0NTJhSVZx?=
 =?utf-8?B?ME01eXhzelNhTVcrMzRMNzVDeUpVV3hmbE1ncWQ0Q05XSDFCQms3WWV1Rk4v?=
 =?utf-8?B?Y1l3NkdjZ0lWNWwrdlVzc1Zhdlp4OVR2Vkc2SjB4R2laNGJ5Qi9tZ2dCZjcv?=
 =?utf-8?B?bVJzMlIvSWdhU0kwVmNwT0dqdUNrU2tBcUVmV2VWTVA2S0lmY2c5QTZSU1VL?=
 =?utf-8?B?ZEVnVmQvT29RSllCM2ViWDFjbmVuY21iVEwxdFFZTXA4bmF6anVWRmdUd24z?=
 =?utf-8?B?dUI0T1dYbENncU92VkRSeDFtSmhHbjhod3hiZS9UUTJtb3BERXN5Wldyc1dz?=
 =?utf-8?B?Qm5aNzhFaFdtQzVTWkVRYjdlMVZwMmQwbTZOWHdvc1g2UlFaRkQxYWtvVzB1?=
 =?utf-8?B?RDR3OWx2UTNPWUFFWitFdlZNcVVkNlRrajFSdzhiYkRRRzBCazlQQXlwTEhW?=
 =?utf-8?B?ZGRPWG5CUW8yKzhFdWVML0ZsMlZRYTBIbXJaRncyNjNEbmp5UUttM3N6b2ZB?=
 =?utf-8?B?aUx3MmJRem5LZnlRZlM3NGc4Q3J0QnBHZFIwcXJZN0NaQzZ5RTZOWEJRb3Fi?=
 =?utf-8?B?WUY0U2sySGJnL3QzUEJIc1FNMGZtTjkwV3crSkM3aFRnRGZ0cVJpNUE0L3h4?=
 =?utf-8?B?N08ydUcyQitUdDAwUXpkYzZsdTVUTFVXU0x4TE5EeDRBZ0YwSzBUUHMvdjhj?=
 =?utf-8?B?bjd4eW1QUkJZcVQvcytBR0JtMW1jSjNHb0J4UEdaU2dxbXphUWFKQUpndGEw?=
 =?utf-8?B?ZVB6UVhZSEpSUnVzMlgzVXRCNHJ5VkV4MjVTOHFkWk1tWE8zazgzL21KMllW?=
 =?utf-8?B?eGRyMS9LeG1GWld5MzJOTFo1REhVMDZvSEo1U0lyejI5OEtkeGEyTHR5UXZB?=
 =?utf-8?B?cysxdkdSZlljY1JESWxFQnd5dDRuLzJRZkV0RitDQjlKcVMzc0xweGFuNUdT?=
 =?utf-8?B?UEFubW1JREt3TGxucm1rRjJPdk5zOE1nbjZ1VGdnbS9HWllHOVlsY2pxUUwr?=
 =?utf-8?B?MFJobE5vR2owOUxLUUNRYUdaNkFHTlJRRFovakhTT1JTMFlxZ2haMHQ0d0dE?=
 =?utf-8?B?bnJqcDhaakpLMy80YVlJZzNmeFdGanhwWGZTTTZwVGVZcGIycEJrWklmbXFR?=
 =?utf-8?B?VS9LWDNkMmI1RWZZWHM0eEZDazNkQmlQY24yc1hLK0pJcnVJSGNDRll4VEZh?=
 =?utf-8?B?UjlkOGZzSncrSEVscmZ5eS9VV2FVK2RKMjNPMHpaNUxRZzV6alJGZ3BaWjZr?=
 =?utf-8?B?MzJEV3BWOENtdXQzWTdnMmxmcUFIcjQwOWY0STI2UHFXYnFhWUdoRTFMQzRm?=
 =?utf-8?B?b0FhYnVralppdnM5bis1d2NYWFVFUWlCeVdsVk45OC9CSlc5VFllWlY2Qis2?=
 =?utf-8?B?TTNoTWtmcnI3eXBFbndFMnRzRUFiV1FLZWhzYURZUHlaWXFObjRwQzhYaVJV?=
 =?utf-8?B?SzJJbXl1TmxKajd2NVBFbmRjSUZQbFRnS0laczc5Q2dWTVNHV0d0M251QUFi?=
 =?utf-8?B?b01WaDJkNE1jU1d5VkIvWHVBUjVFTWYrTEVnQmNOVit4bkNFQjlQZz09?=
X-Exchange-RoutingPolicyChecked: YXKd7PvCFKPbgr46I076NPyBES6ixKQ3Z+7ZU8C3yurRW1+F49edsJLv5y6cG9YpevwPLIcQ+cOnVQWGHQfa2YlWQwwRr0hoiavxgP8iiOvrtOhu4cElE2j6mDGtosjOvQcqZw0xSNBYp/IpjkM/a7IaMYreiXEwuxbvLi842v90RcqM6dDa43YhDq1SyYb14Ha1wZDw1j5vMOx0Z5xkPFGtX8yDHgYuG24K+C3oa7roWXnnBQYsJ1bH5Uk+XZK9Byrm6pvW4Qzf949rk6Zb/ME+OpQEJOTAOXUlSg6hP+ok4UUxPRYaVKba99jG5dFWiEprwQM9iiNMXUrs/nWHVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d46ce6-b065-40cc-99ae-08df34c19cff
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6195.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 07:03:47.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgutcB+fhEYKHfUMb+5L/3SsZrCq8giDO+f6QU/S9thacCL20mkufbQdTWL9z8ggjo/2XaTKm4WFOn5lXTl6Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB497958
X-OriginatorOrg: intel.com


On 10/27/2026 20:49, Bjorn Helgaas wrote:
> [+cc others interested in VF reset]
>
> On Tue, Oct 27, 2026 at 05:04:33PM +0100, Lukasz Laguna wrote:
>> This series improves reset handling for SR-IOV devices. Today there
>> are a few gaps when resets happen with VFs enabled:
>>
>>   1. VF state is lost across PF reset. The PCI core saves and restores
>>      the PF's config state, including its SR-IOV capability, and the
>>      kernel representation of each VF (struct pci_dev / struct device)
>>      survives the reset, but the VFs' hardware state does not. From the
>>      PCI point of view, the VFs do not exist between the PF reset and
>>      the restore of the PF IOV state. Their config space is lost, and
>>      their drivers are never notified about the reset.
>>
>>   2. VFs are prepared in the wrong order during bus and slot reset. VFs
>>      are handled like any other device on the bus, and because the walk
>>      is top-down, the PF's .reset_prepare() runs before its VFs'
>>      callbacks.
>>
>>   3. VFs on an SR-IOV virtual bus are not handled during bus and slot
>>      reset. The walk recurses only through dev->subordinate, so it never
>>      reaches them, as such a bus has no bridge. Those VFs are reset
>>      without being locked, without driver notification and without
>>      config space save/restore.
>>
>>   4. The "bus" reset method is unavailable for a PF with VFs enabled.
>>      pci_parent_bus_reset() accepts a device only if no other devices
>>      are on its bus. A PF's VFs typically sit on the same bus as the PF,
>>      so enabling VFs makes the PF fail this check. The VFs are in the
>>      PF's reset domain, so they should not block a bus reset of the PF.
> I want to hear opinions on this part.  I guess it's obvious that VFs
> are in the PF reset domain, since resetting the PF destroys any VFs.
>
> But I don't know what coordination people expect between users of the
> VFs and the PF.
>
> I think people expect to be able to reset VFs independently so they
> can be assigned to different VMs and be reset without bothering peer
> VMs.

That doesn't change. A VF can still be reset on its own, and that reset 
affects only that VF.

> But whoever owns the PF can reset it and all the VFs, potentially
> destroying any VMs using the VFs?

Yes, but that's already the case today. A PF FLR resets all of its VFs, 
and it's available for a PF with VFs enabled. Only 
pci_parent_bus_reset() rejects it. Patch 8 just makes "bus" consistent 
with the other methods.

>
>> This series addresses these gaps as follows:
>>
>>   - Patches 1-3 add the PCI core helpers used by the rest of the series.
>>
>>   - Patch 4 fixes (1), (2) and (3). It locks all VFs together with the PF
>>     around a function reset, saves and restores the VFs' config state,
>>     and calls the VF drivers' .reset_prepare() / .reset_done()
>>     callbacks, so both architected and device-specific state can be
>>     preserved. During bus and slot resets, VFs are skipped in the device
>>     walk and handled through their PF, so VFs on an SR-IOV virtual bus
>>     are covered as well. VFs are prepared before the PF and restored
>>     after it. As a result, pci_reset_function_locked() now requires PF
>>     callers to hold the device locks of all enabled VFs as well.
>>
>>   - Patches 5-7 adapt PF drivers to the new core behavior. ionic and
>>     pds_core call pci_reset_function_locked() from their error resume
>>     handlers, so they now need to lock the VFs around it. i40e no longer
>>     needs to restore the VFs' MSI state in its .reset_done(), since the
>>     PCI core now restores the VFs' config state.
>>
>>   - Patch 8 fixes (4). pci_parent_bus_reset() now ignores the PF's own
>>     VFs when it checks for other devices on the bus.
>>
>>   - Patches 9-13 replace open-coded VF lookups with the new helpers.
>>     PCI/TSM and ixgbe use the VF iterators, and ice, liquidio and xe
>>     use pci_iov_get_virtfn(). These patches depend on patches 1-2 and
>>     are independent of the reset changes.
>>
>> Link: https://lore.kernel.org/linux-pci/20261019083514.838640-1-lukasz.laguna@intel.com/ [v1]
>>
>> Lukasz Laguna (12):
>>    PCI/IOV: Introduce pci_iov_get_virtfn()
>>    PCI/IOV: Introduce VF iterators
>>    PCI/IOV: Introduce VF locking helpers
>>    ionic: Lock VFs around pci_reset_function_locked()
>>    pds_core: Lock VFs around pci_reset_function_locked()
>>    i40e: Drop VF MSI state restore from PF reset_done
>>    PCI/IOV: Allow bus reset_method for PF with VFs enabled
>>    PCI/TSM: Use generic VF iterators
>>    ixgbe: Use generic VF iterator
>>    ice: Use pci_iov_get_virtfn()
>>    liquidio: Use pci_iov_get_virtfn()
>>    drm/xe/pf: Use pci_iov_get_virtfn()
>>
>> Michał Winiarski (1):
>>    PCI/IOV: Allow VF drivers to handle resets
>>
>>   drivers/gpu/drm/xe/xe_pci_sriov.c             |   4 +-
>>   drivers/net/ethernet/amd/pds_core/main.c      |   5 +-
>>   .../ethernet/cavium/liquidio/octeon_mailbox.c |  10 +-
>>   drivers/net/ethernet/intel/i40e/i40e_main.c   |   3 -
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  26 ---
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   3 -
>>   drivers/net/ethernet/intel/ice/ice_sriov.c    |  20 +-
>>   .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  25 +-
>>   .../ethernet/pensando/ionic/ionic_bus_pci.c   |   5 +-
>>   drivers/pci/iov.c                             |  88 ++++++-
>>   drivers/pci/pci.c                             | 217 +++++++++++++++---
>>   drivers/pci/tsm.c                             |  25 +-
>>   include/linux/pci.h                           |  63 +++++
>>   13 files changed, 357 insertions(+), 137 deletions(-)
>>
>> -- 
>> 2.43.0
>>
