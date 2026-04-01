Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA754774;
	Wed,  1 Apr 2026 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775002671; cv=fail; b=j2NmCZg8lXPQ8mB6vF4TFRiXtypHBCnOgFglLLB+yTQL+dmGitJ9BwaqWVI5IU2JJVGCHH3DV/8uOLuJTSq4jQsHSrlMX7yX1KSzLGJi7UbYtqYouam518f2HrNpNAoiVuuVmWvLbNXE0SBFTmHS1I4L8FLkoZsYzMv52jYRaQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775002671; c=relaxed/simple;
	bh=3VJky9KgMW5/GpSOcKqkXs2f7fCnaGB4nITsuioVfRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lcn4OwA6YkN5tJ0LY/q/xGS+DHN8j+fOmdLcUvizQ4+YgFYYHh1XQgmLo3vZbzjUP8KMOQf4GV4DeVV34CjTg2cV3e63Xi90EJoaKK77WgL8LYOGR6nYCgddk4rpXYtpWwe/WA5rQhiSfhRxYwLMocKBDGEZs/5R7RGMqdkczIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVuguQWi; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVuguQWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775002670; x=1806538670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3VJky9KgMW5/GpSOcKqkXs2f7fCnaGB4nITsuioVfRQ=;
  b=fVuguQWiyQ3u58qGyUkV7YZHh9JhsD2EhgyJ/PpFv3rZPLbW4X+cYTm2
   si/WMAgEQzX4tAFEhxPC+KxyMc7ZxmmDIs7Muilw6/fBy7olo7bkz2DoY
   7bMMJu/XfC/8BtXiLm7VU9xv8LpJuoY9yzHsKmCiX8++Exvf6ervyPsCq
   nmMEvMUMeWF2DVqvjZ6/gwT70JOCpKd5pD1pH1xE/2WOYkK3fwDAYCENq
   FDZwShmIRXifSsxZFPF5jag1zvQZrLDs4/oxArfARR6zQQsMwdEhcC1pi
   0ZOhfp3gBpUiENJDFnDA0Pb+Ieby0a7x/qj58mp/AcMiOsJnit3xVVf5p
   w==;
X-CSE-ConnectionGUID: Hs38qU6fTiqTt9024XeqlA==
X-CSE-MsgGUID: e7ToBsniQeebyoSzxafdyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87492228"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87492228"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:17:50 -0700
X-CSE-ConnectionGUID: vr/nhmzWSqShxHkhsPZQDg==
X-CSE-MsgGUID: t8jWM1KKRZ+YFXS54o3Ecw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="226763018"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:17:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:17:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 17:17:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:17:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYBN/4J3M/52xKYmaWHQfDvyzz7vBCWGh+dXUhJO+w10HxdnfonyHiWW3UpbqBJBDzVXml4zimP/wFVda0uD9Y2G5yV9iyhp0az7z0b6uEKI6pGQtoOqVvyJ+YNPUGfTBXCcqwevqjSbpcq4phUcv69vGsiPK6D7cu0JRXgebZNxZutq9KP9VTwJtFrW/pNWmTLcW4ZjPz2OMPZ5be3Oc/y4KK42rMNCs2GSihVqjBFXvZiceM0XNDkanWosxIHu9umNJxIjDLI5PJdCY7z7+WomRjKCV81ClaT31zda9PJD2vzjhXW9/MkHPbOAUO61eypLQzFVguU/MjJKZvpXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VJky9KgMW5/GpSOcKqkXs2f7fCnaGB4nITsuioVfRQ=;
 b=Zn4jUD1YvrovOXGLJl6Kcp71wZgSYiAXlyNp0bkuikcZRIocb5kMlt4hHWD4WfXjlC9V4QlrR0uHXd+NgAdjifgvvitxp1STXJ1wBgD57zIa8nFHKEjwnN+pyuZufxf/ajWl6NCWtoLEjRCJfV++VHNQvN5B6JrWxuyq87Y985aGND1/MaN/FApbrHHjKJ/qGEvZcMqu5djgxC4g7G7R/C0h0Qrg6ArQbvn9cZBfAlBoiwcBj4eOzXSX/hIBXZyMWfjBXvWpR5r745xtrj3FwKgBFUWqktw3JK1+zUfMVRvXiqy4izYScUbw5gWEMFzsVXs8PmhN/N/3J348avTo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB8327.namprd11.prod.outlook.com (2603:10b6:806:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 00:17:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 00:17:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Thread-Topic: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Thread-Index: AQHcvgX8NqWq/xJEwkC3To7bkkY7WbXHxRYAgADxhICAAKdFAA==
Date: Wed, 1 Apr 2026 00:17:45 +0000
Message-ID: <f38d0a080aee052937cb6721683d55155c657717.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
	 <828f174d49a1ecaec65ba1179e08c6b22e249297.camel@intel.com>
	 <acvX1x5nDdGtZWyI@yilunxu-OptiPlex-7050>
In-Reply-To: <acvX1x5nDdGtZWyI@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB8327:EE_
x-ms-office365-filtering-correlation-id: 314e8e3f-d913-4c16-5f1e-08de8f841967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 9ZkB119+dttolT7IfZl2iRQq5F2zpVB4tzoB9eiGxrKS6tqiTx/QZrEmfmZPVuQPB0g0erm7TSwSwEdSFqU4if9ksgwq7cT/FnrC52bwPlwfU0Vb2SutMVBmESSQs09fVvO8qnk/o/yCxkD1lrb+jttRh4o/Qts8l2xnd30wmxOcgG5sekExkdZARMTaRSTHdUQGBcj14J5CkEwdjPhVhksEQ+11jnanJC6ae13L8XoAgEZ/ay5vpYVjWame9AqisGqmrKli7C8FIenWOsZcBhqUIUDbWJtLjUUvrwfYK0mGMuELkMpyKQj5lXjQeQcx4PL1N5jnLEODuDD/AuKJQCUy802Z8U49SwjrJR5TJuCWsbhvRN3iu5bE91Sj2dciBvoLp8sQKeFD7KcjrZxAqd2+wI7HKHDkte3f60dRsRI1XDqBt/3ORom7Hah0oxaZ+w4wsNoyl+mUwUczmi3oS28pPsb1uaUuVfApPJGXM8k2X0yH+Jz9JXo/X1fW1UDH6f1qgPUokA2/QaO3JX/NKSqtehbOHH5n9JRVie/je9G9lgqrPCBivpOC/boTktkIdTCDAgD3O5GuSL2+cADEdh29pTcM7sQhACmf5DQAG8bgKnrBIY8pwJHeN4KmoTn493l80kCnpsCUkSilX+Os9nPWBe1SxEkoTDWjCvglxECbHKIhaOEn2CfQYYZtVEXIwlh4+y4HIKGrYJqFR8swtNWG3PPU7wZwlVcGi7aPrxM4mdnA4gIT3uYvSWjkDTIpV9AaEKt2nV+xK5jsSxCGQGeX8rMQeeYHda24car4Tes=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlZ2aWZnekJSMU5OdlFmRCtBKzRuVWNadi9hblhIZ0R2eXZKOVo3VEg1VkVP?=
 =?utf-8?B?djF4UUwyVWtPS2UyUTlIT29FcmZHcXNpZW04MDhEa2VJV1RoVGMydUIwMnpz?=
 =?utf-8?B?eElVUVVpejNValVGMW5FTGpkQTlaYVFpaFNHY2xnSVBrdE8vcGs3RzBrQTdD?=
 =?utf-8?B?MDNDRklqdEljeXFITC94RC9tTGRvT1J2QkNUVFFlNFp6MkVRVzJ5cmpxYno3?=
 =?utf-8?B?S3BWcm5iSWlMRWFVeWNwTlUyZzhPZUZNS2crYWRpVnVGWWNuY084RXBXQjlB?=
 =?utf-8?B?OXB4WTB5eTNwL1VRMHluYS9xU3oxTjBTTXVMeXZreWYrOUpPc3BrRkNaaXpz?=
 =?utf-8?B?VjFQL00yNTIyOC9YcTlnaTJIZTF2YXduU0RmeWV6OVd5WkErTzhrendHSFJ6?=
 =?utf-8?B?cnArQThYWGpoV3hqV080eEh3ZEMzQ0lMb0JCbWJtQzhvckxUWVlRcHlHN21U?=
 =?utf-8?B?dXgxVGEwOHdadnV6aG0rdExoZGkxZzRKOEN0NENnQ0VMc1JkTTJvb0REdjhG?=
 =?utf-8?B?bHpTY2Q3MTMzeGFVNlNyRjBEOUZXZ2pFWHR6MGUvVG9vWGtnRU5YU1dnZjZh?=
 =?utf-8?B?dDNCQjZVMTlKeHY5TEFxQlR1MFVXVEF3R0x3cTNjSFNBWlRrSitrWFVqT0hY?=
 =?utf-8?B?SkhNdzU0dDZMOFZVeDgwYjFQRVVaNmxJMWFXODNLdDkvdVBLNU1hYjdmV3VW?=
 =?utf-8?B?cFd1c2Rrb0FrYlMxZG51c0FTS0hwVzJQM2lTRWx5SUdYOHloSjM4TytFb0w0?=
 =?utf-8?B?aHZDZ0hjUm84T1FMSG9JU1p3NU5DM3l1UVJmVjFZMXNlWGtOWXpaOGVLblRi?=
 =?utf-8?B?L0dzNjNuTmh0a0NrL2ozTjIyM3ZyWlZHcHlrVkZxbjViQmJLUTgrc2RyZTdW?=
 =?utf-8?B?cDl0aFdFQkJKTU9QS1dkeWR2K0ZmZEMza3BYTjFaME1sUDN1UVA3dnRxOUVp?=
 =?utf-8?B?UDRodHNTS1cyQzIzeHdWaW9QVmN0WWpacDVIM1l2ZjNnMlFtV0FpZy82czJB?=
 =?utf-8?B?cVF0TmZCanhUUnFzb2F3UVpPM3l6cjdpYzU3eVlIM0wvelhNYUdXYWt5STdQ?=
 =?utf-8?B?QkFQeGdBSXV0SkhqS0pZMDV2bFdZZHZZM3g1aGVydE4zZGhUcjM0WjRZckdE?=
 =?utf-8?B?V21BaE5xNzdJZUZNcnJOak50aG5PYnFQOVBudElzbmVONlM0UVNzZm11Unpx?=
 =?utf-8?B?RlBlWW5HeU9saFY2a1hsYmJwUUJod2tkRitYSlVFSnA5U0xxL0h5TXg2ejFQ?=
 =?utf-8?B?OWJKaG92T29ZNkxZQmhIVzNxeit3bWVMdHVJWm16NTVWem1iVmtjUzN0a0dj?=
 =?utf-8?B?UWlpZDhXSzc1Q2N3eXdIOFlwaVVaZDB5YkNkQjhNdnJ0N3djR3dsTjc1Rnlq?=
 =?utf-8?B?cXdaOXZLd0t5Rkl3bmhGbytBd0hiTWg2Vjl3UjBSMGR2R085MUgwS2dnbVpw?=
 =?utf-8?B?U0tCMG81a0NaVlo5R2NkdGZRUGxvNGM4Wk5IWDhBOHFZRkZJb0MrdGVBcTNS?=
 =?utf-8?B?U3hMTFFFRjduSUxaQ1k2aFRRa1d5aS9qOVVweERPK2FINndZWGVBYlM2SXVl?=
 =?utf-8?B?ZmR3eG1KWStTdnRJMGNyZnhmRktJL1NIN2tJVE9VazZjM0l4Rm1SSmdxdmhN?=
 =?utf-8?B?WkJVYzI5WCsrbGNXcHpVS01rR1locjgrMUw4b2VRNHd5aHZwVzVINE1uT2xx?=
 =?utf-8?B?clF3UU10YXJwWVR6WVQ0T1VSV0JISzN0cDZwdUVsTVZXcHM3RnY0bUNjYWxG?=
 =?utf-8?B?eCs5VG85M2hXYzgyZ1M1TFZtdHBQcXRIRExQZ1E2NkNhZkdzbDhlOFh5YmdE?=
 =?utf-8?B?Y1lhL1hMck5ndG41S29FOWpHTkx0NEdlNERTS25kOHNIY0xSU1c4SEdyL3Fu?=
 =?utf-8?B?VWgvTUZwYzc3c1VoSlI1YWJVNFQ0MTk4MFJjVFhvdFRmd3VZMHdoZGNBaWRi?=
 =?utf-8?B?QmFaK2xNY0xQNnIvZUtCNCtkaDIydktQRFhRaGpVaWZIZXhSemtIeW5HUEVY?=
 =?utf-8?B?M2tpYlc5UFp6RUlHNEMwVm1qRDZxM2c0SnlBckxPeVpmYmw2dWxxS0ZWNkRV?=
 =?utf-8?B?MG9wREhPNEtLQmFnN3grZGRiMktUbzFFa0J6dTMvWmNwSWpOR2h4eTBPUlda?=
 =?utf-8?B?UmV2U3gyY1dHYmlDK3M4OU9SdnFtWFp5aFhNWXNpVU9YUEVnZkVUTDRLUVBs?=
 =?utf-8?B?OWUxbzJ5UWdadlhHQ2F3ZHRFdmVwcjdjSmpJRjhIWk4wVzBoZ0x0NkphT2U5?=
 =?utf-8?B?L2xBMXZpZVY2TmFjV3dBRHloRmtGWGY2OUE3OWc5YTV5TVdPd0ZrT2E0Zmln?=
 =?utf-8?B?OHM3L2g2YWJJbVNaK2IzU25oVEVqRXRERW8rOStiRTdwclRmcEV6SW5hRWl0?=
 =?utf-8?Q?9AnzmH6lluxXoWXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5C674E0CE50F043ACAE3207424DCE04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VcdDE/yI+PQ7eFDN+oWhFKhYjTtYrrkJM18qHJfRRxemo7o1GACrg81++BDzuWNQvXQQO72ls6FtcUmEQVk/YTHa4WYUdpB+mr20/WplVx6nb/DEZuzDxnQVh+de7R0N/83verqrWRCslBLK3mhFCtxl1CFfCTheAvZkWSP8sWRGXnBZRgpY/D/cZuOFodYwuVXHECgeBi5dNn31UjiMoeHEjsM5bbc1PtpdfRkG9DZuvMVvj1Ct7jdHWpMvkYyLtSAfeVIAYdOP41TM2roKcXawE5g/wz964I4RjOfpsvvtKf86fTsxM3AedcQtyAnpM9lW89dqrMzTiX1MJEQD8A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314e8e3f-d913-4c16-5f1e-08de8f841967
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 00:17:45.7537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGoQCp0kTNbmxO84qfMaS8gGngafP2BC6IX/t1pxVGR2qCtSZm96eqfu839Sz5cZD6bfLpcTNjsMDzuIHxwoXY/Fw+y0xZIb91ghPX5TqfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8327
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDIyOjE5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBD
b25zaWRlciB0aGUgYW1vdW50IG9mIHRyaWNrcyB0aGF0IGFyZSBuZWVkZWQgdG8gY29heCB0aGUg
dGR4X3BhZ2VfYXJyYXkgdG8NCj4gPiBwb3B1bGF0ZSB0aGUgaGFuZG9mZiBwYWdlIGFzIG5lZWRl
ZC4gSXQgYWRkcyAyIHBhZ2VzIGhlcmUsIHRoZW4gc3VidHJhY3RzDQo+ID4gdGhlbQ0KPiA+IGxh
dGVyIGluIHRoZSBjYWxsYmFjay4gVGhlbiB0d2Vha3MgdGhlIHBhIGluIHRkeF9wYWdlX2FycmF5
X3BvcHVsYXRlKCkgdG8NCj4gPiBhZGQNCj4gPiB0aGUgbGVuZ3RoLi4uDQo+IA0KPiBtbS4uIFRo
ZSB0cmlja3kgcGFydCBpcyB0aGUgc3BlY2lmaWMgbWVtb3J5IHJlcXVpcmVtZW50L2FsbG9jYXRp
b24sIHRoZQ0KPiBjb21tb24gcGFydCBpcyB0aGUgcGEgbGlzdCBjb250YWluZWQgaW4gYSByb290
IHBhZ2UuIE1heWJlIHdlIG9ubHkgbW9kZWwNCj4gdGhlIGxhdGVyLCBsZXQgdGhlIHNwZWNpZmlj
IHVzZXIgZG9lcyB0aGUgbWVtb3J5IGFsbG9jYXRpb24uIElzIHRoYXQNCj4gY2xvc2VyIHRvIHlv
dXIgImJyZWFrIGNvbmNlcHRzIGFwYXJ0IiBpZGVhPw0KDQpJIGhhdmVuJ3Qgd3JhcHBlZCBteSBo
ZWFkIGFyb3VuZCB0aGlzIGVub3VnaCB0byBzdWdnZXN0IGFueXRoaW5nIGlzIGRlZmluaXRlbHkN
CnRoZSByaWdodCBhcHByb2FjaC4NCg0KQnV0IHllcywgdGhlIGlkZWEgd291bGQgYmUgdGhhdCB0
aGUgYWxsb2NhdGlvbiBvZiB0aGUgbGlzdCBvZiBwYWdlcyB0byBnaXZlIHRvDQp0aGUgVERYIG1v
ZHVsZSB3b3VsZCBiZSBhIHNlcGFyYXRlIGFsbG9jYXRpb24gYW5kIHNldCBvZiBtYW5hZ2VtZW50
IGZ1bmN0aW9ucy4NCkFuZCB0aGUgdGhlIGFsbG9jYXRpb24gb2YgdGhlIHBhZ2VzIHRoYXQgYXJl
IHVzZWQgdG8gY29tbXVuaWNhdGUgdGhlIGxpc3Qgb2YNCnBhZ2VzIChhbmQgaW4gdGhpcyBjYXNl
IG90aGVyIGFyZ3MpIHdpdGggdGhlIG1vZHVsZSB3b3VsZCBiZSBhbm90aGVyIHNldC4gU28NCmVh
Y2ggdHlwZSBvZiBURFggbW9kdWxlIGFyZyBwYWdlIGZvcm1hdCAoSU9NTVVfTVQsIGV0Yykgd291
bGQgYmUgc2VwYXJhYmxlLCBidXQNCnNoYXJlIHRoZSBwYWdlIGxpc3QgYWxsb2NhdGlvbiBwYXJ0
IG9ubHkuIEl0IGxvb2tzIGxpa2UgTmlrb2xheSB3YXMgcHJvYmluZw0KYWxvbmcgdGhlIHNhbWUg
cGF0aC4gTm90IHN1cmUgaWYgaGUgaGFkIHRoZSBzYW1lIHNvbHV0aW9uIGluIG1pbmQuDQoNClNv
IGZvciB0aGlzOg0KMS4gQWxsb2NhdGUgYSBsaXN0IG9yIGFycmF5IG9mIHBhZ2VzIHVzaW5nIGEg
Z2VuZXJpYyBtZXRob2QuDQoyLiBBbGxvY2F0ZSB0aGVzZSB0d28gSU9NTVUgc3BlY2lhbCBwYWdl
cy4NCjMuIEFsbG9jYXRlIG1lbW9yeSBuZWVkZWQgZm9yIHRoZSBzZWFtY2FsbCAocm9vdCBwYWdl
cykNCg0KSGFuZCBhbGwgdGhyZWUgdG8gdGhlIHdyYXBwZXIgYW5kIGhhdmUgaXQgc2hvdmUgdGhl
bSBhbGwgdGhyb3VnaCBpbiB0aGUgc3BlY2lhbA0Kd2F5IGl0IHByZWZlcnMuDQoNCk1heWJlLi4u
IENhbiB5b3Ugd3JpdGUgc29tZXRoaW5nIGFib3V0IHRoZSBzaW1pbGFyaXRpZXMgYW5kIGRpZmZl
cmVuY2VzIHdpdGggdGhlDQp0aHJlZSB0eXBlcyBvZiBsaXN0cyBpbiB0aGF0IHNlcmllcz8gTGlr
ZSBpbiBhIGNvbXBhY3QgZm9ybT8NCg0KQWxzbywgaG93IG11Y2ggb2YgdGhlIGVhcmxpZXIgY29k
ZSBkdXBsaWNhdGlvbiB5b3Ugd2FudGVkIHRvIGF2b2lkIHdhcyB0aGUNCmxlYWtpbmcgYW5kIHNw
ZWNpYWwgZXJyb3IgaGFuZGxpbmcgc3R1ZmY/DQo=
