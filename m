Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] pci: Add and use PCI_GENERIC_SETUP Kconfig entry
To: Palmer Dabbelt <palmer@dabbelt.com>, ink@jurassic.park.msu.ru,
 mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will.deacon@arm.com, geert@linux-m68k.org,
 ralf@linux-mips.org, ysato@users.sourceforge.jp, dalias@libc.org,
 davem@davemloft.net, cmetcalf@mellanox.com, gxt@mprc.pku.edu.cn,
 bhelgaas@google.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-pci@vger.kernel.org, hch@infradead.org
References: <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
 <20170623220857.28774-1-palmer@dabbelt.com>
 <20170623220857.28774-2-palmer@dabbelt.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <60bd9a54-0220-5d52-8843-ea3a654020a6@twiddle.net>
Date: Sat, 24 Jun 2017 08:08:43 -0700
MIME-Version: 1.0
In-Reply-To: <20170623220857.28774-2-palmer@dabbelt.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 06/23/2017 03:08 PM, Palmer Dabbelt wrote:
> We wanted to add RISC-V to the list of architectures that used the
> generic PCI setup-irq.o inside the Makefile and it was suggested that
> instead we define a Kconfig entry and use that.
> 
> I've done very minimal testing on this: I just checked to see that
> an aarch64 defconfig still build setup-irq.o with the patch applied.
> The intention is that this patch doesn't change the behavior of any
> build.
> 
> Signed-off-by: Palmer Dabbelt<palmer@dabbelt.com>
> Reviewed-by: James Hogan<james.hogan@imgtec.com>
> ---
>   arch/alpha/Kconfig     |  1 +

Acked-by: Richard Henderson <rth@twiddle.net>


r~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
