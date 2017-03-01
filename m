Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 Mar 2017 01:54:42 +0200
Message-ID: <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
Subject: Re: [PATCH 07/20] PCI: implement Devres interface to map PCI config
 space
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Jonathan Corbet <corbet@lwn.net>, Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 27, 2017 at 5:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> The introduction of the pci_remap_cfgspace() interface allows
> PCI host controller drivers to map PCI config space through a
> dedicated kernel interface. Current PCI host controller drivers
> use the devm_ioremap_* Devres interfaces to map PCI configuration
> space regions so in order to update them to the new
> pci_remap_cfgspace() mapping interface a new set of Devres interfaces
> should be implemented so that PCI host controller drivers can make
> use of them.
>
> Introduce two new functions in the PCI kernel layer and Devres
> documentation:
>
> - devm_pci_remap_cfgspace()
> - devm_pci_remap_cfg_resource()
>
> so that PCI host controller drivers can make use of them to map
> PCI configuration space regions.

Wouldn't you like to be consistent with current PCI API, i.e.:
1. devm_*() functions called pcim_*() in PCI.
2. If you may notice there is no separate pcim_*map*() stuff, they are
dynamically adapting to the case.

?

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
