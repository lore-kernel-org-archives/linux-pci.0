Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD13C9EE3;
	Fri, 20 Mar 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020805; cv=fail; b=IAPeyFxOCWvMx4nVfLNgr40RMrzScA1jyMlA8rOoTflGr9mah5eyc4zm+mtAluTh/CcICC+U18c2MdgE1B77zVnkc5hpLrQx6hs2NKdjBAFe/YEjQRMCApUPxrqRDm//B7HoAxXQ7rt+Xa6M5joeOeJHTaWT7vpD96KRyS6mUEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020805; c=relaxed/simple;
	bh=V/oi0dtviTLp8cMjGqKoqnUILCtPxBSE+d/JSCTDuWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YaRSSNNYNSaLS4WM32jToa5N7LBn0FM7q6EG9K8QJYjqrJV2ev4uB0WL4aXY2GeCH7+KOnX3Df5bLAF2GbkX06wdgCJnbnJCmRLq+uB4f+zo/s7EJ/qcfKF8CEuuB2TK/qe6qi6GswnYGbivTtN66+TS0j24zfCmK4vH2qQInz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JPcnZGKq; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JPcnZGKq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDPN+kSbQAe47W3BAA+Rs31qRdbFRCP4ejjn9loVz22HY9eUspt4oAzYdoT9bq5zlnRy5px/PXuTxUQTlaWUU335EbQJg/AwuJfAiXJbyIanwphDdCCf1SMUKC1J64C7SUW7QHTo7xmv0+cUxmkQOTsJMHUmBXsyVU2XoiQk0lNANNmOJiwF8Kj0nTko22yX2caajakZibS0xJfflAINhX2tYA/yt1jdp6nHUsp/vOSqphhg9ymfS9oOd9h40z+EJ+vnlfLa/Z83PzTpzstVuJpihKVAyRL3mQ5Nxfhkr906gDU+nhBTORe0Qo/2ZQLIK2Z0rxemIe+/WbHiy079ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVpXu2RHD3wYTfBuPv9akrnPa3tzKC8Wknsa0R/hrFw=;
 b=UXjkpxs0pWAQU4HmI/18NCv7H0FZtgOYzcpJElux9TyppNJranhFbm6SezpFzHRy0W2pUVVigilYbTsO3ccaQv9v8z4bFGUsusyCSuV7arwwD+zXKojslXiYwVbuhUg53YWtNIpeYk+pBY72vqwlqTV6AUtkUFE49kRf3sSsnwsv6bVxFduz+bnLoLslHDJu5Fcfo8Ix5VkRLal5bANjUBwgIDJeYVQCLOQ2Vzy7gKFkHe3Wg/MYbR9ncHh3oO4E1cLKvsfGC6uypjFZoChoe/bJcTj5AfecFRByTzr6y+8YQLG8wCw/M3jpIsDpETtUiAEhzYCgjcZeMMmU1cJhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVpXu2RHD3wYTfBuPv9akrnPa3tzKC8Wknsa0R/hrFw=;
 b=JPcnZGKqIkWqEsjHEk8O6/X9/dqcyNRNGUbm5EQm2N/46jBoBFPSIC27MjSx/YUm8tIIssxdrw8Lw2S5fybf6Toi9ckV+VFjC2e2mj/0ztpFKpbSnv1AN6pVrsgZPZUkECjG7lKVRR3wNw6CPMpBbSxyiZd4iCP5WQ+BCZcqFig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5704.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 15:33:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 15:33:18 +0000
Date: Sat, 21 Mar 2026 00:33:17 +0900
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
Message-ID: <ssouzxjbyna5if6hxknlrq5zv3rgylkqhvjrc7krk2c33nknvc@uabi4556fho7>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>
 <vki7ty3z5jncmzeltk7udsbynffdld4xhcm3b2yjrgx25cfqkm@4ld66m3jbjqo>
 <d3e8d869-1a10-4a50-a9ed-3c6bc10a6178@foss.st.com>
 <nk2cc2ikag2ofpskmnnc7mqzsvtizwcjm6rlkrkuqesq673h3l@mamriu2gshit>
 <8da9e382-bf85-431e-bcfe-0b9255e8db66@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8da9e382-bf85-431e-bcfe-0b9255e8db66@foss.st.com>
X-ClientProxiedBy: TYCP286CA0154.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 623d6204-cd1a-4a3a-4ec5-08de869602aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	Fg5SeiMgrurquIfXyX5IauK7wBI3tKi3C6HmMgVHMAIZl1L5P8qK0lHeuhf5xNG83bJQGqyufTPbLPKuD8FR1NfZscNMKZ9mDxsKFtTKqy20yjml9hK8uF6R/mP8WK0HOTcuAG/8V8RcYGaC8IOiFaKIib9Fpnk0QYil5lJqh2uODNIntoQBIOxoFU3795cBpmcAddhSbAUeKDZ/2wXT0u1sQHsiUwGwsgbfPGvnrEbVx6mv9L/P//o4pK2X/p9/YboWeF3F+GpfdQ+akZsIuPvwXax33m0OUHgETyXO6N0B/AljglQvlqii0RDZa9UIK+6RyXlItJmWZFoqySSCK9arN/mTTr86oHRAk/9PRsqNLg1GNuUqm30/jF5V83yYUfr9WLrKuILqoCmEFzXHB5idlVB/FcK1Rlhc4Os+IguT+Hbzp6NqcG7cYUQv4ZfHY8DLAKC6t3FhTXrqCCqZLVZ7XnmquMWh9dcgynh31RYzuruGB3V1zMwtPGR8My08X04FwdbgmnMvgoYcU5u8MI97dZBAYGyqY9omkU5F0Ythfe0BEGtgjMhd7dEgYMHd8UlHaRAVZizdBYCdpVKlWTHazmV+8hZC19yxeSNBsDyvckZZXogV7z4pJj4BS9bYybMyTplDWqo3OSkX+CwzgoGuKupdPsumVT4ne9iJyDH2/byIRC9zv9HoQATL2V6j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?swRW4m1IJaCNVucQTt2eG2sQ2Gz67irj+1pypKpPruroObdMaOQtJWewjURZ?=
 =?us-ascii?Q?Z3unph42f6zgZ485B/e3sWxkSr3K0weSZULedHzWVFf85r1vc5LUihxj3NBU?=
 =?us-ascii?Q?BBv5rraFECGuWfHI5e/xQ+v1/wfaoSuojN9wBwXIZ3ERo+gsVKhiVdvAz8Te?=
 =?us-ascii?Q?FJsaKui2iM0aP+YXLZTeT2s/LtXnMmhThWgDo/nwDnbJHrIGAh0MEfCem3FQ?=
 =?us-ascii?Q?HccQlnsOMUBEY0I/sbwqGYh/nJz8fFA6IzVsw7PZxHuj45/qgBLZQD1axvsx?=
 =?us-ascii?Q?aMJSX4NB4V2UkhqItXb49VdNSbEFuvohQnv46X6+zrJLU693DqgCnxY0W84c?=
 =?us-ascii?Q?r1iraQa+Zoivg6ySWtNFVbBSqg/ywhSZSS6AQVnbRHP22pFKL/eXq0jvWRqo?=
 =?us-ascii?Q?is8jw+JkWWtCw4VAZBP3YUzudr2w1gYTGoXhc4cRUBb9+coUhPU/cLF4M6Fu?=
 =?us-ascii?Q?nA/bzH5tfNWlMzmWLIZG793ff7WEoqyyixf5ejkPmC1y4yffPTnt6kyRsVbO?=
 =?us-ascii?Q?qBNrGHGX5KBMr1gJOFUz3/GYXW8CgxeUfzrtzMHzIBpsCL5Za5oGLOQIz5Qk?=
 =?us-ascii?Q?rLKn5TuagfS0qTxhGaLtBAnl5mmk4z/lTjBcM41y9jHxAuoBNnmxwHXG/mDp?=
 =?us-ascii?Q?RqwBKBlW3zPE+G8zpDzCb+/6wbX4pv02DuOJI85EvXgtHOdt0wk7Kiu5iH7h?=
 =?us-ascii?Q?rJ5J76vtltJaVTzRhfYmzvhki3zXxehH3Iej2K8M9yOg2ua97+xq2ubNnEV3?=
 =?us-ascii?Q?/9u72Db9UmucJ6GZyU3M17mbnDaNDREXtYvJuvmHCZEE4DbmzJUE5QWgkbcp?=
 =?us-ascii?Q?N8QIcIoADFEBQXMjFJ4VXI/JkEM0yhPr9ZQHuQnq+zjDpoDPvSPn6oH9HLdy?=
 =?us-ascii?Q?3RFVoPTwNhQoy33UJGUjWqMbsv1Kgj9YjFiWlShF9VidiCslOKUaS+Yo4TzY?=
 =?us-ascii?Q?2z7kR9yEqmrGDJo5YNdzOL6H2E386w0nHhhftU4JCntlspNU5Ocx91tB/wu1?=
 =?us-ascii?Q?IGxgvrKJpmcElidwPDdk+SDTQs1xNsOSmgf67QEPio2xAMz28I2YRph4iq5a?=
 =?us-ascii?Q?DYJIYVk4u3WV3hQ/sl/8XjzRsvM6lM448YAt7dCNNVTuk5mxBkoE2GfgMRKZ?=
 =?us-ascii?Q?IIZfEj5U2K33BEh4ZXOqmt0lZYSzUrlDMW2SsvwIbKVMQrG2/GFVgkUAGRiN?=
 =?us-ascii?Q?YIZsz0WF7FDc2iZQVQqu0b7cmbhj7+eqeVT84F0Isbzn+MFtZCK2bOmjHsDZ?=
 =?us-ascii?Q?YXAEvx+wVEFJmk9vU6cG2a0hDkmrmHpHo00Ykx2BqtMBW4jf61yRogX+qf3a?=
 =?us-ascii?Q?/lmHn2dnAN9vMzitgDkp/SjZXLNrimCuCoVp4CFcq4LDlnXNxiQ9z0S9DAML?=
 =?us-ascii?Q?Fz43IbJJwG//26nuILbcFoQsPfx1u/PJu0jst+lHbgjZabWAwtSQL7fXh9/8?=
 =?us-ascii?Q?ZHQIjGp9UR27xwKTh0RY39MjzRDo9xj+2fmQ6j+zSZncI8KxM8ZwSPUaf+yj?=
 =?us-ascii?Q?SBrooi0jUEOSUVGE0AInXaCCL49XXBoGoyavxFobdbcZof6Lta5VGbXhiSS1?=
 =?us-ascii?Q?ZXoSRUvy0e4VKrXMLUGXqdEQJeFkLKksmF2l8HsOo8kzVrewaUfbFk7jl+DR?=
 =?us-ascii?Q?8SwaTvKka8Jjw5/rYCYoLJ8rQ8PHSZx++PEYkcDzQLYQyMrCbd4wzOITY2W3?=
 =?us-ascii?Q?gTScFzByqSR51lJ/fjMbYL3Gg4wpsCFxPNF9FtLQpNp7mksX2hZoctKJEv/M?=
 =?us-ascii?Q?7tRl2GjfHCL60pX75pAvl49ZlJVPFmEXyDLt7zv5sXTnoXm+/et9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 623d6204-cd1a-4a3a-4ec5-08de869602aa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:33:18.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KMnLIxRp0ogefKCopFaaL1ZTtQkaUBmrVRJdcyIHAN/2bgeqOZQfVZZgcoGIWkkrmp+s2tNvi/Pf/aAucej6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5704

On Fri, Mar 20, 2026 at 03:19:15PM +0100, Christian Bruel wrote:
> 
> 
> On 3/20/26 15:05, Koichiro Den wrote:
> > On Fri, Mar 20, 2026 at 11:04:28AM +0100, Christian Bruel wrote:
> > > Hello Koichiro, thank you for your comment
> > > 
> > > On 3/19/26 02:28, Koichiro Den wrote:
> > > > On Wed, Mar 18, 2026 at 03:46:27PM +0100, Christian Bruel wrote:
> > > > > Handle -ENOSPC error. If the number of available inbound ATU entries is
> > > > > insufficient to map the subrange, skip the test instead of failing.
> > > > > 
> > > > > Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
> > > > > Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> > > > > ---
> > > > >    tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
> > > > >    1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > > > > index c417fb3a198b2d92c3060938c23807cc8bea5573..8ea2fda4539d11eb22b22800a7cb8bbaa99c91ba 100644
> > > > > --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > > > > +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> > > > > @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
> > > > >    		SKIP(return, "Subrange map is not supported");
> > > > >    	if (ret == -ENOBUFS)
> > > > >    		SKIP(return, "BAR is reserved");
> > > > > +	if (ret == -ENOSPC)
> > > > > +		SKIP(return, "Not enough ATU entries to allocate subrange");
> > > > 
> > > > Thank you for handling this!
> > > > 
> > > > pci_endpoint_test_bar_subrange() can also return -ENOSPC locally:
> > > > https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/misc/pci_endpoint_test.c#L538
> > > > While that is a different resource limit case, I think it would still be
> > > > reasonable to treat it as SKIP as well.
> > > 
> > > Regarding Niklas's feedback to use the local EINVAL instead of ENOSPC in
> > > pci_endpoint_test_bar_subrange(), I prefer to leave this for you to handle.
> > > That will cover this case.
> > 
> > So could you consider the following tiny patch as a prerequisite for your
> > series?
> > https://lore.kernel.org/linux-pci/20260320140139.2415480-1-den@valinux.co.jp/
> 
> sure, thank you
> 
> > 
> > > 
> > > > 
> > > > If you agree and keep your current approach, then I think the SKIP message
> > > > might be better phrased more generically, e.g. "Insufficient resources".
> > > 
> > > OK I agree, the error message should be less specific to DWC terminology,
> > > even though this case can currently only occur on it.
> > 
> > Yes, I agree. As mentioned in my reply to Niklas, the other -ENOSPC is better
> > replaced with -EINVAL, so I just submitted a tiny patch. That concern should be
> > resolved.
> > 
> > > 
> > > > 
> > > > If you prefer to keep that local case as FAIL (or at least distinguish it
> > > > with a different SKIP message), that would likely require a bit more
> > > > changes overall. Note: Niklas' earlier feedback on the SKIP message would
> > > > still apply.
> > > 
> > > OK, as Niklas also suggested, I will not set an additional local bit besides
> > > the fail bit. The question is whether we should name it SKIP or NOSPC. I
> > > slightly prefer NOSPC, as this is what is used in the selftest to indicate
> > > skipping.
> > 
> > Personally, Niklas' "errno in struct pci_epf_test_reg" idea sounds the best
> > among the options discussed so far.
> 
> It is a good solution but does not match very well with the other existing
> API (See the STATUS_SRC/DST_ADDR_INVALID bits). Thus, we will keep the
> existing method of reporting errors using a second bit alongside the FAIL
> bit.

Understood. Thank you!

Koichiro

> 
> 
> > 
> > Best regards,
> > Koichiro
> > 
> > > 
> > > thank you
> > > 
> > > Christian
> > > 
> > > > 
> > > > Best regards,
> > > > Koichiro
> > > > 
> > > > >    	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
> > > > >    }
> > > > > 
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > 
> 
