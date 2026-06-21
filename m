Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4FC199931
	for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782027031; cv=fail; b=dC3eQTjaT0uEtu3p9zOFD/Vd2ekbJ9Ni1SVemracaxNCjQT3l6lFp2u10MhMQdo9UTuDd3IyNLyihdAG26BlrQq1rsUJ6yM+shvDl03PxtqIUdB/zGkOgNi15o2HuJq03DA3Dyuo+1hXCeaGbbPEqgW2TJI+xnubQbhI0xqWgB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782027031; c=relaxed/simple;
	bh=eA1dZYpCygmwyDxXVkVHLYf+rryUxioeBpE92cuTttI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RJkW8rUCMXQSQrCx08AZ/2yU0wP6RUKAxEnrDEyBvw0Emmw3Tst3mjdH65YMI+yW93ktlacn4gNL4jGRaJcCVI5nniwQZ34lJ+7d7p6jg5g+3DO5ORCdKOhxl1Tt3emPyv+CjKeRjQUEV3WOoP6feffkaVJs57Epr56MCk/sSsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge1UlfOK; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge1UlfOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782027030; x=1813563030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eA1dZYpCygmwyDxXVkVHLYf+rryUxioeBpE92cuTttI=;
  b=ge1UlfOKYOlEnqIWtF2NSymsrKiPaiORaXCAR4isu5wvWUsydyjgHYQ5
   89VvrPNM4dtT+VG8whYdi3Kwvl9ZnDYfTVF2mDY5eBoWtETjdTObCsXlm
   uahpfczfjWGOYdTXe8whsGFs8n6MXzZf6Yguvf4GsuSKY1rGUu75/QqRi
   5KkmdjLK2Vb8YWRU69J1V4ZLYLLMLon1uVNwG0B8mTtixTUbvPS4RLECs
   ZDtPKmIcV0YuTY2YXnH9xXBtcOQrHZ15l7vnF2lpu6NrQsGonqShF80G/
   e04M8w2+3SC11BkDHMNQRB3CfbTbxpsEp/QwMnAZ9wvV98z80nabE0nCg
   w==;
X-CSE-ConnectionGUID: 62eYrsUsRGGHkD7Q+T8ISw==
X-CSE-MsgGUID: AG257+WBQAa0FIrCeiYycw==
X-IronPort-AV: E=McAfee;i="6800,10657,11823"; a="82983374"
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="82983374"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 00:30:29 -0700
X-CSE-ConnectionGUID: 8rShqhHRQ1WKGq/2MnTbng==
X-CSE-MsgGUID: N3qUDWfoTQCY1crwPF2UDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,216,1774335600"; 
   d="scan'208";a="272653933"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 00:30:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 00:30:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 21 Jun 2026 00:30:28 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 00:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMIedbUeHdCoeOKgM4vRuf3I9EM/WIlEqV2/IA03mir0HdqdKOckoX1Il4gW7VzASqqiFsakUGIFVMy7VksTqpLgPjJHTl8DtIqNRcv09kb66XSrwmsXCOM79JHYjjo4FIy2uulrAh8CaYnQdY65fbWxHpjvLh8Yr1vX/XFeXnhECnATjnvf1HPuxcCuPB49yLKxrVPWZuz49Kjb6Q6x9xw4dTzkmYW5S0lYUaIDn+ef8w6/ZK5BUQgNVNO0ZgDDhsFnuXaf33ff8HOP6QCDD7tVLxraPsz8PtFA502GgnAenhmyj+/fYmR5YzC1eEEV3UoVVqEe3B4AygQh9j3AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eA1dZYpCygmwyDxXVkVHLYf+rryUxioeBpE92cuTttI=;
 b=t1Nn+yTjcgLiTC8bi7pt9UNzxwoZYLjobwqdphVgwjRN+bdIG8otySRsW53xm9Gk7bOOIc/hdG/kfecwWEChIOg5J68N4vLeCh4mReQ3lAQQtK+Jwnxdk2okpdg6DNqPwn74yMWdpLzOrjI5PhJ/COCAoEsBrxjgfwShd0DIEKb6qPRlwGWHcpYvKmKVu3AcOlf2SKr4mE9ueRni+P8LU+rPgOL23xxAFKyLs0BUoi1XAwAFz06ZTfmXz43iVXd9uan1NVJk0BKV4Mz0yXYhL6alWX3YWvjqBPP8aJlF+fxt0Hky0H5uDlJGpdFAc/dTHH5XyumBZhUPxz/kQA6iPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 07:30:25 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 07:30:25 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Topic: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZImB0AgAAE6oA=
Date: Sun, 21 Jun 2026 07:30:25 +0000
Message-ID: <29e347a8ed29e7fdc52ddba72c8ce9da80239993.camel@intel.com>
References: <20260621065451.21650-1-emmanuel.grumbach@intel.com>
	 <20260621071242.B20F31F000E9@smtp.kernel.org>
In-Reply-To: <20260621071242.B20F31F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|IA1PR11MB7726:EE_
x-ms-office365-filtering-correlation-id: eccd08ef-5353-4f94-61b1-08decf66f5e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|18002099003|22082099003|11063799006|56012099006|6133799003|4143699003;
x-microsoft-antispam-message-info: zK22tD8NduQXVNA+l3GdB+DlDRH0pIimsjs7z566ZgYnvigWtgGjg4Nk+Tx1xlBt78bomQLgd9oFy1g3CPnf883XpAYZYNpgAKLwrM3eQbY+SC9g9nLPuRqyrHNr/3LgO7KhOmJQ+i4DFSESqey+BMpS3QMneekeTnMHUwn1XvYJll8KMf5HCPSiCyj4Z3s9FFxWp86lH5JQ2dzazFvK7zmj37+hxIiF71jK4NMAqVqNhLUIJqmqvGKPN2Vjq0rj82fqxJuTXk0//uZkiyr46ue0EyVoNeZa5ElI52uTL2bNbSCwD9dAabzBA7TqiCBBgXf1Npo6JgTSRFxbYG+h0f25+9O9g59icK87TSE8zROFixfQT7i89+BgD2cm9PNq6ybF1YQYOU8zbjR4z/GsR9WHzhhku2wD5/dd4PbHC6umr8qgzQlPowEy244UWzPWGtHt4W+APOF5VeFoTV+gF/gYKocdVyZQ+W3kwbctTThOkLM27AA2UM1njZ0RVUWP1sVdT11Y74YCSzRBsZSbkxBQyfHGfh0U/eNgKvW7SWmZ2TSE/hmMGRDW8kKybUwJ9CAbHp1pNKJ2n+8LRc0WLrAUvjhKES8I0nTf25WAe6GZzDPzHDPVs7ulNpxtxDsusYsKX6IHUswzS0HUReHcIIB6GUtrQ+qOoQG7NTvZSdHVe2RgJVMtRX1lHwYVD2T77LKdc+57QtGykaXjYoqhGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW1VNTFmWVI3QUhQYU1NNXZSQ3VzZ2lZVG4xa0NsditkV25CbDd6RlArcCtF?=
 =?utf-8?B?NDFNNi8rSUdLQkpxY241cktMREI4b0FnMjJWOWs1b0ZaVklOR3pXNCtUajQ3?=
 =?utf-8?B?a0xiS3crdnpUQzdkWWk1UnZmQ0RDbkFFMTlzd1RJV1JCV3hWbmdVMlNnMnVQ?=
 =?utf-8?B?L3F5SFI2elhwRWFyT0wzbHRiVTVhSXROQ0J4dWM4US9sVzdWWmUxbHpzbUsw?=
 =?utf-8?B?YTlCUWhZNEhyQlVHZlJUQXMxT1JFQ2JCVHNyV2tqWkFwaWVNZkREZWJ1SzZo?=
 =?utf-8?B?ZDM2czhuaWRZRUw1eTBEajZydFpyNkVVbU1sZG5rbkpOQVhWM3Rvd1AyTXJk?=
 =?utf-8?B?M0dKUEN2K1ZlS2dOWjlZTUozRytUYW1wcC8wb0V4ZW9ta25scFNSVEtub3ZZ?=
 =?utf-8?B?VCtIS3pzaEpPdTYvS1FOZHVrOFJIMG5TbnByL1c0RFVHRlk2Y1puNGE2RTFs?=
 =?utf-8?B?a0tTYSs3c1pBQmFDRFBYZXhtWkRIc2R4bnAxcWhhYjFxYnBoT0VwQ0FFdSs2?=
 =?utf-8?B?NFlPbXdMamdCYkdyK0c2QW9CV1Z2TVZ1czRRV0JBUXAwVUwvd1RpeW0weGVQ?=
 =?utf-8?B?eVFpSFdibk9zQ2hsaXIwK1cvanpnY2tMV0kweitCa2hBbHpGWmhBT0ZhbVhG?=
 =?utf-8?B?RW1CT3N1QWhTdkNoY3B2bHZmeVkvSWlMWjJFNUNzby9VaGlONGpWUnl6em9G?=
 =?utf-8?B?Y0NPK01jSFlRT0MvQzdQUnJsazFlUklYOVk1a3dwWHI5eXJmNWk5NElHWkQ5?=
 =?utf-8?B?MzcvaHV3eDY1NjNYZFR2NGhBYkM5NmN6MWloeGh5NWZRL1h5SFVUemJjbnBi?=
 =?utf-8?B?eUQ2N2pxZlc2STdhdi9nTlY4Q2w0cXErNHpHWW80TzFZTjhCMjlRUC9VNU0w?=
 =?utf-8?B?UVYxY292SVlVQUhsSHY2V1d3OHowUSswY2N4Z3hZVW5XWUx5VXVTTE5pMWFD?=
 =?utf-8?B?bFNKSTEvRk1EY0hmbEdHRVgzQU95UExrS1M5dEc5UXdjekVRdC85blhEZG1D?=
 =?utf-8?B?SzBWUktOVmNTZTNFS3U4U24yS1hDMndFV0hpU25LRjlVUVpqRzNsMmZZQXhp?=
 =?utf-8?B?am45TkNyZXFIcXJtaVVDL3dSYWZPWFZtRTFqbXNjMXZUazBBU2lScFd4akZS?=
 =?utf-8?B?MDA3LzdDL2VUV0xsQXJPd1JGQTIydnlFYUFpb2ppanZXVko4dHBLemxUREpo?=
 =?utf-8?B?U0YwYVNPUk5wcFg2MVhBSVd1bFZ1TGxyb3lqWmJpTDlRUVowZW5QNUlUNlpr?=
 =?utf-8?B?a0ZsRnRBWHVCakF3c2xsY3pBVjZMYVpvU25GV3FRZFh5Zk5tYitBNTQxRVFH?=
 =?utf-8?B?NEJzQjFpTmVOdFMyTWhaSXU1TDdKemhnOUphaEh5UjFPQ0VEdlpHUHlEMzJh?=
 =?utf-8?B?NjltN0g1WExtM2x1YXVrYkhlOHREMDh1cnJMTjh3cW8waWFHakFKREhUOU9v?=
 =?utf-8?B?b0U0Yk9NcjFEbFN1VVp3NU8zUlZwemlMZ0pEcVNRWk50dVpkQ0JGSHYwWFVJ?=
 =?utf-8?B?b2VoOEtsWVB1NmpDVk5GeEo0OFBKWEhIQlhuM0U5dEMxLzZha2VSUlhjNUFX?=
 =?utf-8?B?c1gwMGpyYTJFelpLVlBwdFUrWHFWYlIzS3dHVWR2eGdhS2tzWkRkZEI5MWZh?=
 =?utf-8?B?QkVIQ3JuNTFCN3dWbmZkTm51OVdGUEdHN3JVTDVOUXBvSTc1M0xob1pRdnFY?=
 =?utf-8?B?RE5iWnZkVkJSYndkNUJtblZSa1JpR1FvcTNlYVZTWWFkTUxoUENyU241ckFT?=
 =?utf-8?B?NFE0cVlMcU1YcHNTUXBtY3M3QllFb2JzMHBWbithczcxWk4yZWJ3QVFFTGYr?=
 =?utf-8?B?VjJkd2t4L1UrdHdCK2hScVlrcFFjYjM2ZGRyQ0tWM2tTL1l5SHdtYUczb25l?=
 =?utf-8?B?VSt6T1VITGNkQ0FwQXBaMWpWOUNjMDhaY2xoQ3ZiOHRueEZIS1pvS0wvUkwv?=
 =?utf-8?B?QXEzU2NkdC9XVi9CMTg2Y0xFVEJRWVFVYlY5TWRHWFZwSFIxQVpMbDFhM3ky?=
 =?utf-8?B?VXptc0RyTi9hK0ljdytHeTVJeVF4WXZrS3ozOGl1dGZiYU9udHQyNmFrNVpI?=
 =?utf-8?B?NTdRQTJHckRQVHZudUNKVEtpbEhOMmZ6NEZnY1p5UklGbk83MXJ2MEdtUkZ6?=
 =?utf-8?B?R1F6N3lzOGp3a0ZVVkc0UUlaeUsyRTNTYms1NFF6S2gyZnlOdzRzNUtnY01q?=
 =?utf-8?B?aWdYR0JvNVRScm8xd01lWFZSQ21FMVNnS0FteDRDSTRtYlNvWU5HNzUrbFhK?=
 =?utf-8?B?bC96M0FEbXJlMzNwd25lcDRGUmoxbGc2M2lvMnQzY09WYkxxSktPS3JBVHVU?=
 =?utf-8?B?UmtadkJxNzZBZ3dFTTFDY1FHbVAyUFZoaVRGV05ra3RCc2l3YWNlbWY2bXps?=
 =?utf-8?Q?KzK7EeRgqnEfgNuI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E1A82887384D54A8A0A98E32FF2B7BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LqWAzbzYERClKOaoanpQe55TwrICFaDH8ZPAFLq5rpH7FELLQu62OBtxVEVfBKI8vW9OqtstxKCtd/NWZ96CGlG/3oXYfulyL7hbANHyM854pUi7F1q+Ria3eJr7JiQa6Klt8xJQd8G5eBFj6cTT7hK6w/RHjwYUzTKVPF1blT9bbsbuDQLuhgwb+iHATtfCp3hBoS41NEiSZ6F9MoAUO+bGcPZE8Fok7mPenuKp4qapwU9P2nATA3IPknP63FGsGxPW3TRYNC9DUMSOLEcugIoM0pinL+AfjOv/yFWyq7i3ZEnFQh6nM/69+yfTFFyaR0PEkm6uPRjVA73cUBV4fA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccd08ef-5353-4f94-61b1-08decf66f5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2026 07:30:25.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtbirAxLFPjxflHg+xSKvPKgzEwtrwzwL1ReUo+Yjj26NPr7iaMxi2dr+MRD97NtQ/OuXw+RZK2vhfYCK20QMEAKZaIJzgf0UMJnhmQgeIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTA2LTIxIGF0IDA3OjEyICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAxIHBvdGVudGlhbA0KPiBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbSGln
aF0gTWlzc2luZyBzdXNwZW5kL3Jlc3VtZSBmaXh1cCBob29rIGZvciBJbnRlbCBCRTIwMCBQQ0ll
DQo+IGVycmF0dW0gd29ya2Fyb3VuZA0KPiAtLQ0KPiANCj4gY29tbWl0IGViY2RhYjZkNjhhOTJk
MjNhYTZjZjE3MTNlOGU3MmQ4N2YwZTYyNzkNCj4gQXV0aG9yOiBFbW1hbnVlbCBHcnVtYmFjaCA8
ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPg0KPiANCj4gUENJOiBEaXNhYmxlIE5vU25vb3Ag
YW5kIFJlbGF4ZWQgb3JkZXJpbmcgZm9yIEludGVsIHdpcmVsZXNzIEJFMjAwDQo+IA0KPiBUaGlz
IGNvbW1pdCBkaXNhYmxlcyBOb1Nub29wIGFuZCBSZWxheGVkIG9yZGVyaW5nIG9uIHRoZSByb290
IHBvcnQNCj4gZm9yIHRoZQ0KPiBJbnRlbCB3aXJlbGVzcyBCRTIwMCBkZXZpY2UgYmVjYXVzZSBp
dCBmYWlscyB0byBjb3B5IFRMUCBBdHRyaWJ1dGVzDQo+IGZyb20gYQ0KPiBSZXF1ZXN0IHRvIHRo
ZSBDb21wbGV0aW9uLiANCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3F1aXJrcy5j
IGIvZHJpdmVycy9wY2kvcXVpcmtzLmMNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9xdWlya3MuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQo+ID4gQEAgLTQ2NzQsNiArNDY3NCwxMyBA
QCBzdGF0aWMgdm9pZA0KPiA+IHF1aXJrX2NoZWxzaW9fVDVfZGlzYWJsZV9yb290X3BvcnRfYXR0
cmlidXRlcyhzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gPiDCoERFQ0xBUkVfUENJX0ZJWFVQX0hF
QURFUihQQ0lfVkVORE9SX0lEX0NIRUxTSU8sIFBDSV9BTllfSUQsDQo+ID4gwqAJCQkNCj4gPiBx
dWlya19jaGVsc2lvX1Q1X2Rpc2FibGVfcm9vdF9wb3J0X2F0dHJpYnV0ZXMpOw0KPiA+IMKgDQo+
ID4gKy8qDQo+ID4gKyAqIFRoZSBJbnRlbCB3aXJlbGVzcyBCRTIwMCBmYWlscyB0byBjb3B5IFRM
UCBBdHRyaWJ1dGVzIGZyb20gYQ0KPiA+IFJlcXVlc3QgdG8gdGhlDQo+ID4gKyAqIENvbXBsZXRp
b24gaXQgZ2VuZXJhdGVzLg0KPiA+ICsgKi8NCj4gPiArREVDTEFSRV9QQ0lfRklYVVBfSEVBREVS
KFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MjcyYiwNCj4gPiArCQkJIHF1aXJrX2Rpc2FibGVfcm9v
dF9wb3J0X2F0dHJpYnV0ZXMpOw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBXaWxsIHRoaXMg
d29ya2Fyb3VuZCBzdXJ2aXZlIGEgc3lzdGVtIHN1c3BlbmQgYW5kIHJlc3VtZSBjeWNsZT8NCj4g
DQo+IFdoZW4gdGhlIEludGVsIEJFMjAwIGRldmljZSBpcyBob3RwbHVnZ2VkLCB0aGUgdXBzdHJl
YW0gUm9vdCBQb3J0J3MNCj4gY29uZmlndXJhdGlvbiBzdGF0ZSBpcyBzYXZlZCBhdCBib290IHRp
bWUgYnkgcGNpZV9wb3J0ZHJ2X3Byb2JlKCksDQo+IHdoaWNoIGNhbGxzDQo+IHBjaV9zYXZlX3N0
YXRlKCkuIFRoZSB3b3JrYXJvdW5kIG1vZGlmaWVzIHRoZSBSb290IFBvcnQncyBjdXJyZW50DQo+
IGNvbmZpZ3VyYXRpb24gdG8gZGlzYWJsZSBSZWxheGVkIE9yZGVyaW5nIGFuZCBObyBTbm9vcCwg
YnV0IGl0IGRvZXMNCj4gbm90IHVwZGF0ZQ0KPiB0aGUgUm9vdCBQb3J0J3Mgc2F2ZWQgc3RhdGUg
YXJyYXkuDQoNClRoYXQncyBhIGdvb2QgcG9pbnQsIGJ1dCBJJ20gbm90IHN1cmUgd2UgcmVhbGx5
IHRlc3Qgd2VsbCBob3RwbHVnLi4uDQoNCj4gDQo+IFVwb24gc3lzdGVtIHN1c3BlbmQsIHRoZSBQ
Q0kgY29yZSBza2lwcyBzYXZpbmcgdGhlIFJvb3QgUG9ydCdzIHN0YXRlDQo+IGJlY2F1c2UNCj4g
aXRzIHN0YXRlX3NhdmVkIGZsYWcgaXMgYWxyZWFkeSB0cnVlLiBEdXJpbmcgcmVzdW1lLA0KPiBw
Y2lfcmVzdG9yZV9zdGF0ZSgpDQo+IHJlc3RvcmVzIHRoZSBSb290IFBvcnQgdG8gaXRzIG9yaWdp
bmFsIGJvb3QtdGltZSBzdGF0ZSwgd2hpY2ggd291bGQNCj4gcmUtZW5hYmxlDQo+IHRoZSBwcm9i
bGVtYXRpYyBhdHRyaWJ1dGVzLg0KPiANCj4gU2hvdWxkIHRoZXJlIGFsc28gYmUgYSBERUNMQVJF
X1BDSV9GSVhVUF9SRVNVTUVfRUFSTFkgaG9vayByZWdpc3RlcmVkDQo+IGhlcmUgdG8NCj4gZW5z
dXJlIHRoZSB3b3JrYXJvdW5kIGlzIHJlLWFwcGxpZWQgd2hlbiB0aGUgZGV2aWNlIHJlc3VtZXM/
DQoNCkknbGwgaGF2ZSB0byBjaGVjayBpZiBzdXNwZW5kIC8gcmVzdW1lIGN5Y2xlcyB3ZXJlIHBh
cnQgb2YgdGhlIHRlc3RzDQpiZWluZyBjb25kdWN0ZWQuDQo=
