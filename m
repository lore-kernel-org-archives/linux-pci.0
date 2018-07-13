Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 13 Jul 2018 16:27:37 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/3] PCI: mvebu: cleanup and improvements
Message-ID: <20180713152737.GB18555@red-moon>
References: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nadav Haklai <nadavh@marvell.com>, Russell King <linux@arm.linux.org.uk>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 29, 2018 at 11:10:04AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> The main goal of this series is to convert the pci-mvebu driver to use
> the pci_host_bridge API directly instead of using the ARM-specific
> pci_common_init_dev() API. After this series, the last remaining user
> of pci_common_init_dev() is pci-rcar-gen2.
> 
> I would appreciate some careful review of the MEM and IO resource
> related changes (i.e the new mvebu_pcie_parse_request_resources()
> function), since the mvebu driver is a bit special in that respect,
> and cannot use the standard devm_of_pci_get_host_bridge_resources()
> API.
> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (3):
>   PCI: mvebu: Remove redundant platform_set_drvdata() call
>   PCI: mvebu: Convert to use pci_host_bridge directly
>   PCI: mvebu: Drop bogus comment above mvebu_pcie_map_registers()
> 
>  drivers/pci/controller/pci-mvebu.c | 152 +++++++++++++++++--------------------
>  1 file changed, 71 insertions(+), 81 deletions(-)

Hi Thomas,

it does not apply cleanly to v4.18-rc1, can you please rebase it
and send it again so that I can apply it ?

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
