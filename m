Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 30 May 2018 10:20:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: versatile: include pci.h
Message-ID: <20180530152000.GB39853@bhelgaas-glaptop.roam.corp.google.com>
References: <20180528154850.2647019-1-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20180528154850.2647019-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 28, 2018 at 05:48:39PM +0200, Arnd Bergmann wrote:
> Two patches for PCI host drivers clashed recently, leading to a broken
> build for versatile-pci:
> 
> drivers/pci/host/pci-versatile.c: In function 'versatile_pci_parse_request_of_pci_ranges':
> drivers/pci/host/pci-versatile.c:70:8: error: implicit declaration of function 'devm_of_pci_get_host_bridge_resources'; did you mean 'pci_get_host_bridge_device'? [-Werror=implicit-function-declaration]
> 
> This adds the missing header inclusion that became necessary now.
> 
> Fixes: 9e2aee80c78d ("PCI: Move private DT related functions into private header")
> Fixes: 64720fd1f630 ("PCI: Rework of_pci_get_host_bridge_resources() to devm_of_pci_get_host_bridge_resources()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I added this in the merge where these two commits came together,
so hopefully there should be no bisection hole.

> ---
>  drivers/pci/host/pci-versatile.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
> index ff2cd12b3978..994f32061b32 100644
> --- a/drivers/pci/host/pci-versatile.c
> +++ b/drivers/pci/host/pci-versatile.c
> @@ -15,6 +15,8 @@
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  
> +#include "../pci.h"
> +
>  static void __iomem *versatile_pci_base;
>  static void __iomem *versatile_cfg_base[2];
>  
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
