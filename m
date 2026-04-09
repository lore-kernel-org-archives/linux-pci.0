Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6562E8B82;
	Thu,  9 Apr 2026 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719010; cv=fail; b=GGPvCyAq1tSoHCNIvwXRIuKPtfFFU3y42CWokxzSa9hpt62wDcYdxwvpbrua7NgemMbOk4fEui08GmrPtra6VsF2IUNrV3iBfHUqATpBMtMaL+EooKCu97vOsROIdV42eGLvpxurdIR0u6xtqEUZ90SNiXOHgXBDS9WFbwsLx20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719010; c=relaxed/simple;
	bh=MJJJTJXKqPkd0rDM/jO04lwRv34n0uBTznvCIBotrkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JcdhggWuS8NxF6vNOM6DPZA5/lukNiv5ljNPjCpY++C+0OqTzoQ/NpQgX5/50xDdXxdQQspx/hbr+id+6yxvqqj1wh91as76eOJjtrvT9asOU6973sLwrk/sqdAhB0JElPzT9NUe46E9KlnpCWlhu6kNSORpsCsUrA2zsVj7HDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjuY3maJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjuY3maJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775719009; x=1807255009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MJJJTJXKqPkd0rDM/jO04lwRv34n0uBTznvCIBotrkA=;
  b=ZjuY3maJat1P6D1YlheHmZ77KSiv4BZdR0w40lrKlwrWaeD0BbCXcSnW
   fl0uK6qP+yxyDBDcaqvVyK/CgLwvt9x54NpiGMec2zpsaPQFU8LfrIvlD
   HXv2t9Ntwec3YX9TG0ZTC3tFWRTnuGQ28C1wT4rXaC97bYRGH1sBwLHNN
   XIertHjit6QSP108XxDCv0VKUIoadvEgIFDPrHIYr7LjhPvIsaKc2x9vw
   x3Z1HDremOBIVnQ4mYj3WlQCwIXbwTVdhHtQo79ve3eI44gJAsQ2QDf7K
   JXkYuv9nxtBEMShTGpgtL/70dLm5fiGNQczXrSDMmVCnvRPx7Umnhjlor
   Q==;
X-CSE-ConnectionGUID: 19Ln6VtfQYivd20PXMekPA==
X-CSE-MsgGUID: wfHIvxziRVWusiISJHbnXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76594733"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76594733"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:16:49 -0700
X-CSE-ConnectionGUID: 9U1mtOdYSxuqhPOgDXyNDQ==
X-CSE-MsgGUID: U1MZ4zbRReyh2kF3AWboEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227834492"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:16:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:16:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:16:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMSoM2i3Mx17/OixdoS1XV53DraClfjNFcChf91GeJ44M/2UH8jmkX2g2Ma+pOaikR8xHcHNgFckI5LPA2mevCnMc/3S90gAhZ8RymV6PwD97/1Uw2dKCMZoUVPHeMNEYDuFpGHiIbf52bUUUma5QQeDMx2ZIAOXtYDybOuCznl5Y3YvMRFBz2b0KAz/zMN1UE3c7yuTotqr3j/fWA3W58S/R2SFao5FdBMbbNextyWcET2UBqUuP0MS21XOpOU9eCviMox03uGRh4VcdPYR8Yyt2D07TxacLy4WRji31HYJ3hKQhw7cT0l5F9HHRmKl5bE/yMM+/3JKVF4sb/Gfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJJJTJXKqPkd0rDM/jO04lwRv34n0uBTznvCIBotrkA=;
 b=iMAE8pLz61rBCtrt2/UxeAQ6kfl7jkEz1BehvRywd5EmDc9c8BUV5tqx05oKDqUeiW+UHdvjBF/URxOkfFZ07f5dI1E5ZaukNRjGaNEyglViuGfTMQavWTY14WJMNGxN1KWmnfcIWThjJQRQLZXCbX2nPPxiwRtMwUhTv4g2HdIOd1xb9t1uJf3gwpmJx0VZ1W0byMFPCb8gmUec/ceLScKZ1FerbKRZ208DHo6t//fMsl/dVBnveZGvwn+WhLn3WajdWc2KsOMyLfKOe85KxPqTpTi1/4s1V9uYCm8ZEmiI9t8wbhMsjtiKAfvQofUH7Y/+HzR+hs2jUc6ojnVufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ5PPF6E07EBAE7.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::832) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 9 Apr
 2026 07:16:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 07:16:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
Thread-Topic: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
Thread-Index: AQHcvgd9ANJRNCVJcUiufPiQQD4iRbXWYsNw
Date: Thu, 9 Apr 2026 07:16:44 +0000
Message-ID: <BN9PR11MB52767F28E9FF692ACE69F3D78C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-20-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-20-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ5PPF6E07EBAE7:EE_
x-ms-office365-filtering-correlation-id: a08b405d-c39c-42e2-53e7-08de9607f47c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: tgy7hKGbz/YCU5Wqdif56DMaOWVynyT70maqckS9LCN9lbcpy5oz+bM8FLlnqgR/LlBfr1av0LR863nE6LETYCOQ9hgYdd1+t0xzj4oW65L96ozTZVduKJ/ukhB3mDI8p+RHc/bIIpHuTK9MeHybwliJCruTc4CzxnDYInOiXxOlqrMIaZO1f99OarOG2Y3iiXc191do2+8IAipxi27i65hfRfHe3xFCPfcGCeqjbovUGyjvhNtGN2FnOj0nUHlPhivAyXUzBv2QB4Yjp5ePECpVIeKVImg7IZoKnv/tqIflrIPt0peGqA5JtoYwxmqG6dOL7MzwHXpafGMuyhj3pos4/6MF6AEQJkno11GDj7QeuG59v1oX79ka+1CrLHJ6zU8nK4kxuDBkw0aS3eDZa3j0P8HH01i2VIz50MhLd+RJ7kZzSuuHa0GtpQcnNsjPW5e+pZtgIirUd7we9ikuvs+JUTn6mxGJ1RAbCTwVjwO48ObaAH+eJcx2bHAUPSaF4/iIUTMxz3f1eonETEqoWJZqmPbjW7ufMORyirmTVw7vD1J0mVqgRLHg4X9Vs8Rdw8Hmv2KMMlgQZefnhb3YH9ScML9hiiUSq8yC8aPpq/ej4sxREXU/dMCtket9Lz7BHstsyeX8hev+/O/yaxPGwd6R2bwcuUwh5dEf6z0Lq6UlZn0GOg/dUaswfG7J2WPwN4XNsTexDwwYhP1Wu8/bBospecahwPg24wCouODdZqgJNYnbTFtUOwGa8oNjdmNxinFUM+ngj6yBwVaFW/SDu5MlYfqpjzWfRr1yeQyO3MA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um81Y3RZMzRCVUJHZkhlVmpFeFhvNXlWN2RIVjJBanBZK2twbEVLZ3hKMWVk?=
 =?utf-8?B?TmZpSlpPZjZ4akw3azNhd2Z2QnEvdDdRT1kvUnE3dWdNQzhZZHpLaTdsdzdR?=
 =?utf-8?B?bUdnOCtocFE1YlpoWVU1L2pYM3BSSVpWSEFuWGFoa0gvNUNRMVhrMGVBMzZ0?=
 =?utf-8?B?Q0pOQ0lmaENyRWg0aEp4Tjl3bzBDVU0zNld4T1lHcWtpdEdNSEc1VlhicWhV?=
 =?utf-8?B?OExINlhnQm1PZjhmTml3RCtRb0ovbEpmcXp0SnhtN29GMkhJbUsvS3ZmWHpn?=
 =?utf-8?B?MlMvNjdlVXVDZWVDc2gxSll3VTlmb09yMUU4ajhnUGJnZWxmNzRWdi9WVHJz?=
 =?utf-8?B?UnZvWng1NHV5aXl3TnNldmV0MUtKdEw4bWdacHo1bFRwa1FxRFE1dzBCcjhX?=
 =?utf-8?B?dXdGYUpnc3NCY2dTcitCclpmOGp0bERaclZYc25FL1pkeUlPS2RVcDVlSHd1?=
 =?utf-8?B?YVFxVmkwVzJMUUI2ZmY1cWNDSlcxRnlheHl5cWthUGV6ZFhoUEh5eVpNWVp4?=
 =?utf-8?B?aHp5WWFPNUh4U3dmNlEvN3VMTG5IUW90Sm82VlB1S09ydFNsQm5mQVRudVJB?=
 =?utf-8?B?a2QwUHdOcHVYK08yTE0ya1FsSlBLcEtaM1pFcUR1eGU5Q004aXNIbDNiWmtv?=
 =?utf-8?B?VUllaXhkalBoOEVyM1RaNlNhdmlQMzZMSnZ2VHFCQU13SWlEQ0xCMy9BNnIw?=
 =?utf-8?B?UVM1ZStVd0pJR1JKZ3hYWDE3cXVVa2h6U3p6QmdQR0kySnlzUCtEblhVb3Mx?=
 =?utf-8?B?ZXVIeHNDNEpHdlAvWE42dWRvL3dsSmVmQTVqSFBGdDZEcW4yR3lucjYvWStm?=
 =?utf-8?B?dFJHR0ExU3Q4L2lBU2hHalI3elJaSjNQdmFPb01OK0VmOU9rVWIyZ2lRUXpC?=
 =?utf-8?B?OXc4WG13UG56Um1UMlQzRmtncXBHRkQ1OWF3TU4yRjJCN3ErTlRNYldxQ1NP?=
 =?utf-8?B?cjRlSE5lMHJWUUlsU3F4TFpyMG96b0xEdThzTnJ5eDNsMVdOaWZ6U3ROU2Jz?=
 =?utf-8?B?dWxKa3ZBT3hUQXpNRnRDUGdOMEFLam9NaGdIUzNIVXN3MTk4NkViYk9YcWda?=
 =?utf-8?B?bTd2TU9BSUlUa1UzblNYWmhQY3Bhalo2aXpjbUFMY05Nc0p1NmZKWTlmeU01?=
 =?utf-8?B?V0prS1FlRVNqT2EybHR0YUh5ck9jaTk5a3MvMVp0dWtRb1ZYR0lZVVRBZ29C?=
 =?utf-8?B?MzI0Z2JjNjQxUjNpVEo0aXJTQUo0blBTd3hrbzZZY2xiN0VLcVBPSzl5TzNK?=
 =?utf-8?B?ZEJtejVtMzFzcGZ0eGZDWmFLaXNEbGU2QzlpRkN2OVpGZUMwTklnNjM2K1B1?=
 =?utf-8?B?UVZMalJJRmxmQUlCQTVjN0dSNW44b3htN3VIYk9iSzR4dnc2WmRSUGlDZnYx?=
 =?utf-8?B?aG5wRTJ5WTZUcDcrYjJNN3RncDZVc3hwY2l5a1h1QlVmcHgzM3NYdkMvN25v?=
 =?utf-8?B?MG9OWHo5UENCR0lvTUN1ZmhLK1RyU3gzMzVSc25GdFNDK1VITXYxTERiUWov?=
 =?utf-8?B?L0ltS2dDQ0hYdzJma1VZTzZEN3lxWmU3d25CeW1QanlWOGFYRXNLbFRMUnV0?=
 =?utf-8?B?Mm5DaUpUQWp6NkU1Z095cUVEc3Q3Qm5FaXltZ3owaXNFT25ZYlBkTW9FMGtv?=
 =?utf-8?B?VFNNMHBRdnMvYXJHeTdxZjlaaVN0OXo3RmFOZnFIY0diTitvK2szOHlmeXQw?=
 =?utf-8?B?Z0xZL1hHNkZQMVA1OXhGK2ZxQW5yV1VuZHc3Z2w5cjBSVzBqZWt6YVFUN0Fo?=
 =?utf-8?B?MERzVXFxVHJvbFY2VFF6OS8wOVI2TEZjR0dRTU9Pak5ZaVQ2bC9QcWFYVkRZ?=
 =?utf-8?B?QnhWVHd4K3lQRFNWdCsrQUZSOW1QamVCRlhXVG84K2FjVXNkcHlnSTRJcCts?=
 =?utf-8?B?M2Q5bFFncEcwUGNLU1pWOXhRTDhnVWVxckNEb3I5VmJpQm5yakhlSno4VXpa?=
 =?utf-8?B?azR6Wkhzc3ptSDdPcmI4amEzQ1Y2OWs1NW5wdzUwTG5xRzRNS0drQnlEcWk2?=
 =?utf-8?B?V0IrTTJ1aUMvNkxRLzduM0R4OEdFeGxOcldHRjFDMDBHcm5kVkplV2J3WFU0?=
 =?utf-8?B?WkdZUjNWOWJFVEttanVCeml0UjNHdHdjYzhzRjVIaC9ibUUxMXFYSE12SGVF?=
 =?utf-8?B?Q1lWbWpoSTYvN050RlpkYkZ3YlJPZVVlSXUxbWNzdGx2WkFxWkwxMG8yemcx?=
 =?utf-8?B?TTkvWUFDUWdqVzFqK0JuOGk2SUttQjREYmpDWDJRZWpRQ2dNakhEamdJMGoz?=
 =?utf-8?B?L2JtMFVzSGhiNy9YaTZ4OVRhTEtabGZqMVVjbDYzLzE5Mk96RW9Wb2ZuKzFS?=
 =?utf-8?Q?hmYWZXlCcDJluNNMQ9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fo/SpzqR94PhpWsFxoZRF0PcZqQbPtrv2Pw3qo3c/QRlRdHgqRR3vsmidDZ4kvJLcu1HsQvOaY8sRlckMis3qag0inqWRnCxBnVjOTg1ZPE+Uv686sp63fGg+WuMadf0wEFKYw6lTjpUH131mOWaDTCATg1NxAuvdakQP8leH01Vg2nyDIHCCEp9U/1e5+XxhbreSF7yXY1DUTSETfcZgJRZtWb2f/m8FMnUexZai8yVGvW8vzFaaEzB39ohvRN7nnxmoX96OGVzijyQR5aCla5XuRyHTGMrV+OmhLD/WaOOrMF2IjffgOdJ9DZGtzWkGmeavriA0fOoGE0WsJN7jw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08b405d-c39c-42e2-53e7-08de9607f47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 07:16:44.3309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //D/pQUq/9xfczKR1/Nv65UrKlxQxLhzqnZHuebmOVpfcdO3aP+R6iqbftuG2MCygCHRLUVreH41cx7I02gMrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6E07EBAE7
X-OriginatorOrg: intel.com

PiBGcm9tOiBYdSBZaWx1biA8eWlsdW4ueHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgTWFyY2ggMjgsIDIwMjYgMTI6MDEgQU0NCj4gDQo+ICsNCj4gK3N0YXRpYyBib29sIHBs
YXRmb3JtX2lzX3RkeGNfZW5oYW5jZWQodm9pZCkNCg0KcGxhdGZvcm1fc3VwcG9ydF90ZHhjKCkN
Cg0KPiArew0KPiArCXN0YXRpYyBpbnQgdHZtX3VzYWJsZSA9IC0xOw0KPiArCWludCByZXQ7DQo+
ICsNCj4gKwkvKiBvbmx5IG5lZWQgdG8gcGFyc2Ugb25jZSAqLw0KPiArCWlmICh0dm1fdXNhYmxl
ICE9IC0xKQ0KPiArCQlyZXR1cm4gISF0dm1fdXNhYmxlOw0KPiArDQo+ICsJdHZtX3VzYWJsZSA9
IDA7DQo+ICsJcmV0ID0gYWNwaV90YWJsZV9wYXJzZV9rZXlwKEFDUElfS0VZUF9UWVBFX0NPTkZJ
R19VTklULA0KPiArCQkJCSAgICBrZXlwX2NvbmZpZ191bml0X3R2bV91c2FibGUsDQo+ICZ0dm1f
dXNhYmxlKTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJdHZtX3VzYWJsZSA9IDA7DQoNCnRoaXMg
aXMgdXNlbGVzcy4gdHZtX3VzYWJsZSBpcyBhbHJlYWR5IHNldCB0byAnMCcgYmVmb3JlIHRoZSBm
dW5jdGlvbiBjYWxsLg0KDQo+ICsNCj4gKwlyZXR1cm4gISF0dm1fdXNhYmxlOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBpb21tdV9tYXhfZG9tYWluX2lkKHN0cnVjdCBpbnRl
bF9pb21tdSAqaW9tbXUpDQo+ICt7DQo+ICsJdW5zaWduZWQgbG9uZyBuZG9tcyA9IGNhcF9uZG9t
cyhpb21tdS0+Y2FwKTsNCj4gKw0KPiArCS8qDQo+ICsJICogSW50ZWwgVERYIENvbm5lY3QgQXJj
aGl0ZWN0dXJlIFNwZWNpZmljYXRpb24sIFNlY3Rpb24gMi4yIFRydXN0ZWQNCj4gRE1BDQo+ICsJ
ICoNCj4gKwkgKiBXaGVuIElPTU1VIGlzIGVuYWJsZWQgdG8gc3VwcG9ydCBURFggQ29ubmVjdCwg
dGhlIElPTU1VDQo+IHJlc3RyaWN0cw0KPiArCSAqIHRoZSBWTU3igJlzIERJRCBzZXR0aW5nLCBy
ZXNlcnZpbmcgdGhlIE1TQiBiaXQgZm9yIHRoZSBURFggbW9kdWxlLg0KPiBUaGUNCj4gKwkgKiBU
RFggbW9kdWxlIGFsd2F5cyBzZXRzIHRoaXMgcmVzZXJ2ZWQgYml0IG9uIHRoZSB0cnVzdGVkIERN
QSB0YWJsZS4NCj4gKwkgKi8NCj4gKwlpZiAoZWNhcF90ZHhjKGlvbW11LT5lY2FwKSAmJiBwbGF0
Zm9ybV9pc190ZHhjX2VuaGFuY2VkKCkpIHsNCj4gKwkJcHJfaW5mb19vbmNlKCJNb3N0IFNpZ25p
ZmljYW50IEJpdCBvZiBkb21haW4gSUQNCj4gcmVzZXJ2ZWQuXG4iKTsNCg0KJy4uLiByZXNlcnZl
ZCBmb3IgVERYIENvbm5lY3QnDQoNCj4gKwkJcmV0dXJuIG5kb21zID4+IDE7DQo+ICsJfQ0KPiAr
DQoNCkhlcmUgd2UgbmVlZCBtb3JlIHdvcmRzIHRvIGV4cGxhaW4gdGhlIHN0cmF0ZWd5IGhlcmUu
DQoNClRoZSBjb21tZW50IHNheXMgIldoZW4gSU9NTVUgaXMgKmVuYWJsZWQqLi4uIiwgYnV0IHRo
ZSBjb2RlIGhlcmUNCmp1c3QgY2hlY2tzIHRoZSBzdGF0aWMgY2FwYWJpbGl0eS4gSXQncyBwcm9i
YWJseSBhIGRlc2lnbiBjaG9pY2UgdGhhdCB5b3UNCmRvbid0IHdhbnQgdG8gYWRkIGNvbXBsZXhp
dHkgb24gcmVjeWNsaW5nIERJRHMgd2hlbiBURFggY29ubmVjdA0KaXMgYWN0dWFsbHkgZW5hYmxl
ZCwgYnV0IGl0J3Mgd29ydGggYSBub3RlIGhlcmUuDQoNCmJ0dyBpbiBwYXRjaDIzIGNvbW1pdCBt
c2c6DQoNCiINClRoZXJlIGlzIG5vIGRlZGljYXRlZCB3YXkgdG8gZW51bWVyYXRlIHdoaWNoIElP
TU1VIGRldmljZXMgc3VwcG9ydA0KdHJ1c3RlZCBvcGVyYXRpb25zLiBUaGUgaG9zdCBoYXMgdG8g
Y2FsbCBUREguSU9NTVUuU0VUVVAgb24gYWxsIElPTU1VDQpkZXZpY2VzIGFuZCB0ZWxsIHRoZWly
IHRydXN0ZWQgY2FwYWJpbGl0eSBieSB0aGUgcmV0dXJuIHZhbHVlLg0KIg0KDQp3aGljaCBpbXBs
aWVzIHRoYXQgZWNhcF90ZHhjKCkgYWxvbmUgZG9lc24ndCByZWFsbHkgcmVwb3J0IHRoZSBjYXBh
YmlsaXR5Pw0KDQphbnl3YXkgYWxsIG9mIHRob3NlIG5lZWQgYSBiZXR0ZXIgZXhwbGFuYXRpb24g
aGVyZS4uLg0K
