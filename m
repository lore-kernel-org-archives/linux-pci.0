Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029888;
	b=wlDjzIna+weZ9A8T4AwMGinpud42TjamhS6oSB5ju5vFF0jCbC4L4XJNA4DHaoOlGLFF
	 8c6vleh1ce6dKDY3c6Lu3gpqaYRl1JmXpKvJmyawumKW6CiXFINpakgAKAUHZS5ZTZWXs
	 aKcs5ce6QxoVYw//AHlufpqdg6naAEMODxRoInAQG4rUZvcj207fYObueLa5FDYaVksL5
	 FEVdp7OheMi6Fp+eq0BIEwMiOmxB3FtVZJ/dewQcFtHEErX8K7ljHkhsAflizitSSHnaQ
	 j347WmLeQX12stZbNYm/l3jUIwP3nSmPu6XHOyl0eMIsUX5KE9NAcLMVHgW1q84CxCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029888;
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
	bh=xuf1NetK4nINTUTkARUuMmpRGS/5/3arYBvLu2zglww=;
	b=b2K6i9cyFlknuqUl6hI1IA4KBqzhZomibLjoERNYJsPBjX1MqEfWRhBHKoy5b6N+5smO
	 g+h/Vn+XbwN+3/Sqm9aZQ+i/ztL/gpYotCOPKqDY8eo5t9Y9Z4oXb+5k6hJA2AkDziaI/
	 FQwNhA0g6gTp07qFZCTY0bJ/q70krC4DsIfNJI84DtoRve7AO3wpUS60VtOfPEySR0ZqZ
	 dJpTVVj0k/lObLk96ErBHeDSq36rrJlsKiwxLpoPLTBwK3qzPoj7kzLZK12JeR4lDq+Fb
	 1ynEgSIeNoZiLs0+ymtiHqTfJy/p5fiQQhtaXUIujKSAzsESprmdCo8ki+HK11WwkLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sbD1OyYE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CDB60A2637;
	Wed, 18 Nov 2026 19:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02CDB60A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sbD1OyYE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8NdaCZHQTgMouevPG4rIxm91uCt+sFWdKqMXmFS6FqANcZnkN/UQUyeXuWjVV7CRlZxjSp7vkpKzb6GP7a9W4RdPGEoqdk3kAnEmDSMkye1nD2IV7dtP0s9i2DIC7ZtuQw9XRnfFrfbZd58uqVf2+ZWNivumPvrgNPucgaHfCvn/0QxGUuuYNQjEDObqGVgPAxiq61FstG11HvERFBQpe2BH3YPPcwx0CAO53E/UrNNDHEq2lMbDse6QBIKd6aVvZSMBef3cpM+O99vDfl/AHCbcQN2uPp+I/drDj9qPuLyMvb2q6WB2Y1rFTQK3pZIr4lozbuQuWyNfAcRx3OB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuf1NetK4nINTUTkARUuMmpRGS/5/3arYBvLu2zglww=;
 b=NznKtD/8KtoYPRihbredasB31QNZ/l6J5VyjMeBp7OMUqQ7eez1wnP/amPp9ugTQqz4XMS6L274ph03NGNMC+6Yj6qbYRZQ21+j/9nBSyawcL1JMOUOaLsTYf26fNj8F0rbnQoNooyFTpDN4yUEkk4m5/M5W0t/6jRu9IEjSHz/CGy3DRLVatuv2/UBQWrlEFUxxztQr6riNxfD0Y/+ECHREebyWBeGgzyTV94elNQZMAr0gCo7G2YFj4dqNQXR2PpHL5A/82GEQr0STfTw9DIbW4U+mEGCHrZzghbJZ1B1AJ0qn9kE/DoCDs2M96H/J/C4Tn5jBcLGPLqiqYjYl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuf1NetK4nINTUTkARUuMmpRGS/5/3arYBvLu2zglww=;
 b=sbD1OyYEuPyjVrhZRjJwNWDlrUz1lsGJNheFM4NTURS+6PhF/KgIhiElgR0zQFDfIB248YxxKHwdnfVFFAnLkvYgPZ3apn7ByFU8hZDDJjRBQ/KMaKyPtMiSz5HAJt56LskPsJpXOMZGzHe79ad3gwLZlplHz9BnTbyMgvKfYJs2nQkuds6y+n9/WM+2YMJTGY2llwBMUMlwwsHwvl2p8UfN24e693EDczgdN2xLLzB/slKKI5SPVwOd98++wMHQmszUVnoz50dHZ2Pzs8LLXDG7SnGoe/FMiBv0XBLP+vr2OhQlxDvffr+1yQlQ9ZsMeqp8NESMIyHtisvsDf5OzA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:37 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:36 +0000
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
Subject: RE: [PATCH v6 09/31] vfio/pci: Advertise the mmap areas around
 excluded ranges
Thread-Topic: [PATCH v6 09/31] vfio/pci: Advertise the mmap areas around
 excluded ranges
Thread-Index: AQHdXYpTezTnjj3Ve0mb9zYUP89N07chorcAgBKlyxA=
Date: Wed, 18 Nov 2026 19:24:36 +0000
Message-ID:
 <IA1PR12MB90302EAAFF3790797BF796A6BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-10-mhonap@nvidia.com>
 <20261106133920.144f0665@shazbot.org>
In-Reply-To: <20261106133920.144f0665@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 7da99955-9e82-4f00-ea30-08df45a9956e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 1hTz71Cw5SE7+i/Zwn9R0HXhXi9YnPqA0KBqFcSwGO+NvzekaZ0/ztIGHwnEtoYBB5AU+J2pdhSNVqpv62qt40q7tL8lSoVbnyKHQO1st1fWF/JJajThMa28mpUc/n+IiOEaJF3Z6+oPpH3H15aFuJpsy5Mo1gq/SlIOWNVG7hd5FWoXR25ezlmR93HhHKE443fS9FHYIb1CN1iY4X5dgqxyOmGEU41ogv4NEjgjcXEevlZQgnyh4xpmYG6BFbsumqZzChDyx9gIhoRL3GT2njWMqj8RxBwZw1a5zWatzaiV6lIAXDZnpIr7eOTuQaVK+yQJECu+ethDdgwqy4/4gGyLWHRX32PJOVIBhFsTN16N0i/P92vKTf1ETiiGRKj0TY/8rzNO2l3Xc2XGeNfUag4u21avXtd3Ca1JJPpUlum6FK60uVNEqzXYeoT//3FGlf3DuwqS1O/Vie0/RYqPVnQZ6fbvr/xIzzECd2/ufERg6ZC6a3EexeHAsz+SEFyLovjRBYLx4zoyWx24KHyxXlTyR31OnjwLd83hp4aJrz7+4zZS8Nn2whxthPsHPp6nWDFNqXT0//f17PTVmbi8QCONAK/03xEF9rge2vyTxabWPPDa8Kz9ipAge+n9Qp0NsROPycizUEV3j5WnFkbzwVx32AzyiOPYJH3cebGZh7FPAAmGygQiJW1ZVzlEovxA1P3d9yS1QifWw7MeyH6I0kzIJwTI2sq9oz+ATtyD2C8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qIO9R2wBYzIEOZXtHdjkbpi/Imd1XAbXhBQOhcQWuvcKKm7U+YJKh80/cDxA?=
 =?us-ascii?Q?pCRIthwQ1Kqf50HzYLTLJKzl0wzUpFJQMjaPrKOGJiKKRn8d2E3i+pXJiJmT?=
 =?us-ascii?Q?s1Rx2dsEeCddbpSjsVMNSYDmZZdgVeuMOye/Q52KcWQQw5G4mjq4LeTOxTsA?=
 =?us-ascii?Q?Uke2yK5v2LeeUoD8R76XjnsYok1kcBM655eID7Bsb4qOmxA1zW2JzeE42mFq?=
 =?us-ascii?Q?Dw2d5pSa4g8RWG/ntYEBIPLy+/zxNIn/AFypZxYzKuvqRi+eIyglAblzRPx5?=
 =?us-ascii?Q?2RNhmY8qknAlgAlH1thosSe/RSkLhsPdrj4jRddaiKkbUy2dEYz6v6ffhpq+?=
 =?us-ascii?Q?ux5l9meDlZNAUISd6pDbSzCItObUgRrQII3BL8PL3nkTbxruNGkM9j0LydJv?=
 =?us-ascii?Q?uJQ6fzToMEmXYfDZa44IGVweb56ABb3SPq6Z4L7ZJ2BF0LAsX5VlKt/ZRJjo?=
 =?us-ascii?Q?Q8N9Um3xU8b+nU6gm9P9Y5pFAnstZVz+IOwcYmz7MI6ISj2IWE/c8IemVGyE?=
 =?us-ascii?Q?8l7qy6nwpmoARlf7C9//3uTOncPb6Ai69I5M5cLEY5eSBuo1v4rqraJhYA3D?=
 =?us-ascii?Q?y8BIv406RkbHuOyqVUZcp61D5AtSwk5uL0JJczh/wP5RBfsOHUo3c33M/hfk?=
 =?us-ascii?Q?pJTwWw43mt2jFRmGmRpjiuAAr3E8P5qSYkfRcplj5HOPkbhy4N0tem0HsaWK?=
 =?us-ascii?Q?O2FyrmM5dqZpueWsjKe+uRoI0zMNvOf2rXVKfpsAWQW88bzROmfW2UPh1ph2?=
 =?us-ascii?Q?vmA+w0kK7fLKWjJYkyuglYV1B0EAzFI5ulwUWWTg6YTkhuEqGa+3GedCZlK3?=
 =?us-ascii?Q?RyMjqxRoik4Y4a6FYN8NGv5r8xGAA7g28mkeO3I41yNwM2xjX7xdS04rdwgd?=
 =?us-ascii?Q?3BazdEN4fQlqUvsjNPHBPZui0seBVVrpfjDSazLnWMFFxDuCDMVUrmjt/rqw?=
 =?us-ascii?Q?vYElCrNDkzzV8oG/rf0DdvcQCtpAfC80JATxiQ44FzjqG4PCZlTjHTaRI07A?=
 =?us-ascii?Q?/d5ZUItarkK4foX9N6tvYWrd6ACqI5lafGG9sFocW2mC0lr4O3vBnE9jhwnI?=
 =?us-ascii?Q?53BvmP+r2sgv7hfS0CrBczMnfmGURaJfKVep8OL1H0tK1dpIxflog7dl7fPr?=
 =?us-ascii?Q?wtaRjUr39ZUctOKdkiqAers81GNj2almk43MzgttrFxS2jR5Mbp0F61xYAt5?=
 =?us-ascii?Q?wzGUeVJYGmfcEIfPN2no9H424AgVO8rBQiLwfwRzkrPlZ0LIrNIohwLAxJlC?=
 =?us-ascii?Q?H6ocYc0ja6sC/5zQq0BQrxIC8u7hcFB0+kK3hT9VEuU8CPfenqdhc2rRZ5VG?=
 =?us-ascii?Q?Sp1hzqXE+LBoAajOb9lX3UEQGikLTbUcGBPk6bkhmfa7m+neDhbS5lp9sBkx?=
 =?us-ascii?Q?iHAT/5/AzIOcerj7xd4X3A7gowO1nW/vBeXpdX0qeHywKvtu4BS5m0FLfsiV?=
 =?us-ascii?Q?UyQbEZGGjf0ySKtwDwN/sxl6Zc3APQ4PJQEpO+zrxY6+bC/YFIx7gcAfAjXp?=
 =?us-ascii?Q?S4xnoBEqJx9SYSLUqYZdllWY0rrxSsBtJFPrls45a7CLPMA+SaD+M/YttMEH?=
 =?us-ascii?Q?mM06UcHD9OCabIvVnm/ZDPPG0C4/hKB9dLWPDLcYx0r73fjgg+sc3erw//y4?=
 =?us-ascii?Q?rwdRt5nooFQXNdWgMJqRJ/5+VjMXIjfidGG8s1Qv/Him2FqdZxtsO9Aw9gCO?=
 =?us-ascii?Q?EoyFFPZdm3PKbyt5SRsbb5Yw8/E98LzgEEMQ4QcOy8RcQVki?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da99955-9e82-4f00-ea30-08df45a9956e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:36.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPpKyk09ZMatqr32aGQvcV9FjXxov3xxijJrv2vlYcHLyaq5joMG81iGrCgFaADSplCK9xpOUnmv7/1mBZZu2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, November 7, 2026 2:09 AM
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
> Subject: Re: [PATCH v6 09/31] vfio/pci: Advertise the mmap areas around
> excluded ranges
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:16 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A range excluded from mmap must not be reachable through an mmap of
> > its BAR. Refuse an mmap that overlaps such a range, and advertise the
> > BAR with a sparse mmap capability that lists the areas between the
> > excluded ranges, so a VMM maps those and traps the rest.
> >
> > mmap is page granular, so each range is rounded out to whole pages,
> > and ranges that meet after rounding form one hole. The sorted list
> > gives the areas in two walks: the first counts them and the second fill=
s them.
> >
> > A BAR without mmap-excluded ranges gets no new capability. The MSI-X
> > table is excluded from read and write only, so the MSI-X BAR is
> > unchanged.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 91
> > ++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index bee3d1b4d8d2..f099a294af34 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1106,6 +1106,88 @@ static void vfio_pci_free_excluded_ranges(struct
> vfio_pci_core_device *vdev)
> >       }
> >  }
> >
> > +/* True when [start, start + len) on @bar overlaps a range with any
> > +of @flags. */ static bool vfio_pci_bar_range_excluded(struct
> vfio_pci_core_device *vdev,
> > +                                     int bar, u64 start, u64 len, u32
> > +flags) {
> > +     struct vfio_pci_excluded_range *range;
> > +
> > +     /* Only BARs have excluded ranges; a device-specific region has n=
one. */
> > +     if (bar >=3D PCI_STD_NUM_BARS)
> > +             return false;
> > +
> > +     list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
> > +             if (range->start >=3D start + len)
> > +                     break;
> > +             if ((range->flags & flags) &&
> > +                 start < range->start + range->size)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +/*
> > + * Advertise a BAR with mmap-excluded ranges as the mmap-able areas
> > +between
> > + * them. mmap is page granular, so each range is rounded out to whole
> > +pages;
> > + * ranges that meet after rounding merge into one hole. The first
> > +walk counts
> > + * the areas and the second fills them.
> > + */
> > +static int vfio_pci_excluded_sparse_cap(struct vfio_pci_core_device *v=
dev,
> > +                                     int bar, struct vfio_info_cap
> > +*caps) {
> > +     struct vfio_region_info_cap_sparse_mmap *sparse __free(kfree) =3D=
 NULL;
> > +     u64 bar_len =3D pci_resource_len(vdev->pdev, bar);
> > +     struct vfio_pci_excluded_range *range;
> > +     u32 nr_areas =3D 0;
> > +     bool holes =3D false;
> > +     u64 pos =3D 0;
> > +     u32 i =3D 0;
> > +
> > +     list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
> > +             if (!(range->flags & VFIO_PCI_EXCLUDE_MMAP))
> > +                     continue;
> > +             holes =3D true;
> > +             if (ALIGN_DOWN(range->start, PAGE_SIZE) > pos)
> > +                     nr_areas++;
> > +             pos =3D max(pos, ALIGN(range->start + range->size, PAGE_S=
IZE));
> > +     }
> > +     if (!holes)
> > +             return 0;
> > +     if (pos < bar_len)
> > +             nr_areas++;
>=20
> The number of sparse ranges is bounded by (num_mmap_excluded_ranges +
> 1).  We're dealing with a very low number of excluded ranges, bounded by
> insertion via kernel drivers and core.  It seems worthwhile to avoid the
> duplication with a simple list walk that counts the mmap excluded ranges,=
 then
> all of the alignment happens once, and the resulting nr_areas is calculat=
ed as
> we fill.
>=20
> Note that with the use of __free, it's generally recommended to allocate =
at the
> point it's declared and mixed declarations and statements are allowed for=
 this.
> We can therefore do the declaration and allocation after we've done the s=
imple
> version of the counting loop.
> Thanks,
>=20

okay, I will update this. count the mmap-excluded ranges, allocate count + =
1
areas at the declaration, then align and fill in one walk and take nr_areas
from what was filled.

Thanks,
Manish

> Alex
>=20
> > +
> > +     sparse =3D kzalloc_flex(*sparse, areas, nr_areas);
> > +     if (!sparse)
> > +             return -ENOMEM;
> > +
> > +     sparse->header.id =3D VFIO_REGION_INFO_CAP_SPARSE_MMAP;
> > +     sparse->header.version =3D 1;
> > +     sparse->nr_areas =3D nr_areas;
> > +
> > +     pos =3D 0;
> > +     list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
> > +             u64 hole =3D ALIGN_DOWN(range->start, PAGE_SIZE);
> > +
> > +             if (!(range->flags & VFIO_PCI_EXCLUDE_MMAP))
> > +                     continue;
> > +             if (hole > pos)
> > +                     sparse->areas[i++] =3D (struct vfio_region_sparse=
_mmap_area) {
> > +                             .offset =3D pos,
> > +                             .size =3D hole - pos,
> > +                     };
> > +             pos =3D max(pos, ALIGN(range->start + range->size, PAGE_S=
IZE));
> > +     }
> > +     if (pos < bar_len)
> > +             sparse->areas[i] =3D (struct vfio_region_sparse_mmap_area=
) {
> > +                     .offset =3D pos,
> > +                     .size =3D bar_len - pos,
> > +             };
> > +
> > +     return vfio_info_add_capability(caps, &sparse->header,
> > +                                     struct_size(sparse, areas,
> > +nr_areas)); }
> > +
> >  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vde=
v,
> >                                     unsigned int type, unsigned int sub=
type,
> >                                     const struct vfio_pci_regops *ops,
> > @@ -1254,6 +1336,10 @@ int vfio_pci_ioctl_get_region_info(struct
> vfio_device *core_vdev,
> >                               if (ret)
> >                                       return ret;
> >                       }
> > +                     ret =3D vfio_pci_excluded_sparse_cap(vdev, info->=
index,
> > +                                                        caps);
> > +                     if (ret)
> > +                             return ret;
> >               }
> >
> >               break;
> > @@ -1947,6 +2033,11 @@ int vfio_pci_core_mmap(struct vfio_device
> *core_vdev, struct vm_area_struct *vma
> >       if (req_start + req_len > phys_len)
> >               return -EINVAL;
> >
> > +     /* An excluded sub-range is reachable only through its trap, not =
mmap. */
> > +     if (vfio_pci_bar_range_excluded(vdev, index, req_start, req_len,
> > +                                     VFIO_PCI_EXCLUDE_MMAP))
> > +             return -EINVAL;
> > +
> >       /*
> >        * Ensure the BAR resource region is reserved for use.
> >        */

