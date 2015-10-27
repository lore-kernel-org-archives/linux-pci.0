Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 27 Oct 2015 09:38:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
	catalin.marinas@arm.com, will.deacon@arm.com,
	hanjun.guo@linaro.org, thomas.lendacky@amd.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH V4 7/8] PCI: OF: Move of_pci_dma_configure() to
 pci_dma_configure()
Message-ID: <20151027143812.GB8660@localhost>
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1445442731-28819-8-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445442731-28819-8-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Suravee,

On Wed, Oct 21, 2015 at 08:52:10AM -0700, Suravee Suthikulpanit wrote:
> This patch move of_pci_dma_configure() to a more generic
> pci_dma_configure(), which can be extended by non-OF code (e.g. ACPI).

> -void of_pci_dma_configure(struct pci_dev *pci_dev)
> -{
> -	struct device *dev = &pci_dev->dev;
> -	struct device *bridge = pci_get_host_bridge_device(pci_dev);
> -
> -	if (!bridge->parent)
> -		return;
> -
> -	of_dma_configure(dev, bridge->parent->of_node);
> -	pci_put_host_bridge_device(bridge);
> -}

> +static void pci_dma_configure(struct pci_dev *dev)
> +{
> +	struct device *bridge = pci_get_host_bridge_device(dev);
> +
> +	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> +		if (!bridge->parent)
> +			return;

Don't we leak a bridge reference here?  This looks like it was a problem in
the original code, not something you added.  Ideally I guess I would add a
new patch that only fixes the leak in the original code, followed by this
patch that moves it from of_pci_dma_configure() to pci_dma_configure().

> +
> +		of_dma_configure(&dev->dev, bridge->parent->of_node);
> +	}
> +
> +	pci_put_host_bridge_device(bridge);
> +}
