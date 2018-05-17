Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: Clean up resource allocation in
 devm_of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
 <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
 <CAHp75VeM7_8+9QJjOypXaiBhpWP4B5KACdUQ-p3frbS3jPh=OQ@mail.gmail.com>
 <f35b2972-aa40-5397-facb-765cafe7c315@siemens.com>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-pci@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <97f42f4a-071a-4335-ca65-a0f26adc1b89@mentor.com>
Date: Thu, 17 May 2018 09:23:07 +0300
MIME-Version: 1.0
In-Reply-To: <f35b2972-aa40-5397-facb-765cafe7c315@siemens.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/16/2018 03:31 PM, Jan Kiszka wrote:
> Instead of first allocating and then freeing memory for struct resource
> in case we cannot parse a PCI resource from the device tree, work
> against a local struct and kmemdup it when we decide to go with it.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/pci/of.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index b06585a1da75..fc0f906c5c25 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -266,7 +266,7 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			struct list_head *resources, resource_size_t *io_base)
>  {
>  	struct device_node *dev_node = dev->of_node;
> -	struct resource *res;
> +	struct resource *res, tmp_res;
>  	struct resource *bus_range;
>  	struct of_pci_range range;
>  	struct of_pci_range_parser parser;
> @@ -320,18 +320,16 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
>  			continue;
>  
> -		res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> +		err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
> +		if (err)
> +			continue;
> +
> +		res = devm_kmemdup(dev, &tmp_res, sizeof(tmp_res), GFP_KERNEL);

The change looks okay, apparently probable garbage in tmp_res.desc has no impact.

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
