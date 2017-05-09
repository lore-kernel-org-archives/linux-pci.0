Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170508150224.GA7458@collabora.com>
References: <20170508150224.GA7458@collabora.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 May 2017 22:30:13 -0300
Message-ID: <CAOMZO5DjFxAus3B03Om0xoqxKuY2TkbcjCY1YEUK9s_R8C_DNA@mail.gmail.com>
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
To: Peter Senna Tschudin <peter.senna@collabora.com>
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
 Jingoo Han <jingoohan1@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Peter,

On Mon, May 8, 2017 at 12:02 PM, Peter Senna Tschudin
<peter.senna@collabora.com> wrote:
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

I can reproduce the same problem on a custom imx6q board with a PCI bridge chip.

Other mx6 boards without PCI bridge boot fine.

I haven't bisected it, but the problem for me does not happen on 4.11.
It happens only in linux-next.

The commit you mentioned above is from 4.11 and does not cause the
problem on my tests.

Can you double check if you really have issues with 4.11?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
