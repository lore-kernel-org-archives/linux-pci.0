Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34138 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbcDSIUF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 04:20:05 -0400
Received: by mail-pf0-f170.google.com with SMTP id c20so4553978pfc.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 01:20:05 -0700 (PDT)
Subject: Re: [PATCH v8 31/45] powerpc/pci: Don't scan empty slot
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-32-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
	bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715EA2E.4090105@ozlabs.ru>
Date: Tue, 19 Apr 2016 18:19:58 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-32-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> In hotplug case, function pci_add_pci_devices() is called to rescan
> the specified PCI bus, which might not have any child devices. Access
> to the PCI bus's child device node will cause kernel crash without
> exception.
>
> This adds one more check to skip scanning PCI bus that doesn't have
> any subordinate devices from device-tree, in order to avoid kernel
> crash.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/kernel/pci-hotplug.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 7929a1c..3628c38 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -120,7 +120,8 @@ void pci_add_pci_devices(struct pci_bus *bus)
>   	if (mode == PCI_PROBE_DEVTREE) {
>   		/* use ofdt-based probe */
>   		of_rescan_bus(dn, bus);
> -	} else if (mode == PCI_PROBE_NORMAL) {
> +	} else if (mode == PCI_PROBE_NORMAL &&
> +		   dn->child && PCI_DN(dn->child)) {
>   		/*
>   		 * Use legacy probe. In the partial hotplug case, we
>   		 * probably have grandchildren devices unplugged. So
>


-- 
Alexey
