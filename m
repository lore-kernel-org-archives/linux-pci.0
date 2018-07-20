Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
In-Reply-To: <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 20 Jul 2018 08:33:58 -0700
Message-ID: <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
To: Leonard Crestez <leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Joao.Pinto@synopsys.com,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-pm@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, lorenzo.pieralisi@arm.com,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 20, 2018 at 5:48 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
>
> That commit followed the reference manual but unfortunately the imx7d
> manual is incorrect.
>

I'd also add similar comment to DT file to prevent people from trying
to "fix" this in the future.

Also, this change is going to break QEMU's mapping found here:

https://git.qemu.org/?p=qemu.git;a=blob;f=hw/arm/fsl-imx7.c;h=d5e26855a552e2d52b91f0435a607fae2f88456b;hb=HEAD#l464

any change you are planning to make the change there as well?

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
