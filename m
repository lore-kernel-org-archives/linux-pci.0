Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC99C677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC3D21477
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6ciO18+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC3D21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeJKXnr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbeJKXnq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 19:43:46 -0400
Received: from localhost (unknown [204.56.7.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4C220645;
        Thu, 11 Oct 2018 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539274552;
        bh=WnFoKXbtYE2scA49BODI+KOk4ZxkcOCPTx70CfRSIfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6ciO18+0hOVlUoimtzPkDZs+k2N/XO1Dj25wvWdnVK/n1m/CoZ8k351GLi8JPLwn
         xtaCxZB8UXA+N3y3+DMT970o72jdDuZOUC0aH9F72cRs9bDgeVwqsN8NbvXYj8jwqZ
         jliZ5l1g6gX50CtWlFh1iCpw+QnmKHQ5zVDXnP6M=
Date:   Thu, 11 Oct 2018 11:15:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thomas Jarosch <thomas.jarosch@intra2net.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] pci: Add a few new IDs for Intel GPU "spurious
 interrupt" quirk
Message-ID: <20181011161551.GO5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 08:14:01AM -0700, Bin Meng wrote:
> Add more PCI IDs to the Intel GPU "spurious interrupt" quirk table,
> which are known to break.
> 
> See commit f67fd55fa96f ("PCI: Add quirk for still enabled interrupts
> on Intel Sandy Bridge GPUs"), and commit 7c82126a94e6 ("PCI: Add new
> ID for Intel GPU "spurious interrupt" quirk") for some history.
> 
> Based on current findings, it is highly possible that all Intel
> 1st/2nd/3rd generation Core processors' IGD has such quirk.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Cc: <stable@vger.kernel.org> # v3.4+

Applied to pci/misc for v4.20.

I hope we can figure out a generic way to handle this for future
devices so we don't have to add any more IDs to this quirk.

> ---
> 
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6bc27b7..c0673a7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3190,7 +3190,11 @@ static void disable_igfx_irq(struct pci_dev *dev)
>  
>  	pci_iounmap(dev, regs);
>  }
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
>  
> -- 
> 2.7.4
> 
