Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45947 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbdEHQow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2017 12:44:52 -0400
Date: Mon, 8 May 2017 18:44:40 +0200
From: Peter Senna Tschudin <peter.senna@collabora.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
Message-ID: <20170508164440.GB12665@collabora.com>
References: <20170508150224.GA7458@collabora.com>
 <1494261248.2322.21.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494261248.2322.21.camel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 08, 2017 at 06:34:08PM +0200, Lucas Stach wrote:
> Am Montag, den 08.05.2017, 17:02 +0200 schrieb Peter Senna Tschudin:
> > Hello Kishon,
> > 
> > Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
> > linux-next and I could bisect until:
> > 
> > commit 442ec4c04d1235f8c664a74004dae54a7a574d18
> > Author: Kishon Vijay Abraham I <kishon@ti.com>
> > Date:   Wed Feb 15 18:48:14 2017 +0530
> > 
> >     PCI: dwc: all: Split struct pcie_port into host-only and core structures
> > 
> > Which seem to be causing our issues. Our device (imx6q-b850v3.dts) boots
> > fine with 4.10, and also boots if we disable pcie with:
> 
> Are you sure about this bisect? It seems more likely that the secondary
> bus scanning goes wrong. It seems Lorenzo Pieralisi's cfg space
> non-posting patches landed in next, so the root cause of this might just
> be the driver hooking the wrong fault code now.
> 
> Async and synchronous aborts are different fault codes on ARM. Can you
> see of removing the "16 +" in hook_fault_code() in
> drivers/pci/dwc/pci-imx6.c fixes this issue?

changing it to:

hook_fault_code(6, imx6q_pcie_abort_handler, SIGBUS, 0,
		"imprecise external abort");

made no difference, problem persists...

> 
> Regards,
> Lucas
> 
