Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 5/7] PCI: dwc: all: Modify dbi accessors to access data
 of 4/2/1 bytes
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-arm-kernel@axis.com>
References: <1488880372-7390-1-git-send-email-kishon@ti.com>
 <1488880372-7390-6-git-send-email-kishon@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <090d9947-8003-4608-5e3a-92f62f90eda6@synopsys.com>
Date: Tue, 7 Mar 2017 11:18:35 +0000
MIME-Version: 1.0
In-Reply-To: <1488880372-7390-6-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, nsekhar@ti.com,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali
 Karicheri <m-karicheri2@ti.com>, Niklas Cassel <niklas.cassel@axis.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

=C0s 9:52 AM de 3/7/2017, Kishon Vijay Abraham I escreveu:
> Previously dbi accessors can be used to access data of size 4
> bytes. But there might be situations (like accessing
> MSI_MESSAGE_CONTROL in order to set/get the number of required
> MSI interrupts in EP mode) where dbi accessors must
> be used to access data of size 2. This is in preparation for
> adding endpoint mode support to designware driver.
> =

> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Niklas Cassel <niklas.cassel@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/Kconfig                |   18 ++++----
>  drivers/pci/dwc/pci-dra7xx.c           |    8 ++--
>  drivers/pci/dwc/pci-exynos.c           |   16 +++----
>  drivers/pci/dwc/pci-imx6.c             |   54 +++++++++++-----------
>  drivers/pci/dwc/pci-keystone-dw.c      |   13 +++---
>  drivers/pci/dwc/pcie-armada8k.c        |   38 ++++++++--------
>  drivers/pci/dwc/pcie-artpec6.c         |    6 +--
>  drivers/pci/dwc/pcie-designware-host.c |   18 ++++----
>  drivers/pci/dwc/pcie-designware.c      |   77 +++++++++++++++++++-------=
------
>  drivers/pci/dwc/pcie-designware.h      |   14 +++---
>  drivers/pci/dwc/pcie-hisi.c            |   14 +++---
>  11 files changed, 147 insertions(+), 129 deletions(-)
> =

> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index dfb8a69..cb3d5d0 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -36,7 +36,7 @@ config PCIE_DW_PLAT
>  config PCI_EXYNOS
>  	bool "Samsung Exynos PCIe controller"
>  	depends on PCI
> -	depends on SOC_EXYNOS5440
> +	depends on SOC_EXYNOS5440 || COMPILE_TEST

Kishon, I have the idea that Bjorn suggested some time ago not to use
COMPILE_TEST, because there were some problems in some drivers that needed
specific arch stuff.

Bjorn: Could you please confirm?

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
