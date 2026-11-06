Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793967776;
	b=Rh9H1biIUvbh8eSc0/6CxFyMJbm0wzYrSK55KDMxvspJUq2SB+1mG+GgLNzFbPss79mJ
	 lL7qC4TOq1FSCGY7kT/Lruy5K8ZoFLJZokJolc19Td/f5S3JlgntTlYAoVo6WE/g7Hkpi
	 jUFHMLtnpOuGiWJExRF3pZAh6c43jaCSux6DuSTvxEK2uPmh4EB96sT8IZBi01JJkcnr+
	 8rboSXiDCmW7eztWAgBswD8eR8YoAtRFGv06rrRW5bdXg5Xkdl99mg9l1yCWnAzplgYNj
	 yXsC26gfZ+0Yoqo0izhVWzOAxdNMnEteQqZz7/NT//cxcbyTAASMS0EqPFemGD+MkMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967776;
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
	bh=zJQGyIIcyjicFrZuHpifD5cWuS2JfTaue13a43541YY=;
	b=QfzRDeXmJKw38RvXpV+VOHV01g3wudAMaZJ1wj58pvUkyvc9lt7+0IPnqEjGTr9JbupU
	 HChbKuVKcuPgYbWaBzynNE4FGlRD0Ipr/TFZOsGQFAel94HLCljw7zeDBfZ73N57KpkiI
	 snJ6Ths7MdHTyivP3uQ0UVMyyM2+we7gFezFgtD8elqE8YtFNmprMci24m6mxwL1YmEji
	 oZSvYTJWd0MCduxP90XuBTLkU1/THQ275gWDjMjXje1c+kPbBTB/lBlkNljs6XOE2eDO0
	 k9wLYqLWG2Hvq2ZB1FRz8pA7BgI+8JxwORQSXwUBQKy7WENB7rgJfc8Im8Puou1CtGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W8crmA2V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.3
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D409606A333;
	Fri,  6 Nov 2026 12:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D409606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W8crmA2V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXYZP2TEKoh2iY+5r3ia9x6iERtEQ4+hWk2NdsPbmMspN7ywkm2jjEyA7Oe1gukLgzQaou5z8rUmLoD/P4RGlKZ+00RzzX8YqG/mK69NyNjNjpjSDI7DwKHyn+E/A2ZLoaJunYvCdxmMOY+v+B1DbB2PxmdiXMM1/QV7qvOudci25o30Mx0L1rHoirOJULjXiMR/aQca/OHWYykFM+DIb11NsbNvlxyyzTzkS5NIkVTv2egQZIZQYzz7YGm5v9X7weY+s8lK5eCo4w6ptM4n6XMisbhwy9Z7li17Ef2uU2rkKJQ22l7wbidVw1c3xN2rViN+TpshRUPEHbEYUFNR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJQGyIIcyjicFrZuHpifD5cWuS2JfTaue13a43541YY=;
 b=yqybM4q3YmoaV3yRYZOt6wMHfm8VgZ3zJJKLkYCD/AV/oI/oA2jFXzy3XlvH0My97MTMBfppdKPMRCmZD/tP+wVUvfdhHojQa9d4NwLPdIiJsNXqh1i+WDUJWMlmvSvQ6s62MDSZ+9YlbltfosSq3NEVfliNYNSIgmig1BwhC/hRbGPHPF27yPQraUPbq/UOyrRb37+jspUdgeb11SVeOg8AZtaZ2Ew7aO+l4B8jROb73J9hwcKDFQ2TUicNpsnX6g7Iz6RwOMVBZN1Wb1WkEI3pNOzZDVP9WTtahRXDbXPmLZctIlYO3d1RCF1HCKY+T153GTkwU7iF2fyhuvlGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJQGyIIcyjicFrZuHpifD5cWuS2JfTaue13a43541YY=;
 b=W8crmA2VuKVUwLln+NEjdwfLc4J9SlTGDCmYRk3Pcm0u1chcOeZsdUSW1y1gcCnqYz+NoFsfyP0tWsm93D0Ub/UwE0MVyIeo425sNRX8E8PvxZBb4LU93h9NZ6Cgx/4RIyc27AS+kXNNQ0oKy+DiS9YBzFwjKHyxlby8Ju3x0jDe1TM2ZfO0upXrLKDdcGGUxyJanag8XM46TpD5GMLaJZBJM0NaEwzoXbxtFET9ZzSt3gfLkWK0AdH6UxUbGqP4NOOJDuDPyHYBMyLeX08UQ/yV0Ef+/XQ9jqRcJMiIiVESdF/MxuUEicdQ82o6DZcSNVoTdLCsWmi6Rs/rBYgRZQ==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by PH8PR12MB7109.namprd12.prod.outlook.com
 (2603:10b6:510:22f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 12:22:51 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 12:22:50 +0000
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
Subject: Re: [RFC PATCH v2 5/5] cxl: Invalidate cached coherent range when
 Normalized Addressing is detected
Thread-Topic: [RFC PATCH v2 5/5] cxl: Invalidate cached coherent range when
 Normalized Addressing is detected
Thread-Index: AQHdbTp2J8nqFMNt2EqwnsWnTC7cO7cg1joAgAAh4V8=
Date: Fri, 6 Nov 2026 12:22:50 +0000
Message-ID:
 <SAWPR12MB999267250680D97495D7EF734EB0762@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261105152909.53452-1-ankita@nvidia.com>
 <20261105152909.53452-6-ankita@nvidia.com> <au2o823gktor19qu@MWDK4CY14F>
In-Reply-To: <au2o823gktor19qu@MWDK4CY14F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|PH8PR12MB7109:EE_
x-ms-office365-filtering-correlation-id: 8ca00837-4f82-41d0-e876-08df3c00ac7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|38070700021|261026140227099003|11063799006|56012099006|261026121527099003|4143699003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261102130727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 9S3TSx8uvARdNe7RKh/ub4aUI+A66zvSPxiHCFezP6k/pUTDh4H2UCosIDbY/UGlLn6YpI0kP2DKCJPypRyjriWB4s7iXHBbW20UBtfJRPUs7nBtUM8fZVe+9NSW2Sooe3Fqc8mMWm230HPfccNNh46lHje/6QtqEAzxajjfn25niRC4fzUyh3B4NoLoC40gfsYv7Mysh5JN23DXNiszK3DZ3KiGUt+46DWJqvWpJMnh4yKub8Lz4wY58v6QjggDpPJbiYrbwJCfZxRL7KvvE1+Glk0iy39EeP0RxkgxOLeGDv5beLOelPJSmAO+j5OCc83PjoUeinzvFaLW6+xV2vZ+gyYaKswRFXJ+OjUocWiadqSBWdm0DnzAwe71nZmCSyS4tTLJF1HOorobJ4zuXL704AQL4VhKExwcuXbM/VqRMZqX2unbu2J4VDnn5CBiMo1Eo+MlM+s2F4YTC/qMC2WrtAMUa4ZU20MPHdTJtFE6rr1U5g+4ExfBwSEf+OPOVCmoQpSfkuo5miARy1LQswY0gkF+chHDLuDD4eo8VFKDBxHPk78Yy10ZAtk04aMGqVrMeU3eBg51kOmEmYBdY1Ap+bGUQqGFve0EZRuOyOA3+En5L500T3S7snb0dfwr+l+3AfNV10FBz2F7wsVyKs9PzrGenwiFL+kosqS8Sxpk5n2IgqcJsPVuwOEvK3GvHWhUCFrEFU85KfBmwWIsu1K6ghIBfnYSX/Qzpa4XQ00=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(38070700021)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(4143699003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261102130727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MF0evDVwJNlSh4z0Fb7+hLmlR7vo4Nd9i1D/GZpMaDMspNcYIT3ek2S3Sl?=
 =?iso-8859-1?Q?MoKbUbJfci53zq1xpJ6qbOtf1dHlccC98+3LEEclS94eov5rj6ecOgXHXt?=
 =?iso-8859-1?Q?/EEtS+YKoT7vKwg6lQUe920xkSMsYljyxHGtDwyiNQvJIJNAEOgVerHkAo?=
 =?iso-8859-1?Q?YMriUFaUxKJ+BYLPAcQ6uTT4uvNYz6W8K2b9jdK5cBeGI3Y//99oTdziI0?=
 =?iso-8859-1?Q?VlSOUQMDFwsMVtHdAwEHXpLJ/BXC9YpMgwQMutBtKUSwtoQegfwr8uSuS5?=
 =?iso-8859-1?Q?E+pYlu5AiaEDIMGEXI5jjyJqMj/7Fa1asuL8mwgasnVlKn7tvt6z5LD1LQ?=
 =?iso-8859-1?Q?X7EHM227ZLP8wNdV1FG5AyCh03Tj8bIT34RZdEfCZTyGs8AiyAFPU1EG8O?=
 =?iso-8859-1?Q?yvm5KQ3J/MTqrafjGQYLqTPxxx0b9TDDRaICxZWHttDqGDFlnGAbRu/YnW?=
 =?iso-8859-1?Q?HkVtPdCn3B5parEDUZKV7s/fl8khTHSrZzvO9TVWEXv/QrBgUqK8ybBgZN?=
 =?iso-8859-1?Q?JG55puMXfL7rMY/C9EvDtyPPdGNp0wwn7j90RjMoKUwmjl6BTMSIk+P0n4?=
 =?iso-8859-1?Q?gkIh16A5yT1Mij/GqTnOSUbp8hq8P2SyqXN1KTl6Wx0cu+9T4t8kP7Oggo?=
 =?iso-8859-1?Q?And3Nt5LAitDqBTcRcqY0nvyu27QnbBxbCA69N+u9g76LHh3P99y0IjLnr?=
 =?iso-8859-1?Q?kGtHk2EmojhQJ4sX6gupctqRlwIf77NS7Ep+skmhb3KSifCNDiXFE3WPpM?=
 =?iso-8859-1?Q?feb2O+B76SNgUWiaZG2Bh1wZPdUcoosmgHVsQktd9zYkBEswEocDFubfFv?=
 =?iso-8859-1?Q?gztJwUF9xjC7c2t+Kwa4yC/yVCK33RnAi1EtR17Gj164b5rRu2+wS+/k2H?=
 =?iso-8859-1?Q?2cAz/BVMKQUeQcZJh4nGHnXA1Bp86XvCfaWbEmGcaOZ6+rdw3eOrSsV0DA?=
 =?iso-8859-1?Q?RhHOOpxisP4zah2ZSKLQlBTReRrWLyUdcsL5RrD8eYmN1kByharQ7czDwQ?=
 =?iso-8859-1?Q?+4NvM1VvbVyoZKPARcqq6GyyYln4Hm8m9QpRcE48qHxvH9xidCluonAzIj?=
 =?iso-8859-1?Q?bOYpX+rCU/I8vBgClMXLSil6Ir6mg4DHCzqubbsroKtkPaVAwx1PGHgKhh?=
 =?iso-8859-1?Q?amyLiZMFPi+jKKo/2v1WN+pl3AbxgeSVz1Pp/aNhxH7DXoM2cPH4vTVcrW?=
 =?iso-8859-1?Q?hPDK0iK97m0PK0ljrI9a1NKny43WqfGdgWHygLzEa4zGLeHm+Y/4YzcI5Y?=
 =?iso-8859-1?Q?ajiTJWwsJOK5z/wPrjdZMyZfjSVMNEziHhuPtoIPlKXsdjcbCbSRUY/lCK?=
 =?iso-8859-1?Q?eNklAeF3E5o/zhC/FFBW0kOp3DSS4Ya6YHNT5oxogKM081Nj+SwGijEKJs?=
 =?iso-8859-1?Q?uWvJNhg/uuRnxx2uZI86LqWxy2i+bHoDvrznK2gkxAPjtwA98+6rfVlbn8?=
 =?iso-8859-1?Q?ohEvs+42nDqwUdskMeI/y0gKleffhovJxFCddM+7PHhVTCxnVtnAFVCaei?=
 =?iso-8859-1?Q?0NqV770XCsUIQUdKZcm8L32dVV5m6D4eSlWI3BXKS3sjd5eh2CDKTSmapx?=
 =?iso-8859-1?Q?r99jDuRsjHe7ibDaMVvwX0eZczV824HYLbxESJpY87zjcRh180ggqrNKK7?=
 =?iso-8859-1?Q?wOFgARGY1Szofinx9ViwmS99La6kZ2NYj0megZCnOvdIzkPVPsH9dTyc69?=
 =?iso-8859-1?Q?5+ck5LjcvaL98jUqALQEdlcJFL6O1SyXdFwqymUbo1UrDZsHICy9Ley5QO?=
 =?iso-8859-1?Q?A4vafzl2s3eJwNsc7+kusUPL/HqhQ11o0+6V0VXnJv8q1d?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca00837-4f82-41d0-e876-08df3c00ac7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 12:22:50.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCSnJVfYgMDPhMptR5uQEkzW9RPYH5ACKRV6KdvaviDa3c2leAZ1wAL3ETA8sZMYIW8Ckt/5WKItMXNyYwMMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

> Hi Ankit,=0A=
>=0A=
> Maybe we need to export the function for cxl_core ?=0A=
> with the following x86_64 config, the build fails at modpost:=0A=
>=0A=
> CONFIG_CXL_BUS=3Dm=0A=
> CONFIG_CXL_RESET=3Dy=0A=
> CONFIG_CXL_ATL=3Dy=0A=
>=0A=
> ERROR: modpost: drivers/cxl/core/cxl_core.ko: symbol 'pci_cxl_hdm_coh_inv=
alidate' undefined!=0A=
>=0A=
> Maybe we need this "EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_coh_invalidate,=
 "cxl_core");"=0A=
=0A=
Yeah, that sounds right. Will fix it.=0A=
=0A=
=0A=
