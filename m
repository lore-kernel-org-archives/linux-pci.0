Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A573BBA19;
	Mon, 30 Mar 2026 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914885; cv=fail; b=cUIJ+UMxP8PX7fRWxT7S/9fc5gQPRHBUfu7fDomAfhbQcd7sZ13987NMn5S/VhOQT59f7TZQmM73/YhNZdLoXQJJJbWgFunhmGvVJSZ+RRq2q1AtnsSXtBAnZ1fLRkQ9J49adPpXcxoIaLODj2Q7/kbdsqmY3YXwUk7sLZ4XZxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914885; c=relaxed/simple;
	bh=iFHuDsO+c8820EAK79c5k837dXO6FSAQf6EYzVrPydk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HD8MuYAntOVlJzQ6N+KThnqyC12ClRFssa2cB0Cj+U2d+ENRC8T3vP5RYxWCyHiGvqQxfGd9e8xmaLhpzLMb6fmyn1VPL/+156d4iScgl8BZp2HXuhX/0nWpJ2xmU34jMTGlYedfPM6oR+mW4j11s9PoJ+tVSplnGuQPAm58QjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjdNNpu2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjdNNpu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774914883; x=1806450883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iFHuDsO+c8820EAK79c5k837dXO6FSAQf6EYzVrPydk=;
  b=mjdNNpu2QYb91Rp65MV7LxgNzNdFXINJt0fxRzqL0CmlEXyn327N/sSW
   Wg9q+Mi2t6P/zyl1dCkd2yWoOSbg7nbM6lyLdUbYKqsHnAztNv1jjnGen
   F4IQt5FJx2Bm+BRRncxTbqGbTAMWqyjJ+McVFDoWqmaHwcwu1I9pSH6Up
   mAnPXqZCFTzmsWtqESL8h5scM/Kf1+xVuV8UZHJYSzec2KY7aaSAbr9Z5
   ax/F6hwYPUXsfygJMR65wvKPK/TbHZilg+B+FHZEsXFwNHhtjc0fA5PE9
   JrEVviCn57Yle/niYZEh6yr+UWdtIkH3HvYwIQjEY2ToDQxgJ5Q4HMyQZ
   w==;
X-CSE-ConnectionGUID: aBxx5+xUTeOVAUYyjPe+Cw==
X-CSE-MsgGUID: hNmSZJoUQI2x+QSnjjSf8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87312247"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="87312247"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:54:43 -0700
X-CSE-ConnectionGUID: 522dxBmzRFiGMS+rCPtMwQ==
X-CSE-MsgGUID: 23V3VZ7ERcuP+NRp6b4mpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="225362529"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:54:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:54:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 16:54:41 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqqBOGYaZyypKaDusjj7wIrUVhBzQx+dUBHs/56z0EQSxecSa7NnixtkyRi9cc6NBt6YhxxS4LdjOXMfDodqq8/s8zaOkyQy6xa0qoHFJ/DFMz84wnIR7ywuyLdXsDXMLfAhr02o/+6TqwUi80NoEaMcEgO2lMvVe7tOWn9KxjhBuNwwp/jyJn40PaoqUarlqv4Nd6kjx1iz9Ff0vPFd7cHM+lr+6O7Az2CQeDrJ8jKGsGgSeuRhfYN1J2glP/FFgUQso+OK0k2ijrrMOicLFudf7zWiFGMniSk/NKlPAguOTEWU/9R72mlU5wMorer2DVJryfluTxMGUwIGDR1FhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFHuDsO+c8820EAK79c5k837dXO6FSAQf6EYzVrPydk=;
 b=gnHMi3cZ+tWiC0WxzncOAReUpiWqVX1guLdVD+82CeEHHWHYZFlwbUOZB6SvpMpTrV4nHm9hAQrLiyyf33xkDrAiXh6ueMtyN0r/47Nae3MSumM1HGHaHfbWPKUTmTJfU+LYlGAIlSmQ7BffkxLfAbDfz9Av2/NGRQRwlen7tPNU4VtoomyAu40/N9E26iu5BKUC2PjBlfkLrEe0JPYjmEF4pLyCafYZuHGmJ798Dnyt69iGzFzk7On/CyJ5pXmeqiQ/oRBnx18kDXz6fyoFW9GNygTmDw+BFFPzuiohi9BFHij62tzIMnzTLDIOgNAWuVspBNBmq1BZ3segJi6v4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 23:54:39 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 23:54:39 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Thread-Topic: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Thread-Index: AQHcvgX8NqWq/xJEwkC3To7bkkY7WbXHxRYA
Date: Mon, 30 Mar 2026 23:54:39 +0000
Message-ID: <828f174d49a1ecaec65ba1179e08c6b22e249297.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-6-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB5046:EE_
x-ms-office365-filtering-correlation-id: e3168f68-714b-4366-84bb-08de8eb7b481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: U0DLC/ergAbRiMYC3PgS46Testo5zXEeTK3OkIx/7Gz3IPmNNWqhYhjFPXc60yaF4IxBBKAfRFw8CfFgmaG3Fr3rFjJfv54pzAHuIti6qZIGrpnFcQhJLqqBWcub/vrQN/KMDwHQCr0k+EDIea2ARloJaksNRmE5+CgODWRjiW35pDu17AIvsecZrtrAfpufYALWonSrUsWmEizmGraqnuCe8tLVPkV1nnVVko6HHTfjwfkT9X07kok3M5sZOAw95V1UMPa5jSPgq46wt50t8eCPexwfG/PbMImuM8uCkXItAn0Sj/6Fn9NvRUqt9rPtTQVgYfq29XwOTB5y6ulzk/atjQIVcylZZhhkVDX+IfGg5snreAVB1lJvwpcHaAYx16dko0LARbcuxpeQT1cKxrtq04xqZRHaWSmTANNCe32klGnnO0wTjG/DVfEbWyOoPx78TDguxnk8EymKSAnbscJw2stcgzHMmd6yupN2vXgMQPa0WT9SpO0JGZSP2lvGYN3aLfL0uBcz6mAPbX6OW4t569YBoEiRvmzYWqQ7OcD9VKg+1docFwgpC7E/ACbOr0Hv+FRYfC/MT+jgyqgevSXOqNx2W4h1dscHHVitrW73uX+oU5gD/ysaK9PyseUWI64oWjjAr4W7ryLBrJ+/oeY3JRGU0CnBdMQnfmTDU5v+K3jfa8adqVIbiRgz44rA00Pe8+ZPSU4SJQnA1fr4ZXqJBYCW+DTG4ZlJ8ta8foiilrfP3B22FhDX1pa9zKzhPTyJJfCpiXJclQXZtjN5Z52s2GXPh0/QHsGM/IH0rQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHovQUJvNGpFZVpucXBSVDBBVk50RUhkTDdHUllic2dSMENZakNSVlBhb0tB?=
 =?utf-8?B?RG93aFh1OFlnQXk1MkhLR05oNHdJNEV6ZE9MQUNuU0ZRS3EzYVJRdExYSVJz?=
 =?utf-8?B?N05JUmE3YXU0L2Rud1dMdkhpd0dWeXFOUExuTERzbE1KbHcvclpDSi9jUGhZ?=
 =?utf-8?B?SlFsSGwrV0t0Nzdncm0xWjFRcnliWXFxODJJb1l4TXNIT1lhYm53Q0NxWlVz?=
 =?utf-8?B?Nmp3VC9LaFYzL0RDZzV2L1piVnhRUkVMeU52c2x2SmpPdVlBcmxyS1J5VTY3?=
 =?utf-8?B?QUN0SUFvVGxnd2xSZnZYWWYzblFWRFVobkgwSjBCdmZhTkZocSszY1RjblBQ?=
 =?utf-8?B?ZittTERJMEpkN2V5Z25scDlIbzBWSmIrYzROUXdQTS9VcitsRDB6TkZtZHhP?=
 =?utf-8?B?N3RNcFcrWExpZ0txYnJtczBiOTFSZTYxczYxVmYxT2lCYXN4S0VUOE9ST1dT?=
 =?utf-8?B?Qno0cGpXeXNGSk1hSk9FT29OQTNyVk1WM2IwcmF2Vi9sTlpkeUw5a3lPRHIw?=
 =?utf-8?B?di9YaHZBRXFEMmVWQm9lV2w2aWsxTUNrTzdKZ1d6cE5QUlBpaVlYU0FnMUZI?=
 =?utf-8?B?emxML29Zdk02NlFZS0RRbzBFS2ZISUNVeG41eGtOVlVONVZQNDd4enZoVXJV?=
 =?utf-8?B?SlJpN3hXY1RpUkdYRkxjclBVWi9TcC9MOWxyVGM3VFVwMkhnRk52OStZTDQx?=
 =?utf-8?B?VXAwSVM0SVEzaEtiWTk4M1dpNk5PMDJyY0xVYlJXelBhOEpKTFJURitBZWw2?=
 =?utf-8?B?NEo5VEVqV1UyRC8zL0lwNkYxM3YxTzJxQlBHcUVDdXVhTU5ZSVVmbEx0UE5U?=
 =?utf-8?B?b3NCYlRlRHFicllZZlFlV2JDMzMxOXpmQzBKVjRIR0d4bThjTFdTL3o3SS83?=
 =?utf-8?B?WGo0MTVnc1o1WkxuOUM3ZUtxWFZDVWtGY1JzYm5IMktPT295WDlYTEUvVHVn?=
 =?utf-8?B?S1pKMWQwZXc0YWZBdGRRMHpkUk5aQzROUDdqeVBmRFdxdEZhWVFqZk1tWXp1?=
 =?utf-8?B?SVMxV2hoTlFINHBVWXRvZGtYT1dDWDlPSkY5dHFiZUFPc3NsWE50R3E4WEc2?=
 =?utf-8?B?SnBuYzdEK1dFNWdjay9kc280QlZhR3E2amFlN2N0bXJ0eWNwYUgyNFAvMlZt?=
 =?utf-8?B?bEgvbmZRMU4yaVUydDFVVDRzbkJWMXdJRzVTdTNQSXdyZXMzN3NPcU5PMmkr?=
 =?utf-8?B?WVZRcVo2TkVoVWo3V2hlbEp1S016K2lCTE00bUwxc1FPbUJZQWsxK2FpcHJL?=
 =?utf-8?B?eWFWOUhlQlgzZXVEc0FBbzBiK1U5OVZBNlVBWFJGYW9vbDNkQ0sxK3hJeEVa?=
 =?utf-8?B?N1lGTDRtcjFuZUxkbVV1SkFKRExNQU5Dd2VTclZKWUpKWUJraG9wOWFWdktK?=
 =?utf-8?B?Vjk2RTNmQzZKMEJoSVdTa3dQVGQxaHpWMHRnTkxLNmNhMWVFcmVLUUdKMGdQ?=
 =?utf-8?B?YVc1WEFCQ0d3SWFWZUwzdWptTXBObnhCSk9nOUthbjZub1pYcTFMOW96RkU2?=
 =?utf-8?B?aUZSOHhhR1BrSVRHY0lIMFZwdGxZNnFuMHNFeUhlTG1qZ09xVytLZ0tuTHg1?=
 =?utf-8?B?dS90SE9PQXRPeTBPUFkxNzdEYUltdS9kWXIvb3BCNzFwUk1aeHNyZ1F6dDVJ?=
 =?utf-8?B?c3pkN0wyN3dvZzRaWWNhRzBQdHFWb3k4UUgzcjhmUm5FZkpqMzFxdmoxQ0Jr?=
 =?utf-8?B?aFlVT1BibGx1Q2FGbnVYekNYR3pjdnpoSGNxY3c2Tm94cjhGbW01WVZKWFlE?=
 =?utf-8?B?K053VC90Yk0rSUhZeHFqWU1pRDJ2d1FSQ0hoUjlOQmJsWEZQVUtiR1UyclBz?=
 =?utf-8?B?d2MwZVkwUzlOZ1BMNGF6K3pPa2QzUWMrZE9VNGNER2FvTkgzZjlQaW5VSmF1?=
 =?utf-8?B?dGsraDBpbG5BRmZtRG9CVEV3YW0rUkE1YmdzclhUbkdaNHlNemNTL1dYVnk0?=
 =?utf-8?B?bFczRllzeGpZdVBNVVhoYXhzTHVnZWx6UHVaVmczQXNIRFU5akw0Nk8xRitL?=
 =?utf-8?B?NFlSZU8rSlorYy96RkhveEw4QytITStxZ2ZGMkovL2V1N0dVWkdIVi83a3dl?=
 =?utf-8?B?UmF4WW5GaEQvTzJXWWhicks1OWxLS0UwS0E4WTlJL1FRYXJtS3hyd0ZITzh5?=
 =?utf-8?B?UFJic1lSbTk5N1R6SmtNVDdDYUdjMWVBZnZvWHpEU1JPa21UbjBLQStiQi96?=
 =?utf-8?B?MXQybEF0bkY5azhzWEtFZ05SSmczN0Nnd0syMzh6bm9xQm9Ed1FnTXU4ZmUy?=
 =?utf-8?B?bkdpd0gycjY5NS9VVWhycnljbG5uT3I4K1A5K2xvQkZwUTBXTkp0NjJTZ2M4?=
 =?utf-8?B?UHI3aTFGUmJOVkZoUkovd2pjamdIY25JKzhqOVFxMmFxUEx4bStmRHFHYW9N?=
 =?utf-8?Q?qG/pni1qKOV0k+dw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E98B9CD94DA9574E8190144C6383F754@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bqDtGGxe+ekgr1LEMbrACbCBJfjSLgspw0eSSVml9cd5+ekkF64IclIFX7sPw2xk50f791WJHGoDlTvzj+2gPq+C41Y0OxH7dPDvLjrsPl8iDRRiudD9w0eSTN1RM1t8eBhaqrOCWYRoCrFAvlxd1KV1G0Znc6qQIBhyY9zb5wRi2CkpdE503dUJX/0QtmuCoQJC88OL9+lCKTl5BOB2353SuVMrGifj2FlwQ2VlnVjYKd8Cq0Y0q3e/BvgR1PjBNkhTMxssYWKAM+cuxTvruOwQ1zxMIFO6D+Hr1TFHgtDREF+1CewJexVg+fVMOAKgVLGt0WGwIHR1ZSPXiyI3Ug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3168f68-714b-4366-84bb-08de8eb7b481
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 23:54:39.1244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgL2c/VjLbMosRW68WxxXvycEE9WMP1K8+PjyttEX0xH3fOB5s2iMI7m+o/6UZqALSKYz+RMU+M7wUVEhs2Hz1A2bi79RTd+G7rwHsrVTFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTI4IGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gSU9N
TVVfTVQgaXMgYW5vdGhlciBURFggTW9kdWxlIGRlZmluZWQgc3RydWN0dXJlIHNpbWlsYXIgdG8g
SFBBX0FSUkFZX1QNCj4gYW5kIEhQQV9MSVNUX0lORk8uIFRoZSBkaWZmZXJlbmNlIGlzIGl0IHJl
cXVpcmVzIG11bHRpLW9yZGVyIGNvbnRpZ3VvdXMNCj4gcGFnZXMgZm9yIHNvbWUgZW50cmllcy4g
SXQgYWRkcyBhbiBhZGRpdGlvbmFsIE5VTV9QQUdFUyBmaWVsZCBmb3IgZXZlcnkNCj4gbXVsdGkt
b3JkZXIgcGFnZSBlbnRyeS4NCj4gDQo+IEFkZCBhIGRlZGljYXRlZCBhbGxvY2F0aW9uIGhlbHBl
ciBmb3IgSU9NTVVfTVQuIEZvcnR1bmF0ZWx5IHB1dF9wYWdlKCkNCj4gd29ya3Mgd2VsbCBmb3Ig
Ym90aCBzaW5nbGUgcGFnZXMgYW5kIG11bHRpLW9yZGVyIGZvbGlvcywgc2ltcGxpZnlpbmcgdGhl
DQo+IGNsZWFudXAgbG9naWMgZm9yIGFsbCBhbGxvY2F0aW9uIG1ldGhvZHMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4g
IGFyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oICB8ICAyICsNCj4gIGFyY2gveDg2L3ZpcnQvdm14
L3RkeC90ZHguYyB8IDkwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4g
IDIgZmlsZXMgY2hhbmdlZCwgODkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaCBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3RkeC5oDQo+IGluZGV4IDkxNzNhNDMyYjMxMi4uZDVmMWQ3YjdkMWU3IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS90ZHguaA0KPiBAQCAtMTc1LDYgKzE3NSw4IEBAIHZvaWQgdGR4X3BhZ2VfYXJyYXlf
Y3RybF9sZWFrKHN0cnVjdCB0ZHhfcGFnZV9hcnJheSAqYXJyYXkpOw0KPiAgaW50IHRkeF9wYWdl
X2FycmF5X2N0cmxfcmVsZWFzZShzdHJ1Y3QgdGR4X3BhZ2VfYXJyYXkgKmFycmF5LA0KPiAgCQkJ
CXVuc2lnbmVkIGludCBucl9yZWxlYXNlZCwNCj4gIAkJCQl1NjQgcmVsZWFzZWRfaHBhKTsNCj4g
K3N0cnVjdCB0ZHhfcGFnZV9hcnJheSAqDQo+ICt0ZHhfcGFnZV9hcnJheV9jcmVhdGVfaW9tbXVf
bXQodW5zaWduZWQgaW50IGlxX29yZGVyLCB1bnNpZ25lZCBpbnQgbnJfbXRfcGFnZXMpOw0KPiAg
DQo+ICBzdHJ1Y3QgdGR4X3RkIHsNCj4gIAkvKiBURCByb290IHN0cnVjdHVyZTogKi8NCj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQvdm14
L3RkeC90ZHguYw0KPiBpbmRleCA2YzRlZDgwZThlNWEuLjJiMTdlMGY3M2RhYyAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC90ZHguYw0KPiBAQCAtMjc1LDggKzI3NSwxNSBAQCBzdGF0aWMgaW50IHRkeF9wYWdl
X2FycmF5X3BvcHVsYXRlKHN0cnVjdCB0ZHhfcGFnZV9hcnJheSAqYXJyYXksDQo+ICAJCQkgICAg
VERYX1BBR0VfQVJSQVlfTUFYX05FTlRTKTsNCj4gIA0KPiAgCWVudHJpZXMgPSBhcnJheS0+cm9v
dDsNCj4gLQlmb3IgKGkgPSAwOyBpIDwgYXJyYXktPm5lbnRzOyBpKyspDQo+IC0JCWVudHJpZXNb
aV0gPSBwYWdlX3RvX3BoeXMoYXJyYXktPnBhZ2VzW29mZnNldCArIGldKTsNCj4gKwlmb3IgKGkg
PSAwOyBpIDwgYXJyYXktPm5lbnRzOyBpKyspIHsNCj4gKwkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBh
cnJheS0+cGFnZXNbb2Zmc2V0ICsgaV07DQo+ICsNCj4gKwkJZW50cmllc1tpXSA9IHBhZ2VfdG9f
cGh5cyhwYWdlKTsNCj4gKw0KPiArCQkvKiBOb3cgb25seSBmb3IgaW9tbXVfbXQgKi8NCj4gKwkJ
aWYgKGNvbXBvdW5kX25yKHBhZ2UpID4gMSkNCj4gKwkJCWVudHJpZXNbaV0gfD0gY29tcG91bmRf
bnIocGFnZSk7DQo+ICsJfQ0KPiAgDQo+ICAJcmV0dXJuIGFycmF5LT5uZW50czsNCj4gIH0NCj4g
QEAgLTI4Niw3ICsyOTMsNyBAQCBzdGF0aWMgdm9pZCB0ZHhfZnJlZV9wYWdlc19idWxrKHVuc2ln
bmVkIGludCBucl9wYWdlcywgc3RydWN0IHBhZ2UgKipwYWdlcykNCj4gIAlpbnQgaTsNCj4gIA0K
PiAgCWZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsgaSsrKQ0KPiAtCQlfX2ZyZWVfcGFnZShwYWdl
c1tpXSk7DQo+ICsJCXB1dF9wYWdlKHBhZ2VzW2ldKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGlu
dCB0ZHhfYWxsb2NfcGFnZXNfYnVsayh1bnNpZ25lZCBpbnQgbnJfcGFnZXMsIHN0cnVjdCBwYWdl
ICoqcGFnZXMsDQo+IEBAIC00NjMsNiArNDcwLDEwIEBAIHN0YXRpYyBib29sIHRkeF9wYWdlX2Fy
cmF5X3ZhbGlkYXRlX3JlbGVhc2Uoc3RydWN0IHRkeF9wYWdlX2FycmF5ICphcnJheSwNCj4gIAkJ
CXN0cnVjdCBwYWdlICpwYWdlID0gYXJyYXktPnBhZ2VzW29mZnNldCArIGldOw0KPiAgCQkJdTY0
IHZhbCA9IHBhZ2VfdG9fcGh5cyhwYWdlKTsNCj4gIA0KPiArCQkJLyogTm93IG9ubHkgZm9yIGlv
bW11X210ICovDQo+ICsJCQlpZiAoY29tcG91bmRfbnIocGFnZSkgPiAxKQ0KPiArCQkJCXZhbCB8
PSBjb21wb3VuZF9ucihwYWdlKTsNCj4gKw0KPiAgCQkJaWYgKHZhbCAhPSBlbnRyaWVzW2ldKSB7
DQo+ICAJCQkJcHJfZXJyKCIlcyBlbnRyeVslZF0gWzB4JWxseF0gZG9lc24ndCBtYXRjaCBwYWdl
IGhwYSBbMHglbGx4XVxuIiwNCj4gIAkJCQkgICAgICAgX19mdW5jX18sIGksIGVudHJpZXNbaV0s
IHZhbCk7DQo+IEBAIC01NTUsNiArNTY2LDc5IEBAIHRkeF9wYWdlX2FycmF5X2FsbG9jX2NvbnRp
Zyh1bnNpZ25lZCBpbnQgbnJfcGFnZXMpDQo+ICAJcmV0dXJuIHRkeF9wYWdlX2FycmF5X2FsbG9j
KG5yX3BhZ2VzLCB0ZHhfYWxsb2NfcGFnZXNfY29udGlnLCBOVUxMKTsNCj4gIH0NCj4gIA0KPiAr
c3RhdGljIGludCB0ZHhfYWxsb2NfcGFnZXNfaW9tbXVfbXQodW5zaWduZWQgaW50IG5yX3BhZ2Vz
LCBzdHJ1Y3QgcGFnZSAqKnBhZ2VzLA0KPiArCQkJCSAgICB2b2lkICpkYXRhKQ0KPiArew0KPiAr
CXVuc2lnbmVkIGludCBpcV9vcmRlciA9ICh1bnNpZ25lZCBpbnQpKGxvbmcpZGF0YTsNCj4gKwlz
dHJ1Y3QgZm9saW8gKnRfaXEsICp0X2N0eGlxOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwkvKiBU
T0RPOiBmb2xpb19hbGxvY19ub2RlKCkgaXMgcHJlZmVycmVkLCBidXQgbmVlZCBudW1hIGluZm8g
Ki8NCj4gKwl0X2lxID0gZm9saW9fYWxsb2MoR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8sIGlxX29y
ZGVyKTsNCj4gKwlpZiAoIXRfaXEpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJdF9j
dHhpcSA9IGZvbGlvX2FsbG9jKEdGUF9LRVJORUwgfCBfX0dGUF9aRVJPLCBpcV9vcmRlcik7DQo+
ICsJaWYgKCF0X2N0eGlxKSB7DQo+ICsJCXJldCA9IC1FTk9NRU07DQo+ICsJCWdvdG8gb3V0X3Rf
aXE7DQo+ICsJfQ0KPiArDQo+ICsJcmV0ID0gdGR4X2FsbG9jX3BhZ2VzX2J1bGsobnJfcGFnZXMg
LSAyLCBwYWdlcyArIDIsIE5VTEwpOw0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gb3V0X3RfY3R4
aXE7DQo+ICsNCj4gKwlwYWdlc1swXSA9IGZvbGlvX3BhZ2UodF9pcSwgMCk7DQo+ICsJcGFnZXNb
MV0gPSBmb2xpb19wYWdlKHRfY3R4aXEsIDApOw0KDQpUbyBtZSBpdCBzZWVtcyBsaWtlIHRoaXMg
Y2FuJ3QgcmVhbGx5IGJlIGNhbGxlZCBhIHBhZ2UgYXJyYXkgYW55IG1vcmUuIFRoZSBmaXJzdA0K
dHdvIHU2NCdzIGFyZSB0b28gc3BlY2lhbC4gSW5zdGVhZCBpdCdzIGEgc3BlY2lhbCBvbmUtb2Zm
IEFCSSBmb3JtYXQgcGFzc2VkIHZpYQ0KYSBwYWdlLg0KDQpCVFcsIEkgY2FuJ3QgZmluZCBUREgu
SU9NTVUuU0VUVVAgaW4gdGhlIGRvY3MuIEFueSBwb2ludGVycz8NCg0KPiArDQo+ICsJcmV0dXJu
IDA7DQo+ICsNCj4gK291dF90X2N0eGlxOg0KPiArCWZvbGlvX3B1dCh0X2N0eGlxKTsNCj4gK291
dF90X2lxOg0KPiArCWZvbGlvX3B1dCh0X2lxKTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9
DQo+ICsNCj4gKy8qKg0KPiArICogdGR4X3BhZ2VfYXJyYXlfY3JlYXRlX2lvbW11X210KCkgLSBD
cmVhdGUgYSBwYWdlIGFycmF5IGZvciBJT01NVSBNZW1vcnkgVGFibGVzDQo+ICsgKiBAaXFfb3Jk
ZXI6IFRoZSBhbGxvY2F0aW9uIG9yZGVyIGZvciB0aGUgSU9NTVUgSW52YWxpZGF0aW9uIFF1ZXVl
Lg0KPiArICogQG5yX210X3BhZ2VzOiBOdW1iZXIgb2YgYWRkaXRpb25hbCBvcmRlci0wIHBhZ2Vz
IGZvciB0aGUgTVQuDQo+ICsgKg0KPiArICogQWxsb2NhdGUgYW5kIHBvcHVsYXRlIGEgc3BlY2lh
bGl6ZWQgdGR4X3BhZ2VfYXJyYXkgZm9yIElPTU1VX01UIHN0cnVjdHVyZXMuDQo+ICsgKiBUaGUg
cmVzdWx0aW5nIGFycmF5IGNvbnNpc3RzIG9mIHR3byBtdWx0aS1vcmRlciBmb2xpb3MgKGF0IGlu
ZGV4IDAgYW5kIDEpDQo+ICsgKiBmb2xsb3dlZCBieSB0aGUgcmVxdWVzdGVkIG51bWJlciBvZiBv
cmRlci0wIHBhZ2VzLg0KPiArICoNCj4gKyAqIFJldHVybjogRnVsbHkgcG9wdWxhdGVkIHRkeF9w
YWdlX2FycmF5IG9yIE5VTEwgb24gZmFpbHVyZS4NCj4gKyAqLw0KPiArc3RydWN0IHRkeF9wYWdl
X2FycmF5ICoNCj4gK3RkeF9wYWdlX2FycmF5X2NyZWF0ZV9pb21tdV9tdCh1bnNpZ25lZCBpbnQg
aXFfb3JkZXIsIHVuc2lnbmVkIGludCBucl9tdF9wYWdlcykNCj4gK3sNCj4gKwl1bnNpZ25lZCBp
bnQgbnJfcGFnZXMgPSBucl9tdF9wYWdlcyArIDI7DQoNCkNvbnNpZGVyIHRoZSBhbW91bnQgb2Yg
dHJpY2tzIHRoYXQgYXJlIG5lZWRlZCB0byBjb2F4IHRoZSB0ZHhfcGFnZV9hcnJheSB0bw0KcG9w
dWxhdGUgdGhlIGhhbmRvZmYgcGFnZSBhcyBuZWVkZWQuIEl0IGFkZHMgMiBwYWdlcyBoZXJlLCB0
aGVuIHN1YnRyYWN0cyB0aGVtDQpsYXRlciBpbiB0aGUgY2FsbGJhY2suIFRoZW4gdHdlYWtzIHRo
ZSBwYSBpbiB0ZHhfcGFnZV9hcnJheV9wb3B1bGF0ZSgpIHRvIGFkZA0KdGhlIGxlbmd0aC4uLg0K
DQo+ICsJc3RydWN0IHRkeF9wYWdlX2FycmF5ICphcnJheTsNCj4gKwlpbnQgcG9wdWxhdGVkOw0K
PiArDQo+ICsJaWYgKG5yX3BhZ2VzID4gVERYX1BBR0VfQVJSQVlfTUFYX05FTlRTKQ0KPiArCQly
ZXR1cm4gTlVMTDsNCj4gKw0KPiArCWFycmF5ID0gdGR4X3BhZ2VfYXJyYXlfYWxsb2MobnJfcGFn
ZXMsIHRkeF9hbGxvY19wYWdlc19pb21tdV9tdCwNCj4gKwkJCQkgICAgICh2b2lkICopKGxvbmcp
aXFfb3JkZXIpOw0KPiArCWlmICghYXJyYXkpDQo+ICsJCXJldHVybiBOVUxMOw0KPiArDQo+ICsJ
cG9wdWxhdGVkID0gdGR4X3BhZ2VfYXJyYXlfcG9wdWxhdGUoYXJyYXksIDApOw0KPiArCWlmIChw
b3B1bGF0ZWQgIT0gbnJfcGFnZXMpDQo+ICsJCWdvdG8gb3V0X2ZyZWU7DQo+ICsNCj4gKwlyZXR1
cm4gYXJyYXk7DQo+ICsNCj4gK291dF9mcmVlOg0KPiArCXRkeF9wYWdlX2FycmF5X2ZyZWUoYXJy
YXkpOw0KPiArCXJldHVybiBOVUxMOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwodGR4X3Bh
Z2VfYXJyYXlfY3JlYXRlX2lvbW11X210KTsNCj4gKw0KPiAgI2RlZmluZSBIUEFfTElTVF9JTkZP
X0ZJUlNUX0VOVFJZCUdFTk1BU0tfVTY0KDExLCAzKQ0KPiAgI2RlZmluZSBIUEFfTElTVF9JTkZP
X1BGTgkJR0VOTUFTS19VNjQoNTEsIDEyKQ0KPiAgI2RlZmluZSBIUEFfTElTVF9JTkZPX0xBU1Rf
RU5UUlkJR0VOTUFTS19VNjQoNjMsIDU1KQ0KDQo=
