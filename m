Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 19 Jul 2017 09:01:50 +0100
From: Will Deacon <will.deacon@arm.com>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 4/4] arm64: allow non-legacy VGA devices to be default
Message-ID: <20170719080150.GB13642@arm.com>
References: <20170719021516.24718-1-dja@axtens.net>
 <20170719021516.24718-5-dja@axtens.net>
MIME-Version: 1.0
In-Reply-To: <20170719021516.24718-5-dja@axtens.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, gabriele.paoloni@huawei.com, airlied@linux.ie,
 linux-pci@vger.kernel.org, z.liuxinliang@hisilicon.com, bhelgaas@google.com,
 alex.williamson@redhat.com, benh@kernel.crashing.org, zourongrong@gmail.com,
 daniel.vetter@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 19, 2017 at 12:15:16PM +1000, Daniel Axtens wrote:
> The VGA arbiter only marks a device as default if it can decode
> legacy I/O and memory ranges. This is often not the case on arm64,
> which doesn't use the legacy ranges.
> 
> Enable the VGA arbiter to mark the first enabled VGA card as
> default.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> ---
> 
> Tested on a D05 using the hibmc card.
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index dfd908630631..cefcbd442e4f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -28,6 +28,7 @@ config ARM64
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>  	select ARCH_WANT_FRAME_POINTERS
> +	select ARCH_WANT_VGA_ARB_FALLBACK
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARM_AMBA
>  	select ARM_ARCH_TIMER
> -- 
> 2.11.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
