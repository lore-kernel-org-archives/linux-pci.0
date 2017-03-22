Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci: dwc: hisi needs PCI_HOST_COMMON
To: Arnd Bergmann <arnd@arndb.de>
References: <20170321143229.3372903-1-arnd@arndb.de>
 <001801d2a25a$9c742760$d55c7620$@gmail.com> <58D1EF1B.1080509@hisilicon.com>
 <CAK8P3a0cuu6nnxNDstq8_QiE2D139k0zyTV13TeLzcT0uLha=Q@mail.gmail.com>
CC: linux-pci <linux-pci@vger.kernel.org>, Kishon <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <58D26D01.9050401@hisilicon.com>
Date: Wed, 22 Mar 2017 20:24:33 +0800
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0cuu6nnxNDstq8_QiE2D139k0zyTV13TeLzcT0uLha=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/3/22 16:00, Arnd Bergmann wrote:
> On Mar 22, 2017 04:27, "Zhou Wang" <wangzhou1@hisilicon.com <mailto:wangzhou1@hisilicon.com>> wrote:
> 
>     On 2017/3/21 23:48, Jingoo Han wrote:
>     > (+cc: Joao Pinto, Zhou Wang, Gabriele Paoloni)
>     >
>     > On Tuesday, March 21, 2017 10:32 AM, Arnd Bergmann wrote:
>     >>
>     >> Without PCI_HOST_COMMON support enabled, we get a link error:
>     >>
>     >> drivers/pci/dwc/built-in.o: In function `hisi_pcie_map_bus':
>     >> pcie-hisi.c:(.text+0x8860): undefined reference to `pci_ecam_map_bus'
>     >> drivers/pci/dwc/built-in.o: In function `hisi_pcie_almost_ecam_probe':
>     >> pcie-hisi.c:(.text+0x88b4): undefined reference to `pci_host_common_probe'
>     >>
>     >> This adds an explicit 'select', as the other users have.
> 
>     Hi Arnd,
> 
>     I wonder if we should select PCI_HOST_GENERIC here, like:
> 
>     diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
>     index dfb8a69..b25dce4 100644
>     --- a/drivers/pci/dwc/Kconfig
>     +++ b/drivers/pci/dwc/Kconfig
>     @@ -89,6 +89,7 @@ config PCI_HISI
>             depends on PCI_MSI_IRQ_DOMAIN
>             select PCIEPORTBUS
>             select PCIE_DW_HOST
>     +       select PCI_HOST_GENERIC
>             help
>               Say Y here if you want PCIe controller support on HiSilicon
>               Hip05 and Hip06 SoCs
> 
> 
> I don't know how that would be better. PCI_HOST_GENERIC is
> a standalone driver for machines that don't need any special
> handling (e.g. SBSA or KVM), while PCI_HOST_COMMON is
> the infrastructure used by both PCI_HISI and PCI_HOST_GENERIC.
> 
> Selecting PCI_HOST_GENERIC would also work as we implicitly
> get PCI_HOST_COMMON, but it would not be clear from reading
> the Kconfig file what the purpose of doing that is.

Yes, you are right. I just disabled PCI_HOST_GENERIC and enabled
PCI_HOST_COMMON to test PCI hosts of HiSilicon and Thunder, a build error
happened.

We can fix this by your PCI: generic: stop hiding pci_host_common_probe declaration.
And select PCI_HOST_COMMON here.

Thanks for pointing this!
Zhou.

> 
>       Arnd
