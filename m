Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
Subject: Re: [PATCH V7 07/11] pci, acpi: Handle ACPI companion assignment.
To: Tomasz Nowicki <tn@semihalf.com>, <helgaas@kernel.org>, <arnd@arndb.de>,
        <will.deacon@arm.com>, <catalin.marinas@arm.com>, <rafael@kernel.org>,
        <hanjun.guo@linaro.org>, <Lorenzo.Pieralisi@arm.com>,
        <okaya@codeaurora.org>, <jchandra@broadcom.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-8-git-send-email-tn@semihalf.com>
CC: <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
        <Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
        <wangyijing@huawei.com>, <Suravee.Suthikulpanit@amd.com>,
        <msalter@redhat.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linaro-acpi@lists.linaro.org>,
        <jcm@redhat.com>, <andrea.gallo@linaro.org>, <dhdang@apm.com>,
        <jeremy.linton@arm.com>, <cov@codeaurora.org>,
        Linuxarm
	<linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <573A8BED.7030908@huawei.com>
Date: Tue, 17 May 2016 11:11:41 +0800
MIME-Version: 1.0
In-Reply-To: <1462893601-8937-8-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="gbk"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz

I used the patchset and added "PATCH V6 11/13 specic quirks", tested on HiSilicon D02 board but met the below problem.

[    2.614115] [<ffffff80083b13bc>] hisi_pcie_init+0x6c/0x1ec
[    2.619571] [<ffffff80083ab060>] pci_ecam_create+0x130/0x1ec
[    2.625209] [<ffffff80083f3764>] pci_acpi_scan_root+0x160/0x218
[    2.631096] [<ffffff80083d1f6c>] acpi_pci_root_add+0x36c/0x42c
[    2.636897] [<ffffff80083ce36c>] acpi_bus_attach+0xe4/0x1a8
[    2.642438] [<ffffff80083ce3d8>] acpi_bus_attach+0x150/0x1a8
[    2.648066] [<ffffff80083ce3d8>] acpi_bus_attach+0x150/0x1a8
[    2.653693] [<ffffff80083ce55c>] acpi_bus_scan+0x64/0x74
[    2.658975] [<ffffff8008ae665c>] acpi_scan_init+0x5c/0x19c
[    2.664429] [<ffffff8008ae6408>] acpi_init+0x280/0x2a4
[    2.669538] [<ffffff80080829e8>] do_one_initcall+0x8c/0x19c
[    2.675080] [<ffffff8008ac3af8>] kernel_init_freeable+0x14c/0x1ec
[    2.681139] [<ffffff80087a8438>] kernel_init+0x10/0xfc
[    2.686248] [<ffffff8008085e10>] ret_from_fork+0x10/0x40

In hisi_pcie_init, I used "struct acpi_device *device = ACPI_COMPANION(dev);".
I found the reason is V7 lack the below code. I added the below code, it worked ok.

[PATCH V6 01/13] pci, acpi, x86, ia64: Move ACPI host bridge device companion assignment to core code.
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -564,6 +564,11 @@ static int acpi_pci_root_add(struct acpi_device *device,
  		}
  	}

+	/*
+	 * pci_create_root_bus() needs to detect the parent device type,
+	 * so initialize its companion data accordingly.
+	 */
+	ACPI_COMPANION_SET(&device->dev, device);

This code will be upstreamed with the "PATCH V6 11/13 specic quirks" in next time after the patchset is accepted.
Right ?

ÔÚ 2016/5/10 23:19, Tomasz Nowicki Ð´µÀ:
> This patch provides a way to set the ACPI companion in PCI code.
> We define acpi_pci_set_companion() to set the ACPI companion pointer and
> call it from PCI core code. The function is stub for now.
>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>   drivers/pci/probe.c      | 2 ++
>   include/linux/pci-acpi.h | 4 ++++
>   2 files changed, 6 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8004f67..fb0b752 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -12,6 +12,7 @@
>   #include <linux/slab.h>
>   #include <linux/module.h>
>   #include <linux/cpumask.h>
> +#include <linux/pci-acpi.h>
>   #include <linux/pci-aspm.h>
>   #include <linux/aer.h>
>   #include <linux/acpi.h>
> @@ -2141,6 +2142,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>   	bridge->dev.parent = parent;
>   	bridge->dev.release = pci_release_host_bridge_dev;
>   	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
> +	acpi_pci_set_companion(bridge);
>   	error = pcibios_root_bridge_prepare(bridge);
>   	if (error) {
>   		kfree(bridge);
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 09f9f02..1baa515 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -111,6 +111,10 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>   static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>   #endif	/* CONFIG_ACPI */
>
> +static inline void acpi_pci_set_companion(struct pci_host_bridge *bridge)
> +{
> +}
> +
>   static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus)
>   {
>   	return 0;
>
