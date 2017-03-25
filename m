Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 25 Mar 2017 12:58:59 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: mvebu: avoid changing the SCC bit in the link
 status register
Message-ID: <20170325125859.GM7909@n2100.armlinux.org.uk>
References: <E1cTbUq-0008Gj-9u@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <E1cTbUq-0008Gj-9u@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Ping.  This _fix_ doesn't seem to have made it in.

On Tue, Jan 17, 2017 at 09:40:52PM +0000, Russell King wrote:
> It seems on later Armada 38x, the slot clock configuration bit is not
> read-only, but can be written.  This means that our RW1C protection
> ends up clearing this bit when the link control register is written.
> 
> Adjust the mask so that we only avoid writing '1' bits to the RW1C
> bits of this register (bits 15 and 14 of the link status) rather than
> masking out all the status register bits.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/pci/host/pci-mvebu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 58f75c098b42..3ed4cb7501bd 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -827,10 +827,11 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
>  		 * If the mask is 0xffff0000, then we only want to write
>  		 * the link control register, rather than clearing the
>  		 * RW1C bits in the link status register.  Mask out the
> -		 * status register bits.
> +		 * RW1C bits.
>  		 */
>  		if (mask == 0xffff0000)
> -			value &= 0xffff;
> +			value &= ~((PCI_EXP_LNKSTA_LABS |
> +				    PCI_EXP_LNKSTA_LBMS) << 16);
>  
>  		mvebu_writel(port, value, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
>  		break;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
