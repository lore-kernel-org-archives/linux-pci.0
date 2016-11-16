Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BVYzatwQzHdcYwhHP2Pje7wGoX9_L-jQ3_ZN60z9H=UQ@mail.gmail.com>
References: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160817200022.10418.88555.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CAJ+vNU1e4kKPVG3X-e+gUCf+fZynYpEFTdYTOqP7m0=xQZKqtA@mail.gmail.com> <CAOMZO5BVYzatwQzHdcYwhHP2Pje7wGoX9_L-jQ3_ZN60z9H=UQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 16 Nov 2016 08:15:52 -0800
Message-ID: <CAJ+vNU1BRahcF25UWSDzzFSKJOeU6nEmAQw-eDRJqBHvFFqfHg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] PCI: designware: Add iATU Unroll feature
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jisheng Zhang <jszhang@marvell.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 15, 2016 at 4:30 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Tim,
>
> On Tue, Nov 15, 2016 at 10:22 PM, Tim Harvey <tharvey@gateworks.com> wrote:
>
>> Bjorn / Joao,
>>
>> This patch (from commit a0601a47053714eecec726aea5ebcd829f817497) is
>> causing a kernel regression in 4.9. I can no longer boot the kernel on
>> boards that have a PCIe switch downstream from the IMX6 (ie many of
>> the Gateworks Ventana boards) unless PCI is enabled in the bootloader
>> (which is not recommended as that causes PCI link in the kernel to
>> occasionally fail).
>
> This has been fixed in 4.9-rc4 by the following commit:
>
> commit 416379f9ebded501eda882e6af0a7aafc1866700
> Author: Niklas Cassel <niklas.cassel@axis.com>
> Date:   Fri Oct 14 23:54:55 2016 +0200
>
>     PCI: designware: Check for iATU unroll support after initializing host
>
>     dw_pcie_iatu_unroll_enabled() reads a dbi_base register.  Reading any
>     dbi_base register before pp->ops->host_init has been called causes
>     "imprecise external abort" on platforms like ARTPEC-6, where the PCIe
>     module is disabled at boot and first enabled in pp->ops->host_init.  Move
>     dw_pcie_iatu_unroll_enabled() to dw_pcie_setup_rc(), since it is after
>     pp->ops->host_init, but before pp->iatu_unroll_enabled is actually used.
>
>     Fixes: a0601a470537 ("PCI: designware: Add iATU Unroll feature")
>     Tested-by: James Le Cuirot <chewi@gentoo.org>
>     Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Joao Pinto <jpinto@synopsys.com>
>     Acked-by: Olof Johansson <olof@lixom.net>

Fabio,

That does indeed resolve the issue!

Thanks,

Tim
