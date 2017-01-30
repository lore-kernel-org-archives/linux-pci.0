Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCHv2 0/3] pci: remove msi_controller registration API
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <1482484854-26418-1-git-send-email-thomas.petazzoni@free-electrons.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <dc3d0ac8-bc57-63a6-a4d6-73299c3e16b3@arm.com>
Date: Mon, 30 Jan 2017 10:14:33 +0000
MIME-Version: 1.0
In-Reply-To: <1482484854-26418-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gregory Clement <gregory.clement@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 23/12/16 09:20, Thomas Petazzoni wrote:
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
> Changes between v1 to v2 are described in each individual patch.
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
>  drivers/pci/host/pci-aardvark.c | 172 +++++++++++++++-------------------------
>  drivers/pci/host/pci-mvebu.c    |  17 ----
>  include/linux/of_pci.h          |  11 ---
>  4 files changed, 66 insertions(+), 179 deletions(-)
> 

I somehow missed this series during the Xmas craze. It is definitely a
good cleanup, so for the two patches I haven't Acked yet:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
