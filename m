Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71EC282C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 18:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DF4222C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 18:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfBLSho (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:37:44 -0500
Received: from foss.arm.com ([217.140.101.70]:41984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfBLSho (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Feb 2019 13:37:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A345A78;
        Tue, 12 Feb 2019 10:37:44 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CB8F3F575;
        Tue, 12 Feb 2019 10:37:42 -0800 (PST)
Date:   Tue, 12 Feb 2019 18:37:39 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v2 2/2] PCI: iproc: Add PCIe 32bit outbound memory
 configuration
Message-ID: <20190212183739.GB918@e107981-ln.cambridge.arm.com>
References: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
 <1549342622-9929-3-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549342622-9929-3-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 05, 2019 at 10:27:01AM +0530, Srinath Mannam wrote:
> Add configuration to support IPROC PCIe host controller outbound memory
> window mapping with SOC address range inside 4GB boundary, which is 32 bit
> AXI address.

I do not understand what this means, explain it to me and rewrite the
commit log accordingly.

What does this solve ? Why do we need this patch or rephrased, what
is missing in the current driver ?

> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>

Review tags should be given on public mailing lists, these ones seem
to come from non-public review cycles in which case you must drop
them.

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

See above, I do not understand clearly what this means.

Lorenzo

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
