Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B1241C8C;
	Thu,  2 Apr 2026 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090433; cv=fail; b=lktQJwlz0eMa3DYq5Gk1fYTg7MhIi0JjbD32XuIWAojl66I7j6jqwJa3sPZgpjZa+5wpbrRvF7x6f4/1NRxbP/+GBDZrMm3pCtR5QJvfhL5YESo95yT8ra1w34lkLF4YycziWuZ6aWQItwfYyyQ+RsY36pFXItzloJuQaNslRhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090433; c=relaxed/simple;
	bh=fcPqeM7QbOS5yAuRWSr9Tu8c4soMbHTLgDeA3FSUtUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iOfG0fvD+cll660YkdaNG9lT87BgeNcmi2VYt+c6y7EUR3mxqe6OLhzWMd9GnEPiOy8i95xGnY+FR95oAsg4ts8P92RWw8kyCzvhgIrU0iAYx7Mgive0uSwWOz5WsfIWdYGhH+tdM20N/MF7s3op/ptH0Kr88KNrQV69N1hAaHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVnG3E4Y; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVnG3E4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775090431; x=1806626431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fcPqeM7QbOS5yAuRWSr9Tu8c4soMbHTLgDeA3FSUtUA=;
  b=LVnG3E4YC00bia1MKdRr0zL3mxkXwLcSuTCdak5tjNECFcLUtFYkztXa
   XilGLHauxmdYDomXaQu5QwRi49rCsvgMwey1CZ1OtLqkr32Fg1q9PxBXb
   8C006HOIdFlgizkcqD9sq5FLtQXi7QwYYjcbeulF4HWBMimy2Eoz1p7pV
   I2tCm0cZkpVyjSRwE8FVvNBIAfVL0KqLyQ8nBDP0DfPKRUmIx9D7mKrWs
   d7AsQ5hV7OEpzjC5rkqljPHZcIAE35DFm05p87RBWQA/Hg05vLhC7DVeq
   vijqLtDTE+hYJERoktHVMq9PYXZgUzJzeIlsORtji8SFb/fSj77WGHqAJ
   A==;
X-CSE-ConnectionGUID: vb0wZq7QSM26osjdi+cZCA==
X-CSE-MsgGUID: LAWY8E2zRz+qiqwtW2CeVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76035467"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76035467"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:40:30 -0700
X-CSE-ConnectionGUID: OLw25PuxRa6q2vuclk831w==
X-CSE-MsgGUID: s2HbnyaGSMe5M5eSg/65JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="264765275"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:40:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:40:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 17:40:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtZkHKWqmQno3jenphAsI+oYawk4mHukS/qoImDX1yrlPreBTcx+CPSs9qR0SPJ0oZq6UUoVftCChYdw5q6S359KqQeJ2pPmsHNI+1lV6HsmtPXcMjk+0iplfslgw7xjYT5ljQvwr++gCZFt3CH4xzfVL7gyEycIbzrLEgir50jxDCdB9q4mqiyEAzsiFKMtzZs8i+bMx2tOXkndAf/s411qOOb4Lrmjrzp6JQ6dJ6zYDwo2kbfAsCc+EBdYkavvj/kaYvfiAWSnunbPAOFOb51hEgeBGD2h1XXDKP89bclmmJcMmT0ZPobape6RA6HhT7G6t8M11PTInE0OvTCo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcPqeM7QbOS5yAuRWSr9Tu8c4soMbHTLgDeA3FSUtUA=;
 b=j0qbEUXbSJ2sGzrqTxJwY53sTcFIEVuycn7CXyjbAZdppJIIeWSXl0HKNqvKQhLeVk91lVHILjtVWqKYAHimY0+7RJ9jSWvC1u5TL7UYdgQuZ9XOzz6h17jXsyl5ibll85GyYquq78iizB3uehzIxA+5AhzVGhQd2UrmiKQSUcI3t/GtYWL++4uqZeqYCgHZRjiuNAayHOxHLG917hOpdZMMD62NdRIn47do23fo0rc48q/T+RoPST+wgI1u4554hrxyqZnzJRWATfsBCBwmPT3F4mopjEpXBecDcIDkI9mYRBiLF/p9NL61UWbOxLu5+8/2DkGlx0qvh+nrk7ur9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 LV2PR11MB9538.namprd11.prod.outlook.com (2603:10b6:408:378::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 00:40:27 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Thu, 2 Apr 2026
 00:40:27 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with optional
 TDX Connect feature
Thread-Topic: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with
 optional TDX Connect feature
Thread-Index: AQHcvgciEO9ja9+YTEeNEsKQg5wh6rXK5moAgAAC+ICAAA0lAA==
Date: Thu, 2 Apr 2026 00:40:27 +0000
Message-ID: <847eb26878cb06afb47f4ecdb0bfe8ab7e432e8a.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
		 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
		 <6a28710b65d1a291213d28a8297477bf0287df7d.camel@intel.com>
	 <8c4dfadaf73ed175a959ab16335a8d90266453b5.camel@intel.com>
In-Reply-To: <8c4dfadaf73ed175a959ab16335a8d90266453b5.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|LV2PR11MB9538:EE_
x-ms-office365-filtering-correlation-id: adb22b90-9387-4bb8-239d-08de90506f3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: s7eISYVb+RzhfvoAM3zWioC1SD/W/yf5lQO/+fFG7qyx0p+paP8KcsopsD1sAAmVrUDwlFhWEy1wkEzVSWjrexfNadm/Eg1j7dlbfvMPWJaisEReJJbJD4jBRutMdS73vSncjkYTMMF8gQwQxBNI7++NLmtrl+7mMh8qWsfpIrdfYR/PotLfwFzBcbMe8p0b/rbMUWQTgKX1P/AeTTQZ9q+W67gSomNvJ1kIVgbWOT1Rj5H1nZz/Y86nXJanuA1W4mpNNw4bbRuCE/6lAAGpWmh79s/WXz5UnnvYV2cBRgsGfnAkm0BT7027rO/wp3PqiaI/UVRAk5hrgWtVF/JGPe9oaDnWiMihDivsY0BjVLAa0CYKLKvS/2nDEKfukAx0Fm9k0Tz8q3oahft/ldkfoEL98HsT5ja+JpSa8QEy2Yy7nmkEaYVJ0vfhUY+/9OTpnDoJ6rZgd0FpoeF7Xdkefd7aCp05mzi4kAVGlHVw+Yp4V2KP8AkuXlQEqdzy/0SlR3XFmNfeFzB/5WPJJQH36h5bG7kvzFb+2LbNZUYZDkAUDmymTdXKiWSIU7GjBSA4bBkP41MgR+pwoFRxFQrW9rLjr76BYp8Hqv9r5tOhWSNkDmsxsHekgeEeo8c0cxjjgD0VjSJeWpa05FBQ0lWWD/SaO0cJ2hdAm4sdhm4x62tOL96085q+wq+tfrl7ZPZPjHPh4YVZAMjvBgMS1QAH6RiNaqqMckuMCPuLMwoWiCTWtNoNRplpqV+dpfM+jSfLtYRMaCIhp9InceawasT+1SL+wN+GRKr7x+R6is9cheE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHduMDMxZ0pkN1dZSTZPaXAyNkEwN0w3c1pCUndEMXROazZOcllHQ0psUFJX?=
 =?utf-8?B?WlIvMTd3cWxuYjBucGd6VVNRYkgvR28xYVMrT3lvMUlwYTJjRGNDU3lsRWk5?=
 =?utf-8?B?RXBCcXpHb3BtOWJHQmpOSStJUmJ6bVppSk5RcmZiRWNhNG1hODY1cm92MTIz?=
 =?utf-8?B?dEttUDNHM0VQdEZZUU1tSXJiUXVDS0FYdGtPUDFGczBtakd5M0JMcnk5ZlBN?=
 =?utf-8?B?bjZaR2pjZUIwT1IyRjljemNzanBKTEx1THBqc2ZET1VPczlON1lFRjJoWGRP?=
 =?utf-8?B?b2N6NEdTUGRHR1hEY2RSV2cyZzcweElmKzQ5WFRzV0VpN0pxMHlGbEZ1YzFS?=
 =?utf-8?B?TmFLb0QwSWFETHVFQitFdzBwUHdhWEwwMW9sTXpsaXFtSmN6K0pRMFJEek5Z?=
 =?utf-8?B?akFkcExlWXBaU2dSREdMbWZvZXU5eUIwV2RTTmJySWtSczk4ek52dlVZNyt0?=
 =?utf-8?B?RThkSjQrY1VyQ2lWUWF1SE5uZ2NLVlF5MjZXRy9NK3JLVE1ZT1B4QllRZE5Q?=
 =?utf-8?B?K1pzYTcrUWk2cG9yUUtNRzBjVEhzK0ZrTUpJaWRWNGw5OUFDbzY1VjExMk4y?=
 =?utf-8?B?Y2pseXhpUXBLSzN4Nk5ER0JkanZ0dVlZZlpiWWFDVDFkWWNOc2daZSt5eFZO?=
 =?utf-8?B?d2JtTy9kUnl2Q3BkTDlVdlVERU54VjNqcnErKzRYUUVsbEpMMEdvNWJ0OHkr?=
 =?utf-8?B?cVZpWVlKSXBqRTJwSEpqN2xmKytLcFdHQ1ZGUlY4TVN5U0w0UUFESDMwMXFC?=
 =?utf-8?B?eWZOQzk3ZFVxNm8yUGc1Qm9Ta3RHWkRXbFhnbmxlQksxcWZlQVlUWk9qMXpX?=
 =?utf-8?B?cU5nQmpiZnNIajdoUENsN3kydnpWbDRVTld2WHc3ZlJmRVdvV2FqbVRXRnZ5?=
 =?utf-8?B?dDZvaG10VzFjSXB6RHA2VGVqY2xhRmZIOGhTOHlyN2tYbXpvN3NTQmFtTk1R?=
 =?utf-8?B?MHFYQjUzSW50eVEvY3BSbDRWaldYOE43QnZobWNxVDdRZ0c3eDVGZmQxTStE?=
 =?utf-8?B?UnJKQmNrRHhOd0tKMlhQdU9JMm9sc2daZ2NtaWNwNGZjaVFRYWprRi9sK2F4?=
 =?utf-8?B?QUxpVFF1TDVWTlpYdWJYcG9ZakdQbjdIbGNHeHcyYzZjVFJrRmNCd1hVUnJI?=
 =?utf-8?B?N3p6YzQvUGVUWUQ0SjFHSk5HV0Q2dnJCWHJvblpsY3lCalVHZG8wNkVkRS9k?=
 =?utf-8?B?WC9aYnQ2ZDFsLzZHY3QxVElYZ3FuNXo2cHpkbUdqVUhGc1o4bllFSlg5YXF3?=
 =?utf-8?B?TzBJYTRPRWlVeGkralJlTUZsd1ZMYU1YYU9vcTRLaEprR0hxY2JuWTJhbFkw?=
 =?utf-8?B?Z1M5QkFWTkRsdFMwMnIxcFNRRitIZWJKNXQzeUNkT0NRNUcrQUpJTS9seFhr?=
 =?utf-8?B?NlhNbkdmSXpjNUw1V3dPSkVqcGhGMy9xVXdrbmZhRXFSLzV4NFlXREtoZU4r?=
 =?utf-8?B?TTVPOHB1WHZnZmRRd0FhZm5LNmdOQ1lyZUdZWnJNVGlJZGZDTzhrVEYvSzhY?=
 =?utf-8?B?V1gwL3RwV1lmaDQxa3lXeUpNNktiVUZzbUh1WnpvaFNtK0Y1bmx1aEhHZUE2?=
 =?utf-8?B?SWdDSU9GVHNGbFNidmFydUpRVnY2bTBuMjB5am1NL3dqMTRIOEgrZ0N0R3Nu?=
 =?utf-8?B?UXE3LzdiMURvQ0lrblZWM2hFYzZEajQ4K0RySVNSSHY0UVpEb0ZvUFBsbTBJ?=
 =?utf-8?B?QjJBWnJ5elRFZ1U3MnRVZVd2MW5EQmpnaENoejlxdkVhWmpYaFNQTHk0a3F6?=
 =?utf-8?B?azh3dzBRVGN6V3cvRThrSHdLdWlVOFJGcEI5M2s1UzZUS0M2Q3dqY3lCeEgw?=
 =?utf-8?B?ZFoxUDZOZnRaNnp6OHB5SS9ETVE4OExJaEZPUGxwbmd4TFI2M1pqaWpOVlBr?=
 =?utf-8?B?WDNIcXJpWUJrYVNoamNQNjVhUk43bjFldStlaUEyOVo0THBnUmx0cXNZWHQx?=
 =?utf-8?B?SnNDZ2lOUFJXVHhKV1FscGJiMmRhOGpSdmRkZW9NWWwwaG5GYThYdU95cXFJ?=
 =?utf-8?B?VnBiRWFZbGxnRURaMnRDajdmTHh5dThDZ0hPOEJzT2FnMzRGQWxZakVMeGdn?=
 =?utf-8?B?M09Kc3VOYytaL0hULzFPNXJUWnJmQ0JLcDZTY3NHK0RqNThXaHZkNzBOeUJy?=
 =?utf-8?B?MkJhbnAvMHZqa1ZnSzlYQUNSQTJNYVZRZ09rdkxrcFRwTUora2JXdm1HZHox?=
 =?utf-8?B?dlRnUDh2eUM1VG5ocjBsTlNkOVRBSjl0YVhqNFl1Mk1nYXZ3NlVoVjdzdDEz?=
 =?utf-8?B?NHZOY3RIZEtPMjFCaU94OVJMMmMyL1hCcWJjK1ZRTmd4YWd0cjdTbThOaDBW?=
 =?utf-8?B?czNoYmp2TjU3UUR0aTJEZ1kzU25yU0QvZ2ErelFLOS9VL2ZYUzlYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <134740D48C43EC4B9548D02B6E864903@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MoypVkg7NML17OW64MqQkRmOkIMdPxtiXN+NXiU8OH5PRWfdSaE7SbE5d9yE/iqIxjmeVUhmfxIiILAs7i9/NHWCZ5xwIpvuc2xsxbDz0+edOAUMi+wxLTXfstlXFROgpBmzhypoJAap1slh0MADKRpQ5VHlKfbcJm8QE51ufOo/AE2kfzIDpauTLHy+BuZYhk5k/mygNZK6a0fSbFg/gYa5tmRMNuR1+nsND/NMBZn3suVSrV2z9bbfzkeH2W84sTxPjeWyrG6fyj5L2IrPzGmhyKQm2TTchUazjrTH+NWhLaFSBz9FX3RMg64RdFlxwFroObvRGMAlDdAy64DBEQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb22b90-9387-4bb8-239d-08de90506f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 00:40:27.0707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBJ2lduCHqH9cpKgMUPU70rJh8OM306kaLSfJPydE+yGVdWQ8YOdVYbsScNupwYIXoo/CN/sWz2/TY87Fhxamw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9538
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDIzOjUzICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gV2VkLCAyMDI2LTA0LTAxIGF0IDIzOjQyICswMDAwLCBIdWFuZywgS2FpIHdyb3Rl
Og0KPiA+IE1heWJlIGEgbW9yZSBnZW5lcmljIGNvbW1lbnQ6DQo+ID4gDQo+ID4gSSBkb24ndCBx
dWl0ZSBsaWtlIGhhcmQtY29kaW5nIG9wdC1pbiBURFhfRkVBVFVSRVMwX1REWENPTk5FQ1QgaW5z
aWRlDQo+ID4gY29uZmlnX3RkeF9tb2R1bGUoKSwgZXNwZWNpYWxseSBjdXJyZW50bHkgd2UganVz
dCB1bmNvbmRpdGlvbmFsbHkgb3B0IGl0IGluDQo+ID4gaWYgdGhlIG1vZHVsZSBzdXBwb3J0IHRo
aXMgZmVhdHVyZS4NCj4gPiANCj4gPiBJbml0aWFsaXppbmcgVERYIENvbm5lY3QgKGFuZCBvdGhl
ciBmZWF0dXJlcyB2aWEgVERYIE1vZHVsZSBFeHRlbnNpb25zKQ0KPiA+IGNvbnN1bWVzIG1vcmUg
bWVtb3J5LsKgIEl0IHdvdWxkIGJlIGJldHRlciBpZiB3ZSBjYW4gY2hvb3NlIHRvIG9wdC1pbiB3
aGVuDQo+ID4gdGhlIGtlcm5lbCBoYXMgZW5hYmxlZCBURFggQ29ubmVjdCAob3IgYW55IG90aGVy
IGZlYXR1cmUgdmlhIFREWCBtb2R1bGUNCj4gPiBFeHRlbnNpb25zKSBpbiB0aGUgS2NvbmZpZy4N
Cj4gDQo+IEJldHRlciBob3c/IFREWCB1c2VzIGEgbG90IG9mIG1lbW9yeS4gVGhlcmUgYXJlIG1h
bnkgcG9zc2libGUgb3B0aW1pemF0aW9ucyB0bw0KPiByZWR1Y2UgdGhpcy4gV2h5IGZvY3VzIG9u
IHRoaXMgb25lPyBEbyB3ZSB0aGluayBhbnkgVERYIHVzZXJzIHdvdWxkIGFjdHVhbGx5DQo+IHJl
Y29uZmlndXJlIHRoZXJlIGtlcm5lbCBmb3IgdGhpcyByZWFzb24/DQo+IA0KPiBJIG1lYW4sIEkg
ZG9uJ3QgYWN0dWFsbHkga25vdyBob3cgbXVjaCBtZW1vcnkgdGhpcyBpcywgYnV0IHRvIG1lIHRo
ZSByZWFzb25pbmcNCj4gZG9lc24ndCBzZWVtIGluIGJhbGFuY2Ugd2l0aCB0aGUgd2lkZXIgVERY
IHNpdHVhdGlvbi4NCg0KSW4gYW5vdGhlciBwYXRjaCwgWWlsdW4gc2FpZDoNCg0KICBGb3Igbm93
LCBURFggTW9kdWxlIEV4dGVuc2lvbnMgY29uc3VtZSByZWxhdGl2ZWx5IGxhcmdlIGFtb3VudCBv
Zg0KICBtZW1vcnkgKH41ME1CKS4NCg0KRGlzdHJvcyB0ZW5kIHRvIGVuYWJsZSBhbGwgSSBhc3N1
bWUuICBJIGd1ZXNzIHRoZSBDU1BzIHRlbmQgdG8gZW5hYmxlIGFsbCBhcw0Kd2VsbCwgYnV0IEkg
YW0gbm90IHN1cmUgd2hldGhlciBDU1BzIGNhbiBhbHNvIGNob29zZSB0byBvbmx5IGVuYWJsZSBi
YXNpYw0KVERYIHcvbyBvdGhlciBmZWF0dXJlcyBsaWtlIHJ1bnRpbWUgdXBkYXRlLCBURFggQ29u
bmVjdCBldGMsIGRlcGVuZGluZyBvbg0KaG93IHRoZXkgd2FudCB0byAic2VsbCIgVERYIFZNcy4N
Cg0KRS5nLiwgSSBhc3N1bWUgYSBURCB3aXRob3V0IEdQVSBwYXNzdGhyb3VnaCBjb3VsZCBiZSBj
aGVhcGVyIHRoZSBvbmUgd2hpY2gNCmhhcywgcmlnaHQ/ICBDYW4gdGhlIENTUHMgaG9zdCBzdWNo
IFREcyBvbiBkZWRpY2F0ZWQgbWFjaGluZSBwb29scz8gIENhbg0KdGhleSBjaG9vc2UgdG8gZGlz
YWJsZSBURFggQ29ubmVjdCBvbiB0aGVzZSBtYWNoaW5lcz8NCg0KVGhleSBtaWdodCBub3QgY2Fy
ZSBhYm91dCBsb3NpbmcgfjUwTSBtZW1vcnksIHRob3VnaCwgYnV0IHRoYXQncyBhIGRpZmZlcmVu
dA0Kc3RvcnksIGFuZCBpdCBjb3VsZCBiZSBtb3JlIGluIHRoZSBmdXR1cmUuDQoNCk15IHRoaW5r
aW5nIGlzLCB0aGlzIHNlcmllcyBhY3R1YWxseSBpbnRyb2R1Y2VkIGEgbmV3ICJURFhfQ09OTk5F
Q1QiDQpLY29uZmlnLCBzbyB3aHkgbm90IG9ubHkgY29uc3VtZSB0aGUgbWVtb3J5IHdoZW4gaXQn
cyBvbj8NCg0KQXQgbGFzdCwganVzdCBteSAyY2VudHMsIEkga2luZGEgb3ZlcmFsbCBkb24ndCBh
Z3JlZSB3ZSBhbHdheXMgYXNzdW1lDQoiZXZlcnl0aGluZyB3aWxsIGJlIG9uIiBidXQgbmVnbGVj
dCBhdm9pZGluZyB1bm5lY2Vzc2FyeSBjb2RlL2Nvc3QgdGhhdCBpcw0Kbm90IHJlYWNoYWJsZSB3
aGVuIHNvbWUgb3B0aW9uIGlzIG9mZi4gIFRoYXQgd291bGQgZGVmZWF0IHRoZSBwdXJwb3NlIG9m
DQpoYXZpbmcgS2NvbmZpZyBvcHRpb24uDQo=
