Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC997C43387
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB3E20883
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547824134;
	bh=J8FVti6KX9L9nCKC12RtTaUicjqqz/AebZH1a0x+yVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oPKWLwwH1yCIUjbnNijBsKS/DiSOdIuUG2DMQaquNAUXBjrDpCgJmoheBV8VRtESW
	 5tZoNlFFVsyN+9/5jXtLA1CX6yYasRmbTBsr+9MA1iljUUDDTJhQ9ld0d0vYfUSwk3
	 Ng+eC193nBOxO0UPVbg6u7mWwRoKJoCeYIi/y1yA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfARPIy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:08:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfARPIy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jan 2019 10:08:54 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E34D72086D;
        Fri, 18 Jan 2019 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547824133;
        bh=J8FVti6KX9L9nCKC12RtTaUicjqqz/AebZH1a0x+yVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwWs0V0ycObrqzGti/FiFDmYU5GKY477r2Y7uUHUiZ5bb1izLgAzJ8iRXBGj+wOZQ
         2jYsKsQEeWUq7XXu3EmxweL4EPz+SQ90D7weo9f/tDwzUONtfwjrKxJyNmky5HJKqm
         HGnM8Corr7KXk+MKCFg5oIBvW5owIipaj+ITb+mY=
Date:   Fri, 18 Jan 2019 09:08:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: iproc: CRS state check in config request
Message-ID: <20190118150851.GC25249@google.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
 <1547785403-32268-3-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547785403-32268-3-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 18, 2019 at 09:53:22AM +0530, Srinath Mannam wrote:
> In the current implementation, config read of 0xffff0001 data
> is assumed as CRS completion. but sometimes 0xffff0001 can be
> a valid data.
> IPROC PCIe RC has a register to show config request status flags
> like SC, UR, CRS and CA.
> So that extra check is added in the code to confirm the CRS
> state using this register before reissue config request.

s/. but/.  But/  (Sentences start with a capital letter.)

Please wrap this text correctly.  If it's a single paragraph, wrap it so
the lines are filled.  It *looks* like it's intended to be separate
paragraphs; they should be separated by blank lines.

> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 13ce80f..ee89d56 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -63,6 +63,10 @@
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
> @@ -300,6 +304,9 @@ enum iproc_pcie_reg {
>  	IPROC_PCIE_IARR4,
>  	IPROC_PCIE_IMAP4,
>  
> +	/* config read status */
> +	IPROC_PCIE_CFG_RD_STATUS,
> +
>  	/* link status */
>  	IPROC_PCIE_LINK_STATUS,
>  
> @@ -370,6 +377,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
>  	[IPROC_PCIE_IMAP3]		= 0xe08,
>  	[IPROC_PCIE_IARR4]		= 0xe68,
>  	[IPROC_PCIE_IMAP4]		= 0xe70,
> +	[IPROC_PCIE_CFG_RD_STATUS]	= 0xee0,
>  	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
>  	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
>  	[IPROC_PCIE_ORDERING_CFG]	= 0x2000,
> @@ -501,10 +509,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
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
> @@ -525,6 +535,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
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
> @@ -603,7 +622,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
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
