Return-Path: <SRS0=HNSb=UT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342FAC43613
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F5420657
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 21:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561066684;
	bh=TNmYr6CvvNadt0CrFEbwkNnYFLKwnqfGdwLIPynMFJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YJiTbTp0XeInV9v/cDNCjtdnhqFM6l1AqImA4tXo1gdjj8ya+jUaEn8W2tsDolcZ1
	 drL9Xmvi4eEAOSWGnTAhPKuLaKuVkYzLLsAlIxfPp+9/KzPBIYOoj47unJSHt4uR75
	 5BBBKt4D4fF75FupZyxzKFEqo0qsJgpJETXIjNGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfFTVh6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfFTVh5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 17:37:57 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997182084A;
        Thu, 20 Jun 2019 21:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561066676;
        bh=TNmYr6CvvNadt0CrFEbwkNnYFLKwnqfGdwLIPynMFJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xbcxdOGjQwdd+KsHTxdBW/6Mn4LrjOJDdcATrKHeCYZWK4QU9SvwHmaUEW8iDYuOj
         aE7c0meBbMgEWfTvPeK7Y2ALcZ21grwNmQ3xkeLbXc1x4qw1MzX1vqgPieLpbAS+3P
         ZtFEOyxnCTr1JHxQuwZJ62AqkPYy4FnjrUuK2E+A=
Date:   Thu, 20 Jun 2019 16:37:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/3] net: fddi: skfp: Include generic PCI definitions
Message-ID: <20190620213755.GE110859@google.com>
References: <20190620180754.15413-1-puranjay12@gmail.com>
 <20190620180754.15413-3-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620180754.15413-3-puranjay12@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 11:37:53PM +0530, Puranjay Mohan wrote:
> Include the uapi/linux/pci_regs.h header file which contains the generic
> PCI defines.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  drivers/net/fddi/skfp/drvfbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/fddi/skfp/drvfbi.c b/drivers/net/fddi/skfp/drvfbi.c
> index b324c1acf195..e8245cb281f8 100644
> --- a/drivers/net/fddi/skfp/drvfbi.c
> +++ b/drivers/net/fddi/skfp/drvfbi.c
> @@ -20,7 +20,7 @@
>  #include "h/supern_2.h"
>  #include "h/skfbiinc.h"
>  #include <linux/bitrev.h>
> -
> +#include <linux/pci_regs.h>

You removed the blank line between the list of include files and the
SCCS ID (now there's an anachronism) below.  That blank line is part
of typical Linux style and you should keep it.

>  #ifndef	lint
>  static const char ID_sccs[] = "@(#)drvfbi.c	1.63 99/02/11 (C) SK " ;
>  #endif
> -- 
> 2.21.0
> 
