Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeBFTLc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Feb 2018 14:11:32 -0500
Date: Tue, 6 Feb 2018 13:11:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org,
        vgupta@synopsys.com, mgorman@techsingularity.net, hch@lst.de,
        mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
        paulus@ozlabs.org, will.deacon@arm.com, tony@atomide.com,
        npiggin@gmail.com, yamada.masahiro@socionext.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 20/20] x86/PCI: VMD: Fix malformed default
Message-ID: <20180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-21-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180205012146.23981-21-ulfalizer@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> x86/PCI: VMD: Fix malformed default

In the title, please include a clue about what default you're talking
about, e.g., mention Kconfig somehow.

On Mon, Feb 05, 2018 at 02:21:32AM +0100, Ulf Magnusson wrote:
> 'default N' should be 'default n', though they happen to have the same
> effect here, due to undefined symbols (N in this case) evaluating to n
> in a tristate sense.
> 
> Remove the default from VMD instead of changing it. bool and tristate
> symbols implicitly default to n.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
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
