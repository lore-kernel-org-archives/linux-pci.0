Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 23 Apr 2018 16:09:30 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>, sstabellini@kernel.org
Subject: Re: [PATCH 10/12] arm: don't build swiotlb by default
Message-ID: <20180423200930.GB5215@char.us.oracle.com>
References: <20180423170419.20330-1-hch@lst.de>
 <20180423170419.20330-11-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20180423170419.20330-11-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 23, 2018 at 07:04:17PM +0200, Christoph Hellwig wrote:
> swiotlb is only used as a library of helper for xen-swiotlb if Xen support
> is enabled on arm, so don't build it by default.
> 

CCing Stefano
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aa1c187d756d..90b81a3a28a7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1774,7 +1774,7 @@ config SECCOMP
>  	  defined by each seccomp mode.
>  
>  config SWIOTLB
> -	def_bool y
> +	bool
>  
>  config PARAVIRT
>  	bool "Enable paravirtualization code"
> @@ -1807,6 +1807,7 @@ config XEN
>  	depends on MMU
>  	select ARCH_DMA_ADDR_T_64BIT
>  	select ARM_PSCI
> +	select SWIOTLB
>  	select SWIOTLB_XEN
>  	select PARAVIRT
>  	help
> -- 
> 2.17.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
