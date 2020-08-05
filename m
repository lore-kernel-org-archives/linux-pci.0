Return-Path: <SRS0=Z6n5=BP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E1FC433DF
	for <linux-pci@archiver.kernel.org>; Wed,  5 Aug 2020 17:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506D8206A2
	for <linux-pci@archiver.kernel.org>; Wed,  5 Aug 2020 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596649722;
	bh=OKbo9x6qSIBQ+EfDdXTGM4gIuWDJ2f+ftbIIZeCVXCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=BORtvLC75Bxg5KmFyiGWMQIBVq7Xck8i1PQZMuQoTdWdQdX2MN1e/3KMrgvPxmhda
	 LafqQffY/ps94ScyQBmc4FOMNXFLIeYScrZ13sSJjdMWreAF0s1yrthok1w3u3T9ar
	 fxnCok3iTNVkxpZ4ss0lPVsqhyTa9+91jil6EagU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgHERr6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbgHERoD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 13:44:03 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F69D206B6;
        Wed,  5 Aug 2020 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596649383;
        bh=OKbo9x6qSIBQ+EfDdXTGM4gIuWDJ2f+ftbIIZeCVXCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aKzXNSdu1daPVOFgu4auDzWADIYSal/8inG0/vKAIW9Bipkv6UBJUj0mwiTpkTrOU
         YcP89Hh9pAsyZRo8nox76aKV7Otca6B/iBcrn6WdfkSHYd1XuDT/9d3kNQu8wqqUvm
         6tnv3J54L3HNhIlwe1waQoXzbFQFEg1BDQeCQe/Q=
Date:   Wed, 5 Aug 2020 12:43:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 3/9] PCI/portdrv: Add pcie_walk_rcec() to walk RCiEPs
 associated with RCEC
Message-ID: <20200805174301.GA514577@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804194052.193272-4-sean.v.kelley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 04, 2020 at 12:40:46PM -0700, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> When an RCEC device signals error(s) to a CPU core, the CPU core
> needs to walk all the RCiEPs associated with that RCEC to check
> errors. So add the function pcie_walk_rcec() to walk all RCiEPs
> associated with the RCEC device.
> 
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pcie/portdrv.h      |  2 +
>  drivers/pci/pcie/portdrv_core.c | 82 +++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index af7cf237432a..c11d5ecbad76 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -116,6 +116,8 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *new);
>  
>  extern struct bus_type pcie_port_bus_type;
>  int pcie_port_device_register(struct pci_dev *dev);
> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);
>  #ifdef CONFIG_PM
>  int pcie_port_device_suspend(struct device *dev);
>  int pcie_port_device_resume_noirq(struct device *dev);
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 5d4a400094fc..daa2dfa83a0b 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
> +#include <linux/bitops.h>
>  #include <linux/aer.h>
>  
>  #include "../pci.h"
> @@ -365,6 +366,87 @@ int pcie_port_device_register(struct pci_dev *dev)
>  	return status;
>  }
>  
> +static int pcie_walk_rciep_devfn(struct pci_bus *pbus, int (*cb)(struct pci_dev *, void *),

In drivers/pci, the typical name for a "struct pci_bus *" is "bus",
and for a "struct pci_dev *" is "dev" (below).

> +				 void *userdata, unsigned long bitmap)

Use "u32 bitmap" so the width is explicit.  Looks like this would also
get rid of the cast in the caller.  So maybe you used "unsigned long"
here for some reason?

> +{
> +	unsigned int dev, fn;
> +	struct pci_dev *pdev;
> +	int retval;
> +
> +	for_each_set_bit(dev, &bitmap, 32) {
> +		for (fn = 0; fn < 8; fn++) {
> +			pdev = pci_get_slot(pbus, PCI_DEVFN(dev, fn));

This needs a matching pci_dev_put(), according to the pci_get_slot()
function comment.

> +
> +			if (!pdev || pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> +				continue;
> +
> +			retval = cb(pdev, userdata);
> +			if (retval)
> +				return retval;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pcie_walk_rcec - Walk RCiEP devices associating with RCEC and call callback.
> + * @rcec     RCEC whose RCiEP devices should be walked.
> + * @cb       Callback to be called for each RCiEP device found.
> + * @userdata Arbitrary pointer to be passed to callback.
> + *
> + * Walk the given RCEC. Call the provided callback on each RCiEP device found.
> + *
> + * We check the return of @cb each time. If it returns anything
> + * other than 0, we break out.
> + */
> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +		    void *userdata)
> +{
> +	u32 pos, bitmap, hdr, busn;
> +	u8 ver, nextbusn, lastbusn;
> +	struct pci_bus *pbus;
> +	unsigned int bnr;
> +
> +	pos = pci_find_ext_capability(rcec, PCI_EXT_CAP_ID_RCEC);
> +	if (!pos)
> +		return;

I think all the registers you care about here are read-only.  If so, we
should find the capability, read the registers (bitmap & bus numbers),
and save them at enumeration-time, e.g., in pci_init_capabilities().
I hope we don't have to dig all this out every time we process an
error.

> +	pbus = pci_find_bus(pci_domain_nr(rcec->bus), rcec->bus->number);
> +	if (!pbus)
> +		return;

This seems like a really complicated way to write:

  pbus = rcec->bus;

"rcec->bus" cannot be NULL, so there's no need to check.

> +	pci_read_config_dword(rcec, pos + PCI_RCEC_RCIEP_BITMAP, &bitmap);
> +
> +	/* Find RCiEP devices on the same bus as the RCEC */
> +	if (pcie_walk_rciep_devfn(pbus, cb, userdata, (unsigned long)bitmap))
> +		return;
> +
> +	/* Check whether RCEC BUSN register is present */
> +	pci_read_config_dword(rcec, pos, &hdr);
> +	ver = PCI_EXT_CAP_VER(hdr);
> +	if (ver < PCI_RCEC_BUSN_REG_VER)
> +		return;
> +
> +	pci_read_config_dword(rcec, pos + PCI_RCEC_BUSN, &busn);
> +	nextbusn = PCI_RCEC_BUSN_NEXT(busn);
> +	lastbusn = PCI_RCEC_BUSN_LAST(busn);
> +
> +	/* All RCiEP devices are on the same bus as the RCEC */
> +	if (nextbusn == 0xff && lastbusn == 0x00)
> +		return;
> +
> +	for (bnr = nextbusn; bnr <= lastbusn; bnr++) {
> +		pbus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
> +		if (!pbus)
> +			continue;
> +
> +		/* Find RCiEP devices on the given bus */
> +		if (pcie_walk_rciep_devfn(pbus, cb, userdata, 0xffffffff))
> +			return;
> +	}
> +}
> +
>  #ifdef CONFIG_PM
>  typedef int (*pcie_pm_callback_t)(struct pcie_device *);
>  
> -- 
> 2.27.0
> 
