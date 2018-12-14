Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618C8C43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 17:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E19206E0
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544809023;
	bh=uS4FOfupJ3N5V32Gc9tDOTHOpl6Gtpm4zCVkokL6+8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QMAtq+S5a6ZGjJ7xX84e0DKiMOCon2g/oDXrPsoi8ZVxbrWQxXt9qimGQGz/oYxtU
	 KdW2DXDWyf+CUX/36z7K3tFl5kLY+XgsNTzN9KBS2lw2feKy7xn8mmbgrZlA6PmnPB
	 +tillvzOtQ7ZbkLwCcXYWKabJUja0lyDy0KrvaW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbeLNRhB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:37:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbeLNRhB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 12:37:01 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49658206C0;
        Fri, 14 Dec 2018 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544809021;
        bh=uS4FOfupJ3N5V32Gc9tDOTHOpl6Gtpm4zCVkokL6+8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Blvvmt3BWGQ1W3SV0R9HAVyCJVZWjKYJnNOU5FmZllMIJnFvGqBWeDP9AtaTkeDLi
         U+Z53blD156yEbm0PudPmUsskS1yatBvNcKFuLy/SqOGS2kCgnan9v2sIQa+3IxMmv
         2AwsY2xqsfwrhQl4eAdjCIPCYw9LNYRrwGleGOHQ=
Date:   Fri, 14 Dec 2018 11:36:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
Cc:     keith.busch@intel.com, yu.zheng@hxt-semitech.com,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        jinyanjiang@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: only insert one element into kfifo
Message-ID: <20181214173658.GB20725@google.com>
References: <1544603550-14208-1-git-send-email-yanjiang.jin@hxt-semitech.com>
 <1544603550-14208-2-git-send-email-yanjiang.jin@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544603550-14208-2-git-send-email-yanjiang.jin@hxt-semitech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 12, 2018 at 04:32:30PM +0800, Yanjiang Jin wrote:
> 'commit ecae65e133f2 ("PCI/AER: Use kfifo_in_spinlocked() to
> insert locked elements")' replace kfifo_put() with kfifo_in_spinlocked().
> 
> But as "kfifo_in(fifo, buf, n)" describes:
> " * @n: number of elements to be added".
> 
> We want to insert only one element into kfifo, not "sizeof(entry) = 16".
> Without this patch, we would get 15 uninitialized elements.
> 
> Signed-off-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>

Since this fixes ecae65e133f2, which was applied for v4.20, I applied
this with Keith's reviewed-by to for-linus so we can get it into
v4.20.

For some reason the patch didn't apply, but I can't see why, so I
just applied it by hand.

Thanks!

> ---
>  drivers/pci/pcie/aer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a90a919..fed29de 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1064,7 +1064,7 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>                 .regs           = aer_regs,
>         };
> 
> -       if (kfifo_in_spinlocked(&aer_recover_ring, &entry, sizeof(entry),
> +       if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
>                                  &aer_recover_ring_lock))
>                 schedule_work(&aer_recover_work);
>         else
> --
> 1.8.3.1
> 
> 
> 
> 
> This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
> 
> 
