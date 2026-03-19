Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020131.outbound.protection.outlook.com [52.101.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBAC2750E6;
	Thu, 19 Mar 2026 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883728; cv=fail; b=mAG/ZMrWuO5O7wGWyBbZgPjSYAB55SNzoHsz9t9ZGksQ03nmjRAuY4xI2FXuf/TQ99VItiSo9iVvA9gtIxpoot+d2ac0o2oQDw9l2fuYIcwT/yMsaDQfbWO+39iGNjTaeRrlTloMC9eYWA8a4dCPnThaA+au2doLQC5ib+zU8vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883728; c=relaxed/simple;
	bh=+T7RnPpmTTFBbyTchhblzDxD9ZAOdwCOy8ge6lT9d08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CKNFjaa2F2rqovxKU1ZaJg8Zac77QyRJMz4B0/yOizzVMrW8C6iM+vXPGtVOlztEJrhO4kikzwlr9MRC/aCIa1zup9/TQZzUmtVXX4Kh3pQ/e/J4KZJLhvf0p8dCy90f+xTdvNZ8Iyi+Zi5bV/8iJMCUGcmdn/hCWnHGBIMib78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=orAeAcVq; arc=fail smtp.client-ip=52.101.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="orAeAcVq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FArSU4bgs4NTmeroA1c1gYV8cBagNFCgzHyvyxeedHzG2f+VKKI6zzQbthhjjIYgNqWQ4mc3FIfK5DSPv3KRYaMiCQlmz2xgkSAcrIsNE2rq6GI/msJ7ZRM0NBnGyZEF08R5enYl1Kf/JgxQxoB8ktc9a2GsnpcmvoS/LyHU1xlVF8fcTdyZrjkrLF1ej7lBYRwUAygHVjT2OBz69csyfA1Wc3REFX/YPYVfcl+vJRkA+yZ63JfJ1MqvAac7bdnjNIgAoBm9kA+QdF2DHszqiF00aEAc7tgJEtmWNurWezZgj7zxm6aj6o1sFopwwYjPiolOJdVb2B8ttwvzOGZ99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aqv8MrKoBZz5GyxIamimtWY4LRFdFk1XJCXfE3aovVs=;
 b=XGqIDWdiT1mbZ6W2bOOcy/2xczDbJfzN+o8dic8BHRpEc1s2iznDv09/8vdnle7pri1EXc5rXUCzU3R3BAHffL5wHqAdvvYDKhZzNXL5ePyzJElBSVxndLeW/mb9F4v/elaPzVNF8biUDn4r86oOXImsqOWdUmDyeqdKg2jIDgOK8ovicMmkBAwogs2Wh4RHmB9McQp2ctZ9uQ4LLW6q5m5iwMZNXbbP6sghgykpbNPRgVycLfuKS5hIHq0yz5yFEsKFUZZrZppUJJp825qSAtU4LxzivMZ5y5I2yANLRpQoqZw6CUr6QcjhvuyThTrzkRjRXYMKgQbsne0rN68vAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aqv8MrKoBZz5GyxIamimtWY4LRFdFk1XJCXfE3aovVs=;
 b=orAeAcVq7K7xzjuycw5R17CXasaZJZelIzWUsu+BJ4aKunz5f0vZ8/U5/EDFJPvYiKFcsswGXCmZ82wyoJODDtFbqyM6FtEdvX9dY++ze54381cYLdZ8qpC2uORz+Zg77FOJDN4nLndXYiurvqkdIn49br/MAi3XJ8KJUZ7k+4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2153.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:176::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 01:28:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 01:28:42 +0000
Date: Thu, 19 Mar 2026 10:28:41 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Niklas Cassel <cassel@kernel.org>, fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: pci_endpoint: Skip subrange map test if
 iATU allocation fails
Message-ID: <vki7ty3z5jncmzeltk7udsbynffdld4xhcm3b2yjrgx25cfqkm@4ld66m3jbjqo>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2153:EE_
X-MS-Office365-Filtering-Correlation-Id: db8365e2-b6f8-4da5-2c9a-08de8556db42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|7416014|1800799024|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W+NHSGI4iQdJ7X7Z2Y+2EUJAEJubqQZcygcbA/zyVKALbyMATo7n1gBCVW1amtEuZVi8CwjEu5jmSgGz3m2QhldHrXOtVuHZm1beIjoTyYtP7fgnoP5oDlULqzmneh0SvMUz4IOQfXUEzanjqYxhL9Ffctl/qnNKz5uazuHNcwnRfRXS4itGT88FtL8myeeuXwh89molWEuZooHeVH2RFyIxt1xeFltsRmX/40EEFxRujVmLECzfM5PvmefRxBTpIAqDeE1BX/vO+VBNnwcwfAOKQAOZgjOUKPIKWTjK3ZpGMgTVZmoy53+rF5AO/uvikqWHCAemSu6FwwDkIlwC9h2OYVE29lMU2atc+BY6ZqpnttIYjHtny8CLuDVhPC+urTAVcz5ekVQHDN4kINjXA43tkM1PGVkIUl777EbEQNST5EemMwMdVhpB14as55KACXD2c7o7kOPQAavsp6MFnys97mH+IHnkcd2uVcLKagVyMOB8ZbX/kAtMRms+XdZjg3mYrfBr14TbFI0dhV8naOraO3ij4qKfKaS97nDR9tzhLWlBC7HnswyzZ7A8Kk3dkWid7xm2kt0d8lbXaPFFUvOJLilpLqD76mLtHXfezO4hHBrX1ckwra93YNInW9kwdnp1pnyv5VPEP7rlQQMgQH9+edJLQd2b6jp1DsrwAMntpehi/TdrzpqJibTRgBRu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(7416014)(1800799024)(56012099003)(7053199007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zaZFkm/i68UCukEsRNPZBizFBENKrhr0TOtmMZw1uRVLEfAtgXplEEOiq/b2?=
 =?us-ascii?Q?OvOTRAVeJuMzoFZ49yTayXeA+BZnCMBKb2tFZW2c0rOn8bZ2cs4ccNFPLZJj?=
 =?us-ascii?Q?y+xH0lLN0cAmI78vVAcXdoXWei/w2dvnE0aB1MV2/uJquM9QVwh+s/pJORgU?=
 =?us-ascii?Q?YJeHZTMV+X6xE16sPCVXbAAHPvCmJBWw+LToRrNlOA4aX7mByUo9gF9oWolm?=
 =?us-ascii?Q?sknFTQXjLbKvQo6EJnWADG7uDpbe8iwCo7JR28tBNDvk04P67SoNxexFchWU?=
 =?us-ascii?Q?E1EyMnxZ7Dub/QMHOVFaO2nLJipFcZKgKf2bIrbrUhTVjJ/b5Pju8vIqJgyZ?=
 =?us-ascii?Q?BBmIgdfMHSu1FeiVB856oK+CMweDppOpsJqQ51P0YeLnqgu6rZd2eoSDZAuf?=
 =?us-ascii?Q?rzC7N2VJPIq2MLchZmd+zwf6wqEWwwzb5wIWOOR3QdCxbXYt391EtqAa02fc?=
 =?us-ascii?Q?cmVzoBZGX+yNhx36a78DCSE9Zr4uz2eEO3s5s7Xkk9DWA4ZkKXytnZAM5ZSA?=
 =?us-ascii?Q?SGCRr9b/+ZpM0LUZVkDUjQ6wmc7LKRROMQ1DO2RxBVm9w+4uAfWRNU5bOq+V?=
 =?us-ascii?Q?jWYvpGUIJ3y0OOx31UCkghdlnTv+ZoYB664i4yDxtr82DYgPOB63ITMp/Pld?=
 =?us-ascii?Q?42HOeJuBMm6Pju/S85z5sk//NbQ+hvHEW3eNAISYJqQ/RzYxS7hKzmHqGV5o?=
 =?us-ascii?Q?Nlm1ocN8hqlu0lp9tfAhGa1tU7Sz5pjPrWfhZgCuWNQP7anSIbTDWGACvAjC?=
 =?us-ascii?Q?91yfJVf5+vfFPIhMa5o1E8MEh4KhB3/NkyajgSqicMbuwnZRK/tI9SyDXO1W?=
 =?us-ascii?Q?yW6jRsqpc8TxDOPCKwvwHK9jjEqHbV4q8gUAtJ9PP7TslyXyTWSgWJfvh+Gr?=
 =?us-ascii?Q?8dXkAniA4Tnbr/tPtipnPg4i8FpO5YNF1Z2g2FcQBcec3kkfVNN2Nn+ceJFG?=
 =?us-ascii?Q?KNQgu99EyFKro4gYHUEdX0P4Jni+Fcyt0z3h25ljGX9D/dJ/rJdy2/ZM+qHK?=
 =?us-ascii?Q?7Yhc2XqY4LuCmbfNHUhCiOQqyqYW12iye9ZT8Aic6yj7r4do7iUPrci1SP9D?=
 =?us-ascii?Q?gRr5OcqLrvSQVgiOIvBBcrTAfvTGfJ7+I+OM78VWGp64XQLRXm2dnC9PLaFq?=
 =?us-ascii?Q?U1D5FX29mh3ul0zr14OJV0HBRvBD/ccFrMR2qmXDNiBLvjwCmOXA18g2PxEd?=
 =?us-ascii?Q?e8CVVXiv58mztcwNXhN4zy7wf4wMmeRuJ2Z/rx9iRft2bF8occFG9FJy54c2?=
 =?us-ascii?Q?Kob1/Uck5g9UzcnmC3PdmanSLT9PMmgujypnVlNgfBRQZN6YYBzYkaem/nZW?=
 =?us-ascii?Q?Rah6trE0IQW4bSpMo0x8rtnYHz6a/Tf8m6xmSttFC0rl4C+VuiwUEtuLIDfm?=
 =?us-ascii?Q?KTY1cVDmJAFjnhZ/EEnlb4T+hAqIXj3FfszM8DiF3NT1IDjvh71n7n6L9OCv?=
 =?us-ascii?Q?pGihVl5Yy6nnAmFYiMBoMN+RlQCI0VAUlV+xfirUIcdfNgea4e947yOKM+2i?=
 =?us-ascii?Q?RvG7JbsVqZ4ndZWNf8daBDFbKA0OKxcnBDjOzwBvDok++p6THhe7BSPWRZCC?=
 =?us-ascii?Q?YSzQdmpFKemzfn3Ia+dratH3LCvN9Poe5UWZBPguwstK8qafgN9Mi0i/c/Q3?=
 =?us-ascii?Q?1xMv4dZtEdDL1cI9ISqlHdfFJibwHgR20ODuJkJ5/x1p5rxlFowmSp/qCJkX?=
 =?us-ascii?Q?a4JW09oRQrkTVXN9JbL7IigHLjJgZ9rFc/h3SicpZhc2cdOeN/ISkU9vAHvP?=
 =?us-ascii?Q?i+dYhYJYcbrM2FO++mY+qqScfnkOeUAlHv7YKvKdJW4AFudkLUHL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: db8365e2-b6f8-4da5-2c9a-08de8556db42
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 01:28:42.6728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sonT/8fmkIpZe5WT4F1+B+19oN/nNCrSz5nSA3WgCEIjUIXUYxtZyrb/C8C074n5mfde1Z1A4uTs3mATrbMVpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2153

On Wed, Mar 18, 2026 at 03:46:27PM +0100, Christian Bruel wrote:
> Handle -ENOSPC error. If the number of available inbound ATU entries is
> insufficient to map the subrange, skip the test instead of failing.
> 
> Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> index c417fb3a198b2d92c3060938c23807cc8bea5573..8ea2fda4539d11eb22b22800a7cb8bbaa99c91ba 100644
> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
>  		SKIP(return, "Subrange map is not supported");
>  	if (ret == -ENOBUFS)
>  		SKIP(return, "BAR is reserved");
> +	if (ret == -ENOSPC)
> +		SKIP(return, "Not enough ATU entries to allocate subrange");

Thank you for handling this!

pci_endpoint_test_bar_subrange() can also return -ENOSPC locally:
https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/misc/pci_endpoint_test.c#L538
While that is a different resource limit case, I think it would still be
reasonable to treat it as SKIP as well.

If you agree and keep your current approach, then I think the SKIP message
might be better phrased more generically, e.g. "Insufficient resources".

If you prefer to keep that local case as FAIL (or at least distinguish it
with a different SKIP message), that would likely require a bit more
changes overall. Note: Niklas' earlier feedback on the SKIP message would
still apply.

Best regards,
Koichiro

>  	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>  }
>  
> 
> -- 
> 2.34.1
> 
