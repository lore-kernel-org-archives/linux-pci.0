Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix logic OF logic in pci_dma_configure()
To: <rjw@rjwysocki.net>, <bhelgaas@google.com>, <robin.murphy@arm.com>
References: <1447894192-17210-1-git-send-email-Suravee.Suthikulpanit@amd.com>
CC: <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Message-ID: <564D1DB8.7000504@amd.com>
Date: Wed, 18 Nov 2015 18:54:16 -0600
MIME-Version: 1.0
In-Reply-To: <1447894192-17210-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Arg... sorry for the typo in the subject. It should say:

[PATCH] PCI: Fix OF logic in pci_dma_configure()

Suravee

On 11/18/2015 6:49 PM, Suravee Suthikulpanit wrote:
> This patch fixes a bug introduced by previous commit,
> which incorrectly checkes the of_node of the end-point device.
> Instead, it should check the of_node of the host bridge.
>
> Fixes: 50230713b639 ("PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()")
> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/pci/probe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e735c72..edb1984 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1685,8 +1685,8 @@ static void pci_dma_configure(struct pci_dev *dev)
>   {
>   	struct device *bridge = pci_get_host_bridge_device(dev);
>
> -	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> -		if (bridge->parent)
> +	if (IS_ENABLED(CONFIG_OF) &&
> +		bridge->parent && bridge->parent->of_node) {
>   			of_dma_configure(&dev->dev, bridge->parent->of_node);
>   	} else if (has_acpi_companion(bridge)) {
>   		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>

