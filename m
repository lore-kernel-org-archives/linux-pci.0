Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1494261248.2322.21.camel@pengutronix.de>
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
From: Lucas Stach <l.stach@pengutronix.de>
To: Peter Senna Tschudin <peter.senna@collabora.com>
Date: Mon, 08 May 2017 18:34:08 +0200
In-Reply-To: <20170508150224.GA7458@collabora.com>
References: <20170508150224.GA7458@collabora.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 08.05.2017, 17:02 +0200 schrieb Peter Senna Tschudin:
> Hello Kishon,
> 
> Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
> linux-next and I could bisect until:
> 
> commit 442ec4c04d1235f8c664a74004dae54a7a574d18
> Author: Kishon Vijay Abraham I <kishon@ti.com>
> Date:   Wed Feb 15 18:48:14 2017 +0530
> 
>     PCI: dwc: all: Split struct pcie_port into host-only and core structures
> 
> Which seem to be causing our issues. Our device (imx6q-b850v3.dts) boots
> fine with 4.10, and also boots if we disable pcie with:

Are you sure about this bisect? It seems more likely that the secondary
bus scanning goes wrong. It seems Lorenzo Pieralisi's cfg space
non-posting patches landed in next, so the root cause of this might just
be the driver hooking the wrong fault code now.

Async and synchronous aborts are different fault codes on ARM. Can you
see of removing the "16 +" in hook_fault_code() in
drivers/pci/dwc/pci-imx6.c fixes this issue?

Regards,
Lucas


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
