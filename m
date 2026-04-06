Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC32DEA75;
	Mon,  6 Apr 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493546; cv=fail; b=I96o2pc3/r1pyEt7rZl45i/dD0MbFfxAVwNz6K4Tl0z9WKKNpnuHI96FRYSZVJWj1HWxsw3tf+e+l1tQ5jEZ/IzuieeeHXLnPP0NM+YR4cuc2nPybcoASIE4E7bB66i7DqhVSSFaZ8+HYY4LsIco5qY2ykBcZ2LgPJqjF9PCw7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493546; c=relaxed/simple;
	bh=HDl/xJ2+Na4Nz9EtnMMAVxYHXWghGm43I6mfDMP0XI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUJVpqAElP4GBw0TvnnQ9Q9X/jeKD5/mKqVEKPoSqma7SBlC5RhHbQsrAMbT5plPs3Ll2aQi1b4otUBYRv5xToSNcCDifbqs53dnY3t74nDnpGbAyWlI8AogopWwh/bOUFxT//yeET3gUvGmwhommVbc4jRHqceU7lhxhmiVlQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YI3irLKO; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YI3irLKO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCC3Fk0CVsxdYsST3YEzMUVRkdSDt59B8eDP4YBub7SzmffaSiOqVMULP/Dza6SsYSh8aHlyIzji6yZJjOGxPKo0JBXAUSCvKhrKqxy8RNOqGBA23tOXxmLxwSaSnNuZ1wPZYWlPXXfKs+Xbl5Pm1NZv6TcnTDDNuydXCOg0qT64EH3H6aggAbXfkUUVLLxMxZUsi/n5IWKbd1zNo4hVi6CARqLJhRfH+UVRn2YK9HTm0XnchuCG7P1yFhbucqRtRda21IusDQwiwprELF0qyjWbL1W1BkV1NyU9s1YLEsjgzRkR+uwlb3PGvgKm5nU5VH817WaIybbNwM2oaGEZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NCWWDQV96Rwq+EhA4j0YCCBAJOyyIfA1aL4gfpXqKI=;
 b=HvYn5id1mUq8uOIBEmkci8f9XVyaq6uFJ6w38TB4rzE0xt1uJLQ/h3rH6JIQzFrlcOvSx9YYPj0iQqJPvBVfwqujPBvweGqdyRsKHamn7lfv3uBo+CbslTgr04KdNFhSNCcIXbQb6YrbPG4SFAeGaekdCQxfEN/URgqgg67VTGcnKZHMhJDn0ThF7bejQQrNpPJJRaPDhAEMtgsIEyGimMG+zukS0FAU1n7TqBRwJ6tZxUbeIs/YiIazsuTeZK9eaxP1cV0yEWGF2Y+axqfybmgdoHAPJB52s4BpwL/pCzdsiYtvTvkxrBZ23BbpRvhGL3ZkPsvJoYW1H+t6JX0nVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NCWWDQV96Rwq+EhA4j0YCCBAJOyyIfA1aL4gfpXqKI=;
 b=YI3irLKOrc/fiYg8THH0/Mw+wPhFrPvgRpVIpzmL+5DeXl4x1L8YY7kDKX3qos6F8JzYoal6faRZ2O/Rn77DVm93Ts/nyWHf2Io7cCaO+jvKoX4mOoSGcRpMJYdYQoa+/4pHRAHhxphf5n5jneiaLjie334BxmANIkBGYt9nIcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2674.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:255::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 16:39:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 16:39:01 +0000
Date: Tue, 7 Apr 2026 01:39:00 +0900
From: Koichiro Den <den@valinux.co.jp>
To: carlos.bilbao@kernel.org
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: validate BAR index in
 doorbell test
Message-ID: <bqqpugb2vhp7pia4pptktnv2ky6briu6lgvlnmvtopdx3nqq63@hgdapwdihxe4>
References: <20260404012002.111873-1-carlos.bilbao@kernel.org>
 <20260404012002.111873-2-carlos.bilbao@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404012002.111873-2-carlos.bilbao@kernel.org>
X-ClientProxiedBy: TY4P286CA0116.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2674:EE_
X-MS-Office365-Filtering-Correlation-Id: a64dd1e9-ccc0-4088-cb5d-08de93fb01ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	D3Q/t7kpz1SVjqCcKVRkmtOa7JbYwzCoZoYlP1Wt/aTv2Qp8oBIfFZiu9XZA+zTomAM9TdgdM07kTe4u4Crpcgwm+WEy+dt3+LBYsiIofmB1hx1nou+zUhKrHcqGQTU1jUPs6gk3YBrdEgJOC/MXhdKyachaTZpWY5J3rIKKKocsRsFPSbozPzBILjBJ+A9mcoloxGigQoBV/gh9WKs85gQV84gpiAkiElomVUVoM+cHW3mZT/L48PqJB1SCRhyjk9OmfBS2OiQavKnmfNE0NL/ZcZH5JO87VVjKg88uULG+bEBTUBW8D10eWJeU9g5M5AWhKOj8b9R/EnPzDAjEke1+4D/2pQuTH9iS9rxGCJOXm0/ErdGbO2q7v0sCFAJlDmoierHbdcvYHGXXs2dH8BHKJwWFdcuKBKp/iSNzTHQp5pgAPPGy1qdRYAX5cF2OmZRPUihPO8O0TR2r5xEEeZsdJ3DXuEkmIL1WYxnPN8wituCqsTq0lSvVBSsJZR03qoNA0dIz9BX8m6uVFZzKt7/b6h1e9IWKhdCVDG5LW5ynmxoo9Fg9lwM3/rgWi3Ms2uAVkfcVVnIGoYyCJYEJOxNIWwBmN3PyywAGHCDXyTe+yolvFsBjLSHeZknFT0O24l9Ao5E7AeKBFg9x5zBwKeYqcqVteM5j2ALaKyBryAn+/nEuJWVCffRytYfcChg2eVTseXdgCGz2/GIIsIlNV07deZJvmfGhdVFLBx2jWBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E139lZDEj836GGku7+1SXl8+kU9zVjB/vPmcMpK0n52SWYYEylzDvArQiOXa?=
 =?us-ascii?Q?xxAGe8w7vkGW9NeAjYkJFX0yPIQsH0oX9pC8o2Mj2DFmX2YxJEu7RKgpl0qv?=
 =?us-ascii?Q?MtPNA+vO7GbWGyiioF2Nm6BvJFeJqzWsqK2l7EWTLhSNjDnYfM4blwrzgAXV?=
 =?us-ascii?Q?iyn1sVSBW+dtSJuMGg6x/7JrpjzoUcTciHB7smgWSZAnIsn9USP7mJcla1lz?=
 =?us-ascii?Q?03SvvVwfb/PPKl+sHpAr0bMo45e/lWAWBzYggKGEz13pVn+LWQ10sHpDHTZV?=
 =?us-ascii?Q?gmIXX6R1Ga3gHDOr5HysUDvI6tArpmGGZh63aGExA2OkkBqiSHpBEUrFeWF8?=
 =?us-ascii?Q?sy5sb416W/bPRc/leTMcj1KVYotwyIBznoNfAMGrQzjK1yXthqall5DVil4o?=
 =?us-ascii?Q?X6veSM52BmPWX1k5k2u0mrla0A7INbwCL8Hx8xwzX+Qx28AI9vhk/b8jppcQ?=
 =?us-ascii?Q?B567xkPG6LosWZecv+6jFMesYNXeynZpGMdhc97FkhfKgc9QJBrK/hNaVw8T?=
 =?us-ascii?Q?i7cYAfC+ucVsKCZshnE74bxWPaw9slfuU468Tw8arpQApD+Nh2X4bVLiS/wx?=
 =?us-ascii?Q?gSWmojGEKbABlEnDew5I8Oghpmqr5qZ/oDySUUSqR5LHAU0a0kr5PZel/qml?=
 =?us-ascii?Q?Zqmyt1QwNVRVPkf7Z9eJKMtbZArUy2umKwDZUBGvgx3PCwJC8HlZwDDy/sD6?=
 =?us-ascii?Q?UexsEDh4/Q7YRTKeAIiKGTVgqUSxLEvRgngc0RKzZ6xsPnCdJU9dWWpqlqMZ?=
 =?us-ascii?Q?eIVoqprsbeOfZHrXAnMoQ8WRke97aR58KvcmdROg1OvIjcKOTZ+n3Le5YE0+?=
 =?us-ascii?Q?N2V08AH8GUUBxy1+KoH8dJ2EdAQCmwoRriLLJhv8rGZEx8q44wng8L9aQGUb?=
 =?us-ascii?Q?CbgvfbPp0iQdsuHcyNYSKjIZLVFRX24FAfe8WXvAYgS05l53awzOyaC3R24e?=
 =?us-ascii?Q?SbWMZtKFGyBaUwiaBnoRjnWjqssAPX/DGkR7N4gRFoPqeAQlCrlEr0kE9jMS?=
 =?us-ascii?Q?4oDPOf57LJOjbVX0hDb2J1GQF0jeO89+isykNu+2HvQiws1K2Y0KCRZy1y7i?=
 =?us-ascii?Q?mMH4hMhvIFC0zjgucMW8C3aT3PWvrtfypqZXLnkWPCue3VXIjquFiVAdKw2P?=
 =?us-ascii?Q?a14OM/6tr5sNkcp3ndEfpHIKMGkjZL8CeZixwLHo1hjztPggfm60CvHzu9++?=
 =?us-ascii?Q?Ajd0Ol+6QsjtgvEvy+m6fGjgZUeHRKozu3lxqA7X+CN8udWCWg1KuKSFzU+P?=
 =?us-ascii?Q?ckqRfS4YDw5pNDoA1Bm348/a4OklZwabcSY/wzOZhK5a//qRezhK0E8+K8gU?=
 =?us-ascii?Q?zHsqbs/qs31saPArzt95LO65ODDRjQSvsOY+nVs+HSmHt9YsxVCY1JVUcyw+?=
 =?us-ascii?Q?UvloKpNAK0u7/ypKB/We+76GigtnnrCmfqSMsdLEC/g4CWn/Cr1NJcgMRQ2p?=
 =?us-ascii?Q?KIl0tpmGQiUQp00wSzby138gJaUX9xSQFpwfgTbePLKnDtXPcsVgrVOkBceT?=
 =?us-ascii?Q?fQzUD8k/sJNzEbNXvJccT/TzuhzILhpqVNFLfOUm9llPcm3msHqcFwU+oQwi?=
 =?us-ascii?Q?LsA3IwugFl59et7qnARCoiShBZP/EHKzyfZaXzR8xtvYaKrFUt84kpHx3U1N?=
 =?us-ascii?Q?n04/hRTC/eY5tCHETuHrmcvRx6E+wlR83mJhysuGbVhnwl5ruNGVJ2u7C+5L?=
 =?us-ascii?Q?6KmlkiVDv9vY2OKXMoRBu57M4Fi7tEW28x6JPVfDrlyyC49fSKg8boVg1tht?=
 =?us-ascii?Q?IE9J1pjU/CvUYmwNwdXyeahLDTp2yBKgHimOmQL4S5xSueMi1Rqu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a64dd1e9-ccc0-4088-cb5d-08de93fb01ea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 16:39:01.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snCcdQ0i2GWQuQakLxfFPgDA+Q2hlNyYH9REwhqkWMnsaPrajNuUd/I76fPWNFTlYx9YqHWpXR9pFh4OINCKxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2674

On Fri, Apr 03, 2026 at 06:20:01PM -0700, carlos.bilbao@kernel.org wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
> 
> pci_endpoint_test_doorbell() reads the BAR number directly from an endpoint
> test register and uses it as an index into test->bar[] without bounds
> checking. Since the value is a raw u32 from device MMIO, any value is
> possible and if greater than or equal to PCI_STD_NUM_BARS the access goes
> out of bounds.
> 
> Add a bounds check before dereferencing test->bar[bar].
> 
> Fixes: eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
> Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 74ab5b5b9011..276bed3f1c18 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1089,6 +1089,11 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
>  
>  	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +	if (bar >= PCI_STD_NUM_BARS) {
> +		dev_err(dev, "BAR %u reported by endpoint out of range [0, %u]\n",
> +			bar, PCI_STD_NUM_BARS - 1);
> +		return -EINVAL;
> +	}

Hi,

On the EP-side (pci-epf-test.c), doorbell_bar is set to NO_BAR or a valid BAR
number in the range 0..(PCI_STD_NUM_BARS-1), so if we add such a safeguard here,
we might as well handle NO_BAR explicitly.

That said, I'm not sure this check is really needed. At this point
COMMAND_ENABLE_DOORBELL should have succeeded, so bar is expected to always be
within the valid range. Whether such defensive checks are desirable probably
depends on the maintainers' preference. In any case, I don't think a Fixes tag
is appropriate here.

Also, even if the intention is also to guard against an "all 1's" value scenario
on errors, then I think it might be better to handle that in a more centralized
way, since the same concern would apply to other similar reads as well.

Best regards,
Koichiro

>  
>  	writel(data, test->bar[bar] + addr);
>  
> -- 
> 2.43.0
> 
> 
