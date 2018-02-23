Return-Path: <SRS0=fr7Z=FR=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=fr7Z=FR=arm.com=lorenzo.pieralisi@kernel.org>
Date: Fri, 23 Feb 2018 11:52:50 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: helgaas@kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, tfiga@chromium.org,
	paul.burton@mips.com, m.szyprowski@samsung.com,
	egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
	mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
	robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
	will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
	yamada.masahiro@socionext.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 20/20] x86/PCI: VMD: Fix malformed Kconfig default
Message-ID: <20180223115242.GA21946@e107981-ln.cambridge.arm.com>
References: <0180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
 <20180206221106.16620-1-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180206221106.16620-1-ulfalizer@gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 06, 2018 at 11:11:06PM +0100, Ulf Magnusson wrote:
> 'default N' should be 'default n', though they happen to have the same
> effect here, due to undefined symbols (N in this case) evaluating to n
> in a tristate sense.
> 
> Remove the default instead of changing it. bool and tristate symbols
> implicitly default to n.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.

I have remove this link - it can become stale so I do not think it is
worth adding it to the log.

I have also reworded the $SUBJECT.

Applied to pci/host/misc for v4.17, let me know if that's fine for you.

Thanks,
Lorenzo

> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
> Changes in v2:
> Make it clear that Kconfig is involved.
> 
>  drivers/pci/host/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index a4ed7484d127..dc8a2a175f19 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -215,7 +215,6 @@ config PCIE_TANGO_SMP8759
>  config VMD
>  	depends on PCI_MSI && X86_64 && SRCU
>  	tristate "Intel Volume Management Device Driver"
> -	default N
>  	---help---
>  	  Adds support for the Intel Volume Management Device (VMD). VMD is a
>  	  secondary PCI host bridge that allows PCI Express root ports,
> -- 
> 2.14.1
> 
