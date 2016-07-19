Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 19 Jul 2016 17:05:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 9/9] [RFC] pci: include <asm/dma.h> for
 isa_dma_bridge_buggy
Message-ID: <20160719220510.GD18635@localhost>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466175913-19067-10-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
In-Reply-To: <1466175913-19067-10-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-kernel@lists.codethink.co.uk, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 17, 2016 at 04:05:13PM +0100, Ben Dooks wrote:
> At least on arm, <asm/dma.h> does not get included when building
> drivers/pci/pci.o. This causes the following build warning which
> can be fixed by including <asm/dma.h>:
> 
> drivers/pci/pci.c:37:5: warning: symbol 'isa_dma_bridge_buggy' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to pci/misc for v4.8, thanks, Ben!

> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9add285..86b538d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -26,6 +26,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
>  #include <asm/setup.h>
> +#include <asm/dma.h>
>  #include <linux/aer.h>
>  #include "pci.h"
>  
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
