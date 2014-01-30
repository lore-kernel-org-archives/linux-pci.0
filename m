Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:37701 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbaA3HJC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 02:09:02 -0500
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 30 Jan 2014 12:38:57 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id DA9B81258054
	for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2014 12:40:39 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s0U78lwh25755696
	for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2014 12:38:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s0U78qmu024278
	for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2014 12:38:53 +0530
Date: Thu, 30 Jan 2014 15:08:50 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Or Gerlitz <ogerlitz@mellanox.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, yinghai@kernel.org,
	bhelgaas@google.com, amirv@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140130070850.GA24083@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20140114103712.GD27684@richard>
 <20140114132340.50df7d6f@jpm-OptiPlex-GX620>
 <52d52032.4981e00a.3dcc.ffff81fdSMTPIN_ADDED_BROKEN@mx.google.com>
 <20140115094113.64ca756e@jpm-OptiPlex-GX620>
 <1389772791.6933.84.camel@pasglop>
 <52d653d3.8425e00a.76d0.1e60SMTPIN_ADDED_BROKEN@mx.google.com>
 <20140115160204.24a44af0@jpm-OptiPlex-GX620>
 <20140116020946.GA8702@richard>
 <20140116021429.GB8702@richard>
 <52E8C0D6.3030105@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52E8C0D6.3030105@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 29, 2014 at 10:50:30AM +0200, Or Gerlitz wrote:
>On 16/01/2014 04:14, Wei Yang wrote:
>>>>>+static void mlx4_shutdown(struct pci_dev *pdev)
>>>>>+{
>>>>>+       mlx4_remove_one(pdev);
>>>>>+}
>>>>>+
>>>>>  int mlx4_restart_one(struct pci_dev *pdev)
>>>>>  {
>>>>>         struct mlx4_dev  *dev  = pci_get_drvdata(pdev);
>>>>>@@ -2582,6 +2590,7 @@ static struct pci_driver mlx4_driver = {
>>>>>         .id_table       = mlx4_pci_table,
>>>>>         .probe          = mlx4_init_one,
>>>>>         .remove         = mlx4_remove_one,
>>>>>+       .shutdown       = mlx4_shutdown,
>>>>>         .err_handler    = &mlx4_err_handler,
>>>>>  };
>>>>>
>>>>>Thanks,
>>>>>Gavin
>
>Guys,
>
>Did you converge here?  I don't see this patch in Linus tree, so
>wasn't sure where the discussion went eventually.

Or,

Even this patch really could make the machine boot up, we didn't find the root 
cause of the failure as mentioned in the first mail. I will find some time to
dig into it if I have more time and will send you update if I find it.

For this patch, we(Gavin and I) don't think it is a formal patch. We send it
here just let you know we find a work around and this one really helps. As I
mentioned in the previous mail, we suggest you guys to create a formal patch
with this function, since you are more familiar with this device and the
driver.

If you think it would be nice for a patch from us, I am very glad to do
this.:-)

>
>Or.
>
>Or.

-- 
Richard Yang
Help you, Help me

