Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB436728D;
	Sat, 12 Sep 2026 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789213195; cv=fail; b=ArUmqTbD4bZBj5dhbu3l7Mtm9gkPuY+DeFFe9N0HeKWD8jJysi84Oel8+2WGzoyhQ+6kIAKShoMizHunh2Kz1uvNS0xI9siWBxGLDH32OOOO/WDDTIJBsyMH6Qy50oB8JJI3mGeu9G1aluzUN93VraoRvSbzAOVi6HHZEyIhhm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789213195; c=relaxed/simple;
	bh=iaGAZMQBaVpj20yCLgbDXRI03eUiffKlJXF0mm51P9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m3NwsTbBv1uVkeNVvPc/XqTvxRdt5pvCJN7i21028lbzk12DDSttugGtT/H/OGrkLIJkL3Xy+uTQV0wVdnKkVyBeWm3BEQF9JIw4qBAsviKlMx6x5jv/U16jtRO9ce52SJdWO8Xg9D0zFN/AIv/qUIgcQN/6FiFhgz5KmLw8gv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FvLZghkN; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FvLZghkN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdcpBzsSKVAK+pm3sl1YucjVdWApB2JlvXrLGbhBQ8LPXJF8Z2eFovtyQqQmqFuzb2TYFWdGK/VPFj6g2NDR+BbIFc71+ztaMCvugYAxjBXTFafK04h8g/LFRQznNOIKdL3S1nE5fyIcgZgr+ZP1kj1PGHKX4ROPBKzTyAHJ9QrS8oDAzMW13UdXGLKF9tSIw+99SCzBfMXupnVlJiD7vn4g60xu6SPN/6dc9JFqmhrL9Eg0VnORS8JbRs9z0fRi9X6+qkH2ygChy9Ok3CRq9g7hhSsb2GcrXv6lJ+CaTUtIyPIOoSbsNNhkRTgq9KUvFCaOUTpF/NR4aBHtxdzYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZXJwnSdWWnCiHu6CFBEOlgICtMyxV/EetgcKlS2Cas=;
 b=cRTxvsigtntLNxWeswnVGwxpGeQ+g1dGKccBkl6nHiU6kHMFpDiMM4Tj4qW+PvsVCbdmF/eEh2mEf/gcgtAz3Z5DHBmJtQpW18vD7LjLejEeMSeuztrxvA9CezvTHTVBBSmcjh7poFR+Dwp718Ah5HrZJv1W8sAVoso2VVcx3+C1uUFVo5VC0XWKnH6DcVhWIWGxv8Xm8jJoqulLcciZEwuRDfranQeusDxMrZQC1jx07CBykmg14nbyOlkf4onjUuQKKnCXwNaHGIGSkmDzy1HFYAKHuH7sCAAD8jO5tI24fYGKk97DT4i/vbmq2l3nygXxQjxRbNf1jZrkpRacPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZXJwnSdWWnCiHu6CFBEOlgICtMyxV/EetgcKlS2Cas=;
 b=FvLZghkNn0zv7J9GhwZ3upjMDpnYn7us826ks3pF1QdBD3l0d6EFcdxnc71oodkIkKhQnO8ye2JJnwkoTVyK9vKYXpTbrKtew3yekmD57C21tL23etoUkTza4x3Zqwn78tUors3I73MBBDGRLMqcHd80bJHnNmHZrk4cg9FwBMCXNAjRJlfb+QOExAQACoJgskSaU3z/O3XbZkBdN8Ih2bvia3nogbBArEeLxdyzBZw0KABRgWs2UR7iO0FMRM+tNms7qOCgJJp1z+5ApR+glQEiEH6f2ERX2auq4IqK/a5IHfn1+WrpA5VKKWhg7Oes4IpPuHGyjQHjHGWvMluaJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DBAPR04MB7478.eurprd04.prod.outlook.com (2603:10a6:10:1b3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 11:39:49 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 11:39:48 +0000
Date: Sat, 12 Sep 2026 14:39:44 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH v9 3/3] PCI: Remove device links to PHY
Message-ID: <20260912113944.cfs6tebsv2eqctvw@skbuf>
References: <20260810124315.433448-4-vladimir.oltean@nxp.com>
 <20260911221209.GA587622@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911221209.GA587622@bhelgaas>
X-ClientProxiedBy: WA2PEPF000008BA.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::696) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DBAPR04MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f746bd-4296-43f1-cf9a-08df10c28d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|10070799003|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OFLgkwxff8Qo7TmyuPs+uO7hfEbjjkc286NGkhmmX5v+qijUUUfIq2M0A949+bajRBzKcqEjdmVoVNPOS3sqoRmKri20dNp7sXR5+6aiJFMDkB2gfWdEyqw1BqK3IlYvBBG9mmHUkAEe0eir8apcMI30JoFBqak1f9wjVrlKDA1w1xdhltG7KyfQpz6qQcClwL5ALLzMiephZdUipHL6WVKDjdJBnx9goJnWMUU2t1RQie1G4zyp/HQr0vimycT4GM+MqZvDunzAi0zvbMF4SIpvq+a02QOa6Dx2ztQ6V/EShB+GfJksEUIXDRCLdMKyJ/hI/zUUjj0GhbH8V37pqQ9b3h5NdF4htbjN0p2uZ+Ke/VI052BmXTulmX6bILjq2youLVXzp1t2PcYxMPZume2Buqno8h5vsT9YIq6l1AJfcqlqDpM1+6CDOETvvtGnmDG9NqOdH5ORNGSpgQ+1rBAG3NbHq+uQ04Zl1Bz8xE/eK+VH86Vtt2DBLc91//gj0a4mPbMqmsXb7w1Z9oth1fosC7vqrpEqkOfeRXj44VPnH2L9HeuxbDpt3H5k8L68SaVac4tFPRz2LqlWBK5kpVVvnRCzdiLDHYKL3f0y7vF7ERnuUM0NeUBlDrnWC9Ke9ZPvfMcwc3fAJvm4bPf0+2i8S9muNJjIGuP8ewdS8Xk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(10070799003)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZbFA1VgxTCNW2fgmxPxG2MWdcUtZSlQsJUKPq8lIiX+OPFCJK6OA8CW8FOAS?=
 =?us-ascii?Q?KZXVIQ/Dl+3bZeHZxvTuekz8LnL9+4uJAge+eXTLlpZE61rWixVNkV9JZlUt?=
 =?us-ascii?Q?0wuOaZLvdgH72b340bsXYgxCB3fNuutHA7tdl0aLQ4+IQ2+l2JLt9dUoIFXE?=
 =?us-ascii?Q?Fc3z9HS6JLzr1cNG5hhzG3QIxEInARNy3bmBgtxbVe5JPMdAr+RYBbJGVC2m?=
 =?us-ascii?Q?bP4u9yKOUiozffkfb5gW0hasLpaQOhOGLuBTBX5xU45j8f4GLLy0nc7czJDX?=
 =?us-ascii?Q?w9IccBq6Y4IgiGrtbmBX1fFqoLJImNNb6RGbyomMm60QC1ngQwm+G8m4Cmq4?=
 =?us-ascii?Q?swBl3vB7334VjEB7+Lg4Lub+IYnczRCZWB53NX3O0rowEggyeIUcM4Cm8EMH?=
 =?us-ascii?Q?AqB5bQqn8J/fw4KOg33tTWP4DAzOTma724yx1DrF4QxThGnR+OdICTS5BzaB?=
 =?us-ascii?Q?QUrqKEiKZrUZ7sMYCTd9mxYf9MXbGvx/RZa3xlgWDw8nhctw7e9yyf7f3V+Z?=
 =?us-ascii?Q?Mw1LP1SEhEQvYsnPJmqItFLIJuwAwLsqYg1RK/zT8viD5QYS51RCXfQhh3uR?=
 =?us-ascii?Q?PaZnpcH3SlRJlOsX5U4JYYqU5vpIChBMqoTZFiIaDzEon9SNynu2kCshQWST?=
 =?us-ascii?Q?lh2uH8wB3nLpW+taW0mMwNwUtYAat6MjpbIQ9mDrR9CsN1RurGbSlvQEIz6h?=
 =?us-ascii?Q?19wwSBXYg3tBHEKw7PQ1spW8nzPxuGV8QwRQ5SeJz7iV838t4DKcfTp0RflO?=
 =?us-ascii?Q?hvoiydFZY6sfII9E2kC0GBkN8r4Ea6wXNw3RKxE+wI7K6rDLYdHxuEGqTNDZ?=
 =?us-ascii?Q?9WtbJq8mDV+yaVn3leqLqO6SQxkqejzraMvFY0t/SzbhmO2T5LfoHWHRQ8iQ?=
 =?us-ascii?Q?tK7Wqn2BzaTkZeERzvQJLTz83QGWiGNfRTkebhm4ISphH/uGMczq1oj+CL6d?=
 =?us-ascii?Q?SdLxhvtOFSeE8cO6aMdBrDj+g39w87JOJ1zguEPPJa/hsk6U70+ifrf18Dhj?=
 =?us-ascii?Q?YNbkV/HDbA9BtIybK2mhPRLDD/GZT8+++kvKCGb1od8JlXKkQz2u/qBKB0zA?=
 =?us-ascii?Q?hCeg/lGl00JE9AGaX9AH/wDZR6ZVOApCznyyNAdYSsLsxo0A/TboPXtXQubA?=
 =?us-ascii?Q?70hc0vQ/KIkHQUuFeBmzld8qCGJny7TNFNv1Q4IgTfVQroadL84JRrTU6tjc?=
 =?us-ascii?Q?V45CyVGfF7UdKppa1xcdbyoDzVq5W2opDiEG2wVua85ZPski/af+knnmcYE7?=
 =?us-ascii?Q?QXqLaxe36VeG0AoAp3xMg0uOX0rBidCr1JUvUgdN0QLQjr4cBq3lQYZOFVU9?=
 =?us-ascii?Q?SdGV3pKB7SXao2YLWLethKD2w+fXomdKxqB2gYhHWeKCzWbuS0nbk4Fo03d7?=
 =?us-ascii?Q?7wd5w2FKK+N174w8gnWu2PzD3vq7Ef6jcGrrLeABMwFpxisqG156xhFQdyQ+?=
 =?us-ascii?Q?JBi28TVjxWvEgA7es9vg3baCbpC3aCQySQVzM96ZxhduTrWSVR8zUMZLRy4t?=
 =?us-ascii?Q?u99MglhhOGICARDYerU9tHUzmYNwuJROb80kV2AOTcFX9HD9Chk53glW5WiI?=
 =?us-ascii?Q?lz3LA9xd2hbzN30N/XRDpggs+j3pdKF+Sv5JfgO3C89h+ID0wQRIx9NqjOIH?=
 =?us-ascii?Q?ht5RBBax4R/hZeqfGcTnpMaM8+4mbpJEvQ5bjKhtg3LfWSxzFMhx1RPTMicW?=
 =?us-ascii?Q?4rRd6RivMi7IHXqpzLTQZbF0uqbtNBc/WpV6RdQ/pZ8v+HsIdzvBvUyCRNbu?=
 =?us-ascii?Q?JQp5g0OdB26YtnxUWGA5th/OnjL4rAP+GebtqhHOe946dX8Y05KbeFGinIjS?=
X-MS-Exchange-AntiSpam-MessageData-1: dNtMtMYXUgQSnUy/gsk+UN5EEpuXOrnKD7I=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f746bd-4296-43f1-cf9a-08df10c28d04
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 11:39:48.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLpPF5QL4+Onm1IH+aj4H4dV17uZmYO3RmcAF2OYL0OtM0o5Ymsfe3FEmlbm+kgQBNb0+uZzPHIRkoKGUnipRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7478

Hi Bjorn,

On Fri, Sep 11, 2026 at 05:12:09PM -0500, Bjorn Helgaas wrote:
> [+cc Felix, author of device link leak fixes]
> 
> On Mon, Aug 10, 2026 at 03:43:15PM +0300, Vladimir Oltean wrote:
> > This is practically a full revert of commit
> > 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> > and a partial revert of the device link pieces from commits
> > dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
> > 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> 
> Can we split this into three commits (dra7xx, cadence, keystone)?
> This combined commit is applied on the pci/controller/misc branch, and
> then we have conflicts between that branch and
> pci/controller/dwc-dra7xx.
> 
> I think if we split this into three separate commits, we can apply the
> dra7xx one on pci/controller/dwc-dra7xx and drop Felix's device link
> leak fixes below so we don't clutter the git history with conflict
> resolutions or irrelevant commits:
> 
>   https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=2b9a036b568c ("PCI: dra7xx: Fix device link leak when devm_phy_get() fails")
> 
>   https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=bdfdf654b4b2 ("PCI: dra7xx: Fix device links leak when dra7xx_pcie_enable_phy() fails")

Isn't this patch already merged in pci/next as
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d
?
