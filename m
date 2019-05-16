Return-Path: <SRS0=j3vk=TQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB0C04AAF
	for <linux-pci@archiver.kernel.org>; Thu, 16 May 2019 13:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706802087B
	for <linux-pci@archiver.kernel.org>; Thu, 16 May 2019 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558013290;
	bh=Zv6ZRln99gohm9loMinCpGMe8ABSvr0R7QAANxBD+kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y6J8Btf8U/EPcJSYs7dqFhpt1Y4QKsKpq4yqwaTMNrtLNBhRB6RmiqKMd01nxGeDZ
	 Xf733j/61IKgCJUZSHQchxPu9ExHgQZVYD/tWokmtNZNvWpE3rbcsUoVFDnLjMR0P9
	 URK+/3hU/uAro477xxgNJxIqVeAAoos5vM1YbKAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfEPN2J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 16 May 2019 09:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfEPN2J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 May 2019 09:28:09 -0400
Received: from localhost (50-82-73-190.client.mchsi.com [50.82.73.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7720C20815;
        Thu, 16 May 2019 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558013288;
        bh=Zv6ZRln99gohm9loMinCpGMe8ABSvr0R7QAANxBD+kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBfwdHcf4Po3DSORzgMh2uiY9Ul04pxKYbhMY/zaWlfmyGmYMrWktAkYMR3/g+Zl5
         QD+ntDpAEK1xbh69SJsqqUrJOze0M+lq5CE9k5BEH4i1YZ48kZLzEOp3Uq2M+X0e1Q
         by/MDglHyhTFkXEIUWDjKZbIxkpBNpeq0mzZ2ocE=
Date:   Thu, 16 May 2019 08:28:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
Message-ID: <20190516132807.GB101793@google.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513050626.14991-3-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 13, 2019 at 10:36:13AM +0530, Vidya Sagar wrote:
> Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
> using these APIs be able to build as loadable modules.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Nak, as-is.

1) The argument for why this is needed is unconvincing.  If device
advertises MSI support, we should be able to use it.

2) If it turns out we really need this, it should be some sort of
per-device setting rather than a global thing like this.

> ---
> Changes since [v5]:
> * Corrected inline implementation of pcie_pme_no_msi() API
> 
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * None
> 
> Changes since [v2]:
> * Exported pcie_pme_no_msi() API after making pcie_pme_msi_disabled a static
> 
> Changes since [v1]:
> * This is a new patch in v2 series
> 
>  drivers/pci/pcie/pme.c     | 14 +++++++++++++-
>  drivers/pci/pcie/portdrv.h | 14 ++------------
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 54d593d10396..d5e0ea4a62fc 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -25,7 +25,19 @@
>   * that using MSI for PCIe PME signaling doesn't play well with PCIe PME-based
>   * wake-up from system sleep states.
>   */
> -bool pcie_pme_msi_disabled;
> +static bool pcie_pme_msi_disabled;
> +
> +void pcie_pme_disable_msi(void)
> +{
> +	pcie_pme_msi_disabled = true;
> +}
> +EXPORT_SYMBOL_GPL(pcie_pme_disable_msi);
> +
> +bool pcie_pme_no_msi(void)
> +{
> +	return pcie_pme_msi_disabled;
> +}
> +EXPORT_SYMBOL_GPL(pcie_pme_no_msi);
>  
>  static int __init pcie_pme_setup(char *str)
>  {
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 944827a8c7d3..1d441fe26c51 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -129,18 +129,8 @@ void pcie_port_bus_unregister(void);
>  struct pci_dev;
>  
>  #ifdef CONFIG_PCIE_PME
> -extern bool pcie_pme_msi_disabled;
> -
> -static inline void pcie_pme_disable_msi(void)
> -{
> -	pcie_pme_msi_disabled = true;
> -}
> -
> -static inline bool pcie_pme_no_msi(void)
> -{
> -	return pcie_pme_msi_disabled;
> -}
> -
> +void pcie_pme_disable_msi(void);
> +bool pcie_pme_no_msi(void);
>  void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable);
>  #else /* !CONFIG_PCIE_PME */
>  static inline void pcie_pme_disable_msi(void) {}
> -- 
> 2.17.1
> 
