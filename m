Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA831F986;
	Fri, 27 Mar 2026 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774655145; cv=fail; b=rlQLTJnvYit/MkyuWCmy2B5cc06ld0GW7LCDhx824Sj5mR6NE4tbkeYlI0dlDNwrIBgCPD0cWNGf3WRcK9mxGjiq54wWm/r3EqXANA+7toOoNfAv3sN1zObqtyt9dQPNMUqlj1IPKjakqgr/Unx/5gtuqOsROcjcBKl/Wj8VSs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774655145; c=relaxed/simple;
	bh=0mW5XQwXJOVPJKzikOfiJ4htSq4wIZDVJD+m4D1OaMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GGuFiMtWIMdeqVWgx326HYKP2RzFSA2RHb0ej4aZnbjLSsyrzbIshRwKKGAPUneucpkodGFxfRNVCKqCR+jlEnDwaBILHvFHK+z93tQLSPIAOtAQ/Lhkl6C1y/HUVNdnMHY/qI6Vzm6rhXkleZpdk7lCEC+Ocvq5rKVLJ5hlWrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjwEOaqS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjwEOaqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774655144; x=1806191144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0mW5XQwXJOVPJKzikOfiJ4htSq4wIZDVJD+m4D1OaMQ=;
  b=XjwEOaqSHPa5tjLQeRxwt4vS0aF6xhJtDC1Zs+ShtzOLG7dOP2e23nt0
   HpzQMZu5P1OnBzjOIQvwKcwCe7ybIRqwv1nxVfHGDBUM/AIPscJIPEoV8
   RP4GMLhIzb53h8rhpr6LMQmQ2DqFOm7pIIOIa5uYA2hcb0hse60ViV/sE
   5nVcAWbQuRJV49pS/rAZb1QeWpbSjmJScFbqoP7T/reLnBlA365tPWsxb
   I7xJdJu+tIl3sMPrjnyw+8R97Y8TRRId57OZMNv1jbBnaE3g+ptDFdAKd
   s9F14XMCBt9ZjA1Nd3kUj0DxO+Sm2finG0zbHFBbtnOZ0PDlMX+vuEyst
   A==;
X-CSE-ConnectionGUID: ky/WqLt2SmW8uvDaW0EKTg==
X-CSE-MsgGUID: G5RZqj5MQk21Y2IV0OT29g==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="74917266"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="74917266"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 16:45:43 -0700
X-CSE-ConnectionGUID: HaBKeIc7QYOK4R37GYxh3A==
X-CSE-MsgGUID: DpjkJ8lmQjSg0XILar7XGw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 16:45:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 16:45:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 16:45:42 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 16:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvXBzSzZuYxjm4sHIpVcEGrcaFC7Dwc873fbs69+JfhWMWvE6kShh7rJxuCKpwfMnXpwq9RIpReQAg5hWJVQv2+/kNbdtSqRaCvYNoFS2Od7I92OAzpy6Yqs9AhEiFCxkDQJTifpq23dfbgzRBBrMAbLL2LeBSga0R2Jyeo8MQ6uMungJi6D1YF0OYC4zy1O6qjuiUSDBmhLn8KdyoXKV7DmyhonXhgIkJA4fOLHYuPDwhHof7273lWJk7fk0poDb/me+tZKE0c2zJZlXiuY8wCxYuokp4UiIh/10xdJSLBSId3O1Zclv6rs5GzWeEQ11WkuyEPIPpSUmq+z6n7sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mW5XQwXJOVPJKzikOfiJ4htSq4wIZDVJD+m4D1OaMQ=;
 b=Cv8mmgg52lTKcgxu0WIKJWTxFPsmCcpvc9gMd0ktV4luDdBMa5coYxhOHivcyWPrjfB6RnT/kTxrxlzhk/cS2bhwlOzM0O3c4KoPbOKhidCQdxKfKCrjIFWvmghB7a3LdVbmkIiN+Dl2Zxf6ph3wU5+l/0h4+l+JfkkGv4kGZoKuXRuyUNI54qPZBICfzOIkrcsEcgpACZGs85khjGB+gAAZtE03v3co7RCT8XP+f75j6UIjJRO/n/gLDni95MLPPk5GaR9/twkrRBhBmoNMk+tcGCJ2RuZ2dZ1PgCzwu/XC5suAUuo0DOho1nHTUGeQ5IxGgoI7tp6/40X6QNYzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by SA1PR11MB9876.namprd11.prod.outlook.com (2603:10b6:806:4d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 23:45:40 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c%4]) with mapi id 15.20.9769.011; Fri, 27 Mar 2026
 23:45:39 +0000
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
Subject: Re: [PATCH v2 02/31] x86/virt/tdx: Move bit definitions of
 TDX_FEATURES0 to public header
Thread-Topic: [PATCH v2 02/31] x86/virt/tdx: Move bit definitions of
 TDX_FEATURES0 to public header
Thread-Index: AQHcvgX0AX9nydunr0GVrgahtcVD37XDC5QA
Date: Fri, 27 Mar 2026 23:45:39 +0000
Message-ID: <4228c004ebd59f9737fb39c6c9815bf6e7711acc.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-3-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-3-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|SA1PR11MB9876:EE_
x-ms-office365-filtering-correlation-id: a1720bca-f3d7-41bd-c693-08de8c5af3a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: bbIl9y1QD95xSiltz/dlQdodWRXsxLvVjxuymZ1v16q6OGGg/YflrYS9HmIrjZs96Fy4bE3lPKko+St10SF/UMxTQTRqkHNWS4Bi+F1qDIgVXS63yVB0jl6SGetoi4f27pDRgxZZdBudCrRoG1jFiPfYX9cARqx7nMHX67PeDKi8cgOEzDYM7exzOzQXWw3W1kvXXkiYPWFkKFn7LsRDMIa5L8MqwSn0y2y3A9vi1KJ48YkGeo73XqYOsaN61X6l/3PlbCMCt0iew+vyGf4UAH+4QWEORwHP86LduDN5fJ60z49MNF3PIKHswRGGaiOjtwQuAsiYh2arpZByyM/Vz5DX4kbAV/BcnmpK2FNp5hzaWTjz1S9gzV+eU4IaniFb9bJVta/qpDb+4qL7hfZca+zS2dPveL8TTh2kMXBDd6FgUW4A+gYTp9VGFfi80twd1fbb6LOrc2Vh+kfk6h/6GFCo9Jm18kfTrtdjqh2pnyJILHCiApL1M204jv9ZCwV1d43fPxW2zmg4RKj0HvyH/UbvilegnWxF6mheUK26gASKSmBNsBrAhohsZbm2jT+6luVZJSZiZPCPXO15Sk+VF3Wv5bufaPy+KSRpiKHB0Cd5dMGryqO52VOF516qQIZ8AK28Z5RkEDc6SWBrdZCPyqzeP3eVKwGH/6G0akSY7La59Q/nQ2ubp8Rq22oq5lTSOG3xxlVTkwHnSFk3alTXq6rg6X+qj/ueO8ca3+iq/+HeTfaDCttitoZ8eWow8GZfQXZ9AqWLchlhdcqY25h6DME14H4MbMXbc/C6vRnS79Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXJhY2ZWWVZ4a2tkY2oya3hUTkF4b0sxWlI2QjR0cmxNZ2hIWTBqV21SOFFn?=
 =?utf-8?B?M0VvTlNMMlZZTFFpcm1NaFlLZ05rNnpQL01vSzNLY2djNlJVVUYwUWhUU1BE?=
 =?utf-8?B?bG5tL0t6MC8vWHo4aEozTFJ1RFdqL29STmdkNWRoWHJVTWtoNmpVdlJ1YU0y?=
 =?utf-8?B?ZTBXYTlreEMxVk1Ca3hnWWYrc3VkM2Y1djlnMURYbFhWRlZXU1ZXdzRtOGFN?=
 =?utf-8?B?T3VDbkUvaS9PTUVWM2EzMmNFQzBJaGVySW56M2tkSWZ0aUtVYWxvNVBpclVK?=
 =?utf-8?B?OFpVZk93ZlZLaWs3MTRTVlpCV2J2UjVEYTVyaEFuOURxZ0tCdExZREtDY2hH?=
 =?utf-8?B?eklkdm1ib0I3dEtDdUUxRnJXUEZCTzN6eUdTTk1MeW1tZ1pBQ1VPRWo5UnA5?=
 =?utf-8?B?Vi81aGFvMHlpbVRMM3c3MUwvRDhWeXFkblZNZlg4czBJL0NQa1lndmpnNUNu?=
 =?utf-8?B?cmIxN2twN2RaS1hlMkZhUlo0MUtVWENENmpkbkl2NklzTEpRU05EdEZNQ244?=
 =?utf-8?B?TzFPWDg4UEs4Ym0vVzY0akh1dTNjamNBeFZCa2RtQkpETVpPOFhxblJ2V25p?=
 =?utf-8?B?eXkrR1QvOTJqU1hpUDZ2VDFGOWczZmNpaE1mRU45QVNqeXB6d1JucTJyWU5N?=
 =?utf-8?B?TzRRSXkxUkZ3Z1JMa2FqTGEzTU9KNHdscmxEWm1Uem5zdmRaL1NUMnc2N0lp?=
 =?utf-8?B?amFzenRvRU5hYXRrcndjZTVNRFZUVmFkN0YyaUh4cVVac2xNdEM2NEp1bW1G?=
 =?utf-8?B?dUFUS05VMjdhd1VBQS9BNkFMYklPRERDV0F4ZVZyYndsN0lQcDh6MzlhMElW?=
 =?utf-8?B?YThVWldLbyt4T2VSUmRhMGFDTFBmV1Z0WStOK1ZkOEMyb1JrZ3hZb21oVmlo?=
 =?utf-8?B?QXJHaGY3VWZKaWo3aU5lbjc3eFhsTlhncCtoQzI0S1NSczI2SVJmcUthaytT?=
 =?utf-8?B?WTNFR2wrU0FvTFhER2Rnb2Y1RjlLVG5GZ3NvR2VlMnYzVmJUU05RdlFBVHMz?=
 =?utf-8?B?Y0JQR1BUV0xza2JCQXd3aUhhQmpRUTBHTDc5bStjM3ZOYklhaXZYMVU5N3R6?=
 =?utf-8?B?VmVxQ0hCL0ZNT3ZvN0JxUGFwaTJER0NIWXd0MTZITDBRREQvWmZnL0wzcXQ3?=
 =?utf-8?B?TDF1NzU1MnY4ZGJzQ2tXUU5ydW14V1NQZjVaYnYxUndkMmM0UlFnQmZDSzhl?=
 =?utf-8?B?TjJSRWNaaXoxSmVFQ1JXbXlQNWJyekFFNVAyWnd3WGVXLzBnclBXUUJnOXNu?=
 =?utf-8?B?YkRMZktmQW9nVmZLN1RJYnpTWHd2Y3BuM0hYOWNEbDdYVHNPaE5Bd0dYcjA4?=
 =?utf-8?B?bmVWZ01lbUs4WndtT09RbVUzbFUrMXlsQnpIWEU0dmJoVGdiaU5VRWpSQVdU?=
 =?utf-8?B?SUc4bGpJUlFQKyt6cVA5MU9WMjhIR1pRaGVxWFhMOTRiVnc5NXZoSVlvd3Nn?=
 =?utf-8?B?S1ltbjdIaEZ0RkUwSm1BS2taQ0xxN2tZSGg3NENYenYreUtLbjU2ai9ZM1N3?=
 =?utf-8?B?VEtCZm9YMjhXUkJhd2d4VnA4dnQ3MGxZSk56Rk5ZNkxPc3hpdG1YTkRYZHIr?=
 =?utf-8?B?SHJBMG5kay82UTZHaFluNFZpOUVOM0RQbTBPV01uQUxXNUJYS1BPWERxa2dD?=
 =?utf-8?B?OVRqWUJETVQ1citLUlRyeWQxZXRCSCtiYjBPbmRnbVBoaFVKeGJQNlROY1Zt?=
 =?utf-8?B?WS9KNi83eUpOZTBja2tzdVEveGsyemEyOWxOMGVBZUVSK1o2ZXdFSDhUaWpD?=
 =?utf-8?B?SHcyZVlRb2I4ZVo4SlJKbThiV0VnZ3pqQm1HaVB4U0k1dUx4VUpySEdHVWVZ?=
 =?utf-8?B?b0F4Q2Z5ODIwN0dmSkRZRDJ1NnlqQi9BVjVyVXhCbHdsNDA5SUVxRng5Mzli?=
 =?utf-8?B?S0JiVDZ2RXNwdXBIVm9VUzlYN0V2dDkwcjZpVVFZVTlPK3kxcDFJWk11aXYw?=
 =?utf-8?B?RHNrdUZGR1VQdU9DVzU5WVprZGF4cWpyK01lQndIN3ZBSE5nWk41R3RrSlgy?=
 =?utf-8?B?cHMwTEsrRGhyOTQwL1o5cy9TcVFnbmVDWUk2SFF2ZjV0SStIL0FTdXBmMGV4?=
 =?utf-8?B?ZU9LOTFBS1E4d3RPVUgvSFpvZ3ltRjcwdTBxZGptcERqWU5sK3pKVlRhazlG?=
 =?utf-8?B?SjQxVnNDS0pzQ3lNNk5sMTZzekV2Zm94UjVyem1HVlFRR2hSb3lnd1BqMEMy?=
 =?utf-8?B?NS9oV0VvN0hSZlJ0dVc2Smp0WkF5c05lVnkrSktZK0NaWmM1d3RNQ1Ewb21z?=
 =?utf-8?B?d0xobHUvbnczcko1c3dCdDl2NlZvRlNMcVdvOVBjVDZxUDZ0RUo2L3ZLSnRF?=
 =?utf-8?B?Nk9OazF6MjA3YmJDU2hQSS9ZRitVZUZKZmEwTVgxK0pVcW9JZGhTWThiTTFy?=
 =?utf-8?Q?SxGLSzqOn5ERK2QY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F04A00D424ACC438F594A15F5D73BA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WK8YzxYYiMMxTH77oyqIt6NdMlEkx+c+oeQiVzPxEsqueb4uH0r4U13ZWEYnA8pxvSJtDkukXImK0JKf3pTk8xXBGfJyWED5hJiq17seBTNE9WMEkUWR9l4UmrKlC9Ygsc9HAnZ/nalfiVNbEr3eKLrFxwjOXQoYEr/r3mzWDG9c0MGhmQF8StYNjkbY63QrWWh2Blca+ZL/UZDi4+yJs63ZMh2iUxyFaj9oFG+HXT1ZSrxUJWNZRurx1yEjfR1fEBjRF2vXUlJrqoE/uNSDd2mlq02pnFkpZ8RwlJoT2lnrevGV4OAXW0sLNFqlRV0bMIoFeFanHQ5Ulwt2cVsZZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1720bca-f3d7-41bd-c693-08de8c5af3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 23:45:39.5387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0hc9Q0QsItIEERm0l3MfwmCgyho4TbXjdRDhEP2WNdwWrzGObajaYR/2GpnqtNDZhWQ4/H2r983dS3pWyf18ytDRiYNMISlHtu1pNTB310=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9876
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTI4IGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gTW92
ZSBiaXQgZGVmaW5pdGlvbnMgb2YgVERYX0ZFQVRVUkVTMCB0byBURFggY29yZSBwdWJsaWMgaGVh
ZGVyLg0KDQpQYXRjaCBzZWVtcyByZWFzb25hYmxlLCBidXQgbm90IHN1cmUgYWJvdXQgdGhlICJw
dWJsaWMgaGVhZGVyIiBsYW5ndWFnZS4gTWF5YmUNCm1vcmUgd2lkZWx5IGFjY2Vzc2libHkgaGVh
ZGVyPyBPciBhIGJldHRlciBuYW1lPw0KDQo+IA0KPiBLZXJuZWwgdXNlcnMgZ2V0IFREWF9GRUFU
VVJFUzAgYml0bWFwIHZpYSB0ZHhfZ2V0X3N5c2luZm8oKS4gSXQgaXMNCj4gcmVhc29uYWJsZSB0
byBhbHNvIHB1YmxpYyB0aGUgZGVmaW5pdGlvbnMgb2YgZWFjaCBiaXQuIFREWCBDb25uZWN0IChh
DQo+IG5ldyBURFggZmVhdHVyZSB0byBlbmFibGUgVHJ1c3RlZCBJL08gdmlydHVhbGl6YXRpb24p
IHdpbGwgYWRkIG5ldyBiaXRzDQo+IGFuZCBjaGVjayB0aGVtIGluIHNlcGFyYXRlIGtlcm5lbCBt
b2R1bGVzLg0KPiANCj4gVGFrZSB0aGUgb3Bwb3J0dW5pdHkgdG8gY2hhbmdlIGl0cyB0eXBlIHRv
IEJJVF9VTEwgc2luY2UgVERYX0ZFQVRVUkVTMA0KPiBpcyBleHBsaWNpdGx5IGRlZmluZWQgYXMg
NjQtYml0IGluIGJvdGggVERYIE1vZHVsZSBTcGVjaWZpY2F0aW9uIGFuZA0KPiBURFggY29yZSBj
b2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4LmludGVs
LmNvbT4NCj4gLS0tDQoNCg==
