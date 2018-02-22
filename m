Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751669AbeBVXAz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 18:00:55 -0500
Date: Thu, 22 Feb 2018 17:00:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org,
        vgupta@synopsys.com, mgorman@techsingularity.net, hch@lst.de,
        mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
        paulus@ozlabs.org, will.deacon@arm.com, tony@atomide.com,
        npiggin@gmail.com, yamada.masahiro@socionext.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 20/20] x86/PCI: VMD: Fix malformed Kconfig default
Message-ID: <20180222230052.GA14632@bhelgaas-glaptop.roam.corp.google.com>
References: <0180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
 <20180206221106.16620-1-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180206221106.16620-1-ulfalizer@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 06, 2018 at 11:11:06PM +0100, Ulf Magnusson wrote:
> 'default N' should be 'default n', though they happen to have the same
> effect here, due to undefined symbols (N in this case) evaluating to n
> in a tristate sense.
> 
> Remove the default instead of changing it. bool and tristate symbols
> implicitly default to n.

s/bool/Bool/

> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Since only this patch was posted to linux-pci, I assume it will be merged
via some other tree.

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
