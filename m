Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 27 Mar 2018 14:50:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 0/6] PCI: aardvark: misc fixes and improvements
Message-ID: <20180327195054.GE7759@bhelgaas-glaptop.roam.corp.google.com>
References: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
 <20180327140819.23501-8-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20180327140819.23501-8-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo, who is now maintaining drivers/pci/host/]

On Tue, Mar 27, 2018 at 04:08:13PM +0200, Thomas Petazzoni wrote:
> Hello Bjorn,
> 
> This patch series brings a number of improvements to the aardvark
> PCIe. Sorry for being so slow at sending the v3 after the v2 sent in
> January. Hopefully this time around the series will be fine.
> 
> Changes since v2:
> 
>  - Rebased on v4.16-rc7

No need to rebase to anything other than "master" unless your series
depends on something already merged.

> Evan Wang (2):
>   PCI: aardvark: fix PCIe max read request size setting
>   PCI: aardvark: remove PCIe outbound window configuration
> 
> Thomas Petazzoni (1):
>   PCI: aardvark: introduce an advk_pcie_valid_device() helper
> 
> Victor Gu (3):
>   PCI: aardvark: fix logic in advk_pcie_valid_device()
>   PCI: aardvark: set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
>   PCI: aardvark: use isr1 instead of isr0 interrupt in legacy irq mode

Please capitalize the first word of every title, e.g.,

  PCI: aardvark: Remove PCIe outbound window configuration

and proper nouns, e.g., things directly defined by the spec, as "Max
Read Request Size", as a hint that this has specific meaning and can
be looked up:

  PCI: aardvark: Fix PCIe Max Read Request Size setting

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
