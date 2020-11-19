Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F64C388F9
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 10:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67AE22260
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 10:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgKSKEf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:04:35 -0500
Received: from foss.arm.com ([217.140.110.172]:51884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgKSKEf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 05:04:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB4FD1396;
        Thu, 19 Nov 2020 02:04:34 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3AF13F718;
        Thu, 19 Nov 2020 02:04:33 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:04:28 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Peng Fan <fanpeng@loongson.cn>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] tools: PCI: Fix memory leak in run_test
Message-ID: <20201119100428.GA14090@e121166-lin.cambridge.arm.com>
References: <1591875166-12243-1-git-send-email-fanpeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591875166-12243-1-git-send-email-fanpeng@loongson.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 11, 2020 at 07:32:46PM +0800, Peng Fan wrote:
> We should free "test" before the return of run_test.
> 
> Signed-off-by: Peng Fan <fanpeng@loongson.cn>
> ---
>  tools/pci/pcitest.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 0a1344c..7c20332 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -47,6 +47,7 @@ static int run_test(struct pci_test *test)
>  	fd = open(test->device, O_RDWR);
>  	if (fd < 0) {
>  		perror("can't open PCI Endpoint Test device");
> +		free(test);
>  		return -ENODEV;
>  	}
>  
> @@ -151,6 +152,7 @@ static int run_test(struct pci_test *test)
>  
>  	fflush(stdout);
>  	close(fd);
> +	free(test);
>  	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
>  }
>  
> -- 
> 2.1.0

This is not necessary, though good practice but I would do it when
run_test() returns not as you did.

Patch dropped, feel free to resend it.

Lorenzo
