Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D9BC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 11:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048B32075C
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 11:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfCVLGx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:06:53 -0400
Received: from foss.arm.com ([217.140.101.70]:41874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfCVLGx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 07:06:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985AC374;
        Fri, 22 Mar 2019 04:06:52 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABD943F575;
        Fri, 22 Mar 2019 04:06:51 -0700 (PDT)
Date:   Fri, 22 Mar 2019 11:06:46 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     kishon@ti.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: PCI: exit with error code when test fails
Message-ID: <20190322110646.GA24257@e107981-ln.cambridge.arm.com>
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

Applied to pci/misc for v5.2, thanks.

Lorenzo

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
