Return-Path: <SRS0=nj2g=3H=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=nj2g=3H=free.fr=slash.tmp@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
From: Mason <slash.tmp@free.fr>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
Message-ID: <dcbf9767-d0bc-03f2-3664-7fd74b96969c@free.fr>
Date: Thu, 30 Mar 2017 13:09:04 +0200
MIME-Version: 1.0
In-Reply-To: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 23/03/2017 14:05, Mason wrote:

> +/*
> + * This should probably be module_platform_driver ?
> + */
> +builtin_platform_driver(tango_pcie_driver);

For the sake of completeness,

ERROR: "pci_ecam_map_bus" [drivers/pci/host/pcie-tango.ko] undefined!
ERROR: "pci_host_common_probe" [drivers/pci/host/pcie-tango.ko] undefined!

The two above functions are currently not exported to modules.

I don't know whether this is intentional.

Regards.
