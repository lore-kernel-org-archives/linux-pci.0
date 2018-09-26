Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE83AC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 19:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967AE21537
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 19:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0WkAfCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967AE21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeI0BjW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeI0BjW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 21:39:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7031D21533;
        Wed, 26 Sep 2018 19:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537989894;
        bh=X5n6dmKpmT7KtRZUKm+0JzbChSY8lI18L7dhJ4p1TFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0WkAfCsROFpZF4aKtMYkX6QwN0ajg3JQXHxKxn2ho7DTP+PaCL40i1HdbZqwixsw
         9p+zYc2G69DV3nfqdGWR8XZYYOdcaD+Apc/eyRLDGsIcrUa55I6up1SLCA6TZGyYzD
         jF5NIutESbdiWaX1kM+932nzopKuAQt6AclPSvng=
Date:   Wed, 26 Sep 2018 14:24:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kees Cook <keescook@chromium.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Frederick Lawler <fred@fredlawl.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: hotplug: Remove set but not used variable
 'physical_slot'
Message-ID: <20180926192453.GD28024@bhelgaas-glaptop.roam.corp.google.com>
References: <1537959962-83251-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537959962-83251-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 11:06:02AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/pci/hotplug/cpqphp_core.c: In function 'init_SERR':
> drivers/pci/hotplug/cpqphp_core.c:124:5: warning:
>  variable 'physical_slot' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to pci/hotplug for v4.20, thanks!

> ---
>  drivers/pci/hotplug/cpqphp_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
> index 95b7d60..16bbb18 100644
> --- a/drivers/pci/hotplug/cpqphp_core.c
> +++ b/drivers/pci/hotplug/cpqphp_core.c
> @@ -121,7 +121,6 @@ static int init_SERR(struct controller *ctrl)
>  {
>  	u32 tempdword;
>  	u32 number_of_slots;
> -	u8 physical_slot;
>  
>  	if (!ctrl)
>  		return 1;
> @@ -131,7 +130,6 @@ static int init_SERR(struct controller *ctrl)
>  	number_of_slots = readb(ctrl->hpc_reg + SLOT_MASK) & 0x0F;
>  	/* Loop through slots */
>  	while (number_of_slots) {
> -		physical_slot = tempdword;
>  		writeb(0, ctrl->hpc_reg + SLOT_SERR);
>  		tempdword++;
>  		number_of_slots--;
> 
