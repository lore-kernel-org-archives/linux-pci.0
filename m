Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011066.outbound.protection.outlook.com [52.103.23.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B22D8DC4
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638032; cv=fail; b=PRzxk3whIe4/0wSt1Zh79adMh74F1Uk/wfnrLKxhpIB3+ecvCpA5+B6W/TVb1JzgBGmH1Ywk3pJJQevLtN1379MVzwEzz1KoISHS3lu6x4Q5XcXjs/pvLxT8t6nvD8dsNGo+1EygIulrWHINMsatfasLq7pWGndYlcNyfFJeibs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638032; c=relaxed/simple;
	bh=JQuspwADWlsDR+LKIjrcRSatC+FFwVPpVV9OEs0Agwk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cr8Hm7euOQ6Grn+KRLbc51kJRS/wLYFZRT2YelclqS3g1HEz4DOw3iuNPZ8qlecSvTkN2NgKkwLZQBKLXLtXmvanodRdQOqC6jCH2j6QOxa+4O1XXEweVOcSwUl2+Mj/9+X7P2b3SPFkxfqobbclpbxh/XIZVGjjwoQCbDQFbWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MqjRkTYR; arc=fail smtp.client-ip=52.103.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MqjRkTYR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezs0CTwZrAcBaI1Tybymsr4gaBAkCy+py+TpzhNV2+38cCgmgnGuls2oAaG60ezxhhoFn6i0zVHM/fzgD9vCEBMuuCusssRINK2Rybaf9rSaKgYegr76Zs5Qp0cXL6yVuLriGcPPGX9wgTdcyimGS8waDZUk32UBZUMsQVyh8NgJCNDmn4xtVZ7kZtu17/SVxazK68xIGeU63fR/fPwoMmqOMqzFbcKB2Lrj0zQb2O+BDASEeSefvXKwU+sI5uYx7zcDZu1Hbu7dlhmPj/VBynFOLUcVSUH/+KiEk2Z1f9e8pEgjJgUaOi7kp2u7Ct8IZ2B0GeCu+ZTHIFlpDQHGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQuspwADWlsDR+LKIjrcRSatC+FFwVPpVV9OEs0Agwk=;
 b=Q7aX1DL9i2L1ctjRCr2i8cMsVSKIyd8y3/b2+0Pojro4IJ1MD9DUErdhBwsMa5bR8V4sHCw4QoOMDVMVD5TDWWSMIgrQsZaFldRLBWLf1We0hcLAzJ0hobuKQoA6kggjYxssV4eNE6l2ROOfm6t2axEbDi3BuvvKd0RU3Lk9NNfx00FwPxZh3XY02covx+L4LTcK8pXbXfuA+WMVjJcb9arb1GIcngmkCBg1k/pfk37SVZMwc8k5eeX8Jm+y1Eobr/918CYa0Wb6fX1S1wuDIa42Y6EcsvcSi4124FwXydozWRC5yFX3O6AC1tACMnnJCvyEriW1tXDsVNACPxEgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQuspwADWlsDR+LKIjrcRSatC+FFwVPpVV9OEs0Agwk=;
 b=MqjRkTYReKc2hssgBpWFg1XTqn7jI5HKJZtXt1dS6BG+A7rNWDCeq5IPxCupxtTjW7JFDB+lAAP2qRn3TPXsGCoGxjyWAylGBW6DPasxOh7J7RhlMbASSpXIpdKifd9xLFmw4PowOO3Pq9BcbDko2si6MVDkEoTKh22kxdDXQOEWRpDEuP4luQBc/HQK7kGX4nHJagHyFVczuDwd8sz6CQ7eTebrEtIN+/bj+qvcYLn4dcDmyI8G6G5ThXs8YjCGi7l9CjRzyPk4AcW55nsfH1wE+Slc5d42eh3oeqdp8T3VClXOjt/JYJXVQEGuHKT5dv6+ODCf7we5HHYgzlrK/g==
Received: from SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:485::15)
 by DS4PPFF31B32C29.NAMP221.PROD.OUTLOOK.COM (2603:10b6:f:fc00::ddd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 12:47:08 +0000
Received: from SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM
 ([fe80::6a2e:72ac:9841:e186]) by SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM
 ([fe80::6a2e:72ac:9841:e186%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 12:47:08 +0000
From: Lin Mohan <linmhwork@outlook.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Ali Alaei <ali.alaei.tabatabaei@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Thread-Topic: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Thread-Index: AQHdGQ8KI7YVX7oxkEOL9XgDj80TUg==
Date: Tue, 21 Jul 2026 12:47:07 +0000
Message-ID: <191EE983-DD30-4B14-9B63-93AA0BF750DB@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P221MB0955:EE_|DS4PPFF31B32C29:EE_
x-ms-office365-filtering-correlation-id: 775a7221-e6ee-4d3e-c247-08dee7262cf5
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|15080799012|8022599003|25010399006|8062599012|19101099003|31061999003|19110799012|3412199025|4302099013|440099028|4295299021|102099032|10035399007|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0/+6qZRS+Js1JahTS9g9mJtOneF+GY1x9l3SP7nLZ6xyMaNSidCXutcKW2in?=
 =?us-ascii?Q?FAMsoXXiXnZYb6d9DB6qMADF93e+tb0367tYqqf0wEFWO95jbV3iO/je3uqz?=
 =?us-ascii?Q?58os0CxP4ONWtIkP7dw8ZfaO6lrhnwe8iP7FYZzjEZWVxTiBoEFkwFqzywbT?=
 =?us-ascii?Q?xWOE+bwx+LmWtXaga/OHOQdsHONqpGgnGFU4JL/YihesPCE0d7knJHNKUAd5?=
 =?us-ascii?Q?vqyCucrCjKIigon/o2x9PUPGS0DxhZct0Bw3ewOMcfSQid5UN3IKTmA0Jz2N?=
 =?us-ascii?Q?ANiYqPPv9NGc9m8lawRm9vJe/FZjG6A8jGKnV39SVTWU5YabiC2mz1wvThxa?=
 =?us-ascii?Q?yV9X8svTElE/03i7EbzvFRBVne+yiv6lhyTttqnUcCh5iI01CH9hQK2jT6C+?=
 =?us-ascii?Q?off9GXswmECIpsBKC95bNuB3yr64Mj/00p5c+byI2l7+jmxmKf+m35hi/ONM?=
 =?us-ascii?Q?x7HjfaKnPedrH0GBnNhskp7d0yZ5wzPejgY1fwfIB0N9MOfUMGjOZZ6AnETx?=
 =?us-ascii?Q?7odNCWjeMYIKQ4jy7bqkuTIGL/WCR7T9VU9fiLtQ7q7Lj375kzVGj7/5Kfj5?=
 =?us-ascii?Q?z/ERdVtJogrGjRbojRDoSmLU4E4KJIujLDyxc8I2j2xAFqtC8hGzwWy2fXu1?=
 =?us-ascii?Q?C8RTWV2qgZmE8wpF0psP8qdlCpY7mu/sRJHvHYSF+t2M9VUFh0/GE0ea+OKV?=
 =?us-ascii?Q?gOdN/yzI1MJQnMh5kPfTTcRtlM+zapW2dJScyZS7DzRRvJ9qnptIGgb3Qi5y?=
 =?us-ascii?Q?H6QMhdstrA5WR411bwFgmz/CWPLDiTQBc1qpAmQsHI2i7f/BkyghhnrQs6eo?=
 =?us-ascii?Q?IGjDJuDlSC44ryh4lXqMumhxY6rJ/nc7u3Q7RYEhzctW0EvLDb80hB+sEfDO?=
 =?us-ascii?Q?IOryAS9Est96UftR4DGx6fOHimwgqM/d5riN01x5z9te0O2KS+w30R7KsSfG?=
 =?us-ascii?Q?N1Sx54l+d1vBwaLPBwqYNcZOfS05AoSJPYIC/UiiFN8zKp7AJfGc7lwcwhHd?=
 =?us-ascii?Q?ls+c?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WCo51WYyjS9LMIobadU7lciadRbsggcCwv7tNX6yjroUWYPlH1FfdxeH0RqZ?=
 =?us-ascii?Q?6YqD7PrE4iF+IMiOSzqmOMkbwHrzOCm7YPUSKlgwFFIqqjMdHuMM+zg6aK8N?=
 =?us-ascii?Q?sr2JQI/+ZVc0E9wi1YKt+QmtHRvUY3pZgPyUVizAhZvX5otzSkm+dBZ4B43y?=
 =?us-ascii?Q?OIJJPbRs0hgqOkO/LNuCDdmHqh3Qp/4RbRFRZ1mWtSj9GHX2kxQACCvnmusH?=
 =?us-ascii?Q?Z2TbK+clVBxqHEG+07J79sCxe1DokBk5GWSs9OzW6GIRZEhupINrVU/QAUQk?=
 =?us-ascii?Q?aFgi0gigGJME3Yw02Tx8G02MyVXI81HH1f6LGevTAZDPy89LtvBMPR0RnxsV?=
 =?us-ascii?Q?xumx2zbF1/dG7GS1iwxzvfNPq/8STbynU2T0yr3x1mGjEB1v3yc6mUagcxPg?=
 =?us-ascii?Q?8yZAqbCYyrO9ujKOIFPS0vGKIA7r9AsJX7WX1Aurtm4zYAU5nzrSUyTnoslU?=
 =?us-ascii?Q?+3waQsrPpkCkJx56kPt73ydF3XaVR+s+4AHZug6YJgOsth7mhVyI1A7JEulF?=
 =?us-ascii?Q?69KbEnjhBM+j6crzmBtf1YFQhQY/TqyHj+sXQVcfOhOdYaTAFnTmF2R4+nOm?=
 =?us-ascii?Q?B8rlJYDWfh5cVDAfqhhjvtuNqXAt78VOWeQDImYuZVoaPMjoab+YIbkvE0dV?=
 =?us-ascii?Q?IlKjq0U/VPtdlPl719t3joCKB8z8TOnebLrevt7PSgq5AjCDeSvec8dWdOh9?=
 =?us-ascii?Q?sGKVAo6K2r3dAg65trUKNZZsKV1Vc/aTmOh1GOVg7AvaL5+F4OvQ8iPRBrMn?=
 =?us-ascii?Q?yrJKPfxSo+YYdz0JUQcniZIHxDq1pbVeFtI9n8cANpkbe0p+SbhHbzXZB8GI?=
 =?us-ascii?Q?mx+5v4oXTAq+Jrwz+nhmX0ui4igbQpPCL3sfTmOyjTFMn5UVXkKWrD8+N1k6?=
 =?us-ascii?Q?EHq2MyVo0zBs2NwDjbADP/G9LhKXShov+BCb1WQ7ms2P/UD1h+XPdiKn5l+n?=
 =?us-ascii?Q?d/znh96X/VEbfhqSuq/B/FI5R0TBqGgDrNDS0GVbH8kLDX0og5SqPyELJnIz?=
 =?us-ascii?Q?POAlOfNjlvApRRTDH8bCSC51gH088yQ96iz2fCIBcClOZHxzdimZW0DRHt2k?=
 =?us-ascii?Q?xrpsRa1c3BGddvFEFN5gXuaO/fHV20pomrrfmeC9vKK1FgzaPxus91qw3Wu8?=
 =?us-ascii?Q?eYoMiFv8yVnLf0teU6nyQD1PvNBp1HIto9VJ9xr0Xggqk2u2BqQYOEQDTW+L?=
 =?us-ascii?Q?L+xlhbewLvjCOnDv7W42G/KEFmSlZbYHiYVOZoEutc0akW58XQ91342K42Y3?=
 =?us-ascii?Q?ezF2HAwfJlWIB17YoDvnzPfSRdoY/IC801jJ7oVKPuMxWLUsz6Qb6GcSPYnY?=
 =?us-ascii?Q?/5fk2ZQDs86EC93+xPvJSTyNVV9hBzcl5S889jzaQheDYFSgqV1O1nsdu7br?=
 =?us-ascii?Q?ApiSniXQLr1ivNVcm+4JcWftpy50?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80F047E58C79764C873D54BA71B2DF69@NAMP221.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P221MB0955.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 775a7221-e6ee-4d3e-c247-08dee7262cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:47:07.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF31B32C29

Hi Bjorn,

I am Lin Mohan, the reporter of
https://bugzilla.kernel.org/show_bug.cgi?id=3D221137.

Since commit 22b47bd49e45 ("PCI: vmd: Handle BUS_RESTRICT_CFG value 3
for Arrow Lake-HX") has already been merged, could you please add the
following tags in a follow-up fix?

Reported-by: Lin Mohan <linmhwork@outlook.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221137
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221136

This patch fixes the same Mode 3 / Dynamic Bus Offset issue I
reported on the 8086:09ab VMD device (Arrow Lake-S).

Thanks,
Lin Mohan
