Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:56318 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103AbcCOLNu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2016 07:13:50 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>,
	Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] Remove the inclusion of pci-bridge.h and
 pci-dma-compat.h
Date: Tue, 15 Mar 2016 11:13:47 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E8FE6E@us01wembx1.internal.synopsys.com>
References: <d3ed7b3e4f746831a5d0469da5361b4cd176f5c6.1457978659.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 15 March 2016 04:36 PM, Joao Pinto wrote:
> While building linux-next the test robot detected that the pci.h was including
> two removed header files (pci-dma-compat.h and pci-bridge.h) causing the
> process to fail:
> http://lists.infradead.org/pipermail/linux-snps-arc/2016-March/000711.html
>
> This patch has the goal to fix the build problem.
>
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

@Bjorn since the ARC PCI support is still not upstream, and was slated to go via
you, please pick this one up as well.

Thx,
-Vineet

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

