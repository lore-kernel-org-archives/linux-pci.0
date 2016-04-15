Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, jcm@redhat.com,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, wangyijing@huawei.com, mw@semihalf.com
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic ECAM API
Date: Fri, 15 Apr 2016 20:39:27 +0200
Message-ID: <5110401.mGEq6IVFz2@wuerfel>
In-Reply-To: <1460740008-19489-9-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <1460740008-19489-9-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 15 April 2016 19:06:43 Tomasz Nowicki wrote:
> -MODULE_DEVICE_TABLE(of, thunder_pem_of_match);
> -
> -static int thunder_pem_probe(struct platform_device *pdev)
> +static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg)
>  {
> -       struct device *dev = &pdev->dev;
> -       const struct of_device_id *of_id;
>         resource_size_t bar4_start;
>         struct resource *res_pem;
>         struct thunder_pem_pci *pem_pci;
> +       struct platform_device *pdev;
>  
>         pem_pci = devm_kzalloc(dev, sizeof(*pem_pci), GFP_KERNEL);
>         if (!pem_pci)
>                 return -ENOMEM;
>  
> -       of_id = of_match_node(thunder_pem_of_match, dev->of_node);
> -       pem_pci->gen_pci.cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
> +       pdev = to_platform_device(dev);
>  
>         /*
>          * The second register range is the PEM bridge to the PCIe
> @@ -330,7 +298,29 @@ static int thunder_pem_probe(struct platform_device *pdev)
>         pem_pci->ea_entry[1] = (u32)(res_pem->end - bar4_start) & ~3u;
>         pem_pci->ea_entry[2] = (u32)(bar4_start >> 32);
>  
> -       return pci_host_common_probe(pdev, &pem_pci->gen_pci);
> +       cfg->priv = pem_pci;
> +       return 0;
> +}
> +
> 

I still think it would be better to keep the loadable PCI host drivers
separate from the ACPI PCI infrastructure. There are a number of
simplifications that we want to do to the DT based drivers in the long
run, so it's better if that code is not shared at this level. Abstracting
out the ECAM code is fine, but at that point you should be able to just
call it from the ACPI layer.

	Arnd
