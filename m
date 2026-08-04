Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BC3655CA
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875624; cv=fail; b=nleluKic1wnZccqVbJ1VEx7854bKcb6S4Eoyh/hXy0w3zNyFKV1EtPtUxM2x5PXfsF3V2SnCgHMkbyGAxlU8L4s1EeYpSuHHe4ts9EhzFokhdDFP/cmaZWTHs5qQHFuHViRuQmsmCWOi8tdTsCESZYrhuXQAKkmq7gmuWSK8Y40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875624; c=relaxed/simple;
	bh=nzy8EsmG/DeO/ZI4JJlnryBWPnR/mzfT32FzjTXqUSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KRRv60PTdqhKGFMSqr1LP1yMqoGYOVmOypABdOacDA+0/UfE1Ppqo+ptcKelpKuVPSewE63WQhyJ+e1oKp/n1OARjzrARLpLAlzQm19IB9j96k2o2G+KOKKkCaDL8T5SmUSVhXTd4RqqTQn5WxUBgNikuCiQULIMZ6JywB9vEWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZF8XBF8w; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZF8XBF8w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8jnVOFzvCZxjmK7OpYZ+BHkIbZhI0xHHMGE8zHLTsxpMFhrzORXY7bbky7abhA1KVxfBX1UVo+Zp1pAFa0M2tEhr/aZ99Dxl3Y5sia+t+cnjvECzzDWtLTU7wzOq21C0mTC4eOt98lCv7id6Ueiiux48B4XUDah/xuTcmw2QAo/F/Jrzut0imeYjABNXws0/G7P0rJC4jBjt3sLCNMKskTThxsVrRwU9kaF3ZeEy+2XpfWGcGKRyovB8eckeeDZ2B/BfKRjFaXzp0FRh/AutNSoXD6dQSEsvOsNXRmELkm2+w/E0C+aMXF+2MeMGLZ7t1MyWI/cukvsPxh+rpB9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzy8EsmG/DeO/ZI4JJlnryBWPnR/mzfT32FzjTXqUSc=;
 b=Y+okJ4Na7MdHM37TO9RIR9g0Tkuo85hO3k+gz3USW4mq/TSk0gjmQjlcpTlOMqvTQtekmItYH2qkqzrh3EKyqbNOLAwJYQiQKAkHVuoN01Mx9D3l6Ls7YxoodR1JrhUqDz9W2SBbXpV8+yibyw/XtuIiG13Vz3Tn3xwDc5P1jhFyTiMsKCCdRUxnHrieOubkceMe44bOC5Jcnqk2uMQ8KMuIjQm+y1Wj8uocLrSxlH3o0BkmzykSzgI80eKuBcj1Ufxj+lgy5MsbUY6VQ8lqFQMKs4kARkzNwnzLde/li4G2/btq5o6SJVIo2xgxv4z1ckMj0X0VYHgVvw343SMvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzy8EsmG/DeO/ZI4JJlnryBWPnR/mzfT32FzjTXqUSc=;
 b=ZF8XBF8wdnSbQqEFaIVcJznC4a3aeCyqoUlbmft88V2yvwrjiBl3zd1WddDMbMTCQW4c/VS5B6/pS3wI7YK0pONGuFQ4J55t4JiqKKJSa+3UvXJdRJwYlgS/1Q0xMgrgrn1fp4V0bk2SXeYtGZalev/6CiGjIdLgNHQBP0TnlU/D2UL1FWQMexschJKjBIU/HuHbuaa11Kl3V7vT9bIgtfjtiZWBQ0e46r1MQl2UJhLbAQz85MU/olqbbD0R6OwFs5KCIBsSy5iOQ3g+r/LLlBoMQw3ViN6WKZctkB2GkWZUZSlXloAFOUe5GkrjGc3Ga5JUNNInHuNz+rmNQoaY6g==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by DS7PR12MB5741.namprd12.prod.outlook.com
 (2603:10b6:8:70::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 20:33:35 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%6]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 20:33:35 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Alexey Kardashevskiy <aik@amd.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, Aaron Tomlin <atomlin@atomlin.com>, Alistair
 Francis <alistair.francis@wdc.com>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
	<bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>, Donald Hunter
	<donald.hunter@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Lukas
 Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sami
 Tolvanen <samitolvanen@google.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
Thread-Topic: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Thread-Index: AQHdDMrOwfwmCkkN7EeGRZV1a3LRYbaCujkAgAD+F4CACZTNAIABNzrX
Date: Tue, 4 Aug 2026 20:33:35 +0000
Message-ID:
 <SAWPR12MB999267F65E7DEB49B1F4D9FD58B0D42@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com> <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
In-Reply-To: <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|DS7PR12MB5741:EE_
x-ms-office365-filtering-correlation-id: 66f6dec5-7a9f-4602-0334-08def267a84a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|38070700021|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 5cTFJAnhmU97DKF9+viIgDGreyG3iWzxqvD8QXSEtJtQLqh3oyocN/fQP8BaJBXmqFDSzmnaovCuMPzUyN4mrxl8ybOW9IINTPORo801uRFL6e0WOmsonm/gN+Wnv1ocS9m+6O9M4BQyPudfBd4U6bcwy0+K9Vf5pSmuDhd9PA2OBW9XI1LANIUNz7NLixllVNsHChsuOxPUinQ5DIiuXHnI9GzQ9GQS5Y686W+RlsYT9RPTlgKRngXui/LU5puHKfFF7bv6XA9s52nKZVh/pCAHhANkhayUAmruKBp2NHL1hwb7XrJxs4rFVxsrKaA7LRylMjCvUpjswy888LWw5cwWqPXS8BKS8fAOpx3tKSdv7uJwl585Wab1F2Kou1Rqj0tQJYA+CT2ng3lRPT0jbAQuS34JAM33GCJXiKdnug59xgDTshtzxfU5yKd5WhvWjh4L+DfhHNG25wH1eelQCi24AAU/PlfRkBqouPperfXExzOFncyi2BW3omISQZm4yYSAfVEKeMDSXXVl0bl1nJ7j91g/lCf16KZFJVe44h3jjdesVV/BeeioubkJwoGrAL/2ChNq2Hndxcmfc07nPpKDQk0NzOAtQVBRWxU91cMqni+xPRlZW8pOPUyE7u9lxitYPfBrYIywMsL0meUVNfOjXVy8uc6CmBH/LvQYf2pLGoHKH7Gs0U8O7M09fz/SbU2c65sBxQHIlGGp32DkKe6EKOy9Di1MYFwCKJSun0w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BKik5NDNhxvSH1CN8bNfTmpu1d0j6YGrFTO7yYYTYmqPXW/a44EY1HQrcl?=
 =?iso-8859-1?Q?eCdnLVpZBzabczXjpX0yWGkBkmeMXyOJe4v9b8F5QELxQZQKLD/EHTgi3o?=
 =?iso-8859-1?Q?9sNEfl+JmEOO7o16R3L/p3FJn4zfevO81fpUB7Zi26j1MdImmF9poa9xU2?=
 =?iso-8859-1?Q?zRnBqcJtqrUE05JzMQItJOXkQH4TA7B/vseQLgeZzii01eR6YhFg6wtZZV?=
 =?iso-8859-1?Q?6e7a5LMTQUwSXUa+mfKXZsU1EwJqlERac25llajt9Po5Sx3rE7YwewoNNk?=
 =?iso-8859-1?Q?nMPSARYRUzyIsQb8Ltl91+3HanRkdiVCVfDWyhB7UqKAQdsYfkpK59bD7C?=
 =?iso-8859-1?Q?L+dPs9MBRbsXgCYU9YfH9htgkvAAkFHTHnUMqdINB05dSaMz7lizJRd4TY?=
 =?iso-8859-1?Q?Wel2TV2CCNr9CutoNUW4kR8EWT86/0fprtSj/hXeH3VZqshIUKn1tqX80H?=
 =?iso-8859-1?Q?zy7cqVyuhymE33SK4Ji5vyMmsM4TpUoj4zvicxaL11x5Pq6gV/YiOSs9hZ?=
 =?iso-8859-1?Q?d0AePNIHqiS/mmiw1BvIwzINfl7RoyNzXpgOFu0nXECUgPLmrGWcOcdnKV?=
 =?iso-8859-1?Q?ogsM+GDDV7S4EYb57fle6daletkTDfcaG0/J2PCqt0VR57LXI3ZCRrdm2C?=
 =?iso-8859-1?Q?nGSScmsDUVqlL66nS7o2GHr1AhRYAFflSh+24+099UIZx2lrZGmzY+F3G2?=
 =?iso-8859-1?Q?BgJfiTHoUGSDQpAXtW+FPZX0eGWc0a5jkk76mpdAvLd5AAMwxVJoJDa+d7?=
 =?iso-8859-1?Q?37brePpUjkBP6dH+zPmnJnRsEWxEnEHqsq6tK5XBWEjnSRC5Qr/XAqJCam?=
 =?iso-8859-1?Q?GP5hlTcGFwfDNtOdGEpSc8p3KTfpTQmsFesYCUypNyZA1RpvuSNCCT6ule?=
 =?iso-8859-1?Q?TXP8IcS3ayOhl9UvlmTbHbpPqOpBXbXAZlgw3tgiFy1p3J4UnCBW8xDp3O?=
 =?iso-8859-1?Q?xSePRsTs4YSVmoT7Hw/65ZPWj6OG3tHN8WL1h+fNEI0ORTK+B9wX9FDRU6?=
 =?iso-8859-1?Q?2MKED+1Ym3JvjiP1p0xMCMrd/JiCDHhgytkPDjICbwc74simkny7UPhaQ6?=
 =?iso-8859-1?Q?DCdIYiTvspEAmNWDYXkX0SvZBDEzqA03ZOe974n+Xpac7mLVacm5pcKHmt?=
 =?iso-8859-1?Q?AVDrjq1c+hthcgY36N8Wg9wTfEnZBtSvea8bNQQJqUOZlx26cP10UDmr9z?=
 =?iso-8859-1?Q?nKAXDItWqydNZOysS48FyS0LMkLQdz0DXKihD2VmUpTkpM0ShL4AJ9imQ4?=
 =?iso-8859-1?Q?K7/gUk+WffhF+RrDjT8Qj97pM4olW9ZCLGC4R1/ZqvRuuZbuKwyiIwApmg?=
 =?iso-8859-1?Q?GJj31WAJ9er2g/MDYy4xrVxLahQUex8QzoNbZGIH4qZT27Z9ouNpcKKToH?=
 =?iso-8859-1?Q?BFegOT3rqf8UGMWT+9m04r+bmQOFNJFGRf0nkBtfGcvqTlweYFVnB0N6ff?=
 =?iso-8859-1?Q?BLEYjsSsKvilqnd5jcmC5CpGjDqu7fIfVB1MD+KZAq+4M26bZA1ga4mKrC?=
 =?iso-8859-1?Q?W+6fppnfB3qRMcuFSuDNHTlERk0yODWHtMmL4HRGTRskSJdQU1+G+EMPQY?=
 =?iso-8859-1?Q?pVzeXECe+Ig5ce+pe74ZVUSlUgG17Ku0ECOK7yJvPxV01+XlSrRQIpaiXC?=
 =?iso-8859-1?Q?lDkTOqbJE1Sfmytoxuk9Ua0rO+ZH327BLQMgu1xIv7MIXIbEKiJInnA2IG?=
 =?iso-8859-1?Q?5FL8u9QlZY8GBU+iG7EUGdZnHGYaxJSfzeLQVvkWYQdQBq4y0WHpagass9?=
 =?iso-8859-1?Q?qqJYkxA8jf/gOS21KVhAfL6jkb5bVgYFM9GbHJSnu/kydj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f6dec5-7a9f-4602-0334-08def267a84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 20:33:35.1789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oC94ke0OJOzEy5fVXxJCEQ/efknZnz9tuiD6jQD92P4XB1pPNBIVo0eiHa4DeGpJUt+CY46dKZrAEOG2dTaQzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

> Hi Jason & Ankit:=0A=
> =0A=
> Glad to see you all here to make progress! Intel can also help on this.=
=0A=
> Can we have a meeting to discuss on these topics? As Alexey mentioned,=0A=
> previously we had a bi-weekly call, perhaps use that for our first=0A=
> meeting? Or what time works best for everyone?=0A=
>=0A=
> https://zoom-lfx.platform.linuxfoundation.org/meeting/93219227394?passwor=
d=3D80705486-101a-4e19-8f11-0baaf92104be=0A=
=0A=
Hi Yilun & Alexey=0A=
=0A=
Thanks for the suggestion for the Aug 6 bi-weekly call. Unfortunately I'm o=
n vacation=0A=
for the rest of the week and the meeting timing is inconvenient for Jason (=
PST+4).=0A=
=0A=
We can perhaps consider syncup sometime after Aug 16th. Does that sound fin=
e?=
