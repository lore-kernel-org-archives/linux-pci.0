Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5551EFC1.2010704@linaro.org>
Date: Tue, 12 May 2015 20:19:13 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
CC: Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC v2 6/7] x86/PCI/ACPI: Use common interface to support PCI
 host bridge
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com> <1430793970-11159-7-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1430793970-11159-7-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[...]
>   struct pci_root_info {
> -	struct acpi_device *bridge;
> -	char name[16];
> -	struct pci_controller sd;
> +	struct acpi_pci_root_info_common common;
>   #ifdef	CONFIG_PCI_MMCONFIG
>   	bool mcfg_added;
>   	u16 segment;
> @@ -165,14 +164,17 @@ static int check_segment(u16 seg, struct device *dev, char *estr)
>   	return 0;
>   }
>
> -static int setup_mcfg_map(struct pci_root_info *info, u16 seg, u8 start,
> -			  u8 end, phys_addr_t addr)
> +static int setup_mcfg_map(struct acpi_pci_root_info_common *ci)
>   {
>   	int result;
> -	struct device *dev = &info->bridge->dev;
> +	struct pci_root_info *info;
> +	struct acpi_pci_root *root = ci->root;
> +	struct device *dev = &ci->bridge->dev;
> +	int seg = ci->controller.segment;

...

>
> -	info->start_bus = start;
> -	info->end_bus = end;
> +	info = container_of(ci, struct pci_root_info, common);
> +	info->start_bus = (u8)root->secondary.start;
> +	info->end_bus = (u8)root->secondary.end;
>   	info->mcfg_added = false;

info->segment is not initialized here

>
>   	/* return success if MMCFG is not in use */
> @@ -182,7 +184,8 @@ static int setup_mcfg_map(struct pci_root_info *info, u16 seg, u8 start,
>   	if (!(pci_probe & PCI_PROBE_MMCONF))
>   		return check_segment(seg, dev, "MMCONFIG is disabled,");
>
> -	result = pci_mmconfig_insert(dev, seg, start, end, addr);
> +	result = pci_mmconfig_insert(dev, seg, info->start_bus, info->end_bus,
> +				     root->mcfg_addr);
>   	if (result == 0) {
>   		/* enable MMCFG if it hasn't been enabled yet */
>   		if (raw_pci_ext_ops == NULL)
> @@ -195,8 +198,11 @@ static int setup_mcfg_map(struct pci_root_info *info, u16 seg, u8 start,
>   	return 0;
>   }
>
> -static void teardown_mcfg_map(struct pci_root_info *info)
> +static void teardown_mcfg_map(struct acpi_pci_root_info_common *ci)
>   {
> +	struct pci_root_info *info;
> +
> +	info = container_of(ci, struct pci_root_info, common);
>   	if (info->mcfg_added) {
>   		pci_mmconfig_delete(info->segment, info->start_bus,

But the segment is used here to delete mmconfig entry, it seems that
the domain is 0 so there will be no problem, did I miss something?

Thanks
Hanjun
