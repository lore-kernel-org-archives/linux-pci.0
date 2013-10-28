Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:46214 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab3J1TBx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2013 15:01:53 -0400
Received: by mail-vc0-f177.google.com with SMTP id ib11so2376979vcb.22
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2013 12:01:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B7046265B4@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
	<CAPcvp5Epf+6tOp+0=ZbBLusCzq4dF98aS+Ou0D7Nyko_VwM8KA@mail.gmail.com>
	<3E54258959B69E4282D79E01AB1F32B704625B1A@DFLE11.ent.ti.com>
	<CAPcvp5EwTb7qm_aMzqJzLX0ScrD3A0VFog1qga76dqTT5cBW3g@mail.gmail.com>
	<3E54258959B69E4282D79E01AB1F32B7046265B4@DFLE11.ent.ti.com>
Date: Mon, 28 Oct 2013 19:01:52 +0000
Message-ID: <CAPcvp5G1-0n-BSrpZ=QXigk9_TGP+vWN4GLLvgFb1+VwP4sjSg@mail.gmail.com>
Subject: Re: AER driver on ARM platform
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 28 October 2013 18:09, Karicheri, Muralidharan <m-karicheri2@ti.com> wrote:
>
> Andrewl,
>
> Thanks. I got some questions on AER irq handling below.
>
> >> > Yes. That was it. It probes the driver now. Did you try error inject feature?
> >>
> >> I did have a look at that, but it really depends on what exactly you want to test. There are
> >> many things this won't help you with, you ought to examine the aer inject driver to see
> >> what it does. For example if you are bringing up a new device and want to see it raise an
> >> AER interrupt then aer inject won't help. In this case you'll need to find a way to trigger real
> >> errors.
> >>
>
> What is the IRQ line tied to the AER driver?

This is well defined by the PCIe standard, and codeified in
init_service_irqs (drivers/pci/pcie/portdrv_core.c) - the code
references sections from the standard. I believe if MSI/MSI-X is not
available then all port service interrupts (AER, PM, HP, etc) are
expected to come in on whatever legacy interrupt is set up in the
device config space (most probably IRQ0). Where MSI/MSI-X are used
there are different rules. There is nothing special about port
services, they come throughout whatever interrupt mechanism is turned
on in the config space, i.e. if MSI's are enabled, then the kernel
wouldn't expect a legacy interrupt...

>
> Since this is handling the root port error irq as well as the upstream/downstream device irqs. Does this driver assumes that error interrupt is raised on Legacy IRQ0 or MSI IRQ 0 for all of the ports (root, downstream and upstream)?

The AER driver will 'attach' to any config space that reports having
an AER capability, and use the interrupt associated with that config
space. I can't remember much about root ports I'm afraid... (but if
the downstream/upstream ports don't have AER capability, perhaps the
errors would propagate towards the RC and be captured by the AER there
(?) and the source can be distinguished by the source ID register)

>
> When I have dumped the irq number in the AER driver it shows Legacy irq0 (when nomsi boot parameter is used) or MSI irq0. Our PCIe IP acts as a RC and has a separate IRQ line (12) for root port irq as below
>
> 12 Error Interrupts
>            [0] System error (OR of fatal, nonfatal, correctable errors) (RC mode only)
>            [1] PCIe fatal error (RC mode only)
>            [2] PCIe non-fatal error (RC mode only)
>            [3] PCIe correctable error (RC mode only)
>            [4] AXI Error due to fatal condition in AXI bridge (EP/RC modes)
>            [5] PCIe advanced error (RC mode only)
>
> Does that mean, I need to modify the AER driver to support separate IRQ line for root port (port_type = PCI_EXP_TYPE_ROOT_PORT) for the hw I am working on. Any help?

The standard (and the AER driver) expect AER errors to be reported via
PCIe interrupts, which are either legacy, MSI or MSI-X interrupts, in
your case the hardware appears to use it's own standard CPU interrupt.
The port service drivers, as far as I'm aware do not support this.

It may be possible that your hardware does the right thing, and that
the AER interrupt above is provided in addition for convenience.

Perhaps someone else here may have a different view...

Andrew Murray
