Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:64636 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760242AbcINN1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 09:27:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, hch@infradead.org,
        Joao.Pinto@synopsys.com, mingkai.hu@nxp.com, m-karicheri2@ti.com,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>, linux-ntb@googlegroups.com
Subject: Re: [RFC PATCH 00/11] pci: support for configurable PCI endpoint
Date: Wed, 14 Sep 2016 15:25:41 +0200
Message-ID: <2837059.ka7z3gzjF2@wuerfel>
In-Reply-To: <1473829927-20466-1-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 14, 2016 10:41:56 AM CEST Kishon Vijay Abraham I wrote:
> This patch series
> 	*) adds PCI endpoint core layer
> 	*) modifies designware/dra7xx driver to be configured in EP mode
> 	*) adds a PCI endpoint *test* function driver

Hi Kishon,

I think this is a great start, thanks for posting early with a clear
list of limitations and TODO items.

I've added the drivers/ntb maintainers to Cc, given that there is
a certain degree of overlap between your work and the existing
code, I think they should be part of the discussion.
 
> Known Limitation:
> 	*) Does not support multi-function devices

If I understand it right, this was a problem for USB and adding
it later made it somewhat inconsistent. Maybe we can at least
try to come up with an idea of how multi-function devices
could be handled even if we don't implement it until someone
actually needs it.

Is your hardware able to make the PCIe endpoint look like
a device with multiple PCI functions, or would one have to
do this in software inside of a single PCI function if we
ever need it?

> TODO:
> 	*) access buffers in RC
> 	*) raise MSI interrupts
> 	*) Enable user space control for the RC side PCI driver

The user space control would end up just being one of several
gadget drivers, right? E.g. gadget drivers for standard hardware
(8250 uart, ATA, NVMe, some ethernet) could be done as kernel
drivers while a user space driver can be used for things that
are more unusual and that don't need to interface to another
part of the kernel?

> 	*) Adapt all other users of designware to use the new design (only
> 	   dra7xx has been adapted)

I don't fully understand this part. Does every designware based
driver need modifications, or are the changes to the
generic parts of the designware driver enough to make it
work for the simpler platforms?

> HOW TO:
> 
> ON THE EP SIDE:
> ***************
> 
> /* EP function is configured using configfs */
> # mount -t configfs none /sys/kernel/config
> 
> /* PCI EP core layer creates "pci_ep" entry in configfs */
> # cd /sys/kernel/config/pci_ep/
> 
> /*
>  * This is the 1st step in creating an endpoint function. This
>  * creates the endpoint function device *instance*. The string
>  * before the .<num> suffix will identify the driver this
>  * EP function will bind to.
>  * Just pci_epf_test is also valid. The .<num> suffix is used
>  * if there are multiple PCI controllers and all of them wants
>  * to use the same function.
>  */
> # mkdir pci_epf_test.0

I haven't used USB gadgets, but I assume this is modeled around
the same interface. If there are notable differences, please mention
what they are. Otherwise the general concept seems rather nice to me.

>  drivers/pci/{host => controller}/Kconfig           |  109 +++++-
>  drivers/pci/{host => controller}/Makefile          |    2 +
>  drivers/pci/{host => controller}/pci-aardvark.c    |    0
>  drivers/pci/{host => controller}/pci-dra7xx.c      |  340 +++++++++++++----
>  drivers/pci/{host => controller}/pci-exynos.c      |    0
>  drivers/pci/{host => controller}/pci-host-common.c |    0
>  .../pci/{host => controller}/pci-host-generic.c    |    0
>  drivers/pci/{host => controller}/pci-hyperv.c      |    0
>  drivers/pci/{host => controller}/pci-imx6.c        |    0
>  drivers/pci/{host => controller}/pci-keystone-dw.c |    0
>  drivers/pci/{host => controller}/pci-keystone.c    |    0
>  drivers/pci/{host => controller}/pci-keystone.h    |    0

Maybe it's better to wait before moving it around, this will make
it harder for you to rebase the patch series while you are working on
it and other people are working on the existing code.

I'd suggest dropping the rename patches for the moment and just work
in drivers/pci/host.

Let's talk (high-level) about the DT binding. I see that the way
you have done it here, one will need to have a different .dtb file
for a machine depending on whether the PCIe is used in host or
endpoint mode. The advantage of this way is that it's a much
cleaner binding (PCIe host bindings are a mess, and adding more
options to it will only make it worse), the downside is that
you can't decide at runtime what you want to use it for. E.g.
connecting two identical machines over PCIe requires deciding
in the bootloader which one is the endpoint, or using DT
overlays, which may be awkward for some users. Is this a realistic
use case, or do you expect that all machines will only ever be
used in one of the two ways?

	Arnd
