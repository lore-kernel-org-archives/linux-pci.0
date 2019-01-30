Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D7CC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971CC2087F
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548875826;
	bh=RSqNR6h5oLBNDN1hnnJQbktDRKcM1d5/tzsdeSiYtAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S65mwbK7pjkwHKqiHN/K2mMlI2jmCrx1RZKIfK8ZOxK57UsY9uoMOyDeChh+eOb2N
	 FXWglT/82Gza4DeNnmA90P/W/QcVr6ND3NO1i6iMlGCvXjx8BfzilfUTYz0oHiDp0G
	 lABsZ0g9b7hhavZH81TLjs8EPqsZutNSRA0tg0T8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbfA3TRF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:17:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbfA3TRF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 14:17:05 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D762087F;
        Wed, 30 Jan 2019 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548875825;
        bh=RSqNR6h5oLBNDN1hnnJQbktDRKcM1d5/tzsdeSiYtAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0DZyBb6R+ldObc1NEMBnYf78tFDAurOCfpYdePFWZ3FYavFXjGrVhZuwtSW32+WgO
         t5sCgaCSv4E0N+FEHYC8Ke9CGtX6HRcrmVK4P82VgHWxZz4ZwQLTR555ijXv+U3mPc
         KdElKCgd38iUeWHG0HhtuDpPsB+hAOt++koB22Pg=
Date:   Wed, 30 Jan 2019 13:17:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: make pci_set_mwi a dummy for PCIe devices
Message-ID: <20190130191702.GI229773@google.com>
References: <0599e4ea-55ce-9aba-d5af-1625a3db0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0599e4ea-55ce-9aba-d5af-1625a3db0701@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 21, 2018 at 05:06:58PM +0200, Heiner Kallweit wrote:
> Memory-Write-Invalidate isn't applicable for PCIe devices, therefore
> make the MWI functions a dummy and don't even write to the (dummy)
> PCI config space registers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d068f11d0..fb63b3d89 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4137,6 +4137,9 @@ int pci_set_mwi(struct pci_dev *dev)
>  	int rc;
>  	u16 cmd;
>  
> +	if (pci_is_pcie(dev))
> +		return 0;

I don't think this works quite right for the case of a
PCIe-to-PCI/PCI-X bridge.  That is a PCIe device (it has a PCIe
Capability, and pci_is_pcie() should return true), but the MWI bit is
writable and meaningful (it controls whether the bridge can convert a
PCIe Memory Write into a PCI Memory Write and Invalidate), so I don't
think it would be correct to just skip this.

I'm looking at the "PCI EXPRESS TO PCI/PCI-X BRIDGE" spec, r1.0, sec
5.1.1.1.

>  	rc = pci_set_cacheline_size(dev);
>  	if (rc)
>  		return rc;
> @@ -4203,6 +4206,9 @@ void pci_clear_mwi(struct pci_dev *dev)
>  #ifndef PCI_DISABLE_MWI
>  	u16 cmd;
>  
> +	if (pci_is_pcie(dev))
> +		return;
> +
>  	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>  	if (cmd & PCI_COMMAND_INVALIDATE) {
>  		cmd &= ~PCI_COMMAND_INVALIDATE;
> -- 
> 2.19.1
> 
