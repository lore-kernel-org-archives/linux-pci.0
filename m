Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C5C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C1D2184D
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548890768;
	bh=mvAz+amdws5MC1tgph7MS/eBb+N/Mm8eesy/VZGDaiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2J3BUU7YJW8U15W/od2qIHQJ2kzh4z/Cr7a2BMoslN/OWq6rXKHPl9yeSk1WfpPMB
	 vMtQkMiQyoepP+d/vnzNGMAlCMRsg8rA6vBRQZe2p7tMPS6AFRfbGY7T3NnIZivES9
	 +biLWDpH/Xn/dpw+NZTbdpXkz0fWDmAoBJKDicBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfA3X0H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3X0H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 18:26:07 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE7BC20882;
        Wed, 30 Jan 2019 23:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548890767;
        bh=mvAz+amdws5MC1tgph7MS/eBb+N/Mm8eesy/VZGDaiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acIOVvV6wdRY5o2E0nDQgRpYtQam4Y9LeyH8sZYZ36Wjy1Eaw+LC/das6RmDUOQzp
         Q0p04sFX76Vejq08T6KMCIpYHXhWDnK6GkN9H4q9AdXKNvGdjmju4O+p5dpyGL9KUu
         Oqdu7HvdH6HLY3X26zOsFPQB5BbjPsrvrvqK980Y=
Date:   Wed, 30 Jan 2019 17:26:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan =?iso-8859-1?Q?M=E4tje?= <stefan.maetje@esd.eu>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/ASPM: Add a fix for an erratum of the
 PI7C9X111SLB PCI-to-PCIe bridge
Message-ID: <20190130232605.GN229773@google.com>
References: <20181101192229.48352-1-stefan.maetje@esd.eu>
 <20181101192229.48352-2-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181101192229.48352-2-stefan.maetje@esd.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stefan,

On Thu, Nov 01, 2018 at 08:22:29PM +0100, Stefan Mätje wrote:
> Due to an erratum in the Pericom PI7C9X111SLB bridge in reverse mode the
> retrain link bit needs to be cleared again manually to allow the link
> training to succeed.
> 
> If it is not cleared manually the link training is continuously restarted
> and all devices below the PCI-to-PCIe bridge can't be accessed any more.
> That means drivers for devices below the bridge will be loaded but won't
> work or even crash because the driver is only reading 0xffff.
> 
> See also the Pericom Errata Sheet PI7C9X111SLB_errata_rev1.2_102711.pdf.

Is there a public URL for this?

Are there any bug reports for which you could include URLs?

> Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
> ---
>  drivers/pci/pcie/aspm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 5326916715d2..89a245023aa9 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -268,6 +268,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  	/* Retrain link */
>  	reg16 |= PCI_EXP_LNKCTL_RL;
>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> +	if (0x12d8 == parent->vendor && 0xe111 == parent->device) {
> +		/*
> +		 * Due to an erratum in the Pericom PI7C9X111SLB bridge in
> +		 * reverse mode the retrain link bit needs to be cleared
> +		 * again manually to allow the link training to succeed.
> +		 */
> +		reg16 &= ~PCI_EXP_LNKCTL_RL;
> +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);

There's no timing constraint, e.g., PCI_EXP_LNKCTL_RL doesn't have to be
maintained for some minimum time before being cleared?

> +	}

Sinan suggested a quirk, which I think is a good idea.  Possible
implementation:

  - add a pcie_retrain_link() interface (internal to PCI core, maybe even
    internal to aspm.c)
  - call pcie_retrain_link() from pcie_aspm_configure_common_clock()
  - add a pci_dev.clear_retrain_link:1 bit
  - set the bit in a quirk
  - test the bit in pcie_retrain_link()

>  	/* Wait for link training end. Break out after waiting for timeout */
>  	start_jiffies = jiffies;
> -- 
> 2.15.0
> 
