Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 1/2] freescale/dts: add pcie aer interrupt-name property
 in the dts
Date: Thu, 2 Jun 2016 01:17:24 +0000
Message-ID: <VI1PR0401MB1709DFD5A437FD01D724FF9F92580@VI1PR0401MB1709.eurprd04.prod.outlook.com>
References: <1464242349-15323-1-git-send-email-po.liu@nxp.com>
 <20160601143950.GA1817@rob-hp-laptop>
In-Reply-To: <20160601143950.GA1817@rob-hp-laptop>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Roy Zang <roy.zang@nxp.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stuart Yoder <stuart.yoder@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Yang-Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


>  -----Original Message-----
>  From: Rob Herring [mailto:robh@kernel.org]
>  Sent: Wednesday, June 01, 2016 10:40 PM
>  To: Po Liu
>  Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>  linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Shawn Guo;
>  Marc Zyngier; Roy Zang; Mingkai Hu; Stuart Yoder; Yang-Leo Li; Arnd
>  Bergmann; Bjorn Helgaas; Minghuan Lian
>  Subject: Re: [PATCH 1/2] freescale/dts: add pcie aer interrupt-name
>  property in the dts
>  
>  On Thu, May 26, 2016 at 01:59:09PM +0800, Po Liu wrote:
>  > Freescale some platforms aer interrupt was not MSI/MSI-X/INTx
>  
>  some or all?

For all Layerscape platforms, that should be clear, sorry.

>  
>  > but using interrupt line independently. This patch add a "aer"
>  > interrupt-names for aer interrupt.
>  
>  You are not adding, but replacing the interrupt. This needs a better
>  explanation as you are breaking compatibility.

We used to the "intr" name for general concept, but no use. So removed.
In the Layerscape platform, the aer and pme interrupt lines are independent, 
not in the Complex Root by MSI or MSIX, so need to read from the DTS before
MSIX and MSI searching for pci service driver.
 
>  
>  Rob
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
