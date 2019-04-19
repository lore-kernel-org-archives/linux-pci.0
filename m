Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB69C282E0
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5148204EC
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698831;
	bh=wjLxxB5l4HPOlZ5iGy1ErBKxzKL612cViRET3Ntm12o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jXbu+nDu8EBtBFhyivpTMQWVZXnC3K1k1rZjxG8F4vJeuT67pwxmts9z4IO5rTpi+
	 /cLhtCVEYgC7ZzRngJAUKanxXsvvLm+eTkbyPlbgG5yBox+0aovTS/KkgOWCmPh5b9
	 3CEXYbTUMStu6g8CjvM1QwrxCpNzHvyYAJWoEdSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfDSSdu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbfDSS3Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DFD222B2;
        Fri, 19 Apr 2019 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555681547;
        bh=wjLxxB5l4HPOlZ5iGy1ErBKxzKL612cViRET3Ntm12o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRbY3koYVO9an7FvkcRwuYMsxM9TgAttrsrZwvjXqpVvUEt4sqU4p+ZQr14nTkieA
         4WmabO1cWVLON+NanzrOdE0zsT1DVz07emyJyJKxjzIeOfnAQB8a1l6cgazaG1DMsc
         w+m6qakCoGyCgteDQAA38ojTy5zBR24+aFRZyDcM=
Date:   Fri, 19 Apr 2019 08:45:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Prestwood <james.prestwood@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: quirks: add vendor ID for AR9462 card
Message-ID: <20190419134545.GB173520@google.com>
References: <20190107213248.3034-1-james.prestwood@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107213248.3034-1-james.prestwood@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 07, 2019 at 01:32:48PM -0800, James Prestwood wrote:
> This card has similar issues with bus reset as the others present in
> this list.
> 
> Signed-off-by: James Prestwood <james.prestwood@linux.intel.com>

Alex, I'm inclined to apply this unless you object because it's
basically one more of something we already do.  I wish we didn't have
this quirk at all, but I don't know what else to do.

Maybe there's someplace we could add a printk so dmesg contains a clue
that we can't reset the device?  I assume this quirk means we can't
reset the device when we otherwise would, so maybe that means this
device will leak state from one VM to another?  That sounds like
something we would want to surface somehow if we don't already.

Bjorn

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ef7143a274e0..d9d4a95b0309 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3379,6 +3379,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
>  
>  /*
>   * Root port on some Cavium CN8xxx chips do not successfully complete a bus
> -- 
> 2.17.1
> 
