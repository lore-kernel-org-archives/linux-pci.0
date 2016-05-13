Return-Path: <jayachandran.c@broadcom.com>
Return-Path: <jayachandran.c@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1462893601-8937-9-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com> <1462893601-8937-9-git-send-email-tn@semihalf.com>
From: Jayachandran C <jchandra@broadcom.com>
Date: Fri, 13 May 2016 16:55:48 +0530
Message-ID: <CAKc_7PVJmhiD8x=zw4N3sSDPD-jZz-wh8TPTuuTYEdxn3v78og@mail.gmail.com>
Subject: Re: [PATCH V7 08/11] pci, acpi: Support for ACPI based generic PCI
 host controller
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Rafael Wysocki <rafael@kernel.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, robert.richter@caviumnetworks.com,
	Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>, Wangyijing <wangyijing@huawei.com>,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.org,
	Jon Masters <jcm@redhat.com>, Andrea Gallo <andrea.gallo@linaro.org>, Duc Dang <dhdang@apm.com>,
	jeremy.linton@arm.com, liudongdong3@huawei.com,
	Christopher Covington <cov@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 10, 2016 at 8:49 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> This patch is going to implement generic PCI host controller for
> ACPI world, similar to what pci-host-generic.c driver does for DT world.
>
> All such drivers, which we have seen so far, were implemented within
> arch/ directory since they had some arch assumptions (x86 and ia64).
> However, they all are doing similar thing, so it makes sense to find
> some common code and abstract it into the generic driver.
>
> In order to handle PCI config space regions properly, we define new
> MCFG interface which does sanity checks on MCFG table and keeps its
> root pointer. User is able to lookup MCFG regions based on that root
> pointer and specified domain:bus_start:bus_end touple. We are using
> pci_mmcfg_late_init old prototype to avoid another function name.
>
> The implementation of pci_acpi_scan_root() looks up the MCFG entries
> and sets up a new mapping (regions are not mapped until host controller ask
> for it). Generic PCI functions are used for accessing config space.
> Driver selects PCI_ECAM and uses functions from drivers/pci/ecam.h
> to create and access ECAM mappings.
>
> As mentioned in Kconfig help section, ACPI_PCI_HOST_GENERIC choice
> should be made on a per-architecture basis.
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
[....]

> diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
> index 1ad2176..1cccf57 100644
> --- a/drivers/pci/ecam.h
> +++ b/drivers/pci/ecam.h
> @@ -45,6 +45,11 @@ struct pci_config_window {
>                 void __iomem            *win;   /* 64-bit single mapping */
>                 void __iomem            **winp; /* 32-bit per bus mapping */
>         };
> +#ifdef CONFIG_ACPI_PCI_HOST_GENERIC
> +       struct acpi_device              *companion; /* ACPI companion device */
> +#endif
> +       int                             domain;
> +
>  };

Using struct pci_config_window to pass along domain and
companion looks bad.  I think there are two possible options
to do this better:

1. add a 'struct fwnode_handle *' or 'struct device *parent_dev'
   instead of the companion and domain fields above. In case of
   ACPI either of them can be used to get the acpi_device and
   both  domain and companion can be set from that.

2. make pci_config_window fully embeddable by moving allocation
   out of pci_ecam_create to its callers. Then it can be embedded
   into acpi_pci_generic_root_info, and container_of can be used
   to get acpi info from ->sysdata.

The first option should be easier to implement but the second may
be better on long run. I would leave it to the Bjorn or Rafael to
suggest which is preferred.

JC.
