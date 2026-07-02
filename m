Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012018.outbound.protection.outlook.com [40.107.200.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC351CD1E4;
	Thu,  2 Jul 2026 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782965088; cv=fail; b=Vnbn0D1AYKzfIY8zijqBf6TwSTZmaoxdmLstSVDdpycvSA3IxLYARBGWMaxBVE113ui0tWH1XpWKIh+PdGLXchUgnHAqyDNgY8u26E/9pvi+blFkBRWNcHqJwSZHDDWYyPlWs6YIMBSOtF/g70xD/sE1Yd8I7csKhK9eQTPt39o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782965088; c=relaxed/simple;
	bh=+xo5vi7RF7bEE4KVgHpqpk/CiNvKglf902IIfEPVDoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtnJnevZyubXzzc2hyQ/pvojpVyTfVfMmtWA5a3Il+O/g/bM+jXnIPeeJZgp5fDZQBd/fz3x0YuIX5uxIqAlo+W54Ny+maWA70IVCdzz2TiPrpoFv1a6l/a7yspJ/XoXkzOpVEC/VWwcP+mRwHzNgkh2FmJSkdl0hz5wzsa2TAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DeNsvPd3 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.200.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DeNsvPd3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sApuheVpK/+5nnHTiLsEtfnYx1NGmyW1AyN5jxo1aYNnAoQbnAtn42tZPbhoYB8TFEFDJ71A+SZ4jzFuL8IG5I4MfjnPuKc8fgbwuwJspXAspYW5pU/pibftdrU0CYn3RvBi03aPi1iIcsMzK0rModpZOogwARm+6c7gPxQ/uHllC+G1fLOMgYIfpt7J0Uw53IFWxC6ROA3hOo5FxZSqQjTZrIIpHSlr8D79pfUja2J7XZBk6AAFQ+VrNXtdyxWXgx+yIxEu7OjXxBAM//pC0yQ7ao+2/CARQwqGkOlFPwA4hrQRQ4m3hJ1XoXFJ1UcCQfO6IH3igZAyzwPgHsMLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3eHcbyfC+Rx4BO1NzLO02ubRuMYXtHzHfOCTRpNa7g=;
 b=TRw8l/slReMXB0XLGgkfILbEUY/60A2QkKaQ/RsMyAvQ1YYuzzD1w0OSHaj/BpNhSndu1ltrV1vmN9R3u6adRkCMcZ9O52McX+ym3sTLgJchK6nSaHXgCa9/r++9rdNcoV8M+bk1gGsH30lbxgYcqGP4Bh6EZhq01PZNlAfkNBks+CR2AJC8NlMLi5LdPqLm9ViEv1zzyINrnsUjnwKleTTecayGhwDvt2RUerYg0XrbcsS653i2yoMwG79cQuAtU3ixE0dl1VQACvBMQRsQOTiTOE4JfOc2VVVsLNN8kFnVPgUMYYTJY+jfCFPC9oGLFsNqlTPcsm8FsSD7LAfMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3eHcbyfC+Rx4BO1NzLO02ubRuMYXtHzHfOCTRpNa7g=;
 b=DeNsvPd3S3uyTEMu7jDGGwlbRDlpmpScPxcSkx417t3+NASA1KrCFdh73TJp5mFiHFklyp02cTGh5IhdJ7LSMgVtfgJI1jn9vRsLtKix0icyQ71gZ8+13aNMmmtTh93leKZUld4jWci5iZsYdfw8mw9199NS1W7PYn4QxpAZ+Mi+5RP2SfkdGSVo/0FgPkNaMda5pymfT6EhIncG2g2aJlXBnB2KzQy89Zp/2tlW1/uSZKlt+xe6uHWKQvW+xyndhpaQpGJL3rxltJSN1UHcbQegGYkY97TybZH5yqd5qdKCoIdVNCoqSXEwJYQVyNUx1LXtDitEu9EkGU9MTyCWMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 04:04:42 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 04:04:42 +0000
Date: Thu, 2 Jul 2026 12:04:37 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Herve Codina <herve.codina@bootlin.com>, linux-cxl@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 7/8] PCI: of: Set fwnode device of newly created PCI
 device nodes
Message-ID: <akXjNz0m_dL-YvQW@MWDK4CY14F>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
 <20260630102804.413563-8-herve.codina@bootlin.com>
 <20260630112334.5D0151F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630112334.5D0151F000E9@smtp.kernel.org>
X-ClientProxiedBy: TPYP295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd06955-7db8-4e16-c26f-08ded7ef0aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cdOPUXxiqDMaLd4ETeDFRTKDLWOFW6mhuYQI0VqzgMOYV52lbxAaP3QDwVrpLmXz0mUwtMzJSYsfiQLK6YGzP45Sa0nGcy8hPbWnWpXHXC/yY3zgIgXhqMS8PuuIhvgt0SF3msi6AAPMkWxOTzLf9+BM4PRhpAe0oUzEnzGKxumqemTeIDaVEL3lFF5MyKRw/FHyZOkiJ3gI2FYmrwuiIwW3mx8nFvk/XPdEOl2LazUKV67OTCEO7fKgwFzHl7lYIHfqALI88BLUu9g54AS2My4DdpgfWSnuKy9z4EiDnzjkaDoGBb3Iod5b6pMFHYG+Ko8weR8onPtDmsup8CjxkjD2yELJpTSM2FCdeX66TMiX2OOdETWpR8watH4Y+3a1AB6vMzVu4DxoiO7jvVtu1ShG2nbYoYT9QGPj5wspZ857tRSrKIhYcLKoQ5B72kMoaINL49QpBZlby+KN1U86Ra5wx84kT94xP0GDS4cZ0plsCFCiG08Yiy4LJPimGUzkCXjF+INB85H9T9P2wRmcRW4wn11B1sOlhtrkWQYRhWsoxBUUCy3g4/1EmO48/QMU9Rw1M1kNSr0nMS1Su754KTpoXabXfqRcMI3KphrPU36d4JMHi2oC8GzMqKjiCp3bPiw1fHih3GbkUY+9Y23AlqahBfTmZ5QHqyaZI/MMBZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?PIp3PzMNn/HpmS88NKJa+2uqUNpSFAJuc2s0Fx9y5hVmNkuskxXfbAc7vH?=
 =?iso-8859-1?Q?697hsMq7ROfTk/vO0vh+lF4OOBcvmuGzk/oXNhJg4/E0QPyz8GlMH7OBi7?=
 =?iso-8859-1?Q?bXMddhl43hhj8S7ksdKHWvdGXKhXTtRlJ5N0aMhapSNWJpKuYcjM8KiJ9W?=
 =?iso-8859-1?Q?5Lp0XJNWwVVEzL4dEHzZ54rL0VNNd9lBtTKf2wMaMhfRLP1q2irjVend/6?=
 =?iso-8859-1?Q?RzPbgm4pJWSaY5pk57tqbmik7l50x2siZ+GVoDCFxaZD5rMzX3lX2HHE75?=
 =?iso-8859-1?Q?Ps0hshX6TnzG3QZEgT8QhuFyPYvv927imiv6xx774ZeOgOyDgwrWbeniPh?=
 =?iso-8859-1?Q?zmlXAirdC1WtAUjiJQ+VAm+9sVT6FSK8q/uWVYeYHUXw041plg9IdE70GA?=
 =?iso-8859-1?Q?p0CdMsoVLSRhtz4no5ll+vnIclyc0OWWorVQmk46Z+9ViRsD1O//sytoru?=
 =?iso-8859-1?Q?CZ2g3i5ulBzPeiOnVCkO0Lw4ipdtUCB2bbqfWHikRFQNeeeFF522HmonPC?=
 =?iso-8859-1?Q?Rfix8IuXecTRgaePOU/tpevzb25qdk+8784r6CjfB9X+fglue2tQJXlEhl?=
 =?iso-8859-1?Q?JvttoAa6oWlGEssab44tGJy0Td1uIxoea/R1jzGQv56/i5178jRDmYV33M?=
 =?iso-8859-1?Q?7tChWxy4TyrJhX5/ju0X+AJP5rZSUSr/dL03wmfJ66li9mgnXG2ZSOGtrH?=
 =?iso-8859-1?Q?6ok4Q8GFDmGTlq1hNRRhyOwyrkGtE6OP1edQ45ymQZLmM6QyGHVqOz1xzC?=
 =?iso-8859-1?Q?Hz6jm8SQiQhL+IHq0RTnny94GZGtkdnMdv3WWWXbepVpmVyLZV5H3hJz4U?=
 =?iso-8859-1?Q?WBYjERLQNBJ7+hIr0YxJlerayNeR1CVyYLQnImV0rAWwR9Svh680N2yZxg?=
 =?iso-8859-1?Q?8zjc6+VFM+ELU/E9ly7L4JBdJ6QWYtBXs0f0HSvU1mP0sC9xBB75GdYxIo?=
 =?iso-8859-1?Q?M0p6V8Iw3n2RFKmoJPndAb4aJfSU3X0UeIpazq0Dy0Vmzt16GP+V4IBOTW?=
 =?iso-8859-1?Q?eL0NB0mx8PEl4Mo0TRsFqCvdQW9g4mLUCpdb/8x5jcis4MimXGSHE7Xkfn?=
 =?iso-8859-1?Q?E5p3YCHhXcZwn15x1X+T0C97o9wZdLm7mKFqnPjhQlh7cIFz2R40dB6ySF?=
 =?iso-8859-1?Q?kU351VMjS5XpWlsvXaAtoVoarb6T8+kFWHe5kwVfCT5d2QHKyHrsgy+th6?=
 =?iso-8859-1?Q?LAGQjA05N6QS5XloimzNIexcr8JvhSWOuLFuOM7cwbJBSCWaq0DAeqTdRP?=
 =?iso-8859-1?Q?pUvOkdixQ7GVNFFC/SvK814vPWaDN7R9tqcV/VmRYDrDieXP6cELEpeF0D?=
 =?iso-8859-1?Q?0kM48COIIzOJCpF39R3m7C5iGW2nl5yC3ASMLUwj4Dsn1lRGiQ3TFhjIp7?=
 =?iso-8859-1?Q?gEwZasdUTRjXxqAAIyhiGHzlFEW4ewGy8w1Iber23GQA7MLvkqC9Z8Lq9V?=
 =?iso-8859-1?Q?MSZr+Id5ctmzEbtNK/q4c8VQ7v+wLYZJ5Ve23v4SroHEZoJDHPSIGOasND?=
 =?iso-8859-1?Q?aRsP+ZCuoal0jQUNWouNU1GTdHEzrM+raPhz+b5RecGiBUPscnu7OplABw?=
 =?iso-8859-1?Q?fkdXYdeqr3lvoMY7aTjEsHFHCEVGCe2pODatu5v+HftHbTqnhV/r832+mf?=
 =?iso-8859-1?Q?QMwRdTSf4NaQlA5f8BB3+DUqRn90NXz54E+PVO6upSWT/TJRpt2kT+Po7z?=
 =?iso-8859-1?Q?jy+YKRxR8EnTGuc8JLHAAPQU1XysxoaRPkNpcV0sGuHR+K2i+KlTwRem30?=
 =?iso-8859-1?Q?qeaxiCiJZpRJBcRxKkgozAqve5pNsHCGA2Mr7qJClrKKKj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd06955-7db8-4e16-c26f-08ded7ef0aee
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 04:04:41.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmJumxfs1w6XCKaBTfHKVLzOOohmXtAIfJ1BKCzJ7gCrDVexuh27+1YtGBB54OOHw4uokIQO/KBEuboeT3JC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999

On Tue, Jun 30, 2026 at 11:23:33AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Dangling `fwnode->dev` pointer leads to Use-After-Free during PCI device or host bridge removal.

Seems that sashiko also find the same issue.

--Richard

> --
> 
> commit 282379de7d271ef07bfe62ea73e0c684092059cd
> Author: Herve Codina <herve.codina@bootlin.com>
> 
> PCI: of: Set fwnode device of newly created PCI device nodes
> 
> This commit sets the fwnode device field for dynamically created PCI
> device nodes. This ensures fw_devlink uses the correct PCI device as a
> supplier rather than walking up to the PCI root bridge device.
> 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index ee9eb384b377a..eda14cefca5e7 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -709,6 +709,13 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
> >  	if (ret)
> >  		goto out_free_node;
> >  
> > +	/*
> > +	 * Set the fwnode device in order to have fw_devlink creating links
> > +	 * pointing to this PCI device instead of walking up to the PCI host
> > +	 * bridge.
> > +	 */
> > +	fw_devlink_set_device(&np->fwnode, &pdev->dev);
> 
> [Severity: High]
> Could this leave a dangling pointer in np->fwnode.dev resulting in a 
> use-after-free during device removal?
> 
> When of_pci_remove_node() is called during teardown, it executes 
> device_remove_of_node(&pdev->dev) which clears pdev->dev.fwnode early.
> 
> When device_del() runs later, its standard cleanup logic relies on the
> fwnode pointer still being intact on the device:
> 
>     if (dev->fwnode && dev->fwnode->dev == dev)
>         fw_devlink_set_device(dev->fwnode, NULL);
> 
> Since pdev->dev.fwnode is already NULL from the earlier call, this cleanup 
> is bypassed. If any reference to the OF node is held after the PCI device 
> is freed, np->fwnode.dev will still point to the freed pdev->dev structure.
> 
> Does of_pci_remove_node() (and similarly of_pci_remove_host_bridge_node()) 
> need to manually call fw_devlink_set_device(&np->fwnode, NULL) to clear 
> this safely before the node is removed?
> 
> > +
> >  	ret = of_changeset_apply(cset);
> >  	if (ret)
> >  		goto out_free_node;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260630102804.413563-1-herve.codina@bootlin.com?part=7
> 
