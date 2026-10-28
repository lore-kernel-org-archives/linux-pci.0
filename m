Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793172580;
	b=RmyC23BEOt3S8VSW+qsbrDZYuOhP/OxMS1FLBtXSlfIhyEGz70icYJjjPtKJkkbEML++
	 ppYJt6g9Uz2fObp9Ah3nUE5artm/v9vv1UzN9qbm6h9+nL+tDyhUwnN52meAl6iwZr/Kd
	 2cMbO8rpowrRiDQ64aPoIMFiVcq/WPcRM+CsHLG2+7m9/pFkSdD7gIgTAcb6bWARIrdxn
	 7VQgAV1GkQ/V7/9XOrcn0rSKP6tLsc6GqJvYRqtXLTKZS/Cox5XxhaEILTe2uU3nlaYC0
	 QbQvpbSptpWJTaXofF/DuoFGM1ltklaw7B6Pm6dWALEZP3vJMlg8jPUogoREidaZSgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172580;
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
	bh=Gyh4yyf+NlzxtkvOGevDaF4hwVzAemjEx/5ZRhpsYtM=;
	b=MbRlIBUMl3EC2AcmsKohs5czMuNzP7afo4+7yXKpSYR4gvgl+30fsA5wB/rI+CAwC+xR
	 4Dh5W/NA8hNUEKfVt163a+gP3ZX0cuQqMW9N6pWekHi5p/l0Vb2kHLHJa4NcGmWGBnyz3
	 rcBup0BaD54Ai6r4io1uKBiq6QKqQBbCWHwEA9YfJO+F/XLPDKMKVRU/BSECtal82DBSQ
	 nCorWKf4h5oaq/CqVDqNDL3KbJW2ogthFeHEDwSkfuy6dhqj4KGaNTp1sYXvq83Gmst89
	 WPw8AhKhm8kkwM0UGs0jJAOU1c5Boi2+vRySB7ZGrKBbw4lwpHHtJcBhIi8Ao4m8G6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gXrxanTH;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26751606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 07:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26751606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gXrxanTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793172579; x=1824708579;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nESzw9oVQJqIy9tsPF6E15XKlWAex1ksPziyUpzo0fM=;
  b=gXrxanTHpWQ+4cPpHirF8dcHv+SDv6E0325HQdpojkAtHXnCpD+1Zen5
   LwTMk0zkhEYtmale+ISs9JfNO9c2LwlsWO8b85P87qrTvOPPcrdguCqoq
   fEUL94UnepUeo7OY6W1iUSSFR52eBXCxD197Zo/xIlsgsUC5ztI8AS9kU
   3axJ8xh5ef/i6A0nv40IkG3VlO89TG4IgmJ2tWuKbglOMB8G0LVSuK1xt
   B4NZo7EYQz8Fgn+i6EwA0WttAiiFaG22kDlNFjbUFCbyR4V32ni9iL+ni
   gLdrESfVf9puLgvwe8Zi1Axle63XTXidiZY+JqVRwNegr6pzjISZGf4HN
   w==;
X-CSE-ConnectionGUID: OuWHC5XIShycIZBiR6+PHQ==
X-CSE-MsgGUID: 0pPVkP/FSBKkUPsNHTrVaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1876501"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1876501"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:29:38 -0700
X-CSE-ConnectionGUID: MQCEo+g0SJ+tA1O5CV2UbA==
X-CSE-MsgGUID: j51APhwrQu6hE5t476QFwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4895576"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:29:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 00:29:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 28 Oct 2026 00:29:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 00:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNhlidMxns2Cn+4e03e4+fsBLWNZBj6DZCOs6AFALiX67lkDYxN1/YKVC4ELGXjkPKvI8V9JwUXnHS1mMQ85FwZT3A1WZUVCg+r7ZYE9grF1kGaT0h8uF7ZrVM5vxNTC3twBNYrC6hBkyY++G7R6Yi13n6AXRF98X7oaYJwbxKlXxrvn4iCceUhMCaZuV88cbaf0y5LaYN+mIPWqAmE8XsICJ54/qRCuKv1akVSbXuZtvV8r9RNPGRfqdd41sK6rm2YPRCIupZ2AlgcENejeLvoyKI/+xuSMKd+i7Rr3COnIT/Ob1j1Ki6bBgUeL+GnJhxZqgvNX6kkRm9pI3K8pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gyh4yyf+NlzxtkvOGevDaF4hwVzAemjEx/5ZRhpsYtM=;
 b=hiFgT6JJQqBPqw56oiYMgsKF+W6T0AOHe0qlqiiIarMat+QcYlYEzIQBJA6da8i1V/ZMg3R6nMFhxuiVp/Yra4jNrrE3f31uSPfRHWDBBuqWnhwfZJ+n7URJ2v0KTPEz2KKQ2tBudpV3x81UaylYtXVLALRfglmJmepLxATxx+Q6ZqpLdo73v1a2QOwGtSeCKP5TLTiija+o9fm+SfQeQAd/Spm6Vg2ZNBrYLSPwBvGdYv+UDnl/d61JDTa66zC19KQKNxOsmFlLREHTfuOiU5p09MCXSYC9cgPflokwYWmXOGlQzBjFYiT7qD6onYa0CD4SxHDCQEJQm5vS29OuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 07:29:35 +0000
Received: from IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391]) by IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 07:29:35 +0000
Message-ID: <cd203906-6cf4-40f1-8d45-ccae6d4d60f1@intel.com>
Date: Wed, 28 Oct 2026 08:29:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] PCI/IOV: Introduce VF iterators
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<michal.winiarski@intel.com>, <djbw@kernel.org>, <brett.creeley@amd.com>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
References: <20261027213504.GA456799@bhelgaas>
Content-Language: en-US
From: "Laguna, Lukasz" <lukasz.laguna@intel.com>
In-Reply-To: <20261027213504.GA456799@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To IA1PR11MB6195.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB6195:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 40905085-ff90-4ba3-14a0-08df34c5377b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|261026140227099003|261026130827099003|11063799006|261022113327099003|261009223027099003|261021123027099003|261021135927099003|261021130227099003|261022105027099003|261022075727099003|261021121427099003|261022115727099003|10067099003|56012099006|22082099003|261026121527099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: XlC95QFwCwkBrYqDRwQvWQxkWPUH8/8F2EzMG4q27a24Wg78A8QREf+sXMc2xT0SR26QenRg//3ULLdvFjusVGhrj0sg5/Oj85CIAkQwVcN/M5cIc2hDA3pMdeIbzS0TLxs9Ou9bkIGESDtYT8YH8QOLfgddJmd24Zgxnx/4+v9Ir/Na9r7up4s9ieuy0zj/9dtJRi7OyGs+mJiX+WWsiovjYfzs+YBsfE5BOpMx6mZbMFcp4AqUJp0kN077AE832C+aP0KO4MnTZIIKsVSKlZ84DFqMPhiVHFReohF5rQBChhOtjmjkf2P4/pXvEuARW1a8Hc9G596vYU5aoeNPN1//nSq4drjoNFOKBVCu3JCw1VGgalPnqoEiY0giM40O0BdPvsIW3ytq0PvyoszBPfPloxamnkCw930KNw8VZ1iZYpb1M8QlwK/F4iytlVhTQCkLpiAV91vh1HfAka0hJVxznKKNyf044tc/NmYuCja6Swv4tprMpaywHX3IXcQ6ABCaoCsY8/g31SVxbjXCeLvGpWs7igAcTEBhNbmLibtgLgOTmOG5G580EaOGlxjD0+WmyvHqo157UUbHXxtCPIMXiLdxJDi4i8TDVtHYUGX8K8EcSFMh/2aU0mWvzPz0BG5C8V1oml3NAoimCmnmjwIKFScKdcJTPcMtIgsRsWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6195.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(261026140227099003)(261026130827099003)(11063799006)(261022113327099003)(261009223027099003)(261021123027099003)(261021135927099003)(261021130227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022115727099003)(10067099003)(56012099006)(22082099003)(261026121527099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmVpKzNObTNTV3p2Vkp4TUo0VFRPRS9ESkc0QTZMU09GNVhKS2cwM29mcTlH?=
 =?utf-8?B?ZWZDcTdiUXVrbTQyWEFOREdKclpoWkpWaUJWbmljRzVQNklqSm9rN0dQeFFi?=
 =?utf-8?B?SXBvZ2lDL1M2ZTd5ZUxOUXRuVUNDZ2JHMlBuT0NnOWxlb2xFZTVxSS8yRXdK?=
 =?utf-8?B?dFQ3a0hBZVZuMmYzRnQxcTFqNEt6Y1UyUXdGTFE5VFlZdDZvSWs4ZTFzR2tR?=
 =?utf-8?B?L0w1djVKelFFeXhvQWlhZkI0dDFzOVhPbU1xdlA2VDhrbktBc1MrN1I4UjZp?=
 =?utf-8?B?ekowdHFQeTlGdjY3NzJKOGxqUXJtZ3pDMzhJTERWV1BkMGRUZ00zQlN5TkZN?=
 =?utf-8?B?MGJrZkhOaEZ6blRWTnllVUJoSCtVZkRhSWdiMW96eVI1eVIvYmRRb2dqU3Zv?=
 =?utf-8?B?RlBPQjFWV2dseW0yNnlVYWRQNktDVzZhWFlKK0Q1TzJoeGtXQVpXbjFHbTds?=
 =?utf-8?B?KzZzbDFFVW1UbDhSRDZHdzdoSW9FUzhKNzhsZkJnWGxMRG91eXBlcHY1ajdp?=
 =?utf-8?B?Q2pPTFJsNFc0Z1ZrREx0bnNMZjAzSERhcTAxNTNqWFdrMGJlRy8rQytUcVM2?=
 =?utf-8?B?SzJ4VjVpWThLMUI1Vnl2NHJtSG93dEVscWlJclUvR21LUXFqRDVUeUIvTEFq?=
 =?utf-8?B?Q3RrQ1NtUThBb0JCNVFUa013bTZ6a25ZMHhWcEFLaWU4RFpReWcrYk8wVnFK?=
 =?utf-8?B?RHo5eHJCaXI1TFloVDQzbTRGSE45dmxkWjM0UGFLUGhiVGRYTGk2T21RQUIy?=
 =?utf-8?B?UHFyYVBFS1haTmNDN0ZZSDVod0xWa1FxVGVSWU5hRzRsYlNkejF1c1o4OHhV?=
 =?utf-8?B?YjY0YndjMlcxZFRTL1Y0SGdJcnFzTXo1S3FEOVpGZmt2dUtuN2sxajcvZEJY?=
 =?utf-8?B?YThyTjNuM0Y2V3dGOWZhdWZpTXpBLzBKRWwremY4L0thcGJnMS9pczJQWHlv?=
 =?utf-8?B?ZUI2SmFOZzdtbDZsOGZHSS9GVUtlekdJL1JMNXFtVzBqT2NTbm14a0JaM3NY?=
 =?utf-8?B?Wkc0RW5Jcko0Q1lCVTNiNElGK2VpNHJvdExuTHdsSFM4THhTZEFzMm93WlIy?=
 =?utf-8?B?NUZhZ2VSUkJrM1ZvL21yK1ZSbnE3MFBqZWp5NWlJU084SXAra2syL3dFUjFp?=
 =?utf-8?B?VDhKS2U2ZU52VWw5bUlTNFNZUXBxc3pFZEk0d1NhQ2xwOEJFUFIrelJONXV1?=
 =?utf-8?B?Vi9obmtBRlZ1TWRXZWJrVWF4Ylg5SHQ5bk04alZ0clhaVzNiWmdyZkdkbGtB?=
 =?utf-8?B?QmFXVDhheTdDZ0FQR0lQdHhzclZnMkVrRXRnTldNd1BvKzErbEtyWmVBQmMx?=
 =?utf-8?B?RnJHMGphb0YrMnFmRXFNVVFYQlVMenVYY0kwRktOVi9yaW1sM2kxL1J5Tzhj?=
 =?utf-8?B?TWxTNjFKdUZtc2VkdXJOd2d2bjc0ODUwUnYvV0FrQmc0V3ZjcFYvbmJHcnFL?=
 =?utf-8?B?TE9mNDBiaWd0dEZGZmxhNmxTTENEa1BQR1hOVGFIZnJ5QjJNNy9XMHZjUW1D?=
 =?utf-8?B?MmJDQmlWMW82dDBtbjJ4ZW1lZGRPOFpmSFEwMHlzMFI2RmpzNnR5dUU2Z2JT?=
 =?utf-8?B?bHdrU3JnSmdDSHYxYWhhY3lCdWp2SnhxTmJUMnp6V2xTU2xpMTdPS2kxTHlM?=
 =?utf-8?B?T01ZTEhaTnhXR0cxU0NQeFlCQk5VUElnajZWWmU5SFFmRWVTeWdYRkxuNTQw?=
 =?utf-8?B?VGlvTkxLeFpmY1BmVHkybTJROU8vS29IWUp0RlVBRS94UDdnUWlSOEpZQjl4?=
 =?utf-8?B?dmZNTWpvdVFMUnFkeWJiaHJ6T0FtamJsYXYyVjZZUndoOFJ5T0Vic1Q0MjEr?=
 =?utf-8?B?TjJ4WVliZ0ltUjZPYWd6RUxwcWVHNlE4YUFSalJ4ZmwzemJRbGJsRjcvZkth?=
 =?utf-8?B?NE5nV0tIc2dpZXJUWE9nWlFrS0FyNlZuelpPWjhqaWF2cU9vYXhMRDcrQUVq?=
 =?utf-8?B?cmplMGRuWFlKaS93SEptTUV1blM0T2ttRlJjRWl3WEorWXVnU0VKd28yKzhr?=
 =?utf-8?B?M0R6K3dXamFUcGcxa016dFh0amswcy9XOFJvS1VzQlk3bW54OXgvbEs5WkNR?=
 =?utf-8?B?a2V1ZURvNU42SU1TK2VEZXNZWEk2SkxLR0FRSUdnNXc2cVhZNmJzQnlNSWxh?=
 =?utf-8?B?cmIzUEtXNVZqNmlhcC9oWFN0b0ZTMEVLSDdRaUZvM29tbzd2Vmkxem9jU01l?=
 =?utf-8?B?SWt0T1U0dVdsb3VHZjA5TWNoYjZBNi9XTHNVbDF1QW4vTkhnNW5qRzQ5cm9l?=
 =?utf-8?B?MDdtbklBOTFCQ25qU2I5Z2QvTmI3eDk4NHd5czNRZmRTVmlLd2ptVjUvb2RU?=
 =?utf-8?B?WXRxRGhYWkFTQ0F6QWxyRFd2YmUyOE9ESUJnQTZHempDZ2xnS29EUT09?=
X-Exchange-RoutingPolicyChecked: sCH6sg/Eryi1xqVgCT3gqEuCDR6KoA85evgdT/uLTGDQdouSwYcXZWEoDkRCKaZAp/n9m2C3XkOuwai7GzOOmNtPSAYoPbB3i8sCr250r86bPwWD4eg7uPuugqiKkd0EKKCR0KHhW5LVEUuCptP1SSBxgNqoBHNzjzO9j6aq4wgybx4aocnwrZDTxmA4IeGNZZoOkeSBaqax/6kXL3/ZwDUoJWW1J/sl7m8I2FAe5CLmbt3nOWtoQbqvk18tvTDKVvZKff4KwqRaqX6IJLuax4CyDeoEXq62E3SgVArzrnFTDZYVpAPjKAzyCVifS+DFV0KgdCCpAxOBOurSx2rdrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40905085-ff90-4ba3-14a0-08df34c5377b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6195.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 07:29:35.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p+WCr8mom2GrPXczrx2uOm/Ib7+f9UkvHQPQTuzH8AeBjnG9X6Vz48EkCdeyas4VXC5x8yD8JLmaoWsfeqfcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com


On 10/27/2026 22:35, Bjorn Helgaas wrote:
> On Tue, Oct 27, 2026 at 05:04:35PM +0100, Lukasz Laguna wrote:
>> Introduce helpers to iterate over the enabled VFs of a PF. Add
>> pci_get_vf() and pci_get_vf_reverse() to retrieve the next enabled VF
>> of a PF in ascending or descending VF ID order, along with
>> for_each_pci_vf(), for_each_pci_vf_reverse(), and
>> for_each_pci_vf_continue_reverse() built on top of them. The helpers
>> return each VF with a reference held, matching existing PCI device
>> lookup APIs.
>>
>> This provides a common and convenient way to iterate over a PF's enabled
>> VFs and avoids duplicating the iteration logic in drivers.
>>
>> Assisted-by: LLM
>> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
>> ---
>>   drivers/pci/iov.c   | 63 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci.h | 57 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 120 insertions(+)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index eb019201faed..a437370c4e36 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -70,6 +70,69 @@ struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_iov_get_virtfn);
>>   
>> +/**
>> + * pci_get_vf() - Return the first or next existing VF of a PF
>> + * @dev: PCI PF whose VFs are being iterated
>> + * @from: Previous VF returned by this function, or %NULL to return the first VF
>> + *
>> + * Iterate over existing VFs of @dev in ascending VF ID order, skipping VF IDs
>> + * with no device present. If a VF is found, its reference count is incremented.
>> + * A new iteration is started by passing %NULL as the @from argument. Otherwise,
>> + * iteration continues after @from, and the reference count on @from is
>> + * decremented.
>> + *
>> + * Return: a pointer to the first or next VF, or %NULL if no further VF is found.
>> + */
>> +struct pci_dev *pci_get_vf(struct pci_dev *dev, struct pci_dev *from)
>> +{
>> +	int id = 0;
>> +
>> +	if (from) {
>> +		id = pci_iov_vf_id(from) + 1;
>> +		pci_dev_put(from);
>> +	}
>> +
>> +	for (; id < pci_num_vf(dev); id++) {
>> +		from = pci_iov_get_virtfn(dev, id);
>> +		if (from)
>> +			return from;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_get_vf);
>> +
>> +/**
>> + * pci_get_vf_reverse() - Return the last or previous existing VF of a PF
>> + * @dev: PCI PF whose VFs are being iterated
>> + * @from: Previous VF returned by this function, or %NULL to return the last VF
>> + *
>> + * Same semantics as pci_get_vf(), except iteration proceeds in descending VF
>> + * ID order.
>> + *
>> + * Return: a pointer to the last or previous VF, or %NULL if no further VF is
>> + * found.
>> + */
>> +struct pci_dev *pci_get_vf_reverse(struct pci_dev *dev, struct pci_dev *from)
>> +{
>> +	int id = pci_num_vf(dev);
>> +
>> +	if (from) {
>> +		id = pci_iov_vf_id(from);
>> +		pci_dev_put(from);
>> +	}
>> +
>> +	while (id > 0) {
>> +		id--;
>> +		from = pci_iov_get_virtfn(dev, id);
>> +		if (from)
>> +			return from;
>> +	}
> Seems slightly odd to use different loop control in pci_get_vf() and
> pci_get_vf_reverse().  I think I would use "while" in pci_get_vf() to
> match, obviously with id++ at the tail.

Good point, I'll change it in v3.

>
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_get_vf_reverse);
