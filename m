Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 28 Jun 2017 14:53:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v5 1/2] PCI: mediatek: Add Mediatek PCIe host controller
 support
Message-ID: <20170628195325.GR17844@bhelgaas-glaptop.roam.corp.google.com>
References: <1495338145-9384-1-git-send-email-ryder.lee@mediatek.com>
 <1495338145-9384-2-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1495338145-9384-2-git-send-email-ryder.lee@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Red Hung <red.hung@mediatek.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 21, 2017 at 11:42:24AM +0800, Ryder Lee wrote:
> Add support for the Mediatek PCIe Gen2 controller which can
> be found on MT7623 series SoCs.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/host/Kconfig         |  11 +
>  drivers/pci/host/Makefile        |   1 +
>  drivers/pci/host/pcie-mediatek.c | 553 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 565 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-mediatek.c
>...

> +static int mtk_pcie_register_host(struct pci_host_bridge *host)
> +{
> +	struct mtk_pcie *pcie = pci_host_bridge_priv(host);
> +	struct pci_bus *child;
> +	int err;
> +
> +	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);

Do you really need the PCI_REASSIGN_ALL_RSRC and PCI_REASSIGN_ALL_BUS
flags?  I'd like to get rid of them because we should automatically
assign resources if the firmware hasn't done it.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
