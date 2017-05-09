Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170120155837.2874-1-l.stach@pengutronix.de>
References: <20170120155837.2874-1-l.stach@pengutronix.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 9 May 2017 09:24:20 -0700
Message-ID: <CAJ+vNU1LqNRNEEX4NH3uyiw-xS-07zU94drhGOewwYM5UOs87Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: remove LTSSM disable workaround
To: Lucas Stach <l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 patchwork-lst@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 20, 2017 at 7:58 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> This causes CPU hangs when the system is reset by the watchdog, as
> the GPRs aren't cleared, but the clocks are back to disabled state.
>
> If the bootloader uses PCIe, it must take care to bring it down
> into a safe state, before passing control to the Linux kernel.
> This is the only way to get a properly operating system at all
> times and circumstances.
>

Lucas,

I missed this patch when it came through.

Can you give some details about what you consider a 'safe state' for
the bootloader to bring PCI to before passing control to the kernel
(with respect to PERST#, PCI CLK, and the various host controller
registers)? I would like to investigate making PCI available in the
bootloader as well as the kernel reliable on IMX6.

Regards,

Tim

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
