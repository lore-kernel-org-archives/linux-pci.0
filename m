Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA03225403
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785694335; cv=fail; b=qBucViAFgWZqhSxmslsZFL4mYGsAIWVTtGY2wFEwg7yMBlz2jw+WVzS73faw0qosP+jxXORoFg0t818FZeDhsBYbGvD0GREylaKBYLAUn1vSVVaPoz/2Rpv5bCOb4p7DJN+DkTKOJylxT2YxRk6bsHD3EsLTW5GtEUiSCkeq9qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785694335; c=relaxed/simple;
	bh=oRDW6V16PGYXaKRTN1IQECXRkPCdGh1yu4m/xvWikdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oqPGRUOMCUAc4WFoYSKpzElNUCWaLPjgxcjJpwUTe5DdNC6KH6+2Ey/3CqVgIG1KR/yimkfmamyRMWFsBznMKeBBcGjsIVZiNCGIZFbgb44qwKJvEBaA25V11nkkl/FtA0zjORN+78sKNT68OIlm/dJyC4BfD5dACwH0MTqhOIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ld0LvBEj; arc=fail smtp.client-ip=40.107.208.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ld0LvBEj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqKznHsc9BHdUlJW0xUqytkfFLcFCrPVF9g2cRj22JWKxWnHkU+gdBglLorkjw9pv5LWgC+fyt4U/Ww9pLrzTVWAIRhkBEi7KJ9l0W9OdgrNStBbokiOAmQGwfq6vyrXF2K68bf6zMhH3pQ9OF2uWQ44fK6Ku5LWNQOG5ZhrD4wzRKPoBT5089n6J7a+xKVpHea2ArR9b/PYj6ihfGf8kv2d6/UyP2j1qVr1b8Tt+5UayGku+Nig12IpbAccU/q79at2WaEUIiOKbGiP2J31ka20Z1VOqB9bQLX9Ew3LGZDQi0WTBVOix5fIyl4knuLKcJuFmReb3hbCijYrzMSeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRDW6V16PGYXaKRTN1IQECXRkPCdGh1yu4m/xvWikdg=;
 b=e0QUkPb8q5w0ZF3QLKCrGoJsXkYlIA8yhA3I2Q/5ZMc0G1M87Mkf5tMpYQAdbvcBzIFyC58uKoRBeUfTyj6WHQ+7Rqh8iZpJBDmSFVqKnEMCu5XYtiiIryTTcKRocieag8a8lfuBGw0vxdjKRql9gZzkCsJmsc3D9emnsFlieKpE5oSAKYSdIHBZdoHJC6rOm7NSDpjvtmXMKw7oCiYMnFBg0xJ0P/LN37y8uY8cHoyHHULbDabXWP+d4JVvx6NyY32R0a+aMK6LCi/00BAWtOh41zbDmglEblpHJT7zoWqvgzlf0cGKYwWI7BMeRfNL4y3ObZn1azGFgK5x2CEHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRDW6V16PGYXaKRTN1IQECXRkPCdGh1yu4m/xvWikdg=;
 b=ld0LvBEjl2JIE+Y0OBroW5cpWyPySns/UYdegNKWT/3IHO5tmjqAom6Fixl226m2lhB4TJr8Oqbd9/21XJprmkOLx4jHwXJbt7veCMBLWcYt6to7a51TzhCBmYJzlw1J9Q585waD+JQM2AxWW6KZrNBunS0IjI+W4WYg4f62ZqOTgKKlsjvBY22L5Khh4eHl6Uwsy533cE6O3yUyH9peY39GPFJYvz9f6oaXx7dULE/QdvUcA13BLi3Cq9Dgr8cyQEakQ4cMthp+nhr8He9R0CthzAEAYNDKa23u6FeRZ1WVhZTvSjjs4M/MoBOayObNPqRHLjjihe5YWIs0hlp1Nw==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by SJ2PR12MB8845.namprd12.prod.outlook.com
 (2603:10b6:a03:538::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 18:12:09 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%6]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 18:12:09 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>, Aaron Tomlin
	<atomlin@atomlin.com>, Alistair Francis <alistair.francis@wdc.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>, Donald Hunter
	<donald.hunter@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Luis
 Chamberlain <mcgrof@kernel.org>, Lukas Wunner <lukas@wunner.de>, Petr Pavlu
	<petr.pavlu@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Sami Tolvanen <samitolvanen@google.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Saravana Kannan <saravanak@google.com>, Will Deacon
	<will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, "Fontenot, Nathan"
	<Nathan.Fontenot@amd.com>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
Thread-Topic: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Thread-Index: AQHdDMrOwfwmCkkN7EeGRZV1a3LRYbaCujkAgAh98Ws=
Date: Sun, 2 Aug 2026 18:12:09 +0000
Message-ID:
 <SAWPR12MB9992676CE5F9BC9CAA15591536B0D62@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
In-Reply-To: <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|SJ2PR12MB8845:EE_
x-ms-office365-filtering-correlation-id: f0cfc7ab-a59b-4081-cd91-08def0c191b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 3I/QUM1tbIX6hHT1IPev/dLRkyWJcjoKVJOqonSFJlNxiPBSQysgwx5PwSck51tn/FwmB9jTf7HDcIaaFmQzRV4enuBwACbMZ+ZrkOvmOcvmHGNsEF81fRl3ZsC6xt4owleZtyKVd5Rvj6croJWmCxOuy9BomZxeq/DiAbhKthuDXZrJTVj5RytPYXpQZuGnW0hBYw+McsC3U7vWYMT184BHiFc7leXp3iG25ihVuicONxkq0oK84mtSVxmEKdLUF8LJYgIP5GJcsLXEpo89Zj0am703ZxBr0pReMpHn8a4GsyntPc7+2Zes8cF9nIbmSdgxeD4bSbZrU7ROW4CiXYuH06byrwUychyppS9Db0k8UjtaIQ1VDciCl1Q9iDTHuoUd9st/T4E9NQzkFsC6Qgit7o/t3vkddlLaDjfRODYH8rlzIdxQsyZx5gNMcwnqM9rXNJ5d6gliVvufMqasHiWTcbuflJyhSms4s6+qSOdSH7QAU6JMxFd9X1TGWanqUkkAw3EJ8UMsebnj1I1vWY5/t1p9Wex8KKSwl30TjORef9pukIA+1kl7pfMWFGiB8E/n+sUH+FqLzDFGr0Ws1wD1ycPxONhsi6scCBqriBDtFZwK9SB8YV8W9gKc1uzWrjEOZwaHtvKUb/52PmN2wV564dGe5POS38skaqblTyZF4tJaotcSoksiQYG8Uc3ERqXLKXMjcEYNqCjUcxzH4VBYdmivz41oYRsipDrjYHA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?y9gtodmL2AgubfXeY+0JdhpqiKWUaR6DA7x9aCTvJ0jXDtNHutBLu17/o0?=
 =?iso-8859-1?Q?a5aPP8eAbNa0qz2d39Rnrd43Vbl/oGo30uN54pBBua4wGMTC7UHSjXj7pz?=
 =?iso-8859-1?Q?Kg3vwUKST3npqutUEh20kvTl/IUd5aarTawQxKo+1qPz/BzrPEnafDM7ml?=
 =?iso-8859-1?Q?PICqt/YUuIA6YjVuFy2KOXj6hlm2rHQPsH7zjmXwLE3iswn5Gn9INGJfF/?=
 =?iso-8859-1?Q?m9R4o9A40pVlbPX9MlWR+Aqbr5XmxxBGjs8JSF441kM1lR/bVJ4gCmKvpK?=
 =?iso-8859-1?Q?8sjvNqdPAA0IIxdMC7ugc+35s+eHGgoV8z/ASFxPrBwpgUyD5oM3PIiFS8?=
 =?iso-8859-1?Q?lazrhns9OKICw4gy85NYyWYtK/ck0hCgaaxuQvFTl/ZeTBmjJWxpkb4IS0?=
 =?iso-8859-1?Q?iFF4mEX5JPzVhj3fCDZzN7GG5EhpLL+GiX+laeqKEh2S/WbNEYYAJGi2+z?=
 =?iso-8859-1?Q?2yGYHn2VamRvgboOZa5uv8va/r+uMn45R0Kg8CAUb/QBdANCF4CpDy+2m+?=
 =?iso-8859-1?Q?s6kYIntDkwIrOK/2ReExATfYBVxBb3i3ZLPYMZKJKB55pKDaKzt2QYf9UU?=
 =?iso-8859-1?Q?02hmRVfXu/PCH0RXla2CFzMxNPV5iVEeIL6CghZBYgIb6/xnq9Z6Y5E8dI?=
 =?iso-8859-1?Q?uudWG9JTue/zWqWLLuHfnCXPPaQXzmmU7J9hmCxC/g37zE6hql5ptV+foZ?=
 =?iso-8859-1?Q?Qudvc3t/u00Xd1OQ5PtV34JhuaWFvpPj7fL/bHQEd2KIqyg3VtYkKoZrIN?=
 =?iso-8859-1?Q?Ut9J7W4FFOOBfm1MszIXqK6s4TBgYOcX2hz2gj1b59kbj1Bwbvz9xNzLVE?=
 =?iso-8859-1?Q?zDmEfY7o69/3iZEzLPHVDOM4Ji1SILjtI9/Hoknums/jtLojap3JJIxEJM?=
 =?iso-8859-1?Q?mXp8IqHFGrH205qBDfjjIbT6r0zc6knIhBc+9qwFAKSZpKkPdOBotELhxe?=
 =?iso-8859-1?Q?6CpDn43Z6VR1e+qA+FZ+rPNJ/QcV4ASSqCWB0xwc36ZeAg8oyCI8uUhCXx?=
 =?iso-8859-1?Q?np0z/MLmpbSbzScAqOfBL2LcbRF4ssKI90wwr2fATxg0Wz22hPJtipu8Hp?=
 =?iso-8859-1?Q?t9Bpg2ALtBQb9aJ6ZHCO/4fh7lOxEztxKlE4RxkUqti0YpPIj3eLh9m6LT?=
 =?iso-8859-1?Q?pak07FU6KItDCRFohLpUKbneGxjfKJ9vsTS/AW652Gd29Xs3nX8Uq5lEvx?=
 =?iso-8859-1?Q?Jdz0jnVSjSduzlAa4GGehXwj8Xq/s54xfco4k4mr0NyF0tQdOzZA7ZNs9W?=
 =?iso-8859-1?Q?tLNT2RTXnyZ0NXBgMOKeG+rQBN4Bj0X0LVacgMDifT1+px4beUYfrx0K5u?=
 =?iso-8859-1?Q?1C8CcmjWz5F6tdTz0R3EXjfVfHla7B5GJaOLTBXaS0KTnYo8aVlpKgOlya?=
 =?iso-8859-1?Q?IJhU96VAzwU1XX6c7t3uG+/ZqPy1HYtCr2L9DgkX/yyuo3Emk71V3vx8PV?=
 =?iso-8859-1?Q?vurt8Vdd69oT7wEs1OCIGd7W3upxpPgEiY8dPwqbx7wCoBFUVHo8RXNAG5?=
 =?iso-8859-1?Q?EZ2OATLMXthyNj0MDZvlnbcXppUPFZFQfM2P1ebrtAWg+1A3k90YF5k8xq?=
 =?iso-8859-1?Q?XzyDZG+p6OgFsZNEfG1sNAqY5W6Uhb/zdSxh8zpnGJdbFcCLX5vjvI7ffN?=
 =?iso-8859-1?Q?0rd/1FbmoIE16oJSOHOGRC31axTcl6QmRBPn1IxR5bPAhwtgmNi9Bw6N3r?=
 =?iso-8859-1?Q?cbKEDIzENWALYPI2qHcw+NIabFz3NayKqr9Bsq1tpssRNcRIgnaDjaU8+M?=
 =?iso-8859-1?Q?/QovnFiXPpqnwa9+K3SgIJqjIB33rp+OAkNoBAM7AN3/HE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cfc7ab-a59b-4081-cd91-08def0c191b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 18:12:09.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7wttG34jzV0GAONVlq5J8MELyNYzvndRdQ0f3jxSljdhMLLKruJmGW4TTIxq8FXTIHf+Euc7gkRFrMuoaInxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845

> The direction appears to be set, imho the immediate TODO list is:=0A=
> - address "not-netlink-y enough" concerns=0A=
> - teach pci_iomap() to map mixed private+shared BARs (ones which contain =
MSIX for the starter)=0A=
> - always call pci_tsm_ops::enable_dma/disable_dma=0A=
> - ditch the module trust parameter?=0A=
> - add a knob to enable/disable DMA and keep TDI in RUN=0A=
=0A=
Agreed, couple of items I'll add.=0A=
=0A=
- Donald's suggestion for subsystem name like spdm, tsm or tsm-device (uapi=
-breaking)=0A=
- Fix bugs such as missing pci_tsm_disable_dma() in pci_dma_cleanup()=
