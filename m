Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB17FC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 19:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FC02183F
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655089;
	bh=YffvMbEGhoruT6GnoPlQiNrwPjeurAJ66lZSInC2jnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sV5GGvpd0v9n5DtSNaB9LYSMnhg9bTdzV84m0DzgaGDNdacpjy1p35Y2PNpuXbGYm
	 0LBNyFQzrp0Te8zhcbuw+QXx1BsSpXRnACPSqYDUiSaqmRdL0D7zj6d7MeuzzW87QE
	 UPUeiCHued2misBmk/sJB+nPWIs7cD4yjoBMz/jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBHTos (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHTos (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 14:44:48 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514EA207E0;
        Fri,  8 Feb 2019 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655087;
        bh=YffvMbEGhoruT6GnoPlQiNrwPjeurAJ66lZSInC2jnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acY2bOD2Ez532pUzGiQeQ1HFQ4XLDV/HJukWkrfaohpSzyFrr+vYKGD175ITLTJtX
         PQbDFJS65jn7eu7cQHzyaiTGftaA9S02Qk9jv1hSynw7WGx90BFhU44bHnXT3Xbk/H
         nOY/30DgohF1A+ycl1sChPgQwn+UOnNwMYCJP0O0=
Date:   Fri, 8 Feb 2019 13:44:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] genirq/msi: Clean up usage of __u8/__u16 types
Message-ID: <20190208194444.GW7268@google.com>
References: <20190208165439.19503-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208165439.19503-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc, Thomas]

On Fri, Feb 08, 2019 at 09:54:38AM -0700, Logan Gunthorpe wrote:
> The double underscore types are meant for compatibility in userspace
> headers which does not apply here. Therefore, change to use the
> standard no-underscore types.
> 
> The origin of the double underscore types dates back to before the
> git era so I was not able to find a commit to see the original
> justification.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>

I applied both of these:

  PCI: Clean up usage of __u32 type
  genirq/msi: Clean up usage of __u8/__u16 types

to pci/misc for v5.1, thanks!

> ---
>  include/linux/msi.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 784fb52b9900..7e9b81c3b50d 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -83,12 +83,12 @@ struct msi_desc {
>  		struct {
>  			u32 masked;
>  			struct {
> -				__u8	is_msix		: 1;
> -				__u8	multiple	: 3;
> -				__u8	multi_cap	: 3;
> -				__u8	maskbit		: 1;
> -				__u8	is_64		: 1;
> -				__u16	entry_nr;
> +				u8	is_msix		: 1;
> +				u8	multiple	: 3;
> +				u8	multi_cap	: 3;
> +				u8	maskbit		: 1;
> +				u8	is_64		: 1;
> +				u16	entry_nr;
>  				unsigned default_irq;
>  			} msi_attrib;
>  			union {
> -- 
> 2.19.0
> 
