Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89015C64EBD
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 21:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA33206B2
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 21:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cojvk/Ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA33206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeJCEJo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeJCEJo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Oct 2018 00:09:44 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE4020652;
        Tue,  2 Oct 2018 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538515463;
        bh=VALqT3VRwHTnUn4Ko3gpoHwc419cyYzKNs71GRKJtlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cojvk/JuulTEfwhbTwSadjBDRinh3NJ5NQBdcw4s8x5PaDe2zwyYFBwGapyoDL0Bh
         FNLaFBhERxmOMrqryA7CV7TN9jmGNHIE46rVldCWT1ncRKB7uFU0vcdFiB3YYBtnaY
         UxzTXEDPKa2W0yKR1QqejoosJR03hVkiXBrJpoE0=
Date:   Tue, 2 Oct 2018 16:24:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] x86/PCI: Apply VMD's AERSID fixup generically
Message-ID: <20181002212421.GE120535@bhelgaas-glaptop.roam.corp.google.com>
References: <1536348150-3535-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536348150-3535-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 07, 2018 at 01:22:30PM -0600, Jon Derrick wrote:
> A root port device-id changed between simulation and production. Rather
> than match device-ids which may not be future-proof if left
> unmaintained, match all root ports which exist in a VMD-domain
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

I applied this on pci/host-vmd for v4.20, thanks!

> ---
>  arch/x86/pci/fixup.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 13f4485..30a5111 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -629,17 +629,11 @@ static void quirk_apple_mbp_poweroff(struct pci_dev *pdev)
>  static void quirk_no_aersid(struct pci_dev *pdev)
>  {
>  	/* VMD Domain */
> -	if (is_vmd(pdev->bus))
> +	if (is_vmd(pdev->bus) && pci_is_root_bus(pdev->bus))
>  		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
>  }
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334a, quirk_no_aersid);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334b, quirk_no_aersid);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334c, quirk_no_aersid);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334d, quirk_no_aersid);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
>  
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  
> -- 
> 1.8.3.1
> 
