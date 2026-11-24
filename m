Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795511948;
	b=x1rEo1+Tqh+Tv+ez/SLBNkB/DI6w8Ihqd45C/DxB4ZSvenONthy/vjb0N06McZskLl56
	 G6o6p4y8uj/Bwl2TUf5JViUS8qEg7jrUdlJi88AgsuromXd85FLQBZvvdQ3IzTj5qqvi2
	 JoScXWifBKRNyN7ZpSFkDPweXLl4SkMs5NUbb1eMJyl8MN05qG/DHO5yDB8gdD6jM7HGJ
	 bHevZ2vzAsNDD2w5qEboazeGNCd0yNFTLLy/hMaANuKIjZc7LbSfMNU/M9iWRbpLw8dPl
	 w9iRgo8sOLmQYrtV8IM73o8Ce9br78csMVPMnmSQwkuK9eM5YJo+kKJOpvL4iQcnkUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511948;
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
	bh=cSzYOEuMkucaoAGEmqS49LkiH2UGYv7QRvRwryWZXFw=;
	b=eYtREetYoFo+BQvs5RZieRYrw79gJiAn3ZnuX0vaS76+iBIlz317tzY4bkzaiH5//RvR
	 cLLM62Scf4nEfJMfiHQJqdlVg51by0nQEiYORTvE0bRtCqHXHShu5jOUPLS29wxeCGb19
	 01aAAltRzj5OobbeTTkazYKRnrjYXEVRAAq8yyslNEqrdGNeBJYBgXq2ZeJ98B1sNKJVn
	 Chc5CtvSfm3/22V/Od0JafjU3f7uusJPaN/Sk6hcMwkEcPcg23UNZYnyPc35vEgECLBqy
	 j/UQwa+h00dyO+vVg5faqExF3xR/CYz7VoPcUjjgxZXuhkouzR+4GJFKbNT+Ee8CCSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=myv0Evhg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.16
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896A606A68D;
	Tue, 24 Nov 2026 09:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C896A606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=myv0Evhg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAdKnziR/frajBVkcRGXrGzx3A+HLfDA9F9gLioalalzj6FCCz6kTCmZMe5HUjecQoni2xp30leUTEQrNpardk4NX0t9jrKiYAU6aEaWAfmZsuvbPU4JYtIbZM3krB2bttfus/9zWPVQPU/j/xseFss+1hujJnCi51fICMTFW8exlPc7tBKdMs3esi1psCKmXkRxZm9iRHLf9K+lGkaEeq/sBHFSy4NO8DLfMCV+Cv2R0bWWUAs5zU3JzTXkXBhavr46XGn8W2o742dhf7ktsF9cjDqK3sow4keBerEReUD3n/fJwg3cqtBhBrWxANuZwgOebJ7M6PHvN3uJmhPZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSzYOEuMkucaoAGEmqS49LkiH2UGYv7QRvRwryWZXFw=;
 b=VppXOsNeYHA8WjlB5GuIDoeTg+AZ1BWWYudyshJGn2nTrkohhzgz9QJklGwqh99eCOwsm6whwhEmUotArDkxsqFsOGuqwQYtLE5lTBmTzfMvT1rwYjxyYAPsussmQTqEZidwqemUXlevnj1oneLBiEc05Cyx0bl6DngHRCIxdf7ioWRQvWv4+bVgq8ObATsCYR1V/XFyJXV2IDn9pBfCWCUfkKvPwXCoQMocqPFEjBkIilxRE6sa5YFXpVGGTlIdQONICBKjW7LjsM1w4kM6FjzxLMcbrIkRrHEyR3psMEq9szUujylE8grqk78xEJ7d5cQ5h5iXLXRrmupmqXhw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSzYOEuMkucaoAGEmqS49LkiH2UGYv7QRvRwryWZXFw=;
 b=myv0EvhgOWJ8XxCTeNZX9TK4HP4DRW6bwS6YgkXIJnBB6kskXmtxRC8jUCAIIjmCaaXxnBbEmxTIk8ZBmytzItgWWVjSvCQNfZUgj3aYoaRU3F5UOAe0Hh9x63dBsr/E1UPRU38CTLNgCubcYTJiMGesT6qE9CtzstvN+jYKGreJY13uvwxUk1jImxTKKq1nq0SGoT6pC7FbTRUrHr9s2zIbvPNu8F2YRSwSEf0CcZguqG7qbfr4oKMg6Xxpllaov/PIPXIwR3yBDHop2abuk9HbmvOfpNvoshEQj1nxb99eCWk6IY+U1+2jqHvXH1a6ZmogzLT1l1pGgUpIPMiR9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB903269.namprd12.prod.outlook.com
 (2603:10b6:408:40f::22) by SA1PR12MB9001.namprd12.prod.outlook.com
 (2603:10b6:806:387::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 09:19:00 +0000
Received: from LV2PR12MB903269.namprd12.prod.outlook.com
 ([fe80::29c8:652e:e2b0:4dd1]) by LV2PR12MB903269.namprd12.prod.outlook.com
 ([fe80::29c8:652e:e2b0:4dd1%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:19:00 +0000
Date: Tue, 24 Nov 2026 17:18:52 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Joshua Machauer <machaujo@amazon.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com
Subject: Re: [PATCH v2] PCI: Skip the CXL state update for a VF
Message-ID: <awVWah_JWeVLzI0I@MWDK4CY14F>
References: <20261123162035.79133-1-machaujo@amazon.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123162035.79133-1-machaujo@amazon.de>
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To LV2PR12MB903269.namprd12.prod.outlook.com (2603:10b6:408:40f::22)
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
X-MS-TrafficTypeDiagnostic: LV2PR12MB903269:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: fb21489d-af3c-4f29-f664-08df4a0bf948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|11063799006|5023799004|261102123227099003|261022075727099003|261026140227099003|261022105027099003|261021121427099003|10067099003|261028144727099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	ynKlc6oE9LbH71eFAKxpk4vcLYvOLQcmhPD9LhOELvOe8ERp935sARkpY5TUluEyeZEftg4qzhkoBi0bEM3p/ZefnIRUsScEPN1T9THt8qNg3CPmymt4vOu51h9RlhHanHCVfWueJiPa0+/pJIarrlBfevAGpZ2/FemGYHj6lrX1xQfN8AGr8y617Hrfwc7QCTGiWGNDJeH/8fZDr+WPtATOiGxUDlhLiA/xgI8+jwv6WltaN746ZUKNlnPn0yKBIr/1aFxF8jm9bFKi8GoaE91xdRE2ADrOlbC4RNe3nMIMJxBzujXmi5Cw8Cxpr7j2NXYqg00E7SQMc+U+lAuQcV/u9+ZXd5CzworAm4AYBKKQfI4ZnRi3hBbzQq5KEJW6OkUiyAKMmJpAX30GbqrMqa6kZlzarJ2hVr/7Qh1uxKAWdTChw8vAvz89fdGLUF1iM9Ek8EqnHTdDFjOSCi33b4NC4I+MXSERma0pYRKbtoHCqnJyTnsuWoATlxc/IrxjdFZm1ApN0/UwFXE3B6qCVZCe29dC6WYMeID6/+ATWzhFSu7+3Y5W7ExjZVAyNcyzEeUbhukRAaNwRo820P0zNIxi5Qbx7Rp9QJGOOcOJUTM3irH5BMcRK4kaO6gtV976+eDgndrxjfk+A1LK4um1bek3z+0ar68L68OOocw7qfk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB903269.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(261102123227099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003)(261028144727099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43/KPh4yrFATUKeI8qU/Du6rVFNSw3F59BUNlELHhXcFSJB+wn4bbNi+88GE?=
 =?us-ascii?Q?wnM9rtszVumdFY8mzJ28KoN5Y6U0cydP9PhUzrU4Ab4l5/2XwbF5fh/Rxffu?=
 =?us-ascii?Q?kDWIyWFD1hg65U4qb64tHiAscMwrT0Vrkjsz5MtkLedK5mTLAC+KPK/EdWAa?=
 =?us-ascii?Q?t+dxJyQZ18cPYuZ+I4HkmR2sin11FUEAABKilfzR6ZC8EroKV9PWEczabWx9?=
 =?us-ascii?Q?FLZvTqL2aoMYLvoTGx9tAI1UTflqWsbcu+z+pEtVVWQ4b5cUNoFH3GoC25Jt?=
 =?us-ascii?Q?93StRAz8YHF1+gBrdw+dQjvGfWc2LTc+5yJBdnYqdMEvv28TYlMD55dyJq+p?=
 =?us-ascii?Q?384w29yA3xpb7sfGq4+S+fkkz2o67p47k/swWSbrnBiszsOFuHY4rzeRtk9o?=
 =?us-ascii?Q?mL7zQPapRnyO5Z/t1c6zUgiWlUglLMUbd6PXpOBiyCQYM8hOWtC/93pV5Jim?=
 =?us-ascii?Q?dA2Hink4etndjNDYZ/1YI5vrr37oFxSZMivMJguEDUWloIHE87kACsFtruAe?=
 =?us-ascii?Q?l+HSBbikDFVndxW0Q6wYy1uhJc3oWkJILCAfnrJegcW4aPCFn54BbKvTaMdB?=
 =?us-ascii?Q?EnG7049EwIQoRmtsB0CEi0G6LBYxrmcj8PuO6X04mWXcLFUPlk3M0WlgqlsC?=
 =?us-ascii?Q?wDPVAS5CmS/3a6yaY7wre9Xc9mtfXZOGJGTNM7/E5wBSLWDVFiJbykFyDSlK?=
 =?us-ascii?Q?eRlrwEbNGMTXyW3OqWBjZJpsm1Ug4UTaz4cLcDd5H6HoqgGU2WSARif01FUQ?=
 =?us-ascii?Q?uBLMVvgX7QLoLJgtQRqt/O7Oa02ZxpmZCFRxmJHdm1A32o3VtvWqKYEQnQVl?=
 =?us-ascii?Q?Mg9PSeLqCchAyDdsudl7AI79Y7TcIq6wWX9O3/+0Wc0VKgHxInQKIm37uSsF?=
 =?us-ascii?Q?XfUIEyzv0/5u2Fo9GWIWziD3zuByY7uSBL3L44myfawCIpfVvQljnP08bRrM?=
 =?us-ascii?Q?YMwiVR6iLdHaoHEMzMYZieD650tJAu03BKcjd631wi+obFbTj/WfaVwBDUPv?=
 =?us-ascii?Q?9BBNdWPmOXsmejSs8luPM06JOHKWWQKb8ASr00TyEql4XjrFRgQexjMlN4Ee?=
 =?us-ascii?Q?K6Gu04nQxnbany0ZbIyn+O2o4NML0NT/Ni9tSuY8aktQl3IyKRJ9R5253v6y?=
 =?us-ascii?Q?9gZkvSNwCdKg2Y0JkPX9C5y60cauxlTA2D8+HXfryT/siB1xdkvqXyzJYlPu?=
 =?us-ascii?Q?VxJx7fT/kOQ1OwnIMuJiza3j3JrW3eD3E+ybVwHQc7ZhV9jipa2aeBgy4UI8?=
 =?us-ascii?Q?q73Q/o7fx08laNfb4rwmBMme7wWYq9D9UHw//ubMoyvg567tOS6oPITosyvC?=
 =?us-ascii?Q?BQFHbCfv9oDKGaaH5NopfMePyUh/BZoWvH0wKbB5YRc1N2p7tnwIrGanKljH?=
 =?us-ascii?Q?4yEWLtsWAE7WOm4JI+q2s/nhiZZge7vw4BPgNgy/yHEM+faZOsuqWtdA9aWh?=
 =?us-ascii?Q?mY94WssXeurmgdFvsf0WApaQKLT/aF3x75vKtvmgbWc6VzY3mXlf7zfv+0Q5?=
 =?us-ascii?Q?nR6NAxLJMAiaSQDZ+BNwSRGSSZQ9R1ChijwSU4lU4g9GQK1vefuw6NLMN1Up?=
 =?us-ascii?Q?g5QcypbIOHXiRlnJPxq3CK6kGO5ntOV8/9aJhZ02mxq7AJKcksitEYbFmZFC?=
 =?us-ascii?Q?kDvNWR1Bd3w02yoiG6drBUNQoNR6sv02StinZ3rmAR7joycQlPfSsTMThkkC?=
 =?us-ascii?Q?/Jf2Q6wSvksUmnIeL1Ab2HmRR+KiuOj631lAyCApJ1xR4chfxamXEJqDOJxX?=
 =?us-ascii?Q?vp7vVrnWqQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb21489d-af3c-4f29-f664-08df4a0bf948
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB903269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:19:00.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOPmGJL51ffz7+Ck5HbHLCR5bd3l1RfeChcG7YQE/BRyEo4gfeHIY0ki8wDrnDAEJ4Wmo/3tjioldYJiGHAlhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

On Mon, Nov 23, 2026 at 04:20:35PM +0800, Joshua Machauer wrote:
> set_pcie_cxl() runs for every added device. It first refreshes the CXL
> state of the upstream bridge, which walks that bridge's extended
> capabilities and recurses up to the Root Port, and then searches the
> device's own extended capabilities for the Flex Bus Port DVSEC.
> 
> For a VF neither step changes anything. A CXL device exposes its Flex
> Bus Port DVSEC through Function 0 (CXL r4.0, sec 8.1.8), so the search
> in a VF finds nothing and the VF's is_cxl stays false. The bridges
> above a VF are the ones above its PF, which were already refreshed when
> the PF was added. Because enabling SR-IOV adds the VFs one after
> another, each add repeats both walks without effect.
> 
> Return early for a VF. Every device keeps the is_cxl value it has
> today, and the bridges above the PF are no longer refreshed during a
> VF add.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Joshua Machauer <machaujo@amazon.de>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
> v2:
> - Shorten the commit log (Dave)
> - State that VF adds no longer refresh the bridges above the PF, and
>   cite the spec section in the comment (Richard)
> 
> v1: https://lore.kernel.org/all/20261119164219.51540-1-machaujo@amazon.de/
> 
>  drivers/pci/probe.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f..e302f9dabddd 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1717,6 +1717,15 @@ static void set_pcie_cxl(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return;
>  
> +	/*
> +	 * A CXL device exposes its Flex Bus Port DVSEC through Function 0
> +	 * (CXL r4.0, sec 8.1.8 "PCIe DVSEC for Flex Bus Port"), so a VF has
> +	 * none. Its upstream bridges are the PF's, which were updated when
> +	 * the PF was added.
> +	 */
> +	if (dev->is_virtfn)
> +		return;
> +
>  	/*
>  	 * Update parent's CXL state because alternate protocol training
>  	 * may have changed
> -- 
> 2.47.3
> 
