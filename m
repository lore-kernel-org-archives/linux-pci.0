Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 14 Mar 2017 15:15:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 0/3] pci: remove msi_controller registration API
Message-ID: <20170314201524.GF26264@bhelgaas-glaptop.roam.corp.google.com>
References: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
In-Reply-To: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 Hanna Hawa <hannah@marvell.com>, Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Kumar Gala <galak@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 28, 2017 at 03:31:13PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> This small patch series aims at removing the small msi_controller
> registration API implemented in drivers/of/of_pci.c.
> 
> In order to do so, it moves the last two users of this API to the
> generic MSI support:
> 
>  - The pci-aardvark driver is moved to use the generic MSI
>    support. This driver is both the provider of the MSI capability and
>    the consumer of this capability.
> 
>  - The pci-mvebu driver is cleaned up from using the msi_controller
>    registration API. This driver is only consuming MSI capabilies from
>    another driver (irq-armada-370-xp) which was migrated to the
>    generic MSI support some time ago. Therefore, this patch is simply
>    removing dead code.
> 
> Finally, the last commit removed the now unused API.
> 
> Changes between v2 and v3 are described in each individual patch.
> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (3):
>   pci: pci-aardvark: move to MSI handling using generic MSI support
>   pci: pci-mvebu: remove useless MSI enabling code
>   of: pci: remove unused MSI controller helpers
> 
>  drivers/of/of_pci.c             |  45 -----------
>  drivers/pci/host/pci-aardvark.c | 173 ++++++++++++++++------------------------
>  drivers/pci/host/pci-mvebu.c    |  17 ----
>  include/linux/of_pci.h          |  11 ---
>  4 files changed, 67 insertions(+), 179 deletions(-)

Applied to pci/msi for v4.12, thanks!

I think Marc's ack on 1/30 applies to the first two, so I added it to them.

Oh, and I'll drop the other aardvark change that removes the same bits of
unused "msi-parent" code from advk_pcie_probe().

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
