Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34355 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbdGaXJQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 19:09:16 -0400
Subject: Re: [PATCH v3 08/16] switchtec_ntb: introduce initial NTB driver
To: Logan Gunthorpe <logang@deltatee.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-9-logang@deltatee.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <30bc9192-34cb-274a-387f-55cfb452db46@intel.com>
Date: Mon, 31 Jul 2017 16:08:15 -0700
MIME-Version: 1.0
In-Reply-To: <20170725205753.4735-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 07/25/2017 01:57 PM, Logan Gunthorpe wrote:
> Seeing the Switchtec NTB hardware shares the same endpoint as the
> management endpoint we utilize the class_interface API to register
> an NTB driver for every Switchtec device in the system that has the
> NTB class code.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> ---
>  MAINTAINERS                         |  1 +
>  drivers/ntb/hw/Kconfig              |  1 +
>  drivers/ntb/hw/Makefile             |  1 +
>  drivers/ntb/hw/mscc/Kconfig         |  9 +++++
>  drivers/ntb/hw/mscc/Makefile        |  1 +
>  drivers/ntb/hw/mscc/switchtec_ntb.c | 81 +++++++++++++++++++++++++++++++++++++

Minor nit. Conforming to the existing hw drivers naming scheme, maybe
should name switchtec_ntb.c to ntb_hw_switchtec.c?

>  drivers/pci/switch/switchtec.c      |  3 ++
>  include/linux/switchtec.h           |  4 ++
>  8 files changed, 101 insertions(+)
>  create mode 100644 drivers/ntb/hw/mscc/Kconfig
>  create mode 100644 drivers/ntb/hw/mscc/Makefile
>  create mode 100644 drivers/ntb/hw/mscc/switchtec_ntb.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ff2ad7c1c7b..6e491ce5e876 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10147,6 +10147,7 @@ F:	Documentation/ABI/testing/sysfs-class-switchtec
>  F:	drivers/pci/switch/switchtec*
>  F:	include/uapi/linux/switchtec_ioctl.h
>  F:	include/linux/switchtec.h
> +F:	drivers/ntb/hw/mscc/
>  
>  PCI DRIVER FOR NVIDIA TEGRA
>  M:	Thierry Reding <thierry.reding@gmail.com>
> diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig
> index a89243c9fdd3..e51b581fd102 100644
> --- a/drivers/ntb/hw/Kconfig
> +++ b/drivers/ntb/hw/Kconfig
> @@ -1,3 +1,4 @@
>  source "drivers/ntb/hw/amd/Kconfig"
>  source "drivers/ntb/hw/idt/Kconfig"
>  source "drivers/ntb/hw/intel/Kconfig"
> +source "drivers/ntb/hw/mscc/Kconfig"
> diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile
> index 87332c3905f0..923c442db750 100644
> --- a/drivers/ntb/hw/Makefile
> +++ b/drivers/ntb/hw/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_NTB_AMD)	+= amd/
>  obj-$(CONFIG_NTB_IDT)	+= idt/
>  obj-$(CONFIG_NTB_INTEL)	+= intel/
> +obj-$(CONFIG_NTB_SWITCHTEC) += mscc/
> diff --git a/drivers/ntb/hw/mscc/Kconfig b/drivers/ntb/hw/mscc/Kconfig
> new file mode 100644
> index 000000000000..013ed6716438
> --- /dev/null
> +++ b/drivers/ntb/hw/mscc/Kconfig
> @@ -0,0 +1,9 @@
> +config NTB_SWITCHTEC
> +	tristate "MicroSemi Switchtec Non-Transparent Bridge Support"
> +	select PCI_SW_SWITCHTEC
> +	help
> +	 Enables NTB support for Switchtec PCI switches. This also
> +	 selects the Switchtec management driver as they share the same
> +	 hardware interface.
> +
> +	 If unsure, say N.
> diff --git a/drivers/ntb/hw/mscc/Makefile b/drivers/ntb/hw/mscc/Makefile
> new file mode 100644
> index 000000000000..21907b364e19
> --- /dev/null
> +++ b/drivers/ntb/hw/mscc/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_NTB_SWITCHTEC) += switchtec_ntb.o
> diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
> new file mode 100644
> index 000000000000..253efba72275
> --- /dev/null
> +++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
> @@ -0,0 +1,81 @@
> +/*
> + * Microsemi Switchtec(tm) PCIe Management Driver
> + * Copyright (c) 2017, Microsemi Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + */
> +
> +#include <linux/switchtec.h>
> +#include <linux/module.h>
> +
> +MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
> +MODULE_VERSION("0.1");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Microsemi Corporation");
> +
> +struct switchtec_ntb {
> +	struct switchtec_dev *stdev;
> +};
> +
> +static int switchtec_ntb_add(struct device *dev,
> +			     struct class_interface *class_intf)
> +{
> +	struct switchtec_dev *stdev = to_stdev(dev);
> +	struct switchtec_ntb *sndev;
> +
> +	stdev->sndev = NULL;
> +
> +	if (stdev->pdev->class != MICROSEMI_NTB_CLASSCODE)
> +		return -ENODEV;
> +
> +	sndev = kzalloc_node(sizeof(*sndev), GFP_KERNEL, dev_to_node(dev));
> +	if (!sndev)
> +		return -ENOMEM;
> +
> +	sndev->stdev = stdev;
> +
> +	stdev->sndev = sndev;
> +	dev_info(dev, "NTB device registered");
> +
> +	return 0;
> +}
> +
> +void switchtec_ntb_remove(struct device *dev,
> +			  struct class_interface *class_intf)
> +{
> +	struct switchtec_dev *stdev = to_stdev(dev);
> +	struct switchtec_ntb *sndev = stdev->sndev;
> +
> +	if (!sndev)
> +		return;
> +
> +	stdev->sndev = NULL;
> +	kfree(sndev);
> +	dev_info(dev, "ntb device unregistered");
> +}
> +
> +static struct class_interface switchtec_interface  = {
> +	.add_dev = switchtec_ntb_add,
> +	.remove_dev = switchtec_ntb_remove,
> +};
> +
> +static int __init switchtec_ntb_init(void)
> +{
> +	switchtec_interface.class = switchtec_class;
> +	return class_interface_register(&switchtec_interface);
> +}
> +module_init(switchtec_ntb_init);
> +
> +static void __exit switchtec_ntb_exit(void)
> +{
> +	class_interface_unregister(&switchtec_interface);
> +}
> +module_exit(switchtec_ntb_exit);
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 807569e62bee..0666e33c305b 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1275,6 +1275,9 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
>  	struct switchtec_dev *stdev;
>  	int rc;
>  
> +	if (pdev->class == MICROSEMI_NTB_CLASSCODE)
> +		request_module_nowait("switchtec_ntb");
> +
>  	stdev = stdev_create(pdev);
>  	if (IS_ERR(stdev))
>  		return PTR_ERR(stdev);
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index d8159944f013..09d73d0d1aa8 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -320,6 +320,8 @@ struct pff_csr_regs {
>  	u32 reserved4[174];
>  } __packed;
>  
> +struct switchtec_ntb;
> +
>  struct switchtec_dev {
>  	struct pci_dev *pdev;
>  	struct device dev;
> @@ -357,6 +359,8 @@ struct switchtec_dev {
>  	struct work_struct link_event_work;
>  	void (*link_notifier)(struct switchtec_dev *stdev);
>  	u8 link_event_count[SWITCHTEC_MAX_PFF_CSR];
> +
> +	struct switchtec_ntb *sndev;
>  };
>  
>  static inline struct switchtec_dev *to_stdev(struct device *dev)
> 
