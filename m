Return-Path: <SRS0=cEnS=25=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=cEnS=25=free.fr=slash.tmp@kernel.org>
Subject: Re: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
From: Mason <slash.tmp@free.fr>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>
References: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
Message-ID: <09f95471-a7c1-033f-0037-ae004623cf82@free.fr>
Date: Mon, 20 Mar 2017 15:14:38 +0100
MIME-Version: 1.0
In-Reply-To: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 17/03/2017 17:11, Mason wrote:

> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
> new file mode 100644
> index 000000000000..9d7fed75fd1d
> --- /dev/null
> +++ b/drivers/pci/host/pcie-tango.c
> @@ -0,0 +1,125 @@
> +#include <linux/pci-ecam.h>
> +
> +#define VENDOR_SIGMA	0x1105
> +
> +/*
> + * How do I reach dev->driver_data in the config accessors?
> + */
> +static void __iomem *mux;

	struct pci_config_window *cfg = bus->sysdata;
	dev_get_drvdata(cfg->parent);


/*
 * struct to hold the mappings of a config space window. This
 * is expected to be used as sysdata for PCI controllers that
 * use ECAM.
 */
struct pci_config_window {
	struct resource			res;
	struct resource			busr;
	void				*priv;
	struct pci_ecam_ops		*ops;
	union {
		void __iomem		*win;	/* 64-bit single mapping */
		void __iomem		**winp; /* 32-bit per-bus mapping */
	};
	struct device			*parent;/* ECAM res was from this dev */
};
