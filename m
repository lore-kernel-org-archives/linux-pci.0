Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934780AbcKJV2l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2016 16:28:41 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAALOXjH012520
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2016 16:28:41 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26mwc6p6xx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2016 16:28:40 -0500
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
        Fri, 11 Nov 2016 07:28:38 +1000
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        devicetree@vger.kernel.org
Cc: linux-pci@vger.kernel.org, robh+dt@kernel.org,
        linuxppc-dev@lists.ozlabs.org, frowand.list@gmail.com
Date: Fri, 11 Nov 2016 08:28:32 +1100
In-Reply-To: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1478813312.2592.0.camel@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-11-09 at 12:05 -0200, Guilherme G. Piccoli wrote:
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 393fea8..1ad6882 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -275,7 +275,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>         of_node_put(ipar);
>         of_node_put(newpar);
>  
> -       return -EINVAL;
> +       /* Positive non-zero return means no Level-triggered Interrupts
> +        * capability was found.
> +        */
> +       return ENOENT;
>  }
>  EXPORT_SYMBOL_GPL(of_irq_parse_raw);

I'm not fan. I'd rather it's -ENOENT and the callers can check for that
specific code rather than playing with the sign.

Cheers,
Ben.

