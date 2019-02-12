Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F4DC282C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7298A222C0
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 18:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBLSMQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:12:16 -0500
Received: from foss.arm.com ([217.140.101.70]:41688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfBLSMQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Feb 2019 13:12:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1292A78;
        Tue, 12 Feb 2019 10:12:15 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 134893F575;
        Tue, 12 Feb 2019 10:12:13 -0800 (PST)
Date:   Tue, 12 Feb 2019 18:12:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: iproc: Add CRS check in config read
Message-ID: <20190212181208.GA918@e107981-ln.cambridge.arm.com>
References: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
 <1549342622-9929-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549342622-9929-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 05, 2019 at 10:27:00AM +0530, Srinath Mannam wrote:
> In the current implementation, config read output data 0xffff0001 is
> assumed as CRS completion. But sometimes 0xffff0001 can be a valid data.
> 
> IPROC PCIe host controller has a register to show config read request
> status flags like SC, UR, CRS and CA. So that extra check is added to
> confirm the CRS using status flags before reissue config read.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index c20fd6b..b882255 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -60,6 +60,10 @@
>  #define APB_ERR_EN_SHIFT		0
>  #define APB_ERR_EN			BIT(APB_ERR_EN_SHIFT)
>  
> +#define CFG_RD_SUCCESS			0
> +#define CFG_RD_UR			1
> +#define CFG_RD_CRS			2
> +#define CFG_RD_CA			3
>  #define CFG_RETRY_STATUS		0xffff0001
>  #define CFG_RETRY_STATUS_TIMEOUT_US	500000 /* 500 milliseconds */
>  
> @@ -289,6 +293,9 @@ enum iproc_pcie_reg {
>  	IPROC_PCIE_IARR4,
>  	IPROC_PCIE_IMAP4,
>  
> +	/* config read status */
> +	IPROC_PCIE_CFG_RD_STATUS,
> +
>  	/* link status */
>  	IPROC_PCIE_LINK_STATUS,
>  
> @@ -350,6 +357,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
>  	[IPROC_PCIE_IMAP3]		= 0xe08,
>  	[IPROC_PCIE_IARR4]		= 0xe68,
>  	[IPROC_PCIE_IMAP4]		= 0xe70,
> +	[IPROC_PCIE_CFG_RD_STATUS]	= 0xee0,

So, with the *current* code, on controllers that does not support this
register you won't be able to get any HW whose config space register
value reads 0xffff0001 to work, is that correct ?

Lorenzo

>  	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
>  	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
>  };
> @@ -474,10 +482,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
>  	return (pcie->base + offset);
>  }
>  
> -static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
> +static unsigned int iproc_pcie_cfg_retry(struct iproc_pcie *pcie,
> +					 void __iomem *cfg_data_p)
>  {
>  	int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
>  	unsigned int data;
> +	u32 status;
>  
>  	/*
>  	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software Visibility only
> @@ -498,6 +508,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
>  	 */
>  	data = readl(cfg_data_p);
>  	while (data == CFG_RETRY_STATUS && timeout--) {
> +		/*
> +		 * CRS state is set in CFG_RD status register
> +		 * This will handle the case where CFG_RETRY_STATUS is
> +		 * valid config data.
> +		 */
> +		status = iproc_pcie_read_reg(pcie, IPROC_PCIE_CFG_RD_STATUS);
> +		if (status != CFG_RD_CRS)
> +			return data;
> +
>  		udelay(1);
>  		data = readl(cfg_data_p);
>  	}
> @@ -576,7 +595,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
>  	if (!cfg_data_p)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
> -	data = iproc_pcie_cfg_retry(cfg_data_p);
> +	data = iproc_pcie_cfg_retry(pcie, cfg_data_p);
>  
>  	*val = data;
>  	if (size <= 2)
> -- 
> 2.7.4
> 
