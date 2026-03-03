Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021097.outbound.protection.outlook.com [52.101.125.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41B2DECB2;
	Tue,  3 Mar 2026 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545374; cv=fail; b=WJ0XrUfmAzUpsd6weS4xX0yocVsiYdjIzSsZ2wQVT5R37w1avjoaGa3GL5FTqcxcuaYrYotHSY560sUXsHhYv2PfRQh6NkamBKHLfAssTrPXXD8oCcFvfYnnG1rTOWhhn7eWzYK94lp3JReP45OyW5gfAqFX9uqtCTpIROD8YFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545374; c=relaxed/simple;
	bh=ccMyrp/cWHLra3BCw4SxXsUlCLvwaKz8MJ4tI5If6TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nXlhBbmfCkvWgwwbd/UaK1ECUjBLr1KMKqwC4C4EBjhZ2MvguUqcSPhKvTyiEZwbpjHCvlvsY8eBlNN8upPdEYSbE+TRJlH3b53OqUm1vfc0DuLFKHNvN3fbIIn2TAyy9eLBzLdCdAfl4cNN2ZtgCiRpoQmM8rR6pc//yzCPLr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Wl+69akf; arc=fail smtp.client-ip=52.101.125.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Wl+69akf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvl4/PLoNiOtbfOkVP8SWHij7YY2IhPsIJfaJEVaSwbNEWiG3wwEJxwDowPDIGGZjhrdLOTzUiEDrTqLvk59JvjcFRbkhYG4q2Mr878cVt2dZWPc6JGn9zDoP7+OBj5f/VdfvfN+kAnGHmRHfrCYW4h+3XBqIZPvc7keAlQrEePBKz/Bdw95fKZ0UnMSAoAwpib4yid5L1rW7Xljrgi/vfYj40nVlYNhtNe1VnUbVxPQPJNZpUGW66qYe5jwySw9Qh5gEnmWefRV/L1JlGRj+lOJPXIkOJILG20mBYRtZBALCHn+/SVSxQQ6y6/vOW/IGaWnEJFR2Tx+s7ZBDrkxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCUtpmi9MkPsg4M3BfrNEdYUkdT7nA9E6ebW3HK8G0c=;
 b=AOFvhXJKAzDx+4MTVkTJvG5hHc+hRiB03kFw90cpEDZZ2f4VXJbAkFqqvCKC/T2pcBHn+yM1ZbHaCmJ5DXQZbfc48aJeElV88WgwlUbg/JYMNZXFYn+RW7puDuG3e7zumXBxwydfMyz4A5WOyqgCet/+VukPDlTs8ckKrB5hFu6ipBf1ryJAZvaJklBjyPXhsNkNxD9tR37qXUsCkZV/2SnKDgzv4FL+WmP1AyO1QODrfjFKXAGKHDFgBOH2hVuU6i4BtvzQfbd3VXV+vKRtu6j8JvNd0+FuLlQbiZq4y4lg/LfYj7yKlHzDlZs852poxhUzoVvQNaFOAbK7ab2dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCUtpmi9MkPsg4M3BfrNEdYUkdT7nA9E6ebW3HK8G0c=;
 b=Wl+69akfP30/nC83/gk0paS1NwVP9RFg5je0WiUGGGjVNUI32U0McKZto3X9CcavOS0H3zSy4DvbXxP3UpDahzQYVYCThXYjIFMEq/lYekuxy1BjlDHmd3MV56YJ5DclVCW9hlfjy6Px1CX6SC/WtFlR0vbWQdUlVjGjQ78HEk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7485.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:42:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:42:48 +0000
Date: Tue, 3 Mar 2026 22:42:47 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, kwilczynski@kernel.org, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ye Bin <yebin10@huawei.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: endpoint: pci-epf-vntb: manage ntb_dev
 lifetime and fix vpci bus teardown
Message-ID: <mipdls67csyyrugf4rjx3qqtbxes4sjjtluy3psecnadcgcs7k@rn42d3m6ggsf>
References: <20260226084142.2226875-1-den@valinux.co.jp>
 <20260226084142.2226875-6-den@valinux.co.jp>
 <f3tt2dt63el5v7lzqabgnjcs2vrcj44xot2nrbkxjnqcpmyivs@o6xdl2aarsbi>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3tt2dt63el5v7lzqabgnjcs2vrcj44xot2nrbkxjnqcpmyivs@o6xdl2aarsbi>
X-ClientProxiedBy: TYCP286CA0235.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aac3d5b-77cc-49af-f866-08de792ac212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7416014;
X-Microsoft-Antispam-Message-Info:
	/I/HeI+s4Wsuv+Vc77BElvkvp5YjtEYD9RepFPwu0iznwHhSpcvH7pOvszXw6nyoxCdV0T65MHBn93abbGZWUbcF4lNKSvtBg2G8NEo9zVXNHxf6bx68WxhK+tZiPWQL+beD3Q7HrpVO02N9LWPzVafjPBQhA/sRNVFreUkEkRQorY6aEiH5IsIcKpXKBjhtoXsKMGz63zOohvXLZZw5t2hyDYPmfx6ng0topta7HMfldWDQMbxcw70Hsicx3xeuGanhXkFyDobDRjHf2mDhX99TGjFWXjluGimfvTesONhSqBnmS7ihuoD20J6FyTe7RG/PA0PLYjlpgn3XrFmqpALDwHwANFRe+o5/B4kKt6tVxmLHUbhYj7eSfelK9dsN2YzwQjiQO8FlvVxtfxcU9BlNBjerQrfoISFKzbkByXWLbfuv3YUpeIg6eV7n8u7CFAFax2Fzvv/LSr+EYOZ/+SvRK/ALhn3tn7+KNx1dlJ6nOri+FiwrAJw/xacxww9ApEq3bnlzZgYTjUg8ALQoErw5dk83FrRYOblLEe8PBYvyzdOXRcSQBzS64Q3fAXFEMw1yyGHvsHKsdVQD1yEmIlZn9JmGm2n3llwu+Wji3s/QXsRrbFmV+wp3KOT7mkmjqfewxWKeY39adML1R1fCymIusmtay7/z5+cq6hWYnKA4mqYxV0HVzK/QA08PqZt9HeYBSYL/wLyxK+baab8M02uTpcIRkOTFvIZkBKOjmE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2NneVdsUVlTSW1OSFlIcGFacXkvMFJzQlYxazY0b2tMRVd6Zm54Wjh0eVl0?=
 =?utf-8?B?dDljNmh3REtER1l6Q3Mwb29ORytqSk1xQmVpdzZXTzNrcUUrTFZmYWlONnlI?=
 =?utf-8?B?OTludnRQZEQ5NDFzMXp4cXVKaHhnYjlQbXRKa0x2aXJkN2VsOU5nM2NCd0pU?=
 =?utf-8?B?R3M5T0NnaDlmVDRFV0dvVlJFSHFOdTBwMmp6YjRaN253dnl1SEZtQitrdzFI?=
 =?utf-8?B?Q0ZWNFdldDhDREJyY0t4T29pNzZwVFE2Q2VrUWpORHplbFZFNy9DMkhQYmZi?=
 =?utf-8?B?bmE1WjNSVjRkaDFVRm9QQ1prOVFWbG5Xa2ZuV2ZSTVFRUlNQSXJueFZGa2xB?=
 =?utf-8?B?ZFlmRmtRWjl4MnpPbW40R1BiVVZBOTFuTGp4Y25vOHJ4Uktyck9helJxbVA2?=
 =?utf-8?B?cUhNQXNBN2Z6T0pxRGtGT3hmc3pJTSttNDE5QjZST2swUjVjVWozNmwwVG90?=
 =?utf-8?B?aVpQUDg3TnMxMEgzZDJPcGJPSzN2Qnd5NkdVVTJPRWFsdk5BV1dXUFN0eC9D?=
 =?utf-8?B?K0VTVXl0ZWZrYnFrcEIxcFhuL2F4Y3VTOHpqbHk0Sm1kVmJnekJpMU1qOGkz?=
 =?utf-8?B?ODM4QmV2eWNycXpLWmVtVmxYeWc4VUFkT2xUREVKeDNiLzNLUnEyR2c3RFgw?=
 =?utf-8?B?TkdaNjc2SThuNzIrSGNqZ3Vnc05Ha0xmRlUzSmx2M2wza3IybFY1bUI1SUl6?=
 =?utf-8?B?UzUzcStIQ3BkVlhkOW5tYmJKbzZVcEc1dVY2alo2R1RvQ2RTVm95T1pDT2Ix?=
 =?utf-8?B?eTBydzZIQWM4VFBGaUlTUkJvTFc0aGM5VGE2LzIybm9RZURxV2FrR2IvRm9s?=
 =?utf-8?B?VFlERkNHbUp0QXNzWGt3WDRpY1ZpTGwxTDZYbDZBcHhCNFpnUG9HZFlRNjhT?=
 =?utf-8?B?aDduY3BqYVY1RzU3aXlGM0Mwd0FTbnRTd3E1NlJodHlKYXgyUnYyS21GazJZ?=
 =?utf-8?B?YzF2cFQrNlJISDM5T0N5WWtGaHVKNHppRXdGaEI4c0E4SVNPMzdseUxtUlRq?=
 =?utf-8?B?eHV2RUs3ald3WnNmdU1YTjFMSUpBMllkQnorWmxOaGNocVF4TW5nMGs0WGNm?=
 =?utf-8?B?WHdIaWhUNVFIYmFuUWhDbWdJclhJcVhGZ2hiZGtzSXVmOVJQOFdMVW5SVS9U?=
 =?utf-8?B?MFcwWFl0VVAyK1Q4Uy9yV0EvWllnaDQ0dnpaNDRWTG1MSm5sTmpkeWFUdlRS?=
 =?utf-8?B?NGovVmpsZmxORFRyWnpKSXlRM09MeDd1dk8vbWFJMkpHaVNWQm9QZlhrVEwx?=
 =?utf-8?B?RFgyM1JqN3llZzB0VWU3eW83am95MzhNSytnK0ozUUJVN01LaUVHRHp6ZXJW?=
 =?utf-8?B?dnFDcW12bDlKZ2xFQW1Kb1dPb1FwYXViNjVHR0lna1ZvQkdoekxZbW5TcnpM?=
 =?utf-8?B?akU5L0pMS2pJZ1Q3ZzhMVHMwNHlSNkpSR2pYTmtYZU8rdHF1dHk2dW8xNTA5?=
 =?utf-8?B?RlU4YWx4VXJUckllWDRudFBEM0E2SXlxam5ManNLV1d0ZktNd1VrWkxWTHJT?=
 =?utf-8?B?eEtoWUt0Zi96QkNyYVd5bnpUUnVCbVJPeU9XZTJiV3k1UkdUYXhPaXNXNnJF?=
 =?utf-8?B?d3MzaENWY1JXUXVnNUVrMC9KUkVqVTVab2VxWWdaUCt2SDZZVHpmZnFUdVJT?=
 =?utf-8?B?QkY5UkZnQmhSekRsWVZFaW9MU0FyNXpQQXZNNmxJOG5rQnJ0bWE4alZFMGZu?=
 =?utf-8?B?cUhhMHFFNS9tb3FSb000NFFvc1N4aU1Ga0QvSFVPK3RXOURKVVdWRXNDQllE?=
 =?utf-8?B?WXA3NCt5d09ackNBNlAxRGNSTjU4VXBrYnRPam1mREEyYVVnOVoyQUVkY1dp?=
 =?utf-8?B?QU1LcjZIbTA1WHdNUFlxY0dFZHQ2cTR2SVFPeHhEdkYvYnRlSndpQkFveXdy?=
 =?utf-8?B?YzRFNHA3S2xvMDlZb0xqSDFlM0IwRkNsY3BzRUxBS3oycUhaVGZwOWtQSlIr?=
 =?utf-8?B?TEx6czk4R0phQXpuNDc5MGFPUHhMZXJ3NzFCZDVzQkszR2F6S01GMDlSTTlO?=
 =?utf-8?B?OEtrZDJES3doTEVTbFlpSG5XRmhJVDYxVVpVdG9vdFcrL21HZFBNdDd0Z2tS?=
 =?utf-8?B?NnZTdGViaHZhWGhyUU9OVDhuQTJEeml0WnVsRElZSHgyV25tQTBFNkdQUkRJ?=
 =?utf-8?B?VSszRytKcHVMN1lrUDRWeGYyVHlUSTJXczlRSzUzcEFxcnpMY1J0dGZxOFdj?=
 =?utf-8?B?NzVUNVVzWkc3cDNQUEg1ZjhrUldod0FPb3ZaSTN1ajRudXVUcVpmeGdEL2RT?=
 =?utf-8?B?cjM0WFcyZzNOOU5iOVJ4MTI3UzhJWmtTckttS0N6Rk5ncjhoanFTLzA2bkNv?=
 =?utf-8?B?TU4rVDJiZnBWbmdlVXdBdzlJWjc1bGlIcmNDd01XVTZCc0hITDdqV0lHcEha?=
 =?utf-8?Q?p21pCKt/IW7ecSjw50owd5karrwkzCfG2c8gL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aac3d5b-77cc-49af-f866-08de792ac212
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:42:48.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHrK3EoIyVUt86A2aujLqfMqhNGjEeXJtEQl43Yxwt4h4L4hEWPvf4ir/wOqRqy20P6UNcVjgTJDMrB+cD3WgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7485

On Tue, Mar 03, 2026 at 10:52:05AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Feb 26, 2026 at 05:41:42PM +0900, Koichiro Den wrote:
> > Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
> > or stopping controller and linking or unlinking functions as you want.
> > In fact, re-linking and re-starting is not possible with the embedded
> > design and leads to oopses.
> > 
> > Allocate ntb_dev with devm and add a .remove callback to the pci driver
> > that calls ntb_unregister_device(). This allows a fresh device to be
> > created on the next .bind call.
> > 
> > With these changes, the controller can now be stopped, a function
> > unlinked, configfs settings updated, and the controller re-linked and
> > restarted without rebooting the endpoint, as long as the underlying
> > pci_epc_ops .stop() operation is non-destructive, and .start() can
> > restore normal operations.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v4:
> >   - Adjusted context due to commit:
> >     dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
> > 
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 53 ++++++++++++++-----
> >  1 file changed, 40 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index f353e9a57194..41a2f42e8a39 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -120,7 +120,7 @@ struct epf_ntb_ctrl {
> >  } __packed;
> >  
> >  struct epf_ntb {
> > -	struct ntb_dev ntb;
> > +	struct ntb_dev *ntb;
> >  	struct pci_epf *epf;
> >  	struct config_group group;
> >  
> > @@ -147,10 +147,16 @@ struct epf_ntb {
> >  	void __iomem *vpci_mw_addr[MAX_MW];
> >  
> >  	struct delayed_work cmd_handler;
> > +
> > +	struct pci_bus *vpci_bus;
> >  };
> >  
> >  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> > -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> > +
> > +static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> 
> Nit: No need of 'inline' keyword in a .c file.

Thanks for catching this. I'll drop the 'inline' in v6.


While revisiting Patch 5/5 carefully, I also noticed a lifetime issue around
cmd_handler (and doorbell IRQ handlers).

1. Race window between pci_unregister_driver() and work/IRQ teardown

   With this patch, the following window exists:

   -> epf_ntb_unbind()
      -> pci_unregister_driver()
         ...
         -> pci_vntb_remove()
            -> ntb_unregister_device()
            -> ndev->ntb = NULL ----------------------------- (A)
      -> epf_ntb_epc_cleanup()
         -> disable_delayed_work_sync(&ntb->cmd_handler) ---- (B)
         -> epf_ntb_db_bar_clear() (free_irq, etc.) --------- (C)

   If cmd_handler runs between (A) and (B) (or if epf_ntb_doorbell_handler()
   runs between (A) and (C)), they may call ntb_{db,link}_event(ndev->ntb, ...)
   with ndev->ntb == NULL, leading to a NULL deref.  Also, since the doorbell
   IRQs are requested during bind, the IRQ handler can run even before
   pci_vntb_probe() ever sets up ndev->ntb.

   In current mainline, cmd_handler is initially scheduled in
   epf_ntb_epc_init(), and the doorbell IRQs are also requested during bind,
   i.e. both are set up before pci_register_driver() and ndev->ntb becomes
   valid.

   I think the cleanest solution is to tie cmd_handler and the "enabled" state
   of the doorbell IRQs to the lifetime of struct ntb_dev:

   - Move the initial scheduling (queue_work(..., &ndev->cmd_handler.work)) to
     pci_vntb_probe(), after ntb_register_device() succeeds, and stop it in
     pci_vntb_remove() using disable_delayed_work_sync() before
     ntb_unregister_device().

   - Keep request_irq()/free_irq() in the existing bind/unbind paths, but gate
     delivery in vPCI probe/remove: keep the doorbell IRQs disabled until
     pci_vntb_probe() succeeds (enable_irq() after ndev->ntb becomes valid), and
     disable_irq() them in pci_vntb_remove() before clearing ndev->ntb /
     ntb_unregister_device().

   That way, the unsafe windows I wrote above disappear, and the lifetime of
   struct ntb_dev and its associated resources are managed symmetrically across
   bind/unbind and probe/remove paths.

2. Stale ndev->ntb on probe failure

   pci_vntb_probe() assigns ndev->ntb before ntb_register_device(). If probe
   fails after devm_kzalloc(), ndev->ntb may still hold a stale pointer. I'll
   fix this by avoiding publishing ndev->ntb until ntb_register_device()
   succeeds (or clear it on the error path).

I'll include these fixes into v6.

Best regards,
Koichiro

> 
> - Mani
> 
> > +{
> > +	return (struct epf_ntb *)ntb->pdev->sysdata;
> > +}
> >  
> >  static struct pci_epf_header epf_ntb_header = {
> >  	.vendorid	= PCI_ANY_ID,
> > @@ -176,7 +182,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> >  	else
> >  		ntb->reg->link_status &= ~LINK_STATUS_UP;
> >  
> > -	ntb_link_event(&ntb->ntb);
> > +	ntb_link_event(ntb->ntb);
> >  	return 0;
> >  }
> >  
> > @@ -264,7 +270,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >  	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
> >  		if (ntb->epf_db[i]) {
> >  			atomic64_or(1 << (i - 1), &ntb->db);
> > -			ntb_db_event(&ntb->ntb, i);
> > +			ntb_db_event(ntb->ntb, i);
> >  			ntb->epf_db[i] = 0;
> >  		}
> >  	}
> > @@ -333,7 +339,7 @@ static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
> >  	for (i = 1; i < ntb->db_count; i++)
> >  		if (irq == ntb->epf->db_msg[i].virq) {
> >  			atomic64_or(1 << (i - 1), &ntb->db);
> > -			ntb_db_event(&ntb->ntb, i);
> > +			ntb_db_event(ntb->ntb, i);
> >  		}
> >  
> >  	return IRQ_HANDLED;
> > @@ -1237,6 +1243,7 @@ static int vpci_scan_bus(void *sysdata)
> >  		pr_err("create pci bus failed\n");
> >  		return -EINVAL;
> >  	}
> > +	ndev->vpci_bus = vpci_bus;
> >  
> >  	pci_bus_add_devices(vpci_bus);
> >  
> > @@ -1281,7 +1288,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >  	int ret;
> >  	struct device *dev;
> >  
> > -	dev = &ntb->ntb.dev;
> > +	dev = &ntb->ntb->dev;
> >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> >  	epf_bar = &ntb->epf->bar[barno];
> >  	epf_bar->phys_addr = addr;
> > @@ -1381,7 +1388,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
> >  	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> >  				PCI_IRQ_MSI, interrupt_num + 1);
> >  	if (ret)
> > -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> > +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
> >  
> >  	return ret;
> >  }
> > @@ -1468,9 +1475,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> >  	struct device *dev = &pdev->dev;
> >  
> > -	ndev->ntb.pdev = pdev;
> > -	ndev->ntb.topo = NTB_TOPO_NONE;
> > -	ndev->ntb.ops =  &vntb_epf_ops;
> > +	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
> > +	if (!ndev->ntb)
> > +		return -ENOMEM;
> > +	ndev->ntb->pdev = pdev;
> > +	ndev->ntb->topo = NTB_TOPO_NONE;
> > +	ndev->ntb->ops = &vntb_epf_ops;
> >  
> >  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> >  	if (ret) {
> > @@ -1478,7 +1488,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  		return ret;
> >  	}
> >  
> > -	ret = ntb_register_device(&ndev->ntb);
> > +	ret = ntb_register_device(ndev->ntb);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to register NTB device\n");
> >  		return ret;
> > @@ -1488,6 +1498,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	return 0;
> >  }
> >  
> > +static void pci_vntb_remove(struct pci_dev *pdev)
> > +{
> > +	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> > +
> > +	if (!ndev || !ndev->ntb)
> > +		return;
> > +
> > +	ntb_unregister_device(ndev->ntb);
> > +	ndev->ntb = NULL;
> > +}
> > +
> >  static struct pci_device_id pci_vntb_table[] = {
> >  	{
> >  		PCI_DEVICE(0xffff, 0xffff),
> > @@ -1499,6 +1520,7 @@ static struct pci_driver vntb_pci_driver = {
> >  	.name           = "pci-vntb",
> >  	.id_table       = pci_vntb_table,
> >  	.probe          = pci_vntb_probe,
> > +	.remove         = pci_vntb_remove,
> >  };
> >  
> >  /* ============ PCIe EPF Driver Bind ====================*/
> > @@ -1581,10 +1603,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
> >  {
> >  	struct epf_ntb *ntb = epf_get_drvdata(epf);
> >  
> > +	pci_unregister_driver(&vntb_pci_driver);
> > +
> > +	pci_lock_rescan_remove();
> > +	pci_stop_root_bus(ntb->vpci_bus);
> > +	pci_remove_root_bus(ntb->vpci_bus);
> > +	pci_unlock_rescan_remove();
> > +
> >  	epf_ntb_epc_cleanup(ntb);
> >  	epf_ntb_config_spad_bar_free(ntb);
> > -
> > -	pci_unregister_driver(&vntb_pci_driver);
> >  }
> >  
> >  // EPF driver probe
> > -- 
> > 2.51.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
