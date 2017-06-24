Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 24 Jun 2017 10:13:28 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Message-ID: <20170624091328.GY4902@n2100.armlinux.org.uk>
References: <20170623214538.25967-1-palmer@dabbelt.com>
MIME-Version: 1.0
In-Reply-To: <20170623214538.25967-1-palmer@dabbelt.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, dalias@libc.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, sparclinux@vger.kernel.org,
 gxt@mprc.pku.edu.cn, ysato@users.sourceforge.jp, hch@infradead.org,
 geert@linux-m68k.org, linux-pci@vger.kernel.org, mattst88@gmail.com,
 linux-snps-arc@lists.infradead.org, cmetcalf@mellanox.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru,
 viro@zeniv.linux.org.uk, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, rth@twiddle.net, vgupta@synopsys.com,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, linux-alpha@vger.kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
> We wanted to add RISC-V to the list of architectures that used the
> generic PCI setup-irq.o inside the Makefile and it was suggested that
> instead we define a Kconfig entry and use that.
> 
> I've done very minimal testing on this: I just checked to see that
> an aarch64 defconfig still build setup-irq.o with the patch applied.
> The intention is that this patch doesn't change the behavior of any
> build.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Looks fine from an ARM point of view, thanks.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e0cacb7b8563..658c9f95ab3f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -131,6 +131,9 @@ config PCI_HYPERV
>            The PCI device frontend driver allows the kernel to import arbitrary
>            PCI devices from a PCI backend to support PCI driver domains.
>  
> +config PCI_GENERIC_SETUP
> +	def_bool n

	bool

would be sufficient here - the default is 'n' for all options.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
