Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0F1E2834
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773711936; cv=fail; b=ONeaikZAvV3yl+tOwVM09JH9O3RO/0bOqy+/r2L2LuzoMiBEqGIWFmBt/uW17LCmlsMTdxAsEitG0N8hrxTq77lZw361Sg84jghNEqcBZoHmtSwvmaY49gN0RDjQ29Kns2KeA0HJPydleBHgcBlIcDqS6CyMLkVrATsB82Tf6Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773711936; c=relaxed/simple;
	bh=5pqE6IGsEBAKPJCAzQAbIpCVpDMAe/x4pIcp1xhKvKM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Tu77TyVlDZtnftCAO1dZDPTRoZN9Q7NJ+PQqI0ylLD+L5RwjhG5QGGYXKLV29i2H4tQFA8oQQApPdFZL8aydj7IxpxFVjHwP2sV+vNm7sILjPiBh2uPYniG0FmeCpKI0azq2hVkDZyE9A5kVKvG8+UpcZp11t21CtgXIinZGhA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlzzGSMX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlzzGSMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773711934; x=1805247934;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=5pqE6IGsEBAKPJCAzQAbIpCVpDMAe/x4pIcp1xhKvKM=;
  b=DlzzGSMXzzq9b26FDWcGRsE1KZICOLazu+WWV2VS/wDrwoF8aX3L9bR6
   o0TWDYzZE7rc1ZrHq+eNGA180d+wjGAeaws003NF1CT/Y/0YEZMFLstk3
   /T7p2t28kAI2KjlrQqNrlbQLEo/cQBb1qABFFJK4DMefmEiKQm5Ov/bR6
   S5z+1qzG1Zs7SH7L3ArSamCjVy+7n/gDLfFDLMWS02dmgWEIOgni7h7X2
   lpR2A8xX+wfLXnZjwg9gV6xO9R7KNs6IAHxWH9btrgRE65neEZgABe7dG
   Xr/b0G0y6lQ2W2KRyCd9ojf+XBYnIAtW2BGidEManLj1Br9/adkgF6QFp
   w==;
X-CSE-ConnectionGUID: epfMV32DQP2H8wV9VOC/yg==
X-CSE-MsgGUID: tQ6i6wqqRBeXHwP2nuDx4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86215334"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86215334"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 18:45:33 -0700
X-CSE-ConnectionGUID: i0VQfXGhSRu28nOKJywbmw==
X-CSE-MsgGUID: 7L6AuK6uT+SZafpBX9OV5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226549451"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 18:45:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 18:45:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 18:45:32 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 18:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aej1cnmvYQdMPfeeaszWAMKC0DED1SFnjB6qBPvW+eGOWOWjgsx1qR45plg9Efmyj0fozJhgEQ6Es7n8gVcnYc8to28bJ9b266YgEvGQfBLyFK8dCGA5WhJu09yKMC/2R6datcqoZrdoWlcr/e1D9WhXbnxgnpoYL6MXGc1z5wBAUn+0utbHe6ggg4lh4hJKui69jdIYNIsmJCfukWRjfoArZwSDaE9YHxhXCYIHBI4ZV/47VKa0SSKN0bAS50jxDzz8h9D+xpzpHoOx1b/FP7PVbRnADlg7u6Tysc1u2hRnY9h4s18O7k+EPMP0gmoNkbIbjVMx3TQCSMOwjIqKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx/aNxDPHcOlA2mkMV+cYPdfYc/lS6arVB0OwWtQPFs=;
 b=ajzAX5epxJTPpUEDbOVLyMzpnVjb/B4/KnEyKSK6QTtYmzdkqD9W0br0H7fnBmrGuMyL8HAcUW4LTKDl3bjhGSO1e82JIt7miLh8BTPb7bOndzyP2sfv2VIsl8JBGL9PP01m8ScuaDB+aJ+vQ2vV2uPBjnPESFCAr/3URUATXbA3+EXZERws923ENDcbdoC84QympBzZHGQPcOAc36zjQvykLea9cgE8Vzq69Ddk93Cva2IRnUrawIbfsv/T/fk12J29In6uPYLj6paznmdrgAuAwlbi1T83RRBDjRn5BzRA7biXn5bqgdyDryov8XcX6h/r3g5IookdJvqmKH6A8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 01:45:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 01:45:26 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Mar 2026 18:45:24 -0700
To: Jakub Kicinski <kuba@kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, <jgg@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>
Message-ID: <69b8b234177ea_452b1001a@dwillia2-mobl4.notmuch>
In-Reply-To: <20260314111245.76d18d73@kernel.org>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <20260314111245.76d18d73@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:a03:255::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 0153d2d5-16a0-447d-7f8b-08de83c6dc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4utf/dn2BJ7yTuaFhWDLTxxuA4Qt5pndDuhuUBVnAYvqW2jaby65Hs5ZrqU7mQ33Sxy50hcveyu5kMt4u1p4tSkBSurDYV/1MZ7eNl7D8fcL5t1OJPgHs5s3KLkyrAmLnuX4gLUkMTEwul2lmpmKnUEQrKIO15BNhZ+/Rpttc76gySfpEV2VrrQhxP/xLOCrb3E5VgltOW+eeZAeTumXLx0nj89AJyk5iW8w/9FiTYkOclDOtgi76aUBIQY74X8qUUNTy4JyHTI77fEvT9926d/bsxetoeJ2+J8srfOtWD97Jf0VsZlmHgeRYEXv8jwvPvtsDyjrZO3FgPT3EXzKxH2PGCw/P6VV7LCiQGEwiqOIJoVceC0JgxdDBlY0oU8hqZL+RiTuG2SldTzhj/7oOBgJz6E/k4+jhf6jcFceLGLk3bzWq9VMeypnr3mrkHVq0P6fKjpnO9SQaz0RLtcguAnTy76hPUKW0no8+SChCUBMxsNZ+KCcOk0jn/HWwvUVUD/wWDGQREvghC0L4GGRgA+TZUFgGCMB9nJOTASKY7ULULAay9Dmy5WamL7BQ03hReYiPL6vXXFBWnMYH2wEp88TiHsRFy3flAiTicHRBI00v3eDMgTCWjsFXlhzzHYmqAlfzAQguN2pPhKe81nljTAqDHHz3YUUIKqE0maFsCoFarjds9KAuSE4x9TxeHIV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Njk5cTIzV1FnbEJNN2d3MGtGYU1zQ0drRXE3KzZSaHljNU5lRTdZL1dGc3Rh?=
 =?utf-8?B?VVdWVEN0QUo4QjI3WEtPQi93REh0T21jR2ZNeStCZVFldSt0V1JRQkJwZGFI?=
 =?utf-8?B?NkpQeGtMZk5qbHVyNGVQdHN1RzRwakgxQ3lFTEtOUkJLQTNJVmg4OE9xcWRm?=
 =?utf-8?B?SDkyY2Q4NEErL0RqZjJBamJzMXMxdGY3ZjUvdy9XUXh4WkNMNG1lbHN6WTN5?=
 =?utf-8?B?T3hKOVJQRDZ1T0lDeHdHVzJ6Z1dSU3d5d1E2bmg5ZDBJQW52K3JQbEVENkRG?=
 =?utf-8?B?cjd4b2lVSTNlRncybStyMmUvdmxqcEM3WTlIc1hVTktiYjNzRklMMUtjRUEx?=
 =?utf-8?B?N1BLZXZoeTV0cGVBYWt5Mkpld3BZRnNoOENMUUQvRUdJWkR2YzE3STZhbHlG?=
 =?utf-8?B?SVB1L29zM0MvTitGYlZPRG5tR2l6MytnSE5wbjgxTU5wangzK1JlbGRHcCtw?=
 =?utf-8?B?d2xDSGdaMmJvVjNjVS9iK1J4N3RvSUZQUWV4QWY3VFN2eWhhcFIzN21BMHFY?=
 =?utf-8?B?RUptckhTZ3owZFpLdVVSV0N0QzRxdTF5MmpET1lqcC9ZeHRMMGs1ZkR0aUto?=
 =?utf-8?B?OHpqQllubjhSOEFnSDAwcGM5VXM1dVFvT1Z0U2I2ekIySnJsSndXNVl1SHRl?=
 =?utf-8?B?MDMzREg0TU1nOXRZcng3QWFob2NYWndnMFlrbVhldjJ1NEkwbTF0N21FanRP?=
 =?utf-8?B?d2Rsbk01OGJQZ21lZnllYUoxK2VkV0pjcE5YQ1JnZG1pOGhXYWwzcnB1Qyt3?=
 =?utf-8?B?dkZrV2hrM1doNnpFWHdBNWFheWkxdnI1MUtMaEg0dzREdjdmUlYrVldoNUg5?=
 =?utf-8?B?bXQ1MWkvN3VubGh2ODN5R2pGUWQxOGE3SzZoTmdqb1NHOHNXczFsa0NpdWt6?=
 =?utf-8?B?eXo4bVoxcmFTV2wxUEdkT1VYM1BHOHlNNDVPUmtkSWR5Zjh5OHV6YXo2cmc0?=
 =?utf-8?B?ZmpiSU1GN3ZaVFdwYnJRb1ZwR3NJdnA4RDRDZzA0aks1dk5zMEtRdFlPTmI2?=
 =?utf-8?B?V1JUK1pNTFIzdzlWOFVKRHZvK1Jqcmw0RzVYdzR6cVo5K1Z2UWJqd1dBaDNt?=
 =?utf-8?B?cng5WUtaa1VESHdiT0cxTzVyWDBYR0xXcVhXRjFpL0l2bE1JWGpsbE05VExL?=
 =?utf-8?B?a2p2L0d6NUVvaHVwdjQ3YmZhaXA2Y1FhbDVkWE5HbmN1TmhyY0J1YXNsR2g4?=
 =?utf-8?B?RUF5dDdIbklXSjhkZ2pDL2ZEQ2tiRXM2U3JUblQvSXFFaXNYWFY2U0ZjblJv?=
 =?utf-8?B?aFNDT0VVVWI0MGd4Zm9DRDdENWlubVpubGxNZU1WK0RPa2xPd3g1SXlqV1VZ?=
 =?utf-8?B?T2lXS1JnNlhPbGlDQmtacEwzRE5zc1NFZGZZUGdENUhxQjg0YWFaZ1M2aXNm?=
 =?utf-8?B?MnpvdTBFYnBqYVlBbVZ6bEFoMHh4WGxQaUFXMzUxZitUQTljbUNjL0hBdHV4?=
 =?utf-8?B?S29VUWZZU2lhdGRCT21tbzN5Z2dEc0VpcHNadFY3ZStXMTZNU3BjblZUK04y?=
 =?utf-8?B?bnJ5YVpabXRXM1FvUFFsajVxZmVOWDVxOXlwQ05BNU5vand3bjIvNUtwNU5Z?=
 =?utf-8?B?WlY2RTNPWW5VbDFMMUVuSHBFMGVMWmc5K1E5dXNRVUQvMkdpU0ZkS213NmJy?=
 =?utf-8?B?VnVEVHRPQkg1bDhDeXU0eUJkNmlVWlVhQTJSU2lxeTJvT0FOY2JzcW9HRFAr?=
 =?utf-8?B?L2owVGdiTkVMaVEvSS9RSHNsKy9JbjJsMzhxWWF3VVZTaVJZY2hQZWgxRzdU?=
 =?utf-8?B?K3hrTm5RSkl6dkoyWWRRUlhuSUY0Tkh6elNsNVgwTEhXQWN5V2c2VDU3TWlI?=
 =?utf-8?B?RC9WektWTjRiN0QySkRDcUgxNGNITWltZmlEbnp5dFZtcFFGVWZ5ZHNOTzBL?=
 =?utf-8?B?TmVSTmtwalJMZXRxeTl1b2V5dmpJTFYySlA1UmhaVnpEdndIeEd5OG1pQ2d3?=
 =?utf-8?B?KzRWeDVPN2hxN3diS3Boc00yS2Noa25peG91Wk1kVjFJcTV5MXFBKzhwSDZo?=
 =?utf-8?B?WlFYUHQxZUFoVDR4OUZ6K05KZlJhRUZlbW1FMU54alBxWjFRcXZCL1R3SDZj?=
 =?utf-8?B?ditKTHd3TFpSVDdsR2N3NnpBdGl0V0krZUtHQzRBTVJzaW9FeHcwamd3aWlM?=
 =?utf-8?B?VkgzQng1SGhXSUhQN0pFeVhZTG5XUmN2QkY5bGJqVDhzeGQzbVdUVFFhTnd3?=
 =?utf-8?B?ejQzOVA4ZExCeExpaENpMFhhVU5oMGhpRHFqeDlkS2paUVNrOVRJaHYzK0hR?=
 =?utf-8?B?M2JkWU5vY2NZQmFBU05pUCt3b0NkSDBDVWhTVkZYRTRmdWFhSlkrajRpRFVV?=
 =?utf-8?B?aFAxVW11aklCMDhXL1MwSzdRbFc2NUFLanRDSGFSQUpKU3JvcitFU2pZeC9J?=
 =?utf-8?Q?Z88L2IPNINtKFH2w=3D?=
X-Exchange-RoutingPolicyChecked: Xr+T3rNfK46XhQlRvlJntKkbkQzpBKSOZDCIvLXPKxyJJlCiZxYV8yhOE0nER8rtJ6TYKAEkaDKdBtAUUqyzuPHruJJs7bX7cc34FAIe38u73opNCGUQdw1c4C+ReSTS+TTDmsQ46D2frgKyyUYAd95eygdE6HA7Cfjk2Whi1nsbHN4TU+wVCalHf2Ag22556h5SXtSpWkmltQC+T8ok51Q8oChHz8BAWP6lVaU773jm1mT5zTpBDFvWtEpjpnVOdmCvL6wV/PN313nHREfni2qrZgLYWTb4uY8zY1rhEwevRQVXc6QHCjjUd7eZFffMlKDyHoMnIMXUEj5b0pU4Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0153d2d5-16a0-447d-7f8b-08de83c6dc50
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:45:25.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ+8YveXmXHpkxgJOgVId1It0Mcz+2RobxYri7n4I0KOKigFL6d+xak29vmTGeFIssBio7zElbtXP/AzPWK8qa9h/REQ87nuhHSpzvSpTzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8557
X-OriginatorOrg: intel.com

Jakub Kicinski wrote:
> On Mon,  2 Mar 2026 16:01:56 -0800 Dan Williams wrote:
> > The implementation adheres to the guideline from:
> > Documentation/userspace-api/netlink/genetlink-legacy.rst
> > 
> >     New Netlink families should never respond to a DO operation with
> >     multiple replies, with ``NLM_F_MULTI`` set. Use a filtered dump
> >     instead.
> 
> My understanding of F_MULTI is that deserializer is supposed to
> continue deserializing into current object. IOW if we have:
> 
> struct does_this {
> 	int really;
> 	int have_to;
> 	int be_netlink;
> };

Heh, sensing a subtle message here...

> You can send "really" and "be_netlink" in one message and "have_to" 
> in the next, and receiver should reconstruct them into a single struct.
> 
> If F_MULTI is not set - receiver assumes that the next message is a new
> struct. And the whole dump returns a list of structs.
> 
> So IOW I think what you're doing is a bit too.. inventive.

Fair, but see below, satisfying the requirements here are stuck in the
liminal space between sysfs and netlink... 

> Do you have plans to add more commands? 

Yes, future work like teaching the kernel how to cache device evidence
and re-challenge a device after error or power-loss recovery [1]. It may
even supplant some sysfs interfaces that would be better with
transactional semantics.

For example, a LOCK operation that returns a session cookie and a
RUN/ACCEPT operation that only succeeds if the session has not been
invalidated in the interim. sysfs would require userspace locking for
such a semantic.

[1]: http://lore.kernel.org/69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch

> The read-only stuff feels like it could be a sysfs API?

In fact, the original genesis of a proposal in this space was sysfs back
at Plumbers 2024 [2].

As the number of attributes, modifiers, and transactions grew the
feedback in the BoF was to move to a more suitable uAPI, netlink.

Yes, a subset of the objects here could move to sysfs [3], but that does
relieve the main need here which is an interface that can dump a fresh
copy of the device measurements (settings and device data up to 16MB in
size), signed by the device, with a nonce provided by relying party
(userspace).

[2]: https://lpc.events/event/18/contributions/1955/
[3]: http://lore.kernel.org/20260219124119.GD723117@nvidia.com

> The main strength of Netlink is "do" commands with multiple optional
> attrs.

Yes, that is attractive and saves a pile of bug prone ioctl handling.

The gap I need to fill first though is a uAPI that allows for large
blobs to be fetched after being regenerated / reformatted besed on some
input attributes.

"Multi message netlink attributes" while inventive, feels less awkward
and more future proof than a sysfs binary attribute scheme to do the
same.
