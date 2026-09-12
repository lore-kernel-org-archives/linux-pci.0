Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398E331A6E;
	Sat, 12 Sep 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226601; cv=fail; b=FZOU1lsk4whcGuGXup3mrgwYk4EszhfOxfDuNZV8Kv0hnMmB2E8J1PRPEfMLKD6Wzioq5a/avac2k21qJ8HKW6LayZfPAASNSzBbXMdNPMVkTBmJEbFSFOIV89Rq6WcDvfrpT/TnlZzz3TGMiBNpx89BKSrOjVPBrrDsEyYquCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226601; c=relaxed/simple;
	bh=M0ZY8aCt3UrSLp5V7g7VBIku1xpoEiH8SYLMuzt/H8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ukk1AZPQ3xYlPsfHjJn1vy/h2d3W9uEIrlWyqVm8FIYLR7SD/RFoq0pi9quDOoUjrPm/wWvHkI0Jral4YfNcPABXuzfeEawfgEyNgdmjiIwNdYQEIkQYnLyWgh6adRky/ayG/TiaWAJfwAkxSrC8bCHp5jFipVxiGjMrJIXQ6mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ebcldBL3; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ebcldBL3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuVWurzunUwDEll7dbumssQQuSn+x0HzDx8BUO/tHOSKHmAE4XiOwm0XqjnNwnAN6ZqhF40sSRjDTqxJxtymjJ22wS/pw5zYJoEYgBqz2ghgHJxaPxFy0iEHg5Dikp/5st3l6gmjbHwTW0HzKGYD7ITZ1H1ZdGRWVoyQHzUZrnSvS0FDHq7ZpZLpgaViV34FXovseEEfUkL1KDucrKhdw/BZMguAhCQCwNL/MiTGFNRkQmciZe4T0IFSsmHOX04srP0JJH92HapNTT9ve/f5BuZTPQjBAYvsTzUcDa6UG3QRONVMvrCAt6xzHH6XoONwb3R9pGInR7W1VcPfmM2qqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV7IIr24OVvUZM5HHucJ4uBqM6/uK4l8dNprltbwJzg=;
 b=ynNGbvpvZ8gNzrreQErGlcl+oOgGHNyN7PiVoH5Jw8jWbrC8WQkRLnXS7BcbygjcQ21+kW/Z8ixLmY0H+gONJfanHZ64Zur5HQgJ0994DdwCk+6k9Olr8mRYm8QanrNe6pd6BGYxIDj7MHs4unhuUolD4e58GjXSa63N5ehdDW1mf7HVpZ03ZalThHWDRBYOk8WTt+hW9s33ZJwUOfqp2XioHagWWIxeTigeKl6bV3q8/2C5Gkzx6mpiouMDtWaLsNpHZ4nOuganSRCuTpSRFDnJ/Sz5k9uBE27ld7/uleczYyn1GzRaxIHX2peKzcSz8kNb4OLSxIKD/EjP5+UX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV7IIr24OVvUZM5HHucJ4uBqM6/uK4l8dNprltbwJzg=;
 b=ebcldBL3gEzkplhia0V87O9Mr0+wM2vCn2nq0sGNuvCsz7IQom1MJmScPspxEXnxWdzOOTaPqf+1cMPKVo2qDoyKGzK2P+lZ5vrYdnedR4w/g2cMTPGshEMUa8Dh/9v6hfuvRTmiPSSnl241o5grkiCs3EhdOnDHyNWBWUC/+ncXPo/SoqSHI8YT0Pa94Tm2udSvAYR+EzQzT1xde2+ijjEKo8Gdmob8CauSNlKOWv2rdqQez8xm6IuvN4ZA2wPxm4684QIT0FXkf9MQ/5sWZmRSPe1VeGsNJzwWvCWZRdAXAGBCLvMhMgwUP5RAotoHyRjnI8p/RfE8yi06uY6JHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DBBPR04MB7993.eurprd04.prod.outlook.com (2603:10a6:10:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 15:23:15 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 15:23:15 +0000
Date: Sat, 12 Sep 2026 18:23:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?B?V2lsY3p54omIw5Fza2k=?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH v9 3/3] PCI: Remove device links to PHY
Message-ID: <20260912152311.uq4z3hkmf5ylmpxh@skbuf>
References: <20260912113944.cfs6tebsv2eqctvw@skbuf>
 <20260912140207.GA655851@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912140207.GA655851@bhelgaas>
X-ClientProxiedBy: BE1P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::20) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DBBPR04MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 605ccc8b-c46e-4d6b-842c-08df10e1c404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|366016|10070799003|7416014|376014|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	IrCaKjzE3VVTzR3OTWjmqBZarQxve2nKNuPKePQ5uAjwxwTpOeGJ78Es3QDQ6+ViTxk/NAxRnnQEFU59bDLR/Kzi9f071d78N8DglSFGGUWEKVzx6Aj4w0rPws/V7aOkAIowdFPWeq+I4RVUF00AvR1fC1CMiYuhLC09C9TKvkR9ax6zdKL8zJ8L+SfIwTBySuqp757KusdjZyORgkRhXC0hfSNVMZF8FxEVDBW9tSDV8d/Ot2cwfTIbUTTT9opdZ5eGueKbXPr5acRF86Zsm0cjeIgvdPzdWFwXSoGBumZcuY642M4uku/zds/C4nO/GAljFTbVRkwKxvOUJjWY6OIeSnPJggVUJRKRNJC5E7EBfPyDiKcUSLHZc1oXCADVHLlThMiOGAzaIdFhpPiJYkGbqqJh22WQVdSPp35GS2UZS4WuDNr94TZ4GBMaK1iNI+aVdHBA9FujEBlWmaa47xp2KQSmgL0aT7X5FVt1Ny3qZORAKUCc++1TnulQrEry2gbqfdfQWsthr/VzWK6aUfna3VZyqmhUb53TVQ8qzTJYDuhJEoYWf1FeloYsNGQfPI3yDVu+ujMFUWxEXzNQUtNmUGB4gWybig1cFHLOj4g62fh+9rMqD1V+wYb4jwrOf6Qxq1cZRUSUDhKbFRH9MXQBUMZEMhLOIiEzf1PYWfk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(366016)(10070799003)(7416014)(376014)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ll/bu/Z4sxLWqTi8T4Ky+orLUdXJAjXSXcH1YhGOLIbVVrLuNRiL2+Ef/+VC?=
 =?us-ascii?Q?wQZecROgS0ELFk0Xu5+bnszxGO804JaixvDpkdtdXmq+HYrdRg2GlhKWldxp?=
 =?us-ascii?Q?ykkBDe4DSeTZRpIRltvU9LtWXCfXm0mb7vhV5gQex/NlPVr43UWcW2rw41Z7?=
 =?us-ascii?Q?xfucFa6NOufCNyo7dnMwTQ7sSLqI9fUa7bQ0XHW3x5Wjk095ZAxAs4iVYuT2?=
 =?us-ascii?Q?Wjyzn7v03gCaFKNbSreZ621FJc7H5aOY8oZq3Mni8p6HaO5DglsCnf/h9JWb?=
 =?us-ascii?Q?j9HCQG0GLr5iL77nHoett/T72yBdUEDfp6cCrmuNUteqa5OdyicgA7X1XyiP?=
 =?us-ascii?Q?oZ8frDj9EcZ7eYiiE5JbynZokzj7lpk10yLFaQSRVGUbEptKgXQUyKIYPEQM?=
 =?us-ascii?Q?s/XetrFzJbdGO71eVPVy2p1WZIglhQCoHW0M+qWxTGhv8e9LladjFn3/B6qi?=
 =?us-ascii?Q?SuKMLXuYPVTkOATOjn2b65Ixj5FH7J9B81uJ/WVmRKwysW6/VZv25CtpcYjl?=
 =?us-ascii?Q?5FScmtMsosFesmnNjWK2GA88Uq8lRfcWgi5nSKOFVxBboB71UfgEmPcGtDtB?=
 =?us-ascii?Q?panyNkH5J3yTVZTvTc5ULXC+IN0zon8kbGmB3ViMbnFWNBgmHx5dD6M5O2tz?=
 =?us-ascii?Q?sGwWLUQmEHpYypSLb9b2DCJSbGy2DAWSoLWCxbJgSOnrxESudBPZrYzEjRJX?=
 =?us-ascii?Q?tT+qX5HxEEiJDPdTil6cCG6BwUNbWw+Qm/XI8BCmXfhUIEcobni+tzBg1ZB5?=
 =?us-ascii?Q?p1Pi63IswRzhU04G3WNv9MWQiV/mDEYCy12X6oSA0YCSOQiOQp4b0q8kwFHP?=
 =?us-ascii?Q?hR8aBbwcyPqLCDGYedGHyMujJztCX6A98moJOLOkUvGQlk/pnC9Uuk18DMfc?=
 =?us-ascii?Q?GD7gtd6FTZw9i6LqbHC2iZv+38UoYJfhHRu8zyqhxEHQW3J+uGx7i9ZpzUq2?=
 =?us-ascii?Q?UW5UpxBOBwjqF+tgXGjm3plF5Bzz7KJqLiYtZRSecJgDd9YGaIM0pDp9bYtf?=
 =?us-ascii?Q?llR2tZXUsAhSXL60tQytJa/IJcYtqj4ltCX70plZv1Xk7lAbRRSQlxHBXAsb?=
 =?us-ascii?Q?SuCzRARqfP3M596MhLybLiMVUOR2Sc5A+d8jq4/c+zmaep0amajhcm7pgBcz?=
 =?us-ascii?Q?d7jX6ac9JXTo99ngt5G/n5RY94DOBiBsVLcsG9sXISBVk9cSe3ewB8kEG5lX?=
 =?us-ascii?Q?OahL5ijAOqWzPDd4+jiL6rGD9+vWvikHe6a1dGXN/qWxfw//4KwEpw72G+F9?=
 =?us-ascii?Q?BPComE7E8P8qxTcORGI3zZHvd/icLwS3aZ0GMD0wZh+o5bscakwYv09isg51?=
 =?us-ascii?Q?CrKAivWidrdRmRqVJyY2XPlHzmNnvXkiusoGXF9yRlDnhWyS/C+WUwJ6GNxc?=
 =?us-ascii?Q?U74Nj8oe03Fj+zbTS8D/aZFDWGmyyFBArK0zvimRNCAYoucJ3LUwrmh72DuH?=
 =?us-ascii?Q?G5240ZAzWq5a3OvvPriUVKVGCUR6QZ//kygakfoYlYMrV1WKD+0gtej56atb?=
 =?us-ascii?Q?6jWly2/LxViBifOlKxVwXu2CxJmUSICtfNENXz9TzNBEbVLR2NCF5wGA8SG9?=
 =?us-ascii?Q?GNhMjOJSLxm3TbqTDk4tI7d890lwM0ACIFK0hCWeo1ZXxmDs74tyWum6Gh/5?=
 =?us-ascii?Q?Qt2BovCgc/ZST0KSVRPgCaZHV6LGu6d+tSFs+QR9+7IMUUxfQOE+/nD9ZZyS?=
 =?us-ascii?Q?DZ+0DxpKVPCBwQiTOW0a7/9xTlQh+bYe/SkfClZ0cKf8ksoEhxfNplKFnbsK?=
 =?us-ascii?Q?owuO23lk3x04j2aTGtTyg5E7Z4U4oCHD1yK96Lyi+eFiZkn3iz1kYqr2w1Tk?=
X-MS-Exchange-AntiSpam-MessageData-1: y6LYaneOybEWD+Qo2y3m9BVhNEuuPjGZxcc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605ccc8b-c46e-4d6b-842c-08df10e1c404
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 15:23:15.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fua05SCjSPxbiFsnSR59hK1iWR37T1PK8ftlR9CMteY0/3m+kCkr0d6MALpWlGp8/TGRsI2OLru7vVn8fqdpAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7993

On Sat, Sep 12, 2026 at 09:02:07AM -0500, Bjorn Helgaas wrote:
> On Sat, Sep 12, 2026 at 02:39:44PM +0300, Vladimir Oltean wrote:
> > Hi Bjorn,
> > 
> > On Fri, Sep 11, 2026 at 05:12:09PM -0500, Bjorn Helgaas wrote:
> > > [+cc Felix, author of device link leak fixes]
> > > 
> > > On Mon, Aug 10, 2026 at 03:43:15PM +0300, Vladimir Oltean wrote:
> > > > This is practically a full revert of commit
> > > > 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> > > > and a partial revert of the device link pieces from commits
> > > > dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
> > > > 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> > > 
> > > Can we split this into three commits (dra7xx, cadence, keystone)?
> > > This combined commit is applied on the pci/controller/misc branch, and
> > > then we have conflicts between that branch and
> > > pci/controller/dwc-dra7xx.
> > > 
> > > I think if we split this into three separate commits, we can apply the
> > > dra7xx one on pci/controller/dwc-dra7xx and drop Felix's device link
> > > leak fixes below so we don't clutter the git history with conflict
> > > resolutions or irrelevant commits:
> > > 
> > >   https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=2b9a036b568c ("PCI: dra7xx: Fix device link leak when devm_phy_get() fails")
> > > 
> > >   https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=bdfdf654b4b2 ("PCI: dra7xx: Fix device links leak when dra7xx_pcie_enable_phy() fails")
> > 
> > Isn't this patch already merged in pci/next as
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d
> > ?
> 
> Yes, it is, but until Linus pulls it, the PCI tree is a draft subject
> to revision.  IMO the git history will be much cleaner.  The end
> result will be the same but we won't have conflict resolutions and
> fixes to code that was removed.

OK, and what is your request from me? Submit 3 patches as a replacement
to this one against which tree?

FWIW I didn't know the PCI next branch is not stable. It is, for other
subsystems.
