Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 15 Aug 2017 17:58:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCHv2 0/2] PCI: add ls2088a and ls1088a support
Message-ID: <20170815225826.GU32525@bhelgaas-glaptop.roam.corp.google.com>
References: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
In-Reply-To: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Roy Zang <tie-fei.zang@freescale.com>,
 minghuan.lian@nxp.com, robh+dt@kernel.org, bhelgaas@google.com,
 Mingkai Hu <mingkai.hu@freescale.com>, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mingkai, Roy]

On Fri, Aug 04, 2017 at 02:41:32PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Hou Zhiqiang (2):
>   PCI: layerscape: Add support for ls2088a
>   PCI: layerscape: Add support for ls1088a
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt |  2 ++
>  drivers/pci/dwc/pci-layerscape.c                         | 10 ++++++++++
>  2 files changed, 12 insertions(+)

I'll wait to apply this until we get the other series (with the class
code fixes and the layerscape host_init functions) merged.  We also
need an ack from Minghuan, Mingkai, or Roy.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
