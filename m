Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF7C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94C3218D8
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 16:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfB1QNL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:13:11 -0500
Received: from foss.arm.com ([217.140.101.70]:51118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfB1QNK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Feb 2019 11:13:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FF41A78;
        Thu, 28 Feb 2019 08:13:10 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62F143F720;
        Thu, 28 Feb 2019 08:13:08 -0800 (PST)
Date:   Thu, 28 Feb 2019 16:13:03 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v3 2/2] PCI: iproc: Add outbound configuration for 32-bit
 I/O region
Message-ID: <20190228161303.GA23441@e107981-ln.cambridge.arm.com>
References: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
 <1550680435-9706-3-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550680435-9706-3-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 20, 2019 at 10:03:55PM +0530, Srinath Mannam wrote:
> In the present driver outbound window configuration is done to map above
> 32-bit address I/O regions with corresponding PCI memory range given in
> ranges DT property.
> 
> This patch add outbound window configuration to map below 32-bit I/O range
> with corresponding PCI memory, which helps to access I/O region in IA32

I think you mean ARM 32-bit here, not IA32.

> and one to one mapping of I/O region to PCI memory.
> 
> Ex:
> 1. ranges DT property given for current driver is,
>     ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
>     I/O region address is 0x400000000
> 2. ranges DT property can be given after this patch,
>     ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
>     I/O region address is 0x42000000
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>

I asked you before, please point me at mailing list discussions where
these review tags were given, v1 was already carrying them but that's
not how the process works, they have to be given on mailing lists.

Lorenzo

> ---
>  drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index b882255..080f142 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
>  			resource_size_t window_size =
>  				ob_map->window_sizes[size_idx] * SZ_1M;
>  
> -			if (size < window_size)
> -				continue;
> +			/*
> +			 * Keep iterating until we reach the last window and
> +			 * with the minimal window size at index zero. In this
> +			 * case, we take a compromise by mapping it using the
> +			 * minimum window size that can be supported
> +			 */
> +			if (size < window_size) {
> +				if (size_idx > 0 || window_idx > 0)
> +					continue;
> +
> +				/*
> +				 * For the corner case of reaching the minimal
> +				 * window size that can be supported on the
> +				 * last window
> +				 */
> +				axi_addr = ALIGN_DOWN(axi_addr, window_size);
> +				pci_addr = ALIGN_DOWN(pci_addr, window_size);
> +				size = window_size;
> +			}
>  
>  			if (!IS_ALIGNED(axi_addr, window_size) ||
>  			    !IS_ALIGNED(pci_addr, window_size)) {
> -- 
> 2.7.4
> 
