Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51521421.9020906@gmail.com>
Date: Tue, 26 Mar 2013 16:33:21 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
CC: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	linux-samsung-soc@vger.kernel.org,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Andrew Murray' <andrew.murray@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] pci: Add PCIe driver for Samsung Exynos
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com> <00c301ce277b$f2790080$d76b0180$%han@samsung.com>
In-Reply-To: <00c301ce277b$f2790080$d76b0180$%han@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/22/2013 11:07 PM, Jingoo Han wrote:
> Exynos5440 has a PCIe controller which can be used as Root Complex.
> This driver supports a PCIe controller as Root Complex mode.
> 
> Signed-off-by: Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
> Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  .../devicetree/bindings/pci/exynos-pcie.txt        |   56 +
>  drivers/pci/host/Kconfig                           |    5 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-exynos.c                      | 1139 ++++++++++++++++++++
>  4 files changed, 1201 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/exynos-pcie.txt
>  create mode 100644 drivers/pci/host/Makefile
>  create mode 100644 drivers/pci/host/pci-exynos.c

[...]

> +
> +/* synopsis specific PCIE configuration registers*/

If this is a standard IP block, then the driver naming should reflect
that. I suspect there are several others with the same IP block.

Rob
