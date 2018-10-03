Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D223C00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 10:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5F72098A
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 10:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5F72098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJCR3Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:29:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeJCR3Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Oct 2018 13:29:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 057C118A;
        Wed,  3 Oct 2018 03:41:28 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA8F13F5A0;
        Wed,  3 Oct 2018 03:41:26 -0700 (PDT)
Date:   Wed, 3 Oct 2018 11:41:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/pci: Fix compilation warnings
Message-ID: <20181003104121.GA13827@e107981-ln.cambridge.arm.com>
References: <b2433aaac6ace7b1b9843b520242d9e9185d3685.1535024080.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2433aaac6ace7b1b9843b520242d9e9185d3685.1535024080.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 23, 2018 at 01:34:53PM +0200, Gustavo Pimentel wrote:
> Fix compilation warnings:
>  - remove unused variables
>  - change function return from int to void, since it's not used
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  tools/pci/pcitest.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied to pci/tools for v4.20, however, I reformatted the subject
to make it in line with previous commits and added the warnings that
you are fixing in the commit log.

Lorenzo

> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 9074b47..8ca1c62 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -23,7 +23,6 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/ioctl.h>
> -#include <time.h>
>  #include <unistd.h>
>  
>  #include <linux/pcitest.h>
> @@ -43,17 +42,15 @@ struct pci_test {
>  	unsigned long	size;
>  };
>  
> -static int run_test(struct pci_test *test)
> +static void run_test(struct pci_test *test)
>  {
>  	long ret;
>  	int fd;
> -	struct timespec start, end;
> -	double time;
>  
>  	fd = open(test->device, O_RDWR);
>  	if (fd < 0) {
>  		perror("can't open PCI Endpoint Test device");
> -		return fd;
> +		return;
>  	}
>  
>  	if (test->barnum >= 0 && test->barnum <= 5) {
> -- 
> 2.7.4
> 
