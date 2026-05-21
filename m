Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2E3DA7D3;
	Thu, 21 May 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368756; cv=fail; b=p/CRA2qj3oHI8USOS6Gl8s4vMTjThCQ7ipMcSGdxuxlhTx6HeMd5Cy+mgPXbH4i/q2ON5reqAeAQ9tbewAPjmdGJLz5cQ9yrO8AviLMxeFhewbrfKbl+nvj8GGjLa329pXORkDy6JNncH+hsg+euZLeKca/1fW59noupp9L5O3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368756; c=relaxed/simple;
	bh=rlo9fA5w3x4sgjYoZKEyfVELIg3viyem1u6k/R4C0+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uxb4JAaZee9DXuRgPlypetu3t3bCRKZ6C+w+tJ+ilMxdvZ7hWSLjWmYm/H0gm8XaYqNR+7P5fB/luiw2hCoXT53kypxPYZp20WJNhT0AsCE2sUbY32IJNsM6KrNGmP34LE/MkeOnidn+gyFj8bk7LAnigk2ZwU50ek/MkuCx8Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QUcGZ0K/; arc=fail smtp.client-ip=40.107.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QUcGZ0K/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMI1iHm9wmQxuSuVN3gSKhOuUfFLw6h6ZRdPtK7zbTto1Ga0BNo3LsSlACsl2hGz75HcFiCDyP2h52aDHMFex6iR6ma9BYHkdiUA7P+MsPvW1zfHV5UsQ39c8V8UI1mmYJiln9yOcSS5rE42bnmfwb9CsL73DDMsrKdsGishLeb6ysbGVKcBROmtJKQp4LQjSvteelx8nIdlQ8YrtAGaFU3WSMwdYImH8eC4v2qyukFEK+zSLk+6+8qAs/zUdVspKaHp2PGxk9ER3SbdXWfbEXh5gLOBx2BZgtD0/x8Vm2G7wv+Nho8z6E0vCXvxVoFGR3zBeRL6dgDwX8wOWNGwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlo9fA5w3x4sgjYoZKEyfVELIg3viyem1u6k/R4C0+U=;
 b=B4TYmIuAsPYflW9aVg6Vv09CPUMukPDpqFQuBKr9aSxJAC84NYGh5ZIS6FX+yfjgKzzVookbh0a4lX/OAZOsNwNlxLjfJMRTueUOSR3V7KlLRTYz3j9CQ0hyCmavaCyuks1I0Rcd1ntYr25RiteEC3IaTS+Fb/CqLxoFV/B2P+2pdTMl0F587+CxZ1IjZwVomMIgwYILJEGNMsMmewC68RDxS/Mnj0/15DVhpJ/l36AU1ELMHmySgqlvKr7uQhwU3hniXeoKlVuIvuWGZOS+4GHv9ZVDAs5TAc5EpxDTiVbFEpASnnv6jSGIh7sQD/0Py1k7SZM0DeOGO2XI+UnNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlo9fA5w3x4sgjYoZKEyfVELIg3viyem1u6k/R4C0+U=;
 b=QUcGZ0K/7eOngE9GgHT+s3USrL/q2jlxMtdYh3JyULlP0h9sayzW53mKdrPffGrL1zlbaX0HKc+0kMwOUVq3j2os+FLZGkiCFMi5XsS+EMQev7R9HOnOjjtYsMxc15LyiR+2erDE3xqSA6d0maHjyJojDf/wOQqcjRFJBTdsmWgZYB9CiGXHoYra9yobdTUZ51kaeFelXJv1lRhEFWY/Lo9HJryDg4QGJ2re0jfe5hVBBWDKUsJFL7zK0jVfJTwK5o9APu+OUAg+I95oRQjq4CfXQGFaQ0gcbgghYrMsofP8gQbAIoDQAd/Hl/76FKMghv1j82nT+XhsMeaQItU8nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 21 May
 2026 13:05:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 13:05:45 +0000
Date: Thu, 21 May 2026 10:05:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260521130544.GE3602937@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
 <e8337102-aecd-48e8-9a2d-10f41ed43c5b@intel.com>
 <20260520143410.GV3602937@nvidia.com>
 <80e7e1be-c384-470f-9949-8c0dbad165ac@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80e7e1be-c384-470f-9949-8c0dbad165ac@intel.com>
X-ClientProxiedBy: BN9PR03CA0930.namprd03.prod.outlook.com
 (2603:10b6:408:107::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c5eebd-2e90-46cc-d01a-08deb739abb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	YXosjTLrFNEzWXtzaM+W7WSdNx9IioMkoW3NONraETpwLckY9/pnVVOGRU2eCrAhR4IilgTmXIdU2jkpxDfJvS/EHOwg3AOTjOMJ2iocpcVCJVzhxwlPG/hUh0USa8YkZR8YnHPHM6YTbI1+nd9Vuk01xW7/5dT4Ay1O12uVy3Q63Bix37OjE6D8wTmi7z6C4RK1HOfNTHUSS0UzxtbFpx2yf5Jna75tJUmkJjjqXfqKzuhiGK9LF1Jml+hDcAcISay6DkwljnxSHx5fyQPFiEwV74cOmJ/f8oz5l1BX/0Vj5wmjDF4oiu5M9EDMazJ7XW03Vft/FK6fEAwXN43hVHVxqNxRd4XxmLiy5TgF1XQRW+WzBIoltfdTWJ+wb9uvkXKENt6N0xjKJMfEwM8T6CgzsIgJbqImza0q+Q2gkecU0LqDtE4FfbsDHOj5aaPZhyrcfqhmgQoFxBWWNLCmBc1pEgG35fBMMOR/r7PF/jWaPSp7mm9Yf0dlW6f4bKyIKkeJCLQTYMMG6GNsewSnrJt3p07FE3MRHZNTPIrnsx7HlHAs+0K6zXOmXjZ2UAsRKvrhbj68vomLWzewQdrMbrv7OQw9OeL2biPIy6o0u5juVsfaAJBUfNMXWLlPOdkulBG7Zy3J7MeFX+uwKk/S+K3pQ4IfHcuxlTnbnhT0zdRHSAkaR4vM1/wrrrV0qmtJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G14M1gA6osqmFe/9Zr69Mk2d4R9hvMkBeosxgPzSiDAdHJ9+16rURDr4miaK?=
 =?us-ascii?Q?n0UeSbh2RJGMsqywWBWa9fXI94nCK9H+GxYDBqRDjjCq4T4Z6daxBumW53N3?=
 =?us-ascii?Q?gi2Ts5gwlxh8enosRsoMgS6CN2Afp/5HEf/NR/4X7+xrLL5y8XrDaUcKY7I/?=
 =?us-ascii?Q?vMrnyIYcVnL9wXQYSg8yJ9rxvVqUsUfTpeDePg/lnDP1yXae946yikXDW3mc?=
 =?us-ascii?Q?BEZHsfe3H2GWTiXWCNrFa1e3X8R7bhMUShop9oUA0mDAl8Jn/AH/JludSd2N?=
 =?us-ascii?Q?1xJtrrhkEkrk5wc+PfUAyLP4Hh0Qrq3+1F4NZ7zKHtq1c6KTlz/n+u2uU+Tz?=
 =?us-ascii?Q?DCWl+Di6Y9NbG7nQpmsMUg4SzWg8S0FhsefKY2bCKwJ0pff8NuqCZ43Ep/eG?=
 =?us-ascii?Q?IwydI5dahe13b4Fc5nU+vfc78Y+4fnYmrdvJId1iy6loFq8tMN4v5VDqGUxQ?=
 =?us-ascii?Q?NgLC1iRB5vHVO/hvN6Dvm6ixCzXNZOdtnq2DsUkm8ESP+nIwkSKntAAMHEEh?=
 =?us-ascii?Q?H5iUGXlSdV/zCC4eQBynOCmAkN3ZiPe+LgiwEk3jF2NegbSSJgTYoPxIA6L4?=
 =?us-ascii?Q?bNFjcO1RkQhI4kMWGEUaW57kSAPpQNiLWLXtKLIPDpEDp6hy1jrbPKbZEtL8?=
 =?us-ascii?Q?idoVNYJzkV3DQwj91jixVQempGedA2klAp+rm+A/euDxxHuG8RBulyJ/kOGK?=
 =?us-ascii?Q?/rMx25CLrW2XXpOnmnRHXitE8rlVNeMxnsAgm5J4205klwD/Yba6dM3rzvjt?=
 =?us-ascii?Q?WhjCUGyljDnAyWcr3A8zLkNRoFfgjXZSj4/Uf2ORxX1cfZ/S9pIpEX7dGknG?=
 =?us-ascii?Q?t6GvValDlyAZ6ljdg5chtnpsjJZxsrWyN8R3AuBuZKFwIMTccOIxhIHShCKE?=
 =?us-ascii?Q?fh+w2mgzAGfGUrd7rna/h8e6PQG1WOLFO8rfZl2+gZ0tESXcDGE+iYr6hOfj?=
 =?us-ascii?Q?ZY6JeNCO9zVL+NXtixrIyJLDGkxyc08mIHi520gQhw5XV/N0OaVJ58lgRGXa?=
 =?us-ascii?Q?HhdMKTtUK6HNkhb1ApAtzfTK5rTlNKOx1Tq8krnZ8mWDQfFVwEjPAObJcXTH?=
 =?us-ascii?Q?iZfScH7ZPan9dWK+SWor22pLNB33zwKhb7q4kbXAbwoASwqy3mBTng2KazJn?=
 =?us-ascii?Q?o57u8ENq5ufH6p3rNofJXA6uBSSrWfYPjWELsMljZOLqqdXoZTIYYgiUhbun?=
 =?us-ascii?Q?v7XrQc3/m/4QJ8LtsMBP5ANWXpbprA/++LUGUKLGb4zezDUlE8UXffTdr9jF?=
 =?us-ascii?Q?tFrfTCUobB93s11N8oBHdPx+Nn8VqalasgnlA/90MHp6FUO8q70FTm2GsDiN?=
 =?us-ascii?Q?z3As5wT24RDIEEBwppEvLme1ikmRsiXXCFWE7/eKOatzXYl7vIg4ph1oqHAx?=
 =?us-ascii?Q?X3p42wg5snRlrbatZ1EqX5rv9+3sxucErp68P9pxExggPE6wBYMaUOdadKnU?=
 =?us-ascii?Q?+jpXixpCCH+R//65Hnoo6zsNRhivjDf2gyTwTx7eyupByPDbiEm72ASaaFcD?=
 =?us-ascii?Q?j8zkECVrWq689hteYJnyWiljiXxu47mdIOT0/x70kFN1TvF06F0+E/0xS8km?=
 =?us-ascii?Q?ctJbx8PVcw5UYahSnM5G6/WHVus0FW97PpFbmsuHhCz/9yfs9SWEbMcQN9rX?=
 =?us-ascii?Q?0+Is2r+wKpBUEnDme/FBMfEDDhTiK1hqRVRNK4Ffdz+13YNl78Bh4AstdyPB?=
 =?us-ascii?Q?EUGlkby8fsMf2bnW2iBGeySJy9i3AAkWfE7rbYDcChv37F11?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c5eebd-2e90-46cc-d01a-08deb739abb1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:05:45.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxE0Vl7PE3c2XJmdUy/jh3AeuG4JLW3TGVWgtItspEjbLwDD9s5092N0+YYrr0dC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

On Thu, May 21, 2026 at 03:31:46PM +0800, Yi Liu wrote:

> Does this hardware behavior satisfy the security expectation you have in
> mind? Or do you still require that both the DTE bit and the PCI ATS
> capability be explicitly disabled when a blocking domain is in effect?

If the HW rejects translated TLPs then you should be clearing the ATS
enable bit in the device config space prior to rejecting them

But it does seem secure enough as-is.

Jason
