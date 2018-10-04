Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75FAC64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84E521473
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 11:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84E521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJDSEf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:04:35 -0400
Received: from foss.arm.com ([217.140.101.70]:34604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbeJDSEf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 14:04:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D05F7A9;
        Thu,  4 Oct 2018 04:11:48 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 590723F5A0;
        Thu,  4 Oct 2018 04:11:47 -0700 (PDT)
Date:   Thu, 4 Oct 2018 12:11:44 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: PCI: exit with error code when test fails
Message-ID: <20181004111144.GC5233@e107981-ln.cambridge.arm.com>
References: <1537455773-13470-1-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537455773-13470-1-git-send-email-jjhiblot@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 20, 2018 at 05:02:53PM +0200, Jean-Jacques Hiblot wrote:
> This makes it easier to use pcitest in automated setups.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> ---
>  tools/pci/pcitest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index af146bb..5adc8cd 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -143,6 +143,7 @@ static int run_test(struct pci_test *test)
>  	}
>  
>  	fflush(stdout);
> +	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
>  }
>  
>  int main(int argc, char **argv)
> @@ -231,6 +232,5 @@ int main(int argc, char **argv)
>  		return -EINVAL;
>  	}
>  
> -	run_test(test);
> -	return 0;
> +	return run_test(test);
>  }
> -- 
> 2.7.4
> 

Hi Kishon,

are you OK with this patch ? Please let me know.

Thanks,
Lorenzo
