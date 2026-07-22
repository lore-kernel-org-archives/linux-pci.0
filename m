Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63D35C6AC
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733303; cv=fail; b=TgVYqUgugmIcLszvbf/OBPkUWZM99RUw7ocTRqaH1r3yc1V8uHrvdGgOUoSd4AgIpWWJwSjVqJ5C2WOAf6/MfOs40DqFvVnsp7E/QOrJX3kGEp9zmgbv41DZWhm4CvW9nY6wG3plEoLJc8l/F47zp0tGT6WWBam6encBp5IZ80M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733303; c=relaxed/simple;
	bh=0BxVIymQ4PeIMZxErwSWt/Zxd2gP+yZgwpEB6Jt/9G8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFCsSvQeZaI7B5EBAboLDK0sSAqsgXuYWNyDVXFA0imoXN6cJPCBVVmDWQPuotuwgkwh/IIpSb9yY1AzTAyZGmvQ8XBRT4/pwuD+T+lyyajkS875dY0IVfwxaLrYepu8WcAESWnBbTaNap1+Vh1hQLi+9Y92gwgXeHN96iRvIDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qmfvh4zU; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qmfvh4zU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784733301; x=1816269301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0BxVIymQ4PeIMZxErwSWt/Zxd2gP+yZgwpEB6Jt/9G8=;
  b=Qmfvh4zUSiwZdBKcCmqyF7/7lqWAEoKfghhtCAn7XsO1PP4jjhmleCQl
   fXybxUY8VKlS5DVjVegVXeNUxGw9FesQaejz8J6IwKg3YJ8xYnX009G3P
   Qaw8wfmrEHWZFZ/xhQTYZL10+tOHfltXOQx7KEUwPpCSyeNa8Ze8h7ejh
   fMTeClfVc50nWgJJaE598mixJSnp7U20ffbC3T6PJwahNzSwrBlF96mjN
   PcrrIPMDWhT2fupwnnZmvF6scEF/G4ZZEPfZrpCERvsYOyV0D5l6xd7Fa
   b8QXYgL8NXrlRPCxgXFOvGg9qHwOEysmeqPtUEdrdwtIkN+3UMev9cbU9
   w==;
X-CSE-ConnectionGUID: NHSGiNSrSCCMSxc/j9UR5w==
X-CSE-MsgGUID: cZ/FYcemSlCH9rZWqRoGBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="110914303"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="110914303"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:15:01 -0700
X-CSE-ConnectionGUID: lCBvHxZGQtajMh9ivycP6Q==
X-CSE-MsgGUID: sG8yKTIRS/GZuvIuSjpnAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="296329886"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:15:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 08:14:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 08:14:59 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 08:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o35PSTn+dEz+hIqHi6/OC+NLV0XGVf/ITKnZE/57HxH2i9EA7F8fofx4FRha3SWIyoTdIpMc82XPst3vlGorg8QgTnHgxkP2n+P/sirtZxLMwnCMphnPNnpTgUGpUyONTagOW4fP3A4DtMxjwV4KnmVGpT/hhEI0A8tEwX7A/Y80XPl7xlkNUTrq8OPXf0G89DKi90XFBFxTDDKmGu8uwly8jHZcYIYnyeXXm2aRfhyLiCIPHBClZbJ3E89lYTCR1n7bF4l4NQrGcXye5EypQNkTNmehGOzXepmhdQ6y3t/35TyeSBAiui8wBZy4l4YI38t+ezIHyphtqAODsAMR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BxVIymQ4PeIMZxErwSWt/Zxd2gP+yZgwpEB6Jt/9G8=;
 b=WsiqvSiRwJ8gy/Qmez/484pfFgI2Yp9RbMSmroJ94xbygGf5icOSJODusU5Vbr4hO2zHuYqRR0xs/0ipkoGkaCvlrTYtdtXlQ0zcsHrEeid5dWqV8Ilc6E5CY7e93uJnb8Y+EhxYZ9PmJKj/+tCLNlRRp9Y4d1YL3GLgyQmVMlE5bONzQ4mKMlf3M1PkYL5nG8jBkhts5FOBk66OA7v1MFiCtvYCnWwamNk3v+V5w1rz5QQQntzRiClhedeycLimAgDiDxmWn3q1S9A04eQ1TRVlQXMkRm8D1ZHwTgAMCmKLQnn/AfWHnQhrsz+4x5X+vkkyRrRoWj6R6X7319EOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:14:48 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:14:47 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Topic: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZImB0AgAAE6oCAMTTxAIAABOIA
Date: Wed, 22 Jul 2026 15:14:47 +0000
Message-ID: <62aee750dbabf3e10494e0e5b20f3ba30a7815a3.camel@intel.com>
References: <20260621065451.21650-1-emmanuel.grumbach@intel.com>
	 <20260621071242.B20F31F000E9@smtp.kernel.org>
	 <29e347a8ed29e7fdc52ddba72c8ce9da80239993.camel@intel.com>
	 <20260722145630.GA729605@bhelgaas>
In-Reply-To: <20260722145630.GA729605@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|SN7PR11MB7092:EE_
x-ms-office365-filtering-correlation-id: e6d5b900-9861-424b-2f15-08dee803f828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|38070700021|10067099003|4143699003|3023799007|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: oOoa1PkauDhciGCAoeuTfjVvnc4ZrNj4n/w3vZmDkaBB6Y5KsFm6KVNweesYN6b8PFE7qfiOAK1RleuAR/j6lQwDGWxOxjykNvEgIbxKNACWFqfpVxYH6mFh8LuUXMqRjKIhYl8/aIWXZUFXfImgJryPfeenBuySLc8CFK8WMQbZr0cSCeuQzTTTyvXnCQuqMwLgXZ+YMyxBcnwvP1510Hx4rbFsiaptDN1o63MjzHzkZ7SgzVL7H791e/fs1gLXazNX+Dt6H9GOx2QjbTdTk8HQlrOiqX8EGQw3B5TIljxk4TDHM2BlEpN3gkqCKInaKqKKdPfEv5yyVw/k7vVARB0jfRbP1X1Jp6RiyXUH5Io3p9xxLRzdd4AlUn/PJUJsvz95NUfbRAxHvym3Nh4GQONRZHMKJJcCOMLBj6RBHxReyn7pNS/vCcUhw7udfIlV1tEYZnOrIwJDhAkIPKZO6AnHx8lw3Z2wVkbHSFnIDlmwGBW4Z1uk129Ki+N8V0dAcrpdZRDKfgC/Hx9d6Py15h/YypdNdyLQFrYvV5zy13x2RaUNGDP4b7iuygFKiAFVxsyFtapO+6wY35z+PAWU8mpb1sIit+ytNI0N6H753+DIZw4n+5E0RcvcQtcLroPNVhFcCk6zTGPaHJQ9Lfsj9uwwXH333qWhvzZ6lhq/86cIQjyEmb/QRgxzO/HB8OTWXBh/Bx63Hv6OwQNNAqIUgGWOwPv5JQNIB6H7FCkrqY4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(38070700021)(10067099003)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UExEVndoSCswRFA3cUtXQlhLMG56cGJtcG0zWWpPa2NDNzBoTDlic254Q2NJ?=
 =?utf-8?B?M2tYMnBaY3pUdHN3YWVZdGlrUWllcmp3ajQxc2VKM0pyRTJqdi9pcElESWlR?=
 =?utf-8?B?RWpmelBEYVk0Y0hRMUpWR09TZzN1RE5rc1Q1UnZMSjgycXl4dTBINXNUSzhq?=
 =?utf-8?B?K3NCTWhBcGFNY1BJVW5UVDVHMHB5Q1Z5cjBzY0N6ZWYyWVV1eFAyN1B1cjEw?=
 =?utf-8?B?SFNobGhaU0VHOVI3dTNFRENmc2pwcVdlRFdITG9ucTljVXJJR2lscjBkYXlJ?=
 =?utf-8?B?cmdVOFlLL2IxODd3UDcrV044ZXVEZWpoM0tTeWF4QlZjWlpibU1sNVFwRThE?=
 =?utf-8?B?ODE3cWVUdFlWakEvV0F4TkxtYkc2eVZSRFdjRkpmN2wvYnlKWVVBczJyQmJm?=
 =?utf-8?B?TWwvdEtDbzVwbzZWaGpFZEVld2doV3lrYnkrYTl4d29CVUYyRXlHZ0Rld2x1?=
 =?utf-8?B?VzhZd3VDWllvYW53WDdMMnpCNjdIc28yeHlRdDNBWktNUHg1bFBDcSsxUURR?=
 =?utf-8?B?ZnhZRlJpZnB5ejIwWjlVeTlyRzRYdERoMEROL2RsQTBrMm1mWTRiOTkwdXlo?=
 =?utf-8?B?MC9leVJ6eXNpQjczcDcrbzJ2Sm1kL2luNWo2dnNEQ3R0Sy90NUJpeDlPK0NI?=
 =?utf-8?B?ckdPTXAwTGpYUGd4bFF1dWNibndKcjhEblphZWx5dk1oOGZaRFdVZVVxOUhY?=
 =?utf-8?B?OGFhUFhFcWxqQ1VQVmUyblozVGJqT2hqNUx2QUYwMHpuNEUxY2RlRnp2VUV2?=
 =?utf-8?B?OXNqUmlMWitLNnlxWHd3NjdVTFlpY09kUlJFSnVmVnVYOVpOUDN0OVpCK1RM?=
 =?utf-8?B?NHFQdUE5V1JkR2RNc0d2UmNMOVRYcEZpWXN6UXhRTUNsYThCSHoxU1VsMmEw?=
 =?utf-8?B?Z3hNTzE2NDJNemVHM3dXQlFJYUZWS2RIM0NPTDFXb2xFcTNINHpuZ0QzMHNa?=
 =?utf-8?B?bkFZeTlpV1VUaHRCOGt2S3cxekJiS0Jhc1NraGJCWXpTdVg3em5hQlE4M3Rn?=
 =?utf-8?B?RlJPZ201Rm1vRkxqS3JURFVKZ3RlbUhDR0ptbG9WR0o2YTR0K2hVbDUrQlFr?=
 =?utf-8?B?TFFYTi8xelNmMzJuZXFpaGw0QmdjcG9XNlJJWkFUK1RxQit3bGlUV05DNEs0?=
 =?utf-8?B?dFVzS2dPQzhTcHdrQVBiZTc4N3RwODVRT2ZNdTdjaDk1NFd2ckIxMVR4eXVU?=
 =?utf-8?B?QXZzSkhKT0djYWRwcWVOKzlOYWU5TkdQdHpQdGJvUVJXRGlGUUdEWUdXZkQ0?=
 =?utf-8?B?a0RSNEZlZm9sV0Rwb04zNkdVRk5uYk9GZkJWSUZxRVd1Mk0rYTFTL2tEcDhT?=
 =?utf-8?B?VzJYNzNSODVxZ2UrZkZ5OUtiblFvQXE5YVZyTDlkVUwyazZKcFRnTU94cG4r?=
 =?utf-8?B?aEdJTGtYR2lxbHpzMC9KS3FWV0xmWHRmdnRodXhVSDI4ZC91YjlkNzVIT2t4?=
 =?utf-8?B?RnVIanU4dkdWK0F2Vkx2SWxUZk9rRk4wUlFjRjdYK0QzTmR6eGRFSnVVVGJz?=
 =?utf-8?B?OHVLbmhIN1o5VUMwNHNEUWtOSDVqTG9Yc2JOUVNCRnI2Q3l3ZUNwR2FFek9x?=
 =?utf-8?B?VmU3QjQrLzRIMzBPdTZaR011eCtJMSszeWxnbTNWblN1eWRnakd3NlpmNmFV?=
 =?utf-8?B?UktxbCtlcU14Q0JXUVRVOEszbWRIVnRSR0JSb0VsTy96WlIreHlGRWlEN25k?=
 =?utf-8?B?d1B4SURycVI0TnpQcmNTUFI5Sk5TdnZIdUh1cTZUcUNLNi9zMXA1YnhWMnQx?=
 =?utf-8?B?UDhOSEZyZ0gvRnVWQStZV1ZDRXUrQnI3TTZrcTIxak54dW9tcnlwTlFTcUVX?=
 =?utf-8?B?QVV5WnZ6Njl2MWlFUWl1a3huUGNGV1d0c2U0dFdKcUthd1RIdE41MXpKLzU0?=
 =?utf-8?B?TTJhbk9DUlFiUnBnWVBJWGZ1dmZ5Q2kvdGlhalB0MmpXZ2VGWmtsNkV1YjMw?=
 =?utf-8?B?RUJwbjlIM1pCZ21DTnZsaXRKdVFMWWZXeFo4WU4vRERITXV3K01jMUxYY2dX?=
 =?utf-8?B?UE43dzlkUzVXbEMxb0Q1Vkd3Zk5iWEwxekwyWXdGdDV1R0plQlg1amhpQ2M4?=
 =?utf-8?B?UnY1ekdobFNtV3BhSVdTY0sxRTdpUXZQWThXVklERS9ZT1F1WWNuQm03TjE0?=
 =?utf-8?B?UDFuTWtWbW1vWk1yNGVyTEl2cVREYXljeEV4M0hYVHByUEpSYkVyOTArWGRQ?=
 =?utf-8?B?N1BEcXUxV0RQNitZaGVSN2xvWlVhUHFSS0tiNkpMTnJ5YWpCYW8rN3lsekE2?=
 =?utf-8?B?ZjZKdll4SkI1MG5KYm0xeVNCekRtc1FMck5aOHdkVWJBbDhvbTF2NWpuQXl1?=
 =?utf-8?B?OTNncTloNHRrSkpIUHBGZ0UxdTIyS1Z2eUZmMmRDaFhGSG9ueE9ESCthSzY4?=
 =?utf-8?Q?1A0L9K9Mxh7S2v30=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <287621AAE10A114182990DCC64C92741@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gp+ZRQnK7svI6r07zwBHa6fnI0mWIW3DFj7l+CogKrzRSwISA43efb12HsdwbEHPOt3dtTguhaBoLlv1xvY1Kd3OvehtWmH/DAfWK6nh39FgtatL4xKQVGc8Y3fLT7NPXxKSNKo7hmEuEHrmpmKSOFskIqLCMbHAtVU0VBr9PokntMhd0z4AfxGGwOxSElJ329+HCMCnqnMDhDzEp0J4egfRmkkAcFN/aiE1U4WrPcoKP0UKnAZsvKPSeOdzQcNg2pVaXGN+8CqLMB4oTtPQDnUTVcq3/cFceYkLYtPiOSaX8I/vWnpco9yBsAunzjw6Z2dBju04uluXAUZpT6Wu7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d5b900-9861-424b-2f15-08dee803f828
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 15:14:47.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Z2xkesTR6RBveEz2lD7BdGiBYQW9Poetdn4geuECO53EYn7GJhJs3eSGDjyht1C/LkSWcLAJ4YzWkHwjs9RleLsc5WRMaWBptBoZidd67M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-OriginatorOrg: intel.com

SGkgQmpvcm4sDQoNCmxvbmcgdGltZSA6KQ0KDQpPbiBXZWQsIDIwMjYtMDctMjIgYXQgMDk6NTYg
LTA1MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+IE9uIFN1biwgSnVuIDIxLCAyMDI2IGF0IDA3
OjMwOjI1QU0gKzAwMDAsIEdydW1iYWNoLCBFbW1hbnVlbCB3cm90ZToNCj4gPiBPbiBTdW4sIDIw
MjYtMDYtMjEgYXQgMDc6MTIgKzAwMDAsIHNhc2hpa28tYm90QGtlcm5lbC5vcmfCoHdyb3RlOg0K
PiA+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcg
Zm91bmQgMQ0KPiA+ID4gcG90ZW50aWFsDQo+ID4gPiBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4g
PiA+IC0gW0hpZ2hdIE1pc3Npbmcgc3VzcGVuZC9yZXN1bWUgZml4dXAgaG9vayBmb3IgSW50ZWwg
QkUyMDAgUENJZQ0KPiA+ID4gZXJyYXR1bSB3b3JrYXJvdW5kDQo+ID4gPiAtLQ0KPiA+ID4gDQo+
ID4gPiBjb21taXQgZWJjZGFiNmQ2OGE5MmQyM2FhNmNmMTcxM2U4ZTcyZDg3ZjBlNjI3OQ0KPiA+
ID4gQXV0aG9yOiBFbW1hbnVlbCBHcnVtYmFjaCA8ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29t
Pg0KPiA+ID4gDQo+ID4gPiBQQ0k6IERpc2FibGUgTm9Tbm9vcCBhbmQgUmVsYXhlZCBvcmRlcmlu
ZyBmb3IgSW50ZWwgd2lyZWxlc3MNCj4gPiA+IEJFMjAwDQo+ID4gPiANCj4gPiA+IFRoaXMgY29t
bWl0IGRpc2FibGVzIE5vU25vb3AgYW5kIFJlbGF4ZWQgb3JkZXJpbmcgb24gdGhlIHJvb3QNCj4g
PiA+IHBvcnQNCj4gPiA+IGZvciB0aGUNCj4gPiA+IEludGVsIHdpcmVsZXNzIEJFMjAwIGRldmlj
ZSBiZWNhdXNlIGl0IGZhaWxzIHRvIGNvcHkgVExQDQo+ID4gPiBBdHRyaWJ1dGVzDQo+ID4gPiBm
cm9tIGENCj4gPiA+IFJlcXVlc3QgdG8gdGhlIENvbXBsZXRpb24uIA0KPiA+ID4gDQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9xdWlya3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5j
DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQo+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL3F1aXJrcy5jDQo+ID4gPiA+IEBAIC00Njc0LDYgKzQ2NzQsMTMgQEAgc3RhdGljIHZv
aWQNCj4gPiA+ID4gcXVpcmtfY2hlbHNpb19UNV9kaXNhYmxlX3Jvb3RfcG9ydF9hdHRyaWJ1dGVz
KHN0cnVjdCBwY2lfZGV2DQo+ID4gPiA+ICpwZGV2KQ0KPiA+ID4gPiDCoERFQ0xBUkVfUENJX0ZJ
WFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0NIRUxTSU8sIFBDSV9BTllfSUQsDQo+ID4gPiA+IMKg
CQkJDQo+ID4gPiA+IHF1aXJrX2NoZWxzaW9fVDVfZGlzYWJsZV9yb290X3BvcnRfYXR0cmlidXRl
cyk7DQo+ID4gPiA+IMKgDQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICogVGhlIEludGVsIHdpcmVs
ZXNzIEJFMjAwIGZhaWxzIHRvIGNvcHkgVExQIEF0dHJpYnV0ZXMgZnJvbQ0KPiA+ID4gPiBhDQo+
ID4gPiA+IFJlcXVlc3QgdG8gdGhlDQo+ID4gPiA+ICsgKiBDb21wbGV0aW9uIGl0IGdlbmVyYXRl
cy4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9W
RU5ET1JfSURfSU5URUwsIDB4MjcyYiwNCj4gPiA+ID4gKwkJCSBxdWlya19kaXNhYmxlX3Jvb3Rf
cG9ydF9hdHRyaWJ1dGVzKTsNCj4gPiA+IA0KPiA+ID4gW1NldmVyaXR5OiBIaWdoXQ0KPiA+ID4g
V2lsbCB0aGlzIHdvcmthcm91bmQgc3Vydml2ZSBhIHN5c3RlbSBzdXNwZW5kIGFuZCByZXN1bWUg
Y3ljbGU/DQo+ID4gPiANCj4gPiA+IFdoZW4gdGhlIEludGVsIEJFMjAwIGRldmljZSBpcyBob3Rw
bHVnZ2VkLCB0aGUgdXBzdHJlYW0gUm9vdA0KPiA+ID4gUG9ydCdzDQo+ID4gPiBjb25maWd1cmF0
aW9uIHN0YXRlIGlzIHNhdmVkIGF0IGJvb3QgdGltZSBieQ0KPiA+ID4gcGNpZV9wb3J0ZHJ2X3By
b2JlKCksDQo+ID4gPiB3aGljaCBjYWxscyBwY2lfc2F2ZV9zdGF0ZSgpLiBUaGUgd29ya2Fyb3Vu
ZCBtb2RpZmllcyB0aGUgUm9vdA0KPiA+ID4gUG9ydCdzDQo+ID4gPiBjdXJyZW50IGNvbmZpZ3Vy
YXRpb24gdG8gZGlzYWJsZSBSZWxheGVkIE9yZGVyaW5nIGFuZCBObyBTbm9vcCwNCj4gPiA+IGJ1
dCBpdA0KPiA+ID4gZG9lcyBub3QgdXBkYXRlIHRoZSBSb290IFBvcnQncyBzYXZlZCBzdGF0ZSBh
cnJheS4NCj4gPiANCj4gPiBUaGF0J3MgYSBnb29kIHBvaW50LCBidXQgSSdtIG5vdCBzdXJlIHdl
IHJlYWxseSB0ZXN0IHdlbGwNCj4gPiBob3RwbHVnLi4uDQo+IA0KPiBJdCBsb29rcyBsaWtlIEJF
MjAwIGlzIG5vcm1hbGx5IGFuIE0uMiBmb3JtIGZhY3RvciwgYW5kIEkgZG9uJ3QgdGhpbmsNCj4g
TS4yIGlzIGRlc2lnbmVkIHRvIHN1cHBvcnQgaG90cGx1Zy7CoCBJIGd1ZXNzIGl0IGNvdWxkIGJl
IGRvbmUgd2l0aCBhbg0KPiBNLjItdG8tUENJZSBhZGFwdGVyLCBidXQgdGhhdCBzZWVtcyBhIGJp
dCBlc290ZXJpYy4NCg0KSW5kZWVkLiBCRTIwMCBpcyBhbiBNLjIgZm9ybSBmYWN0b3IuDQoNCj4g
DQo+ID4gPiBVcG9uIHN5c3RlbSBzdXNwZW5kLCB0aGUgUENJIGNvcmUgc2tpcHMgc2F2aW5nIHRo
ZSBSb290IFBvcnQncw0KPiA+ID4gc3RhdGUNCj4gPiA+IGJlY2F1c2UgaXRzIHN0YXRlX3NhdmVk
IGZsYWcgaXMgYWxyZWFkeSB0cnVlLiBEdXJpbmcgcmVzdW1lLA0KPiA+ID4gcGNpX3Jlc3RvcmVf
c3RhdGUoKSByZXN0b3JlcyB0aGUgUm9vdCBQb3J0IHRvIGl0cyBvcmlnaW5hbCBib290LQ0KPiA+
ID4gdGltZQ0KPiA+ID4gc3RhdGUsIHdoaWNoIHdvdWxkIHJlLWVuYWJsZSB0aGUgcHJvYmxlbWF0
aWMgYXR0cmlidXRlcy4NCj4gPiA+IA0KPiA+ID4gU2hvdWxkIHRoZXJlIGFsc28gYmUgYSBERUNM
QVJFX1BDSV9GSVhVUF9SRVNVTUVfRUFSTFkgaG9vaw0KPiA+ID4gcmVnaXN0ZXJlZA0KPiA+ID4g
aGVyZSB0byBlbnN1cmUgdGhlIHdvcmthcm91bmQgaXMgcmUtYXBwbGllZCB3aGVuIHRoZSBkZXZp
Y2UNCj4gPiA+IHJlc3VtZXM/DQo+IA0KPiBJJ20gcHJldHR5IHN1cmUgdGhlIGhlYWRlciBxdWly
a3Mgd291bGQgYmUgcnVuIGJlZm9yZSBwb3J0ZHJ2IHByb2JlcywNCj4gc28gSQ0KPiBndWVzcyB0
aGlzIGlzIHBhcnQgb2YgdGhlIHNhbWUgdGhlb3JldGljYWwgc2NlbmFyaW8sIHdoZXJlIHBvcnRk
cnYNCj4gcHJvYmVzDQo+IGJlZm9yZSBhIEJFMjAwIGlzIGhvdC1hZGRlZC4NCj4gDQo+IENhbiB3
ZSBpbmNsdWRlIGFueSByZWxldmFudCBkbWVzZyBvdXRwdXQsIGUuZy4sIEFFUiBlcnJvcnMgb3IN
Cj4gd2hhdGV2ZXINCj4gbW90aXZhdGVkIHRoaXMgcXVpcmsgaW4gdGhlIGZpcnN0IHBsYWNlPw0K
DQpUaGUgcHJvYmxlbSB3YXMgdGhhdCB3ZSBkaWRuJ3Qgc2hvdyB1cCBhdCBhbGwgaW4gdGhlIGVu
dW1lcmF0aW9uLiBXZQ0Kc2VuZCBhIG1hbGZvcm1lZCBUTFAuIEknbSBub3QgcXVpdGUgYW4gZXhw
ZXJ0IGF0IHRoaXMsIGJ1dCBvdXIgUENJZQ0KZXhwZXJ0cyBydW4gYSBQQ0kgYW5hbHl6ZXIgb24g
dGhlIGVudW1lcmF0aW9uIG9uIHRoYXQgc3BlY2lmaWMgcGxhdGZvcm0NCmFuZCB0aGV5IHNhdyB0
aGF0IHBsYXRmb3JtJ3MgUENJIGNvbnRyb2xsZXIgc2V0cyB0aGUgTm9Tbm9vcCBhbmQNClJlbGF4
ZWQgb3JkZXJpbmcgYml0IGluIHRoZSBUTFAuIEFjY29yZGluZyB0byB0aGUgc3BlYyAod2hpY2gg
SQ0KaWdub3JlKSwgdGhlIEJFMjAwIGlzIHN1cHBvc2VkIHRvIHJldHVybiB0aGUgVExQIGFzIHJl
Y2VpdmVkLCBidXQgd2UNCnJlcGx5IHdpdGggMCBBdHRyaWJ1dGVzIGFuZCB0aGUgZW51bWVyYXRp
b24gZG9lc24ndCBjb21wbGV0ZQ0Kc3VjY2Vzc2Z1bGx5Lg0KDQo+IA0KPiBjNTZkNDQ1MGViNjgg
KCJQQ0k6IFR1cm4gb2ZmIFJlcXVlc3QgQXR0cmlidXRlcyB0byBhdm9pZCBDaGVsc2lvIFQ1DQo+
IENvbXBsZXRpb24gZXJyYXR1bSIpIG1lbnRpb25zIE1hbGZvcm1lZCBUTFAgb3IgVW5leHBlY3Rl
ZCBDb21wbGV0aW9uDQo+IGVycm9ycywgc28gSSBzdXBwb3NlIHRoaXMgaXMgc2ltaWxhcj8NCg0K
UHJlY2lzZWx5Lg0K
