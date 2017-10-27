Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v10 6/9] LPC: Support the LPC host on Hip06/Hip07 with DT
 bindings
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
 bhelgaas@google.com, rafael@kernel.org, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <de9f0362-6f2d-2f73-a23a-af248a9b1963@infradead.org>
Date: Fri, 27 Oct 2017 09:44:19 -0700
MIME-Version: 1.0
In-Reply-To: <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, minyard@acm.org, benh@kernel.crashing.org,
 john.garry@huawei.com, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, linux-acpi@vger.kernel.org,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>, linux-pci@vger.kernel.org,
 olof@lixom.net, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 10/27/17 09:11, Gabriele Paoloni wrote:
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 2408ea3..358eed3 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -64,6 +64,15 @@ config BRCMSTB_GISB_ARB
>  	  arbiter. This driver provides timeout and target abort error handling
>  	  and internal bus master decoding.
>  
> +config HISILICON_LPC
> +	bool "Support for ISA I/O space on Hisilicon Hip0X"
> +	depends on (ARM64 && (ARCH_HISI || COMPILE_TEST))
> +	select LOGIC_PIO
> +	select INDIRECT_PIO
> +	help
> +	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
> +	  on Hisilicon Hip0X SoC.
> +
>  config IMX_WEIM
>  	bool "Freescale EIM DRIVER"
>  	depends on ARCH_MXC

Hi,

Why bool? why not tristate?

-- 
~Randy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
