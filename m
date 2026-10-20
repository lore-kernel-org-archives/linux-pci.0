Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485380;
	b=EJGqX6avBCTo0LTWCmSsg2jsPcVyl8LMLzQYWQANhiM9d0pP/H0mgYu5x1Ero+Y7pJVd
	 kjT7iepzAXEP9KkLomEztMQ9ZRieBwecUsAhOEEMX8kUI1EGo+WEwYuoWyPIdO+SpfLgs
	 lYUS+wuEws6OT9JzGIoilciml1HT3tng808YWNFQ7P2vf/5BhUVHkAJpEmBSDrWm83frT
	 g6BrhPETUONxeki/1r23mRyYrqVmnusZS2sQtmPnxY6REeOGJbZVdO99x8i8aO7sxB8kr
	 ySuBFPL6mBr0L0PHaDsU5iIgJGEqHAWWQizTVBIDEiuxfqcp8m3UYwSqggh6bEpEL0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485380;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XuobEXwqHlVu11oTVerMEEAVkHjwS0JpvhTUTNPJjRg=;
	b=uMNucYZ56AWlhmMbjSf2ZW2qyQ+ZSunVMlGfNtk/nWEX5Zj1LyKCVFqOEasBez4t5e84
	 aMCFqh5MS1SwjXFGuOiKIysdSb0GTprB+aar6rcZfy9K/q83TNSN/gXi5McsO/fPILF2r
	 u/vFwo8KUejS7xlkevNMzHhGvhx4UXAWAEj0tHu95E3fNLXvtaPhgusSFrjDu+D2sjEuq
	 WzqCOwcQwMKvcB4lVbxDC6iVEx1ss1iIQg1mN34vDWZqJF5SPYTuSR9bacYJ9yclM2Ld3
	 HEfZ5ggjGs/HdTp01x0OYEMroKx9nGBe82jX0hd2XQ/egLXk034Gi7OLzeNh4ld+hDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VmfJZcDf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.83
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021083.outbound.protection.outlook.com [52.101.125.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568EE606A319;
	Tue, 20 Oct 2026 08:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 568EE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VmfJZcDf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0z0KweqSJTELyq8cMgbEv4dVsGkYDE5h3oJO9UULwwkgeJR2DRcWNz2lyrOCi54/g/bm+GJkisk90iJadxpkhp8qTZZQNKFIlTSRB8F3opo86rseJYsiD7k0NJBkXBWDAg/DnZnGmUU0XQm71u9JKe2fPJCff1kgTNfKnWloFq9laCH48fuIqtNXOXApyZn53tnSDS+5lMJz3Wisxvmo6j8kCD2DqLua5gSgfO95FWv7I7l5pJPJHzm46xV6Qrol6GOIMBXX62wxm/IW6s9Ew6Bv1AV4hAWOCoIHCLw4GCA9vwkR/+L3WkZAd7/9S9QIxFwadXUt3/lVKb9y5MQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuobEXwqHlVu11oTVerMEEAVkHjwS0JpvhTUTNPJjRg=;
 b=gDhp3ivfB46gmRWyHduxPXOM+IYE6ShAdKZrX00bkyyoGDe7oVRz/uAyZ74Hhv0tQ7YNEjq+SzmPGgnFVcgiKwMHdcKjejt8eS8VDWgiqXm2QQqXiX+kdIwirkzVfnXnEP7cVw3Ze+bsHYtNIsTdvBj2VZjT+VRMpFizLRHNAiq/2BMzbj/b3ceK8qXdrzZ8EyMmkj4VGwA/c597/YJqAZHCb/hlfCPRVUG0k6rGLFvcJ1jKopZycHZFrHmU31VWNg1O8pPhNF9PYYJ8XnoZ90Zj+pIHU/lzx9OVOIpDGAmvJLEr7+f0Q0kd1dLTNns8qoRhvwKO8r3xfR8rij3+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuobEXwqHlVu11oTVerMEEAVkHjwS0JpvhTUTNPJjRg=;
 b=VmfJZcDfnOimbFsT40N9R9nD0wwbqbd1I73Ns75dLcYaSznU2WFWi7VnG3qlGwEM9u/ltltg6ox635jpWbzL4c2xfOXnMnoFbZ1gwOKZNBcNT+ANzNrxc7BrYXvo9Csg2VGo2dHWKJ75KfRC4Gjk3tOBxB/txTcDi0SAIQNHwxc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4112.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 08:36:10 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 08:36:10 +0000
Date: Tue, 20 Oct 2026 17:36:08 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Xincheng Ji <jixincheng@ultrarisc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Jia Wang <wangjia@ultrarisc.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Skip MEM outbound iATU setup for identity
 mappings
Message-ID: <w4cjahbo4niiid7oinmkwjnnzgy44pfviz5pstwrb6ixkqazif@oifxwekunhcx>
References: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
X-ClientProxiedBy: TY4P301CA0094.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1c2e19-4489-4251-dedc-08df2e85313c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|10070799003|18002099003|22082099003|10067099003|261009223027099003|56012099006|27256017;
X-Microsoft-Antispam-Message-Info:
	UczkAktnrdEn4frC1m+bggz5FatO7p88gSvWN8uTGKD4fCglOV9K/9wlWPVnedKsWvUygo7mP6LzTWe2zWch+WkQzSXiJXyT2L0cLC4XaPzUyaU5B/eI+MFCq8Op9rndQ+ILqoUvL0LBxclCoZnEJHLB4XCLqIb1aEcM0QCybfMrIRbIFFmeUOraeohNa0fXbxhwg394kalN94czTP+itoF33sxuaz2kja4VDmd4qMvmLmzS7vxMlx/uObcOwS6E3JHckTgax2se6zFL5X/efafu4oYwwGnXFLvvYZ8muqbg49iQqkfjcx3AdtYI0l7M+PztLH0v9g0y62Ht5dqyVH+Y93k7cI67crIheeZarUCBe3sgp9bwDBBG6hjKkdk+lmqRmToQbsJ7Zks1Q54cBtne7s5ezkqz5/vqVA2iFoh7PYcCACNXlrW1TRX1h+c8TdiRPdV/SBHU8OZFNWvN0KoacQsXuZZkRqNbcLnpfGph2zmANtrdj5fuCRDG1VEKmLeM3+CW9WTaHFn+qg8NDAixSoI7jSfKOHD64BkShKt0SYvA498Km/PQhh8aV5b/bt0rvtynt6ghJpb8GAfTjtHzJ7y+biQbRxCEouaa061e6j1AyxPLrncp+VO4ngbs9doxINA0kOACkOFrWMjd4KXtAbZzX8o4neKBS8oBido=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(10070799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OEPSBPMzuUV9ujjZ53K+D7MSDDYRcGDdhEhsXmSLOt7UxdF+UbgtMgg7BDNi?=
 =?us-ascii?Q?ByJ/dzKrAy1bj3PgWHKZUL+XQGE3sGQcYg8PgP/R4Up/qsLK8tbc9yEZiK1C?=
 =?us-ascii?Q?v7wJMHNyRnz+rP3+0Ltmak+xF4YB8Wo+49IS8kEKkP9MOzCPeh3mf4lihhlX?=
 =?us-ascii?Q?n5/TK2N9fbQty2iWg0GHmZBTSiZeZNxBi41SUxc5hAIYHgMa4AHf85TNN3rN?=
 =?us-ascii?Q?nd/N1peK+/SvVYdioBHJHc6kXooI0lVc9LfAfc1z/psU8yhd/A2p5M2qJ7/K?=
 =?us-ascii?Q?54u7K+jTRDdwvdooXwHnUzK5EucuI/hqv3ti9SfET5cl2DTk86RfRHjaYzUP?=
 =?us-ascii?Q?u7o9prokabTFvbX2YlTpCgJfYahkt7sPRebeINddaqVqnbd+3KIZytBUf/Nk?=
 =?us-ascii?Q?sy2nX/N0oj/Wl3vZpkWkeuEb5yYk25I3kzKwAzN8P1/Z8jZIdFMmVOmx7Wi+?=
 =?us-ascii?Q?27F+5wS+Z78IHryTT2Ds3Gpt2jb9QVCeUZ9mNuhTK7Pk4LCouXgH+ArzuVGk?=
 =?us-ascii?Q?yPl7oXv66MkpTIfUZowacGxnTzxW7mlSLGmiR6GHDxIea/V4mbrUXXUPgmjr?=
 =?us-ascii?Q?5q0vp0T0a4i5qezwb+CMUYuGmqW73KUmnQFbaqkjukEZ2NTiR0S5Yb/JAoXZ?=
 =?us-ascii?Q?TIYmwkLvOUH3rIk02hVE1QMnBuF/c7Ft+rX6Zjy3BDd5aXPdQ5dWfyWCGJ9s?=
 =?us-ascii?Q?wRIKO9d0mAswWa5HLJ1VzPJ3SugZ9O2FJzf6MIK8e+96q7fW4/XC2I0hqVWw?=
 =?us-ascii?Q?YDMSM38n/ZeDrfm10vw5rxyNGdln6p5TVDdWIy5IsDpIC/vjg13ncKVOQ9D0?=
 =?us-ascii?Q?wYjgwikzLYQUrjwB/yz2TgAPWbwAXV8gHpLF/2+aEUWKp7gtO/dC+SO6LNMy?=
 =?us-ascii?Q?aoGJQ4zMQH3EJ5PaxJcCsqM8140U3iRMJk1y5SgCZfSiHSeZBgkFqnx6UQ+R?=
 =?us-ascii?Q?R9Wo9kqNMPSH4YmPK94AsxHbXythzVhefgLCSd0QxaZq7Ru8ACejzaCaNhb8?=
 =?us-ascii?Q?mqbram3QNG+TRkxI9HOLuwx1JR3niYuLKsK+iAG3ebxl/4gG/bZhw5Y7tJtq?=
 =?us-ascii?Q?OPUuuV5kNHznmTqQi6zS4SH0tYydO54RTV2An00JgYpaI5u9PdSGdra1E902?=
 =?us-ascii?Q?WyR1rHJQ0VX8MtV4uvx/m9dm6SXuAFTQOpkX39tBv5b9u9i3G4HyFvaeriXU?=
 =?us-ascii?Q?K3dfFLEpCKM5rG2QHgMmix5XPh9WGxEzLXnFgYTqEwET7tTlDqbxNYdpppru?=
 =?us-ascii?Q?HjV0fmyOO6BzxB+uANqVH3Jo0Wrpu/uGpxqnRB8Vw+n04IdzyzXRf6Hh6lIK?=
 =?us-ascii?Q?oInyF/PmQ+8nCSGQskxe9Bgh3aXug5rLNKGUwkFRipLt91MCyTOEA375Q7H8?=
 =?us-ascii?Q?5ES8xg69te7Z378j5BfNHcME9DtT9PzllZD93C0LcgVCgWMlsvNMedK1PUWl?=
 =?us-ascii?Q?HT/kIKRYkThFG4a1XajcmV7eGRjBZDIEu6wHm8Oab7FJnKgLD8b+6d340few?=
 =?us-ascii?Q?D7yc2X13//PSNA93DTsrxNO6K9QVImpWU/CkLmeBB7tQY+2Y/fVX3kXW+TTu?=
 =?us-ascii?Q?qsNayAOd9bNiFHetxpYo0dnRe79iMTdBzrutU5ntjv7uGdoRu3D6/SaOlQWc?=
 =?us-ascii?Q?M4gEMI6N+07By7CvmwG3zwqbR4OpdMCWck+8ZVjB8VpxdKc8mDsaY46Hn9Ye?=
 =?us-ascii?Q?YIgqA2VnIVXtmQb4lMQPH/h3/IkZn/5ociafmWShv2HTAJkZ4+2l5XDbsTKu?=
 =?us-ascii?Q?n8ze0GHMBfjw8o927CC4vjHbb0kafT31BIlT2pt+bot5JgLOiaof?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1c2e19-4489-4251-dedc-08df2e85313c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:36:10.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri1bax3rwjg++axH6kJxgvD/TmQhjTTAXORpZXTvctfWX7+PseehjYU518Y4XzTv8ywkxZRoeUASPW+mvw2NdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4112

On Tue, Oct 20, 2026 at 10:37:35AM +0800, Xincheng Ji wrote:
> No outbound iATU translation is required when the parent-bus address
> matches the PCI address. This is a DesignWare controller property, not
> an UltraRISC-specific behavior.
> 
> Compare the addresses directly and skip MEM outbound iATU setup when
> they match. Remove bypass_ob_mem_iatu and the UltraRISC-specific setting.
> CFG and I/O accesses, as well as non-identity-mapped MEM ranges, still
> use outbound iATU windows.

Tested this on R-Car S4 (DWC PCIe 5.20a) in RP mode and did not observe any
issues.

Tested-by: Koichiro Den <den@valinux.co.jp>

> 
> Fixes: 17b478b29cf1 ("PCI: dwc: Allow drivers to skip MEM outbound iATU setup")
> Fixes: 8da2b970ed4c ("PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000")
> Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>
> ---
> This series follows up on the recently applied MEM outbound iATU support.
> 
> The DesignWare outbound no-match path does not translate addresses. Skip
> MEM outbound iATU programming whenever atu.parent_bus_addr matches
> atu.pci_addr, rather than relying on a driver-specific flag. CFG and I/O
> accesses, as well as non-identity-mapped MEM ranges, continue to use
> outbound iATU windows.
> 
> The UltraRISC DP1000 driver has removed the now-unneeded 
> bypass_ob_mem_iatu, and the general DesignWare PCIe host 
> code has also dropped bypass_ob_mem_iatu, directly comparing 
> the parent bus and PCI addresses before setting up the MEM 
> outbound iATU window
> ---
> Changes in v2:
> - Merge patch1 and patch2, because they depend on each other
> - Link to v1: https://patch.msgid.link/20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 17 +++++------------
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 -
>  drivers/pci/controller/dwc/pcie-ultrarisc.c       |  6 ------
>  3 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cf5ca281e91b..c593a1f1c2e0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -918,19 +918,12 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>  		atu.pci_addr = entry->res->start - entry->offset;
>  
> -		if (pp->bypass_ob_mem_iatu) {
> -			/*
> -			 * The no-match pass-through path preserves the correct
> -			 * PCI address only for identity-mapped MEM ranges.
> -			 */
> -			if (atu.parent_bus_addr != atu.pci_addr) {
> -				dev_err(pci->dev,
> -					"Cannot bypass outbound iATU for non-identity MEM range %pr\n",
> -					entry->res);
> -				return -EINVAL;
> -			}
> +		/*
> +		 * No ATU translation is required when the parent-bus address matches
> +		 * the PCI address. This is a property of the DesignWare controller.
> +		 */
> +		if (atu.parent_bus_addr == atu.pci_addr)
>  			continue;
> -		}
>  
>  		/* Adjust iATU size if MSG TLP region was allocated before */
>  		if (pp->msg_res && pp->msg_res->parent == entry->res)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 799c05213ae3..128729fee607 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -471,7 +471,6 @@ struct dw_pcie_rp {
>  	struct pci_config_window *cfg;
>  	bool			ecam_enabled;
>  	bool			native_ecam;
> -	bool			bypass_ob_mem_iatu;
>  	bool                    skip_l23_ready;
>  	bool			skip_pwrctrl_off;
>  	/* Set if the RC loses power during suspend */
> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> index 523f454c6c52..a0d328c0c09b 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> @@ -154,12 +154,6 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
>  
>  	pp = &pci->pp;
>  
> -	/*
> -	 * DP1000 routes MEM transactions without outbound iATU windows, which
> -	 * avoids the 16-window/4GB-per-window aperture limit.
> -	 */
> -	pp->bypass_ob_mem_iatu = true;
> -
>  	platform_set_drvdata(pdev, ultra);
>  
>  	ret = ultrarisc_pcie_init_clks(ultra);
> 
> ---
> base-commit: 0a2602de077462d3111eb9fd3da5b12a57fc6c93
> change-id: 20261015-dw-pci-fix-c8e51f83be02
> 
> Best regards,
> --  
> Xincheng Ji <jixincheng@ultrarisc.com>
> 
