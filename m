Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087B312835;
	Fri, 23 Jan 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177327; cv=fail; b=cjWApgBqixRkOHSUp0cw+6S3upxYAIaqaoyc0IFsuaMe5zwHcwB0Tj61jsw7+jgdsYf/192y+iwfegDj/lNMa+xCjVUJA1egxL5DMQiXiUU8Z3jwma9PH5ggOnXkE+Fjev2P3lkjRO988DCWvpn9s1+InRLbYy5899GhtE/TMjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177327; c=relaxed/simple;
	bh=9EZ0z73hnlVX8Kg1qhRF5woe2gwCDW31CMh160EjbQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NQSUApNfvIIp1gA557Ef5USFAgBX+U6RWPKHoA+yeAfAPiBfs54SsvRPFFpo18P3RAo+YUEUbXZocZ3GtGPzB2YD0PeMWTmwHOIoibfOsHw1HClPcGEmszr8nUfZQDawbXxr4LcCzlxfpWG1SkJ28zFryGlg1V3NXz/59In8FqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GmWO62Il; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GmWO62Il"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zm0Kd1o2Ryyahl4bHBAg4zCBU45DntBnOz0KwJ8bfqxkyMD1c6LgfxHLis3XF2rfuXb0RA6HTOt1MXcOlaNBRgWVAagRuyQuQ8d7aysMu1OuYw/EOJN2Wl9wLsZONkxeUFNUyKQo2e4Yc870zSR4WZFIyJJpp/OIO1txzBp3GJnIg4LOBm6Dw0PO6bK2QtQOIDD5PKNhjOkDGuH4m8gvwv4D2Z4P33u+y1+VSsxTRtHTc5SWFysL6LuO8eeDTKYocaAVOVRn4hZZPZCMrJt/AohXmads38+LaynmvKHEwH46LibGx5wOgPpbh4R+++W7krnZgJnkkDqMWq+h34R1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP6U1v1Qncm8h8nZCPmCYXiVC5M8zW7m2V7/yZoe5B0=;
 b=ONJUEmQ0w8PjvGYujjmTHWZAe0UCak6Ihs4CVtTWwLqTXmKl7pluOUnDRXb7jc9+VMHlWq1JtbCmWGxSJ/bUuRfD7zyWmJrhjEgoXaHLks7qwbtygRB5tBQH1pwBKvIJDXt7OQ92wJNFa7k6/nhiWb5tV9RUIFVD9i9SZ4DW+j0/SfJolRsPWUptguWMVyvoZhqljbNAUtQCjD51R+JEW+ePZgunQpra4H5vWQ9l/BRL/GYjc/Scuk78sruGZXicNOEAfb7n9idriigB1BEs09AvFhP2KYBO5KMJ4KFb67n78sjZ9z/HS0uSRaP9Srp8sZQE/GU2IN6T9/eOS/+dVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP6U1v1Qncm8h8nZCPmCYXiVC5M8zW7m2V7/yZoe5B0=;
 b=GmWO62IlAd+agY1K00Fa59pDBm1y8uFNECdA/Cf/cs9S8GCvVsO6z3oDKKh8XVqJTOarAmt3kmhzW/p57Zov4UUtcw/ShTMTdAE9s6dOpYS+YEK2FvKh/Vh60nnK4gI6ZKwultC87+l52EAxBFiFa39L1hiuyn0b72zcc10JCCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5259.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:168::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 14:08:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 14:08:40 +0000
Date: Fri, 23 Jan 2026 23:08:39 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com, 
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <t2hsk77mp3shacbehlqfnpjgc4az2phvo2cyjn5hkybqdmzrcj@hnuwporebhz2>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
 <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
 <aXI_ny1-5NlN8r_z@ryzen>
 <ajuq5dpbzzoghd2hk7cz6w4t6jzcxfmygbyiciqjjhhg6ipkoh@usuhzmne6cap>
 <nrvamhbpi4372c4qmb2q3h74irrqkntlb2rwfasiorgavylp25@rx2lp6ldk64j>
 <aXMytcJTIeBHatIF@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXMytcJTIeBHatIF@ryzen>
X-ClientProxiedBy: TY4P301CA0026.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ceba991-ebc0-43d1-4b93-08de5a88e936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLYrI7WlqfKrbV1txVSTnCcDe9i4ZWALKPihP5S1qG4IN/hCM0lCv5j+wgLd?=
 =?us-ascii?Q?a3YYwBKpNsCoPfkz91UXrfEas4bKdXa/u+o/6Wjsq5S6lsKgFDA4sDusywUF?=
 =?us-ascii?Q?PZM9D90fx5PdE4ipWeGbieTpl6duw9N9NHBQwKPqVTt+SVoRk5gXkseV1kIc?=
 =?us-ascii?Q?jEpkAzR9nyh5PsqzVR84bvhwH1A/Wm/HlXpo5ILDgZHysjILdHmRAN6MMhYB?=
 =?us-ascii?Q?h8BvnDBli0F8SZtEE6gnGMMtaxz0ZshopZcJRHckCAhCa0iNcD5R6yBoGeIa?=
 =?us-ascii?Q?vRBqrWmZbYMNeG7YE633l8f2oIPvhfHpJ0lELLPiDllnKHj4XaUvmpcaR66d?=
 =?us-ascii?Q?gSbvTFS7eozHUHLDA+VJ/vgy78mIoEJM6tOXq8dbvLHN8Rg57203r7jZRwNU?=
 =?us-ascii?Q?FXzUr9v42ipI6XE5DtqzlqHbAXpNdkn50c8M0cVfCadzXlWmPsc/00/FyOyA?=
 =?us-ascii?Q?KY9dLw0tsMi+DZXEIEw/FqmJMi9om5MC1f8LTtjj1uIVjLeUTj+lDQHVeiks?=
 =?us-ascii?Q?sabNEXL/v9q7EgMjErC0F3200j1sBR8AJObvQWlriav4ix887SBvNmYn1dh/?=
 =?us-ascii?Q?4MXv9rt4LOgrbAkEvHxJKDDWykx+yLkBbspMk1eGSgWMk3+JiFZjqiDcf2/c?=
 =?us-ascii?Q?7aINmTXELgB4uxd6lxlkdtW5V2B7bDfZlRNVDUaAjgSEWTp4h7AA4S0Xf2G2?=
 =?us-ascii?Q?j5EjAw0qhOqFNt4FPk6EoJdTXq5er8WTEHvQOIDSLpcq1rb51ghudzYx57Zo?=
 =?us-ascii?Q?1UDeMe54X0tG6GL4EO2Bh0HDvpZergXm9cfzASk3Dm2sBYGQ/5IPwRYgd+WF?=
 =?us-ascii?Q?/+FRvyxhuy9zF8B0pohtrfmmCBjPw8XMC6Ty9q87aYDM8Ar0EvxZ9LqOY3Dx?=
 =?us-ascii?Q?ep7QJHAXlUdyK/cotPXAH2ugi2SDj+qVqj2gmVBoJh55d9B9yJ5c0DzFcuPF?=
 =?us-ascii?Q?i8E5OA9ACuun4ADHj5g5ysgc0J5t7astsrhpn3XBM2YOpKMGf6Im6RRlUGDk?=
 =?us-ascii?Q?Kg360XtHTsT5GUP23jhOyNjes5r+Gm15uaFDr+fc9I2RFhbN/0QGpOJAa4X5?=
 =?us-ascii?Q?WKUGmUWgoeG6aCFlK7nHtP9EV2326xy0olqZjjtIb44DuIBu5UIgk4pem6wp?=
 =?us-ascii?Q?lOWEvMDppmuJepy6OHfvOcG4POy+MkF8/Dndh2WZvLyZJeB+kyBBUElnhoH6?=
 =?us-ascii?Q?wUQoIaRD1YSu9ZvRTjsNV94ND/1iTrpTiYImN9auXLw0Ezs2ZHDfgM8sSXoH?=
 =?us-ascii?Q?1Gl/rfC4ywe+qBqmr9SkNJROxk2YU35c4L9M/cqPDCkrS7TVM7U8XP62X8iz?=
 =?us-ascii?Q?+1SAvVgu1sPSMtSPDJkyeE+Z501FjBnCmnyQzWsMLMjUlTLmH4hjKDFHvcwX?=
 =?us-ascii?Q?8DELHtV4ojKILGkH4upHNMCDPnd7c4ZQkogUr3tMfwvEBF6lqHGXJO5xKLwn?=
 =?us-ascii?Q?oudn+RICjCF3r6PGqq8v/aP5DIcsrMOqodQWlBEb/72Hvd0fKEqdoBQdyqnk?=
 =?us-ascii?Q?wvUoS2PQAshfVBDnjOODVFVVBYPrTbgnJ+TlkPl5mw9HrKn/UQ8Oi65xHww0?=
 =?us-ascii?Q?GH1zUnYWnLwmYj7JRyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z0sJp83TfdweVHPALjITJXuR7HQ0XKDOzYM9jF6Pidp8mAUglEZQEGHWL0hd?=
 =?us-ascii?Q?XAGY801+S20fH0h0JbcLF9cpTMZv2O0CKfmvmH6rW59ks0qxyqErSOpk20Gy?=
 =?us-ascii?Q?xGlAyTXgJSCe07IjgTdPhNU/uofM2KOThca7fzzwc7064wQIpPGj5Ja80/CH?=
 =?us-ascii?Q?RQxubDt7WJ752tnVqPDicccVoNmjXAUBL+yL7aubxRmQ7lP293k2JmqIZIpn?=
 =?us-ascii?Q?VEbO7LRn6c47mdRYYGCQLd4K6S4Ukcn1mg7KstpmGpUlOMsw6fWrsPPLPwcP?=
 =?us-ascii?Q?auIf225mMv9VBkSB2GaNH36x2vg13o1HncCMVm5Gj6aN8O2ArFRL1RcOuwGc?=
 =?us-ascii?Q?u6uc9Qojgdyz8azpm0SARJ9AlQxq2B8igUi756rWpa6njMW9hYjEWVIVs+Qb?=
 =?us-ascii?Q?3x8zSWMpfTXzlcR/uR198xhGzJt+Vy8VyhVUCawGcOMGxUdXW7JjvDhCyUJo?=
 =?us-ascii?Q?YCe/T3xeJTqtgns4Hj+C6p2CcRqrUsdPx8CmzYzZEiVXkWn+laTKGrE8g262?=
 =?us-ascii?Q?wPTxjPJQfWy82icMZDqi4/mMYZW0qECbyddOiTE/Z2f0ZzMl0xLZ4y6l1hgF?=
 =?us-ascii?Q?tUGUOop5zi0Wn4Vm5ZFTeSS+3H3dx7IqfT2BtS7VwxS2/AoFYWTq+J+RtDAS?=
 =?us-ascii?Q?gYMGyMB0zP0NCM/tAaeEF51KkyaUnVEPx5fjkEhmmEYR79xK5uYgX81+uH2L?=
 =?us-ascii?Q?3g2v0HYT7fqdEA5Cm+H3Fu2WdmeUQDTYZYGqzEKVRbb1LYLTrRC1GtPi3RGo?=
 =?us-ascii?Q?dmPY4cYU7987gfuI+3E5enthNFb8qWq7o8cRsK6wWtM7OwqcoBY9gC3HZQyp?=
 =?us-ascii?Q?Xs+WK/tmmCxuOvZ3WM2QHoyNb+Tj8wS6LWYyl/Gemhww57crJtT7tVTftphi?=
 =?us-ascii?Q?933Ax0a8cHsCKc+4Z5+IVPSgptHK4UypM+Ml5FuNND7KNGhcL3jeIoSM7XVb?=
 =?us-ascii?Q?maJtQ+fHd6PZHaN7oQxzHcAmRjAGhpoMOggEUxSk9WlodolYhX4Ax0QAGhFH?=
 =?us-ascii?Q?0afPcYUvJPzIIGk5EFjMptIiPMA3QV4oUU6/Sn75I7jz+sxPvPma0kqARh52?=
 =?us-ascii?Q?WkCAC3TTWqMewPrdBFk3t/oyHdsSULPEke59p5X0vgAFFkFs6mAsdGfX0Ejp?=
 =?us-ascii?Q?6w14WgaJ3vmBYKCmfrqoHQ123cNnNz+yeAkOoOa87KwCPIt1O3Zl6kpaniQD?=
 =?us-ascii?Q?kH0CleU9yrOGtTVmfa4ZnMd+Z4yGqJTKmKK9umO/GyYDtMs4aWRrP+ZPEAhm?=
 =?us-ascii?Q?IISgMe5WBrYa4RXgXPIwJtBMLh6EpFB7+Tji+OQPIFpdfZh1pEkWyTxqEfnA?=
 =?us-ascii?Q?EB+bg9Kx9vG6GZrM0vFqkPoBMPAMFV8V3ruH/Vvvbrnd6dC3sBFpTWFnl0mW?=
 =?us-ascii?Q?TCFxDuRLYKl9SWMzjWx3wmIs3cg/jYB1trn4apvjxeNG3B4MuoeXonP7MVH/?=
 =?us-ascii?Q?Xl8/wZaTnWBFswTtl4i5i4FAEQuUb8I6MYvIqOALtp6CBe+08VIcuRzJGnXD?=
 =?us-ascii?Q?O88Wlu036+17j9055zojJAN+I4eVss8IxwTbsfdTQTEhGw9di0sFLMp02dfa?=
 =?us-ascii?Q?EOlZksipOJZgdpGzU+6WlztlVukWkLGKM9tzQb66qclK311RdBWpj8OYoQon?=
 =?us-ascii?Q?JgM8DAIHhuBTKTUG7Y/6x5zKMkq74G5oEFESLzf67yi35WfoIs+SIr/u/9yL?=
 =?us-ascii?Q?vKSi87wlLsuFI7FIWjXpkEk6ViNSf92o+Qr65OlE1kvgRZ5309nfjSJ5Dw/1?=
 =?us-ascii?Q?s8O+PgCWiNpuzooYgPoabwOd2AMkZWbzXl8IWn++9Jv2RGQDEBhc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ceba991-ebc0-43d1-4b93-08de5a88e936
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:08:40.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgYs94cGyCM12/7Bu1BywfgeSgTDBTBedOxW4e9vDuT+DBeTi/7+iyJzKzek3wRHF7Rzy2xM8I/1YwlFEjvhcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5259

On Fri, Jan 23, 2026 at 09:35:01AM +0100, Niklas Cassel wrote:
> On Fri, Jan 23, 2026 at 04:11:08PM +0900, Koichiro Den wrote:
> > 
> > One additional concern if we were to add a subrange mapping test is that
> > the EP-side pci-epf-test.c currently defines bar_size as follows:
> > 
> >   static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> >   (see https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/endpoint/functions/pci-epf-test.c#L105)
> > 
> > The values 512 (BAR0/1) and 1024 (BAR2) are even smaller than the minimam
> > CX_ATU_MIN_REGION_SIZE (=4KB). This means that introducing
> > BAR_SUBRANGE_TEST would likely require one of the following:
> > 
> >   (a). raising these hard-coded values
> >   (b). reserving a dedicated BAR for the subrange mapping test
> >   (c). limiting the testing to BAR3/4/5 if available (though, for
> >        example, no BAR would pass the test on R-Car Spider which I'm
> >        testing on, where BAR4 is fixed 256B).
> > 
> > I'm wondering whether there is a clean way to add a subrange mapping test
> > without significantly reshaping pci-epf-test.
> 
> If you really want to implement a test, I suggest to look at:

Honestly, I hadn't thought of it until receiving your comment in this
thread, since [1] through [2] already cover the relevant testing. But on
second thought, that might be too heavy-weight, and instead adding just a
simple test for subrange mapping in this series, might suffice.

[1] https://lore.kernel.org/all/20260118135440.1958279-37-den@valinux.co.jp/
[2] https://lore.kernel.org/all/20260118135440.1958279-39-den@valinux.co.jp/

> 
> pci_epf_test_enable_doorbell()
> Which changes the address translation of a BAR dynamically.
> 
> pci_epf_test_disable_doorbell()
> Which reverts back to the original translation.
> 
> pci_epf_test_enable_doorbell() simply does:
> pci_epc_get_next_free_bar() to get a BAR, then writes the BAR
> number in the in the pci-epf-test command registers, offset:
> PCI_ENDPOINT_TEST_DB_BAR                0x34
> 
> (Which represent the offset in struct pci_epf_test, for
> struct member db_bar)
> 
> 
> However, the doorbells are most likely very small, so the chances
> that reg->doorbell_offset will have a value that is smaller than
> BAR size seems likely... but not guaranteed... and there is no
> 
> if (reg->doorbell_offset > epf->bar[bar].size)
>     goto err_doorbell_cleanup;
> 
> So it seems that this doorbell test just ignores the problem...
> 
> Frank, could you perhaps send a patch to add something like the above?
> 
> 
> For your case... I guess we could bump the default sizes in pci-epf-test
> if we want to. pci-epf-test already does:
> 
>                 if (epc_features->bar[bar].type == BAR_FIXED)
>                         test_reg_size = epc_features->bar[bar].fixed_size;
>                 else
>                         test_reg_size = bar_size[bar];
> 
> So if there are fixed size BARs, that size will be respected, so I don't
> think there should be any problem to increase the default sizes, if we
> wanted to.
> 
> E.g. RK3588 has CX_ATU_MIN_REGION_SIZE 64k
> 
> So if we wanted to, a good number would be to have at least a few BARs of size
> 128k or larger (so there could be two submaps), since I assume that some other
> DWC controllers might also have have 64k min alignment.

I'm not entirely sure whether it's really acceptable to bump the hard-coded
sizes for BAR0/1/2/3 (512, 512, 1024, 16384) to 128k, in other words,
whether there were any reasons behind choosing such small default numbers.
Let's see. I agree that 128k or larger should suffice for DWC-based
platforms (as you mentioned, testing with two submaps).

> 
> 
> Having a test for this feature in pci-epf-test sounds really nice.
> You could have even add a capability for this, see
> pci_epf_test_set_capabilities().
> 
> if (epf_test->epc_features->subrange_mapping)
> 	caps |= CAP_SUBRANGE_MAPPING;
> 
> 
> Such that the host side driver (drivers/misc/pci_endpoint_test.c) could return
> a distinct error code when this feature is not supported, such that
> tools/testing/selftests/pci_endpoint/pci_endpoint_test.c could return SKIP when
> that distinct error code is detected.

That sounds nice.

Thanks,
Koichiro

> 
> 
> Kind regards,
> Niklas
