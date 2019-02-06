Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E9CC169C4
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 23:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C095218EA
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549495347;
	bh=UloytMSnbfJNz17cM6JwLKB/gsLA/IYVnQpQckIoZ84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TWqx7bsEOwgaqaOdHO15AiR3pCIa/EvBfAx3cbzDkUxgvqqKfQ587mMnHDcOyAP+e
	 IWpzKZc5274Wi9CHzSWIEKVADetcLfU1ABCKCHe+FGFiy2HQkzh6FDjHq3wqDmQqlI
	 x31XgwBZRk+8cw0STPYV1Jq1Qu43APxquzKkhXls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfBFXW0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfBFXW0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Feb 2019 18:22:26 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02C60218B0;
        Wed,  6 Feb 2019 23:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549495345;
        bh=UloytMSnbfJNz17cM6JwLKB/gsLA/IYVnQpQckIoZ84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HL1Z2AIGaShWoKaj0/0AcbFHvTR5ggAXSskeTTXd/XFDf/bhc2Dz6vDXvsPe3XVHP
         UCZvmO7sbGsIMnFGXVMph9bKWXbsLKy86YYZr7HTXzLCwDScpj299CaGGQITmQGhht
         azzSoYaYFOOCU4nHvBnYy0HcANg8rTZLCKj3/jXA=
Date:   Wed, 6 Feb 2019 17:22:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "Lukas F.Hartmann" <lukas@mntmn.com>,
        Trent Piepho <tpiepho@impinj.com>,
        John Youn <john.youn@synopsys.com>
Subject: Re: [PATCH RESEND] PCI: Check for USB xHCI class for HAPS platform
Message-ID: <20190206232223.GF7268@google.com>
References: <a28cfcee61f0842efe114c97b566bb3d967ba3d3.1549326366.git.thinhn@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28cfcee61f0842efe114c97b566bb3d967ba3d3.1549326366.git.thinhn@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 05, 2019 at 01:04:28PM -0800, Thinh Nguyen wrote:
> The Synopsys HAPS USB controller has a VID PID (16c3,abcd) that matches
> to an existing PCIe controller. This quirk is intended for USB HAPS
> devices only. To fix this, check for the PCI class USB xHCI to prevent
> matching the PCIe controllers.
> 
> Fixes: 03e6742584af ("PCI: Override Synopsys USB 3.x HAPS device class")
> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>

I applied this as below to for-linus for v5.0, thanks!

I *suspect* that this pending patch [1] would make the Root Ports work
correctly as bridges even if they had the wrong class code, e.g., if
we didn't have this fix to the quirk.

But the portdrv wouldn't claim the Root Ports, so PCIe services still
wouldn't work correctly, so we absolutely still need this patch.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=b2fb5cc57469

> ---
>  drivers/pci/quirks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0a413f3f7ca..e2a879e93d86 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -639,8 +639,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
>  		break;
>  	}
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> -			 quirk_synopsys_haps);
> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> +			       PCI_CLASS_SERIAL_USB_XHCI, 0,
> +			       quirk_synopsys_haps);
>  
>  /*
>   * Let's make the southbridge information explicit instead of having to

commit f57a98e1b71357713e44c57268a53d9c803f0626
Author: Thinh Nguyen <thinh.nguyen@synopsys.com>
Date:   Wed Feb 6 17:17:27 2019 -0600

    PCI: Work around Synopsys duplicate Device ID (HAPS USB3, NXP i.MX)
    
    There are at least four different parts with the same Vendor and Device
    ID ([16c3:abcd]):
    
      1) Synopsys HAPS USB3 controller
      2) Synopsys PCIe Root Port in Freescale/NXP i.MX6Q (reported by Lucas)
      3) Synopsys PCIe Root Port in Freescale/NXP i.MX6QP (reported by Lukas)
      4) Synopsys PCIe Root Port in Freescale/NXP i.MX7D (reported by Trent)
    
    The HAPS USB3 controller has a Class Code of PCI_CLASS_SERIAL_USB_XHCI,
    which means the XHCI driver would normally claim it.  Previously,
    quirk_synopsys_haps() changed the Class Code of all [16c3:abcd] devices,
    including the Root Ports, to PCI_CLASS_SERIAL_USB_DEVICE to prevent the
    XHCI driver from claiming them so dwc3-haps can claim them instead.
    
    Changing the Class Code of the Root Ports prevents the PCI core from
    handling them as bridges, so devices below them don't work.
    
    Restrict the quirk so it only changes the Class Code for devices that start
    with the PCI_CLASS_SERIAL_USB_XHCI Class Code, leaving the Root Ports
    alone.
    
    Fixes: 03e6742584af ("PCI: Override Synopsys USB 3.x HAPS device class")
    Reported-by: Lukas F. Hartmann <lukas@mntmn.com>
    Reported-by: Trent Piepho <tpiepho@impinj.com>
    Reported-by: Lucas Stach <l.stach@pengutronix.de>
    Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b0a413f3f7ca..e2a879e93d86 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -639,8 +639,9 @@ static void quirk_synopsys_haps(struct pci_dev *pdev)
 		break;
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
-			 quirk_synopsys_haps);
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
+			       PCI_CLASS_SERIAL_USB_XHCI, 0,
+			       quirk_synopsys_haps);
 
 /*
  * Let's make the southbridge information explicit instead of having to
