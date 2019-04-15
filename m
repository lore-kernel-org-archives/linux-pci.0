Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA7C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933E320880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555336097;
	bh=Kg/VpIt2a6LIFyIdCIQYSJdaca7BkWipRaGqnxauwKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l80pCIpkQ9V5yCzIN3FU5IZdZBECXU/pzh6zsxKtvmDLZ2Ka6Rngvu60OBgxZgcZq
	 /V2nWum+feJ7Y4bYCEUwcAAfw+elG6FRZezQIe/YASntts8vncA/LInvHsaTuZvwZA
	 fSPLzqa2LhdCrUg4hw8zHwT8b7vFu/SwJG738r3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfDONsQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDONsQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 09:48:16 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1961A2073F;
        Mon, 15 Apr 2019 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555336095;
        bh=Kg/VpIt2a6LIFyIdCIQYSJdaca7BkWipRaGqnxauwKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jG015aOQvAIkoMYnJtQPukdWzu9gIsDBEI8CHCNBoVUUXRwBjfy4791Q5tI6cON3g
         ppXoxFp8S6PKPrNqK2cwQW8qV42DYnx+yissd+5KjmYfgkFfEbqwapYxszJnEGDMK0
         h4JzvWgDOQxmvFOyisFdgM9V+zTsh1/Nx+RNiZaI=
Date:   Mon, 15 Apr 2019 08:48:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicolas Chauvet <kwizart@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: disable nv_msi_ht_cap_quirk_leaf quirk on arm/arm64
Message-ID: <20190415134813.GA111421@google.com>
References: <20180730094213.11973-1-kwizart@gmail.com>
 <20190415092537.14305-1-kwizart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415092537.14305-1-kwizart@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 11:25:37AM +0200, Nicolas Chauvet wrote:
> This patch disable the use of nv_msi_ht_cap_quirk_leaf quirk on arm and
> arm64 NVIDIA devices such as Tegra
> 
> This fixes the following output:
> "pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge"
> as experienced on a Trimslice device with PCI host bridge enabled
> 
> v3: exclude the quirk for arm and arm64 instead of only for x86
> 
> v2: use __maybe_unused to avoid a warning on nv_msi_ht_cap_quirk_leaf
> 
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/quirks.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a59ad09ce911..1ac65f09d7ee 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2811,12 +2811,15 @@ static void nv_msi_ht_cap_quirk_all(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
>  
> -static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
> +static void __maybe_unused nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
>  {
>  	return __nv_msi_ht_cap_quirk(dev, 0);
>  }
> +/* HyperTransport is not relevant on theses arches */
> +#if !IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)

I don't see any of the previous versions or discussion on the list, so
I can't tell what led to this #ifdef, but I'd prefer to avoid #ifdefs
like this because they're checking for arch at the wrong level.

If you're seeing that warning message, apparently your system contains
an Nvidia device that has an HT_CAPTYPE_MSI_MAPPING capability, so
HyperTransport is at least in the picture, even on arm/arm64.

The quirk assumes a host bridge at 00:00.0, which is really a
device-specific assumption, or maybe something specific to
HyperTransport.  It's certainly not required by the PCI specs, which
don't require a host bridge to be visible as a PCI device at all.

I'd be tempted to just change that pci_warn() to a pci_info() or maybe
even remove it altogether.  It would be nice to have the complete
"lspci -vv" and dmesg log archived for future reference, since this
quirk has such a broad reach (matching PCI_ANY_ID) and it has a long
and ugly history already.

>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
> +#endif
>  
>  static void quirk_msi_intx_disable_bug(struct pci_dev *dev)
>  {
> -- 
> 2.17.2
> 
