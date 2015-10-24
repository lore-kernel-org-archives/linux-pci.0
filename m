Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <562B36EC.3040406@huawei.com>
Date: Sat, 24 Oct 2015 15:44:44 +0800
From: Hanjun Guo <guohanjun@huawei.com>
MIME-Version: 1.0
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	<bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	<hanjun.guo@linaro.org>, <davem@davemloft.net>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V4 7/8] PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1445442731-28819-8-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1445442731-28819-8-git-send-email-Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Suravee,

Some minor comments  below:

On 2015/10/21 23:52, Suravee Suthikulpanit wrote:
[...]
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index eea8b42..09264f8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -6,12 +6,14 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> -#include <linux/of_pci.h>
> +#include <linux/of_device.h>

Seems it's needed for GICv2m patch but not this one?

>  #include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/cpumask.h>
>  #include <linux/pci-aspm.h>
> +#include <linux/acpi.h>

I think acpi.h should be introduced by the next patch.

> +#include <linux/property.h>

And property.h is also not needed for this patch set.

Thanks
Hanjun

