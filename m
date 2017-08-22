Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 22 Aug 2017 16:36:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v2 0/3] PCI: mediatek: Add MSI support for MT2712 and
 MT7622
Message-ID: <20170822213602.GK6948@bhelgaas-glaptop.roam.corp.google.com>
References: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 14, 2017 at 09:04:25PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> MT2712 and MT7622's PCIe host controller support MSI, but only 32bit MSI
> address are supportted. It connect to GIC with the same IRQ number of INTx
> IRQ, so it shares the same IRQ with INTx IRQ.
> 
> This patchset add MSI support for MT2712 and MT7622.
> Also do some code fixup and cleanups.
> 
> Change Since V1:
>  - Add the first two patches into this patchset.
>  - Using -ENODEV instead of PTR_ERR if msi_domain == NULL
>  - Change the error logs with consistency of lower-case
>  - Using has_msi instead of support_msi to make the parameter name a bit shorter
> 
> Honghui Zhang (3):
>   PCI: mediatek: Fix return value in case of error
>   PCI: mediatek: take use of bus->sysdata to get host private data
>   PCI: mediatek: add msi support for MT2712 and MT7622
> 
>  drivers/pci/host/pcie-mediatek.c | 157 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 151 insertions(+), 6 deletions(-)

Just waiting for an ack from Ryder...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
