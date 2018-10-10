Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C0CC43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 21:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738AD2087A
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 21:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M88PIM4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738AD2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeJKEcX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJKEcX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 00:32:23 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73FF62082B;
        Wed, 10 Oct 2018 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539205706;
        bh=EbbPnHd+FNx/v+CiaQubFQdgDt3Vct3JYAl2r/Qoc7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M88PIM4kGFXgkWGTuo3L6ffFbZ3HCRgmeMZ9e5gdZezMESMvmbhTFd9SEwQ5Eee9x
         jvGD3WvbE6Tx1YArr/BdF9RKNSGuw//0fktjqphyBRPNBezG6qjyWBPIzhppAxJJvV
         oVejvWKdfDMynosO54Fl6ybjmYcJLYO4cM5VfSsA=
Date:   Wed, 10 Oct 2018 16:08:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Doug Meyer <dmeyer@gigaio.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: Re: [PATCH v2] PCI: Fix Switchtec DMA aliasing quirk dmesg noise
Message-ID: <20181010210825.GK5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181005154940.964-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005154940.964-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 05, 2018 at 09:49:40AM -0600, Logan Gunthorpe wrote:
> Currently the Switchtec quirk runs on all endpoints in the Switch
> which includes all the upstream and downstream ports. Seeing these
> other functions do not contain BARs the quirk fails when trying to
> map the BAR and prints the error "Cannot iomap Switchtec device".
> The user will see a few of these useless and scary errors, one for
> each port in the switch.
> 
> At most, the quirk should only run on either a management endpoint
> (class=PCI_CLASS_MEMORY_OTHER) or an NTB endpoint
> (PCI_CLASS_BRIDGE_OTHER). However, seeing the quirk is useless except
> in NTB applications, we will only run it when the class is
> PCI_CLASS_BRIDGE_OTHER.
> 
> Thus, switch to using DECLARE_PCI_FIXUP_CLASS_FINAL and clean up
> the list with a define (so we don't have to change as much code if
> we ever have to adjust the list).
> 
> Reported-by: Stephen  Bates <sbates@raithlin.com>
> Cc: Doug Meyer <dmeyer@gigaio.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> Fixes: ad281ecf1c7d ("PCI: Add DMA alias quirk for Microsemi Switchtec NTB")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied to pci/misc for v4.20, thanks!

I split this into two patches so the important change doesn't get lost in
the noise of the SWITCHTEC_QUIRK() addition:

  - Add the SWITCHTEC_QUIRK() macro, but don't change anything else
  - Change SWITCHTEC_QUIRK() to use DECLARE_PCI_FIXUP_CLASS_FINAL

> ---
> 
> * v2: Changes comment style, per feedback from Christoph
> 
>  drivers/pci/quirks.c | 90 +++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6bc27b7fd452..0f072aed30f5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5057,59 +5057,37 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
>  	pci_iounmap(pdev, mmio);
>  	pci_disable_device(pdev);
>  }
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8531,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8532,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8533,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8534,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8535,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8536,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8543,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8544,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8545,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8546,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8551,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8552,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8553,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8554,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8555,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8556,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8561,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8562,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8563,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8564,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8565,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8566,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8571,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8572,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8573,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8574,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8575,
> -			quirk_switchtec_ntb_dma_alias);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8576,
> -			quirk_switchtec_ntb_dma_alias);
> +
> +#define SWITCHTEC_QUIRK(vid) \
> +	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI, vid, \
> +		PCI_CLASS_BRIDGE_OTHER, 8, quirk_switchtec_ntb_dma_alias)
> +SWITCHTEC_QUIRK(0x8531);  /* PFX 24xG3 */
> +SWITCHTEC_QUIRK(0x8532);  /* PFX 32xG3 */
> +SWITCHTEC_QUIRK(0x8533);  /* PFX 48xG3 */
> +SWITCHTEC_QUIRK(0x8534);  /* PFX 64xG3 */
> +SWITCHTEC_QUIRK(0x8535);  /* PFX 80xG3 */
> +SWITCHTEC_QUIRK(0x8536);  /* PFX 96xG3 */
> +SWITCHTEC_QUIRK(0x8541);  /* PSX 24xG3 */
> +SWITCHTEC_QUIRK(0x8542);  /* PSX 32xG3 */
> +SWITCHTEC_QUIRK(0x8543);  /* PSX 48xG3 */
> +SWITCHTEC_QUIRK(0x8544);  /* PSX 64xG3 */
> +SWITCHTEC_QUIRK(0x8545);  /* PSX 80xG3 */
> +SWITCHTEC_QUIRK(0x8546);  /* PSX 96xG3 */
> +SWITCHTEC_QUIRK(0x8551);  /* PAX 24XG3 */
> +SWITCHTEC_QUIRK(0x8552);  /* PAX 32XG3 */
> +SWITCHTEC_QUIRK(0x8553);  /* PAX 48XG3 */
> +SWITCHTEC_QUIRK(0x8554);  /* PAX 64XG3 */
> +SWITCHTEC_QUIRK(0x8555);  /* PAX 80XG3 */
> +SWITCHTEC_QUIRK(0x8556);  /* PAX 96XG3 */
> +SWITCHTEC_QUIRK(0x8561);  /* PFXL 24XG3 */
> +SWITCHTEC_QUIRK(0x8562);  /* PFXL 32XG3 */
> +SWITCHTEC_QUIRK(0x8563);  /* PFXL 48XG3 */
> +SWITCHTEC_QUIRK(0x8564);  /* PFXL 64XG3 */
> +SWITCHTEC_QUIRK(0x8565);  /* PFXL 80XG3 */
> +SWITCHTEC_QUIRK(0x8566);  /* PFXL 96XG3 */
> +SWITCHTEC_QUIRK(0x8571);  /* PFXI 24XG3 */
> +SWITCHTEC_QUIRK(0x8572);  /* PFXI 32XG3 */
> +SWITCHTEC_QUIRK(0x8573);  /* PFXI 48XG3 */
> +SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
> +SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
> +SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> --
> 2.19.0
