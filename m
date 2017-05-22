Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1495423665.21021.6.camel@mtkswgap22>
Subject: Re: [PATCH v3 1/2] PCI: mediatek: Add Mediatek PCIe host controller
 support
From: Ryder Lee <ryder.lee@mediatek.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 22 May 2017 11:27:45 +0800
In-Reply-To: <CAP=VYLrjeq57S+o0bBBH4oi8Bgwp=XgTsdO8RkWY8xuJyhLP9g@mail.gmail.com>
References: <1494382020-26790-1-git-send-email-ryder.lee@mediatek.com>
 <1494382020-26790-2-git-send-email-ryder.lee@mediatek.com>
 <CAP=VYLrjeq57S+o0bBBH4oi8Bgwp=XgTsdO8RkWY8xuJyhLP9g@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Red Hung <red.hung@mediatek.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2017-05-20 at 15:46 -0400, Paul Gortmaker wrote:
> On Tue, May 9, 2017 at 10:06 PM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> > Add support for the Mediatek PCIe Gen2 controller which can
> > be found on MT7623 series SoCs.
> >
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pci/host/Kconfig         |  11 +
> >  drivers/pci/host/Makefile        |   1 +
> >  drivers/pci/host/pcie-mediatek.c | 563 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 575 insertions(+)
> >  create mode 100644 drivers/pci/host/pcie-mediatek.c
> >
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index f7c1d4d..aef0de9 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -174,6 +174,17 @@ config PCIE_ROCKCHIP
> >           There is 1 internal PCIe port available to support GEN2 with
> >           4 slots.
> >
> > +config PCIE_MEDIATEK
> > +       bool "Mediatek PCIe controller"
> 
> You've got bool here and correctly use the builtin register
> function, but you still have a couple stray references to
> the module.h header and MODULE macros.  Can you
> please also clean them up and resend with those gone?
> 
> Thanks,
> Paul.
> --

> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> 
> [....]
> 
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_pcie_ids);
> > +
> > +static struct platform_driver mtk_pcie_driver = {
> > +       .probe = mtk_pcie_probe,
> > +       .driver = {
> > +               .name = "mtk-pcie",
> > +               .of_match_table = mtk_pcie_ids,
> > +               .suppress_bind_attrs = true,
> > +       },
> > +};
> > +
> > +builtin_platform_driver(mtk_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Mediatek PCIe host controller driver.");
> > +MODULE_LICENSE("GPL v2");


I've already removed them at patch v5. Thanks a lot, Paul!



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
