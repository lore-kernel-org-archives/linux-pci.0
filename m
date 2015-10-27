Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33235 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184AbbJ0QrN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 12:47:13 -0400
Received: by lbbec13 with SMTP id ec13so66479802lbb.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 09:47:12 -0700 (PDT)
Subject: Re: [Linaro-acpi] [PATCH V1 07/11] XEN / PCI: Remove the dependence
 on arch x86 when PCI_MMCONFIG=y
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-8-git-send-email-tn@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-pci@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, wangyijing@huawei.com,
	tglx@linutronix.de, jiang.liu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	Stefano.Stabellini@eu.citrix.com
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Message-ID: <562FAA88.3020609@linaro.org>
Date: Tue, 27 Oct 2015 17:47:04 +0100
MIME-Version: 1.0
In-Reply-To: <1445963922-22711-8-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+ Stefano

On 27.10.2015 17:38, Tomasz Nowicki wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> In drivers/xen/pci.c, there are arch x86 dependent codes when
> CONFIG_PCI_MMCONFIG is enabled, since CONFIG_PCI_MMCONFIG
> depends on ACPI, so this will prevent XEN PCI running on other
> architectures using ACPI with PCI_MMCONFIG enabled (such as ARM64).
>
> Fortunatly, it can be sloved in a simple way. In drivers/xen/pci.c,
> the only x86 dependent code is if ((pci_probe & PCI_PROBE_MMCONF) == 0),
> and it's defined in asm/pci_x86.h, the code means that
> if the PCI resource is not probed in PCI_PROBE_MMCONF way, just
> ingnore the xen mcfg init. Actually this is duplicate, because
> if PCI resource is not probed in PCI_PROBE_MMCONF way, the
> pci_mmconfig_list will be empty, and the if (list_empty())
> after it will do the same job.
>
> So just remove the arch related code and the head file, this
> will be no functional change for x86, and also makes xen/pci.c
> usable for other architectures.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> ---
>   drivers/xen/pci.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
> index 6785ebb..9a8dbe3 100644
> --- a/drivers/xen/pci.c
> +++ b/drivers/xen/pci.c
> @@ -28,9 +28,6 @@
>   #include <asm/xen/hypervisor.h>
>   #include <asm/xen/hypercall.h>
>   #include "../pci/pci.h"
> -#ifdef CONFIG_PCI_MMCONFIG
> -#include <asm/pci_x86.h>
> -#endif
>
>   static bool __read_mostly pci_seg_supported = true;
>
> @@ -222,9 +219,6 @@ static int __init xen_mcfg_late(void)
>   	if (!xen_initial_domain())
>   		return 0;
>
> -	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
> -		return 0;
> -
>   	if (list_empty(&pci_mmcfg_list))
>   		return 0;
>
>
