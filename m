Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029882;
	b=z7ipeIZJnaqwXmLzOdoym6xHEJMP25o/5T1GsMz13tyJbBXHDDgD+eqk93GMKfQJXGRK
	 2U5LiBO6rIeoln8dsb7kvNYRECXDU23ijSDfh6Tu2WgJAnqyQwmo4dljSjtpqLB41S1Ei
	 yLeAsT9KnHv6Q8FjjwtSvZ339E8lS2b/OjaV8SY+oscmIQUIpWHiBL7mL/Sa5nJHu8Aom
	 JazJp9pXxkrLb8mOwZwFO9z5alfLwLlDHQXq4OBAUtlJYLGBZM7w6kRYgFZQAwpCakGg4
	 WZbyjY/CFK2EThhD2ixAbTB9l22lBts3If4P0DlW2WAsrwQQATnop77xUn7iNUFbANA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029882;
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
	bh=vukqaLcc1TEhHMl8RiBg3pPYeSnA6dF1i0mTTjpSK0E=;
	b=PDa9e3gklvWP1hnClqvIkE8x4wnddOhFWxpiAVb/EHH0EpWoWem7UR3i4B6LnST2GUL2
	 H+s1kKFf/CxaYDQa9jU/ABM36cRK9UACMYR0H9iK4FvKsCUEJNIFlr8Ir2pEM6B0S708Q
	 bcA+JLljzKW3FCHEj21GJPPjE+wEwVOixnsxpoY3LixXykntPWXmtc0pUYlv0Io1NfTLs
	 eYfzdtxVm5ZL0JjXIE2cG+Kf880LYPHNOjy5ygM8TXPQFCDe+Y/kF368nyJr2x7ypLppa
	 aR8ZVXePKkrQOfktlIElDXZbAgFzBhCEo1V9Dx5KOhFOg+PqHp4LyT520B2FKmsS5hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GSKNUSME;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.13
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA4606A31C;
	Wed, 18 Nov 2026 19:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2DA4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GSKNUSME
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvI9m2BdBmLHFZj/oKdGBkD7C3nHAGNa2hOVaSO4MX5rbQujD6Jb/LDnserreKCHgiOk85f+hB2LM4MKR0HGZZ0c8oJPnMqsMDqbJtr74RtOJyiFQXUnB7va7jT3Gtx9JYY//RyNKTH7EQzmzW+liLhKS3jpFAS2ZXvV3+/1srdoDKRjrmzXR1p2Xk6S7oO14GM/q2k6ScC/paxAgniY9whzqJ49N5L9St98+d54RBXwfp4MFBHOSPU3yXebLyMNjf0a3wRhPBcRnYgkxx3XLEF0vjK0MM2EwTSg/5KsO+jA4x8ivoUgbfPjLxOYwRiv8A2wcx9akdoRZh8GQYdEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vukqaLcc1TEhHMl8RiBg3pPYeSnA6dF1i0mTTjpSK0E=;
 b=kQw+w6juX0cXP+Pn1h/L2zMZ+Zzz9huvx7qXjfCLyHinP4CWR7Or36QWO7QkdjmRSLHs33ykLdyfRo5/Rp3QyKkAeKn1XJ5d+fPBEbgj+8Kw9uJIEaJERFuwFJtXmoSASdxzodqF/mf5qFAfSdZxgZoFUtyVHjko9B94nJFOx9K21xbkOudKRBIZrrhASwVXOYOcMEwmr6v4PjR7J3Vkl3yaCTndUx60U2MV8miWSQdS+RIXB++JiAC2Q3pCneYQk/AW/HMWCVSxajElrb01kAnqpbCQAQhMISj6xyToo1RyVxCKGc8XUVBsOH94ReufTKfvtxYKdTTV9kVR7gDmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vukqaLcc1TEhHMl8RiBg3pPYeSnA6dF1i0mTTjpSK0E=;
 b=GSKNUSMEgbtI8Wxt6AcJjtyQa7opMH4Y9pjNX8Ge5MUf6WFaMu2X9Np2W1VVTa3gDO+6zI3YkbBFzLhRtPHAakRSQJtVrpCiAsJAwPF8+b5tffcDVyP6C0QUf5Uj9DHbpnvi247atV77h2KxGYO8gjFjXPm2yCaiG8iGXtBQr+Ld7QlzVifNVywj4OkTLxV+0yuCRmivCt2S6lTOIGsiUg9kpBkdT6Uh1hazWgJrpZY/Y1NUX1PKHjzrIdqlk5rmIn4iFq4bvqe+IelbOl2qVIpTru3lwjw1OYpKdE7uXwm4idVs9P1e6duSOFBOPy8PsF4eVOtT/6TPHFyDO2y2xw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:25 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:25 +0000
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
Subject: RE: [PATCH v6 13/31] vfio/pci: Bracket PCI resets with the CXL reset
 hooks
Thread-Topic: [PATCH v6 13/31] vfio/pci: Bracket PCI resets with the CXL reset
 hooks
Thread-Index: AQHdXYpkTge0tadFUkKQBGmeopvbmbch1nCAgBJ4n/A=
Date: Wed, 18 Nov 2026 19:24:24 +0000
Message-ID:
 <IA1PR12MB9030A85A328C20ED230AC4B0BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-14-mhonap@nvidia.com>
 <20261106164427.51791193@shazbot.org>
In-Reply-To: <20261106164427.51791193@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 51619563-0c4e-44ca-26d8-08df45a98e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|3023799007|4143699003|261102130727099003|56012099006|11063799006|261026121527099003|261102123227099003|5023799004|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 MlmONAcfQHBDZ3oKT7rAplfkOrS1bifS2B6pS2pcujQjyMLIycfr2j2FlByniuJDktS6q+CM+54ANhTyaklx3D4aTF9R18a2Rt2qj6PML1PA8nKPk+5VO6CNfZuuet/ggduBu5R6ve8bveyxeVY6cuLl1IAGAhCpnhybgjhIYUuvc8rb0R2MnFmcWlinPIb2CA6p7x8C0hP74Gnj4W/3n2vsORu9HJiqNm1CchdGaWIG2Miqx1Xind1zrMVQMhpZkU0fC8i4N7dDkAYoSlaknCfM8HMeIPpwxld3NT9Eln/D9LDno+YpOwUqF0cWCtrRfrn4aBB5fCLZDxB2qD9EKve5QHC6PojYWJEwHkuKsbVKOtXbEr+Dsz5lFOS6Lrfo/tv+iesShvp+R4lBGlMdW1rDaszO2lDQhkN2dcj47pLDvPIpb9NJSFJgX2V62FgsM+pvsgn08K9V8yKWPbV/apZUL9QPACi+nqT7B4VgX5deVxUbsAp4SSEXb2bLhpTlLU5KjQQj5+YtilXPdedR9MLBLfcK7OrYs0Vi/ZjcjuvD/oLblC5Ds5HjpvD/Q56ppR77KnvcwB5FF3bKF/073cCqyjpiOql2PvvoS5Yv2oHy+Gx7g5Mx9gFOugUIjRNuRBifSLU9x4wdRo+AUY/1Cd03oHg471liz+lpDzDe7KQrzxUApz3eGbW+hLg7dfQYWRMhuyh5SxgFvL+3+PtGgXLewZHngBC199rp54W8YyA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(4143699003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(5023799004)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rDSCHbfAND9UKi9KJ6EhTNvl78We8UWQiSvrX5en6ZP4xbaLT6o+26oafNEi?=
 =?us-ascii?Q?LJghClHMfRnFD13auEWUM+inLRXEC+TkKXMtrZ/C/qMjD/i36dtLkO094K/6?=
 =?us-ascii?Q?1+xswzIzyFZ5NKradtH7rlPHEV1LC+igPyVgvtmoNfg8om++otvfozrnzMys?=
 =?us-ascii?Q?rZhaIFjc4eWRrl4IjEnOU8ZE0SJIDQ7nAnWhWeHvw7/uGDKzgLfLeH13TIJb?=
 =?us-ascii?Q?XFXr+g3Qw/nS/aVzF3FwwuYK11XEs6mPhLNvIkTJ5hDy79uB6v1uqovDobrs?=
 =?us-ascii?Q?vD/lIGDkh96n9PAOv+8+7cose+ZQF2o4FBCW9Oy/tFS8AWlrYi/iMde+W1/4?=
 =?us-ascii?Q?cuPQ5jBJd8Iw21A0xsycJsflAWIvgzNgtoIFHiRlai+aZuJyizD/ZZtQ/Bk6?=
 =?us-ascii?Q?n+8JPdKS5CiJspMyR2QIY6UzBCKuuWXEiKMjXtxj926+CI7sda5OW5evSZYQ?=
 =?us-ascii?Q?iRAO0egANuMuIhj0eV3rnoYcRivfbDeOuP/cGRWrvS68N6FbbqxvW0uQIjI8?=
 =?us-ascii?Q?2E2JKiRQ3b8JeUJwjcZlOvjt//eVFU70yeUpLGejMS1b2ow/E6cjnpQijncz?=
 =?us-ascii?Q?/zJAuIk8dpTpllnM6POshVQ1zy+5rULaBawUV4zeezr+5U4lp5VTYJvcWy07?=
 =?us-ascii?Q?N+1NpKLQSz0D4nBvqEL0UDD/Wn3V/lLvIPNfF7w1rc69e3pbPUJEwhVjpbzT?=
 =?us-ascii?Q?adXSvsOkYSmVE/PQzM66la9WnVmFKA4VZaq7tEhLl3VmqudxVTr4wDSMRk0S?=
 =?us-ascii?Q?wkbLNIGdVyUzHFsJhYUz3oSm1f7n3XmeFAPZ+Ns4lY2YwRjQXQRbglz/uz7u?=
 =?us-ascii?Q?jGsJIuzbZh5vNob/lrtgr3URHzWB3eFDfK+3Bsdg8nRAP2MA6cKKWFtwZYVe?=
 =?us-ascii?Q?rHmSqcsmkahrLK6R/2DQ3YEE9m8If4kCVZWDJyMvFi62AE88uNMJeW44qy67?=
 =?us-ascii?Q?DtsqMy9Xk+hhRI/yVte+gA/zjsxHmilf8/XaS0GUekEnDecCMXB9Px1h+r+y?=
 =?us-ascii?Q?7atQmHSxnHqSMLn0ALmf7J06lARqCj0/g5J6RZumMtiRo6ARsoYvuTmPa0Vj?=
 =?us-ascii?Q?OZ43NaIQX1teWyEbwLcKSq/EgkEaQq8WFvJbh833Bq2biAHmqi1/jkwfkIeI?=
 =?us-ascii?Q?kHkyKXETRSykZPb0uV3BHqfnPEdrdHvKgbfK6vHjhiHXL/kYt8EeVaOwQFCW?=
 =?us-ascii?Q?Da2Emw0+/+4ZpJw3zSZhiRzxi4FuP3kr5sWVyX7zUrjALm/SQLpZQY21rmhC?=
 =?us-ascii?Q?/6POWlkVwtg6dUGFnqiY6IEx5VOW519L7+saa0gDUVU1EgeTiEtMGGWUAZ2d?=
 =?us-ascii?Q?hgnU1jSRjeXXKyQbQLhiHMULGHd0cSf2K8uTgH3UL4rDNBvRFoI9HdOo805n?=
 =?us-ascii?Q?ZAh2D8cM2SySDBcd/UhvtdOk4MIbXRvVHoHwgoygcwTF3D2qh4p0+ouQHoBi?=
 =?us-ascii?Q?oR56/Ni5OAixInDekOTu/VKdtdCxo5fXNMN00Dkp9JFKKsn6e2K/RZKQW56t?=
 =?us-ascii?Q?VU+L4/fNLR7tr/8y+8e3q9oR5sqLlnqNj3gsg6ssCfg6C1FHuIA0PdNlvq0I?=
 =?us-ascii?Q?iNgddRPqm461cijUb1uxMZKVWI67GoH/rthmd/tP9Z131gGjzb8HbxAIOQ+y?=
 =?us-ascii?Q?jZ8UIZ2hLy0Nb8U3iqu7/73bH/M33GDyWOU87UokPcMgnaB1zx0HFA2lOTH2?=
 =?us-ascii?Q?ZKVA6ClBFoISbhv1mgXRM1mq/jOjfDCnr3tGIhOQ5I5OciQZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51619563-0c4e-44ca-26d8-08df45a98e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:24.9446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nvni1VBtHZvO6MaXBCa5rANmkTaQ6KVKw2nxIBJbiEVnz7mjy4FwXtgPQr4twWNuEOYTAdtyYe6EdZ7Oel1tOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, November 7, 2026 5:14 AM
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
> Subject: Re: [PATCH v6 13/31] vfio/pci: Bracket PCI resets with the CXL r=
eset
> hooks
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:20 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 device must quiesce its coherent link before any reset
> > and restore its HDM decoder state afterward, or a reset can leave the
> > device mastering the bus over decoders that are no longer valid. This
> > has to happen around every reset the PCI core drives for the device,
> > not only the ones VFIO issues directly, and around AER and DPC
> > recovery, which can reset the link without the reset callbacks.
> >
> > Add:
> > - reset_prepare
> > - reset_done
> > - an optional error_resume to the CXL ops
> >
> > Export:
> > - vfio_pci_core_reset_prepare()
> > - vfio_pci_core_reset_done()
> > - vfio_pci_core_error_detected()
> > - vfio_pci_core_error_resume()
> > which take the vfio device.
> >
> > vfio-pci calls them from its own pci_error_handlers, which resolve the
> > driver data it owns. A variant driver that binds CXL devices calls
> > them from its own handlers the same way; a driver without
> > reset_prepare, reset_done, error_detected and resume callbacks gets no =
CXL
> support.
> >
> > The provider hooks run with memory_lock held for write: vfio-pci-core
> > already holds it across its own hot reset, and
> > vfio_pci_core_reset_prepare() takes it for a reset started anywhere
> > else until vfio_pci_core_reset_done(). The hot reset records its task,
> > so a reset that another task starts meanwhile waits for memory_lock
> > instead of skipping it. pci_dev_lock() blocks user config access,
> > which a PCI_COMMAND write can be waiting for while it holds
> > memory_lock, so reset_prepare lets config access through while it
> > waits. reset_done returns an error when the provider could not restore
> > its device, and VFIO_DEVICE_PCI_HOT_RESET returns that error; for any
> > other reset the provider logs it.
>=20
> Cryptic.  Seems like we're skipping updating all the variant drivers to m=
ake use
> of the new reset and error hooks, which seems wrong.
>=20
> This also needs to be rebased to the the new drvdata handling in v7.4-rc.

Okay, I will handle both the flagged items. I will check the new drvdata ha=
ndling.

>=20
> I'm also not sure why the "provider" terminology has snuck into this seri=
es with
> this level of prevalence.  There's only one cxl ops "provider", it's vfio=
-cxl.

Okay, for v7, I will mention this as vfio-cxl.

>=20
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci.c      |  39 +++++++-
> >  drivers/vfio/pci/vfio_pci_core.c | 154
> +++++++++++++++++++++++++++++++
> >  include/linux/vfio_pci_core.h    |  22 +++++
> >  3 files changed, 214 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index 830369ff878d..286244059569 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -223,13 +223,50 @@ static const struct pci_device_id
> > vfio_pci_table[] =3D {
> >
> >  MODULE_DEVICE_TABLE(pci, vfio_pci_table);
> >
> > +static void vfio_pci_reset_prepare(struct pci_dev *pdev) {
> > +     struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev)=
;
> > +
> > +     vfio_pci_core_reset_prepare(vdev);
> > +}
> > +
> > +static void vfio_pci_reset_done(struct pci_dev *pdev) {
> > +     struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev)=
;
> > +
> > +     vfio_pci_core_reset_done(vdev);
> > +}
> > +
> > +static pci_ers_result_t vfio_pci_error_detected(struct pci_dev *pdev,
> > +                                             pci_channel_state_t
> > +state) {
> > +     struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev)=
;
> > +
> > +     vfio_pci_core_error_detected(vdev);
> > +     return vfio_pci_core_aer_err_detected(pdev, state); }
> > +
> > +static void vfio_pci_error_resume(struct pci_dev *pdev) {
> > +     struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev)=
;
> > +
> > +     vfio_pci_core_error_resume(vdev); }
> > +
> > +static const struct pci_error_handlers vfio_pci_err_handlers =3D {
> > +     .error_detected =3D vfio_pci_error_detected,
> > +     .reset_prepare =3D vfio_pci_reset_prepare,
> > +     .reset_done =3D vfio_pci_reset_done,
> > +     .resume =3D vfio_pci_error_resume, };
> > +
> >  static struct pci_driver vfio_pci_driver =3D {
> >       .name                   =3D "vfio-pci",
> >       .id_table               =3D vfio_pci_table,
> >       .probe                  =3D vfio_pci_probe,
> >       .remove                 =3D vfio_pci_remove,
> >       .sriov_configure        =3D vfio_pci_sriov_configure,
> > -     .err_handler            =3D &vfio_pci_core_err_handlers,
> > +     .err_handler            =3D &vfio_pci_err_handlers,
> >       .driver_managed_dma     =3D true,
> >  };
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 3d4e01eea7b1..f1e1ec36eec7 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -2462,6 +2462,7 @@ static bool vfio_pci_is_cxl_type2(struct pci_dev
> *pdev)
> >   */
> >  static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
> > {
> > +     const struct pci_error_handlers *err_handler;
> >       const struct vfio_cxl_ops *ops;
> >       int ret;
> >
> > @@ -2473,6 +2474,23 @@ static int vfio_pci_core_cxl_init(struct
> vfio_pci_core_device *vdev)
> >       if (!ops)
> >               return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
> >
> > +     /*
> > +      * The provider must see every PCI core reset of the device and e=
very
> > +      * AER or DPC recovery. A driver without reset_prepare, reset_don=
e,
> > +      * error_detected and resume callbacks gets no CXL support; the d=
river's
> > +      * callbacks must call vfio_pci_core_reset_prepare(), _reset_done=
(),
> > +      * _error_detected() and _error_resume().
> > +      */
> > +     err_handler =3D vdev->pdev->driver ? vdev->pdev->driver->err_hand=
ler :
> NULL;
> > +     if (!err_handler || !err_handler->reset_prepare ||
> > +         !err_handler->reset_done || !err_handler->error_detected ||
> > +         !err_handler->resume) {
> > +             pci_info(vdev->pdev,
> > +                      "driver lacks PCI reset or error recovery hooks,=
 continuing
> without CXL support\n");
> > +             vfio_pci_put_cxl_ops(ops);
> > +             return 0;
> > +     }
> > +
>=20
> Just implement them in all the variant drivers and make them validated in
> vfio_pci_core_register_device().

Okay, I will check this part.

>=20
> >       ret =3D ops->init(vdev);
> >       /*
> >        * A provider that is not ready yet (for example its CXL port
> > has not @@ -2759,6 +2777,128 @@ int
> > vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,  }
> > EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
> >
> > +/*
> > + * Take memory_lock for a reset that the PCI core runs on a locked dev=
ice.
> > + * pci_dev_lock() also blocks user config access, and
> > +vfio_basic_config_write()
> > + * holds memory_lock while its pci_user_*_config() calls wait for
> > +that block
> > + * to clear. Waiting for memory_lock with config access blocked would
> > +hang
> > + * both tasks, so let user config access through while waiting: the
> > +PCI core
> > + * calls reset_prepare before it saves or touches the device. The
> > +caller holds
> > + * the device lock, so a block found set is the caller's own.
> > + */
> > +static void vfio_pci_reset_lock_memory(struct vfio_pci_core_device
> > +*vdev) {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +
> > +     if (down_write_trylock(&vdev->memory_lock))
> > +             return;
> > +
> > +     /* The caller did not block config access: nothing to release. */
> > +     if (pci_cfg_access_trylock(pdev)) {
> > +             pci_cfg_access_unlock(pdev);
> > +             down_write(&vdev->memory_lock);
> > +             return;
> > +     }
> > +
> > +     pci_cfg_access_unlock(pdev);
> > +     down_write(&vdev->memory_lock);
> > +     pci_cfg_access_lock(pdev);
> > +}
> > +
> > +/**
> > + * vfio_pci_core_reset_prepare() - prepare a device for a PCI core
> > +reset
> > + * @vdev: vfio PCI device about to be reset
> > + *
> > + * Call from the driver's pci_error_handlers.reset_prepare callback.
> > + */
> > +void vfio_pci_core_reset_prepare(struct vfio_pci_core_device *vdev) {
> > +     if (!vdev->cxl_ops)
> > +             return;
> > +
> > +     /*
> > +      * vfio-pci-core holds memory_lock across its own hot reset. Hold=
 it
> > +      * across a reset started anywhere else too, until reset_done. Te=
st
> > +      * the owner, not just a flag: another task can reset the device =
while
> > +      * a hot reset holds memory_lock and has not yet locked the devic=
e.
> > +      */
> > +     if (READ_ONCE(vdev->hot_reset_task) !=3D current)
> > +             vfio_pci_reset_lock_memory(vdev);
> > +
> > +     vdev->cxl_ops->reset_prepare(vdev);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_reset_prepare);
>=20
>=20
> This is all super sketchy.  Sashiko triggers multiple critical issues.
> Having different locking behavior across CXL vs non-CXL device is not
> acceptable.  These callbacks occur even if the device is reset through sy=
sfs or
> AER while the device is not opened.  Inferring whether the lock is held o=
r not is
> very hacky.  Thanks,

Okay, I will recheck this part. For my review I was only using review-promp=
ts
kernel md file instructions for my LLM review. I will setup local sashiko a=
nd
verify this with complete runs.

What vfio-cxl needs from these callbacks is to keep the device memory
unmapped from reset_prepare until the device decodes it again.
memory_lock was the convenient lock for that, not a requirement: CXL
memory decode does not depend on the Memory Space bit. So, in v7
I will serialize vfio-cxl memory region with its own lock and take it
in its hooks.
vfio-pci-core will not take lock in the hooks, so its locking
is the same for every device, and hot_reset_task and reset_done_err
will go away.

Thanks,
Manish

>=20
> Alex
>=20
> > +
> > +/**
> > + * vfio_pci_core_reset_done() - restore a device after a PCI core
> > +reset
> > + * @vdev: vfio PCI device that was reset
> > + *
> > + * Call from the driver's pci_error_handlers.reset_done callback.
> > + */
> > +void vfio_pci_core_reset_done(struct vfio_pci_core_device *vdev) {
> > +     int ret;
> > +
> > +     if (!vdev->cxl_ops)
> > +             return;
> > +
> > +     ret =3D vdev->cxl_ops->reset_done(vdev);
> > +
> > +     /*
> > +      * hot_reset_task cannot change since reset_prepare: setting it n=
eeds
> > +      * memory_lock, which this task or the hot reset task holds.
> > +      */
> > +     if (READ_ONCE(vdev->hot_reset_task) =3D=3D current) {
> > +             /* VFIO_DEVICE_PCI_HOT_RESET returns the error. */
> > +             vdev->reset_done_err =3D ret;
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * Nobody waits for the result of a reset started elsewhere. A pr=
ovider
> > +      * that failed has logged it and keeps its device memory out of u=
se
> > +      * until a later reset restores the device.
> > +      */
> > +     up_write(&vdev->memory_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_reset_done);
> > +
> > +/**
> > + * vfio_pci_core_error_detected() - prepare a device for AER or DPC
> > +recovery
> > + * @vdev: vfio PCI device the recovery reports an error on
> > + *
> > + * Call from the driver's pci_error_handlers.error_detected callback.
> > +The
> > + * recovery may reset the device without reset_prepare and
> > +reset_done, so a
> > + * provider takes its device memory out of use here.
> > + */
> > +void vfio_pci_core_error_detected(struct vfio_pci_core_device *vdev)
> > +{
> > +     if (!vdev->cxl_ops)
> > +             return;
> > +
> > +     guard(rwsem_write)(&vdev->memory_lock);
> > +     vdev->cxl_ops->reset_prepare(vdev);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_error_detected);
> > +
> > +/**
> > + * vfio_pci_core_error_resume() - resume a device after AER or DPC
> > +recovery
> > + * @vdev: vfio PCI device the recovery resumes
> > + *
> > + * Call from the driver's pci_error_handlers.resume callback. A
> > +provider puts
> > + * its device memory back if the device still decodes it; otherwise
> > +the memory
> > + * stays out of use until the user resets the device.
> > + */
> > +void vfio_pci_core_error_resume(struct vfio_pci_core_device *vdev) {
> > +     if (!vdev->cxl_ops || !vdev->cxl_ops->error_resume)
> > +             return;
> > +
> > +     guard(rwsem_write)(&vdev->memory_lock);
> > +     vdev->cxl_ops->error_resume(vdev);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_error_resume);
> > +
> >  const struct pci_error_handlers vfio_pci_core_err_handlers =3D {
> >       .error_detected =3D vfio_pci_core_aer_err_detected,  }; @@ -2915,=
6
> > +3055,8 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set
> *dev_set,
> >                       ret =3D -EBUSY;
> >                       break;
> >               }
> > +             WRITE_ONCE(vdev->hot_reset_task, current);
> > +             vdev->reset_done_err =3D 0;
> >
> >               vfio_pci_dma_buf_move(vdev, true);
> >               vfio_pci_zap_bars(vdev); @@ -2940,6 +3082,17 @@ static
> > int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
> >
> >       ret =3D pci_reset_bus(pdev);
> >
> > +     /* A provider that could not restore its device fails the hot res=
et. */
> > +     if (!ret) {
> > +             list_for_each_entry(vdev, &dev_set->device_list,
> > +                                 vdev.dev_set_list) {
> > +                     if (vdev->reset_done_err) {
> > +                             ret =3D vdev->reset_done_err;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +
> >       vdev =3D list_last_entry(&dev_set->device_list,
> >                              struct vfio_pci_core_device,
> > vdev.dev_set_list);
> >
> > @@ -2948,6 +3101,7 @@ static int vfio_pci_dev_set_hot_reset(struct
> vfio_device_set *dev_set,
> >                                        vdev.dev_set_list) {
> >               if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vd=
ev))
> >                       vfio_pci_dma_buf_move(vdev, false);
> > +             WRITE_ONCE(vdev->hot_reset_task, NULL);
> >               up_write(&vdev->memory_lock);
> >       }
> >
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 6520a2dcfd4a..881e51c42414
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -72,6 +72,21 @@ struct vfio_cxl_ops {
> >       void    (*release)(struct vfio_pci_core_device *vdev);
> >       int     (*open_device)(struct vfio_pci_core_device *vdev);
> >       void    (*close_device)(struct vfio_pci_core_device *vdev);
> > +     /*
> > +      * Optional. Called with memory_lock held for write when AER or D=
PC
> > +      * recovery resumes the device, after reset_prepare was called fo=
r the
> > +      * error. Config space is as the recovery left it.
> > +      */
> > +     void    (*error_resume)(struct vfio_pci_core_device *vdev);
> > +     /*
> > +      * Called around a PCI core reset of the device with memory_lock =
held
> > +      * for write; reset_prepare also when AER or DPC recovery reports=
 an
> > +      * error. reset_done returns an error if the provider could not
> > +      * restore the device; VFIO_DEVICE_PCI_HOT_RESET returns it, and =
for
> > +      * any other reset the provider logs it.
> > +      */
> > +     void    (*reset_prepare)(struct vfio_pci_core_device *vdev);
> > +     int     (*reset_done)(struct vfio_pci_core_device *vdev);
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;
> >  };
> > @@ -166,6 +181,9 @@ struct vfio_pci_core_device {
> >       struct vfio_pci_core_device     *sriov_pf_core_dev;
> >       struct notifier_block   nb;
> >       struct rw_semaphore     memory_lock;
> > +     /* Task running VFIO_DEVICE_PCI_HOT_RESET while it holds
> memory_lock */
> > +     struct task_struct      *hot_reset_task;
> > +     int                     reset_done_err;
> >       struct list_head        dmabufs;
> >       /*
> >        * Excluded BAR sub-ranges, one list per BAR, sorted by start
> > and not @@ -207,6 +225,10 @@ void vfio_pci_core_release_dev(struct
> > vfio_device *core_vdev);  int vfio_pci_core_register_device(struct
> > vfio_pci_core_device *vdev);  void
> > vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
> > extern const struct pci_error_handlers vfio_pci_core_err_handlers;
> > +void vfio_pci_core_reset_prepare(struct vfio_pci_core_device *vdev);
> > +void vfio_pci_core_reset_done(struct vfio_pci_core_device *vdev);
> > +void vfio_pci_core_error_detected(struct vfio_pci_core_device *vdev);
> > +void vfio_pci_core_error_resume(struct vfio_pci_core_device *vdev);
> >  int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
> >                                 int nr_virtfn);  long
> > vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,

