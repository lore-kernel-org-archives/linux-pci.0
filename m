Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D606BECE560
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9046621531
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 16:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ucgv35ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9046621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeIZXLO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbeIZXLO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 19:11:14 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D9621531;
        Wed, 26 Sep 2018 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537981042;
        bh=XeUQWtqRhYHhZN7bkClx8wCup4APVtIgIyW6VGvib9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ucgv35ffbKYyu0I33AJ1cXIn7byWu33jQQTK/iRVUaYvUh72mF6uyc06trB/YenFR
         HWtjhJhR5Exn0SC7qyn4wQsnvcCF8HlYnL/quHq2nLKNIx3uToo5tHLrsKGJ+X48lj
         VJvoQC0poNX/0ixUQXAjMxiAQm0xHxzsbZcwRFvg=
Date:   Wed, 26 Sep 2018 11:57:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thomas Jarosch <thomas.jarosch@intra2net.com>,
        stable <stable@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Add a few new IDs for Intel GPU "spurious
 interrupt" quirk
Message-ID: <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
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

[+cc Intel DRM maintainers, etc]

On Wed, Sep 26, 2018 at 08:14:01AM -0700, Bin Meng wrote:
> Add more PCI IDs to the Intel GPU "spurious interrupt" quirk table,
> which are known to break.

Do you have a reference for this?  Any public bug reports, bugzilla,
Intel spec reference or errata?  "Which are known to break" is pretty
vague.

> See commit f67fd55fa96f ("PCI: Add quirk for still enabled interrupts
> on Intel Sandy Bridge GPUs"), and commit 7c82126a94e6 ("PCI: Add new
> ID for Intel GPU "spurious interrupt" quirk") for some history.
> 
> Based on current findings, it is highly possible that all Intel
> 1st/2nd/3rd generation Core processors' IGD has such quirk.

Can you include a reference to these "current findings"?  I assume you
have bug reports that include the device IDs you're adding?  If not,
how did you build this list of new IDs?

The function comment added by f67fd55fa96f ("PCI: Add quirk for still
enabled interrupts on Intel Sandy Bridge GPUs") suggests that this is
actually a BIOS issue, not a hardware erratum, i.e., I don't see
anything there that suggests a hardware defect.

But there must be a hole somewhere -- the kernel can't be expected to
disable interrupts in device-specific ways when there's no driver
loaded.  Maybe it's simply a BIOS defect or maybe there's some
interrupt or _PRT-related setup we're missing.

> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Cc: <stable@vger.kernel.org> # v3.4+
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
