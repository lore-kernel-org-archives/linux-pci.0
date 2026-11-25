Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795568489;
	b=Bt9QKTtpfqRBumY69WTRhcug+VV8UEyfPEEmZ5X3ZRDioJTCMUUZvgikh0bJAzEr8ilx
	 94VPqDfeI5NRoZQ2JvE8x5M5TN1CVtMLIqSExpX9c4GovZiaYcPDqedtNwxqqghiJu65/
	 wvDruHlWw3VHV/7v4E53vcTnLjxH9pOHqafeJaxV/qomOvElpGnCX3vZjtjfZvYKuOIIZ
	 14gMm3sE0xP/rg0xKJTv74l1LAaSoH6dUU7FOKaCk/X039g/SEXNTON73TIOc+WiM/xaF
	 odeMTupX+ltM31ghHzbCYEynxtzlGkCflb/blmi/OPoZ5VkAcldzRwxmUhKXJV8p1KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795568489;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tD6D7eOpdU3J9Niw++brCIW9sp+eVurU7w2P3fH9VtI=;
	b=n2iE72rD8DHBB3LSi9irTzRv6BCMv8XjNwUhFzx5shcUOLrmxnfOOcoyqhI6JE50MxU+
	 OrnFJozfFqKikpn/QnEFFQKI+svIBSgXy9mk2X/ze70olTMn/xBDY+AqPv/1Qw84T36sj
	 5Ib0ux/fKZfezWhpkz6LkZ2ski380FQutkqauGxFxoWeAPQYuuDBtGdEt60YL7fb9jAjW
	 k8PWMT6UohS7FRiEirtABSfZFfcCgPiEHhqNijsb2glDz8Fl8VLYi2OxapMJw6GH8dymC
	 dZ06LNSPQWyPewWXUfVfIHkqCtYAesKWXTZp64kYqaMgjY+e/1CPAqUL1Cyf7HnThwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emP3rh+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C90606A31E;
	Wed, 25 Nov 2026 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emP3rh+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23951F000C4;
	Wed, 25 Nov 2026 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795568488;
	bh=tD6D7eOpdU3J9Niw++brCIW9sp+eVurU7w2P3fH9VtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=emP3rh+PUBax4VRuK4Q3yqpr5+BKSRMsc6jx68NwEFb944vKzvA5faXk/XTJ4fO3H
	 KrakpyE+t92ov6C6FKXXtkNm6Z3LIAV5YW+CoXQcquiPCcOzpL5PbYUMyIaHF4V8tQ
	 GiVJFb9BwhcGhILcxh3FUttUNLZazpc5btnQlBdqk+YLMc4y2/pjraH01Jx816AOos
	 c6iLUP1neetRKhQb8So+Ov/NgNsFXZ9XwqvDsXCl9tivj/Kq9SvAE2G5kqp17r/oys
	 6wbxIaP1Lf8X3cycn25PHPW0giUO5525omuLocZv+h7TWu4Bjy+GMpQMCO/KLTG7IG
	 WD3ObNlskmSZQ==
Date: Wed, 25 Nov 2026 01:01:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Cc: nathan.lynch@amd.com, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, David Rientjes
 <rientjes@google.com>, John.Kariuki@amd.com, Kinsey Ho
 <kinseyho@google.com>, Mario Limonciello <mario.limonciello@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>,
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 03/25] dmaengine: sdxi: Add PCI initialization
Message-ID: <20261125010121.78c33243@jic23-hlaptop>
In-Reply-To: <20261103-sdxi-base-v4-3-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
	<20261103-sdxi-base-v4-3-3668ccc7aab8@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Nov 2026 20:49:44 -0600
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add enough code to bind a SDXI device via the class code and map its
> control registers and doorbell region.
> 
> Keep PCI resource setup in pci.c and register devices with the SDXI core
> through bus operations.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Just a few quick comments inline.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> new file mode 100644
> index 000000000000..0974a83bb45c
> --- /dev/null
> +++ b/drivers/dma/sdxi/device.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI hardware device driver
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/slab.h>
> +
> +#include "sdxi.h"
> +
> +int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
> +{
> +	struct sdxi_dev *sdxi;
> +
> +	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);

Perhaps switch now to devm_kzalloc_obj() and avoid the churn
if it being updated once applied.  The mass change is there
in rc3.

> +	if (!sdxi)
> +		return -ENOMEM;
> +
> +	sdxi->dev = dev;
> +	sdxi->bus_ops = ops;
> +	dev_set_drvdata(dev, sdxi);
> +
> +	return sdxi->bus_ops->init(sdxi);
> +}
> +EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
> +
> +MODULE_AUTHOR("Wei Huang");
> +MODULE_AUTHOR("Nathan Lynch");
> +MODULE_DESCRIPTION("SDXI core");
> +MODULE_LICENSE("GPL");


> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> new file mode 100644
> index 000000000000..0778cde31f14
> --- /dev/null
> +++ b/drivers/dma/sdxi/pci.c

> +
> +static const struct sdxi_bus_ops sdxi_pci_ops = {
> +	.init = sdxi_pci_init,
> +};
> +
> +static int sdxi_pci_probe(struct pci_dev *pdev,
> +			  const struct pci_device_id *id)
> +{
> +	return sdxi_register(&pdev->dev, &sdxi_pci_ops);

This seems oddly miss balanced. Perhaps it's better to introduce
an empty sdxi_unregister() ready for when it's needed later?


> +}
> +
> +static void sdxi_pci_remove(struct pci_dev *pdev)
> +{
> +	pci_disable_sriov(pdev);
> +}

> +
> +MODULE_IMPORT_NS("SDXI");
> +MODULE_AUTHOR("Wei Huang");
> +MODULE_AUTHOR("Nathan Lynch");
> +MODULE_DESCRIPTION("SDXI PCIe interface driver");
> +MODULE_LICENSE("GPL");
> +module_pci_driver(sdxi_driver);

This is normally placed near the struct pci_driver.  So before all
the MODULE_ macros. I found a few examples of this style, but that
one is much more common and makes sense given this is just generating
boiler plate functions to register etc that structure.

> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> new file mode 100644
> index 000000000000..d4c61ca2f875
> --- /dev/null
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * SDXI device driver header
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef DMA_SDXI_H
> +#define DMA_SDXI_H
> +
> +#include <linux/compiler_types.h>
> +#include <linux/types.h>
> +
> +struct sdxi_dev;
> +
> +/**
> + * struct sdxi_bus_ops - Bus-specific methods for SDXI devices.
> + */
> +struct sdxi_bus_ops {
> +	/**
> +	 * @init: Map control registers and doorbell region, allocate
> +	 *        IRQ ranges. Invoked before bus-agnostic SDXI
> +	 *        function initialization.

Trivial but comment wrap should be closer to 80 chars.

> +	int (*init)(struct sdxi_dev *sdxi);
> +};
> +
> +struct sdxi_dev {
> +	struct device *dev;
> +	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
> +	void __iomem *dbs;		/* virt addr of doorbells */
> +
> +	const struct sdxi_bus_ops *bus_ops;
> +};
> +
> +int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
> +
> +#endif /* DMA_SDXI_H */
> 

