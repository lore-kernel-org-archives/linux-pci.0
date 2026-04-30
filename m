Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83089287257;
	Thu, 30 Apr 2026 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777587584; cv=fail; b=fL29P4UB8vMEuAp/UdPBJbIYp2MiuUPztdmI9hOxuHui2xB2gNIfsC88yAN6sXm+6uZIVD+gaFjuLdSfXeURqIwHX/h35a6kZBcqGm8IsGHleq4xkyKn44MugJ4m1M5YN4HZrvCcv6AxayLu5LbZKUR+t4ZG5yg5LUofot/Fq4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777587584; c=relaxed/simple;
	bh=eBLdPUe6QOBWCvlqG4ol7wnlMwHGMh+m1QIhGywksmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uvSmT8TTEsv4LhMjuIlLk/J+uoqtU4JdGcHbJ37mONbggYGZbheB35dcpSasaBn04INACQhZQ5244jjJnt6yK1tzqwljKMcYZgeyHxw4HnIK8FOXz4KGL7iI4SROBC1zOc3QrmDpO+6sgAg8EKwBtgjX8WRPwUo6MXXPu7A+ojo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCrKv7Yy; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCrKv7Yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777587582; x=1809123582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eBLdPUe6QOBWCvlqG4ol7wnlMwHGMh+m1QIhGywksmE=;
  b=eCrKv7Yy+dq74Utqaix0+ZFS/pPErwuQagI9pzUEu1P7kVWsGSkR+PVR
   yD7Kk4LtyjimlMmEeXKwVgJL2JXbmcmLvC6pq4VH43zhVSvoOg7zuDust
   IxfU+004K1m/jLdmrsJHAZqzy8uLMnzq9E/rLlqmtPV3RacIV0BApLvsB
   KqOfhniWZpbeYf9XT20LvMek82yCmdJ3sWl06OxTcggRd2ctP6gIqtc3c
   Ni1GfoamEYRuvnQHYnjXNtSJR0gbJ2oHnkOQsCwxaY4n7TBwfh9B69lCs
   41ymChMDKxLT8Sew7ZWGJF8Iav6P/dU+ncY/iu1uAJirAi7TONzHCGfq+
   g==;
X-CSE-ConnectionGUID: dPC6nEicS1iw94QN2XuFBg==
X-CSE-MsgGUID: kWyl5KzARauNwKmtTBpdJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78545094"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78545094"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 15:19:42 -0700
X-CSE-ConnectionGUID: 2Gij6nV1QQWiMBTDKHWxDQ==
X-CSE-MsgGUID: QDTKf30CQAWr9Pk3VfA9eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="239695061"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 15:19:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 15:19:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 15:19:41 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 15:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMENOac2H35uXe+fuWeT3fsV9+/bVtoxrH03CHNIcVsmQkc3Q/akcTS3m5fkCb7eKD72pcXYgki61x/bLCq4WxnSl/MTeWiC9DxL3xZL/DQzdLEBbDGShe2PCx9KZ8/Yu/7tT6RCWoImqDdNJP56+5AFUP3oD9tMtriilTWCY0OEJNJMASxQSf9nciTfl2rAEnR6gmXXQoi2hkHUe6shCx9Ckmx52MNhNBSt3U078Qg3HxEaAvRWAsfAaH9+t7BIVcIwfMuDnk+FIzurRjOLSGAkasgP+2LmbY1zkyD6gVQ+CGT5ihJ5b3PgALrCjQHDWZtIMeKlW0Ihvc3CniGGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBLdPUe6QOBWCvlqG4ol7wnlMwHGMh+m1QIhGywksmE=;
 b=gnuz2J1++4LfptJxgonb2L7saChl/TjjUsWiK1f05/Ym6Og/I3ntsnO8MQtORZRU/6WzbQco25XkvYRcVoG7LYJ45ktHSTCjkQsaI5PTmp+3GnPVUoTEKY+0ETDTn/8N0byiVjh1paS3Avyg0FBiVRaCHmIywV3I8BRBi0LieiEEAEdy71goBidrzauV6NJR5eSJGgRXvB7Ma8hb8+kJlt8jhoYCUMnODHrQnFlLlIppm8Ks/W7YNbQjHbfGtzl5+veM7R28TiGGKiBHra62yHMc4i4BnCQHCWVsINL6BuOZQqqiYE6L8E067SUR8v2ru2S6jXC1XaZPYs0s2rLqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 22:19:35 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 22:19:35 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC: "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [RFC PATCH 3/4] pcie/aspm: Enable all hardware power-saving
 states by default
Thread-Topic: [RFC PATCH 3/4] pcie/aspm: Enable all hardware power-saving
 states by default
Thread-Index: AQHc2AL/Zy8jPIuUMkaZ3Il+EtnH4bX3ZPaAgADJ24A=
Date: Thu, 30 Apr 2026 22:19:34 +0000
Message-ID: <fcabed06c2b6fa163954e18972ae70bccdcffbf7.camel@intel.com>
References: <20260429180647.197072-1-thomas.falcon@intel.com>
	 <20260429180647.197072-4-thomas.falcon@intel.com>
	 <dfff52bc-06ad-0531-f28a-72804620c072@linux.intel.com>
In-Reply-To: <dfff52bc-06ad-0531-f28a-72804620c072@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS0PR11MB7334:EE_
x-ms-office365-filtering-correlation-id: 4bc08dff-9189-46ff-4ff6-08dea7068f72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: yfkbvNAMOigLvOBHQdqOPRaBQD9R659wQ7rwSTViO4oniZPouAO9slmifmVcFwI9zIMIOvGaK3HgTr0x6oMdUdDSGsGk9tVv3CmQZo202TY0zMoefQSmunZFTTUh65c9AhrJt+MNg79imPZM3yObsJsZfgSk7h5F8ShRnMusd7pyZbZyo4ojRaGHJxL4VzAAiNcKVDAt01vl8Aq/iWeP2DcZsMhZfMgTQt88aeMwwlxp6SD39i3b6BawdtHJLRHhU8/tvQgLXF4Md+24QkmjwA1x4FPjcT7yaKAvozE6wbNix8O/tkcrq5r23HMac3RMkVVIn6xwTaZvNq9ntlcklKT0zsQSVxmoaE1n6thzUf2NPpbhrMGeUqlZ6QpmLLYTdnqCcnzbQDIHFqBbu3zgwvLn9tFzXQliOY3pqKi+MDk/UYbGZeOJf9zNNl0GeGXRY2LQ9wOr3BMZ2jr+9ZHb26vcmDULbvSvZi+d/qCmG289pdpgMPw7YlVyeaRXTcSp0sw7C6Q4v5i54cLiZiBCg2xwWAHuLHx6HLAd5kn81xAvNBuPCjXJ2TM4ZbJIsvxVdDWmKARbnCgFhq6XvKwbUi6N8ugZMsLCGCZpVk5pUZEjpO1TXHHMAanDUnooluPFL4Q7JqT7tHI17L8GukZ+oXSiok1QAy0VL2bqxy++HwjBYQf0DIrunjvk07nDMaRcgvE69S8XCoGREpi9u+VR7SSNAjKHJczm7Dt6M1nvbm/Gh7U3R5sAhetODMoG2/ji
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ui9RS1lBUWxXYjIrczFDSytEbW5hTUo2OXpoUzRMb0tmbjQ3cUZPdnNsN1dx?=
 =?utf-8?B?SWdhN0NMT0hUZUhjZFQxelNKMzFJRm5RbXlQbjFEbmdJY1RaeVZxK01MenBI?=
 =?utf-8?B?ZjBBcVdXOFVQVkVvSVRRYTluanRQMVdUZUNwVTBsSXUxRnpPUWJqbWtocHlZ?=
 =?utf-8?B?QTBFakp6ZkZHNnFzVG81K1BHM0RJdzU5RHZCYUYyVUpacXZpR3p4a2M3cHFJ?=
 =?utf-8?B?bFc4RjN5ZlY3czMzK0JyWEwzbzIwM3pDcHc2dURObVZwTWZ0aTJ1amJvZ2RU?=
 =?utf-8?B?RHV6UlozTEFUaHhhZDd4SXNGL0lxSy9PUnZHc1haWGhDSFFvT1hNeWhTT3gv?=
 =?utf-8?B?T1lHN3BTY09zWmJsZFdqQmlVclorL0QvZDFaU2hkRFE0Q2thYTdzNUlvM0lw?=
 =?utf-8?B?Y2QyN0Z5dVZWaGJWUkZEMTg1b1BiWkEwOWhNSkpEYXM3V2VwZS8zOVh4bVhL?=
 =?utf-8?B?NkZ5Ty9vZjNETWh3YWNVVEFnZGxLWExsRlFETUl6YmdBUndqMVFmTWxua2VL?=
 =?utf-8?B?TnhWWWtKbVpHSUZMK2JPTElVaXd1Q2tNaDIzQjdXQ3VXUkNkdlBlbEN3czdI?=
 =?utf-8?B?Vy85TS9FeUhSK09uY1pmSHFIQ29ndTIyb1poMHlZZ0JlamE5d1owQzhYYzVS?=
 =?utf-8?B?Q3BSSUo2MkhzelpicE82eWJDb2ZhS0dPaGluQU03UmNxR3l1TG5aZFpQZTg5?=
 =?utf-8?B?Rm4rTE1kNjV3bCtKUkUraUJBeVh3WDVRRkVlMG9YdHBLbGJ0bWIxNFJKZWN3?=
 =?utf-8?B?dkFaaFowK21YcEhpeU5mc2xwcldrMVNRbjZzSnBHOGVZOHhpa2Z0UGdUQmNV?=
 =?utf-8?B?THRnaXFMQTE4dTZwUHNYNkgyLzdiUG43SmVNNXZDYm5uMS9uRXJ4d0FMd205?=
 =?utf-8?B?bUdiODhVOWh6ZVRkVHFzTzZCdGJIMi9kWTVUeGtNcC94K0pSYmQxRkpNUHQ2?=
 =?utf-8?B?UC9LK3JuMzFBa1VHRTNlZlN4MklCZkFuWE5BVHBxdjVIWE83QUE3ZTBQQ2Nu?=
 =?utf-8?B?UXptUDQzYmM1NzA3dHQvY0xLV2NQVDhNR0swcjdFNFNQNTFOWUwzdi9NUmtw?=
 =?utf-8?B?RXlCZkVpb0Q0NGVmeERGcWR2SU4yeU93S2pCRmZQeW5MZXNyTmJBWFpLWVFa?=
 =?utf-8?B?Z2huclU2NnZMN0hLRkY0bE5ld2RSUWVBVUY5cnlUSmgxZFhQc2t0VHo0TE1W?=
 =?utf-8?B?cVNjTHh5ajFEWjE1TUUyYi9vZlFjYzVrenBTbC9DUmpYb0NKemIrU1JrRjBN?=
 =?utf-8?B?RlJLamFubk5zOTFNejM2dDIxdWZRV2VNbTBJMUpMbEhvVS8vTFM0ZHBXbXdW?=
 =?utf-8?B?WnlZQi9DdFFrTVh2ektXbzRNNHdIbERXWmYrMmJFN1haN1RwbWNiL1hCTlhG?=
 =?utf-8?B?ZkZYRkkwK0RpSnlwaW84VjVtbWxReGZMbWJtT0VIVkRsSlREZUdtQ3BmUXlH?=
 =?utf-8?B?Q21GOUIwdkNmSVhmOXR0c0dZdkNUL1cvR0szdGJIaHJSNWlFYlY3SDh0MVIz?=
 =?utf-8?B?ZlpXUlhiNTJERENobkZweDFYcjljMXJiMkswbGxCUE9FbmdNY0orU1M3R2lq?=
 =?utf-8?B?MGNXamREREpibkFPQlJua2pDNUNXeXJKR1FBek5FVVZjbU5ZNTNZeTdKQTlD?=
 =?utf-8?B?RllFU0ppZXlqMk4wZ005aXd3emVDcUtyS1JUbmYvWGJTMXpaMTd4QVk2NEtt?=
 =?utf-8?B?UERMTmxmd0tYVkcveEhQcTY3bzNjQTZRMTlGaGdBZmhFbWpUWDZsdzEwN1NE?=
 =?utf-8?B?NXZBTEk0TklBRDRTSyt4UkpseklUVWgwSVZwK0ZrT08rVzExUjNDRHJzdHd1?=
 =?utf-8?B?L2NtemduZkxDUXFvWXRUQUo2TFVZTGpFVlgxS0hScXllWHNGMDhpT2RZK0VN?=
 =?utf-8?B?QWNaQWZ1WlNCQ212MllPeFVIYmZFNENaZ29MWCtVZ2dwZ21ta1MrMjI1T1Q2?=
 =?utf-8?B?aFJsZ2trZjIrSitrQzhmWklheDNIV21lNG5UczZzc0ZyczBoRmRBTzRuWFds?=
 =?utf-8?B?RUt0VFVZWkptYkhETFVQQjVOT1czVkw5NUw3dEEvTDZzOTNSeUZQNW9JbDF6?=
 =?utf-8?B?ZzNDOUtYRmRjZFFWT3U5U0JvR1IzZklGankrakFYOERoWGUyZEN2Q0tveHV3?=
 =?utf-8?B?YXZFRStxeVJwQUVoZlpGd1E5K0w4ZDVGanpLcmpKdzdXaGxNUEJwSGxnbXBO?=
 =?utf-8?B?Ni9LTmhjd2NadFVsZ0VxV3dnWHN6ZXFBd2ttMnZUdFdKZXArVjRwQ0V5ajRx?=
 =?utf-8?B?eWNxY25obUNzU2xWSlN3UEtLc2lsSFZWc25kQTBzZzQva0ZabDN3Q25OUTBW?=
 =?utf-8?B?WWxyMERNclNQQ05NWDA4Z0huclhLeHV2UDNBVnEzMTFsOWc3NnV5OXNkazQr?=
 =?utf-8?Q?PyGOpIK9XcWrUm2s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3CC794C2464624BB90864284759C17B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GEtOUJThHtGQNDoHdMMcJocCPVI6wWOlNnp+c48jCq7tVaglF2i5RSXwJioiQFWIJUmV2JsNtedaMyIeWW/L802vb0ov6vVxKdsWTUpgsTZHxrP9qWvASRPF6YyUudf3fjrm2HcFfC9OfJRMlhwFOesht6XOPUKtXWXmF7HFtkyjihN02eRxGi2vkohDJqkyXNx5JOJWkWIw/0db7KZ0wTUqDq1ntEKw0hTM3GWZXgn/qRO3dL/NkV56a4bqwNvVJc6ddCuNwPjNLKpMiW7Sk95lEzWWasdM6ZJhY0qdugiSXQMHi6eWTEbuh33tJMVL7WoaxZeHBZkpf6vDQu+acQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc08dff-9189-46ff-4ff6-08dea7068f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 22:19:35.0720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdD0KN4pG5819CdI5ay7LZtkE4kXHnBkzXAW6mylhrwqezST+o8llsiAaExrqkGhwt1hDyfXt1ua7X74fp8GBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTMwIGF0IDEzOjE3ICswMzAwLCBJbHBvIErDpHJ2aW5lbiB3cm90ZToN
Cj4gT24gV2VkLCAyOSBBcHIgMjAyNiwgVGhvbWFzIEZhbGNvbiB3cm90ZToNCj4gDQo+ID4gRm9y
IHN5c3RlbXMgd2l0aCBhIEJJT1MgcmVsZWFzZSBkYXRlIHN0YXJ0aW5nIGluIDIwMjUsIGRlZmF1
bHQNCj4gPiBBU1BNIHBvbGljeSB0byBwb3dlcnN1cGVyc2F2ZSBpZiBzdXBwb3J0ZWQgaW4gdGhl
IEFDUEkgRkFEVC4NCj4gPiBQcm92aWRlIGEgZmxhZywgYXNwbV91c2VyX3BvbGljeSwgdHJhY2tp
bmcgd2hldGhlciBhIHVzZXIgaGFzDQo+ID4gcmVxdWVzdGVkIGEgc3BlY2lmaWMgcG93ZXIgc3Rh
dGUgdG8gZ2l2ZSB0aG9zZSBwcmVjZWRlbmNlLg0KPiA+IERvIG5vdCBlbmFibGUgYWxsIHN0YXRl
cyBpZiB1c2VyIGhhcyBjaG9zZW4gYSBzcGVjaWZpYyBwb2xpY3kNCj4gPiBvciBkaXNhYmxlZCBB
U1BNIHVzaW5nIHRoZSBwY2llX2FzcG0gbW9kdWxlIHBhcmFtZXRlci4NCj4gPiANCj4gPiBTdWdn
ZXN0ZWQtYnk6IERhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFRob21hcyBGYWxjb24gPHRob21hcy5mYWxjb25AaW50ZWwuY29tPg0K
PiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9wY2kvcGNpLWFjcGkuY8KgIHzCoCA0ICsrKy0NCj4gPiDC
oGRyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIHwgMTcgKysrKysrKysrKysrKysrKysNCj4gPiDCoGlu
Y2x1ZGUvbGludXgvcGNpLmjCoMKgwqDCoCB8wqAgMSArDQo+ID4gwqAzIGZpbGVzIGNoYW5nZWQs
IDIxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvcGNpLWFjcGkuYyBiL2RyaXZlcnMvcGNpL3BjaS1hY3BpLmMNCj4gPiBpbmRl
eCA0ZDBmMmNiNmM2OTUuLmQ4NDliYzZkMGMwYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bj
aS9wY2ktYWNwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvcGNpLWFjcGkuYw0KPiA+IEBAIC0x
NTIzLDcgKzE1MjMsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBhY3BpX3BjaV9pbml0KHZvaWQpDQo+
ID4gwqAJaWYgKGFjcGlfZ2JsX0ZBRFQuYm9vdF9mbGFncyAmIEFDUElfRkFEVF9OT19BU1BNKSB7
DQo+ID4gwqAJCXByX2luZm8oIkFDUEkgRkFEVCBkZWNsYXJlcyB0aGUgc3lzdGVtIGRvZXNuJ3QN
Cj4gPiBzdXBwb3J0IFBDSWUgQVNQTSwgc28gZGlzYWJsZSBpdFxuIik7DQo+ID4gwqAJCXBjaWVf
bm9fYXNwbSgpOw0KPiA+IC0JfQ0KPiA+ICsJfSBlbHNlDQo+ID4gKwkJLyogSWYgQVNQTSBpcyBz
dXBwb3J0ZWQsIGNvbmZpZ3VyZSB0aGUgZGVmYXVsdA0KPiA+IHBvbGljeSBoZXJlLiAqLw0KPiA+
ICsJCXBjaWVfYXNwbV9wb2xpY3lfY29uZmlnX2luaXQoKTsNCj4gDQo+IFBsZWFzZSBiYWxhbmNl
IGJyYWNlcyAoYW5kIHdpdGggY29tbWVudCB0aGlzIGlzIG11bHRpbGluZSBibG9jaw0KPiBhbnl3
YXkgDQo+IHNvIHlvdSBzaG91bGQgdXNlIGJyYWNlcyBldmVuIGJlY2F1c2Ugb2YgdGhhdCkuDQoN
ClRoYW5rcywgSSB3aWxsIGZpeCB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4g
wqANCj4gPiDCoAlpZiAoYWNwaV9wY2lfZGlzYWJsZWQpDQo+ID4gwqAJCXJldHVybiAwOw0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2llL2FzcG0uYyBiL2RyaXZlcnMvcGNpL3BjaWUv
YXNwbS5jDQo+ID4gaW5kZXggODRkNDlhYThhNWJhLi4xYzgxZTJmMmU1ODkgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvcGNpZS9hc3BtLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9wY2ll
L2FzcG0uYw0KPiA+IEBAIC0yNjcsNiArMjY3LDggQEAgc3RhdGljIGludCBhc3BtX3BvbGljeSA9
DQo+ID4gUE9MSUNZX1BPV0VSX1NVUEVSU0FWRTsNCj4gPiDCoCNlbHNlDQo+ID4gwqBzdGF0aWMg
aW50IGFzcG1fcG9saWN5Ow0KPiA+IMKgI2VuZGlmDQo+ID4gK3N0YXRpYyBpbnQgYXNwbV9kZWZh
dWx0X3BvbGljeSA9IFBPTElDWV9QT1dFUl9TVVBFUlNBVkU7DQo+ID4gK3N0YXRpYyBib29sIGFz
cG1fdXNlcl9wb2xpY3k7DQo+ID4gwqANCj4gPiDCoHN0YXRpYyBjb25zdCBjaGFyICpwb2xpY3lf
c3RyW10gPSB7DQo+ID4gwqAJW1BPTElDWV9ERUZBVUxUXSA9ICJkZWZhdWx0IiwNCj4gPiBAQCAt
MTYwOSw2ICsxNjExLDcgQEAgc3RhdGljIGludCBwY2llX2FzcG1fc2V0X3BvbGljeShjb25zdCBj
aGFyDQo+ID4gKnZhbCwNCj4gPiDCoAlkb3duX3JlYWQoJnBjaV9idXNfc2VtKTsNCj4gPiDCoAlt
dXRleF9sb2NrKCZhc3BtX2xvY2spOw0KPiA+IMKgCWFzcG1fcG9saWN5ID0gaTsNCj4gPiArCWFz
cG1fdXNlcl9wb2xpY3kgPSB0cnVlOw0KPiA+IMKgCWxpc3RfZm9yX2VhY2hfZW50cnkobGluaywg
JmxpbmtfbGlzdCwgc2libGluZykgew0KPiA+IMKgCQlwY2llX2NvbmZpZ19hc3BtX2xpbmsobGlu
aywNCj4gPiBwb2xpY3lfdG9fYXNwbV9zdGF0ZShsaW5rKSk7DQo+ID4gwqAJCXBjaWVfc2V0X2Ns
a3BtKGxpbmssIHBvbGljeV90b19jbGtwbV9zdGF0ZShsaW5rKSk7DQo+ID4gQEAgLTE4MTAsNiAr
MTgxMywyMCBAQCBzdGF0aWMgaW50IF9faW5pdCBwY2llX2FzcG1fZGlzYWJsZShjaGFyDQo+ID4g
KnN0cikNCj4gPiDCoA0KPiA+IMKgX19zZXR1cCgicGNpZV9hc3BtPSIsIHBjaWVfYXNwbV9kaXNh
YmxlKTsNCj4gPiDCoA0KPiA+ICsNCj4gPiArDQo+IA0KPiBFeHRyYSBlbXB0eSBsaW5lcy4NCg0K
T29wcywgSSB3aWxsIGZpeCBpbiB2Mi4NCg0KPiANCj4gPiArdm9pZCBfX2luaXQgcGNpZV9hc3Bt
X3BvbGljeV9jb25maWdfaW5pdCh2b2lkKQ0KPiA+ICt7DQo+ID4gKwkvKg0KPiA+ICsJICogU2V0
IEFTUE0gcG9saWN5IGhlcmUsIGVuYWJsaW5nIGFsbCBwb3dlci1zYXZpbmcgc3RhdGVzDQo+ID4g
KwkgKiB1bmxlc3MgQVNQTSBoYXMgYmVlbiBkaXNhYmxlZCBvciB0aGUgdXNlciBoYXMgYWxyZWFk
eQ0KPiA+ICsJICogcmVxdWVzdGVkIGEgcG9saWN5IG9yIHRoZSBzeXN0ZW1zIEJJT1MgcmVsZWFz
ZSBkYXRlDQo+ID4gKwkgKiBpcyBiZWZvcmUgdGhlIHllYXIgMjAyNS4gT3RoZXJ3aXNlIHVzZSBC
SU9TIGRlZmF1bHRzLg0KPiA+ICsJICovDQo+ID4gKwlpZiAoIWFzcG1fZGlzYWJsZWQgJiYgIWFz
cG1fdXNlcl9wb2xpY3kgJiYNCj4gPiBkbWlfZ2V0X2Jpb3NfeWVhcigpID49IDIwMjUpDQo+IA0K
PiBJcyBpdCBnb29kIHRvIGhhdmUgdGhpcyAyMDI1IGNoZWNrIGluIHR3byBwbGFjZXMgYXMgbGl0
ZXJhbHMsIHNob3VsZA0KPiB0aGVyZSANCj4gYmUgb25seSBvbmUgZnVuY3Rpb24gd2hpY2ggaXMg
Y2FsbGVkIGJ5IGJvdGggcGxhY2VzPw0KDQpPaywgbWlnaHQgYmUgYWJsZSB0byB1c2UgcGNpZV9h
c3BtX2xlZ2FjeV9jb25maWdfY2hlY2sgZnJvbSB0aGUNCnByZXZpb3VzIHBhdGNoIGhlcmUuIEkg
d2lsbCBmaXggaW4gdjIuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiA+ICsJCWFzcG1fcG9saWN5
ID0gYXNwbV9kZWZhdWx0X3BvbGljeTsNCj4gPiArfQ0KPiA+ICsNCj4gPiDCoHZvaWQgcGNpZV9u
b19hc3BtKHZvaWQpDQo+ID4gwqB7DQo+ID4gwqAJLyoNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgNCj4gPiBpbmRleCAyYzQ0NTQ1ODNj
MTEuLjM2ZmE1NTc5NzA5YyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5oDQo+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9wY2kuaA0KPiA+IEBAIC0xOTE1LDYgKzE5MTUsNyBAQCBp
bnQgcGNpX2Rpc2FibGVfbGlua19zdGF0ZV9sb2NrZWQoc3RydWN0DQo+ID4gcGNpX2RldiAqcGRl
diwgaW50IHN0YXRlKTsNCj4gPiDCoGludCBwY2lfZW5hYmxlX2xpbmtfc3RhdGUoc3RydWN0IHBj
aV9kZXYgKnBkZXYsIGludCBzdGF0ZSk7DQo+ID4gwqBpbnQgcGNpX2VuYWJsZV9saW5rX3N0YXRl
X2xvY2tlZChzdHJ1Y3QgcGNpX2RldiAqcGRldiwgaW50IHN0YXRlKTsNCj4gPiDCoHZvaWQgcGNp
ZV9ub19hc3BtKHZvaWQpOw0KPiA+ICt2b2lkIHBjaWVfYXNwbV9wb2xpY3lfY29uZmlnX2luaXQo
dm9pZCk7DQo+ID4gwqBib29sIHBjaWVfYXNwbV9zdXBwb3J0X2VuYWJsZWQodm9pZCk7DQo+ID4g
wqBib29sIHBjaWVfYXNwbV9lbmFibGVkKHN0cnVjdCBwY2lfZGV2ICpwZGV2KTsNCj4gPiDCoCNl
bHNlDQo+ID4gDQo+IA0KDQo=
