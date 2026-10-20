Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487665;
	b=DFTs8CGTGJ8qzr5mH0M6mO7110v9qURGzuLwUU2GphU+59JpmNr+a5jy1ZVCiZTccBIA
	 S9F7yZfJSSbVpt29+n+JLbTNogCRWFN6/OeAPtppfTzXL9K2ZoLEu+6s2jtjmq8llLA7s
	 pPQ9p43ci1fInQeFjpcVRGea3olq6q9bC5Irool0pW+Gwb+rnCxAwXyOVWFSI2spvodsD
	 3UszPC3cbvBvSsUBJC89x0PnLgQchipxsgiZAiqueKoEuzx1+djZ0MHarmc0BemmziJzL
	 17dxfpvuBaeQkMrLdGDr3V0DtMmM4FVnUOr7CW7tBp2CHdmT5KQNH+U8H3Iq1rrYixA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487665;
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
	bh=1bljt0UjddDxq+p41LJaeT1FGzxyDitcN9BqwbeMpZg=;
	b=xGS9ehv8RslEhCKpRr8DvBuVVCdq8iO3wUeG5lXLSJCBp3pqqlAwJPL+ueh9a/rtF+Ls
	 e8CvfASGglhudF73vRVLmhMmO47xTHMd6dqplzcL+x7otswmtdsiG7R6RaxMkEBvGN7e6
	 qGbWVq5vpGQAbFLVSZk1ItJ5jWuJ+BeRgUHO0+nWPeBqweTM5ux8SpgaWhnxmny5BOwJn
	 WLC4a3EXig3KjfRANFHgsgJl0cTR8Xy1C7HfL4aElxlFfvZyXkz8mrH04TUbldSO12R0w
	 ADOc6l0V5TnXoLyrIGXaUNSswm8DuT2TQF/IvQ6HJfLhy0qYnDMUDpm8lI5l1OU8Anw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="iyAOwUr/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.42
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC96606A32A;
	Tue, 20 Oct 2026 09:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC96606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iyAOwUr/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsLJwj/eqha8x3XF70eHDuE9mXDnES8FKzs3zAYDnL50ZgK5mbHuViXf1+0pPLhEESitV+aDR33/Szp5EfsF0v0dWfDD6QZWJG4j38Wx1bqspmI3YyHvIz06oZbM8AE/sD0M3RFhrxiJ8UIhirDakFLXQFnLKVAEROT68zU1BcqdaetHMVDGDJecyrEiWAZi74zD0b46NzzxJzp67FgtZqd4yt1QeHD8NeNl7Bs63dDdlx/kBJTuJsmlK1pvtzvmogz/iLIZb7Up4A0hh/N3JB9d13h+gxNxpMASIiCLGAATQBBZXQax7E/0prrXB8ECElWEoCnuS6N6RnZbWoFcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bljt0UjddDxq+p41LJaeT1FGzxyDitcN9BqwbeMpZg=;
 b=iRS3Dvoet/AsrRtT2MnGPL9vcjkTM+PPC8BxFh8rxKCx7g+CUlEKzmKeKKWNU2dlrdy4GYFJaCQP0numS4UT7vB7k77xcr1nRiSu+bVI8+2dCIRHwVjDDYXyjrQclmSra0DZg/vG6mPIF6BPlPEjzKKQwokR9ZzZVMbQCzoEnxiDphbcTyVk7Cux72fxRWWzAavQ2dreqirw6vUC8VRq32zvgE5+KPU54GLicnS+JbO2nZrdeAGlzOKlehPgC/3NG4bckCp5Kwwf8uVOuIYiWKHvAAnvj1hoX725Fi9D0j37Aaql/zPRSgcTOEqNCah2JFfFzI1o9l1dShdlyKT5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bljt0UjddDxq+p41LJaeT1FGzxyDitcN9BqwbeMpZg=;
 b=iyAOwUr/VuqI6q5SVQPfgUq6+xNhEGWKRVHCjp+kMzgne0Z4N6DqX1iZLbQ6B3Da5fwc5Gg0RJJSVWEfbyvrPWRIxTTN8PBfx14CDtxzzHmM+cz9dn7C0EDFf0UwqxU0PY2aaC3qvdyk38NCIZOXKvSeFZ/ZZiG1yM6U0xEiKzExVtgtUM5lmAvB8yYFTHDYSxIo63DZZGGCfKZ325ZAO1iyJlpgcubSpk3dtMny9TP9M8KVBY06EXmi4HcpW60NhyHIR4oTInxKminbgU/SCNChwbPilxX1tcJn4eAhodzLxw3zAU5VFYk2p7PcpykAjYIkexxbx50vpKJ3XmH0lw==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by DS0PR12MB999082.namprd12.prod.outlook.com
 (2603:10b6:8:302::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 09:14:21 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 09:14:21 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	"ming.li@zohomail.com" <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 3/4] PCI/TSM: Derive the coherent-range IPA from CXL
Thread-Topic: [RFC PATCH 3/4] PCI/TSM: Derive the coherent-range IPA from CXL
Thread-Index: AQHdVJeqGblX8LB8bEWpiS6+ofq1VLb6VKKAgAvmsR8=
Date: Tue, 20 Oct 2026 09:14:21 +0000
Message-ID:
 <SAWPR12MB9992673082391212DC2F41A6E2B0672@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-4-ankita@nvidia.com>
 <as0zRXh5f5kjULVI@ashevche-desk.local>
In-Reply-To: <as0zRXh5f5kjULVI@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|DS0PR12MB999082:EE_
x-ms-office365-filtering-correlation-id: 53d04536-aafd-4bbe-5731-08df2e8a86e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|10070799003|23010399003|376014|1800799024|20052099010|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info:
 XNjy+gI0gTXHGw1lWyBdf5jr58g9sfEtkEu9Ndwf07Y0erkc26TidgMunmtiZtnxGM/aenWNPpd+XdOWb7vcxwG92f+yibcs4yW4S/CLptwK6+DNrbzFGV+1AjFbVaxTOVJYGV32Rry39sPpkfwXwPlG6kBTIb8b9XT5gtC+hNx3w9CL6epKRpxEqzWtmpLzKrYHlCZuesOkP1vr398hoNQ69FB9zZVsFgxd8fX9RPY7BY6tp/6ySGxx/6TzUocp2y2AhGnp5bsetZbDVK1KlJokFISCCjK4p5RbOKqBLdQCcrIjX4I7IoiPpGOysk4ATs1uDd+UKXXrWcoEi+C8XCKR8e4RG6PUMZEvKft+8nozAwVjYPtBrfSa3s3hHvZ10IgazRKRYebyq3/tqeWaGjJuuMiIGzC012L0Nue9cLzDBPpqxSf50mTGyYHdUOZbx4MuOuwt1B4mmC7UWCBtpABaysBn2mfdXCX32+5PzOAP6ZNbLU2JIG7hHtLSIwlMydEDMWcWlDnxDHNKg4h+aZ7p8GeZZTuMGi7aRr5YKIPipoweWGc34+Or8BLH9Drzek0dyO6Hr0QfZE2d10aZGC4qPfBj9MtQlOFCAIFDr0xHO6FixT30HzNH5P0wGzXNCuy5b9pTMrbvVq3FlS9GVg/YXeJz8t9WXR2GDyp8Fm5Ulb/1aFS8WrYsH/rUANeCxIV1ccKz24skNDCw8d2H0jG6TSNRPjZayZrU9N2KBok=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(23010399003)(376014)(1800799024)(20052099010)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Kcv8WZiayeS8fTDNUwZsM3XSAFpVEPkcb6Hd5/i+WDtXw7rclKmOqk7xgX?=
 =?iso-8859-1?Q?4yhY19yFY021HUVVfOSiYzBdeS+pcpQSxuUFRGm0VOl1pfi9JDK0JayLHq?=
 =?iso-8859-1?Q?aTMVWXm44xLcUgBYN9g4c9yUvtjc6OY+s+Jow3YII/jCb/i4VaQUuCnd1k?=
 =?iso-8859-1?Q?hSVUFaSfhiSW122hs44fkW4hbQT9Fdr6S7a2+iPaADXFrzC2GboUN8MCgE?=
 =?iso-8859-1?Q?Rs1UpisbmiB/iTbFqMa/RL4yZ7bfingbDpYAgcq0NUXAp5PL2zGnDEln6F?=
 =?iso-8859-1?Q?Z8GFZnp8BEZEt0OdqpesfztH7FdvkmMXK8juk1aOesr/PSd/uTXj0NDnKf?=
 =?iso-8859-1?Q?pSDoOEXe6vT4hg4a8aozFTdKpFGsfAlUHydvMeEzaoXkuOl9gKckKNEWNp?=
 =?iso-8859-1?Q?JATuncAXOxhOszfBMH9xgPSU8SAvUHC6+9hEN7bXnf4Vc4boHENGGyk0A+?=
 =?iso-8859-1?Q?oBTbNdSGHfM7TikMNoDfylSk3CreyNHxtRcZn6eKYrpHGV6DWfxo61qHoH?=
 =?iso-8859-1?Q?xKckTtgoaCSPZrmzi3FMvWVde54yyb19EeJ7rdiqfihsn9WZ9ERVotMVpm?=
 =?iso-8859-1?Q?GWur8Q2WK96oHYbdvrDyzeK0TjjBmJ1tTNpdRBtmCsKScnmqT0BXUBGug5?=
 =?iso-8859-1?Q?gTUc837eZ0Lwf1iVZxMcZkjQ5u8dNwN5aWYIARYuORRXSxRSfKgfLOrMQ8?=
 =?iso-8859-1?Q?g0mIxC/XcJqBiHQKOauy51zIdL7jMMBjjrUE6w5Xx82pKpuC+3nPvpaVV5?=
 =?iso-8859-1?Q?xBv7o6NhpjGNgDu6bMFrQ3tQa3kwMRW8h4JMmHxmRQin8L8sX+YFYgOHuM?=
 =?iso-8859-1?Q?3iRuuh0jDi6g40W5S4klEfdl8MMGUbOtNqHKkVieHZ9JLZZdZI66znIsaT?=
 =?iso-8859-1?Q?l+29umTSrfvHsGs1xdFxz45cCm91WbHlF1iRvxwGsPyuKm/V3If2Gj/fBe?=
 =?iso-8859-1?Q?I/B8gamX9s7kIlq+i5s/aOLqrozcenWYSfH3HGgJWc2qUSxu9yyaWM4qWq?=
 =?iso-8859-1?Q?8QhUNAIJvEml42JrQUfvPsZT8eRe8oPfJ4DdcsdLz8+8AFqM4KZM4V7DU7?=
 =?iso-8859-1?Q?U7Ffh6gaK+x2p/e97P1QiN05SaEBEZln4sus8Eh3wfEEWk6KViMLvhdoKR?=
 =?iso-8859-1?Q?+zvwnO9b6GZ2YtODmcNlM3ITMTipJud7M+c5WaFVF6eqSFzw7d/Eqepjr9?=
 =?iso-8859-1?Q?XzLsWCm2cZCZET/OIHFoYSuYQEqNWG5RzTdXjhtWXGUZFkrB4nYXMdf0JA?=
 =?iso-8859-1?Q?cchKVogEj3f+Al00tn5ye8QIQfvoxS+aQve78QPJ6eoMmFwTLh5woUAhOk?=
 =?iso-8859-1?Q?oO2npxYL5zUdFgTNNYPlWu4n/wstEhSC+LH0MN914H2Sf/eBaR7y+xDvLC?=
 =?iso-8859-1?Q?Ed3YgT8LmUXXebV6lKrv5GLOPGEc9ryF3M7QdSLMJdH5pEuyckKSeAKqE8?=
 =?iso-8859-1?Q?nualwt56GZvIQ5ZmiGJGRbKWhwSVQWmVD4n565lPfe+RKE1MmCKMnH5pAP?=
 =?iso-8859-1?Q?/1YvvwZAUyGng3ETr5TBXWaZkYYVpZrYMJwd7XUTsfqsa0bSe5lfs102OH?=
 =?iso-8859-1?Q?YKRVx6D94tEbAXRL8LNnOBo1EAizBCB8c2WKwiMyRsv2yrSuYPedwMv69N?=
 =?iso-8859-1?Q?t450NFTC5NfiLvSAKfgrz7rXYw35RtC3AP6Z/Oif7BxfHZSBhDDZNgzZ1+?=
 =?iso-8859-1?Q?L8kJgIq3Q7UvlOwwuvMQV7x+Rp8J/CzgaQEPThYAILHjqqTMvoQAApOBB7?=
 =?iso-8859-1?Q?6cD7tb+XpR0WHinUfoOh6k7ua6HZSRgzIeJ09Rh3RpMsXvBGFDBn7NILnM?=
 =?iso-8859-1?Q?UsUwRUJ2nFOm7kDt5y9ugzgjiem8CwCVgx3EXLqZTUdBaGD6KHax?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d04536-aafd-4bbe-5731-08df2e8a86e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 09:14:21.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csSMvTfueCtb1czfKBgRj3QJZFFs7iKS4/Kv6GYVtahZ7xKlNtSHV8tSMCBAhc8xMb33IJSwqcCTjfu+V4a06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999082

Thanks for the review!=0A=
=0A=
>> Assisted-by: Claude:sonnet-5=0A=
>=0A=
> Assisted-by: LLM=0A=
=0A=
Do you want the model dropped from the tag, or is this about=0A=
format? I followed Documentation/process/coding-assistants.rst=0A=
Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]=0A=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (j =3D=
 0; j < PCI_NUM_RESOURCES; j++)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 if (resource_contains(pci_resource_n(pdev, j), res))=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
>=0A=
> pci_dev_for_each_resource()=0A=
=0A=
Ack.=0A=
=0A=
>> +static int pci_tsm_coherent_range(struct pci_dev *pdev, u64 *out_base,=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 u64 *out_size)=0A=
>=0A=
> Instead of the last two you can use struct range.=0A=
=0A=
Ack.=0A=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (pci_ts=
m_coherent_range(pdev, &range_base,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &r=
ange_len)) {=0A=
>=0A=
> I would leave it on a single line.=0A=
=0A=
Ack.=0A=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 range_off =3D coherent ? tsm_offse=
t :=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tsm_offset - reporting_bar_base;=0A=
>=0A=
> Indentation is broken. I think it's better to read when it's a single lin=
e.=0A=
=0A=
Ok, will fix.=0A=
=0A=
=0A=
=0A=
