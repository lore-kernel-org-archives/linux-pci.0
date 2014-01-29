Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:41248 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750926AbaA2Ivo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 03:51:44 -0500
Message-ID: <52E8C0D6.3030105@mellanox.com>
Date: Wed, 29 Jan 2014 10:50:30 +0200
From: Or Gerlitz <ogerlitz@mellanox.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
CC: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	<yinghai@kernel.org>, <bhelgaas@google.com>, <amirv@mellanox.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, <linux-pci@vger.kernel.org>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
References: <20140114062215.GA19345@richard> <20140114105031.71882944@jpm-OptiPlex-GX620> <20140114103712.GD27684@richard> <20140114132340.50df7d6f@jpm-OptiPlex-GX620> <52d52032.4981e00a.3dcc.ffff81fdSMTPIN_ADDED_BROKEN@mx.google.com> <20140115094113.64ca756e@jpm-OptiPlex-GX620> <1389772791.6933.84.camel@pasglop> <52d653d3.8425e00a.76d0.1e60SMTPIN_ADDED_BROKEN@mx.google.com> <20140115160204.24a44af0@jpm-OptiPlex-GX620> <20140116020946.GA8702@richard> <20140116021429.GB8702@richard>
In-Reply-To: <20140116021429.GB8702@richard>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16/01/2014 04:14, Wei Yang wrote:
> >>>+static void mlx4_shutdown(struct pci_dev *pdev)
> >>>+{
> >>>+       mlx4_remove_one(pdev);
> >>>+}
> >>>+
> >>>  int mlx4_restart_one(struct pci_dev *pdev)
> >>>  {
> >>>         struct mlx4_dev  *dev  = pci_get_drvdata(pdev);
> >>>@@ -2582,6 +2590,7 @@ static struct pci_driver mlx4_driver = {
> >>>         .id_table       = mlx4_pci_table,
> >>>         .probe          = mlx4_init_one,
> >>>         .remove         = mlx4_remove_one,
> >>>+       .shutdown       = mlx4_shutdown,
> >>>         .err_handler    = &mlx4_err_handler,
> >>>  };
> >>>
> >>>Thanks,
> >>>Gavin

Guys,

Did you converge here?  I don't see this patch in Linus tree, so wasn't 
sure where the discussion went eventually.

Or.

Or.
