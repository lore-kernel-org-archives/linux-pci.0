Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B298C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 11:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561A221850
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 11:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfDRLUg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:20:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59758 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfDRLUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 07:20:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F0380D;
        Thu, 18 Apr 2019 04:20:35 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 263683F59C;
        Thu, 18 Apr 2019 04:20:33 -0700 (PDT)
Date:   Thu, 18 Apr 2019 12:20:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     will.deacon@arm.com, bhelgaas@google.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        okaya@kernel.org, zhongmiao@hisilicon.com, eric.auger@redhat.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/9] ACPI/IORT: Check ATS capability in root complex
 nodes
Message-ID: <20190418112018.GA20470@red-moon>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
 <20190417182448.12382-4-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-4-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 07:24:42PM +0100, Jean-Philippe Brucker wrote:
> Root complex node in IORT has a bit telling whether it supports ATS or
> not. Store this bit in the IOMMU fwspec when setting up a device, so it
> can be accessed later by an IOMMU driver. In the future we'll probably
> want to store this bit at the host bridge or SMMU rather than in each
> endpoint.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/acpi/arm64/iort.c | 11 +++++++++++
>  include/linux/iommu.h     |  4 ++++
>  2 files changed, 15 insertions(+)

For the IORT portion:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e48894e002ba..4000902e57f0 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1028,6 +1028,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
>  }
>  
> +static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_root_complex *pci_rc;
> +
> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> +	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
> +}
> +
>  /**
>   * iort_iommu_configure - Set-up IOMMU configuration for a device.
>   *
> @@ -1063,6 +1071,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		info.node = node;
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     iort_pci_iommu_init, &info);
> +
> +		if (!err && iort_pci_rc_supports_ats(node))
> +			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>  	} else {
>  		int i = 0;
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 480921dfbadf..51ab006d348e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -446,6 +446,7 @@ struct iommu_fwspec {
>  	const struct iommu_ops	*ops;
>  	struct fwnode_handle	*iommu_fwnode;
>  	void			*iommu_priv;
> +	u32			flags;
>  	unsigned int		num_ids;
>  	u32			ids[1];
>  };
> @@ -458,6 +459,9 @@ struct iommu_sva {
>  	const struct iommu_sva_ops	*ops;
>  };
>  
> +/* ATS is supported */
> +#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
> +
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>  		      const struct iommu_ops *ops);
>  void iommu_fwspec_free(struct device *dev);
> -- 
> 2.21.0
> 
