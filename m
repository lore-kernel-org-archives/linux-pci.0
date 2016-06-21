Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 8/8] irqchip/gicv3-its: Use MADT ITS subtable to do
 PCI/MSI domain initialization
To: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com,
 tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net,
 bhelgaas@google.com, lorenzo.pieralisi@arm.com,
 robert.richter@caviumnetworks.com, shijie.huang@arm.com,
 Suravee.Suthikulpanit@amd.com
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
 <1466420541-20101-9-git-send-email-tn@semihalf.com>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <d5dbe248-673e-698a-7e92-cf4ccdd2051f@linaro.org>
Date: Tue, 21 Jun 2016 16:19:21 +0800
MIME-Version: 1.0
In-Reply-To: <1466420541-20101-9-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: al.stone@linaro.org, graeme.gregory@linaro.org, Catalin.Marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, okaya@codeaurora.org,
 linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, linux-pci@vger.kernel.org,
 mw@semihalf.com, andrea.gallo@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/6/20 19:02, Tomasz Nowicki wrote:
> Let ACPI build ITS PCI MSI domain. ACPI code is responsible for retrieving
> inner domain token and passing it on to its_pci_msi_init_one generic
> init call.
>
> IORT maintains list of registered domain tokens and allows to find
> corresponding domain based on MADT ITS subtable ID info.
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c | 44 ++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> index d2c2496..ae7221c 100644
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -15,6 +15,7 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#include <linux/iort.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> @@ -144,9 +145,52 @@ static int __init its_pci_of_msi_init(void)
>  	return 0;
>  }
>
> +#ifdef CONFIG_ACPI
> +
> +static int __init
> +its_pci_msi_parse_madt(struct acpi_subtable_header *header,
> +		       const unsigned long end)
> +{
> +	struct acpi_madt_generic_translator *its_entry;
> +	struct fwnode_handle *dom_handle;
> +	const char *node_name;
> +	int err = -ENXIO;
> +
> +	its_entry = (struct acpi_madt_generic_translator *)header;
> +	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
> +			      (long)its_entry->base_address);
> +	dom_handle = iort_find_domain_token(its_entry->translation_id);
> +	if (!dom_handle) {
> +		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
> +		goto out;
> +	}
> +
> +	err = its_pci_msi_init_one(dom_handle, node_name);
> +	if (!err)
> +		pr_info("PCI/MSI: %s domain created\n", node_name);
> +
> +out:
> +	kfree(node_name);
> +	return err;
> +}
> +
> +static int __init its_pci_acpi_msi_init(void)
> +{
> +	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
> +			      its_pci_msi_parse_madt, 0);
> +	return 0;
> +}
> +#else
> +static int __init its_pci_acpi_msi_init(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int __init its_pci_msi_init(void)
>  {
>  	its_pci_of_msi_init();
> +	its_pci_acpi_msi_init();
>
>  	return 0;
>  }

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
