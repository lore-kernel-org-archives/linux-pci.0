Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v5 3/3] pci:aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
Date: Mon, 26 Sep 2016 08:25:10 +0000
Message-ID: <VI1PR0401MB17097C1AE342ADF6F691019092CD0@VI1PR0401MB1709.eurprd04.prod.outlook.com>
References: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
 <1473741659-17618-1-git-send-email-po.liu@nxp.com>
 <1473741659-17618-3-git-send-email-po.liu@nxp.com>
 <20160918005212.GF15478@tiger>
 <VI1PR0401MB1709F91B0C1EB6C80D741E4492F50@VI1PR0401MB1709.eurprd04.prod.outlook.com>
 <20160923130620.GA1486@rob-hp-laptop>
In-Reply-To: <20160923130620.GA1486@rob-hp-laptop>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stuart Yoder <stuart.yoder@nxp.com>, "M.H. Lian" <minghuan.lian@nxp.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Mingkai Hu <mingkai.hu@nxp.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

>  -----Original Message-----
>  From: Rob Herring [mailto:robh@kernel.org]
>  Sent: Friday, September 23, 2016 9:06 PM
>  To: Po Liu
>  Cc: Shawn Guo; linux-pci@vger.kernel.org; linux-arm-
>  kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>  devicetree@vger.kernel.org; Roy Zang; Arnd Bergmann; Marc Zyngier;
>  Stuart Yoder; Leo Li; M.H. Lian; Murali Karicheri; Bjorn Helgaas;
>  Mingkai Hu
>  Subject: Re: [PATCH v5 3/3] pci:aer: add support aer interrupt with none
>  MSI/MSI-X/INTx mode
>  
>  On Sun, Sep 18, 2016 at 03:37:27AM +0000, Po Liu wrote:
>  > Hi Shawn,
>  >
>  >
>  > >  -----Original Message-----
>  > >  From: Shawn Guo [mailto:shawnguo@kernel.org]
>  > >  Sent: Sunday, September 18, 2016 8:52 AM
>  > >  To: Po Liu
>  > >  Cc: linux-pci@vger.kernel.org;
>  > > linux-arm-kernel@lists.infradead.org;
>  > >  linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Roy Zang;
>  > > Arnd  Bergmann; Marc Zyngier; Stuart Yoder; Leo Li; M.H. Lian;
>  > > Murali  Karicheri; Bjorn Helgaas; Mingkai Hu
>  > >  Subject: Re: [PATCH v5 3/3] pci:aer: add support aer interrupt with
>  > > none  MSI/MSI-X/INTx mode
>  > >
>  > >  On Tue, Sep 13, 2016 at 12:40:59PM +0800, Po Liu wrote:
>  > >  > On some platforms, root port doesn't support MSI/MSI-X/INTx in RC
>  mode.
>  > >  > When chip support the aer interrupt with none MSI/MSI-X/INTx
>  > > mode,  > maybe there is interrupt line for aer pme etc. Search the
>  > > interrupt  > number in the fdt file. Then fixup the dev->irq with it.
>  > >  >
>  > >  > Signed-off-by: Po Liu <po.liu@nxp.com>
>  > >
>  > >  Will the new kernel work with existing/old DTB?  I'm trying to
>  > > understand the dependency between driver and DTS changes.
>  >
>  > Yes, We've never use name 'intr' before. So we remove it is ok.
>  > 'aer' is a dts name for researching it's true interrupt number by
>  > kernel. This patch is first time to use name 'aer'. So it must be
>  > compatible with existing/old DTB.
>  
>  Please explain why you are not breaking compatibility in the commit
>  message. I asked for this on v2.

Sorry, I didn't really catch what your means. Do you mean I should add why I remove the 'intr'?

>  
>  > >  > ---
>  > >  > changes for v5:
>  > >  > 	- Add clear 'aer' interrup-names description
>  > >  >
>  > >  >  .../devicetree/bindings/pci/layerscape-pci.txt     | 11 +++++---
>  > >  >  drivers/pci/pcie/portdrv_core.c                    | 31
>  > >  +++++++++++++++++++---
>  > >  >  2 files changed, 35 insertions(+), 7 deletions(-)  >  > diff
>  > > --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>  > >  > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>  > >  > index 41e9f55..101d0a7 100644
>  > >  > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>  > >  > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>  > >  > @@ -18,8 +18,10 @@ Required properties:
>  > >  >  - reg: base addresses and lengths of the PCIe controller  >  -
>  > > interrupts: A list of interrupt outputs of the controller. Must
>  > > contain an
>  > >  >    entry for each entry in the interrupt-names property.
>  > >  > -- interrupt-names: Must include the following entries:
>  > >  > -  "intr": The interrupt that is asserted for controller
>  > > interrupts  > +- interrupt-names: It may be include the following
>  entries:
>  
>  "may be" is not okay. It should be "must" or explain when an interrupt
>  would not be present. Really, differences in interrupts means you need
>  different compatible strings.

How about changing "must" to "should" or "could" and also add when to add after "aer": to explain when to add it?

Thanks!

>  
>  Rob
>  
>  > >  > +  "aer": The interrupt that is asserted for aer interrupt  > +
>  > > "pme": The interrupt that is asserted for pme interrupt  > +  ......
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
