Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029903;
	b=EPKH4BagavEdkFyUTbgE4R5pwb/FOcOVyGSJwRWTQcYZNX3SrS7KsjrRvQbZtIe/ZC1b
	 cIB68GFPUoKYHgSHfw+lytDa7DZra0FCxa2oK4B4sclvhq/XLBsi3SXdNtVgMSjiunMBc
	 UEAHhhde9U/OLudSBer5wMDTxpaoOWhb9iR9T2dYlaO1/hmzsZtcRVj0tn/szLrXUo3Xh
	 yDFHt7FfW7Nfr19uqsfNKUTtz8TOx59JBGJlmnNeiETXB43/wKyWrvJYUZKBr8IIzUBcF
	 III8XL+Sh5pjtN32wgaMJXQhTYyrvPPLR+eX9W2ou4Bo1wZ25YYwUr6rq8iwiYKGDIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029903;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=gtGFlhPLyBmWmNJl+9YBPAwU+sYCzTZsq/qU+GGh5HY=;
	b=KbHj383uO9xXNAHzqgieqkYXwAuujV7U72wpfJ4dBPo6BaypX3X5ifhpRr8r2JFfUuZT
	 UzNZNTM0EKghn0CgsjgEtCXyyNva4Zaz++ErHqHg9umWvycy+298DVto+usDaCez5Pcnm
	 kdF7W8HhbS2I23mg+hWLF0rRlOk5vIs8SJz/VrYVkdZxBEusO6vxrslMNiTKJV+FgsO7v
	 4s6sK8st/kTXDSDEuZaeyWErqk5Xbg6h/OEsj9V4lMsIe+Nz8SaZqVaFRalQIlS8qcBLO
	 QtU2zT80DqoASYY5yV39kEf0C4y7dS2PfBncffJWHC/1vLGfBR2AHn8x6pT+Q+trbkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ihXqSS9g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5A606A32F;
	Wed, 18 Nov 2026 19:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A5A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ihXqSS9g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ozr+XT8UYdZZuTeRrIqYUxSLg02vc5U8LLoE9Oq5/db4VWPrkFHLiZ+qGVuTwSd/WmrZH2295BSSrh+wFHEmUvxFxst3qeR/eZU2vNw0lo+JiRoBcuArdBndyegtmdkpGrOeaSKyPf0HsEgV8alqfCrDKlYv5/Wm1v3287Yld1pOFjDzkZvUs5B6FohvUYIt92RgUe1hmGHHiIqiHepRloci4p5fDfCsBrx5IZeoG61kAVtb0GtooVJz/g9JhQjwURYMfq8vFxFHOR6/wO5ohX4zyV3ERRNAh18HxmkhVbivbEuvvsLj/fySbnLajUerGtpy6styuX+b6AaBP8xlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtGFlhPLyBmWmNJl+9YBPAwU+sYCzTZsq/qU+GGh5HY=;
 b=Rt+/tjEI/Sx4KptYn1D+j8PCjFM5I4Gk71zR5NmDUcbTIlkoLXhxzvtFNX+v/2SAV2I2Lfu4rZdpR0catmz+WHmR2mmLmZaZYP3mqlZputI84WIJsxVdiVgAwZHfiVZw1Z7ChyXrvt/1Bhh/wkbUwrhkYzwVG52NSCChvaJMYLNXIEv8JkROHxb753xThl8WisBYwAf6VIFDQzVpZdrtZ0yGjcQX3lo+1YraCXrY6Yen92O5GcrtP9VGjQdeG8xT/LDz1eCm5GXpOcxwr/Gr5VnvlrTEt36fO51B9Q/NDUXvDyxE2jNgedfW5wi8Ohoj1NllEi5mFGSpTHjCfoAXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtGFlhPLyBmWmNJl+9YBPAwU+sYCzTZsq/qU+GGh5HY=;
 b=ihXqSS9g49q0/9C7oa61X1rVF5Fn9X5D9RB+l/jmqSKSi2ebVlfQ6GMJCEnPHBjYieYQbDRzIl1iG9cLqWpEuqIwSFQbCF9z+zbWWHwMFIUApdMXelhheYYSxmxDJfnsTKjQmwSap86kgsDclVNZm9f7+Wkm1aXPFMnPixVNKdBmYwhVE9b4S38DRhOe8fJuR96D87tgs7qTv7QoLJFe2wpR80pN1956NKdv2xLthOQtnf0ipycDM+pwpXnopCYIlEIu3p4PPgyit78QE+FPm/CqNhxeOT6vC9tEjzIt9n0pt6BE84NMR6uz+J4slgafp0XTCeAh3t2UAMgLss0AEA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:51 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:51 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v6 05/31] PCI: Refuse bus and slot reset below a CXL port
 with SBR masked
Thread-Topic: [PATCH v6 05/31] PCI: Refuse bus and slot reset below a CXL port
 with SBR masked
Thread-Index: AQHdXYo9vGXFFcs/vE6c0Ds0paz9cbcetEWAgBWqfvA=
Date: Wed, 18 Nov 2026 19:24:43 +0000
Message-ID:
 <IA1PR12MB9030454B9C28C1FA0C596696BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-6-mhonap@nvidia.com>
 <20261104165323.78b45467@shazbot.org>
In-Reply-To: <20261104165323.78b45467@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: ae6d0255-8ae7-48e0-65d8-08df45a99de5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|4143699003|261102130727099003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 CDwYgek+Oruao2WJ/vUz1CH+jJKQ/UmtbpJ24XM0EelMtx9EuLuobWsugxayalGWu8nzzbhZR8q6coF07FywznvVXKCLjOtElZlF4+OmsFBAToE4wTch0C9gQRzxTP6V+n4P3nh1/pcvPjTvJlnw9nP38O7mfEFnIoIERNDA+b/H1D9iNx1wSF05bHfZEwL1s0GEk75Ylc+nC7HJO+AFtThGuyz6qnhVwhKnR0/xqB7rkGAjN5Rqti0eTLCz8ot9NLNGJNOquVtkNt+uWWG0/sLkzwh2g/VpSm90o4YjDg1u1YMCvdKQpbV45SRuonva2xuTFU7CnV6qCcxWXE/n4quFy64+1z8fe3shBKi0SGCv8F5XYQzeJjEQ9hpFMKGfbEYh+9K/5UEhlQ+7EmMoxty/LuFJQKMkQw8pE3hTVxdVOoZ8J3a1V+G8ddJRr6CU30yVh6nb4ISvux6kcBRIzjgkVBXg7Noci/6yQFpxOraDxoJL0Jv6MsSXbpCcq2nubO1V3pWyddgJZuQgOIiG990J73SU5WW+dAKr+B10Vmyl2jlCqM11lRF7zsN85QS+5C0wecVSLHYcr6Zq60MHBu9n5/6RPztbvYhMPOcX387UBIRUAs5IR4tRzp2rpRPXZbIEMZri4moWfDtpWOiwNLOxI08UReMuPfZVTznMw31bZJTjm9PE2AGpb4CxLk4Ehs4LM4jbG4Pk/Q694HBAjjYGzeE6lIzGdL5BOHc+Be4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(4143699003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7+YV9MP+B23MkM95+m8GyIf58qlnceVM5vIhzPYCKcQedrYeZKvvae8X+mZz?=
 =?us-ascii?Q?/YxOW8ocjisZEfulcJae6U7FEHtZvUuKLaChdvLBBj7xpgOjosdX5K7ZKr2a?=
 =?us-ascii?Q?qQioWaGKmda6hbgWVKhcLIksXKbsG1ZeG/bEvdznbjD9eh9ebtzXPbcm3R3e?=
 =?us-ascii?Q?OdiggisNFSaHrrm2zMkqJmn/ADsd+13JluEOndCs+4QoVEhBOsMbZxdxDeiu?=
 =?us-ascii?Q?JeYaAj4kiHw1BdBPbwFUi9RGDWvtcuCXhikHXJUdnGu8pAjb6xvmIGw4UF6p?=
 =?us-ascii?Q?MttjFgQWZFCqkdv4+pFW+veF4d9fOkNGUyW6l4HzrXIS5eltfPatq/7l6ebo?=
 =?us-ascii?Q?v+rBb41eZtIDCTd3/bzp1z4JfjuPmpc6dkjFmDoLwP8bExPtCjwv/UPTDc05?=
 =?us-ascii?Q?scYdnEowxg+eoudyFqLFPpoKdvfZHIa4UjvVgSajDDeVbf37aJEMRmCo/diM?=
 =?us-ascii?Q?K/inwjnJmcDK0BQP6eO2SchBvJ5yBJMl49Yo5eDdokLh0vCcaSkD9QhbsV7j?=
 =?us-ascii?Q?fw8kutECDLp7VPk1Mr7815yvR+KEBGCZDZ9pE/UEHgXEweImV3M+KGi0RoN5?=
 =?us-ascii?Q?A/JzCqlQZXvLCj1iagljoBEXXNO5JLl++bWFkxoSbcprgKCPLrKQe+GMxupg?=
 =?us-ascii?Q?yorvJK5yIB5jLdN6rUthhBa5ZrP6oE9FL+wKYkh/XYYYtsOnXQl3kZwfoKyb?=
 =?us-ascii?Q?zLh4O5ZFf/2UuLGXgF4Umh2bG2BiI/1nI9VNhjAIis/AA8ztUwWQAKtkYLpA?=
 =?us-ascii?Q?IrLWp4CK4HJRJ7/JEhgbQfWYVp2dFMibFCthpv6XlrL23DCOfp+QmlO1CPi8?=
 =?us-ascii?Q?lGq3EJpdrlWAa6+3qjnm+QpUz82juENdiiKEM0SWeP2SY85akdbGx3A/bKoh?=
 =?us-ascii?Q?ZJI1YU0P5a8o+zR3TCrPGYIaR5L2q9HNAfmaK5VrRd+84EqmmJMzrAKYgkI1?=
 =?us-ascii?Q?+IIkkgAohU3YM+osZMTo1tSYDGapT5z30UQXWpxq08k5lIcnljbLWuHk14aI?=
 =?us-ascii?Q?yxhpjkin7OWEIUcmHt61h0aHaa9gxc1/7GZPHGd7b9Aw0RWmeV/50E9a3gjr?=
 =?us-ascii?Q?jIVjPeTeJzd/h5rqrxLHMuD2k3UBhacVC4XVSbHpqsurUDM1C7gZfBym8KJx?=
 =?us-ascii?Q?eEihDbYAXd9MlmNZM0DyV77tQzKDTDgT1HW/LSVpiP1XDMTST9hMOz2z8wNv?=
 =?us-ascii?Q?5Btbx9AvoL2bTqpSZzOqCDaoAGFozWJYOV+WrqdCuNMbEDtER7NWTfXAROV1?=
 =?us-ascii?Q?u6325UuexcBftlZK20+cohyvgGUdB/bckghFfjhEPccxBcOwVoqoYYYmbEdR?=
 =?us-ascii?Q?/a0SG3VZCIvaJ4KqC4v3b6vOflvrcObWgKzcN61NOw3Mpt0Dt6maUkP1fimr?=
 =?us-ascii?Q?l9OIAigPe/9mztuQHW2g7CgxyGYecu0lH2zk9KQbuSGvJQ7UIj6RH6+Kw7xA?=
 =?us-ascii?Q?iHgo8uRaDvTXKl1gRNXRs9W/tPOfOoBHqtUB/MpjlJtBRLe0dI2Zyu/wUjNj?=
 =?us-ascii?Q?ltDOP5RoYyZQtAumZwkFez+rzsqFw9Z4w0FFvBdjBcbAVKp7LPvHa+YObgns?=
 =?us-ascii?Q?eiBILq6AR8/WX/+FCD8fHAUj71wOBOGODb4f5jK7QixZtaUvuKMB4/Qk5fUQ?=
 =?us-ascii?Q?FYj796PnTc/97If3w76SfrGwSFHVunzGzlKHDbgnxzPDUSR/MtBKjfSizUI+?=
 =?us-ascii?Q?nOfocYrSgC0tPVT6+SAqN9CNAE90JmDslJjQrFYRK1Okm8rc?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6d0255-8ae7-48e0-65d8-08df45a99de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:43.5673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcRTZJnJDz9yiJ/lAvBwjN3b4yoqmcd/i6j2U4CA2nGsJPr6QKd0oe7MbTVL+kG1Axlopy+0COF2MglF4Bmg0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Thursday, November 5, 2026 5:23 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan Madhavan
> <smadhavan@nvidia.com>; corbet@lwn.net; skhan@linuxfoundation.org;
> dave@stgolabs.net; alison.schofield@intel.com; vishal.l.verma@intel.com;
> iweiny@kernel.org; ming.li@zohomail.com; Yishai Hadas
> <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v6 05/31] PCI: Refuse bus and slot reset below a CXL =
port
> with SBR masked
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:12 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL port ignores the Secondary Bus Reset bit in Bridge Control
> > unless Unmask SBR is set in its CXL Port DVSEC (CXL r4.0 sec 8.1.5.2).
> > pci_reset_bus_function() already returns -ENOTTY in that case.
> > pci_reset_bus(), pci_probe_reset_bus() and the slot variants do not,
> > so they report success for a reset that reached no device below the por=
t.
> >
> > vfio-pci uses these for VFIO_DEVICE_GET_PCI_HOT_RESET_INFO and
> > VFIO_DEVICE_PCI_HOT_RESET. A user is then told a hot reset happened
> > while a CXL device below a masked port kept its state.
> >
> > Return -ENOTTY from pci_probe_reset_slot() and pci_probe_reset_bus()
> > when the bridge above the bus is a CXL port with SBR masked.
> > pci_reset_bus() and pci_try_reset_bridge() probe before they reset, so
> > they refuse too.
> >
> > Users see this in three places:
> > - the vfio hot reset ioctls fail (vfio reports -ENODEV when neither pro=
be
> >   succeeds),
> > - the reset_subordinate sysfs attribute returns -ENOTTY,
> > - vfio-pci groups a device in a hotplug slot below such a port by bus
> >   instead of by slot.
> >
> > Every other pci_reset_bus() caller, including the vfio bus reset at
> > close, is refused the same way. With one device per CXL port both
> > groupings have the same members.
> >
> > Leave pci_bus_error_reset() as it is. AER and host bridge error
> > recovery call it without saving or restoring state and only map its
> > result to recovered or disconnect. Failing it below a masked port
> > would turn recovery of every CXL device there, memory expanders
> > included, into a disconnect; that is a CXL error handling decision, not=
 part of
> this fix.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/pci/pci.c | 31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> > cecf8e681e69..87fe9de81acf 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4984,6 +4984,20 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
> >       return true;
> >  }
> >
> > +/*
> > + * A secondary bus reset below a CXL port with SBR masked does not
> > +reach the
> > + * devices on the bus, so a bus or slot reset there would report
> > +success for
> > + * a reset that did not happen. The probes and the save/restore
> > +resets that
> > + * pci_reset_bus() and reset_subordinate use refuse it; error
> > +recovery
> > + * (pci_bus_error_reset()) keeps its existing behavior.
> > + */
>=20
> Reads like AI over-explaining a fairly obvious concept.

I will drop this.

>=20
> > +static bool pci_bus_cxl_sbr_masked(struct pci_bus *bus) {
> > +     struct pci_dev *bridge =3D bus->self;
> > +
> > +     return bridge && pcie_is_cxl(bridge) && cxl_sbr_masked(bridge);
> > +}
> > +
> >  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)  {
> >       struct pci_dev *bridge =3D pci_upstream_bridge(dev); @@ -5615,6
> > +5629,9 @@ static int pci_slot_reset(struct pci_slot *slot, bool probe)
> >   */
> >  int pci_probe_reset_slot(struct pci_slot *slot)  {
> > +     if (slot && pci_bus_cxl_sbr_masked(slot->bus))
> > +             return -ENOTTY;
>=20
> Why would this be open coded here instead of pci_slot_resettable()?
>=20
> > +
> >       return pci_slot_reset(slot, PCI_RESET_PROBE);  }
> > EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
> > @@ -5638,7 +5655,7 @@ static int pci_try_reset_slot(struct pci_slot
> > *slot)  {
> >       int rc;
> >
> > -     rc =3D pci_slot_reset(slot, PCI_RESET_PROBE);
> > +     rc =3D pci_probe_reset_slot(slot);
>=20
> Also suggests it's tested in the wrong place.
>=20
> >       if (rc)
> >               return rc;
> >
> > @@ -5685,7 +5702,7 @@ static int pci_try_reset_bus(struct pci_bus
> > *bus)  {
> >       int rc;
> >
> > -     rc =3D pci_bus_reset(bus, PCI_RESET_PROBE);
> > +     rc =3D pci_probe_reset_bus(bus);
>=20
> And again.
>=20
> >       if (rc)
> >               return rc;
> >
> > @@ -5726,8 +5743,13 @@ static int pci_reset_bridge(struct pci_dev
> *bridge, bool restore)
> >       if (list_empty(&bus->slots))
> >               goto bus_reset;
> >
> > +     /*
> > +      * Probe without the CXL SBR mask check: error recovery keeps its
> > +      * reset path below a masked CXL port, and pci_try_reset_slot() a=
nd
> > +      * pci_try_reset_bus() refuse the restore path there.
> > +      */
>=20
> More AI?  This function is not designated as exclusive to error recovery.=
  If sbr is
> masked, slot reset doesn't generate an error and doesn't effect a reset,
> regardless of who called it.  If we're including a new condition for a bu=
s/slot
> reset to be effective, it needs to be applied universally.
>=20
> >       list_for_each_entry(slot, &bus->slots, list)
> > -             if (pci_probe_reset_slot(slot))
> > +             if (pci_slot_reset(slot, PCI_RESET_PROBE))
> >                       goto bus_reset;
> >
> >       list_for_each_entry(slot, &bus->slots, list) { @@ -5773,6
> > +5795,9 @@ int pci_try_reset_bridge(struct pci_dev *bridge)
> >   */
> >  int pci_probe_reset_bus(struct pci_bus *bus)  {
> > +     if (pci_bus_cxl_sbr_masked(bus))
> > +             return -ENOTTY;
> > +
> >       return pci_bus_reset(bus, PCI_RESET_PROBE);  }
> > EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
>=20
> Redux, pci_bus_resettable().  Thanks,

After giving more thought for this patch, I am inclined towards drop of thi=
s patch.
AER and host bridge recovery of every CXL device below a port with SBR mask=
ed
ends in a disconnect instead of a reported recovery.
That is a CXL error handling change I do not want to make inside this serie=
s.

This will also change what I wrote on v5 22/27: below a masked port
VFIO_DEVICE_PCI_HOT_RESET keeps returning success without resetting
the device. vfio-cxl does not rely on it. It resets the device with
CXL Reset at open/close/VFIO_DEVICE_RESET.
After any reset vfio-cxl did not start the device memory stays closed
until a CXL Reset through vfio succeeds. I will document this part in v7.

Thanks,
Manish

>=20
> Alex
