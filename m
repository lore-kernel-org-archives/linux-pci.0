Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.56.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793967379;
	b=EiUMpo7iJmiYHJe2sTC+/42WxBFITlmz1RTyzfIPzf0R5q2IroLE/Y5RInxC7A3RKMpY
	 eGVmlj4vSvIXHWIIWqMr6/He/bgh/qrhyZrPbJOEq/t0O5ni/Am7K0EUiKKCGCPdND8ye
	 k6VuSleRrx1v27w3YQRq+ZRPUIGAXeBY/BTOAIOqADHLfl1lqjdiXNKoGIITAbUKHdMWV
	 3YlFK1ae/RJ2iOy4scMKidCuVx+wdlUC8e5JmlHc0nYTJhVYJ/5Bjbxhl/hSPs1bSc0EZ
	 sM3WRfXqSccsMIpNRI9KuemqoKjwLCbyO46Ufdp8uGe4OTSAiJaN29uGY9VB36gATOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967379;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/aXZEI7BuhRcH5Gz0jE1x3VcEZR7ZaInR4MTx8Dwpww=;
	b=ZjZZmIl2eMAvKF0egCQaUkyXX2x+GzUoPLQ8kzrKqVo9Bx3wxZ3VPstlRRwTLgZtMUgo
	 AVAISwM2T78LBvVgPYMZMlWCEz7VKdozxvXIDMQOOtIyJ5aPGJG/5ulA4mgEj0A7JhUHv
	 49SpFIVIetJp612dSmKOtYqlCQmzyoTKDWNZEHPZo74MV3WQ7z29eGj9NzxhwqWLVTXQf
	 ofrhPI30CaLps+He+in+Iz3tG2V6D7vGjSBApjntFGPq7ftfwLTXXTq7dBdDx+1J0jj/m
	 +RPmOpabZRptDMWaRtFAdEuscv8eT3ApYtnCNo9NSGYnRE0uLqGlWYqdRI6j1NNnnPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b1QrjAgj;
	arc=fail smtp.remote-ip=52.101.56.31
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F56606A329;
	Fri,  6 Nov 2026 12:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F56606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b1QrjAgj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnL9DKJWyKbxQRoqaG0wRT5XN2L6cVg4JmpkX6MasMUr2IErC8ubr7sV3e3rHLykrqF+PhjxmmsNKr2NZPD6rKgweTLcaZgeda+dLjifKAvxvM6eW9ceJagE5t+igaAOU6uSplWIRTCkpZpzdURi8VkklHwJ1CVidMSKGcxIYu1TyHCbNxbMI7E5l6SMknodzNAU9DtZlGLhdCYPVsAgl1nrpvxR9j6GdQWVmCtgOmFqgL/lppoPPEBlqG39tw8imWft07L64b8CcM9QkwW6zSoGba3Gt16v3orsPut1HonIJOSqA5sqXBAnmgxRQ5r3oXCg13mAMpUsf6djvQ++3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aXZEI7BuhRcH5Gz0jE1x3VcEZR7ZaInR4MTx8Dwpww=;
 b=DPQ9d723secTIhRD34IWd76LravYqXPx3XgMNT33P1bCxcQOAdv5t+vuxpB8JAkr6YCf7/J7Wosc0qsxpGZ02RX8E/yTTUAcz2aNYwARp7Q+OEQJU3bP817q4kLILm73zAkr6+9mQvYUd/JgvCHZ56YrRfTIIp7OV/atw0Vn18QPOIaGxFfjssVhJx0uLCQONO543Fzh7em9/7khAOZ4C+4Ck/2KEQ/tc01OQrqGnuTOL9SmuO4wcgmz/4PM517VlgR85GTaRat3qGp/XGp980isHC3gvovLYO/+YUIz7gGRwyMVRylkh01cyR2z4jzD2OgapyjDlnamQOCRPNtlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aXZEI7BuhRcH5Gz0jE1x3VcEZR7ZaInR4MTx8Dwpww=;
 b=b1QrjAgjZyCSaNG5MeeXsolWDyBdk9hc62YylCWocKbWMgSy57qErQhjKlBTsWmC0wu6KkOHUWciqQMn1S0d7uNo72yTBqOIbjnlj9PHJuo3AnbCzBrCrG+mmQGKJdsaqkaqHr+2jmh+7fLETAiuyaaWohgR5uDWdcKxy/kbFV16mNNz7OWy23cZgklig7VM92js0C4jI3wCBrMwXVXnjshLMfu5graeJ32P75RjR2teOWd4a1pKSz0d+G55XU9WkP5OeTYhPlkSw1UJMKru+pKlJB+F78gxiXRFHJ8be89r248HQpvvwUS3LwAnemBo+nHU5d4EK9zOD0E6RQIXNg==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by PH8PR12MB7109.namprd12.prod.outlook.com
 (2603:10b6:510:22f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 12:16:14 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 12:16:14 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Richard Cheng <icheng@nvidia.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jic23@kernel.org"
	<jic23@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"aik@amd.com" <aik@amd.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "terry.bowman@amd.com" <terry.bowman@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "brads@mainlining.org"
	<brads@mainlining.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"rrichter@amd.com" <rrichter@amd.com>, "gourry@gourry.net"
	<gourry@gourry.net>
Subject: Re: [RFC PATCH v2 3/5] PCI/TSM: Derive the coherent-range IPA from
 CXL
Thread-Topic: [RFC PATCH v2 3/5] PCI/TSM: Derive the coherent-range IPA from
 CXL
Thread-Index: AQHdbTp5Kg+4eVi9K0++/+gYyidN1Lcg0o2AgAAiFzQ=
Date: Fri, 6 Nov 2026 12:16:13 +0000
Message-ID:
 <SAWPR12MB999267C601F3B004A274DE4A72B0762@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261105152909.53452-1-ankita@nvidia.com>
 <20261105152909.53452-4-ankita@nvidia.com> <au2j8EmUZmyeNs1h@MWDK4CY14F>
In-Reply-To: <au2j8EmUZmyeNs1h@MWDK4CY14F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|PH8PR12MB7109:EE_
x-ms-office365-filtering-correlation-id: 1ac8d5f5-4751-407b-e2ef-08df3bffc066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|38070700021|261026140227099003|11063799006|56012099006|261026121527099003|4143699003|261022105027099003|261022075727099003|261028144727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ZM9516FGe/1BbI/xZ1Zwd+r++S8VEqILhg7+Z5CPBwPRuTSgv2W9DIxYS1Q08HbHl92is7VzGLuOME4Z/Dv36Zqz64GW5jsjCHjt2kj62ONAL6nN2b0m4H/sgFniTk/rjAGwjlM1IW9KSc0Rzf8p5JWTAHb/Sp4QoZmHWHS3NC0x6rPM1pgnKbuc+L4TZ9zU0nU69UjvedfOkuHsOBID+hLxNnFwZhQh06kZsNlSFIc8F+Df6EIR+Ft+whNPyMsrA+eSQD8ok2OC5sd7MjDBiPK2WmJf4bTnY7sc/0UhDiMmeQfLcE2BebyD3OuN17vQ3nqzZu0pnMTP8G9ZNK1p7XL3rcd90VylyD9ah0S3O4PS4L0kPiknP0FPzvcKNKXpJq0+kNQWa3SNqM67ltGPvCsp4w6gG+KraJXlWifpN9i4obXcmmVZN4aKRDzZmEao2u24tJgA+7vRztU7mPLjtVPPqHw+kV+JOlJYzSq6wN2qRF9k+dOjzBumNG+aG0ftcqi4Kcs+knVwtiCD4iTuCdsxIY0m/HUgy50bUqqNUbo9MpRy3XPxZqCUeG0E8f7vPYGbJflvgDTfudsQ7NqPkjwob7MgDnfeXssLU33V1Neng9awmuvQ0Q66GtHjPN4jtpY99tjAY4g46ijcvDCmj5/jroDFAdTAGTaYfV88HU9xZdT7qKVxOxTV3uSefmd+uRQDNMPkdQNTA2x/turwlf5OvTNvm7zOAbBjpNWsj2U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(38070700021)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(4143699003)(261022105027099003)(261022075727099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aGRQrZOeaLz2NeKPRfzknK3m2lF287itxe9lebfXfHV1RkKOxaSWGmoLJX?=
 =?iso-8859-1?Q?ginHGF/aZkk39/z10hkY9HAGLZZ4AJyp4qepYfzWyvxg81fhqlbbPdLOZ0?=
 =?iso-8859-1?Q?w19krm0alimBkfL+/4G90PFmQlhm9rPRMpnQZmEGHJA7JgJ9ZIkCQ+lGjh?=
 =?iso-8859-1?Q?JWtEWADVWM8p/v78/2x7Dpc6FVZaUtdvMuaCkj+r1YNecLHmvo0telpmL6?=
 =?iso-8859-1?Q?x0ctcfIYjNcDxNILB25aU4+H0IvX/NrYCEVzzWEkbmPz4MStmG6y+/k8jT?=
 =?iso-8859-1?Q?Kil2Tm9QySkv3Ofnos2k/gkkws3OoiROHB0+Cxy/4ZuYsJ49FoC8F5jSak?=
 =?iso-8859-1?Q?DOf/YArAkV0hTqNM2xiANdinkFlIopwEzPxyq2ObdIpNVdHN16LWLP21GS?=
 =?iso-8859-1?Q?2PX2HMQIf51vRs5l/RlDfUSvIlTXs0hVwkhhlYUfGAVc7x1QHgWKaHwS6s?=
 =?iso-8859-1?Q?2u6o9lX0FfX2nXRMF8mQbR56xwaHfo8JIfDZSjI2QUqbUbelt8xV1jgyMv?=
 =?iso-8859-1?Q?37LiGK520c8SUgY5HvZ6bj9LAF9UxmbN6DMrZ6E/SbYBasjj/mBhwYXBjv?=
 =?iso-8859-1?Q?geS4MyzZc0c8W015yIdO04OWi6eoi0rx+0HgD3gCvkFSwo70wgNnzbKe8M?=
 =?iso-8859-1?Q?qp3hXFFyFqVtDhPixpNpVOgxkxSw+i8y0n7NcNtgTyZJOCeH5IBONc5Xmi?=
 =?iso-8859-1?Q?u6ooMDKJ1qogtxjWipaFRKmm+MtSsskHrWqArkUp7R733TBVsSTA34HpKP?=
 =?iso-8859-1?Q?wHwx26nM/xtv3VRwEj/TFuyzE4zvUmbOp8FaPLc0elbmOqlJKedpUEDPpG?=
 =?iso-8859-1?Q?NzKHbjAVqH64gj3NzjDy5gnRGn0jbgUoxA9pUcKuIJCLfF2ya/7G+KZZlF?=
 =?iso-8859-1?Q?7hQq6nJblp3178C5yfEGlRqQSUeW+PGTrhY/On/0z+R2L9clnvceXItSLa?=
 =?iso-8859-1?Q?MUU4WiwjJFTOdC1CuVhbOLlZCoiX2hd/ZV4Gembg8+zDV0dHnnRBeyPGzl?=
 =?iso-8859-1?Q?TGMnWmFAh91Sw35pB/tr4ZsQYGsAGtQWuPhaNiZArAmF9+LVSlXPq/xSLY?=
 =?iso-8859-1?Q?KajQM00zx84fQQ9CyoQDUYHpKkJnZF0L6vUWZ+bJVUEsF2UaYWFH3NRwEt?=
 =?iso-8859-1?Q?XyYuLkyQ4qoujNw7NXLirHW4fmLbWOrNOOi83AlN6aO6DZ8ATtJBdKfPrh?=
 =?iso-8859-1?Q?EcqgUkYHouhFwq2ruGn1bm+0A0QBx+pHOPHdnteY45dExpWM3/E2ggltuQ?=
 =?iso-8859-1?Q?D1qgbRnaIA3Tymz4Ke72D9x5GM0MOXzgyBpdd2UemK+Ng9ghLclzUJZGUv?=
 =?iso-8859-1?Q?jwu875vYGYFxo0FqSgE/PGqN3r2kl+FUN+b4ziQAFDU4SQOS6+SgPCeM2d?=
 =?iso-8859-1?Q?MdrVOgtwJ9Qc0YeClxZ3WsaLvuae6lsyw307At/gFXEkWHbHnJpSpG5uSV?=
 =?iso-8859-1?Q?elgtu31PcEEfRWhnvAqYBBFTWy+U6oNw1fcR3vzXztx7q5DDfNqvLQSqac?=
 =?iso-8859-1?Q?o9f/rcxoBfysrT0y70EoPrlAYLvUL3AkqGPhfa0tzmaiahYzamV2K5XKtI?=
 =?iso-8859-1?Q?6nXml3dh4uIkXlF98qr9mBY5/jVK7MyhXW2EF24+EiFzJrys+bVpcZoAK2?=
 =?iso-8859-1?Q?ISoVMYGlPOpnmPw6cIcTAoIuw/NJGZ9Kia7okYu8+7FpH8+/C8e6RRWXps?=
 =?iso-8859-1?Q?oTwc8Y7NELjf1wccvkeFNpx1lP//ueDTQkyb3TfAAlOQaEPb/bt+XodkRA?=
 =?iso-8859-1?Q?rfwwhSU3yoijXPSOgaK2KwpwYHR7PSFLHCkbcrVFr6WYUC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac8d5f5-4751-407b-e2ef-08df3bffc066
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 12:16:13.9534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0aSvKDAsLVxAxAKUaXUieAnCdX6Yd+vHF6TPIbRmELLLU/VdvCX0tdUnNlu9EKrv+0MCmsHI0Ro4Z/aKef29A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

>> +=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reporting_=
bar_base =3D tsm_offset &=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ~((u64)range_len(&wi=
ndow) - 1);=0A=
>=0A=
> Hi Ankit,=0A=
> =0A=
> HDM decoder window can have non-power-of-2 sizes, why do we assume a powe=
r-of-2 size for=0A=
> coherent window?=0A=
=0A=
Hi Richard, yeah the region base calculation needs to be updated=0A=
to correctly determine the CXL region base for the=0A=
non-powerof2 sizes.=0A=
=0A=
> E.g. if we have something like the following=0A=
> Window start: 4GB=0A=
> Window size: 768 MB=0A=
> Reported address: 4GB + 256 MB=0A=
>=0A=
> Assume MMIO_REPORTING_OFFSET is 0, so no address obfuscation needs to be =
removed.=0A=
> The reported page is simply 256 MB into the window.=0A=
>=0A=
> For this size, the mask leaves the reported address unchanged.=0A=
>=0A=
> 0x110000000 & ~(0x30000000 - 1) =3D 0x110000000=0A=
>=0A=
> reporting_bar_base becomes 4GB + 256 MB, rather than actual window base o=
f 4 GB, so=0A=
> range_off is 0.=0A=
>=0A=
> The fianl address will be window.start + range_off =3D 4GB + 0=0A=
>=0A=
> A KUnit test against your patch series can reproduce this.=0A=
> Furthermore, pci_tsm_mmio_setup() accepts the wrong result, because the i=
ncorrect address=0A=
> is still insdie the window.=0A=
>=0A=
> Best regards,=0A=
> Richard Cheng.=0A=
