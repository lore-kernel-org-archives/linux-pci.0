Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 20 Oct 2017 13:28:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCHv2 0/2] PCI: layerscape: add fixes for layerscape-pcie
 errata
Message-ID: <20171020182845.GM6332@bhelgaas-glaptop.roam.corp.google.com>
References: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
In-Reply-To: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: roy.zang@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 minghuan.lian@nxp.com, linux-arm-kernel@lists.infradead.org,
 bhelgaas@google.com, mingkai.hu@nxp.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 12, 2017 at 05:44:46PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The [1/2] is to fix layerscape PCIe MSI/MSI-X capability errata.
> The [2/2] is to change the default AXI system error response behavior
> for PCI Express outbound non-posted requests.
> 
> Hou Zhiqiang (1):
>   PCI: Disable MSI for Freescale PCIe RC mode
> 
> Minghuan Lian (1):
>   pci/layerscape: change the default error response behavior
> 
>  drivers/pci/dwc/pci-layerscape.c | 11 +++++++++++
>  drivers/pci/quirks.c             |  8 ++++++++
>  2 files changed, 19 insertions(+)

Applied to pci/host-layerscape for v4.15, thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
