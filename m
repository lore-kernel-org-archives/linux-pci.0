Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "M.h. Lian" <minghuan.lian@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: RE: [PATCHv2 0/2] PCI: add ls2088a and ls1088a support
Date: Wed, 30 Aug 2017 01:37:09 +0000
Message-ID: <VI1PR04MB1615F2A640C2FB89F5B56380E89C0@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170829221954.GT8154@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170829221954.GT8154@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "M.h. Lian" <minghuan.lian@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Roy Zang <tie-fei.zang@freescale.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks a lot.

 Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>


Thanks,
Minghuan

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Wednesday, August 30, 2017 6:20 AM
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> bhelgaas@google.com; robh+dt@kernel.org; M.h. Lian
> <minghuan.lian@nxp.com>; shawnguo@kernel.org; Minghuan Lian
> <minghuan.Lian@freescale.com>; Mingkai Hu <mingkai.hu@freescale.com>;
> Roy Zang <tie-fei.zang@freescale.com>
> Subject: Re: [PATCHv2 0/2] PCI: add ls2088a and ls1088a support
> 
> [+cc Minghuan, Mingkai, Roy]
> 
> On Fri, Aug 04, 2017 at 02:41:32PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Hou Zhiqiang (2):
> >   PCI: layerscape: Add support for ls2088a
> >   PCI: layerscape: Add support for ls1088a
> >
> >  Documentation/devicetree/bindings/pci/layerscape-pci.txt |  2 ++
> >  drivers/pci/dwc/pci-layerscape.c                         | 10 ++++++++++
> >  2 files changed, 12 insertions(+)
> 
> These still apply cleanly, but I haven't seen an ack from the driver maintainers.
> 
> Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
