Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C48ECE560
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 19:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E5821536
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 19:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="chwQQjGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E5821536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeI0BjK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeI0BjJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 21:39:09 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248B221533;
        Wed, 26 Sep 2018 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537989882;
        bh=2hXRx2MAfdkcNOP4dsXI5d/CD00bmpA6f7jg2uJ17VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chwQQjGGevoGdnx6poapReTxHNIZnXsAbavq1AAGvJFKUjHCVM66z98DGQOanFz4D
         oq889318Oe3oMakV7p1Mgrc96SZGblAOBqkQt2H40I4w7aI56QCGgYwrRiGyVAU27d
         gzkQE0tRFZKSZ2FyGRENBih2h1g++N5GsWIdmKSM=
Date:   Wed, 26 Sep 2018 14:24:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI/AER: Remove duplicated include from err.c
Message-ID: <20180926192440.GC28024@bhelgaas-glaptop.roam.corp.google.com>
References: <1537959610-71713-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537959610-71713-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 11:00:10AM +0000, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to pci/hotplug for v4.20, thanks!

> ---
>  drivers/pci/pcie/err.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 4da2a62b..773197a 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -12,7 +12,6 @@
>  
>  #include <linux/pci.h>
>  #include <linux/module.h>
> -#include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/aer.h>
> 
> 
> 
