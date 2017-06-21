Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170621154136.GA1362@red-moon>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <CACRpkdZ1rBq9eLJkz_gRuXAG=if+xXf-jPzDEPCfG8EgUmUG3A@mail.gmail.com>
 <20170621103042.GA1712@red-moon> <20170621104538.GA8477@red-moon>
 <CACRpkda_6=qWRQDpTy67MFc=-fYRhqWDPx0NnNG5mjXQLyAAkw@mail.gmail.com>
 <20170621154136.GA1362@red-moon>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2017 18:28:39 +0200
Message-ID: <CACRpkdY7tyXZKekyOnXfh8sQuqywHtmZkuK1k55pGXo5Q84nmw@mail.gmail.com>
Subject: Re: [RFT PATCH v2 00/42] PCI: ARM/ARM64: remove pci_fixup_irqs() usage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
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

On Wed, Jun 21, 2017 at 5:41 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> Is the ftpci100.c clock handling being queued for this merge window ?

Yups, it's in Bjorn's tree and visible in linux-next.

> This patch:
>
> https://patchwork.ozlabs.org/patch/778716/
>
> fixes a commit that is not in v4.12-rc6, I need some input to understand
> how to proceed.

Yeah that is just a fix I had to do when fixing this other issue.

It's cool, I just sent a patch. If Bjorn applied your series he can just
apply this on top and all will be fine (for me).

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
