Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161E9C43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6A12083E
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 17:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4POhy9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6A12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeI2AWO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbeI2AWO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 20:22:14 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEBE204FD;
        Fri, 28 Sep 2018 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538157439;
        bh=uR2wDWRutqh/FQUJo7ih+A47LlKMoZ+jJuYPUFyppO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4POhy9Bdf+K/tnMU/dN4T3mxpEKO7s3FtUkIoQScVm8l3UN2r3fpjmb7sLaXUSRw
         ffB74159j6X/0LNm4weDMOUJiH0q7oVbnfSQDd5sTbYF9W9nsL4d90jHEZ+O6AUQMh
         m3m56T/oUiqbNKE+yfpzNvj/kxpPrHBxW1zvqFhA=
Date:   Fri, 28 Sep 2018 12:57:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: add support for Immediate Readiness
Message-ID: <20180928175718.GE18434@bhelgaas-glaptop.roam.corp.google.com>
References: <20180906141355.GC214747@bhelgaas-glaptop.roam.corp.google.com>
 <20180907061651.6156-1-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907061651.6156-1-felipe.balbi@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 07, 2018 at 09:16:51AM +0300, Felipe Balbi wrote:
> PCIe GEN4 defines, on section 7.5.1.1.4, a new bit on Status Register
> which tells us that:
> 
> "Immediate Readiness – This optional bit, when Set, indicates the
> Function is guaranteed to be ready to successfully complete valid
> configuration accesses at any time following any reset that the host
> is capable of issuing Configuration Requests to this Function.
> 
> When this bit is Set, for accesses to this Function, software is
> exempt from all requirements to delay configuration accesses following
> any type of reset, including but not limited to the timing
> requirements defined in Section 6.6.  How this guarantee is
> established is beyond the scope of this document.
> 
> It is permitted that system software/firmware provide mechanisms that
> supersede the indication provided by this bit, however such
> software/firmware mechanisms are outside the scope of this
> specification."
> 
> This means that all delays after a Conventional or Function Reset can
> be skipped.
> 
> This patch reads such bit and caches its value in a flag inside struct
> pci_dev to be checked later if we should delay or can skip delays
> after a reset. While at that, also move the explicit msleep(100) call
> from pcie_flr() and pci_af_flr() to pci_dev_wait().
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Applied to pci/enumeration for v4.20, thanks!

> ---
> 
> changes since v1:
> 	- rename immediate flag to imm_ready
> 	- move imm_ready check to pci_flr() and pci_af_flr()
> 
> 
>  drivers/pci/pci.c             | 14 +++++++++++++-
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  1 +
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 29ff9619b5fa..f94e07262ffa 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -999,7 +999,7 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
>  		 * because have already delayed for the bridge.
>  		 */
>  		if (dev->runtime_d3cold) {
> -			if (dev->d3cold_delay)
> +			if (dev->d3cold_delay && !dev->imm_ready)
>  				msleep(dev->d3cold_delay);
>  			/*
>  			 * When powering on a bridge from D3cold, the
> @@ -2644,6 +2644,7 @@ EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>  void pci_pm_init(struct pci_dev *dev)
>  {
>  	int pm;
> +	u16 status;
>  	u16 pmc;
>  
>  	pm_runtime_forbid(&dev->dev);
> @@ -2706,6 +2707,11 @@ void pci_pm_init(struct pci_dev *dev)
>  		/* Disable the PME# generation functionality */
>  		pci_pme_active(dev, false);
>  	}
> +
> +	pci_read_config_word(dev, PCI_STATUS, &status);
> +
> +	if (status & PCI_STATUS_IMMEDIATE)
> +		dev->imm_ready = 1;
>  }
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> @@ -4376,6 +4382,9 @@ int pcie_flr(struct pci_dev *dev)
>  
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>  
> +	if (dev->imm_ready)
> +		return 0;
> +
>  	/*
>  	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
>  	 * 100ms, but may silently discard requests while the FLR is in
> @@ -4417,6 +4426,9 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  
>  	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
>  
> +	if (dev->imm_ready)
> +		return 0;
> +
>  	/*
>  	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
>  	 * updated 27 July 2006; a device must complete an FLR within
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e72ca8dd6241..7eed464e844a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -325,6 +325,7 @@ struct pci_dev {
>  	pci_power_t	current_state;	/* Current operating state. In ACPI,
>  					   this is D0-D3, D0 being fully
>  					   functional, and D3 being off. */
> +	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
>  	u8		pm_cap;		/* PM capability offset */
>  	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>  					   can be generated */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ee556ccc93f4..b5cf51a06cae 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -52,6 +52,7 @@
>  #define  PCI_COMMAND_INTX_DISABLE 0x400 /* INTx Emulation Disable */
>  
>  #define PCI_STATUS		0x06	/* 16 bits */
> +#define  PCI_STATUS_IMMEDIATE	0x01	/* Immediate Readiness */
>  #define  PCI_STATUS_INTERRUPT	0x08	/* Interrupt status */
>  #define  PCI_STATUS_CAP_LIST	0x10	/* Support Capability List */
>  #define  PCI_STATUS_66MHZ	0x20	/* Support 66 MHz PCI 2.1 bus */
> -- 
> 2.18.0
> 
