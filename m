Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEBCC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 12:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9AA2075E
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 12:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCZMRe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:17:34 -0400
Received: from foss.arm.com ([217.140.101.70]:35462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZMRe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 08:17:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6951596;
        Tue, 26 Mar 2019 05:17:34 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1800F3F59C;
        Tue, 26 Mar 2019 05:17:31 -0700 (PDT)
Date:   Tue, 26 Mar 2019 12:17:27 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, vaerov@amazon.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, zeev@amazon.com,
        ronenk@amazon.com, barakw@amazon.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v2] PCI: al: Add Amazon Annapurna Labs PCIe host
 controller driver
Message-ID: <20190326121727.GA4171@e107981-ln.cambridge.arm.com>
References: <1553512040-4453-1-git-send-email-jonnyc@amazon.com>
 <1553594455-30436-1-git-send-email-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553594455-30436-1-git-send-email-jonnyc@amazon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Zhou, Gustavo]

On Tue, Mar 26, 2019 at 12:00:55PM +0200, Jonathan Chocron wrote:
> Adding support for Amazon's Annapurna Labs PCIe driver.
> The HW controller is based on DesignWare's IP.
> 
> The HW doesn't support accessing the Root Port's config space via
> ECAM, so we obtain its base address via an AMZN0001 device.
> 
> Furthermore, the DesignWare PCIe controller doesn't filter out
> config transactions sent to devices 1 and up on its bus, so they
> are filtered by the driver.
> All subordinate buses do support ECAM access.
> 
> Implementing specific PCI config access functions involves:
>  - Adding an init function to obtain the Root Port's base address
>    from an AMZN0001 device.
>  - Adding a new entry in the mcfg quirk array
> 
> Co-developed-by: Vladimir Aerov <vaerov@amazon.com>
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Signed-off-by: Vladimir Aerov <vaerov@amazon.com>
> Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

Review tags should be given on public mailing lists for public
review and I have not seen them (they were already there in v1) so
you should drop them.

> Changes from v1:
>   - Fix commit message comments (incl. using AMZN0001
>     instead of PNP0C02)
>   - Use the usual multi-line comment style
> 
>  MAINTAINERS                          |  6 +++
>  drivers/acpi/pci_mcfg.c              | 12 +++++
>  drivers/pci/controller/dwc/Makefile  |  1 +
>  drivers/pci/controller/dwc/pcie-al.c | 93 ++++++++++++++++++++++++++++++++++++
>  include/linux/pci-ecam.h             |  1 +
>  5 files changed, 113 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-al.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32d444476a90..7a17017f9f82 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11769,6 +11769,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
>  S:	Supported
>  F:	drivers/pci/controller/
>  
> +PCIE DRIVER FOR ANNAPURNA LABS
> +M:	Jonathan Chocron <jonnyc@amazon.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/controller/dwc/pcie-al.c

I do not think we need a maintainer file for that see below, and
actually this quirk should be handled by DWC maintainers since it is a
DWC quirk, not a platform one.

> +
>  PCIE DRIVER FOR AMLOGIC MESON
>  M:	Yue Wang <yue.wang@Amlogic.com>
>  L:	linux-pci@vger.kernel.org
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index a4e8432fc2fb..b42be067fb83 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -52,6 +52,18 @@ struct mcfg_fixup {
>  static struct mcfg_fixup mcfg_quirks[] = {
>  /*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
>  
> +#define AL_ECAM(table_id, rev, seg, ops) \
> +	{ "AMAZON", table_id, rev, seg, MCFG_BUS_ANY, ops }
> +
> +	AL_ECAM("GRAVITON", 0, 0, &al_pcie_ops),
> +	AL_ECAM("GRAVITON", 0, 1, &al_pcie_ops),
> +	AL_ECAM("GRAVITON", 0, 2, &al_pcie_ops),
> +	AL_ECAM("GRAVITON", 0, 3, &al_pcie_ops),
> +	AL_ECAM("GRAVITON", 0, 4, &al_pcie_ops),
> +	AL_ECAM("GRAVITON", 0, 5, &al_pcie_ops),
> +	AL_ECAM("GRAVITON", 0, 6, &al_pcie_ops),
> +	AL_ECAM("GRAVITON", 0, 7, &al_pcie_ops),
> +
>  #define QCOM_ECAM32(seg) \
>  	{ "QCOM  ", "QDF2432 ", 1, seg, MCFG_BUS_ANY, &pci_32b_ops }
>  
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 7bcdcdf5024e..1ea773c0070d 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -28,5 +28,6 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  # depending on whether ACPI, the DT driver, or both are enabled.
>  
>  ifdef CONFIG_PCI
> +obj-$(CONFIG_ARM64) += pcie-al.o
>  obj-$(CONFIG_ARM64) += pcie-hisi.o
>  endif
> diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
> new file mode 100644
> index 000000000000..65a9776c12be
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-al.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Amazon's Annapurna Labs IP (used in chips
> + * such as Graviton and Alpine)
> + *
> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * Author: Jonathan Chocron <jonnyc@amazon.com>
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/pci-acpi.h>
> +#include "../../pci.h"
> +
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> +
> +struct al_pcie_acpi  {
> +	void __iomem *dbi_base;
> +};
> +
> +static void __iomem *al_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> +				     int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct al_pcie_acpi *pcie = cfg->priv;
> +	void __iomem *dbi_base = pcie->dbi_base;
> +
> +	if (bus->number == cfg->busr.start) {
> +		/*
> +		 * The DW PCIe core doesn't filter out transactions to other
> +		 * devices/functions on the primary bus num, so we do this here.
> +		 */
> +		if (PCI_SLOT(devfn) > 0)
> +			return NULL;
> +		else
> +			return dbi_base + where;
> +	}
> +
> +	return pci_ecam_map_bus(bus, devfn, where);
> +}
> +
> +static int al_pcie_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct acpi_device *adev = to_acpi_device(dev);
> +	struct acpi_pci_root *root = acpi_driver_data(adev);
> +	struct al_pcie_acpi *al_pcie;
> +	struct resource *res;
> +	int ret;
> +
> +	al_pcie = devm_kzalloc(dev, sizeof(*al_pcie), GFP_KERNEL);
> +	if (!al_pcie)
> +		return -ENOMEM;
> +
> +	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	ret = acpi_get_rc_resources(dev, "AMZN0001", root->segment, res);
> +	if (ret) {
> +		dev_err(dev, "can't get rc dbi base address for SEG %d\n",
> +			root->segment);
> +		return ret;
> +	}
> +
> +	dev_dbg(dev, "Root port dbi res: %pR\n", res);
> +
> +	al_pcie->dbi_base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(al_pcie->dbi_base)) {
> +		long err = PTR_ERR(al_pcie->dbi_base);
> +
> +		dev_err(dev, "couldn't remap dbi base %pR (err:%ld)\n",
> +			res, err);
> +		return err;
> +	}
> +
> +	cfg->priv = al_pcie;
> +
> +	return 0;
> +}

This code is basically identical to (apart from the string matching
the DBI resource)

drivers/pci/controller/pcie-hisi.c

because, as you said, that's a DW quirk that is really not
platform specific AFAICS.

Not that I am really fond of the idea but in practice we can
create a quirk that applies to all host controllers DW based,
in case they want to boot with ACPI, this patch is basically
code duplication.

Thanks,
Lorenzo

> +
> +struct pci_ecam_ops al_pcie_ops = {
> +	.bus_shift    = 20,
> +	.init         =  al_pcie_init,
> +	.pci_ops      = {
> +		.map_bus    = al_pcie_map_bus,
> +		.read       = pci_generic_config_read,
> +		.write      = pci_generic_config_write,
> +	}
> +};
> +
> +#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 29efa09d686b..a73164c85e78 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -56,6 +56,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
>  extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
>  extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
> +extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs PCIe */
>  #endif
>  
>  #ifdef CONFIG_PCI_HOST_COMMON
> -- 
> 1.9.1
> 
