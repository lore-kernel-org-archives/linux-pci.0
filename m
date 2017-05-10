Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1494423139.2322.60.camel@pengutronix.de>
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 May 2017 15:32:19 +0200
In-Reply-To: <CAOMZO5CwtT=Zz8+CrT2TA5W7YHFRnDKgthRyChvUpF+f_QsYcQ@mail.gmail.com>
References: <20170508150224.GA7458@collabora.com>
 <CAOMZO5DjFxAus3B03Om0xoqxKuY2TkbcjCY1YEUK9s_R8C_DNA@mail.gmail.com>
 <20170509063439.GC9791@collabora.com>
 <CAOMZO5CXjb7LVT5ByP1RqgBPkkfRn7PcRPmW3hos=UNXGnok=A@mail.gmail.com>
 <20170510131722.GA29556@collabora.com>
 <CAOMZO5CwtT=Zz8+CrT2TA5W7YHFRnDKgthRyChvUpF+f_QsYcQ@mail.gmail.com>
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
 Jingoo Han <jingoohan1@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Peter Senna Tschudin <peter.senna@collabora.com>,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 10.05.2017, 10:27 -0300 schrieb Fabio Estevam:
> On Wed, May 10, 2017 at 10:17 AM, Peter Senna Tschudin
> <peter.senna@collabora.com> wrote:
> > On Tue, May 09, 2017 at 07:21:24AM -0300, Fabio Estevam wrote:
> >> Hi Peter,
> >>
> >> On Tue, May 9, 2017 at 3:34 AM, Peter Senna Tschudin
> >> <peter.senna@collabora.com> wrote:
> >>
> >> > Something that ocurred to me is that u-boot is initializing the PCI, and
> >> > the PCI networkd cards.  Ideally this should not affect anything, but
> >> > can this be related to the issue?
> >>
> >> Yes, in order to narrow things down: please boot 4.11 without PCI
> >> support in U-Boot.
> >
> > Yes, removing the PCI code from u-boot makes 4.11 to boot. But latest
> > next still hangs.
> 
> Ok, good. At least we see the same behaviour now.
> 
> We still need a fix for the mx6q hang on systems with PCI switch for
> linux/next or 4.12-rc1.

I will take a look at this today.

> 
> >> The problem is that mx6q does not have a way to properly reset the PCI block.
> >>
> >> On the board I tested there is no PCI support in U-Boot.
> >>
> >> Maybe we need the following approach in U-Boot as Lucas did for Barebox:
> >> https://git.pengutronix.de/cgit/barebox/commit/?id=f1da98da2760c21487bbba8f7fb957c843a22896
> >
> > Maybe we do need, but the kernel is working on v4.10 for our use case,
> > and it is not working any longer on v4.11. What is the way to continue
> > from here?
> 
> There is no other way other than fixing U-Boot on this case.

You could also revert the change in the kernel if you are absolutely
sure that this won't cause issues on your system (you are not using the
internal watchdog etc.).

But for the long run and to make sure that _all_ use-cases work
properly, there is no way around fixing your bootloader to behave
correctly.

Regards,
Lucas


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
