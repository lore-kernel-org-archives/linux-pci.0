Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 29 Jun 2018 18:30:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] PCI: Clean up resource allocation in
 devm_of_pci_get_host_bridge_resources()
Message-ID: <20180629233034.GH40928@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
 <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
 <CAHp75VeM7_8+9QJjOypXaiBhpWP4B5KACdUQ-p3frbS3jPh=OQ@mail.gmail.com>
 <f35b2972-aa40-5397-facb-765cafe7c315@siemens.com>
MIME-Version: 1.0
In-Reply-To: <f35b2972-aa40-5397-facb-765cafe7c315@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 16, 2018 at 02:31:44PM +0200, Jan Kiszka wrote:
> Instead of first allocating and then freeing memory for struct resource
> in case we cannot parse a PCI resource from the device tree, work
> against a local struct and kmemdup it when we decide to go with it.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied with Vladimir's reviewed-by to pci/resource for v4.19, thanks!

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
>  		if (!res) {
>  			err = -ENOMEM;
>  			goto failed;
>  		}
>  
> -		err = of_pci_range_to_resource(&range, dev_node, res);
> -		if (err) {
> -			devm_kfree(dev, res);
> -			continue;
> -		}
> -
>  		if (resource_type(res) == IORESOURCE_IO) {
>  			if (!io_base) {
>  				dev_err(dev,
> -- 
> 2.13.6

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
