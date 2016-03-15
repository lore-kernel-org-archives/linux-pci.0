Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55994 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934119AbcCONvc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Mar 2016 09:51:32 -0400
Date: Tue, 15 Mar 2016 08:51:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, Vineet.Gupta1@synopsys.com,
	Alexey.Brodkin@synopsys.com
Subject: Re: [PATCH] Remove the inclusion of pci-bridge.h and pci-dma-compat.h
Message-ID: <20160315135127.GC19974@localhost>
References: <d3ed7b3e4f746831a5d0469da5361b4cd176f5c6.1457978659.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d3ed7b3e4f746831a5d0469da5361b4cd176f5c6.1457978659.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 15, 2016 at 11:06:02AM +0000, Joao Pinto wrote:
> While building linux-next the test robot detected that the pci.h was including
> two removed header files (pci-dma-compat.h and pci-bridge.h) causing the
> process to fail:
> http://lists.infradead.org/pipermail/linux-snps-arc/2016-March/000711.html
> 
> This patch has the goal to fix the build problem.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

Thanks, Joao, I folded this fix into the original commit.  I should have
caught this myself, since I'm the one who removed pci-bridge.h.

> ---
>  arch/arc/include/asm/pci.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arc/include/asm/pci.h b/arch/arc/include/asm/pci.h
> index 2f2011c..ba56c23 100644
> --- a/arch/arc/include/asm/pci.h
> +++ b/arch/arc/include/asm/pci.h
> @@ -10,9 +10,6 @@
>  #define _ASM_ARC_PCI_H
>  
>  #ifdef __KERNEL__
> -#include <asm-generic/pci-dma-compat.h>
> -#include <asm-generic/pci-bridge.h>
> -
>  #include <linux/ioport.h>
>  
>  #define PCIBIOS_MIN_IO 0x100
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
