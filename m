Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A1FC433EF
	for <linux-pci@archiver.kernel.org>; Tue, 28 Jun 2022 23:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiF1XiX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 28 Jun 2022 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiF1XiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 19:38:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12946163
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 16:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23037CE235B
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBE1C341C8;
        Tue, 28 Jun 2022 23:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656459497;
        bh=P6VLB+NJ7IqQlRt40SiMu+3VXA+TVVqq0lc6DeEsv0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sO0xZDz+nR3uAvTM2p2nmbcf1H3DUY73eEVY7Do3tffvimbKUR6nXYcOXTiucvbex
         iy0Z/fGJ8HrpCMneJ+VKN7NJN/vVLJ73oYbVHFv3YVXVZ0Kf6EZw9uopDh0WZ/nXJ6
         wJv90Rl7Y1kmp7B23uPb4fzXvcBijoy5ifLg5cuHPLG1SqFFx3n6NaKzmYZVqc+9rZ
         Hp3Y5i3SzR2gFRs7nPokAcAgDwGhtCwNWPXYawsJJIsk/UkHNk1IXDCFUTJ0pXWqlW
         AheWqsQy0dgR6gBl5z0d4axtYeKbFxkxLCVlnw02PdTpqvGMDr6eHbIHAQztYZ6fci
         Z0Ydpm4B3+3yA==
Date:   Tue, 28 Jun 2022 18:38:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        dan.j.williams@intel.com, linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Add DID 8086:7D0B and 8086:AD0B for Intel MTL
 SKU's
Message-ID: <20220628233815.GA1884459@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628221023.190547-1-francisco.munoz.ruiz@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 03:10:23PM -0700, Francisco Munoz wrote:
> Add support for VMD devices in MTL-H/P/U/S/M which support the bus
> restriction mode.
> The feature that turns off vector 0 for MSI-X remapping is also
> enabled.
> 
> Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

Applied to pci/ctrl/vmd for v5.20, thanks!

> ---
>  drivers/pci/controller/vmd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 94a14a3d7e55..36597bbbfceb 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -1013,6 +1013,14 @@ static const struct pci_device_id vmd_ids[] = {
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7d0b),
> +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xad0b),
> +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				VMD_FEAT_OFFSET_FIRST_VECTOR,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -- 
> 2.25.1
> 
