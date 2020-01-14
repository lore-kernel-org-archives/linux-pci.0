Return-Path: <SRS0=eZdz=3D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFADAC33CB3
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 08:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B089E2084D
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 08:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgANIy2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:54:28 -0500
Received: from verein.lst.de ([213.95.11.211]:44889 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgANIy2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 03:54:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A947568B20; Tue, 14 Jan 2020 09:54:25 +0100 (CET)
Date:   Tue, 14 Jan 2020 09:54:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 4/5] PCI: vmd: Stop overriding dma_map_ops
Message-ID: <20200114085425.GD32024@lst.de>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com> <1578676873-6206-5-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578676873-6206-5-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 10, 2020 at 10:21:12AM -0700, Jon Derrick wrote:
> Devices on the VMD domain use the VMD endpoint's requester ID and have
> been relying on the VMD endpoint's DMA operations. The problem with this
> was that VMD domain devices would use the VMD endpoint's attributes when
> doing DMA and IOMMU mapping. We can be smarter about this by only using
> the VMD endpoint when mapping and providing the correct child device's
> attributes during DMA operations.
> 
> This patch modifies Intel-IOMMU to check for a 'Direct DMA Alias' and
> refer to it for mapping.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/iommu/intel-iommu.c    |  18 +++--
>  drivers/pci/controller/Kconfig |   1 -
>  drivers/pci/controller/vmd.c   | 150 -----------------------------------------
>  3 files changed, 13 insertions(+), 156 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 716347e2..7ca807a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -804,14 +804,14 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>  
>  	if (dev_is_pci(dev)) {
>  		struct pci_dev *pf_pdev;
> +		struct pci_dev *dma_alias;
>  
>  		pdev = to_pci_dev(dev);
>  
> -#ifdef CONFIG_X86
> -		/* VMD child devices currently cannot be handled individually */
> -		if (is_vmd(pdev->bus))
> -			return NULL;
> -#endif

Don't we need this sanity check to prevent assingning vmd subdevices?

> +		/* DMA aliased devices use the DMA alias's IOMMU */
> +		dma_alias = pci_direct_dma_alias(pdev);
> +		if (dma_alias)
> +			pdev = dma_alias;
>  
>  		/* VFs aren't listed in scope tables; we need to look up
>  		 * the PF instead to find the IOMMU. */
> @@ -2521,6 +2521,14 @@ struct dmar_domain *find_domain(struct device *dev)
>  		     dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO))
>  		return NULL;
>  
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		struct pci_dev *dma_alias = pci_direct_dma_alias(pdev);
> +
> +		if (dma_alias)
> +			dev = &dma_alias->dev;

Instead of all these duplicate calls, shouldn't pci_direct_dma_alias be
replaced with a pci_real_dma_dev helper that either returns the
dma parent if it exiѕts, or the actual device?

Also I think this patch should be split - one for intel-iommu that
just adds the real device checks, and then one that wires up vmd to
the new mechanism and then removes all the cruft.
