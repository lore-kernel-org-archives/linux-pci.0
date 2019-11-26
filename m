Return-Path: <SRS0=NgYY=ZS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294B0C432C3
	for <linux-pci@archiver.kernel.org>; Tue, 26 Nov 2019 23:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30D320727
	for <linux-pci@archiver.kernel.org>; Tue, 26 Nov 2019 23:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574809527;
	bh=dn0v9Fz/heS543cgtZ4uNK2FFBYGphczhI3Q0Xshvnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=LESheGFwgYjKtkIqUpfKtB46dheI9Oimt/3xeXmbq3E4ewXwO7+9Ft+IdhkoWm0r6
	 4x+LSNzxx3SCIsTJhd8O3KFI03pKU9EVdqPE1DRqGadJbIeJE2VpcxCtIlGo7qtsMc
	 QDJMgZL2iA8uCz6zsMcGGZAoatBov1wzsQP5PFJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfKZXF0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Nov 2019 18:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKZXF0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 18:05:26 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9C820727;
        Tue, 26 Nov 2019 23:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574809525;
        bh=dn0v9Fz/heS543cgtZ4uNK2FFBYGphczhI3Q0Xshvnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iSFMNNXj3DQYX9p/96xbqUAJ6Hgm74pFooB9WLB4UlDOz6YMdSaP2CW46AyYfUW1i
         p++Jg7lp6sfRa9OSs91VX+JW7b3GEHnprxvML1zxAQY5Uc2pYE1YX3sT2azv52nPF6
         x9Ir1DguEmybWOxi4+XKfsbkSA6WCmDjBPblo/sI=
Date:   Tue, 26 Nov 2019 17:05:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, rjui@broadcom.com
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
Message-ID: <20191126230524.GA197236@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115135842.119621-1-wei.liu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 15, 2019 at 01:58:42PM +0000, Wei Liu wrote:
> CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
> in.  Removing the ifdef will allow us to build the driver as a module.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Sorry, I missed this thinking it would be under drivers/pci/controller
and hence handled by Lorenzo.

So I guess this doesn't fix a build problem, but without this patch,
we just don't run the quirk if the driver is a module, right?

> ---
> Alternatively, we can change the condition to:
> 
>   #ifdef CONFIG_PCIE_IPROC_PLATFORM || CONFIG_PCIE_IPROC_PLATFORM_MODULE
>
> I chose to remove the ifdef because that's what other quirks looked like
> in this file.
> ---
>  drivers/pci/quirks.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..cd0e7c18e717 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2381,7 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
>  			 PCI_DEVICE_ID_TIGON3_5719,
>  			 quirk_brcm_5719_limit_mrrs);
>  
> -#ifdef CONFIG_PCIE_IPROC_PLATFORM
>  static void quirk_paxc_bridge(struct pci_dev *pdev)
>  {
>  	/*
> @@ -2405,7 +2404,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> -#endif
>  
>  /*
>   * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
> -- 
> 2.24.0
> 
