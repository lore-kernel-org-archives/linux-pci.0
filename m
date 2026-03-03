Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021101.outbound.protection.outlook.com [40.107.74.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC917C220;
	Tue,  3 Mar 2026 04:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513160; cv=fail; b=cqUx/4JgQqM7kFO7rN07uSG/PcFTH/BvNH0V80E/9hrDX1nfqm1Bt1Jy2dyZgXa3ZJNXFbA1xC/e9wZxdXBeBvtH18ldRxisJPzmbiYrsqmyU9EUJ+hTqYPI3oT6IgcxhLP8RDFc2PqJBq097Rc+P1PRIyS+EHPUsSGFpOzbLEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513160; c=relaxed/simple;
	bh=W9Cj7SrXBKSlzy80WrZMQU3nb1FfKWx4S1Nw6HOAt2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gTULcFzuym/iFilZ++pD7eJowW0RdQZ0KOZc0NXXmFBoH+e8g2GpM0XibxwtUOChiqWeC8ggI4+FfVzfGrPJFsym4Gd3IbPtDC4zYY3vZ9ivJr90yUusA9NRQzMaJG3FRKHd+SBtXmQf2lMdvX5h4pPh6GhfZwmqQNdpbKhl0FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UR69s2GT; arc=fail smtp.client-ip=40.107.74.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UR69s2GT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r91xvvU4iE83cl9zfW2xhWizRZmY5o6CTBHaPZAYNpUyd8pCc9DmGLSe/Q0BHT8q/r7ziDHlRzrQJd8icQj1IhVNgMlqZH+LuczMzHAzXtyKUNJS8CiCKJ6drzChWDVmlQdFUqaOI7unPlYW5zLTmJiNodr4TH3xYuvTNlavaj554F4pLorwnofi6tTB/e4SK9FH4WVTNBFYyrpUYOQga9rDj8dHbcUrCNkS7D1NO1HWb3MWvd0VZnnuIUcV+AgTmVd9lstQ65p23fB5rr7nt4yVADBM9rI8vmhTKFiqImbcRUduwmtLsEel97HjdH7kVb1LarLi+GJ2Bw0c3DCUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BHH8YCbqyg4nQFBTSpZpDVrCp1H3GFLV69BF5wvTdY=;
 b=OQ+BvZVjYmj45iFtisqoOAjmesKOShlHVryf0Y6pEPe1Arvrhfny5oXWkNEo0m17svSn/gz0hRW6LJLGGqgDN8GzU8ocfW0pxzT/w6LRAlOI/Rj5dDH+v7soo0ojrFwUdUR4SueNCgIHTCL7+M/SKtgTfRRQiDiyKu6+kqtFc+C2vXQO84LGZmp0xPtJcn2WYRoyTBqlTr7NhYFcJtI36uL9Lo4bQE029UCaagW1iPB4YlWwFcgRhpWOSrUlp4xuBWK7wjHigc1cL3wk16kDWfL7YjJNC1EYT8t6My5y3ggusSdP/OzRypm7eyS6/I1pSf6LwI3A2M6Yn4g4HnyLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BHH8YCbqyg4nQFBTSpZpDVrCp1H3GFLV69BF5wvTdY=;
 b=UR69s2GT2YUQepETzwL/D6Tt7KwNH3FYcZlup5ifFPeG/1O79+VkvcEWKroWqnsvXCnMEOhIsw4t/hAUhrYk0ieELwkkrw7mEDFQm3NpREpixbd+sotEVx9/hUNSQG3fb40w7v5Gn+JarAP84k/CQVIRMy0foT3F2eLNNRfJs5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5947.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 04:45:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 04:45:55 +0000
Date: Tue, 3 Mar 2026 13:45:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, kwilczynski@kernel.org, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ye Bin <yebin10@huawei.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] PCI: endpoint: pci-epf-vntb: Switch
 vpci_scan_bus() to use pci_scan_root_bus()
Message-ID: <eb7iqd7odcyojhybz2w6uqtbqfh5hayou6qpvyq6wtsokv4b4c@dput6rhnc5vt>
References: <20260226084142.2226875-1-den@valinux.co.jp>
 <20260226084142.2226875-5-den@valinux.co.jp>
 <3tgrcel5fl55ulf3zjya4fkz4t2ms7iwwjif5rnzn2rafsydd6@i4e5etm7uqvz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3tgrcel5fl55ulf3zjya4fkz4t2ms7iwwjif5rnzn2rafsydd6@i4e5etm7uqvz>
X-ClientProxiedBy: TYCP286CA0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: ed294303-c713-4d1b-dcce-08de78dfc153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	sdD50ovWO19xIjIT7n8IyDUC7qu+9cNntajP3c52UCoMhco0huRytya+KtHtt9wKKvIg2UzlEyelGWf4bBHwoT6zOfZF/7VlqEk0TRFTiFK5EFnpZyOGrChFG+14ZMf5AxawEmYi42V0NzU17f5j70/IOzQDbsVGPgYosQxsbgR12NUiR4js6cnkuGyE/1ntG2GRpy1hE/b0BF/Z9juLTUa7o5cCa4Uvm/zqhTJBtoXjgdZDkW0PBujIZ8CZErq9sIQ5TC8xZcW7cJN/hUAICnrL3JKxbEO+rEFbiDk/eV8cVMcKmK7nefjHrmxOzueqCZTVHvyKQhZkgcX1YbVgv5PujZ4ljLH5Svq5HNYx3Fab9hngJR4jubsmnZ/iIFn+wWPZs+6+Yrz20nRP5rBICFJUsiNpfn0ipC1gebr7ikZRDEAwiJm2SSs4e6y765vtnS44c/amGdCrP/IhYoi9JRcKvJPp+hPdIkfNmy09tT1stNGcmOFQGeF6aQNfzuqRfy96psUGB+wV4wlYX+FtXsoOx7KzIs7oulB7JDpHIAF16pLAn4sMx1pScMz+yOli3EQh2JkyeryDCo5llav2cNfVb5FGJYT0n+P/7kdYUTMEptddkv7WdIkL0wfnDZAVeQr5nSSpO5IB4QLHwAVFcwn0yke9UoJqtTTRymsPvnoGOI4zpWm7qHlM5kwCgG61B5+1cYmZmp94+QErg+c6fcH540HrKjDGhFBgiSkjH+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3J1VUJEbnR0YmhmazZzTUY3Zmg3eUJERUR5eXAyNzBxTHRJbmQ4cVFaSUZ2?=
 =?utf-8?B?MU1hWkJQVGltakFUWWIyQjFLeVpISmxobHNlQVVPVVZZeTlUZTFmblFyWFdk?=
 =?utf-8?B?Y0hlUk9BY01ubUg3dEdpRkU0UTVtSnZCcEhGRGRuRjlNRHp2MTl4VUQ3a2Vm?=
 =?utf-8?B?bnJQTnhIK3N6WFJyVEVudTlaWTJFaXNvb3F0eUIzUnJhdEN2SHhmbXN5L085?=
 =?utf-8?B?Mkt3R084eWkxVDV5TDVVNHJiajR6cWJTeFlmd005SHhlSGNyYkFxdlZmY0kw?=
 =?utf-8?B?WGNIbzlHNlBBY0JnNjVxVWM3K2dVOXREdDdLeVlidnRCMFBiVmY2eFlLU093?=
 =?utf-8?B?N0RVa3VnZS93M25ZYnlkV202ZkNMSDd1MzVIOCtXbzNSVzNURXhqdnpMWExn?=
 =?utf-8?B?WEpQcVFnZy9RM1JkZjVXVjZSNWR5OXJDZnVoTEhRNkhsaUtvTWdjTXl5MWFp?=
 =?utf-8?B?MDJLeGtmZ3JkT1d2ZnIwQWV6VFRsOVRGTUdVdkRqQk9OOXJVSlVsM2x5UXI2?=
 =?utf-8?B?cGxCUHFvWWpSaTdPMWJyRmIwNlZHOVYzbHlmc0lXZzA1NUtUMjhkZEhCMjdQ?=
 =?utf-8?B?c3lVUU1iZ3FCd29vMFZsYUwvT1V0TGV0NGtWeVg2eERQNFI1L0xYZThVVExT?=
 =?utf-8?B?YUNoOEpoYmcrWGZQT3VWaTg4MHVtcHNmZTVOd1llc0hkZVJvc0ZNYWROL3Br?=
 =?utf-8?B?TlZ0RzNRQ1haenhUT3RBVjRKajZOWk82bFB0c1M3dUtiTU1OMlZmRVRYOEhS?=
 =?utf-8?B?VXlKYlFCVDhIdjEwQ2JhZkhnanFDT0djTERtSTBkTkpmdk9QYmM2V1I1OUJq?=
 =?utf-8?B?UUFOWHFneW5kVDNQa3NveFhVdjV0bEc3MlRhK25Ea1hqOTZiLzNIUkhzSWN6?=
 =?utf-8?B?eFRRdFlsMUgrLzlaUkJMQ3VJNng5Z0hUT2tXTlVqV3lWNUVzT2ROc0tjOEh6?=
 =?utf-8?B?THhVNGNoMDBXMlh2VnVDQmp4UzBTZWF4WityVHZ5TUNUYVFUWXZJZXdEL2V5?=
 =?utf-8?B?SzVsdnJCYTQycTZWQ0w2NXZMbkNiTHpUMWkyNDQ3a3ZxQTRmY3ozZXRsUVJa?=
 =?utf-8?B?S2ZjTGdycWhFUlVSZUt3emZSMmVJVzluVVk1c3ozcGNzM3pZeWt4cGZwYjhQ?=
 =?utf-8?B?R3d0RWUrTHprN3Z2RStEUUtkdHdWRElOUi9wanAwTFNmNXRneFRvcFdkMk1h?=
 =?utf-8?B?VmhSbUpNUitzbVdNVnVtbElWL3NzWGlYcG1kOHlXVGtINTJiVEVPYlZ0TFlK?=
 =?utf-8?B?MGhoaTNxc1AyckJiM1lMb0FibmF2QXBHSm9QSjQ4RWFzTXpjUFcvM0JFT2tn?=
 =?utf-8?B?bGpuN29KT1E0Wjg4TlRkL01UL3FCS3dOdFZNL1RrdWwzeTlRbWI2eGo4V0VH?=
 =?utf-8?B?ejNRczEvSW9MSW8rL2tPNXJsWGhSeUh0R1pjSVNiTDhkUTdxeXlpSys0dVFJ?=
 =?utf-8?B?dUZLWjFUSmVzK204eHlWRlRjN3NkZjcyZ2RzbGJqWkF3TFptTkMxNEVzL0ZD?=
 =?utf-8?B?UWpwSWZkZVhtL2FUOFJxcG5VdDNOMTdkTTJGTUswK3IwRjIwY1FLSUlPVnhj?=
 =?utf-8?B?c3JZT1N6YitNRlJ5RE9LRitoSGlEM3dnU29tNG5PWVBseWVleUhtZ2QzYW93?=
 =?utf-8?B?cVBhTnY4U0JUcDhqNThiU3RMTFhzWDhFTjhnR1lHRHBBVlFqZFNKZFZoayt1?=
 =?utf-8?B?M2tyOEdHWU55ajFLOEJtT1FIK1EyWTdaK0RwUXBUM1c5bHBTNm1hTDdlNGxi?=
 =?utf-8?B?aUZ6c2NzdDFUa0tMejd5cG5lamY3Q3NKS0ZUNitXbVF4bUI4b0t1MkxPbGRC?=
 =?utf-8?B?M3RNaHBpdXgxbmY3eFgyWDcxbDlkWkVVb25wNkdxbTk1QjFlOU9sdEpSVXQ0?=
 =?utf-8?B?bURiUHlLM1Q3b3B0Y2RBUUxxQ3J2TWtMM3pIR0VuUjZGNEkrOXcxODBMdHg0?=
 =?utf-8?B?dXF6Z1BiS0JQK1FkcVVzMjJqc3NNQU5RMW9qZEJQbzVreTZMS29ldjdOQzgw?=
 =?utf-8?B?OS9JSCtNRWdBVG81WGhoS0svd3BPNy9Yalp6MHNIRVZqV0RsY3ZxVXhObDJ1?=
 =?utf-8?B?N2l0RnFoSkhQZWFKa0huRXl3RzhkQzBObkp3YllXTEJFMGk1dFdPY2hkN1lw?=
 =?utf-8?B?akxQYmNnUDBocnpJWXFxR2lFT3gwc0JYdlZlMnduMjBBN24rVzlHbWdvdVNq?=
 =?utf-8?B?YS9SLzJXVTZQajZnSE9yQVY3MlEvRnlzMEVmS0tBZ2FQRUFtdkFIVGhhRzdn?=
 =?utf-8?B?Zng0b1ZhSHhidUxiTHhCbDNlZ0E0THgwUUloV3dVL1YvWldQM3NmSUlZd3hz?=
 =?utf-8?B?dm1aL2pTNlJNNHdzTkFEZGd1dktQZ2kzL2dvTlUyT210cVdkNDNWdnM1TUN5?=
 =?utf-8?Q?OUKxrYSKCZwcDhdcCAoDAtQ7dqC0Ob5ErbCY2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ed294303-c713-4d1b-dcce-08de78dfc153
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 04:45:55.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TD7iYU1ZALQmujeZYo0p5TSPKkpAp1cXPOCtdlIrJa+qWHXE9/AwvmtvfZ9OfXG+lGMXBNaXvVY1xVJTGnISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5947

On Mon, Mar 02, 2026 at 09:39:26PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Feb 26, 2026 at 05:41:41PM +0900, Koichiro Den wrote:
> > vpci_scan_bus() currently uses pci_scan_bus(), which creates a root bus
> > without a parent struct device. In a subsequent change we want to tear
> > down the virtual PCI root bus using pci_remove_root_bus(). For that to
> > work correctly, the root bus must be associated with a parent device,
> > similar to what the removed pci_scan_bus_parented() helper used to do.
> > 
> > Switch vpci_scan_bus() to use pci_scan_root_bus() and pass
> > &ndev->epf->epc->dev as the parent. Build the resource list in the same
> > way as pci_scan_bus(), so the behavior is unchanged except that the
> > virtual root bus now has a proper parent device. This avoids crashes in
> > the pci_epf_unbind() -> epf_ntb_unbind() -> pci_remove_root_bus() ->
> > pci_bus_release_domain_nr() path once we start removing the root bus in
> > a follow-up patch.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v4:
> >   - Correct the subject prefix
> >     s/NTB: epf: vntb:/PCI: endpoint: pci-epf-vntb:/
> > 
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 805353528967..f353e9a57194 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -1220,8 +1220,19 @@ static int vpci_scan_bus(void *sysdata)
> >  {
> >  	struct pci_bus *vpci_bus;
> >  	struct epf_ntb *ndev = sysdata;
> > -
> > -	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> > +	LIST_HEAD(resources);
> > +	static struct resource busn_res = {
> > +		.start = 0,
> > +		.end = 255,
> > +		.flags = IORESOURCE_BUS,
> > +	};
> > +
> > +	pci_add_resource(&resources, &ioport_resource);
> > +	pci_add_resource(&resources, &iomem_resource);
> > +	pci_add_resource(&resources, &busn_res);
> > +
> > +	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
> > +				     &vpci_ops, sysdata, &resources);
> 
> Don't you need pci_lock_rescan_remove()/pci_unlock_rescan_remove()?

Yes, we do need them. Thanks for pointing this out.

This locking was already missing before this series (when vpci_scan_bus() used
pci_scan_bus()), so I'll add a separate fix patch between Patch 3 and Patch 4,
likely with:
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP").

---8<---
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 805353528967..469b6e2b8d45 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1221,14 +1221,19 @@ static int vpci_scan_bus(void *sysdata)
        struct pci_bus *vpci_bus;
        struct epf_ntb *ndev = sysdata;

+       pci_lock_rescan_remove();
+
        vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
        if (!vpci_bus) {
                pr_err("create pci bus failed\n");
+               pci_unlock_rescan_remove();
                return -EINVAL;
        }

        pci_bus_add_devices(vpci_bus);

+       pci_unlock_rescan_remove();
+
        return 0;
 }

---8<---

Also, while respinning, I'll fix the error path in the pci_scan_root_bus()
version to free the temporary resource list when pci_scan_root_bus() fails,
since it doesn't free it on behalf of the caller. I noticed this while
revisiting the patch.

Best regards,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
