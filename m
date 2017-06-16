Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170608141342.2018-8-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <20170608141342.2018-8-lorenzo.pieralisi@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 16 Jun 2017 11:02:13 +0200
Message-ID: <CACRpkdZEV50hZ6kiHmg+=PjFPMHgb2CVFoMMsk1M0DG97sq7KA@mail.gmail.com>
Subject: Re: [RFT PATCH v2 07/42] drivers: pci: host: ftpci100: Fix host
 bridge memory leakage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Wenrui Li <wenrui.li@rock-chips.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 8, 2017 at 4:13 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> When probing the PCI host controller driver, if an error condition
> is trigger the probe function code does not free memory allocated
> for the struct pci_host_bridge resulting in memory leakage.
>
> Move the struct pci_host_bridge allocation over to the respective
> devm interface to fix the issue.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
