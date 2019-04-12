Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10FFC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAD12084D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDLOlb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:41:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34242 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLOlb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 10:41:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 306B115AB;
        Fri, 12 Apr 2019 07:41:31 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 845C83F557;
        Fri, 12 Apr 2019 07:41:29 -0700 (PDT)
Date:   Fri, 12 Apr 2019 15:41:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: endpoint: fix a potential NULL pointer dereference
Message-ID: <20190412144124.GA8730@red-moon>
References: <20190315050711.8652-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315050711.8652-1-kjlu@umn.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 15, 2019 at 12:07:10AM -0500, Kangjie Lu wrote:
> In case alloc_workqueue, the fix returns -ENOMEM to avoid
> potential NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 3e86fa3c7da3..dc610eb1543a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -570,6 +570,10 @@ static int __init pci_epf_test_init(void)
>  
>  	kpcitest_workqueue = alloc_workqueue("kpcitest",
>  					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +	if (unlikely(!kpcitest_workqueue)) {
> +		pr_err("Failed to allocate the kpcitest work queue\n");
> +		return -ENOMEM;
> +	}
>  	ret = pci_epf_register_driver(&test_driver);
>  	if (ret) {
>  		pr_err("Failed to register pci epf test driver --> %d\n", ret);

Updated the code slighty and pushed out to pci/misc, thanks.

Lorenzo
