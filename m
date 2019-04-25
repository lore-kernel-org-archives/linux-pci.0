Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86342C43218
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 14:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75219206BF
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556201318;
	bh=BRoiHrfZJQwVrBvHJdZ6WzMeL+mNQ6h9J2jqC9rvkAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LDBe3Z/KTF6jMQp8JH7z/zRMDYnP9q2UigOXwaPLXVaOM2/xwweNnzwb5p6oc9FjM
	 btOuvVp0Phgy8LSVlCJ3Adbe++XnFdn63WOPzDCz7MkdU4J6w+bXAsc32pxdOvSwCL
	 QeFGUAYVkgPBdXEw4RzEqQgB+X9yQelV4k3gN5YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfDYOIh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfDYOIh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Apr 2019 10:08:37 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1137F20644;
        Thu, 25 Apr 2019 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556201316;
        bh=BRoiHrfZJQwVrBvHJdZ6WzMeL+mNQ6h9J2jqC9rvkAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ui1wS1a+UnJck+++sWj4+SZ5Vn6cvHLAKckQqvCZUsFJVP+kAFKRXUsLglmsHFYck
         iv4eSuCRGUGsZLuZmQc55X4Ki29FmcxsaBa97gmciVwAJ3ZZi2+TtB27XLwVWWrRb4
         MbuY9pWeOSSwXCAwXu3kphj6H/S7Gkpif3idmZHE=
Date:   Thu, 25 Apr 2019 09:08:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, vaerov@amazon.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, zeev@amazon.com,
        ronenk@amazon.com, barakw@amazon.com, talel@amazon.com,
        hanochu@amazon.com, hhhawa@amazon.com
Subject: Re: [PATCH v3] PCI: al: Add Amazon Annapurna Labs PCIe host
 controller driver
Message-ID: <20190425140834.GE11428@google.com>
References: <20190326125508.GG24180@google.com>
 <1553774276-24675-1-git-send-email-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553774276-24675-1-git-send-email-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 28, 2019 at 01:57:56PM +0200, Jonathan Chocron wrote:
> Add support for Amazon's Annapurna Labs PCIe driver. The HW controller
> is based on DesignWare's IP.
> 
> The HW doesn't support accessing the Root Port's config space via ECAM,
> so we obtain its base address via an AMZN0001 device.
> 
> Furthermore, the DesignWare PCIe controller doesn't filter out config
> transactions sent to devices 1 and up on its bus, so they are filtered
> by the driver.
> 
> All subordinate buses do support ECAM access.
> 
> Implementing specific PCI config access functions involves:
>  - Adding an init function to obtain the Root Port's base address from
>    an AMZN0001 device.
>  - Adding a new entry in the MCFG quirk array
> 
> Co-developed-by: Vladimir Aerov <vaerov@amazon.com>
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Signed-off-by: Vladimir Aerov <vaerov@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

Applied with Ben's reviewed-by and Lorenzo's ack to pci/host/al for v5.2,
thanks!

> ---
> 
> --v2:
>   - Fix commit message comments (incl. using AMZN0001 instead of
>     PNP0C02)
>   - Use the usual multi-line comment style
> 
> --v3:
>   - Fix additional commit message comments
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
